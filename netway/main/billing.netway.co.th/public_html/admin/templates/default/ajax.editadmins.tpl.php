<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}

require_once(APPDIR . 'modules/Other/servicecataloghandle/class.servicecataloghandle.php');
require_once(APPDIR . 'modules/Other/adminconfigurationhandle/class.adminconfigurationhandle.php');

// --- hostbill helper ---
$api        = new ApiWrapper();
$db         = hbm_db();
// --- hostbill helper ---

// --- Get template variable ---
$aStaffPrivs    = $this->get_template_vars('staff_privs');
$aDetails       = $this->get_template_vars('details');
$aAdmins        = $this->get_template_vars('admins');
// --- Get template variable ---

/*
$aCategories     = $db->query("
                    SELECT c.id, c.name
                    FROM hb_categories c
                    WHERE 1
                    ORDER BY c.name ASC
                    ")->fetchAll();

$dsTitle        = 'Domain/Service Provisioning <span style="font-size:.8em;color:red;">(กำหนดว่าเจ้าหน้าที่เข้าถึง command กลุ่ม product ใหนได้บ้าง ไม่เกี่ยวกับ auto provisioning)</span>';
$aStaffPrivs[$dsTitle]  = array();
if (count($aCategories)) {
    foreach ($aCategories as $aCategory) {
        array_push($aStaffPrivs[$dsTitle], 'provision' . $aCategory['id']);
    }
}

$aCategory      = $aCategories;
$aCategories    = array();
if (count($aCategory)) {
    foreach ($aCategory as $arr) {
        $aCategories['provision' . $arr['id']]  = $arr['name'];
    }
}

$this->assign('aCategories', $aCategories);
*/

/* --- Widget --- */
$aWidgets    = array(
    'widgetActiveNoExpire'      => '(1) List บริการที่ active แต่ไม่มีวันหมดอายุ',
    'widgetActiveDueExpire'     => 'List บริการที่ active แต่ due-date น้อยกว่า วันหมดอายุ ยกเว้น (1)',
    'widgetInvoicePaidServiceNotActive'     => 'List invoice ที่จ่ายเงินมาแล้ว 1 สัปดาห์ แต่ยังไม่ได้เปิดให้บริการ',
    'widgetInvoiceUnpaidServiceActive'      => 'List invoice ที่ยังไม่จายเงิน แต่เปิดให้บริการไปแล้วเกิน 6 สัปดาห์',
    'widgetPaypalSub'			=> 'List รายการจ่ายเงิน Paypal Subscrition ที่มีปัญหา ',
    'widgetManualCCInvoiceUnpaid'   => 'List รายการ manual CC ยังไม่ process (invoice Unpaid)',
    'widgetManualDuedateError'   => 'List รายการ account ที่วันหมดอายุและวัน duedate มีข้อผิดพลาด' ,
    'widgetNewCreditLog'   => 'จำนวนรายการ credit log ที่เกิดขึ้นใหม่',
    'widgetListDomainOverNextInvoice'   => 'รายการ domain ที่ถึงวัน geninvoice แต่ไม่มี invoice ออกมา' ,
    'widgetListRecurringError'  => 'List รายการเปลี่ยน billing cycle แล้วไม่ update recurring price' ,
    'widgetListDueIn30Days'  => 'Invoice ที่จะครบกำหนดชำระเงินภายใน 30 วัน' ,
    'widgetListSSLShouldTerminate'  => 'SSL ที่เลย due มา 30 วันควร terminate',
    'widgetListInvoiceContractDateYesterday'  => 'Invoice ที่เริ่มต้นสัญญาเมื่อวาน',
    'widgetListInvoiceUnpaidContractToday'  => 'Invoice ที่ยัง Unpaid แต่เริ่มสัญญาวันนี้'
);

$this->assign('aWidgets', $aWidgets);

$aStaffPrivs['Widget'] = array_keys($aWidgets);

/* --- Menu --- */
$aMenus     = array(
    'menuCustomerfields'        => 'customerfields',
    'menuAdministrators'        => 'Administrators',
    'menuBankStatement'         => 'Bank Statement',
    'menuGeneralconfig'         => 'generalconfig',
    'menuPlugins'               => 'Plugins',
    'menuModules'               => 'Modules',
    'menuProductsandservices'   => 'productsandservices',
    'menuProductaddons'         => 'productaddons',
    'menuEmailtemplates'        => 'emailtemplates',
    'menuSecuritysettings'      => 'securitysettings',
    'menuManapps'               => 'manapps',
);

$this->assign('aMenus', $aMenus);

$aStaffPrivs['Menu'] = array_keys($aMenus);

/* --- Special function --- */
$aSpecials  = array(
    'specialEdittaxnumber'      => 'Edit tax number',
    'deleteSupportTicket'       => 'Delete support ticket',
    'closeSupportTicket'        => 'Close support ticket',
);
$this->assign('aSpecials', $aSpecials);

$aStaffPrivs['Special'] = array_keys($aSpecials);

$this->assign('staff_privs', $aStaffPrivs);


/**
(
[0] => viewInvoices
[1] => deleteInvoices
[2] => viewEstimates
[3] => deleteEstimates
[4] => viewTransactions
[5] => deleteTransactions
[6] => viewOrders
[7] => deleteOrders
[8] => viewAccounts
[9] => deleteServices
[10] => listClients
[11] => deleteClients
[12] => viewCC
[13] => editCC
)
 */


$aExtendPrivs    = array(
    'Billing'       => array(
        'viewInvoices'          => array(
            'editInvoices'      => 'Edit Invoices',
        ),
        'viewEstimates'         => array(
            'editEstimates'     => 'Edit Estimates',
        ),
        'viewTransactions'      => array(
            'editTransactions'  => 'Edit Transactions',
        ),
        'viewOrders'            => array(
            'editOrders'        => 'Edit Orders',
        ),
        'viewAccounts'          => array(
            'editAccounts'      => 'Edit Accounts',
        ),
        'listClients'           => array(
            'editClients'       => 'Edit Clients',
        ),
    ),
);
$aExtendPrivs   = array();

$this->assign('aExtendPrivs', $aExtendPrivs);


$result             = servicecataloghandle::singleton()->listTeam();
$this->assign('aTeam', $result);
$result             = servicecataloghandle::singleton()->getStaffTeam($aDetails['id']);
$this->assign('aStaff', $result);

/* --- extend admin field --- */
$result             = adminconfigurationhandle::singleton()->extendField($aAdmins);
$this->assign('admins', $result);

