REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'tasklist', 'UnpaidOrder','Unpaid order' FROM hb_language WHERE target = 'admin';
##########
ALTER TABLE `hb_knowledgebase_cat` ADD COLUMN `options` INT(4) DEFAULT 0;
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'editTicketMsg','Edit ticket message & replies' FROM hb_language WHERE target!='user';
##########
UPDATE hb_admin_access SET `access` = CONCAT(`access`,',editTicketMsg') WHERE `access` LIKE '%editTicket%';