{php}
$templatePath   = $this->get_template_vars('template_path');
include($templatePath . 'kb.tpl.php');
{/php}


{literal}
<style>

section.hero {
    background: url(https://netway.co.th/templates/netwaybysidepad/images/bg-kb-img-2018-2.png); 
    background-position: top center;
    background-repeat: no-repeat;
    background-attachment: fixed;
    background-position: top;
    padding: 0 20px;
    text-align: center;
    background-size: cover;
    height: 420px;
}
@media only all and (max-width: 768px) {
    section.hero {
        background: linear-gradient(to right, #ec2F4B, #009FFF);
        background-size: 165%;  
        height:200px;
    }  
}
@media only all and (max-width: 480px) {  
    section.hero {
        background: linear-gradient(to right, #ec2F4B, #009FFF);
        background-size: 165%;  
        height:200px;
    }
}

a.font-color{
    color: #333;
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
    padding: 0px;
}
.nw-banner1{
    padding: 30px 0 0 0;
    color: #FFF;
    text-align: left;
    font-size: 35px !important;
    font-family: 'Prompt', sans-serif;
    font-weight: bold;
    line-height: 40px;
    margin-top: 60px;
    margin-left: 20px;
    background-color:transparent ;  
            
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
    text-shadow: 4px 0 0 rgba(255, 255, 255, 0.3)
    
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
    width: 264px;
    height: 31px;
    font-size: 16px;
    font-weight: 100;
    border-radius: 30px;
}
.btn-search {
    border: none;
    color: #FFFFFF;
    background-color: #FF7E00;
    padding: 10px 30px;
    font-size: 20px;
    font-weight: 600;
    text-decoration: none;
    margin-top: -2px;
    border-radius: 30px;
}
.btn-search:hover {
    border: none;
    color: #FFF;
    background-color: #FF3000;
    padding: 10px 30px;
    font-size: 20px;
    font-weight: 600;
    text-decoration: none;
    margin-top: -2px; 
    border-radius: 30px;

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
.kb-product-other{
    color:#333333;
}
.kb-product-other:hover {
    color:#0088cc;
}
.kb-request-button {
    background-color: #656565;
    z-index: 10000;
    cursor: pointer!important;
    height: 47px;
    bottom: 0px;
    vertical-align: middle;
    padding: 9px 0px 13px 0px;
    color: white;
    position: fixed;
    font-size: 16px;
    border: 1px solid #454444;
    text-align: center;
}
.coming-pro{
    -webkit-filter: grayscale(100%);       
}
    
body{
    overflow:-moz-scrollbars-vertical;
    overflow-x: hidden;
    overflow-y: scroll;
}
div.payment-div-visible-phone{
    float: left;
    width: 165px;
    padding: 20px 0px 20px 0px;
}
div.product-div-visible-phone{
    float: left;
    width: 150px;
    padding: 20px 0px 20px 0px;
}
    
</style>

{/literal}


{if $action == 'default'}

    <section class="section hero">
        <div class="container">  
            <div class="row hidden-phone" style="padding: 30px 0 30px 0;">
                <div class="span6 ">
                     <img src="https://netway.co.th/templates/netwaybysidepad/images/img-banner-kb-2018.png"  alt="Img-KB"  style="display:none;" >
                </div>
                <div class="span6">
                    <div class="hero-inner" style="margin-left: 20px;">
                    <h1 class="nw-banner1">Netway Support Center</h1>
                <p class="nw-banner2"> เราพร้อมบริการคุณ ตลอด 
                    <span class="nw-banner3"> 24 </span>ชั่วโมง
                </p>    
                <nav class="navbar navbar-light bg-light " style="z-index: 0;">
                    <form class="form-inline" data-search="" data-instant="true" autocomplete="off" action="https://support.netway.co.th/hc/th/search" accept-charset="UTF-8" method="get">
                        <input style="font-weight: 300;max-width: 100%;box-sizing: border-box; utline: none;transition: border .12s ease-in-out; 
                                color: #000;
                                font-size: 14px;
                                margin-left: 0;" 
                                name="utf8" type="hidden" value="✓">  
                        <input class="form-control mr-sm-2 txt-kb" type="search" aria-label="  ค้นหา หัวข้อ คำถาม ฯลฯ" name="query" id="query" placeholder="ค้นหา หัวข้อ คำถาม ฯลฯ" autocomplete="off">
                        <button class=" btn-search" type="submit">ค้นหา</button>
                    </form>
                </nav> 
                </div>
                </div>
            </div>
            <div class="row visible-phone">
            <div class="span12">
                    <div style="margin-top: -30px">
                    <h1 class="nw-banner1" style="font-size: 25px;margin-left: 12px;text-align: center;">Netway Support Center </h1>
                <center>
                <p class="nw-banner2" style="font-size: 19px;margin-left: 8px;"> เราพร้อมบริการคุณตลอด  
                    <b style="color: yellow;font-size: 22px;font-weight: normal;text-shadow: 2px 0 0 rgba(255, 255, 255, 0.3);">
                        24
                    </b> 
                    ชั่วโมง
                </p>    
                </center>
                
                <nav class="navbar navbar-light bg-light hidden-phone" style="z-index: 0;">
                    <form class="form-inline" data-search="" data-instant="true" autocomplete="off" action="https://support.netway.co.th/hc/th/search" accept-charset="UTF-8" method="get">
                        <input style="font-weight: 300;max-width: 60%;box-sizing: border-box; utline: none;transition: border .12s ease-in-out; 
                                color: #000;
                                font-size: 14px;
                                margin-left: 0;" 
                                name="utf8" type="hidden" value="✓">  
                        <input class="form-control mr-sm-2 txt-kb" type="search" aria-label="ค้นหา หัวข้อ คำถาม ฯลฯ" name="query" id="query" placeholder="ค้นหา หัวข้อ คำถาม ฯลฯ" autocomplete="off">
                        <br/>
                        <button  style="margin-top:5px;" class=" btn-search" type="submit">ค้นหา</button>
                    </form>
                </nav> 
                
                <nav class="navbar navbar-light bg-light hidden-phone" style="z-index: 0;">
                    <form class="form-inline" data-search="" data-instant="true" autocomplete="off" action="https://support.netway.co.th/hc/th/search" accept-charset="UTF-8" method="get">
                        <input style="font-weight: 300;max-width: 60%;box-sizing: border-box; utline: none;transition: border .12s ease-in-out; 
                                color: #000;
                                font-size: 14px;
                                margin-left: 0;" 
                                name="utf8" type="hidden" value="✓">  
                        <input class="form-control mr-sm-2 txt-kb" type="search" aria-label="ค้นหา หัวข้อ คำถาม ฯลฯ" name="query" id="query" placeholder="ค้นหา หัวข้อ คำถาม ฯลฯ" autocomplete="off">
                        <br/>
                        <button  style="margin-top:5px;" class=" btn-search" type="submit">ค้นหา</button>
                    </form>
                </nav> 
                </div>
                </div>
              </div>  
          </div>
    </section>
    
    <section id="customTab" style="margin-top: 0px;   background-color: #4489FF;">
        <div class="dynamic-menu hidden-phone  container " style="background-color: #4489FF; width: 100%;">
           <div class="container">
            <ul class="dynamic-nav ">
                
                <li class="dynamic-nav "><a class="dynamic-nav nav-faq" href="#Payment" >Payment & Invoices</a></li>
                <li class="dynamic-nav"><a class="dynamic-nav nav-datasheet" href="#Products">Products Knowledge</a></li>
                <li class="dynamic-nav"><a class="dynamic-nav nav-servicerequest" href="#technical">Technical Knowledge</a></li>
                <li class="dynamic-nav"><a class="dynamic-nav nav-servicerequest" href="{$ca_url}kb/Blog">Blog</a></li>
                <li class="dynamic-nav" style="display: none;"><a class="dynamic-nav nav-servicerequest" href="{$ca_url}video-tutorials">Video Tutorials</a></li>
                {if $oAdmin.id}
                <li class="dynamic-nav"><a class="dynamic-nav nav-servicerequest" href="{$ca_url}all-categorys">All  Categories</a></li>
                <li class="dynamic-nav"><a class="dynamic-nav nav-servicerequest" href="{$ca_url}tags">Tags</a></li>
                {/if}
                <li class="dynamic-nav"><a class="dynamic-nav nav-datasheet" href="#empty"></a></li>  
            </ul>
            </div>
        </div>


<div class="">
<div class="row-fluid">
    
      <div class="span12 dynamic-content bg-gs-wn" id="hide"  style="background-color: #e4edff;">
           <div class="container">
                <div class="row" style="padding: 120px 10px 120px 10px;">
                  <div class="span12">  
                    <div style="text-align: center;  margin-bottom: -30px;">
                    <h3 class="nw-slogan1 hidden-phone">"บริการหลังการขาย  คือหัวใจหลักของเรา"</h3> 
                     <h5 class="nw-slogan1 visible-phone" style="font-size: 26px; line-height: 40px;">"บริการหลังการขาย  คือหัวใจหลักของเรา"</h5> 
                    <br>
                    <center>     
                    <a  class="nw-kb-btn-ticket" href="https://support.netway.co.th/hc/th/requests/new?_ga=2.106104899.198303363.1523234258-758666310.1510801410">
                       &nbsp;&nbsp;ส่งคำร้องขอ
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
    
<div class="row-fluid white-kb-2018" id="Payment" style="padding: 120px 10px 120px 10px;" > 
        <div class="container" >
            <div class="row">
               <div class="span12 dynamic-content"   >
             <center><h3 class="h3-title-content g-txt32" style="color: #0052cd; font-weight: 300; ">Payment & Invoices</h3>
             <span class="nw-2018-content-line" style="margin-bottom: 100px;"></span></center>          
               </div>
            </div>
       </div>
       <div class="container visible-phone">
            <div class="row " style="text-align: center;">
                
                   <div class="payment-div-visible-phone" 
                   style=" border-right: 3px solid #d8e1e8; border-bottom: 3px solid #d8e1e8;">
                     <a href="{$ca_url}kb/{'การชำระเงินและเอกสารทางบัญชี'|rawurlencode}/{'ข้อมูลทั่วไป'|rawurlencode}">
                         <img src="https://netway.co.th/templates/netwaybysidepad/images/icon-nomal-hover.png"  width= "62px;"> 
                     </a> 
                      <br/> <br/>
                      <a href="{$ca_url}kb/{'การชำระเงินและเอกสารทางบัญชี'|rawurlencode}/{'ข้อมูลทั่วไป'|rawurlencode}">
                          <p class="txt-payment-kb" style="font-size: 16px;">ทั่วไป</p>
                      </a>
                   
                   </div>
                   <div class="payment-div-visible-phone" style="border-bottom: 3px solid #d8e1e8;">
                      <a href="{$ca_url}kb/{'การชำระเงินและเอกสารทางบัญชี '|rawurlencode}/{'Order - การสั่งซื้อ.'|rawurlencode}/360018717612-{'6 ขั้นตอนง่ายๆ ในการสั่งซื้อกับ Netway'|rawurlencode}">
                        <img src="https://netway.co.th/templates/netwaybysidepad/images/icon-payment-cart-2018new.png" width= "62px;"> 
                      </a>
                       <br/> <br/>  
                     <a href="{$ca_url}kb/{'การชำระเงินและเอกสารทางบัญชี '|rawurlencode}/{'Order - การสั่งซื้อ.'|rawurlencode}/360018717612-{'6 ขั้นตอนง่ายๆ ในการสั่งซื้อกับ Netway'|rawurlencode}">
                        <p class="txt-payment-kb" style="font-size: 16px;">การสั่งซื้อ</p>
                      </a>

              </div>
            </div>
         </div>
         <div class="container visible-phone">
            <div class="row " style="text-align: center;">
                
                   <div class="payment-div-visible-phone" style="    border-right: 3px solid #d8e1e8;" >
                      <a href="{$ca_url}kb/{'การชำระเงินและเอกสารทางบัญชี'|rawurlencode}/{'Payment - การชำระเงิน'|rawurlencode}">
                          <img src="https://netway.co.th/templates/netwaybysidepad/images/icon-payment-2018new.png" width= "62px;"> 
                      </a> 
                      <br/> <br/>
                       <a href="{$ca_url}kb/{'การชำระเงินและเอกสารทางบัญชี'|rawurlencode}/{'Payment - การชำระเงิน'|rawurlencode}">
                         <p class="txt-payment-kb" style="font-size: 16px;" >การชำระเงิน</p> 
                      </a> 
                  
                   
                   </div>
                   <div class="payment-div-visible-phone">
                       <a href="{$ca_url}kb/{'การชำระเงินและเอกสารทางบัญชี'|rawurlencode}/{'Tax Invoice - การออกใบกำกับภาษี'|rawurlencode}">
                            <img src="https://netway.co.th/templates/netwaybysidepad/images/icon-billing.png" width= "62px;"> 
                     </a> 
                     <br/> <br/> 
                       <a href="{$ca_url}kb/{'การชำระเงินและเอกสารทางบัญชี'|rawurlencode}/{'Tax Invoice - การออกใบกำกับภาษี'|rawurlencode}">
                           <p class=" txt-payment-kb" style="font-size: 16px;" >การออกใบกำกับภาษี</p>
                      </a> 
                    
                   </div>
            </div>
         </div>
         
         <div class="container hidden-phone">
            <div class="row ">
                    <div class="span3 hover-Payment"  style="border-left: 3px solid #d8e1e8; ">   
                    
                     <a href="{$ca_url}kb/{'การชำระเงินและเอกสารทางบัญชี'|rawurlencode}/{'ข้อมูลทั่วไป'|rawurlencode}">
                         <div class="icon-payment-exchange"></div>
                     </a> 
                      <a href="{$ca_url}kb/{'การชำระเงินและเอกสารทางบัญชี'|rawurlencode}/{'ข้อมูลทั่วไป'|rawurlencode}">
                          <p class="g-txt22 txt-payment-kb" style="margin-left: 108px !important;">ทั่วไป</p>
                      </a>
                    </div>
                    
                    <div class="span3 hover-Payment" style="border-left: 3px solid #d8e1e8;"> 
                     <a href="{$ca_url}kb/{'การชำระเงินและเอกสารทางบัญชี '|rawurlencode}/{'Order - การสั่งซื้อ.'|rawurlencode}/360018717612-{'6 ขั้นตอนง่ายๆ ในการสั่งซื้อกับ Netway'|rawurlencode}">
                            <div class="icon-payment-cart"></div>
                        </a>  
                       <a href="{$ca_url}kb/{'การชำระเงินและเอกสารทางบัญชี '|rawurlencode}/{'Order - การสั่งซื้อ.'|rawurlencode}/360018717612-{'6 ขั้นตอนง่ายๆ ในการสั่งซื้อกับ Netway'|rawurlencode}">
                            <p class="g-txt22 txt-payment-kb" style="margin-left: 100px !important; ">การสั่งซื้อ</p>
                       </a>
                 </div>
                   
                     
                <div class="span3 hover-Payment" style="border-left: 3px solid #d8e1e8;">   
                      <a href="{$ca_url}kb/{'การชำระเงินและเอกสารทางบัญชี'|urlencode}/{'Payment - การชำระเงิน'|rawurlencode}">
                          <div class="icon-payment-pay"></div>
                      </a> 
                       <a href="{$ca_url}kb/{'การชำระเงินและเอกสารทางบัญชี'|rawurlencode}/{'Payment - การชำระเงิน'|rawurlencode}">
                          <p class="g-txt22 txt-payment-kb" style="margin-left: 85px !important;" >การชำระเงิน</p> 
                      </a> 
                </div>
                <div class="span3 hover-Payment" style="border-left: 3px solid #d8e1e8; border-right: 3px solid #d8e1e8; ">   
                       <a href="{$ca_url}kb/{'การชำระเงินและเอกสารทางบัญชี'|rawurlencode}/{'Tax Invoice - การออกใบกำกับภาษี'|rawurlencode}">
                          <div class="icon-payment-bill"></div>
                     </a> 
                      
                       <a href="{$ca_url}kb/{'การชำระเงินและเอกสารทางบัญชี'|rawurlencode}/{'Tax Invoice - การออกใบกำกับภาษี'|rawurlencode}">
                           <p class="g-txt22 txt-payment-kb" style="margin-left: 45px !important;" >การออกใบกำกับภาษี</p>
                       </a>       
                </div>
                
            </div>
        </div>
     </div>  
 <div class="row-fluid white-nw-2018"  id="Products"  style="background-color: #FFF; padding: 0 10px 0 10px;" > 
     <div class="container" >
        <div class="row">
           <div class="span12">
             <center><h3 class="h3-title-content g-txt32" style="color: #0052cd; font-weight: 300; ">Products Knowledge</h3>
             <span class="nw-2018-content-line" style="margin-bottom: 30px;"></span></center>          
            </div>
        </div>
        <div class="row visible-phone">
        <table>
          <tr>
            <td>
                   <div class="span2 hover-icon"> <!-- 1 -->
                       <a href="{$ca_url}kb/{'netway.site'|rawurlencode}" class="kb-product">
                           <div class="icon-nw2018-Other"></div>
                           <div class="kb-txt-pro" >Netway.site</div>  
                         </a>  
                   </div>
            </td>
            <td>
               
                   <div class="span2 hover-icon"> <!-- 2 -->  
                         <a href="{$ca_url}kb/Domains" class="kb-product">
                           <div class="icon-nw2018-Domain"></div> 
                           <div class="kb-txt-pro" >Domain</div>                 
                         </a>
                     </div> 
        
            </td>
          </tr>
          <tr>
            <td>
         
                     <div class="span2 hover-icon" > <!-- 3 -->
                         <a href="{$ca_url}kb/{'Microsoft 365 (Commercial)'|rawurlencode}" class="kb-product">
                           <div class="icon-nw2018-365"></div>
                           <div class="kb-txt-pro" >Microsoft 365</div>              
                         </a>
                    </div>
  
            </td>
            <td>
         
                  <div class="span2 hover-icon"> <!-- 4 -->
                     <a href="{$ca_url}kb/G%20Suite" class="kb-product">
                        <div class="icon-nw2018-Google"> </div> 
                        <div class="kb-txt-pro" >G Suite</div>
                    </a>
                  </div>
               
            </td>
          </tr>
          <tr>
            <td>
            
                  <div class="span2 hover-icon"> <!-- 5 -->
                     <a href="{$ca_url}kb/SSL%20Certificate" class="kb-product">
                         <div class="icon-nw2018-SSL"> </div> 
                         <div class="kb-txt-pro" >SSL</div>
                    </a>
                  </div> 
            </td>
            <td>
                   <div class="span2 hover-icon "><!-- 6 -->
                         <a href="{$ca_url}kb/Zendesk" class="kb-product"> 
                            <div class="icon-nw2018-Zendesk"></div>
                            <div class="kb-txt-pro">Zendesk</div>
                        </a>
                   </div>
             
              
            </td>
          </tr>
          <tr>
            <td>
            <div class="span2 hover-icon"> <!-- 1 -->
                <div class="icon-nw2018-Hosting"> </div> 
                <div class="kb-txt-pro" >Hosting  </div>
                    <a  href="{$ca_url}kb/Linux%20Hosting"class="kb-product" >
                         <div style="margin-top: 6px;">
                             <small style="margin-top: 36px;">
                                 <p>Linux</a>
                                 |<a  href="{$ca_url}kb/Windows%20Hosting"class="kb-product" > Windows </a></p>
                             </small>
                        </div>

            </div> 
         </td>
         <td>
                <div class="span2 hover-icon"> <!-- 2 -->
                    <div class="icon-nw2018-Cloud"> </div> 
                    <div class="kb-txt-pro" >VPS </div>
                         <a href="{$ca_url}kb/Linux%20VPS" class="kb-product">
                             <div style="margin-top: 6px;"><small style="margin-top: 36px;"><p>Linux</a>
                        | <a href="{$ca_url}kb/Windows%20VPS" class="kb-product"> </a></p></small></div>
                </div>
         </td>
          </tr>
          <tr>
            <td>
                <div class="span2 hover-icon"> <!-- 3 -->
                    <div class="icon-nw2018-Dedicated"> </div> 
                    <div class="kb-txt-pro" >Dedicated Server </div>      
                     <a href="{$ca_url}kb/Linux%20Dedicated%20Server" class="kb-product">
                                <div style="margin-top: 6px;"><small style="margin-top: 36px;"><p>Linux</a>
                    | <a href="{$ca_url}kb/Windows%20Dedicated%20Server" class="kb-product">Windows </a></p></small></div>
               
                </div> 
            </td>
            <td>
                <div class="span2 hover-icon"> <!-- 4 -->
                    <div class="icon-nw2018-VMware"> </div> 
                    <div class="kb-txt-pro" >VMware  </div>
                           <a href="{$ca_url}kb/Linux%20VMware" class="kb-product">
                                <div style="margin-top: 6px;"><small style="margin-top: 36px;"><p>Linux</a>
                     
                         |<a href="{$ca_url}kb/Windows%20VMware" class="kb-product">Windows </a></p></small></div>
                </div>
             </td>
          </tr>
           <tr>
            <td>
                <div class="span2 hover-icon "> <!-- 5 -->
                  <a href="{$ca_url}kb/Managed%20Server%20Services" class="kb-product">     
                    <div class="icon-nw2018-Managed"> </div> 
                    <div class="kb-txt-pro" >Managed Service </div>  
                  </a>
                </div>
            </td>
            <td>

                       <div class="span2 hover-icon" > <!-- 6 -->    
                          <a href="{$ca_url}kb/Microsoft%20Azure" class="kb-product">         
                            <div class="icon-Netway2018-Azure"> </div> 
                            <div class="kb-txt-pro" >Microsoft Azure </div>
                          </a>
                        </div> 
            </td>
          </tr>
        </table>
   </div> 
     <!-------------------- hidden-phone ----------------------->
   <br/><br/>   
   <div class="row hidden-phone">

                   <div class="span2 hover-icon"> <!-- 1 -->
                         <a href="{$ca_url}kb/netway.site" class="kb-product">
                           <div class="icon-nw2018-Other"></div>
                           <div class="kb-txt-pro" >Netway.site</div>  
                         </a>  
                   </div>

                     <div class="span2 hover-icon"> <!-- 2 -->  
                          <a href="{$ca_url}kb/Domains" class="kb-product">
                           <div class="icon-nw2018-Domain"></div> 
                           <div class="kb-txt-pro" >Domain</div>                 
                         </a>
                     </div> 

                     <div class="span2 hover-icon" > <!-- 3 -->
                         <a href="{$ca_url}kb/{'Microsoft 365 (Commercial)'|rawurlencode}" class="kb-product">
                           <div class="icon-nw2018-365"></div>
                           <div class="kb-txt-pro" >Microsoft 365</div>              
                         </a>
                    </div>

            

                  <div class="span2 hover-icon"> <!-- 4 -->
                  <a href="{$ca_url}kb/G%20Suite" class="kb-product">
                        <div class="icon-nw2018-Google"> </div> 
                        <div class="kb-txt-pro" >G Suite</div>
                    </a>
                  </div>

       
                  <div class="span2 hover-icon"> <!-- 5 -->
                   <a href="{$ca_url}kb/SSL%20Certificate" class="kb-product">
                         <div class="icon-nw2018-SSL"> </div> 
                         <div class="kb-txt-pro" >SSL</div>
                    </a>
                  </div> 
 
       
                    <div class="span2 hover-icon "><!-- 6 -->
                         <a href="{$ca_url}kb/Zendesk" class="kb-product">  
                            <div class="icon-nw2018-Zendesk"></div>
                            <div class="kb-txt-pro" >Zendesk</div>
                        </a>
                   </div>
            
  </div>
  
   
 <div class="container">     
  <div class="row hidden-phone" style="margin-bottom : 20px;">
         <div class="span2 hover-icon"> <!-- 1 -->
            <div class="icon-nw2018-Hosting"> </div> 
            <div class="kb-txt-pro" >Hosting  </div>
                 <a  href="{$ca_url}kb/Linux%20Hosting"class="kb-product"  style="color: #1a0dab; text-decoration: underline;">
                     <div style="margin-top: 6px;"><small style="margin-top: 36px;"><p>Linux</a>
                |<a  href="{$ca_url}kb/Windows%20Hosting"class="kb-product" style="color: #1a0dab; text-decoration: underline;" >Windows </a></p></small></div>
          
         </div> 
        
         <div class="span2 hover-icon"> <!-- 2 -->
            <div class="icon-nw2018-Cloud"> </div> 
            <div class="kb-txt-pro" >VPS </div>
                 <a href="{$ca_url}kb/Linux%20VPS" class="kb-product" style="color: #1a0dab; text-decoration: underline;">
                      <div style="margin-top: 6px;"><small style="margin-top: 36px;"><p>Linux</a>
                |<a href="{$ca_url}kb/Windows%20VPS" class="kb-product" style="color: #1a0dab; text-decoration: underline;">Windows </a></p></small></div>
      
       </div>

        
         <div class="span2 hover-icon"> <!-- 3 -->
            <div class="icon-nw2018-Dedicated"> </div> 
            <div class="kb-txt-pro" >Dedicated Server </div>
                  <a href="{$ca_url}kb/Linux%20Dedicated%20Server" class="kb-product" style="color: #1a0dab; text-decoration: underline;">
                        <div style="margin-top: 6px;"><small style="margin-top: 36px;"><p>Linux</a> 
                 |<a href="{$ca_url}kb/Windows%20Dedicated%20Server" class="kb-product" style="color: #1a0dab; text-decoration: underline;">Windows </a></p></small></div>
         </div> 
     
         <div class="span2 hover-icon"> <!-- 4 -->
            <div class="icon-nw2018-VMware"> </div> 
            <div class="kb-txt-pro" >VMware  </div>     
                    <a href="{$ca_url}kb/Linux%20VMware" class="kb-product" style="color: #1a0dab; text-decoration: underline;">
                        <div style="margin-top: 6px;"><small style="margin-top: 36px;"><p>Linux</a>
                 | <a href="{$ca_url}kb/Windows%20VMware" class="kb-product" style="color: #1a0dab; text-decoration: underline;">Windows </a></p></small></div>
           
         </div> 
         
         <div class="span2 hover-icon "> <!-- 5 -->
             <a href="{$ca_url}kb/Managed%20Server%20Services" class="kb-product">    
                <div class="icon-nw2018-Managed"> </div> 
                <div class="kb-txt-pro" >Managed Service </div>  
            </a>
         </div>         
                   <div class="span2 hover-icon" > <!-- 6 -->    
                      <a href="{$ca_url}kb/Microsoft%20Azure" class="kb-product">     
                        <div class="icon-Netway2018-Azure"> </div> 
                        <div class="kb-txt-pro" >Microsoft Azure </div>
                      </a>
                    </div> 
           
           
     </div>
  </div>

  
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
         <div class="span12"><h4 style="color: #0052cd;">Email</h4><hr style="margin-top: -5px;"/></div><!-- Email -->
        </div>
        
      <div  class="row" >
          <div class="span3 kb-txt-pro coming-pro" title="Coming Soon" >
             <img src="https://netway.co.th/templates/netwaybysidepad/images/ikb-Co-exist.png"  alt="Co-existl" style="width: 32px;   margin-right: 5px;"> 
             Co-exist Mail Server
         </div > 
         <div class="span3 kb-txt-pro coming-pro" title="Coming Soon" >
             <img src="https://netway.co.th/templates/netwaybysidepad/images/ikb-Cpanel.png"  alt="cPanel" style="width: 32px;   margin-right: 5px;" > 
             cPanel Mail
         </div > 
          <div class="span3 kb-txt-pro ">
              <a href="{$ca_url}kb/G%20Suite" class="kb-product-other font-color">
                  <img src="https://netway.co.th/templates/netwaybysidepad/images/ikb-gsuite.png"  alt="G Suite" style="width: 32px; margin-right: 5px;"> 
                  G Suite 
              </a>
         </div > 
         <div class="span3 kb-txt-pro ">
               <a href="{$ca_url}kb/{'Microsoft 365 (Commercial)'|rawurlencode}" class="kb-product-other font-color">
                  <img src="https://netway.co.th/templates/netwaybysidepad/images/ikb-office365.png"  alt="Office 365"  style="width: 32px; margin-right: 5px;"> 
                  Microsoft 365 
               </a>
         </div > 

    </div>
    <div class="row" style="margin-top: 20px;">
         <div class="span3 kb-txt-pro coming-pro" title="Coming Soon" ><img src="https://netway.co.th/templates/netwaybysidepad/images/ikb-Zimbra.png"  alt="Zimbra" style="
               width: 32px; margin-right: 5px;"> Zimbra Email
         </div > 
         <div class="span3">&nbsp;&nbsp;</div>.
         <div class="span3">&nbsp;&nbsp;</div>
         <div class="span3">&nbsp;&nbsp;</div>
    </div>
 
    <div  class="row" style="margin-top: 60px" >
         <div class="span12 coming-pro" title="Coming Soon" ><h4 style="color: #0052cd;" >Microsoft</h4><hr style="margin-top: -5px;"/></div><!-- อื่นๆ -->
    </div>
 
     <div  class="row "  >
     
             <div class="span3 kb-txt-pro" >
                <a href="{$ca_url}kb/Dynamics%20365" class="kb-product-other font-color">
                  <img src="https://netway.co.th/templates/netwaybysidepad/images/ikb-microsoft-dynamics.png"  alt="Dynamics 365"  style=" width: 32px; margin-right: 5px;"> 
                     Dynamics 365   
              </a>
             </div > 
            <div class="span3 kb-txt-pro coming-pro "title="Coming Soon">           
                <img src="https://netway.co.th/templates/netwaybysidepad/images/ikb-microsoft-dynamics.png"  alt="Dynamics 365 for Talents"  style="width: 32px; margin-right: 5px;"> 
                  Dynamics 365 for Talents      
             </div >
              <div class="span3 kb-txt-pro coming-pro" title="Coming Soon" >
                <img src="https://netway.co.th/templates/netwaybysidepad/images/ikb-ms-Logo.png"  alt="Microsoft 365"  style="width: 32px; margin-right: 5px;"> 
                  Microsoft 365
             </div >
             <div class="span3 kb-txt-pro" ><a href="{$ca_url}kb/Microsoft%20Azure" class="kb-product-other font-color">
                   <img src="https://netway.co.th/templates/netwaybysidepad/images/ikb-MicrosoftAzure.png"  alt="Microsoft Azure"  style="width: 32px; margin-right: 5px;"> 
                  Microsoft Azure
               </a>
             </div >
        </div>
                
        <div  class="row" style="margin-top: 20px; margin-bottom: 20px;" >
           <div class="span3 kb-txt-pro" >
                <a href="{$ca_url}kb/Microsoft%20Azure%20Backup" class="kb-product-other font-color">
                   <img src="https://netway.co.th/templates/netwaybysidepad/images/ikb-MicrosoftAzure.png"  alt="Microsoft Azure Backup"  style="width: 32px; margin-right: 5px;"> 
                   Microsoft Azure Backup
               </a>
             </div > 
            <div class="span3 kb-txt-pro coming-pro" title="Coming Soon" >
                   <img src="https://netway.co.th/templates/netwaybysidepad/images/ikb-MicrosoftBusinessApps.png"  alt="Microsoft Business Apps"  style="width: 32px; margin-right: 5px;"> 
                     Microsoft Business Apps
            </div >
            <div class="span3 kb-txt-pro" >
                <a href="{$ca_url}kb/MS%20License%20Checkup" class="kb-product-other font-color">
                   <img src="https://netway.co.th/templates/netwaybysidepad/images/ikb-MicrosoftLicenseCheckup.png"  alt="Microsoft License Checkup"  style="width: 32px; margin-right: 5px;">
                   Microsoft License Checkup
               </a>
            </div > 
             <div class="span3 kb-txt-pro coming-pro" title="Coming Soon" >
                    <img src="https://netway.co.th/templates/netwaybysidepad/images/ikb-ms-SharePoint.png"  alt="Microsoft SharePoint"  style="width: 32px; margin-right: 5px;"> 
                     Microsoft SharePoint
             </div >
        </div>
        
        
        <div  class="row" style="margin-top: 20px; margin-bottom: 20px;" >
           
                     
           
              <div class="span3 kb-txt-pro coming-pro" title="Coming Soon" >
                     <img src="https://netway.co.th/templates/netwaybysidepad/images/ikb-office2016.png"alt="Office 2016"  style="width: 32px; margin-right: 5px;">
                     Office 2016
             </div > 
            <div class="span3 kb-txt-pro " >
                <a href="{$ca_url}kb/{'Office 365'|rawurlencode}" class="kb-product">
                    <img src="https://netway.co.th/templates/netwaybysidepad/images/ikb-office365.png"  alt="Office 365"  style="width: 32px; margin-right: 5px;"> 
                    Office 365
                </a>
             </div > 
              <div class="span3 kb-txt-pro "  >
                    <a href="{$ca_url}kb/{'power bi'|rawurlencode}" class="kb-product">
                        <img src="https://netway.co.th/templates/netwaybysidepad/images/power-bi.png"  alt="Power BI Pro"  style="width: 32px; margin-right: 5px;"> 
                        Power BI Pro
                    </a>
             </div > 
             
             <div class="span3 kb-txt-pro " >
                   <a href="{$ca_url}kb/Microsoft%20Licenses/{'เกี่ยวกับ Project Online'|rawurlencode}" class="kb-product-other font-color">
                      <img src="https://netway.co.th/templates/netwaybysidepad/images/ikb-ms-project.png"alt="Project"  style="width: 32px; margin-right: 5px;"> 
                      Project
                   </a>
             </div >
        </div>
        
        <div  class="row" style="margin-top: 20px; margin-bottom: 20px;" >

             <div class="span3 kb-txt-pro coming-pro" title="Coming Soon" >
                     <img src="https://netway.co.th/templates/netwaybysidepad/images/ikb-ms-Skype.png"  alt="Skype for Business"  style="width: 32px; margin-right: 5px;"> 
                      Skype for Business
             </div > 
              <div class="span3 kb-txt-pro coming-pro" title="Coming Soon" >
                     <img src="https://netway.co.th/templates/netwaybysidepad/images/ikb-VisualStudioSubscription.png"  alt="Power BI Pro"  style="width: 32px; margin-right: 5px;"> 
                     Visual Studio Subscription
             </div > 
             <div class="span3 kb-txt-pro" >
                 <a href="{$ca_url}kb/Microsoft%20Licenses/{'เกี่ยวกับ Visio'|rawurlencode}" class="kb-product-other font-color">
                   <img src="https://netway.co.th/templates/netwaybysidepad/images/ikb-ms-visio.png"alt="Visio"  style="width: 32px; margin-right: 5px;"> 
                    Visio
                 </a>
             </div>  
             <div class="span3 kb-txt-pro coming-pro" title="Coming Soon"  >
                 <img src="https://netway.co.th/templates/netwaybysidepad/images/ikb-ms-Windows-.png"  alt="Windows 10"  style="width: 32px; margin-right: 5px;"> 
                  Windows 10
            </div >
          
 
          
        </div>
        <div  class="row" style="margin-top: 20px; margin-bottom: 20px;" >

           <div class="span3 kb-txt-pro coming-pro" title="Coming Soon" >
                 <img src="https://netway.co.th/templates/netwaybysidepad/images/ikb-Windows-Exchange.png"  alt="Windows Exchange"  style="width: 32px; margin-right: 5px;"> 
                  Windows Exchange
           </div > 
           <div class="span3 kb-txt-pro coming-pro" title="Coming Soon" >
                 <img src="https://netway.co.th/templates/netwaybysidepad/images/ikb-Windows+Server.png"  alt="Windows Server"  style="width: 32px; margin-right: 5px;"> 
                 Windows Server
           </div >
           <div class="span3 kb-txt-pro coming-pro" title="Coming Soon" >
                <img src="https://netway.co.th/templates/netwaybysidepad/images/ikb-WindowsSQLServer.png"  alt="Windows SQL Server"  style="width: 32px; margin-right: 5px;"> 
                Windows SQL Server
           </div > 
           <div class="span3 kb-txt-pro hidden-phone" >
                &nbsp; &nbsp;
           </div > 
     </div>

        <div  class="row" style="margin-top: 60px" >
         <div class="span12"><h4>Zendesk</h4><hr style="margin-top: -5px;"/></div><!-- Zendesk -->
        </div>
        <div  class="row" >
              
             <div class="span3 kb-txt-pro coming-pro" title="Coming Soon">
                 <img src="https://netway.co.th/templates/netwaybysidepad/images/ikb-Z-Chat.png"  alt="Zendesk Chat" style="width: 32px; margin-right: 5px;">
                 Zendesk Chat
             </div> 
             <div class="span3 kb-txt-pro" >
                 <a href="{$ca_url}kb/Zendesk/How-to%20Zendesk%20Guide"class="kb-product-other font-color">
                   <img src="https://netway.co.th/templates/netwaybysidepad/images/ikb-Z-Guide.png"alt="Zendesk Guide" style="width: 32px; margin-right: 5px;">
                   Zendesk Guide
                </a>
             </div> 
             <div class="span3 kb-txt-pro">
              <a href="{$ca_url}kb/Zendesk/{'Zendesk Support App ที่น่าสนใจ'|rawurlencode}"class="kb-product-other font-color">
                  <img src="https://netway.co.th/templates/netwaybysidepad/images/ikb-Z-Support.png" alt="Zendesk Support" style="width: 32px; margin-right: 5px;">
                  Zendesk Support
              </a>
              </div>
             <div class="span3 kb-txt-pro coming-pro" title="Coming Soon">
                 <img src="https://netway.co.th/templates/netwaybysidepad/images/ikb-Talk.png"alt="Zendesk Talk" style="width: 32px; margin-right: 5px;">
                 Zendesk Talk
             </div> 
            
        </div> 
        <div  class="row" style="margin-top: 60px" >
         <div class="span12"><h4>Marketing Tools</h4><hr style="margin-top: -5px;"/></div><!-- Marketing Tools -->
        </div>
        <div  class="row" >
             <div class="span3 kb-txt-pro" >
              <a href="{$ca_url}kb/MailChimp"class="kb-product-other font-color">
                 <img src="https://netway.co.th/templates/netwaybysidepad/images/ikb-Mailchimp.png"  alt="Mailchimp" style="width: 32px; margin-right: 5px;">
                 Mailchimp
             </a>
                 </div >  
             <div class="span3 kb-txt-pro" >
                <a href="{$ca_url}kb/netway.site"class="kb-product-other font-color">
                     <img src="https://netway.co.th/templates/netwaybysidepad/images/ikb-Netwaysite.png"  alt="Netway.site" 
                     style="width: 32px; margin-right: 5px;">
                     Netway.site
                </a>
             </div >
             <div class="span3 hidden-phone"></div>
             <div class="span3 hidden-phone"></div>
         </div> 
            <div  class="row" style="margin-top: 60px" >
             <div class="span12"><h4>Other Cloud Products</h4><hr style="margin-top: -5px;"/></div><!-- Marketing Tools -->
            </div>
            <div  class="row"   style="margin-bottom: 40px;">
              
             
             <div class="span3 kb-txt-pro coming-pro" title="Coming Soon" ><img src="https://netway.co.th/templates/netwaybysidepad/images/ikb-AdobeCloud.png"  alt="AdobeCloud" style="
                 width: 32px; margin-right: 5px;">
                 Adobe Cloud
             </div >
             
              <div class="span3 kb-txt-pro coming-pro" title="Coming soon" ><img src="https://netway.co.th/templates/netwaybysidepad/images/ikb-Kaspersky.png"  alt="Kaspersky" style="
                 width: 32px; margin-right: 5px;">
                 Kaspersky
             </div >
             
              <div class="span3 kb-txt-pro "  >
               <a href="{$ca_url}/kb/Load%20Balancer"class="kb-product-other font-color">
              <img src="https://netway.co.th/templates/netwaybysidepad/images/ikb-Load-Balancer-min.png"  alt="Load Balancer" style="
                 width: 32px; margin-right: 5px;">
                 Load Balancer
                 </a>   
             </div >
            
             <div class="span3 kb-txt-pro coming-pro" title="Coming Soon" ><img src="https://netway.co.th/templates/netwaybysidepad/images/ikb-VMware.png"  alt="VMware" style="
                 width: 32px; margin-right: 5px;">
                 VMware
             </div >
            
           
           
           
              
        </div> 
      </div>
    <!-- End id="showOther"  -->
 </div>
{/if}
 </div>   
</div>
   <!----------------------visible-phone ------------------------------>
      <div class="row-fluid white-nw-2018 visible-phone" style="padding: 120px 10px 120px 10px !important;"> 
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
                      <a href ="{$ca_url}kb/{'Website Install Application & FTP'|rawurlencode}">
                          <div style="background-repeat: repeat-y;margin-left: 15px;" class="img-technical-web"></div>
                      </a>
                      <dir style="folat:left;color: #64606c;font-size: 17px;font-weight: 100;margin-top: 15px;padding: 0px 0px 0px 15px;"> 
                          ความรู้ทั่วไปเกี่ยวกับเว็บไซต์  วิธี Install Applications และ FTP
                     </dir>
                      <a href ="{$ca_url}kb/{'Website Install Application & FTP'|rawurlencode}"><center><button class="btn-readmore-2018" style="margin-top: 30px;">อ่านเพิ่มเติม</button><center></a>
                </div>
                
                   <div class="span3" style="margin-top:20px;padding: 0px 43px 0px 0px !important;">    
                     <dir  class="txt-tech-kb" >
                         Linux Technical Knowledge
                        <hr style="margin-top:5px;" size="1" class="bottom-img-footer">
                      </dir>  
                     <a href ="/kb/Linux%20Technical%20Knowledge">
                         <div style="background-repeat: repeat-y;margin-left: 15px;" class="img-technical-linux"></div>
                     </a>
                     <dir style="folat:left;color: #64606c;font-size: 17px;font-weight: 100;margin-top: 15px;padding: 0px 0px 0px 15px;">
                         ความรู้ทั่วไป และวิธีแก้ไขปัญหา OS Linux Server
                     </dir>
                     <a href ="{$ca_url}/kb/Linux%20Technical%20Knowledge"><center><button class="btn-readmore-2018" style="margin-top: 30px;">อ่านเพิ่มเติม</button><center></a>  
                </div>
                
                     
                <div class="span3" style="margin-top:20px;padding: 0px 43px 0px 0px !important;">  
                  <dir  class="txt-tech-kb" >
                         Windows Technical Knowledge
                        <hr style="margin-top:5px;" size="1" class="bottom-img-footer">
                      </dir>  
                      <a href ="{$ca_url}kb/Windows%20Technical%20Knowledge">
                          <div style="background-repeat: repeat-y;margin-left: 15px;" class="img-technical-window"></div>
                      </a>
                       <dir style="folat:left;color: #64606c;font-size: 17px;font-weight: 100;margin-top: 15px;padding: 0px 0px 0px 15px;">
                           ความรู้ทั่วไป และวิธีแก้ไขปัญหา  OS Windows Server
                      </dir>
                       <a href ="{$ca_url}kb/Windows%20Technical%20Knowledge"><center><button class="btn-readmore-2018" style="margin-top: 30px;">อ่านเพิ่มเติม</button><center></a>  
                </div>
                
               <div class="span3" style="margin-top:20px;padding: 0px 43px 0px 0px !important;">  
                       <dir  class="txt-tech-kb" >
                         Database
                        <hr style="margin-top:5px;" size="1" class="bottom-img-footer">
                      </dir>    
                         <a href ="{$ca_url}kb/Database">
                             <div style="background-repeat: repeat-y;margin-left: 15px;" class="img-technical-database"></div>
                         </a>
                       <dir style="folat:left;color: #64606c;font-size: 17px;font-weight: 100;margin-top: 15px;padding: 0px 0px 0px 15px;"> 
                           ความรู้ทั่วไป และวิธีแก้ไขปัญหา Database
                      </dir>
                       <a href ="{$ca_url}kb/Database"><center><button class="btn-readmore-2018" style="margin-top: 30px;">อ่านเพิ่มเติม</button><center></a>    
                </div>
            </div>
        </div>
     </div>


 <div class="row-fluid white-nw-2018 hidden-phone" id="technical" style="padding: 120px 10px 120px 10px ;" > 
         
     <div class="container" >
           <div class="row">
            <center><h3 class="h3-title-content g-txt32" style="color: #0052cd; font-weight:300;">Technical Knowledge</h3>
             <span class="nw-2018-content-line" style="margin-bottom: 30px;"></span></center>  
           </div>
            <div class="row ">
                    <div class="span3">
                      <dir  class="txt-tech-kb" >
                         Website/Install Application & FTP 
                        <hr style="margin-top:5px;" size="1" class="bottom-img-footer">
                      </dir>   
                      <a href ="{$ca_url}kb/{'Website Install Application & FTP'|rawurlencode}">
                          <div class="img-technical-web"></div>  
                      </a>
                      <dir style="folat:left;color: #64606c;font-size: 17px;font-weight: 100;margin-top: 15px;padding: 0px;"> ความรู้ทั่วไปเกี่ยวกับเว็บไซต์  วิธี Install Applications และ FTP</dir>
                      <a href ="{$ca_url}kb/{'Website Install Application & FTP'|rawurlencode}"><center><button class="btn-readmore-2018" style="margin-top: 30px;">อ่านเพิ่มเติม</button><center></a>
                </div>
                
                    <div class="span3">   
                     <dir  class="txt-tech-kb" >
                         Linux Technical Knowledge
                        <hr style="margin-top:5px;" size="1" class="bottom-img-footer">
                      </dir>  
                     <a href ="{$ca_url}kb/Linux%20Technical%20Knowledge">
                         <div class="img-technical-linux"></div>
                     </a>                   
                     <dir style="folat:left;color: #64606c;font-size: 17px;font-weight: 100;margin-top: 15px;padding: 0px;">ความรู้ทั่วไป และวิธีแก้ไขปัญหา OS Linux Server</dir>
                     <a href ="{$ca_url}kb/Linux%20Technical%20Knowledge"><center><button class="btn-readmore-2018" style="margin-top: 30px;">อ่านเพิ่มเติม</button><center></a>  
                </div>
                
                     
                <div class="span3">  
                  <dir  class="txt-tech-kb" >
                         Windows Technical Knowledge
                        <hr style="margin-top:5px;" size="1" class="bottom-img-footer">
                      </dir>  
                       <a href ="{$ca_url}kb/Windows%20Technical%20Knowledge"> 
                           <div class="img-technical-window"></div>
                       </a>
                       <dir style="folat:left;color: #64606c;font-size: 17px;font-weight: 100;margin-top: 15px;padding: 0px;">ความรู้ทั่วไป และวิธีแก้ไขปัญหา  OS Windows Server</dir>
                       <a href ="{$ca_url}kb/Windows%20Technical%20Knowledge"><center><button class="btn-readmore-2018" style="margin-top: 30px;">อ่านเพิ่มเติม</button><center></a>  
                </div>
                
                <div class="span3">
                       <dir  class="txt-tech-kb" >
                         Database
                        <hr style="margin-top:5px;" size="1" class="bottom-img-footer">
                      </dir>    
                       <a href ="{$ca_url}kb/Database" >
                           <div class="img-technical-database"></div>
                       </a>    
                       <dir style="folat:left;color: #64606c;font-size: 17px;font-weight: 100;margin-top: 15px;padding: 0px;"> ความรู้ทั่วไป และวิธีแก้ไขปัญหา Database</dir>
                       <a href ="{$ca_url}kb/Database"><center><button class="btn-readmore-2018" style="margin-top: 30px;">อ่านเพิ่มเติม</button><center></a>
                       
                </div>

            </div>
    </div>
  </div>
       
    <div class="row-fluid"  > 
        <div class="container" >
           <div class="row visible-phone"  >
                <a href="https://support.netway.co.th/hc/th/requests/new">
                    <div class="span6 kb-request-button" style="width: 33%;  margin-left:-14px;">
                        ส่งคำร้องขอ
                    </div>  
                </a> 
                
                 <a href="https://netway.co.th/clientarea/?brand_id=3187847&locale_id=81&return_to=https%3A%2F%2Fsupport.netway.co.th%2Fhc%2Fth%3F_ga%3D2.152406970.28029504.1524225365-2115090666.1513582134%26mobile_site%3Dtrue&timestamp=1524369223">
                        <div class="span6 kb-request-button" style="width: 34%;  margin-left: 100px;">
                            คำร้องขอของฉัน 
                        </div>
                 </a>
                 <a href="https://support.netway.co.th/hc/th/search">
                     <div class="kb-request-button" style="width: 27%;margin-left: 224px;text-align: left;padding: 9px 0px 0px 24px;height:46px ">
                         <i class="fa fa-search"></i>
                     </div>
                </a>
                    
            </div>
        </div>
     </div>
 

{literal}
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
