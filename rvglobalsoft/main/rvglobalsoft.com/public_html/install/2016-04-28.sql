INSERT INTO `hb_reports` (`id`, `type`, `name`, `query`, `options`, `handler`)
VALUES
	(NULL, 'Invoices', 'Number of invoices generated per billing cycle in given period', 'SELECT COUNT(i.id) as `Invoice Count`,\r\n a.billingcycle as `Billing Cycle` \r\nFROM hb_invoices i \r\nINNER JOIN hb_invoice_items it ON it.invoice_id = i.id \r\nINNER JOIN hb_accounts a ON (a.id = it.item_id \r\nAND it.type = \'Hosting\') \r\nWHERE\r\n i.date >= :date_bottom \r\nAND i.date <= :date_top \r\nGROUP BY `Billing Cycle`', 1, 'sql');
