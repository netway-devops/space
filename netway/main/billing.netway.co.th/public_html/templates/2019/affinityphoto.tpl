{php} $templatePath = $this->get_template_vars('template_path');
include($templatePath . 'kb.tpl.php'); {/php} {literal}

<script>
    AOS.init({
      easing: 'ease-in-out-sine'
    });
  </script>
{/literal}
<script src="{$template_dir}js/tabs.js" type="text/javascript"></script>
<!-- ******************** Start AddThis ******************** -->
<div class="pathway-inpage">{include file='addthis.tpl'}</div>
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

.bg-logo-customer {
	background-size: 122px 42px;
	height: 40x;
	width: 120px;
	margin-left: -8px;
	display: inline-block;
}

.logo-customer {
	-webkit-filter: grayscale(100%);
	filter: grayscale(100%);
}

.logo-customer:hover {
	-webkit-filter: grayscale(0%);
	filter: grayscale(0%);
}
.txt-center {
    text-align: center;
}
.overlay-content {
    background-color: rgba(245,245,245, 0.7);
    padding: 50px 50px 50px 50px;
    box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
    width: 50%;
}
/*Start Responsive */
@media ( min-width : 1281px) {
	.bg {
	
		background-position: top center;
		background-repeat: no-repeat;
		background-size: cover;
		background-position: top;
		height: 530px;
		width: 100%;
	}
	.bg-content {
	
        background-position: top center;
        background-repeat: no-repeat;
        background-size: cover;
        background-position: top;
        height: 500px;
        width: 100%;
	}
	.bg-content-sky {
    
        background-position: top center;
        background-repeat: no-repeat;
        background-size: cover;
        background-attachment: fixed;
        background-position: bottom;
        height: 410px;
        width: 100%;
    }
    .bg-content-gray {
    
        background-position: top center;
        background-repeat: no-repeat;
        background-size: cover;
        background-position: bottom;
        width: 100%;
    }
	.bg-back {
	    background: rgba(0, 0, 0, 0.4);
	    height: 530px;
	}
	.txt-hero-banner {
		color: #ffffff;
		font-size: 38px;
		line-height: 30px;
		font-weight: 500;
	}
	.txt-hero-banner-topic {
		color: #ffffff;
		font-size: 40px;
		line-height: 30px;
	}
}

@media ( min-width : 1025px) and (max-width: 1280px) {
	.bg {
		background-position: top center;
		text-align: center;
		background-repeat: no-repeat;
		background-size: cover;
		background-attachment: fixed;
		background-position: center;
		height: 530px;
		width: 100%;
	}
}

/* ##Device = Tablets, Ipads (portrait) */
@media ( min-width : 768px) and (max-width: 1024px) {
	.bg {
		background-position: top center;
		text-align: center;
		background-repeat: no-repeat;
		background-size: cover;
		height: 430px;
		width: 100%;
	}
}

/* ##Device = Tablets, Ipads (landscape) */
@media ( min-width : 768px) and (max-width: 1024px) and (orientation:
	landscape) {
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
}
/*
         ##Device = Low Resolution Tablets, Mobiles (Landscape)
         ##Screen = B/w 481px to 767px
      */
@media ( min-width : 481px) and (max-width: 767px) {
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
	.txt-hero-banner {
		color: #001ea7;
		font-size: 28px;
		line-height: 30px;
		font-weight: 800;
	}
}

@media ( min-width : 320px) and (max-width: 480px) {
	.bg {
		text-align: center;
		background-repeat: no-repeat;
		background-size: cover;
		height: auto;
		width: 100%;
	}
	.txt-hero-banner {
		color: #001ea7;
		font-size: 28px;
		line-height: 30px;
		font-weight: 800;
	}
}
/*End Responsive */
/*** End SharePoint ***/
</style>
{/literal}

