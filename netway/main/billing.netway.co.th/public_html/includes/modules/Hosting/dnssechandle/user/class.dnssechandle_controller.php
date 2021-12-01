<?php

require_once dirname(__DIR__) . '/class.dnssechandle.php';
require_once dirname(__DIR__) . '/model/class.dnssechandle_model.php';
require_once(APPDIR . 'class.general.custom.php');
require_once(APPDIR . 'class.api.custom.php');

class dnssechandle_controller extends HBController {
    
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
        $db         = hbm_db();
        
        $this->template->render(dirname(dirname(__FILE__)) .'/templates/user/default.tpl',array(), true);
    }
    
    public function serviceRequest ($request)
    {
        $adminUrl   = GeneralCustom::singleton()->getAdminUrl();
        $apiCustom  = ApiCustom::singleton($adminUrl . '/api.php');
        $db         = hbm_db();

        $aClient    = hbm_logged_client();
        $clientId   = $aClient['id'];
        
        $domainId   = isset($request['domainId']) ? $request['domainId'] : 0;

        $aProduct   = dnssechandle_model::singleton()->getProductDNSSEC();
        $aDomain    = dnssechandle_model::singleton()->getDomainById($domainId);

        
        $intervalTime   = 0;
        if (isset($aProduct['id']) && $aProduct['id']
            && isset($aDomain['client_id']) && $aDomain['client_id'] == $clientId) {
            
            $aAccount       = dnssechandle_model::singleton()->getDSNSECAccountByDomain($aDomain['name'], $aDomain['client_id'], $aProduct['id']);
            
            if (! isset($aAccount['id'])) {

                $aParam         = array(
                    'call'      => 'addOrder',
                    'client_id' => $aDomain['client_id'],
                    'confirm'   => 0,
                    'invoice_generate'  => 0,
                    'invoice_info'      => 0,
                    'module'    => 0,
                    'product'   => $aProduct['id'],
                    'domain_name'   => $aDomain['name'],
                    'cycle'     => 'Free',
                );
                $apiCustom->request($aParam);
                
                $aAccount       = dnssechandle_model::singleton()->getDSNSECAccountByDomain($aDomain['name'], $aDomain['client_id'], $aProduct['id']);
                
                $intervalTime   = 1;
            }

            $aCategry       = dnssechandle_model::singleton()->getCategoryByProductId($aProduct['id']);
            if (isset($aCategry['slug']) && $aCategry['slug'] && isset($aAccount['id']) && $aAccount['id']) {
                if (! $intervalTime) {
                    header('location:/clientarea/services/'. $aCategry['slug'] .'/'. $aAccount['id']);
                    exit;
                }
                $this->template->assign('serviceSlug', $aCategry['slug']);
                $this->template->assign('accountId', $aAccount['id']);
            }

        }
        

        $this->template->render(dirname(dirname(__FILE__)) .'/templates/user/default.tpl',array(), true);
    }
    
    public function dnssecRequest ($request)
    {
        $adminUrl   = GeneralCustom::singleton()->getAdminUrl();
        $apiCustom  = ApiCustom::singleton($adminUrl . '/api.php');
        $db         = hbm_db();
        $aClient    = hbm_logged_client();
        $clientId   = $aClient['id'];

        $aData      = $request;

        $accountId  = isset($request['accountId']) ? $request['accountId'] : 0;
        $domain     = isset($request['domain']) ? $request['domain'] : '';
        $dnssecKeytag       = isset($request['dnssec_keytag']) ? $request['dnssec_keytag'] : '';
        $dnssecAlgorithm    = isset($request['dnssec_algorithm']) ? $request['dnssec_algorithm'] : '';
        $dnssecDigestType   = isset($request['dnssec_digest_type']) ? $request['dnssec_digest_type'] : '';
        $dnssecDigest       = isset($request['dnssec_digest']) ? $request['dnssec_digest'] : '';

        $aAccount   = dnssechandle_model::singleton()->getAccountById($accountId);
        if (! isset($aAccount['client_id'])
            || (isset($aAccount['client_id']) && ($aAccount['client_id'] != $clientId) )) {
            $this->loader->component('template/apiresponse', 'json');
            $this->json->assign('data', json_encode($aData));
            $this->json->show();
            exit;
        }

        $aDetail    = isset($aAccount['extra_details']) ? unserialize($aAccount['extra_details']) : array();
        if (! isset($aDetail['dnssec_status'])  || ($aDetail['dnssec_status'] && $aDetail['dnssec_status'] != 'none') ) {
            $this->loader->component('template/apiresponse', 'json');
            $this->json->assign('data', json_encode($aData));
            $this->json->show();
            exit;
        }

        $aDetail['dnssec_status']       = 'request';
        $aDetail['dnssec_keytag']       = $dnssecKeytag;
        $aDetail['dnssec_algorithm']    = $dnssecAlgorithm;
        $aDetail['dnssec_digest_type']  = $dnssecDigestType;
        $aDetail['dnssec_digest']       = $dnssecDigest;
        dnssechandle_model::singleton()->updateAccountExtraDetail($accountId, $aDetail);

        $aData      = $aDetail;

        $aParam         = array(
            'call'      => 'module',
            'module'    => 'dnssechandle',
            'fn'        => 'sendRequest',
            'accountId' => $accountId
        );
        $apiCustom->request($aParam);
        
        $this->loader->component('template/apiresponse', 'json');
        $this->json->assign('data', json_encode($aData));
        $this->json->show();
    }
    
    public function afterCall ($request)
    {
        $_SESSION['notification']   = array();
    }    

}