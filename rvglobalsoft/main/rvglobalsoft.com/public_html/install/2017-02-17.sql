INSERT INTO hb_notes (`type`,`rel_id` ,`admin_id` ,`date` ,`note`) 
SELECT 'estimate', e.id, 0, e.date_created, e.notes_private FROM hb_estimates e
WHERE e.notes_private!='';
##########
REPLACE INTO hb_configuration VALUES ('ReturnToStockOnTerminate', 0), ('GrantDomainAccessToContacts', 1);
##########
ALTER TABLE `hb_products`
CHANGE COLUMN `stock` `stock` INT NOT NULL DEFAULT '0' AFTER `domain_options`;
##########
UPDATE hb_products p
LEFT JOIN (
	SELECT a.product_id, COUNT(a.id) total 
	FROM hb_accounts a
	GROUP BY a.product_id
) z ON p.id=z.product_id
SET p.qty=COALESCE(z.total, 0), p.stock=p.stock + COALESCE(z.total, 0)
WHERE p.stock > 0;
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'emailtemplates', 'AfterModuleSuspend','Account:Suspended' FROM hb_language WHERE target!='user'
UNION SELECT id, 'emailtemplates', 'AfterModuleUnsuspend','Account:Unsuspended' FROM hb_language WHERE target!='user';
