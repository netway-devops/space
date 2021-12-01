INSERT INTO `hb_reports` (`id`, `type`, `name`, `query`, `options`, `handler`)
VALUES
	(NULL, 'Clients', 'List of all customers with their statistics', 'SELECT cd.id as `Client ID`,\r\n cd.firstname as `First Name`,\r\n cd.lastname as `Last Name`,\r\n cd.city as `City`,\r\n ca.status as `Status`,\r\n cd.datecreated as `Signup Date`,\r\n COALESCE(a.cnt,0) as `Active Services Count`,\r\n COALESCE(i.dt,\'0000-00-00\') as `Date of Last Invoice`,\r\n COALESCE(i.cnt,0) as `Invoices Paid Total`,\r\n COALESCE(t.cnt,0) as `Transaction Income`,\r\n COALESCE(cur.code,sub.main_currency) as `Currency`,\r\n COALESCE(cur.rate,1) as `Currency Rate` \r\nFROM hb_client_details cd \r\nINNER JOIN hb_client_access ca ON ca.id = cd.id \r\nINNER JOIN hb_client_billing cb ON cb.client_id = cd.id \r\nINNER JOIN (SELECT value as main_currency, 0 as currency_id \r\nFROM hb_configuration \r\nWHERE\r\n setting = \'CurrencyCode\') sub ON sub.currency_id = 0 \r\nLEFT JOIN hb_currencies cur ON cur.id = cb.currency_id \r\nLEFT JOIN (SELECT COUNT(id) as cnt, client_id \r\nFROM hb_accounts \r\nGROUP BY client_id) a ON a.client_id = cd.id \r\nLEFT JOIN (SELECT MAX(date) as dt, SUM(total) as cnt, client_id \r\nFROM hb_invoices \r\nWHERE\r\n status = \'Paid\' \r\nGROUP BY client_id) i ON i.client_id = cd.id \r\nLEFT JOIN (SELECT SUM(`in`) as cnt, client_id \r\nFROM hb_transactions \r\nGROUP BY client_id) t ON t.client_id = cd.id \r\n\r\nORDER BY cd.id DESC', 1, 'sql');
