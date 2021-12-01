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
       
      /*** Start SharePoint ***/ 
       
       .padding-row-f {
			   padding: 10px 20px 10px 20px;
	   }
	   .features-list-top {
	   
	          border-top: 1px solid #e8eaeb;
			  border-right: 1px solid #e8eaeb;
			  border-left: 1px solid #e8eaeb;
			  border-top-left-radius: 5px;
			  border-top-right-radius: 5px;
			  background-color: #f8f8f8;
			  
	   }
	   .features-list-content {
	   
              border-right: 1px solid #e8eaeb;
              border-left: 1px solid #e8eaeb;
	   }
	   .features-list-bottom {
	   
              border-bottom: 1px solid #e8eaeb;
              border-right: 1px solid #e8eaeb;
              border-left: 1px solid #e8eaeb;
              border-bottom-left-radius: 5px;
              border-bottom-right-radius: 5px;
              background-color: #fff;
              
       }
	   /*Start Responsive */
	   @media (min-width: 1281px) {
	       .bg {
                
               background-position: top center;
               text-align: center;
               background-repeat: no-repeat;
               background-size: cover;
               background-attachment: fixed;
               background-position: center;
               height: 430px;
               width: 100%;
          }
	      .div-plan-sharepoint {
	           height: 920px  !important;
	           text-align: center; 
	      }
	      .button-plan-125px{
	           margin-top: 142px;
	      }
	      .button-plan-40px {
	           margin-top: 40px;
	      }
	      .img-barnner-sharepoint {
	           margin-left: 140px;
	           width: 93%;
	      }
	      .img-margin-right {
	           margin-right: 40px;
	           margin-bottom: 0px; 
	      }
	      .padding-banner{
	          padding: 0 0 0 0;
	      }
	      .txt-banner-sharepoint  { 
	         color: #001ea7; 
	         text-align: left; 
	         font-size: 36px;  
	         line-height: 50px;  
	         font-weight: 800; 
	      }
	      .p-left {
             margin-left: -40px !important;
          }
          div.plan-gs {
			    background-color: #FFFFFF;
			    padding: 50px 20px 50px 20px;
			    color: #414141;
			    height: 1194px;
			    border: 1px solid #e8eaeb;
			    box-shadow: 0 0 41px 0 rgba(49,110,255,.08);
			    border-radius: 5px;
	      }
	   }
	   
	   @media (min-width: 1025px) and (max-width: 1280px) {
	      .bg {
                
               background-position: top center;
               text-align: center;
               background-repeat: no-repeat;
               background-size: cover;
               background-attachment: fixed;
               background-position: center;
               height: 430px;
               width: 100%;
          }
	      .div-plan-sharepoint {
               height: 920px  !important;
               text-align: center; 
          }
          .button-plan-125px{
               margin-top: 142px;
          }
          .button-plan-40px {
               margin-top: 40px;
               margin-bottom: 0px; 
          }
          .img-barnner-sharepoint {
               margin-left: 140px;
               width: 93%;
          }
           .img-margin-right {
               margin-right: 40px;
          }
          .padding-banner{
              padding: 0 0 0 0;
          }
          .txt-banner-sharepoint  {
             color: #001ea7; 
             text-align: left; 
             font-size: 36px;  
             line-height: 50px;  
             font-weight: 800; 
          }
          .p-left {
             margin-left: -40px !important;
          }
          
           div.plan-gs {
                background-color: #FFFFFF;
                padding: 50px 20px 50px 20px;
                color: #414141;
                height: 1194px;
                border: 1px solid #e8eaeb;
                box-shadow: 0 0 41px 0 rgba(49,110,255,.08);
                border-radius: 5px;
          }
	   }
	   
	   /* ##Device = Tablets, Ipads (portrait) */
	   @media (min-width: 768px) and (max-width: 1024px) {
	       .bg {
                
               background-position: top center;
               text-align: center;
               background-repeat: no-repeat;
               background-size: cover;
               height: 430px;
               width: 100%;
          }
	       .div-plan-sharepoint {
               height: 885px  !important;
               text-align: center; 
          }
          .button-plan-125px{
               margin-top: 142px;
          }
          .button-plan-40px {
               margin-top: 19px;
          }
          .img-barnner-sharepoint {
               margin-left: 140px;
               width: 93%;
          }
          .img-margin-right {
               margin-right: 15px;
               margin-bottom: 0px; 
          }
          .padding-banner{
              padding: 0 20px 0 20px;
          }
          .img-barnner-sharepoint {
               margin-left: -49px;
               width: 85%;
          }
          .txt-banner-sharepoint  { 
             color: #001ea7; 
             text-align: left; 
             font-size: 36px;  
             line-height: 50px;  
             font-weight: 800; 
          }
          .p-left {
             margin-left: -10px !important;
          }
          div.plan-gs {
                background-color: #FFFFFF;
                padding: 50px 20px 50px 20px;
                color: #414141;
                height: 1194px;
                border: 1px solid #e8eaeb;
                box-shadow: 0 0 41px 0 rgba(49,110,255,.08);
                border-radius: 5px;
          }
	   }
	   
	  /* ##Device = Tablets, Ipads (landscape) */
	  @media (min-width: 768px) and (max-width: 1024px) and (orientation: landscape) {
	      .bg {
                
               background-position: top center;
               background-repeat: no-repeat;
               text-align: center;
               width: 100%;
               background-repeat: no-repeat;
               background-size: cover;
               background-attachment: fixed;
               background-position: bottom;
               height: 430px;
               width: 100%;
          }
	      .div-plan-sharepoint {
                  height: 885px  !important;
                  text-align: center; 
          }
          .button-plan-125px {
               margin-top: 142px;
          }
          .button-plan-40px {
               margin-top: 19px;
          }
          .padding-banner{
              padding: 0 20px 0 20px;
          }
          .img-margin-right {
               margin-right: 15px;
               margin-bottom: 0px; 
          }
          .img-barnner-sharepoint {
               margin-left: -49px;
               width: 85%;
          }
          .txt-banner-sharepoint  { 
             color: #001ea7; 
             text-align: left; 
             font-size: 36px;  
             line-height: 50px;  
             font-weight: 800; 
          }
          .p-left {
             margin-left: -10px  !important;
          }
          div.plan-gs {
                background-color: #FFFFFF;
                padding: 50px 20px 50px 20px;
                color: #414141;
                height: 1194px;
                border: 1px solid #e8eaeb;
                box-shadow: 0 0 41px 0 rgba(49,110,255,.08);
                border-radius: 5px;
          }
	  }
	  /*
	     ##Device = Low Resolution Tablets, Mobiles (Landscape)
         ##Screen = B/w 481px to 767px
	  */
	  @media (min-width: 481px) and (max-width: 767px) {
	      .bg {
                
               background-position: top center;
               text-align: center;
               background-repeat: no-repeat;
               background-size: cover;
               background-attachment: fixed;
               background-position: center;
               height: auto;
               width: 100%;
          }
	      .div-plan-sharepoint {
                  height: auto !important;
                  text-align: center; 
          }
          .button-plan-125px{
               margin-top: 105px;
          }
          .padding-banner{
              padding: 0 20px 0 20px;
          }
          .img-barnner-sharepoint {               
               width: 70%;
               margin-top: 25px; 
          }
	     .txt-banner-sharepoint  { 
             color: #001ea7; 
             font-size: 28px;  
             line-height: 50px;  
             font-weight: 800; 
          }
          .button-plan-125px{
               margin-top: 20px;
          }
          .button-plan-40px {
               margin-top: 20px;
          }
          .p-left {
             margin-top: 15px;
             margin-left: -80px  !important;
          }
          
	  }
	  @media (min-width: 320px) and (max-width: 480px) {
	     .bg {

               text-align: center;
               background-repeat: no-repeat;
               background-size: cover;
               height: auto;
               width: 100%;
          }
          .div-plan-sharepoint {
                  height: auto  !important;
                  text-align: center; 
          }
          .padding-banner{
              padding: 0 20px 0 20px;
          }
          .img-barnner-sharepoint {               
               width: 70%;
               margin-top: 25px;
          } 
          .txt-banner-sharepoint  { 
             color: #001ea7; 
             font-size: 28px;  
             line-height: 50px;  
             font-weight: 800; 
          } 
          .button-plan-125px{
               margin-top: 20px;
          }
          .button-plan-40px {
               margin-top: 40px  !important;
          }
          .p-left {
             margin-top: 15px;
             margin-left: -80px  !important;
          }
      }
       /*End Responsive */
      /*** End SharePoint ***/ 
      