<!--Desktop  -->
<div class="bg hidden-phone lazy-hero" data-src="/templates/netwaybysidepad/images/bg-affinity_photo-min.png">

		<div class="container">
			<div class="row">
				<div class="span7" style="font-family: 'Prompt', sans-serif;">

					<div class="padding-banner"	style="margin-top: 100px; text-align: center;">
						<img class="lazy-hero" data-src="/templates/netwaybysidepad/images/affinity_photo_logo-min.png" width="100px" />
						  <p class="g-txt30" style="color: #fff; line-height: normal;">Affinity Photo</p>
						<p class="txt-hero-banner-topic">ทางเลือกใหม่ของซอฟแวร์ดีไซน์</p>
						<p class="g-txt22" style="color: #fff; line-height: normal;">ที่มีประสิทธิภาพเท่าโปรแกรมชั้นนำ</p>
		                 <a class="fancybox.iframe fancybox-media" href="/templates/netwaybysidepad/video/affinity-photo.mp4"  type="video/mp4"  rel="media-gallery">
		                     <button  class="btn-banner-cloud" type="submit">
		                      <i class="fa fa-play-circle" aria-hidden="true"></i>  คลิกดูวีดีโอตัวอย่าง
		                     </button>
		                 </a>
					</div>

				</div>
				<div class="span5">
				</div>

			</div>
		</div>

</div>
<!-- End Desktop  -->
<!-- Mobile -->
<div class="bg visible-phone lazy-hero"
	data-src="/templates/netwaybysidepad/images/bg-affinity_photo-min.png">
	<div class="container">
		<div class="row">

			<div class="span12">
			    <div class="padding-banner" style="margin-top: 60px; text-align: center;">
                   <img class="lazy-hero" data-src="/templates/netwaybysidepad/images/affinity_photo_logo-min.png" width="100px" />
                   <p class="g-txt30" style="color: #fff; line-height: normal;">Affinity Photo</p>
                   <p class="txt-hero-banner-topic">ทางเลือกใหม่ของซอฟแวร์ดีไซน์</p>
                   <p class="g-txt22" style="color: #fff; line-height: normal;">ที่มีประสิทธิภาพเท่าโปรแกรมชั้นนำ</p>
                                        
                 <a class="fancybox.iframe fancybox-media" href="/templates/netwaybysidepad/video/affinity-photo.mp4"  type="video/mp4"  rel="media-gallery">
	                 <button  class="btn-banner-cloud" type="submit">
	                  <i class="fa fa-play-circle" aria-hidden="true"></i>  คลิกดูวีดีโอตัวอย่าง
	                 </button>
                 </a>
                </div>
			</div>

		</div>
	</div>
</div>
<!-- End mobile -->

