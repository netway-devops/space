{php}
$templatePath   = $this->get_template_vars('template_path');
include($templatePath . 'kb.tpl.php');
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
                /*background-color: orange;*/
               
                background-position: top center;
                background-repeat: no-repeat;
                text-align: center;
                width: 100%;
                background:url('https://netway.co.th/templates/netwaybysidepad/images/bg-Managed-Server-Services-min.png');
                background-repeat: no-repeat;
                background-size: cover;
                /*background-attachment: fixed;*/
                background-position: top;
                
    
            } 
           .Features {
               
               
                width: 100%;
                background: url('https://netway.co.th/templates/netwaybysidepad/images/bg-Managed-Server-Services-Features-min.png');
                background-repeat: no-repeat;
                background-size: cover;
                background-attachment: fixed;
                background-position: center;
                margin-bottom: 20px;
                
    
            }   
        .re-topic{
            color: #0052cd; 
            font-weight: 300; 
            font-family: 'Prompt', sans-serif;
        }
        
        .re-txt-banner {
            font-size: 45px;
            font-family: 'Prompt', sans-serif; 
            font-style: normal;
            font-weight: 700;
            color: #fff;
            margin-top: 10px;
            text-shadow: 2px 2px 4px #212127;

        }
.img-icon {
    background-size : 60px 60px;
    height: 100px;
    width:  100px;
    margin-bottom: -20px;

}   

.icon-1  {
    background-image : url('https://netway.co.th/templates/netwaybysidepad/images/managed-server-services-icon-1-min.png');
}
.icon-2  {
    background-image : url('https://netway.co.th/templates/netwaybysidepad/images/managed-server-services-icon-2-min.png');
}

.icon-3  {
    background-image : url('https://netway.co.th/templates/netwaybysidepad/images/managed-server-services-icon-3-min.png');
}
.icon-4  {
    background-image : url('https://netway.co.th/templates/netwaybysidepad/images/managed-server-services-icon-4-min.png');
}


.icon-5  {
    background-image : url('https://netway.co.th/templates/netwaybysidepad/images/managed-server-services-icon-5-min.png');
}
.icon-6  {
    background-image : url('https://netway.co.th/templates/netwaybysidepad/images/managed-server-services-icon-6-min.png');
}


