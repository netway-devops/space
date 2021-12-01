UPDATE `hb_configuration` SET `value` = '4.3.8' WHERE `setting`= 'Version';
##########
ALTER TABLE `hb_mettered_values`
ADD COLUMN `currency_id` INT NOT NULL DEFAULT '0' AFTER `date_updated`;
##########
ALTER TABLE `hb_mettered_reports`
ADD COLUMN `currency_id` INT NOT NULL DEFAULT '0' AFTER `charge`;
##########
INSERT INTO `hb_configuration` (`setting`, `value`) VALUES ('CCForceAttempt', 'off');
##########
INSERT INTO `hb_email_templates` (`id`, `tplname`, `group`, `for`, `language_id`, `subject`, `message`, `send`, `plain`, `system`, `hidden`) VALUES
(NULL, 'Ticket:BounceClose', 'Support', 'Client', 1, 'Your ticket is closed', '{$email_name},\r\n\r\nYour email to our support system could not be accepted as ticket reply because related ticket has already been closed by staff member. If required, please open new ticket.', 1, 1, 1, 0);
