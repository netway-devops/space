REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'clientarea', 'nextinvoicedetails','Next invoice details' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'Totaldue','Total due' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'usagedetails','Usage details' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'entermonth','Month (yyyy-mm):' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'onehour','1 Hour' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'oneday','1 Day' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'Interval','Interval:' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'dateupdated','Date updated' FROM hb_language WHERE target='user'
UNION SELECT id, 'global', 'relatedservice','Related service' FROM hb_language WHERE target='user'
UNION SELECT id, 'global', 'root','Main' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'perhour','Per Hour' FROM hb_language WHERE target='user';