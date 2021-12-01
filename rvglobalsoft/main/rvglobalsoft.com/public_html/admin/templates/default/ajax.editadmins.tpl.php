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

/* --- Widget --- */
$aWidgets    = array(
    'widgetActiveNoExpire'      => '(1) List บริการที่ active แต่ไม่มีวันหมดอายุ',
    'widgetActiveDueExpire'     => 'List บริการที่ active แต่ due-date น้อยกว่า วันหมดอายุ ยกเว้น (1)',
    //'widgetPaypalSub'			=> 'List รายการจ่ายเงิน Paypal Subscrition ที่มีปัญหา ',
    //'widgetPaypalSubSB'			=> 'List รายการจ่ายเงิน Paypal Subscrition  ของ Sitebuilder ',
    'widgetManualCCInvoiceUnpaid'   => 'List รายการ manual CC ยังไม่ process (invoice Unpaid)',
    'widgetManualCreditBalanceNotRenew'   => 'List รายการ accounts ยังไม่ renew (invoice credit balance)',
    'widgetAutomationFullPaidClientGroup'   => 'List รายชื่อ clients ที่ค้างอยู่ในกลุ่ม automation full paid client',
	'widgetRVTwoFactorTerminatedAccount'	=> 'List RV2Factor accounts ที่มีสถานะเป็น terminate และยังไม่ถูก revoke certificate',
    'widgetSSLRenewingToLong'    => 'List accounts ที่มีสถานะเป็น Renewing',
    //'widgetPaypalMissingTransaction'    => 'Paypal Transaction ที่ไม่มีบนระบบ',
    //'widgetPaypalSubLog'        => 'List Paypal Subscrition Log',
    'widgetPaypalTransaction'   => 'Paypal Transaction',
    'widgetSuspendPaypalSubscription'   => 'Suspend Paypal Subscription',
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
    'maCounterTicket'           => 'MA Time counter ticket',
);
$this->assign('aSpecials', $aSpecials);

$aStaffPrivs['Special'] = array_keys($aSpecials);

$this->assign('aStaffPrivs', $aStaffPrivs);


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

$this->assign('aExtendPrivs', $aExtendPrivs);


$result             = servicecataloghandle::singleton()->listTeam();
$this->assign('aTeam', $result);
$result             = servicecataloghandle::singleton()->getStaffTeam($aDetails['id']);
$this->assign('aStaff', $result);

/* --- extend admin field --- */
$result             = adminconfigurationhandle::singleton()->extendField($aAdmins);
$this->assign('admins', $result);

