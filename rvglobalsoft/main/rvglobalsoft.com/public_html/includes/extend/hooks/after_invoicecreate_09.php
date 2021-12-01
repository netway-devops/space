<?php
    $api = new ApiWrapper();

 // --- hostbill helper ---
 $db         = hbm_db();
 // --- hostbill helper ---

    $invoiceId          = $details;
    
    
    $params = array(
        'id'=> $invoiceId
    );
    /*foreach ($_SESSION['AppSettings']['Cart'][0]['product_configuration'] as $value) {
        foreach ($value as $key) {
            if($key['name'] == 'IP Address')
             $ipAddress = $key['val'];
        }
    }*/
    $prorate_date   = isset($_SESSION['AppSettings']['Cart'][0]['product']['prorata_date']) 
    	? $_SESSION['AppSettings']['Cart'][0]['product']['prorata_date'] 
		: '';
    
    if($prorate_date != "") 
    {
        $invoiceDetails = $api->getInvoiceDetails($params);
       
        $descProrata    = "(Pro Rata ".date('d/m/Y',strtotime($prorate_date)).")";
        
        
        $invoiceItem    = $invoiceDetails['invoice']['items'];
        
        foreach ($invoiceItem as $item) 
        {
            $newDesc    = $item['description'];
            if (!preg_match('/[^0-9]+(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})/', $newDesc, $match))
            {
                 $newDesc   .= " ".$ipAddress;
            } 
            else 
            {
                $ipAddress = $match[1];
			}
			
			if (preg_match('/\(\d{2}\/\d{2}\/\d{4} \- \d{2}\/\d{2}\/\d{4}\)/si', $newDesc, $match2))
			{
                 $descProrata = '';
            } 
			
			if (strpos($newDesc, 'Rata') == FALSE) 
			{
                $newDesc   .= " ".$descProrata;
			}
            
            $db->query("
				UPDATE 
					hb_invoice_items
				SET 
					description = :desc 
				WHERE 
					id = :id
			",array(
				':desc' => $newDesc,
				':id'   => $item['id']
			));
        }
    }
?>