<?php

class apihandle_controller extends HBController {
    

    /**
    * $api = new ApiWrapper();
    * $aParam     = array(
    *     'call'      => 'module',
    *     'module'    => 'apihandle',
    *     'fn'        => 'generateInvoiceByAccountId',
    *     'accountId' => $accountId,
    * );
    * $result = $api->request($aParam);
     */
    public function generateInvoiceByAccountId ($request)
    {
        $db         = hbm_db();
        
        $accountId  = isset($request['accountId']) ? $request['accountId'] : 0;

        require_once(APPDIR . 'modules/Site/invoicehandle/admin/class.invoicehandle_controller.php');
        invoicehandle_controller::singleton()->generateInvoiceByAccountId($request);
        
        $result     = $db->query("
            SELECT MAX(ii.invoice_id) AS invoiceId 
            FROM hb_invoice_items ii
            WHERE ii.item_id = :item_id
                AND ii.type = 'Hosting'
            ", array(
                ':item_id'  => $accountId,
            ))->fetch();

        $invoiceId  = isset($result['invoiceId']) ? $result['invoiceId'] : 0;

        return array(true, array(
            'success'   => true,
            'invoiceId' => $invoiceId,
        ));
    }
    

    /**
    * $api = new ApiWrapper();
    * $aParam     = array(
    *     'call'      => 'module',
    *     'module'    => 'apihandle',
    *     'fn'        => 'getLastInvoiceByAccountId',
    *     'accountId' => $accountId,
    * );
    * $result = $api->request($aParam);
     */
    public function getLastInvoiceByAccountId ($request)
    {
        $db         = hbm_db();
        
        $accountId  = isset($request['accountId']) ? $request['accountId'] : 0;

        $result     = $db->query("
            SELECT MAX(ii.invoice_id) AS invoiceId 
            FROM hb_invoice_items ii
            WHERE ii.item_id = :item_id
                AND ii.type = 'Hosting'
            ", array(
                ':item_id'  => $accountId,
            ))->fetch();

        $invoiceId  = isset($result['invoiceId']) ? $result['invoiceId'] : 0;

        return array(true, array(
            'success'   => true,
            'invoiceId' => $invoiceId,
        ));
    }
    

    /**
    * $api = new ApiWrapper();
    * $aParam     = array(
    *     'call'      => 'module',
    *     'module'    => 'apihandle',
    *     'fn'        => 'getClientIdByEmail',
    *     'email'     => $email,
    * );
    * $result = $api->request($aParam);
     */
    public function getClientIdByEmail ($request)
    {
        $db         = hbm_db();
        
        $email      = isset($request['email']) ? trim($request['email']) : '';
        
        $result     = $db->query("
            SELECT ca.*
            FROM hb_client_access ca
            WHERE ca.email = :email
            ", array(
                ':email'  => $email,
            ))->fetch();

        $clientId   = isset($result['id']) ? $result['id'] : 0;

        return array(true, array(
            'success'   => true,
            'clientId'  => $clientId,
        ));
    }
    
}
