
{*

This file is rendered on main HostBill screen when browsed by user

*}
<!-- *************** Start Top Banner *******************-->
{include file='banner.tpl'}
<!-- *************** End Top Banner *******************-->
<!-- Netway Connect -->

{literal}
<style>
@media (min-width: 1281px){
    .td-left {
        width: 50%;
    }
}
@media (min-width: 1281px){
    .td-right {
        width: 50%;
    }
}
.nc{
   text-decoration: none;
   color : #FFF;
}
.nc:hover {
   text-decoration: none;
   color : #7bc8ff;
}
.bannerNC{
    height: 400px;
    display: block;
    background-image: url(/templates/netwaybysidepad/images/bg-netwayconnect2-min.png);
}
</style>
{/literal}
{php}
$date_now = date("Y-m-d H:i:s");
$date_delete = '2020-09-02 14:59:00';
if ($date_delete  >  $date_now ) {
{/php}

<div class="bg-nc hidden-phone bannerNC"  >
        <div class="bg-shadow" style="height: 400px">
            <div class="container">
                <div class="row hidden-phone">
                <div>
                    <table  style="width: 100%;">
                        <tr>
                            <td  class="td-left" >
                                <div class="padding-div-nc" style="padding-top:0px;"   >
                                    <img  src="https://netway.co.th/templates/netwaybysidepad/images/small netwayconnect logo white15-8-min.png" alt="Logo Netway Connect" style="width: 400px; "/>
                                </div>
                                 <div class="padding-div-nc" style="padding-top: 25px;">
                                        <div style="padding: 0 0 0px 20px; line-height: 22px;">
                                        </div>
                                     <br>
                                </div>
                            </td>
                            <td class="td-right" >
                                <div class="padding-div-nc" style="padding-top: 45px;">
                                    <div class="bg-nc-content" style="">
                                        <div style="padding: 0 0 0px 14px;line-height: 22px;margin-top: 10px;">
                                            <p style="color: #FFF;font-size: 34px;font-family: 'Prompt', sans-serif;">ขอเชิญร่วมงานสัมมนาออนไลน์ </p>
                                            <p class="bg-nc-content" style="border-left: none;margin-top: 22px;font-size: 28px;">
                                                Netway Connect Live  ครั้งที่ 34
                                            </p>
                                            <p style="line-height:30px;color: #ffcc3e;font-family: 'Prompt', sans-serif;font-size: 24px;margin-top: 10px;">
                                                <b>Highlight : </b><span style="color: #ffcc3e;font-family: 'Prompt', sans-serif;font-size: 24px;">
                                                เพิ่มความปลอดภัยในการเก็บข้อมูล<br>ให้โดเมนของคุณด้วย DNSSEC</span>
                                            </p>
                                            <p style="margin-top: 20px; font-size: 26px;">

                                                พุธที่  2 ก.ย 2563 เวลา 14.00 - 15.00 น.
                                            </p>
                                            <p style="margin-top: 20px;color: #FFF;font-family: 'Prompt', sans-serif;font-size: 22px;">
                                            ทางเพจ
                                                <a class="nc" href="https://www.facebook.com/netway.official/" target="_blank">
                                                <img src="https://netway.co.th/templates/netwaybysidepad/images/FB-Live.png" width="17%">
                                                netway.official
                                                </a>
                                            </p>
                                        </div>


                                    </div>
                                </div>
                                <div style="margin-bottom: 20px;margin-top: 20px;">
                                    <a href="https://forms.office.com/Pages/ResponsePage.aspx?id=P0gyu2PtR0uE-DxbFIEnRSxy02nL4tRPqmHStgZvrb1UNkZDVlVLTU5DWTdNVDdPNVcwTFRWQVlFOS4u" target="_blank">
                                    <img class="lazy" alt="ลงทะเบียน Netway Connect" style="width: 170px;display:inline;margin: 20px 0px 0px 105px;" src="https://netway.co.th/templates/netwaybysidepad/images/button-resgister-netwayconnect-min.png">
                                    </a>
                                </div>
                                <br>

                            </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="bg-nc lazy visible-phone"   data-src="/templates/netwaybysidepad/images/bg-netwayconnect2-min.png"  style="height: 560px;">
       <div class="bg-shadow" style="height: 560px;" >
        <div class="container">
         <div class="row " style="padding: 45px 15px 40px 15px;">
                <div class="span6 padding-div-nc" style="text-align: center;" >
                   <img  class="lazy" src="https://netway.co.th/templates/netwaybysidepad/images/small netwayconnect logo white15-8-min.png" alt="Logo Netway Connect" style="width: 70%; margin-bottom:0px;"  />

                </div>
                <div class="span6 padding-div-nc " style=" font-size: 26px;  font-family: 'Prompt', sans-serif; color: #FFF; " >
                      <div  class="bg-nc-content" >
                            <div style="padding: 0 0 0px 20px; line-height: 24px;">
                                <p style="color: #FFF; font-size:22px;  font-family: 'Prompt', sans-serif; ">ขอเชิญร่วมงานสัมมนาออนไลน์ </p>
                                <p style="font-size: 20px; ">Netway Connect Live  ครั้งที่ 34 </p>
                                <p style="color: #ffcc3e;font-family: 'Prompt', sans-serif;font-size: 19px;margin-bottom: 10px;">
                                <b>Highlight : </b> เพิ่มความปลอดภัย<br>ในการเก็บข้อมูลให้โดเมนของคุณ<br>ด้วย DNSSEC

                                </p>
                                <p style="line-height: 35px;font-size: 24px;">พุธที่  2 ก.ย. 2563  <br> เวลา 14.00 - 15.00 น.</p>
                                <p style="margin-top: 10px;  font-size: 22px; line-height: normal; color: #ffffff;">
                                ทางเพจ
                                <a class="nc" href="https://www.facebook.com/netway.official/" target="_blank">
                                <img src="https://netway.co.th/templates/netwaybysidepad/images/FB-Live.png" width="20%">
                                netway.official
                                </a>
                                </p>
                            </div>
                      </div>
                      <br/>
                      <div style="text-align: center">
                          <a href="https://forms.office.com/Pages/ResponsePage.aspx?id=P0gyu2PtR0uE-DxbFIEnRSxy02nL4tRPqmHStgZvrb1UNkZDVlVLTU5DWTdNVDdPNVcwTFRWQVlFOS4u" target="_blank">
                              <img class="lazy" src="https://netway.co.th/templates/netwaybysidepad/images/button-resgister-netwayconnect-min.png"  alt="ลงทะเบียน Netway Connect" style=" width: 170px;  margin-left: 25px;"  />
                          </a>
                      </div>
                </div>
          </div>
     </div>
</div>
</div>
{php}
}

