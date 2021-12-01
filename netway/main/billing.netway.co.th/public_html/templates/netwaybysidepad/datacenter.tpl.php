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
  <link rel="stylesheet" href="https://idangero.us/swiper/dist/css/swiper.min.css">
     <script>
    $(document).ready(function(){
    
       var swiper = new Swiper('.swiper-container', {
          slidesPerView: 1,
          spaceBetween: 4,
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
    
    });
     
    </script>
{/literal}
        <div   style="background-color: #1e124f; hight: 430px;"   >
           <div class="container">
            <div class="row hidden-phon"  >
                    
                   <div class="span6 hero-inner">
                      <div style="margin-top: 0px; ">
                
                        <h2 style="font-size: 35px; color: #FFF; margin-top: 120px; margin-bottom: -15px; line-height: normal;">Netway Datacenter </h2>
                        <span class="nw-2018-content-line" style="margin-top: 28px; width: 120px; background: #766DD4;"></span>
                        <p  style="color: #766DD4; font-size: 22px; margin-top: 20px;  width: 135%;">Security, reliability and performance for drive your business. </p>

                        
                       
                      </div>   
                   </div>
                   <div class="span6 hero-inner  " >
                          <img src="https://netway.co.th/templates/netwaybysidepad/images/img-banner-datacenter-min.png" alt="" border="0" width="100%" style="margin-left: 95px; " />
                   </div> 
                   
            </div>
         </div>
        </div>
    <div class="row-fluid" style="margin-top: 80px;  padding: 0 20px 80px 20px;" > 
      <div class="container" >      
          <div class="row">
             <div class="span6" style="border-right: 2px solid #0052cd;">
                   <p class="g-txt26" style="color: #1e124f;">Netway Datacenter</p>
                   <hr/>
                   <p class="g-txt16" style="line-height: 24px; text-align: justify; padding: 0 25px 0 0px;">
                                          ตั้งอยู่ที่  <b>ProEN Internet Data Center ชั้น 18 อาคาร กสท โทรคมนาคม บางรัก </b> ซึ่งเป็นอาคารที่ตั้งของระบบ International Internet Gateway (IIG) และ National Internet Exchange (NIX) ของประเทศไทย โดยเป็นศูนย์กลางการแลกเปลี่ยนข้อมูลอินเตอร์เน็ตระหว่างประเทศ (National Internet Gateway) ที่ใหญ่ที่สุดในประเทศไทย เพียบพร้อมด้วยสิ่งอำนวยความสะดวกที่ครบครัน ตลอดจนระบบเครือข่าย และ ระบบรักษาความปลอดภัย รวมถึงการเชื่อมต่อเครือข่ายอินเทอร์เน็ต ที่สมบูรณ์แบบ เพื่อตอบสนองการใช้งานได้ครบทุกความต้องการ
                      
                     <br/><br/>
                                         ทาง Netway เลือกใช้บริการของ ProEN Internet Data Center เพราะได้รับการรับรองมาตรฐาน  
                    </p>                      
                      <ul style="list-style-type: none;">
                          <li style="line-height: 24px;"><i class="fa fa-check-circle-o" aria-hidden="true" style="color: #00d000;"></i>  ISO/IEC 27001:2013 - Information Security Management  System(ISMS)  </li>
                          <li style="line-height: 24px;"><i class="fa fa-check-circle-o" aria-hidden="true" style="color: #00d000;"></i>  ISO 9001:2015 - Quality Management System  </li>
                          <li style="line-height: 24px;"><i class="fa fa-check-circle-o" aria-hidden="true" style="color: #00d000;"></i>  Tier III Data Center</li>
                          <li style="line-height: 24px;"><i class="fa fa-check-circle-o" aria-hidden="true" style="color: #00d000;"></i>  Redundant Backbone Network</li>
                      </ul>
                     <p class="g-txt16" style="line-height: 24px; text-align: justify; margin-top: 10px; padding: 0 25px 0 0px;">
                                               อันทำให้มั่นใจได้ในการป้องกันข้อมูลส่วนบุคคลของลูกค้าเราในห้อง Internet Data Center และการบริหารจัดการอย่างเป็นระบบ มีคุณภาพ มีการควบคุม ตรวจสอบได้ ตามมาตรฐานที่ได้รับการรับรองมา ซึ่งทำให้ลูกค้าของ Netway มีความปลอดภัยในด้านข้อมูล การเข้าถึง และระบบสามารถทำงานได้อย่างมีประสิทธิภาพ 
                     </p>
                     <h3 style="font-size: 22px;"> บริการของ NETWAY บน Datacenter : <a href="https://netway.co.th/cloud" target="_blank">Netway Cloud </a>   </h3>
             </div>
             <div class="span6">
                 <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3875.8638937936007!2d100.51211131468631!3d13.726688990363732!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x30e298db0a8b5b0b%3A0x5291d408c0b0a394!2sPROEN+INTERNET+DATA+CENTER!5e0!3m2!1sen!2sth!4v1548244008271" width="600" height="300" frameborder="0" style="border:0" allowfullscreen></iframe>
                  <center>
                  <p class="g-txt22" style="line-height: 20px; text-align: center; margin-top: 20px; padding: 0 0 0 25px;">
                                              รายละเอียดเพิ่มเติม <b>IDC - DATASHEET</b>
                  </p>
                  <hr/>
                  <a href="https://drive.google.com/file/d/16pS1hgi8eqDIVZPJEJRO3uF2_rIRymg9/view?usp=sharing" target="_blank" rel="noopener"><img src="https://support.netway.co.th/hc/article_attachments/360013660131/download.png" alt="download.png"></a>
                  </center>
             </div>
      </div>
    </div>
   