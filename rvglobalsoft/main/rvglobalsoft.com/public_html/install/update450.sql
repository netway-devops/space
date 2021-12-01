UPDATE `hb_configuration` SET `value` = '4.5.0' WHERE `setting`= 'Version';
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'myhistory','My History' FROM hb_language WHERE target='user'
UNION SELECT id, 'clients', 'billing_creditcard','Edit Credit Card details' FROM hb_language WHERE target='admin'
UNION SELECT id, 'profiles', 'billing_creditcard','Edit Credit Card details' FROM hb_language WHERE target='user'
UNION SELECT id, 'clients', 'misc_editipaccess','Edit allowed IP access' FROM hb_language WHERE target='admin';
##########
INSERT INTO `hb_email_templates` (`id`, `tplname`, `group`, `for`, `language_id`, `subject`, `message`, `send`, `plain`, `system`, `hidden`) VALUES
('', 'Mobile:Ticket:Closed', 'Mobile', 'Admin', 1, 'Support Ticket Closed', 'Subject: {$ticket.subject}\r\n Submitter: {$ticket.name} \r\n Dept: {$ticket.department}', 1, 1, 1, 0);
##########
UPDATE `hb_client_fields` SET `options`=331 WHERE `code`='password' LIMIT 1;