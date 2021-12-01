#All orders in month
SELECT
	o.id as `Order ID`,
	o.number as `Order Number`,
	COALESCE(m.modname,'None') AS `Payment Gateway`,
	o.client_id AS `Client ID`,
	ca.email AS `Client Email`,
	CONCAT(cd.firstname,' ',cd.lastname) AS `Client`,
	hb_currency(o.total) AS `Order Total`,
	o.order_ip AS `Order IP`,
	hb_date(o.date_created) AS `Order Date`,
	o.status AS `Current Status`,
	COALESCE(cp.code,'None') AS `Promotional Coupon`,
	COALESCE(clog.discount,'0.00') AS `Discount`


FROM
	hb_orders o JOIN
	hb_modules_configuration m ON (m.id=o.payment_module) JOIN
	hb_client_details cd ON (cd.id = o.client_id) JOIN
	hb_client_access ca ON (ca.id=cd.id) LEFT JOIN
	hb_coupons_log clog ON (clog.order_id=o.id) LEFT JOIN
	hb_coupons cp ON (cp.id=clog.coupon_id)
WHERE
	o.date_created > :date_bottom	  AND
	o.date_created < :date_top


ORDER BY
	o.date_created ASC




#All invoices

SELECT
i.id AS `Invoice ID`,
CONCAT(d.firstname,' ',d.lastname) AS `Client`,
hb_currency(i.total,i.currency_id,i.rate) AS `Invoice Total`,
i.status AS `Invoice Status`,
hb_date(i.date) AS `Invoice Date`,
hb_currency(i.credit,i.currency_id,i.rate) AS `Invoice Credit`,
m.modname AS `Gateway Name`,
taxrate as `Tax1 rate`,
taxrate2 as `Tax2 rate`,
tax as `Tax1 Amount`,
tax2 as `Tax2 Amount`,
i.rate AS `Exchange Rate`,
hb_date(i.duedate) AS `Invoice Due Date`,
hb_date(i.datepaid) AS `Invoice Paid Date`,
t.trans_id AS `Related transaction`,
ca.email AS `Client Email`,
d.phonenumber AS `Client Phone`,
d.companyname  AS `Client Company`,
d.city AS `Client City`,
d.country AS `Client Country`,
d.address1 AS `Client Address`,
d.postcode AS `Client ZIP`

FROM hb_invoices i
    JOIN hb_client_details d ON (i.client_id=d.id)
    JOIN hb_client_access ca ON (i.client_id=ca.id)
    LEFT JOIN hb_modules_configuration m ON (m.id=i.payment_module)
    LEFT JOIN hb_currencies c ON (c.id=i.currency_id)
    LEFT JOIN hb_transactions t ON (t.invoice_id=i.id)
WHERE
    i.id NOT IN (
        SELECT invoice_id
        FROM hb_invoice_items
        WHERE `type` = 'Invoice'
    ) 
    AND i.status NOT IN ('Draft','Recurring')
    AND i.datepaid>= :date_bottom
    AND i.datepaid<= :date_top

ORDER BY
	i.id ASC



# top 15 customers

SELECT
cd.id AS `Client ID`,
CONCAT(cd.firstname,' ',cd.lastname) AS `Client`,
hb_currency(SUM(t.`in`),cb.currency_id) AS `Total Income`
FROM hb_client_details cd
JOIN hb_client_billing cb ON (cb.client_id=cd.id)
JOIN hb_transactions t ON (t.client_id=cd.id)
GROUP BY cd.id
ORDER BY SUM(t.`in`) DESC
LIMIT 15

# Unresolved tickets count by staff member

SELECT aa.id AS `Staff ID` , CONCAT( ad.firstname, ' ', ad.lastname ) AS `Staff Member` , COUNT( t.id ) AS `Unresolved Tickets Count`
FROM hb_admin_access aa
JOIN hb_admin_details ad ON ( aa.id = ad.id )
JOIN hb_tickets t ON ( t.owner_id = aa.id )
WHERE t.status!='Closed'
GROUP BY t.owner_id

