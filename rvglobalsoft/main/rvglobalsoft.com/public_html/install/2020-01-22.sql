REPLACE INTO hb_configuration (`setting`, `value`) VALUES ('AddFundsDontCheckOrders', 'off');
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'notifycontact','Notify contact?' FROM hb_language
UNION SELECT id, 'configuration', 'autocredit_yes_taxed_items', 'Apply credit only to invoices with taxed items' FROM hb_language WHERE target='admin'
UNION SELECT id, 'global', 'who', 'Who' FROM hb_language WHERE target='admin'
UNION SELECT id, 'global', 'cancelation_warning', 'This cancelation have process date set by admin: it will be processed by cron at specified time, regardless of related package automation settings.' FROM hb_language WHERE target='admin'
UNION SELECT id, 'global', 'cancelation_note', 'Automation cancelation requests Processing is disabled in related package' FROM hb_language WHERE target='admin'
UNION SELECT id, 'global', 'cancelation_will_be_processed', 'cancelation request will be processed' FROM hb_language WHERE target='admin'
UNION SELECT id, 'global', 'ProcessAutomatically', 'Process automatically' FROM hb_language WHERE target='admin'
UNION SELECT id, 'global', 'ProcessAutomaticallyInfo', 'Yes - Terminate & Cancel this account automatically' FROM hb_language WHERE target='admin'
UNION SELECT id, 'global', 'ProcessAt', 'Process at' FROM hb_language WHERE target='admin'
UNION SELECT id, 'global', 'SubmissionDate', 'Submission date' FROM hb_language WHERE target='admin';
##########
ALTER TABLE `hb_cancel_requests` ADD COLUMN `process_at` datetime NOT NULL DEFAULT "0000-00-00 00:00:00";
##########
ALTER TABLE `hb_cancel_requests` ADD COLUMN `who` VARCHAR(255) NOT NULL DEFAULT '';
##########
ALTER TABLE `hb_currencies` DROP INDEX `code`;
