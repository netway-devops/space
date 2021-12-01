REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'configuration', 'KeySizeToCSR', 'Key size to generate CSR' FROM hb_language;
##########
REPLACE INTO hb_configuration (`setting`, `value`) VALUES ('KeySizeToCSR', 2048);