REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT `id`, 'global', 'usagechargetotal','Total usage charge' FROM hb_language WHERE target='user'
UNION SELECT `id`, 'global', 'FlavorBandwidthOutOverage','Bandwidth Overage - Data Received' FROM hb_language WHERE target='user'
UNION SELECT `id`, 'global', 'FlavorBandwidthInOverage','Bandwidth Overage - Data Sent' FROM hb_language WHERE target='user';