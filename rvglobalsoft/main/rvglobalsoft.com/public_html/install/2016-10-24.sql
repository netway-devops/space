ALTER TABLE `hb_cron_tasks` ADD `profile_id` INT(11)  NULL  DEFAULT '1'  AFTER `run_every_time`;
##########
CREATE TABLE `hb_cron_tasks_profiles` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(127) NOT NULL DEFAULT '',
  `description` text,
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
##########
INSERT INTO `hb_cron_tasks_profiles` (`id`, `name`, `description`)
VALUES (1, 'default', 'Default cron profile for HostBill, run every 5 minutes');