<?php 
#@LICENSE@#
Class RVProductLicenseDao
{
    protected $dbh;
    
    public function __construct() {
        $this->dbh = hbm_db();
    }
    
    private function _buildwhere($where)
    {
        $whereCmd = '';
        if ($where != null) {
            if (is_scalar($where)) {
                $whereCmd = 'WHERE ' . $where;
            } elseif (is_array($where) || is_object($where)) {
                if (is_object($where)) {
                    $aWhere = (array) $where;
                } else {
                    $aWhere = $where;
                }
                $_sqlWhere = '';
                foreach ($aWhere as $k => $v) {
                    if ($_sqlWhere != '') {
                        $_sqlWhere = $_sqlWhere . ' AND ';
                    }
                    $_sqlWhere = $_sqlWhere . $k . '=' . $this->quote_smart($v);
                }
                $whereCmd = 'WHERE ' . $_sqlWhere;
            }
        }
        return $whereCmd;
    }
    
    
    public function quote_smart($value)
    {
        // Stripslashes
        if (get_magic_quotes_gpc()) {
            $value = stripslashes($value);
        }
        // Quote if not integer
        if (!is_numeric($value)) {
            $value = "'" .  $value . "'";
        }
        return $value;
    }
    
    public function &singleton($autoload=false) {
        static $instance;
        // If the instance is not there, create one
        if (!isset($instance) || $autoload) {
            $class = __CLASS__;
            $instance = new $class();
        }
        return $instance;
    }
    
    public function getIpByAccountId($accid)
    {
         $query = sprintf("
            SELECT
                acc.id,acc.product_id, acc.next_due,acc.firstpayment, ac.config_cat, ac.config_id, ac.data ,p.name
            FROM 
                hb_accounts acc
                INNER JOIN hb_config2accounts ac ON ( acc.id = ac.account_id )
                INNER JOIN hb_config_items_cat f ON ( ac.config_cat = f.id )
                INNER JOIN hb_products p ON (acc.product_id = p.id)
            WHERE 
                acc.id = %s
                AND f.variable = 'ip'
            "
            , $this->quote_smart($accid)
            );
         //   echo '=-========================>'.$query;exit;
        return $this->dbh->query($query)->fetch();
    } 
	
	public function getPbIpByAccountId($accid)
    {
         $query = sprintf("
            SELECT
                acc.id,acc.product_id, acc.next_due,acc.firstpayment, ac.config_cat, ac.config_id, ac.data ,p.name
            FROM 
                hb_accounts acc
                INNER JOIN hb_config2accounts ac ON ( acc.id = ac.account_id )
                INNER JOIN hb_config_items_cat f ON ( ac.config_cat = f.id )
                INNER JOIN hb_products p ON (acc.product_id = p.id)
            WHERE 
                acc.id = %s
                AND f.variable = 'public_ip'
            "
            , $this->quote_smart($accid)
            );
         //   echo '=-========================>'.$query;exit;
        return $this->dbh->query($query)->fetch();
    } 
	
	/*******************************************
	 * module : rvskin_perpetual_license/user
	 * dsc : ใช้แค่ตอน provisjion create
	 *****************************************/
	 public function calExpireDate($billingCycle,$next_due_date=''){
        //24/09/2013
        date_default_timezone_set('UTC');
        if ($next_due_date != '') {
            return strtotime($next_due_date);
        } else {
            $startDate = time();
        }
        $expiredate = '';
        $addMonth = 0;
        $addYear = 0;
        switch ($billingCycle) {
            case 'Monthly' : 
                $addMonth = 1;
                break;
                 case 'Quarterly' : 
                $addMonth = 3;
                break;
                 case 'Semi-Annually' : 
                $addMonth = 6;
                break;
                 case 'Annually' : 
                $addYear = 1;
                break;
        }
       
        return mktime(
                                date('H', $startDate),
                                date('i', $startDate),
                                date('s', $startDate),
                                date('n', $startDate) + $addMonth,
                                date('j', $startDate),
                                date('Y', $startDate) + $addYear
                            );
    }
    
    /*******************************************
	 * module : rvskin_perpetual_license/user
	 * dsc : ใช้สำหรับแก้ไจเรื่องราคา ถ้าเป็ฯ noc รายปี และ update ip
	 *****************************************/
	public function update_licenes_quota ($aParam)
	{
		if (isset($aParam['itype']) && isset($aParam['client']) && $aParam['client'] != '') {
			$fname = ($aParam['itype'] == '') ? 'quota_ded_max' : 'quota_vps_max';
		}
		$query = sprintf("
            UPDATE
                %s     
            SET 
                %s = (%s - 1),
                data_update =%s
            WHERE 
                client_id = %s
            "
            , 'hb_rv_license_quota'
            , $fname
            , $fname
            , time()
            , $this->quote_smart($aParam['client'])
            );
        if ($this->dbh->query($query)) { 
            return true;
        } else {
            return false;
        } 
	}
	
	/*******************************************
	 * module : rvskin_perpetual_license/user
	 * dsc : ใช้สำหรับแก้ไจเรื่องราคา ถ้าเป็ฯ noc รายปี และ update ip
	 *****************************************/
	public function updateAccountByAccid ($accid , $main_ip)
	{
		$query = sprintf("
            SELECT
                acc.id as account_id,
                o.invoice_id,
                ic.id as config_cat,
                ci.id as config_id 
            FROM 
                hb_accounts acc,hb_orders o,hb_config_items_cat ic,hb_config_items ci
            WHERE
                acc.order_id = o.id
                AND acc.product_id = ic.product_id
                AND ic.variable = 'ip'
                AND ic.id = ci.category_id
                AND acc.id=%s
            "
            , $this->quote_smart($accid)
            );
		// echo $query;
		$aData = $this->dbh->query($query)->fetch();
		if ($aData) {
			$aData['data'] = $main_ip;
			//$aData['price'] = $price;
			$resinsertIp = $this->insertIpToTableAccConfig($aData);
			
			return $aRes;
		} else {
			return false;
		}
	}
    /*******************************************
     * module : Rvproduct_trial
     * dsc : ใช้สำหรับแก้ไจ expire date
     *****************************************/
    public function updateExpireDateByAccid ($accid , $exp_date)
    {
        $query = sprintf("
            SELECT
                acc.id as account_id,
                o.invoice_id,
                ic.id as config_cat,
                ci.id as config_id 
            FROM 
                hb_accounts acc,hb_orders o,hb_config_items_cat ic,hb_config_items ci
            WHERE
                acc.order_id = o.id
                AND acc.product_id = ic.product_id
                AND ic.variable = 'expiration_date'
                AND ic.id = ci.category_id
                AND acc.id=%s
            "
            , $this->quote_smart($accid)
            );
        // echo $query;
        $aData = $this->dbh->query($query)->fetch();
        if ($aData) {
            $aData['data'] = $exp_date;
            //$aData['price'] = $price;
            $resinsertDate = $this->insertIpToTableAccConfig($aData);
            
            return $aRes;
        } else {
            return false;
        }
    }
	
	/*******************************************
	 * module : rvskin_perpetual_license/user
	 * dsc : ใช้สำหรับหาราคา
	 *****************************************/
	public function getPriceProductPerpetual($product_id)
	{
		$query = sprintf("
            SELECT
                cc.id,cc.a
            FROM 
                hb_common cc
            WHERE
                cc.rel = 'Product' 
                AND cc.id in (%s)
            "
            , $product_id
            );
           // echo $query;
		$aData = $this->dbh->query($query)->fetchall();
		if ($aData) {
			$aRes = array();
			foreach ($aData as $k=>$v) {
				$aRes[$v['id']] = $v['a'];
			}
		    	
			return $aRes;
		} else {
			return false;
		}
	}
	// เอาไว้ get จำนวน โค้วต้าที่เหลือ เพราะเจอบั๊กว่า จะเพิ่มได้เรื่อยๆ
	public function getQuota($client_id)
	{
		$query = sprintf("
            SELECT
                *
            FROM 
                 hb_rv_license_quota
            WHERE
                client_id = %s
            "
            , $client_id
            );
           // echo $query;
		$aData 	= $this->dbh->query($query)->fetch();
		$aRes 	= array();
		if ($aData) {
			$aRes['ded'] = $aData['quota_ded_max'];
			$aRes['vps'] = $aData['quota_vps_max'];
		} else {
			$aRes = false;
		}
		return $aRes;
	}
	
	/*******************************************
	 * module : rvskin_perpetual_license/user
	 * dsc : ใช้สำหรับหาว่า จะเป็น product id อะไร และราคาเท่าไหร่
	 * product id : 
	 * 92,93 = noc
	 * 81,82 = ทั่วไป
	 * 88,89 = Free
	 *****************************************/
	public function getAddLicensePerpetual($client_id,$server_type)
    {
		$query = sprintf("
            SELECT
                acc.id,acc.product_id
            FROM 
                hb_accounts acc
            WHERE 
                acc.product_id in (81,82,92,93,88,89)
                AND acc.client_id = %s
            LIMIT 0,1
            "
            , $this->quote_smart($client_id)
            );
            //echo $query;
		$aData = $this->dbh->query($query)->fetch();

		if ($aData) {
			$aProductNoc = array(92,93);
			$aProduct = array(81,82);
			  
			 
			  	
			  if (in_array($aData['product_id'],$aProductNoc)) {
          	  	    $aRes['product_id_ded'] = 92;
					$aRes['product_id_vps'] = 93;
					$getNumActive = $this->getActiveByClientId($client_id);
					$aRes['num_active'] = $getNumActive + 1;
          	  } elseif (in_array($aData['product_id'],$aProduct)) {
          	  		$aRes['product_id_ded'] = 81;
					$aRes['product_id_vps'] = 82;
					$aPrice = $this->getPriceProductPerpetual('81,82');
					$aRes['product_price_ded'] = $aPrice['81'];
					$aRes['product_price_vps'] = $aPrice['82'];
          	  } else {
          	  		$aRes['product_id_ded'] = 88;
					$aRes['product_id_vps'] = 89;
          	  }
          	//  echo '<pre>';print_r($aRes);
			  return $aRes;
		} else{
			return false;
		}
    } 

    public function getTransferLimitByAccid($where)
    {
        $_where = $this->_buildwhere($where);
        $query = '
            SELECT
                icount
            FROM
                hb_transfer_limit
        ' . $_where;
        $result = $this->dbh->query($query)->fetch();
	
        if (count($result) > 0) {
            return $result['icount'];
        }
        return false;
    }
	
    public function updateNextDueAccount ($aData=null)
    {
       $query = sprintf("
            UPDATE
                %s     
            SET 
                next_due = %s
            WHERE 
                id = %s
            "
            , 'hb_accounts'
            , $this->quote_smart($aData['next_due'])
            , $this->quote_smart($aData['id'])
            );
        if ($this->dbh->query($query)) { 
            return true;
        } else {
            return false;
        } 
    } 

    public function updateInvoiceById ($aData=null)
    {
       $query = sprintf("
            UPDATE
                %s     
            SET 
                subtotal = %s,
                total = %s,
                status = %s
            WHERE 
                id = %s
            "
            , 'hb_invoices'
            , $this->quote_smart($aData['subtotal'])
            , $this->quote_smart($aData['total'])
            , $this->quote_smart($aData['status'])
			, $this->quote_smart($aData['id'])
            );
        if ($this->dbh->query($query)) { 
            return true;
        } else {
            return false;
        } 
    } 
    
    public function updateInvoiceAccountStatusActiveById ($aData=null)
    {
       $this->dbh->query("
                          UPDATE 
                                hb_invoices
                          SET 
                                subtotal = :subtotal,
                                total    = :total,
                                status   = :status,
                                duedate  = :duedate
                          WHERE
                                id = :invid
                         ",array(':subtotal' => $aData['subtotal'],
                                 ':total'    => $aData['total'],
                                 ':status'   => $aData['status'],
                                 ':duedate'  => $aData['duedate'],
                                 ':invid'    => $aData['id']));
        
    } 
    
    public function updateInvoiceItemByInvId ($aData=null)
    {
       $query = sprintf("
            UPDATE
                %s     
            SET 
                description = CONCAT(description,%s),
                amount = %s
            WHERE 
                invoice_id = %s
            "
            , 'hb_invoice_items'
            , $this->quote_smart($aData['ip'])
            , $this->quote_smart($aData['amount'])
			, $this->quote_smart($aData['invoice_id'])
            );
            echo $query;
        if ($this->dbh->query($query)) { 
            return true;
        } else {
            return false;
        } 
    } 
    
    public function UpdateTransferLimitByAccid ($aData=null)
    {
       $query = sprintf("
            UPDATE
                %s     
            SET 
                icount = %s,
                date_update = %s
            WHERE 
                acc_id = %s
            "
            , 'hb_transfer_limit'
            , $this->quote_smart($aData['icount'])
            , time()
            , $this->quote_smart($aData['acc_id'])
            );
        if ($this->dbh->query($query)) { 
            return true;
        } else {
            return false;
        } 
    } 
    
    public function insertIpToTableAccConfig ($param)
    {
    	$chkdata = sprintf("
            SELECT
                data
            FROM 
                hb_config2accounts
            WHERE 
                account_id = %s
                AND config_cat = %s
                AND config_id = %s
            LIMIT 0,1
            "
            , $this->quote_smart($param['account_id'])
			, $this->quote_smart($param['config_cat'])
			, $this->quote_smart($param['config_id'])
            );
            //echo $query;
		$aData = $this->dbh->query($chkdata)->fetch();
		if ($aData) {
			return true;
		}
    	$query = sprintf("
                INSERT INTO 
                    %s              
                    (rel_type, account_id, config_cat, config_id, qty, data)
                VALUES
                    (   %s , %s , %s , %s , %s , %s)
                "
                , 'hb_config2accounts'
                , $this->quote_smart('Hosting')
                , $this->quote_smart($param['account_id'])
				, $this->quote_smart($param['config_cat'])
				, $this->quote_smart($param['config_id'])
				, 1
				, $this->quote_smart($param['data'])
            );
            if ($this->dbh->query($query)) {
                return true;
            } else {
                return false;
            }
    }
	
    public function InsertTransferLimitByAccid ($accid)
    {
        $getCount = $this->getTransferLimitByAccid(array('acc_id'=>$accid));
        
        if ($getCount == false) {
            $query = sprintf("
                INSERT INTO 
                    %s              
                    (acc_id,icount,date_update)
                VALUES
                    (   %s , %s , %s)
                "
                , 'hb_transfer_limit'
                , $this->quote_smart($accid)
                , 1
                , time()
            );
            if ($this->dbh->query($query)) {
                return true;
            } else {
                return false;
            }
        } else {
            (int)$getCount++;
            $res = $this->UpdateTransferLimitByAccid(array('icount'=>$getCount,'acc_id'=>$accid));
            if ($res == true) {
                return $getCount;
            }
            return false;
        }
    }
	
    public function UpdateIpToNAFormCustomByAccid ($aData=null)
    {
       $query = sprintf("
            UPDATE
                %s     
            SET 
                data = %s
            WHERE 
                account_id = %s
                AND data = %s
            "
            , 'hb_config2accounts'
            , $this->quote_smart($aData['data'])
            , $this->quote_smart($aData['account_id'])
            , $this->quote_smart($aData['ip_old'])
            );
			//echo $query;
        if ($this->dbh->query($query)) {
        	 
            return true;
        } else {
            return false;
        } 
    } 
	
    public function UpdateIpFormCustom ($aData=null)
    {
       $query = sprintf("
            UPDATE
                %s     
            SET 
                data = %s
            WHERE 
                account_id = %s
                AND config_cat = %s
                AND config_id = %s
            "
            , 'hb_config2accounts'
            , $this->quote_smart($aData['data'])
            , $this->quote_smart($aData['account_id'])
            , $this->quote_smart($aData['config_cat'])
            , $this->quote_smart($aData['config_id'])
            );
        if ($this->dbh->query($query)) { 
            return true;
        } else {
            return false;
        } 
    } 
    
    public function insertInvoiceItem ($aData=null)
    {
        $query = sprintf("
            INSERT INTO 
                %s              
                (invoice_id, item_id, type, description, amount, taxed, qty)
            VALUES
            	(   %s , %s , %s, %s , %s , %s, %s )
            "
            , 'hb_invoice_items'
            , $this->quote_smart($aData['invoice_id'])
            , $this->quote_smart($aData['item_id'])
            , $this->quote_smart($aData['type'])
            , $this->quote_smart($aData['description'])
            , $this->quote_smart($aData['amount'])
            , $this->quote_smart($aData['taxed'])
			, $this->quote_smart($aData['qty'])
        );
        if ($this->dbh->query($query)) {
            return true;
        } else {
            return false;
        }
    }
	
	public function save_log_renew ($aData=null)
	{
		$query = sprintf("
            INSERT INTO 
                %s              
                (account_id, itype,dt_update)
            VALUES
            (   %s , %s ,%s)
            "
            , 'hb_rv_renew_log'
            , $this->quote_smart($aData['account_id'])
            , $this->quote_smart($aData['itype'])
            , $this->quote_smart($aData['dt_update'])
           
        );
        if ($this->dbh->query($query)) {
            return true;
        } else {
            return false;
        }
	} 
    public function InsertLogTransferIp ($aData=null)
    {
        $query = sprintf("
            INSERT INTO 
                %s              
                (from_ip, acc_id,to_ip, create_date, active_by, active_id, product_type)
            VALUES
            (   %s , %s ,%s, %s , %s, %s, %s)
            "
            , 'hb_transfer_log'
            , $this->quote_smart($aData['from_ip'])
            , $this->quote_smart($aData['acc_id'])
            , $this->quote_smart($aData['to_ip'])
            , time()
            , $this->quote_smart($aData['active_by'])
            , $this->quote_smart($aData['active_id'])
            , $this->quote_smart($aData['product_type'])
        );
        if ($this->dbh->query($query)) {
            return true;
        } else {
            return false;
        }
    }
	
    /*******************************************
	 * module : rvskin_perpetual_license/user
	 * dsc : ใช้สำหรับหาว่า หาจำนวน่ เพื่อที่จะเอาไป renew
	 *****************************************/
	public function getActiveByClientId($clientid)
	{
		$result = array();
        $query = "
			SELECT
           		count(a.id) as num
			FROM 
				hb_accounts a,
				hb_products p,
				hb_categories c

			WHERE 
				a.product_id = p.id
				and p.category_id = c.id
				and c.id = 9
				and a.client_id =  " . $clientid . "
        	GROUP BY 
        		a.client_id
        	";
        $result = $this->dbh->query($query)->fetch();
        if ($result){
        	return $result['num'];
        } 
        return 0;
	}
 
    public function getCheckProductLicenseByAccid($accid)
    {
		// return true;
        $result = array();
        $query = "
            SELECT
                a.product_id, c.email
            FROM
              	hb_accounts a,hb_client_access c
            WHERE 
            	a.client_id = c.id
            	AND a.id = " . $accid . "
        	ORDER BY 
        		a.id DESC
        	";
        $result = $this->dbh->query($query)->fetch();
        return $result;
    }
    
    public function getTransferLog($where)
    { 
       // return true;
        $result = array();
        $_where = $this->_buildwhere($where);
        $query = '
            SELECT
                l.* , FROM_UNIXTIME(l.create_date,"%Y-%m-%d %H:%i:%s") as datecreate
            FROM
                hb_transfer_log l
        ' . $_where . ' GROUP BY l.create_date , l.active_by ORDER BY l.create_date DESC';
        $result = $this->dbh->query($query)->fetchAll();
        return $result;
    }
	
	public function getProductTransfer($where)
    {
        $_where = $this->_buildwhere($where);
        $query = '
            SELECT
                id
            FROM
                hb_products
        ' . $_where;
    	//echo $query;//exit;
        $result = $this->dbh->query($query)->fetchAll();
        if (count($result) > 0) {
            return $result[0]['id'];
        }
        return '';
    }
    
    public function getNameVariable($where)
    {
        $_where = $this->_buildwhere($where);
        $query = '
            SELECT
                variable
            FROM
                hb_config_items_cat
        ' . $_where;
        $result = $this->dbh->query($query)->fetchAll();
        if (count($result) > 0) {
            if ($result[0]['variable'] == 'ip') {
                return true;
            }
        }
        return false;
    }
	
    private function _getdetailProduct ($productid, $serverType) {
    	$aProductSB7_noc = array(159);
        $aProductSB_in = array(77,78);
        $aProductSB_ex = array(79,80);
        $aProductSK_in = array(73,74);
        $aProductSK_ex = array(75,76);
        if (in_array($productid, $aProductSB_in)){
            $product_id = ($serverType == 'vps') ? 78 : 77; 
        } elseif (in_array($productid, $aProductSB_ex)){
            $product_id = ($serverType == 'vps') ? 80 : 79; 
        } elseif (in_array($productid, $aProductSK_in)){
            $product_id = ($serverType == 'vps') ? 74 : 73; 
        } elseif (in_array($productid, $aProductSK_ex)){
            $product_id = ($serverType == 'vps') ? 76 : 75; 
        } elseif (in_array($productid, $aProductSB7_noc)){
        	$product_id = 159;
        }
        return $product_id;
    }
    
    public function getAccByProductId ($client_id, $productid, $serverType) {
        $where = array(
        	'product_id' => $this->_getdetailProduct($productid, $serverType),
        	'client_id' => $client_id
        );
        $_where = $this->_buildwhere($where);
        $query = '
            SELECT
                id
            FROM
                hb_accounts
        ' . $_where;
       // echo $query;
        $result = $this->dbh->query($query)->fetch();
        if (count($result) > 0) {
            return $result['id'];
        }
        return false;
    }
	
	public function getIpActivateRvskinLicense($where)
    {
        $result = array();
        $_where = $this->_buildwhere($where);
        $query = '
            SELECT
                data
            FROM
                hb_config2accounts
        ' . $_where;
      // echo $query;//exit;
        $result = $this->dbh->query($query)->fetchAll();
        return $result;
    }
    
    public function findIpFormCustom($aCustom,$accountid)
    {
        $aData = array();
        foreach ($aCustom as $k=>$v) {
             $isIp = $this->getNameVariable(array('id' => $k));
             if ($isIp == true) {
                 $getConfigId = array_keys($v);
                 $getConfigId = $getConfigId[0];
                 $aIp = $this->getIpActivateRvskinLicense(array(
                    'account_id' => $accountid,
                    'config_cat' => $k,
                    'config_id' => $getConfigId
                 ));
                 $aData['ip'] = $aIp[0]['data'];
                 $aData['config_cat'] = $k;
                 $aData['config_id'] = $getConfigId;
                 return $aData;
             }
        }
        return $aData;
    }

	public function getUserSnd($email)
	{
		$aResult = $this->dbh->query('
			SELECT
				user_snd
			FROM
				snd_user
			WHERE
				user_email = :user_email
		', array(
			':user_email' => $email 
		))->fetch();
		return isset($aResult['user_snd']) ? $aResult['user_snd'] : '0';
	}
}