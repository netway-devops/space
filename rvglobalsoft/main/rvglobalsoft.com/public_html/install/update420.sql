UPDATE `hb_configuration` SET `value` = '4.2.0' WHERE `setting`= 'Version';
##########
ALTER TABLE `hb_email_log`
ADD COLUMN `email` VARCHAR(100) NOT NULL AFTER `client_id`,
ADD COLUMN `status` TINYINT NOT NULL DEFAULT '1' AFTER `date`; 
##########
ALTER TABLE `hb_automation_settings` CHANGE `type` `type` ENUM( 'Hosting', 'Addon', 'Domain', 'ClientGroup' )  NOT NULL DEFAULT 'Hosting';
##########
ALTER TABLE `hb_client_access` ADD `group_id` INT( 10 ) NOT NULL DEFAULT '0' AFTER `id` ,
ADD INDEX ( `group_id` );
##########
CREATE TABLE `hb_client_group` (
 `id` int(10) NOT NULL auto_increment,
 `name` varchar(127) NOT NULL,
 `description` text NOT NULL,
 `color` varchar(7) NOT NULL default '#000000',
 `discount` decimal(10,2) NOT NULL default '0.00',
 `scenario_id` int(10) NOT NULL default '0',
 `default_priority` int(1) NOT NULL DEFAULT '0',
 PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'clientgroups','Client Groups' FROM hb_language WHERE target!='user'
UNION SELECT id, 'global', 'deleteInvoices','Delete Invoices' FROM hb_language WHERE target!='user'
UNION SELECT id, 'global', 'avgresptime','Average response time' FROM hb_language WHERE target!='user'
UNION SELECT id, 'global', 'avgresptime_yes','show average response time in clientarea' FROM hb_language WHERE target!='user'
UNION SELECT id, 'global', 'avgresptime_no','disable this feature ' FROM hb_language WHERE target!='user'
UNION SELECT id, 'tickets', 'deptavgresponsetime','Current average response time for this department:' FROM hb_language WHERE target='user'
UNION SELECT id, 'tickets', 'seconds','Second(s)' FROM hb_language WHERE target='user'
UNION SELECT id, 'tickets', 'minutes','Minute(s)' FROM hb_language WHERE target='user'
UNION SELECT id, 'tickets', 'hours','Hour(s)' FROM hb_language WHERE target='user'
UNION SELECT id, 'tickets', 'days','Day(s)' FROM hb_language WHERE target='user'
UNION SELECT id, 'tickets', 'years','Years(s)' FROM hb_language WHERE target='user';
##########
ALTER TABLE `hb_ticket_departments`
CHANGE COLUMN `options` `options` INT(3) UNSIGNED NOT NULL DEFAULT '13' AFTER `smtppassword`;