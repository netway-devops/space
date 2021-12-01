<?php

class cpaneldnszonehandle_controller extends HBController {
    
    public function beforeCall ($request)
    {
        
    }
    
    public function _default ($request)
    {
        $db     = hbm_db();
        
        
        
        
        $this->_beforeRender();
        $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/default.tpl',array(), true);
    }
    
    public function userdomains ($request)
    {
        $db         = hbm_db();
        $oInfo      = (object) array(
            'title'     => 'ส่วนจัดการ error eximpanic',
            'desc'      => '/etc/userdomains กลายเป็น user system ตามด้านล่าง 
                ซึ่งถ้าทำการต่ออายุแล้วมีการส่ง mail ไปหา user domain นี้จะทำให้เกิด exim panic บนเครื่อง manage.netway.co.th '
            );
        
        $userdomainFile     = dirname(__FILE__) . '/userdomains.txt';
        $file       = file($userdomainFile);
        if (! count($file)) {
            $oInfo->alert   = 'ไม่พบข้อมูล ให้ staff รันคำสั่ง
                <input size="60" value="grep \': system\' /etc/userdomains &gt; '. $userdomainFile . '" />
                ที่เครื่อง manage.netway.co.th เพื่อดึงข้อมูลที่ error มาแสดง<br />
                เมื่อรันเสร็จให้เรียกหน้านี้ใหม่ จะเห็นรายการโดเมนที่ error
                ';
        }
        
        $handle     = fopen($userdomainFile, 'w');
        fwrite($handle, '');
        fclose($handle);
        
        $aDomains   = array();
        if (count($file)) {
            foreach ($file as $v) {
                preg_match('/(.*):\ssystem/', $v, $match);
                if (isset($match[1])) {
                    array_push($aDomains, $match[1]);
                }
            }
        }
        
        $this->template->assign('aDomains', $aDomains);
        
        // echo '<pre>'. print_r($match, true) .'</pre>';
        
        $this->template->assign('oInfo', $oInfo);
        $this->_beforeRender();
        $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/userdomains.tpl',array(), true);
    }

    public function fixdns ($request)
    {
        $db         = hbm_db();
        $oAdmin     = (object) hbm_logged_admin();
        
        $result     = $db->query("
            SELECT
                mc.config
            FROM
                hb_modules_configuration mc
            WHERE
                mc.module = 'cpaneldnszonehandle'
            ")->fetch();
        
        $aConfig    = isset($result['config']) ? unserialize($result['config']) : array();
        $ipPark     = isset($aConfig['IP Park']['value']) ? $aConfig['IP Park']['value'] : '';
        
        $domain         = isset($request['domain']) ? $request['domain'] : '';
        
        if (! $domain) {
            echo '<!-- {"ERROR":["ไม่มีชื่อโดเมนที่ต้องการแก้ไข"]'
                . ',"INFO":[]'
                . ',"STACK":0} -->';
            exit;
        }
        
        $html       = '<h3>'. date('Y-m-d H:i:s') .'</h3>';
        
        $query      = '/dumpzone?domain='. $domain;
        $oResult    = $this->_whmapi($query);
        if ( isset($oResult->result[0]->statusmsg)) {
            $statusmsg  =  $oResult->result[0]->statusmsg;
            $statusmsg  = preg_replace('/(\r|\n)/', '', $statusmsg);
            $html   .= $statusmsg .'<br />--------------- --------------- ---------------<br />';
        }
        
        $aRecord    = isset($oResult->result[0]->record) ? $oResult->result[0]->record : array();

        $html       .= '<table>';
        foreach ($aRecord as $aRow) {
            $html       .= '<tr>';
            foreach ($aRow as $k => $v) {
                $html   .= '<td>'. $v .'</td>';
            }
            $html       .= '</tr>';
        }
        $html       .= '</table><br />';

        $query      = '/killdns?domain='. $domain;
        $oResult    = $this->_whmapi($query);
        if ( isset($oResult->result[0]->statusmsg)) {
            $statusmsg  =  $oResult->result[0]->statusmsg;
            $statusmsg  = preg_replace('/(\r|\n)/', '', $statusmsg);
            $html   .= $statusmsg .'<br />--------------- --------------- ---------------<br />';
        }
        
        $query      = '/adddns?domain='. $domain .'&ip='. $ipPark;
        $oResult    = $this->_whmapi($query);
        if ( isset($oResult->result[0]->statusmsg)) {
            $statusmsg  =  $oResult->result[0]->statusmsg;
            $statusmsg  = preg_replace('/(\r|\n)/', '', $statusmsg);
            $html   .= $statusmsg .'<br />--------------- --------------- ---------------<br />';
        }
        
        foreach ($aRecord as $aRow) {
            if ( (isset($aRow->type) && $aRow->type == 'A') 
                && (isset($aRow->name) && preg_match('/^localhost/i', $aRow->name)) 
                && (isset($aRow->address) && $aRow->address == '127.0.0.1') 
                ) {
                $aRow->name = '';
            }
            $param      = '';
            $match      = false;
            foreach ($aRow as $k => $v) {
                $param  .= '&'. $k .'='. $v;
                if ($k == 'type' && in_array($v, array('NS', 'A', 'CNAME', 'MX', 'TXT'))) {
                    $match      = true;
                }
            }
            if (! $match) {
                continue;
            }
            $query      = '/editzonerecord?domain='. $domain . $param;
            $oResult    = $this->_whmapi($query);
            if ( isset($oResult->result[0]->statusmsg)) {
                $statusmsg  =  $oResult->result[0]->statusmsg;
                $statusmsg  = preg_replace('/(\r|\n)/', '', $statusmsg);
                $html   .= $statusmsg .'for query: '. $query .'<br /><br />';
            }
        }

        $header     = 'MIME-Version: 1.0' . "\r\n" .
                'Content-type: text/html; charset=utf-8' . "\r\n" .
                'From: admin@netway.co.th' . "\r\n" .
                'Reply-To: admin@netway.co.th' . "\r\n" .
                'X-Mailer: PHP/' . phpversion();
        @mail($oAdmin->username, 'Log fix error eximpanic for:'. $domain, $html, $header);
        
        echo '<!-- {"ERROR":[]'
            . ',"INFO":["แก้ไขข้อมูลเรียบร้อยแล้ว"]'
            . ',"HTML":["'. $html .'"]'
            . ',"STACK":0} -->';
        exit;
    }
    
    private function _whmapi ($query)
    {
        $db         = hbm_db();
        
        $result     = $db->query("
            SELECT
                mc.config
            FROM
                hb_modules_configuration mc
            WHERE
                mc.module = 'cpaneldnszonehandle'
            ")->fetch();
        
        $aConfig    = isset($result['config']) ? unserialize($result['config']) : array();
        
        $ipPark     = isset($aConfig['IP Park']['value']) ? $aConfig['IP Park']['value'] : '';
        $dnsServer  = isset($aConfig['DNS Server3 IP']['value']) ? $aConfig['DNS Server3 IP']['value'] : '';
        $dnsUser    = isset($aConfig['DNS Server3 WHM Username']['value']) 
                        ? $aConfig['DNS Server3 WHM Username']['value'] : '';
        $dnsHash    = isset($aConfig['DNS Server3 WHM Hash']['value']) 
                        ? $aConfig['DNS Server3 WHM Hash']['value'] : '';
        
        $query      = 'https://'. $dnsServer .':2087/json-api'. $query;
        
        $curl       = curl_init();
        curl_setopt($curl, CURLOPT_SSL_VERIFYHOST, 0);
        curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, 0);
        curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);
        $header[0]  = 'Authorization: WHM '. $dnsUser .':' . preg_replace('/(\r|\n)/', '', $dnsHash);
        curl_setopt($curl, CURLOPT_HTTPHEADER, $header);
        curl_setopt($curl, CURLOPT_URL, $query);
        $result     = curl_exec($curl);
        curl_close($curl);
        
        $oResult    = json_decode($result);
        
        return $oResult;
    }
    