</style>
{/literal}
    <!--Desktop  -->
        <div class="bg hidden-phone lazy-hero"  data-src="/templates/netwaybysidepad/images/Bg-SharePoint-min.png">
           <div class="container">
            <div class="row"  >
                    
                   <div class="span12 " style="text-align:center; font-family: 'Prompt', sans-serif;">
                     <div style="width : 50%; float:left;">
	                      <div class="padding-banner" style="margin-top: 120px; text-align: justify; ">                     
	                        <p class="txt-banner-sharepoint " > ลดต้นทุนในการพัฒนาระบบ ด้วย Sharepoint Online </p>
	                        
	                        <a href="https://netway.co.th/sharepoint#pricing" ><button class="btn-banner-cloud" type="submit">สนใจคลิก<i class="fa fa-chevron-right" aria-hidden="true"></i></button></a>   
	                       
	                      </div>  
                      </div> 
                      <div style="width : 50%; float:left;">
                            <img src="https://netway.co.th/templates/netwaybysidepad/images/Img-banner-SharePoint-min.png" class="img-barnner-sharepoint" alt="img banner Share Point Online">
                      </div>
                   </div>
     
            </div>
         </div>
      </div>
    <!-- End Desktop  -->
    <!-- Mobile -->
    <div class="bg visible-phone lazy-hero"  data-src="/templates/netwaybysidepad/images/Bg-SharePoint-min.png">
           <div class="container">
            <div class="row"  >
                    
                    <div class="span12 " style="text-align:center; font-family: 'Prompt', sans-serif;">
                          <div class="padding-banner" style="margin-top: 50px;  text-align: center; ">                     
                            <p class="txt-banner-sharepoint " > ลดต้นทุนในการพัฒนาระบบ ด้วย Sharepoint Online </p>
                            
                            <a href="https://netway.co.th/sharepoint#pricing" ><button class="btn-banner-cloud" type="submit">สนใจคลิก<i class="fa fa-chevron-right" aria-hidden="true"></i></button></a>   
                           
                          </div>  
                   </div>
      
            </div>
         </div>
    </div>
    <!-- End mobile -->
    
    <div class="row-fluid" style="background-color: #f2f2f2;  padding: 60px 20px 60px 20px;" > 
      <div class="container" >      
           <div class="row">
               <div class="span12 dynamic-content">
                <center>
                    <img src="https://netway.co.th/templates/netwaybysidepad/images/logo-sharepoint-netway-min.png" alt="Share Point Online">
                    <hr style="    border-top: 1px solid #0052cd;   border-bottom: 1px solid #0052cd;"/>

                    <p class="g-txt16 " style="margin-bottom: 20px; line-height: normal;  text-align: justify; padding: 0  20px 20px 20px;"><b>Sharepoint Online</b> ใช้สำหรับแชร์และจัดการเนื้อหา ความรู้ หรือฝากข้อมูลต่างๆ รวมถึงการจัดการปรับแต่งการใช้งาน เพื่อให้ทีมของท่านทำงานได้อย่างมีประสิทธิภาพ สามารถหาข้อมูลได้รวดเร็ว และลดขั้นตอนการประสานงานกันในระหว่างองค์กร</p>
                </center>
                </div>
           </div>
           <div class="row"  style="padding: 0 0  60px 0px;">
              <div class="span6 hidden-phone" style="text-align: center;">
                  <img src="https://netway.co.th/templates/netwaybysidepad/images/img-sharepoint-1-min.png" alt="Share Point Online 1" width="90%" >
                
              </div>
              <div class="span6"  style="padding: 20px 20px 20px 20px;" >
                  <h3 class="h3-title-content g-txt32 re-topic"><i class="fa fa-users" aria-hidden="true"></i>  การทำงานร่วมกันในทีม </h3>
                  <hr style=" size: 2px;  width: 20%;">
                  <p class="gs-content g-txt16" style="line-height: 24px; text-align: justify;">
                    SharePoint ใช้เป็นตัวกลางในการสื่อสาร แชร์ไฟล์ ข้อมูล ข่าว และทรัพยากร เพื่อให้สมาชิกในทีมเข้าถึงข้อมูลต่างๆ ได้อย่างสะดวกและง่ายดายผ่านคอมพิวเตอร์และอุปกรณ์เคลี่อนที่
                  </p>
              </div>
              <div class="span6 visible-phone" style="text-align: center;">
                  <img src="https://netway.co.th/templates/netwaybysidepad/images/img-sharepoint-1-min.png" alt="Share Point Online 1"  width="90%">
                
              </div>
           </div>
         <div class="row"  style="padding: 0 0  60px 0px;">
          
              <div class="span6"  style="padding: 20px 20px 20px 20px;" >
                  <h3 class="h3-title-content g-txt32 re-topic"><i class="fa fa-newspaper-o" aria-hidden="true"></i>  ข่าวสาร</h3>
                  <hr style=" size: 2px;  width: 20%;">
                  <p class="gs-content g-txt16" style="line-height: 24px; text-align: justify;">
                    SharePoint ยังสามารถใช้เป็นช่องทางการแจ้งข่าวสารต่างๆ ภายในองค์กร ซึ่งเป็นเว็บไซต์ในองค์กร โดยเฉพาะ ทำให้สะดวกสำหรับทีมที่เกียวข้องในการแจ้งข่าวสาร 
                  </p>
              </div>
              <div class="span6" style="text-align: center;">
                  <img src="https://netway.co.th/templates/netwaybysidepad/images/img-sharepoint-2-min.png" alt="Share Point Online 2"  width="90%">
              </div>
           </div>
           
         <div class="row"  style="padding: 0 0  60px 0px;">
              <div class="span6 hidden-phone" style="text-align: center;">
                  <img src="https://netway.co.th/templates/netwaybysidepad/images/img-sharepoint-3-min.png" alt="Share Point Online 3"  width="90%">
                
              </div>
              <div class="span6"  style="padding: 20px 20px 20px 20px;" >
                  <h3 class="h3-title-content g-txt32 re-topic"><i class="fa fa-search" aria-hidden="true"></i>  ค้นหาง่ายเพียงแค่คลิกเดียว</h3>
                  <hr style=" size: 2px;  width: 20%;">
                  <p class="gs-content g-txt16" style="line-height: 24px; text-align: justify;">
                   ใน SharePoint Site หากต้องการค้นหาสิ่งใด สามารถทำได้เพียงแค่ใส่รายละเอียดที่ต้องการ ระบบจะค้นหาให้ทั้ง เอกสาร ไฟล์หรือโฟลเดอร์ต่างๆ รวมทั้งไซต์ย่อย และที่อยู่ในข่าวสาร (Feed)
                  </p>
              </div>
              <div class="span6 visible-phone" style="text-align: center;">
                  <img src="https://netway.co.th/templates/netwaybysidepad/images/img-sharepoint-3-min.png" alt="Share Point Online 3"  width="90%">
                
              </div>
           </div>
           
          <div class="row"  style="padding: 0 0  60px 0px;">
          
              <div class="span6"  style="padding: 20px 20px 20px 20px;" >
                  <h3 class="h3-title-content g-txt32 re-topic"><i class="fa fa-rocket" aria-hidden="true"></i>  เปลี่ยนกระบวนการต่างๆให้รวดเร็วขึ้น</h3>
                  <hr style=" size: 2px;  width: 20%;">
                  <p class="gs-content g-txt16" style="line-height: 24px; text-align: justify;">
                   เพิ่มความรวดเร็วในการทำงานด้วยการเปลี่ยนแปลงกระบวนการต่างๆด้วย Workflow บนระบบ SharePoint, Microsoft Flow และ PowerApps
                  </p>
              </div>
              <div class="span6" style="text-align: center;">
                  <img src="https://netway.co.th/templates/netwaybysidepad/images/img-sharepoint-4-min.png" alt="Share Point Online 4"  width="90%">
              </div>
           </div>
     </div>
