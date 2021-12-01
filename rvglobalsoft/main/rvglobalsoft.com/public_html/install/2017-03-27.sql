ALTER TABLE `hb_task_list` CHANGE `rel_type` `rel_type` ENUM('Hosting','Addon','Ticket','Domain','SingleHosting','SingleDomain')   NOT NULL  DEFAULT 'Hosting';
##########
ALTER TABLE `hb_task_log` CHANGE `rel_type` `rel_type` ENUM('Hosting','Addon','Domain','SingleHosting','SingleDomain')   NOT NULL  DEFAULT 'Hosting';
##########
ALTER TABLE `hb_coupons` ADD `increase_in_days` INT(11)  NOT NULL  DEFAULT '0'  AFTER `max_client_usage`;
