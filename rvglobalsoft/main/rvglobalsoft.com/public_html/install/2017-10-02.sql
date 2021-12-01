REPLACE INTO hb_configuration (`setting`, `value`)
VALUES ('EnableAutoDeleteDomain', 'off'), ('AutoDeleteDomainDays', '20'), ('AutoDeleteDomainType', 'after');
##########

REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'configuration', 'automaticDeleteDomains', 'Auto-Delete domains' FROM hb_language WHERE `target`!='user';
##########
REPLACE INTO `hb_cron_tasks` (`task`, `name`, `lastrun`, `status`, `count`, `metadata`, `output`, `run_every`, `run_every_time`, `profile_id`)
VALUES
	('automaticDeleteDomains', 'Auto-Delete expired domains', '0000-00-00 00:00:00', -1, 0, '', '', 'Time', '1200', 1);
