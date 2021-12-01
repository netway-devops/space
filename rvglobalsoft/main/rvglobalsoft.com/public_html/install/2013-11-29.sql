ALTER TABLE `hb_invoice_items`
CHANGE COLUMN `type` `type` ENUM('Domain Register','Domain Renew',
'Domain Transfer','Hosting','Addon','Other','Upgrade','Invoice','Config','Credit',
'FieldUpgrade','Field','Discount','Support') NOT NULL AFTER `invoice_id`,
CHANGE COLUMN `qty` `qty` DECIMAL(10,2) NOT NULL DEFAULT '1' AFTER `taxed`;
##########
ALTER TABLE `hb_invoice_items_queue`
CHANGE COLUMN `item_id` `rel_id` INT(10) NOT NULL AFTER `client_id`,
CHANGE COLUMN `type` `rel_type` VARCHAR(50) NOT NULL AFTER `rel_id`,
CHANGE COLUMN `qty` `qty` DECIMAL(10,2) NOT NULL DEFAULT '1' AFTER `taxed`,
ADD COLUMN `item_id` INT NOT NULL AFTER `rel_type`,
ADD COLUMN `type` VARCHAR(50) NOT NULL AFTER `item_id`,
DROP INDEX `item_id`,
ADD INDEX `rel_id` (`rel_id`),
ADD INDEX `item_id` (`item_id`);
##########
ALTER TABLE `hb_tickets`
CHANGE COLUMN `notes` `flags` INT(11) NOT NULL AFTER `priority`;
##########
UPDATE `hb_tickets` t SET t.flags=1 WHERE t.flags > 0;
##########
CREATE TABLE IF NOT EXISTS `hb_ticket_billing` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(250) NOT NULL,
  `description` text NOT NULL,
  `price` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE IF NOT EXISTS `hb_ticket_billing_items` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `ticket_id` int(10) NOT NULL,
  `date` datetime NOT NULL,
  `start` datetime NOT NULL,
  `end` datetime NOT NULL,
  `rate_id` int(11) NOT NULL,
  `rate` decimal(10,2) NOT NULL,
  `admin_id` int(10) NOT NULL,
  `admin` varchar(250) NOT NULL,
  `status` tinyint(4) NOT NULL,
  `note` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `rate_id` (`rate_id`),
  KEY `admin_id` (`admin_id`),
  KEY `ticket_id` (`ticket_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE IF NOT EXISTS `hb_ticket_subscriptions` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `admin_id` int(10) NOT NULL,
  `ticket_id` int(10) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `admin_id_ticket_id` (`admin_id`,`ticket_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

