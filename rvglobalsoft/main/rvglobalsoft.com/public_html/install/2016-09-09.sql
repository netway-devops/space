INSERT INTO `hb_configuration` (`setting`, `value`) VALUES ('DomainGracePeriod', '20');
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'domain_past_grace_period','Domain %s expired too long ago to be renewed, please attempt to register it manually' FROM hb_language WHERE target!='user'
