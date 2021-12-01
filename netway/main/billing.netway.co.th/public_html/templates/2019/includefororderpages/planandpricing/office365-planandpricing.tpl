<link rel="stylesheet" href="https://swiperjs.com/package/swiper-bundle.min.css">

<script>
$(document).ready(function(){
   
   $('a[data-toggle="tab"]').click(function(event) {
        $('a[data-toggle="tab"]').removeClass('active');
        $(this).addClass('active');
    });
   
    $(".nav-tabs a").click(function(){
        $(this).tab('show');
    });
   var swiper = new Swiper('.swiper-container', {
      slidesPerView: 1,
      spaceBetween: 30,
      loop: true,
      pagination: {
        el: '.swiper-pagination',
        clickable: true,
      },
      navigation: {
        nextEl: '.swiper-button-next',
        prevEl: '.swiper-button-prev',
      },
    });

  /* $("a.dynamic-nav").on('click', function(event) {
            
        if (this.hash !== "") {
          event.preventDefault();
          var hash = this.hash;
          $('html, body').animate({
            scrollTop: $(hash).offset().top-10
          }, 800, function(){
            window.location.hash = hash;
          });
        }
        //toggleActiveClass($(this));
    });*/
    
    // $('a[data-toggle="tab"]').removeClass('active'); 
    $('#bs').click(); 
    //$('#h').addClass('active');
    
});
 
function toggleActiveClass(el){
    console.log(el[0].hash);
    $("a.dynamic-nav").each(function(){
        $(this).removeClass('active');
    });
    $(el).addClass('active');
    
}

</script>




<div class="row-fluid" style="background-color: #f8f8f8;">
    <div class="container" style="margin-top: 70px; margin-bottom: 50px;">
        <div class="row">
            <div class="span12 dynamic-content">
                <center>
                    <h3 class="h3-title-content g-txt32 re-topic">Plan & Pricing </h3>
                    <span class="nw-2018-content-line" style="margin-bottom: 50px;"></span>
                    <h3 class="g-txt22">ซื้อ Microsoft 365 ผ่าน Netway
ได้ทั้ง บิล VAT และ Support ตลอด 24 ชม.  </h3>
                    
                </center>
            </div>
        </div>
    </div>
</div>
<!-- hidden-phone -->
<div class="row" style="background-color: #f8f8f8;">
    <div class="container">
        <div class="span12">
            <ul class=" hidden-phone menu-office365" style="0px solid #fff;">
                <li><a data-toggle="tab" href="#Business"  class="  cat" id="bs">สำหรับธุรกิจ</a></li>
                <li><a data-toggle="tab" href="#home"  class=" cat" id="h">สำหรับใช้งานที่บ้าน</a></li>
                
                
            </ul>
          
        </div>
    </div>
</div>

