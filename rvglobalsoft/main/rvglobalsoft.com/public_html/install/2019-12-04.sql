REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'clients', 'Contact','Contact select' FROM hb_language WHERE target = 'admin';
##########
ALTER TABLE hb_client_fields MODIFY COLUMN `field_type` ENUM('Select','Check','Input','Password','File','Contact');
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'MainProfile', 'Main Profile' FROM hb_language;
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'services_basic', 'View basic details' FROM hb_language WHERE target='admin'
UNION SELECT id, 'global', 'services_basic', 'View basic details' FROM hb_language WHERE target='admin'
UNION SELECT id, 'global', 'services_cancelation', 'Request cancellation' FROM hb_language WHERE target='admin'
UNION SELECT id, 'global', 'services_billing', 'View billing info' FROM hb_language WHERE target='admin'
UNION SELECT id, 'global', 'services_upgrade', 'Upgrade / Downgrade' FROM hb_language WHERE target='admin'
UNION SELECT id, 'global', 'services_notify', 'Receive related email notifications' FROM hb_language WHERE target='admin'
UNION SELECT id, 'global', 'services_relatedticket', 'Related ticket' FROM hb_language WHERE target='admin'
UNION SELECT id, 'global', 'services_ssl_config', 'Certificate Setup' FROM hb_language WHERE target='admin'
UNION SELECT id, 'global', 'services_rtdetails', 'Certificate Details' FROM hb_language WHERE target='admin'
UNION SELECT id, 'global', 'domains_basic', 'View basic details' FROM hb_language WHERE target='admin'
UNION SELECT id, 'global', 'domains_renew', 'Renew domain' FROM hb_language WHERE target='admin'
UNION SELECT id, 'global', 'domains_notify', 'Receive related email notifications' FROM hb_language WHERE target='admin'
UNION SELECT id, 'global', 'domains_relatedticket', 'Related ticket' FROM hb_language WHERE target='admin'
UNION SELECT id, 'global', 'domains_nameservers', 'Manage Nameservers' FROM hb_language WHERE target='admin'
UNION SELECT id, 'global', 'domains_contactinfo', 'Contact Information' FROM hb_language WHERE target='admin'
UNION SELECT id, 'global', 'domains_domain_dnssec', 'Manage DNSSEC' FROM hb_language WHERE target='admin'
UNION SELECT id, 'global', 'domains_registernameservers', 'Register Nameservers' FROM hb_language WHERE target='admin'
UNION SELECT id, 'global', 'domains_idprotection', 'Manage Privacy' FROM hb_language WHERE target='admin'
UNION SELECT id, 'global', 'domains_reglock', 'Domain Lock Settings' FROM hb_language WHERE target='admin'
UNION SELECT id, 'global', 'misc_editsshkeys', 'Manage SSH Keys' FROM hb_language WHERE target='admin';