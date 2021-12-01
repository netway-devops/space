UPDATE `hb_configuration` SET `value` = '4.7.8' WHERE `setting`= 'Version';
##########
ALTER TABLE `hb_ticket_replies`
CHANGE COLUMN `status` `status` ENUM('Sent','Draft','Scheduled') NOT NULL DEFAULT 'Sent' AFTER `body`;
##########
INSERT INTO `hb_ticket_status` (`status`, `options`) VALUES ('Scheduled', 4), ('Sent-Out', 4);
##########
REPLACE INTO hb_cron_tasks (`task`,`name`,`lastrun`,`status`,`count`,`metadata`,`output`,`run_every`,`run_every_time`) VALUES
('sendScheduledTickets','Send-Out scheduled support tickets / ticket replies',0,1,0,'','','Run',1200);