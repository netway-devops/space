{php}
$templatePath   = $this->get_template_vars('template_path');
include($templatePath . 'knowledgebase.tpl.php');
$oAdmin     = hbm_logged_admin();
$this->assign('oAdmin',$oAdmin);
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
    input[type="search"].txt-kb {
        width: 205px;
        height: 25px;
        font-size: 16px;
        font-weight: 100;
        border-radius: 30px;
        margin-top: 15px;   
        border-color: #c7c7c7;

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

   
      @media only all and (max-width: 768px) {
          section.hero {
            background: #FC466B;
            background: -webkit-linear-gradient(to right, #3F5EFB, #FC466B); 
            background: linear-gradient(to right, #3F5EFB, #FC466B);
        height:200px;
        }  
    }
     @media only all and (max-width: 480px) {  
        section.hero {
            background: #FC466B;
            background: -webkit-linear-gradient(to right, #3F5EFB, #FC466B); 
            background: linear-gradient(to right, #3F5EFB, #FC466B);
            height:200px;
        }
    }  
    .re-txt-banner {
        font-size  : 46px; 
        font-family: 'Prompt', sans-serif; 
        font-style : normal;
        font-weight: 700;
        color      : #FFFFFF;
        margin-top : 185px;
        text-shadow: 2px 2px 4px #0b58ad;
        letter-spacing : 2px;
        
    }
        
   
    .nw-banner {
        color: #FFF;
        text-align: center;
        font-size: 35px;
        font-family: 'Prompt', sans-serif;
        font-weight: bold;
        line-height: 40px;    
        background-color: transparent;
    }
     section.hero {
            background-image: url('https://netway.co.th/templates/netwaybysidepad/images/bg-all-categorys.png');
            background-position: top center;
            background-repeat: no-repeat;
            height: 475px;
            padding: 0 20px;
            text-align: center;
            width: 100%;
        }
        
        @media only all and (max-width: 768px) {
          section.hero {
           /*background: linear-gradient(to right, #ec2F4B, #009FFF);*/
        background-image: url('https://netway.co.th/templates/netwaybysidepad/images/bg-all-categorys.png');
        background-size: 108%;  
        height:200px;
        }  
    }
     @media only all and (max-width: 480px) {  
        section.hero {
        /*background: linear-gradient(to right, #ec2F4B, #009FFF);*/
        background-image: url('https://netway.co.th/templates/netwaybysidepad/images/bg-all-categorys.png');
        background-size: 108%;  
        height:200px;
        }
    }  
    
    hr.category {
    margin: 12px 275px 12px 70px;
    border: 0;
    border-top: 3px solid #eeeeee;
    border-bottom: 1px solid #ffffff;
}
    
  
</style>   
<script>
$(document).ready(function(){
    
      $("#myInput").on("keyup", function() {
        var value = $(this).val().toLowerCase();
        $("#mySearch ul").filter(function() {
          $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
        });
      });
   
});  
</script>

{/literal}
{if $oAdmin.id}
   <section class=" hero " >
        <div class="container" >
            <div class="row hidden-phone" >
                <div class="span6 ">
                    <div class="hero-inner">
                       <h2 class="re-txt-banner"> 
                          All  Categories
                       </h2>        
                       <hr class="category"/> 
                    </div>
               </div>
              <div class="span6"style="margin-left: 100px;width: 560px;">
                <img src="https://netway.co.th/templates/netwaybysidepad/images/img-all-categorys.png" alt="video-tutorial" 
                style=" margin-top: 40px;"> 
            </div>
        </div>
         <div class="row visible-phone">
            <div class="span12">              
               <h2 class="nw-banner" style="font-size: 38px; font-weight: 700;margin-top:80px; "> 
                    All  Categories  
              </h2>                  
            </div>
           </div>    
        </div>
    </section>

<div class="row-fluid ">
    <div class="span12 dynamic-content bg-gs-wn" style="background-color: #e4edff;height: 85px;margin-bottom: 30px;">
        <div class="container">
         <div class="row">
            <div class="span6 ">  
                <div style="padding: 30px 10px 40px 10px; ">
                    <p style="font-weight: normal; color: #a3c1ff;font-size: 20px;"><a style="color: #1473e6;text-decoration: none;" href="{$ca_url}kb">Knowledge Base </a></p> 
                </div>
            </div> 
            
            
           <div class="span6" style="padding: 9px 0 20px 0;">
                <nav class="navbar navbar-light bg-light  pull-right " style="z-index: 0;">
                    <form class="form-inline" data-search="" data-instant="true" autocomplete="off" action="https://support.netway.co.th/hc/th/search" accept-charset="UTF-8" method="get">
                        <input style="font-weight: 300;max-width: 100%;box-sizing: border-box; utline: none;transition: border .12s ease-in-out; 
                        color: #000;font-size: 14px;margin-left: 0;" name="utf8" type="hidden" value="✓">  
                        <input     id ="myInput" class="txt-kb" type="search" aria-label="ค้นหา หัวข้อ คำถาม ฯลฯ" name="query" placeholder="   ค้นหา หัวข้อ คำถาม ฯลฯ" autocomplete="off">
                        <!-- <button class=" btn-search" type="submit">ค้นหา</button> -->
                    </form>
            </nav>
            </div>
          </div>
        </div>
    </div>
</div>   
    {if $action == 'default'}
        <div class="row-fluid white-kb-2018"style="margin-bottom: 50px;"  > 
            {if $aDataCategory|@count}          
                <div class="container ">
                    <div class=" section-tree ">
                        {assign var=val value=0}
                          {foreach from=$aDataCategory key=catId item=aCat}
                            {if empty($aCat.section)}{continue}{/if}
                            {if $val == 0 }
                               <div class="row" style="margin-bottom: -25px;">
                            {/if}
                                {assign var=val value=$val+1}
                                <div class="span6 kb-section hidden-phone "id="mySearch">
                                    <h4 class="section-tree-title" style="margin-bottom:10px;padding: 15px 0px 15px 25px;background: #e4edff;">
                                        <a href="{$ca_url}kb/{$aCat.name|rawurlencode}"
                                         style="color: #000000;font-size: 18px;margin-top: 30px;
                                              text-decoration: none;font-weight: 300;font-family:Arial, sans-serif;">
                                            {$aCat.name}
                                        </a >
                                    </h4>                                    
                                <ul>
                                    {foreach from=$aCat.section key=subId item=aSub}
                                    {if preg_match("/^⚠/", $aSub.name)}{continue}{/if}
                                      <li class="article-list-item" style="padding: 6px 0 6px 0px;list-style: none;">
                                          <i class="fa fa-square" style="font-size: 14px;color: #ccc;"></i>
                                          &nbsp;&nbsp;
                                          <a href="{$ca_url}kb/{$aCat.name|rawurlencode}/{$aSub.name|rawurlencode}" style="color: #333333;">
                                              {$aSub.name}
                                         </a>
                                     </li>
                                    {/foreach}
                                </ul>
                              </div>
                              <div class="visible-phone ">
                                    <h4 class="section-tree-title" style="margin-bottom:10px;padding: 15px 0px 15px 25px;background: #e4edff;">
                                        <a href="{$ca_url}kb/{$aCat.name|rawurlencode}"
                                         style="color: #000000;font-size: 18px;margin-top: 30px;
                                              text-decoration: none;font-weight: 300;font-family:Arial, sans-serif;">
                                            {$aCat.name}
                                        </a >
                                    </h4>                                    
                                <ul>
                                    
                                    {foreach from=$aCat.section key=subId item=aSub}
                                    {if preg_match("/^⚠/", $aSub.name)}{continue}{/if}
                                    
                                      <li class="article-list-item" style="padding: 6px 0 6px 0px;list-style: none;">
                                          <i class="fa fa-square" style="font-size: 14px;color: #ccc;"></i>
                                          &nbsp;&nbsp;
                                          <a href="{$ca_url}kb/{$aCat.name|rawurlencode}/{$aSub.name|rawurlencode}" style="color: #333333;">
                                              {$aSub.name}
                                         </a>
                                     </li>
                                    {/foreach}
                                </ul>
                              </div>
                            {if $val == 2 }     
                            </div>
                                {assign var=val value=0}
                           {/if} 
                    {/foreach}
                  </div>
                </div>  
                {/if}         
         </div>        
{/if}
{else}
<div class="row-fluid" style="margin-top: 50px;margin-bottom: 50px">
    <div class="span12 dynamic-content bg-gs-wn">
        <div class="container">
         <div class="row">
            <div class="span12">  
                <div style="padding: 15px 0px 20px 3px;text-align: center " >
                    <i class="fa fa-exclamation-triangle" style="font-size: 26px;color:#ff9800"></i>&nbsp;&nbsp;
                    <span style="color: #000000;font-size: 20px;">คุณไม่สารมารถดูหน้านี้ได้เนื่องจาก Email ที่ Log-in ของคุณไม่ใช่ Staff</span
                        > 
                </div>
            </div>     
          </div>
        </div>
    </div>
</div>   

{/if}