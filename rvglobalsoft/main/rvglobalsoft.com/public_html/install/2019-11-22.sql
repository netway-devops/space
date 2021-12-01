REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'actionfail','Action Failed' FROM hb_language WHERE target='user';
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'add_more','Add more' FROM hb_language;
##########
ALTER TABLE `hb_servers`
ADD `ns9` VARCHAR (128) AFTER `ns8`,
ADD `ns10` VARCHAR (128) AFTER `ns9`,
ADD `ip9` VARCHAR (128) AFTER `ip8`,
ADD `ip10` VARCHAR (128) AFTER `ip9`;