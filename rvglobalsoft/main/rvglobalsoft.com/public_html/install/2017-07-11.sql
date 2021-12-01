REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'clientarea', 'purchaseadditionalbandwidth','Purchase additional bandwidth' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'additionalbandwidth','Additional Bandwidth' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'additional','Additional' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'data_sent','Data Sent' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'data_received','Data Received' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'confirm','Confirm' FROM hb_language WHERE target='user';