DROP FUNCTION IF EXISTS sql_currency;
DELIMITER $$
CREATE FUNCTION sql_currency (amount float(15,2), currency_id int, rate bool)
RETURNS varchar(50) CHARSET utf8
DETERMINISTIC
BEGIN
DECLARE value varchar(25);
DECLARE currency_prefix varchar(10);
DECLARE currency_suffix varchar(10);
DECLARE currency_rate decimal(15,10);
SET value = amount;
SET value = ROUND(value, 2);
IF currency_id <> 0  THEN
IF rate <> 0 THEN
SELECT c.rate  INTO currency_rate FROM hb_currencies c WHERE c.id = currency_id;
SET value = (amount * currency_rate);
END IF;
SET value = ROUND(value, 2);
SELECT c1.sign INTO currency_prefix FROM hb_currencies c1 WHERE c1.id = currency_id;
SELECT c2.code INTO currency_suffix FROM hb_currencies c2 WHERE c2.id = currency_id;
ELSE
SELECT cn1.value INTO currency_prefix FROM hb_configuration cn1 WHERE setting = 'CurrencySign';
SELECT cn2.value INTO currency_suffix FROM hb_configuration cn2 WHERE setting = 'CurrencyCode';
END IF;
SET value = CONCAT(currency_prefix,value,' ',currency_suffix);
RETURN value;
END$$
DELIMITER ;