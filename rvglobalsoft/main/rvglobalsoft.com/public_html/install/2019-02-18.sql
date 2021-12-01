ALTER TABLE `hb_gateway_log` ADD INDEX (`result`);
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'orders', 'unbanthisip','Unban this IP' FROM hb_language WHERE target = 'admin'
UNION SELECT id, 'global', 'Processing','Processing' FROM hb_language WHERE target = 'user'
UNION SELECT id, 'coupons', 'coupon_already_exist','A coupon with this code already exists' FROM hb_language WHERE target = 'admin';
##########
REPLACE INTO hb_configuration (`setting`, `value`) VALUES ('BanClientIPLoginTime', 300);
##########
UPDATE `hb_reports` SET `query` = 'SELECT cd.country as `Country code`, i.taxrate as `VAT rate %`, COUNT(i.id) as `Invoices`, sql_currency(SUM(i.subtotal),:currency,0) as `Net amount`, sql_currency(SUM(i.tax),:currency,0) as `VAT collected`  FROM hb_invoices i  LEFT JOIN hb_client_details cd ON i.client_id = cd.id  WHERE i.taxrate > 0  AND i.tax > 0  AND i.date > :date_bottom  AND i.date < :date_top  AND cd.country IN ("BE", "BG", "CZ", "DK", "DE", "EE", "IE", "EL", "ES", "FR", "HR", "IT", "CY", "LV", "LT", "LU", "HU", "MT", "NL", "AT", "PL", "PT", "RO", "SI", "SK", "FI", "SE", "UK")  AND i.currency_id = :currency  GROUP BY cd.country, i.taxrate  ORDER BY cd.country ASC, i.taxrate ASC' 
WHERE type='Invoices'  AND name= "MOSS Summary Report";