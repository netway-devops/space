<?php

class zendeskagentssohandle_controller extends HBController {
    
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
        
    private $ZENDESK_URL	=	'';
    private $JWT_SECRET		=	'';
        
    public function beforeCall ($request)
    {
    	
    }
    
    public function _default ($request)
    {
    	//$this->_beforeRender();
    }
    
    public function sso($request){
    	
    	$aAdmin				=	hbm_logged_admin();
    	$db         		=	hbm_db();
		$this->ZENDESK_URL	=	$this->module->configuration['ZENDESK_URL']['value'];
		$this->JWT_SECRET	=	$this->module->configuration['JWT_SECRET']['value'];

		$result		=	$db->query("
    						SELECT
    							t.id, t.name, t.zendesk_agent, t.zendesk_agent_name
    						FROM
    							sc_team t , sc_team_member tm
    						WHERE
    							tm.staff_id = :staff_id
    							and tm.team_id = t.id
    					" , array(
    						':staff_id'		=>	$aAdmin['id']
    					))->fetch();
		
		$aTeamId2StepSSO = array(4,10,3,9);
		$teamId			 = $result['id'];
		if(isset($teamId) && in_array($teamId,$aTeamId2StepSSO) && !isset($request['2stepSSO']) && $request['2stepSSO'] != 1){
			$subSql = '';
			if($teamId == 4 || $teamId == 10){
				$subSql = 'AND id IN (4,10)';
			}else if($teamId == 3 || $teamId == 9){
				$subSql = 'AND id IN (3,9)';
			}
			$result1		=	$db->query("
    						SELECT
    							t.id, t.name, t.zendesk_agent, t.zendesk_agent_name
    						FROM
    							sc_team t
    						WHERE
    							1 {$subSql}
    					" , array())->fetchAll();
			$this->template->assign('listAccounts', $result1);
			$this->template->assign('accountsId', $teamId);
			$this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/default.tpl',array(), true);
			return;
		}
						
    	require_once(APPDIR .'libs/php-jwt-1.0.0/Authentication/JWT.php');
		
		if($aAdmin['id'] == 1 || $aAdmin['id'] == 25){
			$result['zendesk_agent']		=	'prasit@netway.co.th';
			$result['zendesk_agent_name']	=	'Prasit';	
		}
		if(isset($request['2stepSSO']) && $request['2stepSSO'] == 1){
			$result['zendesk_agent']		=	$request['selectZDAccount'];
			$result['zendesk_agent_name']	=	$request['zdAccountName'];
		}
    	
    	if(isset($result) && $result['zendesk_agent'] != ''){
    		
    		$return_to	=	isset($request['return_to']) ? $request['return_to'] : $this->ZENDESK_URL;
    		$key        =	$this->JWT_SECRET;
    		$now        = 	time();
    		$token      =	array(
    				'jti'   		=>	md5($now . rand()),
    				'iat'   		=>	$now,
    				'email' 		=>	$result['zendesk_agent'],
    				'name'			=>	$result['zendesk_agent_name']
    		);
    		 
    		$jwt        = JWT::encode($token, $key);
    		$location   = $this->ZENDESK_URL.'/access/jwt?jwt=' . $jwt . '&return_to=' . $return_to;
    		echo '<script>window.open(\''. $location .'\',\'_self\');</script>';
    		
    	}else{
    		echo '<script>alert(\'คุณไม่สามารถเข้าใช้งานระบบ Zendesk ด้วยวิธีการ SSO ได้ กรุณาติดต่อ Chinnapat \');window.history.back();</script>';
    	}
    	
    }
    
    public function afterCall ($request)
    {
        $_SESSION['notification']   = array();
    }
}