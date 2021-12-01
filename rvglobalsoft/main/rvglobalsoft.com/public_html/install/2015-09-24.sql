REPLACE INTO hb_configuration VALUES ('EnableAutoRegisterDomain', 'on'), ('EnableAutoRenewDomain', 'on');
##########
REPLACE INTO hb_automation_settings (`item_id`, `type`, `setting` , `value`) 
SELECT p.id, 'Domain', 'EnableAutoRegisterDomain', 'off' FROM hb_products p 
JOIN hb_product_types t ON t.id=p.`type`
WHERE p.autosetup=0 and t.`type`='DomainsType'
##########
REPLACE INTO hb_automation_settings (`item_id`, `type`, `setting` , `value`) 
SELECT p.product_id, 'Domain', 'EnableAutoRenewDomain', 'off' FROM hb_domain_prices p 
WHERE p.not_renew=1
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'affiliates', 'ascheck','Mailed Check' FROM hb_language WHERE target='user'
UNION SELECT id, 'affiliates', 'ascredit','Account Credit' FROM hb_language WHERE target='user'
UNION SELECT id, 'global', 'card_is_banned', 'Unable to process your request due to security reasons, you should use alternate credit card.' FROM hb_language
UNION SELECT id, 'global', 'card_update_limit', 'Your credit card details are locked, please wait some time for the lock to expire or contact an administrator' FROM hb_language
UNION SELECT id, 'affiliates', 'ascheck','Mailed Check' FROM hb_language WHERE target='user'
UNION SELECT id, 'affiliates', 'ascredit','Account Credit' FROM hb_language WHERE target='user';