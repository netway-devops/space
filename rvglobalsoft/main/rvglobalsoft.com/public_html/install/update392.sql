UPDATE `hb_configuration` SET `value` = '3.9.2' WHERE `setting`= 'Version';
##########
CREATE TABLE `hb_reports` (
 `id` int(11) NOT NULL auto_increment,
 `type` varchar(32) NOT NULL,
 `name` varchar(255) NOT NULL,
 `query` text NOT NULL,
 `options` int(10) NOT NULL,
 PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
UPDATE `hb_cron_tasks` SET `run_every`='Hour' WHERE `task`='domainSync';
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'services', 'order_scenario','Order scenario' FROM hb_language WHERE target='admin'
UNION SELECT id, 'services', 'show_advanced','Show advanced options' FROM hb_language WHERE target='admin'
UNION SELECT id, 'services', 'Advanced','Advanced' FROM hb_language  WHERE target='admin';