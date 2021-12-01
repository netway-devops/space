{php}
$templatePath   = $this->get_template_vars('template_path');
include($templatePath . 'cart0_dynamic_cart.tpl.php');
{/php}

{php}
                $ar_id = $this->get_template_vars('opconfig');
                $db         = hbm_db();
                $articleData   =      $db->query("select *
                                        from 
                                            hb_kb_article
                                        where 
                                            kb_article_id = '".$ar_id['zendeskfaq']."'
                                        ")->fetch();
                                        
                $articleAllFaqData   =      $db->query("select *
                                        from 
                                            hb_kb_article
                                        where 
                                            kb_article_id = '360000890671'
                                        ")->fetch();
                
                $aArticleInSection =   $db->query("select s.name as sectionName , a.kb_article_id , a.title , c.name as cat_name
                                        from 
                                            hb_kb_article a , hb_kb_section s , hb_kb_category c
                                        where 
                                            a.kb_section_id = s.kb_section_id
                                        and s.kb_section_id = '".$ar_id['zendesksection']."'
                                        and s.kb_category_id = c.kb_category_id
                                        ")->fetchAll();
                                        
               $aArticleServiceRequest =   $db->query("select s.name as sectionName , a.kb_article_id , a.title , c.name as cat_name
                                        from 
                                            hb_kb_article a , hb_kb_section s , hb_kb_category c
                                        where 
                                            a.kb_section_id = s.kb_section_id
                                        and s.kb_section_id = '".$ar_id['zendeskservicerequest']."'
                                        and s.kb_category_id = c.kb_category_id
                                        ")->fetchAll();
               
               $acategory =   $db->query("select *
                                         from 
                                             hb_kb_category
                                        where 
                                         kb_category_id = '".$ar_id['zendeskcategory']."'
                                        ")->fetch();
               $caUrl      = $this->get_template_vars('ca_url'); 
               $this->assign('acategory',$acategory);                 
               
        {/php}

{literal}
<style type ="text/css">
body{
overflow:-moz-scrollbars-vertical;
overflow-x: hidden;
overflow-y: scroll;
}
</style>

<script>
$(document).ready(function() {
    $('.faq-a').after('<hr class="hr-faq"/>');
    $(".btn-pref .btn").click(function () {
        $(".btn-pref .btn").removeClass("btn-primary").addClass("btn-default");
        // $(".tab").addClass("active"); // instead of this do the below 
        $(this).removeClass("btn-default").addClass("btn-primary");   
    });
    $('.faq-a').hide();
    $('.faq-q').css('cursor','pointer');
    $('.faq-q').click(function(){
        var sliceID = $(this).attr('id').split('-');
        $('#faq-a-'+sliceID[2]).slideToggle('slow');
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
        if($(window).scrollTop()>=$(this).position().top-90){
            toggleActiveClass($('.nav-'+$(this).attr('id')));
        }
    });
    
});
</script>{/literal}

<section>
<br>
<div class="container">
    {$opconfig.webhtml|order_pages}
  </div>
    <br>
<br>
</section>
<section id="customTab" style="margin-top: -80px">

<div class="dynamic-menu hidden-phone container">
    <div class="container">
    <ul class="dynamic-nav">
        {assign var="ch_active" value=0}
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
        
        <li class="dynamic-nav"><a class="dynamic-nav nav-faq" href="#faq">FAQ</a></li>
        
        <li class="dynamic-nav"><a class="dynamic-nav nav-datasheet" href="#datasheet">DATASHEET</a></li>
        
        <li class="dynamic-nav"><a class="dynamic-nav nav-servicerequest" href="#servicerequest">SERVICE REQUEST</a></li>
        
        <li class="dynamic-nav"><a class="dynamic-nav" href="/kb/{$acategory.name}">RESOURCES</a></li>
    </ul>
    </div>
</div>


<div class="">
<div class="row-fluid">
    {if $opconfig.tab1value != ''}
        <div class="span12 dynamic-content bg-gs-w" id="{$opconfig.tab1|replace:' ':''}">
            {$opconfig.tab1value|order_pages}
        </div>
       
    {/if}
    {if $opconfig.tab2value != ''}
        <div class="span12 dynamic-content" id="{$opconfig.tab2|replace:' ':''}">
            {$opconfig.tab2value|order_pages}
        </div>
       
    {/if}
    {if $opconfig.tab3value != ''}
        <div class="span12 dynamic-content" id="{$opconfig.tab3|replace:' ':''}">
            {$opconfig.tab3value|order_pages}
        </div>
        
    {/if}
    {if $opconfig.tab4value != ''}
        <div class="span12 dynamic-content" id="{$opconfig.tab4|replace:' ':''}">
            {$opconfig.tab4value|order_pages}
        </div>

    {/if}
        
        <div class="span12 dynamic-content bg-gs-w " id="faq"  >
       
            {php}
               
               echo '<center><h3 class="h3-title-content g-txt32" style="color: #0052cd; font-weight: 300; ">'.$articleData['title'].'</h3>
               <span class="nw-2018-content-line" style="margin-bottom: 30px;"></center>';            
               $faqData = str_replace('<a', '<a target="_blank"', $articleData['body']);
               echo $faqData; 
            {/php}
        </div>
        
        <div class="span12 dynamic-content bg-gs-w "   >
            {php}
               
               echo '<strong class="title-faq">การสั่งซื้อและการชำระบริการ</strong>';    
               $allfaqData = str_replace('<a', '<a target="_blank"', $articleAllFaqData['body']);
               echo $allfaqData;

            {/php}
        </div>
       
        

        <div class="span12 dynamic-content list-datasheet bg-gs-w " id="datasheet" style="margin-top:-150px;">
          
            {php}
               
                echo '<center><h3 class="h3-title-content g-txt32" style="color: #0052cd; font-weight: 300;">' . $aArticleInSection[0]['sectionName'] . '</h3><span class="nw-2018-content-line "></center>';
                echo '<ul style="margin-top: 30px;">';
                
               
                foreach($aArticleInSection as $value){
                    echo '<li><a class="show-section-content" id="'.$value['kb_article_id'].'" href="'.$caUrl.'/knowledgebase/'.$value['cat_name'].'/'.$value['sectionName'].'/'.$value['kb_article_id'].'-'.$value['title'].'">'. $value['title'] .'</a></li>';
                    echo '<hr class="hr-faq">';
                }
                
                echo '</ul>';
            {/php}
        </div> 
        
        
     
        <div class="span12 dynamic-content list-sr bg-gs-w " id="servicerequest" style="margin-top:-150px;">
         
           {php}
               
                echo '<center><h3 class="h3-title-content g-txt32" style="color: #0052cd; font-weight: 300;">' . $aArticleServiceRequest[0]['sectionName'] . '</h3><span class="nw-2018-content-line"></center>';
                echo '<ul style="margin-top: 30px;>';
                foreach($aArticleServiceRequest as $value){
                     echo '<li><a class="show-section-content" id="'.$value['kb_article_id'].'" href="'.$caUrl.'/knowledgebase/'.$value['cat_name'].'/'.$value['sectionName'].'/'.$value['kb_article_id'].'-'.$value['title'].'">'. $value['title'] .'</a></li>';
              		 echo ' <hr class="hr-faq">';
                }
                echo '</ul>';
            {/php}
       
        </div>
        
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
</div>


</section>