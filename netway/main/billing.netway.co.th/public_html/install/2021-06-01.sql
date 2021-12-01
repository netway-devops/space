REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'tickets', 'replyencryptedinfo','This reply contain sensitive data' FROM hb_language
UNION SELECT id, 'tickets', 'encryptreply','This reply contain sensitive data, encrypt its contents' FROM hb_language
UNION SELECT id, 'global', 'emailreplyencryptcontent','==CONTENT REMOVED AS IT WAS MARKED AS SENSITIVE. FULL CONTENT IS AVAILABLE IN THE TICKET DETAILS==' FROM hb_language;