<div class="row-fluid"  style="background-color: #fff; padding: 50px 20px 50px 20px;">
	<div class="container">
		<div class="row" style="padding: 30px 20px 20px 20px;">
			<div class="span12 dynamic-content">
				<center>
					<p class="h3-title-content g-txt32 re-topic">ทางเลือกใหม่สำหรับมืออาชีพ </p>
					<hr width="30%"/>
				
				</center>
				<p class="g-txt18" style="margin-bottom: 20px;  line-height: 24px; text-align: justify;">
					รวดเร็ว ราบรื่น และมีประสิทธิภาพมากกว่าที่เคยด้วย Affinity Photo
					ที่ทำลายขีดจำกัดของซอฟตแวร์แก้ไขภาพแบบเดิมๆ
					ด้วยชุดเครื่องมือมากมายที่ออกแบบมาเพื่อตอบสนองความต้องการของครีเอทีฟ
					และช่างภาพมืออาชีพ ไม่ว่าคุณจะกำลังแก้ไข และตกแต่งภาพ
					หรือตัดต่อสร้างสรรค์ผลงานต่างๆ Affinity Photo มีความสามารถ
					และประสิทธิภาพตามที่คุณต้องการ
			    </p>
			    <img class="lazy"  data-src="/templates/netwaybysidepad/images/for-professionals-min.jpg"   style="margin-top: 30px;" />
			</div>
		</div>
		<div class="row" style="padding: 30px 20px 20px 20px;">
		    <div class="span2 txt-center">
		        <img class="lazy"  data-src="/templates/netwaybysidepad/images/icon-affinityphoto-raw-min.png"  />
		        <p class="g-txt16" style="margin-top: 15px; color: #0052cd;">Raw Editing</p>
		    </div>
		    <div class="span2 txt-center">
                <img class="lazy"  data-src="/templates/netwaybysidepad/images/icon-affinityphoto-hdr-min.png"  />
                <p class="g-txt16" style="margin-top: 15px; color: #0052cd;">HDR Merge</p>
            </div>
            <div class="span2 txt-center">
                <img class="lazy"  data-src="/templates/netwaybysidepad/images/icon-affinityphoto-panorama-min.png"  />
                <p class="g-txt16" style="margin-top: 15px; color: #0052cd;">Panorama Stitching</p>
            </div>
            <div class="span2 txt-center">
                <img class="lazy"  data-src="/templates/netwaybysidepad/images/icon-affinityphoto-focus-min.png"  />
                <p class="g-txt16" style="margin-top: 15px; color: #0052cd;">Focus Stacking</p>
            </div>
            <div class="span2 txt-center">
                <img class="lazy"  data-src="/templates/netwaybysidepad/images/icon-affinityphoto-retouching-min.png"  />
                <p class="g-txt16" style="margin-top: 15px; color: #0052cd; width: 120%;  margin-left: -15px;">Professional Retouching</p>
            </div> 
            <div class="span2 txt-center">
                <img class="lazy"  data-src="/templates/netwaybysidepad/images/icon-affinityphoto-batch-min.png"  />
                <p class="g-txt16" style="margin-top: 15px; color: #0052cd;">Batch Processing</p>
            </div>                               
		</div>
	    <div class="row" style="padding: 30px 20px 20px 20px;">
            <div class="span2 txt-center">
                   &nbsp;&nbsp;
            </div>
            <div class="span2 txt-center">
                <img class="lazy"  data-src="/templates/netwaybysidepad/images/icon-affinityphoto-psd-min.png"  />
                <p class="g-txt16" style="margin-top: 15px; color: #0052cd;">PSD Editing</p>
            </div>
            <div class="span2 txt-center">
                <img class="lazy"  data-src="/templates/netwaybysidepad/images/icon-affinityphoto-painting-min.png"  />
                <p class="g-txt16" style="margin-top: 15px; color: #0052cd;">Digital Painting</p>
            </div>
            <div class="span2 txt-center">
                <img class="lazy"  data-src="/templates/netwaybysidepad/images/icon-affinityphoto-360-min.png"  />
                <p class="g-txt16" style="margin-top: 15px; color: #0052cd;">360° Image Editing</p>
            </div>
            <div class="span2 txt-center">
                <img class="lazy"  data-src="/templates/netwaybysidepad/images/icon-affinityphoto-multi-layered-min.png"  />
                 <p class="g-txt18" style="margin-top: 15px; color: #0052cd;  width: 140%;  ">Multi-Layered Compositions</p>
            </div> 
            <div class="span2 txt-center">
                     &nbsp;&nbsp;
            </div>                               
        </div>
        <div class="row"  style="margin-top: 50px; margin-bottom: 50px;">
          <div class="span6" style="padding: 80px 0 0 0;"> 
                 <p class="h3-title-content g-txt32 re-topic">การแก้ไข และการปรับระดับมืออาชีพ</p>
                 <hr width="30%"/>
                 <p class="g-txt18" style="margin-bottom: 20px;  line-height: 24px; text-align: justify;">
                                     ยกระดับรูปภาพของคุณด้วย Levels, Curves, Black and White, White Balance, HSL, Shadows and Highlights และเครื่องมืออื่นๆ อีกหลายสิบแบบ ซึ่งสามารถแก้ไขรูปภาพพร้อมกับดูตัวอย่างภาพได้ตลอดเวลา Affinity Photo ยังสามารถแก้ไขเลนส์ และจุดรบกวนรูปภาพได้อย่างมีประสิทธิภาพ เพื่อให้คุณสามารถปรับแต่งรูปภาพอย่างเต็มที่
                </p>
          </div>
          <div class="span6">
                <img class="lazy"  data-src="/templates/netwaybysidepad/images/img-affinityphoto-adjustments-min.jpg"  /> 
          </div>
        </div>


	</div>
