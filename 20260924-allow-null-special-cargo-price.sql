ALTER TABLE `f_special_cargo`
    MODIFY COLUMN `price` decimal(10, 2) NULL DEFAULT NULL
        COMMENT '单价浮动';
