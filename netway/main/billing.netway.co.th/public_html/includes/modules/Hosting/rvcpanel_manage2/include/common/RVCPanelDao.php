<?php 
#@LICENSE@#
Class RVCPanelDao
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
    
    public function getProductPcice($where=null)
    {
        $result = array();
        $_where = $this->_buildwhere($where);
        $query = '
            SELECT
                rel,paytype,m,q,s,a,b,t
            FROM
                hb_common
        ' . $_where;
       // echo $query;//exit;
        $result = $this->dbh->query($query)->fetchAll();
        return $result;
    }
    
    public function getIdServerRvCpanel()
    { 
        $result = array();
        $query = '
            SELECT
                id
            FROM
                hb_servers
            WHERE
                name = "cpanel manage2"
        ';
       // echo $query;//exit;
        $result = $this->dbh->query($query)->fetchAll();
        return $result;
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
      // echo $query;//exit;
        $result = $this->dbh->query($query)->fetchAll();
        if (count($result) > 0) {
            if ($result[0]['variable'] == 'ip') {
                return true;
            }
        }
        return false;
    }
    
    public function getIpActivateCpanelLicense($where)
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
    
    public function getDataPriceLinkCpanel ($where)
    {
        $result = array();
        $_where = $this->_buildwhere($where);
        $query = '
            SELECT
                *
            FROM
                hb_price_app_rvcpanel
        '
        .$_where;
        $result = $this->dbh->query($query)->fetchAll();
        return $result;
    }
    
    public function saveDataPriceLinkCpanel ($aData=null)
    {
        $aGetData = $this->getDataPriceLinkCpanel(array(
            'product_id' => $aData['product_id'],
            'price_code' => $aData['price_code']
            )
         );
        if (count($aGetData) > 0) {
            return $this->updateDataPriceLinkCpanel($aData);
        } else {
            return $this->insertDataPriceLinkCpanel($aData);
        }

        
    }
    
    public function insertDataPriceLinkCpanel ($aData=null)
    {
        $query = sprintf("
            INSERT INTO 
                %s              
                (product_id, price_code, cpl_group, cpl_package)
            VALUES
            (   %s , %s , %s , %s)
            "
            , 'hb_price_app_rvcpanel'
            , $this->quote_smart($aData['product_id'])
            , $this->quote_smart($aData['price_code'])
            , $this->quote_smart($aData['cpl_group'])
            , $this->quote_smart($aData['cpl_package'])
        );
        if ($this->dbh->query($query)) {
            return true;
        } else {
            return false;
        }
    }

    public function getDataLogCpanel ($where=null)
    {
        $result = array();
        $_where = $this->_buildwhere($where);
        $query = '
            SELECT
                *
            FROM
                hb_rvcpanel_manage_log
        '
        . $_where
        . ' ORDER BY id DESC LIMIT 0,1';
       // echo $query;
        $result = $this->dbh->query($query)->fetchAll();
        return $result;
    } 
    
    public function insertDataLogCpanel ($aData=null)
    {
        $query = sprintf("
            INSERT INTO 
                %s              
                (account_id, licenseid, ip, reason, action)
            VALUES
            (   %s , %s , %s , %s , %s)
            "
            , 'hb_rvcpanel_manage_log'
            , $this->quote_smart($aData['account_id'])
            , $this->quote_smart($aData['licenseid'])
            , $this->quote_smart($aData['ip'])
            , '"'.$aData['reason'].'"'
            , $this->quote_smart($aData['action'])
        );
      //  echo $query;//exit;
        if ($this->dbh->query($query)) {
            return true;
        } else {
            return false;
        }
    }
    public function updateDataPriceLinkCpanel ($aData=null)
    {
       $query = sprintf("
            UPDATE
                %s     
            SET 
                cpl_group = %s ,
                cpl_package = %s
            WHERE 
                product_id = %s
                AND price_code = %s
            "
            , 'hb_price_app_rvcpanel'
            , $this->quote_smart($aData['cpl_group'])
            , $this->quote_smart($aData['cpl_package'])
            , $this->quote_smart($aData['product_id'])
            , $this->quote_smart($aData['price_code'])
            );
        if ($this->dbh->query($query)) { 
            return true;
        } else {
            return false;
        } 
    } 
}