$date_now2 = date("Y-m-d H:i:s");
$nextTime  = '2020-08-05 15:10:00';
$date_delete2 = '2020-08-19 15:05:00';
if ($date_now2 >= $nextTime  && $date_delete2 > $date_now2 ) {
{/php}
<div class="bg-nc lazy hidden-phone"   data-src="/templates/netwaybysidepad/images/bg-netwayconnect2-min.png" style="height: 400px" >
        <div class="bg-shadow" style="height: 400px">
            <div class="container">
                <div class="row hidden-phone">
                <div>
                    <table  style="width: 100%;">
                        <tr>
                            <td  class="td-left" >
                                <div class="padding-div-nc" style="padding-top:0px;"   >
                                    <img  class="lazy" data-src="https://billing.netway.co.th/templates/netwaybysidepad/images/small netwayconnect logo white15-8-min.png" alt="Logo Netway Connect" style="width: 400px; "/>
                                </div>
                                 <div class="padding-div-nc" style="padding-top: 25px;">
                                        <div style="padding: 0 0 0px 20px; line-height: 22px;">

                                        </div>
                                     <br>

                                </div>
                            </td>
                            <td class="td-right" >
                                <div class="padding-div-nc" style="padding-top: 45px;">
                                    <div class="bg-nc-content" style="">
                                        <div style="padding: 0 0 0px 14px;line-height: 22px;margin-top: 10px;">
                                            <p style="color: #FFF;font-size: 34px;font-family: 'Prompt', sans-serif;">ขอเชิญร่วมงานสัมมนาออนไลน์ </p>
                                            <p class="bg-nc-content" style="border-left: none;margin-top: 22px;font-size: 28px;">
                                                Netway Connect Live  ครั้งที่ 33
                                            </p>
                                            <p style="line-height:30px;color: #ffcc3e;font-family: 'Prompt', sans-serif;font-size: 22px;margin-top: 20px;">
                                                <b>Highlight : </b> ต้องทำอย่างไร ? เมื่อ APPLE INC ประกาศความครอบคลุม SSL Certificate ที่สูงสุด 1 ปีเท่านั้น

                                            </p>
                                            <p style="margin-top: 20px; font-size: 26px;">

                                                พุธที่  19 ส.ค. 2563 เวลา 14.00 - 15.00 น.
                                            </p>
                                            <p style="margin-top:20px;color: #FFF;font-family: 'Prompt', sans-serif;font-size: 22px;">
                                            ทางเพจ
                                                <a class="nc" href="https://www.facebook.com/netway.official/" target="_blank">
                                                <img src="https://netway.co.th/templates/netwaybysidepad/images/FB-Live.png" width="17%">
                                                netway.official
                                                </a>
                                            </p>
                                        </div>


                                    </div>
                                </div>
                                <div style="margin-bottom: 20px;margin-top: 20px;">
                                    <a href="https://forms.office.com/Pages/ResponsePage.aspx?id=P0gyu2PtR0uE-DxbFIEnRSxy02nL4tRPqmHStgZvrb1UMDE1RjZRTUhDWFpVUldRQzdEWVNRSkk3Ny4u" target="_blank">
                                    <img class="lazy" alt="ลงทะเบียน Netway Connect" style="width: 170px;display:inline;margin: 20px 0px 0px 105px;" src="https://netway.co.th/templates/netwaybysidepad/images/button-resgister-netwayconnect-min.png">
                                    </a>
                                </div>
                                <br>

                            </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="bg-nc lazy visible-phone"   data-src="/templates/netwaybysidepad/images/bg-netwayconnect2-min.png"  style="height: 560px;">
       <div class="bg-shadow" style="height: 560px;" >
        <div class="container">
         <div class="row " style="padding: 45px 15px 40px 15px;">
                <div class="span6 padding-div-nc" style="text-align: center;" >
                   <img  class="lazy" src="https://netway.co.th/templates/netwaybysidepad/images/small netwayconnect logo white15-8-min.png" alt="Logo Netway Connect" style="width: 70%; margin-bottom:0px;"  />

                </div>
                <div class="span6 padding-div-nc " style=" font-size: 26px;  font-family: 'Prompt', sans-serif; color: #FFF; " >
                      <div  class="bg-nc-content" >
                            <div style="padding: 0 0 0px 20px; line-height: 24px;">
                                <p style="color: #FFF; font-size:22px;  font-family: 'Prompt', sans-serif; ">ขอเชิญร่วมงานสัมมนาออนไลน์ </p>
                                <p style="font-size: 20px; ">Netway Connect Live  ครั้งที่ 33 </p>
                                <p style="color: #ffcc3e;font-family: 'Prompt', sans-serif;font-size: 19px;margin-bottom: 10px;">
                                <b>Highlight : </b>ต้องทำอย่างไร ? เมื่อ APPLE INC ประกาศความครอบคลุม SSL Certificate ที่สูงสุด 1 ปีเท่านั้น
                                </p>
                                <p style="line-height: 35px;font-size: 24px;"> พุธที่  19 ส.ค. 2563 <br> เวลา 14.00 - 15.00 น. </p>
                                <p style="margin-top: 10px;  font-size: 22px; line-height: normal; color: #ffffff;">
                                ทางเพจ
                                <a class="nc" href="https://www.facebook.com/netway.official/" target="_blank">
                                <img src="https://netway.co.th/templates/netwaybysidepad/images/FB-Live.png" width="20%">
                                netway.official
                                </a>
                                </p>
                            </div>
                      </div>
                      <br/>
                      <div style="text-align: center">
                          <a href="https://forms.office.com/Pages/ResponsePage.aspx?id=P0gyu2PtR0uE-DxbFIEnRSxy02nL4tRPqmHStgZvrb1UMDE1RjZRTUhDWFpVUldRQzdEWVNRSkk3Ny4u" target="_blank">
                              <img class="lazy" src="https://netway.co.th/templates/netwaybysidepad/images/button-resgister-netwayconnect-min.png"  alt="ลงทะเบียน Netway Connect" style=" width: 170px;  margin-left: 25px;"  />
                          </a>
                      </div>
                </div>
          </div>

     </div>
</div>
</div>
{php}
}
{/php}


