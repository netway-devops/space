{php}
$templatePath   = $this->get_template_vars('template_path');
include($templatePath . 'kb.tpl.php');
{/php}
{literal}

<link rel="stylesheet" href="https://netway.services/js/aos-master/dist/aos.css">
  <script src="https://netway.services/js/aos-master/dist/aos.js"></script>
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
    <style>
    

      section.hero {
                /*background-color: orange;*/
               
                background-position: top center;
                background-repeat: no-repeat;
                text-align: center;
                width: 100%;
                background:url('https://netway.co.th/templates/netwaybysidepad/images/bg-Unified-Server-Management-Platform-min.png');
                background-repeat: no-repeat;
                background-size: cover;
                background-attachment: fixed;
                background-position: top;
                
    
            } 
            @media only screen and (max-width: 600px) {
               section.hero {
              
              
                background-repeat: no-repeat;
                text-align: center;
                width: 100%;
                background:url('https://netway.co.th/templates/netwaybysidepad/images/bg-Unified-Server-Management-Platform-min.png');
                background-repeat: no-repeat;        
                background-position: top;
                
    
                  } 
            }
        
           .Features {
               
               
                width: 100%;
                background: url('https://netway.co.th/templates/netwaybysidepad/images/bg-Managed-Server-Services-Features-f-min.png');
                background-repeat: no-repeat;
                background-size: cover;
                background-position: center;
                background-attachment: fixed;
                margin-bottom: 20px;
                
    
            }   
        .re-topic{
            color: #0052cd; 
            font-weight: 300; 
            font-family: 'Prompt', sans-serif;
        }
        
        .re-txt-banner {
            font-size: 40px; 
            font-style: normal;
            font-weight: 700;
            color: #fff;
            margin-top: 10px;
            text-shadow: 4px 4px 4px #213a55;
            text-align:left;
            line-height: normal;

        }
        .re-txt-sub{
                color: #FFF;
			    padding: 20px;
			    font-weight: 300;
			    margin-top: -28px;
			    font-size: 32px;
			   
        }
.img-icon {
    background-size : 100px 100px;
    height: 120px;
    width:  120px;
    margin-top: -17px;

} 
hr.icon {
    background: #bbb;
    text-align: center;
    width: 20%;
    display: block;
    margin: 15px 0% 15px 0%;
}  

.icon-1  {
    background-image : url('https://netway.co.th/templates/netwaybysidepad/images/icon-unified-server-1-min.png');
}
.icon-2  {
    background-image : url('https://netway.co.th/templates/netwaybysidepad/images/icon-unified-server-2-min.png');
}

.icon-3  {
    background-image : url('https://netway.co.th/templates/netwaybysidepad/images/icon-unified-server-3-min.png');
}
.icon-4  {
    background-image : url('https://netway.co.th/templates/netwaybysidepad/images/icon-unified-server-4-min.png');
}


.icon-5  {
    background-image : url('https://netway.co.th/templates/netwaybysidepad/images/icon-unified-server-5-min.png');
}
.icon-6  {
    background-image : url('https://netway.co.th/templates/netwaybysidepad/images/icon-unified-server-6-min.png');
}


.icon-7  {
    background-image : url('https://netway.co.th/templates/netwaybysidepad/images/icon-unified-server-7-min.png');
}


.txt-Features{
     color :#FFF;
     line-height: normal;
     
}
.txt-Features:hover{
     color :#FFAB00;
}
.icon-1 > .txt-Features:hover{
     color :#FFAB00;
}
.ff {
     margin-top: -10px;  
     margin-bottom: 50px;  
     line-height: 30px; 
     font-size: 24px; 
     text-align: center; 
     color: #FFF;     
     /*background-color: rgba(0, 0, 0, 0.5);
     width: 74%;*/

}
table {

  border-spacing: 0;
    width: 100%;
    margin-bottom: 16px;
    border: 1px solid #e5e8ed;
    border-radius: 5px;
    box-shadow: none;
    table-layout: unset;
    margin-left: 0;
}

.fa-check {
    color: rgba(3, 27, 78, 0.7);

}
ul.m-features {
    text-align: left;
    font-size: 20px;
    color: #fff;
}
ul.m-features > li {
    line-height: 32px;
   }
