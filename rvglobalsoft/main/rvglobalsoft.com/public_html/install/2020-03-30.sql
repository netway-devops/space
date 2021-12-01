REPLACE INTO hb_configuration (`setting`, `value`) VALUES ('CCForceAttempt', 'off');
##########
CREATE TABLE IF NOT EXISTS `hb_tickets_timers` (
   `id` int(11) NOT NULL AUTO_INCREMENT,
   `ticket_id` int(11) NOT NULL,
   `macro_id` int(11) NOT NULL,
   `name` VARCHAR(255) NOT NULL DEFAULT '',
   `start_date` datetime NULL,
   `timezone` VARCHAR(255) NULL DEFAULT '',
   `executed_at` datetime NULL,
   `executed_by` varchar(255) NULL,
   `created_at` datetime NULL,
   `created_by` varchar(255) NULL,
   `created_by_id` int(11) NULL DEFAULT 0,
   `auto_reset` tinyint(1) NOT NULL DEFAULT 0,
   `status` enum('Pending', 'Executed', 'Canceled manually', 'Canceled by reply') NOT NULL DEFAULT 'Pending',
   PRIMARY KEY (`id`),
   KEY (`ticket_id`),
   KEY (`macro_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'editadmins', 'createTicketTimers', 'Create Ticket Timers' FROM hb_language WHERE target='admin'
UNION SELECT id, 'editadmins', 'editTicketTimers', 'Edit Ticket Timers' FROM hb_language WHERE target='admin'
UNION SELECT id, 'editadmins', 'viewTicketTimers', 'View Ticket Timers' FROM hb_language WHERE target='admin'
UNION SELECT id, 'editadmins', 'executeTicketTimers', 'Execute Ticket Timers' FROM hb_language WHERE target='admin'
UNION SELECT id, 'editadmins', 'cancelTicketTimers', 'Cancel Ticket Timers' FROM hb_language WHERE target='admin'
UNION SELECT id, 'editadmins', 'removeTicketTimers', 'Remove Ticket Timers' FROM hb_language WHERE target='admin';
##########
ALTER TABLE `hb_tickets_predefinied` ADD `relation` ENUM('none', 'timers') NOT NULL DEFAULT 'none';
##########
UPDATE `hb_tickets_predefinied` SET `relation` = 'none';
##########
REPLACE INTO `hb_cron_tasks` (`task`, `name`, `lastrun`, `status`, `count`, `metadata`, `output`, `run_every`,`run_every_time`, `profile_id`)
VALUES ('executeTicketTimers', 'Execute ticket timers', '0000-00-00 00:00:00', 1, 0, '', '', 'Run', '1200', 1);
##########
UPDATE hb_admin_access SET `access` = CONCAT(access, ',createTicketTimers,editTicketTimers,viewTicketTimers,executeTicketTimers,cancelTicketTimers,removeTicketTimers') WHERE `access` LIKE '%editTicket%';
##########
UPDATE `hb_admin_teams` SET `access` = CONCAT(access, ',createTicketTimers,editTicketTimers,viewTicketTimers,executeTicketTimers,cancelTicketTimers,removeTicketTimers') WHERE `access` LIKE '%editTicket%';