</div>
<div class="bg-content lazy" data-src="/templates/netwaybysidepad/images/img-affinityphoto-retouching-tools-min.jpg">
  <div class="container">
      <div class="row"  style="margin-top: 50px; margin-bottom: 50px;">
          <div class="span6">
               &nbsp;&nbsp;
          </div>
          <div class="span6 overlay-content" > 
                 <p class="h3-title-content g-txt32 re-topic">เครื่องมือตกแต่งที่สมบูรณ์แบบ</p>
                 <hr width="30%"/>
                 <p class="g-txt18" style="margin-bottom: 20px; line-height: 24px;; text-align: justify;">
                                     ไม่ว่าคุณจะต้องการแก้ไขอย่างรวดเร็ว หรือแก้ไขแบบความรายละเอียดสูง Affinity Photo ก็สามารถตอบสนองความต้องการของคุณได้ด้วยเครื่องมือ dodge, burn, clone, patch, blemish และ red eye tools ที่สามารถเก็บรายละเอียดได้อย่างรวดเร็ว ทำให้คุณประหยัดเวลากับงานที่ต้องใช้ความละเอียดสูงได้อย่างง่ายดาย
                </p>
                <table>
                    <tr style="line-height: 30px;">
                        <td width="300px"><i class="fa fa-square" aria-hidden="true"></i>  &nbsp;&nbsp; Clone, Dodge, Burn</td>
                        <td width="300px"><i class="fa fa-square" aria-hidden="true"></i>  &nbsp;&nbsp; Liquefy</td>
                    </tr>
                    <tr style="line-height: 30px;">
                        <td width="300px"><i class="fa fa-square" aria-hidden="true"></i>  &nbsp;&nbsp; Recoloring</td>
                        <td width="300px"><i class="fa fa-square" aria-hidden="true"></i>  &nbsp;&nbsp; Frequency Separation</td>
                    </tr>
                    <tr style="line-height: 30px;">
                        <td width="300px"><i class="fa fa-square" aria-hidden="true"></i>  &nbsp;&nbsp; Inpainting</td>
                        <td width="300px"><i class="fa fa-square" aria-hidden="true"></i>  &nbsp;&nbsp; Healing Tools</td>
                    </tr>                                     
                </table>
          </div>
     </div> 
  </div>
