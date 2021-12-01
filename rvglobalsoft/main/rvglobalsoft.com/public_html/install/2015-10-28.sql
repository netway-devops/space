REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'clients', 'SendTextMessage','Send SMS' FROM hb_language  WHERE target='admin'
UNION SELECT id, 'global', 'sms_sent_to_client','Mobile notification sent to client' FROM hb_language  WHERE target='admin'
UNION SELECT id, 'configfields', 'encryptedinputfield','Encrypted Input' FROM hb_language  WHERE target='admin'
UNION SELECT id, 'configfields', 'encryptedinputfield-description','Gather additional details about purchased items configuration from clients, stored in database in encrypted form' FROM hb_language  WHERE target='admin'
UNION SELECT id, 'configfields', 'encryptedpassword','Encrypted Password Input' FROM hb_language  WHERE target='admin'
UNION SELECT id, 'configfields', 'encryptedpassword-description','Gather additional details about purchased items configuration from clients, show password field in cart, store in database in encrypted form' FROM hb_language  WHERE target='admin';