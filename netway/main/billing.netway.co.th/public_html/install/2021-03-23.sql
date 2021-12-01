REPLACE INTO hb_configuration (`setting`, `value`) VALUES ('PDFPrefix', 'on');
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'configuration', 'PDFPrefix','PDF Prefix' FROM hb_language WHERE target = 'admin'
UNION SELECT id, 'configuration', 'PDFPrefixDesc','Adds a companyname prefix to the file name' FROM hb_language WHERE target = 'admin';