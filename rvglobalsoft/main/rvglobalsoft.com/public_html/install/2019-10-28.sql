REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'clientarea', 'ns_save_failed','Nameservers update failed' FROM hb_language WHERE target = 'user';