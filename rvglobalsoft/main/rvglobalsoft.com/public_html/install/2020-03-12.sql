REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'createTicketTags','Create Ticket Tags' FROM hb_language WHERE target!='user';
##########
UPDATE hb_admin_access SET `access` = CONCAT(`access`,',createTicketTags') WHERE `access` LIKE '%editTicket%';
##########
UPDATE hb_admin_teams SET `access` = CONCAT(`access`,',createTicketTags') WHERE `access` LIKE '%editTicket%';