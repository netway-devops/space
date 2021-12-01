CREATE TABLE IF NOT EXISTS `hb_product_log_diff` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `product_id` INT NOT NULL,
    `data` TEXT NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE INDEX `product_id` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
INSERT INTO hb_product_log_diff (`product_id`, `data`)
SELECT SUBSTR(`setting`, 31),`value` FROM hb_configuration WHERE `setting` LIKE "Component:ProductsLog:Product:%";
##########
DELETE FROM hb_configuration WHERE `setting` LIKE 'Component:ProductsLog%';