</div>
 <div class="container">
      <div class="row"  style="margin-top: 50px; margin-bottom: 50px;">
          <div class="span6" style="padding: 80px 0 0 0;"> 
                 <p class="h3-title-content g-txt32 re-topic">พื้นที่แก้ไข RAW โดยเฉพาะ</p>
                 <hr width="30%"/>
                 <p class="g-txt18" style="margin-bottom: 20px;  line-height: 24px; text-align: justify;">
                                        พัฒนาไฟล์ RAW ของกล้องด้วยพื้นที่แก้ไขไฟล์ RAW โดยเฉพาะพร้อมกับเครื่องมือแก้ไข และการปรับแต่งที่แม่นยำ
                 </p>
          </div>
          <div class="span6">
                <img class="lazy"  data-src="/templates/netwaybysidepad/images/img-affinityphoto-raw-studio-min.jpg"  /> 
          </div>
      </div>
     <hr/>
     <div class="row"  style="margin-top: 50px; margin-bottom: 50px;">
          <div class="span6">
                <img class="lazy"  data-src="/templates/netwaybysidepad/images/img-affinityphoto-hdr-merge-min.jpg"  /> 
          </div>     
          <div class="span6" style="padding: 80px 0 0 0;"> 
                 <p class="h3-title-content g-txt32 re-topic">รวมภาพ HDR ด้วย Tone Mapping</p>
                 <hr width="30%"/>
                 <p class="g-txt18" style="margin-bottom: 20px;  line-height: 24px; text-align: justify;">
                                       ดึงรายละเอียดที่ซ่อนอยู่ด้วยการรวมภาพหลายๆโทนสีเข้าด้วยกัน
                 </p>                
                 <table>
                    <tr style="line-height: 30px;">
                        <td width="300px"><i class="fa fa-square" aria-hidden="true"></i>  &nbsp;&nbsp; Unlimited Source Images</td>
                        <td width="300px"><i class="fa fa-square" aria-hidden="true"></i>  &nbsp;&nbsp; Tone Mapping</td>
                    </tr>
                    <tr style="line-height: 30px;">
                        <td width="300px"><i class="fa fa-square" aria-hidden="true"></i>  &nbsp;&nbsp; Merge from RAW</td>
                        <td width="300px"><i class="fa fa-square" aria-hidden="true"></i>  &nbsp;&nbsp; Automatic Alignment</td>
                    </tr>                                    
                </table>
          </div>

      </div>
 </div>
 <div class="bg-content-sky lazy" data-src="/templates/netwaybysidepad/images/img-affinityphoto-precise-selection-bg-min.jpg">
  <div class="container">
      <div class="row"  style="margin-top: 50px; margin-bottom: 50px;">
          <div class="span6" style="margin-top: 50px;" > 
                 <p class="h3-title-content g-txt32 re-topic">Selections ที่แม่นยำ</p>
                 <hr width="30%"/>
                 <p class="g-txt18" style="margin-bottom: 20px; line-height: 24px;; text-align: justify;">
                                   ความแม่นยำที่คุณไม่เคยคิดว่าเป็นไปได้ด้วยอัลกอริทึมการคัดเลือกขั้นสูงของ Affinity Photo ไม่ว่าจะเป็น การตัดวัตถุ การสร้างหน้ากาก หรือการเลือกใช้การปรับแต่งอย่างเฉพาะเจาะจงคุณก็สามารถเลือกได้อย่างแม่นยำ แม้แต่เส้นผมแต่ละเส้นคุณก็สามารถทำได้ </p>
          </div>
          <div class="span6">
             <img class="lazy"  data-src="/templates/netwaybysidepad/images/img-affinityphoto-precise-selection-min.png"  /> 
          </div>
     </div> 
  </div>
</div>
 <div  style="background-color: #e6e6e6;">
  <div class="container">
      <div class="row"  style="margin-top: 50px; margin-bottom: 50px;">
          <div class="span6 " > 
                 <p class="h3-title-content g-txt32 re-topic">องค์ประกอบที่น่าทึ่ง</p>
                 <hr width="30%"/>
                 <p class="g-txt18" style="margin-bottom: 20px; line-height: 24px;; text-align: justify;">
                                   Affinity Photo มีไลบรารีการปรับเลเยอร์ เอฟเฟ็กต์เลเยอร์ และไลฟ์ฟิลเตอร์เลเยอร์ ซึ่งสามารถจัดกลุ่ม ตัด ทับ หรือปิดบังเลเยอร์เพื่อให้สามารถสร้างองค์ประกอบภาพที่ซับซ้อนได้อย่างไม่น่าเชื่อ</p>
          </div>
          <div class="span6">
              <table style="margin-top: 60px;">
                    <tr style="line-height: 30px;">
                        <td width="350px"><i class="fa fa-square" aria-hidden="true"></i>  &nbsp;&nbsp; Unlimited Layers</td>
                        <td width="350px"><i class="fa fa-square" aria-hidden="true"></i>  &nbsp;&nbsp; Live Filter Layers</td>
                    </tr>
                    <tr style="line-height: 30px;">
                        <td ><i class="fa fa-square" aria-hidden="true"></i>  &nbsp;&nbsp; Adjustment Layers</td>
                        <td ><i class="fa fa-square" aria-hidden="true"></i>  &nbsp;&nbsp; Vector Paths</td>                        
                    </tr>
                    <tr style="line-height: 30px;">
                        <td ><i class="fa fa-square" aria-hidden="true"></i>  &nbsp;&nbsp; Layer Effects</td>
                        <td ><i class="fa fa-square" aria-hidden="true"></i>  &nbsp;&nbsp; Mask Layers</td>
                    </tr>
                    <tr style="line-height: 30px;">
                        <td ><i class="fa fa-square" aria-hidden="true"></i>  &nbsp;&nbsp; Blend Modes</td>
                        <td ><i class="fa fa-square" aria-hidden="true"></i>  &nbsp;&nbsp; Layer Groups</td>
                    </tr> 
                    <tr style="line-height: 30px;"> 
                        <td ><i class="fa fa-square" aria-hidden="true"></i>  &nbsp;&nbsp; Text Tools</td>                        
                    </tr>                                         
                </table>
          </div>
     </div> 
     <div class="row">
          <div class="span12" style="text-align: center; width: 100%;">
               <img class="lazy"  data-src="/templates/netwaybysidepad/images/breathtaking-compositions-min.jpg"  /> 
          </div>
     </div>
     
  </div>
