REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'automation', 'commitment','commitment period will end, and client will be able to place cancelation request' FROM hb_language;
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'affiliates', 'affcampaigns','Campaigns' FROM hb_language
UNION SELECT id, 'affiliates', 'affcampaign_blank','Using this feature you can create campaigns - redirecting visitor to campaign-defined URL upon referal' FROM hb_language WHERE target!='user'
UNION SELECT id, 'affiliates', 'addcampaign','Add campaign' FROM hb_language WHERE target!='user';
##########
CREATE TABLE IF NOT EXISTS `hb_aff_campaigns` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `campid` varchar(255) NOT NULL,
  `name` varchar(255) NULL,
  `description` text NULL,
  `redirect_url` varchar(255) NULL,
  `date_start` varchar(255) NULL,
  `date_end` varchar(255) NULL,
  `status` enum('Active','Draft','Inactive') NULL,
  `notes` text NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
ALTER TABLE `hb_aff_logs` ADD `ref_url` varchar(255) NULL  AFTER `type`;
##########
INSERT INTO `hb_reports` (`id`, `type`, `name`, `query`, `options`, `handler`, `state`, `columns`)
VALUES
	(NULL, 'Affiliates', 'Top affiliate visits within a period', ' SELECT a.id as `Affiliate ID`, concat(c.firstname,'' '',c.lastname) as `Affiliate name`, COUNT(al.id) as `Visits count`  FROM hb_aff_logs al  LEFT JOIN hb_aff a ON (al.aff_id = a.id)  LEFT JOIN hb_client_details c ON (a.client_id = c.id)  WHERE al.date >= :date_bottom  AND al.date <= :date_top  AND al.type = ''Visit''  GROUP BY a.id  ORDER BY COUNT(al.id) DESC', 1, 'sql', '', ''),
	(NULL, 'Affiliates', 'Top affiliate signups within a period', ' SELECT a.id as `Affiliate ID`, concat(c.firstname,'' '',c.lastname) as `Affiliate name`, COUNT(al.id) as `Signups count`  FROM hb_aff_logs al  LEFT JOIN hb_aff a ON (al.aff_id = a.id)  LEFT JOIN hb_client_details c ON (a.client_id = c.id)  WHERE al.date >= :date_bottom  AND al.date <= :date_top  AND al.type = ''Singup''  GROUP BY a.id  ORDER BY COUNT(al.id) DESC', 1, 'sql', '', ''),
	(NULL, 'Affiliates', '100 Top affiliates', ' SELECT a.id as `Affiliate ID`, concat(c.firstname,'' '',c.lastname) as `Affiliate name`, sql_currency(a.total_commissions,cb.currency_id,0) as `Total commissions`, sql_currency(a.total_withdrawn,cb.currency_id,0) as `Total withdrawn`, a.visits as `Total visits`  FROM hb_aff a  LEFT JOIN hb_client_details c ON (c.id = a.client_id)  LEFT JOIN hb_client_billing cb ON (c.id = cb.client_id)  WHERE c.id IS NOT NULL  ORDER BY a.id ASC', 1, 'sql', '', '');
##########
INSERT INTO `hb_reports` (`id`, `type`, `name`, `query`, `options`, `handler`, `state`, `columns`)
VALUES
	(NULL, 'Hidden', 'AffiliateWidget__Recent visits', ' SELECT r.range as `Day`, COALESCE(COUNT((t.id)),0) as `Total visits`  FROM hb_reports_day_range r  LEFT JOIN hb_aff_logs t ON (r.range = DAY(t.date) AND t.type = "Visit" AND t.aff_id = :affiliate_id  AND t.date >= :date_bottom  AND t.date <= :date_top)  WHERE r.range < 32 GROUP BY `Day`, DAY(t.date)  ORDER BY `Day` ASC', 1, 'sql', '', 'a:2:{i:0;s:3:"Day";i:1;s:12:"Total visits";}'),
	(NULL, 'Hidden', 'AffiliateWidget__Recent signups', ' SELECT r.range as `Day`, COALESCE(COUNT((t.id)),0) as `Total signups`  FROM hb_reports_day_range r  LEFT JOIN hb_aff_logs t ON (r.range = DAY(t.date) AND t.type = "Singup" AND t.aff_id = :affiliate_id  AND t.date >= :date_bottom  AND t.date <= :date_top)  WHERE r.range < 32 GROUP BY `Day`, DAY(t.date)  ORDER BY `Day` ASC', 1, 'sql', '', 'a:2:{i:0;s:3:"Day";i:1;s:13:"Total signups";}');

##########
REPLACE INTO hb_configuration (`setting`, `value`) VALUES ('SetupFeeSeparateLine', 'off');
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'configuration', 'SetupFeeSeparateLine','Setup fee as separate line' FROM hb_language
UNION SELECT id, 'configuration', 'SetupFeeSeparateLineDesc','With this option enabled setup fee if present on ordered item, will be added as separate line, rather than sum of recurring and setup fee on single line' FROM hb_language;
##########