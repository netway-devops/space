<?php

require_once(APPDIR .'class.cache.extend.php');
require_once(APPDIR . 'modules/Other/billingcycle/api/class.billingcycle_controller.php');
require_once dirname(__DIR__) . '/model/class.accounthandle_model.php';

class accounthandle_controller extends HBController {
    
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
        $db             = hbm_db();
        
        $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/default.tpl',array(), true);
    }
    
    public function manageConfig2Account ($accountId)
    {
        $db             = hbm_db();
        
        return self::_removeEmptyDedicatedIP($accountId);
        
    }
    
    private function _removeEmptyDedicatedIP ($accountId)
    {
        $db             = hbm_db();
        
        // CASE 1
        $result         = $db->query("
                SELECT c2a.*
                FROM hb_config2accounts c2a,
                    hb_config_items_cat cic
                WHERE c2a.account_id = :accountId
                    AND c2a.rel_type = 'Hosting'
                    AND c2a.config_cat = cic.id
                    AND cic.variable = 'ip'
                    AND c2a.config_id = '0'
                    AND cic.type = 1
                ", array(
                    ':accountId'    => $accountId
                ))->fetch();
        
        if (isset($result['account_id'])) {
            $configCatId    = $result['config_cat'];
            
            $db->query("
                DELETE FROM hb_config2accounts 
                WHERE rel_type = 'Hosting'
                    AND account_id = :accountId
                    AND config_id = 0
                    AND config_cat = :configCatId
                LIMIT 1
                ", array(
                    ':accountId'    => $accountId,
                    ':configCatId'  => $configCatId,
                ));
            
            return true;
        }
        
        // CASE 2
        $result         = $db->query("
                SELECT c2a.*
                FROM hb_config2accounts c2a,
                    hb_config_items ci,
                    hb_config_items_cat cic
                WHERE c2a.account_id = :accountId
                    AND c2a.rel_type = 'Hosting'
                    AND c2a.config_id = ci.id
                    AND c2a.config_cat = cic.id
                    AND cic.variable = 'ip'
                    AND ci.name = '0'
                ", array(
                    ':accountId'    => $accountId
                ))->fetch();
        
        if (! isset($result['account_id'])) {
            return false;
        }
                    
        $configId       = $result['config_id'];
        $configCatId    = $result['config_cat'];
        
        // --- Fixbug ถ้าไมไ่ด้เลือก Dedicated IP ไม่ต้องให้แสดงใน invoice ต้องลย record นั้นออกเลย ---
        $db->query("
            DELETE FROM hb_config2accounts 
            WHERE rel_type = 'Hosting'
                AND account_id = :accountId
                AND config_id = :configId
                AND config_cat = :configCatId
            LIMIT 1
            ", array(
                ':accountId'    => $accountId,
                ':configId'     => $configId,
                ':configCatId'  => $configCatId,
            ));
        
        return true;
    }
    
    public function internalNetwayHypervisor ($aAccounts)
    {
        $db             = hbm_db();
        
        if (! count($aAccounts)) {
            return $aAccounts;
        }
        $countRow = 0;
        foreach ($aAccounts as $k => $aAccount) {
            
            $cacheKey   = md5( __FILE__ . __LINE__ . serialize($aAccount) );
            $result     = CacheExtend::singleton()->get($cacheKey);
            
            if (is_null($result)) {
                
                $result     = $db->query("
                        SELECT
                            ci.variable_id, cic.variable
                        FROM
                            hb_accounts a,
                            hb_config2accounts c2a,
                            hb_config_items ci,
                            hb_config_items_cat cic
                        WHERE
                            a.id = :accountId
                            AND a.id = c2a.account_id
                            AND c2a.rel_type = 'Hosting'
                            AND c2a.config_id = ci.id
                            AND c2a.config_cat = cic.id
                            AND cic.variable IN ('netway', 'hypervisor')
                        ", array(
                            ':accountId'      => $aAccount['id']
                        ))->fetchAll();
                
                CacheExtend::singleton()->set($cacheKey, $result, 3600*3);
            }
            
            if (count($result)) {
                foreach ($result as $v) {
                    $aAccounts[$k]['tags'][$v['variable']]   = $v['variable_id'];
                }
            }
            
            $cacheKey   = md5( __FILE__ . __LINE__ . serialize($aAccount) );
            $result     = CacheExtend::singleton()->get($cacheKey);
            
            if (is_null($result)) {
                
                $result     = $db->query("
                        SELECT
                            ci.id, ci.name
                        FROM
                            hb_accounts a,
                            hb_config2accounts c2a,
                            hb_config_items ci,
                            hb_config_items_cat cic
                        WHERE
                            a.id = :accountId
                            AND a.id = c2a.account_id
                            AND c2a.rel_type = 'Hosting'
                            AND c2a.config_id = ci.id
                            AND c2a.config_cat = cic.id
                            AND cic.name IN ('Hybrid')
                            AND ci.name LIKE '%Yes%'
                        ", array(
                            ':accountId'      => $aAccount['id']
                        ))->fetchAll();
                
                CacheExtend::singleton()->set($cacheKey, $result, 3600*3);
            }
            
            if (count($result)) {
                foreach ($result as $v) {
                    $aAccounts[$k]['tags']['Hybrid']    = $v['id'];
                }
            }
            
            $result2	= $db->query("
						SELECT
							a.domain , a.id , a.username , a.password
						FROM
							hb_accounts a , hb_servers s
							
						WHERE
							a.server_id = s.id
							AND s.group_id = 2
							AND a.id = :accountId
						", array(
                            ':accountId'      => $aAccount['id']
                        ))->fetchAll();
            if (count($result2)) {
            	$aAccounts[$k]['cPanel']   		= count($result2);
            	
            	require_once(APPDIR . 'class.api.custom.php');
				$apiCustom  = ApiCustom::singleton($adminUrl.'/api.php');
				
			    $post = array(
			       'call' => 'getAccountDetails',
			       'id'=> $aAccount['id']
			    );
				
				$return = $apiCustom->request($post);

				if($return['success'] == 1){
					 $aAccounts[$k]['cPanelLogin'] = array('user'=>$return['details']['username'],'password'=>$return['details']['password']);
				}
            }
         
         }
        
        return $aAccounts;
    }
    
    public function listAccountExpiryDate ($aAccounts)
    {
        $db             = hbm_db();
        
        if (! count($aAccounts)) {
            return $aAccounts;
        }
        
        if (is_array($aAccounts) && count($aAccounts)) {
            
            foreach ($aAccounts as $k => $aAccount) {
                
                $post = array(
                    'call'      => 'module',
                    'module'    => 'billingcycle',
                    'fn'        => 'getAccountExpiryDate',
                    'accountId' => $aAccount['id'],
                    'nextDue'   => $aAccount['next_due']
                );
                
                $cacheKey   = md5( __FILE__ . __LINE__ . serialize($post) );
                $result     = CacheExtend::singleton()->get($cacheKey);
                
                if (is_null($result)) {
                    $result = billingcycle_controller::getAccountExpiryDate($post);
                    CacheExtend::singleton()->set($cacheKey, $result, 3600*3);
                }

                if (isset($result[1]['error'])) {
                      $aAccounts[$k]['error']      = implode(' ', $result[1]['error']);
                } elseif (isset($result[1]['expire'])) {
                      $aAccounts[$k]['expire']     = $result[1]['expire'];
                      $aAccounts[$k]['color']      = $result[1]['color'];
                }
                
            }
        }
        
        
        return $aAccounts;
    }

	public function ajaxFilterAccountsByClientId($request){
		
		$db         = hbm_db();
        
        $keyword    = isset($request['data']) ? $request['data'] : '';
		$client_id	= isset($request['client_id']) ? $request['client_id'] : '';
        
        $result     = $db->query("
                SELECT acc.id,acc.manual, acc.domain, acc.billingcycle, 
            			acc.status, acc.total, acc.expiry_date, acc.next_due, prod.name, prod.type, 
            			cd.lastname, cd.firstname, acc.client_id, cb.currency_id,
            			COALESCE(com.paytype,'Free') paytype
            	FROM hb_accounts acc 
            		LEFT JOIN hb_common com ON com.id=acc.product_id AND com.rel='Product'
            		LEFT JOIN hb_products prod ON (prod.id=acc.product_id) 
           		 	LEFT JOIN hb_product_types pt ON (pt.id=prod.type)
            		LEFT JOIN hb_client_details cd ON (cd.id=acc.client_id) 
            		LEFT JOIN hb_client_billing cb ON (cb.client_id=acc.client_id) 
            	WHERE 
            		acc.client_id=:client_id
            		AND (acc.domain LIKE :keyword  
            		OR  acc.id LIKE :keyword)
            	ORDER BY acc.`id` DESC
                ", array(
                    ':keyword'  		=> '%'. $keyword .'%' ,
                    ':client_id'		=>	$client_id	
                ))->fetchAll();
		
		$resHtml = '';
		if(count($result) > 0){
			$resHtml = ' <table cellspacing="0" cellpadding="3" border="0" width="100%" class="glike hover">
						 <thead>
							<tr>
								<th>Account #</th>
								<th>Domain</th>
								<th>Service</th>
								<th>Price</th>
								<th>Billing Cycle</th>
								<th>Status</th>
								<th><span class="livemode" title="ดึงจากวัน duedate ของ invoice ที่ paid ล่าสุด">Expiry Date</span></th>
								<th>Next due</th>
								<th width="20"/>
							  </tr>
						 </thead>';
			$resHtml .= "<tbody>";
			foreach($result as $account){
				
				$resHtml .= "<tr>";
				$resHtml .= "<td><a href=\"?cmd=accounts&action=edit&id={$account['id']}\" target=\"_blank\">{$account['id']}</a></td>";
				if($account.domain != ''){
					$resHtml .= "<td>{$account['domain']}</td>";
				}else{
					$resHtml .= "<td><a href=\"?cmd=accounts&action=edit&id={$account['id']}&define=domainname\">Edit</a></td>";
				}
				$resHtml .= "<td>{$account['name']}";
				$checkHypervisor	=	 self::internalNetwayHypervisor(array($account['id']=>array('id'=> $account['id'])));
				if(isset($checkHypervisor[$account['id']]['cPanel']) && $checkHypervisor[$account['id']]['cPanel'] == '1'){
					$resHtml .= "<div style=\"cursor: pointer;\" class=\"right inlineTags\">";
					$resHtml .= '<form id="login_form'.$account['id'].'" name="login_form'.$account['id'].'" action="https://'.$account['domain'].':2083/login/" method="post" target="_blank">
							           <input name="user" id="user" value="'.$checkHypervisor[$account['id']]['cPanelLogin']['user'].'" type="hidden">
							           <input name="pass" id="pass" value="'.$checkHypervisor[$account['id']]['cPanelLogin']['password'].'" type="hidden">
							           <input type="hidden" name="goto_uri" value="" />
							     </form>';
					$resHtml .= "<a onclick=\"$('#login_form{$account['id']}').submit();\">&nbsp;cPanel</a>";
					$resHtml .= "</div>";
					if(preg_match("/Reseller/i",$account['name'])){
						$resHtml .= "<div style=\"cursor: pointer;\" class=\"right inlineTags\">";
						$resHtml .= '<form id="login_form_whm'.$account['id'].'" name="login_form'.$account['id'].'" action="https://'.$account['domain'].':2087/login/" method="post" target="_blank">
								           <input name="user" id="user" value="'.$checkHypervisor[$account['id']]['cPanelLogin']['user'].'" type="hidden">
								           <input name="pass" id="pass" value="'.$checkHypervisor[$account['id']]['cPanelLogin']['password'].'" type="hidden">
								           <input type="hidden" name="goto_uri" value="" />
								     </form>';
						$resHtml .= "<a onclick=\"$('#login_form_whm{$account['id']}').submit();\">&nbsp;WHM</a>";
						$resHtml .= "</div>";
					}
				}
				if(isset($checkHypervisor[$account['id']]['tags']['netway']) && $checkHypervisor[$account['id']]['tags']['netway'] == '1'){
					$resHtml .= "<div class=\"right inlineTags\"><span>Internal netway</span>&nbsp;</div>";
				}
				if(isset($checkHypervisor[$account['id']]['tags']['hypervisor']) && $checkHypervisor[$account['id']]['tags']['hypervisor'] == '1'){
					$resHtml .= "<div class=\"right inlineTags\"><span>Hypervisor</span>&nbsp;</div>";
				}
				$resHtml .= "</td>";
				$total	= number_format($account['total'], 2, '.', ',');
				$resHtml .= "<td>{$total} บาท</td>";
				$resHtml .= "<td>{$account['billingcycle']}</td>";
				$resHtml .= "<td><span class=\"{$account['status']}\">{$account['status']}</span></td>";
				
				$post = array(
                    'call'      => 'module',
                    'module'    => 'billingcycle',
                    'fn'        => 'getAccountExpiryDate',
                    'accountId' => $account['id'],
                    'nextDue'   => $account['next_due']
                );
				
				$response = billingcycle_controller::getAccountExpiryDate($post);
				$expDate	= $response[1]['expire']; 

				$resHtml .= "<td>{$expDate}</td>";
				$next_due	= date('d M Y' , strtotime($account['next_due']));
				$resHtml .= "<td>{$next_due}</td>";
				$resHtml .= "<td><a href=\"?cmd=accounts&action=edit&id={$account['id']}\"  class=\"editbtn\" target=\"_blank\">Edit</a></td>";
				$resHtml .= "</tr>";
				
			}
			$resHtml .= "</tbody></table>";	
		}else{
			$resHtml .= '<center><h3><font color=red>Nothing to display.</font><h3></center>';
		}
		
		$this->loader->component('template/apiresponse', 'json');
        $this->json->assign('data', $resHtml);
        $this->json->show();
	}
    
    public function search ($request)
    {
        $db         = hbm_db();
        
        $keyword    = isset($request['keyword']) ? $request['keyword'] : '';
        
        $result     = $db->query("
                SELECT a.id, a.domain, 
                    ca.id AS clientId, ca.email,
                    cd.firstname, cd.lastname, cd.companyname,
                    s.name AS service
                FROM hb_accounts a
                    LEFT JOIN hb_servers s
                        ON a.server_id = s.id,
                    hb_client_access ca,
                    hb_client_details cd
                WHERE a.client_id = ca.id
                    AND ca.id = cd.id
                    AND a.status IN ('Active', 'Suspended')
                    AND (
                        a.domain LIKE :keyword
                        OR ca.email LIKE :keyword
                        OR cd.firstname LIKE :keyword
                        OR cd.lastname LIKE :keyword
                        OR cd.companyname LIKE :keyword
                    )
                LIMIT 10
                ", array(
                    ':keyword'  => '%'. $keyword .'%'
                ))->fetchAll();
        
        echo '<!-- {"ERROR":[],"INFO":["Success"]'
            . ',"DATA":['. json_encode($result) .']'
            . ',"STACK":0} -->';
            
        exit;
    }
    
    public function listAccountSuspended ($orderby, $order, $offset, $limit)
    {
        $db         = hbm_db();
        
        $result     = $db->query("
            SELECT acc.id,acc.manual, acc.domain, acc.billingcycle, 
                acc.status, acc.total, acc.next_due, prod.name, prod.type, 
                cd.lastname, cd.firstname, acc.client_id, cb.currency_id,
                COALESCE(com.paytype,'Free') paytype,
                acc.expiry_date
            FROM hb_accounts acc 
                LEFT JOIN hb_common com ON com.id=acc.product_id AND com.rel='Product'
                LEFT JOIN hb_products prod ON (prod.id=acc.product_id) 
                LEFT JOIN hb_product_types pt ON (pt.id=prod.type)
                LEFT JOIN hb_client_details cd ON (cd.id=acc.client_id) 
                LEFT JOIN hb_client_billing cb ON (cb.client_id=acc.client_id)
            WHERE acc.status='Suspended'
            ORDER BY acc.{$orderby} {$order}  
            LIMIT $offset, {$limit}
            ")->fetchAll();
        
        
        
        return $result;
    }
    
    public function afterCall ($request)
    {
        $aAdmin         = hbm_logged_admin();
        $this->template->assign('oAdmin', (object)$aAdmin);
        
        $_SESSION['notification']   = array();
    }

    public function hookAfterAccountCreate ($accountId)
    {

        /**
         * Update invoice item  is_shipped ว่าได้จัดส่งสินค้า แล้ว
         */
         $result    = accounthandle_model::singleton()->getInvoiceItemFromAccountOrder($accountId);
         if (isset($result['id'])) {
            accounthandle_model::singleton()->setInvoiceItenIsShip($result['id']);
         }

    }

}