<!-- Start Why Netway   -->
<div class="row-fluid"  >
     <div class="container">
        <div class="row" >
            <div  class="span12" style="margin-top:40px;  margin-bottom: 20px; color: #414141; font-weight:300; font-size: 20px;  line-height: 30px; text-align: center;">


               <img  class="lazy" data-src="https://billing.netway.co.th/templates/netwaybysidepad/images/netway-20th-min.png"  alt="logo Netway" style="width: 200px;">
                <div class="hidden-phone" style="margin-top: -40px;">
                    <br/> Netway Communication คือ ผู้ให้บริการคลาวด์ครบวงจรสำหรับธุรกิจบนระบบคลาวด์
                    <br/>(One-Stop Cloud Based Business Software and Services)
                    <br/> ครอบคลุม Domain, Hosting, Cloud Solutions, E-mail, Website.
                </div>
                <div class="visible-phone" style="text-align: justify; padding: 0 20px 0 20px;">
                     Netway Communication คือ ผู้ให้บริการคลาวด์ครบวงจรสำหรับธุรกิจบนระบบคลาวด์
                     (One-Stop Cloud Based Business Software and Services)
                                          ครอบคลุม Domain, Hosting, Cloud Solutions, E-mail, Website.
                </div>

                <a href="https://netway.co.th/investor" target="_blank"><button class="btn-check-border" style="margin-top: 40px; margin-bottom:25px;"> &nbsp; &nbsp; เรียนรู้เพิ่มเติม &nbsp;<i class="fa fa-chevron-right pull-right" aria-hidden="true"></i></button></a>

            </div>
        </div>
        <div class="row" >
            <div class="span12">
                <center>
                    <h3 class="h3-titel-content txt36" font-family: 'Prompt', sans-serif;>Why Netway?</h3>
                    <span class="nw-2018-content-line"></span>
                </center>

            </div>
        </div>
       </div>
      <br/>
      <div class="container"  style="margin-bottom: 100px; padding: 0 20px 0 20px;">
        <div class="span4 div-whynetway" style="border: 1px solid #0052cd; margin-bottom: 40px;"  >
        <center>
            <div class="icon-why-netway lazy" data-src="https://billing.netway.co.th/templates/netwaybysidepad/images/icon-netway-top1.png"></div>
            <p style="color: #0052cd; font-size: 22px; margin-top: 20px;">One Stop Service</p>
            <hr class="hr-whynetway"/>
        </center>
                <p class="g-txt16" style="margin-top:20px; text-align: justify; color: #545454;">
                        ไม่ว่าจะเป็นการไอทีพื้นฐานใดๆทั้งโดเมนโฮสติ้ง  เซิร์ฟเวอร์เครื่อง มือธุรกิจอย่าง แอปพลิเคชั่นออฟฟิศ
                       จากทุกค่ายรวมทั้งโซลูชัน เฉพาะทางอย่างงาน Customer Service ทุกอย่างมีครบที่ เน็ตเวย์
                 </p>
            <center>
            <hr class="hr-whynetway"  style=" margin-top: 40px;"/>
            </center>
        </div>
        <div class="span4 div-whynetway" style="border: 1px solid #0052cd; margin-bottom: 40px;" >
        <center>
            <div class="icon-why-netway lazy" data-src="https://billing.netway.co.th/templates/netwaybysidepad/images/icon-support247365.png"></div>
            <p class="g-txt16" style="margin-top:20px; text-align: center; color: #545454;">
            <p style="color: #0052cd; font-size: 22px; margin-top: 20px;">365 x 24 x 7 Support</p>
            <hr class="hr-whynetway"/>
        </center>
           <p class="g-txt16" style="margin-top:20px; text-align: justify; color: #545454;">
                   พนักงานของเราพร้อมให้บริการ
                   และแก้ไขปัญหาให้คุณตลอด  24 ชม.
                   ไม่มีวันหยุด
                   ผ่านช่องทางที่หลากหลายทั้ง โทรศัพท์ เว็บแชท อีเมล  Social Media ฯลฯ
            </p>
            <br/>

            <center>
            <hr class="hr-whynetway"/>
            </center>
        </div><div class="span4 div-whynetway" style="border: 1px solid #0052cd; margin-bottom: 40px;"  >
        <center>
            <div class="icon-why-netway lazy" data-src="https://billing.netway.co.th/templates/netwaybysidepad/images/icon-netway-20th.png"></div>
              <p style="color: #0052cd; font-size: 22px; margin-top: 20px;">20 Years+ of Trust</p>
            <hr class="hr-whynetway"/>
        </center>
         <p class="g-txt16" style="margin-top:20px; text-align: justify; color: #545454;">
                ประสบการณ์กว่า 20 ปีในวงการไอที
      นี่คือเครื่องพิสูจน์ว่า    เน็ตเวย์พร้อม
      สนับสนุนธุรกิจคุณแบบครบวงจร
            </p>
            <br/>
            <br/>
            <br/>
            <center>
            <hr class="hr-whynetway"  style="margin-top: 13px;" />
            </center>
        </div>

     </div>

