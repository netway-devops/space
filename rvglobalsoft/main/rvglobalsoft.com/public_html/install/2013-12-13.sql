INSERT INTO  `hb_reports` (
`id` ,
`type` ,
`name` ,
`query` ,
`options` ,
`handler`
)
VALUES (
    NULL ,  'Support',  'Top 30 tickets-posting countries',  'SELECT cd.country AS  `Client Country` , COUNT( t.id ) AS  `Tickets Count` 
    FROM hb_tickets t
    JOIN hb_client_details cd ON ( cd.id = t.client_id ) 
    GROUP BY cd.country
    ORDER BY  `Tickets Count` DESC 
    LIMIT 30',  '1',  'sql'
);
##########UPDATE hb_common SET paytype ='volume' WHERE paytype = 'tiered' AND rel ='FResource';
##########
REPLACE INTO `hb_configuration` (`setting`, `value`) VALUES
('RenewInvoice', '1'),
('InvoiceGeneration', '7'),
('InvoiceExpectDays', '0'),
('SendPaymentReminderEmails', 'off'),
('InvoiceUnpaidReminder', '0'),
('1DomainReminder', '50'),
('1OverdueReminder', '1'),
('2DomainReminder', '40'),
('2OverdueReminder', '2'),
('3DomainReminder', '30'),
('3OverdueReminder', '3'),
('4DomainReminder', '10'),
('5DomainReminder', '5'),
('AddLateFeeAfter', '6'),
('LateFeeType', '0'),
('LateFeeValue', '0'),
('EnableAutoSuspension', 'off'),
('EnableAutoTermination', 'off'),
('EnableAutoTransferDomain', 'on'),
('EnableAutoUnSuspension', 'on'),
('AdvancedDueDate', 'off'),
('InitialDueDays', '0'),
('AutoSuspensionPeriod', '10'),
('AutoTerminationPeriod', '30'),
('EnableProRata', 'off'),
('ProRataDay', '1'),
('ProRataMonth', 'disabled'),
('ProRataNextMonth', '0'),
('AutoProcessCancellations', 'off'),
('AutoCancelUnpaidInvoices', 'off');
