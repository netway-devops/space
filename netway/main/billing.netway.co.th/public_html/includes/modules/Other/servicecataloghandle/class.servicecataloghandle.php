<?php

class servicecataloghandle extends OtherModule {
    
    protected $modname      = 'Service Catalog Management';
    protected $description  = '***NETWAY*** กระบวนการที่ช่วยจัดการข้อมูลของงานบริการที่เปิดให้บริการอยู่ทั้งหมดให้ถูกต้อง และเป็นปัจจุบัน';

    protected $info         = array(
        'support_menu'      => true
        );
    
    //react on event: before_displayuserfooter
    public function before_displayadminheader($details) {
        //$script_location    = '../includes/modules/Other/servicecataloghandle/templates/js/script.js';
        //this will be rendered in adminarea head tag:
        //echo '<script type="text/javascript" src="'.$script_location.'"></script>';
    }
    
    
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
    
    
    /**
     * ดึงรายชื่อทีม
     */
    public function listTeam ()
    {
        $db             = hbm_db();
        
        $result         = $db->query("
                SELECT t.*
                FROM sc_team t
                ORDER BY t.name ASC
                ")->fetchAll();
        
        $aTeam          = array();
        
        if (! count($result)) {
            return $aTeam;
        }
        
        foreach ($result as $arr) {
            $aTeam[$arr['id']]  = $arr['name'];
        }
        
        return $aTeam;
    }
    
    /**
     * รายชื่อทีม
     */
    public function getStaffTeam ($staffId)
    {
        $db             = hbm_db();
        
        $result         = $db->query("
                SELECT
                    tm.*
                FROM
                    sc_team_member tm
                WHERE
                    tm.staff_id = :staffId
                ", array(
                    ':staffId'      => $staffId
                ))->fetch();
        
        if (isset($result['escalation_policy_1'])) {
            $policy1        = $result['escalation_policy_1'];
            preg_match('/\s\[\[([^\]]*)\]\]\s/', $policy1, $match);
            $result['policy_1_21']  = isset($match[1]) ? $match[1] : '';
            preg_match('/\s\[\[\[([^\]]*)\]\]\]/', $policy1, $match);
            $result['policy_1_22']  = isset($match[1]) ? $match[1] : '';
            preg_match('/\s\{\{([^\}]*)\}\}\s/', $policy1, $match);
            $result['policy_1_31']  = isset($match[1]) ? $match[1] : '';
            preg_match('/\s\{\{\{([^\}]*)\}\}\}/', $policy1, $match);
            $result['policy_1_32']  = isset($match[1]) ? $match[1] : '';
            
        }
        
        return $result;
    }
    
    
}
