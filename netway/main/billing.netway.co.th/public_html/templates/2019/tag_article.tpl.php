<?php  
require_once(APPDIR .'class.cache.extend.php');
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}

// --- hostbill helper ---
$api        = new ApiWrapper();
$db         = hbm_db();
$client     = hbm_logged_client();
$oClient    = isset($client['id']) ? (object) $client : (object) array();
// --- hostbill helper ---
// --- Get template variable ---
$aCategory  = $this->get_template_vars('category');
$action     = $this->get_template_vars('action');
$aResults   = $this->get_template_vars('results');  
$aArticle   = $this->get_template_vars('article');
$aPath      = $this->get_template_vars('path');
$caUrl      = $this->get_template_vars('system_url');
$nameTag       = $_GET['nameTag'];

// --- Get template variable ---
$pathway    = '<a style="color: #727272;text-decoration: none;" href="'.$caUrl.'kb">Knowledge Base</a><a style="color: #1473e6;text-decoration: none;" href="'.$caUrl.'tags"> >> tags  </a> ';
        $showArticleTag  = $db->query("SELECT a.*,s.name as sectionName,c.name as categoryName 
                            FROM hb_kb_article a , hb_kb_section s,hb_kb_category c
                            WHERE labels LIKE BINARY '%\"".$nameTag."\"%' 
                            AND  a.kb_section_id = s.kb_section_id 
                            AND s.kb_category_id = c.kb_category_id   
                            AND a.public = 1  
                           ")->fetchAll();
        
        $this->assign('showArticleTag',$showArticleTag); 
        $this->assign('nameTag',$nameTag); 
       
    $this->assign('pathway',$pathway); 
       
           

      
        
        
        
        
        
        
        
        
        
        