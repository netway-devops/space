REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'allow_own_dom_registered_us','Only if domain was/will be registered with us' FROM hb_language WHERE target = 'admin'
UNION SELECT id, 'services', 'AutoCancelUnpaidOrders', 'Auto-cancel unpaid orders' FROM hb_language WHERE target='admin'
UNION SELECT id, 'services', 'AutoCancelUnpaidOrdersDesc1', 'Cancel unpaid orders' FROM hb_language WHERE target='admin'
UNION SELECT id, 'services', 'AutoCancelUnpaidOrdersDesc2', 'days since creation' FROM hb_language WHERE target='admin';
##########
ALTER TABLE `hb_products` ADD COLUMN `owndomainwithus` tinyint(1) NOT NULL DEFAULT '0' AFTER `owndomain`;
##########
REPLACE INTO `hb_configuration` (`setting`, `value`) VALUES
('EnableAutoCancelUnpaidOrders', 'off'),('AutoCancelUnpaidOrdersPeriod', '30');
##########
INSERT INTO `hb_cron_tasks` (`task`, `name`, `lastrun`, `status`, `count`, `metadata`, `output`, `run_every`, `run_every_time`, `profile_id`)
VALUES ('autoCancelOrders', 'Auto-cancel unpaid orders', '0000-00-00 00:00:00', 1, 0, '', '', 'Time', '1300', 1);