</div>
           


 <div class="row-fluid" style="padding: 80px 20px 0px 20px; " > 
      <div class="container" >  
           <div class="row-fluid" id="pricing" >
                <div class="span12" style="margin-top: -10px;" >
                    <center>
                    <h3 class="h3-titel-content g-txt32">Plan & Pricing</h3>
                    <span class="nw-2018-content-line"></span>
                    <p class="g-txt18" style="margin-top: 20px; margin-bottom: 0px;">&nbsp;&nbsp;&nbsp;&nbsp;</p>
                    </center>
                </div>
            </div>    
            <div class="row  hidden-phone"> 
                   <div class="span3"> &nbsp;&nbsp;&nbsp;   </div>
                   <div class="span3">
					<!-- SharePoint Online Plan 1-->
					<div class="plan-gs div-plan-sharepoint">
					<p class="txt-price-small" style="margin-top: -5px; font-size: 26px;  font-weight: bold;  color: #0052cd">SharePoint Online Plan 1</p>

					
					<hr style="border-top: 2px solid #cccccc;">
			
					<p class="g-txt16" style="padding: 5px 0 35px 0; font-size: 16px; text-align: justify;">
					ฟีเจอร์ที่จำเป็นสำหรับธุรกิจขนาดเล็กและขนาดกลางเพื่อประสบความสำเร็จ
					</p><p>
					<!-- Title Product Group Office 365 Home 0 -->
					</p>
					<p class="txt-titel-pro" style="text-align: left; margin-bottom: 20px;">แอปพลิเคชัน Office </p>
					<p style="padding: 82px 0 135px 0;">ไม่รวม</p>

					<p class="txt-titel-pro" style="text-align: left; margin-top: 20px;">บริการ</p>
				    <table style="width: 100%; text-align: center;">
                          <tr >
                            <th style="width: 25%;"><div class="img-icon bg-SharePoint img-margin-right" ></div></th>
                            <th style="width: 25%;"><div class="img-icon bg-OneDrive img-margin-right"   ></div></th>
                            <th style="width: 25%;"> &nbsp;&nbsp;</th>
                         
                          </tr>
                          <tr>
                            <td><p class="txt-namepro p-left" > SharePoint </p></td>
                            <td><p class="txt-namepro p-left" > OneDrive </p></td>
                            <td><p class="txt-namepro"> &nbsp;&nbsp; </p></td>
                          </tr>
                     </table>


			
			
					<div style="text-align: center;">  
						<a href="https://support.netway.co.th/hc/th/requests/new?ticket_form_id=114093963072&request_subject=ขอใบเสนอนราคา SharePoint Online Plan 1 &request_custom_fields_114095596292=sales_opt_other" target="_blank">
	                    <button class="btn-buy button-plan-125px" style="margin-bottom: 10px;  padding: 15px 5px;" type="button">
	                                              ขอใบเสนอราคา  <i class="fa fa-chevron-right" aria-hidden="true"></i>
	                    </button>
	                    </a>
                    </div>
                      
					</div>
					</div>
                 <div class="span3">
                    <!-- SharePoint Online Plan 2  -->
                    <div class="plan-gs div-plan-sharepoint" >
                    <p class="txt-price-small" style="margin-top: -5px; font-size: 26px;  font-weight: bold;  color: #0052cd"">SharePoint Online Plan 2</p>

                    
                    <hr style="border-top: 2px solid #cccccc;">
        
                    <p class="g-txt16" style="padding: 5px 0 35px 0; font-size: 16px; text-align: left;">
                  SharePoint Online ที่มีฟีเจอร์ทั้งหมดที่มีความสามารถสำหรับองค์กร
                    </p><p>
                    <!-- Title Product Group Office 365 Home 0 -->
                    </p>
                    <p class="txt-titel-pro" style="text-align: left; margin-bottom: 20px;">แอปพลิเคชัน Office </p>
                    <p style="padding: 82px 0 135px 0;">ไม่รวม</p>

                    <p class="txt-titel-pro" style="text-align: left; margin-top: 20px;">บริการ</p>
                    <table style="width: 100%; text-align: center;">
                          <tr >
                            <th style="width: 25%;"><div class="img-icon bg-SharePoint img-margin-right" ></div></th>
                            <th style="width: 25%;"><div class="img-icon bg-OneDrive img-margin-right"   ></div></th>
                            <th style="width: 25%;"> &nbsp;&nbsp;</th>
                         
                          </tr>
                          <tr>
                            <td><p class="txt-namepro p-left" > SharePoint </p></td>
                            <td><p class="txt-namepro p-left" > OneDrive </p></td>
                            <td><p class="txt-namepro"> &nbsp;&nbsp; </p></td>
                          </tr>
                     </table>
                     
                   <div style="text-align: center;">  
	                    <a href="https://support.netway.co.th/hc/th/requests/new?ticket_form_id=114093963072&request_subject=ขอใบเสนอนราคา SharePoint Online Plan 2 &request_custom_fields_114095596292=sales_opt_other" target="_blank">
	                    <button class="btn-buy button-plan-125px" style="margin-bottom: 10px;  padding: 15px 5px;" type="button">
       	                                        ขอใบเสนอราคา  <i class="fa fa-chevron-right" aria-hidden="true"></i>
	                    </button>
	                    </a>
                    </div>
                      
                    </div>
                    </div>
                    
                     <div class="span3">
                    <!-- Office 365 Enterprise E3 -->
                    <div class="plan-gs div-plan-sharepoint">
                    <p class="txt-price-small" style="margin-top: -5px; font-size: 26px;  font-weight: bold;  color: #0052cd"">Office 365 Enterprise E3</p>
     
                    
                    <hr style="border-top: 2px solid #cccccc;">
               
                    <p class="g-txt16" style="padding: 5px 0 0px 0; font-size: 16px; text-align: justify;">
                                                ธุรกิจที่ต้องการใช้ Office ทรงประสิทธิภาพจากบริการขั้นสูง   รวมสิทธิประโยชน์ของ SharePoint Online Plan 2 ทั้งหมดและอื่นๆ
                    </p>
                    <br/>
                    <!-- Title Product Group Office 365 Home 0 -->
                  
                    <p class="txt-titel-pro" style="text-align: left; margin-top: -4px; margin-bottom: 20px;">แอปพลิเคชัน Office </p>
                      <table style="width: 100%;">
						  <tr >
						    <th style="width: 33.33%;"><div class="img-icon bg-Outlook img-margin-right" ></div></th>
						    <th style="width: 33.33%;"><div class="img-icon bg-Word img-margin-right"    ></div></th>
						    <th style="width: 33.33%;"><div class="img-icon bg-Excel img-margin-right"   ></div></th>
						  </tr>
						  
						  <tr>
						    <td><p class="txt-namepro p-left" >Outlook</p></td>
						    <td><p class="txt-namepro p-left" >Word</p></td>
						    <td><p class="txt-namepro p-left" >Excel</p></td>
						  </tr>
						  
						 <tr >
						    <th ><div class="img-icon bg-PowerPoint"  style="margin-bottom: 0;"></div></th>
                            <th ><div class="img-icon bg-OneNote"     style="margin-bottom: 0;"></div></th>
                            <th ><div class="img-icon bg-Publisher"   style="margin-bottom: 0;"></div></th>
                         </tr>
                         
                         <tr>
                            <td><p class="txt-namepro p-left" >PowerPoint</p></td>
                            <td><p class="txt-namepro p-left" >OneNote</p></td>
                            <td><p class="txt-namepro p-left" >Publisher</p></td>
                         </tr>
                         
                          <tr >
                            <th ><div class="img-icon bg-Access"  style="margin-bottom: 0;"></div></th>
                            <th > &nbsp; </th>
                            <th > &nbsp; </th>
                         </tr>
                         
                         <tr>
                            <td><p class="txt-namepro" style="margin-left: -40px;">Access</p></td>
                            <td> &nbsp; </td>
                            <td> &nbsp; </td>
                         </tr>
                         
					 </table>
					 <p class="txt-titel-pro" style="text-align: left; margin-top: 10px; margin-bottom: 10px;">บริการ </p>
                      <table style="width: 100%; ">
                          <tr >
                            <th style="width: 33.33%;"><div class="img-icon bg-Exchange img-margin-right "  ></div></th>
                            <th style="width: 33.33%;"><div class="img-icon bg-OneDrive img-margin-right "  ></div></th>
                            <th style="width: 33.33%;"><div class="img-icon img-margin-right " style="background-image : url('https://netway.co.th/templates/netwaybysidepad/images/AppTile_Yammer-min.png');"></div></th>
                          </tr>
                          <tr>
                            <td><p class="txt-namepro p-left" >Exchange</p></td>
                            <td><p class="txt-namepro p-left" >OneDrive</p></td>
                            <td><p class="txt-namepro p-left" >Yammer</p></td>
                            
                          </tr>
                         <tr >
                            <th ><div class="img-icon bg-SharePoint"  style="margin-bottom: 0; margin-right: 10px;"></div></th>
                            <th ><div class="img-icon bg-Teams"       style="margin-bottom: 0; margin-right: 10px;"></div></th>
                            <th ><div class="img-icon bg-Skype-BS"    style="margin-bottom: 0; margin-right: 10px;"></div></th>
                       
                          </tr>
                          <tr>
                            <td><p class="txt-namepro p-left" >SharePoint</p></td>
                            <td><p class="txt-namepro p-left" >Microsoft Teams</p></td>
                            <td><p class="txt-namepro p-left" >Skype for  <br/> Business</p></td>
                          </tr>
                     </table>
                   
                   <div style="text-align: center;">            
	                   <a href="https://support.netway.co.th/hc/th/requests/new?ticket_form_id=114093963072&request_subject=ขอใบเสนอนราคา Office 365 Enterprise E3 &request_custom_fields_114095596292=sales_opt_other" target="_blank">
		                    <button class="btn-buy button-plan-40px " style="margin-bottom: 10px;  padding: 15px 5px;" type="button">
		                                                  ขอใบเสนอราคา  <i class="fa fa-chevron-right" aria-hidden="true"></i>
		                    </button>
	                    </a>
                    </div>
                    
                      
                    </div>
                    </div>

        
                
    
            </div>
               
    <div class="row-fluid hidden-phone" style="margin-top: 40px;" > 
      <div class="container" >
            <div class="row" style="text-align: center">
                <div class="span3"><div class="padding-row-f"> </div></div>
                <div class="span3 features-list-top"><div class="padding-row-f"> </div><p class="txt-price-small" style="margin-top: -5px; font-size: 20px;  font-weight: bold;  color: #0052cd">SharePoint Online Plan 1</p></div>
                <div class="span3 features-list-top"><div class="padding-row-f"> </div><p class="txt-price-small" style="margin-top: -5px; font-size: 20px;  font-weight: bold;  color: #0052cd">SharePoint Online Plan 2</p></div> 
                <div class="span3 features-list-top"><div class="padding-row-f"> </div><p class="txt-price-small" style="margin-top: -5px; font-size: 20px;  font-weight: bold;  color: #0052cd">Office 365 Enterprise E3</p></div>               
            </div>
            <div class="row">
                 <div class="span12" style="text-align: left; background-color: #d6dae0; padding: 10px 5px 5px 20px;"><p class="g-txt18" style="font-weight: 800;">Apps</p></div>
            </div>      
            <div class="row row-white">
				<div class="span3">
					<div class="padding-row-f">
					   App Catalog and Maketplace
					</div>
				</div>
				<div class="span3 features-list-content" >
					<div class="padding-row-f" style="text-align: center;">
				    	<i class="fa fa-check" aria-hidden="true" style="color: #00cc4d;"></i>
					</div>
				</div>
				<div class="span3 features-list-content">
					<div class="padding-row-f" style="text-align: center;">
					   <i class="fa fa-check" aria-hidden="true" style="color: #00cc4d;"></i>
					</div>
				</div>
				<div class="span3 features-list-content" title="ติดต่อเจ้าหน้าที่">
				   <div class="padding-row-f" style="text-align: center;">
	                  <i class="fa fa-info-circle" aria-hidden="true" title="ติดต่อเจ้าหน้าที่"></i>
	               </div>
                </div>
			</div>
			<div class="row">
                 <div class="span12" style="text-align: left; background-color: #d6dae0; padding: 10px 5px 5px 20px;"><p class="g-txt18" style="font-weight: 800;">Collaboration</p></div>
            </div>  
            <div class="row row-white">
                <div class="span3">
                    <div class="padding-row-f">
                       Team Sites
                    </div>
                </div>
                <div class="span3 features-list-content">
                    <div class="padding-row-f" style="text-align: center;">
                        <i class="fa fa-check" aria-hidden="true" style="color: #00cc4d;"></i>
                    </div>
                </div>
                <div class="span3 features-list-content">
                    <div class="padding-row-f" style="text-align: center;">
                       <i class="fa fa-check" aria-hidden="true" style="color: #00cc4d;"></i>
                    </div>
                </div>
                <div class="span3 features-list-content" title="ติดต่อเจ้าหน้าที่">
                    <div class="padding-row-f" style="text-align: center; color: color: #494a4a;">
                       <i class="fa fa-info-circle" aria-hidden="true" title="ติดต่อเจ้าหน้าที่"></i>
                    </div>
                </div>
            </div>
            <div class="row row-gray">
                <div class="span3">
                    <div class="padding-row-f">
                       External Sharing
                    </div>
                </div>
                <div class="span3 features-list-content">
                    <div class="padding-row-f" style="text-align: center;">
                        <i class="fa fa-check" aria-hidden="true" style="color: #00cc4d;"></i>
                    </div>
                </div>
                <div class="span3 features-list-content">
                    <div class="padding-row-f" style="text-align: center;">
                       <i class="fa fa-check" aria-hidden="true" style="color: #00cc4d;"></i>
                    </div>
                </div>
                <div class="span3 features-list-content" title="ติดต่อเจ้าหน้าที่">
                    <div class="padding-row-f" style="text-align: center; color: color: #494a4a;">
                      <i class="fa fa-info-circle" aria-hidden="true" title="ติดต่อเจ้าหน้าที่"></i>
                    </div>
                </div>
            </div>
            <div class="row">
                 <div class="span12" style="text-align: left; background-color: #d6dae0; padding: 10px 5px 5px 20px;"><p class="g-txt18" style="font-weight: 800;">Search</p></div>
            </div> 
            <div class="row row-white">
                <div class="span3">
                    <div class="padding-row-f">
                       Basic Search
                    </div>
                </div>
                <div class="span3 features-list-content">
                    <div class="padding-row-f" style="text-align: center;">
                        <i class="fa fa-check" aria-hidden="true" style="color: #00cc4d;"></i>
                    </div>
                </div>
                <div class="span3 features-list-content">
                    <div class="padding-row-f" style="text-align: center;">
                       <i class="fa fa-check" aria-hidden="true" style="color: #00cc4d;"></i>
                    </div>
                </div>
                <div class="span3 features-list-content" title="ติดต่อเจ้าหน้าที่">
                    <div class="padding-row-f" style="text-align: center; color: color: #494a4a;">
                       <i class="fa fa-info-circle" aria-hidden="true" title="ติดต่อเจ้าหน้าที่"></i>
                    </div>
                </div>
            </div>
            <div class="row row-gray">
                <div class="span3">
                    <div class="padding-row-f">
                       Standard Search
                    </div>
                </div>
                <div class="span3 features-list-content">
                    <div class="padding-row-f" style="text-align: center;">
                        <i class="fa fa-check" aria-hidden="true" style="color: #00cc4d;"></i>
                    </div>
                </div>
                <div class="span3 features-list-content">
                    <div class="padding-row-f" style="text-align: center;">
                       <i class="fa fa-check" aria-hidden="true" style="color: #00cc4d;"></i>
                    </div>
                </div>
                <div class="span3 features-list-content" title="ติดต่อเจ้าหน้าที่">
                    <div class="padding-row-f" style="text-align: center; color: color: #494a4a;">
                       <i class="fa fa-info-circle" aria-hidden="true" title="ติดต่อเจ้าหน้าที่"></i>
                    </div>
                </div>
            </div>
            
            <div class="row row-white">
                <div class="span3">
                    <div class="padding-row-f">
                       Enterprise Search
                    </div>
                </div>
                <div class="span3 features-list-content">
                    <div class="padding-row-f" style="text-align: center;">
                       <i class="fa fa-minus" aria-hidden="true" style="color: #cccccc;"></i>
                    </div>
                </div>
                <div class="span3 features-list-content">
                    <div class="padding-row-f" style="text-align: center;">
                       <i class="fa fa-check" aria-hidden="true" style="color: #00cc4d;"></i>
                    </div>
                </div>
                <div class="span3 features-list-content" title="ติดต่อเจ้าหน้าที่">
                    <div class="padding-row-f" style="text-align: center; color: color: #494a4a;">
                      <i class="fa fa-info-circle" aria-hidden="true" title="ติดต่อเจ้าหน้าที่"></i>
                    </div>
                </div>
            </div>
            <div class="row">
                 <div class="span12" style="text-align: left; background-color: #d6dae0; padding: 10px 5px 5px 20px;"><p class="g-txt18" style="font-weight: 800;">Content Management</p></div>
            </div> 
            <div class="row row-white">
                <div class="span3">
                    <div class="padding-row-f">
                       Content Management
                    </div>
                </div>
                <div class="span3 features-list-content">
                    <div class="padding-row-f" style="text-align: center;">
                        <i class="fa fa-check" aria-hidden="true" style="color: #00cc4d;"></i>
                    </div>
                </div>
                <div class="span3 features-list-content">
                    <div class="padding-row-f" style="text-align: center;">
                       <i class="fa fa-check" aria-hidden="true" style="color: #00cc4d;"></i>
                    </div>
                </div>
                <div class="span3 features-list-content" title="ติดต่อเจ้าหน้าที่">
                    <div class="padding-row-f" style="text-align: center; color: color: #494a4a;">
                       <i class="fa fa-info-circle" aria-hidden="true" title="ติดต่อเจ้าหน้าที่"></i>
                    </div>
                </div>
            </div>
            <div class="row row-gray">
                <div class="span3">
                    <div class="padding-row-f">
                       Records Management
                    </div>
                </div>
                <div class="span3 features-list-content">
                    <div class="padding-row-f" style="text-align: center;">
                        <i class="fa fa-check" aria-hidden="true" style="color: #00cc4d;"></i>
                    </div>
                </div>
                <div class="span3 features-list-content">
                    <div class="padding-row-f" style="text-align: center;">
                       <i class="fa fa-check" aria-hidden="true" style="color: #00cc4d;"></i>
                    </div>
                </div>
                <div class="span3 features-list-content" title="ติดต่อเจ้าหน้าที่">
                    <div class="padding-row-f" style="text-align: center; color: color: #494a4a;">
                       <i class="fa fa-info-circle" aria-hidden="true" title="ติดต่อเจ้าหน้าที่"></i>
                    </div>
                </div>
            </div>
            <div class="row row-white">
                <div class="span3">
                    <div class="padding-row-f">
                       E-discovery, ACM, Compliance
                    </div>
                </div>
                <div class="span3 features-list-content">
                    <div class="padding-row-f" style="text-align: center;">
                        <i class="fa fa-minus" aria-hidden="true" style="color: #cccccc;"></i>
                    </div>
                </div>
                <div class="span3 features-list-content">
                    <div class="padding-row-f" style="text-align: center;">
                       <i class="fa fa-check" aria-hidden="true" style="color: #00cc4d;"></i>
                    </div>
                </div>
                <div class="span3 features-list-content" title="ติดต่อเจ้าหน้าที่">
                    <div class="padding-row-f" style="text-align: center; color: color: #494a4a;">
                      <i class="fa fa-info-circle" aria-hidden="true" title="ติดต่อเจ้าหน้าที่"></i>
                    </div>
                </div>
            </div>
            <div class="row">
            <div class="span12" style="text-align: left; background-color: #d6dae0; padding: 10px 5px 5px 20px;"><p class="g-txt18" style="font-weight: 800;">Business Intelligence</p></div>
            </div>  
            <div class="row row-white">
                <div class="span3">
                    <div class="padding-row-f">
                       Excel Services, PowerPivot, PowerView 
                    </div>
                </div>
                <div class="span3 features-list-content">
                    <div class="padding-row-f" style="text-align: center;">
                       <i class="fa fa-minus" aria-hidden="true" style="color: #cccccc;"></i>
                    </div>
                </div>
                <div class="span3 features-list-content">
                    <div class="padding-row-f" style="text-align: center;">
                       <i class="fa fa-check" aria-hidden="true" style="color: #00cc4d;"></i>
                    </div>
                </div>
                <div class="span3 features-list-content" title="ติดต่อเจ้าหน้าที่">
                    <div class="padding-row-f" style="text-align: center; color: color: #494a4a;">
                      <i class="fa fa-info-circle" aria-hidden="true" title="ติดต่อเจ้าหน้าที่"></i>
                    </div>
                </div>
            </div>
            <div class="row">
               <div class="span12" style="text-align: left; background-color: #d6dae0; padding: 10px 5px 5px 20px;"><p class="g-txt18" style="font-weight: 800;">Business Solutions</p></div>
            </div> 
            <div class="row row-white">
                <div class="span3">
                    <div class="padding-row-f">
                       Visio Services
                    </div>
                </div>
                <div class="span3 features-list-content">
                    <div class="padding-row-f" style="text-align: center;">
                        <i class="fa fa-minus" aria-hidden="true" style="color: #cccccc;"></i>
                    </div>
                </div>
                <div class="span3 features-list-content">
                    <div class="padding-row-f" style="text-align: center;">
                       <i class="fa fa-check" aria-hidden="true" style="color: #00cc4d;"></i>
                    </div>
                </div>
                <div class="span3 features-list-content" title="ติดต่อเจ้าหน้าที่">
                    <div class="padding-row-f" style="text-align: center; color: color: #494a4a;">
                        <i class="fa fa-info-circle" aria-hidden="true" title="ติดต่อเจ้าหน้าที่"></i>
                    </div>
                </div>
            </div>
            <div class="row row-gray">
                <div class="span3">
                    <div class="padding-row-f">
                       Form Based Application 
                    </div>
                </div>
                <div class="span3 features-list-content">
                    <div class="padding-row-f" style="text-align: center;">
                        <i class="fa fa-minus" aria-hidden="true" style="color: #cccccc;"></i>
                    </div>
                </div>
                <div class="span3 features-list-content">
                    <div class="padding-row-f" style="text-align: center;">
                       <i class="fa fa-check" aria-hidden="true" style="color: #00cc4d;"></i>
                    </div>
                </div>
                <div class="span3 features-list-content" title="ติดต่อเจ้าหน้าที่">
                    <div class="padding-row-f" style="text-align: center; color: color: #494a4a;">
                        <i class="fa fa-info-circle" aria-hidden="true" title="ติดต่อเจ้าหน้าที่"></i>
                    </div>
                </div>
            </div> 
            <div class="row row-white">
                <div class="span3 ">
                    <div class="padding-row-f">
                       SharePoint 2013 Workflow
                    </div>
                </div>
                <div class="span3 features-list-content">
                    <div class="padding-row-f" style="text-align: center;">
                        <i class="fa fa-check" aria-hidden="true" style="color: #00cc4d;"></i>
                    </div>
                </div>
                <div class="span3 features-list-content">
                    <div class="padding-row-f" style="text-align: center;">
                       <i class="fa fa-check" aria-hidden="true" style="color: #00cc4d;"></i>
                    </div>
                </div>
                <div class="span3 features-list-content" title="ติดต่อเจ้าหน้าที่">
                    <div class="padding-row-f" style="text-align: center; color: color: #494a4a;">
                       <i class="fa fa-info-circle" aria-hidden="true" title="ติดต่อเจ้าหน้าที่"></i>
                    </div>
                </div>
            </div> 
            <div class="row row-gray">
                <div class="span3">
                    <div class="padding-row-f">
                       Business Connectivity Services
                    </div>
                </div>
                <div class="span3 features-list-content">
                    <div class="padding-row-f" style="text-align: center;">
                        <i class="fa fa-minus" aria-hidden="true" style="color: #cccccc;"></i>
                    </div>
                </div>
                <div class="span3 features-list-content">
                    <div class="padding-row-f" style="text-align: center;">
                       <i class="fa fa-check" aria-hidden="true" style="color: #00cc4d;"></i>
                    </div>
                </div>
                <div class="span3 features-list-content" title="ติดต่อเจ้าหน้าที่">
                    <div class="padding-row-f" style="text-align: center; color: color: #494a4a;">
                      <i class="fa fa-info-circle" aria-hidden="true" title="ติดต่อเจ้าหน้าที่"></i>
                    </div>
                </div>
            </div> 
            <div class="row row-white">
               <div class="span3">
                    <div class="padding-row-f">
                       &nbsp;&nbsp;  
                    </div>
                </div>
                <div class="span3 features-list-bottom">
                    <div class="padding-row-f" style="text-align: center;">
                       <a href="https://support.netway.co.th/hc/th/requests/new?ticket_form_id=114093963072&request_subject=ขอใบเสนอนราคา  SharePoint Online Plan 1 &request_custom_fields_114095596292=sales_opt_other" target="_blank">
                            <button class="btn-buy button-plan-40px " style="margin-bottom: 40px;  padding: 15px 5px;" type="button">
                                                          ขอใบเสนอราคา  <i class="fa fa-chevron-right" aria-hidden="true"></i>
                            </button>
                        </a>
                    </div>
                </div>
                <div class="span3 features-list-bottom">
                    <div class="padding-row-f" style="text-align: center;">
                      <a href="https://support.netway.co.th/hc/th/requests/new?ticket_form_id=114093963072&request_subject=ขอใบเสนอนราคา  SharePoint Online Plan 2 &request_custom_fields_114095596292=sales_opt_other" target="_blank">
                            <button class="btn-buy button-plan-40px " style="margin-bottom: 40px;  padding: 15px 5px;" type="button">
                                                          ขอใบเสนอราคา  <i class="fa fa-chevron-right" aria-hidden="true"></i>
                            </button>
                        </a>
                    </div>
                </div>
                <div class="span3 features-list-bottom">
                    <div class="padding-row-f" style="text-align: center; color: color: #494a4a;">
                      <a href="https://support.netway.co.th/hc/th/requests/new?ticket_form_id=114093963072&request_subject=ขอใบเสนอนราคา Office 365 Enterprise E3 &request_custom_fields_114095596292=sales_opt_other" target="_blank">
                            <button class="btn-buy button-plan-40px " style="margin-bottom: 40px;  padding: 15px 5px;" type="button">
                                                          ขอใบเสนอราคา  <i class="fa fa-chevron-right" aria-hidden="true"></i>
                            </button>
                        </a>
                    </div>
                </div>
            </div>
        
       </div>
     </div>
     
