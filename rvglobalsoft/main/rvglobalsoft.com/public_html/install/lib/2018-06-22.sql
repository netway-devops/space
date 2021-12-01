REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'clientarea', 'dnserrcaa_flag', 'Invalid value for the flag field of the CAA record' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'dnserrcaa_tag', 'Invalid value for the tag field of the CAA record' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'dnserrcaa_value', 'Invalid value for the value field of the CAA record' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'dnsrecordtlsadata', 'Certificate Data' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'dnsrecordtlsadatainfo', 'Example: d2abde240d7cd3ee6b4b28c54df034b979' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'dnsrecordcaaflagsinfo', 'Integer between 0-255' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'dnsrecordcaatag', 'Tag' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'dnsrecordcaataginfo', 'Valid values: issue, issuewild, and iodef' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'dnsrecordcaavalue', 'Value' FROM hb_language WHERE target='user'
UNION  SELECT id, 'clientarea', 'dnsrecordcaavalueinfo', 'Example: letsencrypt.com' FROM hb_language WHERE target='user';