# Unresolved tickets count by department member

SELECT d.id AS `Department ID` , d.name AS `Department Name` , COUNT( t.id ) AS `Unresolved Tickets Count`
FROM hb_tickets t
JOIN hb_ticket_departments d ON ( t.dept_id = d.id )
WHERE t.status != 'Closed'
GROUP BY t.dept_id


# List of clients that are Active, but dont have any active service
SELECT
cd.id AS `Client ID`,
CONCAT(cd.firstname,' ',cd.lastname) AS `Client`
FROM hb_client_details cd
WHERE cd.id NOT IN (SELECT client_id FROM hb_accounts WHERE status='Active')
AND cd.id NOT IN (SELECT client_id FROM hb_domains WHERE status='Active')
AND cd.id NOT IN (SELECT a.client_id FROM hb_accounts a JOIN hb_accounts_addons ad ON (ad.account_id=a.id) WHERE ad.status='Active')
ORDER BY cd.id ASC

# List of clients with active services, with inactive profile (disabled login) TEST
SELECT
cd.id AS `Client ID`,
CONCAT(cd.firstname,' ',cd.lastname) AS `Client`
FROM hb_client_details cd
JOIN hb_client_access ca ON (ca.id=cd.id)
WHERE (
cd.id IN (SELECT client_id FROM hb_accounts WHERE status='Active')
OR cd.id IN (SELECT client_id FROM hb_domains WHERE status='Active')
OR cd.id IN  (SELECT a.client_id FROM hb_accounts a JOIN hb_accounts_addons ad ON (ad.account_id=a.id) WHERE ad.status='Active')
)
AND ca.status!='Active'
ORDER BY cd.id ASC


# List of possible duplicates in client profiles
SELECT
cd.id AS `Client ID`,
CONCAT(cd.firstname,' ',cd.lastname) AS `Client`,
ca.email AS `Client Email`
FROM hb_client_details cd
JOIN hb_client_access ca ON (ca.id=cd.id)
INNER JOIN (
 SELECT firstname, lastname FROM hb_client_details GROUP BY firstname,lastname HAVING COUNT(id)>1
) dup ON (dup.firstname=cd.firstname AND dup.lastname=cd.lastname)
ORDER BY cd.firstname,cd.lastname ASC


# Total transaction fees by gateway
SELECT
m.modname AS `Gateway Name`,
hb_currency(SUM(t.fee),t.currency_id,t.rate) AS `Total Fee`
FROM hb_modules_configuration m
JOIN hb_transactions t ON (t.module=m.id)
GROUP BY t.module


# Total transactions count by gateway
SELECT
m.modname AS `Gateway Name`,
COUNT(t.id) AS `Transactions count`
FROM hb_modules_configuration m
JOIN hb_transactions t ON (t.module=m.id)
GROUP BY t.module


# List of tickets due today (based on SLA)

SELECT
t.subject AS `Ticket Subject`,
t.ticket_number AS `Ticket ID`,
d.name AS `Department`,
t.status AS `Ticket Status`,
t.name AS `Submitter Name`,
t.email AS `Submitter Email`,
t.`date` AS `Ticket Date`,
t.resolve_date AS `Ticket Due Date`
FROM hb_tickets t
JOIN hb_ticket_departments d ON ( t.dept_id = d.id )
WHERE t.status != 'Closed'
AND
t.resolve_date!='0000-00-00 00:00:00'
AND
DATE(t.resolve_date)=DATE(NOW())


# List of overdue tickets (based on SLA)

SELECT
t.subject AS `Ticket Subject`,
t.ticket_number AS `Ticket ID`,
d.name AS `Department`,
t.status AS `Ticket Status`,
t.name AS `Submitter Name`,
t.email AS `Submitter Email`,
t.`date` AS `Ticket Date`,
t.resolve_date AS `Ticket Due Date`
FROM hb_tickets t
JOIN hb_ticket_departments d ON ( t.dept_id = d.id )
WHERE t.status != 'Closed'
AND
t.resolve_date!='0000-00-00 00:00:00'
AND
t.resolve_date < NOW()