.table th, .table td {
    vertical-align: middle;
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

    <section class="section hero hidden-phone" style="height: 600px; text-align: center;">
        <div class="container"  >
            <div class="row" >
        
                   <div class="hero-inner">
                      <div style="margin-top: 100px;">                     
                        <h2 class="re-txt-banner">Unified Server Management Platform <br/> for Incident, Configuration Management and Report.  
                      
                        </h2>
                        <span class="nw-2018-content-line" style="margin-bottom: 20px;  margin-top: -10px;  margin-left: 20px;  width: 20%; "></span>
                        <h3 class="re-txt-sub">Managed server faster, safer and easier.</h3>
                        <a href="https://netway.co.th/managed-server-services#PlanAndPricing"><button class="btn-check" type="submit" style=" margin-left: 20px; margin-top: 1px;">อ่านเพิ่มเติม</button></a> 

                      </div>  
                  </div>
            </div>
  
        </div>
    </section>
    
        <section class="section hero visible-phone" style="height: 350px; text-align: center;">
        <div class="container"  >
            <div class="row" >
        
                   <div class="hero-inner">
                      <div style="margin-top: 60px;">                     
                        <h2 class="re-txt-banner" style="font-size: 20px;">Unified Server Management Platform <br/> for Incident, Configuration Management and Report.  
                      
                        </h2>
                        <span class="nw-2018-content-line" style="margin-bottom: 20px;  margin-top: -10px;  margin-left: 20px;  width: 20%; "></span>
                        <h3 class="re-txt-sub" style="font-size:18px;">Managed server faster, safer and easier.</h3>
                        <a href="https://netway.co.th/managed-server-services#PlanAndPricing"><button class="btn-check" type="submit" style=" margin-left: 20px; margin-top: 1px;">อ่านเพิ่มเติม</button></a> 

                      </div>  
                  </div>
            </div>
  
        </div>
    </section>
  

  <div class="row-fluid"  style="background-color: #fff;"> 
      <div class="container"style="margin-top: 50px;" >         
            <div class="row">
               <div class="span12 dynamic-content">
                 <center>
                        <h3 class="h3-title-content g-txt32 re-topic" >   Unified Server Management Platform </h3>
                        <span class="nw-2018-content-line" style="margin-bottom: 50px;"></span>
                        
                 </center>          
                </div>
            </div>
       </div>
       <div class="container"> 
            <div class="row ">
                <div class="span12 dynamic-content" style="margin-bottom: 30px;"  >
              
                         
                             
                        <p class="hr-pro hr-pro-bottom gs-txt gs-content hidden-phone " style="margin-top: -10px;  margin-bottom: 50px;  line-height: 30px; font-size: 24px; text-align: center;">
                            ระบบบริหารจัดการเซิร์ฟเวอร์ที่เข้มแข็ง และปลอดภัยโดย Netway Communication ให้ระบบเซิร์ฟเวอร์ของคุณทำงานได้เต็มประสิทธิภาพ ไม่สะดุด ในราคาที่คุ้มสุด ๆ
     
                        </p>
                         <p class="hr-pro hr-pro-bottom gs-txt16 gs-content visible-phone" 
                         style="    line-height: normal;    font-size: 18px;    text-align: center;    padding: 10px 10px 10px 10px;">
                            ระบบบริหารจัดการเซิร์ฟเวอร์ที่เข้มแข็ง และปลอดภัยโดย Netway Communication ให้ระบบเซิร์ฟเวอร์ของคุณทำงานได้เต็มประสิทธิภาพ ไม่สะดุด ในราคาที่คุ้มสุด ๆ
     
                        </p>
  
                </div>
                    
             </div>

  </div>
 </div>

<div class="row-fluid Features"  style="text-align: center;" > 
       <div class="container"style="margin-top: 100px; margin-bottom: 100px;" >
            <div class="row">
                 <div class="span12">
                      <center>
                          <h3 class="h3-title-content g-txt34 re-topic" style="color: #FFF;" >Features </h3>
                            <span class="nw-2018-content-line" style="margin-bottom: 50px;"></span>
                          <p class="hr-pro hr-pro-bottom  gs-content ff" style="padding: 0px 10px 0px 10px;"> 
                            Platform classify event notifications to reduce noise and detect anomalies. And integrated configuration management, remote access and report system.  
                          </p>
                      </center>
                 </div>
            </div>

            <div class="row" style="margin-bottom:30px;" >
                 <div class="span2" >
                     <div class="icon-1 img-icon" style="margin-left:10px"></div>
                 </div>
                  <div class="span4" style="text-align: left; padding: 20px 20px 20px 20px;">
           
                            <p class="g-txt24 txt-Features" >Monitoring</p>
							<hr class="icon" />
							<ul class="m-features">
							<li>Server health monitoring</li>
							<li>Network performance monitoring</li>
							<li>Application performance monitoring</li>
							<li>Back-up monitoring</li>
                           </ul>
                    
                 </div>
                <div class="span2" >
                     <div class="icon-4 img-icon" style="margin-left:10px"></div>
                 </div>
                  <div class="span4" style="text-align: left; padding: 20px 0px 20px 20px;" >          
                            <p class="g-txt24 txt-Features" >Server configuration automation</p>
                            <hr class="icon" />
                            <ul class="m-features">
                            <li>Configuration profile</li>
                            <li>Scripting</li>
                            <li>Configuration release management</li>
                            
                           </ul>

                 
                 </div>
            </div>
           
           
            <div class="row" style="margin-bottom:30px;" >
                 <div class="span2" >
                     <div class="icon-3 img-icon" style="margin-left:10px"></div>
                 </div>
                  <div class="span4" style="text-align: left; padding: 20px 20px 20px 20px;">
           
                            <p class="g-txt24 txt-Features" >ITIL ticket service management</p>
                            <hr class="icon" />
                            <ul class="m-features">
                            <li>Event, Incident, Problem, Change</li>
                            <li>Up to 99% reduction on noise event notification</li>
                            <li>Realtime Incident feed</li>
                            <li>Zendesk integration*</li>
                           </ul>
                    
                 </div>
                <div class="span2" >
                     <div class="icon-5 img-icon" style="margin-left:10px"></div>
                 </div>
                  <div class="span4" style="text-align: left; padding: 20px 20px 20px 20px;" >          
                            <p class="g-txt24 txt-Features" >Security management</p>
                            <hr class="icon" />
                            <ul class="m-features">
                            <li>Patch management</li>
                            <li>RBL monitoring</li>
                            <li>Security scanner*</li>
                            
                           </ul>

                 
                 </div>
            </div>
            
               <div class="row" style="margin-bottom:30px;" >
                 <div class="span2" >
                     <div class="icon-2 img-icon" style="margin-left:10px"></div>
                 </div>
                  <div class="span4" style="text-align: left; padding: 20px 20px 20px 20px;">
           
                            <p class="g-txt24 txt-Features" >Integration</p>
                            <hr class="icon" />
                            <ul class="m-features">
                            <li>Extendable connectors</li>
                            <li>Up to 99% reduction on noise event notification</li>
                            <li>Email to ticket</li>
                            <li>API</li>
                           </ul>
                    
                 </div>
                <div class="span2" >
                     <div class="icon-6 img-icon" style="margin-left:10px"></div>
                 </div>
                  <div class="span4" style="text-align: left; padding: 20px 20px 20px 20px;" >          
                            <p class="g-txt24 txt-Features" >Report</p>
                            <hr class="icon" />
                            <ul class="m-features">
                            <li>Server report</li>
                            <li>Agent report</li>
                            
                           </ul>

                 
                 </div>
            </div>
                   
                   
                   
                     <div class="row" style="margin-bottom:30px;" >
                 <div class="span2" >
                     <div class="icon-7 img-icon" style="margin-left:10px"></div>
                 </div>
                  <div class="span4" style="text-align: left; padding: 20px 20px 20px 20px;">
           
                            <p class="g-txt24 txt-Features" >Customer management</p>
                            <hr class="icon" />
                            <ul class="m-features">
                            <li>Customer portal*</li>
                            <li>SLA management</li>

                           </ul>
                    
                 </div>
                <div class="span2" >
                   
                 </div>
                  <div class="span4" style="text-align: left;" >          
                   

                 
                 </div>
            </div>
          <div>
       </div>
    </div>
</div>
  
   <div class="row-fluid"  style="background-color: #fff;" id="PlanAndPricing"> 
      <div class="container"style="margin-top: 50px;" >         
            <div class="row">
               <div class="span12 dynamic-content">
                 <center>
                        <h3 class="h3-title-content g-txt34 re-topic" >Plan & Pricing </h3>
                        <span class="nw-2018-content-line" style="margin-bottom: 50px;"></span>
                        
                 </center>          
                </div>
            </div>
       </div>
       <div class="container"> 
            <div class="row ">
                <div class="span12 dynamic-content" style="margin-bottom: 30px;"  >
              
                         
                             
                        <p class="hr-pro hr-pro-bottom gs-txt gs-content " style="margin-top: -10px;  margin-bottom: 20px;  line-height: 30px; font-size: 22px; text-align: center;">
                          Unified Server Management Platform เหมาะสำหรับ องค์กร หรือ ผู้ให้บริการ MSP ที่ดูแล Server มากกว่า 10 ตัว ขึ้นไป <br/> กรณีที่มี server ในความดูแล  1- 2 ตัว แนะนำให้ใช้บริการ <a herf="https://netway.co.th/managed-server-services" style="color: #395481;">Managed Server Services </a>
     
                        </p>
              </div>
           </div>
       <div class="row ">
             
             <div class="span6" ><!-- Office 365 Home Plan 3 -->
             <div class="plan-gs" style="height: 300px; text-align: center;">
                 <p class="hr-pro hr-pro-bottom gs-txt gs-content " style="margin-top: 10px;  margin-bottom: 50px;  line-height: 30px; font-size: 32px; text-align: center;   color: #ff5725;">
                 $100 + $2 / server * + $30 /agent
                 </p>
              
                <p class="txt-price-small" style="font-size: 22px;   line-height: normal;">Monthly pricing  <br/>* 10 servers are minimum purchase</p>

                <hr style="border-top: 2px solid #cccccc;"/>
                <center>
                 <a href="https://support.netway.co.th/hc/th/requests/new?ticket_form_id=114093963072&request_subject=Order-Unified Server Management Platform&request_custom_fields_114095596292=sales_opt_other" ><button class="btn-check" type="submit"  style="margin-top:15px;">สนใจสั่งซื้อ</button></a> 
                </center>
                
  
           </div>
       </div>
       <div class="span6">
 
                        <p class="g-txt24" style="font-weight: 400;     background: #f5f5f5;   padding: 20px 10px 20px;     border: 1px solid #e5e8ed; color: #031b4e;">Add-on Services</p>
                 
     <table class="table table-hover table-striped  hidden-phone " style="color:#555555; width: 100%; font-size: 19px; height: 334px;">

  <tbody>
    <tr>
      <td style=" width: 255px;"><i class="fa fa-check" aria-hidden="true"></i>&nbsp;&nbsp;   Managed server services </td>
      <td>$49 / server (฿1,500)</td>
    </tr>
    <tr>
      <td><i class="fa fa-check" aria-hidden="true"></i>&nbsp;&nbsp;   KernelCare License </td>
      <td>100 บาท/ เดือน</td>
    </tr>
     <tr>
      <td><i class="fa fa-check" aria-hidden="true"></i>&nbsp;&nbsp;  cPanel & WHM License </td>
      <td style="line-height: normal;">700 บาท/ เดือน(VPS),<br/> 1,400 บาท/ เดือน(DED)</td>
    </tr>
    <tr>
      <td><i class="fa fa-check" aria-hidden="true"></i>&nbsp;&nbsp;  Antivirus </td>
      <td>เริ่มต้นที่ 600 บาท</td>
    </tr>
    <tr>
      <td><i class="fa fa-check" aria-hidden="true"></i>&nbsp;&nbsp;   Billable technical support </td>
      <td>$35 / hour</td>
    </tr>

  </tbody>
</table>

  <table class="table table-hover table-striped  visible-phone" style="color:#555555; width: 100%; font-size: 13px;">

  <tbody>
    <tr>
      <td style=" width: 50%;"><i class="fa fa-check" aria-hidden="true"></i>&nbsp;&nbsp;   Managed server services </td>
      <td>$49 / server (฿1,500)</td>
    </tr>
    <tr>
      <td><i class="fa fa-check" aria-hidden="true"></i>&nbsp;&nbsp;   KernelCare License </td>
      <td>100 บาท/ เดือน</td>
    </tr>
     <tr>
      <td><i class="fa fa-check" aria-hidden="true"></i>&nbsp;&nbsp;  cPanel & WHM License </td>
      <td style="line-height: normal;">700 บาท/ เดือน(VPS),<br/> 1,400 บาท/ เดือน(DED)</td>
    </tr>
    <tr>
      <td><i class="fa fa-check" aria-hidden="true"></i>&nbsp;&nbsp;  Antivirus </td>
      <td>เริ่มต้นที่ 600 บาท</td>
    </tr>
    <tr>
      <td><i class="fa fa-check" aria-hidden="true"></i>&nbsp;&nbsp;   Billable technical support </td>
      <td>$35 / hour</td>
    </tr>

  </tbody>
</table>

 <center>
                 <a href="https://support.netway.co.th/hc/th/requests/new?ticket_form_id=114093963072&request_subject=Order-Unified Server Management Platform&request_custom_fields_114095596292=sales_opt_other" ><button class="btn-check visible-phone" type="submit"  style="margin-top:15px;">สนใจสั่งซื้อ</button></a> 
                </center>
       </div>
               
               
               
       </div>    


  </div>
 </div>
