
{php}
$templatePath   = $this->get_template_vars('template_path');
include($templatePath . 'cart0_dynamic_cart.tpl.php');
require_once(APPDIR .'class.cache.extend.php');
{/php}

{php}

                $ar_id = $this->get_template_vars('opconfig'); 
                $db         = hbm_db();
               
                $zendeskKeyFaq  = md5('aIdArticleFaq'.$ar_id['zendeskfaq']);
                $cacheZendeskFaq  = CacheExtend::singleton()->get($zendeskKeyFaq);
                if (empty($cacheZendeskFaq)) {
                    $articleData   =      $db->query("select *
                                        from 
                                            hb_kb_article
                                        where 
                                            kb_article_id = '".$ar_id['zendeskfaq']."'
                                        ")->fetch();
                   
                    CacheExtend::singleton()->set($zendeskKeyFaq, $articleData, 3600*3);
                } else {
                   $articleData = $cacheZendeskFaq;
                }
                
                 $KeyFaq  = md5('idPayOrderFaq'.$ar_id['zendeskfaq']);
                 $cacheKeyFaq = CacheExtend::singleton()->get($KeyFaq);  
                 if (empty($cacheKeyFaq)) {                         
                $articleAllFaqData   =      $db->query("select *
                                        from 
                                            hb_kb_article
                                        where 
                                            kb_article_id = '360000890671'
                                        ")->fetch();
                      
                 CacheExtend::singleton()->set($KeyFaq, $articleAllFaqData, 3600*3);
                } else {
                  $articleAllFaqData = $cacheKeyFaq;
                }
              
                 $KeyArticleDatasheet  = md5('idArticleDatasheet'.$ar_id['zendesksection']);

                 $cacheKeyArticleDatasheet = CacheExtend::singleton()->get($KeyArticleDatasheet);  
                 if (empty($cacheKeyArticleDatasheet)) {                           
                $aArticleInSection =   $db->query("select s.name as sectionName , a.kb_article_id , a.title , c.name as cat_name,a.public 
                                        from 
                                            hb_kb_article a , hb_kb_section s , hb_kb_category c
                                        where 
                                            a.kb_section_id = s.kb_section_id
                                        and s.kb_section_id = '".$ar_id['zendesksection']."'
                                        and s.kb_category_id = c.kb_category_id
                                        and a.public = 1
                                        
                                        ")->fetchAll();
                                        
                 CacheExtend::singleton()->set($KeyArticleDatasheet, $aArticleInSection, 3600*3);
               
                } else {
                  $aArticleInSection = $cacheKeyArticleDatasheet;
                  
                }                        
                                        
                                        
                $aServiceRequestKey  = md5('sServiceRequestId'.$ar_id['zendeskservicerequest']);
  
                $cacheServiceRequest = CacheExtend::singleton()->get($aServiceRequestKey); 
                if(empty($cacheServiceRequest)) {                       
                      $aArticleServiceRequest =   $db->query("select s.name as sectionName , a.kb_article_id , a.title , c.name as cat_name,a.public,a.promoted ,a.position,a.add_time
                                        from 
                                            hb_kb_article a , hb_kb_section s , hb_kb_category c
                                        where 
                                            a.kb_section_id = s.kb_section_id
                                        and s.kb_section_id = '".$ar_id['zendeskservicerequest']."'
                                        and s.kb_category_id = c.kb_category_id
                                        and s.public = 1
                                        and a.public = 1
                                        ORDER BY a.promoted DESC,a.position ASC,a.add_time DESC
                                        ")->fetchAll();
                      CacheExtend::singleton()->set($aServiceRequestKey, $aArticleServiceRequest, 3600*3);
                } else {
                   $aArticleServiceRequest = $cacheServiceRequest;
                }
                
                $zendeskHowtoKey  = md5('sZendeskHowtoId'.$ar_id['zendeskhowto']);
                $cacheZendeskhowto = CacheExtend::singleton()->get($zendeskHowtoKey); 
                if(empty($cacheZendeskhowto)) {                       
                     $sectionHowto =   $db->query("select s.name as sectionName , a.kb_article_id , a.title , c.name as cat_name,a.path,a.promoted ,a.position,a.add_time
                                        from 
                                            hb_kb_article a , hb_kb_section s , hb_kb_category c
                                        where a.kb_section_id = s.kb_section_id
                                        and s.kb_section_id = '".$ar_id['zendeskhowto']."' 
                                        and s.kb_category_id = c.kb_category_id
                                        ORDER BY a.promoted DESC,a.position ASC,a.add_time DESC
                                        ")->fetchAll();
                    CacheExtend::singleton()->set($zendeskHowtoKey, $sectionHowto, 3600*3);
                } else {
                   $sectionHowto = $cacheZendeskhowto;
                }
                
                 $newsUpdates =   $db->query("select s.kb_section_id,s.name as sectionName , a.kb_article_id , a.title , c.name as cat_name,a.path,a.promoted ,a.position,a.add_time
                                        from 
                                            hb_kb_article a , hb_kb_section s , hb_kb_category c
                                        where a.kb_section_id = s.kb_section_id
                                        and s.kb_section_id = '".$ar_id['zendeskNewsUpdates']."' 
                                        and s.kb_category_id = c.kb_category_id
                                        ORDER BY a.promoted DESC,a.position ASC,a.add_time DESC
                                        ")->fetchAll();
                                 
                $this->assign('newsUpdates',$newsUpdates);   
                
               $acategory =   $db->query("select *
                                         from 
                                             hb_kb_category
                                        where 
                                         kb_category_id = '".$ar_id['zendeskcategory']."'
                                        ")->fetch();
               $caUrl      = $this->get_template_vars('ca_url'); 
               $this->assign('acategory',$acategory);    
    
                $sectionBlog   =      $db->query("SELECT c.name as Category_Name, s.kb_section_id ,s.name 
                                        FROM hb_kb_category c,hb_kb_section s
                                        where s.kb_category_id = 115000134251
                                        AND c.kb_category_id = 115000134251
                                        AND  s.kb_section_id ='".$ar_id['zendeskblogsection']."'
                                   ")->fetch();
              $this->assign('sectionBlog',$sectionBlog);  
                
                
               
                
           {/php}

{literal}
<style type ="text/css">
body{
    overflow:-moz-scrollbars-vertical;
    overflow-x: hidden;
    overflow-y: scroll;
}
 li.dynamic-nav:nth-last-child(2){
    float: right;
}
   
</style>

<script>
$(document).ready(function() {
  
    $(".btn-pref .btn").click(function () {
        $(".btn-pref .btn").removeClass("btn-primary").addClass("btn-default");
        // $(".tab").addClass("active"); // instead of this do the below 
        $(this).removeClass("btn-default").addClass("btn-primary");   
    });
   
     $('.faq-a').after('<hr class="hr-faq"/>');
     $('p').find('strong.title-faq').append('&nbsp;&nbsp;<i class=" expland fa fa-plus" style="color:#ff8400;cursor:pointer;font-size:20px;float:right"> Expand All</i>');
      
      $( "#title2" ).addClass( "titlefaq" );
      $( "#title3" ).addClass( "titlefaq" );
      $( "#title4" ).addClass( "titlefaq" );
      $( "#title5" ).addClass( "titlefaq" );
      $( "#title6" ).addClass( "titlefaq" );
         
    
    $( ".expland").click(function() { 
        if($(this).text() == ' Expand All'){
            $(this).text(' Collapse All');
        }else {
           $(this).text(' Expand All');
        }
           
        $(this).parent().parent().nextUntil("p.titlefaq",".faq-a").slideToggle("");
        $(this).toggleClass("fa fa-minus fa fa-plus");  
         
          
     }); 
     
    $('.faq-a').hide();
    $('.faq-q').css('cursor','pointer');
    $('.faq-q').click(function() {
       
        var sliceID = $(this).attr('id').split('-');
        $('#faq-a-'+sliceID[2]).slideToggle("slow");
   });
    
    $('a.show-section-content').click(function(event){
        event.preventDefault();        
        $.post( "?cmd=zendeskhandle&action=getArticleContent", 
            {
                articleID    : $(this).attr('id')
            },
            function( data ) {
                
               //console.log(data.data);
               var response =   data.data;
               
               if(response.body != undefined){
                   var title = '';
                   if(response.title !== undefined) title = response.title;
                   
                   $('h4.modal-title').text(title);
                   $('div.modal-body').html(response.body);
                   $('#articleModal').modal('toggle');
                   
               }
                
            });
        
    });

    $("a.dynamic-nav").on('click', function(event) {
            
        if (this.hash !== "") {
          event.preventDefault();
          var hash = this.hash;
          $('html, body').animate({
            scrollTop: $(hash).offset().top-50
          }, 800, function(){
            window.location.hash = hash;
          });
        }
        toggleActiveClass($(this));
    });

});
 
function clickback(){
    
        $('div.list-datasheet').show('slow');
        $('div.list-datasheet').attr('id','datasheet');
        $('div.show-datasheet-content').hide('slow');
        $('div.show-datasheet-content').attr('id','');
        
    }
function clickbacksr(){
    
        $('div.list-sr').show('slow');
        $('div.list-sr').attr('id','servicerequest');
        $('div.show-sr-content').hide('slow');
        $('div.show-sr-content').attr('id','');
        
}

function toggleActiveClass(el){
    console.log(el[0].hash);
    $("a.dynamic-nav").each(function(){
        $(this).removeClass('active');
    });
    $(el).addClass('active');
    
}


$(window).scroll(function(e){
    var pos = $('#customTab').position();
    if($(window).scrollTop() >= pos.top){
        $('.dynamic-menu').addClass('fix-top-dynamic-menu');
    }else{
        $('.dynamic-menu').removeClass("fix-top-dynamic-menu");
    }
    $('.dynamic-content').each(function(){
        /*if($(window).scrollTop()>=$(this).position().top-90){
            toggleActiveClass($('.nav-'+$(this).attr('id')));
        }*/
    });
    
});
</script>
{/literal}

<section>

<div class="">
    {$opconfig.webhtml|order_pages:$current_cat}
  </div>
    <br>
<br>
</section>

<section id="customTab" style="margin-top: -50px;">
<div class="dynamic-menu hidden-phone  container " style="background-color: #4489FF; width: 100%;">
   <div class="container">
    <ul class="dynamic-nav ">
       
        {assign var="ch_active" value=0}
           
        {if $opconfig.tab0value != ''}
            {assign var="activeStr" value=""}
            {assign var="ch_active" value=$ch_active+1}     
            {if $ch_active == 1}
                {assign var="activeStr" value="active"}
            {/if}
            <li class="dynamic-nav"><a class="{$activeStr} dynamic-nav nav-{$opconfig.tab0|replace:' ':''}" href="#{$opconfig.tab0|replace:' ':''}">{$opconfig.tab0}</a></li>
            
        {/if}   
        {if $opconfig.tab1value != ''}
            {assign var="activeStr" value=""}
            {assign var="ch_active" value=$ch_active+1}     
            {if $ch_active == 1}
                {assign var="activeStr" value="active"}
            {/if}
            <li class="dynamic-nav"><a class="{$activeStr} dynamic-nav nav-{$opconfig.tab1|replace:' ':''}" href="#{$opconfig.tab1|replace:' ':''}">{$opconfig.tab1}</a></li>
            
        {/if}
        {if $opconfig.tab2value != ''}
            {assign var="activeStr" value=""}
            {assign var="ch_active" value=$ch_active+1}
            {if $ch_active == 1}
                {assign var="activeStr" value="active"}
            {/if}
            <li class="dynamic-nav"><a class="{$activeStr} dynamic-nav nav-{$opconfig.tab2|replace:' ':''}" href="#{$opconfig.tab2|replace:' ':''}">{$opconfig.tab2}</a></li>
            
        {/if}
        {if $opconfig.tab3value != ''}
            {assign var="activeStr" value=""}
            {assign var="ch_active" value=$ch_active+1}
            {if $ch_active == 1}
                {assign var="activeStr" value="active"}
            {/if}
            <li class="dynamic-nav"><a class="{$activeStr} dynamic-nav nav-{$opconfig.tab3|replace:' ':''}" href="#{$opconfig.tab3|replace:' ':''}">{$opconfig.tab3}</a></li>
            
        {/if}
        
        {if $opconfig.tab4value != ''}
            {assign var="activeStr" value=""}
            {assign var="ch_active" value=$ch_active+1}
            {if $ch_active == 1}
                {assign var="activeStr" value="active"}
            {/if}
            <li class="dynamic-nav"><a class="{$activeStr} dynamic-nav nav-{$opconfig.tab4|replace:' ':''}" href="#{$opconfig.tab4|replace:' ':''}">{$opconfig.tab4}</a></li>
            
        {/if}
        
        {php}
           if ($articleData!=null){ 
                echo'<li class="dynamic-nav"><a class="dynamic-nav nav-faq" href="#faq">FAQ</a></li>';
           }
           if ($aArticleInSection!=null){ 
                echo'<li class="dynamic-nav"><a class="dynamic-nav nav-datasheet" href="#datasheet">Datasheet</a></li>';
           }
           if ($aArticleServiceRequest!=null){ 
                echo'<li class="dynamic-nav"><a class="dynamic-nav nav-servicerequest" href="#servicerequest">Service Request</a></li>';
           }
           if ($sectionHowto!=null){ 
                echo'<li class="dynamic-nav"><a class="dynamic-nav " href="#sectionHowto">How-to</a></li>';
            }
           if($newsUpdates[0]['kb_section_id'] != null){
               
                echo' <li class="dynamic-nav"><a class="dynamic-nav " href="#newsUpdates">News Updates</a></li>';
            }
           {/php}
           
            
             {if $opconfig.tab4 == 'Bandwidth Calculator'}
                <li class="dynamic-nav"><a class="dynamic-nav" href="/office365-bandwidth"target="_blank">{$opconfig.tab4}</a></li>
                <!-- <li li class="dynamic-nav"><a class="dynamic-nav" href="/office365-bandwidth">{$opconfig.tab4}</a></li> -->
             {/if}
           <li class="dynamic-nav"><a class="dynamic-nav" href="/kb/{$acategory.name|rawurlencode}"><i class="fa fa-external-link pull-right"></i>Resources</a></li>
           
          {if $sectionBlog !=''}
              <li class="dynamic-nav"><a class="dynamic-nav" href="/kb/Blog/{$sectionBlog.name|rawurlencode}"target="_blank">Blog</a></li>
         {else}
         <li class="dynamic-nav"><a class="dynamic-nav" href=""target="_blank"></a></li>
       {/if}

    </ul>
    </div>
</div>


<div class="">
<div class="row-fluid">
  {if $opconfig.tab0value != ''}
        <div class="span12 dynamic-content bg-gs-w " id="{$opconfig.tab0|replace:' ':''}">
            {$opconfig.tab0value|order_pages:$current_cat}
        </div>
       
    {/if}
    {if $opconfig.tab1value != ''}
        <div class="span12 dynamic-content bg-gs-w " id="{$opconfig.tab1|replace:' ':''}">
            {$opconfig.tab1value|order_pages:$current_cat}
        </div>
       
    {/if}
    {if $opconfig.tab2value != ''}
        <div class="span12 dynamic-content" id="{$opconfig.tab2|replace:' ':''}">
            {$opconfig.tab2value|order_pages:$current_cat}
        </div>
       
    {/if}
    {if $opconfig.tab3value != ''}
        <div class="span12 dynamic-content" id="{$opconfig.tab3|replace:' ':''}">
            {$opconfig.tab3value|order_pages:$current_cat}
        </div>
        
    {/if}
    
    {if $opconfig.tab4value != ''}
        <div class="span12 dynamic-content" id="{$opconfig.tab4|replace:' ':''}">
            {$opconfig.tab4value|order_pages:$current_cat}
        </div>

    {/if}
     {if $opconfig.tab4 == 'Banwidth Calculator'}
        <div class="span12 dynamic-content">
            {$opconfig.tab4|order_pages:$current_cat}
        </div>

    {/if}

        <div class="span12 dynamic-content bg-gs-w " id="faq"  >
            <div class="container" style="padding: 0px 30px 0px 30px;">      
          
            {php}
            
            if($articleData!=null){
                   
               echo '<center><h3 class="h3-title-content g-txt32 " style="color: #0052cd; font-weight: 300; ">'.$articleData['title'].'</h3>
               <span class="nw-2018-content-line" style="margin-bottom: 30px;">
               </center>';            
               $faqData = str_replace('<a', '<a target="_blank"', $articleData['body']);
               echo $faqData;    
               echo '<p class="titlefaq"><strong class="title-faq">การสั่งซื้อและการชำระบริการ</strong><p>';    
               $allfaqData = str_replace('<a', '<a target="_blank"', $articleAllFaqData['body']);
               echo $allfaqData;
              }
           {/php}
           
           </div>
        </div>

        {php} 
        if ($aArticleInSection!=null){
        echo '<div class="span12 dynamic-content list-datasheet bg-gs-w hidden-phone " id="datasheet" style="margin-top: 0px;">';       
        echo '  <div class="container">';
                    echo '<center><h3 class="h3-title-content g-txt32" style="color: #0052cd; font-weight: 300;">' . $aArticleInSection[0]['sectionName'] . '</h3><span class="nw-2018-content-line "></center>';
                    echo '<ul style="margin-top: 50px;">';
                    foreach($aArticleInSection as $value){
                        echo '<li><a id="'.$value['kb_article_id'].'" href="'.$caUrl.'/kb/'.rawurlencode($value['cat_name']).'/'.rawurlencode($value['sectionName']).'/'.$value['kb_article_id'].'-'.rawurlencode($value['title']).'"target="_blank">'. $value['title'];
                        echo ' </a> </li>';
                        echo '<hr class="hr-faq">';
                    }
                   echo '</a></li>';
                 echo '</ul>';
            echo '</div>';
          echo '</div>';
        }
         
        if ($aArticleServiceRequest!=null){
         echo '<div class="span12 dynamic-content list-sr bg-gs-w hidden-phone " id="servicerequest" style="margin-top: 0px;">';
          echo '<div class="container" style=" padding: 0 30px;">';
                    echo '<center><h3 class="h3-title-content g-txt32" style="color: #0052cd; font-weight: 300;">' . $aArticleServiceRequest[0]['sectionName'] . '</h3><span class="nw-2018-content-line"></center>';
                    echo '<ul style="margin-top: 50px; ">';                   
                    foreach($aArticleServiceRequest as $value){
                         echo '<li><a  id="'.$value['kb_article_id'].'" href="'.$caUrl.'/kb/'.rawurlencode($value['cat_name']).'/'.rawurlencode($value['sectionName']).'/'.$value['kb_article_id'].'-'.rawurlencode($value['title']).'" target="_blank"">'.$value['title'];
                  		 echo '</a></li>';
                  		 echo '<hr class="hr-faq">';
                    }
                    echo '</ul>';
            echo '</div>';
          echo '</div>';
        }
          if ($sectionHowto!=null){
         echo '<div class="span12 dynamic-content list-sr bg-gs-w hidden-phone " id="sectionHowto" style="margin-top: 0px;">';
          echo '<div class="container" style=" padding: 0 30px;">';
                    echo '<center><h3 class="h3-title-content g-txt32" style="color: #0052cd; font-weight: 300;">' . $sectionHowto[0]['sectionName'] . '</h3><span class="nw-2018-content-line"></center>';
                    echo '<ul style="margin-top: 50px; ">';                   
                    foreach($sectionHowto as $value){     
                         echo '<li><a  id="'.$value['kb_article_id'].'" href="'.$caUrl.'/kb/'.rawurlencode($value['cat_name']).'/'.rawurlencode($value['sectionName']).'/'.$value['kb_article_id'].'-'.rawurlencode($value['title']).'" target="_blank">'.$value['title'];
                         echo '</a></li>';
                         echo '<hr class="hr-faq">';
                    }
                    echo '</ul>';
            echo '</div>';
          echo '</div>';
        }
        
         if ($newsUpdates[0]["kb_section_id"]!=null){
         echo '<div class="span12 dynamic-content list-sr bg-gs-w hidden-phone " id="newsUpdates" style="margin-top: 0px;">';
          echo '<div class="container" style=" padding: 0 30px;">';
                    echo '<center><h3 class="h3-title-content g-txt32" style="color: #0052cd; font-weight: 300;">' . $newsUpdates[0]['sectionName'] . '</h3><span class="nw-2018-content-line"></center>';
                    echo '<ul style="margin-top: 50px; ">';                   
                    foreach($newsUpdates as $value){     
                         echo '<li><a  id="'.$value['kb_article_id'].'" href="'.$caUrl.'/kb/'.rawurlencode($value['cat_name']).'/'.rawurlencode($value['sectionName']).'/'.$value['kb_article_id'].'-'.rawurlencode($value['title']).'" target="_blank">'.$value['title'];
                         echo '</a></li>';
                         echo '<hr class="hr-faq">';
                    }
                    echo '</ul>';
            echo '</div>';
          echo '</div>';
        }

   {/php}
  
        <div class="span12 show-sr-content" style="display: none; padding: 20px 0 0 20px"></div>
        <div class="modal fade" id="articleModal" role="dialog">
            <div class="modal-dialog modal-lg">
              <div class="modal-content">
                <div class="modal-header">
                  <h4 class="modal-title">Modal Header</h4>
                </div>
                <div class="modal-body">
                  <p>This is a large modal.</p>
                </div>
                <div class="modal-footer">
                  <button type="button" class="btn btn-default" data-dismiss="modal">ปิด </button>
                </div>
              </div>
            </div>
          </div>  
    </div>
</div>

</section>