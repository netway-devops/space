REPLACE INTO hb_configuration (`setting`, `value`) VALUES
('MergeMonthlyServiceRenewals', 'off'),
('MergeAnnualServiceRenewals', 'off');
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'configuration', 'MergeMonthlyServiceRenewals','Issue invoice for hosting services sooner, if customer has invoice for other services issued in renewal month' FROM hb_language WHERE target='admin'
UNION SELECT id, 'configuration', 'MergeAnnualServiceRenewals','Issue invoice for annual hosting services sooner, if customer has invoice for other services issued in renewal year' FROM hb_language WHERE target='admin';