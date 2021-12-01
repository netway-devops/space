<?php

class rvlicense_trial_controller extends HBController {
    
    public function _default($request) {
        $this->template->render(APPDIR_MODULES.'Other'.'/rvlicense_trial/template/admin/default.tpl',$request,true);

    }
    
    public function addLicence($request){
       $db = hbm_db();
       $aDate = $this->calExpireDate($request['exp']);
       if(filter_var(trim($request['mip']), FILTER_VALIDATE_IP) && filter_var(trim($request['sip']), FILTER_VALIDATE_IP)){
            try{
                if($request['product'] == 'RVSitebuilder'){
                    $query = $db->query("
                        INSERT INTO 
                            rvsitebuilder_license_trial
                            (license_type, main_ip, second_ip,exprie,effective_expiry)
                        VALUES
                            (:license_type,:main_ip,:second_ip,:exprie,:effective_expiry)
                    ",array(
                        ':license_type'     => $request['type'],
                        ':main_ip'          => trim($request['mip']),
                        ':second_ip'        => trim($request['sip']),
                        ':exprie'           => $aDate['exp'],
                        ':effective_expiry' => $aDate['eff']
                    ));
                 }
                 else if($request['product'] == 'RVSkin'){
                    $query = $db->query("
                        INSERT INTO 
                            rvskin_license_trial
                            (license_type, main_ip, second_ip,exprie,effective_expiry)
                        VALUES
                            (:license_type,:main_ip,:second_ip,:exprie,:effective_expiry)
                    ",array(
                        ':license_type'     => $request['type'],
                        ':main_ip'          => trim($request['mip']),
                        ':second_ip'        => trim($request['sip']),
                        ':exprie'           => $aDate['exp'],
                        ':effective_expiry' => $aDate['eff']
                    ));       
                 }
            }catch(exception $e){
               $this->template->assign('errorss', 'Main IP or Second IP not available');
            }
            if ($query) {
               $this->template->assign('success', 'Complete');   
            }
        }
        else
           $this->template->assign('errorss', 'Main IP or Second IP not available');   
        $this->template->render(APPDIR_MODULES.'Other'.'/rvlicense_trial/template/admin/default.tpl',$request,true);
        
       
    }
   
    public function searchLicence($request){
        $request['ip'] = trim($request['ip']);
        $searchData['site'] = $this->searchRVSitebuilderLicenseFromIP($request['ip']);
        $searchData['skin'] = $this->searchRVSkinLicenseFromIP($request['ip']);
        $this->template->assign('searchData', $searchData);
        $this->template->render(APPDIR_MODULES.'Other'.'/rvlicense_trial/template/admin/default.tpl',$request,true);
        
    }
    
    
    public function editRVSiteLicence($request){
        $searchData['site'] = $this->searchRVSitebuilderLicenseFromID($request['tid']);
        $this->template->assign('searchData', $searchData);
        $this->template->assign('product', 'RVSitebuilder');
        $this->template->assign('tid', $request['tid']);
        $this->template->render(APPDIR_MODULES.'Other'.'/rvlicense_trial/template/admin/edit.tpl',$request,true);
        
    }

    public function editRVSkinLicence($request){
        $searchData['site'] = $this->searchRVSkinLicenseFromID($request['tid']);
        $this->template->assign('searchData', $searchData);
        $this->template->assign('product', 'RVSkin');
        $this->template->assign('tid', $request['tid']);
        $this->template->render(APPDIR_MODULES.'Other'.'/rvlicense_trial/template/admin/edit.tpl',$request,true);
        
    }
    
    public function deleteLicence($request){
         $db = hbm_db();
        if($request['product'] == 'RVSitebuilder'){
            $query = $db->query("
                DELETE FROM `rvsitebuilder_license_trial` WHERE t_id = :id
            ",array(
                ':id'     => $request['tid']
            ));
         }
         else if($request['product'] == 'RVSkin'){
            $query = $db->query("
              DELETE FROM `rvskin_license_trial` WHERE t_id = :id
            ",array(
                ':id'     => $request['tid']
            ));
         }
         if($query){
             $this->template->assign('success', 'Complete'); 
         }
         $this->template->render(APPDIR_MODULES.'Other'.'/rvlicense_trial/template/admin/default.tpl',$request,true);
            
    }
    
    public function updateLicence($request){
         $db = hbm_db();
         $aDate = $this->calExpireDate($request['exp']);
        if(filter_var(trim($request['mip']), FILTER_VALIDATE_IP) && filter_var(trim($request['sip']), FILTER_VALIDATE_IP)){
      
            if($request['product'] == 'RVSitebuilder'){
                $query = $db->query("
                    UPDATE `rvsitebuilder_license_trial` 
                    SET `license_type`=:license_type,
                        `main_ip`=:main_ip,
                        `second_ip`=:second_ip,
                        `exprie`=:exprie,
                        `effective_expiry`=:effective_expiry
                    WHERE t_id = :id
                ",array(
                    ':id'     => $request['tid'],
                    ':license_type'     => $request['type'],
                    ':main_ip'          => trim($request['mip']),
                    ':second_ip'        => trim($request['sip']),
                    ':exprie'           => $aDate['exp'],
                    ':effective_expiry' => $aDate['eff']
                ));
             }
             else if($request['product'] == 'RVSkin'){
                $query = $db->query("
                    UPDATE `rvskin_license_trial` 
                    SET `license_type`=:license_type,
                        `main_ip`=:main_ip,
                        `second_ip`=:second_ip,
                        `exprie`=:exprie,
                        `effective_expiry`=:effective_expiry
                    WHERE t_id = :id
                ",array(
                    ':id'     => $request['tid'],
                    ':license_type'     => $request['type'],
                    ':main_ip'          => trim($request['mip']),
                    ':second_ip'        => trim($request['sip']),
                    ':exprie'           => $aDate['exp'],
                    ':effective_expiry' => $aDate['eff']
                ));
             }
             if($query){
                 $this->template->assign('success', 'Complete'); 
             }
         }
        else
           $this->template->assign('errorss', 'Main IP or Second IP not available');
         $this->template->render(APPDIR_MODULES.'Other'.'/rvlicense_trial/template/admin/default.tpl',$request,true);
    }
    
    
    private function searchRVSkinLicenseFromID($id){
        $db = hbm_db();
        $query = $db->query("
                            SELECT 
                                t_id as id,
                                license_type as type,
                                main_ip as mip,
                                second_ip as sip,
                                exprie as exp,
                                effective_expiry as eff,
                                comment
                            FROM 
                                rvskin_license_trial
                            WHERE
                                t_id = :id
                            ",array(':id' => $id))->fetch();
        if($query){
            $query['exp'] = date("Y-m-d",$query['exp']);
            $query['eff'] = date("Y-m-d",$query['eff']);
        }
        return $query;
    }
    private function searchRVSitebuilderLicenseFromID($id){
        $db = hbm_db();
        $query = $db->query("
                            SELECT 
                                t_id as id,
                                license_type as type,
                                main_ip as mip,
                                second_ip as sip,
                                exprie as exp,
                                effective_expiry as eff,
                                comment
                            FROM 
                                rvsitebuilder_license_trial
                            WHERE
                                t_id = :id
                            ",array(':id' => $id))->fetch();
        if($query){
            $query['exp'] = date("Y-m-d",$query['exp']);
            $query['eff'] = date("Y-m-d",$query['eff']);
        }
        return $query;
    }
    
    private function searchRVSkinLicenseFromIP($ip){
        $db = hbm_db();
        $query = $db->query("
                            SELECT 
                                t_id as id,
                                license_type as type,
                                main_ip as mip,
                                second_ip as sip,
                                exprie as exp,
                                effective_expiry as eff,
                                comment
                            FROM 
                                rvskin_license_trial
                            WHERE
                                main_ip = :ip
                                OR second_ip = :ip
                            ",array(':ip' => $ip))->fetch();
        if($query){
            $query['exp'] = date("F j, Y - H:i:s",$query['exp']);
            $query['eff'] = date("F j, Y - H:i:s",$query['eff']);
        }
        return $query;
    }
     private function searchRVSitebuilderLicenseFromIP($ip){
        $db = hbm_db();
        $query = $db->query("
                            SELECT 
                                t_id as id,
                                license_type as type,
                                main_ip as mip,
                                second_ip as sip,
                                exprie as exp,
                                effective_expiry as eff,
                                comment
                            FROM 
                                rvsitebuilder_license_trial
                            WHERE
                                main_ip = :ip
                                OR second_ip = :ip
                            ",array(':ip' => $ip))->fetch();
        if($query){
            $query['exp'] = date("F j, Y - H:i:s",$query['exp']);
            $query['eff'] = date("F j, Y - H:i:s",$query['eff']);
        }
        return $query;
    }
     
     
    
    private function calExpireDate($next_due_date = '') {
        if ($next_due_date == '0000-00-00')  $next_due_date = '2030-01-07';
        $aDate['exp'] = strtotime($next_due_date);
        $aDate['eff'] = mktime(
                                date('H', $aDate['exp'])+23,
                                date('i', $aDate['exp']),
                                date('s', $aDate['exp']),
                                date('n', $aDate['exp']),
                                date('j', $aDate['exp'])+3,
                                date('Y', $aDate['exp'])
                            );
        return $aDate;
    }
    
}
?>