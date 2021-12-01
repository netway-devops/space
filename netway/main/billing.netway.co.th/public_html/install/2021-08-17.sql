REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'est_inv_converted','New invoice was issued from your accepted estimate' FROM hb_language WHERE target='user';
