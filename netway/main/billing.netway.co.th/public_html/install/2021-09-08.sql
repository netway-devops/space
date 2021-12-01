REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'affiliates', 'youcantusethiscode','You cannot use this code!' FROM hb_language WHERE target='user';