# Average number of ticket replies per department
SELECT
d.name AS `Department`,
a.tot/COUNT(t.id) AS `Average replies`
FROM hb_ticket_departments d JOIN
(
 SELECT COUNT(r.id) as tot, t.dept_id FROM hb_ticket_replies r JOIN hb_tickets t ON (t.id=r.ticket_id)
 GROUP BY t.dept_id
) a ON (a.dept_id=d.id)
JOIN hb_tickets t ON (t.dept_id=d.id)
GROUP BY t.dept_id

# List of tickets with rated less than 3 points this month

SELECT
t.subject AS `Ticket Subject`,
t.ticket_number AS `Ticket ID`,
d.name AS `Department`,
t.status AS `Ticket Status`,
t.name AS `Submitter Name`,
t.email AS `Submitter Email`,
t.`date` AS `Ticket Date`
FROM hb_tickets t
JOIN hb_ticket_departments d ON ( t.dept_id = d.id )
WHERE t.id IN (
    SELECT r.ticket_id FROM hb_ticket_replies r JOIN  `hb_ticket_replies_rating` rate ON (rate.reply_id=r.id)
    WHERE rate.rating<3
)
ORDER BY t.date ASC


# List of overdue invoices


SELECT
i.id AS `Invoice ID`,
CONCAT(d.firstname,' ',d.lastname) AS `Client`,
hb_currency(i.total,i.currency_id,i.rate) AS `Invoice Total`,
i.status AS `Invoice Status`,
i.duedate AS `Invoice Due Date`,
m.modname AS `Gateway Name`,
taxrate as `Tax1 rate`,
taxrate2 as `Tax2 rate`,
tax as `Tax1 Amount`,
tax2 as `Tax2 Amount`,
i.rate AS `Exchange Rate`,
i.date AS `Invoice Date`,
ca.email AS `Client Email`,
d.phonenumber AS `Client Phone`,
d.companyname  AS `Client Company`,
d.city AS `Client City`,
d.country AS `Client Country`,
d.address1 AS `Client Address`,
d.postcode AS `Client ZIP`,
d.id AS `Client ID`

FROM hb_invoices i
    JOIN hb_client_details d ON (i.client_id=d.id)
    JOIN hb_client_access ca ON (i.client_id=ca.id)
    LEFT JOIN hb_modules_configuration m ON (m.id=i.payment_module)
    LEFT JOIN hb_currencies c ON (c.id=i.currency_id)
WHERE
    i.id NOT IN (
        SELECT invoice_id
        FROM hb_invoice_items
        WHERE `type` = 'Invoice'
    )
    AND i.status IN ('Unpaid')
    AND i.duedate >= NOW()

ORDER BY
	i.id ASC




# Hours spent by staff online this week
SELECT
l.admin_id AS `Staff ID`,
CONCAT( ad.firstname, ' ', ad.lastname ) AS `Staff Member`,
SUM(TIME_TO_SEC(TIMEDIFF(l.logout,l.login)))/3600 as `Hours Online`
FROM hb_admin_log l 
JOIN hb_admin_details ad ON (ad.id=l.admin_id)
WHERE
 YEARWEEK(l.login) = YEARWEEK(NOW())
 GROUP BY admin_id

# Hours spent online by staff this month
SELECT
l.admin_id AS `Staff ID`,
CONCAT( ad.firstname, ' ', ad.lastname ) AS `Staff Member`,
SUM(TIME_TO_SEC(TIMEDIFF(l.logout,l.login)))/3600 as `Hours Online`
FROM hb_admin_log l
JOIN hb_admin_details ad ON (ad.id=l.admin_id)
WHERE
 MONTH(l.login) = MONTH(NOW())
AND
 YEAR(l.login) = YEAR(NOW())
 GROUP BY admin_id


# Number of support ticket opened per service in given period

