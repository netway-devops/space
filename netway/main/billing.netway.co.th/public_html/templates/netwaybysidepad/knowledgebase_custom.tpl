{php}
/* มาจาก knowledgebase.tpl แล้ว
$templatePath   = $this->get_template_vars('template_path');
include($templatePath . 'knowledgebase.tpl.php');
*/
{/php}

{literal}

<style>
tr.border-zendeskKB{
 border: 1px solid #c5c5c5;   
}
td.border-zendeskKB{
 border: 1px solid #c5c5c5;   
 padding: 4px;
}
   .article-content > .article-body > p {
        margin : 0 0 10px;     
    }
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
 
    .txt-tech-kb {
        color: #4d64ae;
        font-size: 17px;
        padding: 0px;
    }
    .header-band{
        background-image: url(../images/bg-kb-2018.png);
        background-color: #0052cd;
        background-position: top center;
        background-repeat: no-repeat;
        height: 400px;
        padding: 0 20px;
        text-align: center;
        width: 100%; 
    }

    .nw-banner1 {
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
    
   
    .sidenav-item.current-article {
    /* background-color: #379ee5; */
    color: gray;
    text-decoration: none;
}

    .sidenav-item {
  border-radius: 0px;
  color: #0088cc;
  display: block;
  font-weight: 300;
  margin-bottom: 0px;
  padding: 10px 1px;
  border-bottom:#cccccc solid 1px;
}


.sidenav-item:hover {
    border-radius: 0px;
    color: #0088cc;
    display: block;
    font-weight: 300;
    margin-bottom: 0px;
    padding: 10px 1px;
    border-bottom: #cccccc solid 1px;
}


    input[type="search"].txt-kb {
        width: 205px;
        height: 25px;
        font-size: 16px;
        font-weight: 100;
        border-radius: 30px;
        margin-top: 15px;
    }
    .btn-search {
        border: none;
        color: #FFFFFF;
        background-color: #1473e6;
        padding: 8px 27px;
        font-size: 16px;
        font-weight: 600;
        text-decoration: none;
        margin-top: 15px;
        border-radius: 30px;
    }
    .btn-search:hover {
        border: none;
        color: #FFFFFF;
        background-color: #3899e4;
        padding: 8px 27px;
        font-size: 16px;
        font-weight: 600;
        text-decoration: none;
        margin-top: 15px;
        border-radius: 30px;

    }
    .btn-outline-success {
      color: #379ee5;
      background-color: transparent;
      background-image: none;
      font-weight: 700;
      letter-spacing: 1px;
      text-transform: uppercase;
      padding: 10px 20px;
      border: 1px solid #379ee5;
      margin-left: 10px;
      
    }
    .btn-outline-success:hover {
      color: #FFF;
      background-color: #379ee5;
      background-image: none;
      font-weight: 700;
      letter-spacing: 1px;
      text-transform: uppercase;
      padding: 10px 20px;
      border: 1px solid #379ee5;
      margin-left: 10px;
      
    }
    .btn-outline-danger {
      color: #c1c1c1;
      background-color: transparent;
      background-image: none;
      padding: 10px 20px;

      font-weight: 700;
      letter-spacing: 1px;
      text-transform: uppercase;
      border: 1px solid  #c1c1c1;
    }
    .btn-outline-danger:hover {
      color: #FFF;
      background-color: #6c757d;
      background-image: none;
      padding: 10px 20px;

      font-weight: 700;
      letter-spacing: 1px;
      text-transform: uppercase;
      border: 1px solid  #6c757d;
    }
    .btn-follow{
      color: #379ee5;
      background-color: transparent;
      background-image: none;
      padding: 10px 20px;
      margin-left: 10px;
      font-weight: 700;
      letter-spacing: 1px;
      text-transform: uppercase;
      border: 1px solid #379ee5;
    }
    .btn-follow:hover {
      color: #FFF;
      background-color: #379ee5;
      background-image: none;
      padding: 10px 20px;
      margin-left: 10px;
      font-weight: 700;
      letter-spacing: 1px;
      text-transform: uppercase;
      border: 1px solid  #379ee5;
    }
    .btn2018 {
    display: inline-block;
    font-weight: 400;
    text-align: center;
    white-space: nowrap;
    vertical-align: middle;
    -webkit-user-select: none;
    -moz-user-select: none;
    -ms-user-select: none;
    user-select: none;
    padding: .375rem 0.75rem;
    font-size: 1rem;
    line-height: 1.5;
    border-radius: .25rem;
    transition: color .15s ease-in-out,background-color .15s ease-in-out,border-color .15s ease-in-out,box-shadow .15s ease-in-out;
    }
    .btn2018:hover {
    display: inline-block;
    font-weight: 400;
    text-align: center;
    white-space: nowrap;
    vertical-align: middle;
    -webkit-user-select: none;
    -moz-user-select: none;
    -ms-user-select: none;
    user-select: none;
    padding: .375rem 0.75rem;
    font-size: 1rem;
    line-height: 1.5;
    border-radius: .25rem;
    transition: color .15s ease-in-out,background-color .15s ease-in-out,border-color .15s ease-in-out,box-shadow .15s ease-in-out;
    }
    

</style>


<style type="text/css">
.content ul{
    padding-left: 20px;
    list-style-position: outside;
    margin: 20px 0 20px 20px;
    list-style-type: disc;
}

.content ol{
    padding-left: 0px;
    list-style-position: outside;
    margin: 10px 20px 12px 30px
}

.tableOfContent{ 
    border: 1px solid #a2a9b1;
    background-color: #f8f9fa;
    display: block;
    width: 400px;  
}
ol.list {
     counter-reset: item 
}
li.listNum{ 
    display: block ;
    margin-left: 0px; 
   letter-spacing: 0.5px;
}
li.countList:before { 
    content: counters(item, ".") " "; counter-increment: item 
}
.share-icon{
    left: 0px;
    line-height: 30px;
    position: inherit;
    z-index: unset;
    float: right;
    width: 50%;
    margin-top: -8px;

}

.span4{
    height: auto !important;

}

</style>



{/literal}
<div class="row-fluid hidden-phone">
    <div class="span12 dynamic-content bg-gs-wn" style="background-color: #e4edff;height: 85px;margin-bottom: 30px;">
        <div class="container">
         <div class="row">
            <div class="span6">  
                <div style="padding: 30px 10px 40px 10px; width: 700px;">
                    <p style="font-weight: normal; color: #a3c1ff;font-size: 20px;">{$pathway}</p>
                </div>
            </div> 
             <div class="span6" style="padding: 9px 0 20px 0;">
                <nav class="navbar navbar-light bg-light  pull-right " style="z-index: 0;">
                    <form class="form-inline" data-search="" data-instant="true" autocomplete="off" action="https://support.netway.co.th/hc/th/search" accept-charset="UTF-8" method="get">
                        <input style="font-weight: 300;max-width: 100%;box-sizing: border-box; utline: none;transition: border .12s ease-in-out; 
                        color: #000;font-size: 14px;margin-left: 0;" name="utf8" type="hidden" value="✓">  
                        <input class="form-control mr-sm-2 txt-kb" type="search" aria-label="ค้นหา หัวข้อ คำถาม ฯลฯ" name="query" id="query" placeholder="   ค้นหา หัวข้อ คำถาม ฯลฯ" autocomplete="off">
                        <button class=" btn-search" type="submit">ค้นหา</button>
                    </form>
            </nav>
            </div>
          </div>
        </div>
    </div>
</div>   

<div class="row-fluid visible-phone">
    <div class="span12 dynamic-content bg-gs-wn" style="background-color: #e4edff;height: 85px;">
        <div class="container">
         <div class="row">
            <div class="span6">  
                <div style="padding: 15px 0px 20px 3px; ">
                    <p style="color: #a3c1ff;font-size: 18px;">{$pathway}</p> 
                </div>
            </div> 
             <div class="span6" style="padding: 9px 0 20px 0;">
                <nav class="navbar navbar-light bg-light  pull-right " style="z-index: 0;">
                    <form class="form-inline" data-search="" data-instant="true" autocomplete="off" action="https://support.netway.co.th/hc/th/search" accept-charset="UTF-8" method="get">
                        <input style="font-weight: 300;max-width: 100%;box-sizing: border-box; utline: none;transition: border .12s ease-in-out; 
                        color: #000;font-size: 14px;margin-left: 0;" name="utf8" type="hidden" value="✓">  
                        <input class="form-  var toc     = $('.content').find('[TOC]');control mr-sm-2 txt-kb" type="search" aria-label="ค้นหา หัวข้อ คำถาม ฯลฯ" name="query" id="query" placeholder="   ค้นหา หัวข้อ คำถาม ฯลฯ" autocomplete="off" style=' margin-top: 30px;'>
                        <button class=" btn-search" type="submit" style="padding: 5px 17px;margin-top: 30px;">ค้นหา</button>
                    </form>
              </nav>
            </div>
          </div>
        </div>
    </div>
</div>   


{if $action == 'default'}
{literal}
    <style>
        
        section.hero {
            background-image: url('https://p5.zdassets.com/hc/theme_assets/1304520/115000070588/ns-banner.jpg');
            background-position: top center;
            background-repeat: no-repeat;
            height: 400px;
            padding: 0 20px;
            text-align: center;
            width: 100%;
        }
        
    </style>   
    {/literal}
 <div class="row-fluid white-kb-2018" > 
      <div class="container">
    {if $aDataCategory|@count}
        <div class="row">
           <div class="span12 dynamic-content" >
        {foreach from=$aDataCategory key=catId item=aCat}
            {if empty($aCat.section)}{continue}{/if}
            <div class="span4 ">
                <h4 class="section-tree-title">
                    <a href="{$ca_url}kb/{$aCat.name|rawurlencode}" style="color: #333333; ">
                        {$aCat.name}
                    </a>
                </h4>
            <ul>
                {foreach from=$aCat.section key=subId item=aSub}
                
                    {if preg_match("/^⚠/", $aSub.name)}{continue}{/if}
                    <li><a href="{$ca_url}kb/{$aCat.name|rawurlencode}/{$aSub.name|rawurlencode|replace:'%2F':'-'}" style="color: #333333;">{$aSub.name}</a></li>
                {/foreach}
            </ul>
            </div>
        {/foreach}
        </div>
    {/if}
       </div>
{/if}
</div>

{*$action*}

    {if $aSectionInCat|@count}
    <div class="container ">
    <div class=" section-tree ">
          {assign var=val value=0}
          {foreach from=$aSectionInCat key=catId item=aCat}
            {if empty($aCat.article)}{continue}{/if}
            {if $val == 0 }
               <div class="row">
            {/if}
            {assign var=val value=$val+1}
            <div class="span6 kb-section hidden-phone " style="margin: 30px 50px 30px 0!important;">
                <h4 class="section-tree-title" style="margin-bottom: 10px;">
                    
                    <a href="{$ca_url}kb/{$argss.2|rawurlencode}/{$aCat.name|rawurlencode|replace:'%2F':'-'}" style="color: #333333;font-size: 18px;">
                         {$aCat.name}
                         
                   </a>
                </h4>
               
            <ul class="article-list" style="list-style-type: none">
               {assign var=loop value=0} 
                {foreach from=$aCat.article key=subId item=aSub}
                  {if preg_match("/^⚠/", $aSub.title)}{continue}{/if}
                  {if $loop !=10}   
                       {assign var=loop value=$loop+1} 
                       <li class="article-list-item ">
                           {if $aSub.promoted}
                              <i class="fa fa-star " style="color: #379ee5;border: 1px solid;border-radius: 10px;padding: 2px 2px;font-size: 12px;" ></i>&nbsp;
                           {else}
                           <i class="fa fa-circle" style="font-size: 6px"></i>&nbsp;&nbsp;
                           {/if}
                               <a href="{$ca_url}kb/{$aSub.kb_article_id}" style="color: #333333;">
                                    {$aSub.title}
                               </a>
                            {if $loop ==10}   
                        </li>
                        {/if}
                    {/if}
           {/foreach}  
        
            </ul>
            {if $aCat.article|@count >10 }
              <a href="{$ca_url}kb/{$argss.2|rawurlencode}/{$aCat.name|rawurlencode|replace:'%2F':'-'}"  style="color: #337ab7;margin-left: 40px;">
                 ดูบทความทั้งหมด&nbsp;{$aCat.article|@count} &nbsp;บทความ
              </a>
             {/if}
            </div>
            
            <div class="span6 visible-phone">
                <h4 class="section-tree-title" style="margin-bottom: 10px;">
                    <a href="{$ca_url}kb/{$argss.2|rawurlencode}/{$aCat.name|rawurlencode|replace:'%2F':'-'}" style="color: #333333;font-size: 18px;">
                        {$aCat.name}
                    </a>
               </h4>
            <ul class="article-list" style="list-style-type: none">
                 {assign var=loop value=0} 
                   {foreach from=$aCat.article key=subId item=aSub}
                    {if preg_match("/^⚠/", $aSub.title)}{continue}{/if}
                     {if $loop !=10}   
                       {assign var=loop value=$loop+1} 
                        <li class="article-list-item "> 
                           {if $aSub.promoted}
                              <i class="fa fa-star " style="color: #379ee5;border: 1px solid;border-radius: 10px;padding: 2px 2px;font-size: 12px;" ></i>&nbsp;
                           {else}
                              <i class="fa fa-circle" style="font-size: 6px"></i>&nbsp;&nbsp;
                           {/if}
                               <a href="{$ca_url}kb/{$aSub.path|rawurlencode|replace:'%2F':'-'}-{$aSub.kb_article_id}" style="color: #333333;">
                                 {$aSub.title}
                               </a>    
                         {if $loop ==10}   
                        </li>
                        {/if}
                    {/if}
                    {/foreach} 
            </ul> 
              {if $aCat.article|@count >10 }
                 <a href="{$ca_url}kb/{$argss.2|rawurlencode}/{$aCat.name|rawurlencode|replace:'%2F':'-'}"  style="color: #337ab7;margin-left: 40px;">
                   ดูบทความทั้งหมด&nbsp;{$aCat.article|@count} &nbsp;บทความ
                 </a>
             {/if}
            </div>
            
       {if $val == 2 }     
     </div>
       {assign var=val value=0}
      {/if} 
    {/foreach}
  </div>
{/if}
</div>


    

{if $aArticleInSection|@count}
 <div class="container">
     <section class="section-content">
     <header class="page-header" >
        <h2>
            {$aArticleInSection.0.sectionName}
            </br>  
      </h2>
    </header>
    
    
            <ul class="article-list" style="list-style-type: none">
                {foreach from=$aArticleInSection key=subId item=aSub}
                {if isset($oAdmin.id)}
                    <li class="article-list-item ">
                        {if $aSub.promoted}
                          <i class="fa fa-star " style="color: #379ee5;border: 1px solid;border-radius: 10px;padding: 2px 2px;font-size: 12px;" ></i>&nbsp;
                        {else}
                        <i class="fa fa-circle" style="font-size: 6px"></i>&nbsp;&nbsp;
                       {/if}
                        
                        <a href="{$ca_url}kb/{$aSub.kb_article_id}" style="color: #333333;">
                            {$aSub.title}
                        </a>
                     
                   </li>
                {else}
                    {if isset($aSub.user_segment_id)}
                        <li class="article-list-item ">
                        {if $aSub.promoted}
                          <i class="fa fa-star " style="color: #379ee5;border: 1px solid;border-radius: 10px;padding: 2px 2px;font-size: 12px;" ></i>&nbsp;
                        {else}
                        <i class="fa fa-circle" style="font-size: 6px"></i>&nbsp;&nbsp;
                       {/if}
                        
                        <a href="{$ca_url}kb/{$aSub.kb_article_id}" style="color: #333333;">
                            {$aSub.title}
                        </a>
                    </li>
                    {else}
                    <h2>
                        User login ของคุณ ไม่สามารถดู Article ในหัวข้อนี้ได้ 
                        </br>  
                    </h2>
                    {/if}
                {/if}
                {/foreach}
            </ul>
     
</section>
{/if}
 </div>


{if $aArticleData|@count}
    {literal}
        <script>
            
            $(document).ready(function(){
               
               $("#bnt-subscript-login").click(function(){
                    window.open("/login",'_self');
                });
                
                $('#bnt-subscript').click(function(){
                    $(this).toggle();
                    $('#bnt-unsubscript').toggle();
                });
                $('#bnt-unsubscript').click(function(){
                    $(this).toggle();
                     $('#bnt-subscript').toggle();
                });
                
                $('#bnt-vote-up').click(function(){
                    $('#bnt-vote-down').removeClass("btn-primary");
                    $('#bnt-vote-down').addClass("btn-default");
                    if($(this).hasClass("btn-default")){
                        $('.article-vote-label').html('<i class="fa fa-spinner fa-spin" style="font-size:24px"></i>');
                        $.post( "?cmd=zendeskhandle&action=vote", 
                            {
                                articleID    : '{/literal}{$aArticleData.0.kb_article_id}{literal}' ,
                                vote        : 'up'
                            },
                        function( data ) {
                          //console.log(data.data);
                          getArticleVote();
                        });
                        $(this).removeClass("btn-default");
                        $(this).addClass("btn-primary");
                        
                    }else{
                        
                        $(this).removeClass("btn-primary");
                        $(this).addClass("btn-default");
                    }
                    
                });
                
                $('#bnt-vote-down').click(function(){
                    $('#senderEmail').select().focus();
                    $('#bnt-vote-up').removeClass("btn-primary");
                    $('#bnt-vote-up').addClass("btn-default");
                    if($(this).hasClass("btn-default")){
                        $('#articleModal').modal('toggle');
                        $('.article-vote-label').html('<i class="fa fa-spinner fa-spin" style="font-size:24px"></i>');
                        $.post( "?cmd=zendeskhandle&action=vote", 
                            {
                                articleID    : '{/literal}{$aArticleData.0.kb_article_id}{literal}' ,
                                vote        : 'down'
                            },
                        function( data ) {
                          //console.log(data.data);
                          getArticleVote();
                        });
                        $(this).removeClass("btn-default");
                        $(this).addClass("btn-primary");
                    }else{
                        $(this).removeClass("btn-primary");
                        $(this).addClass("btn-default");
                    }
                    
                });
                
                $.post( "?cmd=zendeskhandle&action=getArticleSubscription", 
                    {
                        articleID    : '{/literal}{$aArticleData.0.kb_article_id}{literal}'
                    },
                function( data ) {
                  //console.log(data.data);
                  var response = data.data;
                  
                  if(response.isSubscription == 1){
                      $('#bnt-unsubscript').show();
                      $('#bnt-unsubscript').val(response.subscriptionID);
                      $('#bnt-subscript').hide();
                  }else if(response.isSubscription == 0){
                      $('#bnt-subscript').show();
                      $('#bnt-unsubscript').hide();
                  }
                });
                
                $('#bnt-unsubscript').click(function(){
                    
                    $.post( "?cmd=zendeskhandle&action=articleUnSubscription", 
                    {
                        subscriptionID    : $(this).val() , 
                        articleID    : '{/literal}{$aArticleData.0.kb_article_id}{literal}'
                    },
                    function( data ) {
                        
                       // console.log(data.data);
                        
                    });
                });
                
                $('#bnt-subscript').click(function(){
                    
                    $.post( "?cmd=zendeskhandle&action=articleSubscription", 
                    {
                        articleID    : '{/literal}{$aArticleData.0.kb_article_id}{literal}'
                    },
                    function( data ) {
                        
                       // console.log(data.data);
                        var response = data.data;
                        $('#bnt-unsubscript').val(response.subscription.id);
                        
                        
                    });
                });
                
                $('#createVoteDownTicket').submit(function(){
                    var senderEmail = $('#senderEmail').val();
                    var comment     = $('#votedown_comment').val();
                    event.preventDefault();
                    $('div.modal-body').html('<i class="fa fa-spinner fa-spin" style="font-size:50px"></i>').css('text-align','center');
                    $.post( "?cmd=zendeskhandle&action=voteDownCreateTicket", 
                    {
                        articleID    : '{/literal}{$aArticleData.0.kb_article_id}{literal}' ,
                        url    : '{/literal}{$aArticleData.0.html_url}{literal}' ,
                        comment : ''+comment+'' ,
                        title   : '{/literal}{$aArticleData.0.title}{literal}' ,
                        author : '{/literal}{$aArticleData.0.author_id}{literal}' ,
                        senderEmail : senderEmail
                    },
                    function( data ) {
                        $('#articleModal').modal('toggle');
                       //console.log(data.data);
                        
                    });
                    
                });
            
          });
                
            getArticleVote(); 
            
        </script>
    {/literal}

    {php}
        $articleData = $this->get_template_vars('aArticleData');
        $articleUrl  = $articleData[0]['html_url'];
        $ch = curl_init(); 
        curl_setopt($ch, CURLOPT_URL, $articleUrl); 
        curl_setopt($ch,CURLOPT_RETURNTRANSFER,1);
        curl_setopt($ch,CURLOPT_USERAGENT,'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.13) Gecko/20080311 Firefox/2.0.0.13');
        $output = curl_exec($ch); 
        curl_close($ch);  
       
        $aClient    = hbm_logged_client();
        $this->assign('aClient',$aClient);
       
      
    {/php}
   
    {*$aClient.id*}   
   
      <div class="container hidden-phone" > 
         <div class="article-container" id="article-container" >
                <div class="article-sidebar" >
                   <section class="section-articles collapsible-sidebar ">  
                    <h3 class="collapsible-sidebar-title sidenav-title">บทความในส่วนนี้</h3>
                    
                    <ul>
                     {assign var=loop value=0}   
                    {foreach from=$aLeftHandArticleInSection key=subId item=aSub}
                     {if $loop !=10}   
                       {assign var=loop value=$loop+1} 
                            <li>
                                <a class=" sidenav-item" href="{$ca_url}kb/{$argss.2|rawurlencode}/{$aLeftHandArticleInSection.0.sectionName|rawurlencode}/{$aSub.path|rawurlencode|replace:'%2F':'-'}-{$aSub.kb_article_id}" 
                                style="text-decoration: none;{if $aArticleData.0.title == $aSub.title} color: gray;{else} color: #0088cc;{/if}">
                                    {$aSub.title}
                                </a>
                           {if $loop ==10}     
                            </li>
                          {/if}  
                        {/if}  
                    {/foreach}
                    </ul>
                     {if $aLeftHandArticleInSection|@count >10 }
                     <a href="{$ca_url}kb/{$argss.2|rawurlencode}/{$aLeftHandArticleInSection.0.sectionName|rawurlencode}"  style="color: #0088cc;margin-left: 40px;">
                       ดูเพิ่มเติม
                      </a>
                    {/if}
                    </section>
                 </div>
          
       
          <div class="article ">   
                <div class="article-header">
                     {if $oAdmin.id}
                        
                        <h1 class="article-title "style="padding: 0px 0px 0px 0px; margin-top: 20px;margin-bottom: 0px;">
                             {if empty($aArticleData.0.title)}  
                             {else}
                             {$aArticleData.0.title}  
                             <a href="https://pdi-netway.zendesk.com/knowledge/articles/{$aArticleData.0.kb_article_id}/th"  target="_blank" class="article-list-link"  >
                                 &nbsp; &nbsp; &nbsp;<i class="fa fa-edit " style="font-size: 28px;"></i>
                             </a>    
                             {/if}               
                        </h1>
                                          
                         {else}
                    <h1 class="article-title "style="padding: 0px 0px 0px 0px; margin-top: 20px;margin-bottom: 0px;">
                        {$aArticleData.0.title}           
                    </h1>
                    {/if}
                        <div class="article-author"> 
                          <div class="avatar article-avatar">
                               <span class="icon-agent"></span>                               
                               <img src="{if empty($aArticleData.0.zendesk_user_avatar)} https://pdi-netway.zendesk.com/system/photos/3603/7280/7591/logo-netway-440x440.jpg{else}{$aArticleData.0.zendesk_user_avatar}{/if}" class="img-circle pic-avatar" width="40px">
                           </div>
                           <div class="article-meta" style=" font-size: 16px;">            
                                   
                                  &nbsp;&nbsp;{$aArticleData.0.zendesk_user_name}
                               
                             <ul class="meta-group">
                                   <li class="meta-data">  &nbsp;&nbsp;อัพเดทเมื่อ  </li><li class="meta-data"> {$aArticleData.0.update_time}</li>
                             </ul>
                           </div>
                       </div>
                        
                            {if $aClient.id}
                                <button type="button" id="bnt-subscript" class="btn2018 btn-follow">
                                   ติดตาม
                                </button>
                                <button style="display: none;" id="bnt-unsubscript" type="button" class="btn2018 btn-outline-danger">
                                    <i class="fa fa-minus-circle"></i>&nbsp;&nbsp; ยกเลิกติดตาม
                               </button>
                            {else}
                                <button type="button" id="bnt-subscript-login" class="btn2018 btn-follow">
                                     ติดตาม
                               </button>
                            {/if}
                    
                  
        
                </div>
               <section class="article-info">
                 <div class="article-content">
                    <!-- <div class="tableOfContent"></div><br/> -->
                    <div class=" article-body content" id="kbContent"  style=" line-height: 1.6; word-wrap: break-word; font-size: 16px;">
                          {if empty($aArticleData.0.body)}
                           {$emptyArticle}
                          {else}
                               {$aArticleData.0.body}<br/><br/>
                          {/if}
                    </div>
                 {if ! empty($aArticleData.0.attachments)}
                    <ul class="attachments">                      
                      {foreach from=$aArticleData.0.attachments key=attach item=Aattach}
                        <li >
                            <a href="{$Aattach}" target="_blank" style="font-size: 16px; color: #08c;" class="gs-tooltip " >
                            <i class="fa fa-eye"></i> &nbsp;&nbsp;View File
                            <span class="gs-tooltiptext" style="margin-top: -60px;width: auto;box-shadow: 0 1px 16px rgba(0, 0, 0, 0.37);">
                            {assign var="url_catname" value="/"|explode:$Aattach}
                                {assign var="url_catname" value=$url_catname[6]}
                                {$url_catname}
                             </span>
                             </a>
                               &nbsp;&nbsp;|&nbsp;&nbsp;
                              <a href="{$Aattach}" class="attachment-meta-item meta-data"   download style="font-size: 16px;">
                                <i class="fa fa-download"></i>&nbsp;&nbsp;Download
                             </a>
                        </li>  
                        
                      {/foreach}  
                     </ul>   
                   {/if}               
                 </div>
                </section>
                <div class="article-votes" align="center" >
                
                    <span class="article-votes-question" style="margin-bottom: 30px;  font-size: 16px;">บทความนี้มีประโยชน์หรือไม่</span>
                    <div class="article-votes-controls" role="radiogroup" style="margin-top: 30px; margin-bottom: 30px;">
                        <button type="button" id="bnt-vote-up" class="btn2018 btn-outline-success btn-default">
                          <li class="fa fa-heart-o"></li> &nbsp; ใช่
                        </button>
                        <button type="button" id="bnt-vote-down" class="btn2018 btn-outline-success btn-default">
                          <li class="fa fa-close"></li> &nbsp;ไม่ใช่
                       </button>
                  </div>
                    <small class="article-votes-count">
                      <span class="article-vote-label"  style="font-size: 16px; color: #555555;">0 จาก 0 เห็นว่ามีประโยชน์</span>
                    </small>
                    <br><br>
                    <div style="margin-bottom: 30px;">
                        มีคำถามเพิ่มเติมหรือไม่ 
                        <a href="https://support.netway.co.th/hc/th/requests/new" style="color: #007bff; text-decoration: none;">
                            <i class="fa fa-send-o"></i> ส่งคำร้องขอ
                        </a>
                    </div>
                    <hr/>
                </div>
            
          </div>
       
      </div>
  </div>
  
   <div class="container visible-phone" style="line-height: 1.6;" > 
         <div class="row" >   
            <div class="span4" >
               <div class="row-c">
                  <div>
                    <h3>{$aArticleData.0.title}</h3>
                    
                    <div class="row-fluid">
                        <div class="span4">
                            <table>
                                <tr>
                                  <td rowspan="2">
                                      <img src="{if empty($aArticleData.0.zendesk_user_avatar)} https://pdi-netway.zendesk.com/system/photos/3603/7280/7591/logo-netway-440x440.jpg{else}{$aArticleData.0.zendesk_user_avatar}{/if}" class="img-circle pic-avatar" width="40px">
                                      </td>                           
                                  <td>&nbsp;&nbsp;{$aArticleData.0.zendesk_user_name}
                                     {if $oAdmin.id}
                                        <a href="https://pdi-netway.zendesk.com/knowledge/articles/{$aArticleData.0.kb_article_id}/th"  target="_blank" class="article-list-link"  >
                                        &nbsp; &nbsp; &nbsp;<i class="fa fa-edit " style="font-size: 28px;"></i>
                                        </a>
                                      {/if}     
                                  </td>  
                                </tr>
                                <tr>
                                    <td>&nbsp;&nbsp;อัพเดทเมื่อ {$aArticleData.0.update_time}</td>
                                </tr>
                            </table>
                            
                        </div>
                        <div class="span4">
                            {if $aClient.id}
                                <div style="float: left;width:40%;">
                                    <button type="button" id="bnt-subscript" class="btn2018 btn-follow"style="padding: 4px 11px;">
                                        ติดตาม
                                    </button>
                                   <button style= "display: none;" id="bnt-unsubscript" type="button" class="btn2018 btn-outline-danger">
                                        <i class="fa fa-minus-circle"></i>&nbsp;&nbsp; ยกเลิกติดตาม
                                   </button> 
                               </div>
                               <div class="a2a_kit a2a_kit_size_32 a2a_floating_style a2a_vertical_style  share-icon" style="width: 60%;" >
                                      <table style="width:100%">
                                        <tr>
                                            <td><span style="color: #2c5fbc;">Share&nbsp;</span></td>
                                            <td style="width: 15%;">
                                               <a class="a2a_button_facebook" target="_blank" href="/#facebook" rel="nofollow noopener">
                                                    <span class="a2a_svg a2a_s__default a2a_s_facebook" style="background-color: rgb(59, 89, 152);width: 37px;height: 36px;">
                                                        <svg focusable="false" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32">
                                                            <path fill="#FFF" d="M17.78 27.5V17.008h3.522l.527-4.09h-4.05v-2.61c0-1.182.33-1.99 2.023-1.99h2.166V4.66c-.375-.05-1.66-.16-3.155-.16-3.123 0-5.26 1.905-5.26 5.405v3.016h-3.53v4.09h3.53V27.5h4.223z"></path>
                                                       </svg>
                                                    </span><span class="a2a_label">Facebook</span>
                                                </a>
                                            </td>
                                            <td style="width: 15%;">
                                                <a class="a2a_button_line" rel="nofollow noopener" href="/#line" target="_blank" rel="nofollow noopener">
                                                    <span class="a2a_svg a2a_s__default a2a_s_line" style="background-color: rgb(0, 195, 0);width: 37px;height: 36px;">
                                                        <svg focusable="false" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32">
                                                            <path fill="#FFF" d="M28 14.304c0-5.37-5.384-9.738-12-9.738S4 8.936 4 14.304c0 4.814 4.27 8.846 10.035 9.608.39.084.923.258 1.058.592.122.303.08.778.04 1.084l-.172 1.028c-.05.303-.24 1.187 1.04.647s6.91-4.07 9.43-6.968c1.74-1.905 2.57-3.842 2.57-5.99zM11.302 17.5H8.918a.631.631 0 0 1-.63-.63V12.1a.63.63 0 0 1 1.26.002v4.14h1.754c.35 0 .63.28.63.628a.63.63 0 0 1-.63.63zm2.467-.63a.631.631 0 0 1-.63.628.629.629 0 0 1-.63-.63V12.1a.63.63 0 1 1 1.26 0v4.77zm5.74 0a.632.632 0 0 1-1.137.378l-2.443-3.33v2.95a.631.631 0 0 1-1.26 0V12.1a.634.634 0 0 1 .63-.63.63.63 0 0 1 .504.252l2.444 3.328V12.1a.63.63 0 0 1 1.26 0v4.77zm3.853-3.014a.63.63 0 1 1 0 1.258H21.61v1.126h1.755a.63.63 0 1 1 0 1.258H20.98a.63.63 0 0 1-.628-.63V12.1a.63.63 0 0 1 .63-.628h2.384a.63.63 0 0 1 0 1.258h-1.754v1.126h1.754z"></path>
                                                        </svg>
                                                    </span> 
                                                </a>
                                            </td>
                                            <td>
                                               <a class="a2a_dd" href="https://www.addtoany.com/share">
                                                    <span class="a2a_svg a2a_s__default a2a_s_a2a" style="background-color: rgb(1, 102, 255);width: 37px;height: 36px;">
                                                        <i class="fa fa-share-alt" style="font-size: 20px;color: #fff; margin: 7px 8px;"></i>
                                                   </span>                                                 
                                               </a>
                                            </td>
                                        </tr>
                                    </table>
                              </div>
                            {else}
                                <div style="float: left;width:40%;">
                                <button type="button" id="bnt-subscript-login" class="btn2018 btn-follow" style="padding: 4px 11px;">
                                     ติดตาม
                               </button>
                               </div>
                               <div class="a2a_kit a2a_kit_size_32 a2a_floating_style a2a_vertical_style  share-icon" style="width: 60%;">
                                      <table style="width:100%">
                                        <tr>
                                            <td><span style="color: #2c5fbc;">Share&nbsp;</span></td>
                                            <td style="width: 15%;">
                                               <a class="a2a_button_facebook" target="_blank" href="/#facebook" rel="nofollow noopener">
                                                    <span class="a2a_svg a2a_s__default a2a_s_facebook" style="background-color: rgb(59, 89, 152);width: 37px;height: 36px; ">
                                                        <svg focusable="false" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32">
                                                            <path fill="#FFF" d="M17.78 27.5V17.008h3.522l.527-4.09h-4.05v-2.61c0-1.182.33-1.99 2.023-1.99h2.166V4.66c-.375-.05-1.66-.16-3.155-.16-3.123 0-5.26 1.905-5.26 5.405v3.016h-3.53v4.09h3.53V27.5h4.223z"></path>
                                                       </svg>
                                                    </span><span class="a2a_label">Facebook</span>
                                                </a>
                                            </td>
                                            <td style="width: 15%;">
                                                <a class="a2a_button_line" rel="nofollow noopener" href="/#line" target="_blank" rel="nofollow noopener">
                                                    <span class="a2a_svg a2a_s__default a2a_s_line" style="background-color: rgb(0, 195, 0);width: 37px;height: 36px;">
                                                        <svg focusable="false" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32">
                                                            <path fill="#FFF" d="M28 14.304c0-5.37-5.384-9.738-12-9.738S4 8.936 4 14.304c0 4.814 4.27 8.846 10.035 9.608.39.084.923.258 1.058.592.122.303.08.778.04 1.084l-.172 1.028c-.05.303-.24 1.187 1.04.647s6.91-4.07 9.43-6.968c1.74-1.905 2.57-3.842 2.57-5.99zM11.302 17.5H8.918a.631.631 0 0 1-.63-.63V12.1a.63.63 0 0 1 1.26.002v4.14h1.754c.35 0 .63.28.63.628a.63.63 0 0 1-.63.63zm2.467-.63a.631.631 0 0 1-.63.628.629.629 0 0 1-.63-.63V12.1a.63.63 0 1 1 1.26 0v4.77zm5.74 0a.632.632 0 0 1-1.137.378l-2.443-3.33v2.95a.631.631 0 0 1-1.26 0V12.1a.634.634 0 0 1 .63-.63.63.63 0 0 1 .504.252l2.444 3.328V12.1a.63.63 0 0 1 1.26 0v4.77zm3.853-3.014a.63.63 0 1 1 0 1.258H21.61v1.126h1.755a.63.63 0 1 1 0 1.258H20.98a.63.63 0 0 1-.628-.63V12.1a.63.63 0 0 1 .63-.628h2.384a.63.63 0 0 1 0 1.258h-1.754v1.126h1.754z"></path>
                                                        </svg>
                                                    </span> 
                                                </a>
                                            </td>
                                            <td>
                                               <a class="a2a_dd" href="https://www.addtoany.com/share">
                                                    <span class="a2a_svg a2a_s__default a2a_s_a2a" style="background-color: rgb(1, 102, 255);width: 37px;height: 36px;">
                                                        <i class="fa fa-share-alt" style="font-size: 20px;color: #fff;margin: 7px 8px;"></i>
                                                   </span>                                                 
                                               </a>
                                            </td>
                                        </tr>
                                    </table>
                              </div>
                            {/if}
                        </div>
                    </div>
              <br/>
                </div>
                <div id='zoom-pic'>
                    {$aArticleData.0.body}
                </div>
           <div class="article-votes" align="center">
               <hr/>
                    <span class="article-votes-question">บทความนี้มีประโยชน์หรือไม่</span>
                    <div class="article-votes-controls" role="radiogroup">
                      <button type="button" id="bnt-vote-up" class="btn-outline-success btn-default">
                          <li class="fa fa-heart-o"></li> &nbsp;&nbsp; ใช่
                     </button>
                      <button type="button" id="bnt-vote-down" class="btn-outline-success btn-default"  style="margin-left: 10px">ไม่ใช่ </button>
                    </div>
                    <br/>
                    <small class="article-votes-count">
                      <span class="article-vote-label">0 จาก 0 เห็นว่ามีประโยชน์</span>
                    </small>
                    <br><br>
                    <div>
                        มีคำถามเพิ่มเติมหรือไม่ <a href="https://support.netway.co.th/hc/th/requests/new">ส่งคำร้องขอ</a>
                    </div>
                    <hr/>
                </div>
             </div>
          </div>
          
          <div class="span4"style="margin-left: 0px;margin-top: 25px" >
              <h4>บทความในส่วนนี้</h4>
                 <ul>
                   {assign var=loop value=0}   
                    {foreach from=$aLeftHandArticleInSection key=subId item=aSub}
                       {if $loop !=10}   
                       {assign var=loop value=$loop+1} 
                            <li >
                                <a class="kb-sidenav-item" href="{$ca_url}kb/{$argss.2|rawurlencode}/{$aLeftHandArticleInSection.0.sectionName|rawurlencode}/{$aSub.path|rawurlencode|replace:'%2F':'-'}-{$aSub.kb_article_id}"
                                style="text-decoration: none;{if $aArticleData.0.title == $aSub.title} color: gray;{else} color: #0088cc;{/if}">
                                    {$aSub.title}
                                </a>
                          {if $loop ==10}       
                           </li>
                          {/if}
                       {/if}    
                    {/foreach}
                </ul>
                
                 {if $aLeftHandArticleInSection|@count >10 }
                     <a href="{$ca_url}kb/{$argss.2|rawurlencode}/{$aLeftHandArticleInSection.0.sectionName|rawurlencode}"  style="color: #0088cc;margin-left: 40px;">
                       ดูเพิ่มเติม
                    </a>
                 {/if}
          </div>
       </div>
  </div>  
</div>
    
    <div class="modal fade" id="articleModal" role="dialog" style="display: none;" > 
            <div class="modal-dialog modal-lg">
              <div class="modal-content">
                <div class="modal-header">
                  <h4 class="modal-title">ความคิดเห็นต่อบทความนี้</h4>
                </div>
                <div class="modal-body">
                  <form id="createVoteDownTicket" method="post">
                      <div class="form-group">
                        <label for="senderEmail">Email address</label>
                        <input type="email" class="form-control" id="senderEmail" placeholder="name@example.com" required="required">
                      </div>  
                      <div class="form-group">
                        <label for="votedown_comment">ความคิดเห็น</label>
                        <textarea class="form-control" name="votedown_comment" id="votedown_comment" rows="3" style="width: 80%"></textarea>
                      </div>
                      <div class="form-group">
                          <input type="submit" value="ส่งความคิดเห็น" id="votedown_comment_send" />
                      </div>
                  </form>
                </div>
                <div class="modal-footer">
                  <!--<button type="button" class="btn btn-default" data-dismiss="modal" id="votedown_comment_send">ส่ง</button>-->
                </div>
              </div>
            </div>
          </div>
      </div>
{/if}
<br>



<div class="row-fluid white-nw-2018 visible-phone" style="padding: 30px 0px 30px 0px !important;"> 
      <div class="container" style="padding: 0px 0px 0px 15px !important;">
         <div class="row">
             <center><h3 class="h3-title-content g-txt32" style="color: #0052cd; font-weight: 300; ">Technical Knowledge</h3>
             <span class="nw-2018-content-line" style="margin-bottom: 30px;"></span></center>  
           </div>
            <div class="row ">
                    <div class="span3" style="margin-top:20px;padding: 0px 43px 0px 0px !important;">  
                      <dir  class="txt-tech-kb" >
                         Website/Install Application & FTP 
                        <hr style="margin-top:5px;" size="1" class="bottom-img-footer">
                      </dir>   
                      <div style="background-repeat: repeat-y;margin-left: 15px;" class="img-technical-web"></div>  
                      <dir style="folat:left;color: #64606c;font-size: 17px;font-weight: 100;margin-top: 15px"> 
                          ความรู้ทั่วไปเกี่ยวกับเว็บไซต์  วิธี Install Applications และ FTP
                      </dir>
                      <a href ="{$ca_url}kb/Website%20Install%20Application%20%26%20FTP">
                          <center>
                              <button class="btn-readmore-2018" style="margin-top: 30px;">อ่านเพิ่มเติม</button>
                          <center>
                     </a>
                </div>
                
                   <div class="span3" style="margin-top:20px;padding: 0px 43px 0px 0px !important;">    
                     <dir  class="txt-tech-kb" >
                         Linux Technical Knowledge
                        <hr style="margin-top:5px;" size="1" class="bottom-img-footer">
                      </dir>  
                     <div style="background-repeat: repeat-y;margin-left: 15px;" class="img-technical-linux"></div>
                     
                     <dir style="folat:left;color: #64606c;font-size: 17px;font-weight: 100;margin-top: 15px">
                         ความรู้ทั่วไป และวิธีแก้ไขปัญหา OS Linux Server
                    </dir>
                     <a href ="/kb/Linux%20Technical%20Knowledge">
                         <center>
                             <button class="btn-readmore-2018" style="margin-top: 30px;">อ่านเพิ่มเติม</button>
                        <center>
                     </a>  
                </div>
                
                     
                <div class="span3" style="margin-top:20px;padding: 0px 43px 0px 0px !important;">  
                  <dir  class="txt-tech-kb" >
                         Windows Technical Knowledge
                        <hr style="margin-top:5px;" size="1" class="bottom-img-footer">
                      </dir>  
                      <div style="background-repeat: repeat-y;margin-left: 15px;" class="img-technical-window"></div>
                       <dir style="folat:left;color: #64606c;font-size: 17px;font-weight: 100;margin-top: 15px">
                           ความรู้ทั่วไป และวิธีแก้ไขปัญหา  OS Windows Server
                       </dir>
                       <a href ="{$ca_url}kb/Windows%20Technical%20Knowledge">
                           <center>
                               <button class="btn-readmore-2018" style="margin-top: 30px;">
                                   อ่านเพิ่มเติม
                               </button>
                          <center>
                       </a>  
                </div>
                
               <div class="span3" style="margin-top:20px;padding: 0px 43px 0px 0px !important;">  
                       <dir  class="txt-tech-kb" >
                         Database
                        <hr style="margin-top:5px;" size="1" class="bottom-img-footer">
                      </dir>    
                         <div style="background-repeat: repeat-y;margin-left: 15px;" class="img-technical-database"></div>
                       <dir style="folat:left;color: #64606c;font-size: 17px;font-weight: 100;margin-top: 15px"> 
                           ความรู้ทั่วไป และวิธีแก้ไขปัญหา Database
                      </dir>
                       <a href ="{$ca_url}kb/Database">
                        <center>
                           <button class="btn-readmore-2018" style="margin-top: 30px;">อ่านเพิ่มเติม</button>
                        <center>
                      </a>    
                </div>
            </div>
        </div>
     </div>


 <div class="row-fluid white-nw-2018 hidden-phone" id="technical" style="padding: 40px 30px 40px 30px;margin-top: 60px;" > 
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
                      <dir style="folat:left;color: #64606c;font-size: 17px;font-weight: 100;margin-top: 15px"> 
                          ความรู้ทั่วไปเกี่ยวกับเว็บไซต์  วิธี Install Applications และ FTP
                      </dir>
                      <a href ="{$ca_url}kb/Website%20Install%20Application%20%26%20FTP">
                          <center>
                             <button class="btn-readmore-2018" style="margin-top: 30px;">อ่านเพิ่มเติม</button>
                          <center>
                      </a>
                </div>
                
                    <div class="span3">   
                     <dir  class="txt-tech-kb" >
                         Linux Technical Knowledge
                        <hr style="margin-top:5px;" size="1" class="bottom-img-footer">
                      </dir>  
                     <div class="img-technical-linux"></div>
                     
                     <dir style="folat:left;color: #64606c;font-size: 17px;font-weight: 100;margin-top: 15px">
                         ความรู้ทั่วไป และวิธีแก้ไขปัญหา OS Linux Server
                     </dir>
                     <a href ="{$ca_url}kb/Linux%20Technical%20Knowledge">
                         <center>
                             <button class="btn-readmore-2018" style="margin-top: 30px;">อ่านเพิ่มเติม</button>
                        <center>
                     </a>  
                </div>
                
                     
                <div class="span3">  
                  <dir  class="txt-tech-kb" >
                         Windows Technical Knowledge
                        <hr style="margin-top:5px;" size="1" class="bottom-img-footer">
                      </dir>  
                      <div class="img-technical-window"></div>
                       <dir style="folat:left;color: #64606c;font-size: 17px;font-weight: 100;margin-top: 15px">
                           ความรู้ทั่วไป และวิธีแก้ไขปัญหา  OS Windows Server
                       </dir>
                       <a href ="{$ca_url}kb/Windows%20Technical%20Knowledge">
                           <center>
                               <button class="btn-readmore-2018" style="margin-top: 30px;">อ่านเพิ่มเติม</button>
                           <center>
                      </a>  
                </div>
                
                <div class="span3">
                       <dir  class="txt-tech-kb" >
                         Database
                        <hr style="margin-top:5px;" size="1" class="bottom-img-footer">
                      </dir>    
                         <div class="img-technical-database"></div>
                       <dir style="folat:left;color: #64606c;font-size: 17px;font-weight: 100;margin-top: 15px"> 
                           ความรู้ทั่วไป และวิธีแก้ไขปัญหา Database
                       </dir>
                       <a href ="{$ca_url}kb/Database">
                         <center>
                            <button class="btn-readmore-2018" style="margin-top: 30px;">อ่านเพิ่มเติม</button>
                         <center>
                       </a>
                       
                </div>

            </div>
    </div>
  </div>
 {literal}
  <script>
    $(document).ready(function(){
      setTimeout(function(){ 
           var zoom = 0;
         $("#zoom-pic").each(function(){
            $(this).find('p img').addClass('zoomPic');
         });
            $( "p a img" ).removeClass('zoomPic');

          $('img.zoomPic').each(function(){
          
                var linkImg = $(this).attr('src');
                $(this).wrap( "<a href=\'"+linkImg+"\' data-lightbox=\'zoom-"+(zoom+=1)+"\'></a>" );
        
          });
         
                       
                       
        }, 5000);
        
        
     
        
    });             
  </script>
 {/literal}


{literal}
<script language="JavaScript">
   
    var TableOfContent     = function () {
        this.data   = {};
    };

TableOfContent.prototype.buildData  = function () {

    var i       = {h1:0,h2:0,h3:0,h4:0,h5:0};
    var oHead   = $('.content').find('h1:first');
    if (! oHead.length) {
        oHead   = $('.content').find('h2:first');
    }
    if (! oHead.length) {
        oHead   = $('.content').find('h3:first');
    }

    while (oHead.length) {
        var oData   = {};
        var text    = oHead.text();
        
        if (oHead.is('h1')) {
            i.h1++;
            var id = 'h1'+ i.h1; 
            oHead.prepend('<div id="'+ id +'"style="padding: 60px 0px 0px 0px;">');
            oData   = { 
                [i.h1]: { id: id, text: text, child: {} }
            };
            oTableOfContent.data    = $.extend(true, oTableOfContent.data, oData);
        }
        
        if (oHead.is('h2')) {
            i.h2++;
            var id = 'h2'+ i.h2;
            oHead.prepend('<div id="'+ id +'"style="padding: 58px 0px 0px 0px;">');
            oData   = {
                [i.h1]: {
                    child: {
                        [i.h2]: { id: id, text: text, child: {} }
                    }
                }
            };
            oTableOfContent.data    = $.extend(true, oTableOfContent.data, oData);
        }
        
        if (oHead.is('h3')) {
            i.h3++;
            var id = 'h3'+ i.h3;
            oHead.prepend('<div id="'+ id +'">');
            oData   = {
                [i.h1]: { 
                    child: {
                        [i.h2]: {
                            child: {
                                [i.h3]: { id: id, text: text, child: {} }
                            }
                        }
                    }
                }
            };
            oTableOfContent.data    = $.extend(true, oTableOfContent.data, oData);
        }
        
        if (oHead.is('h4')) {
            i.h4++;
            var id = 'h4'+ i.h4;
            oHead.prepend('<div id="'+ id +'"style="padding: 58px 0px 0px 0px;">');
            oData   = {
                [i.h1]: {
                    child: {
                        [i.h2]: {
                            child: {
                                [i.h3]: {
                                    child: {
                                        [i.h4]: { id: id, text: text, child: {} }
                                    }
                                }
                            }
                        }
                    }
                }
            };
            oTableOfContent.data    = $.extend(true, oTableOfContent.data, oData);
        }
        
        if (oHead.is('h5')) {
            i.h5++;
            var id = 'h5'+ i.h5;
            oHead.prepend('<div id="'+ id +'"style="padding: 58px 0px 0px 0px;">');
            oData   = {
                [i.h1]: { 
                    child: {
                        [i.h2]: {
                            child: {
                                [i.h3]: {
                                    child: {
                                        [i.h4]: {
                                            child: {
                                                [i.h5]: { id: id, text: text, child: {} }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            };
            oTableOfContent.data    = $.extend(true, oTableOfContent.data, oData);
        }
        
        oHead   = oHead.next();
       
    }

    
    //console.log(oTableOfContent.data);
    
    
    var html    = '';
    var wordContent ='<br><center>เนื้อหา</center>' ;
    var oData       = oTableOfContent.data;
    var count   = Object.keys(oData).length; 
    if (count == 1) {
      oData = oData['0'].child;
    }
    html        = oTableOfContent.getChild(oData);
    var toc     = $('#kbContent:contains("[TOC]")');
   
   
  
    if(toc.length){   console.dir(toc);
     $('p:contains("[TOC]")').attr('id','toc').html(); 
     //$('.tableOfContent').detach();
     $('#toc').attr('class','tableOfContent').html(wordContent+html);
     $('p:contains([TOC])').css('display','none');

      $('#kbContent').find('h1').css('background-color', '#f1f1f1' ).css('padding' ,'0 0 30px 10px');
      
    } 
    if(! toc.length){   
     $( 'h1' ).css( 'background-color', 'transparent' )

    } 
     if ( ! Object.keys(oTableOfContent.data).length) {
        $('.tableOfContent').hide();
    }
    
};

       

TableOfContent.prototype.getChild     = function (oData) { 
    
    var count   = Object.keys(oData).length; 
    var html    = '';
    
    if (count) {
        html += '<ol class="list" >';
        $.each(oData, function (k, v) {
          
         
            html += '<li class=" listNum countList "> <a  class="dynamic-nav"  href="#'+v.id+'" style="color:#0645ad" >'+ v.text;
           
            html += oTableOfContent.getChild(v.child);
            
            html += '</a></li>';
           
        });
        html += '</ol>';     
    }
    
    return html;
};


var oTableOfContent    = new TableOfContent(); 
$(document).ready( function () {
    oTableOfContent.buildData();
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

</script>



<script>
    $(document).ready(function(){
         
        $('#custom-search-form').submit(function(event){
           event.preventDefault();
           var stringSearch =   $('.search-query').val();
           window.open("https://support.netway.co.th/hc/th/search?utf8=%E2%9C%93&query="+stringSearch,'_self');
        });
        
     $('.faq-a').after('<hr class="hr-faq"/>');
     $('p').find('strong.title-faq').append('&nbsp;&nbsp;<i class=" expland fa fa-plus" style="color:#ff8400;cursor:pointer;font-size:16px;float:right"> Expand All</i>');
      
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

<link rel="stylesheet" href=" https://static.zdassets.com/hc/assets/application-bee674523c8aecd578b92ce25310bd7d.css">
<link rel="stylesheet"href=" https://p13.zdassets.com/hc/theming_assets/1304520/3187847/style.css?digest=360081720072&locale=th">
<link rel="stylesheet" href="https://netway.co.th/templates/lightbox/dist/css/lightbox.min.css">
<script src="https://netway.co.th/templates/lightbox/dist/js/lightbox-plus-jquery.min.js"></script>