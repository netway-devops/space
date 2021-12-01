CREATE TABLE IF NOT EXISTS `hb_oslicenses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `client_id` int(11) NOT NULL,
  `account_id` int(11) DEFAULT NULL,
  `config_id` int(11) DEFAULT NULL,
  `template_id` varchar(255) DEFAULT NULL,
  `flag` tinyint(4) NOT NULL DEFAULT '0',
  `invoice_item` int(11) DEFAULT NULL,
  `meta` text,
  PRIMARY KEY (`id`),
  KEY `client_id` (`client_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
ALTER TABLE `hb_invoice_items`
CHANGE COLUMN `type` `type` ENUM('Domain Register','Domain Renew','Domain Transfer','Hosting','Addon','Other','Upgrade','Invoice','Config','Credit','FieldUpgrade','Field','Discount','Support','RefundedItem', 'OSLicense') NOT NULL AFTER `invoice_id`;