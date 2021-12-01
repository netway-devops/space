REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'Biennially','Biennially' FROM hb_language WHERE target='user'