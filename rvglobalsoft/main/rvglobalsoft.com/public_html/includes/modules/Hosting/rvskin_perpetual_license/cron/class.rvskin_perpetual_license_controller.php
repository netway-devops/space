<?php
require_once APPDIR . "class.general.custom.php";
require_once APPDIR . "class.api.custom.php";
class rvskin_perpetual_license_controller extends HBController {
    
    public function call_Daily(){
        $this->findLicenceExpireAndSuspend();
        $this->findLicenceExpireSoonAndSendEmail();
        
        return "Success";
    }
    
    private function findLicenceExpireSoonAndSendEmail(){
        $next30day  = date('Y-m-d',strtotime('+30 days',strtotime(date('Y-m-d')))); 
        $listEmail  = $this->listLicenceExpireSoon($next30day);
        $url        = $this->getAdminURL().'index.php';
        $cookiefile = '/tmp/curl-session';
        $username   = 'admin@rvglobalsoft.com';
        $password   = 'ritik,g0Hf';

        $aParam     = array(
            'action'    => 'login',
            'username'  => $username,
            'password'  => $password,
            'rememberme'=> '1'
        );
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_HEADER, false);
        curl_setopt($ch, CURLOPT_POST, 1);
        curl_setopt($ch, CURLOPT_TIMEOUT, 60);
        curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $aParam);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false);
        curl_setopt($ch, CURLOPT_COOKIEFILE, $cookiefile);
        curl_setopt($ch, CURLOPT_COOKIEJAR, $cookiefile);
        $data = curl_exec($ch);
        /* --- ค่าที่ hostbill ใช้ verify เมื่อมีการ call XMLHttpRequest --- */
        preg_match('/<meta\sname="csrf\-token"\scontent="(.*)"\s?\/>/i', $data, $matches);
        
        $csrfToken  = isset($matches[1]) ? $matches[1] : '';
        if ($csrfToken == '') {
            
            throw new Exception('ไม่มีค่า csrf-toke ไม่สามารถ run task automaticRenewDomains ได้');
            
        }
        
        echo 'number of email '.sizeof($listEmail)."\n";
        foreach ($listEmail as $key) {
            $post = array(
              'mail_id' => 134,
              'id'=>$key['aid']
           );
            
            curl_setopt($ch, CURLOPT_POST, 0);
            curl_setopt($ch, CURLOPT_TIMEOUT, 60);
            curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
            curl_setopt($ch, CURLOPT_POSTFIELDS, $post);
            curl_setopt($ch, CURLOPT_HTTPHEADER, array(
                'Accept: */*', 
                'X-Requested-With: XMLHttpRequest', 
                'X-CSRF-Token: ' . $csrfToken,
            ));
            
            curl_setopt($ch, CURLOPT_URL, $url . '?cmd=accounts&action=sendmail');

            $data = curl_exec($ch);
            echo 'account id: '.$key['aid'].$data."\n";
            
            $this->insertLogEmail($key['aid']);
        }
        curl_close($ch);
    }
    
    private function findLicenceExpireAndSuspend(){
        
        $today          = date('Y-m-d'); 
        $listSuspend    = $this->listLicenceExpire($today);
         //$url    = 'http://192.168.1.100/demo/rvglobalsoft.com/public_html/7944web/index.php';
        $adminURL       = $this->getAdminURL();
        $url            = $adminURL.'api.php';
        echo $url;
        $apiCustom = ApiCustom::singleton($url);
        $post = array(
          'call' => 'accountSuspend'
        );
        
        $url1 = $adminURL.'index.php';
        $cookiefile = '/tmp/curl-session';
        $username   = 'admin@rvglobalsoft.com';
        $password   = 'ritik,g0Hf';

        $aParam     = array(
            'action'    => 'login',
            'username'  => $username,
            'password'  => $password,
            'rememberme'=> '1'
        );
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $url1);
        curl_setopt($ch, CURLOPT_HEADER, false);
        curl_setopt($ch, CURLOPT_POST, 1);
        curl_setopt($ch, CURLOPT_TIMEOUT, 60);
        curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $aParam);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false);
        curl_setopt($ch, CURLOPT_COOKIEFILE, $cookiefile);
        curl_setopt($ch, CURLOPT_COOKIEJAR, $cookiefile);
        $data = curl_exec($ch);
        /* --- ค่าที่ hostbill ใช้ verify เมื่อมีการ call XMLHttpRequest --- */
        preg_match('/<meta\sname="csrf\-token"\scontent="(.*)"\s?\/>/i', $data, $matches);
        
        $csrfToken  = isset($matches[1]) ? $matches[1] : '';
        if ($csrfToken == '') {
            
            throw new Exception('ไม่มีค่า csrf-toke ไม่สามารถ run task automaticRenewDomains ได้');
            
        }
        
        echo 'number of user expire '.sizeof($listSuspend)."\n";
        
        foreach($listSuspend as $value){
            
            $post['id'] = $value['aid'];
            $result = $apiCustom->request($post);
            
            
            $post1 = array(
              'mail_id' => 135,
              'id'=>$post['id']
            );
            
            curl_setopt($ch, CURLOPT_POST, 0);
            curl_setopt($ch, CURLOPT_TIMEOUT, 60);
            curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
            curl_setopt($ch, CURLOPT_POSTFIELDS, $post1);
            curl_setopt($ch, CURLOPT_HTTPHEADER, array(
                'Accept: */*', 
                'X-Requested-With: XMLHttpRequest', 
                'X-CSRF-Token: ' . $csrfToken,
            ));
            curl_setopt($ch, CURLOPT_URL, $url1 . '?cmd=accounts&action=sendmail');
            $data = curl_exec($ch);

            echo json_encode($result)."\n";
            echo 'account id: '.$data."\n";
        }
        
        
         curl_close($ch);
    }
    
    /**
     * return array
     */
    private function listLicenceExpire($day){
        $db = hbm_db();
        $perpetualLicensesCategoryID = 9;
        
        $result = $db->query("
                            SELECT
                                a.id as aid
                            FROM
                                hb_accounts a 
                                INNER JOIN hb_products p
                                ON (a.product_id = p.id AND p.category_id = :cat_id)
                            WHERE
                                a.status = 'Active'
                                AND a.billingcycle != 'Free'
                                AND a.next_due <= :day   
                             ",array(':cat_id' => $perpetualLicensesCategoryID,
                                     ':day'    => $day))->fetchAll();
        
        //echo '<pre>'.print_r($result,true);
        //exit(0);                    
        return $result;
    }


 /**
     * return array
     */
    private function listLicenceExpireSoon($day){
        $db = hbm_db();
        $perpetualLicensesCategoryID = 9;
        
        $result = $db->query("
                            SELECT
                                a.id as aid
                            FROM
                                hb_accounts a 
                                INNER JOIN hb_products p
                                ON (a.product_id = p.id AND p.category_id = :cat_id)
                            WHERE
                                a.status = 'Active'
                                AND a.billingcycle != 'Free'
                                AND a.next_due > CURDATE()
                                AND a.next_due <= :day
                                AND a.id NOT IN(SELECT hb_acc
                                                FROM   rv_perpetual_email
                                                WHERE  DATE_ADD(`date`,INTERVAL 30 DAY) > CURDATE())   
                             ",array(':cat_id' => $perpetualLicensesCategoryID,
                                     ':day'    => $day))->fetchAll();
        
        //echo '<pre>'.print_r($result,true);
        //exit(0);                    
        return $result;
    }
    
    
    private function insertLogEmail($accID){
        $db = hbm_db();
        $result = $db->query("
                            INSERT INTO 
                                        `rv_perpetual_email`(`hb_acc`, `date`) 
                            VALUES 
                                        (:accid,CURDATE())   
                             ",array(':accid' => $accID));
        
    }
    
    private function getAdminURL(){
        if (isset($_SERVER['HTTP_HOST'])) {
            $adminUrl   = (isset($_SERVER['HTTPS']) ? 'https://' : 'http://') . $_SERVER['HTTP_HOST']
                    . (preg_match('/^192\.168\.1/', $_SERVER['HTTP_HOST']) 
                        ? '/demo/rvglobalsoft.com/public_html/7944web/'
                        : '/7944web/');
        } else {
            $adminUrl = 'https://rvglobalsoft.com/7944web/';
        }   
        
        return $adminUrl;
    }

}    
?>