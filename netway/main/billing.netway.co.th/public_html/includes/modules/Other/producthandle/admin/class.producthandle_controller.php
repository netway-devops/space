<?php

require_once(APPDIR .'class.cache.extend.php');

class producthandle_controller extends HBController {
    
    private static  $instance;
    
    public static function singleton ()
    {
        if (!isset(self::$instance)) {
            $c = __CLASS__;
            self::$instance = new $c();
        }

        return self::$instance;
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
        header('Location:?cmd=producthandle&action=report');
        exit;
    }
    
    public function provisionWithCapture ($request)
    {
        $db         = hbm_db();
        
        $result     = $db->query("
            SELECT *
            FROM hb_products_config
            WHERE 1
            ")->fetchAll();
        
        $aConfig    = array();
        if (count($result)) {
            foreach ($result as $arr) {
                $aConfig[$arr['id']]    = $arr['provision_with_capture'];
            }
        }
        
        $aList      = array('hosting' => array(),'domains' => array());
        if (isset($request['hosting']) && count($request['hosting'])) {
            foreach ($request['hosting'] as $arr) {
                $aList['hosting'][$arr['id']]   = isset($aConfig[$arr['product_id']]) ? $aConfig[$arr['product_id']] : 0;
            }
        }
        if (isset($request['domains']) && count($request['domains'])) {
            $aDomain    = array();
            foreach ($request['domains'] as $arr) {
                if (isset($arr['id'])) {
                    array_push($aDomain, $arr['id']);
                }
            }
            
            if (count($aDomain)) {
                
                $result     = $db->query("
                    SELECT *
                    FROM hb_domains
                    WHERE id IN (". implode(',', $aDomain) .")
                    ")->fetchAll();
                
                $aDomain    = array();
                if (count($result)) {
                    foreach ($result as $arr) {
                        $aDomain[$arr['id']]    = $arr['tld_id'];
                    }
                }
                
                foreach ($request['domains'] as $arr) {
                    $productId  = $aDomain[$arr['id']];
                    $aList['domains'][$arr['id']]   = isset($aConfig[$productId]) ? $aConfig[$productId] : 0;
                }
            
            }
            
        }
        
        
        
        return $aList;
    }
    
    public function getConfig ($request)
    {
        $db         = hbm_db();
        
        $productId  = isset($request['id']) ? $request['id'] : 0;
        $isReturn   = isset($request['isReturn']) ? $request['isReturn'] : 0;
        
        $result     = $db->query("
            SELECT *
            FROM hb_products_config
            WHERE id = :productId
            ", array(
                ':productId'    => $productId
            ))->fetch();
        
        $result     = self::_getConfigFulfillment($result);
        
        if ($isReturn) {
            return $result;
        }
        
        $this->loader->component('template/apiresponse', 'json');
        $this->json->assign('data', $result);
        $this->json->show();
    }

    public function setProductDBCConfig($request){
        $db         = hbm_db();
        
        $productId  = isset($request['productId']) ? $request['productId'] : 0;
        $field  = isset($request['field']) ? $request['field'] : '';
        $value   = isset($request['value']) ? $request['value'] : '';

        if($productId != 0){
            $db->query("
            UPDATE hb_products
            SET {$field} = :value
            WHERE id = :productId
            ", array(
                ':productId'    => $productId,
                ':value'        => $value
            ));
        }
        
    }
    
    public function getConfigAddonByProduct ($request)
    {
        $db         = hbm_db();
        $accountId  = isset($request['accountId']) ? $request['accountId'] : 0;
        
        $result     = $db->query("
            SELECT *
            FROM hb_accounts_addons
            WHERE account_id = :accountId
            ", array(
                ':accountId'    => $accountId
            ))->fetch();
        $request['id']  = isset($result['addon_id']) ? $result['addon_id'] : 0;
        
