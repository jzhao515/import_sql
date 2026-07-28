-- Standardize every create_by/update_by column in the current database to varchar(100).
-- Existing character set, collation, NULL constraint, default value and comment are preserved.

DROP PROCEDURE IF EXISTS `migrate_audit_user_columns_to_100`;

DELIMITER $$

CREATE PROCEDURE `migrate_audit_user_columns_to_100`()
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE target_table VARCHAR(64);
    DECLARE target_column VARCHAR(64);
    DECLARE target_charset VARCHAR(64);
    DECLARE target_collation VARCHAR(64);
    DECLARE target_nullable VARCHAR(3);
    DECLARE target_default TEXT;
    DECLARE target_comment TEXT;
    DECLARE unsupported_columns INT DEFAULT 0;
    DECLARE error_message VARCHAR(128);

    DECLARE audit_columns CURSOR FOR
        SELECT c.TABLE_NAME,
               c.COLUMN_NAME,
               c.CHARACTER_SET_NAME,
               c.COLLATION_NAME,
               c.IS_NULLABLE,
               c.COLUMN_DEFAULT,
               c.COLUMN_COMMENT
        FROM information_schema.COLUMNS c
        INNER JOIN information_schema.TABLES t
                ON t.TABLE_SCHEMA = c.TABLE_SCHEMA
               AND t.TABLE_NAME = c.TABLE_NAME
               AND t.TABLE_TYPE = 'BASE TABLE'
        WHERE c.TABLE_SCHEMA = DATABASE()
          AND c.COLUMN_NAME IN ('create_by', 'update_by')
          AND c.DATA_TYPE IN ('char', 'varchar', 'tinytext', 'text', 'mediumtext', 'longtext')
          AND NOT (c.DATA_TYPE = 'varchar' AND c.CHARACTER_MAXIMUM_LENGTH = 100)
        ORDER BY c.TABLE_NAME, c.ORDINAL_POSITION;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    IF DATABASE() IS NULL THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'No database selected';
    END IF;

    SELECT COUNT(*)
      INTO unsupported_columns
      FROM information_schema.COLUMNS c
      INNER JOIN information_schema.TABLES t
              ON t.TABLE_SCHEMA = c.TABLE_SCHEMA
             AND t.TABLE_NAME = c.TABLE_NAME
             AND t.TABLE_TYPE = 'BASE TABLE'
     WHERE c.TABLE_SCHEMA = DATABASE()
       AND c.COLUMN_NAME IN ('create_by', 'update_by')
       AND c.DATA_TYPE NOT IN ('char', 'varchar', 'tinytext', 'text', 'mediumtext', 'longtext');

    IF unsupported_columns > 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Unsupported create_by/update_by column type found';
    END IF;

    OPEN audit_columns;

    check_column_data: LOOP
        FETCH audit_columns
         INTO target_table,
              target_column,
              target_charset,
              target_collation,
              target_nullable,
              target_default,
              target_comment;

        IF done = 1 THEN
            LEAVE check_column_data;
        END IF;

        SET @audit_oversized_rows = 0;
        SET @audit_data_check = CONCAT(
            'SELECT COUNT(*) INTO @audit_oversized_rows FROM `',
            REPLACE(target_table, '`', '``'),
            '` WHERE CHAR_LENGTH(`',
            REPLACE(target_column, '`', '``'),
            '`) > 100'
        );

        PREPARE audit_data_check_statement FROM @audit_data_check;
        EXECUTE audit_data_check_statement;
        DEALLOCATE PREPARE audit_data_check_statement;

        IF @audit_oversized_rows > 0 THEN
            SET error_message = CONCAT(
                'Values exceed 100 chars in ',
                LEFT(target_table, 40),
                '.',
                LEFT(target_column, 40)
            );
            SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = error_message;
        END IF;
    END LOOP;

    CLOSE audit_columns;

    SET done = 0;
    OPEN audit_columns;

    alter_columns: LOOP
        FETCH audit_columns
         INTO target_table,
              target_column,
              target_charset,
              target_collation,
              target_nullable,
              target_default,
              target_comment;

        IF done = 1 THEN
            LEAVE alter_columns;
        END IF;

        SET @audit_column_ddl = CONCAT(
            'ALTER TABLE `', REPLACE(target_table, '`', '``'),
            '` MODIFY COLUMN `', REPLACE(target_column, '`', '``'),
            '` varchar(100)',
            IF(target_charset IS NULL, '', CONCAT(' CHARACTER SET ', target_charset)),
            IF(target_collation IS NULL, '', CONCAT(' COLLATE ', target_collation)),
            IF(target_nullable = 'YES', ' NULL', ' NOT NULL'),
            IF(target_default IS NULL,
               IF(target_nullable = 'YES', ' DEFAULT NULL', ''),
               CONCAT(' DEFAULT ', QUOTE(target_default))),
            ' COMMENT ', QUOTE(target_comment)
        );

        PREPARE audit_column_statement FROM @audit_column_ddl;
        EXECUTE audit_column_statement;
        DEALLOCATE PREPARE audit_column_statement;
    END LOOP;

    CLOSE audit_columns;
END$$

DELIMITER ;

CALL `migrate_audit_user_columns_to_100`();
DROP PROCEDURE `migrate_audit_user_columns_to_100`;

-- Release gate: must return 0.
SELECT COUNT(*) AS invalid_audit_column_length
FROM information_schema.COLUMNS c
INNER JOIN information_schema.TABLES t
        ON t.TABLE_SCHEMA = c.TABLE_SCHEMA
       AND t.TABLE_NAME = c.TABLE_NAME
       AND t.TABLE_TYPE = 'BASE TABLE'
WHERE c.TABLE_SCHEMA = DATABASE()
  AND c.COLUMN_NAME IN ('create_by', 'update_by')
  AND NOT (c.DATA_TYPE = 'varchar' AND c.CHARACTER_MAXIMUM_LENGTH = 100);
