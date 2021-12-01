UPDATE `hb_configuration` SET `value` = '4.4.2' WHERE `setting`= 'Version';
##########
ALTER TABLE `hb_currencies` 
CHANGE COLUMN `sign` `sign` VARCHAR(4) NOT NULL AFTER `code`;