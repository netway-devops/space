UPDATE `hb_reports` SET `query`='SELECT l.date AS `Date`,\nl.`in` AS `Credit Applied`,\nl.`admin_id` AS `Staff ID`,\nCONCAT( ad.firstname, \' \', ad.lastname ) AS `Staff Member`,\nCOALESCE(mc.modname,\'None\') AS `Gateway`,\nCOALESCE(cx.iso,\'Main Currency\') AS `Currency`,\nl.client_id AS `Client Id`,\nCONCAT(cd.firstname,\' \',cd.lastname) AS `Client name`\nFROM hb_client_credit_log l\nJOIN hb_client_details cd ON cd.id =l.client_id\nJOIN hb_client_billing b ON b.client_id=l.client_id\nLEFT JOIN hb_transactions t ON t.id=l.transaction_id\nLEFT JOIN hb_modules_configuration mc ON mc.id=t.module\nLEFT JOIN hb_currencies cx ON cx.id=b.currency_id\nLEFT JOIN hb_admin_details ad ON ad.id=l.admin_id\n\nWHERE l.date>:date_bottom\nAND l.date<:date_top\nAND l.`in`>0\nORDER BY l.date ASC' 
WHERE  `name`='List of credits applied to client accounts in given period';
##########
UPDATE `hb_reports` SET `query`='SELECT SUM(l.`in`) AS `Credit Applied`,\nCOALESCE(cx.iso,\'Main Currency\') AS `Currency`,\nl.admin_id AS `Staff ID`,\nCONCAT( ad.firstname, \' \', ad.lastname ) AS `Staff Member`\nFROM hb_client_credit_log l\nJOIN hb_client_details cd ON cd.id =l.client_id\nJOIN hb_client_billing b ON b.client_id=l.client_id\nLEFT JOIN hb_transactions t ON t.id=l.transaction_id\nLEFT JOIN hb_modules_configuration mc ON mc.id=t.module\nLEFT JOIN hb_currencies cx ON cx.id=b.currency_id\nLEFT JOIN hb_admin_details ad ON ad.id=l.admin_id\nWHERE l.date>:date_bottom\nAND l.date<:date_top\nAND\nl.`in`>0\nGROUP BY b.currency_id, l.admin_id' 
WHERE  `name`='Amount of credit applied to client accounts in given period by staff member';
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'affiliates', 'landingpage','Landing page' FROM hb_language WHERE target='user'
UNION SELECT id, 'affiliates', 'landingpageurl','Landing page url' FROM hb_language WHERE target='user'
UNION SELECT id, 'affiliates', 'enternewlandingurl','Enter new landing page url, it needs to be accesible within our domain' FROM hb_language WHERE target='user'
UNION SELECT id, 'affiliates', 'landurldescr','Redirect visitors to this page after visiting your affiliate link. Click on link to edit.' FROM hb_language WHERE target='user';
##########
ALTER TABLE  `hb_downloads` DROP  `rel_type` ,
DROP  `rel_id` ;
##########
ALTER TABLE `hb_downloads`
CHANGE COLUMN `clients` `rel_type` TINYINT(11) NOT NULL DEFAULT '0' AFTER `downloads`,
CHANGE COLUMN `client_id` `rel_id` INT(11) NOT NULL DEFAULT '0' AFTER `rel_type`;