SELECT
c.name AS `Product Category`,
p.name AS `Product Name`,
COUNT(t.id) AS `Tickets count`
FROM hb_products p
JOIN hb_categories c ON (c.id=p.category_id)
JOIN hb_accounts a ON (a.product_id=p.id)
JOIN hb_tickets t ON (t.client_id=a.client_id)
WHERE
    t.date >= :date_bottom
    AND t.date <= :date_top
GROUP BY p.id



# Income from manually created invoices in given period
SELECT
 hb_currency(SUM(t.`in`),t.currency_id,t.rate) AS `Total Income`
FROM
 hb_transactions t
 JOIN hb_invoices i ON (t.invoice_id=i.id)
 WHERE
 i.id IN (SELECT invoice_id FROM hb_invoice_items WHERE  `type`='Other')
 AND
    t.date >= :date_bottom
    AND t.date <= :date_top


# List of overdue but non-terminated recurring accounts
SELECT
 a.id AS `Account ID`,
 c.name AS `Category Name`,
 p.name AS `Product Name`,
 a.status AS `Account Status`,
 a.next_due AS `Account next due date`

FROM hb_accounts a
 JOIN hb_products p ON (p.id=a.product_id)
 JOIN hb_categories c ON (c.id=p.category_id)
WHERE
 a.status NOT IN ('Terminated','Cancelled','Fraud','Pending')
AND
 a.billingcycle NOT IN ('Free','One Time')
AND
 a.id IN (
 SELECT it.item_id FROM hb_invoice_items it JOIN hb_invoices i ON (i.id=it.invoice_id)
 WHERE it.type='Hosting' AND i.status='Unpaid'
)

# Total sales tax liability in selected period, converted to main currency
SELECT
 hb_currency(SUM(i.tax)) AS `Total Tax L1`,
 hb_currency(SUM(i.tax2)) AS `Total Tax L2`,
 hb_currency(SUM(i.total)) AS `Invoice totals`,
 hb_currency(SUM(i.subtotal)) AS `Invoice subtotals`,
 hb_currency(SUM(i.credit)) AS `Invoice credits`
FROM hb_invoices i
 WHERE i.status='Paid'
 AND  i.datepaid>= :date_bottom
    AND i.datepaid<= :date_top

# Sales tax liability in selected period, converted to main currency

SELECT
i.id AS `Invoice ID`,
CONCAT(d.firstname,' ',d.lastname) AS `Client`,
hb_currency(i.total) AS `Invoice Subtotal`,
hb_currency(i.credit) AS `Invoice Credit`,
hb_currency(i.tax) AS `Invoice Tax L1`,
hb_currency(i.tax2) AS `Invoice Tax L2`,
hb_currency(i.total) AS `Invoice Total`,
hb_date(i.datepaid) AS `Invoice Paid Date`,
hb_date(i.date) AS `Invoice Date`,
m.modname AS `Gateway Name`,
t.trans_id AS `Related transaction`

FROM hb_invoices i
    JOIN hb_client_details d ON (i.client_id=d.id)
    JOIN hb_client_access ca ON (i.client_id=ca.id)
    LEFT JOIN hb_modules_configuration m ON (m.id=i.payment_module)
    LEFT JOIN hb_transactions t ON (t.invoice_id=i.id)
WHERE
    i.id NOT IN (
        SELECT invoice_id
        FROM hb_invoice_items
        WHERE `type` = 'Invoice'
    )
    AND i.status IN ('Paid')
    AND i.datepaid>= :date_bottom
    AND i.datepaid<= :date_top

ORDER BY
	i.id ASC


# List all suspended accounts with their suspension dates
SELECT
 a.id AS `Account ID`,
 MAX(s.`date`) AS `Suspension Date`,
 a.client_id AS `Client ID`,
 CONCAT(cd.firstname,' ',cd.lastname) AS `Client`,
 a.`domain` AS `Account Domain`,
 a.date_created AS `Creation date`,
 a.billingcycle AS `Billing cycle`,
 a.username AS `Username`
FROM
     hb_accounts a JOIN
     hb_client_details cd ON (cd.id=a.client_id) JOIN
     `hb_account_logs` s ON (s.account_id=a.id)
