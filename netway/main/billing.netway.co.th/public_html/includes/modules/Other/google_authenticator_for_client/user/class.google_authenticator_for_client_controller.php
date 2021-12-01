<?php

require_once APPDIR_MODULES . 'Other/google_authenticator/lib/class.googleauthenticator.php';

class google_authenticator_for_client_controller extends HBController {
    
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
    
    public function isActive ()
    {
        $db         = hbm_db();
        
        $result     = $db->query("
            SELECT id
            FROM hb_modules_configuration
            WHERE filename = 'class.google_authenticator_for_client.php'
                AND active = 1
            ")->fetch();
        
        $active     = isset($result['id']) ? $result['id'] : 0;
        
        return $active;
    }
    
    public function getClientSetGoogleAuth ()
    {
        $db         = hbm_db();
        
        $aClient    = hbm_logged_client();
        
        $result     = $db->query("
            SELECT cfv.*
            FROM hb_client_fields_values cfv,
                hb_client_fields cf
            WHERE cfv.client_id = :clientId
                AND cfv.field_id = cf.id
                AND cf.code = 'googleauthenticator'
            ", array(
                ':clientId'     => $aClient['id']
            ))->fetch();
        
        $value  = isset($result['value']) ? $result['value'] : '';
        if ($value == 'Enable') {
            $result     = $db->query("
                SELECT cf.*
                FROM hb_client_fields cf
                WHERE cf.code = 'googleauthenticatorcode'
                ")->fetch();
            
            $fieldId    = isset($result['id']) ? $result['id'] : 0;
            
            $result     = $db->query("
                SELECT value
                FROM hb_client_fields_values
                WHERE client_id = :clientId
                    AND field_id = :fieldId
                ", array(
                    ':clientId'     => $aClient['id'],
                    ':fieldId'      => $fieldId
                ))->fetch();
            
            $value2     = isset($result['value']) ? $result['value'] : '';
            if (! preg_match('/VERIFIED/i', $value2)) {
                $value  = '';
            }
            
        }
        
        return $value;
    }
    
    public function getClientSetGoogleAuthCode ()
    {
        $db         = hbm_db();
        
        $aClient    = hbm_logged_client();
        
        $result     = $db->query("
            SELECT cf.*
            FROM hb_client_fields cf
            WHERE cf.code = 'googleauthenticatorcode'
            ")->fetch();
        
        $fieldId    = isset($result['id']) ? $result['id'] : 0;
        
        $result     = $db->query("
            SELECT value
            FROM hb_client_fields_values
            WHERE client_id = :clientId
                AND field_id = :fieldId
            ", array(
                ':clientId'     => $aClient['id'],
                ':fieldId'      => $fieldId
            ))->fetch();
        
        $value      = isset($result['value']) ? $result['value'] : '';
        
        return $value;
    }
    
    public function getGoogleAuthenticatorCode ()
    {
        $db         = hbm_db();
        
        $aClient    = hbm_logged_client();
        
        $name       = 'Netway ('. $aClient['email'] .')';
        $ga         = new PHPGangsta_GoogleAuthenticator();
        
        $result     = $db->query("
            SELECT cf.*
            FROM hb_client_fields cf
            WHERE cf.code = 'googleauthenticatorcode'
            ")->fetch();
        
        $fieldId    = isset($result['id']) ? $result['id'] : 0;
        
        $result     = $db->query("
            SELECT value
            FROM hb_client_fields_values
            WHERE client_id = :clientId
                AND field_id = :fieldId
            ", array(
                ':clientId'     => $aClient['id'],
                ':fieldId'      => $fieldId
            ))->fetch();
        
        $secret     = isset($result['value']) ? $result['value'] : '';
        if (! $secret) {
            $secret = $ga->createSecret();
        }
        $qrCodeUrl  = $ga->getQRCodeGoogleUrl($name, $secret);
        
        if (! isset($aClient['id']) || ! $aClient['id']) {
            return $qrCodeUrl;
        }
        
        $db->query("
            REPLACE INTO hb_client_fields_values (
            client_id, field_id, value
            ) VALUES (
            :clientId, :fieldId, :value
            )
            ", array(
                ':clientId' => $aClient['id'],
                ':fieldId'  => $fieldId,
                ':value'    => $secret
            ));
        
