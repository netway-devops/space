REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'thisvalueseemsbeinvalid','This value seems to be invalid.' FROM hb_language WHERE target='user'
UNION SELECT id, 'global', 'thisvalueshouldavalidemail','This value should be a valid email.' FROM hb_language WHERE target='user'
UNION SELECT id, 'global', 'thisvalueshouldavalidurl','This value should be a valid url.' FROM hb_language WHERE target='user'
UNION SELECT id, 'global', 'thisvalueshouldavalidnumber','This value should be a valid number.' FROM hb_language WHERE target='user'
UNION SELECT id, 'global', 'thisvalueshouldavalidinteger','This value should be a valid integer.' FROM hb_language WHERE target='user'
UNION SELECT id, 'global', 'thisvalueshoulddigits','This value should be digits.' FROM hb_language WHERE target='user'
UNION SELECT id, 'global', 'thisvalueshouldalphanumeric','This value should be alphanumeric.' FROM hb_language WHERE target='user'
UNION SELECT id, 'global', 'thisvalueshouldnotblank','This value should not be blank.' FROM hb_language WHERE target='user'
UNION SELECT id, 'global', 'thisvaluerequired','This value is required.' FROM hb_language WHERE target='user'
UNION SELECT id, 'global', 'thisvalueshouldgreaterthanequals','This value should be greater than or equal to %s.' FROM hb_language WHERE target='user'
UNION SELECT id, 'global', 'thisvalueshouldlowerthanequals','This value should be lower than or equal to %s.' FROM hb_language WHERE target='user'
UNION SELECT id, 'global', 'thisvalueshouldbetweenss','This value should be between %s and %s.' FROM hb_language WHERE target='user'
UNION SELECT id, 'global', 'thisvaluetooshortshouldhavescharact','This value is too short. It should have %s characters or more.' FROM hb_language WHERE target='user'
UNION SELECT id, 'global', 'thisvaluetoolongshouldhavescharacte','This value is too long. It should have %s characters or fewer.' FROM hb_language WHERE target='user'
UNION SELECT id, 'global', 'thisvaluelengthinvalidshouldbetween','This value length is invalid. It should be between %s and %s characters long.' FROM hb_language WHERE target='user'
UNION SELECT id, 'global', 'youmustselectleastschoices','You must select at least %s choices.' FROM hb_language WHERE target='user'
UNION SELECT id, 'global', 'youmustselectschoicesfewer','You must select %s choices or fewer.' FROM hb_language WHERE target='user'
UNION SELECT id, 'global', 'youmustselectbetweensschoices','You must select between %s and %s choices.' FROM hb_language WHERE target='user'
UNION SELECT id, 'global', 'thisvalueshouldthesame','This value should be the same.' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'searchemails','Search e-mails...' FROM hb_language WHERE target='user';
##########
UPDATE `hb_language_locales` SET `section` = 'global' 
WHERE (`keyword` = 'wrong_image_verification' AND `section` = 'tickets');
##########
ALTER TABLE `hb_knowledgebase`
ADD COLUMN `sort_order` INT NOT NULL AFTER `options`,
ADD COLUMN `views` INT(11) NOT NULL AFTER `sort_order`;
##########
ALTER TABLE `hb_knowledgebase_cat`
ADD COLUMN `sort_order` INT NOT NULL AFTER `description`;