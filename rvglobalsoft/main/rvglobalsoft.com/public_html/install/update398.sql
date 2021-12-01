UPDATE `hb_configuration` SET `value` = '3.9.8' WHERE `setting`= 'Version';
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'configuration', 'EnableClientScurity','Allow clients to set IP access rules' FROM hb_language WHERE target='admin';
##########
INSERT INTO `hb_configuration` (`setting`, `value`) VALUES ('EnableClientScurity', 'on');