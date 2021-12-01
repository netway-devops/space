UPDATE `hb_configuration` SET `value` = '3.7.0' WHERE `setting`= 'Version';
##########
CREATE TABLE `hb_admin_fields` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`name` VARCHAR(127) NOT NULL,
	`variable` VARCHAR(127) NOT NULL,
	`type` VARCHAR(127) NOT NULL,
        `default` TEXT NOT NULL DEFAULT '',
	PRIMARY KEY (`id`),
        KEY (`variable`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_admin_fields_values` (
	`field_id` INT(11) NOT NULL,
	`admin_id` INT(11) NOT NULL,
	`value` TEXT NOT NULL,
	PRIMARY KEY (`field_id`,`admin_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
ALTER TABLE `hb_servers` ADD `custom` TEXT NOT NULL;
##########
CREATE TABLE `hb_accounts_tags` (
	`account_id` INT(11) NOT NULL,
        `target_id` INT(11) NOT NULL DEFAULT '0',
	`tag` VARCHAR(63),
	PRIMARY KEY (`account_id`,`target_id`,`tag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
ALTER TABLE `hb_modules_configuration` CHANGE `type` `type` ENUM( 'Hosting', 'Payment', 'Domain', 'Fraud', 'Other', 'Notification' )  NOT NULL ;
##########
ALTER TABLE `hb_email_templates` CHANGE `group` `group` ENUM( 'Domain', 'Product', 'Invoice', 'General', 'Support', 'Custom', 'Mobile' ) NULL DEFAULT NULL ;
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'notificationmodules','Notification modules' FROM hb_language WHERE target='admin'
UNION SELECT id, 'global', 'Notifications','Mobile Notifications' FROM hb_language WHERE target='admin'
UNION SELECT id, 'notifications', 'notification_settings','Notification settings' FROM hb_language WHERE target='admin';
##########
UPDATE hb_language_locales SET `value`='Notification System' WHERE `keyword`='emailnotification' AND `section`='editadmins' AND `language_id`='1';
##########
INSERT INTO `hb_email_templates` (`id`, `tplname`, `group`, `for`, `language_id`, `subject`, `message`, `send`, `plain`, `system`, `hidden`) VALUES
('', 'Mobile:Account:Created', 'Mobile', 'Client', 1, 'Your service is ready', 'Dear client, Your order has been accepted and your service {$service.product_name} is active', 1, 1, 1, 0),
('', 'Mobile:Domain:Registered', 'Mobile', 'Client', 1, 'Your domain has been registered', 'Dear client, Your domain: {$domain.name} has been registered', 1, 1, 1, 0),
('', 'Mobile:Domain:Transfered', 'Mobile', 'Client', 1, 'Your domain has been transfered', 'Dear client, Your domain: {$domain.name} has been transfered', 1, 1, 1, 0),
('', 'Mobile:Domain:Reminder', 'Mobile', 'Client', 1, 'Your domain will soon expire', 'Dear client, Your domain: {$domain.name} will soon expire - make sure to renew!', 1, 1, 1, 0),
('', 'Mobile:Invoice:New', 'Mobile', 'Client', 1, 'New invoice', 'Dear client, New invoice has been added to your account with us, proceed to our client area for details', 1, 1, 1, 0),
('', 'Mobile:Invoice:Reminder', 'Mobile', 'Client', 1, 'Due invoice', 'Dear client, Invoice in your account is due, to avoid downtimes pay it in time', 1, 1, 1, 0),
('', 'Mobile:Ticket:Reply', 'Mobile', 'Client', 1, 'Reply to ticket', 'Dear client, staff member replied to your support ticket -  {$ticket.subject}', 1, 1, 1, 0),
('', 'Mobile:Ticket:New', 'Mobile', 'Admin', 1, 'New Support Ticket', 'Subject: {$ticket.subject}\r\n Submitter: {$ticket.name} \r\n Dept: {$ticket.department}', 1, 1, 1, 0),
('', 'Mobile:Ticket:Escalated', 'Mobile', 'Admin', 1, 'Support Ticket Escalated', 'Subject: {$ticket.subject}\r\n Submitter: {$ticket.name} \r\n Dept: {$ticket.department}', 1, 1, 1, 0),
('', 'Mobile:Ticket:Reply', 'Mobile', 'Admin', 1, 'Client repiled to ticket', 'Subject: {$ticket.subject}\r\n Submitter: {$ticket.name} \r\n Dept: {$ticket.department}', 1, 1, 1, 0),
('', 'Mobile:Ticket:Note', 'Mobile', 'Admin', 1, 'New ticket note', '#{$ticket.ticket_number} \r\n Note: {$note.msg}', 1, 1, 1, 0),
('', 'Mobile:Failed Login', 'Mobile', 'Admin', 1, 'Adminarea failed login', 'Failed Login: Date: {$date}\r\nIP: {$ip}\r\nHost: {$host}\r\n\r\nLogin: {$login}', 1, 1, 1, 0),
('', 'Mobile:Order:New', 'Mobile', 'Admin', 1, 'New HostBill Order', 'Client: {$client.firstname} {$client.lastname}\r\nTotal(+tax): {$order.total|price:$currency}', 1, 1, 1, 0),
('', 'Mobile:Transaction:New', 'Mobile', 'Admin', 1, 'New Payment from client', 'Transaction total: {$transaction.in|price:$currency}, Invoice: {$transaction.invoice_id}', 1, 1, 1, 0),
('', 'Mobile:AccountAutomation:Failed', 'Mobile', 'Admin', 1, 'Account automation failed', 'Action: {$account_action}, {if $account_error}Errors:{foreach from=$account_error item=errx} {$errx}    {/foreach}{/if}Account ID: {$service.id} ', 1, 1, 1, 0),
('', 'Mobile:DomainAutomation:Failed', 'Mobile', 'Admin', 1, 'Domain automation failed', 'Action:  {$domain_action} FAILED, {if $domain_error}Error: {$domain_error}{/if}, Domain Name: {$domain.name}', 1, 1, 1, 0),
('', 'Ticket:Assigned', 'Support', 'Admin', 1, 'You have been assigned to ticket: #{$ticket.ticket_number}', 'Staff member: {$admin.firstname} {$admin.lastname} assigned you to ticket #{$ticket.ticket_number}\r\n\r\n------------------------------------------\r\n\r\n{$ticket.body}\r\n\r\n------------------------------------------\r\nSubject: {$ticket.subject}\r\nStatus: {$ticket.status}\r\nSubmitter: {$ticket.name}\r\nURL: {$ticket_admin_url}\r\n----------------------------------------------', 1, 1, 1, 0),
('', 'Ticket:Escalated', 'Support', 'Admin', 1, 'Ticket: #{$ticket.ticket_number} has been escalated', 'This ticket is now: {if $overdue}OVERDUE{else}ESCALATED{/if}\r\n\r\nTicket #{$ticket.ticket_number}\r\nSubject: {$ticket.subject}\r\nStatus: {$ticket.status}\r\nSubmitter: {$ticket.name}\r\nURL: {$ticket_admin_url}\r\n----------------------------------------------', 1, 1, 1, 0);
##########
REPLACE INTO `hb_configuration` VALUES ('MobileNotificationsAdmin','off');
##########
REPLACE INTO `hb_configuration` VALUES ('MobileNotificationsClient','off');
##########
REPLACE INTO `hb_configuration` VALUES ('MobileNotificationsModClient','all');
##########
REPLACE INTO `hb_configuration` VALUES ('MobileNotificationsModAdmin','all');
##########
ALTER TABLE `hb_email_templates`
DROP PRIMARY KEY,
DROP INDEX `language_id`,
ADD PRIMARY KEY (`id`, `language_id`);
##########
ALTER TABLE `hb_ticket_departments`
ADD COLUMN `sla_level_one` INT(10) UNSIGNED NOT NULL DEFAULT '0' AFTER `autoclose`,
ADD COLUMN `sla_level_two` INT(10) UNSIGNED NOT NULL DEFAULT '0' AFTER `sla_level_one`;
##########
ALTER TABLE `hb_ticket_departments`
ADD COLUMN `macro_sla1_id` INT(10) UNSIGNED NOT NULL DEFAULT '0' AFTER `sla_level_two`,
ADD COLUMN `macro_sla2_id` INT(10) UNSIGNED NOT NULL DEFAULT '0' AFTER `macro_sla1_id`;
##########
ALTER TABLE `hb_tickets`
ADD COLUMN `escalated` TINYINT(1) NOT NULL AFTER `senderip`,
ADD COLUMN `start_date` DATETIME NOT NULL AFTER `escalated`,
ADD COLUMN `resolve_date` DATETIME NOT NULL AFTER `start_date`;
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'ticketdepts', 'slaescalate','SLA / Escalations' FROM hb_language WHERE target='admin'
UNION SELECT id, 'ticketdepts', 'blanksla','SLA (Service Level Agreement) is an agreement you can offer to meet certain standards in your support quality. SLA set for 15 minutes in HostBill means<br /> that if ticket wont be answered within 15 minutes it will be considered as overdue, and escalated. Additionally you can set time in which ticket should be closed (resolved) by a staff member' FROM hb_language WHERE target='admin'
UNION SELECT id, 'ticketdepts', 'escalate_unresponded','Escalate un-responded ticket in' FROM hb_language WHERE target='admin'
UNION SELECT id, 'ticketdepts', 'escalate_unresolved','Overdue un-closed ticket in' FROM hb_language WHERE target='admin'
UNION SELECT id, 'ticketdepts', 'minutes','Minute(s)' FROM hb_language WHERE target='admin'
UNION SELECT id, 'ticketdepts', 'hours','Hour(s)' FROM hb_language WHERE target='admin'
UNION SELECT id, 'ticketdepts', 'days','Day(s)' FROM hb_language WHERE target='admin'
UNION SELECT id, 'tickets', 'author_uuid','Author UUID' FROM hb_language WHERE target='admin'
UNION SELECT id, 'tickets', 'nothing_assigned','There are no tickets assigned to you.' FROM hb_language WHERE target='admin'
UNION SELECT id, 'tickets', 'nothing_indept','There are no tickets in this department yet.' FROM hb_language WHERE target='admin'
UNION SELECT id, 'tickets', 'nothing_here','There are no open support tickets, you can wait for your clients to submit them or open them yourself.' FROM hb_language WHERE target='admin'
UNION SELECT id, 'global', 'ticketmacros','Ticket Macros' FROM hb_language WHERE target='admin'
UNION SELECT id, 'global', 'ticketfilters','Ticket Filters' FROM hb_language WHERE target='admin'
UNION SELECT id, 'ticketbans', 'pre_import','Pre-import filter' FROM hb_language WHERE target='admin'
UNION SELECT id, 'ticketbans', 'post_import','Post-import' FROM hb_language WHERE target='admin'
UNION SELECT id, 'ticketbans', 'filter','filter' FROM hb_language WHERE target='admin'
UNION SELECT id, 'ticketbans', 'filters','filters' FROM hb_language WHERE target='admin'
UNION SELECT id, 'ticketbans', 'addprefilter','Add pre-import filter' FROM hb_language WHERE target='admin'
UNION SELECT id, 'ticketbans', 'addpostfilter','Add post-import filter' FROM hb_language WHERE target='admin'
UNION SELECT id, 'global', 'match','Match' FROM hb_language WHERE target='admin'
UNION SELECT id, 'global', 'Any','Any' FROM hb_language WHERE target='admin'
UNION SELECT id, 'global', 'If','If' FROM hb_language WHERE target='admin'
UNION SELECT id, 'global', 'newmacro','Create new macro' FROM hb_language WHERE target='admin'
UNION SELECT id, 'ticketbans', 'ticket_rule_added','New filter rule added' FROM hb_language WHERE target='admin'
UNION SELECT id, 'ticketbans', 'ticket_rule_removed','Filter removed' FROM hb_language WHERE target='admin'
UNION SELECT id, 'ticketbans', 'ticket_rule_updated','Filter updated' FROM hb_language WHERE target='admin'
UNION SELECT id, 'ticketbans', 'final','Final' FROM hb_language WHERE target='admin'
UNION SELECT id, 'ticketbans', 'final_desc','Filters with final option will stop hostbill from checking other filters if they are matched, that means filters after this one wont get a chance to apply their functions.' FROM hb_language WHERE target='admin'
UNION SELECT id, 'ticketbans', 'Contains','Contains' FROM hb_language WHERE target='admin'
UNION SELECT id, 'ticketbans', 'exact_match','Exact match' FROM hb_language WHERE target='admin'
UNION SELECT id, 'ticketbans', 'regex','Regular expression' FROM hb_language WHERE target='admin'
UNION SELECT id, 'ticketbans', 'removeruleconfirm','Are you sure you wish to remove this item?' FROM hb_language WHERE target='admin'
UNION SELECT id, 'ticketbans', 'blank_pre_header','Filter out unwanted messages' FROM hb_language WHERE target='admin'
UNION SELECT id, 'ticketbans', 'blank_pre_desc','Create filters that will check against imported emails, and won\'t let unwanted messages in.' FROM hb_language WHERE target='admin'
UNION SELECT id, 'ticketbans', 'blank_post_header','Take additional acctions' FROM hb_language WHERE target='admin'
UNION SELECT id, 'ticketbans', 'blank_post_desc','With the use of macros and fiters you can automaticaly set things like assigned staf member, tags, priority and more, to new tickets.' FROM hb_language WHERE target='admin'
UNION SELECT id, 'predefinied', 'addmacro','Add macro' FROM hb_language WHERE target='admin'
UNION SELECT id, 'predefinied', 'reply_added','Macro added' FROM hb_language WHERE target='admin'
UNION SELECT id, 'predefinied', 'reply_removed','Macro removed' FROM hb_language WHERE target='admin'
UNION SELECT id, 'predefinied', 'reply_emptycat','Choose category to add macro into' FROM hb_language WHERE target='admin'
UNION SELECT id, 'predefinied', 'removereplyconfirm','Do you really want to remove this reply?' FROM hb_language WHERE target='admin'
UNION SELECT id, 'predefinied', 'predefined_mylistadd','New macro added to your list' FROM hb_language WHERE target='admin'
UNION SELECT id, 'predefinied', 'blank_kb_desc','You can add new macro using this section or save your ticket setting for later use.' FROM hb_language WHERE target='admin'
UNION SELECT id, 'predefinied', 'blank_kb2','Your macro list is empty, click ' FROM hb_language WHERE target='admin'
UNION SELECT id, 'predefinied', 'blank_kb','Create category' FROM hb_language WHERE target='admin'
UNION SELECT id, 'global', 'manageyour','Manage your list' FROM hb_language WHERE target='admin'
UNION SELECT id, 'global', 'changepriority','Change priority' FROM hb_language WHERE target='admin'
UNION SELECT id, 'global', 'changestatus','Change status' FROM hb_language WHERE target='admin'
UNION SELECT id, 'global', 'priority','Priority' FROM hb_language WHERE target='admin'
UNION SELECT id, 'global', 'nochange','No change' FROM hb_language WHERE target='admin'
UNION SELECT id, 'global', 'assignedto','Assigned to' FROM hb_language WHERE target='admin'
UNION SELECT id, 'global', 'assignto','Assign to' FROM hb_language WHERE target='admin'
UNION SELECT id, 'global', 'owner','Owner' FROM hb_language WHERE target='admin'
UNION SELECT id, 'global', 'Affects','Affects' FROM hb_language WHERE target='admin'
UNION SELECT id, 'global', 'Usage','Usage' FROM hb_language WHERE target='admin'
UNION SELECT id, 'global', 'Note','Note' FROM hb_language WHERE target='admin'
UNION SELECT id, 'global', 'And','And' FROM hb_language WHERE target='admin'
UNION SELECT id, 'tickets', 'asmacro','Save as Macro' FROM hb_language WHERE target='admin'
UNION SELECT id, 'tickets', 'askbarticle','Insert into Knowledgebase' FROM hb_language WHERE target='admin'
UNION SELECT id, 'global', 'mymacros','My Macros' FROM hb_language WHERE target='admin'
UNION SELECT id, 'global', 'browsemacros','Browse Macros' FROM hb_language WHERE target='admin'
UNION SELECT id, 'predefinied', 'reply_updated','Macro updated' FROM hb_language WHERE target='admin'
UNION SELECT id, 'predefinied', 'addtoyourlist','Add new macro to your list' FROM hb_language WHERE target='admin'
UNION SELECT id, 'global', 'applymacro','Apply macro' FROM hb_language WHERE target='admin'
UNION SELECT id, 'ticketdepts', 'clientsetpriority','Choose priority' FROM hb_language WHERE target='admin'
UNION SELECT id, 'ticketdepts', 'yesclientsetpriority','Allow client to select priority for ticket' FROM hb_language WHERE target='admin'
UNION SELECT id, 'ticketdepts', 'noclientsetpriority','Only staff member can change ticket priority' FROM hb_language WHERE target='admin'
UNION SELECT id, 'tickets', 'priority','Priority' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'tickets', 'low','Low' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'tickets', 'medium','Medium' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'tickets', 'high','High' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'clientarea', 'filterdomains', 'Search your domains...' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'global', 'Reset', 'Reset' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'clientarea', 'javareq','Java is required to run this application' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'clientarea', 'makeitoff','Make sure that your machine is switched off' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'global', 'Go','Go' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'global', 'Accounting','Accounting' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'global', 'Full_Privileges','Full Privileges' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'global', 'Technical_Staff','Technical Staff' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'ticketbans', 'rejectmsg','Reject message' FROM hb_language WHERE target='admin';
##########
UPDATE `hb_language_locales` SET `section` = 'global' 
WHERE (`keyword` = 'Reply' AND `section` = 'tickets') 
OR (`keyword` = 'Medium' AND `section` = 'tickets')
OR (`keyword` = 'Low' AND `section` = 'tickets')
OR (`keyword` = 'High' AND `section` = 'tickets')
OR (`keyword` = 'addreply' AND `section` = 'predefinied');
##########
CREATE TABLE `hb_ticket_filter` (
	`id` INT(10) NOT NULL AUTO_INCREMENT,
	`name` VARCHAR(50) NOT NULL,
	`type` ENUM('pre','post') NOT NULL,
	`final` INT(10) NOT NULL,
	`join_type` ENUM('all','any') NOT NULL,
	`macro_id` INT(10) NOT NULL DEFAULT '0',
	`sort_order` INT(10) NOT NULL DEFAULT '0',
	PRIMARY KEY (`id`),
	INDEX `name` (`name`),
	INDEX `macro_id` (`macro_id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_ticket_filter_items` (
	`id` INT(10) NOT NULL,
	`filter_id` INT(10) NOT NULL,
	`field` VARCHAR(50) NOT NULL,
	`type` ENUM('contains','match','regexp') NOT NULL,
	`content` TEXT NOT NULL,
	PRIMARY KEY (`id`, `filter_id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
ALTER TABLE `hb_invoice_items` CHANGE `type` `type` ENUM( 'Domain Register', 'Domain Renew', 'Domain Transfer', 'Hosting', 'Addon', 'Other', 'Upgrade', 'Invoice', 'Config', 'Credit', 'FieldUpgrade', 'Field' )  NOT NULL ;
##########
ALTER TABLE `hb_tickets_emails`
CHANGE COLUMN `status` `status` VARCHAR(20) NOT NULL AFTER `message`;
##########
UPDATE `hb_tickets_emails` SET `status` = 
  CASE
    WHEN `status` = 'Not Found' THEN '3'
    WHEN `status` = 'Success' THEN '2'
    WHEN `status` = 'Not Registered' THEN '1'
    WHEN `status` = 'Blocked' THEN '0'
    ELSE '5'
  END;
##########
ALTER TABLE `hb_tickets_emails`
CHANGE COLUMN `status` `status` TINYINT(2) NOT NULL AFTER `message`;
##########
ALTER TABLE `hb_tickets`
ADD COLUMN `owner_id` INT NOT NULL DEFAULT '0' AFTER `resolve_date`;
##########
ALTER TABLE `hb_tickets_predefinied`
ADD COLUMN `note` TINYINT NULL AFTER `usability`,
ADD COLUMN `priority` TINYINT NULL AFTER `note`,
ADD COLUMN `status` TINYINT NULL AFTER `priority`,
ADD COLUMN `owner` INT(10) NULL AFTER `status`,
ADD COLUMN `tags` TEXT NULL AFTER `owner`;
##########
INSERT INTO `hb_ticket_filter` (`id`, `name`, `type`, final, join_type, macro_id, sort_order) VALUES (1, 'Example', 'pre', 1, 'any', 0 , 0);
##########
INSERT INTO `hb_ticket_filter_items` (`id`, `filter_id`, `field`, `type`, `content`) 
VALUES (1,1, 'subject', 'contains', '***SPAM'), (2, 1, 'body', 'regexp', '/eval\\s*(\\s*base64_decode/i');
##########
REPLACE INTO hb_cron_tasks (`task`,`name`,`lastrun`,`status`,`count`,`metadata`,`output`,`run_every`,`run_every_time`) VALUES
('processAccountProvisioning','Auto provision paid accounts',0,1,0,'','','Run',1200),
('escalateTickets','Escalate overdue tickets',0,1,0,'','','Run',1200);
