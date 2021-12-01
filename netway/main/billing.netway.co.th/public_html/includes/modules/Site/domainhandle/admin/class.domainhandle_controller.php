<?php

require_once dirname(__DIR__) . '/model/class.domainhandle_model.php';

class domainhandle_controller extends HBController {
    
    private static  $instance;
    
    public static function singleton ()
    {
        if (!isset(self::$instance)) {
            $c = __CLASS__;
            self::$instance = new $c();
        }

        return self::$instance;
    }
    
    public function predefineDomainContact ($request)
    {
        $db     = hbm_db();
        
        $id         = isset($request['id']) ? $request['id'] : 0;
        $aContact   = isset($request['extended']) ? unserialize($request['extended']) : array();
        
        if (! $id) {
            return false;
        }
        
        if (! isset($aContact['registrant'])) {
            return false;
        }
        
        if (! isset($aContact['registrant']['companyname']) || ! $aContact['registrant']['companyname']) {
            $aContact['registrant']['companyname']  = $aContact['registrant']['firstname'];
        }
        
        $address1   = $aContact['registrant']['address1'];
        $address2   = $aContact['registrant']['address2'];
        
        if (strlen($address1) > 99) {
            $address    = substr($address1, 0, 99);
            $aContact['registrant']['address1'] = $address;
            $address    = substr($address1, 99) .' '. $address2;
            
            if (strlen($address) > 99) {
                $address    = substr($address, 0, 99);
            }
            $aContact['registrant']['address2'] = $address;
            
        }
        if (strlen($address2) > 99) {
            $address    = substr($address2, 0, 99);
            $aContact['registrant']['address2'] = $address;
        }
        
        if (! $aContact['registrant']['city']) {
            $aContact['registrant']['city']         = 'Bangsue';
        }
        if (! $aContact['registrant']['state']) {
            $aContact['registrant']['state']        = 'Bangkok';
        }
        if (! $aContact['registrant']['postcode']) {
            $aContact['registrant']['postcode']     = '10800';
        }
        if (! $aContact['registrant']['country']) {
            $aContact['registrant']['country']      = 'TH';
        }
        
        $aContact['registrant']['phonenumber']  = preg_replace('/[^0-9]/', '', $aContact['registrant']['phonenumber']);
        $aContact['registrant']['fax']          = preg_replace('/[^0-9]/', '', $aContact['registrant']['fax']);
        
        $aContact['admin']      = $aContact['registrant'];
        $aContact['billing']    = $aContact['registrant'];
        
        $db->query("
            UPDATE hb_domains
            SET extended = '". serialize($aContact) ."'
            WHERE id = :id
            ", array(
                ':id'   => $id
            ));
        
