<?php

/*
 * INSERT INTO  `rvglobal_hostbill`.`hb_admin_fields` (
`id` ,
`name` ,
`variable` ,
`type` ,
`default`
)
VALUES (
NULL ,  'Two-Factor Authentication',  '2faenable',  'checkbox',  '{$lang.enable}'
), (
NULL ,  'Two-Factor Secret',  '2fasecretadmin',  'input',  ''
);
 * 
 * */

require_once APPDIR_MODULES . 'Other/google_authenticator/lib/class.googleauthenticator.php';

class google2factorforadmins extends OtherModule implements Observer {
    
    protected $modname      = 'Google Authenticator for hostbill admins';
    protected $description  = 'ระบบ 2factor สำหรับ admins';
    
    const SESSION_KEY = '_2fa_admin';
    public  $adminId;
    public  $adminName;
    
    public function getConfig(){
        
        $appSetting         =   $_SESSION['AppSettings'];
        $admin_login        =   $appSetting['admin_login'];
        $this->adminId      =   $admin_login['id'];
        $this->adminName    =   $admin_login['firstname'];
                
    }
    
    public function before_displayadminheader()
    {
        
        $this->getConfig();
        
        $aAdmin     = hbm_logged_admin();
        if (isset($aAdmin['email']) && $aAdmin['email'] == 'prasit@netway.co.th') {
            //return true;
        }

        if($_GET['cmd'] == 'google2factorforadmins' && $_SESSION[self::SESSION_KEY] == 1 && isset($_COOKIE['2facRemember7days'])) Utilities::redirect('index.php');
        
        if($this->checkAdminEnable2factor() && $_GET['cmd'] != 'google2factorforadmins' && $_SESSION[self::SESSION_KEY] != 1 && !isset($_COOKIE['2facRemember7days'])){
            Utilities::redirect('?cmd=google2factorforadmins');
        }/*else if($_GET['cmd'] != 'editadmins' && !$this->checkAdminEnable2factor()){
            Utilities::redirect('?cmd=editadmins&action=administrator&id='. $this->adminId);
        }*/
        
        $bn = $aAdmin['email'];// $this->adminName . '@netway.co.th';
        echo '<script>' . "\n" . '    function google2factorAuth(){' . "\n\t" . 'var gau=$(\'input[name=2fasecretadmin]\');' . "\n" . '        if(!gau.length)' . "\n" . '            return;' . "\n" . '            ' . "\n\t" . 'var btn = $(\'<input type="button" class="btn btn-small" value="Generate Code"/>\').click(function(){' . "\n" . '        function randomString(length, chars) {' . "\n" . '            var result = \'\';' . "\n" . '            for (var i = length; i > 0; --i) result += chars[Math.floor(Math.random() * chars.length)];' . "\n" . '            return result;' . "\n" . '        }' . "\n" . '        var rString = randomString(16, \'ABCDEFGHIJKLMNOPQRSTUVWXYZ234567\');' . "\n\n\t" . '    gau.val(rString).change();' . "\n\t" . '    return false;' . "\n\t" . '});;' . "\n\t\n\t" . 'var gg = $(\'<div>Use the Google Authenticator app on your iOS or Android device to scan the QR code and complete the setup process.</dif>\');' . "\n\t" . 'gau.after(gg);' . "\n\t" . 'gau.after(btn);' . "\n\t" . 'var page = "' . $bn . '";' . "\n" . '            ' . "\n\t" . 'gau.change(function(){' . "\n\t\t" . '$(\'#gau_img\').remove();' . "\n\n\t\t" . 'if(gau.val()) {' . "\n\t\t\t" . 'var img = $("<img>").css(\'display\',\'block\').attr(\'id\',\'gau_img\');' . "\n\t\t\t" . 'gg.after(img);' . "\n\t\t\t" . 'img.attr(\'src\',\'https://chart.apis.google.com/chart?chs=200x200&chld=M|0&cht=qr&chl=otpauth://totp/\'+page+\'%3Fsecret%3D\'+gau.val());' . "\n\t\t" . '}' . "\n\t" . '})' . "\n" . '        if(!gau.val().length)' . "\n" . '            btn.click();' . "\n" . '        else' . "\n" . '            gau.change();' . "\n" . '    }' . "\n" . '$(document).ready(google2factorAuth);' . "\n" . '</script>';

}

