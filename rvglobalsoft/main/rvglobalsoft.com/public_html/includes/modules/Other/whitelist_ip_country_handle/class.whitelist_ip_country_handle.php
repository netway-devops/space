<?php
class whitelist_ip_country_handle extends OtherModule implements Observer{
    protected $modname      = 'Whitelist IP Thailand';
    protected $description  = 'อนุญาติให้ IP ในประเทศ สามารถสั่งซื้อบริการของ RV ได้'; 
    protected $info         = array(
        'haveadmin'   =>  true,    //is module accessible from adminarea
        'extras_menu' =>  true,    //should module be listed in extras menu
        );
   
    public function before_cartorder($details)
    {
        
    }
   
}
