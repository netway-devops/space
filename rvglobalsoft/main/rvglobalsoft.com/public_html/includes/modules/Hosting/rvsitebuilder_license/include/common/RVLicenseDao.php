<?php 
#@LICENSE@#
Class RVLicenseSBDao
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
   
    
   
}