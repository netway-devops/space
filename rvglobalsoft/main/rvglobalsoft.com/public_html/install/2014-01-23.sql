REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'clientarea', 'passistooshort','Password is too short (minimum is %d characters)' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'uppercaselowercase','Password should include uppercase and lowercase characters' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'specialcharacters','Password should include special characters' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'lettersanddigits','Password should include letters and digits' FROM hb_language WHERE target='user'
UNION SELECT id, 'global', 'paymentsucces','Payment succesfull' FROM hb_language WHERE target='user';