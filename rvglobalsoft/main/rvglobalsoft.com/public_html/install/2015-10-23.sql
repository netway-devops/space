CREATE TABLE IF NOT EXISTS `hb_order_items` (
  `order_id` int(11) NOT NULL,
  `type` enum('Domain Register','Domain Renew','Domain Transfer','Hosting','Addon','Other','Upgrade','FieldUpgrade') NOT NULL,
  `item_id` int(11) NOT NULL,
  PRIMARY KEY (`order_id`,`type`,`item_id`),
  KEY `type_item_id` (`type`,`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
ALTER TABLE `hb_tickets` DROP INDEX `ticket_number`,
CHANGE `acc_hash` `acc_hash` VARCHAR(32) NOT NULL  DEFAULT '0',
ADD INDEX (`ticket_number`),
ADD INDEX (`acc_hash`(6));