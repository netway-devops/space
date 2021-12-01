
ALTER TABLE `hb_estimate_items` ADD `unit_price` DECIMAL(10,2) NOT NULL AFTER `qty`;
#######
ALTER TABLE `hb_estimate_items` ADD `discount_price` DECIMAL(10,2) NOT NULL  AFTER `unit_price`;
#######
ALTER TABLE `hb_estimate_items` ADD `quantity` int  NOT NULL  AFTER `discount_price`;
#######
ALTER TABLE `hb_estimate_items` ADD `quantity_text` varchar(255)  CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL AFTER `quantity`;