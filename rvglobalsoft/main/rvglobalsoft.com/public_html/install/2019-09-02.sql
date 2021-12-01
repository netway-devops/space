CREATE TABLE IF NOT EXISTS `hb_product_metrics` (
 `id` int(11) NOT NULL AUTO_INCREMENT,
 `product_id` int(11) NOT NULL,
 `module_id` int(11) NOT NULL,
 `metric` varchar(255) NOT NULL,
 `name` varchar(255) NOT NULL,
 `unit` varchar(255) NOT NULL,
 `limit` float NULL DEFAULT 0.00,
 `trigger_period` int(11) NOT NULL,
 `flags` int(11) NULL DEFAULT 0,
 PRIMARY KEY (`id`),
 INDEX `product_id` (`product_id`),
 INDEX `module_id` (`module_id`),
 INDEX `metric` (`metric`),
 INDEX `limit` (`limit`),
 INDEX `trigger_period` (`trigger_period`),
 INDEX `flags` (`flags`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;
##########
CREATE TABLE IF NOT EXISTS `hb_account_metrics` (
`id` int(11) NOT NULL AUTO_INCREMENT,
`account_id` int(11) NOT NULL,
`metric_id` varchar(255) NOT NULL,
`date` datetime NOT NULL,
`value` float NULL DEFAULT 0.00,
`success` tinyint(1) NOT NULL,
`trigger` tinyint(1) NOT NULL,
PRIMARY KEY (`id`),
INDEX `account_id` (`account_id`),
INDEX `metric_id` (`metric_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT `id`, 'services', 'quotas_tab','Quotas' FROM hb_language WHERE target = 'admin'
UNION SELECT `id`, 'global', 'quotaussage','Quota usage' FROM hb_language WHERE target = 'admin';
##########
REPLACE INTO `hb_cron_tasks` (`task`, `name`, `lastrun`, `status`, `count`, `metadata`, `output`, `run_every`,`run_every_time`, `profile_id`)
VALUES ('updateAccountsMetrics', 'Update accounts metrics', '0000-00-00 00:00:00', 1, 0, '', '', 'Run', '1200', 1);
##########