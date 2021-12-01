UPDATE hb_configuration
SET VALUE = 'off'
WHERE setting = 'Netstat';
##########
UPDATE hb_configuration
SET VALUE = 'on'
WHERE setting = 'Netstat'
AND (SELECT count(id) FROM hb_servers WHERE status_url IS NOT NULL AND status_url <> '') > 0;
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'ordersubproduct','Order sub-product' FROM hb_language WHERE target = 'user'
UNION SELECT id, 'global', 'clickheretoorder','Click here to order' FROM hb_language WHERE target = 'user'
UNION SELECT id, 'global', 'iamorderingforaccount','I am ordering this product for service' FROM hb_language WHERE target = 'user';