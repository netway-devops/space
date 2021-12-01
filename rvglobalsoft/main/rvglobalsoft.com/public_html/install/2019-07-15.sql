ALTER TABLE `hb_tickets_predefinied` ADD `subscribers` TEXT DEFAULT NULL AFTER `owner`;
##########
ALTER TABLE `hb_tickets_predefinied` ADD `sub_email` INT(11) NOT NULL DEFAULT 0 AFTER `notify`;
##########
ALTER TABLE `hb_ticket_departments` ADD `macro_reportreply` INT(10) NOT NULL DEFAULT 0;
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT `id`, 'tickets', 'report_reply','Report this reply' FROM hb_language WHERE target='user'
UNION SELECT `id`, 'tickets', 'report_reply_to_manager','Report message below to manager' FROM hb_language WHERE target='user'
UNION SELECT `id`, 'tickets', 'report_reply_note','Please note: Escalating reply may increase response time. Message can be only reported once.' FROM hb_language WHERE target='user'
UNION SELECT `id`, 'tickets', 'report_reply_info','Thank you, this massage is now marked as reported' FROM hb_language WHERE target='user'
UNION SELECT `id`, 'tickets', 'report_reply_question','Are you sure you want to report this reply?' FROM hb_language WHERE target='user'
UNION SELECT `id`, 'tickets', 'reply_reported','Submitter reported this message' FROM hb_language WHERE target='admin';
##########
ALTER TABLE `hb_ticket_replies` ADD `flags` INT(11) NOT NULL DEFAULT 0;