        return $this->getConfigAddon($request);
    }
    
    public function getConfigAddon ($request)
    {
        $db         = hbm_db();
        
        $productId  = isset($request['id']) ? $request['id'] : 0;
        $isReturn   = isset($request['isReturn']) ? $request['isReturn'] : 0;
        
        $result     = $db->query("
            SELECT *
            FROM hb_addons_config
            WHERE id = :productId
            ", array(
                ':productId'    => $productId
            ))->fetch();
        
        $result     = self::_getConfigFulfillment($result);
        
        if ($isReturn) {
            return $result;
        }
        
        $this->loader->component('template/apiresponse', 'json');
        $this->json->assign('data', $result);
        $this->json->show();
    }
    
    private function _getConfigFulfillment ($request)
    {
        $db         = hbm_db();
        
        $arr        = array();
        array_push($arr, 0);
        array_push($arr, ($request['fulfillment_create_id'] ? $request['fulfillment_create_id'] : 0));
        array_push($arr, ($request['fulfillment_renew_id'] ? $request['fulfillment_renew_id'] : 0));
        array_push($arr, ($request['fulfillment_suspend_id'] ? $request['fulfillment_suspend_id'] : 0));
        array_push($arr, ($request['fulfillment_unsuspend_id'] ? $request['fulfillment_unsuspend_id'] : 0));
        array_push($arr, ($request['fulfillment_terminate_id'] ? $request['fulfillment_terminate_id'] : 0));
        array_push($arr, ($request['fulfillment_upgrade_id'] ? $request['fulfillment_upgrade_id'] : 0));
        array_push($arr, ($request['fulfillment_transfer_id'] ? $request['fulfillment_transfer_id'] : 0));
        array_push($arr, ($request['fulfillment_fraud_id'] ? $request['fulfillment_fraud_id'] : 0));
        
        $result     = $db->query("
            SELECT sc.id, CONCAT(c.name,' > ',sc.title) AS title
            FROM sc_service_catalog sc
                LEFT JOIN sc_category c
                ON c.id = sc.category_id
            WHERE sc.id IN (". implode(',', $arr) .")
            ")->fetchAll();
        
        $request['aFulfillment']    = array();
        if (count($result)) {
            $result_    = $result;
            foreach ($result_ as $arr) {
                $request['aFulfillment'][$arr['id']]    = $arr;
                
                $result     = $db->query("
                    SELECT pg.*
                    FROM sc_process_group pg
                    WHERE pg.sc_id = :scId
                    ", array(
                        ':scId'     => $arr['id']
                    ))->fetchAll();
                
                $request['aFulfillment'][$arr['id']]['aProcess']    = $result;
                
            }
        }
        
        
        
        return $request;
    }
    
    public function updateConfig ($request)
    {
        $db         = hbm_db();
        $aData      = array();
        
        $productId  = isset($request['productId']) ? $request['productId'] : 0;
        $config     = isset($request['config']) ? $request['config'] : '';
        $value      = isset($request['value']) ? $request['value'] : '';
        
        $result     = $db->query("
            SELECT *
            FROM hb_products_config
            WHERE id = :productId
            ", array(
                ':productId'    => $productId
            ))->fetch();
        
        if (! isset($result['id'])) {
            $db->query("INSERT INTO hb_products_config (id) VALUES (:productId)", array(':productId' => $productId));
        }
        
        $db->query("
            UPDATE hb_products_config
            SET {$config} = :value
            WHERE id = :productId
            ", array(
                ':productId'    => $productId,
                ':value'        => $value
            ));
        
        $this->loader->component('template/apiresponse', 'json');
        $this->json->assign('data', $aData);
        $this->json->show();
    }
    
    public function updateConfigAddon ($request)
    {
        $db         = hbm_db();
        $aData      = array();
        
        $productId  = isset($request['productId']) ? $request['productId'] : 0;
        $config     = isset($request['config']) ? $request['config'] : '';
        $value      = isset($request['value']) ? $request['value'] : '';
        
        $result     = $db->query("
            SELECT *
            FROM hb_addons_config
            WHERE id = :productId
            ", array(
                ':productId'    => $productId
            ))->fetch();
        
        if (! isset($result['id'])) {
            $db->query("INSERT INTO hb_addons_config (id) VALUES (:productId)", array(':productId' => $productId));
        }
        
        $db->query("
            UPDATE hb_addons_config
            SET {$config} = :value
            WHERE id = :productId
            ", array(
                ':productId'    => $productId,
                ':value'        => $value
            ));
        
        $this->loader->component('template/apiresponse', 'json');
        $this->json->assign('data', $aData);
        $this->json->show();
    }

    public function getAccountAddonByAddonStatus($aListProducts,$addonId){

        if(empty($aListProducts) || $addonId == '') return array();

        $db             = hbm_db();
        $aAccountAddon  =   array();

        foreach($aListProducts as $productId){
            $result     = $db->query("
                                SELECT aa.status, COUNT(aa.id) as total
                                FROM hb_accounts_addons as aa, hb_accounts as a
                                WHERE aa.account_id = a.id
                                AND a.product_id = :productId
                                AND aa.addon_id = :addonId
                                GROUP by aa.status
                            ", array(
                                ':productId'    =>  $productId,
                                ':addonId'      =>  $addonId
                            ))->fetchAll();
            
            if (count($result)) {
                $aTotal[$productId]   = array();               
                foreach($result as $value){
                    $color      = 'black';
                    switch ($value['status']) {
                        case 'Pending'      : 
                        {   $color = 'blue';    break;  }
                        case 'Active'       : 
                        {   $color = 'green';   break;  }
                        case 'Terminated'   : 
                        {    $color = 'red';    break;  }
                        case 'Cancelled'    : 
                        {   $color = 'gray';    break;  }
                    }
                    $aTotal[$productId]['acc']   .= '<a href="?cmd=accounts&list=all&filter%5Bproduct_id%5D='. $productId 
                    .''.'" title="'. $value['status'] 
                    .'" style="color:'. $color .'" target="_blank">'. $value['total'] .'</a> ';
                }
            }
            $aAccountAddon[$productId]    =   $result;
        }


        return $aTotal;

    }

    public function getTotalServiceStatus ($aCategory, $aProducts)
    {
        $db             = hbm_db();
        $aTotal         = array();
        $categoryId     =  $aCategory['id'];
        
        if (! count($aProducts)) {
            return $aTotal;
        }
        
        foreach ($aProducts as $pid => $arr) {
            
            $cacheKey   = md5(__FILE__ . __LINE__ . $pid . serialize($arr));
            $result     = CacheExtend::singleton()->get($cacheKey);
            
            if ($result == null) {
                 
                if ($categoryId == '1' || $categoryId == '121') {
                    $result     = $db->query("
                            SELECT status, COUNT(*) AS total 
                            FROM `hb_domains` 
                            WHERE tld_id = :productId 
                            GROUP BY status
                            ", array(
                                ':productId'    => $pid
                            ))->fetchAll();
                    
                } else {
                    $result     = $db->query("
                            SELECT status, COUNT(*) AS total 
                            FROM `hb_accounts` 
                            WHERE product_id = :productId 
                            GROUP BY status
                            ", array(
                                ':productId'    => $pid
                            ))->fetchAll();
                    
                }
                
                CacheExtend::singleton()->set($cacheKey, $result, 3600);
            }
        
            $aTotal[$pid]   = array();
			$allQty			= 0;
            $quantity		= 0;
            if (count($result)) {
                $count = 0;
                foreach ($result as $v) {
                    $color      = 'black';
                    if($v['status'] == 'PendingVerify') continue;
                    switch ($v['status']) {
                        case 'Pending Registration': 
                        	{
                        		$color = 'blue'; break;
                        	}
                        case 'Pending Transfer':
							{
								$color = 'blue'; break;
							}
                        case 'Pending'      : 
                        	{
                        		$color = 'blue'; break;
                        	}
                        case 'Active'       : 
                        	{
                        		$color = 'green'; break; 
							}
                        case 'Expired':
                        	{
                        		$color = 'orange'; break;
                        	}
                        case 'Terminated'   : 
                        	{
                        		$color = 'red'; break; 
							}
                        case 'Cancelled'    : 
                        	{
                        		$color = 'gray'; break;
                            }
                        case 'Suspended'    : 
                            {
                                $color = 'black'; break;
                            }
                    }
                   
                    if ($categoryId != '1' && $categoryId != '121') {$quantity	=	self::countProductQuantityByStatus($pid,$v['status']);}
                                
                    if($count > 0){
                        $aTotal[$pid]['acc'] .= ' / ';
                    } 
                    if ($categoryId == '1' || $categoryId == '121')  {
                        $aTotal[$pid]['acc']   .= '<a href="?cmd=domains&list=all&filter%5Btld_id%5D='. $pid 
                            .'&filter%5Bstatus%5D='. $v['status'] .'" title="'. $v['status'] 
                            .'" style="color:'. $color .'" target="_blank">'. $v['total'] .'</a> ';
                    } else {
                        if($count > 0){
                            $aTotal[$pid]['qty'] .= ' / ';
                        } 
                        $aTotal[$pid]['acc']   .= '<a href="?cmd=accounts&list=all&filter%5Bproduct_id%5D='. $pid 
                            .'&filter%5Bstatus%5D='. $v['status'] .'" title="'. $v['status'] 
                            .'" style="color:'. $color .'" target="_blank">'. $v['total'] .'</a> ';
							
						$aTotal[$pid]['qty']   .= '<a href="?cmd=accounts&list=all&filter%5Bproduct_id%5D='. $pid 
                            .'&filter%5Bstatus%5D='. $v['status'] .'" title="'. $v['status'] 
                            .'" style="color:'. $color .'" target="_blank">'. $quantity .'</a> ';
						$allQty += $quantity;
                    }
                    $count++;
                }
            }
			$lastStr	= $aTotal[$pid]['qty'] ;
        	$aTotal[$pid]['qty']	=	$lastStr;
		}
        return $aTotal;
    }

	private function countProductQuantityByStatus($productId , $status){
		
		$db             = hbm_db();
		
		$result			= $db->query("
							SELECT
								id , product_id , status
							FROM
								hb_accounts
							WHERE
								product_id = :productId
								AND status = :status
						  ", array(
						  		':productId'			=>	$productId ,
						  		':status'				=>	$status
						  ))->fetchAll();
		$aAllId = array();				  
		foreach($result as $key => $value){
			$aAllId[] = $value['id'];
		}				  
		$allId = implode(',', $aAllId);
		$quantity	=	0;	
        
        if (count($allId)) {			  		
		$result			=	$db->query("
								SELECT
									SUM(data) as sumQuantity
								FROM
									hb_config2accounts c2a , hb_config_items_cat cic
								WHERE
									c2a.config_cat = cic.id
									AND c2a.account_id IN ({$allId})
									AND cic.variable = 'quantity'
							  ")->fetch();
		  $quantity = isset($result['sumQuantity']) ? $result['sumQuantity'] : 0;
        }
	
		return $quantity;
	}
    
    public function report ($request)
    {
        $db         = hbm_db();
        
        $aCategory  = $this->_getCategory();
        $this->template->assign('aCategory', $aCategory);
        $aProducts  = $this->_getProduct();
        $this->template->assign('aProducts', $aProducts);
        $aAutomation    = $this->_getAutomation();
        $this->template->assign('aAutomation', $aAutomation);
        $aConfiguration = $this->_getConfiguration();
        $this->template->assign('aConfiguration', $aConfiguration);
        $aServiceCatalog    = $this->_getServiceCatalog();
        $this->template->assign('aServiceCatalog', $aServiceCatalog);
        $aProcessGroup      = $this->_getFulfillmentProcess();
        $this->template->assign('aProcessGroup', $aProcessGroup);
        $aEmailTemplate     = $this->_getEmailTemplate();
        $this->template->assign('aEmailTemplate', $aEmailTemplate);
        
        
        $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/report.tpl',array(), true);
    }
    
    private function _getCategory ()
    {
        $db         = hbm_db();
        
        $result     = $db->query("
            SELECT c.id, c.name , c.slug , c.opconfig
            FROM hb_categories c
            WHERE 1
            ORDER BY c.sort_order ASC
            ")->fetchAll();
        
        $aCategory  = array();
        
        foreach ($result as $arr) {
            $aCategory[$arr['id']]  = $arr;
        }
        
        return $aCategory;
    }
    
    private function _getarticle ()
    {
        $db         = hbm_db();
        
        $result     = $db->query("
            SELECT a.kb_article_id , a.title , a.html_url
            FROM hb_kb_article a
            WHERE 1
            ORDER BY a.kb_article_id ASC
            ")->fetchAll();
        
        $aArticle  = array();
        
        foreach ($result as $arr) {
            $aArticle[$arr['kb_article_id']]  = $arr;
        }
        
        return $aArticle;
    }

    private function _getSection ()
    {
        $db         = hbm_db();
        
        $result     = $db->query("
            SELECT a.kb_section_id , a.name
            FROM hb_kb_section a
            WHERE 1
            ORDER BY a.kb_section_id ASC
            ")->fetchAll();
        
        $aSection  = array();
        
        foreach ($result as $arr) {
            $aSection[$arr['kb_section_id']]  = $arr;
        }
        
        return $aSection;
    }
    
    private function _getZendeskCategory ()
    {
        $db         = hbm_db();
        
        $result     = $db->query("
            SELECT a.kb_category_id , a.name
            FROM hb_kb_category a
            WHERE 1
            ORDER BY a.kb_category_id ASC
            ")->fetchAll();
        
        $aCategory  = array();
        
        foreach ($result as $arr) {
            $aCategory[$arr['kb_category_id']]  = $arr;
        }
        
        return $aCategory;
    }
    
    private function _getPageSeo(){
        
        $db         = hbm_db();
        
        $result     = $db->query("
            SELECT *
            FROM hb_hostbill_seo
            WHERE 1
            AND type IN ('title' , 'description') 
            AND page = 'prodcat'
            ")->fetchAll(); 
        
        $aPageSeo  = array();
        
        foreach ($result as $arr) {
            $newID = substr($arr['unique_name'], 1);
            $newID = substr($newID, 0 , -7);
            $aPageSeo[$newID][$arr['type']]  = $arr['value'];
        }
        
        return $aPageSeo;
        
    }
    
    private function _getProduct ()
    {
        $db         = hbm_db();
        
        $result     = $db->query("
            SELECT p.id, p.category_id, p.name, p.type, p.autosetup,
                pc.provision_with_capture
            FROM hb_products p
                LEFT JOIN hb_products_config pc
                ON pc.id = p.id
            WHERE 1
            ORDER BY p.sort_order ASC
            ")->fetchAll();
        
        $aProduct   = array();
        
        foreach ($result as $arr) {
            $catId  = $arr['category_id'];
            if (! isset($aProduct[$catId])) {
                $aProduct[$catId]   = array();
            }
            $aProduct[$catId][$arr['id']]  = $arr;
        }
        
        return $aProduct;
    }
    
    private function _getAutomation ()
    {
        $db         = hbm_db();
        
        $result     = $db->query("
            SELECT c.*
            FROM hb_configuration c
            WHERE c.setting IN ('EnableAutoRegisterDomain', 'InvoiceGeneration')
            ")->fetchAll();
        
        $aAutomation    = array();
        
        foreach ($result as $arr) {
            $aAutomation[$arr['setting']]   = $arr['value'];
        }
        
        $result     = $db->query("
            SELECT a.*
            FROM hb_automation_settings a
            WHERE `type` IN ('Hosting', 'Domain')
            ")->fetchAll();
        
        foreach ($result as $arr) {
            $productId  = $arr['item_id'];
            if (! isset($aAutomation[$productId])) {
                $aAutomation[$productId]    = array();
            }
            $aAutomation[$productId][$arr['setting']]    = $arr['value'];
        }
        
        return $aAutomation;
    }
    
    private function _getConfiguration ()
    {
        $db         = hbm_db();
        
        $result     = $db->query("
            SELECT pc.*
            FROM hb_products_config pc
            WHERE 1
            ")->fetchAll();
        
        $aConfiguration     = array();
        
        foreach ($result as $arr) {
            $aConfiguration[$arr['id']] = $arr;
        }
        
        return $aConfiguration;
    }
    
    private function _getServiceCatalog ()
    {
        $db         = hbm_db();
        
        $result     = $db->query("
            SELECT sc.*
            FROM sc_service_catalog sc
            WHERE 1
            ")->fetchAll();
        
        $aServiceCatalog    = array();
        
        foreach ($result as $arr) {
            $aServiceCatalog[$arr['id']] = $arr;
        }
        
        return $aServiceCatalog;
    }
    
    private function _getFulfillmentProcess ()
    {
        $db         = hbm_db();
        
        $result     = $db->query("
            SELECT pg.*
            FROM sc_process_group pg
            WHERE 1
            ")->fetchAll();
        
        $aProcessGroup  = array();
        
        foreach ($result as $arr) {
            $aProcessGroup[$arr['id']] = $arr;
        }
        
        return $aProcessGroup;
    }
    
    private function _getEmailTemplate ()
    {
        $db         = hbm_db();
        
        $result     = $db->query("
            SELECT id, event, email_id
            FROM hb_email_assign
            WHERE rel = 'Product'
            ")->fetchAll();
        
        $aEmail     = array();
        
        foreach ($result as $arr) {
            $productId  = $arr['id'];
            $event      = $arr['event'];
            if (! isset($aEmail[$productId])) {
                $aEmail[$productId]   = array();
            }
            $aEmail[$productId][$event] = $arr;
        }
        
        $result     = $db->query("
            SELECT id, subject
            FROM hb_email_templates
            WHERE 1
            ORDER BY language_id ASC
            ")->fetchAll();
        
        $aEmailTemplate = array();
        
        foreach ($result as $arr) {
            $emailId    = $arr['id'];
            $aEmailTemplate[$emailId] = $arr;
        }
        
        $aEmail_    = $aEmail;
        foreach ($aEmail_ as $productId => $arr) {
            foreach ($arr as $event => $arr) {
                $emailId    = $arr['email_id'];
                $aEmail[$productId][$event]['subject']  = $aEmailTemplate[$emailId]['subject'];
            }
        }
        
        return $aEmail;
    }
    
    public function fulfillment ($request)
    {
        $db         = hbm_db();
        $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/fulfillment.tpl',array(), true);
    }
    
    public function orderpage ($request)
    {
        $db         = hbm_db();
        
        $aCategory  = $this->_getCategory();
        $this->template->assign('aCategory', $aCategory);
        $aArticle  = $this->_getarticle();
        $this->template->assign('aArticle', $aArticle);
        $aSection  = $this->_getSection();
        $this->template->assign('aSection', $aSection);
        $aZendeskCategory  = $this->_getZendeskCategory();
        $this->template->assign('aZendeskCategory', $aZendeskCategory);
        $aPageSeo    = $this->_getPageSeo();
        $this->template->assign(aPageSeo ,$aPageSeo);
        
        
        $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/orderpage.tpl',array(), true);
    }
    
    public function afterCall ($request)
    {
        $aAdmin         = hbm_logged_admin();
        $this->template->assign('oAdmin', (object)$aAdmin);
        
        $_SESSION['notification']   = array();
    }
}