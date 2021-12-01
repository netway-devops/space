REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'multiinputfield', 'Multi-input text box' FROM hb_language WHERE target != 'user';