REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'renewal_cost', 'Renewal cost'  FROM hb_language
UNION SELECT id, 'global', 'invalid_attachment_id', 'Invalid attachment ID'  FROM hb_language
UNION SELECT id, 'global', 'no_attachment_found', 'No attachment with this ID was found'  FROM hb_language;
##########
REPLACE INTO hb_configuration (`setting`, `value`) VALUES ('WholeDigits', '10');