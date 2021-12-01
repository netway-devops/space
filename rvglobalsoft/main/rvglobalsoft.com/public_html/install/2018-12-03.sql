REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'configuration', 'BlockFinalInvoiceEdits','Block final invoice edits' FROM hb_language WHERE target!='user'
UNION SELECT id, 'configuration', 'BlockFinalInvoiceEdits_desc','When enabled staff member will not be able to edit/update invoice once final number will be issued for it.' FROM hb_language WHERE target!='user'
UNION SELECT id, 'global', 'impaccounts','Import Services' FROM hb_language WHERE target!='user';
##########
REPLACE INTO hb_configuration (`setting`, `value`) VALUES ('BlockFinalInvoiceEdits', 0);