        return true;
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
        
    }
    
    public function updateDateCreated ($request)
    {
        $db             = hbm_db();
        
        $domainId       = isset($request['id']) ? $request['id'] : 0;
        $dateCreated    = isset($request['date_created']) ? $request['date_created'] : '';
        $status         = isset($request['status']) ? $request['status'] : '';
        
        if (! $domainId || $dateCreated != '0000-00-00' || $status != 'Active') {
            return false;
        }
        
        $result         = $db->query("
                SELECT dl.id, dl.date
                FROM hb_domain_logs dl
                WHERE dl.domain_id = :domainId
                    AND dl.result = '1'
                    AND dl.change LIKE '%status%from%Pending%Active%'
                ORDER BY dl.date ASC 
                ", array(
                    ':domainId' => $domainId
                ))->fetch();
        
        if (! isset($result['date'])) {
            return false;
        }
        
        $dateCreated    = $result['date'];
        
        $db->query("
            UPDATE hb_domains
            SET date_created = :dateCreated
            WHERE id = :domainId
            ", array(
                ':dateCreated'  => $dateCreated,
                ':domainId'     => $domainId
            ));
        
        return true;
    }

	public function ajaxFilterDomainByClientId($request){
		
		$db         = hbm_db();
        
        $keyword    = isset($request['data']) ? $request['data'] : '';
		$client_id	= isset($request['client_id']) ? $request['client_id'] : '';
        
        $result     = $db->query("
                SELECT d.id, d.manual, d.name, cd.lastname, 
                    cd.firstname,  cd.id as cid, d.period, d.recurring_amount, 
                    cb.currency_id,m.module, d.next_due, d.expires, d.status, d.type, 
                    d.date_created, d.autorenew, d.reglock, d.idprotection 
                    FROM hb_domains d 
                    LEFT JOIN hb_client_details cd ON (d.client_id=cd.id) 
                    LEFT JOIN hb_client_billing cb ON (cb.client_id=d.client_id) 
                    LEFT JOIN hb_modules_configuration m ON (d.reg_module=m.id) 
                    WHERE 
		 				d.client_id = :client_id
		 				AND (d.name LIKE :keyword OR d.id LIKE :keyword) 
		 			ORDER BY d.`id` DESC 
                ", array(
                    ':keyword'  		=> '%'. $keyword .'%' ,
                    ':client_id'		=>	$client_id	
                ))->fetchAll();
		
		$resHtml = '';
		if(count($result) > 0){
			$resHtml = ' <table cellspacing="0" cellpadding="3" border="0" width="100%" class="glike hover">
						 <thead>
							<tr>
								<th>ID #</th>
								<th>Domain</th>
								<th>Poriod</th>
								<th>Registrar</th>
								<th>Status</th>
								<th>Amount</th>
								<th>Expiry Date</th>
								<th width="20"/>
							  </tr>
						 </thead>';
			$resHtml .= "<tbody>";
			foreach($result as $domain){
				
				$resHtml .= "<tr>";
				$resHtml .= "<td><a href=\"?cmd=domains&action=edit&id={$domain['id']}\" target=\"_blank\">{$domain['id']}</a></td>";
				$resHtml .= "<td>";
				if($domain['type'] == 'Transfer'){
					$resHtml .= "Transfer: ";
				}
				$resHtml .= "{$domain['name']}</td>";
				$resHtml .= "<td>{$domain['period']} Year/s</td>";
				$resHtml .= "<td>{$domain['module']}</td>";
				$resHtml .= "<td><span class=\"{$domain['status']}\">{$domain['status']}</span></td>";
				$total	= number_format($domain['recurring_amount'], 2, '.', ',');
				$resHtml .= "<td>{$total} บาท</td>";
				if($domain['expires'] == '' || $domain['expires'] == '0000-00-00'){
					 $expDate = '-'; 
				}else{
					 $expDate	= date('d M Y' , strtotime($domain['expires'])); 
				}
				$resHtml .= "<td>{$expDate}</td>";
				$resHtml .= "<td><a href=\"?cmd=domains&action=edit&id={$domain['id']}\"  class=\"editbtn\" target=\"_blank\">Edit</a></td>";
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
    
    public function getDomainLock ($request)
    {
        $db         = hbm_db();
        
        $domainId   = isset($request['id']) ? $request['id'] : 0;
        
        $result     = $db->query("
            SELECT c2a.*
            FROM hb_domains d,
                hb_config2accounts c2a,
                hb_config_items ci,
                hb_config_items_cat cic
            WHERE d.id = :domainId
                AND d.id = c2a.account_id
                AND c2a.rel_type = 'Domain'
                AND c2a.config_id = ci.id
                AND c2a.config_cat = cic.id
                AND cic.variable = 'lock_domain'
            ", array(
                ':domainId' => $domainId
            ))->fetch();
        
        $isLock     = (isset($result['data']) && $result['data']) ? 1 : 0;
        
        return $isLock;
    }

    public function DomainRegisterDocument($request){
        $db         = hbm_db();
        
        $productId  = isset($request['productId']) ? $request['productId'] : 0;
        $documentText       = isset($request['documentText']) ? $request['documentText'] : '';
        
        if (! $productId) {
            echo '<!-- {"ERROR":["Product ID ผิดพลาด"],"INFO":[]'
                . ',"STACK":0} -->';
            exit;
        }
        
        $db->query("
            UPDATE hb_products
            SET reg_document = :documentText
            WHERE id = :id
            ", array(
                ':id'               => $productId,
                ':documentText'     => $documentText
            ));
        
        echo '<!-- {"ERROR":[],"INFO":["Update ข้อมูลเรียบร้อยแล้ว"]'
            . ',"STACK":0} -->';
        exit;
    }
    
    public function DomainRegisterDocumentKb($request){
        $db         = hbm_db();
        
        $productId  = isset($request['productId']) ? $request['productId'] : 0;
        $documentKbText       = isset($request['documentKbText']) ? $request['documentKbText'] : '';
        
        if (! $productId) {
            echo '<!-- {"ERROR":["Product ID ผิดพลาด"],"INFO":[]'
                . ',"STACK":0} -->';
            exit;
        }
        
        $db->query("
            UPDATE hb_products
            SET reg_document_kb = :documentKbText
            WHERE id = :id
            ", array(
                ':id'               => $productId,
                ':documentKbText'     => $documentKbText
            ));
        
        echo '<!-- {"ERROR":[],"INFO":["Update ข้อมูลเรียบร้อยแล้ว"]'
            . ',"STACK":0} -->';
        exit;
    }
    
    public function getDomainRegisterDocument($domainId){
        $db         = hbm_db();
        
        $domainId   = isset($domainId) ? $domainId : 0;
        
        $result     = $db->query("
            SELECT id , name , reg_document , reg_document_kb
            FROM hb_products
            WHERE id = :domainId
            ", array(
                ':domainId' => $domainId
            ))->fetch();
        
        return $result;
    }
    
    public function CategoryPromotion($request){
        
        $db         = hbm_db();
        
        $categoryId                = isset($request['categoryId']) ? $request['categoryId'] : 0;
        $promotionText             = isset($request['promotionText']) ? $request['promotionText'] : '';
        
        if (! $categoryId) {
            echo '<!-- {"ERROR":["Product ID ผิดพลาด"],"INFO":[]'
                . ',"STACK":0} -->';
            exit;
        }
        
        $db->query("
            UPDATE hb_categories
            SET promotion = :promotionText
            WHERE id = :id
            ", array(
                ':id'               => $categoryId,
                ':promotionText'     => $promotionText
            ));
        
        echo '<!-- {"ERROR":[],"INFO":["Update ข้อมูลเรียบร้อยแล้ว"]'
            . ',"STACK":0} -->';
        exit;
        
    } 
    
    public function getCategoryPromotion($categoryId){
        $db         = hbm_db();
        
        $categoryId   = isset($categoryId) ? $categoryId : 0;
        
        $result     = $db->query("
            SELECT id , name , promotion , codeName
            FROM hb_categories
            WHERE id = :categoryId
            ", array(
                ':categoryId' => $categoryId
            ))->fetch();
        
        return $result;
    }
    
    public function afterCall ($request)
    {
        $_SESSION['notification']   = array();
    }

    public function hookAfterDomainRegister ($domainId)
    {
        /**
         * Update invoice item  is_shipped ว่าได้จัดส่งสินค้า แล้ว
         */
        $result    = domainhandle_model::singleton()->getInvoiceItemFromDomainOrder($domainId, 'Domain Register');
        if (isset($result['id'])) {
            domainhandle_model::singleton()->setInvoiceItenIsShip($result['id']);
        }


    }

    public function hookAfterDomainRenew ($domainId)
    {
        /**
         * Update invoice item  is_shipped ว่าได้จัดส่งสินค้า แล้ว
         */
        $result    = domainhandle_model::singleton()->getInvoiceItemFromDomainOrder($domainId, 'Domain Renew');
        if (isset($result['id'])) {
            domainhandle_model::singleton()->setInvoiceItenIsShip($result['id']);
        }


    }

    public function hookAfterDomainSave ($domainId)
    {
        /**
         * Update invoice item  is_shipped ว่าได้จัดส่งสินค้า แล้ว
         */
        if (isset($_POST['is_shipped']) && $_POST['is_shipped']) {
            domainhandle_model::singleton()->setInvoiceItenIsShip($_POST['is_shipped']);
        }


    }

    public function hookAfterDomainTransfer ($domainId)
    {

        /**
         * Update invoice item  is_shipped ว่าได้จัดส่งสินค้า แล้ว
         */
        $result    = domainhandle_model::singleton()->getInvoiceItemFromDomainOrder($domainId, 'Domain Transfer');
        if (isset($result['id'])) {
            domainhandle_model::singleton()->setInvoiceItenIsShip($result['id']);
        }


    }

    # https://billing.netway.co.th/7944web/index.php?cmd=domainhandle&action=checkDomainExpireStatusActive&step=import
    # https://billing.netway.co.th/7944web/index.php?cmd=domainhandle&action=checkDomainExpireStatusActive&step=sync
    public function checkDomainExpireStatusActive ($request)
    {
        $db         = hbm_db();
        $api        = new ApiWrapper();

        $step       = isset($request['step']) ? $request['step'] : '';

        if ($step == 'import') {

            $result     = $db->query("
                SELECT d.id
                FROM hb_domains d
                    LEFT JOIN import_domain_check dc
                        ON dc.domain_id = d.id
                WHERE d.status = 'Active'
                    AND d.expires < NOW()
                    AND dc.domain_id IS NULL
                ORDER BY d.id ASC
                LIMIT 10
                ")->fetchAll();
            
            if (! count($result)) {
                echo 'Import done.';
                exit;
            }

            foreach ($result as $arr) {
                $db->query("
                    INSERT IGNORE INTO import_domain_check (
                        domain_id
                    ) VALUES (
                        :domain_id
                    )
                    ", array(
                        ':domain_id'    => $arr['id']
                    ));
            }

            echo '
                <script>
                setTimeout( function () {
                    document.location = "?cmd=domainhandle&action=checkDomainExpireStatusActive&step=import";
                },5000);
                </script>
                ';

        }

        if ($step == 'sync') {

            $aReport    = array();
            
            $result     = $db->query("
                SELECT d.id, d.name, mc.module
                FROM import_domain_check dc
                    LEFT JOIN hb_domains d
                        ON d.id = dc.domain_id
                    LEFT JOIN hb_modules_configuration mc
                        ON mc.id = d.reg_module
                WHERE dc.is_check = 0
                ORDER BY dc.domain_id ASC
                LIMIT 5
                ")->fetchAll();

            if (! count($result)) {
                echo 'Sync done.';
                exit;
            }
            
            $result_    = $result;
            foreach ($result_ as $arr) {
                $domainId       = $arr['id'];
                $domainName     = $arr['name'];
                $module         = $arr['module'];

                $status     = '';
                $expire     = '';
                $registrar  = '';

                $result     = $db->query("
                    SELECT *
                    FROM import_domain_opensrs
                    WHERE `1` = :1
                    ", array(
                        ':1'    => $domainName
                    ))->fetch();
                
                if (isset($result['id'])) {
                    $registrar  = 'domain_opensrs';
                    $status     = strtolower(trim($result['3']));
                    $expire     = date('Y-m-d', strtotime(trim($result['5'])));

                }

                if (! $status) {

                    $result     = $db->query("
                        SELECT *
                        FROM import_domain_srsplus
                        WHERE `1` = :1
                        ", array(
                            ':1'    => $domainName
                        ))->fetch();
                    
                    if (isset($result['id'])) {
                        $registrar  = 'domain_srsplus';
                        $status     = strtolower(trim($result['5']));
                        $expire     = date('Y-m-d', strtotime(trim($result['3'])));

                    }

                }

                if (! $status) {

                    $result     = $db->query("
                        SELECT *
                        FROM import_domain_resellerclub
                        WHERE `1` = :1
                        ORDER BY `10` DESC
                        ", array(
                            ':1'    => $domainName
                        ))->fetch();
                    
                    if (isset($result['id'])) {
                        $registrar  = 'domain_resellerclub';
                        $status     = strtolower(trim($result['9']));
                        $expire     = date('Y-m-d', strtotime(trim($result['10'])));

                    }

                }

                if (! $status) {

                    $result     = $db->query("
                        SELECT *
                        FROM import_domain_dotarai
                        WHERE `1` LIKE '". $domainName ."%'
                        ", array(

                        ))->fetch();
                    
                    if (isset($result['id'])) {
                        $registrar  = 'domain_dotarai';
                        $aExpire    = explode(' ', trim($result['2']));
                        $expire     = $aExpire[0];
                        $status     = isset($aExpire[1]) ? strtolower($aExpire[0]) : '';
                        $expire     = date('Y-m-d', strtotime($expire));

                    }

                }

                $isImportExist  = $registrar ? 1 : 0;

                if (preg_match('/opensrs/i', $module) && ! $registrar) {
                    $registrar  = 'domain_opensrs';
                }
                if (preg_match('/srsplus/i', $module) && ! $registrar) {
                    $registrar  = 'domain_srsplus';
                }
                if (preg_match('/resellerclub/i', $module) && ! $registrar) {
                    $registrar  = 'domain_resellerclub';
                }
                if (preg_match('/dotarai/i', $module) && ! $registrar) {
                    $registrar  = 'domain_dotarai';
                }

    
                $isExpire   = 0;

                if ($registrar) {

                    $note   = 'Domain exist';

                    if (! $expire) {
                        $expire = '1970-01-01';
                    }
                    if (strtotime($expire) < time()) {
                        $isExpire   = 1;
                    }
    
                    if ($isExpire) {
                        
                        $aParam     = array(
                            'id'    => $domainId,
                            'server_id'     => 98,
                            'reg_module'    => 110,
                            'expires'       => $expire,
                        );
                        $api->domainEdit($aParam);

                        $note   = 'Domain edit from '. $registrar .' to onlydomaindotcom';

                    }


                }

                $arr    = array(
                    'id'    => $domainId,
                    'registrar'     => $registrar,
                    'name'  => $domainName,
                    'isExpire'  => $isExpire,
                    'expire'    => $expire,
                    'note'      => $note,
                );
                $aReport[$domainId] = $arr;


                $note       = $note ? $note : 'No registrar';

                $db->query("
                    UPDATE import_domain_check
                    SET is_check = 1,
                        is_import_exist = :is_import_exist,
                        is_expire = :is_expire,
                        expire_date = :expire_date,
                        check_note = :check_note
                    WHERE domain_id = :domain_id
                    ", array(
                        ':domain_id'    => $domainId,
                        ':is_import_exist'  => $isImportExist,
                        ':is_expire'    => $isExpire,
                        ':expire_date'    => $expire,
                        ':check_note'   => $note,
                    ));
                


            }

            echo '<pre>'. print_r($aReport,true) .'</pre>';
            

            echo '
                <script>
                setTimeout( function () {
                    document.location = "?cmd=domainhandle&action=checkDomainExpireStatusActive&step=sync";
                },10000);
                </script>
                ';

        }



    }
    
}