<!--hidden-phone -->
<div class="row hidden-phone" style="background-color: #f8f8f8;">
    <div class="container">
        <div class="span12">
            <hr style="margin: 0px 0px 0px 0px; border-top: 0px solid #AEAEAE;">
              <div style="text-align: center;padding: 15px 0px 15px 0px;background: #2974f7;">
                <span style="padding: 15px;color: white;font-size: 18px;font-weight: 500;">
                    Office 365 เปลี่ยนชื่อเป็น Microsoft 365 ชื่อใหม่ แต่คุ้มค่าเหมือนเดิมในราคาเดิม
                </span>
              </div>  
            <div class="tab-content" style="overflow: initial;">
                <!-- tab-plan&pricing -->

                <div id="home"  class="tab-pane fade in ">
                    <div class="row" style="margin-top: 40px; margin-bottom: 70px;">
                        <div class="span3 " style="height: 500px;">
                            <div class="detail_plan">
                                <p class="g-txt16" style="color: #000;">กำลังมองหาอะไรเพิ่มเติมใช่ไหม</p>
                                <br />

                                <p class="g-txt16">ดูตัวเลือกสำหรับ:</p>
                                <p class="g-txt16 ">
                                    <a href="https://office365education.com">นักเรียน</a> | <a href="https://netway.co.th/office-home">Mac</a>
                                </p>

                                <br /> <a href="https://netway.co.th/office-home"><p class="g-txt16 color-blue-a">
                                        Microsoft 365 <br />สำหรับใช้งานที่บ้านคืออะไร
                                    </p></a>

                            </div>
                        </div>
                        <div class="span3">
                            <!-- Microsoft 365 Family Plan 1 -->
                            <div class="plan-gs" style="height: 1050px; text-align: center;">
                                <p class="txt-price-small">Microsoft 365 <br> Family<br><span style="font-size: 14px;">(เดิมชื่อ Office 365 Home)</span></p>
                                <p class="color-blue-s txt-price-top"  style="margin-top: 37px;">฿{price.664.a}</p>
                                <p style="margin-top: -25px; margin-bottom: 25px;">(ต่อปี)</p>
                                
                                <a href='{link.664}'><button class="btn-buy"
                                        style="margin-top: 5px; margin-bottom: 10px;">ซื้อทันที</button></a>
                                  

                                    </p></a>
                                <hr style="border-top: 2px solid #cccccc;" />
                                <p class="g-txt16"
                                    style="padding: 10px 0 20px 0; font-size: 15px;">
                                    เหมาะที่สุดสำหรับใช้งานในครอบครัว รวมถึงแอปพลิเคชัน Office <br />สำหรับผู้ใช้สูงสุด
                                    5 ราย
                                <p>

                                    <!-- Title Product Group Microsoft 365 Family 0 -->
                                <p class="txt-titel-pro"
                                    style="text-align: left; margin-bottom: 20px;">รวมแอปพลิเคชั่น
                                    Office</p>

                                <!-- row 0 -->
                                <div class="i-product" style="padding: 10px 33px 10px 0;">
                                    <div class="img-icon bg-Word"></div>
                                    <!-- img -->
                                    <br />
                                    <p class="txt-namepro">Word</p>
                                </div>

                                <div class="i-product" style="padding: 10px 33px 10px 0;">
                                    <div class="img-icon bg-Excel"></div>
                                    <!-- img -->
                                    <br />
                                    <p class="txt-namepro">Excel</p>
                                </div>

                                <div class="i-product" style="padding: 10px 0 10px 0;">
                                    <div class="img-icon bg-PowerPoint"></div>
                                    <!-- img -->
                                    <br />
                                    <p class="txt-namepro">PowerPoint</p>
                                </div>
                                <!-- / row 0 -->

                                <!-- row 1 -->
                                <div class="i-product" style="padding: 10px 33px 10px 0;">
                                    <div class="img-icon bg-OneNote"></div>
                                    <!-- img -->
                                    <br />
                                    <p class="txt-namepro">OneNote</p>
                                </div>

                                <div class="i-product" style="padding: 10px 33px 10px 0;">
                                    <div class="img-icon bg-Outlook"></div>
                                    <!-- img -->
                                    <br />
                                    <p class="txt-namepro">Outlook</p>
                                </div>

                                <div class="i-product" style="padding: 10px 0 10px 0;">
                                    <div class="img-icon bg-Publisher"></div>
                                    <!-- img -->
                                    <br />
                                    <p class="txt-namepro" style="width: 60px;">Publisher
                                        (พีซีเท่านั้น)</p>
                                </div>
                                <!-- / row 1 -->

                                <!-- row 2 -->
                                <div class="i-product" style="padding: 10px 20px 10px 0;">
                                    <div class="img-icon bg-Access"></div>
                                    <!-- img -->
                                    <br />
                                    <p class="txt-namepro" style="width: 60px;">Access
                                        (พีซีเท่านั้น)</p>
                                </div>

                                <div class="i-product" style="padding: 10px 20px 10px 0;">
                                    <div class="img-icon"></div>
                                    <!-- img -->
                                    <br />
                                    <p class="txt-namepro">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
                                </div>

                                <div class="" style="padding: 10px 20px 10px 0;">
                                    <div class="img-icon "></div>
                                    <!-- img -->
                                    <br />
                                    <p class="txt-namepro">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
                                </div>
                                <!-- / row 2 -->



                                <!-- Title Product Group Microsoft 365 Family Home1 -->
                                <br />
                                <br />
                                <br />
                                <p class="txt-titel-pro"
                                    style="text-align: left; margin-top: 50px;">รวมบริการ</p>

                                <!-- row 3 -->
                                <div class="i-product" style="padding: 10px 33px 10px 0;">
                                    <div class="img-icon bg-OneDrive"></div>
                                    <!-- img -->
                                    <br />
                                    <p class="txt-namepro">OneDrive</p>
                                </div>

                                <div class="i-product" style="padding: 10px 33px 10px 0;">
                                    <div class="img-icon bg-Skype"></div>
                                    <!-- img -->
                                    <br />
                                    <p class="txt-namepro  ">Skype</p>
                                </div>

                                <div class="i-product" style="padding: 10px 0 10px 0;">
                                    <div class="img-icon "></div>
                                    <!-- img -->
                                    <br />
                                    <p class="txt-namepro">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
                                </div>
                                <!-- / row 3 -->

                            </div>
                        </div>


                        <div class="span3">
                            <!-- Microsoft 365 Home Plan 2 -->
                            
                            <div class="plan-gs" style="height: 1050px; text-align: center;">
                                <p class="txt-price-small" >Microsoft 365 Personal <br><span style="font-size: 14px;">(เดิมชื่อ Office 365 Personal)</span></p>
                                <p class="color-blue-s txt-price-top" style="margin-top: 38px">฿{price.749.a}</p>
                                <p style="margin-top: -25px; margin-bottom: 25px;">(ต่อปี)</p>
                                
                                <a href='{link.749}'><button class="btn-buy"
                                        style="margin-top: 5px; margin-bottom: 8px;">ซื้อทันที</button></a>

                  
                                    </p></a>
                                <hr style="border-top: 2px solid #cccccc;" />
                                <p class="g-txt16"
                                    style="padding: 10px 0 20px 0; font-size: 15px;">
                                    เหมาะที่สุดสำหรับใช้งานคนเดียว รวมถึงแอปพลิเคชัน Office <br />สำหรับผู้ใช้
                                    1 ราย
                                <p>

                                    <!-- Title Product Group Microsoft 365 Family 0 -->
                                <p class="txt-titel-pro"
                                    style="text-align: left; margin-bottom: 20px;">รวมแอปพลิเคชั่น
                                    Office</p>

                                <!-- row 0 -->
                                <div class="i-product" style="padding: 10px 33px 10px 0;">
                                    <div class="img-icon bg-Word"></div>
                                    <!-- img -->
                                    <br />
                                    <p class="txt-namepro">Word</p>
                                </div>

                                <div class="i-product" style="padding: 10px 33px 10px 0;">
                                    <div class="img-icon bg-Excel"></div>
                                    <!-- img -->
                                    <br />
                                    <p class="txt-namepro">Excel</p>
                                </div>

                                <div class="i-product" style="padding: 10px 0 10px 0;">
                                    <div class="img-icon bg-PowerPoint"></div>
                                    <!-- img -->
                                    <br />
                                    <p class="txt-namepro">PowerPoint</p>
                                </div>
                                <!-- / row 0 -->

                                <!-- row 1 -->
                                <div class="i-product" style="padding: 10px 33px 10px 0;">
                                    <div class="img-icon bg-OneNote"></div>
                                    <!-- img -->
                                    <br />
                                    <p class="txt-namepro">OneNote</p>
                                </div>

                                <div class="i-product" style="padding: 10px 33px 10px 0;">
                                    <div class="img-icon bg-Outlook"></div>
                                    <!-- img -->
                                    <br />
                                    <p class="txt-namepro">Outlook</p>
                                </div>

                                <div class="i-product" style="padding: 10px 0 10px 0;">
                                    <div class="img-icon bg-Publisher"></div>
                                    <!-- img -->
                                    <br />
                                    <p class="txt-namepro" style="width: 60px;">Publisher
                                        (พีซีเท่านั้น)</p>
                                </div>
                                <!-- / row 1 -->

                                <!-- row 2 -->
                                <div class="i-product" style="padding: 10px 33px 10px 0;">
                                    <div class="img-icon bg-Access"></div>
                                    <!-- img -->
                                    <br />
                                    <p class="txt-namepro" style="width: 60px;">Access
                                        (พีซีเท่านั้น)</p>
                                </div>

                                <div class="i-product" style="padding: 10px 33px 10px 0;">
                                    <div class="img-icon"></div>
                                    <!-- img -->
                                    <br />
                                    <p class="txt-namepro">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
                                </div>

                                <div class="" style="padding: 10px 0 10px 0;">
                                    <div class="img-icon "></div>
                                    <!-- img -->
                                    <br />
                                    <p class="txt-namepro">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
                                </div>
                                <!-- / row 2 -->



                                <!-- Title Product Group Microsoft 365 Family 1 -->
                                <br />
                                <br />
                                <br />
                                <p class="txt-titel-pro"
                                    style="text-align: left; margin-top: 50px;">รวมบริการ</p>

                                <!-- row 3 -->
                                <div class="i-product" style="padding: 10px 33px 10px 0;">
                                    <div class="img-icon bg-OneDrive"></div>
                                    <!-- img -->
                                    <br />
                                    <p class="txt-namepro">OneDrive</p>
                                </div>

                                <div class="i-product" style="padding: 10px 33px 10px 0;">
                                    <div class="img-icon bg-Skype"></div>
                                    <!-- img -->
                                    <br />
                                    <p class="txt-namepro  ">Skype</p>
                                </div>

                                <div class="i-product" style="padding: 10px 0px 10px 0;">
                                    <div class="img-icon "></div>
                                    <!-- img -->
                                    <br />
                                    <p class="txt-namepro">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
                                </div>
                                <!-- / row 3 -->

                            </div>
                        </div>

                        <div class="span3">
                            <!-- Office Home & Student 2019 for PC Plan 3 -->
                            <div class="plan-gs" style="height: 1050px; text-align: center;">
                                <p class="txt-price-small">Office Home & Student 2019 for PC</p>
                                <p class="color-blue-s txt-price-top" style="margin-top: 65px;" >฿{price.776.m}</p>
                                <!--*ไม่มีราคาใน hostbill-->
                                <p style="margin-top: -25px; margin-bottom: 25px;">(การซื้อครั้งเดียว)</p>
                               
                                <a href='{link.776}'><button class="btn-buy"
                                        style="margin-top: 5px; margin-bottom: 8px;">ซื้อทันที</button></a>

                                <hr style="border-top: 2px solid #cccccc;" />
                                <p class="g-txt16"
                                    style="padding: 10px 0 20px 0; font-size: 15px;">
                                    เหมาะที่สุดสำหรับใช้งานคนเดียวด้วยความต้องการพื้นฐาน <br />รวมถึงแอปพลิเคชัน
                                    Office
                                <p>

                                    <!-- Title Product Group Microsoft 365 Family 0 -->
                                <p class="txt-titel-pro"
                                    style="text-align: left; margin-bottom: 20px;">รวมแอปพลิเคชั่น
                                    Office</p>

                                <!-- row 0 -->
                                <div class="i-product" style="padding: 10px 33px 10px 0;">
                                    <div class="img-icon bg-Word"></div>
                                    <!-- img -->
                                    <br />
                                    <p class="txt-namepro">Word</p>
                                </div>

                                <div class="i-product" style="padding: 10px 33px 10px 0;">
                                    <div class="img-icon bg-Excel"></div>
                                    <!-- img -->
                                    <br />
                                    <p class="txt-namepro">Excel</p>
                                </div>

                                <div class="i-product" style="padding: 10px 0 10px 0;">
                                    <div class="img-icon bg-PowerPoint"></div>
                                    <!-- img -->
                                    <br />
                                    <p class="txt-namepro">PowerPoint</p>
                                </div>
                                <!-- / row 0 -->

                                <!-- row 1 -->
                                <div class="i-product" style="padding: 10px 33px 10px 0;">
                                    <div class="img-icon bg-OneNote"></div>
                                    <!-- img -->
                                    <br />
                                    <p class="txt-namepro">OneNote</p>
                                </div>

                                <div class="i-product" style="padding: 10px 33px 10px 0;">
                                    <div class="img-icon "></div>
                                    <!-- img -->
                                    <br />
                                    <p class="txt-namepro"></p>
                                </div>

                                <div class="i-product" style="padding: 10px 0 10px 0;">
                                    <div class="img-icon "></div>
                                    <!-- img -->
                                    <br />
                                    <p class="txt-namepro" style="width: 60px;"></p>
                                </div>
                                <!-- / row 1 -->

                                <!-- row 2 -->
                                <div class="i-product" style="padding: 10px 20px 10px 0;">
                                    <div class="img-icon "></div>
                                    <!-- img -->
                                    <br />
                                    <p class="txt-namepro" style="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
                                </div>

                                <div class="i-product" style="padding: 10px 20px 10px 0;">
                                    <div class="img-icon"></div>
                                    <!-- img -->
                                    <br />
                                    <p class="txt-namepro">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
                                </div>

                                <div class="" style="padding: 10px 20px 10px 0;">
                                    <div class="img-icon "></div>
                                    <!-- img -->
                                    <br />
                                    <p class="txt-namepro">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
                                </div>
                                <!-- / row 2 -->



                                <!-- Title Product Group Microsoft 365 Family 1 -->
                                <br />
                                <br />
                                <br />
                                <p class="txt-titel-pro"
                                    style="text-align: left; margin-top: -13px;">รวมบริการ</p>
                                <p class="g-txt16" style="margin-top: 10px; text-align: left;">(ไม่รวม)</p>

                            </div>
                        </div>



                    </div>
                    <div class="hidden-phone;">
                        <hr style="border-top: 2px solid #E4E4E4; margin-bottom: -1px;" />
                    </div>
                    <div class="row row-gray">
                        <div class="span3">
                            <div class="padding-row-plan gs-tooltip" style="color: #333;">
                                แอป Office
                                แบบพรีเมี่ยมที่ติดตั้งอย่างเต็มรูปแบบพร้อมฟีเจอร์ใหม่พิเศษทุกเดือน
                                &nbsp;<i class="fa fa-info-circle" aria-hidden="true"></i> <span
                                    class="gs-tooltiptext hidden-phone"> เข้ากันได้กับ
                                    Windows 7 หรือใหม่กว่า Micros 2016 for Mac ต้องการ Mac OS X
                                    10.10 จำเป็นต้องมีบัญชี Microsoft</span>
                            </div>
                        </div>
                        <div class="span3">
                            <div class="padding-row-plan" style="text-align: center;">

                                <img
                                    src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png"
                                    width="35px" />

                            </div>
                        </div>
                        <div class="span3">
                            <div class="padding-row-plan" style="text-align: center;">

                                <img
                                    src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png"
                                    width="35px" />

                            </div>
                        </div>
                        <div class="span3" style="text-align: center;">
                            <div class="padding-row-plan">แอป Office
                                คลาสสิกที่ติดตั้งอย่างเต็มรูปแบบ</div>
                        </div>
                    </div>


                    <div class="row row-white">
                        <div class="span3">
                            <div class="padding-row-plan gs-tooltip" style="color: #333;">
                                รวมแอป &nbsp;<i class="fa fa-info-circle" aria-hidden="true"></i>
                                <span class="gs-tooltiptext hidden-phone">ความพร้อมใช้งานของแอปและฟีเจอร์แตกต่างกันไปตามอุปกรณ์,
                                    แพลตฟอร์ม, และภาษา</span>
                            </div>
                        </div>
                        <div class="span3">
                            <div class="padding-row-plan gs-tooltip"
                                style="text-align: center; color: #333;">
                                Word, Excel, PowerPoint, OneNote, Outlook, Publisher, Access
                                &nbsp;<i class="fa fa-info-circle" aria-hidden="true"></i> <span
                                    class="gs-tooltiptext hidden-phone"
                                    style="left: 10px; top: 78px;">Publisher และ Access
                                    มีพร้อมให้ใช้งานบนพีซีเท่านั้น</span>
                            </div>
                        </div>
                        <div class="span3">
                            <div class="padding-row-plan gs-tooltip"
                                style="text-align: center; color: #333;">

                                Word, Excel, PowerPoint, OneNote, Outlook, Publisher, Access
                                &nbsp;<i class="fa fa-info-circle" aria-hidden="true"></i> <span
                                    class="gs-tooltiptext hidden-phone"
                                    style="left: 10px; top: 78px;">Publisher และ Access
                                    มีพร้อมให้ใช้งานบนพีซีเท่านั้น</span>

                            </div>
                        </div>
                        <div class="span3">
                            <div class="padding-row-plan" style="text-align: center;">
                                Word, Excel, PowerPoint, OneNote</div>
                        </div>
                    </div>


                    <div class="row row-gray">
                        <div class="span3">
                            <div class="padding-row-plan">ที่เก็บข้อมูลบนระบบคลาวด์ของ
                                OneDrive ขนาด 1 TB สำหรับผู้ใช้แต่ละราย</div>
                        </div>
                        <div class="span3">
                            <div class="padding-row-plan" style="text-align: center;">

                                <img
                                    src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png"
                                    width="35px" />
                                <p>สำหรับสูงสุด 5 คน</p>

                            </div>
                        </div>
                        <div class="span3">
                            <div class="padding-row-plan" style="text-align: center;">

                                <img
                                    src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png"
                                    width="35px" />
                                <p>สำหรับสูงสุด 1 คน</p>
                            </div>
                        </div>
                        <div class="span3">
                            <div class="padding-row-plan"></div>
                        </div>
                    </div>

                    <div class="row row-white">
                        <div class="span3">
                            <div class="padding-row-plan">ที่เก็บข้อมูลบนระบบคลาวด์ของ
                                OneDrive ขนาด 1 TB สำหรับผู้ใช้แต่ละราย</div>
                        </div>
                        <div class="span3">
                            <div class="padding-row-plan" style="text-align: center;">

                                <img
                                    src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png"
                                    width="35px" />
                                <p>สำหรับสูงสุด 5 คน</p>

                            </div>
                        </div>
                        <div class="span3">
                            <div class="padding-row-plan" style="text-align: center;">

                                <img
                                    src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png"
                                    width="35px" />
                                <p>สำหรับสูงสุด 1 คน</p>

                            </div>
                        </div>
                        <div class="span3">
                            <div class="padding-row-plan" style="text-align: center;">
                                Word, Excel, PowerPoint, OneNote</div>
                        </div>
                    </div>


                    <div class="row row-gray">
                        <div class="span3">
                            <div class="padding-row-plan gs-tooltip" style="color: #333;">
                                ด้วย Skype โทรไปยังโทรศัพท์มือถือและโทรศัพท์บ้าน 60
                                นาทีต่อเดือนต่อผู้ใช้ 
                                &nbsp;<i class="fa fa-info-circle" aria-hidden="true"></i> <span
                                    class="gs-tooltiptext hidden-phone" style="left: 150px;">จำเป็นต้องใช้บัญชี
                                    Skype ไม่รวมหมายเลขพิเศษ หมายเลขพรีเมียม
                                    หมายเลขที่ไม่สามารถระบุประเทศได้
                                    โทรไปยังโทรศัพท์มือถือสำหรับประเทศที่เลือกเท่านั้น นาที Skype
                                    พร้อมใช้งานในประเทศที่เลือก</span>
                            </div>
                        </div>
                        <div class="span3">
                            <div class="padding-row-plan" style="text-align: center;">

                                <img
                                    src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png"
                                    width="35px" />
                                <p>สำหรับสูงสุด 5 คน</p>

                            </div>
                        </div>
                        <div class="span3">
                            <div class="padding-row-plan" style="text-align: center;">

                                <img
                                    src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png"
                                    width="35px" />
                                <p>สำหรับสูงสุด 1 คน</p>
                            </div>
                        </div>
                        <div class="span3">
                            <div class="padding-row-plan"></div>
                        </div>
                    </div>



                    <div class="row row-white">
                        <div class="span3">
                            <div class="padding-row-plan">การสนับสนุน Microsoft
                                ผ่านการพูดคุยหรือโทรศัพท์โดยไม่มีค่าใช้จ่ายเพิ่มเติมผ่านการสมัครใช้งานของคุณ
                            </div>
                        </div>
                        <div class="span3">
                            <div class="padding-row-plan" style="text-align: center;">

                                <img
                                    src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png"
                                    width="35px" />


                            </div>
                        </div>
                        <div class="span3">
                            <div class="padding-row-plan" style="text-align: center;">

                                <img
                                    src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png"
                                    width="35px" />


                            </div>
                        </div>
                        <div class="span3">
                            <div class="padding-row-plan" style="text-align: center;">
                                รวมสำหรับ 60 วัน</div>
                        </div>
                    </div>

                    <div class="row row-gray">
                        <div class="span3">
                            <div class="padding-row-plan">
                                สิทธิ์การใช้งานสำหรับการใช้งานที่บ้าน</div>
                        </div>
                        <div class="span3">
                            <div class="padding-row-plan" style="text-align: center;">
                                <img
                                    src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png"
                                    width="35px" />
                            </div>
                        </div>
                        <div class="span3">
                            <div class="padding-row-plan" style="text-align: center;">
                                <img
                                    src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png"
                                    width="35px" />
                            </div>
                        </div>
                        <div class="span3" style="text-align: center;">
                            <div class="padding-row-plan">
                                <img
                                    src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png"
                                    width="35px" />
                            </div>
                        </div>
                    </div>

                    <div class="row row-white">
                        <div class="span3">
                            <div class="padding-row-plan">วิธีการซื้อ</div>
                        </div>
                        <div class="span3">
                            <div class="padding-row-plan gs-tooltip"
                                style="text-align: center; color: #333;">

                                ซื้อการสมัครสมาชิกแบบ<br />รายปีหรือรายเดือน &nbsp;<i
                                    class="fa fa-info-circle" aria-hidden="true"></i> <span
                                    class="gs-tooltiptext hidden-phone"
                                    style="left: 10px; top: 78px;">Publisher และ Access
                                    มีพร้อมให้ใช้งานบนพีซีเท่านั้น</span>

                            </div>
                        </div>
                        <div class="span3">
                            <div class="padding-row-plan gs-tooltip"
                                style="text-align: center; color: #333;">

                                ซื้อการสมัครสมาชิกแบบ<br />รายปีหรือรายเดือน &nbsp;<i
                                    class="fa fa-info-circle" aria-hidden="true"></i> <span
                                    class="gs-tooltiptext hidden-phone"
                                    style="left: 10px; top: 78px;">Publisher และ Access
                                    มีพร้อมให้ใช้งานบนพีซีเท่านั้น</span>

                            </div>
                        </div>
                        <div class="span3" style="text-align: center;">
                            <div class="padding-row-plan">การซื้อครั้งเดียว</div>
                        </div>
                    </div>

                    <hr
                        style="border-top: 2px solid #E4E4E4; margin-bottom: -25px; margin-top: 0px;">
                    <div class="row" style="margin-top: 40px;">
                        <div class="span3 " style="height: 600px;">
                            <div class="detail_plan"></div>
                        </div>
                        <div class="span3">
                            <!-- Microsoft 365 Home Plan 1 -->
                            <div class="plan-gs" style="height: 450px; text-align: center;">
                                <p class="txt-price-small">Microsoft 365 <br> Family<br><span style="font-size: 14px;">(เดิมชื่อ Office 365 Home)</span></p>
                                <p class="color-blue-s txt-price-top" style="margin-top: 38px;" >฿{price.664.a}</p>
                                <p style="margin-top: -25px; margin-bottom: 25px;">(ต่อปี)</p>
                            
                                <a href='{link.664.a}'><button class="btn-buy"
                                        style="margin-top: 30px; margin-bottom: 10px;">ซื้อทันที</button></a>
                                
  
                                    </p></a>
                                <hr style="border-top: 2px solid #cccccc;" />

                                <center>
                                    <a href="www.netway.co.th/office-home"><p class="txt-price-detill"
                                            style="font-size: 18px;">
                                            เรียนรู้เพิ่มเติม <i class="fa fa-chevron-right"
                                                aria-hidden="true"></i>
                                        </p></a>
                                </center>
                            </div>
                        </div>


                        <div class="span3">
                            <!-- Microsoft 365 Personal Plan 2 -->
                            <div class="plan-gs" style="height: 450px; text-align: center;">
                                <p class="txt-price-small">Microsoft 365 Personal<br><span style="font-size: 14px;">(เดิมชื่อ Office 365 Personal)</span></p>
                                <p class="color-blue-s txt-price-top" style="margin-top: 38px;">฿{price.749.a}</p>
                                <p style="margin-top: -25px; margin-bottom: 25px;">(ต่อปี)</p>
                                
                                <a href='{link.749}'><button class="btn-buy"
                                        style="margin-top: 30px; margin-bottom: 10px;">ซื้อทันที</button></a>

           
                                    </p></a>
                                <hr style="border-top: 2px solid #cccccc;" />

                                <center>
                                    <a href="https://www.netway.co.th/office-personal" style="display:none;"><p class="txt-price-detill"
                                            style="font-size: 18px;">
                                            เรียนรู้เพิ่มเติม <i class="fa fa-chevron-right"
                                                aria-hidden="true"></i>
                                        </p></a>
                                </center>

                            </div>
                        </div>

                        <div class="span3">
                            <!-- Microsoft 365 Family  Plan 3 -->
                            <div class="plan-gs" style="height: 450px; text-align: center;">
                                <p class="txt-price-small">Office Home & Student 2019 for PC</p>
                                <p class="color-blue-s txt-price-top" style="margin-top: 70px;">฿{price.776.m}</p>
                                <p style="margin-top: -25px; margin-bottom: 50px;">(การซื้อครั้งเดียว)</p>
               
                                <a href='{link.776.a}'><button class="btn-buy"
                                        style="margin-top: 2px; margin-bottom:8px;">ซื้อทันที</button></a>

                                <hr style="border-top: 2px solid #cccccc;" />

                                <center>
                                    <a href="#" style="display:none;"><p class="txt-price-detill"
                                            style="font-size: 18px;">
                                            เรียนรู้เพิ่มเติม <i class="fa fa-chevron-right"
                                                aria-hidden="true"></i>
                                        </p></a>
                                </center>


                            </div>



                        </div>
                    </div>
                </div>
                <!-- / HOME -->

                <!-- id Office365 for Business  -->
                <div id="Business"  class="tab-pane fade in active  ">
                    <div class="row" style="margin-top: 40px;">
                        <div class="span3 " style="height: 500px;">
                            <div class="detail_plan">
                                <p class="g-txt16" style="color: #000;">กำลังมองหาอะไรเพิ่มเติมใช่ไหม</p>
                                <br />

                                <p class="g-txt16">ดูตัวเลือกสำหรับ :</p>
                                <p class="g-txt16 ">
                                    <a href="https://bit.ly/2tVykCi" class="color-blue-a">ดูตัวเลือกสำหรับองค์กร</a>
                                </p>

                                <br /> <a href="https://bit.ly/2zcp1Tt"><p class="g-txt16 color-blue-a">Microsoft 365 สำหรับธุรกิจคืออะไร</p></a> <br /> <a herf="#">
                                    <p class="g-txt16">
                                        <i class="qode_icon_font_awesome fa fa-comments-o txt18"
                                            style="border: none; vertical-align: baseline !important; width: 15px; color: #2c415e;"></i>&nbsp;&nbsp;สนทนากับฝ่ายขาย
                                    </p></a> <a herf="#"><p class="g-txt16">
                                        <i class="qode_icon_font_awesome fa fa-phone txt18"
                                            style="border: none; vertical-align: baseline !important; width: 15px; color: #2c415e;"></i>&nbsp;&nbsp;02-055-1095
                                    </p></a> <a herf="#"><p class="g-txt16">
                                        <i class="qode_icon_font_awesome fa fa-envelope txt18"
                                            style="border: none; vertical-align: baseline !important; width: 15px; color: #2c415e;"></i>&nbsp;&nbsp;ติดต่อเรา
                                    </p></a>

                            </div>
                        </div>
                        <div class="span3">
                            <!--Microsoft 365 Apps for business Plan 1 -->                      
                            <div class="plan-gs" style="height: 1322px; text-align: center;">
                                <p class="txt-price-small" style="margin-top: 45px;">Microsoft 365 <br>Apps for business<br><span style="font-size: 14px;">(เดิมชื่อ Office 365 Business)</span></p>
                                <p class="color-blue-s txt-price-top" style="margin-top: 150px;">
                                    ฿{price.759.m}</p>
                                <p style="margin-top: -25px; margin-bottom: 25px;">ผู้ใช้/เดือน</p>
                                <p class="txt-price-small" style="font-size: 18px;">(ข้อตกลงแบบรายปี)</p>
                                <select class="plan-office365" id="selectPrice00">
                                    <option value="707">1 ปี ฿{price.707.a} ผู้ใช้/ปี</option>
                                    <option value="759">1เดือน ฿{price.759.m} ผู้ใช้/เดือน</option>
                                </select>
                                <a href='{link.707}' id ='priceOrder00'>
                                    <button class="btn-buy"style="margin-top: 30px; margin-bottom: 10px;" typ="button" onclick="Office365Business00()">
                                        ซื้อทันที
                                    </button>
                                </a>
                                <p
                                    style="margin-top: 5px; margin-bottom: 25px; font-size: 15px;">ราคายังไม่รวมภาษี</p>

                                <hr style="border-top: 2px solid #cccccc;" />
                                <p class="g-txt16"
                                    style="padding: 10px 0 20px 0; font-size: 15px;">
                                    ดีที่สุดสำหรับธุรกิจที่ต้องการแอปพลิเคชัน Office
                                    รวมถึงที่จัดเก็บและการแชร์ไฟล์ในระบบคลาวด์ <br />ไม่รวมอีเมลระดับธุรกิจ
                                <p>

                                    <!-- Title Product Group Microsoft 365 Family 0 -->
                                <p class="txt-titel-pro"
                                    style="text-align: left; margin-bottom: 20px;">รวมแอปพลิเคชั่น
                                    Office</p>

                                <!-- row 0 -->
                                <div class="i-product" style="padding: 10px 33px 10px 0;">
                                    <div class="img-icon bg-Outlook"></div>
                                    <!-- img -->
                                    <br />
                                    <p class="txt-namepro">Outlook</p>
                                </div>

                                <div class="i-product" style="padding: 10px 33px 10px 0;">
                                    <div class="img-icon bg-Word"></div>
                                    <!-- img -->
                                    <br />
                                    <p class="txt-namepro">Word</p>
                                </div>

                                <div class="i-product" style="padding: 10px 0 10px 0;">
                                    <div class="img-icon bg-Excel"></div>
                                    <!-- img -->
                                    <br />
                                    <p class="txt-namepro">Excel</p>
                                </div>


                                <!-- / row 0 -->

                                <!-- row 1 -->
                                <div class="i-product" style="padding: 10px 33px 10px 0;">
                                    <div class="img-icon bg-PowerPoint"></div>
                                    <!-- img -->
                                    <br />
                                    <p class="txt-namepro" style="width: 40px;">PowerPoint</p>
                                </div>

                                <div class="i-product" style="padding: 10px 33px 10px 0;">
                                    <div class="img-icon bg-OneNote"></div>
                                    <!-- img -->
                                    <br />
                                    <p class="txt-namepro">OneNote</p>
                                </div>

                                <div class="i-product" style="padding: 10px 0 10px 0;">
                                    <div class="img-icon bg-Access"></div>
                                    <!-- img -->
                                    <br />
                                    <p class="txt-namepro" style="width: 60px;">Access
                                        (พีซีเท่านั้น)</p>
                                </div>
                                <!-- / row 1 -->

                                <!-- Title Product Group Microsoft 365 Apps for business 1 -->
                                <br />
                                <br />
                                <br />
                                <p class="txt-titel-pro"
                                    style="text-align: left; margin-top: 50px;">รวมบริการ</p>

                                <!-- row 3 -->
                                <div class="i-product" style="padding: 10px 33px 10px 0;">
                                    <div class="img-icon bg-OneDrive"></div>
                                    <!-- img -->
                                    <br />
                                    <p class="txt-namepro">OneDrive</p>
                                </div>

                                <div class="i-product" style="padding: 10px 33px 10px 0;">
                                    <div class="img-icon"></div>
                                    <!-- img -->
                                    <br />
                                    <p class="txt-namepro  "></p>
                                </div>

                                <div class="i-product" style="padding: 10px 0 10px 0;">
                                    <div class="img-icon "></div>
                                    <!-- img -->
                                    <br />
                                    <p class="txt-namepro">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
                                </div>
                                <!-- / row 3 -->

                            </div>
                        </div>

                        <div class="span3">
                            <!-- Microsoft 365 Apps for business Plan 1 -->
                            <div class="promotion gs-tooltip span12">
                                ข้อเสนอพิเศษ: <u>ประหยัดขึ้นกว่าเดิม</u><br />
                                <p style="font-size: 15px;">
                                    ในระยะเวลาจำกัดเท่านั้น <i class="fa fa-info-circle"
                                        aria-hidden="true"></i>
                                </p>
                                <span class="gs-tooltiptext hidden-phone"
                                    style="margin-top: 2px; margin-left: 130px;">ข้อเสนอพิเศษสำหรับการสมัครใช้งานรายปีตั้งแต่วันที่ 7 กรกฎาคม - 30 กันยายน 2563 นี้เท่านั้น</span>
                            </div>
                            <div class="plan-gs" style="height: 1322px; text-align: center;">
                                <p class="txt-price-small" style="margin-top: 40px;">Microsoft 365 Business Standard<br><span style="font-size: 14px;">(เดิมชื่อ Office 365 <br> Business Premium)</span></p>
                                <p class="" style="margin-top: 40px;color: #f50000;">ใช้ Promo Code: CUT20</p>
                                <p style="margin-top: 40px; text-decoration: line-through;">฿420.00 ผู้ใช้/เดือน<p>
                                <p class="color-blue-s txt-price-top" >฿292.00
                                </p>
                                <p style="margin-top: -25px; margin-bottom: 25px;"s>ผู้ใช้/เดือน</p>
                                <p class="txt-price-small" style="font-size: 18px;">(ข้อตกลงแบบรายปี)</p>
                                <select class="plan-office365" id="selectPrice10">
                                    <option value="709">1 ปี ฿3,500.00 ผู้ใช้/ปี</option>
                                    <option value="760">1 เดือน ฿292.00 ผู้ใช้/เดือน</option>
                                </select>
                                
                                <a  id="priceOrder10">
                                    <button class="btn-buy" style="margin-top: 30px; margin-bottom: 10px;" onclick="Office365Business10()">ซื้อทันที</button>
                                </a>
                                <p
                                    style="margin-top: 5px; margin-bottom: 25px; font-size: 15px;">ราคายังไม่รวมภาษี</p>

                                <hr style="border-top: 2px solid #cccccc;" />
                                <p class="g-txt16"
                                    style="padding: 10px 0 36px 0; font-size: 15px;">ดีที่สุดสำหรับธุรกิจที่ต้องการอีเมลระดับธุรกิจ
                                    แอปพลิเคชัน Office และบริการทางธุรกิจอื่นๆ
                                <p>

                                    <!-- Title Product Group Microsoft 365 Apps for business 0 -->
                                <p class="txt-titel-pro"
                                    style="text-align: left; margin-bottom: 20px;">รวมแอปพลิเคชั่น
                                    Office</p>

                                <!-- row 0 -->
                                <div class="i-product" style="padding: 10px 33px 10px 0;">
                                    <div class="img-icon bg-Outlook"></div>
                                    <!-- img -->
                                    <br />
                                    <p class="txt-namepro">Outlook</p>
                                </div>

                                <div class="i-product" style="padding: 10px 33px 10px 0;">
                                    <div class="img-icon bg-Word"></div>
                                    <!-- img -->
                                    <br />
                                    <p class="txt-namepro">Word</p>
                                </div>

                                <div class="i-product" style="padding: 10px 0 10px 0;">
                                    <div class="img-icon bg-Excel"></div>
                                    <!-- img -->
                                    <br />
                                    <p class="txt-namepro">Excel</p>
                                </div>


                                <!-- / row 0 -->

                                <!-- row 1 -->
                                <div class="i-product" style="padding: 10px 33px 10px 0;">
                                    <div class="img-icon bg-PowerPoint"></div>
                                    <!-- img -->
                                    <br />
                                    <p class="txt-namepro" style="width: 40px;">PowerPoint</p>
                                </div>

                                <div class="i-product" style="padding: 10px 33px 10px 0;">
                                    <div class="img-icon bg-OneNote"></div>
                                    <!-- img -->
                                    <br />
                                    <p class="txt-namepro">OneNote</p>
                                </div>

                                <div class="i-product" style="padding: 10px 0 10px 0;">
                                    <div class="img-icon bg-Access"></div>
                                    <!-- img -->
                                    <br />
                                    <p class="txt-namepro" style="width: 60px;">Access
                                        (พีซีเท่านั้น)</p>
                                </div>
                                <!-- / row 1 -->

                                <!-- Title Product Group Microsoft 365 Apps for business 1 -->
                                <br />
                                <br />
                                <br />
                                <p class="txt-titel-pro"
                                    style="text-align: left; margin-top: 50px;">รวมบริการ</p>

                                <!-- row 3 -->
                                <div class="i-product" style="padding: 10px 33px 10px 0;">
                                    <div class="img-icon  bg-Exchange"></div>
                                    <!-- img -->
                                    <br />
                                    <p class="txt-namepro  ">Exchange</p>
                                </div>


                                <div class="i-product" style="padding: 10px 33px 10px 0;">
                                    <div class="img-icon bg-OneDrive"></div>
                                    <!-- img -->
                                    <br />
                                    <p class="txt-namepro">OneDrive</p>
                                </div>

                                <div class="i-product" style="padding: 10px 0 10px 0;">
                                    <div class="img-icon bg-SharePoint"></div>
                                    <!-- img -->
                                    <br />
                                    <p class="txt-namepro  ">SharePoint</p>
                                </div>

                                <div class="i-product" style="padding: 10px 33px 10px 0;">
                                    <div class="img-icon bg-Teams"
                                        title="Microsoft Teams (ภาษาอังกฤษ)"></div>
                                    <!-- img -->
                                    <br />
                                    <p class="txt-namepro" style="width: 60px;">Microsoft Teams
                                    </p>
                                </div>
                                <!-- / row 3 -->

                            </div>
                        </div>


                        <div class="span3">
                            <!-- Microsoft 365 Apps for business Plan 1 -->
                            <div class="promotion gs-tooltip span12">
                                ข้อเสนอพิเศษ: <u>ประหยัดขึ้นกว่าเดิม</u><br />
                                <p style="font-size: 15px;">
                                    ในระยะเวลาจำกัดเท่านั้น <i class="fa fa-info-circle"
                                        aria-hidden="true"></i>
                                </p>
                                <span class="gs-tooltiptext hidden-phone"
                                    style="margin-top: 2px; margin-left: -187px;">ข้อเสนอพิเศษสำหรับการสมัครใช้งานรายปีตั้งแต่วันที่ 7 กรกฎาคม - 30 กันยายน 2563 นี้เท่านั้น</span>
                            </div>
                            <div class="plan-gs" style="height: 1322px; text-align: center;">
                             <p class="txt-price-small" style="margin-top: 45px;">Microsoft 365 Business Basic<br><span style="font-size: 14px;">(เดิมชื่อ Office 365 <br> Business Essentials)</span></p>
                             <p class="" style="margin-top: 40px;color: #f50000;">ใช้ Promo Code: CUT50 </p>
                             <p style="margin-top: 40px; text-decoration: line-through;">฿168.00 ผู้ใช้/เดือน<p>
                                <p class="color-blue-s txt-price-top">฿75.00
                                </p>
                                <p style="margin-top: -25px; margin-bottom: 25px;">ผู้ใช้/เดือน</p>
                                <p class="txt-price-small" style="font-size: 18px;">(ข้อตกลงแบบรายปี)</p>
                                <select class="plan-office365" id="selectPrice20">
                                    <option value="708">1 ปี ฿890.00 ผู้ใช้/ปี</option>
                                    <option value="758">1เดือน ฿75.00 ผู้ใช้/เดือน</option>
                                </select>
                                
                                <a id ='priceOrder20'>
                                    <button class="btn-buy"
                                        style="margin-top: 30px; margin-bottom: 10px;" onclick="Office365Business20()">ซื้อทันที</button>
                                 </a>
                                <p
                                    style="margin-top: 5px; margin-bottom: 25px; font-size: 15px;">ราคายังไม่รวมภาษี</p>

                                <hr style="border-top: 2px solid #cccccc;" />
                                <p class="g-txt16"
                                    style="padding: 10px 0 36px 0; font-size: 15px;">ดีที่สุดสำหรับธุรกิจที่ต้องการอีเมลระดับธุรกิจและบริการทางธุรกิจอื่นๆ
                                    ไม่รวมแอปพลิเคชัน Office
                                <p>

                                    <!-- Title Product Group Microsoft 365 Family  0 -->
                                <p class="txt-titel-pro"
                                    style="text-align: left; margin-bottom: 20px;">รวมแอปพลิเคชั่น
                                    Office</p>
                                <div class="gs-tooltip" style="text-align: left; width: 100%;">
                                    (ไม่รวม) &nbsp;<i class="fa fa-info-circle" aria-hidden="true"></i>
                                    <span class="gs-tooltiptext hidden-phone"
                                        style="margin-top: 2px; margin-left: -155px; padding: 20px 10px 20px 10px;">แผนนี้ใช้งานร่วมกับ
                                        Office, Office 2013 <br />และ Office 2011 for Mac
                                        เวอร์ชันล่าสุด Office เวอร์ชันก่อนหน้า เช่น Office 2010 และ
                                        Office 2007 อาจใช้งานร่วมกับ Microsoft 365
                                        โดยมีฟังก์ชันการทำงานที่ลดลง ความเข้ากันได้กับ Office
                                        นี้ไม่รวมแผน Exchange Online Kiosk หรือ Microsoft 365 F1
                                    </span>
                                </div>

                                <!-- Title Product Group Microsoft 365 Family 1 -->
                                <br />
                                <br />
                                <br />
                                <p class="txt-titel-pro"
                                    style="text-align: left; margin-top: 165px;">รวมบริการ</p>

                                <!-- row 3 -->
                                <div class="i-product" style="padding: 10px 33px 10px 0;">
                                    <div class="img-icon  bg-Exchange"></div>
                                    <!-- img -->
                                    <br />
                                    <p class="txt-namepro  ">Exchange</p>
                                </div>


                                <div class="i-product" style="padding: 10px 33px 10px 0;">
                                    <div class="img-icon bg-OneDrive"></div>
                                    <!-- img -->
                                    <br />
                                    <p class="txt-namepro">OneDrive</p>
                                </div>

                                <div class="i-product" style="padding: 10px 0px 10px 0;">
                                    <div class="img-icon bg-SharePoint"></div>
                                    <!-- img -->
                                    <br />
                                    <p class="txt-namepro  ">SharePoint</p>
                                </div>

                                <div class="i-product" style="padding: 10px 33px 10px 0;">
                                    <div class="img-icon bg-Teams"
                                        title="Microsoft Teams (ภาษาอังกฤษ)"></div>
                                    <!-- img -->
                                    <br />
                                    <p class="txt-namepro" style="width: 60px;">Microsoft Teams
                                    </p>
                                </div>
                                <!-- / row 3 -->

                            </div>
                        </div>



                    </div>
                    <div class="hidden-phone;">
                        <hr style="border-top: 2px solid #E4E4E4; margin-bottom: -1px;" />
                    </div>
                    <div class="row row-gray">
                        <div class="span3">
                            <div class="padding-row-plan ">
                                การโฮสต์อีเมลด้วยกล่องจดหมายขนาด 50 GB
                                และที่อยู่โดเมนอีเมลแบบกำหนดเอง</div>
                        </div>
                        <div class="span3">
                            <div class="padding-row-plan" style="text-align: center;">



                            </div>
                        </div>
                        <div class="span3">
                            <div class="padding-row-plan" style="text-align: center;">

                                <img
                                    src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png"
                                    width="35px" />

                            </div>
                        </div>
                        <div class="span3">
                            <div class="padding-row-plan" style="text-align: center;">
                                <img
                                    src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png"
                                    width="35px" />
                            </div>
                        </div>
                    </div>


                    <div class="row row-white">
                        <div class="span3">
                            <div class="padding-row-plan">
                                แอปพลิเคชัน Office เวอร์ชันล่าสุด ที่เป็นเวอร์ชันบนเดสก์ท็อป: Outlook, Word,
                                Excel, PowerPoint, OneNote <br />(รวมถึง Access และ Publisher
                                สำหรับพีซีเท่านั้น)
                            </div>
                        </div>
                        <div class="span3">
                            <div class="padding-row-plan" style="text-align: center;">

                                <img
                                    src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png"
                                    width="35px" />

                            </div>
                        </div>
                        <div class="span3">
                            <div class="padding-row-plan" style="text-align: center;">

                                <img
                                    src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png"
                                    width="35px" />

                            </div>
                        </div>
                        <div class="span3">
                            <div class="padding-row-plan"></div>
                        </div>
                    </div>


                    <div class="row row-gray">
                        <div class="span3">
                            <div class="padding-row-plan">Word, Excel และ PowerPoint
                                เวอร์ชันบนเว็บ</div>
                        </div>
                        <div class="span3">
                            <div class="padding-row-plan" style="text-align: center;">

                                <img
                                    src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png"
                                    width="35px" />


                            </div>
                        </div>
                        <div class="span3">
                            <div class="padding-row-plan" style="text-align: center;">
                                <img
                                    src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png"
                                    width="35px" />
                                <p>รวมถึง Outlook เวอร์ชันบนเว็บ</p>
                            </div>
                        </div>
                        <div class="span3">
                            <div class="padding-row-plan" style="text-align: center;">
                                <img
                                    src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png"
                                    width="35px" />
                                <p>รวมถึง Outlook เวอร์ชันบนเว็บ</p>
                            </div>
                        </div>
                    </div>

                    <div class="row row-white">
                        <div class="span3">
                            <div class="padding-row-plan gs-tooltip" style="color: #333;">
                                หนึ่งสิทธิ์การใช้งานครอบคลุมโทรศัพท์ 5 เครื่อง แท็บเล็ต 5
                                เครื่อง และพีซีหรือ Mac 5 เครื่องต่อผู้ใช้ &nbsp;<i
                                    class="fa fa-info-circle" aria-hidden="true"></i> <span
                                    class="gs-tooltiptext hidden-phone"
                                    style="margin-top: 20px; padding: 20px 10px 20px 10px;">
                                    เข้าได้กับ Windows 7 หรือใหม่กว่า Office 2016 for Mac ต้องใช้ Mac OS X 10.10 เรียนรู้เกี่ยวกับ 
                                    
                                </span>
                            </div>
                        </div>
                        <div class="span3">
                            <div class="padding-row-plan" style="text-align: center;">

                                <img
                                    src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png"
                                    width="35px" />


                            </div>
                        </div>
                        <div class="span3">
                            <div class="padding-row-plan" style="text-align: center;">

                                <img
                                    src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png"
                                    width="35px" />


                            </div>
                        </div>
                        <div class="span3">
                            <div class="padding-row-plan"></div>
                        </div>
                    </div>


                    <div class="row row-gray">
                        <div class="span3">
                            <div class="padding-row-plan">
                                ที่จัดเก็บไฟล์และการแชร์ไฟล์ด้วยที่เก็บข้อมูลของ OneDrive <br />ขนาด
                                1 TB
                            </div>
                        </div>
                        <div class="span3">
                            <div class="padding-row-plan" style="text-align: center;">

                                <img
                                    src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png"
                                    width="35px" />


                            </div>
                        </div>
                        <div class="span3">
                            <div class="padding-row-plan" style="text-align: center;">

                                <img
                                    src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png"
                                    width="35px" />

                            </div>
                        </div>
                        <div class="span3">
                            <div class="padding-row-plan" style="text-align: center;">
                                <img
                                    src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png"
                                    width="35px" />
                            </div>
                        </div>
                    </div>



                    <div class="row row-white">
                        <div class="span3">
                            <div class="padding-row-plan">
                                อินทราเน็ตทั่วทั้งองค์กรและทีมไซต์ด้วย SharePoint</div>
                        </div>
                        <div class="span3">
                            <div class="padding-row-plan" style="text-align: center;">




                            </div>
                        </div>
                        <div class="span3">
                            <div class="padding-row-plan" style="text-align: center;">

                                <img
                                    src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png"
                                    width="35px" />


                            </div>
                        </div>
                        <div class="span3">
                            <div class="padding-row-plan" style="text-align: center;">
                                <img
                                    src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png"
                                    width="35px" />
                            </div>
                        </div>
                    </div>

                    <div class="row row-gray">
                        <div class="span3">
                            <div class="padding-row-plan gs-tooltip" style="color: #333;">
                                การประชุมแบบวิดีโอและออนไลน์สำหรับผู้คนสูงสุด 250 คน &nbsp;<i
                                    class="fa fa-info-circle" aria-hidden="true"></i> <span
                                    class="gs-tooltiptext hidden-phone"
                                    style="margin-top: 20px; margin-left: 60spx; padding: 20px 10px 20px 10px;">
                                    สำหรับการโทรแบบ HD จำเป็นต้องใช้ฮาร์ดแวร์ HD
                                    ที่เข้ากันได้และการเชื่อมต่อแบบบรอดแบนด์ที่มีความเร็วอย่างน้อย
                                    4 Mbps </span>
                            </div>
                        </div>
                        <div class="span3">
                            <div class="padding-row-plan" style="text-align: center;">

                            </div>
                        </div>
                        <div class="span3">
                            <div class="padding-row-plan" style="text-align: center;">
                                <img
                                    src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png"
                                    width="35px" />
                            </div>
                        </div>
                        <div class="span3" style="text-align: center;">
                            <div class="padding-row-plan">
                                <img
                                    src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png"
                                    width="35px" />
                            </div>
                        </div>
                    </div>

                    <div class="row row-white">
                        <div class="span3">
                            <div class="padding-row-plan gs-tooltip" style="color: #333;">
                                ฮับสำหรับการทำงานเป็นทีมเพื่อเชื่อมต่อทีมของคุณกับ Microsoft
                                Teams &nbsp;<i class="fa fa-info-circle" aria-hidden="true"></i>
                                <span class="gs-tooltiptext hidden-phone"
                                    style="margin-top: 20px; margin-left: 60spx; padding: 20px 10px 20px 10px;">
                                    ขณะนี้ Microsoft Teams
                                    ยังไม่ถูกแปลเป็นภาษาของคุณและยังคงเป็นภาษาอังกฤษ </span>
                            </div>
                        </div>
                        <div class="span3">
                            <div class="padding-row-plan" style="text-align: center;">
                            </div>
                        </div>

                        <div class="span3">
                            <div class="padding-row-plan" style="text-align: center;">

                                <img
                                    src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png"
                                    width="35px" />
                            </div>
                        </div>

                        <div class="span3" style="text-align: center;">
                            <div class="padding-row-plan">
                                <img
                                    src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png"
                                    width="35px" />

                            </div>
                        </div>
                    </div>

                    <div class="row row-white">
                        <div class="span3">
                            <div class="padding-row-plan ">
                                ให้ลูกค้าเข้าถึงและพัฒนาความสัมพันธ์กับลูกค้าด้วย Outlook
                                Customer Manager</div>
                        </div>
                        <div class="span3">
                            <div class="padding-row-plan" style="text-align: center;">
                            </div>
                        </div>

                        <div class="span3">
                            <div class="padding-row-plan" style="text-align: center;">

                                <img
                                    src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png"
                                    width="35px" />
                            </div>
                        </div>

                        <div class="span3" style="text-align: center;">
                            <div class="padding-row-plan"></div>
                        </div>
                    </div>

                    <div class="row row-gray">
                        <div class="span3">
                            <div class="padding-row-plan ">
                                จัดการธุรกิจของคุณได้ดีขึ้นด้วย Microsoft Bookings</div>
                        </div>
                        <div class="span3">
                            <div class="padding-row-plan" style="text-align: center;">
                            </div>
                        </div>

                        <div class="span3">
                            <div class="padding-row-plan" style="text-align: center;">

                                <img
                                    src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png"
                                    width="35px" />
                            </div>
                        </div>

                        <div class="span3" style="text-align: center;">
                            <div class="padding-row-plan"></div>
                        </div>
                    </div>
                    <div class="row row-white">
                        <div class="span3">
                            <div class="padding-row-plan ">
                                จัดการงานและการทำงานเป็นทีมด้วย Microsoft Planner</div>
                        </div>
                        <div class="span3">
                            <div class="padding-row-plan" style="text-align: center;">
                            </div>
                        </div>

                        <div class="span3">
                            <div class="padding-row-plan" style="text-align: center;">

                                <img
                                    src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png"
                                    width="35px" />
                            </div>
                        </div>

                        <div class="span3" style="text-align: center;">
                            <div class="padding-row-plan">
                                <img
                                    src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png"
                                    width="35px" />

                            </div>
                        </div>
                    </div>

                    <div class="row row-gray">
                        <div class="span3">
                            <div class="padding-row-plan ">
                                จัดการกำหนดการและงานประจำวันด้วย Microsoft StaffHub</div>
                        </div>
                        <div class="span3">
                            <div class="padding-row-plan" style="text-align: center;">
                            </div>
                        </div>

                        <div class="span3">
                            <div class="padding-row-plan" style="text-align: center;">

                                <img
                                    src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png"
                                    width="35px" />
                            </div>
                        </div>

                        <div class="span3" style="text-align: center;">
                            <div class="padding-row-plan"></div>
                        </div>
                    </div>

                    <div class="row row-white">
                        <div class="span3">
                            <div class="padding-row-plan ">จำนวนผู้ใช้สูงสุด</div>
                        </div>
                        <div class="span3">
                            <div class="padding-row-plan" style="text-align: center;">
                                300</div>
                        </div>

                        <div class="span3">
                            <div class="padding-row-plan" style="text-align: center;">
                                300</div>
                        </div>

                        <div class="span3" style="text-align: center;">
                            <div class="padding-row-plan">300</div>
                        </div>
                    </div>

                    <div class="row row-gray">
                        <div class="span3">
                            <div class="padding-row-plan ">การสนับสนุนการปรับใช้
                                FastTrack ด้วยการซื้อ 50 สิทธิ์ขึ้นไปโดยไม่มีค่าใช้จ่ายเพิ่มเติม
                            </div>
                        </div>
                        <div class="span3">
                            <div class="padding-row-plan" style="text-align: center;">

                                <img
                                    src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png"
                                    width="35px" />

                            </div>
                        </div>

                        <div class="span3">
                            <div class="padding-row-plan" style="text-align: center;">

                                <img
                                    src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png"
                                    width="35px" />
                            </div>
                        </div>

                        <div class="span3" style="text-align: center;">
                            <div class="padding-row-plan">
                                <img
                                    src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png"
                                    width="35px" />

                            </div>
                        </div>
                    </div>

                    <div class="row row-white">
                        <div class="span3">
                            <div class="padding-row-plan ">
                                การสนับสนุนทางโทรศัพท์และเว็บไซต์ทุกวันตลอด 24 ชั่วโมง</div>
                        </div>
                        <div class="span3">
                            <div class="padding-row-plan" style="text-align: center;">

                                <img
                                    src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png"
                                    width="35px" />

                            </div>
                        </div>

                        <div class="span3">
                            <div class="padding-row-plan" style="text-align: center;">

                                <img
                                    src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png"
                                    width="35px" />
                            </div>
                        </div>

                        <div class="span3" style="text-align: center;">
                            <div class="padding-row-plan">
                                <img
                                    src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png"
                                    width="35px" />

                            </div>
                        </div>
                    </div>

                    <div class="row row-gray">
                        <div class="span3">
                            <div class="padding-row-plan ">
                                ได้รับอนุญาตสำหรับการใช้งานเชิงพาณิชย์</div>
                        </div>
                        <div class="span3">
                            <div class="padding-row-plan" style="text-align: center;">

                                <img
                                    src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png"
                                    width="35px" />

                            </div>
                        </div>

                        <div class="span3">
                            <div class="padding-row-plan" style="text-align: center;">

                                <img
                                    src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png"
                                    width="35px" />
                            </div>
                        </div>

                        <div class="span3" style="text-align: center;">
                            <div class="padding-row-plan">
                                <img
                                    src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png"
                                    width="35px" />

                            </div>
                        </div>
                    </div>
                    <hr
                        style="border-top: 2px solid #E4E4E4; margin-bottom: -25px; margin-top: 0px;">
                    <!-- Start detail_plan -->
                    <div class="row" style="margin-top: 40px; margin-bottom: 70px;">
                        <div class="span3 " style="height: 500px;">
                            <div class="detail_plan"></div>
                        </div>
                        <div class="span3">
                            <!-- Microsoft 365 Apps for business Plan 1 -->
                            <div class="plan-gs" style="height: 775px; text-align: center;">
                                   <p class="txt-price-small">Microsoft 365 <br> Apps for business<br><span style="font-size: 14px;">(เดิมชื่อ Office 365 Business)</span></p>
                                <p class="color-blue-s txt-price-top" style="margin-top:155px;">฿{price.759.m}</p>
                                <p style="margin-top: -25px; margin-bottom: 25px;">ผู้ใช้/เดือน</p>
                                <p class="txt-price-small" style="font-size: 18px;">(ข้อตกลงแบบรายปี)</p>
                                <select class="plan-office365" id="selectPrice01">
                                    <option value="707">1 ปี ฿{price.707.a} ผู้ใช้/ปี</option>
                                    <option value="759">1เดือน ฿{price.759.m} ผู้ใช้/เดือน</option>
                                </select>
                             
                                <a href="{link.759}" id="priceOrder01">
                                    <button class="btn-buy" style="margin-top: 58px; margin-bottom: 10px;" onclick="Office365Business01()">
                                        ซื้อทันที
                                    </button>
                               </a>
                                    <p style="margin-top: 5px; margin-bottom: 25px; font-size: 15px;">ราคายังไม่รวมภาษี</p>

                                    <hr style="border-top: 2px solid #cccccc;" />

                                    <center>
                                        <a href="https://support.netway.co.th/hc/th/requests/new?ticket_form_id=114093963072&request_subject=สนใจทดลองใช้ฟรี Microsoft 365 Apps for business&request_custom_fields_114095596292=sales_opt_office_365"><p class="txt-price-detill"
                                                style="font-size: 18px;">
                                                ทดลองใช้ฟรี <i class="fa fa-chevron-right"
                                                    aria-hidden="true"></i>
                                            </p></a> <br /> <a href="https://netway.co.th/kb/Office%20365%20(Commercial)"><p class="txt-price-detill"
                                                style="font-size: 18px;">
                                                เรียนรู้เพิ่มเติม <i class="fa fa-chevron-right"
                                                    aria-hidden="true"></i>
                                            </p></a>
                                    </center>
                            </div>
                        </div>


                        <div class="span3">
                            <!-- Microsoft 365 Business Standard Plan 2 -->
                            <div class="plan-gs" style="height: 775px; text-align: center;">
                                <p class="txt-price-small">Microsoft 365 Business Standard<br><span style="font-size: 14px;">(เดิมชื่อ Office 365 <br> Business Premium)</span></p>
                              <p class="" style="margin-top: 40px;color: #f50000;">ใช้ Promo Code: CUT20 </p>
                               <p style="text-decoration: line-through;margin-top: 40px;" >฿420.00 ผู้ใช้/เดือน<p>
                                <p class="color-blue-s txt-price-top">฿292.00</p>
                                <p style="margin-top: -25px; margin-bottom: 25px;">ผู้ใช้/เดือน</p>
                                <p class="txt-price-small" style="font-size: 18px;">(ข้อตกลงแบบรายปี)</p>
                                <select class="plan-office365" id ="selectPrice11">
                                    <option value="709">1 ปี ฿3,500.00 ผู้ใช้/เดือน</option>
                                    <option value="760">1เดือน ฿292.00 ผู้ใช้/เดือน</option>
                                </select>
                                
                                <a id="priceOrder11" >
                                    <button class="btn-buy" style="margin-top: 58px; margin-bottom: 10px;" onclick="Office365Business11()"> 
                                        ซื้อทันที
                                    </button>
                                </a>

                                <p style="margin-top: 5px; margin-bottom: 25px; font-size: 15px;">ราคายังไม่รวมภาษี</p>


                                <hr style="border-top: 2px solid #cccccc;" />
                                <center>
                                    <a href="https://support.netway.co.th/hc/th/requests/new?ticket_form_id=114093963072&request_subject=สนใจทดลองใช้ฟรี  Microsoft 365 Business Standard &request_custom_fields_114095596292=sales_opt_office_365"><p class="txt-price-detill"   style="font-size: 18px;">
                                            ทดลองใช้ฟรี <i class="fa fa-chevron-right" aria-hidden="true"></i>
                                        </p></a> <br /> <a href="https://netway.co.th/kb/Office%20365%20(Commercial)"><p class="txt-price-detill"
                                            style="font-size: 18px;">
                                            เรียนรู้เพิ่มเติม <i class="fa fa-chevron-right"
                                                aria-hidden="true"></i>
                                        </p></a>
                                </center>

                            </div>
                        </div>

                        <div class="span3">
                            <!-- Microsoft 365 Business Basic Plan 3 -->
                            <div class="plan-gs" style="height: 775px; text-align: center;">
                                <p class="txt-price-small">Microsoft 365 Business Basic<br><span style="font-size: 14px;">(เดิมชื่อ Office 365 <br> Business Essentials)</span></p>
                                <p class="" style="margin-top:40px;color: #f50000;">ใช้ Promo Code: CUT50</p>
                                <p style="text-decoration: line-through;margin-top: 40px;">฿168.00 ผู้ใช้/เดือน<p>
                                <p class="color-blue-s txt-price-top">฿75.00</p>
                                <p style="margin-top: -25px; margin-bottom: 25px;">ผู้ใช้/เดือน</p>
                                <p class="txt-price-small" style="font-size: 18px;">(ข้อตกลงแบบรายปี)</p>
                                <select class="plan-office365" id="selectPrice21">
                                    <option value="708">1 ปี ฿890.00 ผู้ใช้/ปี</option>
                                    <option value="758">1เดือน ฿75.00 ผู้ใช้/เดือน</option>
                                </select>
                                
                                <a href="{link.758}"  id ='priceOrder21'>
                                    <button class="btn-buy"
                                        style="margin-top: 57px; margin-bottom: 10px;"onclick="Office365Business21()">ซื้อทันที</button></a>
                                <p
                                    style="margin-top: 5px; margin-bottom: 25px; font-size: 15px;">ราคายังไม่รวมภาษี</p>
                                <hr style="border-top: 2px solid #cccccc;" />
                                <center>
                                    <a href="https://netway.co.th/kb/Office%20365%20(Commercial)"><p class="txt-price-detill"
                                            style="font-size: 18px;">
                                            เรียนรู้เพิ่มเติม <i class="fa fa-chevron-right"
                                                aria-hidden="true"></i>
                                        </p></a>
                                </center>


                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


