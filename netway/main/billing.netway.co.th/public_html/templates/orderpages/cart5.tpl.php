 <?php
 
    if ( ! defined('HBF_APPNAME')) {
        exit;
    }
    
    if(isset($_SESSION['Checkout'])){

    //include_once(APPDIR_MODULES . 'Other/googleanalytics/class.googleanalytics.php'); 

    function getProductDetailByItemID($itemID , $itemType){
        $db         =   hbm_db();
            $sql        =   '';
            
            if($itemType == 'Hosting'){
                $sql    =   "
                                SELECT
                                    a.id as item_id , p.name as product_name , c.name as category_name
                                FROM    
                                    hb_accounts a , hb_products p , hb_categories c
                                WHERE
                                    a.id = {$itemID}
                                    AND a.product_id = p.id
                                    AND p.category_id = c.id
                            ";
            }else if($itemType == 'Domain Register'){
                $sql    =   "
                                SELECT
                                    d.id as item_id , p.name as product_name , c.name as category_name
                                FROM    
                                    hb_domains d , hb_products p , hb_categories c
                                WHERE
                                    d.id = {$itemID}
                                    AND d.tld_id = p.id
                                    AND p.category_id = c.id
                            ";
            }else if($itemType == 'Addon'){
                $sql    =   "
                                SELECT
                                    a.id as item_id , a.name as product_name , 'Addon'  as category_name
                                FROM    
                                    hb_accounts_addons a
                                WHERE
                                    a.id = {$itemID}
                            ";
            }
            
            if($sql == ''){
                $emptyArray =   array();
                return  $emptyArray;
            }
            
            $result     =   $db->query($sql)->fetch();
            
            return $result;
        
    }
   
    
    $aCheckoutData              =   $_SESSION['Checkout'];
    
    $invoice = Invoice::createInvoice($aCheckoutData['invoice_id']);
    $details = $invoice->getInvoice(false);
    
    $aInvoiceData               =   $details;

  
    foreach($aInvoiceData['items'] as $aProduct){
         $priceOneTime   =   0;
         $checkType      =   $aProduct['type'];
         $qty    =   isset($aProduct['quantity']) ? $aProduct['quantity'] : 1;
         
         
        $aItemData  =   getProductDetailByItemID($aProduct['item_id'] , $aProduct['type']);
        
        if(empty($aItemData)) continue;
        
        $qty    =   isset($aProduct['quantity']) ? $aProduct['quantity'] : 1;
        
        $priceOneTime   =   0;
        if($qty == 0){
            $priceOneTime = $aProduct['amount'];
        }
        
         $aItem[]  =   array(
                            'id'            =>  $aProduct['id'],
                            'name'              =>  $aItemData['product_name'], 
                            'category'          =>  $aItemData['category_name'], 
                            'quantity'          =>  isset($qty) && $qty > 0 ? $qty : 1,
                            'price'             =>  $aProduct['unit_price']
                            );      
    }

    $this->assign('checkType',$checkType); 
    $itemJs    = json_encode($aItem);

     $jsGtag =  <<<HTML
            <script>
                gtag('event', 'purchase', {
                  'transaction_id': '{$aInvoiceData['id']}',
                  'affiliation'   : 'netway',
                  'value'         : '{$aInvoiceData['total']}',
                  'tax'           : '{$aInvoiceData['tax']}',
                  'shipping'      : '0' ,
                  'items'         : {$itemJs}
                });
            </script>
HTML;
$this->assign('jsGtag',$jsGtag);   


}



