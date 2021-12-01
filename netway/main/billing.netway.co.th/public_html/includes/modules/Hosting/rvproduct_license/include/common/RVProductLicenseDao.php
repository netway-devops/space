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
                acc.id, ac.config_cat, ac.config_id, ac.data     
            FROM 
                hb_accounts acc
                INNER JOIN hb_config2accounts ac ON ( acc.id = ac.account_id )
                INNER JOIN hb_config_items_cat f ON ( ac.config_cat = f.id )
            WHERE 
                acc.id = %s
                AND f.variable = 'ip'
            "
            , $this->quote_smart($accid)
            );
         //   echo '=-========================>'.$query;exit;
        return $this->dbh->query($query)->fetch();
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
        ' . $_where . ' ORDER BY l.create_date DESC';
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
        $aChkFieldIp = $this->getNameVariable();
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
}