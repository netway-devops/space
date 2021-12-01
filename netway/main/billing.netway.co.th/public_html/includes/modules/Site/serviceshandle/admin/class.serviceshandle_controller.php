<?php

class serviceshandle_controller extends HBController {

	public function addCloudOsTemplate($request) {

	   	$db = hbm_db();
		
		$name				= isset($request['osTemplateName']) ? $request['osTemplateName'] : '';
		$desc				= isset($request['osTemplateDesc']) ? $request['osTemplateDesc'] : '';
		$baseos				= isset($request['baseOs']) ? $request['baseOs'] : '';
		$controlpanel		= isset($request['controlpanel']) ? $request['controlpanel'] : '';
		$database			= isset($request['database']) ? $request['database'] : '';
		$virtualizorapiid	= isset($request['virtualizorapiid']) ? $request['virtualizorapiid'] : '';
		$vmwareapiid		= isset($request['vmwareapiid']) ? $request['vmwareapiid'] : '';
								
		$db->query("
					INSERT INTO
						hb_cloud_os_template
							(name , description , virtualizor_api_id , vmware_api_id , os_name , control_panel , `database`)
					VALUES
							(:name , :desc , :virtualizor_api_id , :vmware_api_id , :os_name , :control_panel , :database )
						
			
					", array(
							':name'					=>	$name ,
							':desc'					=>	$desc ,
							':virtualizor_api_id'	=>	$virtualizorapiid ,
							':vmware_api_id'		=>	$vmwareapiid ,
							':os_name'				=>	$baseos ,
							':control_panel'		=>	$controlpanel , 
							':database'				=>	$database
					));

		
		/*$this->loader->component('template/apiresponse', 'json');
        $this->json->assign('data', json_encode($arr));
        $this->json->show();*/
            
	}

	public function delCloudOsTemplate($request){
		
		$db = hbm_db();
		$db->query("DELETE FROM hb_cloud_os_template WHERE id = :id" , array(':id'	=>	$request['id']));
		
	}
	
	public function editCloudOsTemplate($request) {

	   	$db = hbm_db();
		
		$id			= isset($request['ost-id']) ? $request['ost-id'] : 0;
		$name				= isset($request['osTemplateName']) ? $request['osTemplateName'] : '';
		$desc				= isset($request['osTemplateDesc']) ? $request['osTemplateDesc'] : '';
		$baseos				= isset($request['baseOs']) ? $request['baseOs'] : '';
		$controlpanel		= isset($request['controlpanel']) ? $request['controlpanel'] : '';
		$database			= isset($request['database']) ? $request['database'] : '';
		$virtualizorapiid	= isset($request['virtualizorapiid']) ? $request['virtualizorapiid'] : '';
		$vmwareapiid		= isset($request['vmwareapiid']) ? $request['vmwareapiid'] : '';
		
		$arr = array(
							':name'				=>	$name ,
							':desc'				=>	$desc ,
							':virtualizor_api_id'	=>	$virtualizorapiid ,
							':vmware_api_id'		=>	$vmwareapiid ,
							':os_name'				=>	$baseos ,
							':control_panel'		=>	$controlpanel , 
							':database'				=>	$database ,
							':id'				=>	$id
					);

		$db->query("
					UPDATE
						hb_cloud_os_template
					SET
						name = :name ,
						description = :desc ,
						virtualizor_api_id = :virtualizor_api_id ,
						vmware_api_id = :vmware_api_id ,
						os_name = :os_name ,
						control_panel = :control_panel ,
						`database` = :database
					WHERE
						id= :id
					", $arr );
            
	}
        
}