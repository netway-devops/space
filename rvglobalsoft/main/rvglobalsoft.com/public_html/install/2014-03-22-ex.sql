CREATE TABLE IF NOT EXISTS `rv_perpetual_email` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `hb_acc` int(11) NOT NULL,
  `date` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB





CREATE TABLE IF NOT EXISTS `rvlogin_license` (
  `license_id` int(11) NOT NULL AUTO_INCREMENT,
  `client_id` int(11) NOT NULL DEFAULT '0',
  `cpv_id` int(11) NOT NULL DEFAULT '0',
  `license_type` int(11) NOT NULL DEFAULT '0',
  `primary_ip` varchar(32) NOT NULL DEFAULT '',
  `secondary_ip` varchar(32) NOT NULL DEFAULT '',
  `expire` int(20) DEFAULT NULL,
  `effective_expiry` int(20) DEFAULT NULL COMMENT 'effective expiry',
  `active` tinyint(1) NOT NULL DEFAULT '0',
  `email_installation` tinyint(1) NOT NULL DEFAULT '0',
  `rvskin_user_snd` varchar(32) NOT NULL DEFAULT '',
  `hb_acc` int(11) DEFAULT '0',
  `comment` varchar(255) DEFAULT NULL,
  `edit_hit` int(10) NOT NULL DEFAULT '0',
  `edit_log` text,
  `transfer_log` text,
  `date_nameserver` int(11) NOT NULL,
  PRIMARY KEY (`license_id`),
  UNIQUE KEY `primary_ip_2` (`primary_ip`,`secondary_ip`),
  KEY `primary_ip` (`primary_ip`),
  KEY `secondary_ip` (`secondary_ip`),
  KEY `active` (`active`),
  KEY `cpv_id` (`cpv_id`),
  KEY `client_id` (`client_id`),
  KEY `hb_acc` (`hb_acc`)
) ENGINE=MyISAM  DEFAULT CHARSET=tis620




CREATE TABLE IF NOT EXISTS `fraud_server_ip` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ip` varchar(32) NOT NULL,
  `note` text NOT NULL,
  `who` varchar(128) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ip` (`ip`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;


CREATE TABLE IF NOT EXISTS `pipedrive` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `deal_id` int(11) NOT NULL,
  `pipe_line` varchar(64) NOT NULL,
  `date_created` datetime NOT NULL,
  `date_changed` datetime NOT NULL,
  `won_stage_1` int(1) NOT NULL DEFAULT '0',
  `won_stage_2` int(1) NOT NULL DEFAULT '0',
  `won_stage_3` int(1) NOT NULL DEFAULT '0',
  `won_stage_4` int(1) NOT NULL DEFAULT '0',
  `won_stage_5` int(1) NOT NULL DEFAULT '0',
  `won_stage_6` int(1) NOT NULL DEFAULT '0',
  `won_stage_7` int(1) NOT NULL DEFAULT '0',
  `won_stage_8` int(1) NOT NULL DEFAULT '0',
  `won_stage_9` int(1) NOT NULL DEFAULT '0',
  `order_type` varchar(32) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

ALTER TABLE `pipedrive` ADD `is_won` INT( 1 ) NOT NULL;

INSERT INTO `hb_configuration` (`setting` ,`value` ) VALUES ('nwTicketIDNotificationFrom', '100'), ('nwTicketReplyIDNotificationFrom', '100'), ('nwTicketNoteIDNotificationFrom', '100');


CREATE TABLE IF NOT EXISTS `hb_geo_ip_country` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ip_start` varchar(32) NOT NULL,
  `ip_end` varchar(32) NOT NULL,
  `ip_long_start` int(11) NOT NULL,
  `ip_long_end` int(11) NOT NULL,
  `country_code` varchar(2) NOT NULL,
  `country_name` varchar(128) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

ALTER TABLE `hb_geo_ip_country` ADD `is_whitelsit` INT( 1 ) NOT NULL ;

ALTER TABLE `hb_accounts` CHANGE `status` `status` ENUM( 'Pending', 'Active', 'Suspended', 'Terminated', 'Cancelled', 'Fraud', 'Transfer', 'Transfer Request', 'Pending Transfer' ) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ;

CREATE TABLE IF NOT EXISTS `hb_license_logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL,
  `date` datetime NOT NULL,
  `event` varchar(255) NOT NULL,
  `detail` text NOT NULL,
  `rel` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

INSERT INTO `hb_configuration` (`setting` ,`value` ) VALUES ('nwSendmailAutomationTask', '0');

