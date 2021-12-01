<?php

class widget_dnssec_request extends HostingWidget {
 
    protected $description = 'DNSSEC Request for SRSPlus';
    protected $widgetfullname = 'DNSSEC Request';
 
    public function clientFunction (&$module)
    {
        $reflectionObject = new ReflectionObject($module);
        $property   = $reflectionObject->getProperty('account_details');
        $property->setAccessible(true);
        $aAccount   = $property->getValue($module); 

        $accountId  = isset($aAccount['id']) ? $aAccount['id'] : 0;
        $data['accountId']  = $accountId;
        $domain     = isset($aAccount['domain']) ? $aAccount['domain'] : '';
        $data['domain']     = $domain;
        $aCustomField   = isset($aAccount['extra_details']) ? $aAccount['extra_details'] : array();
        $data['aCustomField']   = $aCustomField;
        

        //echo '<pre>'. print_r($aAccount, true) .'</pre>';
 
        return array('dnssec.tpl', $data);
    }

}