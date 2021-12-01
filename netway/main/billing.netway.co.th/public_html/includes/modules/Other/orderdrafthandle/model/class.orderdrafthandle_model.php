<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}

class orderdrafthandle_model {

    private static  $instance;
    private $db;
     
    public static function singleton ()
    {
        if (!isset(self::$instance)) {
            $c = __CLASS__;
            self::$instance = new $c();
        }

        return self::$instance;
    }
    
    public function __clone ()
    {
        trigger_error('Clone is not allowed.', E_USER_ERROR);
    }
    
    private function __construct () 
    {
        $this->db       = hbm_db();
        
    }
    
    public function getOrderDraftById ($orderDraftId)
    {

        $result     = $this->db->query("
            SELECT *
            FROM hb_order_drafts
            WHERE id = '{$orderDraftId}'
            ")->fetch();
        
        return $result;
    }
    
    public function updateDealByOrderDraftId ($orderDraftId, $aData)
    {
        $this->db->query("
            UPDATE hb_order_drafts
            SET clickup_task_id = :clickup_task_id
            WHERE id = '{$orderDraftId}'
            ", array(
                ':clickup_task_id' => $aData['clickup_task_id']
            ));
        
    }
    
}
