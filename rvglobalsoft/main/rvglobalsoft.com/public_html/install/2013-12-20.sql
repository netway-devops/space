REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'prepayoverusagefee','Over-usage Fee' FROM hb_language WHERE target='user';