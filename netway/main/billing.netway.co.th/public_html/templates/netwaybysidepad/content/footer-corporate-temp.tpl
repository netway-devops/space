{php}
$templatePath   = $this->get_template_vars('template_path');
include($templatePath . 'content/footer-corporate-temp.tpl.php');
{/php}

</div>
 <div id="back-top" style="display:none"><!-- ปุ่ม UP -->
          <a href="#top"><span></span></a>
        </div>
<br />
<script src="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.6.0/slick.js"></script>
{assign var=queryString value="/"|explode:$smarty.server.QUERY_STRING}
{assign var=requestURI value="/"|explode:$smarty.server.REQUEST_URI}
{if $requestURI.1 == 'knowledgebase' || $requestURI.1 == 'kb' ||$requestURI.1 == 'gsuite'||$requestURI.1 == 'microsoft-license-checkup'||$requestURI.1 == 'microsoft-sam'||$requestURI.1 == 'microsoft-dynamics365'||$requestURI.1=='payment'||$requestURI.1=='contact'|| ( $queryString.1 == 'cart' && $step == 0) }
<!--
<div class="row-fluid">
  <div class="container">
    <div class="row footer-2018">
      <div style="margin-bottom: 50px;">
        <center>
        <h3 class="h3-titel-content g-txt32">Partners</h3>
            <span class="nw-2018-content-line"> </span>
        </center>

        <section class="customer-logos slider " style="margin-top: 30px;">
          <div class="slide "><img src="/templates/netwaybysidepad/images/google_18.png"  alt="google" title="google" /></div>
          <div class="slide "><img src="/templates/netwaybysidepad/images/symantec_20.png" alt="symantec" title="symantec" /></div>
          <div class="slide "><img src="/templates/netwaybysidepad/images/microsoft_22.png" alt="microsoft" title="microsoft" /></div>
          <div class="slide "><img src="/templates/netwaybysidepad/images/digicert_24.png" alt="digicert" title="digicert" /></div>

          <div class="slide"><img src="/templates/netwaybysidepad/images/cpanelwhm_27.png" alt="cpanelwhm" title="cpanelwhm"  /></div>
          <div class="slide"><img src="/templates/netwaybysidepad/images/amazon_28.png" alt="amazon" title="amazon" /></div>
          <div class="slide"><img src="/templates/netwaybysidepad/images/godaddy_29.png" alt="godaddy" title="godaddy"/></div>
          <div class="slide"><img src="/templates/netwaybysidepad/images/cloudlinux_31.png" alt="cloudlinux" title="cloudlinux" /></div>

          <div class="slide"><img src="/templates/netwaybysidepad/images/zimbra_32.png" alt="zimbra" title="zimbra" /></div>
          <div class="slide"><img src="/templates/netwaybysidepad/images/veeam_34 .png" alt="veeam" title="veeam" /></div>
          <div class="slide"><img src="/templates/netwaybysidepad/images/vmware_35.png" alt="vmware" title="vmware" /></div>
          <div class="slide"><img src="/templates/netwaybysidepad/images/srsplus_37.png" alt="srsplus" title="srsplus" /></div>

          <div class="slide"><img src="/templates/netwaybysidepad/images/adobe_38.png" alt="adobe" title="adobe"   /></div>
          <div class="slide"><img src="/templates/netwaybysidepad/images/kaspersky_39.png" alt="kaspersky" title="kaspersky"   /></div>
          <div class="slide"><img src="/templates/netwaybysidepad/images/Entrus-new-logo-min.png" alt="Entrust" /></div>
          <div class="slide"><img src="/templates/netwaybysidepad/images/zendesk-logo-min.png" alt="Zendesk" /></div>
        </section>
      </div>
    </div>
  </div>
</div>
-->
{/if}

