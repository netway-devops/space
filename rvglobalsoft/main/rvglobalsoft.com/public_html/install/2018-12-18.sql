REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'monday','Monday' FROM hb_language WHERE target='user'
UNION SELECT id, 'global', 'tuesday','Tuesday' FROM hb_language WHERE target='user'
UNION SELECT id, 'global', 'wednesday','Wednesday' FROM hb_language WHERE target='user'
UNION SELECT id, 'global', 'thursday','Thursday' FROM hb_language WHERE target='user'
UNION SELECT id, 'global', 'friday','Friday' FROM hb_language WHERE target='user'
UNION SELECT id, 'global', 'saturday','Saturday' FROM hb_language WHERE target='user'
UNION SELECT id, 'global', 'sunday','Sunday' FROM hb_language WHERE target='user'
UNION SELECT id, 'global', 'ipaddress','IP address' FROM hb_language WHERE target='user';