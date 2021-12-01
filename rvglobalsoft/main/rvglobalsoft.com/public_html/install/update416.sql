UPDATE `hb_configuration` SET `value` = '4.1.6' WHERE `setting`= 'Version';
##########
ALTER TABLE `hb_tickets` CHANGE `status` `status` VARCHAR( 31 ) NOT NULL DEFAULT 'Open';
##########
ALTER TABLE hb_tickets DROP INDEX `status`;
##########
ALTER TABLE hb_tickets ADD INDEX `status`(`status`(3));
##########
CREATE TABLE `hb_ticket_status` (
 `status` varchar(31) NOT NULL,
 `options` int(3) NOT NULL default '0',
 `sort_order` int(3) NOT NULL default '0',
 PRIMARY KEY  (`status`),
 KEY `options` (`options`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
INSERT INTO `hb_ticket_status` VALUES
('Open',1,0),
('Closed',1,1),
('Answered',3,2),
('In-Progress',1,3),
('Client-Reply',1,4);
##########
REPLACE INTO hb_language_locales(`language_id`,`section`,`keyword`,`value`) SELECT `language_id`,`section`,'Client-Reply',`value` FROM  hb_language_locales WHERE `keyword`='Clientreply';
##########
REPLACE INTO hb_language_locales(`language_id`,`section`,`keyword`,`value`) SELECT `language_id`,`section`,'In-Progress',`value` FROM  hb_language_locales WHERE `keyword`='Inprogress';
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'configuration', 'ticketstatuses','Ticket Statuses' FROM hb_language WHERE target!='user'
UNION SELECT id, 'global', 'deleteInvoices','Delete Invoices' FROM hb_language WHERE target!='user'
UNION SELECT id, 'global', 'deleteEstimates','Delete Estimates' FROM hb_language WHERE target!='user'
UNION SELECT id, 'global', 'deleteTransactions','Delete Transactions' FROM hb_language WHERE target!='user'
UNION SELECT id, 'global', 'deleteOrders','Delete Orders' FROM hb_language WHERE target!='user';
##########
ALTER TABLE `hb_tickets_predefinied` CHANGE `status` `status` VARCHAR( 31 ) NULL DEFAULT NULL;
##########
UPDATE `hb_tickets_predefinied`
    SET `status` = CASE
        WHEN `status`=1 THEN "Open"
        WHEN `status`=2 THEN "Closed"
        WHEN `status`=3 THEN "Answered"
        WHEN `status`=4 THEN "In-Progress"
        WHEN `status`=5 THEN "Client-Reply"
        ELSE `status`
    END;
##########
INSERT INTO `hb_reports` (
`id` ,
`type` ,
`name` ,
`query` ,
`options`
)
VALUES (
NULL , 'Support', 'Number of tickets closed per staff member in given period', 'SELECT SUBSTRING_INDEX(l.`action`,''member'',''-1'') AS `Staff member`, COUNT(t.`id`) AS `Total closed`, DATE(l.`date`) AS `Date` FROM `hb_tickets` t JOIN `hb_tickets_log` l ON (l.ticket_id=t.id) WHERE l.date>= :date_bottom AND l.date<= :date_top AND t.status=''Closed'' AND l.action LIKE ''%to "Closed" by%'' GROUP BY `Date`, `Staff member`', '1'
),(
NULL , 'Support', 'Detailed list of all tickets in given period', 'SELECT t.subject AS `Ticket Subject`, t.ticket_number AS `Ticket ID`, d.`name` AS `Department`, t.status AS `Ticket Status`, t.`name` AS `Submitter Name`, t.email AS `Submitter Email`, t.`date` AS `Ticket Date`, COALESCE(CONCAT(a.firstname,'' '',a.lastname),''-'') AS `Assigned Admin`, COALESCE(r.`rep`,''0'') AS `Number of Replies`, t.`lastreply` AS `Last Reply Date`, t.`priority` AS `Priority Level` FROM `hb_tickets` t JOIN `hb_ticket_departments` d ON ( t.dept_id = d.id ) LEFT JOIN (SELECT r.`ticket_id`, COUNT(r.`id`) AS `rep` FROM `hb_ticket_replies` r WHERE r.`status`!=''Draft'' GROUP BY r.`ticket_id`) r ON (r.ticket_id=t.id) LEFT JOIN `hb_admin_details` a ON (a.id=t.owner_id) WHERE t.`date`>= :date_bottom AND t.`date`<= :date_top ', '1'
);
##########
UPDATE `hb_admin_access` SET access = CONCAT(access, ',deleteInvoices') WHERE access LIKE '%viewInvoices%';
##########
UPDATE `hb_admin_access` SET access = CONCAT(access, ',deleteEstimates') WHERE access LIKE '%viewEstimates%';
##########
UPDATE `hb_admin_access` SET access = CONCAT(access, ',deleteTransactions') WHERE access LIKE '%viewTransactions%';
##########
UPDATE `hb_admin_access` SET access = CONCAT(access, ',deleteOrders') WHERE access LIKE '%viewOrders%';