<!-- End Business  -->

    <div class="row">
        <div class="span12">
             <ul class="dynamic-nav  visible-phone  menu-office365" style="background-color: #FFFFFF;">
                <li ><a class="dynamic-nav " href="#Business-Mobile">สำหรับธุรกิจ</a></li>
                 <li ><a class="dynamic-nav " href="#Home-Mobile">สำหรับใช้งานที่บ้าน</a></li>
            </ul>
        </div>
    </div>
    
<div id="Home-Mobile"  style="font-size: 18px;">
  <div class="swiper-container">
    <div class="swiper-wrapper">
    <!--  visible-phone   Microsoft 365 Family -->
  
    <div class="row  visible-phone  swiper-slide">
       <div class="container"> 
                   <div class="span3">
                        <div class="plan-gs " style="height: 550px; text-align: center;">
                            <p class="txt-price-small">Microsoft 365  Family<br><span style="font-size: 14px;">(เดิมชื่อ Office 365 Home)</span></p>
                            <p class="color-blue-s txt-price-top" style="margin-top: 38px;">฿{price.664.a}</p>
                            <p style="margin-top: -25px; margin-bottom: 25px;">(ต่อปี)</p>
                            
                            <a href='{link.664}'><button class="btn-buy"
                                    style="margin-top: 30px; margin-bottom: 10px;">ซื้อทันที</button></a>
                            <a href="https://support.netway.co.th/hc/th/requests/new?ticket_form_id=114093963072&request_subject=สนใจทดลองใช้ฟรี Microsoft 365 Home&request_custom_fields_114095596292=sales_opt_office_365"><button class="btn-try"
                                    style="margin-top: 10px; margin-bottom: 20px;">ทดลองใช้ฟรี</button></a>
         
                                </p></a>
                            <hr style="border-top: 2px solid #cccccc;" />
                            <p class="g-txt16" style="font-size: 15px;">
                                เหมาะที่สุดสำหรับใช้งานในครอบครัว รวมถึงแอปพลิเคชัน Office <br />สำหรับผู้ใช้สูงสุด
                                5 ราย
                            <p>
                        </div>
        
                    </div>
                    <div class="span3 plan-gs " style="height: 600px; margin-top: 5px; margin-bottom: 5px;">
                        <p class="txt-titel-pro"
                            style="text-align: left; margin-bottom: 10px;">รวมแอปพลิเคชั่น
                            Office</p>
                        <table style="text-align: center; width: 100%;">
                            <tr>
                                <th class="moblie365">
                                    <div class="i-product" style="padding: 10px 9px 0 0;">
                                        <div class="img-icon bg-Word"></div>
                                        <!-- img -->
                                        <br />
                                        <p class="txt-namepro">Word</p>
                                    </div>
                                </th>
                                <th class="moblie365">
                                    <div class="i-product" style="padding: 10px 9px 0 0;">
                                        <div class="img-icon bg-Excel"></div>
                                        <!-- img -->
                                        <br />
                                        <p class="txt-namepro">Excel</p>
                                    </div>
                                </th>
                                <th class="moblie365">
                                    <div class="i-product" style="padding: 10px 9px 0 0;">
                                        <div class="img-icon bg-PowerPoint"></div>
                                        <!-- img -->
                                        <br />
                                        <p class="txt-namepro">PowerPoint</p>
                                    </div>
                                </th>
                            
                            </tr>
                            <tr>
                                <th class="moblie365">
                                    <div class="i-product" style="padding: 0 9px 0 0;">
                                        <div class="img-icon bg-OneNote"></div>
                                        <!-- img -->
                                        <br />
                                        <p class="txt-namepro">OneNote  <br/></p>
                                    </div>
                                </th>
                                <th class="moblie365">
                                    <div class="i-product" style="padding: 0 9px 0 0;">
                                        <div class="img-icon bg-Outlook"></div>
                                        <!-- img -->
                                        <br />
                                        <p class="txt-namepro">Outlook <br/></p>
                                    </div>
                                </th>
                                <th class="moblie365">
                                    <div class="i-product" style="padding: 20px 9px 0 0;">
                                        <div class="img-icon bg-Publisher"></div>
                                        <!-- img -->
                                        <br />
                                        <p class="txt-namepro">Publisher <br/> (พีซีเท่านั้น)</p>
                                    </div>
                                </th>
                            
                            </tr>
                              <tr>
                                <th class="moblie365">
                                    <div class="i-product" style="padding: 0 9px 0 0;">
                                        <div class="img-icon bg-Access"></div>
                                        <!-- img -->
                                        <br />
                                        <p class="txt-namepro">Access <br/> (พีซีเท่านั้น)</p>
                                    </div>
                                </th>
                                <th class="moblie365">
                                 
                                </th>
                                <th class="moblie365">
                                  
                                </th>
                            
                            </tr>
                        </table>
                        <p class="txt-titel-pro" style="margin-bottom: 10px; width: 100%;">รวมบริการ
                        </p>
                        <table style="text-align: center;">
                            <tr>
                                <th class="moblie365">
                                    <div class="i-product" style="padding: 10px 9px 10px 0;">
                                        <div class="img-icon bg-OneDrive"></div>
                                        <!-- img -->
                                        <br />
                                        <p class="txt-namepro">OneDrive</p>
                                    </div>
                                </th>
                                <th class="moblie365">
                                    <div class="i-product" style="padding: 10px 9px 10px 0;">
                                        <div class="img-icon bg-Skype"></div>
                                        <!-- img -->
                                        <br />
                                        <p class="txt-namepro">Skype</p>
                                    </div>
                                </th>
                                <th class="moblie365"></th>
                                <th class="moblie365"></th>
                            </tr>
        
                        </table>
        
                    </div>
                    <div class="span3 plan-gs" style="height: 800px; margin-top: 5px; margin-bottom: 5px;">
                        <table class="moblie365"
                            style="width: 100%; font-size: 12px; margin-top: -40px; text-align: left;">
                            <tr class="row-white">
                                <th class="moblie365" style="width: 57%; font-size: 15px;">ฟีเจอร์ของแผน</th>
                                <th class="moblie365" style="font-size: 15px;">Microsoft 365 Home</th>
                            </tr>
                            <tr class="row-gray">
                                <th class="moblie365">แอป Office
                                    แบบพรีเมี่ยมที่ติดตั้งอย่างเต็มรูปแบบพร้อมฟีเจอร์ใหม่พิเศษทุกเดือน
                                    &nbsp;<i class="fa fa-info-circle" aria-hidden="true"></i> <span
                                    class="gs-tooltiptext hidden-phone"> เข้ากันได้กับ Windows
                                        7 หรือใหม่กว่า Office 2016 for Mac ต้องการ Mac OS X 10.10
                                        จำเป็นต้องมีบัญชี Microsoft</span>
                                </th>
                                <th class="moblie365" style="text-align: center;"><img
                                    src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png"
                                    width="24px" /></th>
                            </tr>
                            <tr class="row-white">
                                <th class="moblie365">รวมแอป
                                   &nbsp;<i class="fa fa-info-circle" aria-hidden="true"></i>
                                        <span class="gs-tooltiptext hidden-phone">ความพร้อมใช้งานของแอปและฟีเจอร์แตกต่างกันไปตามอุปกรณ์,
                                            แพลตฟอร์ม, และภาษา</span>
                                
                                </th>
                                <th class="moblie365">Word, Excel, PowerPoint, OneNote,
                                    Outlook, Publisher, Access</th>
                            </tr>
                            <tr class="row-gray">
                                <th class="moblie365">พร้อมใช้</th>
                                <th class="moblie365">พีซี หรือ Mac ได้สูงสุด 5 เครื่อง
                                    แท็บเล้ต 5 เครื่องและโทรศัพท์ 5 เครื่อง</th>
                            </tr>
                            <tr class="row-white">
                                <th class="moblie365">เก็บข้อมูลบนระบบคลาวด์ของ OneDrive ขนาก
                                    1 TB สำหรับผู้ใช้แต่ละราย</th>
                                <th class="moblie365" style="text-align: center;"><img
                                    src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png"
                                    width="24px" /> <br /> สำหรับใช้สูงสุด 5 คน</th>
                            </tr>
                            <tr class="row-gray">
                                <th class="moblie365">ด้วย Skype
                                    โทรไปยังโทรศัพท์มือถือและโทรศัพท์บ้าน 60 นาทีต่อเดือนต่อผู้ใช้
                                    &nbsp;<i class="fa fa-info-circle" aria-hidden="true"></i> <span
                                            class="gs-tooltiptext hidden-phone" style="left: 150px;">จำเป็นต้องใช้บัญชี
                                            Skype ไม่รวมหมายเลขพิเศษ หมายเลขพรีเมียม
                                            หมายเลขที่ไม่สามารถระบุประเทศได้
                                            โทรไปยังโทรศัพท์มือถือสำหรับประเทศที่เลือกเท่านั้น นาที Skype
                                            พร้อมใช้งานในประเทศที่เลือก</span>
                                    </th>
                                <th class="moblie365" style="text-align: center;"><img
                                    src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png"
                                    width="24px" /> <br /> สำหรับใช้สูงสุด 5 คน</th>
                            </tr>
                            <tr class="row-white">
                                <th class="moblie365">การสนับสนุน Microsoft
                                    ผ่านการพูดคุยหรือโทรศัพท์โดยไม่มีค่าใช้จ่ายเพิ่มเติมผ่านการสมัครใช้งานของคุณ</th>
                                <th class="moblie365" style="text-align: center;"><img
                                    src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png"
                                    width="24px" /></th>
                            </tr>
                            <tr class="row-gray">
                                <th class="moblie365">สิทธิ์การใช้งานสำหรับการใช้งานที่บ้าน</th>
                                <th class="moblie365" style="text-align: center;"><img
                                    src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png"
                                    width="24px" /></th>
                            </tr>
                            <tr class="row-white">
                                <th class="moblie365">วิธีสั่งซื้อ
                                &nbsp;<i
                                            class="fa fa-info-circle" aria-hidden="true"></i> <span
                                            class="gs-tooltiptext hidden-phone"
                                            style="left: 10px; top: 78px;">Publisher และ Access
                                            มีพร้อมให้ใช้งานบนพีซีเท่านั้น</span>
                                
                                </th>
                                <th class="moblie365">ซื้อการสมัครสมาชิกแบบรายปีหรือรายเดือน</th>
                            </tr>
        
                        </table>
        
        
                    </div>
                    <div class="span3 plan-gs"style="text-align: center; height: 475px; margin-top: 5px; margin-bottom: 5px;">
                        <p class="txt-price-small">Microsoft 365 Family<br><span style="font-size: 14px;">(เดิมชื่อ Office 365 Home)</span></p>
                        <p class="color-blue-s txt-price-top" style="margin-top: 38px;">฿{price.664.a}</p>
                        <p style="margin-top: -25px; margin-bottom: 25px;">(ต่อปี)</p>  
                        <a href='{link.664}'><button class="btn-buy"
                                style="margin-top: 30px; margin-bottom: 10px;">ซื้อทันที</button></a>
                        <a href="https://support.netway.co.th/hc/
        th/requests/new?ticket_form_id=114093963072&request_subject=สนใจทดลองใช้ฟรี Microsoft 365 Home&request_custom_fields_114095596292=sales_opt_office_365"><button class="btn-try"
                                style="margin-top: 10px; margin-bottom: 20px;">ทดลองใช้ฟรี</button></a>

                            </p></a>
                        <hr style="border-top: 2px solid #cccccc;" />
                        <center>
                            <a href="https://netway.co.th/office-home"><p class="txt-price-detill"
                                    style="font-size: 18px;">
                                    เรียนรู้เพิ่มเติม <i class="fa fa-chevron-right"
                                        aria-hidden="true"></i>
                                </p></a>
                        </center>
                    </div>
                </div>
                
           </div>     
        
     
 <!-- End   visible-phone   Microsoft 365 Home-->

    <!-- Satrt  visible-phone   Microsoft 365 Personal-->
    <div class="row  visible-phone  swiper-slide">
        <div class="container">
            <div class="span3">
                <div class="plan-gs" style="height: 550px; text-align: center;">
                    <p class="txt-price-small" >Microsoft 365 Personal<br><span style="font-size: 14px;">(เดิมชื่อ Office 365 Personal)</span></p>
                    <p class="color-blue-s txt-price-top" style="margin-top: 38px;">฿{price.749.a}</p>
                    <p style="margin-top: -25px; margin-bottom: 25px;">(ต่อปี)</p>
                    <a href='{link.749}'><button class="btn-buy"
                            style="margin-top: 29px; margin-bottom: 8px;">ซื้อทันที</button></a>


                        </p></a>
                    <hr style="border-top: 2px solid #cccccc;" />
                    <p class="g-txt16" style="font-size: 15px;">
                        เหมาะที่สุดสำหรับใช้งานในครอบครัว รวมถึงแอปพลิเคชัน Office <br />สำหรับผู้ใช้สูงสุด
                        1 ราย
                    <p>
                </div>

            </div>
                               <div class="span3 plan-gs " style="height: 600px; margin-top: 5px; margin-bottom: 5px;">
                        <p class="txt-titel-pro"
                            style="text-align: left; margin-bottom: 10px;">รวมแอปพลิเคชั่น
                            Office</p>
                        <table style="text-align: center; width: 100%;">
                            <tr>
                                <th class="moblie365">
                                    <div class="i-product" style="padding: 10px 9px 0 0;">
                                        <div class="img-icon bg-Word"></div>
                                        <!-- img -->
                                        <br />
                                        <p class="txt-namepro">Word</p>
                                    </div>
                                </th>
                                <th class="moblie365">
                                    <div class="i-product" style="padding: 10px 9px 0 0;">
                                        <div class="img-icon bg-Excel"></div>
                                        <!-- img -->
                                        <br />
                                        <p class="txt-namepro">Excel</p>
                                    </div>
                                </th>
                                <th class="moblie365">
                                    <div class="i-product" style="padding: 10px 9px 0 0;">
                                        <div class="img-icon bg-PowerPoint"></div>
                                        <!-- img -->
                                        <br />
                                        <p class="txt-namepro">PowerPoint</p>
                                    </div>
                                </th>
                            
                            </tr>
                            <tr>
                                <th class="moblie365">
                                    <div class="i-product" style="padding: 0 9px 0 0;">
                                        <div class="img-icon bg-OneNote"></div>
                                        <!-- img -->
                                        <br />
                                        <p class="txt-namepro">OneNote  <br/></p>
                                    </div>
                                </th>
                                <th class="moblie365">
                                    <div class="i-product" style="padding: 0 9px 0 0;">
                                        <div class="img-icon bg-Outlook"></div>
                                        <!-- img -->
                                        <br />
                                        <p class="txt-namepro">Outlook <br/></p>
                                    </div>
                                </th>
                                <th class="moblie365">
                                    <div class="i-product" style="padding: 20px 9px 0 0;">
                                        <div class="img-icon bg-Publisher"></div>
                                        <!-- img -->
                                        <br />
                                        <p class="txt-namepro">Publisher <br/> (พีซีเท่านั้น)</p>
                                    </div>
                                </th>
                            
                            </tr>
                              <tr>
                                <th class="moblie365">
                                    <div class="i-product" style="padding: 0 9px 0 0;">
                                        <div class="img-icon bg-Access"></div>
                                        <!-- img -->
                                        <br />
                                        <p class="txt-namepro">Access <br/> (พีซีเท่านั้น)</p>
                                    </div>
                                </th>
                                <th class="moblie365">
                                 
                                </th>
                                <th class="moblie365">
                                  
                                </th>
                            
                            </tr>
                        </table>
                        <p class="txt-titel-pro" style="margin-bottom: 10px; width: 100%;">รวมบริการ
                        </p>
                        <table style="text-align: center;">
                            <tr>
                                <th class="moblie365">
                                    <div class="i-product" style="padding: 10px 9px 10px 0;">
                                        <div class="img-icon bg-OneDrive"></div>
                                        <!-- img -->
                                        <br />
                                        <p class="txt-namepro">OneDrive</p>
                                    </div>
                                </th>
                                <th class="moblie365">
                                    <div class="i-product" style="padding: 10px 9px 10px 0;">
                                        <div class="img-icon bg-Skype"></div>
                                        <!-- img -->
                                        <br />
                                        <p class="txt-namepro">Skype</p>
                                    </div>
                                </th>
                                <th class="moblie365"></th>
                                <th class="moblie365"></th>
                            </tr>
        
                        </table>
        
                    </div>
            <div class="span3 plan-gs"
                style="height: 800px; margin-top: 5px; margin-bottom: 5px;">
                <table class="moblie365"
                    style="width: 100%; font-size: 12px; margin-top: -40px; text-align: left;">
                    <tr class="row-white">
                        <th class="moblie365" style="width: 57%; font-size: 15px;">ฟีเจอร์ของแผน</th>
                        <th class="moblie365" style="font-size: 15px;">Microsoft 365 Personal </th>
                    </tr>
                    <tr class="row-gray">
                        <th class="moblie365">แอป Office
                            แบบพรีเมี่ยมที่ติดตั้งอย่างเต็มรูปแบบพร้อมฟีเจอร์ใหม่พิเศษทุกเดือน
                            &nbsp;<i class="fa fa-info-circle" aria-hidden="true"></i> <span
                            class="gs-tooltiptext hidden-phone"> เข้ากันได้กับ Windows
                                7 หรือใหม่กว่า Office 2016 for Mac ต้องการ Mac OS X 10.10
                                จำเป็นต้องมีบัญชี Microsoft</span>
                        </th>
                        <th class="moblie365" style="text-align: center;"><img
                            src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png"
                            width="24px" /></th>
                    </tr>
                    <tr class="row-white">
                        <th class="moblie365">
                          รวมแอป
                          &nbsp;<i class="fa fa-info-circle" aria-hidden="true"></i>
                                <span class="gs-tooltiptext hidden-phone">ความพร้อมใช้งานของแอปและฟีเจอร์แตกต่างกันไปตามอุปกรณ์,
                                    แพลตฟอร์ม, และภาษา</span>
                        </th>
                        <th class="moblie365">Word, Excel, PowerPoint, OneNote,
                            Outlook, Publisher, Access</th>
                    </tr>
                    <tr class="row-gray">
                        <th class="moblie365">พร้อมใช้</th>
                        <th class="moblie365">พีซี หรือ Mac ได้สูงสุด 1 เครื่อง
                            แท็บเล้ต 1 เครื่องและโทรศัพท์ 1 เครื่อง</th>
                    </tr>
                    <tr class="row-white">
                        <th class="moblie365">เก็บข้อมูลบนระบบคลาวด์ของ OneDrive ขนาก
                            1 TB สำหรับผู้ใช้แต่ละราย</th>
                        <th class="moblie365" style="text-align: center;"><img
                            src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png"
                            width="24px" /> <br /> สำหรับใช้สูงสุด 1 คน</th>
                    </tr>
                    <tr class="row-gray">
                        <th class="moblie365">ด้วย Skype
                            โทรไปยังโทรศัพท์มือถือและโทรศัพท์บ้าน 60 นาทีต่อเดือนต่อผู้ใช้
                            &nbsp;<i class="fa fa-info-circle" aria-hidden="true"></i> <span
                                    class="gs-tooltiptext hidden-phone" style="left: 150px;">จำเป็นต้องใช้บัญชี
                                    Skype ไม่รวมหมายเลขพิเศษ หมายเลขพรีเมียม
                                    หมายเลขที่ไม่สามารถระบุประเทศได้
                                    โทรไปยังโทรศัพท์มือถือสำหรับประเทศที่เลือกเท่านั้น นาที Skype
                                    พร้อมใช้งานในประเทศที่เลือก</span>
                            
                            </th>
                        <th class="moblie365" style="text-align: center;"><img
                            src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png"
                            width="24px" /> <br /> สำหรับใช้สูงสุด 1 คน</th>
                    </tr>
                    <tr class="row-white">
                        <th class="moblie365">การสนับสนุน Microsoft
                            ผ่านการพูดคุยหรือโทรศัพท์โดยไม่มีค่าใช้จ่ายเพิ่มเติมผ่านการสมัครใช้งานของคุณ</th>
                        <th class="moblie365" style="text-align: center;"><img
                            src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png"
                            width="24px" /></th>
                    </tr>
                    <tr class="row-gray">
                        <th class="moblie365">สิทธิ์การใช้งานสำหรับการใช้งานที่บ้าน</th>
                        <th class="moblie365" style="text-align: center;"><img
                            src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png"
                            width="24px" /></th>
                    </tr>
                    <tr class="row-white">
                        <th class="moblie365">วิธีสั่งซื้อ
                          &nbsp;<i
                                    class="fa fa-info-circle" aria-hidden="true"></i> <span
                                    class="gs-tooltiptext hidden-phone"
                                    style="left: 10px; top: 78px;">Publisher และ Access
                                    มีพร้อมให้ใช้งานบนพีซีเท่านั้น</span>
                        </th>
                        <th class="moblie365">
                              ซื้อการสมัครสมาชิกแบบรายปีหรือรายเดือน
                              
                        
                         </th>
                    </tr>

                </table>


            </div>
            <div class="span3 plan-gs"
                style="text-align: center; height: 440px; margin-top: 5px; margin-bottom: 5px;">
                <p class="txt-price-small">Microsoft 365 Personal <br><span style="font-size: 14px;">(เดิมชื่อ Office 365 Personal)</span></p>
                <p class="color-blue-s txt-price-top"  style="margin-top:38px;">฿{price.749.a}</p>
                <p style="margin-top: -25px; margin-bottom: 25px;">(ต่อปี)</p>
                
                <a href='{link.749}'><button class="btn-buy"
                        style="margin-top: 29px; margin-bottom: 10px;">ซื้อทันที</button></a>


                    </p></a>
                <hr style="border-top: 2px solid #cccccc;" />
                <center>
                    <a href="https://netway.co.th/office-personal"><p class="txt-price-detill"
                            style="font-size: 18px;">
                            เรียนรู้เพิ่มเติม <i class="fa fa-chevron-right"
                                aria-hidden="true"></i>
                        </p></a>
                </center>
            </div>
        </div>

    </div>
    <!-- End  visible-phone   Microsoft 365 Personal-->


    <!-- Start  visible-phone   Microsoft 365 Home & Student 2019 for PC-->
    <div class="row  visible-phone  swiper-slide">
        <div class="container">
            <div class="span3">
                <div class="plan-gs" style="height: 550px; text-align: center;">
                    <p class="txt-price-small">Office Home & Student 2019 for PC</p>
                    <p class="color-blue-s txt-price-top" style="margin-top: 65px;">฿{price.776.m}</p>
                    <!--*ไม่มีราคาใน hostbill-->
                    <p style="margin-top: -25px; margin-bottom: 50px;">(การซื้อครั้งเดียว)</p>
                   
                    <a href='{link.776}'><button class="btn-buy"
                            style="margin-top: 2px; margin-bottom: 30px;">ซื้อทันที</button></a>
                    <hr style="border-top: 2px solid #cccccc;" />
                    <p class="g-txt16" style="font-size: 15px;">
                        เหมาะที่สุดสำหรับใช้งานในครอบครัว รวมถึงแอปพลิเคชัน Office
                        <p>  
                   
                   
                   
                   
                   
                </div>
                  
        </div>
        <div class="span3 plan-gs"
                style="height:300px;  margin-top: 5px;   margin-bottom: 5px;">
        <p class="txt-titel-pro"
                    style="text-align: left; margin-bottom: 10px;">รวมแอปพลิเคชั่น Office </p>
        <table style="text-align: center;">
        <tr>
          <th class="moblie365">
           <div class="i-product" style="padding: 10px 9px 10px 0;">
           <div class="img-icon bg-Word"></div>
                                <!-- img -->
           <br />
           <p class="txt-namepro">Word</p>
           </div>
          </th>
          <th class="moblie365">
           <div class="i-product" style="padding: 10px 9px 10px 0;">
           <div class="img-icon bg-Excel"></div>
                                <!-- img -->
           <br />
           <p class="txt-namepro">Excel</p>
           </div>
           </th>
           <th class="moblie365">
           <div class="i-product" style="padding: 10px 9px 10px 0;">
           <div class="img-icon bg-PowerPoint"></div>
                                <!-- img -->
           <br />
           <p class="txt-namepro">PowerPoint</p>
           </div>
       </th>
       <th class="moblie365">
           <div class="i-product" style="padding: 10px 9px 10px 0;">
           <div class="img-icon bg-OneNote"></div>
                                <!-- img -->
           <br />
           <p class="txt-namepro">OneNote</p>
           </div>
       </th>

        </tr>
        
      </table>
      <p class="txt-titel-pro"
                    style=" margin-bottom: 10px; width: 100%;">รวมบริการ </p>
      <table style="text-align: center;">
      <tr>
        <th class="moblie365" style="text-align: center;">(ไม่รวม) </th>
        <th class="moblie365"></th>
        <th class="moblie365"></th>
        <th class="moblie365"></th>
      </tr>
      
       </table>
                   
        </div>
        <div class="span3 plan-gs"
                style="height: 800px; margin-top:5px; margin-bottom:5px;">
         <table class="moblie365"
                    style="width: 100%; font-size:12px; margin-top: -40px; text-align: left;">
         <tr class="row-white">
           <th class="moblie365" style="width: 57%; font-size:15px;">ฟีเจอร์ของแผน</th>
           <th class="moblie365" style="font-size:15px;">Microsoft 365 Prosonal</th>
         </tr>
           <tr class="row-gray">
           <th class="moblie365">แอป Office แบบพรีเมี่ยมที่ติดตั้งอย่างเต็มรูปแบบพร้อมฟีเจอร์ใหม่พิเศษทุกเดือน  
           &nbsp;<i class="fa fa-info-circle" aria-hidden="true"></i>
              <span class="gs-tooltiptext hidden-phone"> เข้ากันได้กับ Windows 7 หรือใหม่กว่า Office 2016 for Mac ต้องการ Mac OS X 10.10 จำเป็นต้องมีบัญชี Microsoft</span>
            
           </th>
           <th class="moblie365" style="text-align:center;">แอปคลาสสิกที่ติดตั้งเต็มรูปแบบ </th>
         </tr>
           <tr class="row-white">
           <th class="moblie365">
               รวมแอป
             &nbsp;<i class="fa fa-info-circle" aria-hidden="true"></i>
                                <span class="gs-tooltiptext hidden-phone">ความพร้อมใช้งานของแอปและฟีเจอร์แตกต่างกันไปตามอุปกรณ์,
                                    แพลตฟอร์ม, และภาษา</span>
           
           </th>
           <th class="moblie365">Word, Excel, PowerPoint, OneNote</th>
         </tr>
           <tr class="row-gray">
           <th class="moblie365">พร้อมใช้</th>
           <th class="moblie365">พีซี  1 เครื่อง </th>
         </tr>
           <tr class="row-white">
           <th class="moblie365">เก็บข้อมูลบนระบบคลาวด์ของ OneDrive ขนาก 1 TB สำหรับผู้ใช้แต่ละราย</th>
           <th class="moblie365" style="text-align:center;"></th>
         </tr>
           <tr class="row-gray">
           <th class="moblie365">
              ด้วย Skype โทรไปยังโทรศัพท์มือถือและโทรศัพท์บ้าน 60 นาทีต่อเดือนต่อผู้ใช้
              &nbsp;<i class="fa fa-info-circle" aria-hidden="true"></i> <span
                                    class="gs-tooltiptext hidden-phone" style="left: 150px;">จำเป็นต้องใช้บัญชี
                                    Skype ไม่รวมหมายเลขพิเศษ หมายเลขพรีเมียม
                                    หมายเลขที่ไม่สามารถระบุประเทศได้
                                    โทรไปยังโทรศัพท์มือถือสำหรับประเทศที่เลือกเท่านั้น นาที Skype
                                    พร้อมใช้งานในประเทศที่เลือก</span>
           
           </th>
           <th class="moblie365" style="text-align:center;"></th>
         </tr>
           <tr class="row-white">
           <th class="moblie365">การสนับสนุน Microsoft ผ่านการพูดคุยหรือโทรศัพท์โดยไม่มีค่าใช้จ่ายเพิ่มเติมผ่านการสมัครใช้งานของคุณ</th>
           <th class="moblie365" style="text-align:center;"></th>
         </tr>
         <tr class="row-gray">
           <th class="moblie365">สิทธิ์การใช้งานสำหรับการใช้งานที่บ้าน</th>
           <th class="moblie365" style="text-align:center;"><img
                            src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png"
                            width="24px" /></th>
         </tr>
         <tr class="row-white">
           <th class="moblie365">วิธีสั่งซื้อ</th>
           <th class="moblie365">การซื้อครั้งเดียว</th>
         </tr>
    
       </table>
        
        
        </div>
        <div class="span3 plan-gs"  style="text-align: center; height: 440px; margin-top:5px; margin-bottom:5px;">
                <p class="txt-price-small">Office Home & Student 2019 for PC</p>
                <p class="color-blue-s txt-price-top" style="margin-top: 40px;">฿{price.776.m}    </p>
                <p style=" margin-top: -25px;    margin-bottom: 30px;">(การซื้อครั้งเดียว)</p>
                
                <a href='{link.776}'><button class="btn-buy"
                        style="margin-top: 5px; margin-bottom: 8px;">ซื้อทันที</button></a>                    
        <hr style="border-top: 2px solid #cccccc;" />       
        <center>
        <a href="#" style="display:none;"><p class="txt-price-detill"
                            style="font-size: 18px;">เรียนรู้เพิ่มเติม  <i
                                class="fa fa-chevron-right" aria-hidden="true"></i>
                        </p></a>
        </center>
        </div>
      </div>
     </div>
     
