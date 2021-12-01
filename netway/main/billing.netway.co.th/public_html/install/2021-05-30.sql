REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'editAccountBilling','Edit Account Billing' FROM hb_language
UNION SELECT id, 'global', 'editAccountTechnical','Edit Account Technical' FROM hb_language WHERE target = 'admin'
UNION SELECT id, 'global', 'editDomainBilling', 'Edit Domain Billing'  FROM hb_language WHERE target = 'admin'
UNION SELECT id, 'global', 'editDomainTechnical', 'Edit Domain Technical'  FROM hb_language WHERE target = 'admin'
UNION SELECT id, 'global', 'lackpriviliges_action_partly', 'The next data has not been changed due to your admin role: %s'  FROM hb_language WHERE target = 'admin';
##########
UPDATE `hb_admin_access` SET access = CONCAT(access, ',editAccountBilling,editAccountTechnical') WHERE access LIKE '%editAccounts%';
##########
UPDATE `hb_admin_teams` SET access = CONCAT(access, ',editAccountBilling,editAccountTechnical') WHERE access LIKE '%editAccounts%';
##########
UPDATE `hb_admin_access` SET access = CONCAT(access, ',editDomainBilling,editDomainTechnical') WHERE access LIKE '%editDomains%';
##########
UPDATE `hb_admin_teams` SET access = CONCAT(access, ',editDomainBilling,editDomainTechnical') WHERE access LIKE '%editDomains%';