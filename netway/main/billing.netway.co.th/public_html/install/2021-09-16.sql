ALTER TABLE `hb_ticket_departments_sla` ADD `de_escalate` TINYINT DEFAULT 0 AFTER `tags`;
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'DefaultTicketRate','Default Ticket Rate' FROM hb_language WHERE target='admin';
##########
ALTER TABLE `hb_ticket_departments` ADD `default_rate` INT(10) NOT NULL DEFAULT  '0' AFTER  `autoclose`;