</div>
<div class="swiper-pagination" style="top: 1%;height:20px;"></div>
    <!-- Add Arrows -->
    <div class="swiper-button-next" style="top: 2%;"></div>
    <div class="swiper-button-prev" style="top: 2%;"></div>
</div>

  <!-- Swiper JS -->
<script src="https://swiperjs.com/package/swiper-bundle.min.js"></script>
<!--End Office Home & Student 2019 for PC  -->

</div>

<div class="row">
        <div class="span12">
             <ul class="dynamic-nav  visible-phone  menu-office365" style="background-color: #FFFFFF;">
                <li><a class="dynamic-nav " href="#Business-Mobile">สำหรับธุรกิจ</a></li>
                <li><a class="dynamic-nav " href="#Home-Mobile">สำหรับใช้งานที่บ้าน</a></li>  
            </ul>
        </div>
    </div>

 <!--  visible-phone  Microsoft 365 Apps for business  -->
 <div id="Business-Mobile" >   
   <div class="swiper-container">
     <div class="swiper-wrapper">
    <!-- Start  visible-phone   Microsoft 365 Personal-->
    <div class="row  visible-phone  swiper-slide">
        <div class="container">
            <div class="span3">
            
                <div class="plan-gs" style="height: 700px; text-align: center;">
                  <p class="txt-price-small" style="padding-top: 79px;padding-bottom: 45px;" >Microsoft 365 <br>Apps for business<br><span style="font-size: 14px;">(เดิมชื่อ Office 365 Business)</span>  </p>
                  <p class="color-blue-s txt-price-top" style="margin-top: 0px;"> ฿{price.759.m}</p>
                          <p style="margin-top: -25px; margin-bottom: 25px;">ผู้ใช้/เดือน</p>
                          <p class="txt-price-small" style="font-size: 18px;">(ข้อตกลงแบบรายปี)</p>
                          <select class="plan-office365" id="selectPricePhone00">
                          <option value="707">1 ปี ฿{price.707.a} ผู้ใช้/ปี</option>
                          <option value="759">1เดือน ฿{price.759.m} ผู้ใช้/เดือน</option>
                         </select>
                    
                    <a href='{link.759}' id="priceOrderPhone00">
                        <button class="btn-buy" style="margin-top: 58px; margin-bottom: 10px;" onclick="BusinessPhone00()">ซื้อทันที</button>
                    </a>
                    <p style="margin-top: 5px; margin-bottom: 25px; font-size: 15px;">ราคายังไม่รวมภาษี</p>
                    <hr style="border-top: 2px solid #cccccc;" />
                    <p class="g-txt16" style="font-size: 15px;">
                        เหมาะที่สุดสำหรับใช้งานในครอบครัว รวมถึงแอปพลิเคชัน Office <br />สำหรับผู้ใช้สูงสุด
                        1 ราย
                    <p>
                </div>

            </div>
            <div class="span3 plan-gs"
                style="height: 480px; margin-top: 5px; margin-bottom: 20px;">
               
            <table style="width:100%">
			      <tr>
			        <th style="text-align: left;"><p class="txt-titel-pro" style="text-align: left;" >รวมแอปพลิเคชั่น Office </p></th>
			      </tr>
			      <tr>
			        <td>
			             <div class="i-product" style="padding: 10px 10px 10px 0;">
                         <div class="img-icon bg-Outlook"></div><!-- img -->
                         <br/>
                         <p class="txt-namepro" style="width: 60px;" >Outlook</p>
                         </div>
			             <div class="i-product" style="padding: 10px 10px 10px 0;">
			             <div class="img-icon bg-Word"></div><!-- img -->
			             <br/>
			             <p class="txt-namepro" style="width: 60px;" >Word</p>
			             </div>
			             <div class="i-product" style="padding: 10px 10px  10px 0;">
			             <div class="img-icon bg-Excel"></div><!-- img -->
			             <br/>
			             <p class="txt-namepro" style="width: 60px;" >Excel</p>
			             </div>
			             <div class="i-product" style="padding: 10px 10px 10px 0;">
			             <div class="img-icon bg-PowerPoint"></div><!-- img -->
			             <br/>
			             <p class="txt-namepro" style="width: 60px;" >PowerPoint</p>
			             </div>
			             <div class="i-product" style="padding: 10px 10px 10px 0;">
			             <div class="img-icon bg-OneNote"></div><!-- img -->
			             <br/>
			             <p class="txt-namepro" style="width: 60px;">OneNote</p>
			             </div>
			           
			             <div class="i-product" style="padding: 10px 10px 10px 0;">
			             <div class="img-icon bg-Access"></div><!-- img -->
			             <br/>
			             <p class="txt-namepro" style="width: 60px;">Access (พีซีเท่านั้น)</p>
			             </div>
			        
			        
			        
			        </td>
			      </tr>
			    </table>
                <p class="txt-titel-pro" style="margin-bottom: 10px; width: 100%;">รวมบริการ
                </p>
                <table style="text-align: center;">
                    <tr>
                        <th class="moblie365">
                            <div class="i-product" style="padding: 10px 9px 10px 0;">
                                <div class="img-icon bg-OneDrive"></div>
                                <!-- img -->
                                <br />
                                <p class="txt-namepro">OneDrive</p>
                            </div>
                        </th>
                        <th class="moblie365"></th>
                        <th class="moblie365"></th>
                        <th class="moblie365"></th>
                    </tr>

                </table>

            </div>
            <div class="span3 plan-gs" style="height: 1100px; margin-top: 5px; margin-bottom: 5px;">
                <table class="moblie365"
                    style="width: 100%; font-size: 8px; text-align: left;">
                    <tr class="row-white">
                        <th class="moblie365" style="width: 80%; font-size: 15px;">ฟีเจอร์ของแผน</th>
                        <th class="moblie365" style="font-size: 15px;">Microsoft 365 Business Basic</th>
                    </tr>
                    <tr class="row-gray">
                        <th class="moblie365">แอป Office
                            การโฮสต์อีเมลด้วยกล่องจดหมายขนาด 50 GB และที่อยู่โดเมนอีเมลแบบกำหนดเอง
                        </th>
                        <th class="moblie365"></th>
                    </tr>
                    <tr class="row-white">
                        <th class="moblie365">
                          แอปพลิเคชัน Office เวอร์ชันล่าสุด ที่เป็นเวอร์ชันบนเดสก์ท็อป: Outlook, Word, Excel, PowerPoint, OneNote (รวมถึง Access และ Publisher สำหรับพีซีเท่านั้น)
                        </th>
                        <th class="moblie365" style="text-align: center;"><img
                            src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png"
                            width="24px" /></th>
                    </tr>
                    <tr class="row-gray">
                        <th class="moblie365">Word, Excel และ PowerPoint เวอร์ชันบนเว็บ</th>
                        <th class="moblie365"style="text-align: center;"><img
                            src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png"
                            width="24px" /></th>
                    </tr>
                    <tr class="row-white">
                        <th class="moblie365">
                           หนึ่งสิทธิ์การใช้งานครอบคลุมโทรศัพท์ 5 เครื่อง แท็บเล็ต 5 เครื่อง และพีซีหรือ Mac 5 เครื่องต่อผู้ใช้ 
                           &nbsp;<i class="fa fa-info-circle" aria-hidden="true"></i> <span
                            class="gs-tooltiptext hidden-phone"> เข้ากันได้กับ Windows
                                7 หรือใหม่กว่า Office 2016 for Mac ต้องการ Mac OS X 10.10
                                จำเป็นต้องมีบัญชี Microsoft</span>
                        
                        </th>
                        <th class="moblie365" style="text-align: center;"><img
                            src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png"
                            width="24px" /></th>
                    </tr>
                    <tr class="row-gray">
                        <th class="moblie365">ที่จัดเก็บไฟล์และการแชร์ไฟล์ด้วยที่เก็บข้อมูลของ OneDrive ขนาด 1 TB
                          </th>
                        <th class="moblie365" style="text-align: center;"><img
                            src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png"
                            width="24px" /></th>
                    </tr>
                    <tr class="row-white">
                        <th class="moblie365">อินทราเน็ตทั่วทั้งองค์กรและทีมไซต์ด้วย SharePoint</th>
                        <th class="moblie365" style="text-align: center;"></th>
                    </tr>
                    <tr class="row-gray">
                        <th class="moblie365">
                           การประชุมแบบวิดีโอและออนไลน์สำหรับผู้คนสูงสุด 250 คน 
                           &nbsp;<i class="fa fa-info-circle" aria-hidden="true"></i> 
                           <span class="gs-tooltiptext hidden-phone"> สำหรับการโทรแบบ HD จำเป็นต้องใช้ฮาร์ดแวร์ HD ที่เข้ากันได้และการเชื่อมต่อแบบบรอดแบนด์ที่มีความเร็วอย่างน้อย 4 Mbps</span>
                        </th>
                        <th class="moblie365" style="text-align: center;"></th>
                    </tr>
                    <tr class="row-white">
                        <th class="moblie365">ฮับสำหรับการทำงานเป็นทีมเพื่อเชื่อมต่อทีมของคุณกับ Microsoft Teams
                        &nbsp;<i class="fa fa-info-circle" aria-hidden="true"></i> 
                           <span class="gs-tooltiptext hidden-phone"> ขณะนี้ Microsoft Teams ยังไม่ถูกแปลเป็นภาษาของคุณและยังคงเป็นภาษาอังกฤษ</span>
                        </th>
                        <th class="moblie365" ></th>
                    </tr>
                     <tr class="row-gray">
                        <th class="moblie365">ให้ลูกค้าเข้าถึงและพัฒนาความสัมพันธ์กับลูกค้าด้วย Outlook Customer Manager </th>
                        <th class="moblie365" ></th>
                    </tr>
                     <tr class="row-white">
                        <th class="moblie365">จัดการธุรกิจของคุณได้ดีขึ้นด้วย Microsoft Bookings</th>
                        <th class="moblie365"></th>
                    </tr>
                     <tr class="row-gray">
                        <th class="moblie365">จัดการงานและการทำงานเป็นทีมด้วย Microsoft Planner </th>
                        <th class="moblie365"></th>
                    </tr>
                     <tr class="row-white">
                        <th class="moblie365">จัดการกำหนดการและงานประจำวันด้วย Microsoft StaffHub</th>
                        <th class="moblie365"></th>
                    </tr>
                     <tr class="row-gray">
                        <th class="moblie365">จำนวนผู้ใช้สูงสุด </th>
                        <th class="moblie365" style="text-align: center;">300</th>
                    </tr>
                    <tr class="row-white">
                        <th class="moblie365">
                         การสนับสนุนการปรับใช้ FastTrack ด้วยการซื้อ 50 สิทธิ์ขึ้นไปโดยไม่มีค่าใช้จ่ายเพิ่มเติม 
                        </th>
                        <th class="moblie365" style="text-align: center;"><img
                            src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png"
                            width="24px" /></th>
                    </tr>
                    <tr class="row-gray">
                        <th class="moblie365">
                         การสนับสนุนทางโทรศัพท์และเว็บไซต์ทุกวันตลอด 24 ชั่วโมง
                        </th>
                        <th class="moblie365" style="text-align: center;"><img
                            src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png"
                            width="24px" /></th>
                    </tr>
                    <tr class="row-white">
                        <th class="moblie365">
                         ได้รับอนุญาตสำหรับการใช้งานเชิงพาณิชย์
                        </th>
                        <th class="moblie365" style="text-align: center;"><img
                            src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png"
                            width="24px" /></th>
                    </tr>
                </table>


            </div>
            <div class="span3 plan-gs" style="text-align: center; height: 650px; margin-top: 5px; margin-bottom: 5px;">
                <p class="txt-price-small">Microsoft 365 <br>Apps for business<br><span style="font-size: 14px;">(เดิมชื่อ Office 365 Business)</span></p>
                <p class="color-blue-s txt-price-top" style="margin-top: 60px;"> ฿{price.759.m}</p>
                          <p style="margin-top: -25px; margin-bottom: 25px;">ผู้ใช้/เดือน</p>
                          <p class="txt-price-small" style="font-size: 18px;">(ข้อตกลงแบบรายปี)</p>
                      <select class="plan-office365" id = "selectPricePhone01" >
                          <option value="707">1 ปี ฿{price.707.a} ผู้ใช้/ปี</option>
                          <option value="759">1เดือน ฿{price.759.m} ผู้ใช้/เดือน</option>
                      </select>
                    
                    <a href='{link.707}' id="priceOrderPhone01">
                        <button class="btn-buy" style="margin-top: 58px; margin-bottom: 10px;" onclick="BusinessPhone01()">ซื้อทันที</button>                  
                    </a>
                    <p style="margin-top: 5px; margin-bottom: 25px; font-size: 15px;">ราคายังไม่รวมภาษี</p>
                    
                <hr style="border-top: 2px solid #cccccc;" />
                <center>
                       <a href="https://support.netway.co.th/hc/