</div>
<div class="bg-content lazy" data-src="/templates/netwaybysidepad/images/img-affinityphoto-import-export-min.jpg">
  <div class="container">
      <div class="row"  style="margin-top: 50px; margin-bottom: 50px;">
          <div class="span6">
               &nbsp;&nbsp;
          </div>
          <div class="span6 overlay-content" > 
                 <p class="h3-title-content g-txt32 re-topic">PSD import/export</p>
                 <hr width="30%"/>
                 <p class="g-txt18" style="margin-bottom: 20px; line-height: 24px;; text-align: justify;">
                                นำเข้าและแก้ไขไฟล์ Photoshop โดยตรงอีกทั้งยังสามารถรักษาการปรับแต่งเอฟเฟ็กต์ และเลเยอร์ให้คงอยู่สภาพเดิมได้ รองรับไฟล์ PSB ขนาดใหญ่รวมถึงปลั๊กอิน Photoshop และไฟล์แปรง ABR</p>
          </div>
     </div> 
  </div>
</div>
 <div class="container">
      <div class="row"  style="margin-top: 50px; margin-bottom: 50px;">
          <div class="span6" style="padding: 30px 0 0 0;"> 
                 <p class="h3-title-content g-txt32 re-topic">การประมวลผลแบบกลุ่ม</p>
                 <hr width="30%"/>
                 <p class="g-txt18" style="margin-bottom: 20px;  line-height: 24px; text-align: justify;">
                                       พัฒนาไฟล์ RAW ของกล้องด้วยพื้นที่แก้ไขไฟล์ RAW โดยเฉพาะพร้อมกับเครื่องมือแก้ไข และการปรับแต่งที่แม่นยำ
                 </p>
          </div>
          <div class="span6">
                <img class="lazy"  data-src="/templates/netwaybysidepad/images/img-affinityphoto-batch-processing-min.jpg"  /> 
          </div>
      </div>
     <hr/>
     <div class="row"  style="margin-top: 50px; margin-bottom: 50px;">
          <div class="span6">
                <img class="lazy"  data-src="/templates/netwaybysidepad/images/img-affinityphoto-liquify-min.jpg"  /> 
          </div>     
          <div class="span6" style="padding: 30px 0 0 0;"> 
                 <p class="h3-title-content g-txt32 re-topic">ความสามารถในการ Liquify</p>
                 <hr width="30%"/>
                 <p class="g-txt18" style="margin-bottom: 20px;  line-height: 24px; text-align: justify;">
                                 เครื่องมือที่จะทำให้คุณสามารถบีบ หรือดึงรูปภาพของคุณได้เพียงแค่คลิกและลากเมาส์ ด้วยเทคโนโลยีที่ชาญฉลาดที่จะปรับเปลี่ยนรูปภาพของคุณให้ต่างไปจากเดิม
                 </p>                
                 <table>
                    <tr style="line-height: 30px;">
                        <td width="300px"><i class="fa fa-square" aria-hidden="true"></i>  &nbsp;&nbsp; Push</td>
                        <td width="300px"><i class="fa fa-square" aria-hidden="true"></i>  &nbsp;&nbsp; Twirl</td>
                    </tr>
                    <tr style="line-height: 30px;">
                        <td width="300px"><i class="fa fa-square" aria-hidden="true"></i>  &nbsp;&nbsp; Pinch</td>
                        <td width="300px"><i class="fa fa-square" aria-hidden="true"></i>  &nbsp;&nbsp; Punch</td>
                    </tr> 
                    <tr style="line-height: 30px;">
                        <td width="300px"><i class="fa fa-square" aria-hidden="true"></i>  &nbsp;&nbsp; Turbulence</td>
                        <td width="300px"><i class="fa fa-square" aria-hidden="true"></i>  &nbsp;&nbsp; Freeze</td>
                    </tr>
                    <tr style="line-height: 30px;">
                        <td width="300px"><i class="fa fa-square" aria-hidden="true"></i>  &nbsp;&nbsp; Thaw</td>
                        <td width="300px">&nbsp;&nbsp; </td>
                    </tr>                                                                                  
                </table>
          </div>

      </div>
 </div>
  <div  class="lazy" data-src="/templates/netwaybysidepad/images/img-affinityphoto-real-time-effects-bg.jpg">
  <div class="container">
      <div class="row"  style="margin-top: 50px; margin-bottom: 50px;">
          <div class="span12" style="width: 100%; text-align: center;" > 
                 <p class="h3-title-content g-txt32 re-topic">เอฟเฟกต์เรียลไทม์ที่น่าตื่นตา</p>
                 <center><hr width="30%"/></center>
                 <p class="g-txt18" style="margin-bottom: 20px; line-height: 24px;; text-align: justify;">
                                  Affinity Photo มาพร้อมกับฟิลเตอร์ระดับไฮเอนด์ที่สามารถปรับแต่งได้อย่างหลากหลายรวมถึงการเติมแสง ทำเบลอ เพิ่มเงา และเรืองแสง แต่สิ่งที่ Affinity Photo ทำให้แตกต่างออกไปก็คือเมื่อคุณปรับคุณสมบัติของฟิลเตอร์คุณจะสามารถเห็นผลลัพธ์ได้แบบเรียลไทม์</p>
          </div>
     </div> 
     <div class="row">
          <div class="span12" style="text-align: center; width: 100%;">
               <img class="lazy"  data-src="/templates/netwaybysidepad/images/img-affinityphoto-real-time-effects.png"  /> 
          </div>
     </div>
     
  </div>
</div>
{literal}
<!-- Add fancyBox main JS and CSS files -->
    <script type="text/javascript" src="/js/fancybox/jquery.fancybox.js"></script>
    <link rel="stylesheet" type="text/css" href="/js/fancybox/jquery.fancybox.css" media="screen" />

    <!-- Add Media helper (this is optional) -->
    <script type="text/javascript" src="/js/fancybox/source/helpers/jquery.fancybox-media.js?v=1.0.6"></script>
    <script type="text/javascript">
        $(document).ready(function() {
            
            /*
             *  Media helper. Group items, disable animations, hide arrows, enable media and button helpers.
            */
            $('.fancybox-media')
                .attr('rel', 'media-gallery')
                .fancybox({
                    openEffect : 'none',
                    closeEffect : 'none',
                    prevEffect : 'none',
                    nextEffect : 'none',

                    arrows : false,
                    helpers : {
                        media : {},
                        buttons : {}
                    }
                });
        });
    </script> 
{/literal}