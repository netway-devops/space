REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'markallasread','Mark all as read' FROM hb_language WHERE target = 'user';