th/requests/new?ticket_form_id=114093963072&request_subject=สนใจทดลองใช้ฟรี ffice 365 Business&request_custom_fields_114095596292=sales_opt_office_365
                       "><p class="txt-price-detill"
                            style="font-size: 18px;">
                            ทดลองใช้ฟรี <i class="fa fa-chevron-right"
                                aria-hidden="true"></i>
                        </p></a>
                    <a href="https://netway.co.th/kb/Office%20365%20(Commercial)"><p class="txt-price-detill"
                            style="font-size: 18px;">
                            เรียนรู้เพิ่มเติม <i class="fa fa-chevron-right"
                                aria-hidden="true"></i>
                        </p></a>
                </center>
            </div>
        </div>

    </div>
    <!-- End  visible-phone   Microsoft 365 Apps for business-->
 
 
 
 
  <!-- Start  visible-phone   Microsoft 365 Business Standard -->
    <div class="row  visible-phone  swiper-slide">
        <div class="container">
            <div class="span3">
                <div class="promotion gs-tooltip span12">
                                ข้อเสนอพิเศษ: <u>ประหยัดขึ้นกว่าเดิม</u><br />
                                <p style="font-size: 15px;">
                                    ในระยะเวลาจำกัดเท่านั้น <i class="fa fa-info-circle"
                                        aria-hidden="true"></i>
                                </p>
                                <span class="gs-tooltiptext hidden-phone"
                                    style="margin-top: 2px; margin-left: 130px;">ข้อเสนอพิเศษสำหรับการสมัครใช้งานแบบรายปีตั้งแต่วันที่ 7 กรกฎาคม - 30 กันยายน 2563 นี้เท่านั้น</span>
                                <!--<span class="gs-tooltiptext hidden-phone"
                                    style="margin-top: 2px; margin-left: 130px;">ข้อเสนอพิเศษในระยะเวลาจำกัดเท่านั้นสำหรับการสมัครใช้งานรายปี</span>-->
                            </div>
                           
                <div class="plan-gs" style="height: 775px; text-align: center;">
                
                  <p class="txt-price-small">Microsoft 365 Business Standard<br><span style="font-size: 14px;">(เดิมชื่อ Office 365 <br> Business Premium)</span></p>
                  <p style="margin-top: 60px; text-decoration: line-through;">฿420.00 ผู้ใช้/เดือน<p> 
                  <p class="color-blue-s txt-price-top" >฿292.00</p>
                  <p style="margin-top: -25px; margin-bottom: 25px;">ผู้ใช้/เดือน</p>
                  <p class="txt-price-small" style="font-size: 18px;">(ข้อตกลงแบบรายปี)</p>
                      <select class="plan-office365" id="selectPricePhone10">
                            <option value="709">1 ปี ฿3,500 ผู้ใช้/ปี</option>
                            <option value="760">1เดือน ฿292.00 ผู้ใช้/เดือน</option>
                      </select>
                  
                  <a  id ="priceOrderPhone10">
                      <button class="btn-buy" style="margin-top: 30px; margin-bottom: 10px;"onclick="BusinessPhone10()">ซื้อทันที</button></a>
                  <p style="margin-top: 5px; margin-bottom: 25px; font-size: 15px;">ราคายังไม่รวมภาษี</p>
                  <hr style="border-top: 2px solid #cccccc;" />
                    <p class="g-txt16" style="font-size: 15px;">
                        เหมาะที่สุดสำหรับใช้งานในครอบครัว รวมถึงแอปพลิเคชัน Office <br />สำหรับผู้ใช้สูงสุด
                        1 ราย
                    <p>
                </div>

            </div>
            <div class="span3 plan-gs" style="height:600px; margin-top: 5px; margin-bottom: 5px;">
              <table style="width:100%">
                  <tr>
                    <th style="text-align: left;"><p class="txt-titel-pro" style="text-align: left;" >รวมแอปพลิเคชั่น Office </p></th>
                  </tr>
                  <tr>
                    <td>
                         <div class="i-product" style="padding: 10px 10px 10px 0;">
                         <div class="img-icon bg-Outlook"></div><!-- img -->
                         <br/>
                         <p class="txt-namepro" style="width: 60px;" >Outlook</p>
                         </div>
                         <div class="i-product" style="padding: 10px 10px 10px 0;">
                         <div class="img-icon bg-Word"></div><!-- img -->
                         <br/>
                         <p class="txt-namepro" style="width: 60px;" >Word</p>
                         </div>
                         <div class="i-product" style="padding: 10px 10px  10px 0;">
                         <div class="img-icon bg-Excel"></div><!-- img -->
                         <br/>
                         <p class="txt-namepro" style="width: 60px;" >Excel</p>
                         </div>
                         <div class="i-product" style="padding: 10px 10px 10px 0;">
                         <div class="img-icon bg-PowerPoint"></div><!-- img -->
                         <br/>
                         <p class="txt-namepro" style="width: 60px;">PowerPoint</p>
                         </div>
                         <div class="i-product" style="padding: 10px 10px 10px 0;">
                         <div class="img-icon bg-OneNote"></div><!-- img -->
                         <br/>
                         <p class="txt-namepro" style="width: 60px;">OneNote</p>
                         </div>
                         <div class="i-product" style="padding: 10px 10px 10px 0;">
                         <div class="img-icon bg-Access"></div><!-- img -->
                         <br/>
                         <p class="txt-namepro" style="width: 60px;">Access (พีซีเท่านั้น)</p>
                         </div>
                    
                    
                    
                    </td>
                  </tr>
                </table>
                <p class="txt-titel-pro" style="margin-bottom: 10px; width: 100%;">รวมบริการ
                </p>
                <table style="text-align: center;">
                    <tr>
                        <th class="moblie365">
                            <div class="i-product" style="padding: 10px 9px 10px 0;">
                                <div class="img-icon bg-Exchange"></div>
                                <!-- img -->
                                <br />
                                <p class="txt-namepro" style="width: 60px;" >Exchange</p>
                            </div>
                        </th>
                        <th class="moblie365">
                         <div class="i-product" style="padding: 10px 9px 10px 0;">
                                <div class="img-icon bg-OneDrive"></div>
                                <!-- img -->
                                <br />
                                <p class="txt-namepro" style="width: 60px;" >OneDrive</p>
                            </div>
                        </th>
                        <th class="moblie365">
                         <div class="i-product" style="padding: 10px 9px 10px 0;">
                                <div class="img-icon bg-SharePoint"></div>
                                <!-- img -->
                                <br />
                                <p class="txt-namepro" style="width: 60px;" >SharePoint</p>
                            </div>
                        
                        </th>
                    </tr>
                        <th class="moblie365">
                         <div class="i-product" style="padding: 10px 9px 10px 0;">
                                <div class="img-icon bg-Teams"></div>
                                <!-- img -->
                                <br />
                                <p class="txt-namepro" style="width: 60px;" >Microsoft Teams</p>
                            </div>
                        </th>
                        <th class="moblie365">        
                           &nbsp;&nbsp; 
                        </th>
                        <th class="moblie365">        
                           &nbsp;&nbsp; 
                        </th>
                    </tr>

                </table>

            </div>
            <div class="span3 plan-gs"
                style="height: 1250px; margin-top: 5px; margin-bottom: 5px;">
                <table class="moblie365"
                    style="width: 100%; font-size: 12px; margin-top: -40px; text-align:left; ">
                    <tr class="row-white">
                        <th class="moblie365" style="width: 57%; font-size: 15px;">ฟีเจอร์ของแผน</th>
                        <th class="moblie365" style="font-size: 15px;">Microsoft 365 Business Basic</th>
                    </tr>
                    <tr class="row-gray">
                        <th class="moblie365">แอป Office
                            การโฮสต์อีเมลด้วยกล่องจดหมายขนาด 50 GB และที่อยู่โดเมนอีเมลแบบกำหนดเอง
                        </th>
                        <th class="moblie365" style="text-align: center;"><img
                            src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png"
                            width="24px" /></th>
                    </tr>
                    <tr class="row-white">
                        <th class="moblie365">
                          แอปพลิเคชัน Office เวอร์ชันล่าสุด ที่เป็นเวอร์ชันบนเดสก์ท็อป: Outlook, Word, Excel, PowerPoint, OneNote (รวมถึง Access และ Publisher สำหรับพีซีเท่านั้น)
                        </th>
                        <th class="moblie365" style="text-align: center;"><img
                            src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png"
                            width="24px" /></th>
                    </tr>
                    <tr class="row-gray">
                        <th class="moblie365">Word, Excel และ PowerPoint เวอร์ชันบนเว็บ</th>
                        <th class="moblie365"style="text-align: center;"><img
                            src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png"
                            width="24px" />
                            <br/>
                            รวมถึง Outlook เวอร์ชันบนเว็บ
                            </th>
                    </tr>
                    <tr class="row-white">
                        <th class="moblie365">
                           หนึ่งสิทธิ์การใช้งานครอบคลุมโทรศัพท์ 5 เครื่อง แท็บเล็ต 5 เครื่อง และพีซีหรือ Mac 5 เครื่องต่อผู้ใช้ 
                           &nbsp;<i class="fa fa-info-circle" aria-hidden="true"></i> <span
                            class="gs-tooltiptext hidden-phone"> เข้ากันได้กับ Windows
                                7 หรือใหม่กว่า Office 2016 for Mac ต้องการ Mac OS X 10.10
                                จำเป็นต้องมีบัญชี Microsoft</span>
                        
                        </th>
                        <th class="moblie365" style="text-align: center;"><img
                            src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png"
                            width="24px" /></th>
                    </tr>
                    <tr class="row-gray">
                        <th class="moblie365">ที่จัดเก็บไฟล์และการแชร์ไฟล์ด้วยที่เก็บข้อมูลของ OneDrive ขนาด 1 TB
                          </th>
                        <th class="moblie365" style="text-align: center;"><img
                            src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png"
                            width="24px" /></th>
                    </tr>
                    <tr class="row-white">
                        <th class="moblie365">อินทราเน็ตทั่วทั้งองค์กรและทีมไซต์ด้วย SharePoint</th>
                        <th class="moblie365" style="text-align: center;"></th>
                    </tr>
                    <tr class="row-gray">
                        <th class="moblie365">
                           การประชุมแบบวิดีโอและออนไลน์สำหรับผู้คนสูงสุด 250 คน 
                           &nbsp;<i class="fa fa-info-circle" aria-hidden="true"></i> 
                           <span class="gs-tooltiptext hidden-phone"> สำหรับการโทรแบบ HD จำเป็นต้องใช้ฮาร์ดแวร์ HD ที่เข้ากันได้และการเชื่อมต่อแบบบรอดแบนด์ที่มีความเร็วอย่างน้อย 4 Mbps</span>
                        </th>
                        <th class="moblie365" style="text-align: center;"></th>
                    </tr>
                    <tr class="row-white">
                        <th class="moblie365">ฮับสำหรับการทำงานเป็นทีมเพื่อเชื่อมต่อทีมของคุณกับ Microsoft Teams
                        &nbsp;<i class="fa fa-info-circle" aria-hidden="true"></i> 
                           <span class="gs-tooltiptext hidden-phone"> ขณะนี้ Microsoft Teams ยังไม่ถูกแปลเป็นภาษาของคุณและยังคงเป็นภาษาอังกฤษ</span>
                        </th>
                        <th class="moblie365" ></th>
                    </tr>
                     <tr class="row-gray">
                        <th class="moblie365">ให้ลูกค้าเข้าถึงและพัฒนาความสัมพันธ์กับลูกค้าด้วย Outlook Customer Manager </th>
                        <th class="moblie365" style="text-align: center;"><img
                            src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png"
                            width="24px" /></th>
                    </tr>
                     <tr class="row-white">
                        <th class="moblie365">จัดการธุรกิจของคุณได้ดีขึ้นด้วย Microsoft Bookings</th>
                        <th class="moblie365" style="text-align: center;"><img
                            src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png"
                            width="24px" /></th>
                    </tr>
                     <tr class="row-gray">
                        <th class="moblie365">จัดการงานและการทำงานเป็นทีมด้วย Microsoft Planner </th>
                        <th class="moblie365" style="text-align: center;"><img
                            src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png"
                            width="24px" /></th>
                    </tr>
                     <tr class="row-white">
                        <th class="moblie365">จัดการกำหนดการและงานประจำวันด้วย Microsoft StaffHub</th>
                        <th class="moblie365" style="text-align: center;"><img
                            src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png"
                            width="24px" /></th>
                    </tr>
                     <tr class="row-gray">
                        <th class="moblie365">จำนวนผู้ใช้สูงสุด </th>
                        <th class="moblie365" style="text-align: center;">300</th>
                    </tr>
                    <tr class="row-white">
                        <th class="moblie365">
                         การสนับสนุนการปรับใช้ FastTrack ด้วยการซื้อ 50 สิทธิ์ขึ้นไปโดยไม่มีค่าใช้จ่ายเพิ่มเติม 
                        </th>
                        <th class="moblie365" style="text-align: center;"><img
                            src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png"
                            width="24px" /></th>
                    </tr>
                    <tr class="row-gray">
                        <th class="moblie365">
                         การสนับสนุนทางโทรศัพท์และเว็บไซต์ทุกวันตลอด 24 ชั่วโมง
                        </th>
                        <th class="moblie365" style="text-align: center;"><img
                            src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png"
                            width="24px" /></th>
                    </tr>
                    <tr class="row-white">
                        <th class="moblie365">
                         ได้รับอนุญาตสำหรับการใช้งานเชิงพาณิชย์
                        </th>
                        <th class="moblie365" style="text-align: center;"><img
                            src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png"
                            width="24px" /></th>
                    </tr>
                </table>


            </div>
            <div class="span3 plan-gs" style="text-align: center; height: 650px; margin-top: 5px; margin-bottom: 5px;">
                <p class="txt-price-small">Microsoft 365 Business Standard<br><span style="font-size: 14px;">(เดิมชื่อ Office 365 <br> Business Premium)</span></p> 
                <p class="" style="margin-top: 40px;color: #f50000;">ใช้ Promo Code:CUT20 </p>
                <p style="text-decoration: line-through;">฿420.00 ผู้ใช้/เดือน<p>
                <p class="color-blue-s txt-price-top" >฿292.00
                                </p>
                                <p style="margin-top: -25px; margin-bottom: 25px;">ผู้ใช้/เดือน</p>
                                <p class="txt-price-small" style="font-size: 18px;">(ข้อตกลงแบบรายปี)</p>
                                <select class="plan-office365" id="selectPricePhone11">
                                    <option value="709">1 ปี ฿3,500.00 ผู้ใช้/ปี</option>
                                    <option value="760">1เดือน ฿292.00 ผู้ใช้/เดือน</option>
                                </select>
                                <a href="{link.760}" id="priceOrderPhone11">
                                    <button class="btn-buy" style="margin-top: 30px; margin-bottom: 10px;" onclick="BusinessPhone11()">ซื้อทันที</button>
                                </a>
                                <p
                                    style="margin-top: 5px; margin-bottom: 25px; font-size: 15px;">ราคายังไม่รวมภาษี</p>
                    
                <hr style="border-top: 2px solid #cccccc;" />
                <center>
                       <a href="#"><p class="txt-price-detill"
                            style="font-size: 18px;">
                            ทดลองใช้ฟรี <i class="fa fa-chevron-right"
                                aria-hidden="true"></i>
                        </p></a>
                    <a href="#"><p class="txt-price-detill"
                            style="font-size: 18px;">
                            เรียนรู้เพิ่มเติม <i class="fa fa-chevron-right"
                                aria-hidden="true"></i>
                        </p></a>
                </center>
            </div>
        </div>

    </div>
    <!-- End  visible-phone  Microsoft 365 Business Standard-->
    
    
    

      <!-- Start  visible-phone  Microsoft 365 Business Basic -->
        <div class="row  visible-phone  swiper-slide ">
            <div class="container">
                 <div class="span3">
                    <div class="promotion gs-tooltip span12">
                                ข้อเสนอพิเศษ: <u>ประหยัดขึ้นกว่าเดิม</u><br />
                                <p style="font-size: 15px;">
                                    ในระยะเวลาจำกัดเท่านั้น <i class="fa fa-info-circle"
                                        aria-hidden="true"></i>
                                </p>
                                <span class="gs-tooltiptext hidden-phone"
                                    style="margin-top: 2px; margin-left: -187px;">ข้อเสนอพิเศษสำหรับการสมัครใช้งานแบบรายปีตั้งแต่วันที่ 7 กรกฎาคม - 30 กันยายน 2563 นี้เท่านั้น</span>
                    </div>
                    <div class="plan-gs" style="height: 775px; text-align: center;">
                    <p class="txt-price-small">Microsoft 365 Business Basic<br><span style="font-size: 14px;">(เดิมชื่อ Office 365 <br> Business Essentials)</span></p>
                    <p class="" style="margin-top: 40px;color: #f50000;">ใช้ Promo Code: CUT50 </p>
                    <p style="margin-top: 60px; text-decoration: line-through;">฿168.00 ผู้ใช้/เดือน<p>
                      <p class="color-blue-s txt-price-top" >฿75.00 </p>
                      <p style="margin-top: -25px; margin-bottom: 25px;">ผู้ใช้/เดือน</p>
                      <p class="txt-price-small" style="font-size: 18px;">(ข้อตกลงแบบรายปี)</p>
                          <select class="plan-office365" id="selectPricePhone20">
                                <option value="708">1 ปี ฿890.00 ผู้ใช้/ปี</option>
                                <option value="758">1เดือน ฿75.00 ผู้ใช้/เดือน</option>
                          </select>
                      
                      <a id="priceOrderPhone20">
                          <button class="btn-buy" style="margin-top: 30px; margin-bottom: 10px;" onclick="BusinessPhone20()">ซื้อทันที</button>
                      </a>
                      <p style="margin-top: 5px; margin-bottom: 25px; font-size: 15px;">ราคายังไม่รวมภาษี</p>
                      <hr style="border-top: 2px solid #cccccc;" />
                        <p class="g-txt16" style="font-size: 15px;">
                            เหมาะที่สุดสำหรับใช้งานในครอบครัว รวมถึงแอปพลิเคชัน Office <br />สำหรับผู้ใช้สูงสุด
                            1 ราย
                        <p>
                    </div>

                </div>
                <div class="span3 plan-gs"
                    style="height: 684px; margin-top: 5px; margin-bottom: 5px;">
                  
                   
                    
                                    <!-- Title Product Group Microsoft 365 Home 0 -->
                                <p class="txt-titel-pro"
                                    style="text-align: left; margin-bottom: 20px;">รวมแอปพลิเคชั่น
                                    Office</p>
                                <div class="gs-tooltip" style="text-align: left; width: 100%;">
                                    (ไม่รวม)
                                    <br/>
                                    <br/>
                                    
                             
                                    
                                </div>

                                <!-- Title Product Group Microsoft 365 Home 1 -->
                                <br />
          
                                <p class="txt-titel-pro"
                                    style="text-align: left; margin-top: 20px;">รวมบริการ</p>

                                <!-- row 3 -->
                                <div class="i-product" style="padding: 10px 33px 10px 0;">
                                    <div class="img-icon  bg-Exchange"></div>
                                    <!-- img -->
                                    <br />
                                    <p class="txt-namepro  ">Exchange</p>
                                </div>


                                <div class="i-product" style="padding: 10px 33px 10px 0;">
                                    <div class="img-icon bg-OneDrive"></div>
                                    <!-- img -->
                                    <br />
                                    <p class="txt-namepro">OneDrive</p>
                                </div>

                                <div class="i-product" style="padding: 10px 0px 10px 0;">
                                    <div class="img-icon bg-SharePoint"></div>
                                    <!-- img -->
                                    <br />
                                    <p class="txt-namepro  ">SharePoint</p>
                                </div>
                                <div class="i-product" style="padding: 10px 33px 10px 0;">
                                    <div class="img-icon bg-Teams"
                                        title="Microsoft Teams (ภาษาอังกฤษ)"></div>
                                    <!-- img -->
                                    <br />
                                    <p class="txt-namepro" style="width: 60px;">Microsoft Teams
                                    </p>
                                </div>
                                <!-- / row 3 -->
                 </div>
                 <div class="span3 plan-gs" style="height: 900px; margin-top: 5px; margin-bottom: 5px;">
                    <table class="moblie365"
                        style="width: 100%; font-size: 12px; margin-top: -40px; text-align: left;">
                        <tr class="row-white">
                            <th class="moblie365" style="width: 57%; font-size: 15px;">ฟีเจอร์ของแผน</th>
                            <th class="moblie365" style="font-size: 15px;">Microsoft 365 Apps for business</th>
                        </tr>
                        <tr class="row-gray">
                            <th class="moblie365">แอป Office
                                การโฮสต์อีเมลด้วยกล่องจดหมายขนาด 50 GB และที่อยู่โดเมนอีเมลแบบกำหนดเอง
                            </th>
                            <th class="moblie365" style="text-align: center;"><img
                                src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png"
                                width="24px" /></th>
                        </tr>
                        <tr class="row-white">
                            <th class="moblie365">
                              แอปพลิเคชัน Office เวอร์ชันล่าสุด ที่เป็นเวอร์ชันบนเดสก์ท็อป: Outlook, Word, Excel, PowerPoint, OneNote (รวมถึง Access และ Publisher สำหรับพีซีเท่านั้น)
                            </th>
                            <th class="moblie365" style="text-align: center;"><img
                                src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png"
                                width="24px" /></th>
                        </tr>
                        <tr class="row-gray">
                            <th class="moblie365">Word, Excel และ PowerPoint เวอร์ชันบนเว็บ</th>
                            <th class="moblie365"style="text-align: center;"><img
                                src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png"
                                width="24px" />
                                <br/>
                                รวมถึง Outlook เวอร์ชันบนเว็บ
                                </th>
                        </tr>
                        <tr class="row-white">
                            <th class="moblie365">
                               หนึ่งสิทธิ์การใช้งานครอบคลุมโทรศัพท์ 5 เครื่อง แท็บเล็ต 5 เครื่อง และพีซีหรือ Mac 5 เครื่องต่อผู้ใช้ 
                               &nbsp;<i class="fa fa-info-circle" aria-hidden="true"></i> <span
                                class="gs-tooltiptext hidden-phone"> เข้ากันได้กับ Windows
                                    7 หรือใหม่กว่า Office 2016 for Mac ต้องการ Mac OS X 10.10
                                    จำเป็นต้องมีบัญชี Microsoft</span>
                            
                            </th>
                            <th class="moblie365" style="text-align: center;"><img
                                src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png"
                                width="24px" /></th>
                        </tr>
                        <tr class="row-gray">
                            <th class="moblie365">ที่จัดเก็บไฟล์และการแชร์ไฟล์ด้วยที่เก็บข้อมูลของ OneDrive ขนาด 1 TB
                              </th>
                            <th class="moblie365" style="text-align: center;"><img
                                src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png"
                                width="24px" /></th>
                        </tr>
                        <tr class="row-white">
                            <th class="moblie365">อินทราเน็ตทั่วทั้งองค์กรและทีมไซต์ด้วย SharePoint</th>
                            <th class="moblie365" style="text-align: center;"></th>
                        </tr>
                        <tr class="row-gray">
                            <th class="moblie365">
                               การประชุมแบบวิดีโอและออนไลน์สำหรับผู้คนสูงสุด 250 คน 
                               &nbsp;<i class="fa fa-info-circle" aria-hidden="true"></i> 
                               <span class="gs-tooltiptext hidden-phone"> สำหรับการโทรแบบ HD จำเป็นต้องใช้ฮาร์ดแวร์ HD ที่เข้ากันได้และการเชื่อมต่อแบบบรอดแบนด์ที่มีความเร็วอย่างน้อย 4 Mbps</span>
                            </th>
                            <th class="moblie365" style="text-align: center;"></th>
                        </tr>
                        <tr class="row-white">
                            <th class="moblie365">ฮับสำหรับการทำงานเป็นทีมเพื่อเชื่อมต่อทีมของคุณกับ Microsoft Teams
                            &nbsp;<i class="fa fa-info-circle" aria-hidden="true"></i> 
                               <span class="gs-tooltiptext hidden-phone"> ขณะนี้ Microsoft Teams ยังไม่ถูกแปลเป็นภาษาของคุณและยังคงเป็นภาษาอังกฤษ</span>
                            </th>
                            <th class="moblie365" ></th>
                        </tr>
                         <tr class="row-gray">
                            <th class="moblie365">ให้ลูกค้าเข้าถึงและพัฒนาความสัมพันธ์กับลูกค้าด้วย Outlook Customer Manager </th>
                            <th class="moblie365" style="text-align: center;"><img
                                src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png"
                                width="24px" /></th>
                        </tr>
                         <tr class="row-white">
                            <th class="moblie365">จัดการธุรกิจของคุณได้ดีขึ้นด้วย Microsoft Bookings</th>
                            <th class="moblie365" style="text-align: center;"><img
                                src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png"
                                width="24px" /></th>
                        </tr>
                         <tr class="row-gray">
                            <th class="moblie365">จัดการงานและการทำงานเป็นทีมด้วย Microsoft Planner </th>
                            <th class="moblie365" style="text-align: center;"><img
                                src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png"
                                width="24px" /></th>
                        </tr>
                         <tr class="row-white">
                            <th class="moblie365">จัดการกำหนดการและงานประจำวันด้วย Microsoft StaffHub</th>
                            <th class="moblie365" style="text-align: center;"><img
                                src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png"
                                width="24px" /></th>
                        </tr>
                         <tr class="row-gray">
                            <th class="moblie365">จำนวนผู้ใช้สูงสุด </th>
                            <th class="moblie365" style="text-align: center;">300</th>
                        </tr>
                        <tr class="row-white">
                            <th class="moblie365">
                             การสนับสนุนการปรับใช้ FastTrack ด้วยการซื้อ 50 สิทธิ์ขึ้นไปโดยไม่มีค่าใช้จ่ายเพิ่มเติม 
                            </th>
                            <th class="moblie365" style="text-align: center;"><img
                                src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png"
                                width="24px" /></th>
                        </tr>
                        <tr class="row-gray">
                            <th class="moblie365">
                             การสนับสนุนทางโทรศัพท์และเว็บไซต์ทุกวันตลอด 24 ชั่วโมง
                            </th>
                            <th class="moblie365" style="text-align: center;"><img
                                src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png"
                                width="24px" /></th>
                        </tr>
                        <tr class="row-white">
                            <th class="moblie365">
                             ได้รับอนุญาตสำหรับการใช้งานเชิงพาณิชย์
                            </th>
                            <th class="moblie365" style="text-align: center;"><img
                                src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png"
                                width="24px" /></th>
                        </tr>
                    </table>

                </div>
                 <div class="span3 plan-gs" style="text-align: center; height: 650px; margin-top: 5px; margin-bottom: 5px;">
                   <p class="txt-price-small">Microsoft 365 Business Basic<br><span style="font-size: 14px;">(เดิมชื่อ Office 365 <br> Business Essentials)</span></p>
                   <p class="" style="margin-top: 40px;color: #f50000;">ใช้ Promo Code: CUT50</p>
                   <p style="text-decoration: line-through;">฿168.00 ผู้ใช้/เดือน<p>
                    <p class="color-blue-s txt-price-top" style=" margin-top: 38px;">฿75.00
                                </p>
                                <p style="margin-top: -25px; margin-bottom: 25px;">ผู้ใช้/เดือน</p>
                                <p class="txt-price-small" style="font-size: 18px;">(ข้อตกลงแบบรายปี)</p>
                                <select class="plan-office365" id="selectPricePhone21">
                                    <option value="708">1 ปี ฿890.00 ผู้ใช้/ปี</option>
                                    <option value="758">1เดือน ฿75.00 ผู้ใช้/เดือน</option>
                                </select>

                                <a href="{link.758}" id ="priceOrderPhone21">
                                    <button class="btn-buy" style="margin-top: 30px; margin-bottom: 10px;"onclick="BusinessPhone21()">ซื้อทันที</button>
                                </a>
                                <p
                                    style="margin-top: 5px; margin-bottom: 25px; font-size: 15px;">ราคายังไม่รวมภาษี</p>
                    
                    <hr style="border-top: 2px solid #cccccc;" />
                    <center>
            
                        <a href="https://netway.co.th/kb/Office%20365%20(Commercial)"><p class="txt-price-detill"
                                style="font-size: 18px;">
                                เรียนรู้เพิ่มเติม <i class="fa fa-chevron-right"
                                    aria-hidden="true"></i>
                            </p></a>
                    </center>
              </div>
           </div>

        </div>
    <!-- End  visible-phone  Microsoft 365 Business Basic-->
       </div>
         <div class="swiper-pagination" id ='pagination1'style="top: 3%; height: 20px"></div>
    <!-- Add Arrows -->
    <div class="swiper-button-next"  style="top: 3%;"></div>
    <div class="swiper-button-prev"  style="top: 3%;"></div>
     </div>
     <script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
  </div>
  
   <!-- End 
   Business-->

