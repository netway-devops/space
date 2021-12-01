{php}
$templatePath   = $this->get_template_vars('template_path');
include($templatePath . 'kb.tpl.php');
{/php}
{literal}

<style>
    
      #custom-search-form {
        margin:0;
        margin-top: 5px;
        padding: 0;
    }
 
    #custom-search-form .search-query {
        padding-right: 3px;
        padding-right: 4px \9;
        padding-left: 3px;
        padding-left: 4px \9;
        /* IE7-8 doesn't have border-radius, so don't indent the padding */
 
        margin-bottom: 0;
        -webkit-border-radius: 3px;
        -moz-border-radius: 3px;
        border-radius: 3px;
    }
 
    #custom-search-form button {
        border: 0;
        background: none;
        /** belows styles are working good */
        padding: 2px 5px;
        margin-top: 2px;
        position: relative;
        left: -28px;
        /* IE7-8 doesn't have border-radius, so don't indent the padding */
        margin-bottom: 0;
        -webkit-border-radius: 3px;
        -moz-border-radius: 3px;
        border-radius: 3px;
    }
 
    .search-query:focus + button {
        z-index: 3;   
    }
    
    .nw-banner1{
        padding: 30px 0 0 0;
        color: #FFE700;
        text-align: left;
        font-size: 35px;
        font-family: 'Prompt', sans-serif;
        font-weight: bold;
        line-height: 40px;
        margin-top: 60px;
        margin-left: 20px;       
    }
    .nw-banner2{
        padding: 0;
        color: #FFF;
        text-align: left;
        font-size: 24px;
        font-weight: normal;
        display: block;
        -webkit-margin-before: 1em;
        -webkit-margin-after: 1em;
        -webkit-margin-start: 0px; 
        font-family: 'Prompt', sans-serif;
        margin-left: 20px;
    }
     .nw-banner3{    
        padding: 0;
        margin: 0 0 20px 0;
        color: yellow;
        text-align: left;
        font-size: 40px;
        font-weight: normal;
        text-shadow: 4px 0 0 rgba(0,0,0,0.3);
        font-family: 'Kanit', sans-serif;
    }
   

   
     h4 > a {
	    font-size: 22px;
	    color: #545454;
	    margin-top: 30px;
	    text-decoration:none;
	    font-weight: 300;
	    
    }
    h4 > a:hover {
	    font-size: 22px;
	    color: #2431a8;
	    margin-top: 30px;
	    text-decoration:none;
	    font-weight: 300;
	    
    }
     ul {
       list-style-type: none;
    }
     ul.category> li > a {
        font-size: 16px;
	    color: #545454;
	    text-decoration:none;
    
    }
     ul > li > a:hover {
        font-size: 16px;
	    color: #2431a8;
	    text-decoration:none;
    }
    .span4 {
        width: 360px;
        height: 400px;
        margin-top: 15px;
        margin-bottom: 15px;
     }
      
    /******************menuNav*********************/  
  p, ul, li, div, nav { 
     padding:0; margin:0; 
 } 
    #menu { 
        overflow:hidden; 
        position:relative; 
        z-index:2; 
        margin-left:335px;
    } 
    .parent-menu { 
        background-color: #0c8fff; 
        min-width:255px; 
        float:left; 
    } 
    #menu ul { 
        list-style-type:none; 
    } 
    #menu ul li a { 
        padding:10px 32px; 
        display:block; 
        color:#fff; 
        text-decoration:none;
        font-family :Roboto, Arial, sans-serif;
        font-size :18px;
    } 
    #menu ul li a:hover { 
        background-color:#007ee9; 
    } 

    #menu ul li:hover > ul { 
     left: 255px; 
     -webkit-transition: left 1000ms ease-in; 
     -moz-transition: left 1000ms ease-in; 
     -ms-transition: left 1000ms ease-in; 
     transition: left 1000ms ease-in; 
    }
    #menu ul li > ul { 
     position: absolute; 
     background-color: #333; 
     top: 0; 
     left: -155px; 
     min-width: 255px; z-index: -1; 
     height: 100%; 
     -webkit-transition: left 200ms ease-in; 
     -moz-transition: left 200ms ease-in; 
     -ms-transition: left 200ms ease-in; 
     transition: left 200ms ease-in; 
    } 
     #menu ul li > ul li a:hover { 
         background-color:#2e2e2e; 
       
         
    } 
    
    input[type="search"].txt-kb {
        color: #0052cd;
        width: 264px;
        height: 31px;
        font-size: 18px;
        font-weight: 100;
        border-radius: 2px;
    }
    .btn-search {
        border: none;
        color: #FFFFFF;
        background-color: #3899e4;
        padding: 10px 30px;
        font-size: 20px;
        font-weight: 600;
        text-decoration: none;
        margin-top: -2px;
        border:2px solid #3052cd;     
    }
    .btn-search:hover {
        border: none;
        color: #FFF;
        background-color:#55acee;
        padding: 10px 30px;
        font-size: 20px;
        font-weight: 600;
        text-decoration: none;
        margin-top: -2px;
        border:2px solid #FFF;  

    }
     .iconPayment2018{
         width : 64px;
         
     }
     a.kb-product{
        color:#405368;
    }
    a.kb-product:hover {
        color:#0088cc;
    }
  
   
