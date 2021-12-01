<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}

require_once(APPDIR . 'modules/Site/invoicehandle/model/class.invoicehandle_model.php');

class invoicehandle_controller extends HBController {
    
    private static  $instance;
    
    public static function singleton ()
    {
        if (!isset(self::$instance)) {
            $c = __CLASS__;
            self::$instance = new $c();
        }

        return self::$instance;
    }
    
    public function beforeCall ($request)
    {
        $this->_beforeRender();
    }
    
    public function _default ($request)
    {
        $db     = hbm_db();

    }
    
    public function addItemManual ($request)
    {
        $db     = hbm_db();
        
        // --- Custom helper ---
        require_once(APPDIR . 'class.api.custom.php');
        require_once(APPDIR . 'class.general.custom.php');
        $adminUrl   = GeneralCustom::singleton()->getAdminUrl();
        $apiCustom  = ApiCustom::singleton($adminUrl.'/api.php');
        // --- Custom helper ---
        
        $invoiceId  = isset($request['invoiceId']) ? $request['invoiceId'] : 0;
        $aItem      = isset($request['item']['n']) ? $request['item']['n'] : array();
        
        $result     = 0;
        
        if ($invoiceId) {
            
            $aParam         = array(
                'call'      => 'addInvoiceItem',
                'id'        => $invoiceId,
                'line'      => (isset($aItem['description']) ? $aItem['description'] : '-'),
                'price'     => (isset($aItem['amount']) ? $aItem['amount'] : 0),
                'qty'      => (isset($aItem['qty']) ? $aItem['qty'] : 0),
                'tax'      => (isset($aItem['taxed']) ? $aItem['taxed'] : 0)
            );
            $result         = $apiCustom->request($aParam);
            
        }
        
        
        $this->loader->component('template/apiresponse', 'json');
        $this->json->assign('data', $result);
        $this->json->show();
    }
    
    public function setPayToNetway ($request)
    {
        $db     = hbm_db();

        $invoiceId  = isset($request['invoiceId']) ? $request['invoiceId'] : 0;

        invoicehandle_model::singleton()->setIsPayToNetway($invoiceId);
        $result     = array();

        $this->loader->component('template/apiresponse', 'json');
        $this->json->assign('data', $result);
        $this->json->show();
    }

    public function addtaxinvoice ($request)
    {
        $db     = hbm_db();
        
        $invoiceId  = isset($request['id']) ? $request['id'] : 0;
        if (! $invoiceId) {
            return false;
        }
        
        require_once(APPDIR . 'class.config.custom.php');
        $nwTaxNumber    = ConfigCustom::singleton()->getValue('nwTaxNumber');
        $invoiceNumber  = self::buildTaxNumberFormat($nwTaxNumber);
        
        $db->query("
            UPDATE hb_invoices
            SET invoice_number = :invoiceNumber
            WHERE 
                id = :invoiceId
                AND invoice_number = ''
            LIMIT 1
        ", array(
            ':invoiceNumber'    => $invoiceNumber,
            ':invoiceId'        => $invoiceId,
        ));
        
        echo '<!-- {"ERROR":[],"INFO":["Added invoice number:'. $invoiceNumber .' to invoice:'. $invoiceId .'"]'
            . ',"HTML":"'. $invoiceNumber .'"'
            . ',"STACK":0} -->';
            
