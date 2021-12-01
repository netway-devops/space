<?php

class adminconfigurationhandle extends OtherModule {
    
    protected $modname      = 'Admin Extend Configuration';
    protected $description  = 'เพิ่มส่วนจัดการข้อมูล Staff เช่น update custom field';
    
    public $configuration    = array();
    
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
    
    public function extendField ($aAdmins, $order = '')
    {
        $db             = hbm_db();
        
        $result         = $db->query("
                SELECT af.variable, afv.*
                FROM hb_admin_fields_values afv,
                    hb_admin_fields af
                WHERE afv.field_id = af.id
                ")->fetchAll();
        
        if (! count($result)) {
            return $aAdmins;
        }
        
        $aStaff         = array();
        foreach ($result as $arr) {
            $id             = $arr['admin_id'];
            $aStaff[$id]    = $arr;
        }
        
        $aOrder         = array();
        for ($i = 0; $i < count($aAdmins); $i++) {
            $id             = $aAdmins[$i]['id'];
            $aOrder[$id]    = $i;
            if (! isset($aStaff[$id])) {
                continue;
            }
            
            if ($aStaff[$id]['variable'] == 'profile_picture_url') {
                $aAdmins[$i]['profile_picture_url']    = $aStaff[$id]['value'];
            }
            
        }
        
        if ($order) {
            $result         = $db->query("
                    SELECT aa.id
                    FROM hb_admin_access aa,
                        hb_admin_details ad
                    WHERE aa.id = ad.id
                    ORDER BY aa.username ASC
                    ")->fetchAll();
            
            if (count($result)) {
                $aAdmins_       = array();
                foreach ($result as $arr) {
                    $id     = $arr['id'];
                    $idx    = $aOrder[$id];
                    if (! isset($aAdmins[$idx])) {
                        continue;
                    }
                    array_push($aAdmins_, $aAdmins[$idx]);
                }
                $aAdmins    = $aAdmins_;
            }
            
        }
        
        return $aAdmins;
    }
    
}
