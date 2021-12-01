CREATE TABLE IF NOT EXISTS `hb_client_group_discount` (
  `group_id` int(11) NOT NULL,
  `rel_id` int(11) NOT NULL,
  `rel` enum('Product','Category') NOT NULL,
  `discount` DECIMAL(10,2) NOT NULL DEFAULT '0.00',
  `type` enum('fixed','percent') NOT NULL DEFAULT 'fixed',
  PRIMARY KEY  (`group_id`,`rel_id`,`rel`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
ALTER TABLE  `hb_order_drafts` ADD  `scenario_id` INT( 11 ) NOT NULL DEFAULT  '0';
##########
CREATE TABLE IF NOT EXISTS `hb_invoice_items_queue` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `client_id` int(10) NOT NULL,
  `item_id` int(10) NOT NULL,
  `type` varchar(50) NOT NULL,
  `description` text NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `taxed` tinyint(4) NOT NULL,
  `qty` int(10) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `client_id` (`client_id`),
  KEY `item_id` (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;