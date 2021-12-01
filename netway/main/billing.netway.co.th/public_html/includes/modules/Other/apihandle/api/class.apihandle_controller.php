<?php

require_once(APPDIR_MODULES . 'Other/apihandle/model/class.apihandle_model.php');

class apihandle_controller extends HBController {
    

    /**
    * $api = new ApiWrapper();
    * $aParam     = array(
    *     'call'      => 'module',
    *     'module'    => 'apihandle',
    *     'fn'        => 'addInvoiceNote',
    *     'invoiceId' => $invoiceId,
    * );
    * $result = $api->request($aParam);
     */
    public function addInvoiceNote ($request)//ใช้บน power automate (สำหรับ Add Admin Note)
    {
        $db         = hbm_db();
        
        $invoiceId  = isset($request['invoiceId']) ? $request['invoiceId'] : 0;
        $note       = isset($request['note']) ? $request['note'] : '';
        $deal_id    = isset($request['dealId']) ? $request['dealId'] :'';

        $aData      = array(
            'note'  => $note,
            'dealId' => $deal_id
        );
        $result     = apihandle_model::singleton()->addInvoiceNote($invoiceId, $aData);

        return array(true, array(
            'success'   => true,
            'invoiceId' => $invoiceId,
            'request' => $request,
        ));
    }
    public function updateDealtoInvoice ($request)//update deal after Invoice cearte
    {
        $db         = hbm_db();

        $invoiceId  = isset($request['invoiceId']) ? $request['invoiceId'] : 0;
        $deal_id    = isset($request['dealId']) ? $request['dealId'] :'';

        $result     = apihandle_model::singleton()->updateDealtoInvoice($invoiceId, $deal_id);

        return array(true, array(
            'success'   => true,
            'invoiceId' => $invoiceId,
            'request' => $request,
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
        
        $result     = apihandle_model::singleton()->getClientAccessByEmail($email);

        $clientId   = isset($result['id']) ? $result['id'] : 0;

        return array(true, array(
            'success'   => true,
            'clientId'  => $clientId,
        ));
    }
    
    public function getOrdraftByEstimateId ($request)
    {
        $db         = hbm_db();
        $estimateId = isset($request['estimateId']) ? trim($request['estimateId']) : 0;
        
        $result     = apihandle_model::singleton()->getOrderDraftIdByEstimateId($estimateId);
       
        $orderDraftId   = isset($result['id']) ? $result['id'] : 0;
        $clickupTaskId  = isset($result['clickup_task_id']) ? $result['clickup_task_id'] : "";
    
    
        return array(true, array(
            'success'   => true,
            'orderDraftId'  => $orderDraftId,
            'clickupTaskId' => $clickupTaskId
        ));
    }

    public function addEsitmateDeal ($request)
    {
        $db         = hbm_db();
        $estimateId = isset($request['estimateId']) ? trim($request['estimateId']) : 0;
        $dealId = isset($request['dealId']) ? trim($request['dealId']) : 0;
        
        $aData      = array(
            'estimateId'  => $estimateId,
            'dealId'      => $dealId
        );
        
    
        $result     = apihandle_model::singleton()->updateDealIdByEstimateId($aData);

    
        return array(true, array(
            'success'    => true,
            'estimateId' => $estimateId,
            'request'    => $request,
        ));
    }

    public function getDealByinvoiceId ($request)
    {
        $db         = hbm_db();
        
        $invoiceId  = isset($request['invoiceId']) ? $request['invoiceId'] : 0;

        $result     = apihandle_model::singleton()->getEstimateDetail($invoiceId);

        $status     = isset($result['status']) ? $result['status'] : '';
        $invoiceId  = isset($result['invoice_id']) ? $result['invoice_id'] : 0;
        $dealId     = isset($result['deal_id']) ? $result['deal_id'] : '';

        return array(true, array(
            'success'   => true,
            'status'    => $status,
            'invoiceId' =>$invoiceId,
            'dealId'    => $dealId
             
        ));
    }



  
}
