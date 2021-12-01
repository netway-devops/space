UPDATE `hb_configuration` SET `value` = '4.6.8' WHERE `setting`= 'Version';
##########
ALTER TABLE `hb_domain_prices`
ADD COLUMN `options` TINYINT(4) NOT NULL DEFAULT '1' AFTER `epp`;
##########
UPDATE `hb_domain_prices` SET `options` = `epp`;
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'clientarea', 'turnoffbeforereset','VM has to be switched off before you can reset password.' FROM hb_language WHERE target='user';