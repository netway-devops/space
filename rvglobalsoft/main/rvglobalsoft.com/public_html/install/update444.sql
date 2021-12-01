UPDATE `hb_configuration` SET `value` = '4.4.4' WHERE `setting`= 'Version';
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'configuration', 'AllowBulkPayment','Allow paying in bulk' FROM hb_language WHERE target!='user'
UNION SELECT id, 'configuration', 'AllowBulkPayment_descr1','clients are not allowed to generate bulk-payment invoice' FROM hb_language WHERE target!='user'
UNION SELECT id, 'configuration', 'AllowBulkPayment_descr','clients can generate bulk-payment invoice' FROM hb_language WHERE target!='user';
##########
REPLACE INTO `hb_configuration` VALUES ('AllowBulkPayment','on');