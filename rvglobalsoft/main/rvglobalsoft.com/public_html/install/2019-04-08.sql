CREATE TABLE IF NOT EXISTS `hb_price_update_profile` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` text NULL,
  `status` ENUM('Active', 'Inactive') NOT NULL DEFAULT 'Active',
  `server_id` int(11) NOT NULL,
  `default_product` int(11) NOT NULL,
  `default_margin_registration` DECIMAL(10,2) NOT NULL DEFAULT '0.00',
  `default_margin_renewal` DECIMAL(10,2) NOT NULL DEFAULT '0.00',
  `default_margin_transfer` DECIMAL(10,2) NOT NULL DEFAULT '0.00',
  `default_margin_redemption` DECIMAL(10,2) NOT NULL DEFAULT '0.00',
  `default_margin_type` ENUM('Percent', 'Fixed') NOT NULL DEFAULT 'Percent',
  `options` int(11) DEFAULT 0,
  `last_sync` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  INDEX `server_id` (`server_id`),
  INDEX `default_product` (`default_product`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8;
##########
CREATE TABLE IF NOT EXISTS `hb_price_update_profile_items` (
  `profile_id` int(11) NOT NULL,
  `tld` varchar(255) NOT NULL,
  `margin_registration` DECIMAL(10,2) NOT NULL DEFAULT '0.00',
  `margin_renewal` DECIMAL(10,2) NOT NULL DEFAULT '0.00',
  `margin_transfer` DECIMAL(10,2) NOT NULL DEFAULT '0.00',
  `margin_redemption` DECIMAL(10,2) NOT NULL DEFAULT '0.00',
  `margin_type` ENUM('Percent', 'Fixed') NOT NULL DEFAULT 'Percent',
  `options` int(11) DEFAULT 0,
  INDEX `profile_id` (`profile_id`),
  INDEX `tld` (`tld`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8;
##########
REPLACE INTO `hb_cron_tasks` (`task`, `name`, `lastrun`, `status`, `count`, `metadata`, `output`, `run_every`,`run_every_time`, `profile_id`)
VALUES ('tldPriceAutoUpdate', 'TLD Price auto-update', '000-00-00 00:00:00', 1, 0, '', '', 'Time', '1200', 1);