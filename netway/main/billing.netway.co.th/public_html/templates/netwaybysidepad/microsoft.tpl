{php}
$templatePath   = $this->get_template_vars('template_path');
include($templatePath . 'kb.tpl.php');
{/php}
{literal}

  <script>
    AOS.init({
      easing: 'ease-in-out-sine'
    });
  </script>
{/literal}  
<script src="{$template_dir}js/tabs.js"  type="text/javascript"></script>   
<!-- ******************** Start AddThis ******************** -->
<div class="pathway-inpage">
    {include file='addthis.tpl'}
</div>
<!-- ******************** End AddThis ******************** -->
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
   <script>
            $(() => {
                'use strict';
                $('button').click(function() {
                    $(this).toggleClass('pressed');
                });
            });
            
            $(".single-item").slick({
                dots: true,
              infinite: true,
            slidesToShow: 1,
            slidesToScroll:1,
            cssEase: "ease",
            autoplay: true,
            autoplaySpeed: 3000,
            });

  </script>
{/literal}
        <div class="hero-ms-2018  hidden-phone"  >
         <div style=" background: rgba(0, 0, 0, 0.5); height: 430px;" >
         <div class="container">
            <div class="row-fluid hidden-phon"  >
                   <div class="span4"></div>
                   <div class="span4"></div>
                   <div class="span4"  style="text-align: right;"><img src="https://netway.co.th/templates/netwaybysidepad/images/Microsoft_logo_white-min.png"   style=" width: 160px;
    margin-top: 60px;" /> </div>
      </div>
      </div>
       <div class="row-fluid hidden-phon"  >
                   <div class="span12 hero-inner">
              
                      <div style="margin-top: 35px; text-align: center;">                     
                        <h2 class="re-txt-banner"  style="font-size: 40px; line-height: 52px;"> มากกว่า 20,000 องค์กรทั่วโลกไว้วางใจใช้ <br/>บริการ Microsoft ผ่าน Netway   </h2>
                        
                        <a href="https://support.netway.co.th/hc/th/requests/new?ticket_form_id=114093963072&request_subject= สอบถามเกี่ยวกับ Microsoft
 &request_custom_fields_114095596292=sales_opt_microsoft"><button class="btn-banner-cloud" type="submit">ติดต่อสอบถาม</button></a>   
                      </div>  
                  </div>
            </div>
            </div>
        </div>

    
        <div class="  hero-ms-2018  visible-phone" >
            <div class="row-fluid modal-hero-height"  style="background: rgba(0, 0, 0, 0.5);" >
        
                   <div class="hero-inner">
                      <div style="margin-top: 80px; text-align: center;">                     
                         <h2 class="re-txt-banner"  style="font-size: 40px; line-height: 52px;"> มากกว่า 20,000 องค์กรทั่วโลกไว้วางใจใช้ <br/>บริการ Microsoft ผ่าน Netway   </h2>
                        <center><hr style="width: 10%; margin: 10px 0 16px;"/></center>      
                        <a href="https://support.netway.co.th/hc/th/requests/new?ticket_form_id=114093963072&request_subject= สอบถามเกี่ยวกับ Microsoft
 &request_custom_fields_114095596292=sales_opt_microsoft"><button class="btn-banner-cloud" type="submit">ติดต่อสอบถาม</button></a>   
                      </div>  
                </div>
            </div>
  
        </div>

    
        

<div class="row-fluid "  id="Features" >
      <div class="container  " style=" padding: 70px 0px 0px 20px;" >      
            <div class="row">
               <div class="span12 dynamic-content">
                 <center>
                   <img src="https://netway.co.th/templates/netwaybysidepad/images/MPN_logo-min.png"  style="margin-bottom: 20px;margin-top: -50px; width: 700px;" />
                 </center>          
                </div>
            </div>
       
 </div>
 
 <div class="container  " style=" padding: 0px 0px 100px;" >      
       
             <div class="row">
                  <div class="span dynamic-content g-txt16 gs-content " style="text-align: center; line-height: 25px; padding: 0px 20px 0 20px;" >      
                 Netway Communication คือ Authorized CSP Partner ของ Microsoft อย่างเป็นทางการ สิทธิพิเศษที่ลูกค้า Netway จะได้รับคือ เรามีทีมงานที่มีความเชี่ยวชาญทั้งการใช้งาน ติดตั้ง และบริการ พร้อมให้การสนับสนุนคุณแบบ 24 ชั่วโมงทุกวัน คุณยังได้รับโปรโมชันผลิตภัณฑ์จาก Microsoft ในราคาพิเศษสุด อีกทั้งเรายังรับประกันความพึงพอใจตลอดอายุการใช้งาน เรายินดีให้คำปรึกษาการเลือกใช้งานว่าองค์กรของคุณเหมาะที่จะใช้งานผลิตภัณฑ์ใดเพื่อให้ตรงกับความต้องการของคุณ  <a href="https://support.netway.co.th/hc/th/requests/new?ticket_form_id=114093963072&amp;request_subject=%20%E0%B8%AA%E0%B8%AD%E0%B8%9A%E0%B8%96%E0%B8%B2%E0%B8%A1%E0%B9%80%E0%B8%81%E0%B8%B5%E0%B9%88%E0%B8%A2%E0%B8%A7%E0%B8%81%E0%B8%B1%E0%B8%9A%20Microsoft&amp;request_custom_fields_114095596292=sales_opt_microsoft&amp;_ga=2.159696189.1286870241.1536476298-593851065.1525956799"> ติดต่อเราเลย</a>
                 </div>
             </div>
