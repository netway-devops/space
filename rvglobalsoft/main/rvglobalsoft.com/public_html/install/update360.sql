UPDATE `hb_configuration` SET `value` = '3.6.0' WHERE `setting`= 'Version';
##########
CREATE TABLE `hb_order_drafts` (
	`id` INT(10) NOT NULL AUTO_INCREMENT,
	`payment_module` INT(10) NOT NULL,
	`client_id` INT(10) NOT NULL,
	`total` DECIMAL(10,2) NOT NULL,
	`date_created` DATETIME NOT NULL,
	`options` TINYINT NOT NULL DEFAULT '7',
	PRIMARY KEY (`id`),
	INDEX `client_id` (`client_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_order_drafts_items` (
	`draft_id` INT(10) UNSIGNED NOT NULL,
	`item_id` INT(10) NOT NULL,
	`item_type` VARCHAR(50) NOT NULL,
	`settings` TEXT NOT NULL,
	PRIMARY KEY (`draft_id`, `item_id`, `item_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
REPLACE INTO hb_cron_tasks (`task`,`name`,`lastrun`,`status`,`count`,`metadata`,`output`,`run_every`,`run_every_time`) VALUES
('processAccountProvisioning','Auto provision paid accounts',0,-1,0,'','','Run',1200);
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'services', 'procesbycron','After payment received, process by cron' FROM hb_language WHERE target='admin'
UNION SELECT id, 'orders', 'newdraft','New Order Draft' FROM hb_language WHERE target='admin'
UNION SELECT id, 'orders', 'deldraft','Delete draft' FROM hb_language WHERE target='admin'
UNION SELECT id, 'orders', 'generatefromdraft','Generate order from this Draft' FROM hb_language WHERE target='admin'
UNION SELECT id, 'orders', 'generatefromdrafts','Generate orders from selected Drafts' FROM hb_language WHERE target='admin'
UNION SELECT id, 'orders', 'draftid','Draft ID' FROM hb_language WHERE target='admin'
UNION SELECT id, 'global', 'revertchanges','Revert changes' FROM hb_language WHERE target='admin'
UNION SELECT id, 'global', 'whenfinished','When finished' FROM hb_language WHERE target='admin';
##########
UPDATE `hb_language_locales` SET `section` = 'global' WHERE (`keyword` = 'selectcustomer' AND `section` = 'invoices') OR (`keyword` = 'savedraft' AND `section` = 'tickets');
