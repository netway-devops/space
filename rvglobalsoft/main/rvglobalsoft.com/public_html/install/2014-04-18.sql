REPLACE INTO `hb_configuration` (`setting`, `value`) VALUES ('CCAllowStorage', 'on');
##########
INSERT INTO `hb_email_templates` (`id`, `tplname`, `group`, `for`, `language_id`, `subject`, `message`, `send`, `plain`, `system`, `hidden`) VALUES
(NULL, 'New Incoming Transaction', 'General', 'Admin', 1, 'Admin: New Incoming Transaction', 'New transaction just came in!\r\n\r\nCustomer: {$client.firstname} {$client.lastname}\r\nGateway: {$transaction.gateway}\r\nAmount: {$transaction.in|price:$currency}\r\nTransaction id: {$transaction.trans_id}\r\n\r\n{if $transaction.invoice_id}\r\nRelated invoice id: {$transaction.invoice_id}\r\nRelated invoice status: {$invoice.status}\r\n{/if}', 1, 1, 1, 0);
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'clientarea', 'snapshot_revert','VM will be reverted to selected snapshot' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'snapshot_delete','Snapshot scheduled for removal' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'snapshot_limit','Snapshot limit reached' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'snapshot_create','Snapshot scheduled for creation' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'addfunds_fraud','Your recent order has been marked as fraud, please settle this case before adding funds' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'addfunds_order','You need at least one successfully completed order before adding funds' FROM hb_language WHERE target='user';