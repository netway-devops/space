REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'dnszonetaken','This zone is already taken' FROM hb_language WHERE target='user';