        exit;
    }
    
    public function updatetaxinvoice ($request)
    {
        $db     = hbm_db();
        
        $invoiceId      = isset($request['invoiceId']) ? $request['invoiceId'] : 0;
        $invoiceNumber  = isset($request['invoiceNumber']) ? $request['invoiceNumber'] : 0;
        if (! $invoiceId) {
            return false;
        }
        
        $db->query("
            UPDATE hb_invoices
            SET invoice_number = :invoiceNumber
            WHERE 
                id = :invoiceId
            LIMIT 1
        ", array(
            ':invoiceNumber'    => $invoiceNumber,
            ':invoiceId'        => $invoiceId,
        ));
        
        echo '<!-- {"ERROR":[]'
            . ',"INFO":["Update invoice number:'. $invoiceNumber .' to invoice:'. $invoiceId .'"]'
            . ',"STACK":0} -->';
        exit;
    }
    
    /*
     * [TODO] function นี้ถูก access จากที่อื่นแบบ เรียก function โดยตรง ระวังเรื่อง this
     * /includes/extend/hooks/after_invoicefullpaid_01.php
     */
    public function buildTaxNumberFormat ($id)
    {
        $db     = hbm_db();
        
        $invoiceNumber  = 'HN' . substr(date('Y'),-2) . date('m') .'-'. sprintf('%04s', $id);
        
        $nextTaxNumber  = $id + 1;
        
        $db->query("
            UPDATE hb_configuration
            SET value = :nextTaxNumber
            WHERE 
                setting = 'nwTaxNumber'
            LIMIT 1
        ", array(
            ':nextTaxNumber'  => $nextTaxNumber
        ));
        
        return $invoiceNumber;
    }
    
    public function updateInvoiceItemPriceProrate ($invoiceId)
    {
        $db         = hbm_db();
        $aAdmin     = hbm_logged_admin();
        
        $result     = invoicehandle_model::singleton()->getItemAccountByInvoiceId($invoiceId);
        
        if (! count($result)) {
            return true;
        }
        
        $aItems     = $result;
        
        foreach ($aItems as $aItem) {
            $itemId         = $aItem['id'];
            $productId      = $aItem['product_id'];
            
            
        }
        
        
    }
    
    public function checkPayToNetway ($invoiceId)
    {
        $db         = hbm_db();
        $aAdmin     = hbm_logged_admin();
        
        $result     = invoicehandle_model::singleton()->getByIdWithPayment($invoiceId);
        
        if (! isset($result['id'])) {
            return false;
        }
        
        $isNetway   = 0;

        $aConfig    = isset($result['mc_config']) ? unserialize($result['mc_config']) : array();
        if (isset($aConfig['business']['value'])) {
            $email      = $aConfig['business']['value'];
            if ($email == 'payment@rvglobalsoft.com') {
                $isNetway   = 1;
            }
        }

        if (isset($aConfig['IS_NETWAY_MERCHANT']['value'])) {
            if ($aConfig['IS_NETWAY_MERCHANT']['value']) {
                $isNetway   = 1;
            }
        }

        
        if (! $isNetway) {
            return false;
        }

        invoicehandle_model::singleton()->setIsPayToNetway($invoiceId);

        return true;
    }

    public function addFreeTrial ($request)
    {
        return true;
        
        $db         = hbm_db();
        $aAdmin     = hbm_logged_admin();
        $api        = new ApiWrapper();

        $invoiceId  = isset($request['invoiceId']) ? $request['invoiceId'] : 0;

        $aItems     = invoicehandle_model::singleton()->getItemWithTrialAccountByInvoiceId($invoiceId);

        foreach ($aItems as $aItem) {
            $itemId     = $aItem['id'];
            $accountId  = $aItem['item_id'];
            $nextDue        = $aItem['next_due'];
            $bextInvoice    = $aItem['next_invoice'];
            $desc       = $aItem['description'];
            preg_match('/\((\d{2}\/\d{2}\/\d{4})\s+\-\s+(\d{2}\/\d{2}\/\d{4})\)/i', $desc, $match);
            
            if (isset($match[1]) && isset($match[2])) {
                $startDate  = $match[1];
                $date   = $startDate;
                $date   = substr($date,-4) .'-'. substr($date,3,2) .'-'. substr($date,0,2);
                $startDateNew   = date('d/m/Y', strtotime('+30 day', strtotime($date)));
                $endDate    = $match[2];
                $date   = $endDate;
                $date   = substr($date,-4) .'-'. substr($date,3,2) .'-'. substr($date,0,2);
                $endDateNew     = date('d/m/Y', strtotime('+30 day', strtotime($date)));
                $desc   = str_replace($startDate, $startDateNew, $desc);
                $desc   = str_replace($endDate, $endDateNew, $desc);
                if (! preg_match('/trial/', $desc)) {
                    $desc   .= "\n".'+ Free trial 30 Days.';

                    $aData  = array(
                        'id'    => $itemId,
                        'description'   => $desc,
                    );
                    invoicehandle_model::singleton()->updateItemDescIncludeTrial($aData);

                }
            }

        }

        return true;
    }

    public function extendDeveloperLicenseTrialAccount ($request)
    {
        $db         = hbm_db();
        $api        = new ApiWrapper();
        $accountId  = isset($request['accountId']) ? $request['accountId'] : 0;

        $aAccount   = invoicehandle_model::singleton()->getAccountById($accountId);

        if (! isset($aAccount['product_id']) || $aAccount['product_id'] != 170) {
            return true;
        }

        $nextDue    = $aAccount['expiry_date'];

        $aData  = array(
            'id'        => $accountId,
            'next_due'  => $nextDue,
        );
        $api->editAccountDetails($aData);
    }

    public function extendDeveloperLicenseByInvoice ($request)
    {
        $db         = hbm_db();
        $api        = new ApiWrapper();
        $invoiceId  = isset($request['id']) ? $request['id'] : 0;
        $aItems     = isset($request['items']) ? $request['items'] : array();

        if (! count($aItems)) {
            return false;
        }

        foreach ($aItems as $aItem) {
            $accountId  = 0;
            $type       = isset($aItem['type']) ? $aItem['type'] : '';
            $itemId     = isset($aItem['item_id']) ? $aItem['item_id'] : 0;

            if ($type == 'Hosting') {
                $accountId  = $itemId;
            }

            if (! $accountId) {
                continue;
            }

            $aAccount   = invoicehandle_model::singleton()->getAccountById($accountId);

            if (! isset($aAccount['product_id']) || ! ( $aAccount['product_id'] == 161 || $aAccount['product_id'] == 162)) {
                continue;
            }

            $expire     = $aAccount['expiry_date'];
            $status     = 'Active';

            $result     = $db->query("
                SELECT i.id, i.duedate
                FROM hb_invoice_items ii,
                    hb_invoices i
                WHERE ii.type = 'Hosting'
                    AND ii.item_id = '{$accountId}'
                    AND ii.invoice_id = i.id
                    AND i.status = 'Paid'
                ORDER BY i.duedate DESC
                LIMIT 1
                ")->fetch();
    
            if (isset($result['id'])) {
                $expire     = date('Y-m-d', strtotime('+1 year', strtotime($result['duedate'])));
            }

            $db->query("
            UPDATE hb_accounts 
            SET expiry_date = :expiry_date
            WHERE id = :id
            ", array(
                ':expiry_date'  => $expire,
                ':id'   => $accountId,
            ));

            $db->query("
                UPDATE
                    rvsitebuilder_developer_license
                SET
                    active = 1,
                    expire = :expire,
                    status = :status
                WHERE
                    hb_acc = :hb_acc
                ", array(
                    ':hb_acc' => $accountId,
                    ':expire' => $expire,
                    ':status' => $status
            ));
            
        }
    }

    public function generateInvoiceByAccountId ($request)
    {
        $db         = hbm_db();
        
        $accountId  = isset($request['accountId']) ? $request['accountId'] : 0;

        require_once(APPDIR . 'class.api.custom.php');
        require_once(APPDIR . 'class.general.custom.php');
        GeneralCustom::singleton()->adminUIActionRequest('?cmd=accounts&account_id='. $accountId .'&action=generateinvoice&account[]='. $accountId .'');

        return true;
    }
    
    private function _beforeRender ()
    {
        $this->template->assign('tplPath', dirname(dirname(__FILE__)) . '/templates/');
        $this->template->assign('tplClientPath', MAINDIR . 'templates/');
    }
    
    public function afterCall ($request)
    {
        
    }
}