REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'flavor_hours_on', 'Hours On' FROM hb_language
UNION SELECT id, 'global', 'flavor_hours_off', 'Hours Off' FROM hb_language;