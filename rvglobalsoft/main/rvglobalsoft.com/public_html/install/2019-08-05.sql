ALTER TABLE `hb_ticket_departments` ADD `macro_reportticket` INT(10) NOT NULL DEFAULT 0;
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT `id`, 'tickets', 'report_ticket','Report this ticket' FROM hb_language WHERE target='user'
UNION SELECT `id`, 'tickets', 'report_ticket_reason','Please give reason for reporting this ticket' FROM hb_language WHERE target='user'
UNION SELECT `id`, 'tickets', 'report_ticket_to_manager','Report ticket below to manager' FROM hb_language WHERE target='user'
UNION SELECT `id`, 'tickets', 'report_ticket_note','Please note: Escalating ticket may increase response time. Ticket can be only reported once.' FROM hb_language WHERE target='user'
UNION SELECT `id`, 'tickets', 'report_ticket_info','Thank you, this ticket is now marked as reported' FROM hb_language WHERE target='user'
UNION SELECT `id`, 'tickets', 'report_ticket_question','Are you sure you want to report this ticket?' FROM hb_language WHERE target='user'
UNION SELECT `id`, 'tickets', 'report_ticket_reported','This ticket has already been reported' FROM hb_language WHERE target='user'
UNION SELECT `id`, 'tickets', 'ticket_reported','Submitter reported this ticket' FROM hb_language WHERE target='admin';
##########
ALTER TABLE `hb_tickets_predefinied` ADD `admin_note` TEXT AFTER `reply`;
##########
REPLACE INTO hb_configuration (`setting`, `value`) VALUES ('ReplyToPublicTicket', 'reject');
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT `id`, 'accounts', 'cancelrequest','Request Cancellation' FROM hb_language WHERE target='admin'
UNION SELECT `id`, 'accounts', 'canceltype','Cancellation type' FROM hb_language WHERE target='admin'
UNION SELECT `id`, 'accounts', 'endbillingperiod','End of billing period' FROM hb_language WHERE target='admin'
UNION SELECT `id`, 'accounts', 'adminsubmitted','Admin submitted' FROM hb_language WHERE target='admin'
UNION SELECT `id`, 'accounts', 'empty_reason','Reason cannot be empty' FROM hb_language WHERE target='admin'
UNION SELECT `id`, 'accounts', 'Admin submitted','Admin submitted' FROM hb_language WHERE target='admin';
##########
ALTER TABLE `hb_cancel_requests` CHANGE COLUMN `type` `type` ENUM('Immediate','End of billing period','Admin submitted','Other') NOT NULL AFTER `reason`;