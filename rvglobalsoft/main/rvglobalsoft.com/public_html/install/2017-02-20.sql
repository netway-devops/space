CREATE TABLE IF NOT EXISTS `hb_queue_status` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `rel_type` varchar(16) NOT NULL DEFAULT 'None',
  `rel_id` int(11) NOT NULL DEFAULT '0',
  `token` varchar(32) NOT NULL DEFAULT '',
  `status` int(2) NOT NULL DEFAULT '1',
  `added` datetime NOT NULL,
  `changed` datetime NOT NULL,
  `queue` varchar(32) NOT NULL DEFAULT '',
  `payload` text NOT NULL,
  `hash` varchar(32) NOT NULL,
  `description` text,
  `env` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `token` (`token`),
  KEY `rel_type` (`rel_type`,`rel_id`),
  KEY `hash` (`hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
ALTER TABLE `hb_queue_status` ADD `parent_id` INT(11)  NOT NULL  DEFAULT '0'  AFTER `rel_id`;
##########
ALTER TABLE `hb_queue_status` ADD INDEX (`parent_id`);
##########
ALTER TABLE `hb_queue_status` ADD INDEX (`status`);
##########
ALTER TABLE `hb_queue_status` ADD INDEX (`queue` (16));
##########
ALTER TABLE `hb_queue_status` ADD `human_description` TEXT NOT NULL  DEFAULT ''  AFTER `description`;
##########
ALTER TABLE `hb_queue_status` ADD INDEX (`added`);
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'func_scheduled_for_execute','Function has been scheduled for execution' FROM hb_language;