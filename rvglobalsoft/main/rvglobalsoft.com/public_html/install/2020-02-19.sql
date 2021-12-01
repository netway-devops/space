CREATE TABLE IF NOT EXISTS `hb_tickets_tags_archived` (
  `id` int(11) NOT NULL,
  `tag` varchar(128) NOT NULL,
  `color` VARCHAR(8)  NULL  DEFAULT '#03a9f4',
  `date` datetime NULL,
  `who` varchar(250) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8;
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'root', 'providenewpassword', 'Please provide a new password for your account' FROM hb_language WHERE target='user'
UNION SELECT id, 'root', 'newpassword', 'New password' FROM hb_language WHERE target='user'
UNION SELECT id, 'root', 'newpasswordconfirm', 'Confirm new password' FROM hb_language WHERE target='user'
UNION SELECT id, 'root', 'changepass', 'Change password' FROM hb_language WHERE target='user'
UNION SELECT id, 'root', 'passesdontmatch', 'The password confirmation does not match' FROM hb_language WHERE target='user'
UNION SELECT id, 'global', 'passhasbeenchanged', 'Your password has been changed' FROM hb_language WHERE target='user';
##########
REPLACE INTO hb_configuration (`setting`, `value`) VALUES ('PasswordRestoreMethod', 'email');