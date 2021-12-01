REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'clientarea', 'snapshot','Snapshot' FROM hb_language WHERE target='user';