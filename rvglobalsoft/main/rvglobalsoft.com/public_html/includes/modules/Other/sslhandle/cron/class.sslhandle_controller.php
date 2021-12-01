<?php

class sslhandle_controller extends HBController {
    
    public $module;
    
    public function call_EveryRun()
    {
        
        $db         = hbm_db();
        $message    = '';
        
        $message    = $this->checkSSLOrderStatus();
        echo $message;
        return $message;
    }
    
    public function checkSSLOrderStatus ()
    {
        $db         = hbm_db();
        $message    = '';
        
        require_once HBFDIR_LIBS . 'RvLibs/SSL/PHPLibs.php';
        $oAuth      =& RvLibs_SSL_PHPLibs::singleton();
        
        $aResult     = $db->query("
            SELECT
                hso.order_id,
                ha.id AS account_id,
                ha.status AS account_status,
                hso.symantec_status,
                hso.is_renewal,
                ha.domain
            FROM
                hb_ssl_order AS hso
                , hb_accounts AS ha
                , hb_invoices AS hi
                , hb_orders AS ho
            WHERE
                ha.order_id = hso.order_id
                AND ha.status != 'Terminated'
                AND ha.status != 'Cancelled'
                AND ho.id = ha.order_id
                AND ho.invoice_id = hi.id
                AND hi.status = 'Paid'
                AND hso.partner_order_id != ''
                AND (
                        (
                            hso.cron_update = 1
                        ) OR (
                            hso.csr != ''
                            AND ho.id = ha.order_id
                            AND ho.invoice_id = hi.id
                            AND hso.authority_orderid = ''
                        )
                )
            ORDER BY hso.last_updated
            LIMIT 0,3
            ")->fetchAll();
        
        foreach($aResult as $result){
        
            $orderId    = isset($result['order_id']) ? $result['order_id'] : 0;
            if (! $orderId) {
                continue;
            }
            
            $domain     = $result['domain'];
            
            $result     = $oAuth->checkStatus($orderId);
            
            $result     = $db->query("
                SELECT symantec_status, cert_status, date_expire
                FROM hb_ssl_order
                WHERE order_id = '{$orderId}'
                ")->fetch();
            
            $message    .= 'SSL Order#'. $orderId .' '. $domain .' check state ';
            
            if(isset($result['symantec_status']) && $result['symantec_status'] == 'REJECTED'){
            	$aParam     = array(
            			'ticket'    => array(
            					'requester_id'  => 360075848914,
            					'submitter_id'  => 360075848914,
            					'subject'       => 'SSL Order#'. $orderId .' has rejected',
            					'assignee_id'   =>  360075848914,
            					'comment'       => array(
            							'public'    => 'true',
            							'html_body' => nl2br( '<br>Add credit คืนให้ลูกค้าด้วยครับ<br>
            									<a href="https://rvglobalsoft.com/7944web/?cmd=orders&action=edit&id=' . $orderId
            									.'">https://rvglobalsoft.com/7944web/?cmd=orders&action=edit&id=' . $orderId . '</a>'
            							)
            					)
            			)
            	);
            	
            	$request    = array(
            			'url'       => '/tickets.json',
            			'method'    => 'post',
            			'data'      => $aParam
            	);
            	
            	$response     = self::_send($request);
            }
            
            if(isset($result['symantec_status']) && $result['symantec_status'] == 'COMPLETED' && $result['cert_status'] == 'Active'){
                
                $expireDate = $result['date_expire'] ? date('Y-m-d', $result['date_expire']) : '';
                
                $db->query("
                    UPDATE hb_accounts 
                    SET status = 'Active' 
                        ". ($expireDate ? " , next_due = '{$expireDate}' " : "") ."
                    WHERE order_id = '{$orderId}'
                    ");
                $message    .= ' symantec_status = '. $result['symantec_status'];
                $message    .= ' cert_status = '. $result['cert_status'];
                
                // update order เป็น active ด้วย
                
                $result     = $db->query("
                    SELECT *
                    FROM hb_orders
                    WHERE id = '{$orderId}'
                        AND status = 'Pending'
                    ")->fetch();
                
                $invoiceId  = isset($result['invoice_id']) ? $result['invoice_id'] : 0;
                
                if ($invoiceId) {
                    $result     = $db->query("
                        SELECT COUNT(*) AS total
                        FROM hb_invoice_items
                        WHERE invoice_id = '{$invoiceId}'
                        ")->fetch();
                    $total      = $result['total'];
                    if ($total == 1) {
                        $db->query("
                            UPDATE hb_orders 
                            SET status = 'Active'
                            WHERE id = '{$orderId}'
                            ");
                        $db->query("
                            INSERT INTO hb_order_log (
                            `order_id`, `date`, `type`, `entry`, `who` 
                            ) VALUES (
                            '{$orderId}', NOW(), '', 'Execute step Provision : SUCCESS', 'class.sslhandle_controller.php'
                            )
                            ");
                    }
                }
                
            } else {
                $message    .= ' nothing ';
            }
            
            $db->query("
                UPDATE hb_ssl_order
                SET last_updated = :last_updated
                WHERE order_id = '{$orderId}'
                ", array(
                    ':last_updated' => time()
                ));
        }
        return $message;
    }
    
    private function _send ($request)
    {
    	$url        = $request['url'];
    	$method     = isset($request['method']) ? $request['method'] : 'get';
    	$data       = isset($request['data']) ? json_encode($request['data']) : array();
    
    	$ch = curl_init();
    	curl_setopt($ch, CURLOPT_URL, 'https://rvglobalsoft.zendesk.com/api/v2'. $url);
    	if ($method == 'post') {
    		curl_setopt($ch, CURLOPT_POST, 1);
    	}
    	if ($method == 'put') {
    		curl_setopt($ch, CURLOPT_CUSTOMREQUEST, 'PUT');
    	}
    	if ($method != 'get') {
    		curl_setopt($ch, CURLOPT_POSTFIELDS, $data);
    	}
    	curl_setopt($ch, CURLOPT_TIMEOUT, 30);
    	curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
    	curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
    	curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false);
    	curl_setopt($ch, CURLOPT_USERPWD, 'prasit+rv@netway.co.th/token:rzkJaKdbWg2cptxaVZjsezCiIY8mxgrpG89kobAg');
    	curl_setopt($ch, CURLOPT_HTTPAUTH, CURLAUTH_BASIC);
    	curl_setopt($ch, CURLOPT_HTTPHEADER, array('Content-Type:application/json'));
    	$data   = curl_exec($ch);
    	curl_close($ch);
    	$result = json_decode($data, true);
    
    	return $result;
    }
    
}