    /**
     * ให้สามารถลบ dns zone ทิ้งกรณี create account ไม่ได้ เพราะจดโดเมนแล้วมันสร้าง zone ให้
     * @param unknown_type $request
     * @return unknown_type
     * @reference https://documentation.cpanel.net/display/SDK/Authenticating+API+Function+Calls
     */
    public function deletednszone ($request)
    {
        $db     = hbm_db();
        
        $domainName     = (isset($request['domainName']) && $request['domainName']) ? trim($request['domainName']) : '';
        
        if (! $domainName) {
            echo '<!-- {"ERROR":["Invalid domainname."],"INFO":[]'
                . ',"HTML":""'
                . ',"STACK":0} -->';
            exit;
        }
        
        
        $aConfigs       = $this->module->configuration;
        
        $errorMessage   = '';
        $infoMessage    = '';
        
        for ($i = 1; $i<=2; $i++) {
            
            $dnsServer      = $aConfigs['DNS Server'. $i .' IP']['value'];
            $dnsUser        = $aConfigs['DNS Server'. $i .' WHM Username']['value'];
            $dnsHash        = $aConfigs['DNS Server'. $i .' WHM Hash']['value'];
            
            $query          = 'https://'. $dnsServer .':2087/json-api/killdns?domain='. $domainName;
            
            $curl = curl_init();
            # Create Curl Object
            curl_setopt($curl, CURLOPT_SSL_VERIFYHOST,0);
            # Allow certs that do not match the domain
            curl_setopt($curl, CURLOPT_SSL_VERIFYPEER,0);
            # Allow self-signed certs
            curl_setopt($curl, CURLOPT_RETURNTRANSFER,1);
            # Return contents of transfer on curl_exec
            $header[0] = "Authorization: WHM $dnsUser:" . preg_replace("'(\r|\n)'","",$dnsHash);
            # Remove newlines from the hash
            curl_setopt($curl,CURLOPT_HTTPHEADER,$header);
            # Set curl header
            curl_setopt($curl, CURLOPT_URL, $query);
            # Set your URL
            $result = curl_exec($curl);
            # Execute Query, assign to $result
            if (! $result) {
                $errorMessage  .= ' Error on:'. $dnsServer;
            } else {
                
                $oResult        = json_decode($result);
                if (isset($oResult->result[0])) {
                    $oResult    = $oResult->result[0];
                    
                    if ($oResult->status == 1) {
                        $infoMessage   .= ' Success on:'. $dnsServer .' '. $oResult->statusmsg;
                        
                    }
                }
            }
            curl_close($curl);
        
        }
        
        echo '<!-- {"ERROR":[' 
            . (($errorMessage) ? '"'. $errorMessage .'"' : '') 
            . '],"INFO":['
            . (($infoMessage) ? '"'. $infoMessage .'"' : '') 
            .']'
            . ',"HTML":""'
            . ',"STACK":0} -->';
        exit;

        
    }
    
    private function _beforeRender ()
    {
        $this->template->assign('tplPath', dirname(dirname(__FILE__)) . '/templates/');
        $this->template->assign('tplClientPath', dirname(dirname(dirname(dirname(dirname(dirname(__FILE__)))))) 
            . '/templates/');
    }

    public function afterCall ($request)
    {
        
    }
}