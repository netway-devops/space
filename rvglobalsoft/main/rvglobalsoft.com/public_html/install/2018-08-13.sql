ALTER TABLE hb_order_drafts ADD `estimate_id` INT(11) DEFAULT 0;
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT `id`, 'global', 'accept_estimate','Accept estimate' FROM hb_language WHERE target!='admin'
UNION SELECT `id`, 'global', 'order_draft_has_estimate', 'This order draft already has estimate generated for it' FROM hb_language WHERE target!='user'
UNION SELECT `id`, 'global', 'order_draft_has_estimate2', 'This order draft has a generated estimate!' FROM hb_language WHERE target!='user'
UNION SELECT `id`, 'global', 'accept_estimate_q', 'Are you sure? This will issue new order / invoice in your account.' FROM hb_language WHERE target!='admin'
UNION SELECT `id`, 'global', 'est_markedinvoiced', 'Estimate #%s marked Invoiced' FROM hb_language
UNION SELECT `id`, 'global', 'estimate_has_invoice','This estimate was converted to invoice' FROM hb_language WHERE target!='user'
UNION SELECT `id`, 'global', 'estimate_has_order_draft', 'This estimate have order draft related to it' FROM hb_language WHERE target!='user';
##########
ALTER TABLE `hb_estimates` ADD COLUMN `invoice_id` INT(11) DEFAULT 0;
