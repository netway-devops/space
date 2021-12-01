<?php
require_once APPDIR . "class.general.custom.php";
class rvlicense_controller extends HBController {

	function _default($request) {

	}

	public static function &singleton($autoload=false) {
		static $instance;
		// If the instance is not there, create one
		if (!isset($instance) || $autoload) {
			$class = __CLASS__;
			$instance = new $class();
		}
		return $instance;
	}

	public function get_remote_issue($request){
		$db = hbm_db();
		$user = $request["u_id"];
		$remoteIssue = $db->query("
			SELECT
				r.remote_main_ip AS main
				, r.remote_sub_first_ip AS first
				, r.remote_sub_last_ip AS last
			FROM
				remote_issue AS r
				, license_quota AS l
			WHERE
				r.quota_id = l.quota_id
				AND l.hb_user_id = :uid
		", array(":uid" => $user))->fetchAll();	
		
		$this->loader->component('template/apiresponse', 'json');
		$this->json->assign('remote_list', $remoteIssue);
		$this->json->show();
	}

}
?>