</div>

<div   class="lazy"  data-src="/templates/netwaybysidepad/images/bg-landding-netwaysite.png"
        style="
            background-position: top center;
            background-repeat: no-repeat;
            padding: 0 0px;
            text-align: center;
            width: 100%;
            background-repeat: no-repeat;
            background-size: cover;
            background-position: top;
            height: 350px;
        ">

       <div class="row-fluid" style="margin-top: -45px;">
            <div class="container" >
              <div class="span6 ">
               <p style="color: #FFF; font-family: 'Prompt', sans-serif; font-size: 42px;  margin-top: 80px;  margin-bottom:42px; ">Netway.site
               <sup><font
                    style="
                    border-radius: 20px;
                    color: #ffffff;
                    font-size: 16px;
                    color: #FFF;
                    background-color: red;
                    margin-top: -18px;
                    padding: 0px 13px;">NEW</font></sup></p>
               <p  class="hidden-phone" style="color: #FFF; font-family: 'Prompt', sans-serif; font-size: 22px;  margin-bottom: 9px;  line-height: normal; text-align: left;">
                   Your Website Your Style สร้างเว็บไซต์ภายใน 15 นาที ด้วยตัวคุณเอง
               </p>

                <p class="visible-phone" style="color: #FFF; font-family: 'Prompt', sans-serif; font-size: 22px;  margin-bottom: 9px;  line-height: normal; text-align: center;">
                   Your Website Your Style สร้างเว็บไซต์ภายใน 15 นาทีด้วยตัวคุณเอง
               </p>
               <br/>
               <a href="https://netway.site"><button class="btn-learnmore" style="margin-bottom: 20px;"> &nbsp; &nbsp;เรียนรู้เพิ่มเติม&nbsp; &nbsp;</button></a>
              </div>
              <div class="span6 hidden-phone ">
                  <img  class="lazy"  data-src="/templates/netwaybysidepad/images/img-min.png"  alt="Hero Layout Netway.site" style=" margin-top: 50px; margin-bottom: 30px;" />
              </div>


            </div>
        </div>
     </div>