.icon-7  {
    background-image : url('https://netway.co.th/templates/netwaybysidepad/images/managed-server-services-icon-7-min.png');
}
.icon-8  {
    background-image : url('https://netway.co.th/templates/netwaybysidepad/images/managed-server-services-icon-8-min.png');
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
     font-size: 20px; 
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
    
    <section class="section hero  hidden-phone" style="height: 500px;">
        <div class="container"  data-aos="zoom-in">
            <div class="row" >
        
                   <div class="hero-inner">
                      <div style="margin-top: 130px;">                     
                        <h2 class="re-txt-banner">สนใจ ดูแล Server  1,500 บ./ เดือน
  </h2> 
                      
                          
                        <a href="#PlanAndPricing"><button class="btn-check" type="submit" data-aos="flip-up">อ่านเพิ่มเติม</button></a> 

                      </div>  
                </div>
            </div>
  
        </div>
    </section>
    
        <section class="section hero visible-phone" style="height: 325px;">
        <div class="container"  data-aos="zoom-in">
            <div class="row" >
        
                   <div class="hero-inner">
                      <div style="margin-top: 130px;">                     
                        <h2 class="re-txt-banner" style="font-size: 30px;">สนใจ ดูแล Server  1,500 บ./ เดือน
  </h2> 
                      
                          
                        <a href="#"><button class="btn-check" type="submit" >อ่านเพิ่มเติม</button></a> 

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
                        <h3 class="h3-title-content g-txt32 re-topic" >Managed Server Services </h3>
                        <span class="nw-2018-content-line" style="margin-bottom: 50px;"></span>
                        
                 </center>          
                </div>
            </div>
       </div>
       <div class="container"> 
            <div class="row ">
                <div class="span12 dynamic-content" style="margin-bottom: 30px;"  >
              
                         
                             
                        <p class="hr-pro hr-pro-bottom gs-txt gs-content hidden-phone " style="margin-top: -10px;  margin-bottom: 50px;  line-height: 30px; font-size: 20px; text-align: center;">
                             ระบบบริหารจัดการเซิร์ฟเวอร์ที่เข้มแข็ง และปลอดภัยโดย Netway Communication ให้ระบบเซิร์ฟเวอร์ของคุณทำงานได้เต็มประสิทธิภาพ ไม่สะดุด ในราคาที่คุ้มสุด ๆ
     
                        </p>
                         <p class="hr-pro hr-pro-bottom gs-txt16 gs-content visible-phone" 
                         style="    line-height: normal;    font-size: 17px;    text-align: center;    padding: 10px 10px 10px 10px;">
                             ระบบบริหารจัดการเซิร์ฟเวอร์ที่เข้มแข็ง และปลอดภัยโดย <br/> Netway Communication <br/> ให้ระบบเซิร์ฟเวอร์ของคุณทำงานได้เต็มประสิทธิภาพ ไม่สะดุด ในราคาที่คุ้มสุด ๆ
     
                        </p>
  
                </div>
                    
             </div>

  </div>
 </div>

<div class="row-fluid Features"  style="text-align: center;" > 
       <div class="container"style="margin-top: 50px;" >
            <div class="row">
                 <div class="span12">
                      <center>
	                      <h3 class="h3-title-content g-txt32 re-topic" style="color: #FFF;" >Features </h3>
	                        <span class="nw-2018-content-line" style="margin-bottom: 50px;"></span>
	                      <p class="hr-pro hr-pro-bottom  gs-content ff" > 
	                        จัดการธุรกิจไอทีของคุณได้อย่างมีประสิทธิภาพด้วยบริการ Managed Server Service ที่ทรงประสิทธิภาพ  
	                      </p>
                      </center>
                 </div>
            </div>
          
            <div class="row" style="margin-bottom:20px;" >
                 <div class="span3" style="text-align:center;">
                     <div class="icon-1 img-icon" style="margin-left:10px"></div>
                     <center><hr style=" size: 2px;  width: 10%;"></center>
                     <p class="g-txt20 txt-Features" >24x7x365 Phone,<br><small>Email Ticket System </small></p>
                 </div>
                  <div class="span3" style="text-align:center;">
                     <div class="icon-2 img-icon" style="margin-left:10px"></div>
                     <center><hr style=" size: 2px;  width: 10%;"></center>
                     <p class="g-txt20 txt-Features" >15 Minute Initial <br><small>Response Time Guarantee </small></p>
                 </div>
                  <div class="span3" style="text-align:center;">
                     <div class="icon-3 img-icon" style="margin-left:10px"></div>
                     <center><hr style=" size: 2px;  width: 10%;"></center>
                     <p class="g-txt20 txt-Features" >Server Hardening<br><small>&nbsp;&nbsp; </small></p>
                 </div>
                  <div class="span3" style="text-align:center;">
                     <div class="icon-4 img-icon" style="margin-left:10px"></div>
                     <center><hr style=" size: 2px;  width: 11%;"></center>
                     <p class="g-txt20 txt-Features" >System Level Health Monitoring ,<br><small>Graphing and Alert   </small></p>
                 </div>
            </div>
            <div class="row" style="margin-bottom: 70px;" >
                 <div class="span3" style="text-align:center;">
                     <div class="icon-5 img-icon" style="margin-left:10px"></div>
                     <center><hr style=" size: 2px;  width: 10%;"></center>
                     <p class="g-txt20 txt-Features" >System tweaks<br><small>for Performance Tuning and Optimization   </small></p>
                 </div>
                  <div class="span3" style="text-align:center;">
                     <div class="icon-6 img-icon" style="margin-left:10px"></div>
                     <center><hr style=" size: 2px;  width: 10%;"></center>
                     <p class="g-txt20 txt-Features" >Proactively monitoring  <br><small>&nbsp;&nbsp; </small></p>
                 </div>
                  <div class="span3" style="text-align:center;">
                     <div class="icon-7 img-icon" style="margin-left:10px"></div>
                     <center><hr style=" size: 2px;  width: 10%;"></center>
                     <p class="g-txt20 txt-Features" >Patch management    <br><small>&nbsp;&nbsp; </small></p>
                 </div>
                  <div class="span3" style="text-align:center;">
                     <div class="icon-8 img-icon" style="margin-left:10px"></div>
                     <center><hr style=" size: 2px;  width: 10%;"></center>
                     <p class="g-txt20 txt-Features" >Report <br><small>&nbsp;&nbsp; </small></p>
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
                        <h3 class="h3-title-content g-txt32 re-topic" >Plan & Pricing </h3>
                        <span class="nw-2018-content-line" style="margin-bottom: 50px;"></span>
                        
                 </center>          
                </div>
            </div>
       </div>
       <div class="container"> 
            <div class="row ">
                <div class="span12 dynamic-content" style="margin-bottom: 30px;"  >
              
                         
                             
                        <p class="hr-pro hr-pro-bottom gs-txt gs-content " style="margin-top: -10px;  margin-bottom: 20px;  line-height: 30px; font-size: 28px; text-align: center;">
                          บริการ Managed Server Services เราให้บริการ
     
                        </p>
                        <p class="hr-pro hr-pro-bottom gs-txt gs-content " style="margin-top: 10px;  margin-bottom: 50px;  line-height: 30px; font-size: 32px; text-align: center;   color: #ff5725;">
                         ราคาเพียง <b>1,500</b> บาทต่อเดือน
                        </p>
                        
                        <center>
  <a href="https://support.netway.co.th/hc/th/requests/new?ticket_form_id=114093963072&request_subject=สนใจดูแล Server 1,500บ./เดือน/Product Managed Server Service&request_custom_fields_114095596292=sales_opt_other" ><button class="btn-check" type="submit"  style="margin-top:-15px;">สนใจสั่งซื้อ</button></a> 
</center>
     
                        <p class="hr-pro hr-pro-bottom gs-txt gs-content " style="margin-top: -10px;  margin-bottom: 50px;  line-height: 30px; font-size: 20px; text-align: center;">
                        เราให้บริการ Managed Server Services ทั้งเครื่องที่อยู่ใน Netway Data Center และภายนอก อาจจะเป็นเครื่องที่อยู่ที่องค์กรของลูกค้าเอง สำหรับเครื่องที่อยู่ภายนอกนั้นผู้ใช้บริการจะต้องดำเนินการให้เจ้าหน้าที่ของเราสามารถ Remote Access เข้าไปบริหารจัดการเครื่องได้ และราคาดังกล่าวนี้ไม่รวมถึงการ On-site Services</p>
                        <center><hr style="width:20%; margin-top: -20px;"></center>
                        <p class="g-txt24" style="font-weight: 400;     background: #f5f5f5;   padding: 20px 10px 20px;     border: 1px solid #e5e8ed; color: #031b4e;">Add-on Services</p>
                 
                       <table class="table table-hover table-striped hidden-phone" style="color:#555555; width: 100%; font-size: 19px;">

  <tbody>
    <tr>
      <td><i class="fa fa-check" aria-hidden="true"></i>&nbsp;&nbsp;   Backup Storage </td>
      <td>100GB/ 700 บาท</td>
    </tr>
    <tr>
      <td><i class="fa fa-check" aria-hidden="true"></i>&nbsp;&nbsp;   Billable technical support*  </td>
      <td>1,000 บาท/ ชั่วโมง</td>
    </tr>
     <tr>
      <td><i class="fa fa-check" aria-hidden="true"></i>&nbsp;&nbsp;   KernelCare License </td>
      <td>100 บาท/ เดือน</td>
    </tr>
    <tr>
      <td><i class="fa fa-check" aria-hidden="true"></i>&nbsp;&nbsp;   cPanel & WHM License </td>
      <td>700 บาท/ เดือน(VPS) , 1,400 บาท/ เดือน(DED)</td>
    </tr>
    <tr>
      <td><i class="fa fa-check" aria-hidden="true"></i>&nbsp;&nbsp;   DirectAdmin License </td>
      <td>1,200 บาท/ เดือน</td>
    </tr>
    <tr>
      <td><i class="fa fa-check" aria-hidden="true"></i>&nbsp;&nbsp;   Antivirus  </td>
      <td>เริ่มต้นที่ 600 บาท</td>
    </tr>
  </tbody>
</table>


   <table class="table table-hover  table-striped  visible-phone" style="color: #031b4e; width: 100%;">

  <tbody>
    <tr>
      <td><i class="fa fa-check" aria-hidden="true"></i></td>
      <td>&nbsp;&nbsp;   Backup Storage </td>
      <td>100GB/ 700 บาท</td>
    </tr>
    <tr>
      <td><i class="fa fa-check" aria-hidden="true"></i></td>
      <td>Billable technical support*  </td>
      <td>1,000 บาท/ ชั่วโมง</td>
    </tr>
     <tr>
      <td><i class="fa fa-check" aria-hidden="true"></i></td>
      <td>   KernelCare License </td>
      <td>100 บาท/ เดือน</td>
    </tr>
    <tr>
      <td><i class="fa fa-check" aria-hidden="true"></i></td>
      <td>  cPanel & WHM License </td>
      <td>700 บาท/ เดือน(VPS) , 1,400 บาท/ เดือน(DED)</td>
    </tr>
    <tr>
      <td><i class="fa fa-check" aria-hidden="true"></i></td>
      <td>   DirectAdmin License </td>
      <td>1,200 บาท/ เดือน</td>
    </tr>
    <tr>
      <td><i class="fa fa-check" aria-hidden="true"></i></td>
      <td>   Antivirus  </td>
      <td>เริ่มต้นที่ 600 บาท</td>
    </tr>
  </tbody>
</table>
<br/>

                </div>
                    
             </div>

  </div>
 </div>
