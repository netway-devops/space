REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'domains', 'deletedomain','Delete domain' FROM hb_language WHERE target!='user'
UNION SELECT id, 'domains', 'deletedomattempt','You\'re attempting to delete domain(s), choose how you want to proceed:' FROM hb_language WHERE target!='user'
UNION SELECT id, 'domains', 'deletedomhard','Delete domain(s) from HostBill and from registrar if possible' FROM hb_language WHERE target!='user'
UNION SELECT id, 'domains', 'deletedomsoft','Soft delete domain(s) - remove only from HostBill, not from the registrar' FROM hb_language WHERE target!='user'
UNION SELECT id, 'domains', 'deletedomconfirm','Are you sure you want to delete this domain?' FROM hb_language WHERE target!='user'
UNION SELECT id, 'domains', 'error_during_delete','Error while deletting %s domain' FROM hb_language WHERE target!='user'
UNION SELECT id, 'domains', 'domain_deleted','Domain %s deleted' FROM hb_language WHERE target!='user';