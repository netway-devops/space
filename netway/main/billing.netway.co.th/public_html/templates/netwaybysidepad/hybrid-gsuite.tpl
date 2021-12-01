{php}
$templatePath   = $this->get_template_vars('template_path');

                $db           = hbm_db();
                $faqHybrid  =  $db->query("SELECT * 
                                    FROM hb_kb_article 
                                    WHERE kb_article_id ='360033675091'
                                ")->fetch();
               $this->assign('faqHybrid',$faqHybrid);   
{/php}
{literal}
<style>
@media (min-width: 1200px){
    hr.hr-hybrid{
        width: 11%;
        border: 1px solid #0052cd;
        margin: -5px 0px 0px 52px;
    }
    .hybrid365{ 
            height: 390px;
            background-attachment: unset;   
            text-align: center;
            width: 100%;
            background-repeat: no-repeat;
            background-size: cover;
            background-position: center;
            background-image:linear-gradient(to right, #014ccf , #b6e2fb);
    }
    .btn-hybrid{
        background: #df5d00;
        color: #ffffff;
        padding: 14px 30px;
        margin-top: 43px;
        font-size: 21px;
        font-weight: 600;
        font-family: 'Prompt', sans-serif;
        border: none;
    }
    .btn-hybrid:hover{
        border: 2px solid #fff;
    }
    .hybrid-list{
       height: 80px;
       width:  80px;
       margin-bottom: 20px;
    }
    .hybris-topic{
        font-size: 24px;
        font-weight: 600;
        color: #3356d7;
        margin-left: 13px;
    }
    table.hybrid-365-price tr td,th {
        border: 1px solid #d0d0d0;
        text-align:center;
        padding:15px 10px;
    }    
     table.hybrid-365-price2 tr td,th {
        border: 1px solid #d0d0d0; 
        padding:15px 20px;
        text-align: center; 
    }
    table.hybrid-365-price2 {
        table-layout: fixed;
        width: 83%; 
    }
    .hybrid-tap {
        list-style: none;
        width: inherit;
        height: inherit;
        display: flex;
        align-items: center;
        color:   #efefef;
        margin: 0px;
    }
    .hybrid-tap li {
        display: flex;
        align-items: center;
        justify-content: center;
        margin: 0px 4px 0px 2px;
        height: 53px;
        width: 280px;
        border: 2px solid #aeaeae; 
        border-radius: 30px;
    }
    .hybrid-tap li:hover {
          cursor: pointer;
     }
    span.active{
        border: 3px solid #f6bb06;
        padding: 2px 0px;
        border-radius: 30px;
        font-weight: 600;
        
    }
}

@media (max-width:760px) {
     .hybrid365{ 
            height: 390px;
            background-attachment: unset;   
            text-align: center;
            width: 100%;
            background-repeat: no-repeat;
            background-size: cover;
            background-position: center;
            background-image: linear-gradient(to right, #014ccf , #b6e2fb);
    }
    .btn-hybrid{
        background: #df5d00;;
        color: #ffffff;
        padding: 14px 30px;
        margin-top: 35px;
        font-size: 20px;
        font-weight: 600;
        font-family: 'Prompt', sans-serif;
        border: none;
    }
    
    .hr-hybrid {
        width: 25%;
        border: 1px solid #0052cd;
        margin: -5px 0px 0px 52px;
    }
    .hybrid-list {
       height: 70px ;
       width:  70px ;
       margin-bottom: 20px;
    
    }
    .hybris-topic {
        font-size: 20px;
        font-weight: 600;
        color: #3356d7;
        margin-bottom: 13px;
    }
    .hybrid table {
        text-align: center;
    }
     table.hybrid-365-price tr td,th {
        border: 1px solid #d0d0d0;
       padding: 10px 5px;
       text-align: center;
    }    
     table.hybrid-365-price2 tr td,th {
        border: 1px solid #d0d0d0; 
        padding: 10px 5px;
       text-align: center; 
    }

    .hybrid-tap {
        list-style: none;
        width: inherit;
        height: inherit;
        display: flex;
        align-items: center;
        justify-content: center;
        color: #828282;
    }
    .hybrid-tap li {
        display: flex;
        align-items: center;
        justify-content: center;
        margin: 1px;
        height: 48px;
        width: 171px;
        border-top: 1px solid #353535;
        transition: all .5s;
        border: 2px solid #aeaeae;
        border-radius: 30px;
        
    }
    .hybrid-tap li:hover {
          cursor: pointer;
        }
     span.active{
        border: 3px solid #f6bb06;
        padding: 2px 0px;
        border-radius: 30px;
        font-weight: 600;
        
    }
    .plan-head{
        height: 52px;
        text-align: center;
        padding:12px;
        border-radius: 10px 10px 0 0;
        font-size: 22px;
        margin-top: 10px;
    }
}

.hidden{
    display:none;
}
.coming-list{
     -webkit-filter: grayscale(100%); 
     cursor: none;
}
div.plan-gs{
  border: 1px solid #c6c6c6;  
  
}
.txt-price-top{
  font-size: 24px;
}
.faq-a {
 text-align: unset; 
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

$(window).scroll(function(e){
    var pos = $('#customTab').position();
    if($(window).scrollTop() >= pos.top){
        $('.dynamic-menu').addClass('fix-top-dynamic-menu');
    }else{
        $('.dynamic-menu').removeClass("fix-top-dynamic-menu");
    }
    $('.dynamic-content').each(function(){
       
    });
    
});
 
    
    $('.faq-a').after('<hr class="hr-faq"/>');
    $('p').find('strong.title-faq').append('&nbsp;&nbsp;<i class=" expland fa fa-plus" style="color:#ff8400;cursor:pointer;font-size:20px;float:right"> Expand All</i>');
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
            $('#faq-a-'+sliceID[2]).slideToggle();
         });
 
    });
