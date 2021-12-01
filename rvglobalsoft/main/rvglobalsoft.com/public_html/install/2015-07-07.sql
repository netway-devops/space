ALTER TABLE `hb_ticket_departments`
ADD COLUMN `smtpemail` VARCHAR(128) NOT NULL AFTER `smtplogin`;
##########
UPDATE `hb_ticket_departments` SET smtpemail=`smtplogin`;
##########
REPLACE INTO hb_configuration (`value`, `setting`) SELECT `value`, 'MailSMTPEmail' FROM hb_configuration WHERE `setting` = 'MailSMTPUsername';
##########
ALTER TABLE `hb_currencies`
CHANGE COLUMN `rate` `rate` DECIMAL(15,10) NOT NULL DEFAULT '1.0000' AFTER `iso`;
##########
ALTER TABLE `hb_invoices`
CHANGE COLUMN `rate` `rate` DECIMAL(15,10) NOT NULL DEFAULT '1.0000' AFTER `currency_id`,
CHANGE COLUMN `rate2` `rate2` DECIMAL(15,10) NOT NULL DEFAULT '0.0000' AFTER `rate`,
CHANGE COLUMN `rate3` `rate3` DECIMAL(15,10) NOT NULL DEFAULT '1.0000' AFTER `rate2`;
##########
ALTER TABLE `hb_transactions`
CHANGE COLUMN `rate` `rate` DECIMAL(15,10) NOT NULL DEFAULT '1.0000' AFTER `currency_id`;
