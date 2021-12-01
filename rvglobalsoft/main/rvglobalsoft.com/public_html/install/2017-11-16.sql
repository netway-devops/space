REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'Closing', 'Closing' FROM hb_language WHERE target!='user'
UNION SELECT id, 'global', 'accountisclosing', 'Sorry, but you are not allowed to place new orders'  FROM hb_language;
##########
ALTER TABLE `hb_client_access` CHANGE `status` `status` ENUM('Active','Closed','Closing')   NOT NULL  DEFAULT 'Active';
