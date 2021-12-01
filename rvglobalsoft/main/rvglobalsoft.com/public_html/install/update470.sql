UPDATE `hb_configuration` SET `value` = '4.7.0' WHERE `setting`= 'Version';
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'clientarea', 'areyousureremoverule','Are you sure you want to remove this rule?' FROM hb_language WHERE target='user';