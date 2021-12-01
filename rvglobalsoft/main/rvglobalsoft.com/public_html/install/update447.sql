INSERT INTO `hb_configuration` (`setting`, `value`) VALUES ('nwSupportDepartmentId', '3');
ALTER TABLE `hb_invoice_items` ADD `is_shipped` TINYINT( 1 ) NOT NULL DEFAULT '0';