</div>
</div>
<div class="row-fluid" style="margin-bottom: 180px;" > 
  <div class="container">
          <div class="row" style="margin-top: 20px; margin-bottom: 40px;">
               <div class="span12 dynamic-content">
                 <center>
                        <h3 class="h3-title-content g-txt32 re-topic" >Microsoft Products </h3>
                        <span class="nw-2018-content-line" ></span>
   
                 </center>
                </div>   
           </div>
            <div class="row" >
               <a href="https://netwaystore.in.th/windows10">
               <div class="span3"><button class="g-txt18" style="background-color: transparent; border:  transparent; padding: 10px 10px 10px 10px; color: #0078d7;"><img src="https://netway.co.th/templates/netwaybysidepad/images/ikb-ms-Windows-.png" alt="Windows 10" style="width: 32px; margin-right: 5px;"/>Windows 10 </button></div></a>
               <a href="https://netwaystore.in.th/windows-server"><div class="span3"><button class="g-txt18" style="background-color: transparent; border:  transparent; padding: 10px 10px 10px 10px; color: #00188f;"><img src="https://netway.co.th/templates/netwaybysidepad/images/ikb-Windows+Server.png" alt="Windows Server" style="width: 32px; margin-right: 5px;"/> Windows Server</button></div></a>
               <a href="https://netway.co.th/azure"><div class="span3"><button class="g-txt18" style="background-color: transparent; border:  transparent; padding: 10px 10px 10px 10px; color: #0078d7;"><img src="https://netway.co.th/templates/netwaybysidepad/images/ikb-MicrosoftAzure.png" alt="Microsoft Azure" style="width: 43px; margin-right: 5px;"/> Microsoft Azure </button></div></a>
               <a href="https://netway.co.th/dynamics365"><div class="span3"><button class="g-txt18" style="background-color: transparent; border:  transparent; padding: 10px 10px 10px 10px; color: #00188f;"><img src="https://netway.co.th/templates/netwaybysidepad/images/ikb-microsoft-dynamics.png" alt="Dynamics 365" style=" width: 32px; margin-right: 5px;"/>Dynamics 365</button></div></a>
            </div>
            
            <div class="row" >
               <a href="https://netwaystore.in.th/microsoft-exchange-server"><div class="span3 "><button class="g-txt18" style="background-color: transparent; border:  transparent; padding: 10px 10px 10px 10px; color: #0776C7;"><img src="https://netway.co.th/templates/netwaybysidepad/images/ikb-Windows-Exchange.png" alt="Office2016" style=" width: 32px; margin-right: 5px;"/>Windows Exchange</button></div></a>
               <a href="https://netwaystore.in.th/microsoft-sql-server"><div class="span3"><button class="g-txt18" style="background-color: transparent; border:  transparent; padding: 10px 10px 10px 10px; "><img src="https://netway.co.th/templates/netwaybysidepad/images/ikb-WindowsSQLServer.png" alt="Office2016" style=" width: 32px; margin-right: 5px;"/>Windows SQL Server</button></div></a>
               <a href="https://netway.co.th/office365" ><div class="span3"><button class="g-txt18"   style="background-color: transparent; border:  transparent; padding: 10px 10px 10px 10px; color: #0045a0;;"><img src="https://netway.co.th/templates/netwaybysidepad/images/microsoft365-newlogo.png" alt="Microsoft 365" style=" width: 37px; margin-right: 17px;"/>Microsoft 365</button></div></a>
               <a href="https://netwaystore.in.th/office2019" ><div class="span3"><button class="g-txt18"  style="background-color: transparent; border:  transparent; padding: 10px 10px 10px 10px; color: #F36523;"><img src="https://netway.co.th/templates/netwaybysidepad/images/ikb-office2016.png" alt="Office2016" style=" width: 32px; margin-right: 5px;"/>Office 2019</button></div></a>
               
               
            </div>
            
              <div class="row" >
               <a href="#"><div class="span3" title="Coming Soon"><button class="g-txt18" style="background-color: transparent; border:  transparent; padding: 10px 10px 10px 10px; color: #F36523; -webkit-filter: grayscale(100%);"><img src="https://netway.co.th/templates/netwaybysidepad/images/ikb-ms-project.png" alt="Microsoft Project" style=" width: 32px; margin-right: 5px;"/>Project</button></div></a>
                <a href="#"><div class="span3" title="Coming Soon"><button class="g-txt18" style="background-color: transparent; border:  transparent; padding: 10px 10px 10px 10px; color: #F36523;   -webkit-filter: grayscale(100%);"><img src="https://netway.co.th/templates/netwaybysidepad/images/ikb-ms-visio.png" alt="Microsoft Visio" style=" width: 32px; margin-right: 5px;"/>Visio</button></div></a>
               <div class="span3"> </div>
               <div class="span3"> </div>
            </div>
            
           
          
      
   </div>
