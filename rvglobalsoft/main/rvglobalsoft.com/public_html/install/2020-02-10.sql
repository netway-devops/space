DELETE FROM hb_modules_configuration WHERE filename = 'class.whoisservers.php';
##########
REPLACE INTO hb_configuration (`setting`, `value`) VALUES ('EnablePremiumDomains', 'off');
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'whoisservers','Lookup settings' FROM hb_language  WHERE target='admin'
UNION SELECT id, 'global', 'domainanddns','Domain &amp; DNS' FROM hb_language  WHERE target='admin'
UNION SELECT id, 'managemodules', 'domainmodulelisting','Domain Imports' FROM hb_language  WHERE target='admin'
UNION SELECT id, 'managemodules', 'domainlookupinterface','Domain Lookup Engine' FROM hb_language  WHERE target='admin'
UNION SELECT id, 'managemodules', 'domainpriceimport','Import TLDs & Prices' FROM hb_language  WHERE target='admin'
UNION SELECT id, 'managemodules', 'domainmodulednssec','DNSSEC' FROM hb_language  WHERE target='admin'
UNION SELECT id, 'managemodules', 'domainpremiuminterface','Premium Domains' FROM hb_language  WHERE target='admin'
UNION SELECT id, 'managemodules', 'domainsuggestionsinterface','Domain Names Suggestions' FROM hb_language  WHERE target='admin'
UNION SELECT id, 'managemodules', 'sslhostingautoinstallmodule','Auto-install SSL' FROM hb_language  WHERE target='admin'
UNION SELECT id, 'managemodules', 'reversedns','Reverse DNS' FROM hb_language  WHERE target='admin'
UNION SELECT id, 'managemodules', 'hostingmoduleproductimport','Import Products & Prices' FROM hb_language  WHERE target='admin'
UNION SELECT id, 'managemodules', 'hostingmodulelisting','Import Services' FROM hb_language  WHERE target='admin'
UNION SELECT id, 'managemodules', 'metricsmoduleinterface','Metrics / Quotas' FROM hb_language  WHERE target='admin'
UNION SELECT id, 'managemodules', 'dnssecmodule','DNSSEC' FROM hb_language  WHERE target='admin'
UNION SELECT id, 'managemodules', 'ticketimportinterface','Ticket Import' FROM hb_language  WHERE target='admin'
UNION SELECT id, 'managemodules', 'domainwhoisinterface','Domain WHOS Engine' FROM hb_language  WHERE target='admin'
UNION SELECT id, 'managemodules', 'flavorhostinginterface','Flavor Billing' FROM hb_language  WHERE target='admin'
UNION SELECT id, 'global', 'loadingrecomended','Loading recommended names ...' FROM hb_language  WHERE target!='admin'
UNION SELECT id, 'global', 'premium','Premium' FROM hb_language
##########
ALTER TABLE `hb_domains` ADD `premium` TINYINT(1)  NULL  DEFAULT '0'  AFTER `manual`;
##########
INSERT IGNORE INTO `hb_automation_settings` (`item_id`, `type`, `setting`, `value`)
SELECT client_id, 'Client', 'EnableAutoSuspension', 'off' FROM hb_client_billing WHERE overideautosusp = 1
UNION SELECT client_id, 'Client', 'EnableAutoTermination', 'off' FROM hb_client_billing WHERE overideautosusp = 1;