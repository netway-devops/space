<?php 
#@LICENSE@#
Class SSLDao
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
			$value = "'" . mysql_real_escape_string($value) . "'";
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
	
	public function getSSL($where=null)
	{
		$_where = $this->_buildwhere($where);
		if ($_where == '') {
			$_where = ' WHERE ssl_name = p.name';
		} else {
			$_where = $_where . ' AND ssl_name = p.name';
		}
		$query = '
			SELECT
				ssl_id, ssl_validation_id, ssl_authority_id, ssl_name, warranty, ssl_multidomain_id
				, ssl_defail, issuance_time, key_length, encryption, reissue, green_addressbar
				, secure_subdomain, non_fqdn, mobile_support, licensing_multi_server, ind, uc, malware_scan
				, seal_in_search, siteseal_id, p.id AS pid
			FROM
				hb_ssl,
				hb_products AS p
		' . $_where;
		
		$result = $this->dbh->query($query)->fetchAll();
		return $result;
	}
	
	public function getSSLValidation($where=null)
	{
		$where['status'] = 1;
		$query = '
    		SELECT
    			ssl_validation_id, validation_name
    		FROM
    			hb_ssl_validation
    		' . $this->_buildwhere($where);
			
		$result = $this->dbh->query($query)->fetchAll();
			
		$aData = array();
		if (isset($result)) {
			foreach ($result as $k => $v) {
				$aData[$v['ssl_validation_id']] = $v['validation_name'];
			}
		}
		return $aData;
	}
}