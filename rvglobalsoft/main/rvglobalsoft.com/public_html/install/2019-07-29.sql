CREATE TABLE IF NOT EXISTS `hb_ticket_departments_import` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dept_id` int(11) NOT NULL,
  `hash` char(32) DEFAULT NULL,
  `method` varchar(50) NOT NULL,
  `config` text NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `hash` (`hash`),
  KEY `dept_id` (`dept_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'ticketdepts', 'import_msg_tab', 'Import Messages' FROM hb_language WHERE target='admin'
UNION SELECT id, 'ticketdepts', 'send_msg_tab', 'Notification' FROM hb_language WHERE target='admin';
##########
INSERT INTO `hb_email_templates` (`tplname`, `group`, `for`, `language_id`, `subject`, `message`, `altmessage`, `send`, `plain`, `system`, `hidden`, `notify`)
VALUES ('Mobile:Ticket:New', 'Mobile', 'Client', 1, 'New Support Ticket', 'Dear client, thank you for your request, we will be in touch shortly.', '', 1, 1, 1, 0, 0);
##########
INSERT INTO `hb_cron_tasks` (`task`, `name`, `lastrun`, `status`, `count`, `metadata`, `output`, `run_every`, `run_every_time`, `profile_id`)
VALUES ('importTickets', 'Import Tickets', '0000-00-00 00:00:00', 1, 0, '', '', 'Run', '1200', 1);