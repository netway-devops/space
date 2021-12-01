REPLACE INTO hb_configuration (`setting`, `value`)
VALUES ('CanRemoveUnpaidInvoices', 'off');
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'clientarea', 'invs_deleted','Invoice deleted' FROM hb_language WHERE target='user';
