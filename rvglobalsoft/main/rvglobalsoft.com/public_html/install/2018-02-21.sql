CREATE TABLE IF NOT EXISTS `hb_accounts_relations` (
	`parent_type` ENUM ('Hosting','Domain') NOT NULL DEFAULT 'Hosting',
	`parent_id` INT(11) NOT NULL,
	`child_type` ENUM ('Hosting','Domain') NOT NULL DEFAULT 'Hosting',
	`child_id` INT(11) NOT NULL,
	PRIMARY KEY (`parent_type`,`parent_id`,`child_type`,`child_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
REPLACE INTO `hb_accounts_relations` SELECT 'Hosting',a.id,'Hosting',b.id FROM hb_accounts a JOIN hb_accounts b ON a.id=b.parent_id WHERE b.parent_id!=0;
##########
REPLACE INTO `hb_accounts_relations` SELECT 'Hosting',a.id,'Domain',d.id FROM hb_accounts a JOIN hb_domains d ON (a.domain=d.name AND a.client_id=d.client_id);
##########
  REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'Hosting','Service' FROM hb_language
UNION SELECT id, 'global','Domain','Domain' FROM hb_language
UNION  SELECT id, 'global', 'norelatedservicesyet','None. No services can be attached now' FROM hb_language WHERE target='admin'
UNION  SELECT id, 'cart', 'norelatedservicesyet','None. No services can be attached now' FROM hb_language WHERE target!='admin'
UNION  SELECT id, 'cart', 'loginrelatedservice','Login first to attach your related service to this order' FROM hb_language WHERE target!='admin'