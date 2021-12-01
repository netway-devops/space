<script src="{$template_dir}js/tabs.js"  type="text/javascript"></script>   
<!-- ******************** Start AddThis ******************** -->
<div class="pathway-inpage">
    {include file='addthis.tpl'}
</div>
<!-- ******************** End AddThis ******************** -->
{literal}
    <style>
       .bg {
       
                background-repeat: no-repeat;
                background-size: cover;
                background-position: top;
                background-attachment: fixed;
                text-align: center;
                height: 360px;
                width: 100%;
            }    
       .bg-back {
            background: rgba(0, 24, 192, 0.5);
            height: 360px;
        }
        .re-txt-banner {
            font-size: 28px;
            font-family: 'Prompt', sans-serif; 
            font-style: normal;
            line-height: 40px;
            font-weight: 500;
            color: #fff;

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
            $(this).html('<img class="lazy" data-src="https://netway.co.th/templates/netwaybysidepad/images/icon-Ohter-Products-KB-hover.png">');
         });  
    
        $('#custom-search-form').submit(function(event){
           event.preventDefault();
           var stringSearch =   $('.search-query').val();
           window.open("https://support.netway.co.th/hc/th/search?utf8=%E2%9C%93&query="+stringSearch,'_self');
        });
        
         $('.faq-a').after('<hr class="hr-faq"/>');
    $(".btn-pref .btn").click(function () {
        $(".btn-pref .btn").removeClass("btn-primary").addClass("btn-default");
        // $(".tab").addClass("active"); // instead of this do the below 
        $(this).removeClass("btn-default").addClass("btn-primary");   
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

 
<div class="bg hidden-phone lazy-hero" data-src="/templates/netwaybysidepad/images/resellerTry.png">
  <div class="bg-back">   
        <div class="container" >
            <div class="row hidden-phone" >
        
                   <div class="hero-inner" style="padding: 80px 0 50px 0;">
                        <h2 class="re-txt-banner" style="font-size: 38px;">ร่วมเป็น Netway Reseller วันนี้ </h2>
                        <h2 class="re-txt-banner">เพื่อรับสิทธิพิเศษทั้งด้านราคา คำปรึกษา และสิทธิพิเศษอื่น ๆ มากมาย</h2>          
                         <a href="https://docs.google.com/a/netwaygroup.com/forms/d/e/1FAIpQLSfkiDjNMTUR3NOcI98cDTLhm-DBYP_EyxHkAxdqRGjfpIQ7vg/viewform">
                           <button class="btn-banner-cloud" type="submit"><i class="fa fa-edit"></i>&nbsp;สมัครเป็น Resellerกับเราวันนี้</button>
                         </a>                        

                </div>
            </div>
             <div class="row visible-phone" >
        
                   <div class="hero-inner">
                        <h2 class="re-txt-banner" style="margin-top: 70px;letter-spacing: 1px; font-size: 23px;text-align: left;line-height: 30px;"> 
                            ร่วมเป็น Netway Reseller วันนี้ เพื่อรับสิทธิพิเศษทั้งด้านราคา คำปรึกษา และสิทธิพิเศษอื่น ๆ มากมาย</h2>          
                         <a href="https://docs.google.com/a/netwaygroup.com/forms/d/e/1FAIpQLSfkiDjNMTUR3NOcI98cDTLhm-DBYP_EyxHkAxdqRGjfpIQ7vg/viewform">
                           <button class="btn-banner-cloud" type="submit"><i class="fa fa-edit"></i>&nbsp;สมัครเป็น Resellerกับเราวันนี้</button>
                         </a>                        

                </div>
            </div>
        </div>
  </div>
</div>
 <section id="customTab" style="margin-top: 0px;   background-color:#4489FF;">
        <div class="dynamic-menu hidden-phone  container " style="background-color: #4489FF;width: 100%;">
           <div class="container">
            <ul class="dynamic-nav ">
                
                <li class="dynamic-nav"><a class="dynamic-nav " href="#special" >สิทธิพิเศษ</a></li>
                <li class="dynamic-nav"><a class="dynamic-nav " href="#whyNetway">ทำไมต้อง Netway</a></li>
                <li class="dynamic-nav"><a class="dynamic-nav " href="#register">ขั้นตอนการสมัคร</a></li>     
                <li class="dynamic-nav"><a class="dynamic-nav " href="#"></a></li>
            </ul>
            </div>
        </div>
<div class="row-fluid">
    
      <div class="span12 dynamic-content bg-gs-wn" id="hide"  style="background: #C9D6FF;  /* fallback for old browsers */
background: -webkit-linear-gradient(to right, #E2E2E2, #C9D6FF);  /* Chrome 10-25, Safari 5.1-6 */
background: linear-gradient(to right, #E2E2E2, #C9D6FF); /* W3C, IE 10+/ Edge, Firefox 16+, Chrome 26+, Opera 12+, Safari 7+ */
">
           <div class="container">
                <div class="row">
                  <div class="span12">  
                    <div style="text-align: center;">
                     <h3 class="nw-slogan1" style="
    font-size: 30px;
    color: #000;
" >"ขายง่าย&nbsp;&nbsp;มีตัวช่วย&nbsp;&nbsp;พร้อมให้คำปรึกษา&nbsp;24&nbsp;ชั่วโมง"</h3> 
                    </div>
                  </div>     
                </div>
            </div>
        </div> 
</div>
</section>


  <div class="row-fluid  " id="special"> 
      <div class="container"style="margin-top: 60px;" >         
            <div class="row">
               <div class="span12 dynamic-content"   >
             <center><h3 class="h3-title-content g-txt32 re-topic" >สิ่งที่ Netway Reseller จะได้รับ</h3>
             <span class="nw-2018-content-line" style="margin-bottom: 30px;"></span></center>          
               </div>
            </div>
            </div>
             <div class="container"> 
            <div class="row " style="padding: 20px 0px 0px 20px; margin-top: 10px;">
                <div class="span12 dynamic-content"   >
                   <div class="span7"  style="margin-top: 67px;margin-left: 0px;"> 
                        <p class="font-special-txt g-txt22"><b>เพิ่มความสามารถในการแข่งขันให้กับธุรกิจของคุณเอง</b><br>ด้วยการเข้าถึงผลิตภัณฑ์เทคโนโลยีต่าง ๆ แบบครบวงจร</p>
                    </div>
                    <div class="span5 ">   
                        <img class="lazy" data-src="https://netway.co.th/templates/netwaybysidepad/images/img-reseller2018-1.png" alt="Netway Reseller 2" width="383" height="249">
                    </div>
                    
                </div>    
             </div>
             <hr/>
             <div class="row " style="padding: 20px 0px 0px 20px; margin-top: 10px;">
                <div class="span12 dynamic-content"   >
                    <div class="span5"> 
                       <img class="lazy" data-src="https://netway.co.th/templates/netwaybysidepad/images/img-reseller2018-2.png" alt="Netway Reseller 2" width="383" height="249">
                    </div>
                    <div class="span7 "style="margin-top: 67px;">   
                         <p class="font-special-txt g-txt22"><b>เพิ่มยอดขายของคุณด้วยผลิตภัณฑ์ที่มีจุดเด่นรวมถึงมีความต้องการในตลาดสูง</b></p>
                    </div>
                    
                </div>    
             </div>
             <hr/>
             <div class="row " style="padding: 20px 0px 0px 20px; margin-top: 10px;">
                <div class="span12 dynamic-content"   >
                   
                    <div class="span7"  style="margin-top: 67px;margin-left: 0px;"> 
                        <p class="font-special-txt g-txt22"><b>เชื่อมต่อกับกลุ่มลูกค้าได้อย่างง่ายดาย และเพิ่มอำนาจให้กับบริษัทของคุณ</b><br>ด้วยเครือข่ายพันธมิตรทางธุรกิจ</p>
                    </div>
                     <div class="span5 ">   
                        <img class="lazy" data-src="https://netway.co.th/templates/netwaybysidepad/images/img-reseller2018-3.png" alt="Netway Reseller 3" width="383" height="249">
                    </div>
                </div>    
             </div>
       </div>
  </div>

     <div class="row-fluid" id="whyNetway" style="background-color: #E8EAF6;"> 
        <div class="container"  style="margin-top: 70px;"> 
            <div class="row">
               <div class="span12 dynamic-content"   >
             <center><h3 class="h3-title-content g-txt32 re-topic">ทำไมต้องขายกับ Netway</h3>
             <span class="nw-2018-content-line" style="margin-bottom: 30px;"></span></center>          
               </div>
            </div>
          </div>
       <div class="container" style=" margin-bottom: 50px;">
           <div class="row" style="margin: 10px 10px 10px 10px;" >
            <div class="span6 div-whynetway">
                <center>
                    <div class="icon-20year"></div>
                    <p class="title-why-netway txt22">ประสบการณ์ที่ยาวนาน</p>
                    <hr class="hr-whynetway"> 
                </center>  
                <p class="nw-content g-txt16" style="margin-top: 20px;">
                ด้วยประสบการณ์ของการให้บริการทางด้านไอทีที่ยาวนานกว่า 20 ปี ทำให้ Netway Communication พัฒนาความเชี่ยวชาญในเชิงลึกเพื่อให้คุณได้รับบริการแบบครบวงจร
                </p>
               
            </div>
             <div class="span6 div-whynetway">
                <center>
                <div class="icon-onestopservice"></div>
                <p class="title-why-netway txt22">ผลิตภัณฑ์ที่ครบวงจรสำหรับทุกๆด้านของธุรกิจ</p>
                <hr class="hr-whynetway"> 
                </center>  
                <p class="nw-content g-txt16" style="margin-top:20px;  ">
                ด้วยวิสัยทัศน์อันก้าวไกล ทำให้ Netway Communication พัฒนาแพ็คเกจผลิตภัณฑ์ที่โดดเด่น ล้ำหน้าผู้ให้บริการอื่น ๆ เสมอ 
                การเป็นตัวแทนจำหน่ายจึงมอบความเป็นต่อในเชิงธุรกิจให้แก่คุณ
                </p>
            </div>
            
          </div>
         <div class="row" style="margin: 10px 10px 10px 10px;">
            <div class="span6 div-whynetway" >
                <center>
                    <div class="icon-safe"></div>
                    <p class="title-why-netway txt22">ระบบความปลอดภัยชั้นยอด</p>
                    <hr class="hr-whynetway"> 
                </center>  
                <p class="nw-content g-txt16" style="margin-top:20px;">
                ความมั่นคงของระบบความปลอดภัยคือหัวใจหลักของการบริการด้านข้อมูลให้แก่ลูกค้าทั่วประเทศ Netway Communication 
                จึงเน้นย้ำในระบบรักษาความปลอดภัยอย่างรัดกุม เพื่อสร้างความเชื่อมั่นและความไว้วางใจให้แก่ลูกค้าทั่วประเทศ  
                </p>     
            </div>
            <div class="span6 div-whynetway" >
                <center>
                    <div class="icon-goodpastner"></div>
                    <p class="title-why-netway txt22">เครือข่ายกับพันธมิตรธุรกิจจากทั่วโลก</p>
                    <hr class="hr-whynetway"> 
                </center>  
                <p class="nw-content g-txt16" style="margin-top:20px; margin-bottom: 35px;">
                จากความร่วมมือกับเจ้าของผลิตภัณฑ์ที่มีชื่อเสียงระดับโลก อย่างเช่น cPanel, Symantec, owncloud และ onapp ทำให้ Netway Communication 
                พัฒนาศักยภาพในการมอบบริการที่กว้างขวางและแพร่หลายมากขึ้น
                </p>
                
                </div>
            </div>
         </div>
    </div>     
          
          
    <div class="row-fluid resller-3step" id="register"> 
        <div class="container" style="margin-top: 60px;" > 
            <div class="row">
               <div class="span12 dynamic-content"   >
             <center><h3 class="h3-title-content g-txt32 re-topic" style="
    color:  #FFF;">3 ขั้นตอนง่าย ๆ ในการเป็น Reseller</h3>
             <span class="nw-2018-content-line" style="margin-bottom: 30px;"></span></center>          
               </div>
            </div>
          </div>
          <div class="container" >
             <div class="row" style="margin: 0px 10px 80px 10px;" >
                <div class="span3 div-regisreseller hidden-phone" style="margin-left: 55px;">
                    <center>
                        <div class="register-step-1"></div>
                    </center>  
                    <p class="nw-content g-txt16"  style="margin-top:50px;text-indent: 15px;margin-left: 8px;">
                    1. กรอกฟอร์มสมัคร และรอเจ้าหน้าที่ติดต่อกับ 
                     </p>     
                </div>
                <div class="span3 div-regisreseller visible-phone" >
                    <center>
                        <div class="register-step-1"></div>
                    </center>  
                    <p class="nw-content g-txt16"  style="margin-top:50px;text-indent: 15px;margin-left: 8px;">
                    1. กรอกฟอร์มสมัคร และรอเจ้าหน้าที่ติดต่อกับ 
                     </p>     
                </div>
                <div class="span1 hidden-phone" style="margin-left: 10px;margin-top: 35px;zoom: 2;">
                    <i class="fa fa-chevron-right " style="color: #FFF;
    margin-top: 80px;
    margin-left: 15px;;
"></i>
                </div>
                <div class="span3 div-regisreseller" >
                    <center>
                        <div class="register-step-2"></div>
                    </center>  
                    <p class="nw-content g-txt16" style="margin-top:50px;text-indent: 40px;">
                    2. นำส่งเอกสารสมัครเป็นตัวแทนจำหน่าย
                    </p>
                </div> 
                 <div class="span1 hidden-phone"  style="margin-left: 10px;margin-top: 35px;zoom: 2;">
                     <i class="fa fa-chevron-right " style="color: #FFF;
    margin-top: 80px;
    margin-left: 15px;
"></i>
                </div>
               <div class="span3 div-regisreseller " >
                    <center>
                         <div class="register-step-3"></div>   
                     </center>  
                    <p class="nw-content g-txt16" style="margin-top:50px;text-align: left;">3. เริ่มขายได้เลย!คุณสามารถส่งคำสั่งซื้อได้ในระบบสั่งซื้อของเรา หรือให้ Sales ของเราช่วยอำนวยความสะดวกให้</p>
                   
            </div>  
             </div>
         </div>
              
  </div>
     
     

     
  
{include file='notificationinfo.tpl'}
