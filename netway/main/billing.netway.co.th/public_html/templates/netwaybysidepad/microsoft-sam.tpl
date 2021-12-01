
{literal}
    <style>
        
        section.hero {

            height: 380px;
            padding: 0 20px;
            text-align: center;
            width: 100%;
            background: url('https://netway.co.th/templates/netwaybysidepad/images/bg-sam2018.png');
            background-repeat: no-repeat;
            background-size: cover;
            background-attachment: fixed;
            background-position: top;

        }
        
        .sam-txt-banner {
            font-size: 38px;
            font-family: 'Prompt', sans-serif; 
            font-style: normal;
            line-height: 40px;
            font-weight: 600;
            color: #fff;
            text-shadow: 2px 2px 4px #041b5a;
            /*letter-spacing: 2px;*/

        }
        
        .font-special-txt{
            font-family: Roboto,Arial, sans-serif;
            font-size: 20px;
            line-height: 30px;
            font-weight: 100; 
            
        }

        .sam-topic{
            color: #0052cd; 
            font-weight: 300; 
            font-family: 'Prompt', sans-serif;
        }
        
        
         .re-btn-regis {
            color: #000000;
            font-family: 'Prompt', sans-serif;
            background-color: #f3a749;
            padding: 9px 10px 9px 10px;
            font-size: 18px;
            font-weight: 600;
            line-height: 26px;
            border: 2px solid #a94f01;
            border-radius: 10px;
        
        }
        .re-btn-regis:hover {
            color: #000000;
            font-family: 'Prompt', sans-serif;
            background-color: #ef8707;
            padding: 9px 10px 9px 10px;
            font-size: 18px;
            font-weight: 600;
            line-height: 26px;
            border:2px solid #7d3a00;  
            border-radius: 10px;
          }
        .why-sam-opti{
         
            background-size: 118px;
            height: 102px;
            width: 118px;
            padding: 30px 30px 30px 30px;
            margin-top: -10px;
        }
        .why-sam-cont{
            
            background-size: 118px;
            height: 102px;
            width: 110px;
            padding: 30px 30px 30px 30px;
            margin-top: -10px;
        }
        .why-sam-align{
          
            background-size: 118px;
            height: 102px;
            width: 110px;
            padding: 30px 30px 30px 30px;
            margin-top: -10px
        }
        li {
           line-height: 28px;
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
{/literal}


    <section class="section hero">
        <div class="container" >
            <div class="row" style="padding: 30px 0 30px 0;">
                <div class="">
                   <div class="hero-inner visible-phone" style="margin-top: 25px;">
                        <h2 class="sam-txt-banner hidden-phone">ประเมินว่าองค์กรของคุณใช้ซอฟต์แวร์คุ้มค่าหรือไม่ </h2>
                        <img src="https://netway.co.th/templates/netwaybysidepad/images/img-banner-icon-lock.png" style="margin-top: 10px;  width: 100px;" />
                        <h2 class="sam-txt-banner visible-phone" style="font-size: 22px;margin-top: 3px;">ประเมินว่าองค์กรของคุณใช้ซอฟต์แวร์คุ้มค่าหรือไม่ </h2>          
                         <a href="https://www.microsoft.com/resources/sam/tool.mspx">
                           <button class="nw-kb-btn-ticket" type="submit" style="display: none; "><i class="fa fa-play"></i>&nbsp;&nbsp;&nbsp;ทดสอบ</button>
                         </a>                        
                   </div>
                   <div class="hero-inner hidden-phone" style="margin-top: 90px;">
                        <h2 class="sam-txt-banner">ประเมินว่าองค์กรของคุณใช้ซอฟต์แวร์คุ้มค่าหรือไม่ </h2>          
                         <a href="https://www.microsoft.com/resources/sam/tool.mspx">
                           <button class="nw-kb-btn-ticket" type="submit" style="pointer-events: none;-webkit-filter: grayscale(100%); display: none; "><i class="fa fa-play"></i>&nbsp;&nbsp;&nbsp;ทดสอบ</button>
                         </a>                        
                   </div>
                </div>
            </div>
        </div>
  
    </section>

 <section id="customTab" style="margin-top: 0px;   background-color:#4489FF;">
        <div class="dynamic-menu hidden-phone  container " style="background-color: #4489FF;width: 100%;">
           <div class="container" >
            <ul class="dynamic-nav ">
                <li class="dynamic-nav"><a class="dynamic-nav nav-faq" href="#whySam" >ทำไมต้องทำ SAM</a></li>
                <li class="dynamic-nav"><a class="dynamic-nav nav-datasheet" href="#whatSam">SAM คืออะไร</a></li>
                <li class="dynamic-nav"><a class="dynamic-nav nav-servicerequest" href="#benefitSam">ประโยชน์ของ SAM</a></li>
                <li class="dynamic-nav"><a class="dynamic-nav nav-datasheet" href="#stepSam">ขั้นตอนการทำ SAM</a></li>
                <li class="dynamic-nav"><a class="dynamic-nav nav-datasheet" href="#docSam">เอกสารที่เกี่ยวข้อง</a></li>
                <li class="dynamic-nav"><a class="dynamic-nav nav-datasheet" href="#rateSam">ประเมินทรัพย์สินซอฟต์แวร์ (SAM Tool)</a></li>
                <li class="dynamic-nav"><a class="dynamic-nav nav-datasheet" href="#"></a></li>
            </ul>
            </div>
        </div>
</section>

<div class="row-fluid white-kb-2018" id="whySam"> 
        <div class="container"  style="margin-top: 70px;margin-bottom: 90px;">
            <div class="row">
               <div class="span12 dynamic-content"   >
             <center><h3 class="h3-title-content g-txt32 sam-topic" style="color: #0052cd; font-weight: 300; ">ทำไมต้องทำ SAM</h3>
             <span class="nw-2018-content-line" style="margin-bottom: 30px;"></span></center>          
               </div>
            </div>
            
            <div class="row"  >
                    <div class="span4 hover-Payment"  style="padding: 10px 0px 34px 0px; ">   
                        <div class="why-sam-cont hidden-phone" style="margin-left: 125px;">
                            <img src="https://netway.co.th/templates/netwaybysidepad/images/new_control-sam.png"/>
                        </div>
                        <div class="why-sam-cont visible-phone" style="margin-left: 110px;">
                            <img src="https://netway.co.th/templates/netwaybysidepad/images/new_control-sam.png">
                        </div>
                        <center><p class="g-txt22 txt-whysam" style="margin-top: 40px;  margin-bottom: 20px;">ควบคุม</p></center>
                        <p class="nw-content g-txt16" >
                            ต้นทุน, ความเสี่ยง และความยืดหยุ่นเพื่อสถานะทางการเงินของบริษัทที่แข็งแกร่งยิ่งขึ้นของคุณ
                        </p>
                    </div>
                    <div class="span4 hover-Payment" style="padding: 10px 0px 34px 0px; "> 
                        <div class="why-sam-opti hidden-phone" style="margin-left: 110px;">
                            <img src="https://netway.co.th/templates/netwaybysidepad/images/new_optimize-sam.png">
                        </div>
                        <div class="why-sam-opti visible-phone" style="margin-left: 110px;">
                              <img src="https://netway.co.th/templates/netwaybysidepad/images/new_optimize-sam.png">
                        </div>
                        <center><p class="g-txt22 txt-whysam" style="margin-top: 40px; margin-bottom: 20px;">เพิ่มประสิทธิภาพ</p></center>
                        <p class="nw-content g-txt16" >
                            ของการใช้งานและต้นทุนของทรัพย์สินซอฟต์แวร์ ดังนั้นคุณจึงสามารถใช้สิ่งที่คุณมีให้เกิดประโยชน์มากกว่าเดิม
                        </p>
                    </div>
                    <div class="span4 hover-Payment" style="padding: 10px 0px 34px 0px;">   
                        <div class="why-sam-align hidden-phone" style="margin-left: 110px;">
                            <img src="https://netway.co.th/templates/netwaybysidepad/images/new_align-sam.png">
                        </div>
                        <div class="why-sam-align visible-phone" style="margin-left: 110px;">
                            <img src="https://netway.co.th/templates/netwaybysidepad/images/new_align-sam.png">
                        </div>
                        <center><p class="g-txt22 txt-whysam" style="margin-top: 40px;  margin-bottom: 20px;" >ปรับปรุง</p></center> 
                        <p class="nw-content g-txt16" >
                           การลงทุนด้าน IT ของคุณด้วยเป้าหมายของธุรกิจคุณเพื่อเพิ่มความคล่องตัวและเพิ่มความสามารถในการผลิต
                        </p>
                    </div>
                </div>
            </div>
     </div>

   <div class="row-fluid white-kb-2018" id="whatSam" style="background: #f8f8f8;
">
        <div class="container"  style="margin-top: 70px; margin-bottom:  110px;">

            <div class="row"  >
                    <div class="span7"> 
                                   <h3 class="h3-title-content g-txt32 sam-topic" style="color: #0052cd;font-weight: 300;font-size: 34px;">SAM คืออะไร</h3>
             <span class="nw-2018-content-line" style="margin-bottom: 30px;"></span>  
                        <p class="nw-product-title g-txt18" style="color: #4b5058;">การบริหารจัดการสินทรัพย์ซอฟต์แวร์ หรือ SAM (Software Asset Management) </p>
                    
                        <p class="nw-content g-txt16" style="margin-top:  30px; margin-bottom: 30px; color: #14214a;" >
                            เป็นแนวคิดทางด้านการบริหารจัดการทรัพย์สินที่เป็นซอฟต์แวร์ ซึ่งมีการนำเสนอแนวทางและกระบวนการในการบริหารจัดการซอฟต์แวร์อย่างมีประสิทธิภาพ
                              ในขณะที่ซอฟต์แวร์คุณภาพสูงเป็นสิ่งที่มีความสำคัญต่ององค์กรอย่างมาก แต่น่าประหลาดใจที่ ไม่มีการเอาใจใส่ในเรื่องการบริหารจัดการซอฟต์แวร์มากนัก การบริหารจัดการสินทรัพย์ทางด้านซอฟต์แวร์ช่วยป้องกันซอฟต์แวร์ในองค์กรของคุณ และช่วยในคุณรู้ว่าใช้งานซอฟต์แวร์อะไรอยู่บ้าง ทำงานอยู่ที่ไหน และมีไลเซนส์ซ้ำซ้อนกันหรือไม่ SAM จึงเป็นสิ่งจำเป็นในโลกธุรกิจปัจจุบัน  
                        </p>
                    </div>
                    <div class="span5">
                   <img src="https://netway.co.th/templates/netwaybysidepad/images/img-sam-2018-1.png" style="margin-top: 30px;" />
                    </div>
                </div>
            </div>
     </div>
</div>


<div class="row-fluid white-kb-2018"  style="background: #00c6ff;  /* fallback for old browsers */
background: -webkit-linear-gradient(to right, #0072ff, #00c6ff);  /* Chrome 10-25, Safari 5.1-6 */
background: linear-gradient(to right, #0072ff, #00c6ff); /* W3C, IE 10+/ Edge, Firefox 16+, Chrome 26+, Opera 12+, Safari 7+ */
">
        <div class="container"  >
       
            <div class="row" style="padding: 70px 0px 70px 0px;"  id="benefitSam" >
                    <div class="span7">   
                     <h3 class="h3-title-content g-txt32 sam-topic" style="color: #fff; font-weight: 300;  font-size: 34px; ">ประโยชน์ของ SAM</h3>
             <span class="nw-2018-content-line" style="margin-bottom: 30px;"></span>   
                        <p class="nw-product-title " style="color: #fff;  font-weight: 500; font-size: 28px;   line-height: 32px; "><b>10</b> เหตุผลที่ตอนนี้คุณควรจะเริ่มนำ SAM ไปปรับใช้</p>
                        <p class="nw-content g-txt16" style="color: #fff; text-indent: 40px; margin-top: 30px; margin-bottom: 30px;">
                            ทำไมคุณถึงควรนำแผนกลยุทธ์ด้านการบริหารจัดการสินทรัพย์ซอฟต์แวร์ (SAM) 
                            ไปปรับใช้กับธุรกิจของคุณ? พิจารณาเหตุผลเหล่านี้เมื่อคุณประเมินความต้องการของคุณและระบุว่าแผนการด้าน SAM 
                            จะเหมาะสมกับองค์กรของคุณอย่างไร
                        </p>
                        <ol class="h3-title-content " style="color: #fff;  font-weight: 500; font-size: 18px; ">
                            <li> เพิ่มความปลอดภัยด้านการเงิน 
                            <li> ได้ส่วนลดเมื่อสั่งซื้อปริมาณมากเพื่อให้ได้ราคาถูกลง
                            <li> ขจัดปัญหาทางกฎหมาย
                            <li> ธรรมาภิบาลที่ดีสำหรับองค์กร
                            <li> พนักงานทุกคนได้รับประโยชน์
                            <li> การดำเนินงานที่เป็นไปอย่างราบรื่น   
                            <li> ขจัดความสิ้นเปลืองและค่าใช้จ่ายที่ซ้ำซ้อน   
                            <li> วางตำแหน่งทางการตลาดได้ดีขึ้น 
                            <li> เพิ่มมูลค่าของธุรกิจในระยะยาว   
                            <li> ประโยชน์ในอนาคต    
                        
                        </ol>
                        
                    </div>
                    <div class="span5">
                   <img src="https://netway.co.th/templates/netwaybysidepad/images/img-sam-2018-2.png" class="hidden-phone" style="margin-top: 250px;" />
                   <img src="https://netway.co.th/templates/netwaybysidepad/images/img-sam-2018-2.png" class="visible-phone" style="margin-top: 50px;" />
                     </div>
                </div>
            </div>
     </div>

    
     <div class="row-fluid white-kb-2018" id="stepSam">
        <div class="container"  style="margin-top: 70px;">
            <div class="row">
               <div class="span12 dynamic-content"   >
                   <center><h3 class="h3-title-content g-txt32 sam-topic" style="color: #0052cd; font-weight: 300; ">ขั้นตอนการทำ SAM</h3>
                   <span class="nw-2018-content-line" style="margin-bottom: 30px;"></span></center>          
               </div>
            </div>
            
            <div class="row"  >  
                <div class="span12"> 
                      <p class=" g-txt22" style="color: #14214a;font-weight: 500;">SAM Step by Step</p>
                      <p class=" nw-product-title g-txt20 explain-sam "  style="margin-left: 0px; ">
                        การบริหารซอฟต์แวร์แม้จะฟังแล้วดูยุ่งยาก แต่จริง ๆ เมื่อคุณเห็นภาพชัดเจนยิ่งขึ้นแล้วก็จะสามารถทำได้ง่าย ๆ 
                        ด้วยขั้นตอนแบบ step-by-step 4 ขั้นตอนดังนี้
                      </p>
                </div>
            </div>
            <div class="row">
                    <div class="span3 div-products-gs" style="text-align:  center;">
                        <p class="nw-product-title g-txt22" style="margin-top: 15px;">ขั้นตอนที่ <b>1</b></p>
                        <img src="../templates/netwaybysidepad/images/icon-step-sam-1.png" style="width: 120px;">
                        
                        <p class="nw-product-title g-txt18" style="margin-top: 15px;">บันทึกข้อมูลเกี่ยวกับซอฟต์แวร์ </p>
                      
                 
                    </div>
                    <div class="span3 div-products-gs" style="text-align:  center;">
                        <p class="nw-product-title g-txt22" style="margin-top: 15px;">ขั้นตอนที่ <b>2</b> </p>
                        <img src="../templates/netwaybysidepad/images/icon-step-sam-2.png" style="width: 120px;">
                      
                        <p class="nw-product-title g-txt18" style="margin-top: 15px;">การเปรียบเทียบซอฟต์แวร์กับสิทธิการใช้งาน</p>        
                    </div>
                    <div class="span3 div-products-gs" style="text-align:  center;"> 
                    <p class="nw-product-title g-txt22" style="margin-top: 15px;">ขั้นตอนที่ <b>3</b></p>
                     <img src="../templates/netwaybysidepad/images/icon-step-sam-3.png" style="width: 120px;">
                    
                       <p class="nw-product-title g-txt18" style="margin-top: 10px;">ทบทวนนโยบาย และขั้นตอนปฏิบัติ</p>
                </div>
                <div class="span3 div-products-gs" style="text-align:  center; ">
                    <p class="nw-product-title g-txt22" style="margin-top: 15px;">ขั้นตอนที่  <b>4</b> </p>
                    
                    <img src="../templates/netwaybysidepad/images/icon-step-sam-4.png" style="width: 120px;">
                    
                    <p class="nw-product-title g-txt18" style="margin-top: 15px;">จัดการแผนการ SAM ขึ้นมา</p>
               </div>
          </div>

      </div>
     </div>

    <div class="row-fluid white-kb-2018" id="docSam">
        <div class="container"  style="margin-top: 70px;">
            <div class="row">
               <div class="span12 dynamic-content"   >
                   <center><h3 class="h3-title-content g-txt32 sam-topic" style="color: #0052cd; font-weight: 300; ">เอกสารที่เกี่ยวข้อง</h3>
                   <span class="nw-2018-content-line" style="margin-bottom: 30px;"></span></center>          
               </div>
            </div>
            
            <div class="row">  
               <div> 
                    <p class="nw-product-title g-txt22">เอกสารสำหรับดาวน์โหลด</p>
                    
                        <p class="g-txt18"  style="margin-top: 20px;">&nbsp;<i class="fa fa-angle-right"></i>&nbsp;&nbsp;ความรู้เบื้องต้นเกี่ยวกับ SAM</p>
                           <a href="http://download.microsoft.com/documents/en-us/sam/SAM_Quick_Guide.pdf" style="text-decoration: none;">
                               &nbsp;&nbsp;<p   class="g-txt18" style="font-size: 16px;"><i class="fa fa-file-pdf-o"></i>&nbsp;&nbsp;  SAM Quick Guide (PDF , 110.1kB)</p> 
                              
                           </a>
                        <hr/>     
                        <p class="g-txt18">&nbsp;<i class="fa fa-angle-right"></i>&nbsp;&nbsp;ความคิดเห็นของลูกค้า</p>  
                            <a href="http://download.microsoft.com/documents/en-us/sam/SAM_Customer_Testimonials.pdf" style="text-decoration: none;">
                                &nbsp;&nbsp;<p  class="g-txt18" style="font-size: 16px;"><i class="fa fa-file-pdf-o"></i>&nbsp;&nbsp; Testimonials (PDF , 113.0kB) </p>      
                            </a>
                        <hr/>
                        <p class="g-txt18">&nbsp;<i class="fa fa-angle-right"></i>&nbsp;&nbsp;ประโยชน์ของการบริหารซอฟต์แวร์</p>
                            <a href="http://download.microsoft.com/documents/en-us/sam/SAM_Benefits.pdf" style="text-decoration: none;">
                                 &nbsp;&nbsp;<p class="g-txt18" style="font-size: 16px;"><i class="fa fa-file-pdf-o"></i>&nbsp;&nbsp; The Benefit of SAM(PDF , 2.3MB) </p>
                            </a>
                        <hr/>
                        <p class="g-txt18">&nbsp;<i class="fa fa-angle-right"></i>&nbsp;&nbsp;เอกสารนำเสนอประโยชน์ และขั้นตอนของ SAM</p>
                           <a href="http://download.microsoft.com/documents/en-us/sam/Why_Implement_SAM.pdf" style="text-decoration: none;">
                                 &nbsp;&nbsp;<p class="g-txt18" style="font-size: 16px;"><i class="fa fa-file-pdf-o"></i>&nbsp;&nbsp; Why ImplementSAM?(PDF , 3.0MB) </p>
                           </a>
                        <hr/>
                      
               </div>
           </div>
      </div>
 </div>
      
<div class="row-fluid white-kb-2018" id="rateSam">
        <div class="container"  style="margin-top: 70px;">
            <div class="row">
               <div class="span12 dynamic-content"   >
                   <center><h3 class="h3-title-content g-txt32 sam-topic" style="color: #0052cd; font-weight: 300; ">ขั้นตอนการบริหารซอฟต์แวร์</h3>
                   <span class="nw-2018-content-line" style="margin-bottom: 30px;"></span></center>          
               </div>
            </div>
            
            <div class="row"  >  
                <div class="span12"> 
                      <p class="g-txt20" style="color: #000000;font-weight: 300;font-size:  20px;line-height: 24px;">
                          SAM Checklist <a href="http://download.microsoft.com/documents/en-us/sam/SAM_Checklist.pdf"style="text-decoration: none;">รายการที่ต้องตรวจสอบ &nbsp;&nbsp;<i class="fa fa-file-pdf-o" aria-hidden="true"></i></a>
                      </p>
                </div>
            </div>
            <div class="row" style="margin-top: 20px;">
                    <div class="span8 sam-checklist" >
                        <p class="nw-product-title g-txt20">ขั้นตอนที่ 1: ตรวจสอบรายการซอฟต์แวร์ที่ติดตั้ง</p>
                        <p class="g-txt16" style="margin-top: 30px;">&nbsp;<i class="fa fa-angle-right"></i>
                            &nbsp;&nbsp;<a href="https://drive.google.com/file/d/1ZNzgBQkpFYAVDeikBWySKYEPWYIxnE2V/view?usp=sharing"style="text-decoration: none;">PC Software Inventory report Template</a>                          
                        </p>                  
                        <p class="g-txt16">&nbsp;<i class="fa fa-angle-right"></i>
                            &nbsp;&nbsp;<a href="https://drive.google.com/file/d/1oaZod_Nff3Ny4bmn9K10DE-M0Vzp2kTm/view?usp=sharing"style="text-decoration: none;">Software Inventory Summary Report Template</a>                           
                        </p>

                    </div> 
                    <div class="span4 hidden-phone">
                       <img src="https://netway.co.th/templates/netwaybysidepad/images/icon-step-sammmm-1.png" style="margin-top: 30px;  width: 150px;" />
                    </div>
            </div>
            <hr/>
            <div class="row" style="margin-top: 20px;">
                 <div class="span8 sam-checklist">
                      <p class="nw-product-title g-txt20">ขั้นตอนที่ 2: ตรวจรายการลิขสิทธิ์</p>
                      <p class="g-txt16" style=" margin-top: 30px;">&nbsp;<i class="fa fa-angle-right"></i>
                          &nbsp;&nbsp;<a href="https://drive.google.com/file/d/1mEwaxrrRzkUWUmNJ9WMKrXiyx-A-vl4h/view?usp=sharing"style="text-decoration: none;" >License Summary Report Template</a>                         
                      <p class="g-txt16" >&nbsp;<i class="fa fa-angle-right"></i>
                          &nbsp;&nbsp;<a href="https://drive.google.com/file/d/1cRC42x2zmT-fFtqx19_Gl7SxsBywJF5B/view?usp=sharing"style="text-decoration: none;" >Software and License Summary Report Template </a>                        
                     <p class="g-txt16"  >&nbsp;<i class="fa fa-angle-right"></i>
                          &nbsp;&nbsp;<a href="https://drive.google.com/file/d/1bv9TCcPRDdGefF7UhkWt2sVIJn-7IDGB/view?usp=sharing"style="text-decoration: none;" >Software License Documentation</a>                        
                     </p>   
                </div>
                <div class="span4 hidden-phone">
                    <img src="https://netway.co.th/templates/netwaybysidepad/images/icon-step-sammmm-2.png" style="margin-top: 30px;  width: 150px;" />
                </div>
           </div>
           <hr/>
           <div class="row" style="margin-top: 20px;">
                 <div class="span8 sam-checklist">
                      <p class="nw-product-title g-txt20">ขั้นตอนที่ 3: ทบทวนขั้นตอน และนโยบายองค์กร</p>
                      <p class="g-txt16" style="margin-top: 30px;">&nbsp;<i class="fa fa-angle-right"></i>
                          &nbsp;&nbsp;<a href="https://drive.google.com/file/d/1jk9k8X6SoQ2AudjeTjqSF3qLCz_iw-Ga/view?usp=sharing"style="text-decoration: none;" >Software Use Policy Template</a>                            
                      <p class="g-txt16">&nbsp;<i class="fa fa-angle-right"></i>
                          &nbsp;&nbsp;<a href="https://drive.google.com/file/d/1NRpoxKV51FKRP1WO_zxU72j9fa5oJxd0/view?usp=sharing"style="text-decoration: none;" >New Software Check-in Checklist</a>                         
                     </p>
                      <p class="g-txt16" >&nbsp;<i class="fa fa-angle-right"></i>
                          &nbsp;&nbsp;<a href="https://drive.google.com/file/d/19wSCguoC07UGL5rGVvuUALCRbqBbKjLn/view?usp=sharing"style="text-decoration: none;" >Software Acquisition Policy Template</a>                           
                     </p>
                     <p class="g-txt16">&nbsp;<i class="fa fa-angle-right"></i>
                          &nbsp;&nbsp;<a href="https://drive.google.com/file/d/1Pxb3ql7kyApAdx68_FHpuml4bqHACSoA/view?usp=sharing"style="text-decoration: none;" >Software Disaster Recovery Plan Template</a>                          
                     </p>
                     
                </div>
                <div class="span4 hidden-phone">
                  <img src="https://netway.co.th/templates/netwaybysidepad/images/icon-step-sammmm-3.png"  style="margin-top: 50px;  width: 150px;" />
                   
                </div>
           </div>
            <hr/>
           <div class="row" style="margin-top: 40px;  margin-bottom: 40px;">
                 <div class="span8 sam-checklist" >
                      <p class="nw-product-title g-txt20">ขั้นตอนที่ 4: วางแผนการบริหารซอฟต์แวร์</p>
                      <p class="g-txt16" style="margin-top: 30px;">&nbsp;<i class="fa fa-angle-right"></i>
                          &nbsp;&nbsp;<a href="https://drive.google.com/file/d/1joVChPYFArZUImqnX8vJU_FXlVWBahIs/view?usp=sharing"style="text-decoration: none;" >Employee Software Questionnaire</a>
                      <p class="g-txt16">&nbsp;<i class="fa fa-angle-right"></i>
                          &nbsp;&nbsp;<a href="https://drive.google.com/file/d/1NxBVQPt3MZC4KPusdGMYFrO76fNV671X/view?usp=sharing"style="text-decoration: none;" >Tips on Reducing Support Costs</a>                         
                     </p>
                     <p class="g-txt16">&nbsp;<i class="fa fa-angle-right"></i>
                          &nbsp;&nbsp;<a href="https://drive.google.com/file/d/1A-bHmIBleeAjJw6v1ftd2O6xldPSS1zY/view?usp=sharing"style="text-decoration: none;" >Software and Hardware Spreadsheet Template</a>                            
                     </p>   
                      <p class="g-txt16">&nbsp;<i class="fa fa-angle-right"></i>
                          &nbsp;&nbsp;<a href="https://drive.google.com/file/d/1-FNFVnd31CjBMJ_0Lf4lgUc_aFKrfcoP/view?usp=sharing"style="text-decoration: none;" >Software and Hardware Map Example</a>
                     </p>   
                </div>
                <div class="span4 hidden-phone">
                 <img src="https://netway.co.th/templates/netwaybysidepad/images/icon-step-sammmm-4.png" style="margin-top: 60px;  width: 150px;" />
                </div>
           </div>
           <hr/>
      </div>
     </div>
     
<div class="row-fluid white-nw-2018"  id="Competencies"  style="background-color: #FFF;" > 
     <div class="container"  style="margin-top: 50px;">
        <div class="row">
           <div class="span12" style="padding: 0px 10px 0px 10px;">
             <center><h3 class="h3-title-content g-txt32  sam-topic" >SAM Certified Competencies</h3>
             <span class="nw-2018-content-line" style="margin-bottom: 30px;"></span></center>          
            </div>
        </div>
        <div class="row">
           <div class="span12" style="padding: 0px 10px 0px 10px;">
             <h3 class="h3-title-content g-txt18" style="font-weight: 100; ">
                  บริการ License Checkup นี้ได้รับการรับรองโดย Microsoft และทีมงาน SAM (ทั้ง Microsoft Certified Professional 
                  หรือ MCP และ Microsoft Certified Solution Associate หรือ MCSA) ที่ได้รับการอบรมเรื่องลิขสิทธิ์ซอฟต์แวร์ของ 
                  Microsoft ทั้ง On-Premise และ Cloud ดังต่อไปนี้
             </h3>
                      
            </div>
        </div>

        
     </div>
     <div class="container "style="margin-top: 20px;">
     <div> <!-- อื่นๆ -->
        <div  class="row" >
         <div class="span12"><h4>Software License Management (SAM)</h4><hr style="margin-top: -5px;"/></div>
        </div>
        
        <div  class="row" >
           <div class="span6 kb-txt-pro">
               <a href="https://www.youracclaim.com/badges/5546e6c2-0683-4fb7-90a7-5406cbb6e060/public_url"style="text-decoration: none;"class="cer">
                  <img src="https://netway.co.th/templates/netwaybysidepad/images/License1.png"  alt="License1"  
                 style="width: 150px; margin-right: 50px;">Software Asset Management (SAM)</a> 
           </div > 
              
              <div class="span6 kb-txt-pro"  >
              <a href="https://www.youracclaim.com/badges/bb730531-fe93-48e3-a702-28ffe687fb6f/public_url"style="text-decoration: none;"class="cer">
                  <img src="https://netway.co.th/templates/netwaybysidepad/images/License2.png"  alt="License2"
                style="width: 150px; margin-right: 50px;">Designing and Providing 
             </a>
              </div > 
         
        </div>
    
        <div  class="row" style="margin-top: 20px" >
             <div class="span12" ><h4>Office 365</h4><hr style="margin-top: -5px;"/></div>
        </div>
        <div  class="row" >
                 
              <div class="span6 kb-txt-pro" >
                 <a href="https://www.youracclaim.com/badges/9eced0a1-af64-48fe-b45c-c6b5a4e138af/public_url"style="text-decoration: none;"class="cer">
                    <img src="https://netway.co.th/templates/netwaybysidepad/images/License3.png"  alt="License3"  
                    style="width: 150px; margin-right: 50px;">Managing Office 365
                </a>
             </div > 
             <div class="span6 kb-txt-pro ">
                <a href="https://www.youracclaim.com/badges/33a3046c-7afd-4ebb-bd76-f99c13b43d78/public_url"style="text-decoration: none;"class="cer">
                    <img src="https://netway.co.th/templates/netwaybysidepad/images/License4.png"  alt="License4"
                    style="width: 150px; margin-right: 50px;">Enabling Office 365 Services
               </a> 
              </div > 
        </div>
        <div  class="row" style="margin-top: 20px" >
             <div class="span12 coming-pro" ><h4>Azure</h4><hr style="margin-top: -5px;"/></div>
        </div>
        <div  class="row" >
              <div class="span6 kb-txt-pro " >
                 <a href="https://www.youracclaim.com/badges/45a1dfe5-05d9-4398-86f5-5006cd8821f9/public_url"style="text-decoration: none;"class="cer">
                 <img src="https://netway.co.th/templates/netwaybysidepad/images/License5.png"  alt="License5"  
                 style="width: 150px; margin-right: 50px;">
                  Developing Microsoft Azure Solutions
                
                </a>
              </div > 
                 
             <div class="span6 kb-txt-pro ">
                 <a href="https://www.youracclaim.com/badges/9574e76d-da0c-40a2-b73d-ef314d205c0b/public_url"style="text-decoration: none;"class="cer">  
                    <img src="https://netway.co.th/templates/netwaybysidepad/images/License6.png"  alt="License4"
                    style="width: 150px; margin-right: 50px;">Implementing Microsoft Azure 
                 </a>
            </div > 
        </div>
        <div  class="row" style="margin-top: 20px" >
             <div class="span12 coming-pro" ><h4>MCSA</h4><hr style="margin-top: -5px;"/></div>
        </div>
        <div  class="row" >
              <div class="span6 kb-txt-pro " >
                   <a href="https://www.youracclaim.com/badges/80c6fef9-2ac6-46de-8a15-b728ba7893ca/public_url"style="text-decoration: none;"class="cer"> 
                       <img src="https://netway.co.th/templates/netwaybysidepad/images/License7.png"  alt="License7"  
                      style="width: 150px; margin-right: 50px;">MCSA: Cloud Platform - Certified 2017
                   </a>
              </div > 
             <div class="span6 kb-txt-pro ">
                  <a href="https://www.youracclaim.com/badges/a724c66c-876d-4e21-8cf1-ba95bf6b0f02/public_url"style="text-decoration: none;"class="cer"> 
                     <img src="https://netway.co.th/templates/netwaybysidepad/images/License8.png"    alt="License8"
                     style="width: 150px; margin-right: 50px;">MCSA: Office 365 
                 </a>
             </div > 
        </div>
     </div>
   </div>     
</div>

<div class="row-fluid white-kb-2018" id="Professionals">
        <div class="container"  style="margin-top: 70px;">
            <div class="row">
               <div class="span12 dynamic-content"   >
                   <center><h3 class="h3-title-content g-txt32 sam-topic">
                            SAM Certified Professionals
                           </h3>
                   <span class="nw-2018-content-line" style="margin-bottom: 30px;"></span></center>          
               </div>
            </div>
            
            <div class="row"  >  
                <div class="span12"> 
                      <p class=" nw-product-title g-txt20 explain-sam "  style="margin-left: 0px; ">
                          บุคลากรที่ดูแลคุณเรื่องของ License Checkup นั้นได้รับการรับรองมาตรฐานจาก Microsoft ทั้งที่เป็น MCP และ MCSA
                      </p>
                </div>
            </div>
            <div class="row">
                    <div class="span3 div-products-gs" style="text-align:  center;">
                        <img src="https://netway.co.th/templates/netwaybysidepad/images/Professionals1.png" style="width: 255px;">
                        <a href="https://drive.google.com/file/d/0B3rr8u_oE3APcmh1VG1mczh5Zmc/view?usp=sharing" class="cer" style="text-decoration: none;"><p class="g-txt18" style="margin-top: 15px;">Microsoft Certified Solutions Association</p></a>
                    </div>
                    <div class="span3 div-products-gs" style="text-align:  center;">
                        <img src="https://netway.co.th/templates/netwaybysidepad/images/Professionals2.png" style="width: 255px;">
                        <a href="https://drive.google.com/file/d/1NCPTwl2dTmQ2XEBKQeywmFrAvWRmieRE/view?usp=sharing" class="cer" style="text-decoration: none;"><p class=" g-txt18" style="margin-top: 15px;">Microsoft Certified Professional</p></a>     
                    </div>
                    <div class="span3 div-products-gs" style="text-align:  center;"> 
                     <img src="https://netway.co.th/templates/netwaybysidepad/images/Professionals3.png" style="width:255px;">
                       <a href="https://drive.google.com/file/d/0B3rr8u_oE3APNHZmal8zNk5HMW8/view?usp=sharing" class="cer" style="text-decoration: none;"><p class=" g-txt18" style="margin-top: 10px;">Microsoft Certified Solutions Associate</p></a>
                </div>
                <div class="span3 div-products-gs" style="text-align:  center; "> 
                    <img src="https://netway.co.th/templates/netwaybysidepad/images/Professionals4.png" style="width: 225px;">      
                    <a href="https://drive.google.com/file/d/0B3rr8u_oE3APSmdsVnl2S3ljbTQ/view?usp=sharing" class="cer" style="text-decoration: none;"><p class=" g-txt18" style="margin-top: 15px;">Microsoft Certified Solutions Associate</p></a>
               </div>
          </div>

      </div>
  </div>
          
          
   <div class="row-fluid white-kb-2018" id="Partner">
        <div class="container"  style="margin-top: 70px;">
            <div class="row">
               <div class="span12 dynamic-content"   >
                   <center><h3 class="h3-title-content g-txt32 sam-topic">Microsoft Partner Level</h3>
                   <span class="nw-2018-content-line" style="margin-bottom: 30px;"></span></center>          
               </div>
            </div>
             <div class="row">
                    <div class="span12" style="text-align:  center;">
                        <img src="https://netway.co.th/templates/netwaybysidepad/images/mi-parther.png" style="width: 700px;">
                   </div>
             </div>
             <div class="row" style="margin-top: 15px;" >  
                <div class="span12"> 
                   <a href="https://drive.google.com/file/d/1GOhx9V3i8K75-gNH632SDrET4oubeeR9/view" class="cer" style="text-decoration: none;"> 
                      <center><button class="nw-kb-btn-ticket" type="submit">View Certificate</button></center>
                  </a>  
                </div>
             </div>
      </div>
  </div>       
          
 <div class="row-fluid white-kb-2018" id="Authorized">
        <div class="container"  style="margin-top: 70px;">
            <div class="row">
               <div class="span12 "   >
                   <center><h3 class="h3-title-content g-txt32 sam-topic">
                             Microsoft Authorized Education partner
                           </h3>
                           <span class="nw-2018-content-line" style="margin-bottom: 30px;"></span>
                   </center>          
               </div>
            </div>
             <div class="row">
                    <div class="span12" style="text-align:  center;">
                        <img src="https://netway.co.th/templates/netwaybysidepad/images/Authorized.png" 
                             style="width: 770px;height: 190px;border: 2px solid #0f0700;border-radius: 10px;">
                   </div>
             </div>
             <div class="row" style="margin-top: 15px;" >  
                <div class="span12" > 
                   <a href="https://drive.google.com/file/d/1O6NWUzjAPZVKHBxcajmcrbm7P-46f3A-/view" class="cer" style="text-decoration: none;"> 
                    <center><button class="nw-kb-btn-ticket" type="submit">View Certificate</button></center>
                  </a>  
                </div>
             </div>
      </div>
  </div>
