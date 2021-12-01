REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'editTicketFilters','Adjust Ticket Filters' FROM hb_language WHERE target = 'admin'
UNION SELECT id, 'global', 'emaildeliveryfailed','Email delivery failed' FROM hb_language;
##########
UPDATE `hb_admin_access` SET access = CONCAT(access, ',editTicketFilters') WHERE access LIKE '%editConfiguration%';
##########
UPDATE `hb_admin_teams` SET access = CONCAT(access, ',editTicketFilters') WHERE access LIKE '%editConfiguration%';