{literal}     
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
                    <div class="swiper-container  visible-phone">
                        <div class="swiper-wrapper">
                            <div class="row  swiper-slide">
                               <div class="span3">
				                    <!-- SharePoint Online Plan 1-->
				                    <div class="plan-gs div-plan-sharepoint">
				                    <p class="txt-price-small" style="margin-top: -5px; font-size: 26px;  font-weight: bold;  color: #0052cd">SharePoint Online Plan 1</p>
				
				                    
				                    <hr style="border-top: 2px solid #cccccc;">
				            
				                    <p class="g-txt16" style="padding: 5px 0 35px 0; font-size: 16px; text-align: justify;">
				                    ฟีเจอร์ที่จำเป็นสำหรับธุรกิจขนาดเล็กและขนาดกลางเพื่อประสบความสำเร็จ
				                    </p><p>
				                    <!-- Title Product Group Office 365 Home 0 -->
				                    </p>
				                    <p class="txt-titel-pro" style="text-align: left; margin-bottom: 20px;">แอปพลิเคชัน Office </p>
				                    <p style="padding: 10px 0 10px 0;">ไม่รวม</p>
				
				                    <p class="txt-titel-pro" style="text-align: left; margin-top: 20px;">บริการ</p>
				                    <table style="width: 100%; text-align: center;">
				                          <tr >
				                            <th style="width: 25%;"><div class="img-icon bg-SharePoint img-margin-right" ></div></th>
				                            <th style="width: 25%;"><div class="img-icon bg-OneDrive img-margin-right"   ></div></th>
				                            <th style="width: 25%;"> &nbsp;&nbsp;</th>
				                         
				                          </tr>
				                          <tr>
				                            <td><p class="txt-namepro p-left" > SharePoint </p></td>
				                            <td><p class="txt-namepro p-left" > OneDrive </p></td>
				                            <td><p class="txt-namepro"> &nbsp;&nbsp; </p></td>
				                          </tr>
				                     </table>
				
				
				            
				            
				                    <div style="text-align: center;">  
				                        <a href="https://support.netway.co.th/hc/th/requests/new?ticket_form_id=114093963072&request_subject=ขอใบเสนอนราคา SharePoint Online Plan 1 &request_custom_fields_114095596292=sales_opt_other" target="_blank">
				                        <button class="btn-buy button-plan-125px" style="margin-bottom: 40px;  padding: 15px 5px;" type="button">
				                                                  ขอใบเสนอราคา  <i class="fa fa-chevron-right" aria-hidden="true"></i>
				                        </button>
				                        </a>
				                    </div>
				                    
				                    <table style="width: 100%;">
				                          <tr style="text-align: left; background-color: #d6dae0;">
				                            <th colspan="2" style="padding: 10px 5px 5px 20px;"> <p class="g-txt18" style="font-weight: 800;">Apps</p> </th> 
				                          </tr>
				                          <tr>
				                             <td class="padding-row-f" style="text-align: left; width :70%;"> App Catalog and Maketplace </td>
				                             <td class="padding-row-f" style="width :50%;"> <i class="fa fa-check" aria-hidden="true" style="color: #00cc4d;"></i> </td>
				                          </tr>
				                          <tr style="text-align: left; background-color: #d6dae0;">
                                            <td colspan="2" style="padding: 10px 5px 5px 20px;"> <p class="g-txt18" style="font-weight: 800;">Collaboration</p> </td> 
                                          </tr>
                                          <tr>
                                             <td class="padding-row-f" style="text-align: left; width :70%;"> Team Sites </td>
                                             <td class="padding-row-f" style="width :50%;"> <i class="fa fa-check" aria-hidden="true" style="color: #00cc4d;"></i> </td>
                                          </tr>
                                          <tr style="background-color: #f8f8f8;">
                                             <td class="padding-row-f" style="text-align: left; width :70%;">External Sharing </td>
                                             <td class="padding-row-f" style="width :50%;"> <i class="fa fa-check" aria-hidden="true" style="color: #00cc4d;"></i> </td>
                                          </tr>
                                          <tr style="text-align: left; background-color: #d6dae0;">
                                            <td colspan="2" style="padding: 10px 5px 5px 20px;"> <p class="g-txt18" style="font-weight: 800;">Search</p> </td> 
                                          </tr>
                                          <tr>
                                             <td class="padding-row-f" style="text-align: left; width :70%;"> Basic Search </td>
                                             <td class="padding-row-f" style="width :50%;"> <i class="fa fa-check" aria-hidden="true" style="color: #00cc4d;"></i> </td>
                                          </tr>
                                          <tr style="background-color: #f8f8f8;">
                                             <td class="padding-row-f" style="text-align: left; width :70%;"> Standard Search</td>
                                             <td class="padding-row-f" style="width :50%;"> <i class="fa fa-check" aria-hidden="true" style="color: #00cc4d;"></i> </td>
                                          </tr>
                                          <tr>
                                             <td class="padding-row-f" style="text-align: left; width :70%;"> Enterprise Search </td>
                                             <td class="padding-row-f" style="width :50%;"> <i class="fa fa-minus" aria-hidden="true" style="color: #cccccc;"></i> </td>
                                          </tr>
                                          <tr style="text-align: left; background-color: #d6dae0;">
                                            <td colspan="2" style="padding: 10px 5px 5px 20px;"> <p class="g-txt18" style="font-weight: 800;">Content Management</p> </td> 
                                          </tr>
                                          <tr>
                                             <td class="padding-row-f" style="text-align: left; width :70%;"> Content Management </td>
                                             <td class="padding-row-f" style="width :50%;"> <i class="fa fa-check" aria-hidden="true" style="color: #00cc4d;"></i> </td>
                                          </tr>
                                          <tr style="background-color: #f8f8f8;">
                                             <td class="padding-row-f" style="text-align: left; width :70%;"> Records Management </td>
                                             <td class="padding-row-f" style="width :50%;"> <i class="fa fa-check" aria-hidden="true" style="color: #00cc4d;"></i> </td>
                                          </tr>
                                          <tr>
                                             <td class="padding-row-f" style="text-align: left; width :70%;"> E-discovery, ACM, Compliance </td>
                                             <td class="padding-row-f" style="width :50%;"> <i class="fa fa-minus" aria-hidden="true" style="color: #cccccc;"></i> </td>
                                          </tr>
                                          <tr style="text-align: left; background-color: #d6dae0;">
                                            <td colspan="2" style="padding: 10px 5px 5px 20px;"> <p class="g-txt18" style="font-weight: 800;">Business Intelligence</p> </td> 
                                          </tr>
                                          <tr>
                                             <td class="padding-row-f" style="text-align: left; width :70%;"> Excel Services, PowerPivot, PowerView</td>
                                             <td class="padding-row-f" style="width :50%;"> <i class="fa fa-minus" aria-hidden="true" style="color: #cccccc;"></i> </td>
                                          </tr>
                                          <tr style="text-align: left; background-color: #d6dae0;">
                                            <td colspan="2" style="padding: 10px 5px 5px 20px;"> <p class="g-txt18" style="font-weight: 800;">Business Solutions</p> </td> 
                                          </tr>
                                          <tr>
                                             <td class="padding-row-f" style="text-align: left; width :70%;"> Visio Services </td>
                                             <td class="padding-row-f" style="width :50%;"> <i class="fa fa-minus" aria-hidden="true" style="color: #cccccc;"></i>  </td>
                                          </tr>
                                          <tr style="background-color: #f8f8f8;">
                                             <td class="padding-row-f" style="text-align: left; width :70%;"> Form Based Application</td>
                                             <td class="padding-row-f" style="width :50%;"> <i class="fa fa-minus" aria-hidden="true" style="color: #cccccc;"></i>  </td>
                                          </tr>
                                          <tr>
                                             <td class="padding-row-f" style="text-align: left; width :70%;"> SharePoint 2013 Workflow</td>
                                             <td class="padding-row-f" style="width :50%;"> <i class="fa fa-check" aria-hidden="true" style="color: #00cc4d;"></i> </td>
                                          </tr>
                                          <tr style="background-color: #f8f8f8;">
                                             <td class="padding-row-f" style="text-align: left; width :70%;"> Business Connectivity Services </td>
                                             <td class="padding-row-f" style="width :50%;"> <i class="fa fa-minus" aria-hidden="true" style="color: #cccccc;"></i>  </td>
                                          </tr>
				                    </table>
				                    
				                       <div style="text-align: center;">  
                                        <a href="https://support.netway.co.th/hc/th/requests/new?ticket_form_id=114093963072&request_subject=ขอใบเสนอนราคา SharePoint Online Plan 1 &request_custom_fields_114095596292=sales_opt_other" target="_blank">
                                        <button class="btn-buy button-plan-125px" style="margin-bottom: 40px;  padding: 15px 5px;" type="button">
                                                                                        ขอใบเสนอราคา  <i class="fa fa-chevron-right" aria-hidden="true"></i>
                                        </button>
                                        </a>
                                      </div>
				                      
				                    </div>
				                </div>
                            </div>
                            <div class="row  visible-phone  swiper-slide">
                                <div class="span3">
				                    <!-- SharePoint Online Plan 2  -->
				                    <div class="plan-gs div-plan-sharepoint" >
				                    <p class="txt-price-small" style="margin-top: -5px; font-size: 26px;  font-weight: bold;  color: #0052cd"">SharePoint Online Plan 2</p>
				
				                    
				                    <hr style="border-top: 2px solid #cccccc;">
				        
				                    <p class="g-txt16" style="padding: 5px 0 35px 0; font-size: 16px; text-align: left;">
				                  SharePoint Online ที่มีฟีเจอร์ทั้งหมดที่มีความสามารถสำหรับองค์กร
				                    </p><p>
				                    <!-- Title Product Group Office 365 Home 0 -->
				                    </p>
				                    <p class="txt-titel-pro" style="text-align: left; margin-bottom: 20px;">แอปพลิเคชัน Office </p>
				                    <p style="padding: 10px 0 10px 0;">ไม่รวม</p>
				
				                    <p class="txt-titel-pro" style="text-align: left; margin-top: 20px;">บริการ</p>
				                    <table style="width: 100%; text-align: center;">
				                          <tr >
				                            <th style="width: 25%;"><div class="img-icon bg-SharePoint img-margin-right" ></div></th>
				                            <th style="width: 25%;"><div class="img-icon bg-OneDrive img-margin-right"   ></div></th>
				                            <th style="width: 25%;"> &nbsp;&nbsp;</th>
				                         
				                          </tr>
				                          <tr>
				                            <td><p class="txt-namepro p-left" > SharePoint </p></td>
				                            <td><p class="txt-namepro p-left" > OneDrive </p></td>
				                            <td><p class="txt-namepro"> &nbsp;&nbsp; </p></td>
				                          </tr>
				                     </table>
				                     
				                   <div style="text-align: center;">  
				                        <a href="https://support.netway.co.th/hc/th/requests/new?ticket_form_id=114093963072&request_subject=ขอใบเสนอนราคา SharePoint Online Plan 2 &request_custom_fields_114095596292=sales_opt_other" target="_blank">
				                        <button class="btn-buy button-plan-125px" style="margin-bottom: 40px;  padding: 15px 5px;" type="button">
				                                                ขอใบเสนอราคา  <i class="fa fa-chevron-right" aria-hidden="true"></i>
				                        </button>
				                        </a>
				                    </div>
				                    
				                    <table style="width: 100%;">
                                          <tr style="text-align: left; background-color: #d6dae0;">
                                            <th colspan="2" style="padding: 10px 5px 5px 20px;"> <p class="g-txt18" style="font-weight: 800;">Apps</p> </th> 
                                          </tr>
                                          <tr>
                                             <td class="padding-row-f" style="text-align: left; width :70%;"> App Catalog and Maketplace </td>
                                             <td class="padding-row-f" style="width :50%;"> <i class="fa fa-check" aria-hidden="true" style="color: #00cc4d;"></i> </td>
                                          </tr>
                                          <tr style="text-align: left; background-color: #d6dae0;">
                                            <td colspan="2" style="padding: 10px 5px 5px 20px;"> <p class="g-txt18" style="font-weight: 800;">Collaboration</p> </td> 
                                          </tr>
                                          <tr>
                                             <td class="padding-row-f" style="text-align: left; width :70%;"> Team Sites </td>
                                             <td class="padding-row-f" style="width :50%;"> <i class="fa fa-check" aria-hidden="true" style="color: #00cc4d;"></i> </td>
                                          </tr>
                                          <tr style="background-color: #f8f8f8;">
                                             <td class="padding-row-f" style="text-align: left; width :70%;">External Sharing </td>
                                             <td class="padding-row-f" style="width :50%;"> <i class="fa fa-check" aria-hidden="true" style="color: #00cc4d;"></i> </td>
                                          </tr>
                                          <tr style="text-align: left; background-color: #d6dae0;">
                                            <td colspan="2" style="padding: 10px 5px 5px 20px;"> <p class="g-txt18" style="font-weight: 800;">Search</p> </td> 
                                          </tr>
                                          <tr>
                                             <td class="padding-row-f" style="text-align: left; width :70%;"> Basic Search </td>
                                             <td class="padding-row-f" style="width :50%;"> <i class="fa fa-check" aria-hidden="true" style="color: #00cc4d;"></i> </td>
                                          </tr>
                                          <tr style="background-color: #f8f8f8;">
                                             <td class="padding-row-f" style="text-align: left; width :70%;"> Standard Search</td>
                                             <td class="padding-row-f" style="width :50%;"> <i class="fa fa-check" aria-hidden="true" style="color: #00cc4d;"></i> </td>
                                          </tr>
                                          <tr>
                                             <td class="padding-row-f" style="text-align: left; width :70%;"> Enterprise Search </td>
                                             <td class="padding-row-f" style="width :50%;"> <i class="fa fa-check" aria-hidden="true" style="color: #00cc4d;"></i> </td>
                                          </tr>
                                          <tr style="text-align: left; background-color: #d6dae0;">
                                            <td colspan="2" style="padding: 10px 5px 5px 20px;"> <p class="g-txt18" style="font-weight: 800;">Content Management</p> </td> 
                                          </tr>
                                          <tr>
                                             <td class="padding-row-f" style="text-align: left; width :70%;"> Content Management </td>
                                             <td class="padding-row-f" style="width :50%;"> <i class="fa fa-check" aria-hidden="true" style="color: #00cc4d;"></i> </td>
                                          </tr>
                                          <tr style="background-color: #f8f8f8;">
                                             <td class="padding-row-f" style="text-align: left; width :70%;"> Records Management </td>
                                             <td class="padding-row-f" style="width :50%;"> <i class="fa fa-check" aria-hidden="true" style="color: #00cc4d;"></i> </td>
                                          </tr>
                                          <tr>
                                             <td class="padding-row-f" style="text-align: left; width :70%;"> E-discovery, ACM, Compliance </td>
                                             <td class="padding-row-f" style="width :50%;"> <i class="fa fa-check" aria-hidden="true" style="color: #00cc4d;"></i> </td>
                                          </tr>
                                          <tr style="text-align: left; background-color: #d6dae0;">
                                            <td colspan="2" style="padding: 10px 5px 5px 20px;"> <p class="g-txt18" style="font-weight: 800;">Business Intelligence</p> </td> 
                                          </tr>
                                          <tr>
                                             <td class="padding-row-f" style="text-align: left; width :70%;"> Excel Services, PowerPivot, PowerView</td>
                                             <td class="padding-row-f" style="width :50%;"> <i class="fa fa-check" aria-hidden="true" style="color: #00cc4d;"></i> </td>
                                          </tr>
                                          <tr style="text-align: left; background-color: #d6dae0;">
                                            <td colspan="2" style="padding: 10px 5px 5px 20px;"> <p class="g-txt18" style="font-weight: 800;">Business Solutions</p> </td> 
                                          </tr>
                                          <tr>
                                             <td class="padding-row-f" style="text-align: left; width :70%;"> Visio Services </td>
                                             <td class="padding-row-f" style="width :50%;"> <i class="fa fa-check" aria-hidden="true" style="color: #00cc4d;"></i> </td>
                                          </tr>
                                          <tr style="background-color: #f8f8f8;">
                                             <td class="padding-row-f" style="text-align: left; width :70%;"> Form Based Application</td>
                                             <td class="padding-row-f" style="width :50%;"> <i class="fa fa-check" aria-hidden="true" style="color: #00cc4d;"></i> </td>
                                          </tr>
                                          <tr>
                                             <td class="padding-row-f" style="text-align: left; width :70%;"> SharePoint 2013 Workflow</td>
                                             <td class="padding-row-f" style="width :50%;"> <i class="fa fa-check" aria-hidden="true" style="color: #00cc4d;"></i> </td>
                                          </tr>
                                          <tr style="background-color: #f8f8f8;">
                                             <td class="padding-row-f" style="text-align: left; width :70%;"> Business Connectivity Services </td>
                                             <td class="padding-row-f" style="width :50%;"> <i class="fa fa-check" aria-hidden="true" style="color: #00cc4d;"></i> </td>
                                          </tr>
                                    </table>
                                    
                                       <div style="text-align: center;">  
                                        <a href="https://support.netway.co.th/hc/th/requests/new?ticket_form_id=114093963072&request_subject=ขอใบเสนอนราคา SharePoint Online Plan 2 &request_custom_fields_114095596292=sales_opt_other" target="_blank">
                                        <button class="btn-buy button-plan-125px" style="margin-bottom: 40px;  padding: 15px 5px;" type="button">
                                                                                        ขอใบเสนอราคา  <i class="fa fa-chevron-right" aria-hidden="true"></i>
                                        </button>
                                        </a>
                                      </div>
                                      
				                    </div>
				                 </div>
                             </div>
                             <div class="row  visible-phone  swiper-slide">   
                                <div class="span3">
			                    <!-- Office 365 Enterprise E3 -->
				                    <div class="plan-gs div-plan-sharepoint">
				                    <p class="txt-price-small" style="margin-top: -5px; font-size: 26px;  font-weight: bold;  color: #0052cd"">Office 365 Enterprise E3</p>
				     
				                    
				                    <hr style="border-top: 2px solid #cccccc;">
				               
				                    <p class="g-txt16" style="padding: 5px 0 0px 0; font-size: 16px; text-align: justify;">
				                                                ธุรกิจที่ต้องการใช้ Office ทรงประสิทธิภาพจากบริการขั้นสูง   รวมสิทธิประโยชน์ของ SharePoint Online Plan 2 ทั้งหมดและอื่นๆ
				                    </p>
				                    <br/>
				                    <!-- Title Product Group Office 365 Home 0 -->
				                  
				                    <p class="txt-titel-pro" style="text-align: left; margin-top: -4px; margin-bottom: 20px;">แอปพลิเคชัน Office </p>
				                      <table style="width: 100%;">
				                          <tr >
				                            <th style="width: 33.33%;"><div class="img-icon bg-Outlook img-margin-right" ></div></th>
				                            <th style="width: 33.33%;"><div class="img-icon bg-Word img-margin-right"    ></div></th>
				                            <th style="width: 33.33%;"><div class="img-icon bg-Excel img-margin-right"   ></div></th>
				                          </tr>
				                          
				                          <tr>
				                            <td><p class="txt-namepro p-left" >Outlook</p></td>
				                            <td><p class="txt-namepro p-left" >Word</p></td>
				                            <td><p class="txt-namepro p-left" >Excel</p></td>
				                          </tr>
				                          
				                         <tr >
				                            <th ><div class="img-icon bg-PowerPoint"  style="margin-bottom: 0;"></div></th>
				                            <th ><div class="img-icon bg-OneNote"     style="margin-bottom: 0;"></div></th>
				                            <th ><div class="img-icon bg-Publisher"   style="margin-bottom: 0;"></div></th>
				                         </tr>
				                         
				                         <tr>
				                            <td><p class="txt-namepro p-left" >PowerPoint</p></td>
				                            <td><p class="txt-namepro p-left" >OneNote</p></td>
				                            <td><p class="txt-namepro p-left" >Publisher</p></td>
				                         </tr>
				                         
				                          <tr >
				                            <th ><div class="img-icon bg-Access"  style="margin-bottom: 0;"></div></th>
				                            <th > &nbsp; </th>
				                            <th > &nbsp; </th>
				                         </tr>
				                         
				                         <tr>
				                            <td><p class="txt-namepro p-left" >Access</p></td>
				                            <td> &nbsp; </td>
				                            <td> &nbsp; </td>
				                         </tr>
				                         
				                     </table>
				                     <p class="txt-titel-pro" style="text-align: left; margin-top: 10px; margin-bottom: 10px;">บริการ </p>
				                      <table style="width: 100%; ">
				                          <tr >
				                            <th style="width: 33.33%;"><div class="img-icon bg-Exchange img-margin-right "  ></div></th>
				                            <th style="width: 33.33%;"><div class="img-icon bg-OneDrive img-margin-right "  ></div></th>
				                            <th style="width: 33.33%;"><div class="img-icon img-margin-right " style="background-image : url('https://netway.co.th/templates/netwaybysidepad/images/AppTile_Yammer-min.png');"></div></th>
				                          </tr>
				                          <tr>
				                            <td><p class="txt-namepro p-left" >Exchange</p></td>
				                            <td><p class="txt-namepro p-left" >OneDrive</p></td>
				                            <td><p class="txt-namepro p-left" >Yammer</p></td>
				                            
				                          </tr>
				                         <tr >
				                            <th ><div class="img-icon bg-SharePoint"  style="margin-bottom: 0; margin-right: 10px;"></div></th>
				                            <th ><div class="img-icon bg-Teams"       style="margin-bottom: 0; margin-right: 10px;"></div></th>
				                            <th ><div class="img-icon bg-Skype-BS"    style="margin-bottom: 0; margin-right: 10px;"></div></th>
				                       
				                          </tr>
				                          <tr>
				                            <td><p class="txt-namepro p-left" >SharePoint</p></td>
				                            <td><p class="txt-namepro p-left" >Microsoft Teams</p></td>
				                            <td><p class="txt-namepro p-left" >Skype for  <br/> Business</p></td>
				                          </tr>
				                     </table>
				                   
				                   <div style="text-align: center;">            
				                       <a href="https://support.netway.co.th/hc/th/requests/new?ticket_form_id=114093963072&request_subject=ขอใบเสนอนราคา Office 365 Enterprise E3 &request_custom_fields_114095596292=sales_opt_other" target="_blank">
				                            <button class="btn-buy button-plan-40px " style="margin-bottom: 40px;  padding: 15px 5px;" type="button">
				                                                          ขอใบเสนอราคา  <i class="fa fa-chevron-right" aria-hidden="true"></i>
				                            </button>
				                        </a>
				                    </div>
				                    
				                    <table style="width: 100%;">
                                          <tr style="text-align: left; background-color: #d6dae0;">
                                            <th colspan="2" style="padding: 10px 5px 5px 20px;"> <p class="g-txt18" style="font-weight: 800;">Apps</p> </th> 
                                          </tr>
                                          <tr>
                                             <td class="padding-row-f" style="text-align: left; width :70%;"> App Catalog and Maketplace </td>
                                             <td class="padding-row-f" style="width :50%;"> <i class="fa fa-minus" aria-hidden="true" style="color: #cccccc;"></i>  </td>
                                          </tr>
                                          <tr style="text-align: left; background-color: #d6dae0;">
                                            <td colspan="2" style="padding: 10px 5px 5px 20px;"> <p class="g-txt18" style="font-weight: 800;">Collaboration</p> </td> 
                                          </tr>
                                          <tr>
                                             <td class="padding-row-f" style="text-align: left; width :70%;"> Team Sites </td>
                                             <td class="padding-row-f" style="width :50%;"> <i class="fa fa-minus" aria-hidden="true" style="color: #cccccc;"></i>  </td>
                                          </tr>
                                          <tr style="background-color: #f8f8f8;">
                                             <td class="padding-row-f" style="text-align: left; width :70%;">External Sharing </td>
                                             <td class="padding-row-f" style="width :50%;"> <i class="fa fa-minus" aria-hidden="true" style="color: #cccccc;"></i>  </td>
                                          </tr>
                                          <tr style="text-align: left; background-color: #d6dae0;">
                                            <td colspan="2" style="padding: 10px 5px 5px 20px;"> <p class="g-txt18" style="font-weight: 800;">Search</p> </td> 
                                          </tr>
                                          <tr>
                                             <td class="padding-row-f" style="text-align: left; width :70%;"> Basic Search </td>
                                             <td class="padding-row-f" style="width :50%;"> <i class="fa fa-minus" aria-hidden="true" style="color: #cccccc;"></i>  </td>
                                          </tr>
                                          <tr style="background-color: #f8f8f8;">
                                             <td class="padding-row-f" style="text-align: left; width :70%;"> Standard Search</td>
                                             <td class="padding-row-f" style="width :50%;"> <i class="fa fa-minus" aria-hidden="true" style="color: #cccccc;"></i>  </td>
                                          </tr>
                                          <tr>
                                             <td class="padding-row-f" style="text-align: left; width :70%;"> Enterprise Search </td>
                                             <td class="padding-row-f" style="width :50%;"> <i class="fa fa-minus" aria-hidden="true" style="color: #cccccc;"></i>  </td>
                                          </tr>
                                          <tr style="text-align: left; background-color: #d6dae0;">
                                            <td colspan="2" style="padding: 10px 5px 5px 20px;"> <p class="g-txt18" style="font-weight: 800;">Content Management</p> </td> 
                                          </tr>
                                          <tr>
                                             <td class="padding-row-f" style="text-align: left; width :70%;"> Content Management </td>
                                             <td class="padding-row-f" style="width :50%;"> <i class="fa fa-minus" aria-hidden="true" style="color: #cccccc;"></i>  </td>
                                          </tr>
                                          <tr style="background-color: #f8f8f8;">
                                             <td class="padding-row-f" style="text-align: left; width :70%;"> Records Management </td>
                                             <td class="padding-row-f" style="width :50%;"> <i class="fa fa-minus" aria-hidden="true" style="color: #cccccc;"></i>  </td>
                                          </tr>
                                          <tr>
                                             <td class="padding-row-f" style="text-align: left; width :70%;"> E-discovery, ACM, Compliance </td>
                                             <td class="padding-row-f" style="width :50%;"> <i class="fa fa-minus" aria-hidden="true" style="color: #cccccc;"></i>  </td>
                                          </tr>
                                          <tr style="text-align: left; background-color: #d6dae0;">
                                            <td colspan="2" style="padding: 10px 5px 5px 20px;"> <p class="g-txt18" style="font-weight: 800;">Business Intelligence</p> </td> 
                                          </tr>
                                          <tr>
                                             <td class="padding-row-f" style="text-align: left; width :70%;"> Excel Services, PowerPivot, PowerView</td>
                                             <td class="padding-row-f" style="width :50%;"> <i class="fa fa-minus" aria-hidden="true" style="color: #cccccc;"></i>  </td>
                                          </tr>
                                          <tr style="text-align: left; background-color: #d6dae0;">
                                            <td colspan="2" style="padding: 10px 5px 5px 20px;"> <p class="g-txt18" style="font-weight: 800;">Business Solutions</p> </td> 
                                          </tr>
                                          <tr>
                                             <td class="padding-row-f" style="text-align: left; width :70%;"> Visio Services </td>
                                             <td class="padding-row-f" style="width :50%;"> <i class="fa fa-minus" aria-hidden="true" style="color: #cccccc;"></i>  </td>
                                          </tr>
                                          <tr style="background-color: #f8f8f8;">
                                             <td class="padding-row-f" style="text-align: left; width :70%;"> Form Based Application</td>
                                             <td class="padding-row-f" style="width :50%;"> <i class="fa fa-minus" aria-hidden="true" style="color: #cccccc;"></i>  </td>
                                          </tr>
                                          <tr>
                                             <td class="padding-row-f" style="text-align: left; width :70%;"> SharePoint 2013 Workflow</td>
                                             <td class="padding-row-f" style="width :50%;"> <i class="fa fa-minus" aria-hidden="true" style="color: #cccccc;"></i>  </td>
                                          </tr>
                                          <tr style="background-color: #f8f8f8;">
                                             <td class="padding-row-f" style="text-align: left; width :70%;"> Business Connectivity Services </td>
                                             <td class="padding-row-f" style="width :50%;"> <i class="fa fa-minus" aria-hidden="true" style="color: #cccccc;"></i>  </td>
                                          </tr>
                                    </table>
                                    
                                    <div style="text-align: center;">            
                                       <a href="https://support.netway.co.th/hc/th/requests/new?ticket_form_id=114093963072&request_subject=ขอใบเสนอนราคา Office 365 Enterprise E3 &request_custom_fields_114095596292=sales_opt_other" target="_blank">
                                            <button class="btn-buy button-plan-40px " style="margin-bottom: 40px;  padding: 15px 5px;" type="button">
                                                                          ขอใบเสนอราคา  <i class="fa fa-chevron-right" aria-hidden="true"></i>
                                            </button>
                                        </a>
                                    </div>
				                    
				                      
				                    </div>
			                    </div>
                             </div>
                              
                           
                              
                            </div>
                    <div class="swiper-pagination" style="top: 1%;height: 20px;"></div>
                        <!-- Add Arrows -->
                        <div class="swiper-button-next" style="top: 2%;"></div>
                        <div class="swiper-button-prev" style="top: 2%;"></div>
                                    
      
                    </div>
  
     
{literal}<script src="https://idangero.us/swiper/dist/js/swiper.min.js"></script>{/literal}
 