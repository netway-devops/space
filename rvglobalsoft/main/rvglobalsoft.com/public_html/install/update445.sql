#### Tax number 
INSERT INTO `hb_configuration` (`setting`, `value`) VALUES ('nwTaxNumber', '1');
ALTER TABLE `hb_invoices` ADD `invoice_number` VARCHAR( 32 ) NOT NULL DEFAULT '' AFTER `paid_id`;
