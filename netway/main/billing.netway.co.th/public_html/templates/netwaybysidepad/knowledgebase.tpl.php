<?php  
require_once(APPDIR .'class.cache.extend.php');
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}

require_once(APPDIR . 'class.general.custom.php');
require_once(APPDIR . 'class.config.custom.php');
// [ยกเลิก] require_once(APPDIR . 'modules/Site/kbhandle/user/class.kbhandle_controller.php');

// --- hostbill helper ---
$api        = new ApiWrapper();
$db         = hbm_db();
$client     = hbm_logged_client();
$Admin      = hbm_logged_admin();
$oClient    = isset($client['id']) ? (object) $client : (object) array();


// --- hostbill helper ---


// --- Get template variable ---
$aCategory  = $this->get_template_vars('category');
$action     = $this->get_template_vars('action');
$aResults   = $this->get_template_vars('results');
$aArticle   = $this->get_template_vars('article');
$aPath      = $this->get_template_vars('path');
$caUrl      = $this->get_template_vars('system_url');
$cmd        = $this->get_template_vars('cmd');

// --- Get template variable ---

$this->assign('oAdmin',$Admin);

if($cmd == 'knowledgebase' && preg_match('/^\d/', $action)) {
    
    $articleId      =  $action;
    if(isset($Admin['id'])){
    $article_data =  $db->query("SELECT c.name as category_name , s.name as section_name , a.* 
                        FROM hb_kb_section s,hb_kb_category c,hb_kb_article a 
                        WHERE a.kb_article_id = '".$articleId."'
                        AND a.kb_section_id = s.kb_section_id
                        AND s.kb_category_id = c.kb_category_id
                        
                    ")->fetch();
                    
           $catName  = rawurlencode ($article_data['category_name']);  
           $sectName = rawurlencode ($article_data['section_name']); 
           $checkArticleId = $article_data['kb_article_id'];          
           $articlePath = rawurlencode($article_data['path']); 
           $find = array("%2F",".","%23","%26","%3F","%21","%27");
           $replace = array("-","","-","-","-","-","-");
           $strPath = str_replace($find,$replace,$articlePath); 
        if (empty($article_data)) { 
            echo '<h3 style="color :blue;text-align:center;margin-top:50px">กรุณาลองใหม่ในอีก 5 นาที เนื่องจากระบบกำลังดำเนินการซิงค์ข้อมูล  !!</h3>';  
        } else {
            header("HTTP/1.1 301 Moved Permanently");      
            header('Location: https://netway.co.th/kb/'.$catName.'/'.$sectName.'/'.$strPath.'-'.$checkArticleId);
            exit(); 
        }  
    }else{
        $article_data =  $db->query("SELECT c.name as category_name , s.name as section_name , a.* 
                        FROM hb_kb_section s,hb_kb_category c,hb_kb_article a 
                        WHERE a.kb_article_id = '".$articleId."'
                        AND a.kb_section_id = s.kb_section_id
                        AND s.kb_category_id = c.kb_category_id
                        AND a.public = 1 
                        AND s.public = 1
                        AND a.user_segment_id = ''
                    ")->fetch();
                    
           $catName  = rawurlencode ($article_data['category_name']);  
           $sectName = rawurlencode ($article_data['section_name']); 
           $checkArticleId = $article_data['kb_article_id'];          
           $articlePath = rawurlencode($article_data['path']);     
           $find = array("%2F",".","%23","%26","%3F","%21","%27");
           $replace = array("-","","-","-","-","-","-");
           $strPath = str_replace($find,$replace,$articlePath);  
        if (empty($article_data)) {
            $dataCatSec =  $db->query("SELECT c.name as category_name , s.name as section_name , a.* 
                        FROM hb_kb_section s,hb_kb_category c,hb_kb_article a 
                        WHERE a.kb_article_id = '".$articleId."'
                        AND a.kb_section_id = s.kb_section_id
                        AND s.kb_category_id = c.kb_category_id
                        AND a.public = 1 
                        AND s.public =1
                        ")->fetch();
                                  
            $rawCategoryName  = rawurlencode ($dataCatSec['category_name']);  
            $rawSectionName = rawurlencode ($dataCatSec['section_name']);   
           if(isset($dataCatSec)){
                echo '<h3 style="color :red;text-align:center;margin-top:50px">คุณไม่สามารถดูหน้านี้ได้เนื่องจาก User ของคุณไม่ใช่ Staff!!</h3>';  
                echo ("<script LANGUAGE='JavaScript'>
                        setTimeout(function(){location.href='https://netway.co.th/kb/".$rawCategoryName."/".$rawSectionName."'} ,1000);
                       </script>");
           }
        } else {
            header("HTTP/1.1 301 Moved Permanently");      
            header('Location: https://netway.co.th/kb/'.$catName.'/'.$sectName.'/'.$strPath.'-'.$checkArticleId);
            exit(); 
        }    
            
        
    }
}

$pathWay = '';
if($action != 'default'){
    
    $queryString   =   $_SERVER['QUERY_STRING'];

    preg_match('/m365migration-offering/', $queryString,$outputString);

    if($outputString[0]=="m365migration-offering"){
       
        
        $queryString = '/kb/Blog/Microsoft365/Limited Offers !!! ย้ายฟรี G Suite ไป Microsoft Teams และพร้อมยินดีรับดูแลเซิร์ฟเวอร์เพิ่มเติมในองค์กรคุณ-360049880172';
    }
    $arg    =   explode('/', $queryString);

   
    if(count($arg) <= 3){

        $pathWay    =   '<a style="color: #1473e6;text-decoration: none;" href="'.$caUrl.'kb"> Knowledge Base </a> ';
        $pathWay    .=  ' >> <a style="color: #1473e6;text-decoration: none;" href="'.$caUrl.'kb/'.rawurlencode($arg[2]).'">'.urldecode($arg[2]).'</a>';   
        $sql = "select s.* 
                FROM hb_kb_section s  , hb_kb_category c
                WHERE s.kb_category_id = c.kb_category_id
                AND c.name = :cname
                ";
            if(!isset($Admin['id'])){
                $sql .= "AND s.public = 1 ORDER BY s.id ASC ";
                
            }else{
                $sql .= "AND (s.public = 1 OR s.public = 0) ORDER BY s.id ASC";
            }
                
            $aSectionInCat   =  $db->query($sql, array(
                ':cname' => urldecode($arg[2]) 
                ))->fetchAll();  
                                 
        $SectionNameKeyKb       = md5('SectionNameOnNetwayKb'.$arg[2]);
        if (isset($_GET['debug']) && $_GET['debug']) {
            CacheExtend::singleton()->delete($SectionNameKeyKb);
        }
        $CacheSectionNameKeyKb  = CacheExtend::singleton()->get($SectionNameKeyKb);
        
        if(empty($CacheSectionNameKeyKb)) {   
            foreach($aSectionInCat as $key => $value){
                if(isset($Admin['id'])){
                    $aSectionInCat[$key]['article'] =   $db->query("
                            SELECT kb_article_id,title,path,position,promoted,add_time,user_segment_id
                            FROM hb_kb_article 
                            WHERE kb_section_id ='".$value['kb_section_id']."'
                            AND title NOT LIKE '⚠%'
                            ORDER BY promoted DESC, position ASC,add_time DESC
                    ")->fetchAll();
                }else{
                    $aSectionInCat[$key]['article'] =   $db->query("
                            SELECT kb_article_id,title,path,position,promoted,add_time,user_segment_id
                            FROM hb_kb_article 
                            WHERE 
                            kb_section_id ='".$value['kb_section_id']."'
                            and public = 1
                            and title NOT LIKE '⚠%'
                            and user_segment_id = ''
                            ORDER BY promoted DESC, position ASC,add_time DESC
                    ")->fetchAll();
                }
                             
                $this->assign('aSectionInCat',$aSectionInCat);
                CacheExtend::singleton()->set($SectionNameKeyKb, $aSectionInCat, 3600);
          }
        }else{
         $this->assign('aSectionInCat',$CacheSectionNameKeyKb);
        }
          
    }else if(count($arg) == 4){
        
            $pathWay    =   '<a style="color: #1473e6;text-decoration: none;" href="'.$caUrl.'kb">Knowledge Base </a>';
            $pathWay   .=  ' >> <a style="color: #1473e6;text-decoration: none;" href="'.$caUrl.'kb/'.rawurlencode($arg[2]).'">'.urldecode($arg[2]).'</a>';
            $sqlArticel = "SELECT  s.name as sectionName, 
                                a.kb_article_id, 
                                a.title,a.path,
                                a.promoted,
                                a.position,
                                a.add_time,
                                a.user_segment_id
                            FROM hb_kb_article a,
                                hb_kb_section  s,
                                hb_kb_category c 
                            WHERE a.kb_section_id = s.kb_section_id  
                                AND s.name = :sname
                                AND s.kb_category_id = c.kb_category_id
                                AND c.name = :cname
                           
                            
            ";
             if(! isset($Admin['id'])){
                 $sqlArticel .= "AND a.public = 1  AND s.public = 1  AND a.user_segment_id = '' ORDER BY a.promoted DESC,a.position ASC,a.add_time DESC ";
             }
            else{
                $sqlArticel .="AND (s.public = 1 OR s.public = 0) ORDER BY a.promoted DESC,a.position ASC,a.add_time DESC";
            }
           
            $aArticleInSection   =  $db->query($sqlArticel, array(
                ':sname' => urldecode($arg[3]),
                ':cname' => urldecode($arg[2]),
                ))->fetchAll();

            foreach($aArticleInSection as $aInSection =>$values){
                $find = array("#",".htaccess","&","?","\'");
                $replace = array("-",'htaccess',"-","-","-");
                $aArticleInSection[$aInSection]['path'] = str_replace($find,$replace, $aArticleInSection[$aInSection]['path'] ); 
            }
           
            $this->assign('aArticleInSection',$aArticleInSection);
        
    }else if(count($arg) == 5){
        
        preg_match('/^(\d+)\-/', $arg[4], $match);
        $articleID  = isset($match[1]) ? $match[1] : 0;
        if (! $articleID) {
            preg_match('/\-(\d+)$/', $arg[4], $match);
            $articleID  = isset($match[1]) ? $match[1] : 0;
        }
        $ArticleKeyKb       = md5('ArticleIdOnNetwayKb'.$articleID);
        if (isset($_GET['debug']) && $_GET['debug']) {
            CacheExtend::singleton()->delete($ArticleKeyKb );
        }
        $aArticleData       = CacheExtend::singleton()->get($ArticleKeyKb);

        foreach($aArticleData as $articleData =>$values){
            
            $find = array("#",".htaccess","&","?","\'");
            $replace = array("-",'htaccess',"-","-","-");
            $aArticleData[$articleData]['path'] = str_replace($find,$replace, $aArticleData[$articleData]['path'] ); 
        }
        if(empty($aArticleData)) {
            
            $sql    = "
                SELECT a.* ,
                av.*,
                    s.name AS sectionName,
                    c.name AS categoryName
                FROM hb_kb_article a 
                LEFT JOIN hb_kb_avatar av
                ON av.zendesk_user_id = a.author_id,
                    hb_kb_section s , 
                    hb_kb_category c 
                WHERE a.kb_article_id = '".$articleID."'
                    AND c.name = :cname
                    AND s.name = :sname
                    AND a.kb_section_id = s.kb_section_id  
                    AND s.kb_category_id = c.kb_category_id
                ";
            
                if(! isset($Admin['id'])){
                  $sql .= "
                        AND a.public = 1
                        AND a.user_segment_id = ''
                        AND s.public = 1
                        ";
                }
                else{
                    $sql .= "AND (a.public = 1 OR a.public = 0)";
                }
                $aArticleData   =      $db->query($sql, array(
                    ':sname' => urldecode($arg[3]),
                    ':cname' => urldecode($arg[2]),
                    ))->fetchAll();
                
                if(empty($aArticleData)){
                    echo '<h3 style="color :red;text-align:center;margin-top:50px">คุณไม่สามารถดูหน้านี้ได้เนื่องจาก User ของคุณไม่ใช่ Staff!!</h3>';  
                    echo ("<script LANGUAGE='JavaScript'>
                           setTimeout(function(){location.href='https://netway.co.th/kb/".rawurlencode($arg[2])."/".rawurlencode($arg[3])."'} , 2000);
                         </script>");
                }
           
           $aArticleData[0]['update_time'] = date('Y-m-d H:i:s',strtotime($aArticleData[0]['update_time'])+25200); 
           $aArticleData[0]['attachments'] = isset($aArticleData[0]['attachments']) ? unserialize($aArticleData[0]['attachments']) :array();
           
           foreach($aArticleData as $articleData =>$values){
                $find = array("#",".htaccess","?","&","\'");
                $replace = array("-",'htaccess',"-","-","-");
                $aArticleData[$articleData]['path'] = str_replace($find,$replace, $aArticleData[$articleData]['path'] ); 
            }

           CacheExtend::singleton()->set($ArticleKeyKb, $aArticleData, 3600);
        }
        $this->assign('aArticleData', $aArticleData);
        
        $categoryName   = isset($aArticleData[0]) ? $aArticleData[0]['categoryName'] : '';
        $sectionName   = isset($aArticleData[0]) ? $aArticleData[0]['sectionName'] : '';
        $pathWay    =   '<a style="color: #1473e6;text-decoration: none;" href="'.$caUrl.'kb"> Knowledge Base </a>';
        $pathWay    .=  ' >> <a style="color: #1473e6;text-decoration: none;" href="'.$caUrl.'kb/'.rawurlencode($categoryName).'">'.urldecode($categoryName).'</a>';
        $pathWay    .=  ' >> <a  style="color: #1473e6;text-decoration: none;" href="'.$caUrl.'kb/'.rawurlencode($categoryName).'/'.rawurlencode($sectionName).'">'.urldecode($sectionName).'</a>';
        $pathWay    =   str_replace(array('+', ' '), array('-', ' '), $pathWay);
        
        $LeftHandArticleNameKeyKb     = md5('$LeftHandArticleOnNetwayKb'.$arg[2].$arg[3]);
        if (isset($_GET['debug']) && $_GET['debug']) {
            CacheExtend::singleton()->delete($LeftHandArticleNameKeyKb);    
        }
        $aLeftHandArticleInSection    = CacheExtend::singleton()->get($LeftHandArticleNameKeyKb);
        
        foreach($aLeftHandArticleInSection as $aLeft =>$values){
            $find = array("#",".htaccess","?","\'");
            $replace = array("-",'htaccess',"-","-");
            $aLeftHandArticleInSection[$aLeft]['path'] = str_replace($find,$replace, $aLeftHandArticleInSection[$aLeft]['path']); 
        }
            if(empty($aLeftHandArticleInSection)) {
                 $sql    = " SELECT s.name as sectionName, 
                                        a.kb_article_id,
                                        a.title,a.path,
                                        a.promoted,
                                        a.position,
                                        a.add_time
                                    FROM hb_kb_article a,
                                        hb_kb_section  s,
                                        hb_kb_category c
                                    WHERE  c.name = :cname
                                        AND s.name = :sname
                                        AND a.kb_section_id = s.kb_section_id
                                        AND s.kb_category_id = c.kb_category_id
                                        
                                       
                                    
                 ";
                 if(!isset($Admin['id'])){
                  $sql .= "AND a.public = 1 AND s.public = 1 AND a.user_segment_id = '' ORDER BY a.promoted DESC ,a.position ASC, a.add_time DESC";
                  
                 }else{
                      $sql .="AND (s.public = 1 OR s.public = 0) ORDER BY a.promoted DESC ,a.position ASC, a.add_time DESC";
                 }
                 
                $aLeftHandArticleInSection   =      $db->query($sql, array(
                    ':sname' => urldecode($arg[3]),
                    ':cname' => urldecode($arg[2]),
                    ))->fetchAll();
                
                foreach($aLeftHandArticleInSection as $aLeft =>$values){
                    $find = array("#",".htaccess","?","&","\'");
                    $replace = array("-",'htaccess',"-","-","-");
                    $aLeftHandArticleInSection[$aLeft]['path'] = str_replace($find,$replace, $aLeftHandArticleInSection[$aLeft]['path']); 
                }

                CacheExtend::singleton()->set($LeftHandArticleNameKeyKb, $aLeftHandArticleInSection, 3600);
            } 
         $this->assign('aLeftHandArticleInSection',$aLeftHandArticleInSection);  
    }

}else{
        $aDataCategory =   $db->query("SELECT * FROM hb_kb_category")->fetchAll();
        foreach($aDataCategory as $key => $value){
            $sql    = " SELECT * 
                        FROM hb_kb_section 
                        WHERE kb_category_id ='".$value['kb_category_id']."'
                       
                        ";
            
            if(!isset($Admin['id'])){
             $sql .= "AND public = 1 ";
             
            }else{
                 $sql .= "AND (public = 1 OR  public = 0)";
            }
            
            $aDataCategory[$key]['section'] =   $db->query($sql)->fetchAll();  

        }
    $this->assign('aDataCategory',$aDataCategory);  
}

$argss    =   explode('/', $_SERVER['QUERY_STRING']);
$this->assign('argss',$argss);
$this->assign('pathway',$pathWay);