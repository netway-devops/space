CREATE TABLE IF NOT EXISTS `hb_tickets_public` (
  `ticket_id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  PRIMARY KEY (`ticket_id`,`client_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
REPLACE INTO `hb_configuration` (`setting`, `value`) VALUES ('EmailsPerCronRun', '200');
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'ticket_is_public','This is announcement ticket, replying directly to it is not possible. To reply to this case, please open new ticket' FROM hb_language
UNION SELECT id, 'tickets', 'reply_scheduled','Reply has been scheduled for emailing, it will be visible once email is sent' FROM hb_language WHERE target!='user'
UNION SELECT id, 'tickets', 'ticket_scheduled','Ticket has been scheduled for emailing, it will be visible once email is sent' FROM hb_language WHERE target!='user';
##########
INSERT INTO `hb_email_templates` (`id`, `tplname`, `group`, `for`, `language_id`, `subject`, `message`, `altmessage`,`send`, `plain`, `system`, `hidden`) VALUES
(NULL, 'Ticket:BouncePublic', 'Support', 'Client', 1, 'Your reply was not accepted', 'Your email to our support system could not be accepted as reply, because ticket you''re sending it to is public / announcement ticket.\r\nTo reply please open new support ticket in our client portal', '', 1, 1, 1, 0);
