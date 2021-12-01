<?php
require_once APPDIR . "class.general.custom.php";
/**
 * Invoice has been fully paid
 * Following variable is available to use in this file:  $details This array of invoice details contains following keys:
 * $details["id"]; // Invoice id
 * $details["status"]; //Current invoice status
 * $details["client_id"]; //Owner of invoice
 * $details["date"]; //Invoice generation date
 * $details["subtotal"]; //Subtotal
 * $details["credit"]; //Credit applied to invoice
 * $details["tax"]; //Tax applied to invoice
 * $details["total"]; //Invoice total
 * $details["payment_module"]; //ID of gateway used with invoice
 * $details["currency_id"]; //ID of invoice currency, default =0
 * $details["notes"]; //Invoice notes
 * $details["items"]; // Invoice items are listed under this key, sample item:
 * $details["items"][0]["type"]; //Item type (ie. Hosting, Domain)
 * $details["items"][0]["item_id"]; //Item id, for type=Hosting this relates to hb_accounts.id field
 * $details["items"][0]["description"]; //Item line text
 * $details["items"][0]["amount"]; //Item price
 * $details["items"][0]["taxed"]; //Is item taxed? 1/0
 * $details["items"][0]["qty"]; //Item quantitiy
 */

 // --- hostbill helper ---
 $db         = hbm_db();
 // --- hostbill helper ---

/**
 * [XXX] 0001420: [general] Domains are not renewed automatically when invoice is paid 
 * Hostbill แก้ไขให้แล้ว ไม่ต้องมีไฟล์นี้
 * ทำ auto renew domain ทันที
 */
$count = 0;
foreach ($details["items"] as $value) {
	if($value['type'] == 'Hosting')
        $count++;
}


if($count > 1){
    $result_update = $db->query("
                UPDATE
                     hb_client_access c,hb_client_group g
                SET
                    c.group_id = g.id
                WHERE
                    g.name like '%AutomationProformaFullpaid%'
                    AND c.group_id = 0
                    AND c.id = :client_id
                ", array(
                    ':client_id' => $details["client_id"],
                ));
    
    // 3. ตรวจสอบว่ามี item เพราะ curl ทำได้ครั้งละ 5 เท่านั้น 
    if ($result_update) {
     
        //$url    = (isset($_SERVER['HTTPS']) ? 'https://' : 'http://') . $_SERVER['HTTP_HOST'] . $_SERVER['SCRIPT_NAME'];
        //$url    = 'https://rvglobalsoft.com/7944web/index.php';
        $url    = GeneralCustom::singleton()->getAdminUrl().'/index.php';
        // [FIXME] Fixcode
        $cookiefile = '/tmp/curl-session';
        $username   = 'rvbillingautomation@rvglobalsoft.com';
        $password   = '|{l*8Sp+-anG8Ac';

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
            exit(0);
        }
    
        foreach ($details["items"] as $k => $v) {
            if ($v['type'] == 'Hosting') {

                curl_setopt($ch, CURLOPT_POST, 0);
                curl_setopt($ch, CURLOPT_TIMEOUT, 60);
                curl_setopt($ch, CURLOPT_HTTPHEADER, array(
                    'Accept: */*', 
                    'X-Requested-With: XMLHttpRequest', 
                    'X-CSRF-Token: ' . $csrfToken,
                ));
                
                curl_setopt($ch, CURLOPT_URL, $url . '?cmd=configuration&action=executetask&task=processAccountProvisioning&debug=0');

                $data = curl_exec($ch);
                curl_close($ch);
               
            } elseif ($v['type'] == 'Domain Register') {
                curl_setopt($ch, CURLOPT_POST, 0);
                curl_setopt($ch, CURLOPT_TIMEOUT, 60);
                curl_setopt($ch, CURLOPT_HTTPHEADER, array(
                    'Accept: */*', 
                    'X-Requested-With: XMLHttpRequest', 
                    'X-CSRF-Token: ' . $csrfToken,
                ));
                curl_setopt($ch, CURLOPT_URL, $url . '?cmd=configuration&action=executetask&task=automaticRegisterDomains&debug=0');

                $data = curl_exec($ch);
                curl_close($ch);
                
            } elseif ($v['type'] == 'Domain Renew') {
                curl_setopt($ch, CURLOPT_POST, 0);
                curl_setopt($ch, CURLOPT_TIMEOUT, 60);
                curl_setopt($ch, CURLOPT_HTTPHEADER, array(
                    'Accept: */*', 
                    'X-Requested-With: XMLHttpRequest', 
                    'X-CSRF-Token: ' . $csrfToken,
                ));
                curl_setopt($ch, CURLOPT_URL, $url . '?cmd=configuration&action=executetask&task=automaticRenewDomains&debug=0');

                $data = curl_exec($ch);
                curl_close($ch);
            } elseif ($v['type'] == 'Domain Transfer') {
                curl_setopt($ch, CURLOPT_POST, 0);
                curl_setopt($ch, CURLOPT_TIMEOUT, 60);
                curl_setopt($ch, CURLOPT_HTTPHEADER, array(
                    'Accept: */*', 
                    'X-Requested-With: XMLHttpRequest', 
                    'X-CSRF-Token: ' . $csrfToken,
                ));
                curl_setopt($ch, CURLOPT_URL, $url . '?cmd=configuration&action=executetask&task=automaticTransferDomains&debug=0');

                $data = curl_exec($ch);
                curl_close($ch);
            }
        }
         //$ss = $db->query("select 'eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee'");
        //4. เปลี่ยน group ให้เป็นเหมอืนเดิม
        $db->query("
            UPDATE
                 hb_client_access c
            SET
                c.group_id = 0
            WHERE
                c.id = :client_id
            ", array(
                ':client_id' => $details["client_id"]
            ));
          
        if (is_file($cookiefile)) {
            unlink($cookiefile);
        }
        
        foreach ($details["items"] as $itemacc) {
            if($details["status"] == 'Paid'){
                $result = $db->query("
                        SELECT
                            status,
                            order_id
                        FROM
                            hb_accounts
                        WHERE
                            id = :accid
                        ",array(':accid'=>$itemacc['item_id']))->fetch();
                if($result['status'] == 'Active'){
                     $db->query("
                            UPDATE
                                 hb_orders
                            SET
                                status = 'Active'
                            WHERE
                                id = :order_id
                            ", array(
                                ':order_id' => $result["order_id"]
                     ));
                }           
            }
        }
        
    }
    
}

?>