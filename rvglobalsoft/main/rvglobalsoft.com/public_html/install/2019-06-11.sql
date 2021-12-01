REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'pn_domain_registered', 'Domain %s Registered' FROM hb_language WHERE target != 'admin'
UNION SELECT id, 'global', 'pn_domain_registered', 'Domain %s Registered' FROM hb_language WHERE target != 'admin'
UNION SELECT id, 'global', 'pn_domain_transferred', 'Domain %s Transferred' FROM hb_language WHERE target != 'admin'
UNION SELECT id, 'global', 'pn_domain_renewed', 'Domain %s Renewed' FROM hb_language WHERE target != 'admin'
UNION SELECT id, 'global', 'pn_domain_deleted', 'Domain %s Deleted' FROM hb_language WHERE target != 'admin'
UNION SELECT id, 'global', 'pn_domain_auth_code', 'Domain %s Auth Code requested' FROM hb_language WHERE target != 'admin'
UNION SELECT id, 'global', 'pn_domain_updated_ns', 'Updated nameservers for the %s domain' FROM hb_language WHERE target != 'admin'
UNION SELECT id, 'global', 'pn_domain_updated_contants', 'Updated contacts for the %s domain' FROM hb_language WHERE target != 'admin'
UNION SELECT id, 'global', 'pn_domain_updated_protection', 'Updated ID protection for the %s domain' FROM hb_language WHERE target != 'admin'
UNION SELECT id, 'global', 'pn_domain_updated_autorenew', 'Updated auto renewal for the %s domain' FROM hb_language WHERE target != 'admin'
UNION SELECT id, 'global', 'pn_ssl_created', 'SSL certificate created' FROM hb_language WHERE target != 'admin'
UNION SELECT id, 'global', 'pn_ssl_renewed', 'SSL certificate renewed' FROM hb_language WHERE target != 'admin';