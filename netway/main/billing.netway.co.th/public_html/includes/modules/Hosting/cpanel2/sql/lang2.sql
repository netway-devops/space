REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'cpanel_opt_custom2', 'Whitelist IPs' FROM hb_language WHERE target!='user'
UNION SELECT id, 'cpanel2', 'cpanel_cfs_whitelist', 'Whitelisted IPs' FROM hb_language
UNION SELECT id, 'cpanel2', 'cpanel_csf_whitelist_ip', 'Whitelist new IP' FROM hb_language
UNION SELECT id, 'global', 'cpanel_opt_allow2', 'Allows clients to whitelist their own IPs' FROM hb_language WHERE target!='user'
UNION SELECT id, 'cpanel2', 'cpanel_cfs_ipadded','IP address has been whitelisted' FROM hb_language WHERE target='user'
UNION SELECT id, 'cpanel2', 'cpanel_csf_cantbe_whitelisted','This IP address can\'t be whitelisted/unblocked' FROM hb_language WHERE target='user';