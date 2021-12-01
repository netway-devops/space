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
  <style>
/** Start Email Page**/

.hero-email-2018 {

   background-position: top center;
   background-repeat: no-repeat;
   text-align: center;
   width: 100%;
   background-image: url(https://netway.co.th/templates/netwaybysidepad/images/img-email-page-background-min.png);
   background-color: #F5F5FF;  

   background-repeat: no-repeat;
   background-size: cover;
   background-position: center;
   height: 500px;
   
   
                
} 



div.div-emailllll {
    /*box-shadow: 0 4px 16px #e0e0e0;*/
    text-decoration: none;
    text-align: left;
    border-radius: 7px;
    background-color: #f5f7f8;
    margin-bottom: 15px;
    color: #414141;
    padding: 20px 20px 20px 20px;
    margin-bottom: 50px;

    
}
div.div-emailllll:hover {
    /*box-shadow: 0 4px 16px #e0e0e0;*/
    text-decoration: none;
    text-align: left;
    border-radius: 7px;
    background-color: #f2f2f2;
    margin-bottom: 15px;
    color: #414141;
    padding: 20px 20px 20px 20px;
    margin-bottom: 50px;

    
}
.features-email {
    margin-top: 60px; 
    background: #E0EAFC; 
    background: -webkit-linear-gradient(to right, #edf2f9, #eff4fb); 
    background: linear-gradient(to right,  #edf2f9, #eff4fb);
   
    
}

@media (min-width: 768px) {
  div.div-emailllll {
     height: 456.05px;
  }
  .features-email {
     height: 450px;
  }
}

@media only all and (max-width: 480px) {
  div.div-emailllll {
      height: 600px;
  }
    .features-email {
     height: 1350px;
  }

}


div.div-emailllll  > ul {
    text-align: left;
    margin: 25px;
    list-style: none;
    padding: 0;
}

div.div-emailllll  > ul  > li{
  line-height: 25px;
}
div.div-emailllll  > ul  > li:before {
  content: "\f105"; /* FontAwesome Unicode */
  font-family: FontAwesome;
  display: inline-block;
  margin-left: -1.3em; /* same as padding-left set on li */
  width: 1.3em; /* same as padding-left set on li */
}


/** End Email Page**/


</style>    
{/literal}
        <div class="hero-email-2018 hidden-phone"  >
           <div class="container">
            <div class="row hidden-phon"  >
                    
                   <div class="span7 hero-inner">
                      <div style="margin-top: 100px; text-align: justify; font-family: 'Prompt', sans-serif;">                     
                        <h2 style="font-size: 34px; color: #141267;">ระบบอีเมลไหนที่เหมาะกับคุณมากที่สุด? </h2>
                        <h2 style="font-size: 34px; color: #141267;"> Netway รู้ดี </h2>
                        
                        <hr width="10%" size="3">
                        <h2 style="font-size: 26px; color: #141267;">  เพราะเราให้บริการระบบอีเมลทุกระบบ </h2>
             
                        <a href="https://support.netway.co.th/hc/th/requests/new?ticket_form_id=360000181612&request_subject= มองหาระบบอีเมลที่เหมาะสมมากที่สุด  "><button class="btn-check" type="submit">ติดต่อเจ้าหน้าที่</button></a>   
                       
                      </div>   
                   </div>
                   <div class="span6 hero-inner">
                          <img src="https://netway.co.th/templates/netwaybysidepad/images/img-email-page-min.png" alt="" border="0" width="100%" style="margin-top: 90px; " />
                   </div> 
                   
            </div>
         </div>
        </div>

    
        <div class="container hero-email-2018 visible-phone" >
            <div class="row-fluid"  >
        
                     <div style="margin-top: 120px; text-align: center; font-family: 'Prompt', sans-serif;">                     
                        <h2 style="font-size: 28px; color: #141267;">ระบบอีเมลไหนที่เหมาะกับคุณมากที่สุด? </h2>
                        <h2 style="font-size: 28px; color: #141267;"> Netway รู้ดี </h2>
                        <center>
                        <hr width="10%" size="3">
                        </center>
                        <h2 style="font-size: 26px; color: #141267;">  เพราะเราให้บริการระบบอีเมลทุกระบบ </h2>
             
                        <a href="https://support.netway.co.th/hc/th/requests/new?ticket_form_id=360000181612&request_subject= มองหาระบบอีเมลที่เหมาะสมมากที่สุด  "><button class="btn-check" type="submit">ติดต่อเจ้าหน้าที่</button></a>   
                       
                      </div> 
            </div>
  
        </div>


<div class="row-fluid "  id="PlanAndPricing" style="margin-top: 80px;"> 
       <div class="container" style=" padding: 0 20px 0 20px;" >  
              <div class="row">
               <div class="span12 dynamic-content">
                 <center>
                     <p class="g-txt20" style="margin-bottom: 50px;">เราให้บริการระบบอีเมลทุกแบรนด์มาตรฐานสากล ให้คุณทำงานง่าย และที่สำคัญได้ราคาคุ้มกว่าใคร </p>
                        <h3 class="h3-title-content g-txt32 re-topic" >Plan & Pricing </h3>
                        <span class="nw-2018-content-line" style="margin-bottom: 50px;"></span>
                 </center>          
                </div>
            </div> 
             <div class="row hidden-phone" style=" margin-bottom: 50px;">
               <div class="span12 dynamic-content">
                
                <table style="width:100%">
            
                  <tr>
                    <td>
                        <div class="plan-gs" style="height: 450px; text-align: center;"> 
                           <img src="https://netway.co.th/templates/netwaybysidepad/images/icon-gsuite-email-min.png" alt="G Suite Email" border="0" width="200px"  />
                            <p style="margin-top: 5px; margin-bottom: 25px;">เริ่มต้นที่</p>
                            <p class="color-blue-s txt-price-top" style="margin-top: 20px;">฿1,590.00 </p>
                            <p style="margin-top: -25px; margin-bottom: 25px;">บาท/ ผู้ใช้ / ปี  <br> &nbsp;&nbsp;</p>

                             <a href="https://support.netway.co.th/hc/th/requests/new?ticket_form_id=114093963072&request_subject= ขอใบเสนอราคาอีเมล  G Suite "><button class="btn-buy" style="margin-top: 20px; margin-bottom: 10px;">ขอใบเสนอราคา</button></a>
                        </div>
                    </td>
                        <td>
                        <div class="plan-gs" style="height: 450px; text-align: center;"> 
                         <p style="color: #3171c5;font-weight: 600;font-size: 35px;margin-top: 43px;margin-bottom: 42px;font-family: 'Leelawadee UI','Segoe UI',SegoeUI,&quot;Helvetica Neue&quot;,Helvetica,Arial,sans-serif;">
                            Microsoft 365
                         </p>
                         <!-- <img src="https://netway.co.th/templates/netwaybysidepad/images/microsoft-logo-365.png" alt="Office365 Email" border="0" width="200px" style="margin-top: 25px;"/>-->
                            <p style="margin-top: 26px; margin-bottom: 25px;">เริ่มต้นที่</p>
                            <p class="color-blue-s txt-price-top" style="margin-top: 20px;">฿890.00 </p>
                            <p style="margin-top: -25px; margin-bottom: 25px;">บาท/ ผู้ใช้ / ปี   <br> &nbsp;&nbsp;</p>

                            <a href="https://support.netway.co.th/hc/th/requests/new?ticket_form_id=114093963072&request_subject= ขอใบเสนอราคาอีเมล  Office 365"><button class="btn-buy" style="margin-top: 20px; margin-bottom: 10px;">ขอใบเสนอราคา</button></a>
                        </div>
                    </td>
                    <td>
                       <div class="plan-gs" style="height: 450px; text-align: center;"> 
                         <img src="https://netway.co.th/templates/netwaybysidepad/images/icon-Hybrid-email-min.png" alt="Netway Hybrid Email" border="0" width="200px" />
                            <p style="margin-top: 5px; margin-bottom: 25px;">เริ่มต้นที่</p>
                            <p class="color-blue-s txt-price-top" style="margin-top: 20px;">฿3,000.00 </p>
                            <p style="margin-top: -25px; margin-bottom: 25px;">บาท/ ปี <br/> (ไม่จำกัด ผู้ใช้)</p>

                            <a href="https://support.netway.co.th/hc/th/requests/new?ticket_form_id=114093963072&request_subject= ขอใบเสนอราคา  Netway Hybrid Email "><button class="btn-buy" style="margin-top: 20px; margin-bottom: 10px;">ขอใบเสนอราคา</button></a>
                        </div>
                    </td>
                  
                    <td>
                      <div class="plan-gs" style="height: 450px; text-align: center;"> 
                         <img src="https://netway.co.th/templates/netwaybysidepad/images/icon-cpanel-email-min.png" alt="cPanel Email" border="0" width="200px"  />
                            <p style="margin-top: 5px; margin-bottom: 25px;">เริ่มต้นที่</p>
                            <p class="color-blue-s txt-price-top" style="margin-top: 20px;">฿2,160.00 </p>
                            <p style="margin-top: -25px; margin-bottom: 25px;">บาท/ ปี  <br/> (ไม่จำกัด ผู้ใช้)</p>

                            <a href="https://support.netway.co.th/hc/th/requests/new?ticket_form_id=114093963072&request_subject= ขอใบเสนอราคาอีเมล  cPanel"><button class="btn-buy" style="margin-top: 20px; margin-bottom: 10px;">ขอใบเสนอราคา</button></a>
                        </div>
                    </td>
              
                  </tr>
            
                </table>

               </div>
             </div>   
   


 <link rel="stylesheet" href="https://idangero.us/swiper/dist/css/swiper.min.css">
 {literal}
 <script>
$(document).ready(function(){

   var swiper = new Swiper('.swiper-container', {
      slidesPerView: 1,
      spaceBetween: 10,
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
                    <div class="swiper-container"  >
                        <div class="swiper-wrapper">
                               <div class="row  visible-phone  swiper-slide">   
                                    <div class="span3">
                                         <div class="plan-gs" style="height: 450px; text-align: center;"> 
                                               <img src="https://netway.co.th/templates/netwaybysidepad/images/icon-gsuite-email-min.png" alt="G Suite Email" border="0" width="200px"  />
                                                <p style="margin-top: 5px; margin-bottom: 25px;">เริ่มต้นที่</p>
                                                <p class="color-blue-s txt-price-top" style="margin-top: 20px;">฿1,590.00 </p>
                                                <p style="margin-top: -25px; margin-bottom: 25px;">บาท/ ผู้ใช้ / ปี  <br> &nbsp;&nbsp;</p>
                    
                                                 <a href="https://support.netway.co.th/hc/th/requests/new?ticket_form_id=114093963072&request_subject= ขอใบเสนอราคาอีเมล  G Suite "><button class="btn-buy" style="margin-top: 20px; margin-bottom: 10px;">ขอใบเสนอราคา</button></a>
                                         </div>
                                    </div>
                             </div>
               
                             <div class="row  visible-phone  swiper-slide">   
                                    <div class="span3">
                                         <div class="plan-gs" style="height: 450px; text-align: center;"> 
                                            <p style="color: #3171c5;font-weight: 600;font-size: 35px;margin-top: 43px;margin-bottom: 42px;font-family: 'Leelawadee UI','Segoe UI',SegoeUI,&quot;Helvetica Neue&quot;,Helvetica,Arial,sans-serif;">
                                                Microsoft 365
                                            </p>
                                         <!--<img src="https://netway.co.th/templates/netwaybysidepad/images/microsoft-logo-365.png" alt="Office365 Email" border="0" width="200px" />-->
                                            <p style="margin-top: 5px; margin-bottom: 25px;">เริ่มต้นที่</p>
                                            <p class="color-blue-s txt-price-top" style="margin-top: 20px;">฿890.00 </p>
                                            <p style="margin-top: -25px; margin-bottom: 25px;">บาท/ ผู้ใช้ / ปี   <br> &nbsp;&nbsp;</p>
                
                                            <a href="https://support.netway.co.th/hc/th/requests/new?ticket_form_id=114093963072&request_subject= ขอใบเสนอราคาอีเมล  Office 365"><button class="btn-buy" style="margin-top: 20px; margin-bottom: 10px;">ขอใบเสนอราคา</button></a>
                                        </div>
                                      </div>
                             </div>
                             <div class="row  visible-phone  swiper-slide">   
                                         <div class="span3 ">
                                         
                    <div class="plan-gs" style="height: 450px; text-align: center;"> 
                         <img src="https://netway.co.th/templates/netwaybysidepad/images/icon-Hybrid-email-min.png" alt="Netway Hybrid Email" border="0" width="200px" />
                            <p style="margin-top: 5px; margin-bottom: 25px;">เริ่มต้นที่</p>
                            <p class="color-blue-s txt-price-top" style="margin-top: 20px;">฿3,000.00 </p>
                            <p style="margin-top: -25px; margin-bottom: 25px;">บาท/ ปี <br/> (ไม่จำกัด ผู้ใช้)</p>

                            <a href="https://support.netway.co.th/hc/th/requests/new?ticket_form_id=114093963072&request_subject= ขอใบเสนอราคา  Netway Hybrid Email "><button class="btn-buy" style="margin-top: 20px; margin-bottom: 10px;">ขอใบเสนอราคา</button></a>
                        </div>

                             </div>
                              
                            </div>
                              <div class="row  visible-phone  swiper-slide">   
                                      <div class="span3 ">
                                         <div class="plan-gs" style="height: 450px; text-align: center;"> 
                                             <img src="https://netway.co.th/templates/netwaybysidepad/images/icon-zimbra-email-min.png" alt="Zimbra Email" border="0" width="200px" />
                                             <p style="margin-top: 5px; margin-bottom: 25px;">เริ่มต้นที่</p>
                                             <p class="color-blue-s txt-price-top" style="margin-top: 20px;">฿350.00 </p>
                                             <p style="margin-top: -25px; margin-bottom: 25px;">บาท/ ผู้ใช้ / ปี  <br> &nbsp;&nbsp;</p>
                                
                                             <a href="https://support.netway.co.th/hc/th/requests/new?ticket_form_id=114093963072&request_subject= ขอใบเสนอราคาอีเมล  Zimbra"><button class="btn-buy" style="margin-top: 20px; margin-bottom: 10px;">ขอใบเสนอราคา</button></a>
                                         </div>
                                                                         
                                     </div>
                             </div>
                                 <div class="row  visible-phone  swiper-slide">   
                                         <div class="span3 ">
                                         

                                           <div class="plan-gs" style="height: 450px; text-align: center;"> 
                         <img src="https://netway.co.th/templates/netwaybysidepad/images/icon-cpanel-email-min.png" alt="cPanel Email" border="0" width="200px"  />
                            <p style="margin-top: 5px; margin-bottom: 25px;">เริ่มต้นที่</p>
                            <p class="color-blue-s txt-price-top" style="margin-top: 20px;">฿2,160.00 </p>
                            <p style="margin-top: -25px; margin-bottom: 25px;">บาท/  ปี  <br/> (ไม่จำกัด ผู้ใช้)</p>

                            <a href="https://support.netway.co.th/hc/th/requests/new?ticket_form_id=114093963072&request_subject= ขอใบเสนอราคาอีเมล  cPanel"><button class="btn-buy" style="margin-top: 20px; margin-bottom: 10px;">ขอใบเสนอราคา</button></a>
                        </div>

                             </div>
                              
                            </div>
                            
                                  
   
                        <div class="swiper-pagination" style="top: 19%; height: 20px;"></div>
                        <!-- Add Arrows -->
                        <div class="swiper-button-next" style="top: 20%;"></div>
                        <div class="swiper-button-prev" style="top: 20%;"></div>
                             
      
                    </div>
  
     
     {literal}  <script src="https://idangero.us/swiper/dist/js/swiper.min.js"></script>{/literal}  
       </div>
   </div>
 </div>
<div class="row-fluid  features-email"> 
       <div class="container" style="margin-top: 60px; margin-bottom:60px;" >
            <div class="row">
               <div class="span12" >
                        <center>
                        <h3 class="h3-title-content g-txt32 re-topic" >ซื้อกับ Netway คุ้มชัวร์</h3>
                        <span class="nw-2018-content-line" style="margin-bottom: 0px;"></span>
                        </center>
               </div>
            </div>

            <div class="row " >
                 <div class="span3" style="text-align:center; padding: 40px 5px 40px 5px;">                          
                     <img src="https://netway.co.th/templates/netwaybysidepad/images/icon-email-247-min.png"  style="margin-bottom: 20px;  width: 80px;" />  
                     <p class="g-txt22" style="margin-bottom: 22px; color:#141267;">24/7 SUPPORT</p>
                     <center><hr width="10%" style="border-top: 1px solid #4a5d86; border-bottom: 1px solid #4a5d86;"></center>
                     <p class="g-txt16" >บริการสนับสนุนโดย Netway <br/>ตลอด 24 ชั่วโมง (ภาษาไทย)</p>          
                 </div>
                    <div class="span3" style="text-align:center; padding: 40px 5px 40px 5px;">                          
                     <img src="https://netway.co.th/templates/netwaybysidepad/images/icon-email-training-min.png"  style="margin-bottom: 20px;  width: 80px;" />  
                     <p class="g-txt22" style="margin-bottom: 22px; color:#141267;">On-boarding Training</p>
                     <center><hr width="10%" style="border-top: 1px solid #4a5d86; border-bottom: 1px solid #4a5d86;"></center>
                     <p class="g-txt16">มีบริการสอนการใช้งาน<br/>ช่วยให้ User และ Admin  ใช้งานได้เร็วขึ้นหลังเริ่มต้นใช้งาน</p>          
                 </div>
                    <div class="span3" style="text-align:center; padding: 40px 5px 40px 5px;">                          
                     <img src="https://netway.co.th/templates/netwaybysidepad/images/icon-email-migration-min.png"  style="margin-bottom: 20px;  width: 80px;" />  
                     <p class="g-txt22" style="margin-bottom: 22px; color:#141267;">Migration Service</p>
                     <center><hr width="10%" style="border-top: 1px solid #4a5d86; border-bottom: 1px solid #4a5d86;"></center>
                     <p class="g-txt16">ย้ายระบบด้วยบริการที่คล่องตัว <br/>และทำให้ user ใช้งานได้ราบรื่น  </p>          
                 </div>
                    <div class="span3" style="text-align:center; padding: 40px 5px 40px 5px;">                          
                     <img src="https://netway.co.th/templates/netwaybysidepad/images/icon-email-cost-min.png"  style="margin-bottom: 20px;  width: 80px;" />  
                     <p class="g-txt22" style="margin-bottom: 22px; color:#141267;">Cost-Effective</p>
                     <center><hr width="10%" style="border-top: 1px solid #4a5d86; border-bottom: 1px solid #4a5d86;"></center>
                     <p class="g-txt16">คุณสามารถเลือกใช้โซลูชั่นแบบ Hybrid <br/>ได้ ทำให้ผสม user แบบประหยัดและแพงเข้าด้วยกันได้  </p>          
                 </div>
             
                  
           </div>
           

            

     
          <div>
       </div>
    </div>
</div>
 
    <div class="row-fluid" style="margin-top: 80px; padding: 0 20px 0 20px;" > 
      <div class="container" >      
            <div class="row" class="hidden-phone"  id="GSuiteOROffice365"> 
                 <div class="span12" style="height: 100px; "></div>
            </div>
            <div class="row">
               <div class="span6 div-emailllll" style="height: 550px;" >     
                      <center>
                      <img src="https://netway.co.th/templates/netwaybysidepad/images/icon-gsuite-email-min.png" alt="G Suite Email" border="0" width="200px"  />
                      <p class="g-txt22"> ตัวแทนจำหน่ายบริการจาก Google </p>  
                      </center>
                      <ul>
                       <li>อีเมลและพื้นที่เก็บไฟล์ขั้นต่ำ 30GB  บนระบบ Cloud</li>
                       <li>ระบบการค้นหาข้อความในอีเมลโดย Google Search</li>
                       <li>ใช้งานกับ Google Apps อื่น ๆ ได้ฟรี</li>
                       <li>บริการ App Advisor ที่ช่วยเพิ่มมูลค่าด้วย Third-Party Plugin</li>
                       <li>ทำ Hybrid ได้ ช่วยประหยัดค่าใช้จ่าย</li>
                      </ul>
                      <div class="inline" style="margin-top: 108px; margin-bottom: 30px; text-align: center;">
                                      <img src="/templates/netwaybysidepad/images/icon-gmail.png" style="width: 35px;">
                                    <img src="/templates/netwaybysidepad/images/icon-calendar.png" style="margin-left: 5px; width: 35px;">
                                    <img src="/templates/netwaybysidepad/images/icon-drive.png" style="margin-left: 5px; width: 35px;"> 
                                    <img src="/templates/netwaybysidepad/images/icon-docs.png" style="margin-left: 5px; width: 35px;">
                                    <img src="/templates/netwaybysidepad/images/icon-sheets.png" style="margin-left: 5px; width: 35px;">
                                    <img src="/templates/netwaybysidepad/images/icon-slides.png" style="margin-left: 5px; width: 35px;">
                                
        
                               </div>
                       <center>
                       <a href="https://netway.co.th/gsuite#PlanandPricing" class="btn-check-border" style="margin-top: 15px;"> ดูราคา </a>
                       &nbsp;&nbsp;&nbsp;
                       <a href="https://support.netway.co.th/hc/th/requests/new?ticket_form_id=114093963072&request_subject= ขอใบเสนอราคาอีเมล  G Suite "><button class="btn-buy" style="padding: 17px 6px;
    margin-top: -3px; ">ขอใบเสนอราคา</button></a>
                       </center>
               </div> 
               
                <div class="span6 div-emailllll " style="height: 550px;padding-right: 9px;"  >     
                      <center>
                      <!--<img src="https://netway.co.th/templates/netwaybysidepad/images/microsoft-logo-365.png" alt="Office365 Email" border="0" width="200px" />-->
                      <p style="color: #3171c5;font-weight: 600;font-size: 35px;margin-top: 40px;margin-bottom: 42px;font-family: 'Leelawadee UI','Segoe UI',SegoeUI,&quot;Helvetica Neue&quot;,Helvetica,Arial,sans-serif;">
                        Microsoft 365
                      </p>
                      <p class="g-txt22"> ตัวแทนจำหน่ายบริการจาก Microsoft </p>  
                      </center>
                      <ul>
                       <li>เก็บอีเมลได้จัดเต็มถึง 50GB Inbox </li>
                       <li>ราคาถูกกว่าหน้าเว็บไซต์ของไมโครซอฟท์</li>
                       <li>พื้นที่เก็บไฟล์บน Cloud Storage ขนาดถึง 1TB</li>
                       <li>ระบบความปลอดภัยแบบสุงสุด</li>
                       <li>สิทธิประโยชน์สำหรับการใช้งาน Office เวอร์ชันล่าสุด</li>
                       <li>สามารถทำระบบ Hybrid ที่ผสมกันระหว่าง Microsoft 365 และอีเมลอื่นๆได้ </li>
                       <li>มาพร้อมการอบรมการใช้งาน</li>
                       
                      </ul>
                      <div class="inline" style="margin-top: 30px; margin-bottom: 30px; text-align: center;">
                                    <img src="/templates/netwaybysidepad/images/Office365-Outlook-min.png" style="width: 35px;">
                                    <img src="/templates/netwaybysidepad/images/Office365-Wold-min.png" style="margin-left:5px; width: 35px;">
                                    <img src="/templates/netwaybysidepad/images/Office365-Excel-min.png" style="margin-left: 5px; width: 35px;"> 
                                    <img src="/templates/netwaybysidepad/images/Office365-PowerPoint-min.png" style="margin-left: 5px; width: 35px;">
                                    <img src="/templates/netwaybysidepad/images/Office365-OneNote-min.png" style="margin-left: 5px; width: 35px;">
                                    <img src="/templates/netwaybysidepad/images/Office365-Access-home-min.png" style="margin-left: 5px; width: 35px;">
        
                     </div>
                     <center>
                       <a href="https://netway.co.th/office365#PlanandPricing" class="btn-check-border" style="margin-top: 15px;"> ดูราคา </a>
                         &nbsp;&nbsp;&nbsp;
                       <a href="https://support.netway.co.th/hc/th/requests/new?ticket_form_id=114093963072&request_subject= ขอใบเสนอราคาอีเมล  Office365 "><button class="btn-buy" style="padding: 17px 6px;
    margin-top: -3px; ">ขอใบเสนอราคา</button></a>
                     </center>
               </div> 
               
            </div>  
            <div class="row" class="hidden-phone" id="HybridORZimbra"> 
                 <div class="span12" style="height: 100px; "></div>
            </div>
              <div class="row"  >
               <div class="span6 div-emailllll" style="height: 550px;" id="Hybrid">     
                      <center>
                       <img src="https://netway.co.th/templates/netwaybysidepad/images/icon-Hybrid-email-min.png" alt="Netway Hybrid Email" border="0" width="200px" />
                      <p class="g-txt18"> บริการอีเมลแบบผสมในราคาที่คุ้มค่า</p>
                      </center>
                      <ul>
                       <li>ระบบอีเมลที่เป็นทางเลือกใหม่ของการลงทุนที่ผสมผสานทั้ง Office 365 และระบบอีเมลที่พัฒนาขึ้นเองเฉพาะองค์กร</li>
                       <li>สามารถผสม Google Apps for Work เข้ากับระบบอีเมลทั่วไปได้</li>
                       <li>ช่วยลดต้นทุนในกรณีที่ User มีปริมาณมาก</li>
                       <li>ประสบการณ์การใช้งานเสมอเหมือนการใช้งานอีเมลทุกระบบใช้งานได้ดี <br/>ไม่ติดขัด ทั้งบน Desktop และ Mobile</li>
                       <li>ไม่ต้องเสียค่าใช้จ่ายแบบ Per-User ทั้งหมดก็ได้</li>
                      </ul>
                      
                      <center>
                
                       <a href="https://support.netway.co.th/hc/th/requests/new?ticket_form_id=114093963072&request_subject= ขอใบเสนอราคา  Netway Hybrid Email "  class="btn-check-border"> ขอข้อมูลเพิ่มเติม </a>
                      </center>
              
               </div> 
               <div class="span6 div-emailllll" style="height: 550px;" >     
                      <center>
                       <img src="https://netway.co.th/templates/netwaybysidepad/images/icon-zimbra-email-min.png" alt="Zimbra Email" border="0" width="200px" />
                      <p class="g-txt18"> ตัวแทนจำหน่ายบริการจาก  Zimbra</p>
                      </center>
                      <ul>
                       <li>ประหยัดมากขึ้นการเพิ่มจำนวน user ได้เต็มที่บนเครื่อง Dedicated Server </li>
                       <li>บริหารจัดการกับเทคโนโลยีต่าง ๆ ในองค์กรได้ดี</li>
                       <li>ระบบ Unified Communication สำหรับองค์กร</li>
                       <li>Opensource Email ที่มีความเป็นส่วนตัวสูงและปลอดภัยที่สุด</li>
                       <li>เหมาะสำหรับองค์กรขนาดใหญ่</li>
                      </ul>
                      <center>
                
                       <a href="https://support.netway.co.th/hc/th/requests/new?ticket_form_id=114093963072&request_subject= ขอใบเสนอราคาอีเมล  Zimbra"  class="btn-check-border" style="margin: 80px 0% 50px 0%;"> ขอข้อมูลเพิ่มเติม </a>
                      </center>
                      
                    
              
               </div> 
               

            </div> 
            <div class="row" class="hidden-phone" id="cPanel"> 
                 <div class="span12" style="height: 100px; "></div>
            </div>
            <div class="row" >
               
               
                <div class="span6 div-emailllll"  style="height: 550px;" >     
                      <center>
                      <img src="https://netway.co.th/templates/netwaybysidepad/images/icon-cpanel-email-min.png" alt="cPanel Email" border="0" width="180px"  />
                      <p class="g-txt18"> ตัวแทนจำหน่ายบริการจาก  cPanel Hosting </p>
                      </center>
                      <ul>
                       <li>เหมาะสำหรับ SME ส่วนใหญ่ในประเทศไทย</li>
                       <li>มีบริการสนับสนุนที่พร้อมสำหรับทุกองค์กร</li>
                       <li>บริหารจัดการ user ได้เองง่ายและสะดวก</li>
                       <li>ใช้เชื่อมต่อโดย Outlook ที่คุณมีในองค์กรได้</li>
                       <li>ราคาประหยัดที่สุด พร้อม Hosting Package แบบครบวงจร </li>
                       
                      </ul>
                      <center>
                
                       <a href="https://support.netway.co.th/hc/th/requests/new?ticket_form_id=114093963072&request_subject= ขอใบเสนอราคาอีเมล  cPanel "  class="btn-check-border"> ขอข้อมูลเพิ่มเติม </a>
                      </center>
                      
                 
                
               </div> 
               
                <div class="span6"></div> 
               
            </div>  
            
            

       </div>
       
 </div>








