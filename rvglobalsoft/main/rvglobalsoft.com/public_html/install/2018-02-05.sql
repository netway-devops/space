UPDATE hb_configuration SET  `value` = SUBSTR(`value`, 7)
WHERE `setting` = 'AdminLogoPath' AND POSITION('admin/' IN `value`);