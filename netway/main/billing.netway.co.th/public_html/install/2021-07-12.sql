REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'tickets', 'messageencryptedinfo','This message contain sensitive data' FROM hb_language
UNION SELECT id, 'tickets', 'encryptmessage','This message contain sensitive data, encrypt its contents' FROM hb_language
UNION SELECT id, 'global', 'emailmessageencryptcontent','==CONTENT REMOVED AS IT WAS MARKED AS SENSITIVE. FULL CONTENT IS AVAILABLE IN THE TICKET DETAILS==' FROM hb_language
UNION SELECT id, 'tickets', 'encryptedmessagebody','This message contained sensitive data, auto-removed on ticket close on %s' FROM hb_language;
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'encryptTicketMsg', 'Encrypt ticket message & replies' FROM hb_language WHERE target!='user';
##########
UPDATE hb_admin_access SET `access` = CONCAT(`access`,',encryptTicketMsg') WHERE `access` LIKE '%editTicketMsg%';
##########
UPDATE `hb_admin_teams` SET access = CONCAT(`access`,',encryptTicketMsg') WHERE `access` LIKE '%editTicketMsg%';