<!-- ** / Why Netway ?  **-->

<!-- ** Start Section 80% ของ XXX ในประเทศไทย **-->
<div class="row-fluid white-nw-2019" id="ourproducts">
       <div class="container ">
          <div class="row">
            <div class="span12" >
                <center>
                <h3 class="h3-titel-content txt36" style="
    font-family: 'Prompt', sans-serif;
">กว่า 3,000 องค์กรในประเทศไทยใช้บริการ Netway </h3>
                <span class="nw-2018-content-line"></span>
            </div>
         </div>
      </div>
      <div class="container " style="text-align : center;">
        <div class="row-fluid" style="margin-top : 40px;">

          <div class="span3 hover-icon"  >
           <a href="https://netway.site" style="text-decoration: none;" ><div class="icon-allproducts-home lazy" data-src="https://billing.netway.co.th/templates/netwaybysidepad/images/icon-Netway2018-Other-hover.png" ></div>
               <p class="nw-product-title txt22"  >Netway.site </p>
               <center><hr width="40%"/></center>
               <p  class="nw-sub-title txt16 hidden-phone">Your Website Your Style  สร้างเว็บไซต์ภายใน 15 นาที ด้วยตัวคุณเอง</p>


                <div class="span12">
                <a href="https://netway.site" style="text-decoration: none;" ><button class="btn-readmore-2018" style="margin-top: 20px; margin-bottom: 20px;" >อ่านเพิ่มเติม</button></a>
               </div>
               </a>
            </div>

            <div class="span3 hover-icon"  >
              <a href="https://www.siamdomain.com" style="text-decoration: none;">
               <div  class="icon-allproducts-home lazy" data-src="https://billing.netway.co.th/templates/netwaybysidepad/images/icon-Netway2018-Domain.png" ></div>
               <p class="nw-product-title txt22" id="Domain-p-nw2018">Domain</p>
               <center><hr width="40%"/></center>
               <p  class="nw-sub-title txt16" >ค้นหาโดเมนสำหรับธุรกิจ<br/>และตัวคุณเอง </p>

               <div class="span12">
               <a href="https://www.siamdomain.com"><button class="btn-readmore-2018" style="margin-top: 20px; margin-bottom: 20px;">อ่านเพิ่มเติม</button></a>
               </div>
               </a>
            </div>

            <div class="span3 hover-icon"  >
               <a href="https://netway.co.th/linux-hosting"  style="text-decoration: none;" >
               <div  class="icon-allproducts-home lazy" data-src="https://billing.netway.co.th/templates/netwaybysidepad/images/icon-Netway2018-Hosting.png" ></div>
               <p class="nw-product-title txt22">Hosting</p>
               <center><hr width="40%"/></center>
               <p  class="nw-sub-title txt16">ศึกษารายละเอียดบริการเช่าใช้โฮสติ้งประเภทต่างๆ </p>

               <div class="span12">
               <a href="https://netway.co.th/linux-hosting" ><button class="btn-readmore-2018" style="margin-top: 20px; margin-bottom: 20px;">อ่านเพิ่มเติม</button></a>
               </div>
               </a>
            </div>

            <div class="span3 hover-icon"  >
             <a href="https://netway.co.th/cloud"  style="text-decoration: none;">
               <div class="icon-allproducts-home lazy" data-src="https://billing.netway.co.th/templates/netwaybysidepad/images/icon-Netway2018-Cloud.png" ></div>
               <p class="nw-product-title txt18"  style="margin-top: 6px; ">Cloud VPS & Dedicated Server</p>
               <center><hr width="40%"/></center>
               <p  class="nw-sub-title txt16">ศึกษารายละเอียดบริการเช่าใช้ Cloud VPS & Dedicated Server</p>

               <div class="span12">
               <a href="https://netway.co.th/cloud"><button class="btn-readmore-2018" style="margin-top: 20px; margin-bottom: 13px;" >อ่านเพิ่มเติม</button></a>
               </div>
             </a>
            </div>

        </div>
        <div class="row-fluid" style="margin-top : 20px;">
           <div class="span3 hover-icon"  >
            <a href="https://ssl.in.th/"  style="text-decoration: none;" >
             <div class="icon-allproducts-home lazy" data-src="https://billing.netway.co.th/templates/netwaybysidepad/images/icon-Netway2018-SSL.png" ></div>
               <p class="nw-product-title txt22">SSL</p>
               <center><hr width="40%"/></center>
               <p  class="nw-sub-title txt16">ตัวช่วยเพิ่มความปลอดภัยให้กับเว็บไซต์ของคุณมากยิ่่งขึ้น</p>
               <br>
               <div class="span12">
               <a href="https://ssl.in.th/" ><button class="btn-readmore-2018" style="margin-top: 20px; margin-bottom: 20px;" >อ่านเพิ่มเติม</button></a>
               </div>
               </a>
            </div>

            <div class="span3 hover-icon"   >
               <a href="https://netway.co.th/microsoft"  style="text-decoration: none;">
                <div class="icon-allproducts-home lazy" data-src="https://billing.netway.co.th/templates/netwaybysidepad/images/icon-Netway2018-MS-hover.png" ></div>
               <p class="nw-product-title txt22">Microsoft</p>
               <center><hr width="40%"/></center>
               <p  class="nw-sub-title txt16" >
               Windows, Microsoft 365, Office 2019, Windows Azure </p>
               <br>
               <div class="span12">
               <a href="https://netway.co.th/microsoft" ><button class="btn-readmore-2018" style="margin-top: 20px; margin-bottom: 20px;">อ่านเพิ่มเติม</button></a>
               </div>
               </a>
            </div>

            <div class="span3 hover-icon"  >
               <a href="https://netway.co.th/gsuite" style="text-decoration: none;">
               <div class="icon-allproducts-home lazy" data-src="https://billing.netway.co.th/templates/netwaybysidepad/images/icon-Netway2018-GSuite-hover.png" ></div>
               <p class="nw-product-title txt22" >Google</p>
               <center><hr width="40%"/></center>
               <p  class="nw-sub-title txt16" >G-Suite, Google Vault </p>
               <br>
               <div class="span12">
                <a href="https://netway.co.th/gsuite"><button class="btn-readmore-2018" style="margin-top: 45px; margin-bottom: 20px;">อ่านเพิ่มเติม</button></a>
               </div>
               </a>
            </div>

            <div class="span3 hover-icon" >
             <a href="https://netway.services"  style="text-decoration: none;">
               <div class="icon-allproducts-home lazy" data-src="https://billing.netway.co.th/templates/netwaybysidepad/images/icon-Netway2018-Zendesk-hover.png" ></div>
               <p class="nw-product-title txt22">Zendesk</p>
               <center><hr width="40%"/></center>
               <p  class="nw-sub-title txt16">โซลูชัั่น Omni-Channel เพื่อการจัดการลูกค้า</p>
               <br>
                <div class="span12">
               <a href="https://netway.services"><button class="btn-readmore-2018" style="margin-top: 20px; margin-bottom: 20px;">อ่านเพิ่มเติม</button></a>
               </div>
               </a>
            </div>

        </div>
        <div class="span12"></div>
      </div><script src="https://cdn.rawgit.com/michalsnik/aos/2.1.1/dist/aos.js"></script>
