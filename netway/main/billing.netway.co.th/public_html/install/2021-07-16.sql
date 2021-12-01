INSERT INTO `hb_configuration` (`setting`, `value`) VALUES
('1ServiceReminder', '0'),
('2ServiceReminder', '0'),
('3ServiceReminder', '0'),
('4ServiceReminder', '0'),
('5ServiceReminder', '0');
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'services', 'ServiceReminder','Send expiration notifications' FROM hb_language
UNION SELECT id, 'services', 'daysbeforeduedate','days before account due date' FROM hb_language
UNION SELECT id, 'services', 'remindNextDueDate','Reminder of the  due date' FROM hb_language
UNION SELECT id, 'automation', 'servicereminder','Send service due date reminder' FROM hb_language;
##########
INSERT INTO `hb_email_templates` (`tplname`, `group`, `for`, `language_id`, `subject`, `message`, `altmessage`, `send`, `plain`, `system`, `hidden`) VALUES
('Account:Reminder', 'Product', 'Client', 1, 'The next due date is coming', 'Dear {$client.firstname} {$client.lastname},\r\n\r\nService: {if !empty($service.domain)}{$service.domain}{else}#{$service.id}{/if} - Next due date {$account.next_due|dateformat:$date_format}.\r\n\r\nPay for the service:\r\n{$clientarea_url}', 'Dear {$client.firstname} {$client.lastname},\r\n\r\nService: {if !empty($service.domain)}{$service.domain}{else}#{$service.id}{/if} - Next due date {$account.next_due|dateformat:$date_format}.\r\n\r\nPay for the service:\r\n{$clientarea_url}', 1, 2, 1, 0);
##########
INSERT INTO `hb_cron_tasks` (`task`, `name`, `lastrun`, `status`, `count`, `metadata`, `output`, `run_every`, `run_every_time`) VALUES
('serviceNotification', 'Send Expiring Service Notifications', '0000-00-00 00:00:00', 1, 0, '', '', 'Time', '1200');