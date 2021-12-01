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
        <div class="hero-azurebackup-2018"  >
           <div class="container">
            <div class="row-fluid hidden-phone" >
                  
                   <div class="span6 hero-inner">
                      <div style="margin-top: 150px; text-align: left;">                     
                        <h2 class="re-txt-banner"  style="font-size: 35px; line-height: 52px; color: #2f3b49;"><b>แบคอัพข้อมูล บนระบบคลาวด์ ง่ายๆ ในราคาประหยัด </b>
                        <br/></h2>
                        <hr style="width: 10%; margin: 10px 0 16px; "/>      
                        <a href="https://netway.co.th/azurebackup#Features"><button class="btn-banner-azurebackup" type="submit">อ่านเพิ่มเติม</button></a>   
                       
                      </div>  
                </div>
                
                <div class="span6">
                       <img src="https://netway.co.th/templates/netwaybysidepad/images/bg-img-azure-backup-min.png" style="margin-top: 74px; width: 528px;
                        margin-left: -132px;"  />     
                </div>
              </div>
              
              <div class="row-fluid visible-phone" style="margin-top: 5px;">
                 <div class="span12" style="text-align: center;">
                      <img src="https://netway.co.th/templates/netwaybysidepad/images/bg-img-azure-backup-min.png" style="margin-top: 30px;  width: 320px;"  />  
                      <br/>
                       <h2 class="re-txt-banner"  style="font-size: 28px; line-height: 52px; color: #2f3b49;"><b>แบคอัพข้อมูล บนระบบคลาวด์ ง่ายๆ ในราคาประหยัด </b>
                        <br/> </h2>
                        <center><hr style="width: 10%; margin: 10px 0 16px;"/></center>      
                        <a href="https://netway.co.th/azurebackup#Features"><button class="btn-banner-azurebackup" type="submit">อ่านเพิ่มเติม</button></a> 

                 </div>
              
              </div>
              
              
            </div>
        </div>

    

        
        

<div class="row-fluid bg-cloud-content"  id="Features"> 
      <div class="container  " style="background: rgba(255, 255, 255, 0.5);   padding: 120px 0px 0px 0px;" >      
            <div class="row">
               <div class="span12 dynamic-content">        
                             <center>
                             <h3 class="h3-title-content g-txt32 re-topic">Azure Backup </h3>
                             <span class="nw-2018-content-line" style="margin-bottom: 50px;"></span>                            
                             </center>
                </div>
            </div>
            <div class="row"  >
               <div class="span12 dynamic-content" >
                                     
                     <p style="text-align: center; line-height: 26px;">
                            Azure Backup เป็นบริการหนึ่งบน Microsoft Azure ที่ใช้สำรองและ
                                                        ปกป้องข้อมูลในรูปแบบต่างๆ บนระบบ Cloud ของ Microsoft
                            <br/>
                                                        โดยสามารถใช้งานได้ทั้งบน Physical Server หรือ Virtual Machine 
                                                         ซี่งเราสามารถเลือกใช้งานรูปแบบต่างๆ ให้เหมาะสมได้ตามความต้องการ
                                                         ครอบคลุม MSSQL, Hyper-V,  Exchange, SharePoint 
                                                         และอื่น ๆ ที่เป็นโปรดักส์ของ Microsoft
                      </p>

                      
                      <br/>
                      <a href="https://support.netway.co.th/hc/th/requests/new?ticket_form_id=114093963072&request_subject= สนใจทดลองใช้งาน  Azure Backup  &request_custom_fields_114095596292=sales_opt_vps"><button class="btn-check-border" type="submit">สนใจทดลองใช้งาน</button></a>   
               </div>
              
             </div>
            <div class="row"  style="margin-top: 80px; ">
                
                <div class="span3 dynamic-content" >        </div>
                <div class="span3 dynamic-content" >        </div>
                <div class="span3 dynamic-content" >        </div>
                <div class="span3 dynamic-content" >        </div>
            </div>   
                 
      </div>
</div>
  