<script>
    function Office365Business00() {
        var optionValue = document.getElementById("selectPrice00").value;
        if(optionValue =='707'){
             document.getElementById("priceOrder00").setAttribute("href","https://netway.co.th/?cmd=cart&action=add&id=707");
        }else if(optionValue =='759'){
            document.getElementById("priceOrder00").setAttribute("href","https://netway.co.th/?cmd=cart&action=add&id=759");
        }else {
            document.getElementById("priceOrder00").setAttribute("href","https://netway.co.th/?cmd=cart&action=add&id=707");
        }
    }
  
    function Office365Business01() {
        var optionValue = document.getElementById("selectPrice01").value;
        if(optionValue =='759'){
             document.getElementById("priceOrder01").setAttribute("href","https://netway.co.th/?cmd=cart&action=add&id=759");
        }else if(optionValue =='707'){
             document.getElementById("priceOrder01").setAttribute("href","https://netway.co.th/?cmd=cart&action=add&id=707");
        }else {
             document.getElementById("priceOrder01").setAttribute("href","https://netway.co.th/?cmd=cart&action=add&id=759");
        }
    }   
    
    
     function Office365Business20() {
        var optionValue = document.getElementById("selectPrice20").value;
        if(optionValue =='708'){
            document.getElementById("priceOrder20").setAttribute("href","https://netway.co.th/?cmd=cart&action=add&id=708&addcoupon=true&promocode=CUT50");
        }else if(optionValue =='758'){
            document.getElementById("priceOrder20").setAttribute("href","https://netway.co.th/?cmd=cart&action=add&id=758");
        }else {
            document.getElementById("priceOrder20").setAttribute("href","https://netway.co.th/?cmd=cart&action=add&id=708&addcoupon=true&promocode=CUT50");
         }
    }   
    
  
    
    function Office365Business10() {
        var optionValue = document.getElementById("selectPrice10").value;
        if(optionValue =='709'){
            document.getElementById("priceOrder10").setAttribute("href","https://netway.co.th/?cmd=cart&action=add&id=709&addcoupon=true&promocode=CUT20");
        }else if(optionValue =='760'){
            document.getElementById("priceOrder10").setAttribute("href","https://netway.co.th/?cmd=cart&action=add&id=760");
        }else {
            document.getElementById("priceOrder10").setAttribute("href","https://netway.co.th/?cmd=cart&action=add&id=709&addcoupon=true&promocode=CUT20");
        }
    }   
     
    
     function Office365Business11() {
        var optionValue = document.getElementById("selectPrice11").value;
        if(optionValue =='709'){
             document.getElementById("priceOrder11").setAttribute("href","https://netway.co.th/?cmd=cart&action=add&id=709&addcoupon=true&promocode=CUT20");
        }else if(optionValue =='760'){
            document.getElementById("priceOrder11").setAttribute("href","https://netway.co.th/?cmd=cart&action=add&id=760");
        }else {
            document.getElementById("priceOrder11").setAttribute("href","https://netway.co.th/?cmd=cart&action=add&id=709&addcoupon=true&promocode=CUT20");
         }
    }   
   
   function Office365Business21() {
        var optionValue = document.getElementById("selectPrice21").value;
        if(optionValue =='708'){
           document.getElementById("priceOrder21").setAttribute("href","https://netway.co.th/?cmd=cart&action=add&id=708&addcoupon=true&promocode=CUT50");
        }else if(optionValue =='758'){
          document.getElementById("priceOrder21").setAttribute("href","https://netway.co.th/?cmd=cart&action=add&id=758");
        }else {
             document.getElementById("priceOrder21").setAttribute("href","https://netway.co.th/?cmd=cart&action=add&id=708&addcoupon=true&promocode=CUT50");
         }
    }   
    
    // Visible-Phone
    
    function BusinessPhone00(){
        var optionValue = document.getElementById("selectPricePhone00").value;
        if(optionValue =='707'){
            document.getElementById("priceOrderPhone00").setAttribute("href","https://netway.co.th/?cmd=cart&action=add&id=707");
        }else if(optionValue =='759'){
            document.getElementById("priceOrderPhone00").setAttribute("href","https://netway.co.th/?cmd=cart&action=add&id=759");
        }else {
            document.getElementById("priceOrderPhone00").setAttribute("href","https://netway.co.th/?cmd=cart&action=add&id=759");
         }
    }   
    
     function BusinessPhone01(){
        var optionValue = document.getElementById("selectPricePhone01").value;
        if(optionValue =='707'){
            document.getElementById("priceOrderPhone01").setAttribute("href","https://netway.co.th/?cmd=cart&action=add&id=707");
        }else if(optionValue =='759'){
             document.getElementById("priceOrderPhone01").setAttribute("href","https://netway.co.th/?cmd=cart&action=add&id=759");
        }else {
            document.getElementById("priceOrderPhone01").setAttribute("href","https://netway.co.th/?cmd=cart&action=add&id=707");
         }
     }   
     function BusinessPhone10(){
        var optionValue = document.getElementById("selectPricePhone10").value;
        if(optionValue =='709'){
            document.getElementById("priceOrderPhone10").setAttribute("href","https://netway.co.th/?cmd=cart&action=add&id=709&addcoupon=true&promocode=CUT20");
        }else if(optionValue =='760'){
             document.getElementById("priceOrderPhone10").setAttribute("href","https://netway.co.th/?cmd=cart&action=add&id=760");
        }else {
            document.getElementById("priceOrderPhone10").setAttribute("href","https://netway.co.th/?cmd=cart&action=add&id=709&addcoupon=true&promocode=CUT20");
         }
     }   
     function BusinessPhone11(){
        var optionValue = document.getElementById("selectPricePhone11").value;
        if(optionValue =='709'){
            document.getElementById("priceOrderPhone11").setAttribute("href","https://netway.co.th/?cmd=cart&action=add&id=709&addcoupon=true&promocode=CUT20");
        }else if(optionValue =='760'){
             document.getElementById("priceOrderPhone11").setAttribute("href","https://netway.co.th/?cmd=cart&action=add&id=760");
        }else {
            document.getElementById("priceOrderPhone11").setAttribute("href","https://netway.co.th/?cmd=cart&action=add&id=709&addcoupon=true&promocode=CUT20");
         }
     }   
     function BusinessPhone20(){
        var optionValue = document.getElementById("selectPricePhone20").value;
        if(optionValue =='708'){
            document.getElementById("priceOrderPhone20").setAttribute("href","https://netway.co.th/?cmd=cart&action=add&id=708&addcoupon=true&promocode=CUT50");
        }else if(optionValue =='758'){
             document.getElementById("priceOrderPhone20").setAttribute("href","https://netway.co.th/?cmd=cart&action=add&id=758");
        }else {
            document.getElementById("priceOrderPhone20").setAttribute("href","https://netway.co.th/?cmd=cart&action=add&id=708&addcoupon=true&promocode=CUT50");
         }
     }   
     function BusinessPhone21(){
        var optionValue = document.getElementById("selectPricePhone21").value;
        if(optionValue =='758'){
            document.getElementById("priceOrderPhone21").setAttribute("href","https://netway.co.th/?cmd=cart&action=add&id=758");
        }else if(optionValue =='708'){
             document.getElementById("priceOrderPhone21").setAttribute("href","https://netway.co.th/?cmd=cart&action=add&id=708&addcoupon=true&promocode=CUT50");
        }else {
            document.getElementById("priceOrderPhone21").setAttribute("href","https://netway.co.th/?cmd=cart&action=add&id=758");
         }
     }   
     
   
   
</script>