        return $qrCodeUrl;
    }
    
    public function updateclientfeature ($request)
    {
        $db         = hbm_db();
        $aData      = array();
        $aClient    = hbm_logged_client();
        
        $value      = (isset($request['status']) && $request['status']) ? 'Enable' : 'Disable';
        
        $result     = $db->query("
            SELECT cf.*
            FROM hb_client_fields cf
            WHERE cf.code = 'googleauthenticator'
            ")->fetch();
        
        $fieldId    = isset($result['id']) ? $result['id'] : 0;
        
        $db->query("
            REPLACE INTO hb_client_fields_values (
            client_id, field_id, value
            ) VALUES (
            :clientId, :fieldId, :value
            )
            ", array(
                ':clientId' => $aClient['id'],
                ':fieldId'  => $fieldId,
                ':value'    => $value
            ));
        
        if ($value == 'Disable') {
            $result     = $db->query("
                SELECT cf.*
                FROM hb_client_fields cf
                WHERE cf.code = 'googleauthenticatorcode'
                ")->fetch();
            
            $fieldId    = isset($result['id']) ? $result['id'] : 0;
            
            $db->query("
                REPLACE INTO hb_client_fields_values (
                client_id, field_id, value
                ) VALUES (
                :clientId, :fieldId, ''
                )
                ", array(
                    ':clientId' => $aClient['id'],
                    ':fieldId'  => $fieldId
                ));
        }
        
        $this->loader->component('template/apiresponse', 'json');
        $this->json->assign('data', $aData);
        $this->json->show();
    }
    
    public function verifygoogleauthcode ($request)
    {
        $db         = hbm_db();
        
        $aClient    = hbm_logged_client();
        $code       = (isset($request['code']) && $request['code']) ? $request['code'] : '';
        $save       = (isset($request['save']) && $request['save']) ? $request['save'] : 0;
        $ga         = new PHPGangsta_GoogleAuthenticator();
        
        $result     = $db->query("
            SELECT cf.*
            FROM hb_client_fields cf
            WHERE cf.code = 'googleauthenticatorcode'
            ")->fetch();
        
        $fieldId    = isset($result['id']) ? $result['id'] : 0;
        
        $result     = $db->query("
            SELECT value
            FROM hb_client_fields_values
            WHERE client_id = :clientId
                AND field_id = :fieldId
            ", array(
                ':clientId'     => $aClient['id'],
                ':fieldId'      => $fieldId
            ))->fetch();
        
        $secret     = isset($result['value']) ? $result['value'] : '';
        $secret     = preg_replace('/\:VERIFIED/i', '', $secret);
        
        $oneCode    = $ga->getCode($secret);
        $checkResult = $ga->verifyCode($secret, $oneCode, 2);
        
        if ($checkResult) {
            $db->query("
                REPLACE INTO hb_client_fields_values (
                client_id, field_id, value
                ) VALUES (
                :clientId, :fieldId, :value
                )
                ", array(
                    ':clientId' => $aClient['id'],
                    ':fieldId'  => $fieldId,
                    ':value'    => $secret .':VERIFIED'
                ));
            
            $_SESSION['notification']   = array(
                'type'      => 'success',
                'message'   => 'ยืนยันการเข้าใช้งานลผ่าน Google Authenticator สำเร็จ'
            );
            $_SESSION['googleAuthenVerify'] = 1;
            
            if ($save) {
                setcookie('client_google_auth_code', md5($secret .':VERIFIED'), time()+(60*60*24*30), '/');
            }
        } else {
            $_SESSION['notification']   = array(
                'type'      => 'error',
                'message'   => 'ยืนยันการเข้าใช้งานลผ่าน Google Authenticator ผิดพลาด'
            );
        }
        
        $aData      = array(
            'verify'   => $checkResult
        );
        $this->loader->component('template/apiresponse', 'json');
        $this->json->assign('data', $aData);
        $this->json->show();
    }
    
    public function googleauthverify ($request)
    {
        $db         = hbm_db();
        
        $this->template->render(dirname(dirname(__FILE__)) .'/templates/user/googleauthverify.tpl',array(), true);
    }
    
    public function setting ($request)
    {
        $db         = hbm_db();
        $status     = self::getClientSetGoogleAuth();
        $this->template->assign('status',$status);
        $this->template->render(dirname(dirname(__FILE__)) .'/templates/user/setting.tpl',array(), true);
    }
	
    public function afterCall ($request)
    {
        $_SESSION['notification']   = array();
    }
}