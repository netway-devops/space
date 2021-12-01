REPLACE INTO `hb_configuration` (`setting`, `value`) VALUES ('TaxTimetracking', 'on');
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'configuration', 'TaxTimetracking','Tax time tracking entries' FROM hb_language WHERE target!='user'
UNION SELECT id, 'configuration', 'TaxTimetracking1','Do not tax time tracking entries' FROM hb_language WHERE target!='user'
UNION SELECT id, 'clientarea', 'switchoffvmbeforescale','VM has to be switched off before you can scale it.' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'loading','Loading..' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'createvolume','Create new volume' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'attachexistingvolume','Attach existing volume' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'presets','Presets' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'loadingpresets','Loading presets..' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'inboundfirewall','Inbound Firewall' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'outboundfirewall','Outbound Firewall' FROM hb_language WHERE target='user'
UNION SELECT id, 'configfields', 'sliderinput','Slider input' FROM hb_language WHERE target!='user'
UNION SELECT id, 'configfields', 'sliderinput-description','Client can set amount of required config by using custom slider or enter it manually' FROM hb_language WHERE target='admin';
##########
UPDATE hb_language_locales SET `keyword`='portforwarding'  WHERE `keyword`='portfowarding';
##########
UPDATE hb_language_locales SET `value`='Port forwarding'  WHERE `value`='Port fowarding';