<div class="row-fluid Features windows-basic-vps-features "  style="text-align: center;   background: #f8f8f8;  color: #2a2a2a;
" > 
       <div class="container" style="margin-top: 120px; margin-bottom:120px;" >
            <div class="row">
                 <div class="span12">
                      <center>
                          <h3 class="h3-title-content g-txt32 re-topic"  >Features </h3>
                            <span class="nw-2018-content-line" style="margin-bottom: 50px;"></span>
                      </center>
                 </div>
            </div>

            <div class="row" style="margin-bottom:20px;" >
                 <div class="span3" style="text-align:center; padding: 40px 5px 40px 5px;     ">   
                       <img src="https://netway.co.th/templates/netwaybysidepad/images/Azure Automation-min.png" width="60px" style="margin-bottom: 20px;" />                         
                     <p class="g-txt22" style="margin-bottom: 20px;">Automatic Storage Management </p>
                          <center><hr width="10%" /></center> 
                     <p class="g-txt16"> ปรับพื้นที่ตามการอัตโนมัติทำให้ใช้งานได้ไม่จำกัด</p>          
                 </div>
             
                  <div class="span3" style="text-align:center;     padding: 40px 5px 70px 5px;  ">
                      <img src="https://netway.co.th/templates/netwaybysidepad/images/Azure Load Balancer (feature)-min.png" width="60px"  style="margin-bottom: 20px;"/> 
                     <p class="g-txt22 "  style="margin-bottom: 20px;"> Unlimited Scaling</p>
                          <center><hr width="10%" style="margin-top: 40px;"/></center> 
                     <p class="g-txt16"> รองรับการใช้งานด้วย High Availability ทำให้ไม่ต้องกังวลเรื่องการใช้งาน</p>
                 </div>
                   <div class="span3" style="text-align:center;     padding: 40px 5px 40px 5px; ">
                    <img src="https://netway.co.th/templates/netwaybysidepad/images/Azure Cloud Services - Web roles-min.png" width="60px"  style="margin-bottom: 20px;"/> 
                     <p class="g-txt22 " style="margin-bottom: 20px;"> Multiple Storage Options</p> 
                          <center><hr width="10%" style="margin-top: 40px;"/></center> 
                    <p class="g-txt16"> สามารถเลือกการใช้งานได้ทั้งแบบ Locally Redundant Storage, Geo-redundant storage</p>
                    <p></p>
                 </div>
                  <div class="span3" style="text-align:center;     padding: 40px 5px 20px 5px; ">
                    <img src="https://netway.co.th/templates/netwaybysidepad/images/Azure Traffic Manager-min.png" width="60px"  style="margin-bottom: 20px;" /> 
                    <p class="g-txt22" style="margin-bottom: 20px;">Unlimited Data Transfer</p>
                         <center><hr width="10%" style="margin-top: 40px;"/></center> 
                    <p class="g-txt16">ไม่จำกัดการใช้งาน และไม่คิดค่าใช้จ่ายในการ Backup ,Restore</p> 
                 </div>
                 
           </div>
           
            <div class="row" style="margin-bottom:20px;" >
                 <div class="span3" style="text-align:center; padding: 40px 5px 40px 5px;     ">   
                       <img src="https://netway.co.th/templates/netwaybysidepad/images/Azure Security Center-min.png" width="60px" style="margin-bottom: 20px;" />                         
                     <p class="g-txt22" style="margin-bottom: 20px;">Data Encryption  </p>
                          <center><hr width="10%" style="margin-top: 40px;"/></center> 
                     <p class="g-txt16"> มีความปลอดภัยทั้งในส่วนของการรับ-ส่งข้อมูล และ Storage</p>          
                 </div>
             
                  <div class="span3" style="text-align:center;     padding: 40px 5px 70px 5px;  ">
                      <img src="https://netway.co.th/templates/netwaybysidepad/images/Azure App Service-min.png" width="60px"  style="margin-bottom: 20px;"/> 
                     <p class="g-txt22 "  style="margin-bottom: 20px;">Application-Consistent Backup</p>
                          <center><hr width="10%"/></center> 
                     <p class="g-txt16">  ใช้งานได้ต่อเนื่องโดยไม่ส่งผลกระทบและไม่ต้อง shutdown</p>
                 </div>
                   <div class="span3" style="text-align:center;     padding: 40px 5px 40px 5px; ">
                    <img src="https://netway.co.th/templates/netwaybysidepad/images/Azure Backup - Backup Agent-min.png" width="60px"  style="margin-bottom: 20px;"/> 
                     <p class="g-txt22 " style="margin-bottom: 20px;"> Long-Term Retention</p> 
                          <center><hr width="10%" style="margin-top: 40px;"/></center> 
                    <p class="g-txt16"> เก็บข้อมูลได้นานสูงสุดถึง 99 ปี</p>
                    <p></p>
                 </div>
                  <div class="span3" style="text-align:center;     padding: 40px 5px 20px 5px; ">
                    <img src="https://netway.co.th/templates/netwaybysidepad/images/Azure Backup - Recovery Vault-min.png" width="60px"  style="margin-bottom: 20px;" /> 
                    <p class="g-txt22" style="margin-bottom: 20px;">Restore Data</p>
                         <center><hr width="10%" style="margin-top: 40px;"/></center> 
                    <p class="g-txt16"> มีความปลอดภัยและง่ายต่อการใช้งาน</p> 
                 </div>
                 
           </div>

            

     
          <div>
       </div>
    </div>
