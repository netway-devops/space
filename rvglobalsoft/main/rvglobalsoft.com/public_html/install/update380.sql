UPDATE `hb_configuration` SET `value` = '3.8.0' WHERE `setting`= 'Version';
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'domcontacts','Domain contacts' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'global', 'PrePay','Pre-Paid' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'global', 'PrePay','Pre-Paid' FROM hb_language WHERE target='admin'
UNION SELECT id, 'cart', 'domcontact_loged','Use my details as domain contacts' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'cart', 'domcontact_checkout','Use main contact details I’ll provide during checkout ' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'global', 'definenew','Define new' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'global', 'registrant','Registrant' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'global', 'admininfo','Admin contact:' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'cart', 'useregistrant','Use registrant information' FROM hb_language WHERE target!='admin';
##########
UPDATE `hb_language_locales` SET `section` = 'global' 
WHERE (`keyword` = 'techinfo' AND `section` = 'clientarea') 
OR (`keyword` = 'billinginfo' AND `section` = 'clientarea')
OR (`keyword` = 'registrantinfo' AND `section` = 'clientarea')
OR (`keyword` = 'seconds' AND `section` = 'stats');
##########
ALTER TABLE `hb_tickets_predefinied` ADD COLUMN `share` INT NULL AFTER `tags`;
##########
REPLACE INTO `hb_configuration` (`setting`,`value`) VALUES ('TicketImportTimeLimit', 5);
##########
INSERT INTO `hb_email_templates` (`tplname`, `group`, `for`, `language_id`, `subject`, `message`, `send`, `plain`, `system`, `hidden`) VALUES
('Ticket:TimeLimit', 'Support', 'Client', 1, 'Your Ticket was not opened', '{$email_name},\r\n\r\nYour email to our support system could not be accepted as ticket, you have to wait {$time_left} second(s) before sending next request.', 1, 1, 1, 0)