    public function checkAdminEnable2factor(){
                    
        /*$db                 =   $db = hbm_db();
        
        $sql                =   "SELECT
                                    count(afv.value) as num , afv.admin_id , af.variable , afv.value
                                 FROM     hb_admin_fields af , hb_admin_fields_values afv
                                 WHERE
                                    afv.admin_id  = {$this->adminId}
                                    AND afv.field_id = af.id
                                    AND af.variable = '2faenable'
                                    AND afv.value = '1'
                                ";
        $result             =   $db->query($sql,array())->fetch();*/
        
        return  1;//$result['num'];
        
    }

    public function verifyCode($oneCode)
    {
        $ga = new PHPGangsta_GoogleAuthenticator();
        
        if ($ga->verifyCode($this->get2fasecretadmin(), $oneCode, 2)) {
            $_SESSION[self::SESSION_KEY] = 1;
            return true;
        }
        unset($_SESSION[self::SESSION_KEY]);
        $this->addError('securitycode_wrong');
        return false;
    }
    
    public function get2fasecretadmin(){
            
        $this->getConfig();
                    
        $db                 =   $db = hbm_db();
        
        $sql                =   "SELECT
                                    afv.admin_id , af.variable , afv.value
                                 FROM     hb_admin_fields af , hb_admin_fields_values afv
                                 WHERE
                                    afv.admin_id  = {$this->adminId}
                                    AND afv.field_id = af.id
                                    AND af.variable = '2fasecretadmin'
                                ";
        $result             =   $db->query($sql,array())->fetch();
        
        return  $result['value'];
        
    }
    
    public function updateSecret($secret){
        
        $this->getConfig();
                    
        $db                 =   $db = hbm_db();
        $fieldId            =   0;
        $sql                =   "SELECT
                                    af.*
                                 FROM     hb_admin_fields af
                                 WHERE
                                    af.variable = '2fasecretadmin'
                                ";
        $result             =   $db->query($sql,array())->fetch();
        $fieldId            =   $result['id'];
        
        $getSecret          =   $this->get2fasecretadmin();
        
        if($getSecret != ''){
            $db->query("UPDATE hb_admin_fields_values SET value = '{$secret}' WHERE field_id = {$fieldId} AND admin_id = {$this->adminId}");
        }else{
            $db->query("INSERT INTO hb_admin_fields_values VALUES({$fieldId},{$this->adminId},'{$secret}')");
        }
        
    }
    
    public function updateFirstLogin(){
        
        $this->getConfig();
                    
        $db                 =   $db = hbm_db();
        $fieldId            =   0;
        $sql                =   "SELECT
                                    af.*
                                 FROM     hb_admin_fields af
                                 WHERE
                                    af.variable = '2faenable'
                                ";
        $result             =   $db->query($sql,array())->fetch();
        $fieldId            =   $result['id'];
        
        $getenable          =   $this->get2faenable();
        
        if(empty($getenable)){
             $db->query("INSERT INTO hb_admin_fields_values VALUES({$fieldId},{$this->adminId},'1')");
        }else{
            if($getenable['value'] == ''){
                $db->query("UPDATE hb_admin_fields_values SET value = '1' WHERE field_id = {$fieldId} AND admin_id = {$this->adminId}");
            }
        }
        
    }
    
    public function get2faenable(){
            
        $this->getConfig();
                    
        $db                 =   $db = hbm_db();
        
        $sql                =   "SELECT
                                    afv.admin_id , af.variable , afv.value
                                 FROM     hb_admin_fields af , hb_admin_fields_values afv
                                 WHERE
                                    afv.admin_id  = {$this->adminId}
                                    AND afv.field_id = af.id
                                    AND af.variable = '2faenable'
                                ";
        $result             =   $db->query($sql,array())->fetch();
        
        return  $result;
        
    }
    
    public function setCookie7Days(){
                
        if (!isset($_COOKIE['2facRemember7days'])){
            setcookie('2facRemember7days', true,  time()+(60*60*24*30));
        }            
        
    }
    
    
}

?>