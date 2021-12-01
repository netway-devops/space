REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'removeTicket','Remove Support tickets' FROM hb_language WHERE target!='user'
UNION SELECT id, 'global', 'editTicket','Edit Support Tickets' FROM hb_language WHERE target!='user'
UNION SELECT id, 'global', 'editOwnMesg','Edit Own Ticket reply' FROM hb_language WHERE target!='user'
UNION SELECT id, 'global', 'manageMacros','Manage / Use Ticket Macro' FROM hb_language WHERE target!='user'
UNION SELECT id, 'global', 'passistooshort','Password is too short (minimum is %d characters)' FROM hb_language WHERE target!='user'
UNION SELECT id, 'global', 'pass_lowercase','Password requires at least one lowercase character' FROM hb_language
UNION SELECT id, 'global', 'pass_uppercase','Password requires at least one uppercase character' FROM hb_language
UNION SELECT id, 'global', 'pass_numbers','Password requires at least one numeric character' FROM hb_language
UNION SELECT id, 'global', 'pass_symbol','Password requires at least one symbol character' FROM hb_language;
##########
UPDATE hb_admin_access SET `access`=CONCAT(`access`,',removeTicket,editTicket,editOwnMesg,manageMacros') WHERE `access` LIKE "%viewTickets%";
##########
UPDATE hb_admin_log SET `update`=3 WHERE logout='0000-00-00 00:00:00';