-- Production repair for tbl_flight.id row identity.
-- Compatible with MySQL 5.7 and MySQL 8.x; no MD5, CTE, or window function is used.
--
-- Required execution order:
--   1. Stop every application instance and scheduled job that writes tbl_flight.
--   2. Back up the database through the normal production backup process.
--   3. Select the target schema explicitly: USE `your_database`;
--   4. Execute this complete file with a user that can create routines and tables.
--   5. Restart the application only after every post-migration check is valid.
--
-- Safety guarantees:
--   * An existing PRIMARY KEY(id) makes this script a no-op.
--   * Empty ids, conflicting row versions, triggers, foreign keys, an unexpected
--     primary key, or an unfinished previous attempt stop the migration.
--   * Byte-for-byte-equivalent duplicate rows are collapsed with SELECT DISTINCT.
--   * The complete original table is retained as tbl_flight_backup_before_id_pk.
--   * RENAME TABLE switches the rebuilt and original tables atomically.
--
-- Do not delete tbl_flight_backup_before_id_pk until production acceptance and
-- the normal retention period have both completed.

DROP PROCEDURE IF EXISTS `repair_tbl_flight_id_schema`;

DELIMITER $$

CREATE PROCEDURE `repair_tbl_flight_id_schema`()
migration: BEGIN
    DECLARE v_database_name VARCHAR(64) DEFAULT NULL;
    DECLARE v_lock_name VARCHAR(128) DEFAULT NULL;
    DECLARE v_lock_acquired INT DEFAULT 0;
    DECLARE v_table_count BIGINT DEFAULT 0;
    DECLARE v_id_column_count BIGINT DEFAULT 0;
    DECLARE v_primary_column_count BIGINT DEFAULT 0;
    DECLARE v_primary_id_count BIGINT DEFAULT 0;
    DECLARE v_backup_count BIGINT DEFAULT 0;
    DECLARE v_rebuild_count BIGINT DEFAULT 0;
    DECLARE v_trigger_count BIGINT DEFAULT 0;
    DECLARE v_foreign_key_count BIGINT DEFAULT 0;
    DECLARE v_invalid_id_count BIGINT DEFAULT 0;
    DECLARE v_total_rows BIGINT DEFAULT 0;
    DECLARE v_distinct_ids BIGINT DEFAULT 0;
    DECLARE v_conflicting_ids BIGINT DEFAULT 0;
    DECLARE v_migrated_rows BIGINT DEFAULT 0;
    DECLARE v_source_rows_after_copy BIGINT DEFAULT 0;
    DECLARE v_source_ids_after_copy BIGINT DEFAULT 0;
    DECLARE v_drop_id_indexes TEXT DEFAULT NULL;
    DECLARE v_row_signature_parts LONGTEXT DEFAULT NULL;
    DECLARE v_original_group_concat_max_len BIGINT UNSIGNED DEFAULT 0;
    DECLARE v_group_concat_changed TINYINT DEFAULT 0;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        IF v_group_concat_changed = 1 THEN
            SET SESSION group_concat_max_len = v_original_group_concat_max_len;
        END IF;
        IF v_lock_acquired = 1 THEN
            DO RELEASE_LOCK(v_lock_name);
        END IF;
        RESIGNAL;
    END;

    SET v_database_name = DATABASE();

    IF v_database_name IS NULL OR v_database_name = '' THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'select the target database with USE before running this script';
    END IF;

    SET v_lock_name = CONCAT(
        'tfpk:',
        LEFT(v_database_name, 48),
        ':',
        LPAD(HEX(CRC32(v_database_name)), 8, '0')
    );
    SELECT GET_LOCK(v_lock_name, 10) INTO v_lock_acquired;

    IF COALESCE(v_lock_acquired, 0) <> 1 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'another tbl_flight id repair is already running';
    END IF;

    SELECT COUNT(*)
      INTO v_table_count
      FROM information_schema.TABLES
     WHERE TABLE_SCHEMA = v_database_name
       AND TABLE_NAME = 'tbl_flight'
       AND TABLE_TYPE = 'BASE TABLE';

    IF v_table_count <> 1 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'tbl_flight does not exist as a base table in the selected database';
    END IF;

    SELECT COUNT(*)
      INTO v_id_column_count
      FROM information_schema.COLUMNS
     WHERE TABLE_SCHEMA = v_database_name
       AND TABLE_NAME = 'tbl_flight'
       AND COLUMN_NAME = 'id';

    IF v_id_column_count <> 1 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'tbl_flight.id does not exist';
    END IF;

    SELECT
        COUNT(*),
        COALESCE(SUM(CASE WHEN COLUMN_NAME = 'id' THEN 1 ELSE 0 END), 0)
      INTO v_primary_column_count, v_primary_id_count
      FROM information_schema.STATISTICS
     WHERE TABLE_SCHEMA = v_database_name
       AND TABLE_NAME = 'tbl_flight'
       AND INDEX_NAME = 'PRIMARY';

    IF v_primary_column_count = 1 AND v_primary_id_count = 1 THEN
        DO RELEASE_LOCK(v_lock_name);
        SET v_lock_acquired = 0;
        SELECT
            'SKIPPED' AS migration_status,
            'tbl_flight.id is already the primary key' AS migration_message;
        LEAVE migration;
    END IF;

    IF v_primary_column_count > 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'tbl_flight has an unexpected primary key; manual review is required';
    END IF;

    SELECT COUNT(*)
      INTO v_backup_count
      FROM information_schema.TABLES
     WHERE TABLE_SCHEMA = v_database_name
       AND TABLE_NAME = 'tbl_flight_backup_before_id_pk';

    IF v_backup_count > 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'tbl_flight_backup_before_id_pk already exists while the active table has no primary key';
    END IF;

    SELECT COUNT(*)
      INTO v_rebuild_count
      FROM information_schema.TABLES
     WHERE TABLE_SCHEMA = v_database_name
       AND TABLE_NAME = 'tbl_flight_id_pk_rebuild';

    IF v_rebuild_count > 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'tbl_flight_id_pk_rebuild already exists; inspect the previous migration attempt';
    END IF;

    SELECT COUNT(*)
      INTO v_trigger_count
      FROM information_schema.TRIGGERS
     WHERE TRIGGER_SCHEMA = v_database_name
       AND EVENT_OBJECT_TABLE = 'tbl_flight';

    IF v_trigger_count > 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'tbl_flight has triggers; manual review is required before rebuilding it';
    END IF;

    SELECT COUNT(*)
      INTO v_foreign_key_count
      FROM information_schema.KEY_COLUMN_USAGE
     WHERE REFERENCED_TABLE_NAME IS NOT NULL
       AND (
           (TABLE_SCHEMA = v_database_name AND TABLE_NAME = 'tbl_flight')
           OR
           (REFERENCED_TABLE_SCHEMA = v_database_name AND REFERENCED_TABLE_NAME = 'tbl_flight')
       );

    IF v_foreign_key_count > 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'tbl_flight participates in foreign keys; manual review is required before rebuilding it';
    END IF;

    SELECT COUNT(*)
      INTO v_invalid_id_count
      FROM `tbl_flight`
     WHERE `id` IS NULL OR TRIM(`id`) = '';

    IF v_invalid_id_count > 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'tbl_flight contains null or empty ids; automatic repair is unsafe';
    END IF;

    SELECT COUNT(*), COUNT(DISTINCT `id`)
      INTO v_total_rows, v_distinct_ids
      FROM `tbl_flight`;

    SET v_original_group_concat_max_len = @@SESSION.group_concat_max_len;
    SET SESSION group_concat_max_len = 1048576;
    SET v_group_concat_changed = 1;

    SELECT GROUP_CONCAT(
               CONCAT(
                   'IF(`', REPLACE(COLUMN_NAME, '`', '``'), '` IS NULL,',
                   '''N'',CONCAT(''V'',OCTET_LENGTH(CAST(`',
                   REPLACE(COLUMN_NAME, '`', '``'),
                   '` AS BINARY)), '':'', HEX(CAST(`',
                   REPLACE(COLUMN_NAME, '`', '``'),
                   '` AS BINARY))))'
               )
               ORDER BY ORDINAL_POSITION
               SEPARATOR ','
           )
      INTO v_row_signature_parts
      FROM information_schema.COLUMNS
     WHERE TABLE_SCHEMA = v_database_name
       AND TABLE_NAME = 'tbl_flight';

    IF v_row_signature_parts IS NULL OR v_row_signature_parts = '' THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'could not build a byte-preserving tbl_flight row signature';
    END IF;

    SET @tbl_flight_conflicting_ids = 0;
    SET @tbl_flight_conflict_sql = CONCAT(
        'SELECT COUNT(*) INTO @tbl_flight_conflicting_ids FROM (',
        'SELECT `id` FROM `tbl_flight` GROUP BY `id` ',
        'HAVING COUNT(DISTINCT CONCAT_WS(''|'',', v_row_signature_parts, ')) > 1',
        ') AS conflicts'
    );

    PREPARE tbl_flight_conflict_statement FROM @tbl_flight_conflict_sql;
    EXECUTE tbl_flight_conflict_statement;
    DEALLOCATE PREPARE tbl_flight_conflict_statement;

    SET v_conflicting_ids = @tbl_flight_conflicting_ids;
    SET SESSION group_concat_max_len = v_original_group_concat_max_len;
    SET v_group_concat_changed = 0;

    IF v_conflicting_ids > 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'same tbl_flight.id has conflicting row versions; automatic repair is unsafe';
    END IF;

    CREATE TABLE `tbl_flight_id_pk_rebuild` LIKE `tbl_flight`;

    SELECT GROUP_CONCAT(
               CONCAT('DROP INDEX `', REPLACE(single_column_indexes.INDEX_NAME, '`', '``'), '`')
               ORDER BY single_column_indexes.INDEX_NAME
               SEPARATOR ', '
           )
      INTO v_drop_id_indexes
      FROM (
          SELECT INDEX_NAME
            FROM information_schema.STATISTICS
           WHERE TABLE_SCHEMA = v_database_name
             AND TABLE_NAME = 'tbl_flight_id_pk_rebuild'
             AND INDEX_NAME <> 'PRIMARY'
           GROUP BY INDEX_NAME
          HAVING COUNT(*) = 1
             AND MAX(CASE WHEN COLUMN_NAME = 'id' THEN 1 ELSE 0 END) = 1
      ) AS single_column_indexes;

    SET @alter_tbl_flight_sql = CONCAT(
        'ALTER TABLE `tbl_flight_id_pk_rebuild` ',
        IF(v_drop_id_indexes IS NULL OR v_drop_id_indexes = '', '', CONCAT(v_drop_id_indexes, ', ')),
        'ADD PRIMARY KEY (`id`) USING BTREE'
    );

    PREPARE alter_tbl_flight_statement FROM @alter_tbl_flight_sql;
    EXECUTE alter_tbl_flight_statement;
    DEALLOCATE PREPARE alter_tbl_flight_statement;

    INSERT INTO `tbl_flight_id_pk_rebuild`
    SELECT DISTINCT *
      FROM `tbl_flight`;

    SELECT COUNT(*)
      INTO v_migrated_rows
      FROM `tbl_flight_id_pk_rebuild`;

    IF v_migrated_rows <> v_distinct_ids THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'rebuilt tbl_flight row count does not match the distinct id count';
    END IF;

    SELECT COUNT(*), COUNT(DISTINCT `id`)
      INTO v_source_rows_after_copy, v_source_ids_after_copy
      FROM `tbl_flight`;

    IF v_source_rows_after_copy <> v_total_rows OR v_source_ids_after_copy <> v_distinct_ids THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'tbl_flight changed during migration; keep writers stopped and retry after review';
    END IF;

    RENAME TABLE
        `tbl_flight` TO `tbl_flight_backup_before_id_pk`,
        `tbl_flight_id_pk_rebuild` TO `tbl_flight`;

    DO RELEASE_LOCK(v_lock_name);
    SET v_lock_acquired = 0;

    SELECT
        'SUCCESS' AS migration_status,
        v_database_name AS database_name,
        v_total_rows AS original_rows,
        v_migrated_rows AS migrated_rows,
        v_total_rows - v_migrated_rows AS removed_exact_duplicates;
END$$

DELIMITER ;

CALL `repair_tbl_flight_id_schema`();
DROP PROCEDURE `repair_tbl_flight_id_schema`;

-- Post-migration verification. Expected values:
--   primary_key_columns = 1
--   redundant_rows = 0
--   ordinary_single_id_indexes = 0
--   backup_table_count = 1 after a migration, or 0 if this database already had
--   PRIMARY KEY(id) before the first execution of this script.
SELECT COUNT(*) AS primary_key_columns
  FROM information_schema.STATISTICS
 WHERE TABLE_SCHEMA = DATABASE()
   AND TABLE_NAME = 'tbl_flight'
   AND INDEX_NAME = 'PRIMARY'
   AND COLUMN_NAME = 'id';

SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT `id`) AS distinct_ids,
    COUNT(*) - COUNT(DISTINCT `id`) AS redundant_rows
  FROM `tbl_flight`;

SELECT COUNT(*) AS ordinary_single_id_indexes
  FROM (
      SELECT INDEX_NAME
        FROM information_schema.STATISTICS
       WHERE TABLE_SCHEMA = DATABASE()
         AND TABLE_NAME = 'tbl_flight'
         AND INDEX_NAME <> 'PRIMARY'
       GROUP BY INDEX_NAME
      HAVING COUNT(*) = 1
         AND MAX(CASE WHEN COLUMN_NAME = 'id' THEN 1 ELSE 0 END) = 1
  ) AS redundant_id_indexes;

SELECT COUNT(*) AS backup_table_count
  FROM information_schema.TABLES
 WHERE TABLE_SCHEMA = DATABASE()
   AND TABLE_NAME = 'tbl_flight_backup_before_id_pk';

SHOW INDEX FROM `tbl_flight`;

-- Rollback (do not run after accepting new writes unless those writes are first
-- preserved and reconciled):
--   1. Stop every application instance and scheduled job that writes tbl_flight.
--   2. Confirm whether tbl_flight contains post-migration data that must be retained.
--   3. Preserve the repaired table and restore the original atomically:
--      RENAME TABLE
--          tbl_flight TO tbl_flight_after_id_pk_repair,
--          tbl_flight_backup_before_id_pk TO tbl_flight;