function toggleActiveClass(el){
    console.log(el[0].hash);
    $("a.dynamic-nav").each(function(){
        $(this).removeClass('active');
    });
    $(el).addClass('active');
    
}
</script>
{/literal}
 
    <div class="row-fluid"> 
      <div class=" hybrid365  ">
              <div class="container">       
                <div class="span7 hero-inner hidden-phone" >
                    <div style="margin-top: 70px;text-align: left;font-family: 'Prompt', sans-serif;margin-left: 45px;">                     
                       <h2 class="re-txt-banner" style="font-size: 36px;line-height: 49px;text-align: center;"><b>Solution Hybrid Email G Suite</b></h2>
                       <h2 class="re-txt-banner" style="font-size: 32px;letter-spacing: 1px;text-align: center;"><b style="letter-spacing: 1px;">ลดต้นทุนอีเมล มากกว่า 19%</b></h2>
                        <center>
                            <a href="https://support.netway.co.th/hc/th/requests/new?ticket_form_id=360000181612&request_subject=%E0%B8%82%E0%B8%AD%E0%B8%82%E0%B9%89%E0%B8%AD%E0%B8%A1%E0%B8%B9%E0%B8%A5%E0%B9%80%E0%B8%9E%E0%B8%B4%E0%B9%88%E0%B8%A1%E0%B9%80%E0%B8%95%E0%B8%B4%E0%B8%A1%E0%B9%81%E0%B8%A5%E0%B8%B0%E0%B8%A3%E0%B8%B2%E0%B8%84%E0%B8%B2%20Solution%20Hybrid%20Office%20365/G%20Suite" target="_blank" style="margin: 21px 0px 0px 0px;">
                               <button class="btn-hybrid" type="submit">ติดต่อเจ้าหน้าที่</button>
                            </a> 
                        </center>  
                    </div>  
                </div>
                <div class="span5 hero-inner hidden-phone" style="width: 42%;margin:0px 0px 0px -16px;">
                     <img src="https://netway.co.th/templates/netwaybysidepad/images/hybrid-banner.png" alt="" border="0" width="100%" style="margin-top: 20px;">
                </div>  
                <div class="span6 hero-inner visible-phone">
                <div style="text-align: center;font-family: 'Prompt', sans-serif;padding: 9px 8px;">                     
                    <h2 class="re-txt-banner" style="font-size: 30px;line-height: 38px;letter-spacing: 2px;"><b>Solution Hybrid Email G Suite</b></h2>
                    <h2 class="re-txt-banner" style="font-size: 25px;letter-spacing: 1px;"><b style="letter-spacing: 1px;">ลดต้นทุนอีเมล มากกว่า 19%</b></h2>
                    <span style="width: 21%;margin: 10px 0 9px;height: 5px;background: #000;"> </span>
                </div>  
                </div>
                <div class="span6 hero-inner visible-phone" >
                     <img class="lazy-hero " data-src="https://netway.co.th/templates/netwaybysidepad/images/hybrid-banner.png"  alt="" style="width: 200px;margin-top:-16px;">
                    <a  class="visible-phone" href="https://support.netway.co.th/hc/th/requests/new?ticket_form_id=360000181612&request_subject=%E0%B8%82%E0%B8%AD%E0%B8%82%E0%B9%89%E0%B8%AD%E0%B8%A1%E0%B8%B9%E0%B8%A5%E0%B9%80%E0%B8%9E%E0%B8%B4%E0%B9%88%E0%B8%A1%E0%B9%80%E0%B8%95%E0%B8%B4%E0%B8%A1%E0%B9%81%E0%B8%A5%E0%B8%B0%E0%B8%A3%E0%B8%B2%E0%B8%84%E0%B8%B2%20Solution%20Hybrid%20Office%20365/G%20Suite" target="_blank">
                         <button class="btn-hybrid" type="submit" style="padding: 11px 16px;margin-top: 10px;">ติดต่อเจ้าหน้าที่</button>
                    </a> 
                </div>
            </div>
        </div>
    </div>  
    <section id="customTab" style="margin-top: 0px;   background-color: #4489FF;">
        <div class="dynamic-menu hidden-phone  container " style="background-color: #4489FF; width: 100%;">
            <div  class="container">
                <ul class="dynamic-nav ">
                    <li class="dynamic-nav o365-menu "><a class="dynamic-nav nav-Features active" href="#Feature">Feature </a></li>
                    <li class="dynamic-nav o365-menu"><a class="dynamic-nav nav-PlanandPricing" href="#PlanandPricing">Plan and  Pricing</a></li>
                    <li class="dynamic-nav o365-menu"><a class="dynamic-nav nav-faq" href="#faq">FAQ</a></li>
                    <li class="dynamic-nav gsuite-menu hidden"><a class="dynamic-nav nav-datasheet" href="#empty"></a></li> 
                </ul>
             </div>
        </div>
    </section>
