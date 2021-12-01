UPDATE `hb_modules_configuration` SET `settings`='|haveadmin|havetpl|header_js|' WHERE  `filename`='class.hbextras.php';
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'clientarea', 'lowdiskspace','Not enough disk space' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'reinstalnotpl','Reinstall using original template' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'reinstalwithtpl','Reinstall with new template' FROM hb_language WHERE target='user';