REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'clientarea', 'datadisk_limit','Data Disk' FROM hb_language WHERE target='user';