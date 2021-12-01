ALTER TABLE `hb_servers` ADD `monthly_cost` decimal(10,2) NOT NULL default '0.00'  AFTER `custom`;
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'monthlycosts','Monthly Costs' FROM hb_language;
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'monthlycostsdescription','Monthly cost for this App connection' FROM hb_language;