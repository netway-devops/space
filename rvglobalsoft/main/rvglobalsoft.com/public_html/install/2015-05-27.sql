REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'addthiscontact','Add this contact to my account' FROM hb_language WHERE target='user';
