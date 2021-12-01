<?php
class hostpartnerhandle_controller extends HBController {
    
    private static  $instance;
    
    public static function singleton (){
        if (!isset(self::$instance)) {
            $c = __CLASS__;
            self::$instance = new $c();
        }
        
        return self::$instance;
    }
    
   
    public function AddCompany($aParam){
        $db             = hbm_db();
        
            $clientId       = isset($aParam['clientId'])?$aParam['clientId']:0;  
            $companyName    = isset($aParam['companyName'])?$aParam['companyName']:'';  
            $logo           = isset($aParam['logoupload'])?$aParam['logoupload']:'';
            $webUrl         = isset($aParam['webUrl'])?$aParam['webUrl']:''; 
            $title          = isset($aParam['title'])?$aParam['title']:''; 
       
            
        $result = $db->query("
                    SELECT * 
                    FROM hb_client_details
                    WHERE id = {$clientId}
                    AND companyname = ''
                    AND company = 0
                   ")->fetch(); 
           
        $country = isset($result['country'])?$result['country']:'';   
                   
            if(isset($result)){
                $checkCompany = $db->query("
                                SELECT * 
                                FROM hb_hosting_partner
                                WHERE client_id = {$clientId} 
                       ")->fetch();               
            }           
            if(empty($checkCompany['client_id']) && $companyName !=''){
                $AddCompanyName = $db->query("
                    INSERT INTO hb_hosting_partner (id, client_id, country, company_name, logo, web_url,title,status,status_edit_company)  
                    VALUES (NULL,{$clientId} ,'{$country}','{$companyName}','{$logo}','{$webUrl}','{$title}',0,0)
                    ");
            }
            
         $dataPartner = $db->query("
                        SELECT * 
                        FROM hb_hosting_partner
                        WHERE client_id = {$clientId}
                       ")->fetch(); 

         
        if(isset($dataPartner)){
            $companyData = $dataPartner;
            return $companyData;
        }
    }


    public function EditCompanyData($aParam){
        $db             = hbm_db();
        
            $clientId       = isset($aParam['eCompanyClientId'])?$aParam['eCompanyClientId']:0;  
            $companyName    = isset($aParam['eCompanyName'])?$aParam['eCompanyName']:'';  
            $logo           = isset($aParam['eFileLogo'])?$aParam['eFileLogo']:'';
            $webUrl         = isset($aParam['eWebUrl'])?$aParam['eWebUrl']:''; 
            $title          = isset($aParam['eTitle'])?$aParam['eTitle']:'';   
            if(isset($clientId) && $clientId != 0){
                $checkCompany = $db->query("
                                SELECT * 
                                FROM hb_hosting_partner
                                WHERE client_id = {$clientId} 
                                AND status = 1 
                                AND status_edit_company = 1
                       ")->fetch();               
            }           
            if(isset($checkCompany['client_id']) && $checkCompany['status_edit_company'] == 1){
                $editCompanyName = $db->query("
                    UPDATE hb_hosting_partner 
                    SET company_name = '{$companyName}', 
                        logo         = '{$logo}', 
                        web_url      = '{$webUrl}',
                        title        = '{$title}',
                        status_edit_company = 0 
                    WHERE client_id = {$checkCompany['client_id']}
                    
                    ");
            }
            
         $dataPartner = $db->query("
                        SELECT * 
                        FROM hb_hosting_partner
                        WHERE client_id = {$clientId}
                       ")->fetch(); 

         
        if(isset($dataPartner)){
            $EditData = $dataPartner;
            return $EditData;
        }
    }

    public function HostingProviders(){
        header("Access-Control-Allow-Origin: https://rvsitebuilder.com");
         $db             = hbm_db();
         $result = $db->query("
                       SELECT DISTINCT(hp.client_id),hp.id,hp.country,hp.company_name,hp.logo,hp.web_url,hp.title,hp.status,hp.status_edit_company,a.status
                        FROM hb_accounts a 
                        LEFT JOIN hb_products p 
                        ON a.product_id = p.id 
                        LEFT JOIN hb_client_details cd
                        ON cd.id = a.client_id 
                        LEFT JOIN  hb_hosting_partner hp 
                        ON hp.client_id = a.client_id
                        WHERE  a.status != 'Terminated'
                        AND p.category_id = '6' 
                        AND p.id IN (66,67,99,100,157,155,158)
                        AND hp.status = 1 
                        AND hp.status_edit_company = 1
                        ORDER BY country ASC,company_name ASC
                    ")->fetchAll();  
                       
        $this->loader->component('template/apiresponse', 'json');
        $this->json->assign('partner', $result);
        $this->json->show();               
              
    }
}