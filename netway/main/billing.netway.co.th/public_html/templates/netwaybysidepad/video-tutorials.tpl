{php}
$templatePath   = $this->get_template_vars('template_path');
include($templatePath . 'video-tutorials.tpl.php');
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
    section.hero {     
	        background-color: #281c99;
	        height: 333px;
    }  
      @media only all and (max-width: 768px) {
          section.hero {
            background-color: #281c99;
            height:333px;
        }  
    }
     @media only all and (max-width: 480px) {  
        section.hero {
            background-color: #281c99;
            height:200px;
        }
    }  
    .re-txt-banner {
        font-size: 32px;
        font-family: 'Prompt', sans-serif; 
        font-style: normal;
        font-weight: 500;
        color: #fff;
        margin-top: 10px;
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
  
</style>   

<script>
    $(document).ready(function(){
         
        $('#custom-search-form').submit(function(event){
           event.preventDefault();
           var stringSearch =   $('.search-query').val();
           window.open("https://support.netway.co.th/hc/th/search?utf8=%E2%9C%93&query="+stringSearch,'_self');
        });
   });
</script>    
{/literal}

   <section class="section hero " >
        <div class="container" >
            <div class="row hidden-phone" >
                <div class="span6 ">
                    <div class="hero-inner">
                       <h2 class="re-txt-banner" style="font-size: 45px; font-weight: 300;margin-top: 150px; "> 
                           Video Tutorials  
                       </h2>             
                    </div>
               </div>
              <div class="span6"  style="text-align:center;">
                <img src="https://netway.co.th/templates/netwaybysidepad/images/Video-Tutorials-min.png" alt="video-tutorial" />
            </div>
        </div>
         <div class="row visible-phone">
            <div class="span12">              
               <h2 class="nw-banner" style="font-size: 38px; font-weight: 500;margin-top:80px; "> 
                    Video Tutorials  
              </h2>                  
            </div>
           </div>    
        </div>
    </section>

<div class="row-fluid hidden-phone">
    <div class="span12 dynamic-content bg-gs-wn" style="background-color: #e4edff;height: 100px;">
        <div class="container">
         <div class="row">
             <div class="span6">  
                <div style="padding: 30px 10px 40px 10px; width: 700px;">
                    <p style="font-weight: normal; color: #1473e6;font-size: 20px;">Video Tutorials</p> 
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
    <div class="span6 dynamic-content bg-gs-wn" style="background-color: #e4edff;height: 85px;">
        <div class="container">
            <div class="row">
                <div class="span12" style="padding: 9px 0 20px 0;">
                    <nav class="navbar navbar-light bg-light  pull-right " style="z-index: 0;">
                        <form class="form-inline" data-search="" data-instant="true" autocomplete="off" action="https://support.netway.co.th/hc/th/search" accept-charset="UTF-8" method="get">
                            <input style="font-weight: 300;max-width: 100%;box-sizing: border-box; utline: none;transition: border .12s ease-in-out; 
                            color: #000;font-size: 14px;margin-left: 0;" name="utf8" type="hidden" value="✓">  
                            <input class="form-  var toc     = $('.content').find('[TOC]');control mr-sm-2 txt-kb" type="search" aria-label="ค้นหา หัวข้อ คำถาม ฯลฯ" name="query" id="query" placeholder="   ค้นหา หัวข้อ คำถาม ฯลฯ" autocomplete="off" style=" margin-top: 30px;">
                            <button class=" btn-search" type="submit" style="padding: 8px 22px;margin-top: 30px;">ค้นหา</button>
                        </form>
                    </nav>
                </div>
            </div>
        </div>
    </div>
</div>

  {if $videoCategory|@count}
    <div class="container ">
    <div class="row kb-section-tree ">
          {assign var=val value=0}
          {foreach from=$videoCategory key=catId item=aCat}
            {if empty($aCat.section)}{continue}{/if}
            {if $val == 0 }
               <div class="row">
            {/if}
            {assign var=val value=$val+1}
            <div class="span6 kb-section hidden-phone ">
                <h4 class="section-tree-title" style="margin-bottom: 10px;">
                    <a href="{$ca_url}kb/{$aCat.name|rawurlencode}" style="color: #333333;font-size: 18px;">
                        {$aCat.name}
                    </a>
                </h4>
           <ul>
                {foreach from=$aCat.section key=subId item=aSub}
                    {if preg_match("/^⚠/", $aSub.name)}{continue}{/if}
                    <li><a href="{$ca_url}kb/{$aCat.name|rawurlencode}/{$aSub.name|rawurlencode}" style="color: #333333;">{$aSub.name}</a></li>
                {/foreach}
            </ul>
            </div>
            <div class="span6  visible-phone"><h4 class="section-tree-title" style="margin-bottom: 10px;"><a href="{$ca_url}kb/{$aCat.name|rawurlencode}" style="color: #333333;font-size: 18px;">{$aCat.name}</a></h4>
            <ul>
                {foreach from=$aCat.section key=subId item=aSub}
                    {if preg_match("/^⚠/", $aSub.name)}{continue}{/if}
                    <li><a href="{$ca_url}kb/{$aCat.name|rawurlencode}/{$aSub.name|rawurlencode}" style="color: #333333;">{$aSub.name}</a></li>
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