</div>
<!-- ** / End Section 80% ของ XXX ในประเทศไทย **-->

<!-- Start Partner-->
        <script type="text/javascript" src="{$template_dir}js/bxslide/jquery.bxslider.js"></script>
        <link href="{$template_dir}js/bxslide/jquery.bxslider.css" rel="stylesheet" type="text/css" />
        {literal}
        <script type="text/javascript">
        $(document).ready(function(){
          dots: true;
          infinite: true;
          $('.bxslider').bxSlider();
          $('.bx-pager').hide();
        });
        </script>

        {/literal}

<div class="row-fluid hidden-phone" style="padding: 100px 0 100px 0">
   <div class="container">
     <div class="row">
       <div class="span12">
        <center>
           <h3 class="h3-titel-content g-txt28">Partners</h3>
          <span class="nw-2018-content-line" style="margin-bottom: 30px;"> </span>
        </center>
        </div>
     </div>
     <div class="row">
        <div class="span3"><img  class="lazy" data-src="https://billing.netway.co.th/templates/netwaybysidepad/images/google_18.png"       alt="google"     style=" width: 189px; margin-left: 12px;" /></div>
        <div class="span3"><img  class="lazy" data-src="https://billing.netway.co.th/templates/netwaybysidepad/images/microsoft_22.png"    alt="microsoft"  style=" width: 215px;
