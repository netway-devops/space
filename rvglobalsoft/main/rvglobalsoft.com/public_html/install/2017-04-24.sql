REPLACE INTO `hb_configuration` VALUES ('ClientLogoutAfter','30');
##########
INSERT INTO `hb_email_templates` ( `tplname`, `group`, `for`, `language_id`, `subject`, `message`, `altmessage`, `send`, `plain`, `system`, `hidden`)
VALUES
	( 'Account:ChangeOwner:OldOwner', 'General', 'Client', 1, 'Ownership change', 'Dear: {$oldclient.firstname} {$oldclient.lastname} \r\n\r\n{if $domain}{$domain.name}{else}{$service.domain}{/if} was pushed from your account {$oldclient.email} to new owner {$client.email}:\r\n\r\nThis push was completed on {$curdate|dateformat:$date_format}. Please keep this email for your records.\r\n', '', 1, 1, 1, 0),
	('Account:ChangeOwner:NewOwner', 'General', 'Client', 1, 'Ownership change', 'Dear: {$client.firstname} {$client.lastname} \r\n\r\n{if $domain}{$domain.name}{else}{$service.domain}{/if} was pushed from account {$oldclient.email} to your account {$client.email}:\r\n\r\nThis push was completed on {$curdate|dateformat:$date_format}. Please keep this email for your records.\r\n', '', 1, 1, 1, 0),
	('Details:Login', 'General', 'Client', 1, 'New login to billing portal', 'Dear {$client.firstname} {$client.lastname},\r\n\r\nWith this e-mail we would like to welcome back to your  billing account!\n\n------------------------------------------------------------------\nLogin information:\n\nLogin ID: {$client.email}\nIP Address: {$session.ip_address},\nBrowser type: {$session.browser.name},\nOperating system/platform: {$session.browser.platform},\nFull User-Agent: {$session.browser.userAgent}', '', 0, 1, 1, 0);
##########
ALTER TABLE `hb_client_fields` ADD `country` TEXT  NULL  AFTER `expression`;
