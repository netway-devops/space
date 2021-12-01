REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'affiliates', 'affurlchanged','Landing page URL has been saved!' FROM hb_language WHERE target='user';