" /></div>
        <div class="span3"><img class="lazy" data-src="https://billing.netway.co.th/templates/netwaybysidepad/images/godaddy_29.png"       alt="godaddy"    style=" width: 200px;" /></div>
        <div class="span3"><img class="lazy" data-src="https://billing.netway.co.th/templates/netwaybysidepad/images/zendesk-logo-min.png" alt="zendesk"    style=" width: 200px;"/></div>
     </div>
     <div class="row">
        <div class="span3"><img class="lazy" data-src="https://billing.netway.co.th/templates/netwaybysidepad/images/symantec_20.png"      alt="symantec"   style=" width: 230px;" /></div>
        <div class="span3"><img class="lazy" data-src="https://billing.netway.co.th/templates/netwaybysidepad/images/cloudlinux_31.png"    alt="cloudlinux" style=" width: 216px;  margin-left: -15px;" /></div>
        <div class="span3"><img class="lazy" data-src="https://billing.netway.co.th/templates/netwaybysidepad/images/digicert_24.png"      alt="digicert"   style=" width: 200px;  margin-left: 15px;  margin-top: 8px;" /></div>
        <div class="span3"><img class="lazy" data-src="https://billing.netway.co.th/templates/netwaybysidepad/images/kaspersky_39.png"     alt="kaspersky"  style=" width: 200px;  margin-top: 1px;" /></div>
     </div>
     <div class="row">
        <div class="span3"><img class="lazy" data-src="https://billing.netway.co.th/templates/netwaybysidepad/images/adobe_38.png"         alt="adobe"      style=" width: 200px; margin-left: 6px;" /></div>
        <div class="span3"><img class="lazy" data-src="https://billing.netway.co.th/templates/netwaybysidepad/images/veeam_34 .png"        alt="veeam"      style=" width: 210px; margin-left: -23px;" /></div>
        <div class="span3"><img class="lazy" data-src="https://billing.netway.co.th/templates/netwaybysidepad/images/vmware_35.png"        alt="vmware"     style=" width: 220px;"/></div>
        <div class="span3"><img class="lazy" data-src="https://billing.netway.co.th/templates/netwaybysidepad/images/srsplus_37.png"       alt="srsplus"    style=" width: 214px;" /></div>
     </div>
     <div class="row">
        <div class="span3"><img class="lazy" data-src="https://billing.netway.co.th/templates/netwaybysidepad/images/cpanelwhm_27.png"     alt="cpanelwhm"  style=" width: 230px;" /></div>
        <div class="span3"><img class="lazy" data-src="https://billing.netway.co.th/templates/netwaybysidepad/images/zimbra_32.png"        alt="zimbra"     style=" width: 211px;  margin-left: 10px;" /></div>
        <div class="span3"><img class="lazy" data-src="https://billing.netway.co.th/templates/netwaybysidepad/images/amazon_28.png"        alt="amazon"     style=" width: 200px;"/></div>
        <div class="span3"><img class="lazy" data-src="https://billing.netway.co.th/templates/netwaybysidepad/images/Entrus-new-logo-min.png"  alt="Entrust" style=" width: 200px;" /></div>
     </div>
   </div>
