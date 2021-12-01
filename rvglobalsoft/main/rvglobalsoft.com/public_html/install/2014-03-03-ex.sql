ALTER TABLE `hb_knowledgebase_cat` ADD `google_drive_id` VARCHAR( 64 ) NOT NULL ,
ADD `sync_date` INT NOT NULL;
ALTER TABLE `hb_knowledgebase` ADD `description` TEXT NOT NULL;
ALTER TABLE `hb_knowledgebase` ADD `tags` VARCHAR( 255 ) NOT NULL;
INSERT INTO `hb_configuration` (`setting`, `value`) VALUES ('nwDisqusSecretKey', 'wQX6vozSdzBHSMXnvt8PF9FngeudeEGwTmgqLpzsYr2jKRfqIWBxTrUdnkRsdLiK'), ('nwDisqusPublicKey', 'pxgdqt5mrRkTveVbGZVsMTA3bubd2YxTTv0lL3o7r2Iz2HWBcnjkdFzjFXyci3Mx');
ALTER TABLE `hb_knowledgebase_cat` ADD `weight` INT NOT NULL;
ALTER TABLE `hb_knowledgebase` ADD `weight` INT NOT NULL;

CREATE TABLE IF NOT EXISTS `hb_ticket_ma_counter` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ticket_id` int(11) NOT NULL,
  `date` datetime NOT NULL,
  `start_counter` datetime NOT NULL,
  `counter_in_minute` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 ;

ALTER TABLE `hb_ticket_departments` ADD `kb_categories` VARCHAR( 255 ) NOT NULL;
ALTER TABLE `hb_ticket_departments` CHANGE `kb_categories` `kb_category` INT( 10 ) NOT NULL DEFAULT '0';

CREATE TABLE IF NOT EXISTS `hb_ticket_customfields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ticket_id` int(11) NOT NULL,
  `date` datetime NOT NULL,
  `content` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;