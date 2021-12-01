ALTER TABLE  `hb_reports` ADD  `handler` ENUM(  'php',  'sql' ) NOT NULL DEFAULT  'sql';
##########
INSERT INTO `hb_reports` (`id`, `type`, `name`, `query`, `options`, `handler`) VALUES
(NULL, 'Custom', 'Revenue per product type', 'report.revenuepertype.php', 0, 'php');
##########
ALTER TABLE  `hb_invoice_items` 
CHANGE  `type`  `type` ENUM(  'Domain Register',  'Domain Renew',  'Domain Transfer',  'Hosting',  'Addon',  'Other', 
 'Upgrade',  'Invoice',  'Config',  'Credit',  'FieldUpgrade',  'Field', 'Discount',  'Support',  'RefundedItem' ) NOT NULL;
##########
REPLACE INTO hb_configuration (`setting`, `value`) VALUES ('ShopingCartMode','1');