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
    /*Departmental Modules  */
.hvrbox , .hvrbox * {
    box-sizing: border-box;
}
.hvrbox {
    position: relative;
    display: inline-block;
    overflow: hidden;
    max-width: 100%;
    height: auto;
}

.hvrbox .hvrbox-layer_bottom {
    display: block;
}
.hvrbox .hvrbox-layer_top {
    opacity: 0;
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    width: 100%;
    height: 100%;
    background: #24dce9;
    padding: 15px;
    
    
}

.hvrbox:hover .hvrbox-layer_top,
.hvrbox.active .hvrbox-layer_top {
    opacity: 1;
    
}
.hvrbox .hvrbox-text {
    text-align: left;
    display: inline-block;
    margin-top: 40px;
    left: 0px;
    color: #000000c7;
}
.hvrbox .hvrbox-text_mobile {
    font-size: 15px;
    border-top: 1px solid rgb(179, 179, 179); /* for old browsers */
    border-top: 1px solid rgba(179, 179, 179, 0.7);
    margin-top: 5px;
    padding-top: 2px;
    display: none;
}
.hvrbox.active .hvrbox-text_mobile {
    display: block;
}

/*End Departmental Modules */
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
                        <h2 class="re-txt-banner"> Dynamics 365 ระบบ CRM ยุคใหม่ <br/>ยกระดับธุรกิจไปอีกขั้น  พร้อมดูแล<br/>ตลอด 24 ชม.  </h2>          
                                               

                </div>
            </div>
             <div class="row visible-phone" >
        
                   <div class="hero-inner">
                        <h2 class="re-txt-banner" style="margin-top: 70px;letter-spacing: 1px; font-size: 23px;text-align: left;line-height: 30px;"> 
                       Dynamics 365 ระบบ CRM ยุคใหม่ <br/>ยกระดับธุรกิจไปอีกขั้น  พร้อมดูแลตลอด 24 ชม.  
                        </h2>          
                         <a href="https://docs.google.com/a/netwaygroup.com/forms/d/e/1FAIpQLSfkiDjNMTUR3NOcI98cDTLhm-DBYP_EyxHkAxdqRGjfpIQ7vg/viewform">
                           <button class="nw-kb-btn-ticket" type="submit"><i class="fa fa-edit"></i>&nbsp;Check Now</button>
                         </a>                        

                </div>
            </div>
        </div>
    </section>

  <div class="row-fluid"  style="background-color: #fff;"> 
      <div class="container"style="margin-top: 80px;" >         
            <div class="row">
               <div class="span12 dynamic-content"   >
                 <center>
                     <h3 class="h3-title-content g-txt32 re-topic" >Microsoft Dynamics 365 </h3>
                        <span class="nw-2018-content-line" style="margin-bottom: 30px;"></span>
                 </center>          
                </div>
            </div>
       </div>
       <div class="container"> 
            <div class="row " style="padding: 20px 0px 30px 20px; margin-top: 10px;">
                <div class="span12 dynamic-content"   >
                    <div class="span5 ">   
                        <img src="https://netway.co.th/templates/netwaybysidepad/images/dynamics-365-logo.jpg" alt="COMPLIANCE<" width="250" height="250">
                    </div> 
                <div class="span7"  style="margin-top: 0px;margin-left: 0px;"> 
                     
                        <p class="font-special-txt g-txt16">
                            
                            <br>Microsoft Dynamics 365 คือแอปพลิเคชันสำหรับธุรกิจที่รองรับการเติบโต
                            ขององค์กรอย่างครบวงจรสำหรับทุกแผนก รวมทุกระบบไว้ในหนึ่งเดียว ไม่ว่าจะเป็น CRM และ ERP 
                            รวมถึง HRM เป็นต้น Dynamics 365 ตอบโจทย์การใช้งานหลากหลายรูปแบบ ให้ทุกแผนกไม่ว่าจะเป็นฝ่ายขาย, 
                            การตลาด บริการลูกค้า, ทีมปฏิบัติงาน, การเงิน, ฝ่ายภาคสนาม, ทีมโปรเจค ฯลฯ ไปจนถึงฝ่ายวิเคราะห์ข้อมูลลูกค้าที่สามารถทำงานร่วมกันได้อย่างมีประสิทธิภาพ
                        </p>
               </div>
            </div>    
        </div>
    </div>
  </div>
  
  <div class="row-fluid" style="background-color: #00b7c3;"> 
        <div class="container">
            <div class="row " style="padding: 20px 0px 0px 20px; margin-top: 10px; height: 390px;">
                 <div class="span12 dynamic-content">
                    <center>
                       <div class="span12 ytp-cued-thumbnail-overlay"  style="margin-left: 0px;"> 
                          <iframe width="560" height="315" src="https://www.youtube-nocookie.com/embed/hiaL1f4SQCQ" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen 
                               style="margin-top: 20px;
                                      margin-bottom: 30px;">
                            </iframe>
                        </div>  
                    </center>
                 </div>    
            </div>
        </div>
 </div>
 
 
 <div class="row-fluid white-kb-2018">
        <div class="container"  style="margin-top: 70px;">
            <div class="row">
               <div class="span12 dynamic-content"   >
                   <center>
                       <h3 class="h3-title-content g-txt32 sam-topic" style="color: #0052cd; font-weight: 300; ">
                             Departmental Modules <br/>เลือกได้เฉพาะแผนกหรือทั้งองค์กร
                      </h3>
                     <span class="nw-2018-content-line" style="margin-bottom: 30px;"></span>
                  </center>          
               </div>
            </div>

            <div class="row">
                <div class="span4 div-products-gs hvrbox " style="background-color: #FFF;border: solid 4px #00b7c3;height: 200px; ">  
                    <div class="hvrbox-layer_bottom">
                        <p class="nw-product-title g-txt20 " style="text-align: center;color: #0052cc;">
                          <b>SALES</b><br/>
                           <img src="https://netway.co.th/templates/netwaybysidepad/images/dynamics-365-sale.png" style="margin-top: 8px; width: 140px;margin-left: 0px;" />
                        </p>
                        <div class="hvrbox-layer_top">
                          <p class="nw-product-title g-txt18 hvrbox-text">
                            เพิ่มยอดขายและเอาใจลูกค้าได้อยู่หมัดตั้งแต่แรกเจอด้วยระบบสนับสนุนการขายที่มีกลไกการเรียนรู้อัตโนมัติ
                         </p>  
                        </div> 
                    </div>
                </div>

                <div class="span4 div-products-gs hvrbox " style="background-color: #FFF;border: solid 4px #00b7c3;height: 200px; ">  
                    <div class="hvrbox-layer_bottom">
                        <p class="nw-product-title g-txt20 " style="text-align: center;color: #0052cc;">
                          <b>CUSTOMER SERVICE</b><br/>
                           <img src="https://netway.co.th/templates/netwaybysidepad/images/dynamics-365-custom.png" style="margin-top: 8px; width: 140px;margin-left: 0px;" />
                        </p>
                        <div class="hvrbox-layer_top">
                          <p class="nw-product-title g-txt18 hvrbox-text">
                            บริการลูกค้าขั้นเทพที่เชื่อมต่อกับทุกจุดของการสื่อสาร เพิ่ม Loyalty ให้แก่องค์กรด้วยระบบสนับสนุนลูกค้า
                         </p>  
                        </div> 
                    </div>
                </div>
                <div class="span4 div-products-gs hvrbox " style="background-color: #FFF;border: solid 4px #00b7c3;height: 200px; ">  
                    <div class="hvrbox-layer_bottom">
                        <p class="nw-product-title g-txt20 " style="text-align: center;color: #0052cc;">
                          <b>LOGISTICS</b><br/>
                           <img src="https://netway.co.th/templates/netwaybysidepad/images/dynamics-365-Fields.png" style="margin-top: 8px; width: 140px;margin-left: 0px;" />
                        </p>
                        <div class="hvrbox-layer_top">
                          <p class="nw-product-title g-txt18 hvrbox-text">
                            ค้าขายฉับไว ดูแลทุกส่วนของคลังสินค้าจนถึงการนำส่งให้ถึงมือลูกค้าคุณ อย่างรวดเร็วและประทับใจ                           
                         </p>  
                        </div> 
                    </div>
                </div>

          <div class="row" >
               <div class="span4 div-products-gs hvrbox " style="background-color: #FFF;border: solid 4px #00b7c3;height: 200px; ">  
                    <div class="hvrbox-layer_bottom">
                        <p class="nw-product-title g-txt20 " style="text-align: center;color: #0052cc;">
                          <b>HRM</b><br/>
                           <img src="https://netway.co.th/templates/netwaybysidepad/images/dynamics-365-talent.png" style="margin-top: 8px; width: 140px;margin-left: 0px;" />
                        </p>
                        <div class="hvrbox-layer_top">
                          <p class="nw-product-title g-txt18 hvrbox-text">
                           ใช้เครื่องมือสุดล้ำจาก LinkedIn ในการจัดหา ดูแล สอนงาน และอื่นๆ ครบทุกส่วนงานขององค์กร
                         </p>  
                        </div> 
                    </div>
                </div>
                <div class="span4 div-products-gs hvrbox " style="background-color: #FFF;border: solid 4px #00b7c3;height: 200px; ">  
                    <div class="hvrbox-layer_bottom">
                        <p class="nw-product-title g-txt20 " style="text-align: center;color: #0052cc;">
                          <b>FINANCE & OPERATIONS</b><br/>
                           <img src="https://netway.co.th/templates/netwaybysidepad/images/dynamics-365-Finance.png" style="margin-top: 8px; width: 140px;margin-left: 0px;" />
                        </p>
                        <div class="hvrbox-layer_top">
                          <p class="nw-product-title g-txt18 hvrbox-text">
                           สนับสนุนระบบบัญชีและการดำเนินการ ด้วยระบบ ERP ที่ออกแบบมาสำหรับองค์กรทุกขนาด
                         </p>  
                        </div> 
                    </div>
                </div>
                <div class="span4 div-products-gs hvrbox " style="background-color: #FFF;border: solid 4px #00b7c3;height: 200px; ">  
                    <div class="hvrbox-layer_bottom">
                        <p class="nw-product-title g-txt20 " style="text-align: center;color: #0052cc;">
                          <b>STORE FRONT</b><br/>
                           <img src="https://netway.co.th/templates/netwaybysidepad/images/dynamics-365-Retail.png" style="margin-top: 8px; width: 140px;margin-left: 0px;" />
                        </p>
                        <div class="hvrbox-layer_top">
                          <p class="nw-product-title g-txt18 hvrbox-text">
                           หน้าร้าน Retails จะมีเครื่องมือที่ใช้จัดการสิ่งต่างๆ ได้จากที่เดียว ไม่ยุ่งยากและเชื่อมต่อตลอดเวลา
                           
                         </p>  
                        </div> 
                    </div>
                </div>
          </div>
            <div class="row" >
                <div class="span4 div-products-gs hvrbox " style="background-color: #FFF;border: solid 4px #00b7c3;height: 200px; ">  
                    <div class="hvrbox-layer_bottom">
                        <p class="nw-product-title g-txt20 " style="text-align: center;color: #0052cc;">
                          <b>PROJECTS</b><br/>
                           <img src="https://netway.co.th/templates/netwaybysidepad/images/Dynamics-365-Project.png" style="margin-top: 8px; width: 140px;margin-left: 0px;" />
                        </p>
                        <div class="hvrbox-layer_top">
                          <p class="nw-product-title g-txt18 hvrbox-text">
                             ทีมบริหารโครงการทำงานได้อย่างคล่องตัวทั้งบนเดสก์ท้อปและโมบาย อัพเดทสถานะงานและส่งรายงานข้ามทีมได้
                         </p>  
                        </div> 
                    </div>
                </div>
                <div class="span4 div-products-gs hvrbox " style="background-color: #FFF;border: solid 4px #00b7c3;height: 200px; ">  
                    <div class="hvrbox-layer_bottom">
                        <p class="nw-product-title g-txt20 " style="text-align: center;color: #0052cc;">
                          <b>MARKETING</b><br/>
                           <img src="https://netway.co.th/templates/netwaybysidepad/images/dynamics-365-Marketing.png" style="margin-top: 8px; width: 140px;margin-left: 0px;" />
                        </p>
                        <div class="hvrbox-layer_top">
                          <p class="nw-product-title g-txt18 hvrbox-text">
                             วางแผนแคมเปญทางการตลาดอย่างลงตัวแม่นยำและรู้จักลูกค้าได้จากทุกช่องทางที่คุณโปรโมทสินค้าออกไป
                         </p>  
                        </div> 
                    </div>
                </div>    
                <div class="span4 div-products-gs hvrbox " style="background-color: #FFF;border: solid 4px #00b7c3;height: 200px; ">  
                    <div class="hvrbox-layer_bottom">
                        <p class="nw-product-title g-txt20 " style="text-align: center;color: #0052cc;">
                          <b>BUSINESS CENTRA</b><br/>
                           <img src="https://netway.co.th/templates/netwaybysidepad/images/business.png" style="margin-top: 8px; width: 140px;margin-left: 0px;" />
                        </p>
                        <div class="hvrbox-layer_top">
                          <p class="nw-product-title g-txt18 hvrbox-text">
                             เป็นทุกอย่างขององค์กรด้วย Business Central ที่ทำหน้าที่เป็นกระดูกสันหลังขององค์กรคุณ
                         </p>  
                        </div> 
                    </div>
                </div>                 
            </div>
       </div>
    </div>
 </div>
 
 
 <div class="row-fluid white-kb-2018">
        <div class="container"  style="margin-top: 70px;">
            <div class="row">
               <div class="span12 dynamic-content"   >
                   <center><h3 class="h3-title-content g-txt32 sam-topic" style="color: #0052cd; font-weight: 300; ">Enterprise Features</h3>
                   <span class="nw-2018-content-line" style="margin-bottom: 30px;"></span></center>          
               </div>
            </div>
            
            <div class="row" style="margin-top: 20px;">
                    <div class="span8 sam-checklist" >
                        <p class="nw-product-title g-txt20">รองรับการใช้งานเฉพาะทาง (Purpose-built)</p>
                        <p class="g-txt16" style="margin-top: 30px;">&nbsp;<i class="fa fa-angle-right"></i>
                            &nbsp;&nbsp;ปรับแต่งให้ใช้ทำงานกับงานเฉพาะทางได้                      
                        </p>                  
                        <p class="g-txt16">&nbsp;<i class="fa fa-angle-right"></i>
                            &nbsp;&nbsp;ทำงานร่วมกับแอพอื่นได้                        
                        </p>
                         <p class="g-txt16">&nbsp;<i class="fa fa-angle-right"></i>
                            &nbsp;&nbsp;รองรับจำนวนผู้ใช้งานได้ตั้งแต่ 1 จนถึง 1,000 ขึ้นไป                        
                        </p>
                    </div> 
                    <div class="span4 hidden-phone"style="margin-left: 0px;">
                       <img src="https://netway.co.th/templates/netwaybysidepad/images/dynamics365-icon-01.png" style="margin-top: 30px;  width: 260px;" />
                    </div>
            </div>
            <hr/>
            <div class="row" style="margin-top: 20px;">
                 <div class="span8 sam-checklist">
                      <p class="nw-product-title g-txt20">ทำงานได้จากทุกเครื่องมือที่ถนัด (Productive)</p>
                      <p class="g-txt16" style=" margin-top: 30px;">&nbsp;<i class="fa fa-angle-right"></i>
                            &nbsp;&nbsp;ผู้ใช้ไม่ต้องเรียนรู้ใหม่                      
                        </p>                  
                        <p class="g-txt16">&nbsp;<i class="fa fa-angle-right"></i>
                            &nbsp;&nbsp;ทำงานบน Excel ที่คุ้นเคย                       
                        </p>
                         <p class="g-txt16">&nbsp;<i class="fa fa-angle-right"></i>
                            &nbsp;&nbsp;มีเมนูและ UI ที่เข้าใจง่าย                        
                        </p>   
                </div>
                <div class="span4 hidden-phone"style="margin-left: 0px;">
                    <img src="https://netway.co.th/templates/netwaybysidepad/images/dynamics365-icon-02.png" style="margin-top: 30px;  width: 260px;" />
                </div>
           </div>
           <hr/>
           <div class="row" style="margin-top: 20px;">
                 <div class="span8 sam-checklist">
                      <p class="nw-product-title g-txt20">รวมทุกระบบการทำงานไว้ในที่เดียว (Intelligent)</p>
                      <p class="g-txt16" style=" margin-top: 30px;">&nbsp;<i class="fa fa-angle-right"></i>
                            &nbsp;&nbsp;ฐานข้อมูลแบบ built in เพื่อเชื่อมต่อกับ Power BI, Cortana Intelligence <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;และ Azure Machine Learning 
                     
                        </p>                  
                        <p class="g-txt16">&nbsp;<i class="fa fa-angle-right"></i>
                            &nbsp;&nbsp;เรียกดูรายงานได้แบบรีลไทม์                     
                        </p>
                         <p class="g-txt16">&nbsp;<i class="fa fa-angle-right"></i>
                            &nbsp;&nbsp;ใช้ประกอบการตัดสินใจได้ทุกการประชุม                     
                        </p>   
                </div>
                <div class="span4 hidden-phone"style="margin-left: 0px;">
                    <img src="https://netway.co.th/templates/netwaybysidepad/images/dynamics365-icon-03.png" style="margin-top: 30px;  width: 260px;" />
                </div>
           </div>
            <hr/>
            <div class="row" style="margin-top: 20px;">
                 <div class="span8 sam-checklist">
                      <p class="nw-product-title g-txt20">ปรับแต่งได้ง่ายตามความต้องการของคุณ (Adaptable)</p>
                      <p class="g-txt16" style=" margin-top: 30px;">&nbsp;<i class="fa fa-angle-right"></i>
                            &nbsp;&nbsp;จัดการทุกอย่างจากหน้าจอเดียว 
                        </p>                  
                        <p class="g-txt16">&nbsp;<i class="fa fa-angle-right"></i>
                            &nbsp;&nbsp;ทำงานกับ Microsoft PowerApps เพื่อสร้าง Mobile/Web Application สำหรับองค์ก                  
                        </p>
                         <p class="g-txt16">&nbsp;<i class="fa fa-angle-right"></i>
                            &nbsp;&nbsp;ทำงานร่วมกับ Microsoft Flow เพื่อสร้างระบบงานอัตโนมัติ                   
                        </p>   
                </div>
                <div class="span4 hidden-phone"style="margin-left: 0px;">
                    <img src="https://netway.co.th/templates/netwaybysidepad/images/dynamics365-icon-04.png" style="margin-top: 30px;  width: 260px;" />
                </div>
           </div>
           <hr/>
      </div>
     </div>
  
 
 <div class="row-fluid white-kb-2018">
        <div class="container"  style="margin-top: 70px;">
            <div class="row">
               <div class="span12 dynamic-content"   >
                   <center><h3 class="h3-title-content g-txt32 sam-topic" style="color: #0052cd; font-weight: 300; ">Plan  & Pricing</h3>
                   <span class="nw-2018-content-line" style="margin-bottom: 30px;"></span></center>          
               </div>
            </div>
            <div class="row">
                    <div class="span3 div-products-gs" style="text-align:  center;">
                        <p class="nw-product-title g-txt20" style="margin-top: 10px;color: #0052cc;"><b>SALES</b></p>
                          <p class="nw-product-title g-txt18" style="margin-top: 15px;">เริ่มต้นที่</p>
                          <p class="nw-product-title g-txt18" style="margin-top: 10px;"><b>21,500 บาท</b></p>
                          <p class="nw-product-title g-txt18" style="margin-top: 10px;"> ต่อผู้ใช้ต่อปี </p>
                 
                    </div>
                    <div class="span3 div-products-gs" style="text-align:  center;">
                         <p class="nw-product-title g-txt20" style="margin-top: 10px;color: #0052cc;"><b>CUSTOMER SERVICE</b></p>
                          <p class="nw-product-title g-txt18" style="margin-top: 15px;">เริ่มต้นที่</p>
                          <p class="nw-product-title g-txt18" style="margin-top: 10px;"><b>30,000 บาท</b></p>
                          <p class="nw-product-title g-txt18" style="margin-top: 10px;">ต่อผู้ใช้ต่อปี</p>
                    </div>
                    <div class="span3 div-products-gs" style="text-align:  center;"> 
                     <p class="nw-product-title g-txt20" style="margin-top: 10px;color: #0052cc;"><b>LOGISTICS</b></p>
                          <p class="nw-product-title g-txt18" style="margin-top: 15px;">เริ่มต้นที่</p>
                          <p class="nw-product-title g-txt18" style="margin-top: 10px;"><b>30,000 บาท</b></p>
                          <p class="nw-product-title g-txt18" style="margin-top: 10px;"> ต่อผู้ใช้ต่อปี </p>
                    </div>
                    <div class="span3 div-products-gs" style="text-align:  center; ">
                     <p class="nw-product-title g-txt20" style="margin-top: 10px;color: #0052cc;"><b>HRM</b></p>
                          <p class="nw-product-title g-txt18" style="margin-top: 15px;">เริ่มต้นที่</p>
                          <p class="nw-product-title g-txt18" style="margin-top: 10px;"><b>15,000 บาท</b></p>
                          <p class="nw-product-title g-txt18" style="margin-top: 10px;"> ต่อผู้ใช้ต่อปี </p>
                          <p class="nw-product-title g-txt16" style="margin-top: 10px;color: #f60c2f; ">* ขั้นต่ำ 5 users</p> 
                    </div>
          </div>
          <div class="row" >
                    <div class="span3 div-products-gs" style="text-align:  center;">
                       <p class="nw-product-title g-txt20" style="margin-top: 10px;color: #0052cc;"><b>FINANCE & OPERATIONS</b></p>
                          <p class="nw-product-title g-txt18" style="margin-top: 15px;">เริ่มต้นที่</p>
                          <p class="nw-product-title g-txt18" style="margin-top: 10px;"><b>60,000 บาท</b></p>
                          <p class="nw-product-title g-txt18" style="margin-top: 10px;"> ต่อผู้ใช้ต่อปี </p>
                    </div>
                    <div class="span3 div-products-gs" style="text-align:  center;">
                        <p class="nw-product-title g-txt20" style="margin-top: 10px;color: #0052cc;"><b>STORE FRONT</b></p>
                          <p class="nw-product-title g-txt18" style="margin-top: 15px;">เริ่มต้นที่</p>
                          <p class="nw-product-title g-txt18" style="margin-top: 10px;"><b>49,500 บาท</b></p>
                          <p class="nw-product-title g-txt18" style="margin-top: 10px;"> ต่อผู้ใช้ต่อปี </p>        
                    </div>
                    <div class="span3 div-products-gs" style="text-align:  center;"> 
                       <p class="nw-product-title g-txt20" style="margin-top: 10px;color: #0052cc;"><b>PROJECTS</b></p>
                          <p class="nw-product-title g-txt18" style="margin-top: 15px;">เริ่มต้นที่</p>
                          <p class="nw-product-title g-txt18" style="margin-top: 10px;"><b>30,000 บาท</b></p>
                          <p class="nw-product-title g-txt18" style="margin-top: 10px;"> ต่อผู้ใช้ต่อปี </p>
                   </div>
                   <div class="span3 div-products-gs" style="text-align:  center; ">
                     <p class="nw-product-title g-txt20" style="margin-top: 10px;color: #0052cc;"><b>MARKETING</b></p>
                          <p class="nw-product-title g-txt18" style="margin-top: 15px;">เริ่มต้นที่</p>
                          <p class="nw-product-title g-txt18" style="margin-top: 10px;"><b>245,000 บาท</b></p>
                          <p class="nw-product-title g-txt18" style="margin-top: 10px;"> ต่อผู้ใช้ต่อปี </p>
                  </div>
            </div>
           <div class="row" >
                    <div class="span3 div-products-gs" style="text-align:  center;">
                       <p class="nw-product-title g-txt20" style="margin-top: 10px;color: #0052cc;"><b>BUSINESS CENTRAL</b></p>
                          <p class="nw-product-title g-txt18" style="margin-top: 15px;">เริ่มต้นที่</p>
                          <p class="nw-product-title g-txt18" style="margin-top: 10px;"><b>21,500 บาท</b></p>
                          <p class="nw-product-title g-txt18" style="margin-top: 10px;"> ต่อผู้ใช้ต่อปี </p>
                    </div>
                    <div class="span3 div-products-gs" style="text-align:  center;">
                        <p class="nw-product-title g-txt20" style="margin-top: 10px;color: #0052cc;"><b>FULL CRM</b></p>
                          <p class="nw-product-title g-txt18" style="margin-top: 15px;">เริ่มต้นที่</p>
                          <p class="nw-product-title g-txt18" style="margin-top: 10px;"><b>36,500 บาท</b></p>
                          <p class="nw-product-title g-txt18" style="margin-top: 10px;"> ต่อผู้ใช้ต่อปี </p>  
                          <p class="nw-product-title g-txt16" style="margin-top: 10px;color: #f60c2f; ">* ขั้นต่ำ 20 users</p>      
                    </div>
                    <div class="span3 div-products-gs" style="text-align:  center;"> 
                       <p class="nw-product-title g-txt20" style="margin-top: 10px;color: #0052cc;"><b>FULL ERP</b></p>
                          <p class="nw-product-title g-txt18" style="margin-top: 15px;">เริ่มต้นที่</p>
                          <p class="nw-product-title g-txt18" style="margin-top: 10px;"><b>60,000 บาท</b></p>
                          <p class="nw-product-title g-txt18" style="margin-top: 10px;"> ต่อผู้ใช้ต่อปี </p>
                          <p class="nw-product-title g-txt16" style="margin-top: 10px;color: #f60c2f; ">* ขั้นต่ำ 20 users</p>
                   </div>
                   <div class="span3 div-products-gs" style="text-align:  center; ">
                     <p class="nw-product-title g-txt20" style="margin-top: 10px;color: #0052cc;"><b>FULL CRM & ERP</b></p>
                          <p class="nw-product-title g-txt18" style="margin-top: 15px;">เริ่มต้นที่</p>
                          <p class="nw-product-title g-txt18" style="margin-top: 10px;"><b>65,000 บาท</b></p>
                          <p class="nw-product-title g-txt18" style="margin-top: 10px;"> ต่อผู้ใช้ต่อปี </p>
                          <p class="nw-product-title g-txt16" style="margin-top: 10px;color: #f60c2f; ">* ขั้นต่ำ 20 users</p>
                  </div>
            </div>
            <div class="row">
             <div class="span12">
                 <p class="g-txt16" style="margin-left: 3px;">*ราคาไม่รวมภาษีมูลค่าเพิ่ม</p>
             </div>
             <center>
                 <div class="hidden-phone">
                    <a class="btn-check" href="https://support.netway.co.th/hc/th/requests/new?ticket_form_id=114093961711&request_subject=%E0%B9%83%E0%B8%9A%E0%B9%80%E0%B8%AA%E0%B8%99%E0%B8%AD%E0%B8%A3%E0%B8%B2%E0%B8%84%E0%B8%B2%20Dynamics%20365">
                        ขอใบเสนอราคา
                   </a>
                 </div>
            </center>
           </div>
       </div>
    </div>
 </div> 
  
    <div class="row-fluid bg-gs-w ">
    <div class="container">
         <div class="row">
            <div class="span12" style="margin-top: -10px;">
            <center>
            <h3 class="h3-titel-content g-txt32">Promo</h3>
            <span class="nw-2018-content-line"></span>
            </center>
            </div>
         </div>
        <div class="row" style="margin-top: 30px; margin-bottom: 30px;">
        <div class="span4" style="padding: 0px 10px 0px 10px;">
            <center>
                <img src="https://netway.co.th/templates/netwaybysidepad/images/Try_Home-2048x600.png" width="600px">
            </center>
        </div>
        <div class="span8" style="padding: 0px 10px 0px 10px;">
            <p class="g-txt16" style="margin-top: 10px;">คุณสามารถทดลองใช้งาน Dynamics 365 เพื่อพัฒนาธุรกิจของคุณให้ทันสมัยและก้าวไปข้างหน้า </p>
            <p class="g-txt16"> <b> เป็นระยะเวลา 30 วัน โดยไม่มีค่าใช้จ่ายใดๆ</b></p>          
           
            <div class="hidden-phone">
                <a class="btn-check" href="https://support.netway.co.th/hc/th/requests/new?ticket_form_id=114093963072&request_subject=ทดลองใช้งาน%20Dynamics%20365%20ฟรี%2030%20วัน&request_custom_fields_114095596292=sales_opt_other">
                    ลงทะเบียน 
               </a>
            </div>
            <div class="visible-phone" style="text-align:center;">
                <a class="btn-check" href="https://support.netway.co.th/hc/th/requests/new?ticket_form_id=114093963072&request_subject=ทดลองใช้งาน%20Dynamics%20365%20ฟรี%2030%20วัน&request_custom_fields_114095596292=sales_opt_other">
                    ลงทะเบียน 
                </a>
            </div>
        </div>

    </div>
    </div>
</div>

  
  
{include file='notificationinfo.tpl'}