<br/>
<div class="footer-corporate">
    {literal}

      <script type="text/javascript">
        (function(d,s,i,r) {
          if (d.getElementById(i)){return;}
          var n=d.createElement(s),e=d.getElementsByTagName(s)[0];
          n.id=i;n.src='//js.hs-analytics.net/analytics/'+(Math.ceil(new Date()/r)*r)+'/2451831.js';
          e.parentNode.insertBefore(n, e);
        })(document,"script","hs-analytics",300000);
      </script>

      <style>
        div.affiliate{
            text-align: left;
        }

      </style>
        {/literal}
        <!--
    <div class="footer-nw-2018" style=" padding: 30px 0 30px 0px;">
        <div class="container " >
            <div class="row-fluid">
                <div class="span3 hidden-phone">
                    <dir style="padding: 0px;color:#8FC3FE;">Latest Promo <hr style="margin-top:5px;" size="1" class="bottom-img-footer" /></dir>
                    <div class="img-footer-show">
                      <div><img src="https://netway.co.th/storage/transform/4484/conversions/img100-136_copy_1619166091_-thumb_600.jpg" width="270"></div>
                      <p>FINAL CALL! Microsoft 365 Sale Up To 50%<br></p>
                      <div style="text-align: right;"><a href="{$smarty.const.CMS_URL}/kb/latest-promo/final-call-microsoft-365-sale-up-to-50-" target="_parent"><u style="color:yellow;"> อ่านเพิ่มเติม</u></a></div>
                    </div>
                     <br/>
                </div>

                <div class="span3 hidden-phone">
                    <dir style="padding: 0px;color:#8FC3FE;">Latest News <hr style="margin-top:5px;" size="1" class="bottom-img-footer" /></dir>
                   <div class="img-footer-show">

                  <div><img  src="{$smarty.const.CMS_URL}/storage/images/Domain-Prize_KB_copy_1613534165_.png"><div class="clear"></div></div>
                  <p>[1 มี.ค. 64] ปรับราคาค่าบริการโดเมน 7 รายการ</p>
                  <div style="text-align: right;"><a href="{$smarty.const.CMS_URL}/kb/blog/news-%26-updates/%5B1-มี-ค-64%5D-ปรับราคาค่าบริการโดเมน-7-รายการ" target="_parent"><u style="color:yellow;"> อ่านเพิ่มเติม</u></a></div>
                    </div>
                     <br/>
                </div>

                <div class="span3 hidden-phone">
                     <dir style="padding: 0px;color:#8FC3FE;text-decoration: none;"> Latest Blog <hr style="margin-top:5px;" size="1" class="bottom-img-footer" /></dir>
                    <div class="img-footer-show">
                      <div><img  src="{$smarty.const.CMS_URL}/storage/transform/4456/conversions/img100-136-font-thumb_600.jpg"><div class="clear"></div></div>
                      <p>5 ฟอนต์ใหม่ใน Microsoft365</p>
                      <div style="text-align: right;"><a href="{$smarty.const.CMS_URL}/kb/latest-blog/5-ฟอนต์ใหม่ใน-microsoft365" target="_parent"><u style="color:yellow;"> อ่านเพิ่มเติม</u></a></div>
                    </div>
                     <br/>
                </div>
                <div class="span3">
                    <div class="txt-hashtag">#มีครบจบที่เดียว</div>
                    <div class="address" style="margin-top:20px;background-color:transparent;" >
                    <a href="{$smarty.const.CMS_URL}/kb/blog" target="_blank">
                     <img  class="lazy" src="https://netway.co.th/templates/netwaybysidepad/images/icon-footer-blog-min.png"
                             style="margin-right: 3px;
                                  width: 37px;
                                  height: 37px;
                            ">
                    </a>
                    <a href="https://www.facebook.com/netway.official" target="_blank">
                         <img  class="lazy" src="https://netway.co.th/templates/netwaybysidepad/images/icon-footer-facebook-min.png"
                             style="margin-right: 3px;
                                  width: 37px;
                                  height: 37px;
                             ">

                    </a>
                    <a href="https://bit.ly/line-netway" target="_blank">
                         <img  class="lazy" src="https://netway.co.th/templates/netwaybysidepad/images/footer-line.png"
                             style="margin-right: 3px;
                                  width: 37px;
                                  height: 37px;
                             ">

                    </a>
                    <a href="https://plus.google.com/u/0/115831524037938794033" target="_blank">
                        <img  class="lazy" src="https://netway.co.th/templates/netwaybysidepad/images/icon-footer-google-min.png"
                            style="margin-right: 3px;
                                  width: 37px;
                                  height: 37px;
                           ">

                    </a>
                    <a href="https://twitter.com/NetwayClub" target="_blank">
                        <img class="lazy" src="https://netway.co.th/templates/netwaybysidepad/images/icon-footer-twitter-min.png"
                           style="margin-right: 3px;
                                  width: 37px;
                                  height: 37px;
                           ">
                    </a>
                    <a href="https://www.youtube.com/channel/UC1mPYP1YuOoIshuehyZUvPw/feed" target="_blank"><img class="lazy" src="https://netway.co.th/templates/netwaybysidepad/images/icon-footer-youtube-min.png"
                           style="margin-right: 3px;
                                  width: 37px;
                                  height: 37px;
                           ">
                      </a>
                    </div>
                    <br/>
                    <h4 class="txt-subscribe txt20" style="display:none;" >สมัครรับข้อมูลโปรโมชั่น</h4>
                    <form class="form-inline" action="#" style="display:none;">
                      <div class="form-group">
                        <input type="email" class="enter-email-2018" placeholder="Enter Your E-mail">
                      </div>
                    </form>
                    </div>
                </div>
            </div>
        </div>
    </div>-->

 <div class="white-nw-2018 hidden-phone">
   <div class="container">
       <div class="span4">
         <h4 class="nw-footer-title txt18">Payment Channels</h4>
         <br/>
         <div>
              <br>
              <img class="lazy" alt="เงินสด" src="https://netway.co.th/templates/netwaybysidepad/images/footer-icon-2018_06.png">&nbsp; &nbsp; &nbsp;&nbsp;
              <img class="lazy" alt="visa" src="https://netway.co.th/templates/netwaybysidepad/images/footer-icon-2018_03.png" style="">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;
              <img class="lazy" alt="MasterCard" src="https://netway.co.th/templates/netwaybysidepad/images/footer-icon-2018_12.png" style="">&nbsp;
            </div>
            <div>&nbsp;
              <img class="lazy" alt="Paypal" src="https://netway.co.th/templates/netwaybysidepad/images/footer-icon-2018_14.png">&nbsp; &nbsp;
              <img class="lazy" alt="PromptPay" src="https://netway.co.th/templates/netwaybysidepad/images/footer-icon-2018_25.png">
          </div>
       </div>
       <div class="span4">
         <h4 class="nw-footer-title txt18">Delivery Services</h4>
         <br/>
         <div>
            <div class="icon-footer-2018"><img class="lazy" src="https://netway.co.th/templates/netwaybysidepad/images/footer-icon-2018_16.png"  alt="ThailandPost"></div>
            <div class="icon-footer-2018"><img class="lazy" src="https://netway.co.th/templates/netwaybysidepad/images/footer-icon-2018_09.png"  alt="KERRY"></div>
         </div>
       </div>
       <div class="span4">
         <h4 class="nw-footer-title txt18">Verified by</h4>
         <br/>

                    {literal}

                    <div style="display: inline">
                        <a style="padding-left: 5px;" href="javascript:void(0);" onclick="open_popup('https://www.trustmarkthai.com/callbackData/popup.php?data=dc-37-4-15a4e2c11b8166550e1a1d088f8c3218c1686265b8','verifiled');">
                            <img width="120px" src="https://netway.co.th/images/dbd_silver.png">
                        </a>
                    </div>
                    <script>
                        function open_popup(url,windowName) {
                           newwindow=window.open(url,windowName,'height=750,width=700');
                           if (window.focus) {newwindow.focus()}
                           return false;
                         }
                    </script>
                    {/literal}

                    <hr/>


       </div>
   </div>
 </div>


    <div class="row-fluid footer-adr-2018 "style="padding: 30px 0 30px 0px !important;">
      <div class="container"  style="margin-top: -20px;padding: 30px 30px 30px 12px !important;">

          <div class="span4 hidden-phone" style="margin-top: 30px;">
           <h4 class="nw-footer-title txt18">บริการลูกค้า</h4>
           <hr class="div-footer" />
           <div style="margin-top:20px; font-size: 18px;">
               <a href="{$smarty.const.CMS_URL}/kb"><h5 class="txt-footer-2018">ศูนย์ดูแลลูกค้า</h5></a>
               <a href="{$smarty.const.CMS_URL}/payment"><h5 class="txt-footer-2018">วิธีชำระเงินและหักภาษี</h5></a>
               <a href="{$smarty.const.CMS_URL}/promo"><h5 class="txt-footer-2018">โปรโมชั่น</h5></a>
               <a href="{$system_url}order"><h5 class="txt-footer-2018">สั่งซื้อสินค้า</h5></a>
               <a href="{$smarty.const.CMS_URL}/kb/blog"><h5 class="txt-footer-2018">Blog</h5></a>
               <a href="{$smarty.const.CMS_URL}/training"><h5 class="txt-footer-2018">Training</h5></a>
           </div>
          </div>
          <div class="span4"  style="margin-top: 30px;">
           <h4 class="nw-footer-title txt18">เกี่ยวกับ Netway</h4>
           <hr class="div-footer" />
           <div style="margin-top:20px; font-size: 18px;">
               <a href="{$smarty.const.CMS_URL}/companyprofile"><h5 class="txt-footer-2018">เกี่ยวกับเรา</h5></a>
               <a href="{$smarty.const.CMS_URL}/careers"><h5 class="txt-footer-2018">ร่วมงานกับเรา</h5></a>
               <a href="{$smarty.const.CMS_URL}/reseller"><h5 class="txt-footer-2018">สนใจเป็นตัวแทน</h5></a>
               <a href="{$smarty.const.CMS_URL}/policy"><h5 class="txt-footer-2018">Pivacy Policies</h5></a>
               <a href="{$smarty.const.CMS_URL}/investor"><h5 class="txt-footer-2018">นักลงทุนสัมพันธ์</h5></a>
           </div>
          </div>

        <div class="span4 hidden-phone"  style="margin-top: 30px;">
          <div style="text-align: left;">
          <img src="https://netway.co.th/templates/netwaybysidepad/images/logo-netway-2018.png" width="150" height="auto" alt="logo Netway" style="">
          </div>
           <h4 class="nw-footer-title txt20">บริษัท เน็ตเวย์ คอมมูนิเคชั่น จำกัด</h4>
           <div style="margin-top:20px;">
               <h5 class="txt-footer-2018 ">
                  57/25 หมู่ที่ 9 ตำบลบางพูด อำเภอปากเกร็ด <br>จังหวัดนนทบุรี 11120
                  <br/><br/>
                        เลขประจำตัวผู้เสียภาษี 0135539003143 สำนักงานใหญ่  <br/> เลขทะเบียนพาณิชย์อิเล็กทรอนิกส์ 7100203002110<br/>
                         <i class="qode_icon_font_awesome fa fa-phone txt18" style="border:none; vertical-align: baseline !important; width:15px; color: #2c415e;font-size: 16px;"></i><a href="tel:+6620551095">02-055-1095</a> ,
                         &nbsp;<i class="qode_icon_font_awesome fa fa-fax txt18" style="border:none; vertical-align: baseline !important; width:15px; color: #2c415e;font-size: 16px;"></i> 02-055-1098<br/><br>
                          <img src="https://netway.co.th/templates/netwaybysidepad/images/line-icon.png" alt="" style="width: 30px" > Line: <a href="https://bit.ly/line-netway"> @netway </a> (มี @ ด้านหน้า)
                         <br/>
                         <hr/>
                         <b><u>
                         <a href="{$smarty.const.CMS_URL}/contact"><font color="#2c415e" class="txt18" >คลิ๊กดูแผนที่</font></a>
                         </u></b>

               </h5>
               <div class="visible-phone">
               <a style="padding-left: 5px;" href="javascript:void(0);" onclick="open_popup('https://www.trustmarkthai.com/callbackData/popup.php?data=dc-37-4-15a4e2c11b8166550e1a1d088f8c3218c1686265b8','verifiled');">
                            <img width="80px" class="lazy" src="https://netway.co.th/images/dbd_silver.png"  alt="dbd_silver"/>
               </a>
               </div>
           </div>
        </div>
        <div class="span4 visible-phone"  style="margin-top: 150px;">
          <div style="text-align: left; margin-top: 130px;">
          <img src="https://netway.co.th/templates/netwaybysidepad/images/logo-netway-2018.png" width="150" height="auto" alt="logo Netway" style="">
          </div>
           <h4 class="nw-footer-title txt20">บริษัท เน็ตเวย์ คอมมูนิเคชั่น จำกัด</h4>
          <div style="margin-top:20px;">
               <h5 class="txt-footer-2018 ">
                 57/25 หมู่ที่ 9 ตำบลบางพูด อำเภอปากเกร็ด จังหวัดนนทบุรี 11120<br/><br/>
                        เลขประจำตัวผู้เสียภาษี 0135539003143 สำนักงานใหญ่  <br/> เลขทะเบียนพาณิชย์อิเล็กทรอนิกส์ 7100203002110<br/>
                         <i class="qode_icon_font_awesome fa fa-phone txt18" style="border:none; vertical-align: baseline !important; width:15px; color: #2c415e;font-size: 16px;"></i><a href="tel:+6620551095"> 02-055-1095</a> ,
                         &nbsp;<i class="qode_icon_font_awesome fa fa-fax txt18" style="border:none; vertical-align: baseline !important; width:15px; color: #2c415e;font-size: 16px;"></i> 02-055-1098<br/>
                          <img src="https://netway.co.th/templates/netwaybysidepad/images/line-icon.png" alt="" style="width: 25px">Line: <a href="https://bit.ly/line-netway"> @netway </a> (มี @ ด้านหน้า)
                         <br/>
                         <hr/>
                         <b><u>
                         <a href="{$smarty.const.CMS_URL}/contact"><font color="#2c415e" class="txt18" >คลิ๊กดูแผนที่</font></a>
                         </u></b>

               </h5>
               <div class="visible-phone">
                <a style="padding-left: 5px;" href="javascript:void(0);" onclick="open_popup('https://www.trustmarkthai.com/callbackData/popup.php?data=dc-37-4-15a4e2c11b8166550e1a1d088f8c3218c1686265b8','verifiled');">
                              <img width="80px" class="lazy" src="https://netway.co.th/images/dbd_silver.png"  alt="dbd_silver"/>
                </a>
               </div>
          </div>
        </div>
    </div>
  </div>

{literal}
<style type="text/css">
  h5.txt-footer-2018 {
      font-size: 16px;
  }
</style>
{/literal}




<script type="text/javascript" src="https://billing.netway.co.th/templates/netwaybysidepad/js/jquery.lazy.min.js"></script>
<script type="text/javascript" src="https://billing.netway.co.th/templates/netwaybysidepad/js/jquery.lazy.plugins.min.js"></script>
<script type="text/javascript" src="https://billing.netway.co.th/templates/netwaybysidepad/js/javascript-2019-01.js"></script>