</div>    

<div class="row-fluid " style=" color: #193441; background-color: #f2f2f2;"  >
      <div class="container  " style=" padding: 70px 0px 70px 0px;" >  
      
           <div class="row" style="margin-top: 20px; margin-bottom: 40px;">
               <div class="span12 dynamic-content">
                 <center>
                        <h3 class="h3-title-content g-txt32 re-topic" > Why Netway </h3>
                        <span class="nw-2018-content-line" ></span>
   
                 </center>
                </div>   
           </div>
           
               
            <div class="row" style="line-height: 26px; text-align:  center; padding: 70px 0px 70px 0px; " >
            <div class="span4 g-txt16">
               <img src="https://netway.co.th/templates/netwaybysidepad/images/icon-microsoft-1-min.png"  width="48px"/>
               <center>
               <hr  style="border-top: 1px solid #0052cd; border-bottom: 1px solid #0052cd; width : 10%; ">
               </center>
              <p style="padding: 0px 20px 20px 20px;">มั่นใจว่าได้ของแท้ 100% เราเป็นตัวแทน Microsoft อย่างเป็นทางการ </p>
            </div>
            <div class="span4 g-txt16">
                          
               <img src="https://netway.co.th/templates/netwaybysidepad/images/icon-microsoft-4-min.png"  width="48px"/>
               <center>
               <hr  style="border-top: 1px solid #0052cd; border-bottom: 1px solid #0052cd; width : 10%; ">
               </center>
              <p style="padding: 0px 20px 20px 20px;">สามารถ Update Patch กับ Microsoft <br/>  ได้ไม่จำกัด</p>             
                          
            </div>
            <div class="span4 g-txt16">
                <img src="https://netway.co.th/templates/netwaybysidepad/images/icon-microsoft-2-min.png"  width="48px"/>
               <center>
               <hr  style="border-top: 1px solid #0052cd; border-bottom: 1px solid #0052cd; width : 10%; ">
               </center>
              <p style="padding: 0px 20px 20px 20px;"> รับประกันตลอดอายุการใช้งาน </p>  
            
            </div>
            </div>
            
            <div class="row" style="line-height: 26px; text-align:  center; padding: 0px 0px 70px 0px; " >
            <div class="span2"></div>
            <div class="span4 g-txt16">
              <img src="https://netway.co.th/templates/netwaybysidepad/images/icon-microsoft-5-min.png"  width="48px"/>
               <center>
               <hr  style="border-top: 1px solid #0052cd; border-bottom: 1px solid #0052cd; width : 10%; ">
               </center>
              <p style="padding: 0px 20px 20px 20px;"> มีบริการหลังการขายด้วย  ประสบการณ์กว่า 20 ปี</p>  
            </div>
            <div class="span4 g-txt16">
              <img src="https://netway.co.th/templates/netwaybysidepad/images/icon-microsoft-3-min.png"  width="48px"/>
               <center>
               <hr  style="border-top: 1px solid #0052cd; border-bottom: 1px solid #0052cd; width : 10%; ">
               </center>
              <p style="padding: 0px 20px 20px 20px;">ไม่พอใจยินดีคืนส่วนต่างภายใน 15 วัน</p>  
                             
             </div>
            <div class="span2"></div>
            </div>
            
       </div>
       
 </div>



<script>
    {literal}
    $(document).ready(function(){
        $('.customer-logos').slick({
            slidesToShow: 5,
            slidesToScroll: 1,
            autoplay: true,
            autoplaySpeed: 1500,
            arrows: false,
            dots: false,
            pauseOnHover: false,
            responsive: [{
                breakpoint: 768,
                settings: {
                    slidesToShow: 4
                }
            }, {
                breakpoint: 520,
                settings: {
                    slidesToShow: 3
                }
            }]
        });
    });
{/literal}
</script>






