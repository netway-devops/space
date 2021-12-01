<?php

class netway_reseller_controller extends HBController {

    private static  $instance;
    
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
    
    public function beforeCall ($request)
    {
        $aNotification  = isset($_SESSION['notification']) ? $_SESSION['notification'] : array();
        $this->template->assign('aNotification', $aNotification);
        
        $this->template->assign('tplPath', dirname(dirname(__FILE__)) . '/templates/');
        $this->template->assign('tplClientPath', MAINDIR . 'templates/');
    }
    
    public function _default ($request)
    {
        $db     = hbm_db();
        $api    = new ApiWrapper();
        
        $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/default.tpl',array(), true);
    }
    
    public function customtab ($request)
    {
        $db         = hbm_db();
        
        $clientId   = $request['client_id'];
        $accountId  = $request['accountId'];
        
        //$this->template->assign('aLists', $result);
        //$this->template->assign('clientId', $clientId);
        
        $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/customtab.tpl',array(), true);
    }
    
    /**
     * product นี้เปิดให้ reseller ขายได้หรือไม่
     */
    public function isEnableProductForReseller ($productId, $type)
    {
        $db         = hbm_db();
        $type       = ($type == 'DomainsType') ? 'Domain' :'Hosting';
        
        $result     = $db->query("
            SELECT *
            FROM rp_product 
            WHERE product_id = :id
                AND type = :type
                AND is_enable = 1
            ", array(
                ':id'       => $productId,
                ':type'     => $type
            ))->fetch();
        
        $isEnable   = isset($result['id']) ? true : false;
        
        return $isEnable;
    }
    
    public function enableProductForReseller ($request)
    {
        $db         = hbm_db();
        
        $productId  = isset($request['productId']) ? $request['productId'] : 0;
        $type       = isset($request['type']) ? $request['type'] : '';
        
        if (! $productId || empty($type)) {
            echo '<!-- {"ERROR":["Product ID หรือ Product Type ผิดพลาด"],"INFO":[]'
                . ',"STACK":0} -->';
            exit;
        }
        
        $result     = $db->query("
            SELECT *
            FROM rp_product 
            WHERE product_id = :id
                AND type = :type
            ", array(
                ':id'       => $productId,
                ':type'     => $type
            ))->fetch();
        
        if (! isset($result['id'])) {
            $db->query("
                INSERT INTO rp_product (
                id, `create`, `update`, product_id, type, is_enable
                ) VALUES (
                '', NOW(), NOW(), :id, :type, 0
                )
                ", array(
                    ':id'       => $productId,
                    ':type'     => $type
                ));
        }
        
        $db->query("
            UPDATE rp_product
            SET is_enable = IF(is_enable, 0,1),
                `update` = NOW()
            WHERE product_id = :id
                AND type = :type
            ", array(
                ':id'       => $productId,
                ':type'     => $type
            ));
        
        echo '<!-- {"ERROR":[],"INFO":["Update ข้อมูลเรียบร้อยแล้ว"]'
            . ',"STACK":0} -->';
        exit;
    }
    
    public function afterCall ($request)
    {
        $aAdmin     = hbm_logged_admin();
        $this->template->assign('oAdmin', (object)$aAdmin);
        
        $_SESSION['notification']   = array();
    }
    
}