WHERE
     a.status='Suspended'
    AND s.`event`='AccountSuspend' 
    AND s.`result`='1'
GROUP BY a.id
ORDER BY `Suspension Date` DESC

# 15 clients with highest number of tickets
SELECT
 t.client_id AS `Client ID`,
 COUNT(t.id) AS `Total tickets`,
 CONCAT(cd.firstname,' ',cd.lastname) AS `Client`,
 cd.datecreated AS `Client since`
FROM hb_tickets t JOIN
 hb_client_details cd ON (cd.id=t.client_id)

GROUP BY t.client_id
ORDER BY `Total tickets` DESC
LIMIT 15

# All transactions informations in given period with purchased items details

SELECT
 t.trans_id AS `Transaction ID`,
 t.date AS `Transaction Date`,
 hb_currency(t.`in`,t.`currency_id`,t.rate) AS `Amount In`,
 it.description AS `Invoice Item`,
 hb_currency(t.`fee`,t.`currency_id`,t.rate) AS `Transaction Fees`,
 CONCAT(d.firstname,' ',d.lastname) AS `Client`,
 t.description AS `Transaction Description`,
 hb_currency(t.`out`,t.`currency_id`,t.rate) AS `Amount Out`,
 t.client_id AS `Client ID`,
 t.invoice_id AS `Invoice ID`,
 m.modname AS `Payment Gateway`

FROM hb_transactions t JOIN
hb_invoices i ON (i.id=t.invoice_id) JOIN
hb_invoice_items it ON (it.invoice_id=i.id) JOIN
hb_client_details d ON (d.id=t.client_id) JOIN
hb_modules_configuration m ON (m.id=t.`module`)
WHERE

    t.date>= :date_bottom
    AND t.date<= :date_top
ORDER BY t.date DESC


# Number of tickets closed per staff member in given period

SELECT
    SUBSTRING_INDEX(l.`action`,'member','-1') AS `Staff member`,
    COUNT(t.`id`) AS `Total closed`,
    DATE(l.`date`) AS `Date`
FROM `hb_tickets` t
JOIN `hb_tickets_log` l ON (l.ticket_id=t.id)
WHERE
    l.date>= :date_bottom
    AND l.date<= :date_top
AND 
    t.status='Closed'
AND
    l.action LIKE '%to "Closed" by%'

GROUP BY `Date`, `Staff member`

# Detailed list of all tickets in given period


SELECT
t.subject AS `Ticket Subject`,
t.ticket_number AS `Ticket ID`,
d.`name` AS `Department`,
t.status AS `Ticket Status`,
t.`name` AS `Submitter Name`,
t.email AS `Submitter Email`,
t.`date` AS `Ticket Date`,
COALESCE(CONCAT(a.firstname,' ',a.lastname),'-') AS `Assigned Admin`,
COALESCE(r.`rep`,'0') AS `Number of Replies`,
t.`lastreply` AS `Last Reply Date`,
t.`priority` AS `Priority Level`

FROM `hb_tickets` t
JOIN `hb_ticket_departments` d ON ( t.dept_id = d.id )
LEFT JOIN (SELECT r.`ticket_id`, COUNT(r.`id`) AS `rep` FROM `hb_ticket_replies` r WHERE r.`status`!='Draft' GROUP BY r.`ticket_id`) r ON (r.ticket_id=t.id)
LEFT JOIN `hb_admin_details` a ON (a.id=t.owner_id)
WHERE
  t.`date`>= :date_bottom
  AND t.`date`<= :date_top



# Income per product in given period

SELECT
p.name AS `Product Name`,
SUM(it.`amount`) AS `Product Income`,
p.id AS `Product ID`

FROM hb_invoices i
JOIN hb_invoice_items it ON (it.invoice_id=i.id)
JOIN hb_accounts a ON (a.id=it.item_id AND it.type='Hosting')
JOIN hb_products p ON (p.id=a.product_id)
WHERE i.status='Paid'
AND
  i.`datepaid`>= :date_bottom
  AND i.`datepaid`<= :date_top

GROUP BY p.id
ORDER BY `Product Income` DESC