REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'required_field','The %s field is required' FROM hb_language WHERE target='user';