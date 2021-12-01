REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'dnszoneremoved','Selected Domains has been removed' FROM hb_language WHERE target='user'
UNION SELECT id, 'global', 'revdnsupdated','Reverse DNS settings has been updated' FROM hb_language WHERE target='user'
UNION SELECT id, 'global', 'revdnsnoarpa','Unable to load related .in-addr.arpa zone' FROM hb_language WHERE target='user'
UNION SELECT id, 'global', 'revdnsnoarpamatch','No matching .in-addr.arpa zone has been found in DNS records' FROM hb_language WHERE target='user'
UNION SELECT id, 'global', 'revdnsnoarpazones','DNS module did not return any in-addr.arpa zones' FROM hb_language WHERE target='user'
UNION SELECT id, 'global', 'revdnsnoserver','Unable to load DNS App' FROM hb_language WHERE target='user'
UNION SELECT id, 'global', 'revdnsnoipam','rDNS app is not configured in IPAM' FROM hb_language WHERE target='user'
UNION SELECT id, 'global', 'noipsassigned','No IPs are assigned for this account yet' FROM hb_language WHERE target='user';
