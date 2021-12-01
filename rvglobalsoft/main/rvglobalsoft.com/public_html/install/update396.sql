UPDATE `hb_configuration` SET `value` = '3.9.6' WHERE `setting`= 'Version';
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'tickets', 'attachfile','Add files...' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'tickets', 'added','Added' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'tickets', 'resolvedticket','Your issue is already resolved? Click button below to close this ticket' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'tickets', 'notresolvedticket','Your issue is not yet resolved? Use button below to re-open this ticket.' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'tickets', 'alltickets','All tickets' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'global', 'close','Close' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'global', 'viewpricing','View pricing' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'global', 'ruleformat','Rule formats' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'global', 'keywordmatchingall','keyword matching all IPs' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'global', 'singleiprule','Single IP' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'global', 'ipmaskrule','IP with Mask in CIDR format' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'global', 'ipmaskruledoted','IP with Mask in dotted quad format' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'global', 'ruleexample1','<strong>120.123.123.57/28</strong> matches IP from 120.123.123.48 to 120.123.123.63' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'global', 'ruleexample2','<strong>120.123.123.57/16</strong> matches IP from 120.123.0.0 to 120.123.255.255' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'global', 'noccyet','No credit card has been submitted yet' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'global', 'firewallrule', 'Default firewall rule' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'global', 'rule', 'Rule' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'global', 'ACCEPT', 'ACCEPT' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'global', 'srcaddr', 'Source Address' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'global', 'destport', 'Destination port' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'global', 'protocol', 'Protocol' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'global', 'command', 'Command' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'global', 'DROP', 'DROP' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'global', 'applyfirewall', 'Apply Firewall Rules' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'global', 'addrule', 'Add new rule' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'global', 'interface', 'Interface' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'global', 'port', 'Port' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'global', 'label', 'Label' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'global', 'network', 'Network' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'global', 'os', 'Operating System' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'global', 'destination', 'Destination' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'global', 'tags', 'Tags' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'global', 'notags', 'No tags defined' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'global', 'newtag', 'Add new tag' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'global', 'recovery', 'Recovery' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'global', 'enableautobackup', 'Enable autobackup' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'global', 'increaselimits', 'Increase limits' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'tickets', 'droptoattach','Drop files here to attach them' FROM hb_language WHERE target!='admin';
##########
UPDATE `hb_language_locales` SET `value`="Click <a href=\"?cmd=cart&amp;cat_id=addons&amp;account_id=%s\">here</a> to add addons for this account" WHERE `language_id`='2' AND `section`="clientarea" AND `keyword`="clickaddaddons";
##########
UPDATE `hb_language_locales` SET `value`="You don't have any domains registered with us. Click <a href=\"%s\">here</a> to register a new domain." WHERE `language_id`='2' AND `section`="clientarea" AND `keyword`="nodomains";
##########