REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'AllowSignupWithoutPurchase', 'Allow signup without purchase' FROM hb_language WHERE target!='user'
UNION SELECT id, 'global', 'create_account_durning_order', 'You can create an account only during the order' FROM hb_language WHERE target!='admin';
##########
REPLACE INTO hb_configuration (`setting`, `value`) VALUES ('AllowSignupWithoutPurchase', 'on');