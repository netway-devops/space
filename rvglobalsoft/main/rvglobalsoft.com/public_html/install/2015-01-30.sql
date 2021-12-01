REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'configuration', 'InvoicePrefix_desc', 'Use {$y} for invoice year, {$d} for invoice day, {$m} for invoice month, {$client_id} for client id' FROM hb_language WHERE target!='user';
