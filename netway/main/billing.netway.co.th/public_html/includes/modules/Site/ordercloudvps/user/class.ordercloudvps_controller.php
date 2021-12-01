<?php
class ordercloudvps_controller extends HBController {

    private $arrConfig      = array();
                                    
    private $arrValue       = array();
    
    function beforeCall($request) {
        
    }
    
    function _default($request) {
        $this->toTemplate($request);
    }      
   
   
    private function toTemplate($request){
        
        if(empty($request)){
            exit;
        }
        

        foreach($request as $key => $value){
            
            if($key == 'c'){
                $_SESSION['currentCloudSelectData']['cpu'] = $value;
            }else  if($key == 'r'){
                $_SESSION['currentCloudSelectData']['ram'] = $value;
            }else  if($key == 'd'){
                $_SESSION['currentCloudSelectData']['hdd'] = $value;
            }else  if($key == 'p'){
                $productID  =   $value;
            }else  if($key == 'cp'){
                $_SESSION['currentCloudSelectData']['controlpanel'] = $value;
            }else  if($key == 't'){
                $_SESSION['currentCloudSelectData']['type'] = $value;
            }else  if($key == 'os'){
                $_SESSION['currentCloudSelectData']['os'] = $value;
            }else  if($key == 'db'){
                $_SESSION['currentCloudSelectData']['db'] = $value;
            }
            else  if($key == 'tem'){
                $_SESSION['currentCloudSelectData']['tem'] = $value;
            }
            
        }

        $this->template->assign('linkToOrder', '?cmd=cart&action=add&id=' . $productID );
        $this->template->render( dirname(dirname(__FILE__)).'/templates/ordercloudvps.tpl'); 
        
    }
       
}
?>
    