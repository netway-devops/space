<?php
#@LICENSE@#

class listproductprice_controller extends HBController 
{

	public function request($request)
	{
		if(isset($request)){
			
			$msg	=	'';
			$status =	true;
			$aData	=	Array();
			
			$by			=	isset($request['by']) ? $request['by'] : '';
			$value		=	isset($request['value']) ? $request['value'] : 0;
			
			if(isset($by) && $by == 'id'){
				
				$aData	=	self::byId($value);
				
			}else if(isset($by) && $by == 'cat'){
				
				$aData	=	self::byCat($value);
				
			}else{
				$msg	=	'Can\'t process this request.';
			}
					
			$this->loader->component('template/apiresponse', 'json');
			$this->json->assign("aResponse", array(
													'status'	=>	$status ,
													'data'		=>	$aData ,
													'msg'		=>	$msg
													));
	        $this->json->show();
			
		}
				
	}
	
	private function byId($id){
		
		$db		=	hbm_db();
		$result	=	$db->query("
								SELECT
									*
								FROM
									hb_products p , hb_common c
								WHERE
									p.id = :id 
									and p.id = c.id
									AND c.rel = 'Product'
								",array(
									':id'	=>	$id
								))->fetch();	
		if(!empty($result)){
			return $result;
		}else{
			return 'empty';
		}
		
	}
	
	private function byCat($id){
		
		$db		=	hbm_db();
		$result	=	$db->query("
								SELECT
									*
								FROM
									hb_products p , hb_common c
								WHERE
									p.category_id IN ( {$id} ) 
									and p.id = c.id
									AND c.rel = 'Product'
								",array(
									//':id'	=>	$id
								))->fetchAll();	
				
		if(!empty($result)){
			return $result;
		}else{
			return 'empty';
		}
		
	}
	
}
