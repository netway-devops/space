<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}

// --- hostbill helper ---
$api        = new ApiWrapper();
$db         = hbm_db();
// --- hostbill helper ---

// --- Get template variable ---
$aTasks     = $this->get_template_vars('tasks');
// --- Get template variable ---

//echo '<pre>'.print_r($tasks,true).'</pre>';

$aTaskSQLs = array(
    'generateInvoices'      => "
        
           33 Query UPDATE `hb_cron_tasks` SET status='0', `count`='1', lastrun='2019-08-27 16:18:12', `output`='' WHERE task='generateInvoices'
           33 Query SELECT `item_id`, `type`
            FROM hb_subscription_items 
            WHERE gateway_subid!='' 
            AND next_date > DATE_SUB(NOW(), INTERVAL 1 WEEK)
           33 Query SELECT c.account_id FROM hb_cancel_requests c
           33 Query SELECT a.client_id, a.next_due, a.due_day,
            a.next_invoice, a.total, a.billingcycle, a.payment_module, a.id, a.label, 
            a.product_id, p.name, p.tax, cd.firstname, cd.lastname, a.domain, 
            c.name as catname, cd.language, a.billingtype, a.status
            FROM hb_accounts a 
            JOIN hb_client_details cd ON(a.client_id=cd.id)
            JOIN hb_client_access ca ON(a.client_id=ca.id)
            LEFT JOIN hb_products p ON (a.product_id=p.id)
            LEFT JOIN hb_categories c ON (p.category_id=c.id)
            WHERE (a.status='Active' OR a.status='Suspended') 
                AND a.next_invoice <= '2019-08-27 16:18:12' 
                AND a.next_invoice!='0000-00-00' 
                AND a.next_invoice!=''
                AND a.billingcycle!='One Time' 
                AND a.billingcycle!='Free'
                AND a.billingcycle!=''
                AND a.next_due
                AND a.autorenew!=0
                AND ca.status IN ('Active', 'Closing')
            ORDER BY a.client_id
           33 Query SELECT a.client_id, a.next_due, a.due_day,
            a.next_invoice, a.total, a.billingcycle, a.payment_module, a.id, a.label, 
            a.product_id, p.name, p.tax, cd.firstname, cd.lastname, a.domain, 
            c.name as catname, cd.language, a.billingtype, a.status
            FROM hb_accounts a 
            JOIN hb_client_details cd ON(a.client_id=cd.id)
            JOIN hb_client_access ca ON(a.client_id=ca.id)
            LEFT JOIN hb_products p ON (a.product_id=p.id)
            LEFT JOIN hb_categories c ON (p.category_id=c.id)
            WHERE (a.status='Active' OR a.status='Suspended') 
                AND a.next_invoice <= '2019-08-27 16:18:12' 
                AND a.next_invoice!='0000-00-00' 
                AND a.next_invoice!=''
                AND a.billingcycle!='One Time' 
                AND a.billingcycle!='Free'
                AND a.billingcycle!=''
                AND a.next_due
                AND a.autorenew!=0
                AND ca.status IN ('Active', 'Closing')
            ORDER BY a.client_id
           33 Query SELECT a.*, a.recurring_amount total, 
            accs.client_id, adds.taxable tax, cd.firstname, cd.language, 
            cd.lastname, accs.domain, p.name prodname, accs.billingtype,
            accs.status as 'account_status', a.status
            FROM hb_accounts_addons a
            JOIN hb_accounts accs ON ( accs.id = a.account_id )
            JOIN hb_client_details cd ON (accs.client_id=cd.id)
            JOIN hb_client_access ca ON (accs.client_id=ca.id)
            LEFT JOIN hb_products p ON (accs.product_id=p.id)
            LEFT JOIN `hb_addons` adds ON ( adds.id = a.addon_id )
            WHERE ( a.status = 'Active' OR a.status='Suspended')
                AND ( accs.status = 'Active' OR accs.status='Suspended')
                AND a.next_invoice <= '2019-08-27 16:18:12' 
                AND a.next_invoice!='' 
                AND a.next_invoice!='0000-00-00'
                AND a.billingcycle != 'One Time' 
                AND a.billingcycle != 'Free'
                AND accs.autorenew!=0
                AND ca.status IN ('Active', 'Closing')
            ORDER BY accs.client_id
           33 Query SELECT a.*, a.recurring_amount total, 
            accs.client_id, adds.taxable tax, cd.firstname, cd.language, 
            cd.lastname, accs.domain, p.name prodname, accs.billingtype,
            accs.status as 'account_status', a.status
            FROM hb_accounts_addons a
            JOIN hb_accounts accs ON ( accs.id = a.account_id )
            JOIN hb_client_details cd ON (accs.client_id=cd.id)
            JOIN hb_client_access ca ON (accs.client_id=ca.id)
            LEFT JOIN hb_products p ON (accs.product_id=p.id)
            LEFT JOIN `hb_addons` adds ON ( adds.id = a.addon_id )
            WHERE ( a.status = 'Active' OR a.status='Suspended')
                AND ( accs.status = 'Active' OR accs.status='Suspended')
                AND a.next_invoice <= '2019-08-27 16:18:12' 
                AND a.next_invoice!='' 
                AND a.next_invoice!='0000-00-00'
                AND a.billingcycle != 'One Time' 
                AND a.billingcycle != 'Free'
                AND accs.autorenew!=0
                AND ca.status IN ('Active', 'Closing')
            ORDER BY accs.client_id
           33 Query SELECT d.*, cd.firstname, cd.lastname, cd.language
            FROM hb_domains d
            JOIN hb_client_details cd ON (cd.id=d.client_id)
            JOIN hb_client_access ca ON (ca.id=d.client_id)
            LEFT JOIN hb_automation_settings au ON au.item_id = d.tld_id AND au.setting = 'RenewInvoice'
            WHERE
                d.autorenew='1'
                AND d.status='Active'
                AND d.next_invoice<='2019-08-27 16:18:12'
                AND d.next_invoice!='0000-00-00'
                AND d.next_invoice!=''
                AND (au.value IS NULL OR au.value = 1)
                AND ca.status IN ('Active', 'Closing')
                AND d.id NOT IN (
                    SELECT oi.item_id
                    FROM hb_order_items oi
                    JOIN hb_orders o ON o.id=oi.order_id
                    WHERE o.date_created > DATE_SUB('2019-08-27 16:18:12', INTERVAL 10 MONTH)
                    AND oi.`type` = 'Domain Renew'
                )
           33 Query SELECT i.id AS invoice_id, r.*, cd.firstname, cd.lastname
            FROM hb_recurring_invoices r 
            JOIN hb_invoices i ON (i.status='Recurring' AND i.recurring_id=r.id)
            JOIN hb_client_details cd ON (cd.id=i.client_id)
            JOIN hb_client_access ca ON (ca.id=i.client_id)
            WHERE r.next_invoice<=CURDATE() 
            AND ca.status IN ('Active', 'Closing')
            AND (
              (r.invoices_left>0 AND r.occurrences>0) 
              OR r.occurrences=0
            )
           33 Query DELETE FROM hb_invoices 
            WHERE  status='Draft' 
            AND client_id=0 
            AND `date`!=CURDATE() 
            AND id NOT IN (SELECT invoice_id FROM hb_invoice_items)
           33 Query UPDATE `hb_cron_tasks` SET status='1', `count`='0', lastrun='2019-08-27 16:18:12', `output`='' WHERE task='generateInvoices'

            
    ",
    'TaskScheduler'         => "
    
         Query SELECT `status`,`count`,`output` FROM `hb_cron_tasks` WHERE `task`='TaskScheduler' LIMIT 1
         Query UPDATE `hb_cron_tasks` SET status='0', `count`='1', lastrun='2013-04-04 17:55:18', `output`='' WHERE task='TaskScheduler'
         Query SELECT * FROM hb_task_list WHERE `interval` >0 AND `when`='after' AND `event` NOT IN ('NewOrder') AND `interval_type` IN ('DAY')
         Query SELECT * FROM hb_task_list WHERE `interval` >0 AND `when`='before'
         Query UPDATE `hb_cron_tasks` SET status='1', `count`='0', lastrun='2013-04-04 17:55:19', `output`='' WHERE task='TaskScheduler'
    
    ",
    'moduleAutomation'      => "
    
         Query SELECT DISTINCT it.* , client.firstname, client.lastname, inv.client_id, it.item_id AS autid
                FROM hb_invoice_items it
                JOIN hb_invoices inv ON (it.invoice_id=inv.id)
                JOIN hb_client_details client ON ( client.id = inv.client_id )
                LEFT JOIN hb_accounts a ON ( it.item_id = a.id AND it.type = 'Hosting' )
                LEFT JOIN hb_accounts_addons ad ON ( it.item_id = ad.id AND it.type = 'Addon' )
                LEFT JOIN hb_automation_settings s ON ( (s.item_id = a.product_id AND s.type = 'Hosting') OR (s.item_id = ad.addon_id AND s.type = 'Addon') )
                WHERE
                    ((s.setting = 'EnableAutoTermination' AND s.value='on') OR  s.setting = 'AutoTerminationPeriod')
                AND it.type IN ('Hosting','Addon')
                AND it.item_id NOT IN (
                    SELECT rel_id FROM hb_task_log WHERE task_id=2 AND rel_type='Hosting'
                )
                AND  inv.status='Unpaid' ORDER BY inv.duedate ASC
    
         Query SELECT a.id AS item_id, a.client_id, client.firstname, client.lastname, 'Hosting' as type, a.id AS autid, '1' as isfree
                FROM hb_accounts a
                JOIN hb_client_details client ON ( client.id = a.client_id )
                WHERE a.id IN  (
                    SELECT ac.id
                    FROM hb_accounts ac
                        JOIN hb_automation_settings s ON ( s.item_id = ac.product_id AND s.type = 'Hosting' )
                    WHERE ((s.setting = 'EnableAutoTermination' AND s.value='on') OR  s.setting = 'AutoTerminationPeriod')
                ) AND a.id NOT IN (
                    SELECT rel_id FROM hb_task_log WHERE task_id=2 AND rel_type='Hosting'
                ) AND a.status='Active' AND a.billingcycle='Free' AND a.next_due!='' AND a.next_due!='0000-00-00'   AND a.next_due<'2013-04-04 18:13:12'
                
         Query SELECT a.id AS item_id, adb.client_id, client.firstname, client.lastname, 'Addon' as type, a.id AS autid, '1' as isfree
                FROM hb_accounts_addons a
                JOIN hb_accounts adb ON (adb.id=a.account_id)
                JOIN hb_client_details client ON ( client.id = adb.client_id )
                WHERE a.id NOT IN  (
                    SELECT ac.id
                    FROM hb_accounts_addons ac
                    JOIN hb_automation_settings s ON ( s.item_id = ac.addon_id AND s.type = 'Addon' )
                    WHERE s.setting = 'EnableAutoTermination' OR s.setting='AutoTerminationPeriod'
                ) AND a.status='Active' AND a.billingcycle='Free' AND a.next_due!='' AND a.next_due!='0000-00-00'   AND a.next_due<'2013-04-04 18:13:12'
                
    ",
    'processAccountProvisioning'    => "
        
         Query (
                SELECT ac.id,o.invoice_id,ac.order_id
                FROM hb_accounts ac
                JOIN hb_products pr ON (
                    pr.id=ac.product_id AND (
                        pr.autosetup = 4 OR ac.client_id IN (
                            SELECT ca.id FROM hb_client_access ca
                            JOIN hb_client_group cg ON (cg.id=ca.group_id)
                            JOIN hb_automation_settings s ON (s.item_id=cg.id AND s.type='ClientGroup')
                            WHERE s.setting='EnableAutoCreation'
                            AND s.value='4'
                         )
                     )
                 )
            JOIN hb_orders o ON o.id=ac.order_id
            JOIN hb_invoices i ON i.id=o.invoice_id AND i.`status` = 'Paid'
            LEFT JOIN hb_account_logs al ON al.account_id=ac.id AND al.`action` = 'Cron provision'
            WHERE ac.`status` = 'Pending' AND al.id IS NULL ORDER BY ac.date_created ASC LIMIT 5)
            UNION
            (SELECT ac.id,0 as invoice_id,ac.order_id FROM hb_accounts ac
             JOIN hb_products pr ON (
                    pr.id=ac.product_id AND (
                        pr.autosetup = 4 OR ac.client_id IN (
                            SELECT ca.id FROM hb_client_access ca
                            JOIN hb_client_group cg ON (cg.id=ca.group_id)
                            JOIN hb_automation_settings s ON (s.item_id=cg.id AND s.type='ClientGroup')
                            WHERE s.setting='EnableAutoCreation'
                            AND s.value='4'
                         )
                     )
                 )
            JOIN hb_orders o ON o.id=ac.order_id
            LEFT JOIN hb_account_logs al ON al.account_id=ac.id AND al.`action` = 'Cron provision'
            WHERE o.invoice_id='0' AND ac.`status` = 'Pending' AND al.id IS NULL ORDER BY ac.date_created ASC LIMIT 5)
    
    ",
    'automaticRegisterDomains'      => "
    
         Query SELECT dom.tld_id, dom.id, dom.name, dom.period, dom.order_id, dom.client_id, modu.module, ord.number AS order_num, p.autosetup
                FROM hb_domains dom
                JOIN hb_products p ON (dom.tld_id=p.id)
                JOIN hb_modules_configuration modu ON ( dom.reg_module = modu.id )
                JOIN hb_orders ord ON ( dom.order_id = ord.id )
                LEFT JOIN hb_invoices inv ON (ord.invoice_id = inv.id)
            WHERE
                dom.status='Pending'
                AND p.autosetup!='0'
                AND dom.type='Register'
                AND (inv.status='Paid' OR ord.invoice_id=0)
                AND DATEDIFF('2013-04-04 20:38:36',inv.datepaid)<2
                AND modu.module NOT IN ('Email','0')
                AND dom.id NOT IN
                    (
                        SELECT domain_id FROM hb_domain_logs
                            WHERE (`action` LIKE 'Register domain%' OR `event`='DomainRegister')
                            AND DATEDIFF('2013-04-04 20:38:36',`date`)<3
                    )
    
    ",
    'automaticRenewDomains'     => "
    
         Query SELECT dom.tld_id, dom.id, dom.name, dom.period, dom.order_id, dom.client_id, modu.module, ord.number AS order_num
    FROM hb_domains dom
        JOIN hb_domain_prices p ON (p.product_id=dom.tld_id)
        JOIN hb_modules_configuration modu ON ( dom.reg_module = modu.id )
        JOIN hb_orders ord ON ( dom.order_id = ord.id )
        LEFT JOIN hb_invoices inv ON (ord.invoice_id = inv.id)
        WHERE
            dom.status IN ('Active','Expired')
            AND p.not_renew=0
            AND dom.type='Renew'
             AND (inv.status='Paid' OR ord.invoice_id=0)
            AND DATEDIFF('2013-04-04 20:43:08',inv.datepaid)<2
            AND modu.module NOT IN ('Email','0')
            AND dom.id NOT IN (SELECT domain_id FROM hb_domain_logs WHERE (`action` LIKE 'Renew domain%' OR `event`='DomainRenew') AND DATEDIFF('2013-04-04 20:43:08',`date`)<3)
    
    ",
    'cancellationRequests'      => "
    
         Query SELECT c.*,a.domain, a.client_id, cd.firstname, cd.lastname FROM hb_cancel_requests c
        LEFT JOIN hb_accounts a ON (a.id = c.account_id)
     LEFT JOIN hb_client_details cd ON (cd.id = a.client_id)
    WHERE (a.status != 'Terminated' AND a.status != 'Fraud' AND a.status != 'Cancelled' AND a.status != 'Pending') AND
    ((c.type='Immediate' AND a.id NOT IN (SELECT account_id FROM hb_account_logs WHERE admin_login='Automation' AND `action`='Delete Account' AND DATE_ADD(`date`,INTERVAL 1 DAY)>'2013-04-04 20:49:20'))
            OR (c.type='End of billing period' AND a.next_invoice=CURRENT_DATE()))
                AND a.product_id IN (SELECT item_id FROM hb_automation_settings s WHERE type='Hosting' AND setting='AutoProcessCancellations' AND value='on')
    
    ",
    'customModules'             => "
    
         Query UPDATE `hb_cron_tasks` SET status='0', `count`='1', lastrun='2013-04-04 20:52:22', `output`='' WHERE task='customModules'
         Query UPDATE `hb_cron_tasks` SET status='1', `count`='0', lastrun='2013-04-04 20:52:22', `output`='' WHERE task='customModules'
    
    ",
    'TaskScheduler_Execute'     => "
    
         Query SELECT l.*,c.action_config, c.task  FROM hb_task_log l JOIN hb_task_list c ON (c.id=l.task_id)
            WHERE l.date_execute<= '2013-04-04 20:54:21' AND l.status='Pending'
    
    ",
    'automaticSynchronizePendingDomains'        => "
    
         Query SELECT dom.id, dom.name, modu.module, dom.synch_date
            FROM hb_domains dom
            JOIN hb_modules_configuration modu ON ( dom.reg_module = modu.id )
            WHERE dom.status = 'Pending Registration' OR dom.status = 'Pending Transfer'
            AND modu.module NOT IN ('Email') AND dom.synch_date < DATE_SUB('2013-11-20 13:18:33',INTERVAL 6 HOUR) ORDER BY dom.synch_date ASC LIMIT 10
    
    ",
    'automaticTransferDomains'        => "
    
        Query   SELECT dom.tld_id, dom.id, dom.name, dom.period, dom.order_id, dom.client_id, modu.module, ord.number AS order_num
                        FROM hb_domains dom
                        JOIN hb_modules_configuration modu ON ( dom.reg_module = modu.id )
                        JOIN hb_orders ord ON ( dom.order_id = ord.id )
                        LEFT JOIN hb_invoices inv ON (ord.invoice_id = inv.id)
                    WHERE
                        dom.status='Pending'
                        AND dom.type='Transfer'
                        AND (inv.status='Paid' OR ord.invoice_id=0)
                        AND DATEDIFF('2013-12-03 22:09:40',inv.datepaid)<2
                        AND modu.module NOT IN ('Email','0')
                        AND dom.id NOT IN
                            (
                                SELECT domain_id FROM hb_domain_logs
                                    WHERE (`action` LIKE 'Transfer domain%' OR `event`='DomainTransfer')
                                    AND DATEDIFF('2013-12-03 22:09:40',`date`)<3
                            )    
    "

);


$this->assign('aTaskSQLs', $aTaskSQLs);

