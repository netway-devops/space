REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'perform_action','Are you sure you want to perform this action?' FROM hb_language WHERE target!='user'
UNION SELECT id, 'global', 'delete_account_opt1','Delete account from HostBill and terminate on server if possible' FROM hb_language WHERE target!='user'
UNION SELECT id, 'global', 'delete_account_opt2','Soft delete account - remove only from HostBill, not from the server' FROM hb_language WHERE target!='user'
UNION SELECT id, 'global', 'records_per_page','Records per page' FROM hb_language WHERE target!='user'
UNION SELECT id, 'global', 'browseintree','Browse in tree' FROM hb_language WHERE target!='user';
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'ticket_response_rated','The response has been rated' FROM hb_language WHERE target!='admin';