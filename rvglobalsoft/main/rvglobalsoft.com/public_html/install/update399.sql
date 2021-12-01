UPDATE `hb_configuration` SET `value` = '3.9.9' WHERE `setting`= 'Version';
##########
ALTER TABLE `hb_admin_access` CHANGE `password` `password` VARCHAR( 255 ) NOT NULL DEFAULT '';
##########
ALTER TABLE `hb_client_access` CHANGE `password` `password` VARCHAR( 255 )  NOT NULL;
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'tickets', 'markasread','Mark as read' FROM hb_language WHERE target='admin'
UNION SELECT id, 'clientarea', 'forms_upgrade_success','Components upgrade succeeded' FROM hb_language WHERE target!='admin';
