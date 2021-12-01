<?php

require_once(APPDIR . 'class.config.custom.php');
require_once(APPDIR . 'modules/Other/internalcontrolhandle/model/class.internalcontrolhandle_model.php');
require_once(APPDIR . 'modules/Other/internalcontrolhandle/library/class.internalcontrolhandle_library.php');

class internalcontrolhandle_controller extends HBController {
    /* 
     * Under $this->module HostBill will load your module
     * in this case it will be Example 
    */
    public $module;
    
    /**
     * 
     * @return string
     */
    public function call_EveryRun()
    {
        $db             = hbm_db();
        
        $message        = '';
        $message       .= $this->_analyzeErrorLog();
        
        # echo '<pre>'. print_r($aConfig, true) .'</pre>';
        
        return $message;
    }
    
    private function _analyzeErrorLog ()
    {
        $db             = hbm_db();
        $aConfig        = $this->module->configuration;
        
        $aEmail         = array();
        $arr            = explode(',',$aConfig['DEV_EMAIL']['value']);
        foreach ($arr as $email) {
            $email      = trim($email);
            array_push($aEmail, $email);
        }
        
        $message        = '';
        
        $hbCurrentErrorLogDate     = ConfigCustom::singleton()->getValue('hbCurrentErrorLogDate');
        
        $result         = internalcontrolhandle_model::singleton()->getNextError($hbCurrentErrorLogDate, 1);
        
        foreach ($result as $arr) {
            $errorId    = $arr['id'];
            $hbCurrentErrorLogDate  = $arr['date'];
            $email      = isset($arr['admin_email']) ? $arr['admin_email'] : '';
            
            if (! in_array($email, $aEmail)) {
                $subject    = $arr['id'] .' '. $arr['date'] .' '. $arr['type'];
                $body       = $arr['entry'];
                $aBpdy      = explode("\n", $body);
                $subject    = isset($aBpdy[0]) ? substr($aBpdy[0], 0, 200) : $subject;
                
                $aParam     = array(
                    'brand_id'          => $aConfig['ZENDESK_BRAND_ID']['value'],
                    'ticket_form_id'    => $aConfig['ZENDESK_FORM_ID']['value'],
                    'tags'          => array('internal_control', 'hostbill_error'),
                    'custom_fields' => array(
                        array('id' => 360021685791, 'value' => $aConfig['FROM_DOMAIN']['value']),
                        array('id' => 360021769131, 'value' => ($email ? $email : '')),
                    ),
                    'subject'   => $subject,
                    'comment'   => array(
                        'body'  => $body
                    ),
                );
                
                internalcontrolhandle_library::singleton($aConfig)->createTicket($aParam);
            }
            
            internalcontrolhandle_model::singleton()->deleteError($hbCurrentErrorLogDate);
        }
        
        ConfigCustom::singleton()->setValue('hbCurrentErrorLogDate', $hbCurrentErrorLogDate);
        
        return $message;
    }
    
    
    
}


