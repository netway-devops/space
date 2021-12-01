<?php
class managefraudip extends OtherModule implements Observer{
    protected $modname      = 'Manage fraud ip';
    protected $description  = 'เพิ่ม หรือ ลบ ip ของ Product ที่ไม่ต้องการให้ใช้ในการทำ order'; 
    protected $info = array(
      'haveadmin'=>true,    //is module accessible from adminarea
      'haveuser'=>false,     //is module accessible from client area
      'havelang'=>false,     //does module support multilanguage
      'havetpl'=>false,      //does module have template
      'havecron'=>false,     //does module support cron calls
      'haveapi'=>false,      //does module have functions accessible via api
      'needauth'=>false,     //does module needs authorisation by clients to use it
      'isobserver'=>false,   //is module an observer - must implement Observer interface!
      'clients_menu'=>false, //should module be listed in adminarea->clients menu
      'support_menu'=>false,  //should module be listed in adminarea->support menu
      'payment_menu'=>false,  // should module be listed in adminarea->payments menu
      'orders_menu'=>false,   //should module be listed in adminarea->orders menu
      'extras_menu'=>true,    //should module be listed in extras menu
      'mainpage'=>false,       //should module be listed in admin home screen and/or clientarea root screen
      'header_js'=>false,     //does module have getHeaderJS function - add header javascript code to admin/clientarea
   );   
   
   public function before_cartorder($details){
        //  echo '<pre>'.print_r($details,true).'</pre>';
        //$this->addError('ssssssssss');
        // $this->template->render('/home/sukit/Workspace/rvglobalsoft.com/public_html/templates/netwaybysidepad/cart.tpl',array(), true);
        // header('Location: ' .'&aaaa', true, $permanent ? 301 : 302);
        $cart = $details->cart;
        foreach ($cart as $item) {
            if(sizeof($item['product_configuration'])>0){
                foreach ($item['product_configuration'] as $conarr) {
                    foreach ($conarr as $conItem) {
                        if($conItem['name'] == 'IP Address'){
                            $db     = hbm_db();
                            $result = $db->query("SELECT * 
                                                  FROM fraud_server_ip 
                                                  WHERE ip = :ip",
                                                  array(':ip'=>$conItem['val']))->fetch();
                                                  
                            if($result){
                                $this->addError('Your IP can not order.');
                                hbm_redirect('cart/');
                            }
                        }
                        
                    }
                }
                
            }
        }
     
        
      
        
   }
   
  // public function 
}


?>