</style>

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
        /*if($(window).scrollTop()>=$(this).position().top-90){
            toggleActiveClass($('.nav-'+$(this).attr('id')));
        }*/
    });
    
});
</script>

<script>
    $(document).ready(function(){
          
         $("#showOther").hide();
         $("#other").click(function(){
            $("#showOther").toggle(); 
            $(this).html('<img src="https://netway.co.th/templates/netwaybysidepad/images/icon-Ohter-Products-KB-hover.png">');
         });  
    
        $('#custom-search-form').submit(function(event){
           event.preventDefault();
           var stringSearch =   $('.search-query').val();
           window.open("https://support.netway.co.th/hc/th/search?utf8=%E2%9C%93&query="+stringSearch,'_self');
        });
        
         $('.faq-a').after('<hr class="hr-faq"/>');
    $(".btn-pref .btn").click(function () {
        $(".btn-pref .btn").removeClass("btn-primary").addClass("btn-default");
        // $(".tab").addClass("active"); // instead of this do the below 
        $(this).removeClass("btn-default").addClass("btn-primary");   
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
    
    function getArticleVote(){
        
        $.post( "?cmd=zendeskhandle&action=getArticleVote", 
            {
                articleID    : '{/literal}{$aArticleData.0.kb_article_id}{literal}'
            },
        function( data ) {
          //console.log(data.data);
          var response = data.data;
          
          if(response.isVote == 1){
              
              if(response.voteValue == 1){
                  $('#bnt-vote-up').removeClass("btn-default");
                  $('#bnt-vote-up').addClass("btn-primary");
              }else if(response.voteValue == -1){
                  $('#bnt-vote-down').removeClass("btn-default");
                  $('#bnt-vote-down').addClass("btn-primary");
              }
              
          }else if(response.isVote == 0){
              
          }
          
          $('.article-vote-label').html(response.upVote + " จาก " + response.allVote + " เห็นว่ามีประโยชน์");
          
        });  
    }
  

</script>
{/literal}
<!-- <div class="row-fluid">
    
    <div class="span8">
        {$pathway}
    </div>
     <div class="span4" align="right">
       <form id="custom-search-form" class="form-search form-horizontal">
                <div class="input-append span12">
                    <input type="text" class="search-query" placeholder="Search">
                    <button type="submit" class="btn"><i class="icon-search"></i></button>
                </div>
        </form> 
    </div>
    
</div>-->

{if $action == 'default'}

{literal}
    <style>
        
        section.hero {
            background-image: url(../images/bg-kb-2018.png);
            background-color: #0052cd;
            background-position: top center;
            background-repeat: no-repeat;
            height: 400px;
            padding: 0 20px;
            text-align: center;
            width: 100%;
        }
        
    </style>
{/literal}

    <section class="section hero">
        <div class="container">
            
            <div class="row" style="padding: 30px 0 30px 0;">
                <div class="span6 hidden-phone">
                     <img src="https://netway.co.th/templates/netwaybysidepad/images/img-banner-kb-2018.png"  alt="Img-KB" >
                </div>
                <div class="span6">
                    <div class="hero-inner" style="margin-left: 20px;">
                    <h1 class="nw-banner1">Netway Support Center</h1>
                <p class="nw-banner2"> เราพร้อมบริการคุณ ตลอด 
                    <span class="nw-banner3"> 24 </span>ชั่วโมง
                </p>    
                <nav class="navbar navbar-light bg-light" style="z-index: 0;">
                    <form class="form-inline" data-search="" data-instant="true" autocomplete="off" action="https://support.netway.co.th/hc/th/search" accept-charset="UTF-8" method="get">
                        <input style="font-weight: 300;max-width: 100%;box-sizing: border-box; utline: none;transition: border .12s ease-in-out; 
                                color: #000;
                                font-size: 14px;
                                margin-left: 0;" 
                                name="utf8" type="hidden" value="✓">  
                        <input class="form-control mr-sm-2 txt-kb" type="search" aria-label="ค้นหา หัวข้อ คำถาม ฯลฯ" name="query" id="query" placeholder="ค้นหา หัวข้อ คำถาม ฯลฯ" autocomplete="off">
                        <button class=" btn-search" type="submit">ค้นหา</button>
                    </form>
                </nav> 
                </div>
                </div>
            </div>
        </div>
    </section>
    
    <section id="customTab" style="margin-top: 0px;   background-color: #4489FF;">
        <div class="dynamic-menu hidden-phone  container ">
           <div class="container">
            <ul class="dynamic-nav ">
                
                <li class="dynamic-nav"><a class="dynamic-nav nav-faq" href="#Payment" >Payment & Invoices</a></li>
                <li class="dynamic-nav"><a class="dynamic-nav nav-datasheet" href="#Products">Products</a></li>
                <li class="dynamic-nav"><a class="dynamic-nav nav-servicerequest" href="#technical">Technical Knowledge</a></li>
                <li class="dynamic-nav"><a class="dynamic-nav nav-datasheet" href="#Products"></a></li>  
            </ul>
            </div>
        </div>


<div class="">
<div class="row-fluid">
    
      <div class="span12 dynamic-content bg-gs-wn" id="hide"  style="background-color: #e4edff;">
           <div class="container">
                <div class="row">
                  <div class="span12">  
                    <div style="text-align: center; padding: 30px 10px 40px 10px;">
                    <h3 class="nw-slogan1">"บริการหลังการขาย  คือหัวใจหลักของเรา"</h3> 
                    <br>
                    <center>     
                    <a  class="nw-kb-btn-ticket" href="https://support.netway.co.th/hc/th/requests/new?_ga=2.106104899.198303363.1523234258-758666310.1510801410">
                        <i class="fa fa-envelope" style="font-size: 31px;"></i>&nbsp;&nbsp;ส่งคำร้องขอ
                    </a>
                    </center>    
                    </div>
                  </div>     
                </div>
            </div>
        </div>
        
</div>
</div>
</section>
    
       <div class="row-fluid white-kb-2018" id="Payment"> 
        <div class="container" >
            <div class="row">
               <div class="span12 dynamic-content"   >
             <center><h3 class="h3-title-content g-txt32" style="color: #0052cd; font-weight: 300; ">Payment & Invoices</h3>
             <span class="nw-2018-content-line" style="margin-bottom: 30px;"></span></center>          
               </div>
            </div>
            <div class="row " style="padding: 20px 0px 0px 20px;">
                    <div class="span3 hover-Payment"  style="border-left: 3px solid #d8e1e8; ">   
                    {if $refund|@count}
                     <a href="{$ca_url}kb/{$refund.category_name}/{$refund.section_name}">
                         <div class="icon-payment-exchange"></div>
                     </a> 
                     
                      <a href="{$ca_url}kb/{$refund.category_name}/{$refund.section_name}">
                          <p class="g-txt22 txt-payment-kb" style="margin-left: 108px;">ทั่วไป</p>
                      </a>
                  {/if}
            </div>
                
                    <div class="span3 hover-Payment" style="border-left: 3px solid #d8e1e8;"> 
                     {if $order|@count}
                        <a href="{$ca_url}kb/{$order.category_name}/{$order.section_name}/{$order.kb_article_id}"><div class="icon-payment-cart"></div></a>  
                        <a href="{$ca_url}kb/{$order.category_name}/{$order.section_name}/{$order.kb_article_id}"> <p class="g-txt22 txt-payment-kb" style="margin-left: 100px;">การสั่งซื้อ</p></a>
                    {/if}
                 </div>
                   
                     
                <div class="span3 hover-Payment" style="border-left: 3px solid #d8e1e8;">   
                    {if $payment|@count}
                      <a href="{$ca_url}kb/{$payment.category_name}/{$payment.section_name}">
                          <div class="icon-payment-pay"></div>
                      </a> 
                  
                      <a href="{$ca_url}kb/{$payment.category_name}/{$payment.section_name}"><p class="g-txt22 txt-payment-kb" style="margin-left: 85px;" >กาชำระเงิน</p> </a> 
                 {/if} 
                </div>
                <div class="span3 hover-Payment" style="border-left: 3px solid #d8e1e8; border-right: 3px solid #d8e1e8; ">   
                    {if $tax|@count}
                      <a href="{$ca_url}kb/{$tax.category_name}/{$tax.section_name}">
                          <div class="icon-payment-bill"></div>
                     </a> 
                      
                       <a href="{$ca_url}kb/{$tax.category_name}/{$tax.section_name}"><p class="g-txt22 txt-payment-kb" style="margin-left: 45px;" >การออกใบกำกับภาษี</p></a> 
                   {/if}      
                </div>
                
            </div>
        </div>
     </div>
       
 <div class="row-fluid white-nw-2018"  id="Products"  style="background-color: #FFF;" > 
     <div class="container" >
        <div class="row">
           <div class="span12" style="padding: 0px 10px 0px 10px;">
             <center><h3 class="h3-title-content g-txt32" style="color: #0052cd; font-weight: 300; ">Products</h3>
             <span class="nw-2018-content-line" style="margin-bottom: 30px;"></span></center>          
            </div>
        </div>
   {if $aDataCategory|@count}      
   <div class="row">
                   <div class="span2 hover-icon"> <!-- 1 -->
                         <a href="https://netway.site" class="kb-product">
                           <div class="icon-nw2018-Other"></div>
                           <div class="kb-txt-pro" >Netway.site</div>  
                         </a>  
                     </div> 

             {foreach from=$aDataCategory key=catId item=aCat}
                 {if empty($aCat.section)}{continue}{/if}  
                 {if $aCat.kb_category_id=='115000633367'}    
                     <div class="span2 hover-icon"> <!-- 2 -->  
                         <a href="{$ca_url}kb/{$aCat.name}" class="kb-product">
                           <div class="icon-nw2018-Domain"></div> 
                           <div class="kb-txt-pro" >Domain</div>                 
                         </a>
                     </div> 
                {/if}
             {/foreach}
                     
             {foreach from=$aDataCategory key=catId item=aCat}
                {if empty($aCat.section)}{continue}{/if}  
                {if $aCat.kb_category_id=='115000868027'}
                     <div class="span2 hover-icon" > <!-- 3 -->
                         <a href="{$ca_url}kb/{$aCat.name}" class="kb-product">
                           <div class="icon-nw2018-365"></div>
                           <div class="kb-txt-pro" >Office 365</div>              
                         </a>
                    </div>
                {/if}
            {/foreach}
            
             {foreach from=$aDataCategory key=catId item=aCat}
                {if empty($aCat.section)}{continue}{/if}  
                {if $aCat.kb_category_id=='115000868007'}
                  <div class="span2 hover-icon"> <!-- 4 -->
                    <a href="{$ca_url}kb/{$aCat.name}" class="kb-product">
                        <div class="icon-nw2018-Google"> </div> 
                        <div class="kb-txt-pro" >G Suite</div>
                    </a>
                  </div>
                {/if}
            {/foreach} 
               
            {foreach from=$aDataCategory key=catId item=aCat}
                 {if empty($aCat.section)}{continue}{/if}  
                 {if $aCat.kb_category_id=='115000874188'}
                  <div class="span2 hover-icon"> <!-- 5 -->
                    <a href="{$ca_url}kb/{$aCat.name}" class="kb-product">
                         <div class="icon-nw2018-SSL"> </div> 
                         <div class="kb-txt-pro" >SSL</div>
                    </a>
                  </div> 
                 {/if}
            {/foreach}
         
             {foreach from=$aDataCategory key=catId item=aCat}
                 {if empty($aCat.section)}{continue}{/if}  
                 {if $aCat.kb_category_id=='115000934888'}
                    <div class="span2 hover-icon "><!-- 6 -->
                        <a href="{$ca_url}kb/{$aCat.name}" class="kb-product"> 
                            <div class="icon-nw2018-Zendesk"></div>
                            <div class="kb-txt-pro" >Zendesk</div>
                        </a>
                   </div>
                {/if}
              {/foreach}
    
  </div>{/if}
   {if $aDataCategory|@count}   
  <div class="row" style="margin-bottom : 20px;">
         <div class="span2 hover-icon"> <!-- 1 -->
            <div class="icon-nw2018-Hosting"> </div> 
            <div class="kb-txt-pro" >Hosting  </div>
            {foreach from=$aDataCategory key=catId item=aCat}
                 {if empty($aCat.section)}{continue}{/if} 
                 {if $aCat.kb_category_id=='115000868187'}
                      <a  href="{$ca_url}kb/{$aCat.name} "class="kb-product" >
                     <div style="margin-top: 6px;"><small style="margin-top: 36px;"><p>Linux</a>{/if}
                 {if $aCat.kb_category_id=='115000634667'}
                     |<a  href="{$ca_url}kb/{$aCat.name}"class="kb-product" > Windows </a></p></small></div>{/if}
          {/foreach}
         </div> 
        
         <div class="span2 hover-icon"> <!-- 2 -->
            <div class="icon-nw2018-Cloud"> </div> 
            <div class="kb-txt-pro" >Basic VPS </div>
            {foreach from=$aDataCategory key=catId item=aCat}
                 {if empty($aCat.section)}{continue}{/if} 
                 {if $aCat.kb_category_id=='360000037831'}
                      <a href="{$ca_url}kb/{$aCat.name}" class="kb-product">
                      <div style="margin-top: 6px;"><small style="margin-top: 36px;"><p>Linux</a>{/if} 
                {if $aCat.kb_category_id=='360000036012'}
                      | <a href="{$ca_url}kb/{$aCat.name}" class="kb-product">Windows </a></p></small></div>{/if}
        {/foreach}
      

        
         <div class="span2 hover-icon"> <!-- 3 -->
            <div class="icon-nw2018-Dedicated"> </div> 
            <div class="kb-txt-pro" >Dedicated Server </div>
            {foreach from=$aDataCategory key=catId item=aCat}
                 {if empty($aCat.section)}{continue}{/if} 
                 {if $aCat.kb_category_id=='360000037891'}
                    <a href="{$ca_url}kb/{$aCat.name}" class="kb-product">
                        <div style="margin-top: 6px;"><small style="margin-top: 36px;"><p>Linux</a>{/if} 
                 {if $aCat.kb_category_id=='360000036052'}
                 | <a href="{$ca_url}kb/{$aCat.name}" class="kb-product">Windows </a></p></small></div>{/if}
            {/foreach}
         </div> 
     
         <div class="span2 hover-icon"> <!-- 4 -->
            <div class="icon-nw2018-VMware"> </div> 
            <div class="kb-txt-pro" >VMware  </div>
            {foreach from=$aDataCategory key=catId item=aCat}
                 {if empty($aCat.section)}{continue}{/if} 
                 {if $aCat.kb_category_id=='360000036032'}
                    <a href="{$ca_url}kb/{$aCat.name}" class="kb-product">
                        <div style="margin-top: 6px;"><small style="margin-top: 36px;"><p>Linux</a>{/if} 
                 {if $aCat.kb_category_id=='360000037851'}
                 | <a href="{$ca_url}kb/{$aCat.name}" class="kb-product">Windows </a></p></small></div>{/if}
            {/foreach}
         </div> 
         
         <div class="span2 hover-icon"> <!-- 5 -->
            
                <div class="icon-nw2018-Managed"> </div> 
                <div class="kb-txt-pro" >Managed Service </div>  
           
         </div> 
         
        {foreach from=$aDataCategory key=catId item=aCat}
            {if empty($aCat.section)}{continue}{/if}  
                {if $aCat.kb_category_id=='115000874108'}
                   <div class="span2 hover-icon" > <!-- 6 -->    
                      <a href="{$ca_url}kb/{$aCat.name}" class="kb-product">     
                        <div class="icon-Netway2018-Azure"> </div> 
                        <div class="kb-txt-pro" >Microsoft Azure </div>
                      </a>
                    </div> 
                {/if} 
        {/foreach}
           
  </div>
</div>
{/if}<!-- $aDataCategory|@count-->      
<div class="container">    
        <div class="row" style="margin-bottom : 20px;">
              
          <div class="span12" style="text-align:center; " >
             <hr style="border-top: 3px solid #dfdddd;">
             
             <img src="https://netway.co.th/templates/netwaybysidepad/images/icon-Ohter-Products-KB.png"  
             style=" margin-top: -60px;border: 2px solid #cecece;"  id="other">
          </div>
        </div>
     <div  id="showOther" > <!-- อื่นๆ -->
        <div  class="row" >
         <div class="span12"><h4>Email</h4><hr style="margin-top: -5px;"/></div><!-- Email -->
        </div>
        
      <div  class="row" >
          <div class="span3 kb-txt-pro" ><img src="https://netway.co.th/templates/netwaybysidepad/images/ikb-office365.png"  alt="Office 365"  style="
               width: 32px; margin-right: 5px;"> Office 365
           </div > 
          <div class="span3 kb-txt-pro" ><img src="https://netway.co.th/templates/netwaybysidepad/images/ikb-gsuite.png"  alt="G Suite" style="
               width: 32px; margin-right: 5px;"> G Suite 
         </div > 
         <div class="span3 kb-txt-pro" ><img src="https://netway.co.th/templates/netwaybysidepad/images/ikb-Zimbra.png"  alt="Zimbra" style="
               width: 32px; margin-right: 5px;"> Zimbra Email
         </div >  
         <div class="span3 kb-txt-pro" ><img src="https://netway.co.th/templates/netwaybysidepad/images/ikb-Cpanel.png"  alt="cPanel" style="
             width: 32px;   margin-right: 5px;" > cPanel Mail
         </div > 
    </div>
    <div class="row">
        <div class="span3 kb-txt-pro" ><img src="https://netway.co.th/templates/netwaybysidepad/images/ikb-Co-exist.png"  alt="Co-existl" style="
             width: 32px;   margin-right: 5px;"> Co-exist Mail Server
         </div > 
    </div>

        
        
        <div  class="row" style="margin-top: 20px" >
         <div class="span12"><h4>Microsoft</h4><hr style="margin-top: -5px;"/></div><!-- อื่นๆ -->
        </div>
        <div  class="row" >
             <div class="span3 kb-txt-pro" ><img src="https://netway.co.th/templates/netwaybysidepad/images/ikb-ms-Windows-.png"  alt="Windows 10"  style="
               width: 32px; margin-right: 5px;"> Windows 10
             </div > 
            <div class="span3 kb-txt-pro" ><img src="https://netway.co.th/templates/netwaybysidepad/images/ikb-office365.png"  alt="Office 365"  style="
               width: 32px; margin-right: 5px;"> Office 365
             </div > 
              <div class="span3 kb-txt-pro" ><img src="https://netway.co.th/templates/netwaybysidepad/images/ikb-ms-Logo.png"  alt="Microsoft 365"  style="
               width: 32px; margin-right: 5px;"> Microsoft 365
             </div >
             <div class="span3 kb-txt-pro" ><img src="https://netway.co.th/templates/netwaybysidepad/images/ikb-office2016.png"  alt="Office 2016"  style="
               width: 32px; margin-right: 5px;"> Office 2016
             </div >  
        </div>
        <div  class="row" style="margin-top: 20px; margin-bottom: 20px;" >
            <div class="span3 kb-txt-pro" ><img src="https://netway.co.th/templates/netwaybysidepad/images/ikb-microsoft-dynamics.png"  alt="Dynamics 365"  style="
               width: 32px; margin-right: 5px;"> Dynamics 365
             </div > 
            <div class="span3 kb-txt-pro" ><img src="https://netway.co.th/templates/netwaybysidepad/images/ikb-microsoft-dynamics.png"  alt="Dynamics 365 for Talents"  style="
               width: 32px; margin-right: 5px;"> Dynamics 365 for Talents
             </div > 
              <div class="span3 kb-txt-pro" ><img src="https://netway.co.th/templates/netwaybysidepad/images/ikb-ms-project.png"  alt="Project"  style="
               width: 32px; margin-right: 5px;"> Project
             </div >
             <div class="span3 kb-txt-pro" ><img src="https://netway.co.th/templates/netwaybysidepad/images/ikb-ms-visio.png"  alt="Visio"  style="
               width: 32px; margin-right: 5px;"> Visio
             </div >  
        </div>
        <div  class="row" style="margin-top: 20px; margin-bottom: 20px;" >
            <div class="span3 kb-txt-pro" ><img src="https://netway.co.th/templates/netwaybysidepad/images/ikb-ms-Skype.png"  alt="Skype for Business"  style="
               width: 32px; margin-right: 5px;"> Skype for Business
             </div > 
            <div class="span3 kb-txt-pro" ><img src="https://netway.co.th/templates/netwaybysidepad/images/ikb-BIPro.png"  alt="Power BI Pro"  style="
               width: 32px; margin-right: 5px;"> Power BI Pro
             </div > 
              <div class="span3 kb-txt-pro" ><img src="https://netway.co.th/templates/netwaybysidepad/images/ikb-Windows+Server.png"  alt="Windows Server"  style="
               width: 32px; margin-right: 5px;"> Windows Server
             </div >
             <div class="span3 kb-txt-pro" ><img src="https://netway.co.th/templates/netwaybysidepad/images/ikb-WindowsSQLServer.png"  alt="Windows SQL Server"  style="
               width: 32px; margin-right: 5px;"> Windows SQL Server
             </div > 
        </div>
        <div  class="row" style="margin-top: 20px; margin-bottom: 20px;" >
            <div class="span3 kb-txt-pro" ><img src="https://netway.co.th/templates/netwaybysidepad/images/ikb-Windows-Exchange.png"  alt="
Windows Exchange"  style="
               width: 32px; margin-right: 5px;"> 
Windows Exchange
             </div > 
            <div class="span3 kb-txt-pro" ><img src="https://netway.co.th/templates/netwaybysidepad/images/ikb-ms-SharePoint.png"  alt="Microsoft SharePoint"  style="
               width: 32px; margin-right: 5px;"> Microsoft SharePoint
             </div > 
              <div class="span3 kb-txt-pro" ><img src="https://netway.co.th/templates/netwaybysidepad/images/ikb-MicrosoftBusinessApps.png"  alt="Microsoft Business Apps"  style="
               width: 32px; margin-right: 5px;"> Microsoft Business Apps
             </div >
             <div class="span3 kb-txt-pro" ><img src="https://netway.co.th/templates/netwaybysidepad/images/ikb-MicrosoftAzure.png"  alt="Microsoft Azure"  style="
               width: 32px; margin-right: 5px;"> Microsoft Azure
             </div > 
        </div>
        <div  class="row" style="margin-top: 20px; margin-bottom: 20px;" >
           <div class="span3 kb-txt-pro" ><img src="https://netway.co.th/templates/netwaybysidepad/images/ikb-MicrosoftLicenseCheckup.png"  alt="Microsoft License Checkup"  style="
               width: 32px; margin-right: 5px;"> Microsoft License Checkup
             </div > 
            <div class="span3 kb-txt-pro" ><img src="https://netway.co.th/templates/netwaybysidepad/images/ikb-VisualStudioSubscription.png"  alt="Power BI Pro"  style="
               width: 32px; margin-right: 5px;"> Visual Studio Subscription
             </div > 
              <div class="span3 kb-txt-pro" ></div >
             <div class="span3 kb-txt-pro" ></div > 

        </div>
        <div  class="row" style="margin-top: 20px" >
         <div class="span12"><h4>Zendesk</h4><hr style="margin-top: -5px;"/></div><!-- Zendesk -->
        </div>
        <div  class="row" >
             <div class="span3 kb-txt-pro">
	             <img src="https://netway.co.th/templates/netwaybysidepad/images/ikb-Z-Support.png"  alt="Zendesk Support" style="
	             width: 32px; margin-right: 5px;">
                 Zendesk Support
             </div> 
             <div class="span3 kb-txt-pro">
                 <img src="https://netway.co.th/templates/netwaybysidepad/images/ikb-Z-Chat.png"  alt="Zendesk Chat" style="
	             width: 32px; margin-right: 5px;">Zendesk Chat
             </div> 
             <div class="span3 kb-txt-pro"><img src="https://netway.co.th/templates/netwaybysidepad/images/ikb-Talk.png"  alt="Zendesk Talk" style="
	             width: 32px; margin-right: 5px;">
	             Zendesk Talk
	         </div> 
             <div class="span3 kb-txt-pro" ><img src="https://netway.co.th/templates/netwaybysidepad/images/ikb-Z-Guide.png"  alt="Zendesk Guide" style="
	             width: 32px; margin-right: 5px;">
	             Zendesk Guide
	             </div > 
        </div> 
        <div  class="row" style="margin-top: 20px" >
         <div class="span12"><h4>Marketing Tools</h4><hr style="margin-top: -5px;"/></div><!-- Marketing Tools -->
        </div>
        <div  class="row" >
             <div class="span3 kb-txt-pro" ><img src="https://netway.co.th/templates/netwaybysidepad/images/ikb-Mailchimp.png"  alt="Mailchimp" style="
	             width: 32px; margin-right: 5px;">
	             Mailchimp
	             </div >  
	         <div class="span3 kb-txt-pro" ><img src="https://netway.co.th/templates/netwaybysidepad/images/ikb-Netwaysite.png"  alt="Netway.site" style="
	             width: 32px; margin-right: 5px;">
	             Netway.site
	         </div >
	         <div class="span3"></div>
	         <div class="span3"></div>
        </div> 
        <div  class="row" style="margin-top: 20px" >
         <div class="span12"><h4>Other Cloud Products</h4><hr style="margin-top: -5px;"/></div><!-- Marketing Tools -->
        </div>
        <div  class="row"   style="margin-bottom: 40px;">
             <div class="span3 kb-txt-pro" ><img src="https://netway.co.th/templates/netwaybysidepad/images/ikb-VMware.png"  alt="VMware" style="
	             width: 32px; margin-right: 5px;">
	             VMware
	         </div >
             <div class="span3 kb-txt-pro" ><img src="https://netway.co.th/templates/netwaybysidepad/images/ikb-AdobeCloud.png"  alt="AdobeCloud" style="
	             width: 32px; margin-right: 5px;">
	             Adobe Cloud
	         </div >
	         <div class="span3 kb-txt-pro" ><img src="https://netway.co.th/templates/netwaybysidepad/images/ikb-Kaspersky.png"  alt="Kaspersky" style="
	             width: 32px; margin-right: 5px;">
	             Kaspersky
	         </div >
	         <div class="span3"></div>

              
        </div> 
      </div><!-- End id="showOther"  -->
 </div>
 
{/if}
       
         <div class="row-fluid white-nw-2018" id="technical" > 
         
              <div class="container" >
           <div class="row">
            <center><h3 class="h3-title-content g-txt32" style="color: #0052cd; font-weight: 300; ">Technical Knowledge</h3>
             <span class="nw-2018-content-line" style="margin-bottom: 30px;"></span></center>  
           </div>
            <div class="row ">
                    <div class="span3">
                      <dir  class="txt-tech-kb" >
                         Website/Install Application & FTP 
                        <hr style="margin-top:5px;" size="1" class="bottom-img-footer">
                      </dir>   
                      <div class="img-technical-web"></div>  
                      <dir style="folat:left;color: #64606c;font-size: 17px;font-weight: 100;margin-top: 15px"> ความรู้ทั่วไปเกี่ยวกับเว็บไซต์  วิธี Install Applications และ FTP</dir>
                      <a href ="/kb/{$technicalArticle.category_name}"><center><button class="btn-readmore-2018" style="margin-top: 30px;">อ่านเพิ่มเติม</button><center></a>
                </div>
                
                    <div class="span3">   
                     <dir  class="txt-tech-kb" >
                         Linux Technical Knowledge
                        <hr style="margin-top:5px;" size="1" class="bottom-img-footer">
                      </dir>  
                     <div class="img-technical-linux"></div>
                     
                     <dir style="folat:left;color: #64606c;font-size: 17px;font-weight: 100;margin-top: 15px">ความรู้ทั่วไป และวิธีแก้ไขปัญหา OS Linux Server</dir>
                     <a href ="/kb/{$linuxTechnical.category_name}"><center><button class="btn-readmore-2018" style="margin-top: 30px;">อ่านเพิ่มเติม</button><center></a>  
                </div>
                
                     
                <div class="span3">  
                  <dir  class="txt-tech-kb" >
                         Windows Technical Knowledge
                        <hr style="margin-top:5px;" size="1" class="bottom-img-footer">
                      </dir>  
                      <div class="img-technical-window"></div>
                       <dir style="folat:left;color: #64606c;font-size: 17px;font-weight: 100;margin-top: 15px">ความรู้ทั่วไป และวิธีแก้ไขปัญหา  OS Windows Server</dir>
                       <a href ="/kb/{$windowsTechnical.category_name}"><center><button class="btn-readmore-2018" style="margin-top: 30px;">อ่านเพิ่มเติม</button><center></a>  
                </div>
                
                <div class="span3">
                       <dir  class="txt-tech-kb" >
                         Database
                        <hr style="margin-top:5px;" size="1" class="bottom-img-footer">
                      </dir>    
                         <div class="img-technical-database"></div>
                       <dir style="folat:left;color: #64606c;font-size: 17px;font-weight: 100;margin-top: 15px"> ความรู้ทั่วไป และวิธีแก้ไขปัญหา Database</dir>
                       <a href ="/kb/{$database.category_name}"><center><button class="btn-readmore-2018" style="margin-top: 30px;">อ่านเพิ่มเติม</button><center></a>
                       
                </div>

            </div>
        </div>
     </div>
 
        

