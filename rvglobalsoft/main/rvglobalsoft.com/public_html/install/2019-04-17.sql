REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'bulkdomaintransfer','Bulk Domain Transfer' FROM hb_language WHERE target = 'user'
UNION SELECT id, 'global', 'bulkdomaintransferdesc','Enter a list of domains to transfer, one per line, followed by colon ":" and authcode.' FROM hb_language WHERE target = 'user';