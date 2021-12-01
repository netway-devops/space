{php}
$templatePath   = $this->get_template_vars('template_path');
include($templatePath . 'tag_article.tpl.php');
$oAdmin     = hbm_logged_admin();
$this->assign('oAdmin',$oAdmin);
{/php}
              
{literal}

<style type ="text/css">
span.nw-2018-content-line{
      width: 194px;  
}
</style>
{/literal}
{if $oAdmin.id}
<div class="row-fluid hidden-phone">
    <div class="span12 dynamic-content bg-gs-wn" style="background-color: #e4edff;height: 85px;margin-bottom: 30px;">
        <div class="container">
         <div class="row">
            <div class="span6">  
                <div style="padding: 30px 10px 40px 10px; width: 700px;">
                    <p style="font-weight: normal; color: #a3c1ff;font-size: 20px;">{$pathway}</p> 
                </div>
            </div> 
          </div>
        </div>
    </div>
</div>
<div class="row-fluid visible-phone">
    <div class="span12 dynamic-content bg-gs-wn" style="background-color: #e4edff;height:55px;">
        <div class="container">
         <div class="row">
            <div class="span6">  
                <div style="padding: 15px 0px 20px 3px; ">
                    <p style="color: #a3c1ff;font-size: 18px;">{$pathway}</p> 
                </div>
            </div> 
             
          </div>
        </div>
    </div>
</div>  

    <div class="row-fluid white-kb-2018" > 
        <div class="container ">
            <div class="row kb-section-tree "> 
                <div class="row">
                  <center>
                     <h3 class="h3-title-content g-txt32" style="color: #0052cd; font-weight:300;">
                        Articles of {$nameTag} Tag  
                     </h3>
                     <span class="nw-2018-content-line" style="margin-bottom: 30px;"></span>
                 </center>  
               </div>   
           </div>   
        </div>     
 
        <div class="container "> 
           
               {assign var=val value=0}
                   {if $val == 0 }
                       <div class="row">
                   {/if}
                   {assign var=val value=$val+1}
                  {foreach from=$showArticleTag key=tagName item=aName}
                  <div class="span6 hidden-phone " style="margin: 0px 0px 0px 0;">
                  <ul  class="article-list" style="list-style-type: none">
                            <li class="article-list-item ">
                                {if $aName.promoted}
                                  <i class="fa fa-star " style="color: #379ee5;border: 1px solid;border-radius: 10px;padding: 2px 2px;font-size: 12px;" ></i>&nbsp;
                                {else}
                                <i class="fa fa-circle" style="font-size: 6px"></i>&nbsp;&nbsp;
                               {/if}
                                <a href="{$ca_url}kb/{$aName.categoryName|rawurlencode}/{$aName.sectionName|rawurlencode}/{$aName.kb_article_id}-{$aName.path|rawurlencode}" style="color: #333333;">
                                    {$aName.title}
                                </a>
                             
                           </li> 
                           </ul>
                     </div>
                     {/foreach} 
                    {if $val == 2 }      
                </div>
                  {assign var=val value=0}
                      {/if}
                  
            </div>
        </div>
        
    

    <div class="container visible-phone">
     <section class="section-content">
            <ul class="article-list" style="list-style-type: none">
                  {foreach from=$showArticleTag key=tagName item=aName}
                    <li class="article-list-item ">
                        {if $aName.promoted}
                            <i class="fa fa-star " style="color: #379ee5;border: 1px solid;border-radius: 10px;padding: 2px 2px;font-size: 12px;" ></i>&nbsp;
                        {else}
                            <i class="fa fa-circle" style="font-size: 6px"></i>&nbsp;&nbsp;
                        {/if}
                           <a href="{$ca_url}kb/{$aName.categoryName}/{$aName.sectionName}/{$aName.kb_article_id}-{$aName.path}" style="color: #333333;">
                        {$aName.title}
                           </a>
                    </li>
                {/foreach}
            </ul>
        </section>
    </div>
{else}
<div class="row-fluid">
    <div class="span12 dynamic-content bg-gs-wn">
        <div class="container">
         <div class="row">
            <div class="span6">  
                <div style="padding: 15px 0px 20px 3px; ">
                    <p style="color: #000000;font-size: 18px;"><strong style="color: red">**</strong>คุณไม่สารมารถดูหน้านี้ได้เนื่องจาก User ของคุณไม่ใช่ Staff</p> 
                </div>
            </div>     
          </div>
        </div>
    </div>
</div>   
{/if}