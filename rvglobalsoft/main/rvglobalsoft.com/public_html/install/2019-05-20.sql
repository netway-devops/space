ALTER TABLE `hb_price_update_profile`
  ADD COLUMN `type` ENUM('tld','products') NOT NULL DEFAULT 'tld' AFTER `id`;
##########
REPLACE INTO `hb_cron_tasks` (`task`, `name`, `lastrun`, `status`, `count`, `metadata`, `output`, `run_every`,`run_every_time`, `profile_id`)
VALUES ('productsPriceAutoUpdate', 'Products Price auto-update', '000-00-00 00:00:00', 1, 0, '', '', 'Time', '1200', 1);
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'tasklist', 'UnpaidInvoice','Last unpaid invoice due date' FROM hb_language WHERE target='admin';
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'automation', 'unpaidinvoice','last unpaid invoice will reach its due date' FROM hb_language WHERE target='admin';

