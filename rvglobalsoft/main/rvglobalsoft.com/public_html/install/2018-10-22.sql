REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'sshkeyselect', 'SSH key select' FROM hb_language WHERE target!='user'
UNION SELECT id, 'configfields', 'sshkeyselect-description','It allows the customer to choose one of the defined SSH keys or enter a new one.' FROM hb_language WHERE target!='user'
UNION SELECT id, 'configuration', 'EnableClientScuritySSHKey','Allow Clients to manage ssh keys' FROM hb_language WHERE target!='user'
UNION SELECT id, 'global', 'shhkey', 'SSH Key' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'global', 'shhkeys', 'SSH Keys' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'global', 'enter_new_key', 'Enter new key' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'global', 'add_new_ssh_key', 'Add new SSH key' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'global', 'use_current_key_login', 'To use your current key please' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'global', 'log_in', 'Log In' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'global', 'remove_ssh_key_desc', 'Are you sure? note, that this key will NOT be removed from your services if its used already' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'global', 'enter_publi_ssh_key', 'Enter your public SSH key in OpenSSH format' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'global', 'misc_editsshkeys', 'Manage SSH Keys' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'cart', 'invalid_key_format', 'Invalid key format' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'profiles', 'key_not_exist', 'The key does not exist' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'global', 'settings_nameservers_title1','Use our default nameservers when registering new domains' FROM hb_language WHERE target ='user'
UNION SELECT id, 'global', 'settings_nameservers_title2','Use my custom nameservers:' FROM hb_language WHERE target ='user'
UNION SELECT id, 'global', 'additem','Add item' FROM hb_language WHERE target ='user'
UNION SELECT id, 'global', 'proformaid','Pro-forma ID' FROM hb_language
UNION SELECT id, 'global', 'Receiptscanceled','Canceled Credit Receipts' FROM hb_language
UNION SELECT id, 'global', 'Receiptcanceled','Receipt canceled' FROM hb_language
UNION SELECT id, 'global', 'finalid','Final ID' FROM hb_language;
##########
REPLACE INTO hb_configuration (`setting`, `value`) VALUES ('EnableClientScuritySSHKey', 'on');
##########
ALTER TABLE `hb_invoices` CHANGE `status` `status` ENUM('Paid','Unpaid','Cancelled','Draft','Recurring','Refunded','Credited','Creditnote','Collections','Receiptunpaid','Receiptpaid','Receiptcanceled')  CHARACTER SET utf8  NOT NULL  DEFAULT 'Draft';