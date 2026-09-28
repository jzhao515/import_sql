ALTER TABLE `f_special_cargo`
    ADD COLUMN `rate` decimal(10, 4) NULL DEFAULT NULL
        COMMENT '费率（计算符号为*时，基础运价乘该值）' AFTER `price`;
