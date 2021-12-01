ALTER TABLE `hb_client_group_discount`
ADD COLUMN `id` INT(11) NOT NULL AUTO_INCREMENT FIRST,
CHANGE COLUMN `group_id` `rel_id` INT(11) NOT NULL AFTER `id`,
ADD COLUMN `rel_type` ENUM('ClientGroup', 'Client') NOT NULL AFTER `rel_id`,
CHANGE COLUMN `rel_id` `item_id` INT(11) NOT NULL AFTER `rel_type`,
CHANGE COLUMN `rel` `item_type` ENUM('Product','Category') NOT NULL AFTER `item_id`,
DROP PRIMARY KEY,
ADD PRIMARY KEY (`id`),
ADD INDEX `rel_id_rel_type` (`rel_id`, `rel_type`);
##########
INSERT INTO `hb_automation_settings` (`item_id`, `type`, `setting`, `value`)
SELECT id, 'ClientGroup', 'DiscountGlobal', discount FROM hb_client_group WHERE discount > 0;
##########
INSERT INTO `hb_automation_settings` (`item_id`, `type`, `setting`, `value`)
SELECT id, 'ClientGroup', 'SupportPriority', default_priority FROM hb_client_group WHERE default_priority > 0;
##########
INSERT INTO `hb_automation_settings` (`item_id`, `type`, `setting`, `value`)
SELECT id, 'ClientGroup', 'OrderScenario', scenario_id FROM hb_client_group WHERE scenario_id > 0;
##########
INSERT INTO `hb_automation_settings` (`item_id`, `type`, `setting`, `value`)
SELECT client_id, 'Client', 'TaxExempt', '1' FROM hb_client_billing WHERE taxexempt = 1;
##########
INSERT INTO `hb_automation_settings` (`item_id`, `type`, `setting`, `value`)
SELECT client_id, 'Client', 'TaxOverrideRate', taxrate FROM hb_client_billing WHERE taxrateoverride = 1;
##########
INSERT INTO `hb_automation_settings` (`item_id`, `type`, `setting`, `value`)
SELECT client_id, 'Client', 'SendPaymentReminderEmails', 'off' FROM hb_client_billing WHERE latefeeoveride = 1;
##########
INSERT INTO `hb_automation_settings` (`item_id`, `type`, `setting`, `value`)
SELECT client_id, 'Client', 'EnableAutoSuspension', 'off' FROM hb_client_billing WHERE overideautosusp = 1
UNION SELECT client_id, 'Client', 'EnableAutoTermination', 'off' FROM hb_client_billing WHERE overideautosusp = 1;
##########
INSERT INTO `hb_automation_settings` (`item_id`, `type`, `setting`, `value`)
SELECT client_id, 'Client', 'LateFeeType', '0' FROM hb_client_billing WHERE overideduenotices = 1;
##########
INSERT INTO `hb_automation_settings` (`item_id`, `type`, `setting`, `value`)
SELECT client_id, 'Client', 'EmailSwitch', '0' FROM hb_client_billing WHERE disableemails = 1;
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'personal_discount','Personal' FROM hb_language;
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'clientregister', 'Register' FROM hb_language WHERE target != 'admin'
UNION SELECT id, 'editadmins', 'billPendingItems', 'Bill Pending Items' FROM hb_language WHERE target != 'user';
##########
UPDATE hb_admin_access SET `access` = CONCAT(access, ',billPendingItems') WHERE `access` LIKE '%editInvoices%';
##########
UPDATE hb_admin_teams SET `access` = CONCAT(access, ',billPendingItems') WHERE `access` LIKE '%editInvoices%';
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'clientregister', 'Register' FROM hb_language WHERE target != 'admin'
UNION SELECT id, 'editadmins', 'billPendingItems', 'Bill Pending Items' FROM hb_language WHERE target != 'user';
##########
UPDATE hb_admin_access SET `access` = CONCAT(access, ',billPendingItems') WHERE `access` LIKE '%editInvoices%';
##########
UPDATE hb_admin_teams SET `access` = CONCAT(access, ',billPendingItems') WHERE `access` LIKE '%editInvoices%';
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'clientarea', 'choose_your_bank', 'Choose your bank:' FROM hb_language WHERE target != 'admin';
