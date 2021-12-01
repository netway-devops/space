UPDATE `hb_configuration` SET `value` = '4.8.6' WHERE `setting`= 'Version';
##########
UPDATE hb_email_templates s SET s.language_id=100 WHERE s.`for`='Admin' AND s.language_id=0;