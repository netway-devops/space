ALTER TABLE `hb_client_access` ADD `loginattempts` TINYINT(1)  NULL  DEFAULT '0'  AFTER `status`;
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'ip_ban_added','Your IP address has been banned' FROM hb_language WHERE target!='admin';