</div>
<!-- Show Phone  -->
<div class="row-fluid visible-phone">
    <div class="container">
     <div class="row footer-2018  ">
      <div style="margin-bottom: 50px;">
        <center>
        <h3 class="h3-titel-content g-txt28">Partners</h3>
            <span class="nw-2018-content-line"> </span>
        </center>

     <section class="customer-logos slider " style="margin-top: 30px;">
         <div class="slide "><img class="lazy" data-src="https://billing.netway.co.th/templates/netwaybysidepad/images/google_18.png"     alt="google" title="google" /></div>
         <div class="slide "><img class="lazy" data-src="https://billing.netway.co.th/templates/netwaybysidepad/images/symantec_20.png"   alt="symantec" /></div>
         <div class="slide "><img class="lazy" data-src="https://billing.netway.co.th/templates/netwaybysidepad/images/microsoft_22.png"  alt="microsoft" /></div>
         <div class="slide "><img class="lazy" data-src="https://billing.netway.co.th/templates/netwaybysidepad/images/digicert_24.png"   alt="digicert" title="digicert" /></div>

         <div class="slide"><img  class="lazy" data-src="https://billing.netway.co.th/templates/netwaybysidepad/images/cpanelwhm_27.png"  alt="cpanelwhm" title="cpanelwhm"  /></div>
         <div class="slide"><img  class="lazy" data-src="https://billing.netway.co.th/templates/netwaybysidepad/images/amazon_28.png"     alt="amazon" title="amazon" /></div>
         <div class="slide"><img  class="lazy" data-src="https://billing.netway.co.th/templates/netwaybysidepad/images/google_18.png"     alt="godaddy" title="godaddy"/></div>
         <div class="slide"><img  class="lazy" data-src="https://billing.netway.co.th/templates/netwaybysidepad/images/cloudlinux_31.png" alt="cloudlinux" title="cloudlinux" /></div>

         <div class="slide"><img  class="lazy" data-src="https://billing.netway.co.th/templates/netwaybysidepad/images/zimbra_32.png"     alt="zimbra" title="zimbra" /></div>
         <div class="slide"><img  class="lazy" data-src="https://billing.netway.co.th/templates/netwaybysidepad/images/veeam_34 .png"     alt="veeam" title="veeam" /></div>
         <div class="slide"><img  class="lazy" data-src="https://billing.netway.co.th/templates/netwaybysidepad/images/vmware_35.png"     alt="vmware" title="vmware" /></div>
         <div class="slide"><img  class="lazy" data-src="https://billing.netway.co.th/templates/netwaybysidepad/images/srsplus_37.png"    alt="srsplus" title="srsplus" /></div>

         <div class="slide"><img class="lazy" data-src="https://billing.netway.co.th/templates/netwaybysidepad/images/adobe_38.png"       alt="adobe" title="adobe"   /></div>
         <div class="slide"><img class="lazy" data-src="https://billing.netway.co.th/templates/netwaybysidepad/images/kaspersky_39.png"   alt="kaspersky" title="kaspersky"   /></div>
         <div class="slide"><img class="lazy" data-src="https://billing.netway.co.th/templates/netwaybysidepad/images/Entrus-new-logo-min.png"  alt="Entrust" /></div>
         <div class="slide"><img class="lazy" data-src="https://billing.netway.co.th/templates/netwaybysidepad/images/zendesk-logo-min.png" alt="Zendesk"   alt="Zendesk" title="Zendesk" /></div>
   </section>
   </div>
</div>
</div>
</div>


<div class="clearit"></div>
<script src="https://cdn.rawgit.com/michalsnik/aos/2.1.1/dist/aos.js"></script>
<script language="JavaScript">
{literal}
$(document).ready( function () {
    var url     = window.location.href;
    var pos     = url.search(/resetpasswordcustom/i);
    if (pos >= 0) {
        $('.none-resetpasswordcustom').hide();
        $('.resetpasswordcustom').show();
    }
});
{/literal}
</script>

<script>
{literal}
$(document).ready(function(){
       $("#myModal").modal('toggle');
       $("#myModalPhone").modal('toggle');


});
{/literal}
</script>