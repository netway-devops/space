INSERT INTO `hb_email_templates` (`id`, `tplname`, `group`, `for`, `language_id`, `subject`, `message`, `altmessage`, `send`, `plain`, `system`, `hidden`)
VALUES
	(NULL, 'Account:Cancellation Request', 'General', 'Client', 1, 'Cancellation Request', 'Dear: {$client.firstname} {$client.lastname} \r\n\r\n# We have received following cancelation request: \r\n\r\n# Account ID: {$details.acc_id}\r\n# Type: {$details.type}\r\n# Reason: {$details.reason}', '', 1, 1, 1, 0);
##########
UPDATE hb_language_locales SET section='global' WHERE keyword='paidbybalance';
