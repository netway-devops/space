<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}

class adminhandle_model {

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
    
    public function listActive () 
    {
        $result         = $this->db->query("
            SELECT ad.*
            FROM hb_admin_access a,
                hb_admin_details ad
            WHERE a.status = 'Active'
                AND a.id = ad.id
            ")->fetchAll();
        
        $result         = count($result) ? $result : array();
        
        return $result;
    }
    
    public function listActiveWithTeam ($team = array()) 
    {
        $result         = $this->db->query("
            SELECT ad.*
            FROM hb_admin_access a,
                hb_admin_details ad,
                sc_team_member tm,
                sc_team t
            WHERE a.status = 'Active'
                AND a.id = ad.id
                AND a.id = tm.staff_id
                AND tm.team_id = t.id
                ". (count($team) ? " AND t.name IN ('". implode("','", $team) ."') " : " ") ."
            ORDER BY t.name DESC, ad.email ASC
            ")->fetchAll();
        
        $result         = count($result) ? $result : array();
        
        return $result;
    }

    
}
