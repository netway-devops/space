REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'createcreditnote','Create Credit Note' FROM hb_language;
##########
UPDATE `hb_reports` SET   `query` =  'SELECT r.range as `Day`,\r\n@total := @total +  COALESCE(t.income,0) as `Income` \r\nFROM hb_reports_day_range r \r\nJOIN (SELECT @total := 0) as tx \r\nLEFT JOIN (SELECT DAY(date) as date, COALESCE(SUM((`in` - `out`) / `rate`),0) as income \r\nFROM hb_transactions \r\nWHERE\r\n DATE(date) >= :date_bottom\r\nAND DATE(date) <=  :date_top\r\nGROUP BY DAY(date) ORDER BY date ASC) as t ON (r.range = t.date) \r\nWHERE\r\n r.range < 31\r\nGROUP BY `Day` \r\nORDER BY r.range ASC'
WHERE id = 2001;
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'accounts', 'set_commitment_period','Set Commitment period' FROM hb_language WHERE target!='user'
UNION SELECT id, 'accounts', 'set_commitment_period_desc','Once this period is set, customer will not be able to place cancelation request on this service until this date.' FROM hb_language WHERE target!='user'
UNION SELECT id, 'accounts', 'for_3_days','for 3 days' FROM hb_language WHERE target!='user'
UNION SELECT id, 'accounts', 'for_7_days','for 7 days' FROM hb_language WHERE target!='user'
UNION SELECT id, 'accounts', 'for_14_days','for 14 days' FROM hb_language WHERE target!='user'
UNION SELECT id, 'accounts', 'for_1_month','for 1 month' FROM hb_language WHERE target!='user'
UNION SELECT id, 'accounts', 'custom_date','Custom date' FROM hb_language WHERE target!='user'
UNION SELECT id, 'accounts', 'set_period','Set period' FROM hb_language WHERE target!='user'
UNION SELECT id, 'accounts', 'period_has_been_set','The commitment period has been set' FROM hb_language WHERE target!='user'
UNION SELECT id, 'accounts', 'period_has_been_disabled','The commitment period has been disabled' FROM hb_language WHERE target!='user'
UNION SELECT id, 'accounts', 'commitment_period_set_to','Commitment period was previously set to' FROM hb_language WHERE target!='user'
UNION SELECT id, 'accounts', 'prevent_cancellation_request','Prevent the cancellation request' FROM hb_language WHERE target!='user';
##########
ALTER TABLE hb_accounts
ADD COLUMN `commitment_date` DATE NULL DEFAULT '0000-00-00';
##########
REPLACE INTO hb_configuration (`setting`, `value`) VALUES ('PeriodOnEstimates', 'on');
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'configuration', 'period_on_estimates','Period on estimates' FROM hb_language WHERE target!='user'
UNION SELECT id, 'configuration', 'period_on_estimates_desc','Allows to enable and disable the period view for Estimate.' FROM hb_language WHERE target!='user';
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'clearfilters','Clear filters' FROM hb_language
UNION SELECT id, 'global', 'filterbyservice','Filter by service:' FROM hb_language
UNION SELECT id, 'global', 'showall','Show all' FROM hb_language;
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'filterdata','Filter data' FROM hb_language
UNION SELECT id, 'global', 'hideterminated','Hide terminated' FROM hb_language
UNION SELECT id, 'global', 'hidecancelled','Hide cancelled' FROM hb_language
UNION SELECT id, 'global', 'hidesuspended','Hide suspended' FROM hb_language
UNION SELECT id, 'global', 'hidefraud','Hide services marked as fraud' FROM hb_language;