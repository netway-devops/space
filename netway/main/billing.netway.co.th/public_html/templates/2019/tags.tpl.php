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

// --- Get template variable ---

$pathWay    = '<a style="color: #1473e6;text-decoration: none;" href="'.$caUrl.'kb">Knowledge Base</a><a style="color: #1473e6;text-decoration: none;" href="'.$caUrl.'tags"> >> tags  </a> ';

       
        $aTagPopular   =  $db->query("SELECT name, total_article
                            FROM  hb_kb_tag 
                            WHERE total_article > 0
                            ORDER BY  total_article DESC 
                            
                          ")->fetchAll();
                          $this->assign('aTagPopular',$aTagPopular);
                          
        $aTagNew       = $db->query("SELECT name, total_article
                          FROM  hb_kb_tag
                          WHERE total_article > 0
                          ORDER BY  created_at DESC 
                        ")->fetchAll();
                        $this->assign('aTagNew',$aTagNew);   
                       
        $aTagName     = $db->query("SELECT name,total_article
                          FROM hb_kb_tag
                          WHERE total_article > 0
                          ORDER BY name ASC  
                       ")->fetchAll();     
                      $this->assign('aTagName',$aTagName);
                      
     
    
$this->assign('pathway',$pathWay);