{php}
$templatePath   = $this->get_template_vars('template_path');
include($templatePath . '/content/footer-corporate-temp.tpl.php');
{/php}
{literal}
<style>
	   .bg {
		        background-attachment: fixed;
		        background-repeat: no-repeat;
		        background-size: cover;
		        background-position: top;
		        height: 280px;
		        width: 100%;
		    }
            .re-txt-banner {
            font-size: 32px;
            font-family: 'Prompt', sans-serif; 
            font-style: normal;
            font-weight: 500;
            color: #fff;
            margin-top: 10px;

        }
        .bg-back {
	        background: rgba(0, 24, 192, 0.5);
	        height: 280px;
	    }
</style>   
{/literal}


<div class="bg hidden-phone lazy-hero" data-src="/templates/netwaybysidepad/images/bg-promo2018-min.png">
  <div class="bg-back">
         <div class="container" >
            <div class="row" >
        
                <div class="hero-inner" style="text-align: center;">
                        <h2 class="re-txt-banner" style="font-size: 45px; font-weight: 300;     margin-top: 110px; "> Promotion  </h2>           
                </div>
            </div>
        </div>
    </div>
</div>

{if $allPromo|@count}
<div class="row-fluid">
    <div class="span12 dynamic-content"  style="background: #fff; margin-top: 15px;">
       <div class="container">
          <div class="row kb-section-tree "> 
           
               {foreach from=$allPromo key=atId item=aAtr}
                 {if preg_match("/^Office365/", $aAtr.title) || preg_match("/^Office 365 /", $aAtr.title)}
                    {$aAtr.kb_article_id}
                 {else}
                 
                 {/if}
                <div class="row" style="margin-top: 50px;">
                    <div class="span6">
                        <img class="lazy"  data-src="{$aAtr.share_image}" class="img-promo"/>
                    </div>
                    <div class="span6" style="margin-top: 30px;  height: 210px;">
                        
                        <!--<p style="font-size: 18px;font-family: Roboto, Arial, sans-serif;">#โปรร้อนลดปรอทแตก!!  โปรโมชั่น Hot Hot จาก Netway  <b>ซื้อ Cloud Server ราคาเริ่มต้น 5,389.20 บ./ปี (แถมใช้งานฟรีอีก 3เดือน)</b></p> 
                        <a href="https://netway.co.th/promo-hotcloud"><button class="btn-readmore-2018" style="margin-top: 10px;">อ่านเพิ่มเติม</button></a>-->
                       
                        <p style="font-size: 18px;font-family: Roboto, Arial, sans-serif;">{$aAtr.title}</p> 
                        <a href="/kb/{$aAtr.category_name|urlencode}/{$aAtr.section_name|urlencode}/{$aAtr.kb_article_id}-{$aAtr.path|urlencode}"><button class="btn-readmore-2018" style="margin-top: 10px;">อ่านเพิ่มเติม</button></a>
                    
                    </div> 
                  <br>
                </div>  
                 
                {/foreach}
                  
                           
         </div>   
     </div>
  </div>

</div>
{/if}




