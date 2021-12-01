REPLACE INTO hb_configuration (`setting`, `value`) VALUES
  ('CreditDelayAutoApply', '0'),
  ('GenerateSeparateTax', 'off');
##########
REPLACE INTO `hb_cron_tasks`
(`task`, `name`, `lastrun`, `status`, `count`, `metadata`, `output`, `run_every`,`run_every_time`, `profile_id`)
VALUES ('creditAutoApply', 'Apply Credit to due invoices', '000-00-00 00:00:00', 1, 0, '', '', 'Time', '0100', 1);
##########
ALTER TABLE `hb_accounts`
  ADD COLUMN `autorenew` TINYINT(1) NOT NULL DEFAULT '1' AFTER `due_day`,
  ADD INDEX `autorenew` (`autorenew`),
  ADD INDEX `status_autosuspend` (`status`, `autosuspend`);
##########
ALTER TABLE `hb_client_billing`
  ADD INDEX `overideautosusp` (`overideautosusp`);
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
  SELECT id, 'automation', 'addonduedate','addon will reach its due date' FROM hb_language WHERE target='admin';