<div class="row-fluid " id='hybrid-gsuite' > 
    <div class="row-fluid" style="margin-top: 80px;" id="Feature" >
        <div class="span12 dynamic-content" >
            <center>
                <h3 class="h3-title-content g-txt32 re-topic" >
                    Solution Hybrid G Suite  
               </h3>
                <span class="nw-2018-content-line" style="margin-bottom: 50px;"></span>
            </center>          
        </div>
        <div class="container">
            <div class="row " >       
               <div class="span11 dynamic-content" >
                   <p style="color: #0052cd;text-align: left; font-size: 20px;">
                        <img src="https://netway.co.th/templates/netwaybysidepad/images/hybrid365-icon1.png" style="width: 55px;height: auto;"> 
                        Pricing Optimization
                        <hr class="hr-hybrid">
                   </p>
                   <p  class="g-txt18 gs-content hidden-phone"  style="text-align:justify;margin-left: 50px;line-height: 28px;" >
                   โซลูชันของ Hybrid G Suite นั้นคือการเลือกผสมการใช้งานร่วมกันระหว่าง User บน G Suite และบน  Email Server ประเภทอื่น เช่น  Email Server บน Control Panel ทั่วไปบนเครื่องประเภท Shared Hosting หรือ Virtual Private Server (VPS) หรือ Dedicated Server ก็ได้ภายใต้โดเมนเนมเดียวกัน 
                   <br> <br> ตัวอย่างเช่น ถ้าองค์กรของคุณมีพนักงาน 100 คน และมีงบประมาณที่จัดสรรให้แก่ G Suite User เพียง 30 คน คุณสามารถเลือกวางอีก 70 Users นั้นไว้บน VPS เครื่องอื่นได้
                   </p>
                   <p  class="g-txt16 gs-content visible-phone"  style="padding:10px" >
                   โซลูชันของ Hybrid G Suite นั้นคือการเลือกผสมการใช้งานร่วมกันระหว่าง User บน G Suite และบน  Email Server ประเภทอื่น เช่น  Email Server บน Control Panel ทั่วไปบนเครื่องประเภท Shared Hosting หรือ Virtual Private Server (VPS) หรือ Dedicated Server ก็ได้ภายใต้โดเมนเนมเดียวกัน 
                   <br> ตัวอย่างเช่น ถ้าองค์กรของคุณมีพนักงาน 100 คน และมีงบประมาณที่จัดสรรให้แก่ G Suite User เพียง 30 คน คุณสามารถเลือกวางอีก 70 Users นั้นไว้บน VPS เครื่องอื่นได้
                   </p>
               </div>
            </div>
            <div class="row " style="margin-top: 30px;"> 
                <center>
                <table class="hybrid-365-price hidden-phone" style="table-layout: fixed; width: 83%;font-family: 'Prompt', sans-serif;font-size: 17px;">
                  <tbody>
                    <tr>
                        <th style="border: none;"> </th>
                        <th style="text-align: center;background: #377dc1;color:#fff;font-size: 18px;"> G Suite  </th>
                        <th style="text-align: center;background: #6a9fd1;color:#fff;font-size: 18px;">VPS</th>
                    </tr>
                    <tr>
                        <td>จำนวน Users</td>
                        <td>30</td>
                        <td >70</td>
                    </tr>
                    <tr>
                        <td>ค่าใช้จ่าย</td>
                        <td>30 x ราคา G Suite Users (รายปี) </td>
                        <td >1 x ราคาเครื่อง Server (รายปี)</td>
                    </tr>
                    <tr>
                        <td>ประสบการณ์การใช้งาน</td>
                        <td>เป็นไปตามข้อกำหนดของ Plan ต่างๆ <br>ของ Google</td>
                        <td >เป็นไปตามความสามารถที่สร้างไว้เองบนเซิร์ฟเวอร์ </td>
                    </tr>
                  </tbody>
                </table>
                </center>
                <table class="hybrid-365-price visible-phone" style="font-family: 'Prompt', sans-serif;font-size: 17px;">
                  <tbody>
                    <tr>
                        <th style="border: none;"> </th>
                         <th style="text-align: center;background: #377dc1;color:#fff;font-size: 18px;"> G Suite </th>
                        <th style="text-align: center;background: #6a9fd1;color:#fff;font-size: 18px;">VPS</th>
                    </tr>
                    <tr>
                        <td>จำนวน Users</td>
                        <td>30</td>
                        <td >70</td>
                    </tr>
                    <tr>
                        <td>ค่าใช้จ่าย</td>
                        <td>30 x ราคา G Suite Users (รายปี) </td>
                        <td >1 x ราคาเครื่อง Server (รายปี)</td>
                    </tr>
                    <tr>
                        <td>ประสบการณ์การใช้งาน</td>
                        <td>เป็นไปตามข้อกำหนดของ Plan ต่างๆ ของ Google</td>
                        <td >เป็นไปตามความสามารถที่สร้างไว้เองบนเซิร์ฟเวอร์ </td>
                    </tr>
                  </tbody>
                </table>
            </div>
            <div class="row " style="margin-top: 35px;"> 
                <p  class="g-txt18 gs-content hidden-phone"  style="text-align:justify;width: 85%; margin-left: 97px;" >
                หากคุณเลือกใช้  G Suite G Suite Basics สำหรับองค์กรคุณตามตัวอย่างข้างต้น คุณจะประหยัดงบประมาณลงได้ตามการคำนวณดังต่อไปนี้ 
                </p>
                <p  class="g-txt16 gs-content visible-phone"  style="padding:10px" >
                หากคุณเลือกใช้  G Suite G Suite Basics สำหรับองค์กรคุณตามตัวอย่างข้างต้น คุณจะประหยัดงบประมาณลงได้ ตามการคำนวณดังต่อไปนี้ 
                </p>
            </div>
            <div class="row " style="margin-top: 20px;"> 
               <center>
               <table class="hybrid-365-price2 " style="font-family: 'Prompt', sans-serif;font-size: 17px;">
                  <tr>
                    <th style="border: none;"> </th>
                    <th style="background: #377dc1;text-align: center;color:#FFF;font-size: 18px;padding: 15px 0px;" >หากซื้อ  G Suite ทั้งหมด </th>
                    <th style="background: #6a9fd1;text-align: center;color:#FFF;font-size: 18px;padding: 15px 0px;" >หากซื้อโซลูชัน Hybrid G Suite</th>  
                  </tr>
                  <tr>
                    <td rowspan="2">จำนวน</td>
                    <td >100 G Suite Basics</td>
                    <td >30 G Suite Basics</td>
                    
                  </tr>
                   <tr>
                    <td>-</td>
                    <td>70 Users on VPS </td>  
                  </tr>
                  <tr>
                    <td rowspan="2">ราคาต่อหน่วย / ปี</td>
                    <td>100 Users x 1,590 บาท / ปี</td>
                    <td>30 Users x 1,590 บาท  / ปี</td>
                  </tr>
                   <tr>
                    <td>-</td>
                    <td>1 เครื่อง x 80,000 บาท / ปี</td>  
                  </tr>
                  <tr>
                    <td rowspan="2">ราคา</td>
                    <td> 159,000 บาท / ปี</td>
                    <td> 47,700 บาท / ปี </td>
                  </tr>
                   <tr>
                    <td>-</td>
                    <td>80,000 บาท / ปี</td>  
                  </tr>
                  <tr>
                    <td>ราคารวม</td>
                    <td>159,000 บาท / ปี</td>
                    <td>127,700บาท / ปี</td>
                  </tr>
                  <tr>
                    <td>ราคาต่อ User</td>
                    <td>1,590 บาท </td>
                    <td>1,277 บาท
                
                  </tr>
                  <tr>
                    <td>งบประมาณลดลง</td>
                    <td>0 %</td>
                    <td>มากกว่า 19 % </td>
                  </tr>
                </table>
                </center>
            </div>
            <div class="row "style="margin-top: 70px;margin-bottom: 60px;" >       
               <div class="span11 dynamic-content" >
                   <p style="color: #0052cd;text-align: left; font-size: 20px;">
                        <img src="https://netway.co.th/templates/netwaybysidepad/images/hybrid-domain.png" style="width: 55px;height: auto;"> 
                        Single Domain, Multi-Tenants
                        <hr class="hr-hybrid">
                   </p>
                   <p  class="g-txt18 gs-content hidden-phone"  style="text-align:justify;margin-left: 50px;line-height: 28px;" >
                   การเลือก Hybrid Email G Suite สามารถใช้ภายใต้โดเมนเดียวกัน ทำให้ External Users สามารถสีอีเมลเข้ามายังโดเมนเดียวกันขององค์กรได้ โดยไม่จำเป็นต้องแยกโดเมนเนมออก เช่น 
                   </p>
                   <p  class="g-txt16 gs-content visible-phone"  style="padding:10px;" >
                   การเลือก Hybrid Email G Suite สามารถใช้ภายใต้โดเมนเดียวกัน ทำให้ External Users สามารถสีอีเมลเข้ามายังโดเมนเดียวกันขององค์กรได้โดยไม่จำเป็นต้องแยก<br>โดเมนเนมออก เช่น
                   </p>
                   <div style="text-align: center;">
                       <img  src="/templates/netwaybysidepad/images/hybrid-gsuite-chart.jpg" style="height: auto;width: 762px;">
                   </div>
                    <p  class="g-txt18 gs-content hidden-phone"  style="text-align:justify;margin-left: 50px" >
                    โดยที่เวลาส่งออก User 1 จะส่งออกจาก Mailbox ของ G Suite และ User 2 วงออกจาก Mailbox ของเครื่อง VPS แต่ผู้รับปลายทางรับรู้ว่ามาจากโดเมนเนม @mycompany.com
                    
                   </p>
                   <p  class="g-txt16 gs-content visible-phone"  style="padding:10px;" >
                    โดยที่เวลาส่งออก User 1 จะส่งออกจาก Mailbox ของ G Suite และ User 2 วงออกจาก Mailbox ของเครื่อง VPS แต่ผู้รับปลายทางรับรู้ว่ามาจากโดเมนเนม @mycompany.com
                  
                   </p>
               </div>
            </div>
            <div class="row" style="margin-bottom: 60px;" >     
               <div class="span11 dynamic-content" >
                   <p style="color: #0052cd;text-align: left; font-size: 20px;">
                        <img src="/templates/netwaybysidepad/images/hybrid-security.png" style="width: 50px;height: auto;"> 
                        Security Benefits
                        <hr class="hr-hybrid">
                   </p>
                   <p  class="g-txt18 gs-content hidden-phone"  style="text-align:justify;margin-left: 50px;line-height: 28px;" >
                      Hybrid G Suite ใช้มาตรการตรวจจับความปลอดภัยของ G Suite กับทุก User ภายใต้โดเมนนั้นได้ โดยจะกรองอีเมลเข้าทุกฉบับ
                      <br>ผ่านระบบความปลอดภัยของ G Suite ก่อนเสมอ จากนั้นจะเลือกส่งต่อไปยัง User ที่อยู่บน Email Server ต่างๆ ต่อไป *****
                   </p>
                   <p  class="g-txt16 gs-content visible-phone"  style="padding:10px;" > 
                      Hybrid G Suite ใช้มาตรการตรวจจับความปลอดภัยของ G Suite กับทุก User ภายใต้โดเมนนั้นได้ โดยจะกรองอีเมลเข้าทุกฉบับ
                      <br>ผ่านระบบความปลอดภัยของ G Suite ก่อนเสมอ จากนั้นจะเลือกส่งต่อไปยัง User ที่อยู่บน Email Server ต่างๆ ต่อไป *****
                   </p>
                   <div style="text-align: center;">
                       <img  src="/templates/netwaybysidepad/images/hybrid-gsuite-chart2.jpg" style="height: auto;">
                   </div>
                   <p  class="g-txt18 gs-content hidden-phone"  style="text-align:justify;margin-left: 50px" >
                   ***** ในกรณีที่ MX record อยู่ที่ G Suite เท่านั้น โดยปริมาณความเหมาะสมตามจำนวน User ของทั้ง 2 Server
                   </p>
                    <p  class="g-txt16 gs-content visible-phone"  style="padding:10px;" > 
                   ***** ในกรณีที่ MX record อยู่ที่ G Suite เท่านั้น โดยปริมาณความเหมาะสมตามจำนวน User ของทั้ง 2 Server
                   </p>
               </div>
            </div>
        </div>            
    </div> <!-- end Feature gsuite  --> 
    
    <div class="row-fluid " id="PlanandPricing" style="margin-top: 0px;"> 
        <div class="container" style="margin-top: 65px; margin-bottom: 10px;">         
            <div class="row">
                <div class="span12 dynamic-content">
                    <center>
                    <h3 class="h3-title-content g-txt32 re-topic">Plan &amp; Pricing </h3>
                    <span class="nw-2018-content-line"></span>
                    </center>    
                    <p class="g-txt18 hidden-phone" style="margin: 38px 0px;line-height: 28px;">
                        Hybrid Email G Suite สามารถเริ่มต้นที่ 2 User ขึ้นไปโดยพิจารณาจากสัดส่วนของจำนวน Users ที่อยู่บนแต่ละเครื่องเป็นสำคัญ แนะนำให้ติดต่อเจ้าหน้าที่ฝ่ายขายและแจ้งจำนวน Users ทั้งหมดที่ท่านต้องการใช้ หรือสามารถเลือกจากแพ็คเกจต่อไปนี้ได้
                    </p> 
                    <p class="g-txt16 gs-content visible-phone" style="padding:10px;">  
                        Hybrid Email G Suite สามารถเริ่มต้นที่ 2 User ขึ้นไปโดยพิจารณาจากสัดส่วนของจำนวน Users ที่อยู่บนแต่ละเครื่องเป็นสำคัญ แนะนำให้ติดต่อเจ้าหน้าที่ฝ่ายขายและแจ้งจำนวน Users ทั้งหมดที่ท่านต้องการใช้ หรือสามารถเลือกจากแพ็คเกจต่อไปนี้ได้
                    </p>
                </div>
            </div>
            <div class="container span12 dynamic-content ">  
                    <div class="dynamic-content">
                        <div class="container">  
                           <div class="tab-content " style="padding: 20px 10px 40px 10px;margin-bottom: 50px;background-color: white;">
                                <div class="tab-pane active" >
                                  <div class="row" style="font-family: 'Prompt', sans-serif;">  
                                    <div class="span3">
                                        <table class="hidden-phone">
                                        <tbody>
                                        <tr>
                                        <td class="span3" height="65" style="background-color: #8BC34A;border-radius:10px 10px 0 0;text-align:center;height: 44px;">
                                        <p class="txt-price-small" style="margin-bottom: 0px;font-weight:600;color: #000000;padding: 0px 10px;">MINI</p>
                                        </td>
                                        </tr>
                                        </tbody>
                                        </table> 
                                        <div class="visible-phone plan-head" style="background-color: #8BC34A;" >
                                            <p style="font-weight:600;color: #000000;padding:5px;">MINI</p> 
                                        </div> 
                                        <div class="plan-gs" style="height: 330px; text-align: center; padding: 12px 20px 0px 20px;border-radius: 0 0 10px 10px;">
                                            <p class="color-blue-s txt-price-top" style="margin-bottom: 5px;">2-50 Users</p>                                                                         
                                             <img src="/templates/netwaybysidepad/images/Mini1.png" style="width: 69px;height: auto;margin-top: 12px;">                                          
                                            <table class="table-hover" style="color: #434343; width:100%;  font-size: 16px; text-align: left;">
                                                <tbody>
                                                <tr>
                                                <td style="padding: 9px 0 5px 0;text-align: center;font-size: 18px;color: #000000;font-weight: 600;">องค์กรขนาดเล็ก</td>
                                                </tr>
                                                <tr>
                                                <td style="padding: 5px 0 5px 0;">ที่ยังต้องการความคล่องตัวในการสลับไปมาระหว่าง G Suite และ  Email Server ทั่วไป</td>
                                                
                                                </tr>
                                                </tbody>
                                            </table>
                                            <hr style="margin-top: 0px;  margin-bottom: 0px;">      
                                            <a href="https://support.netway.co.th/hc/th/requests/new?ticket_form_id=114093963072&request_subject=%E0%B8%82%E0%B8%AD%E0%B8%82%E0%B9%89%E0%B8%AD%E0%B8%A1%E0%B8%B9%E0%B8%A5%E0%B9%80%E0%B8%9E%E0%B8%B4%E0%B9%88%E0%B8%A1%E0%B9%80%E0%B8%95%E0%B8%B4%E0%B8%A1%E0%B9%81%E0%B8%A5%E0%B8%B0%E0%B8%A3%E0%B8%B2%E0%B8%84%E0%B8%B2%20Solution%20Hybrid%20Office%20365/G%20Suite" target="_blank">
                                            <button class="btn-buy " style="margin-top: 28px;margin-bottom: 10px;padding: 12px;">ขอใบเสนอราคา<i class="fa fa-chevron-right" aria-hidden="true"></i></button>
                                            </a>
                                        </div>
                                    </div>
                                    <div class="span3"> 
                                        <table  class="hidden-phone">
                                        <tbody>
                                        <tr>
                                            <td class="span3" height="65" style="background-color: #5db2ff;border-radius:10px 10px 0 0;text-align:center;height: 44px;">
                                            <p class="txt-price-small" style="margin-bottom: 0px;font-weight:600;color: #000000;padding: 0px 10px;">    SME   </p>
                                            </td>
                                        </tr>
                                        </tbody>
                                        </table> 
                                         <div class="visible-phone plan-head" style="background-color: #5db2ff;" >
                                            <p style="font-weight:600;color: #000000;padding:5px;">SME</p> 
                                         </div> 
                                        <div class="plan-gs" style="height: 330px; text-align: center; padding: 12px 20px 0px 20px;border-radius: 0 0 10px 10px;">                                                      
                                            <p class="color-blue-s txt-price-top" style="margin-bottom: 5px;">51-100 Users</p>                                                            
                                            <img src="/templates/netwaybysidepad/images/SME.png" style="width: 66px;height: auto;margin-top: 14px;">                      
                                            <table class="table-hover" style="color: #434343; width:100%;  font-size: 16px; text-align: left;">
                                                <tbody>
                                                <tr>
                                                    <td style="padding: 11px 0 5px 0;text-align: center;font-size: 18px;color: #000000;font-weight: 600;">องค์กรทั่วไป</td>
                                                </tr>
                                                <tr>
                                                    <td style="padding: 5px 0 5px 0;">ที่ต้องการปรับเปลี่ยนระบบอีเมลและลงทุนในระดับเริ่มต้นก่อนย้ายไประบบใดระบบหนึ่งทั้งหมด</td>
                                                </tr>
                                                </tbody>
                                            </table>
                                            <hr style="margin-top: 0px;  margin-bottom: 0px;">      
                                            <a href="https://support.netway.co.th/hc/th/requests/new?ticket_form_id=114093963072&request_subject=%E0%B8%82%E0%B8%AD%E0%B8%82%E0%B9%89%E0%B8%AD%E0%B8%A1%E0%B8%B9%E0%B8%A5%E0%B9%80%E0%B8%9E%E0%B8%B4%E0%B9%88%E0%B8%A1%E0%B9%80%E0%B8%95%E0%B8%B4%E0%B8%A1%E0%B9%81%E0%B8%A5%E0%B8%B0%E0%B8%A3%E0%B8%B2%E0%B8%84%E0%B8%B2%20Solution%20Hybrid%20Office%20365/G%20Suite" target="_blank">
                                              <button class="btn-buy " style="margin-top: 28px;margin-bottom: 10px;padding: 12px;">ขอใบเสนอราคา<i class="fa fa-chevron-right" aria-hidden="true"></i></button>
                                            </a>
                                        </div>
                                    </div>
                                    <div class="span3"> 
                                        <table  class="hidden-phone">
                                            <tbody>
                                            <tr>
                                            <td class="span3" height="65" style="background-color: #1b6fff;border-radius:10px 10px 0 0;text-align:center;height: 44px;">
                                            <p class="txt-price-small" style="margin-bottom: 0px;font-weight:600;color: #000000;">MID SIZE</p>
                                            </td>
                                            </tr>
                                            </tbody>
                                        </table> 
                                        <div class="visible-phone plan-head" style="background-color:#1b6fff " >
                                            <p style="font-weight:600;color: #000000;padding:5px;">MID SIZE</p> 
                                        </div> 
                                        <div class="plan-gs" style="height: 330px; text-align: center; padding: 12px 20px 0px 20px;border-radius: 0 0 10px 10px;">    
                                            <p class="color-blue-s txt-price-top" style="margin-bottom: 5px;">101-500 Users</p>
                                            <img src="/templates/netwaybysidepad/images/MID.png" style="width: 75px;height: auto;">                                                                                                   
                                            <table class="table-hover" style="color: #434343; width:100%;  font-size: 16px; text-align: left;">
                                            <tbody><tr>
                                            <td style="padding: 2px 0 5px 0;text-align: center;font-size: 18px;color: #000000;font-weight: 600;">องค์กรขนาดใหญ่</td>
                                            </tr>
                                            <tr>
                                            <td style="padding: 5px 0 5px 0;">ที่มองหาโซลูชันที่ตอบโจทย์งบประมาณที่แปรผันตามปีโดยสามารถเปลี่ยน  Email Server ได้อย่างคล่องตัว</td>
                                            </tr>
                                            </tbody>
                                            </table>
                                            <hr style="margin-top: 0px;  margin-bottom: 0px;">      
                                            <a href="https://support.netway.co.th/hc/th/requests/new?ticket_form_id=114093963072&request_subject=%E0%B8%82%E0%B8%AD%E0%B8%82%E0%B9%89%E0%B8%AD%E0%B8%A1%E0%B8%B9%E0%B8%A5%E0%B9%80%E0%B8%9E%E0%B8%B4%E0%B9%88%E0%B8%A1%E0%B9%80%E0%B8%95%E0%B8%B4%E0%B8%A1%E0%B9%81%E0%B8%A5%E0%B8%B0%E0%B8%A3%E0%B8%B2%E0%B8%84%E0%B8%B2%20Solution%20Hybrid%20Office%20365/G%20Suite" target="_blank">
                                            <button class="btn-buy " style="margin-top: 7px;margin-bottom: 10px;padding: 12px;">ขอใบเสนอราคา<i class="fa fa-chevron-right" aria-hidden="true"></i></button>
                                            </a>
                                        </div>
                                    </div>
                                    <div class="span3"> 
                                        <table  class="hidden-phone"> 
                                            <tbody>
                                            <tr>
                                            <td class="span3" height="65" style="background-color:rgb(226, 137, 60);border-radius:10px 10px 0 0;text-align:center;height: 44px;">
                                            <p class="txt-price-small" style="margin-bottom: 0px;font-weight:600;color: #000000;">ENTERPRISE</p>
                                            </td>
                                            </tr>
                                            </tbody>
                                            </table> 
                                             <div class="visible-phone plan-head" style="background-color:rgb(226, 137, 60) " >
                                              <p style="font-weight:600;color: #000000;padding:5px;">ENTERPRISE</p> 
                                           </div> 
                                        <div class="plan-gs" style="height: 330px; text-align: center; padding: 12px 20px 0px 20px;border-radius: 0 0 10px 10px;">  
                                            <p class="color-blue-s txt-price-top" style="margin-bottom: 5px;">500+ Users</p>                                                           
                                            <img src="/templates/netwaybysidepad/images/Enterprise.png" style="width: 66px;height: auto;margin-top: 5px">                                    
                                            <table class="table-hover" style="color: #434343; width:100%;  font-size: 16px; text-align: left;">
                                                <tbody>
                                                <tr>
                                                  <td style="padding: 7px 0 5px 0;text-align: center;font-size: 18px;color: #000000;font-weight: 600;">องค์กรหลายสาขา</td>
                                                </tr>
                                                <tr>
                                                  <td style="padding: 5px 0 5px 0;">ที่ต้องการลงทุนระยะยาวกับเครื่องเซิร์ฟเวอร์ประเภท Dedicated Server ร่วมกับ Cloud Service ต่างๆ</td>  
                                                </tr>
                                                </tbody>
                                            </table>
                                            <hr style="margin-top: 0px;  margin-bottom: 0px;">      
                                            <a href="https://support.netway.co.th/hc/th/requests/new?ticket_form_id=114093963072&request_subject=%E0%B8%82%E0%B8%AD%E0%B8%82%E0%B9%89%E0%B8%AD%E0%B8%A1%E0%B8%B9%E0%B8%A5%E0%B9%80%E0%B8%9E%E0%B8%B4%E0%B9%88%E0%B8%A1%E0%B9%80%E0%B8%95%E0%B8%B4%E0%B8%A1%E0%B9%81%E0%B8%A5%E0%B8%B0%E0%B8%A3%E0%B8%B2%E0%B8%84%E0%B8%B2%20Solution%20Hybrid%20Office%20365/G%20Suite" target="_blank">
                                            <button class="btn-buy " style="margin-top: 6px;margin-bottom: 11px;padding: 12px;">ขอใบเสนอราคา<i class="fa fa-chevron-right" aria-hidden="true"></i></button>
                                            </a>
                                        </div>
                                    </div>
                                  </div>
                                </div>   
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div><!-- end Plan & Pricing  gsuite -->
 </div> 
<div class="row-fluid "  style="margin-top: 0px;"  id="faq"> 
    <div class="container" style="padding: 0px 30px 0px 30px;">      
        <div class="span12 dynamic-content bg-gs-w ">   
            {php}
            if(count($faqHybrid)){  
                echo '<center><h3 class="h3-title-content g-txt32 " style="color: #0052cd; font-weight: 300; ">'.$faqHybrid['title'].'</h3>
                <span class="nw-2018-content-line" style="margin-bottom: 30px;">
                </center>';   
                echo $faqHybrid['body'];    
                }
            {/php}
        </div>
    </div>
</div>