</div>   
   

   <div class="row-fluid"   id="howto" > 
       <div class="container"style="margin-top: 120px; margin-bottom: 120px;" >         
            <div class="row">
               <div class="span12 dynamic-content">
                 <center>
                        <h3 class="h3-title-content g-txt32 re-topic" >How to</h3>
                        <span class="nw-2018-content-line" style="margin-bottom: 30px;"></span>
                 </center>          
                </div>
            </div>
            <div class="row hidden-phone" style="margin-bottom: 10px;">
               <div class="span12 dynamic-conten g-txt22" style="text-align: center;">
                                           ตัวอย่าง การคิดค่าใช้จ่าย ตามการใช้งานจริง   
               </div>
             </div>
             <div class="row hidden-phone">
               <div class="span4  dynamic-content">
                 <div class="plan-azure-backup small" style="text-align: center; margin-bottom: 30px; height: 400px;">
                        <center>
                        <div class="img-azure-small"></div>
                        </center>
                       
                       <p class="txt-price-small blue"> พื้นที่ 100 GB  </p> 
                       <center>
                       <hr width="25%"/>
                       </center> 
                       <p class="txt-price-small" >มีค่าใช้จ่ายประมาณ 14.56 $  </p>
                       <a href="https://netway.co.th/azure-server#PlanandPricing"><button class="btn-buy" style="margin-top: 15px; margin-bottom: 10px;">สั่งซื้อ Token </button></a> 
                  </div>
                </div>
                <div class="span4 dynamic-content">
                 <div class="plan-azure-backup medium" style="text-align: center; margin-bottom: 50px; height: 400px;">
                        <center>
                           <div class="img-azure-medium"></div>
                        </center>   
                  
                       <p class="txt-price-small blue"> พื้นที่ 500 GB  </p> 
                       <center>
                       <hr width="25%"/>
                       </center> 
                       <p class="txt-price-small">  มีค่าใช้จ่ายประมาณ 32.80 $  </p>
                       <a href="https://netway.co.th/azure-server#PlanandPricing"><button class="btn-buy" style="margin-top: 15px; margin-bottom: 10px;">สั่งซื้อ Token </button></a> 
                  </div>
                </div>
                <div class="span4  dynamic-content">
                 <div class="plan-azure-backup large" style="text-align: center; margin-bottom: 50px; height: 400px;">
                       <center>
                           <div class="img-azure-large"></div>
                        </center> 
                       <p class="txt-price-small blue" > พื้นที่ 1 TB  </p> 
                         <center>
                       <hr width="25%"/>
                       </center> 
                        <p class="txt-price-small"> มีค่าใช้จ่ายประมาณ 76.33 $ </p>
                        
                        <a href="https://netway.co.th/azure-server#PlanandPricing"><button class="btn-buy" style="margin-top: 15px; margin-bottom: 10px;">สั่งซื้อ Token </button></a> 
                  </div>
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
                    <div class="swiper-container">
                        <div class="swiper-wrapper">
                            <div class="row  visible-phone  swiper-slide">
                                     <div class="span3 "> 
                                       <div class="plan-azure-backup" style="text-align: center; margin-bottom: 50px;">
					                           <img src="https://netway.co.th/templates/netwaybysidepad/images/icon-azure-bakeup-small-100-min.png" width="180px" style="margin-bottom: 20px;" />  
							                       
							                       <p class="txt-price-small" style="font-weight: bold;"> พื้นที่ 100 GB  </p> 
							                        <center>
							                       <hr width="25%"/>
							                       </center> 
							                        <p class="txt-price-small">มีค่าใช้จ่ายประมาณ 14.56 $  </p>
							                         
											<a href="https://support.netway.co.th/hc/th/requests/new?ticket_form_id=114093963072&request_subject= ขอใบเสนอราคา  Azure Backup   &request_custom_fields_114095596292=sales_opt_vps"><button class="btn-buy" style="margin-top: 20px; margin-bottom: 10px;">ขอใบเสนอราคา</button></a>
					                       <p style="margin-top: 5px; margin-bottom: 25px; font-size: 15px;">ราคาไม่รวม vat7%</p>
					                   </div>
                                        
                                     </div>
                            </div>
                            <div class="row  visible-phone  swiper-slide">
                                     <div class="span3 "> 
                                        <div class="plan-azure-backup" style="text-align: center; margin-bottom: 50px;">
					                          <img src="https://netway.co.th/templates/netwaybysidepad/images/icon-azure-bakeup-large-1000-min.png" width="180px" style="margin-bottom: 20px;" />  
						                       
						                       <p class="txt-price-small" style="font-weight: bold;" > พื้นที่ 500 GB  </p> 
						                        <center>
                                                   <hr width="25%"/>
                                                   </center> 
						                       <p class="txt-price-small">  มีค่าใช้จ่ายประมาณ 32.80 $  </p>
											   
					                        <a href="https://support.netway.co.th/hc/th/requests/new?ticket_form_id=114093963072&request_subject= ขอใบเสนอราคา  Azure Backup  &request_custom_fields_114095596292=sales_opt_vps"><button class="btn-buy" style="margin-top: 20px; margin-bottom: 10px;">ขอใบเสนอราคา</button></a>
					                       <p style="margin-top: 5px; margin-bottom: 25px; font-size: 15px;">ราคาไม่รวม vat7%</p>
					                   </div>
                                     </div>
                             </div>
                             <div class="row  visible-phone  swiper-slide">   
                                     <div class="span3 "> 
                                        <div class="plan-azure-backup" style="text-align: center; margin-bottom: 50px;">
						                       <img src="https://netway.co.th/templates/netwaybysidepad/images/icon-azure-bakeup-medium-500-min.png" width="180px" style="margin-bottom: 20px;" />  
							                      
							                       <p class="txt-price-small" style="font-weight: bold;"> พื้นที่ 1 TB  </p> 
							                        <center>
                                                   <hr width="25%"/>
                                                   </center> 
							                       <p class="txt-price-small" > มีค่าใช้จ่ายประมาณ 76.33 $ </p>
												   
						                        <a href="https://support.netway.co.th/hc/th/requests/new?ticket_form_id=114093963072&request_subject= ขอใบเสนอราคา  Azure Backup  &request_custom_fields_114095596292=sales_opt_vps"><button class="btn-buy" style="margin-top: 20px; margin-bottom: 50px;">ขอใบเสนอราคา</button></a>
						                       <p style="margin-top: 5px; margin-bottom: 25px; font-size: 15px;">ราคาไม่รวม vat7%</p>
						                 </div>
                                     </div>
                             </div>
                           
                           
                              
                            </div>
                    <div class="swiper-pagination" style="top: 4%;"></div>
                        <!-- Add Arrows -->
                        <div class="swiper-button-next" style="top: 10%;"></div>
                        <div class="swiper-button-prev" style="top: 10%;"></div>
                    </div>
          </div>                      
     
     
     {literal}  <script src="https://idangero.us/swiper/dist/js/swiper.min.js"></script>{/literal}  