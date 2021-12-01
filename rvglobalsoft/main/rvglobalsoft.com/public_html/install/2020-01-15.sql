REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'show_details','Show details' FROM hb_language
UNION SELECT id, 'global', 'cart_additional_tax','Additional VAT applicable to your account' FROM hb_language WHERE target = 'user';