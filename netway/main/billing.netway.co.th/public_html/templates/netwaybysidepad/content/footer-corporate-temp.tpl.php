<?php

require_once(APPDIR .'class.cache.extend.php');

if ( ! defined('HBF_APPNAME')) {
    exit;
}

// --- hostbill helper ---
$api        = new ApiWrapper();
$db         = hbm_db();
// --- hostbill helper ---


  $latestKeyNews  = md5('footerLatestNews');
  $resultNews  = CacheExtend::singleton()->get($latestKeyNews);

  if ($resultNews == null) {
   $latestNews = $db->query("
      SELECT a.* , s.name as section_name ,  c.name as category_name
      FROM hb_kb_article a
      LEFT JOIN hb_kb_section s  
      ON a.kb_section_id = s.kb_section_id
        ,hb_kb_category c    
      WHERE c.kb_category_id = s.kb_category_id
      AND a.is_news = 1
      AND a.public = 1
      ORDER BY a.add_time DESC LIMIT 1
        ")->fetch();
    $this->assign('latestNews',$latestNews);
 
    CacheExtend::singleton()->set($latestKeyNews, $latestNews, 600);
 }
  else{
       $this->assign('latestNews',$resultNews);
  }
   
   
 $latestKeyPromo  = md5('footerLatestPromotion');
 $resultPromo     = CacheExtend::singleton()->get($latestKeyPromo);
  if ($resultPromo == null) {   
$latestPromo = $db->query("
      SELECT a.* , s.name as section_name ,  c.name as category_name
      FROM hb_kb_article a
      LEFT JOIN hb_kb_section s  
      ON a.kb_section_id = s.kb_section_id
        ,hb_kb_category c    
      WHERE c.kb_category_id = s.kb_category_id
      AND a.is_promo = 1
      AND a.public = 1
      ORDER BY a.add_time DESC LIMIT 1
        ")->fetch();
 $this->assign('latestPromo',$latestPromo);
   CacheExtend::singleton()->set($latestKeyPromo, $latestPromo, 3600*3);
 }
  else{
       $this->assign('latestPromo',$resultPromo);
  }
 
 
  $latestKeyBlog = md5('footerLatestBlog');
  CacheExtend::singleton()->delete($latestKeyBlog );
  $resultBlog   = CacheExtend::singleton()->get($latestKeyBlog );
  if ($resultBlog == null) {   
 $latestBlog = $db->query("
      SELECT a.* , s.name as section_name ,  c.name as category_name
      FROM hb_kb_article a
      LEFT JOIN hb_kb_section s  
      ON a.kb_section_id = s.kb_section_id
        ,hb_kb_category c    
      WHERE c.kb_category_id = s.kb_category_id
      AND a.is_blog = 1
      AND a.public = 1
      ORDER BY a.add_time DESC LIMIT 1
        ")->fetch();
  $this->assign('latestBlog',$latestBlog);
  CacheExtend::singleton()->set($latestKeyBlog, $latestBlog, 3600*3);
 }
  else{
       $this->assign('latestBlog',$resultBlog);
  }
 
  $KeyAllPromotion = md5('AllPromotionOnKb');
  CacheExtend::singleton()->delete($KeyAllPromotion );
  $resultAllPromotion   = CacheExtend::singleton()->get($KeyAllPromotion );
  if ($resultAllPromotion == null) {   
  $allPromo = $db->query("
            SELECT a.* , s.name as section_name ,  c.name as category_name
            FROM hb_kb_article a
            LEFT JOIN hb_kb_section s  
            ON a.kb_section_id = s.kb_section_id,hb_kb_category c    
            WHERE c.kb_category_id = s.kb_category_id
            AND a.is_promo = 1
            AND a.public = 1
            ORDER BY a.update_time DESC
              ")->fetchAll();
 $this->assign('allPromo',$allPromo);
 CacheExtend::singleton()->set($KeyAllPromotion, $allPromo, 3600*3);
 }
  else{
       $this->assign('allPromo',$resultAllPromotion);
  }
 