CREATE TABLE IF NOT EXISTS `hb_mettered_summary` (
  `account_id` int(11) NOT NULL,
  `variable_id` int(11) NOT NULL,
  `type` enum('report','summary') NOT NULL,
  `last_value_id` int(11) NOT NULL,
  `date_start` date NOT NULL,
  `date_end` datetime NOT NULL,
  `usage` decimal(25,5) NOT NULL,
  `charge` decimal(25,5) NOT NULL,
  PRIMARY KEY (`account_id`,`variable_id`,`type`),
  KEY `account_id` (`account_id`),
  KEY `date_start` (`date_start`),
  KEY `variable_id` (`variable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
ALTER TABLE `hb_mettered_values`
ADD INDEX `variable_id_account_id` (`variable_id`, `account_id`);
##########
ALTER TABLE `hb_mettered_reports`
ADD INDEX `account_id_variable_id` (`account_id`, `variable_id`);
##########
REPLACE INTO `hb_cron_tasks` (`task`, `name`, `lastrun`, `status`, `count`, `metadata`, `output`, `run_every`, `run_every_time`) 
VALUES ('meteredBillingCleanup', 'Cleanup old Metered Billing data', now(), 1, 0, '', '', 'Time', '0100');


