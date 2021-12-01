<?php
/*
require_once(APPDIR .'class.cache.extend.php');
require_once(APPDIR . 'modules/Other/billingcycle/api/class.billingcycle_controller.php');
*/
class accounthandle_controller extends HBController {
    
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
        $db             = hbm_db();
        
        $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/default.tpl',array(), true);
    }
    
    public function manageConfig2Account ($accountId)
    {
        $db             = hbm_db();
        
        return self::_removeEmptyDedicatedIP($accountId);
        
    }
    
    private function _removeEmptyDedicatedIP ($accountId)
    {
        $db             = hbm_db();
        
        // CASE 1
        $result         = $db->query("
                SELECT c2a.*
                FROM hb_config2accounts c2a,
                    hb_config_items_cat cic
                WHERE c2a.account_id = :accountId
                    AND c2a.rel_type = 'Hosting'
                    AND c2a.config_cat = cic.id
                    AND cic.variable = 'ip'
                    AND c2a.config_id = '0'
                    AND cic.type = 1
                ", array(
                    ':accountId'    => $accountId
                ))->fetch();
        
        if (isset($result['account_id'])) {
            $configCatId    = $result['config_cat'];
            
            $db->query("
                DELETE FROM hb_config2accounts 
                WHERE rel_type = 'Hosting'
                    AND account_id = :accountId
                    AND config_id = 0
                    AND config_cat = :configCatId
                LIMIT 1
                ", array(
                    ':accountId'    => $accountId,
                    ':configCatId'  => $configCatId,
                ));
            
            return true;
        }
        
        // CASE 2
        $result         = $db->query("
                SELECT c2a.*
                FROM hb_config2accounts c2a,
                    hb_config_items ci,
                    hb_config_items_cat cic
                WHERE c2a.account_id = :accountId
                    AND c2a.rel_type = 'Hosting'
                    AND c2a.config_id = ci.id
                    AND c2a.config_cat = cic.id
                    AND cic.variable = 'ip'
                    AND ci.name = '0'
                ", array(
                    ':accountId'    => $accountId
                ))->fetch();
        
        if (! isset($result['account_id'])) {
            return false;
        }
        
        $configId       = $result['config_id'];
        $configCatId    = $result['config_cat'];
        
        // --- Fixbug ถ้าไมไ่ด้เลือก Dedicated IP ไม่ต้องให้แสดงใน invoice ต้องลย record นั้นออกเลย ---
        $db->query("
            DELETE FROM hb_config2accounts 
            WHERE rel_type = 'Hosting'
                AND account_id = :accountId
                AND config_id = :configId
                AND config_cat = :configCatId
            LIMIT 1
            ", array(
                ':accountId'    => $accountId,
                ':configId'     => $configId,
                ':configCatId'  => $configCatId,
            ));
        
        return true;
    }
    
    public function afterCall ($request)
    {
        $aAdmin         = hbm_logged_admin();
        $this->template->assign('oAdmin', (object)$aAdmin);
        
        $_SESSION['notification']   = array();
    }
}