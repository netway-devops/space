UPDATE `hb_configuration` SET `value` = '4.8.4' WHERE `setting`= 'Version';
##########
REPLACE INTO hb_configuration (`setting`, `value`) SELECT 'DisplayDecimalPlaces', `value` FROM hb_configuration WHERE `setting` = 'DecimalPlaces';