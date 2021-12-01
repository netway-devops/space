UPDATE hb_language_locales SET section="global" WHERE keyword IN ("droptoattach","attachfile");
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'configfields', 'documentsupload','File upload' FROM hb_language WHERE target!='user'
UNION SELECT id, 'configfields', 'documentsupload-description','Allow customer to upload files from orderpage' FROM hb_language WHERE target='admin';
