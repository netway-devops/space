<?php
    if(isset($_GET['ip'])){
    	
        $ip = trim($_GET['ip']);
        $this->assign('ip',$ip);
		
		require_once(APPDIR . 'modules/Site/productlicensehandle/user/class.productlicensehandle_controller.php');
		
        if (preg_match( "/^(([1-9]?[0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5]).){3}([1-9]?[0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])$/", $ip)
			&& ! productlicensehandle_controller::singleton()->ip_is_private($ip))
        {
            require_once(APPDIR . 'modules/Site/verifyrvlicense/user/class.verifyrvlicense_controller.php');
			
            $arr['rvskin'] = verifyrvlicense_controller::singleton()->verify_license_rvskin($ip);
            $arr['rvsitebuilder'] = verifyrvlicense_controller::singleton()->verify_license_rvsitebuilder($ip);
			
            $invalid = "Not licensed.";
			
            if(sizeof($arr['rvskin']) >= 1 ){
               	$this->assign('dataskin',$arr['rvskin'] );
            /*}else if(sizeof($arr['rvskin']) > 1){
                $message = $ip.' has more than 1 record in our license system.Please contact RVStaff ';
                $message.= '<a href="https://rvglobalsoft.com/tickets/new&deptId=2">here</a>';
                $this->assign('nodataskin',$message);*/
            }else{
                 $this->assign('nodataskin',$invalid);
            }
			
            if(sizeof($arr['rvsitebuilder']) >= 1){
                $this->assign('datasite',$arr['rvsitebuilder']);
            /*}else if(sizeof($arr['rvsitebuilder']) > 1){
                $message = $ip.' has more than 1 record in our license system.Please contact RVStaff ';
                $message.= '<a href="https://rvglobalsoft.com/tickets/new&deptId=2">here</a>';
                $this->assign('nodatasite',$message);*/
            }else{
                 $this->assign('nodatasite',$invalid);
            }
            
        }else{
        	
            $invalid = "Bad IP address. Please correct and resubmit the form.";
            
            if(productlicensehandle_controller::singleton()->ip_is_private($ip)){
            	
            	$invalid = "Please insert the Public IP to validate license here. <br>Don't know your Public IP? Please run this in SSH \"wget -qO- http://myip.cpanel.net/v1.0/ ; echo\" <br>OR \"wget -qO- http://ipecho.net/plain ; echo\".";
				
            }
			
          	$this->assign('error',$invalid);
        }

    
    }
?>