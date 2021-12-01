<?php 
#@LICENSE@#

class RvCpUsers extends OtherModule
{
	function isRoot()
	{
		$userId = isset($_SESSION['AppSettings']['login']['id']) 
			? $_SESSION['AppSettings']['login']['id'] 
			: null;
		if (is_null($userId) === true) {
			return false;	
		} else {
			$db         = hbm_db();
			$aMyServer = $db->query(
				'
					SELECT 
						cpserver_id
					FROM 
						hb_res_cpservers
					WHERE
						usr_id = :usr_id
						AND owner_id = :usr_id
				', array(
					':usr_id' => $userId
			))->fetchall();

			if (count($aMyServer) > 0) {
				return true;
			} else {
				return false;	
			}
		}
	}
}