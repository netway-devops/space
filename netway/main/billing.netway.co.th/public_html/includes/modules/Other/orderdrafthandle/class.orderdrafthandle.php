<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}

class orderdrafthandle extends OtherModule implements Observer {
    
    protected $modname      = 'Order draft handle';
    protected $description  = '***NETWAY***
    <br />
    - เพิ่ม deal inputbox ให้ staff ระบุใน order draft ได้ <br />
    ';
    
    public $configuration    = array(
        'EXTEND_INPUT_NAME'      => array(
            'value'     => 'override_recipients',
            'type'      => 'input',
            'description'   => 'ชื่อ html input name ที่ต้องการแทรก Clickup task (deal) บริเวณใหน $("input[name=EXTEND_INPUT_NAME]")'
        ),
    );
    
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

    public function install ()
    {
        $this->db->exec("
            # ALTER TABLE `hb_order_drafts` ADD `clickup_task_id` VARCHAR(32) NOT NULL COMMENT 'Netway ถ้ามี desal ไม่ต้องไปสร้างใหม่ที่ Clickup' 
            ");
        
        return true;
    }

    public function before_displayadminheader ($details)
    {
        $aConfig    = $this->configuration;
        
        $script     = '/includes/modules/Other/orderdrafthandle/templates/js/script.js?varsion=1';
        foreach ($aConfig as $k => $arr) {
            $script     .= '&'. $k .'='. rawurlencode($arr['value']);
        }

        echo '<script type="text/javascript" src="'. $script .'"></script>';
    }
    
}

