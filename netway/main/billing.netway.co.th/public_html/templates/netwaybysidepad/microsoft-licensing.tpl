{php}
$templatePath   = $this->get_template_vars('template_path');
include($templatePath . 'kb.tpl.php');
{/php}
{php}
                
                
                $DatasheetSection =   $db->query("SELECT s.name as sectionName , a.kb_article_id , a.title , c.name as cat_name
                                        FROM 
                                            hb_kb_article a , hb_kb_section s , hb_kb_category c
                                        WHERE 
                                            a.kb_section_id = s.kb_section_id
                                        AND s.kb_section_id = 360000456911  
                                        AND s.kb_category_id = c.kb_category_id
                                        ")->fetchAll();
              $licensepromo  = $db->query("SELECT s.name as section_name ,c.name as category_name, a.kb_article_id , a.title,a.path,a.share_image
                    ,s.path as section_path,a.kb_article_id,c.path as category_path
                    FROM hb_kb_article a , hb_kb_section s , hb_kb_category c 
                    where a.kb_section_id = s.kb_section_id 
                    AND s.kb_category_id = c.kb_category_id 
                    AND s.kb_category_id = 360000193252
                    AND a.kb_section_id  = 360000450812                     
                    ORDER BY a.add_time DESC   
                    ")->fetch();  
        {/php}

<script src="{$template_dir}js/tabs.js"  type="text/javascript"></script>   
<!-- ******************** Start AddThis ******************** -->
<div class="pathway-inpage">
    {include file='addthis.tpl'}
</div>
<!-- ******************** End AddThis ******************** -->
{literal}
    <style>
    section.hero {
               
                background-color: #d2940894;
                background-position: top center;
                background-repeat: no-repeat;
                padding: 0 20px;
                text-align: center;
                height: 400px;
                width: 100%;
                background: url('https://netway.co.th/templates/netwaybysidepad/images/bg-microsoft-licensing.png');
                background-repeat: no-repeat;
                background-size: cover;
                background-attachment: fixed;
                background-position: center;
    
            }     
         .licen-topic{
            color: #0052cd; 
            font-weight: 300; 
            font-family: 'Prompt', sans-serif;
        }      
            
        .re-txt-banner {
            font-size: 38px;
            font-family: 'Prompt', sans-serif; 
            font-style: normal;
            line-height: 40px;
            font-weight: 900;
            color: #fff;
            letter-spacing: 2px;
            margin-top: 140px;

        }
        
        .font-special-txt{
            font-family: Roboto,Arial, sans-serif;
            font-size: 20px;
            line-height: 30px;
            font-weight: 100; 
            
        }

        .re-topic{
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
    div.payment-div-visible-phone{
        float: left;
        width: 150px;
        padding: 20px 0px 20px 0px;
    }
       a.cer{
         color:#000;
       } 
       a.cer:hover{
           color:#0052cd;
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

    <section class="section hero">
        <div class="container" >
            <div class="row hidden-phone" >
        
                   <div class="hero-inner">
                        <h2 class="re-txt-banner">ทำอย่างไรลิขสิทธิ์ Windows และ Officeถึงจะถูกต้อง</h2>          
                                               

                </div>
            </div>
             <div class="row visible-phone" >
        
                   <div class="hero-inner">
                        <h2 class="re-txt-banner" style="margin-top: 70px;letter-spacing: 1px; font-size: 23px;text-align: left;line-height: 30px;"> 
                       ทำอย่างไรลิขสิทธิ์ Windows และ Officeถึงจะถูกต้อง
                        </h2>          
                         <a href="https://docs.google.com/a/netwaygroup.com/forms/d/e/1FAIpQLSfkiDjNMTUR3NOcI98cDTLhm-DBYP_EyxHkAxdqRGjfpIQ7vg/viewform">
                           <button class="nw-kb-btn-ticket" type="submit"><i class="fa fa-edit"></i>&nbsp;Check Now</button>
                         </a>                        

                </div>
            </div>
        </div>
    </section>

 <section id="customTab" style="margin-top: 0px;   background-color:#4489FF;">
        <div class="dynamic-menu hidden-phone  container " style="background-color: #4489FF; width: 100%;">
           <div class="container">
            <ul class="dynamic-nav " >
                
                <li class="dynamic-nav"><a class="dynamic-nav " href="#whyLicense" >Why License Checkup?</a></li>
                <li class="dynamic-nav"><a class="dynamic-nav " href="#howto">How TO License Checkup?</a></li>
                <li class="dynamic-nav"><a class="dynamic-nav " href="#Competencies">Certified Competencies</a></li>     
                <li class="dynamic-nav"><a class="dynamic-nav " href="#Professionals">Certified Professionals</a></li> 
                <li class="dynamic-nav"><a class="dynamic-nav " href="#Partner">Microsoft Partner Level</a></li> 
                <li class="dynamic-nav"><a class="dynamic-nav " href="#Authorized">Microsoft Authorized</a></li> 
                <li class="dynamic-nav"><a class="dynamic-nav " href="#plan">Plan & Pricing</a></li>
                
                <li class="dynamic-nav"><a class="dynamic-nav " href="#"></a></li>
            </ul>
            </div>
        </div>
</section>


  <div class="row-fluid" id="whyLicense"  style="background-color: #fff;"> 
      <div class="container"style="margin-top: 80px;" >         
            <div class="row">
               <div class="span12 dynamic-content"   >
             <center>
                 <h3 class="h3-title-content g-txt32 re-topic" >WHY License Checkup?</h3>
             <span class="nw-2018-content-line" style="margin-bottom: 30px;"></span></center>          
               </div>
               
            </div>
            </div>
             <div class="container"> 
            <div class="row " style="padding: 20px 0px 0px 20px; margin-top: 10px;">
                <div class="span12 dynamic-content"   >
                   <div class="span7"  style="margin-top: 67px;margin-left: 0px;"> 
                        <p class="g-txt22" >COMPLIANCE</p>
                        <br/>
                        <p class="font-special-txt g-txt16">
                            
                            <br>ใช้งานซอฟต์แวร์ลิขสิทธิ์อย่างถูกต้อง ไม่ผิดกฎหมาย และไม่ตกเป็นผู้ละเมิดทรัพย์สินทางปัญญา โดยใช้เครื่องมือในการบริหารจัดการ Software License ของ Microsoft และบริการจาก SAM Certified Speacialist
                        </p>
                    </div>
                    <div class="span5 ">   
                        <img src="https://netway.co.th/templates/netwaybysidepad/images/icon-microsoft-licensing-2018-1.png" alt="COMPLIANCE<" width="250" height="250">
                    </div>
                    
                </div>    
             </div>
             <hr/>
             <div class="row " style="padding: 20px 0px 0px 20px; margin-top: 10px;">
                <div class="span12 dynamic-content"   >
                    <div class="span5"> 
                       <img src="https://netway.co.th/templates/netwaybysidepad/images/icon-microsoft-licensing-2018-2.png" alt="EASE OF USE" width="250" height="250">
                    </div>
                    <div class="span7 "style="margin-top: 67px;">   
                        <p class="g-txt22" >EASE OF USE</p>
                        <br/>
                         <p class="font-special-txt g-txt18">
                             <br>วิเคราะห์ทางเลือกและจัดซื้อซอฟต์แวร์จากช่องทางที่ถูกที่สุด หลังจากที่คุณใช้บริการ License Check-up แล้วจะได้ตัวเลือกในการซื้อ License ที่ถูกที่สุดเสมอ
                        </p>
                    </div>
                    
                </div>    
             </div>
             <hr/>
             <div class="row " style="padding: 20px 10px 50px 20px; ">
                <div class="span12 dynamic-content"   >
                   
                    <div class="span7"  style="margin-top: 67px;margin-left: 0px;"> 
                      <p class="g-txt22" >SECURITY</p>
                        <br/>
                        <p class="font-special-txt g-txt16">
                            <br>ซอฟต์แวร์ Microsoft License ทั้งหมดมีระบบอัพเดทความปลอดภัยที่มั่นใจได้และประกันว่าคุณจะไม่โดนโจมตีโดยภัยคุกคามใหม่ๆ
                       </p>
                    </div>
                     <div class="span5 ">   
                        <img src="https://netway.co.th/templates/netwaybysidepad/images/icon-microsoft-licensing-2018-3.png" alt="SECURITY" width="250" height="250">
                    </div>
                </div>    
             </div>
         
       </div>
  </div>
  <div class="row-fluid" style="background-color: #5C2D91;"> 
 <div class="container">
    <div class="row " style="padding: 20px 0px 0px 20px; margin-top: 10px; height: 390px;">
                <div class="span12 dynamic-content">
                    <center>
                    <div class="span12 ytp-cued-thumbnail-overlay"  style="margin-left: 0px;"> 
                       <iframe width="560" height="315" src="https://www.youtube.com/embed/j7vnEHuWeFs?rel=0&amp;showinfo=0" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen style="
                        margin-top: 20px;
                        margin-bottom: 30px;">
                        </iframe>
                    </div>  
                </center>
                </div>    
             </div>
 </div>
 </div>
  <div class="row-fluid" id="howto" style="background-color: #E8EAF6;"> 
        <div class="container"  style="margin-top: 70px;"> 
            <div class="row">
               <div class="span12 dynamic-content"   >
                 <center><h3 class="h3-title-content g-txt32 re-topic">HOW TO License Checkup?</h3>
                 <span class="nw-2018-content-line" style="margin-bottom: 30px;"></span></center>          
               </div>
            </div>
             <div class="row">
               <div class="span12 "   >            
                  <p class=" g-txt16">
                     บริการ MS License Checkup คือการแนะนำ License Base ของคุณและการันตีด้วย Report & Certificate ที่สามารถนำไปใช้กับกระบวนการ ISO/IEC 19770 ได้ตามมาตรฐานสากล รวมทั้งใช้อ้างอิงกับ Auditor ได้ด้วย
                  </p>
                      
               </div>
            </div>
          </div>
       <div class="container" style=" margin-bottom: 50px;">
           <div class="row" style="margin: 10px 10px 10px 10px;" >
            <div class="span4 div-whynetway">
                <center>
                    <img src="https://netway.co.th/templates/netwaybysidepad/images/icon-licensing.png" alt="Order License Checkup Service" width="150" height="150">
                    <p class="title-why-netway g-txt22">1.Order License Checkup Service</p>
                    <hr class="hr-whynetway"> 
                </center>  
                <p class="nw-content g-txt16" style="margin-top: 20px;">
                    เข้าถึงหน้าสั่งซื้อของ netway.co.th แล้วเลือกลง Cart หรือสั่งซื้อที่นี่ 
                </p>
               
            </div>
             <div class="span4 div-whynetway">
                <center>
                <img src="https://netway.co.th/templates/netwaybysidepad/images/icon-licensing-2.png" alt="Pay for Fee" width="150" height="150">
                <p class="title-why-netway g-txt22">2.Pay for Fee</p>
                <hr class="hr-whynetway"> 
                </center>  
                <p class="nw-content g-txt16" style="margin-top:20px;  ">
                    ชำระค่าธรรมเนียมในการแนะนำและวิเคราะห์หรือใส่ Promo Code
                </p>
            </div>
            <div class="span4 div-whynetway" >
                <center>
                  <img src="https://netway.co.th/templates/netwaybysidepad/images/icon-licensing-3.png" alt="Get a Certified Report" width="150" height="150">
                    <p class="title-why-netway g-txt22">3.Get a Certified Report</p>
                    <hr class="hr-whynetway"> 
                </center>  
                <p class="nw-content g-txt16" style="margin-top:20px;">
                    หลังจากทีม Specialist ดำเนินการแล้ว คุณจะได้รับ Certified Report เป็นข้อมูลอ้างอิงได้ทันที
                </p>     
            </div>
          </div>
          <div class="row">
               <div class="span12 dynamic-content"   >            
                    <h3  style="text-align: center;">
                    <a href="https://drive.google.com/file/d/1Zj42GvblUdfJTOuTWXnLZ0UIxa80gF0t/view?usp=sharing" class="nw-kb-btn-ticket" style=" text-decoration: none; font-weight: 200;  margin-top: 50px;">
                   ดู sample report ที่นี่ 
                  </a>
                    </h3>  
               </div>
            </div>
         </div>
    </div>     


 <div class="row-fluid white-nw-2018"  id="Competencies"  style="background-color: #FFF;" > 
     <div class="container"  style="margin-top: 50px;">
        <div class="row">
           <div class="span12" style="padding: 0px 10px 0px 10px;">
             <center><h3 class="h3-title-content g-txt32 re-topic" >SAM Certified Competencies</h3>
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
                   <center><h3 class="h3-title-content g-txt32 re-topic">
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
                   <center><h3 class="h3-title-content g-txt32 re-topic">Microsoft Partner Level</h3>
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
                   <center><h3 class="h3-title-content g-txt32 re-topic">
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
  
  <div class="row-fluid" id="plan" style="background-color: #fff"> 
        <div class="container" style="margin-top: 60px;" > 
            <div class="row">
               <div class="span12 dynamic-content"   >
             <center><h3 class="h3-title-content g-txt32 re-topic">
                        Plan & Pricing
                    </h3>
                    <span class="nw-2018-content-line" style="margin-bottom: 30px;"></span>
            </center>          
               </div>
            </div>
          </div>
          <div class="container" >
             <div class="row" style="margin: 0px 10px 40px 10px;" >
                <div class="span3 div-regisreseller hidden-phone" style="background-color: #df4012;padding: 30px 11px 30px 10px;height: 420px;">
                    <center>
                        <div>
                            <p class="g-txt22" style="color:#fff" >1-30 PC</p>
                            <hr class="hr-whynetway"style="height: 3px;">
                        </div>
                    </center>  
                    <p class=" g-txt16"  style="margin-top:20px;margin-left: 8px; color:#fff">
                       License Check-up 30 max
                    <p class=" g-txt16"  style="margin-top:20px;margin-left: 8px; color:#fff">
                        บริการตรวจเช็คความถูกต้องของ Microsoft License สำหรับองค์กรจำนวน 1-30 PC 
                     </p>  
                      <p class="g-txt16"  style="margin-top:20px;margin-left:3px;color:#fff">
                        ตรวจสอบด้วยโปรแกรม MAP Toolkit 
                     </p>   
                      <p class="g-txt16"  style="margin-top:20px;margin-left: 3px;color:#fff">
                        รองรับ Cloud Auditing 
                     </p>   
                      <p class=" g-txt16"  style="margin-top:20px;margin-left: 3px;color:#fff">
                        รับรองผลถูกต้อง 100%
                     </p>   
                      <p class="g-txt18"  style="margin-top:20px;margin-left: 3px;color:#fff;text-align: center;">
                        <br/><br/>4,700 บาท
                     </p>      
                </div>
                
                
                 <div class="span3 div-regisreseller" style="background-color: #6da105;padding: 30px 11px 30px 10px;height: 420px;">
                    <center>
                        <div>
                            <p class="g-txt22" style="color:#fff" >31-75 PC</p>
                            <hr class="hr-whynetway" style="height: 3px;">
                        </div>
                    </center>  
                   <p class=" g-txt16"  style="margin-top:20px;margin-left: 8px; color:#fff">
                        License Check-up 75 max
                    <p class=" g-txt16"  style="margin-top:20px;margin-left: 8px; color:#fff">
                       บริการตรวจเช็คความถูกต้องของ Microsoft License สำหรับองค์กรจำนวน 31-75 PC
                     </p>  
                      <p class="g-txt16"  style="margin-top:20px;margin-left:3px;color:#fff">
                        ตรวจสอบด้วยโปรแกรม MAP Toolkit
                     </p>   
                      <p class="g-txt16"  style="margin-top:20px;margin-left: 3px;color:#fff">
                        รองรับ Cloud Auditing 
                     </p>   
                      <p class=" g-txt16"  style="margin-top:20px;margin-left: 3px;color:#fff">
                        รับรองผลถูกต้อง 100%
                     </p>   
                      <p class="g-txt18"  style="margin-top:20px;margin-left: 3px;color:#fff;text-align: center;">
                        <br/><br/>9,500 บาท
                     </p>      
                </div> 

                <div class="span3 div-regisreseller" style="background-color: #2590e7;padding: 30px 11px 30px 10px;height: 420px;">
                    <center>
                        <div>
                            <p class="g-txt22" style="color:#fff" >76-200 PC</p>
                            <hr class="hr-whynetway" style="height: 3px;">
                        </div>
                    </center>  
                    <p class=" g-txt16"  style="margin-top:20px;margin-left: 8px; color:#fff">
                       License Check-up 200 max
                    <p class=" g-txt16"  style="margin-top:20px;margin-left: 8px; color:#fff">
                        บริการตรวจเช็คความถูกต้องของ Microsoft License สำหรับองค์กรจำนวน 76-200 PC
                     </p>  
                      <p class="g-txt16"  style="margin-top:20px;margin-left:3px;color:#fff">
                        ตรวจสอบด้วยโปรแกรม MAP Toolkit และ/หรือ System Center Configuration Manager
                     </p>   
                      <p class="g-txt16"  style="margin-top:20px;margin-left: 3px;color:#fff">
                        รองรับ Cloud Auditing 
                     </p>   
                      <p class=" g-txt16"  style="margin-top:20px;margin-left: 3px;color:#fff">
                        รับรองผลถูกต้อง 100%
                     </p>   
                      <p class="g-txt18"  style="margin-top:20px;margin-left: 3px;color:#fff;text-align: center; ">
                        14,500 บาท
                     </p>      
                </div> 
               <div class="span3 div-regisreseller " style="background-color: #eda606;padding: 30px 11px 30px 10px;height: 420px;" >
                    <center>
                        <div>
                            <p class="g-txt22" style="color:#fff" >201-250 PC</p>
                            <hr class="hr-whynetway"style="height: 3px;">
                        </div>
                    </center>  
                   <p class=" g-txt16"  style="margin-top:20px;margin-left: 8px; color:#fff">
                      License Check-up 250 max
                    <p class=" g-txt16"  style="margin-top:20px;margin-left: 8px; color:#fff">
                       บริการตรวจเช็คความถูกต้องของ Microsoft License สำหรับองค์กรจำนวน 201-250 PC
                     </p>  
                      <p class="g-txt16"  style="margin-top:20px;margin-left:3px;color:#fff">
                        ตตรวจสอบด้วยโปรแกรม MAP Toolkit และ/หรือ System Center Configuration Manager
                     </p>   
                      <p class="g-txt16"  style="margin-top:20px;margin-left: 3px;color:#fff">
                        รองรับ Cloud Auditing 
                     </p>   
                      <p class=" g-txt16"  style="margin-top:20px;margin-left: 3px;color:#fff">
                        รับรองผลถูกต้อง 100%
                     </p>   
                      <p class="g-txt18"  style="margin-top:20px;margin-left: 3px;color:#fff;text-align: center;">
                        23,500 บาท
                     </p>      
                </div>   
           </div>
           <div class="row">
             <div class="span12">
                 <p class="g-txt16" style="margin-left: 3px;">*ราคาไม่รวมภาษีมูลค่าเพิ่ม 7%</p>
             </div>
        </div>
           <div class="row">
            <div class="span4" style="width: 380px;margin-top: 10px;font-size: 19px;line-height: 24px;  padding: 0px 10px 10px 10px;">
                <span>ติดต่อสอบถามว่ามีอะไรใหม่เกี่ยวกับ Office เวอร์ชั่นล่าสุดนี้ได้ตลอดเวลาเลยนะคะ</span> 
            </div> 
            <div class="span4" style="width:250px;">
                <img src="https://netway.co.th/templates/netwaybysidepad/images/tel.png" alt="office365" style="padding: 20px 10px 20px 10px;width: 60px;">  
                <span class="txtorange">Tel :</span> 029122558
            </div>
            <div class="span4" style="width:300px;">
                <img src="https://netway.co.th/templates/netwaybysidepad/images/mail.png" alt="office365"style="padding: 20px 10px 20px 10px;width: 60px;">
                <span class="txtorange">E-mail :</span> <a href="mailto:nwteam@netway.co.th" style="color:#333333;">support@netway.co.th</a>
                </div>
        </div>
      </div>     
  </div>
  
  
  <div class=class="row-fluid" id="promo" > 
      <div class="container"style="margin-top: 70px;" >
           <div class="row">
             <center><h3 class="h3-title-content g-txt32 re-topic">Promo</h3>
             <span class="nw-2018-content-line" style="margin-bottom: 30px;"></span></center>  
           </div>
            <div class="row ">
                    <div class="span6">   
                     <dir  class="txt-tech-kb" >  
                          <img src="https://support.netway.co.th/hc/article_attachments/360003423551/Landin_page_Banner.png" style="height: 200px;width: 350px;border-radius: 5px;">
                      </dir>  
 
                </div>
                
                <div class="span6">  
                     <p style="font-size: 18px;font-family: Roboto, Arial, sans-serif;">ขอเชิญร่วมฟังบรรยาย "จ่ายแล้วไม่เจ็บ หรือเจ็บที่ต้องจ่าย" ในวันที่ 27 เม.ย. 2561 ณ สำนักงานบริษัท Netway Communication  ชั้น 2</p> 
                     <a href="/kb/MS License Checkup/PROMOTION (โปรโมชั่น)/360002682892-ขอเชิญร่วมฟังบรรยาย "จ่ายแล้วไม่เจ็บ หรือเจ็บที่ต้องจ่าย" ในวันที่ 27 เม.ย. 2561 ณ สำนักงานบริษัท Netway Communication  ชั้น 2"><button class="btn-readmore-2018" style="margin-top: 10px;">อ่านเพิ่มเติม</button></a>
               </div>
                
              
            </div>
        </div>
   </div>
  
  
    <div class="row-fluid">
        <div class="span12 dynamic-content list-datasheet bg-gs-w hidden-phone " id="datasheet" style="margin-top: 0px;">
          <div class="container">
            {php}
               
                echo '<center><h3 class="h3-title-content g-txt32" style="color: #0052cd; font-weight: 300;">' . $DatasheetSection[0]['sectionName'] . '</h3><span class="nw-2018-content-line "></center>';
                echo '<ul style="margin-top: 50px;">';
                  
                foreach($DatasheetSection as $value){
                    echo '<li><a class="show-section-content" id="'.$value['kb_article_id'].'" href="'.$caUrl.'/kb/'.$value['cat_name'].'/'.$value['sectionName'].'/'.$value['kb_article_id'].'-'.$value['title'].'">'. $value['title'];
                    echo '</a></li>';
                    echo '<hr class="hr-faq">';
                }
                echo '</a></li>';
                echo '</ul>';
            {/php}
          </div>
        </div> 

        <div class="span12 show-sr-content" style="display: none; padding: 20px 0 0 20px"></div>
        <div class="modal fade" id="articleModal" role="dialog">
            <div class="modal-dialog modal-lg">
              <div class="modal-content">
                <div class="modal-header">
                  <h4 class="modal-title">Modal Header</h4>
                </div>
                <div class="modal-body">
                  <p>This is a large modal.</p>
                </div>
                <div class="modal-footer">
                  <button type="button" class="btn btn-default" data-dismiss="modal">ปิด </button>
                </div>
              </div>
            </div>
          </div>
        </div>
  
  
  
  
  
        
  
{include file='notificationinfo.tpl'}
