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
       .bg-logo-customer {
              background-size: 122px 42px;
              height: 40x;
              width: 120px;
              margin-left: -8px;
              display: inline-block;  
       }
       .logo-customer   {
       
			 -webkit-filter: grayscale(100%);
			  filter: grayscale(100%);
		  
		}
	    .logo-customer:hover {
       
             -webkit-filter: grayscale(0%);
              filter: grayscale(0%);
          
        }
        
       /*Start Responsive */
       @media (min-width: 1281px) {
           .bg {
                
               background-position: top center;
               text-align: center;
               background-repeat: no-repeat;
               background-size: cover;
               background-position: center;
               height: 520px;
               width: 100%;
          }
          .txt-hero-banner  { 
             color: #001ea7; 
             text-align: left; 
             font-size: 45px;  
             line-height: 50px;  
             font-weight: 800; 
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
          .txt-hero-banner  { 
             color: #001ea7; 
             font-size: 28px;  
             line-height: 50px;  
             font-weight: 800; 
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

          .txt-hero-banner  { 
             color: #001ea7; 
             font-size: 28px;  
             line-height: 50px;  
             font-weight: 800; 
          } 
    
      }
       /*End Responsive */
      /*** End SharePoint ***/ 
      
</style>
{/literal}
    <!--Desktop  -->
        <div class="bg hidden-phone lazy-hero"  data-src="/templates/netwaybysidepad/images/Siaminterhost-new-bg-min.png">
           <div class="container">
            <div class="row"  >
                    
                   <div class="span12 " style="text-align:center; font-family: 'Prompt', sans-serif;">
                     <div style="width : 100%; float:left;">
                          <div class="padding-banner" style="margin-top: 50px; text-align: justify; ">                     
                            <p class="txt-hero-banner " >Siaminterhost</p>
                            <span class="nw-2018-content-line"></span>
                            <p class="g-txt22" style="margin-top: 20px;"> ผู้ให้บริการ Internet Solutions และ  E-Commerce ครบวงจรชั้นนำของไทย  </p>
                            
                            <a href="https://netway.co.th/siaminterhost#products" ><button class="btn-banner-cloud" type="submit">สนใจคลิก<i class="fa fa-chevron-right" aria-hidden="true"></i></button></a>   
                           
                          </div>  
                      </div> 
                   </div>
     
            </div>
         </div>
      </div>
    <!-- End Desktop  -->
    <!-- Mobile -->
    <div class="bg visible-phone lazy-hero"  data-src="/templates/netwaybysidepad/images/Siaminterhost-new-bg-min.png">
           <div class="container">
            <div class="row"  >
                    
                    <div class="span12 " style="text-align:center; font-family: 'Prompt', sans-serif;">
                          <div class="padding-banner" style="margin-top: 50px;  text-align: center; ">                     
                            <p class="txt-hero-banner " >Siaminterhost</p>
                            <span class="nw-2018-content-line"></span>
                            <p class="g-txt22" style="margin-top: 10px;"> ผู้ให้บริการ Internet Solutions และ  E-Commerce ครบวงจรชั้นนำของไทย  </p>
                            
                            <a href="https://netway.co.th/siaminterhost#products" ><button class="btn-banner-cloud" type="submit">สนใจคลิก<i class="fa fa-chevron-right" aria-hidden="true"></i></button></a>   
                           
                          </div>  
                   </div>
      
            </div>
         </div>
    </div>
    <!-- End mobile -->
    
    <div class="row-fluid" style="background-color: #fff;  padding: 50px 20px 50px 20px;" > 
      <div class="container" >      
           <div class="row">
               <div class="span12 dynamic-content">
                <center>
                    <img class="lazy-hero"  data-src="/templates/netwaybysidepad/images/logo-siaminterhost-min.png" alt="Siaminterhost">  <img class="lazy-hero"  data-src="/templates/netwaybysidepad/images/netway-20th-min.png"  alt="Netway"   width="145px;"  style="margin-left: 30px;"/>
                 

                    <p class="g-txt18 " style="margin-bottom: 20px; line-height: normal;  text-align: center; padding: 20px  20px 20px 20px;">เร็วๆ นี้ Siaminterhost.com ได้ย้ายมาภายใต้ URL netway.co.th/siaminterhost ยังคงให้บริการ Internet Solution และ E-Commerce Solution ครบวงจรเช่นเดิม พร้อมให้คำปรึกษาตลอด 24 ชม. </p>
                                           
                </center>
                </div>
           </div>
     </div>
</div>
           


 <div class="row-fluid" style="padding: 50px 20px 50px 20px;  background-color: #f4f5f6;" > 
      <div class="container" >  
           <div class="row-fluid" id="products" >
                <div class="span12" style="margin-top: -10px;" >
                    <center>
                    <h3 class="h3-titel-content g-txt32">Our Products </h3>
                    <span class="nw-2018-content-line"></span>
                    <p class="g-txt18" style="margin-top: 20px; margin-bottom: 0px;">&nbsp;&nbsp;&nbsp;&nbsp;</p>
                    </center>
                </div>
            </div>    
            
           <div class="row-fluid">
          
	            <div class="span2 hover-icon   "  >
	                <a href="https://netway.co.th/linux-hosting" style="text-decoration: none;" target="_blank">
	               <img class="lazy"  data-src="/templates/netwaybysidepad/images/icon-linux-hosting-min.png" width="100px" alt="Linux hosting">  
	               <p class="g-txt18"  >Linux Hosting </p>
	               </a>
	            </div>
	            
	            <div class="span2 hover-icon   "  >
	                 <a href="https://netway.co.th/windows-hosting" style="text-decoration: none;" target="_blank">
	               <img class="lazy"  data-src="/templates/netwaybysidepad/images/icon-linux-windows-min.png"  width="100px" alt="Windows hosting">  
	               <p class="g-txt18"  >Windows Hosting </p>
	               </a>
	            </div>
	            
	            <div class="span2 hover-icon   "  >
	                 <a href="https://netway.co.th/domain-order" style="text-decoration: none;" target="_blank">
	               <img class="lazy"  data-src="/templates/netwaybysidepad/images/icon-siaminterhost-domain-min.png" width="100px" alt="Domain"> 
	               <p class="g-txt18"  >Domain </p>
	               </a>
	            </div>
	            
	            <div class="span2 hover-icon   "  >
	               <a href="https://netwaystore.in.th/webhosting-software/" style="text-decoration: none;" target="_blank">
	               <img class="lazy"  data-src="/templates/netwaybysidepad/images/icon-siaminterhost-cpanel-min.png" width="100px" alt="cPanel License"> 
	               <p class="g-txt18"  >cPanel License </p>
	               </a>
	            </div>
	            
	            <div class="span2 hover-icon   "  >
	               <a href="https://ssl.in.th" style="text-decoration: none;" target="_blank">
	               <img class="lazy"  data-src="/templates/netwaybysidepad/images/icon-siaminterhost-ssl-min.png" width="100px" alt="SSL"> 
	               <p class="g-txt18"  >SSL </p>
	               </a>
	            </div>
	            
	            <div class="span2 hover-icon   "  >
	               <a href="https://netway.co.th/cloud" style="text-decoration: none;" target="_blank">
	               <img class="lazy"  data-src="/templates/netwaybysidepad/images/icon-siaminterhost-vps-min.png" width="100px" alt="Cloud VPS - Dedicated"> 
	               <p class="g-txt18" style=" font-size: 15px;"  >Cloud VPS - Dedicated </p>
	               </a>
	            </div>
         
        </div>       
        
        <div class="row-fluid">
          
                <div class="span2 hover-icon   "  >
                     <a href="https://netway.co.th/email" style="text-decoration: none;" target="_blank">
                   <img class="lazy"  data-src="/templates/netwaybysidepad/images/icon-siaminterhost-email-min.png" width="100px" alt="Email">  
                   <p class="g-txt18"  > Email </p>
                   </a>
                </div>
                
                <div class="span2 hover-icon   "  >
                     <a href="https://netway.co.th/gsuite" style="text-decoration: none;" target="_blank">
                   <img class="lazy"  data-src="/templates/netwaybysidepad/images/icon-siaminterhost-google-min.png"  width="100px" alt="G Suite">  
                   <p class="g-txt18"  > G Suite </p>
                   </a>
                </div>
                
                <div class="span2 hover-icon   "  >
                   <a href="https://netway.co.th/office365" style="text-decoration: none;" target="_blank">
                   <img class="lazy"  data-src="/templates/netwaybysidepad/images/icon-siaminterhost-office-min.png" width="100px" alt="Office"> 
                   <p class="g-txt18"  > Office </p>
                   </a>
                </div>
                
                <div class="span2 hover-icon   "  >
                   <a href="https://netway.co.th/microsoft" style="text-decoration: none;" target="_blank">
                   <img class="lazy"  data-src="/templates/netwaybysidepad/images/icon-siaminterhost-microsoft-min.png" width="100px" alt="Microsoft"> 
                   <p class="g-txt18"  >Microsoft </p>
                   </a>
                </div>
                
                <div class="span2 hover-icon   "  >
                   <a href="https://netway.co.th/zendesk" style="text-decoration: none;" target="_blank">
                   <img class="lazy"  data-src="/templates/netwaybysidepad/images/icon-siaminterhost-zendesk-min.png" width="100px" alt="Zendesk"> 
                   <p class="g-txt18"  >Zendesk </p>
                   </a>
                </div>
                
                <div class="span2 hover-icon   "  >
                   <a href="https://netway.site" style="text-decoration: none;" target="_blank">
                   <img class="lazy"  data-src="/templates/netwaybysidepad/images/icon-siaminterhost-netwaysite-min.png" width="100px" alt="Netway.site"> 
                   <p class="g-txt18" >Netway.site</p>
                   </a>
                </div>

        </div>       
    </div>
</div> 

    <div class="row-fluid" style="background-color: #fff;  padding: 50px 20px 50px 20px;" > 
      <div class="container" >      
           <div class="row">
                <div class="span12" style="margin-top: -10px;" >
                    <center>
                    <h3 class="h3-titel-content g-txt32">Our Customers </h3>
                    <span class="nw-2018-content-line"></span>
                    <p class="g-txt18" style="margin-top: 20px; margin-bottom: 0px;">&nbsp;&nbsp;&nbsp;&nbsp;</p>
                    </center>
                </div>
           </div>
           
           <div class="row">
                <div class="span2 logo-customer">      
               
                    <img class="lazy "  data-src="/templates/netwaybysidepad/images/financial_01-min.jpg" /> 
                   
                </div>
                
                <div class="span2 logo-customer">       
                     <img class="lazy "  data-src="/templates/netwaybysidepad/images/financial_02-min.jpg" /> 
                     <span class="gs-tooltiptext hidden-phone" style="left: 0px"> </span>
                </div>
                     
                <div class="span2 logo-customer">       
                     <img class="lazy "  data-src="/templates/netwaybysidepad/images/financial_03-min.jpg" /> 
                     <span class="gs-tooltiptext hidden-phone" style="left: 0px"></span>
                </div>
                
                <div class="span2 logo-customer">       
                     <img class="lazy "  data-src="/templates/netwaybysidepad/images/financial_04-min.jpg" /> 
                </div>
                
                <div class="span2 logo-customer">       
                     <img class="lazy "  data-src="/templates/netwaybysidepad/images/financial_05-min.jpg" /> 
                </div>
                
                <div class="span2 logo-customer" >       
                     <img class="lazy "  data-src="/templates/netwaybysidepad/images/financial_07-min.jpg"/> 
                </div>
           </div>
           
          <div class="row" style="margin-top: 25px; margin-bottom: 25px;">
                
                <div class="span2 logo-customer">       
                     <img class="lazy "  data-src="/templates/netwaybysidepad/images/financial_08-min.jpg" /> 
                     <span class="gs-tooltiptext hidden-phone" style="left: 0px"> </span>
                </div>
                
                <div class="span2 logo-customer">      
                     <img class="lazy "  data-src="/templates/netwaybysidepad/images/financial_06-min.jpg" /> 
                </div>
                     
                <div class="span2 logo-customer" >       
                     <img class="lazy "  data-src="/templates/netwaybysidepad/images/financial_09-min.jpg" /> 
                </div>
                
                <div class="span2 logo-customer" >       
                     <img class="lazy "  data-src="/templates/netwaybysidepad/images/financial_10-min.jpg" /> 
                </div>
                
                <div class="span2 logo-customer" >       
                     <img class="lazy "  data-src="/templates/netwaybysidepad/images/financial_11-min.jpg" /> 
                </div>
                
                <div class="span2 logo-customer">       
                     <img class="lazy "  data-src="/templates/netwaybysidepad/images/financial_12-min.jpg"/> 
                </div>
           </div>
           
           <div class="row" style="margin-top: 25px; margin-bottom: 25px;">
           
                <div class="span2 logo-customer">      
                     <img class="lazy "  data-src="/templates/netwaybysidepad/images/company_03-min.jpg" /> 
                </div>
                               
                <div class="span2 logo-customer">       
                     <img class="lazy "  data-src="/templates/netwaybysidepad/images/company_02-min.jpg" /> 
                     <span class="gs-tooltiptext hidden-phone" style="left: 0px"> </span>
                </div>
                  
                <div class="span2 logo-customer" >       
                     <img class="lazy "  data-src="/templates/netwaybysidepad/images/company_04-min.jpg" /> 
                </div>
                
                <div class="span2 logo-customer" >       
                     <img class="lazy "  data-src="/templates/netwaybysidepad/images/company_05-min.jpg" /> 
                </div>
                
                <div class="span2 logo-customer">       
                     <img class="lazy "  data-src="/templates/netwaybysidepad/images/company_07-min.jpg"  style="margin-top: -5px;" /> 
                </div>
                
                <div class="span2 logo-customer">       
                     <img class="lazy "  data-src="/templates/netwaybysidepad/images/company_12-min.jpg"   style="margin-top: 15px;" /> 
                </div>
           </div>
           
           <div class="row" style="margin-top: 25px; margin-bottom: 25px;">
           
                <div class="span2 logo-customer" >      
                     <img class="lazy "  data-src="/templates/netwaybysidepad/images/company_01-min.jpg" /> 
                </div>
                               
                <div class="span2 logo-customer">       
                     <img class="lazy "  data-src="/templates/netwaybysidepad/images/company_08-min.jpg" /> 
                     <span class="gs-tooltiptext hidden-phone" style="left: 0px"> </span>
                </div>
                  
                <div class="span2 logo-customer" >       
                     <img class="lazy "  data-src="/templates/netwaybysidepad/images/company_09-min.jpg" /> 
                </div>
                
                <div class="span2 logo-customer" >       
                     <img class="lazy "  data-src="/templates/netwaybysidepad/images/company_10-min.jpg" /> 
                </div>
                
                <div class="span2 logo-customer">       
                     <img class="lazy "  data-src="/templates/netwaybysidepad/images/company_11-min.jpg"  style="margin-top: 7px;" /> 
                </div>
                
                <div class="span2 logo-customer" >       
                     <img class="lazy "  data-src="/templates/netwaybysidepad/images/company_06-min.jpg"  /> 
                </div>
           </div>
           
           <div class="row" style="margin-top: 25px; margin-bottom: 25px;">
           
                <div class="span2 logo-customer" >      
                     <img class="lazy "  data-src="/templates/netwaybysidepad/images/government_06-min.jpg" /> 
                </div>
                               
                <div class="span2 logo-customer" >       
                     <img class="lazy "  data-src="/templates/netwaybysidepad/images/government_01-min.jpg" /> 
                     <span class="gs-tooltiptext hidden-phone" style="left: 0px"> </span>
                </div>

                <div class="span2 logo-customer" >       
                     <img class="lazy "  data-src="/templates/netwaybysidepad/images/government_02-min.jpg" /> 
                     <span class="gs-tooltiptext hidden-phone" style="left: 0px"> </span>
                </div>
                
                <div class="span2 logo-customer" >       
                     <img class="lazy "  data-src="/templates/netwaybysidepad/images/government_04-min.jpg" /> 
                     <span class="gs-tooltiptext hidden-phone" style="left: 0px"> </span>
                </div>                  

                <div class="span2 logo-customer" >       
                     <img class="lazy "  data-src="/templates/netwaybysidepad/images/government_05-min.jpg" /> 
                     <span class="gs-tooltiptext hidden-phone" style="left: 0px"> </span>
                </div>
                
                <div class="span2 logo-customer" >       
                     <img class="lazy "  data-src="/templates/netwaybysidepad/images/government_03-min.jpg" /> 
                     <span class="gs-tooltiptext hidden-phone" style="left: 0px"> </span>
                </div>                
           </div>
           
                      
           <div class="row" style="margin-top: 25px; margin-bottom: 25px;">
           
                <div class="span2 logo-customer" >      
                     <img class="lazy "  data-src="/templates/netwaybysidepad/images/educational_01-min.jpg" /> 
                </div>
                               
                <div class="span2 logo-customer">       
                     <img class="lazy "  data-src="/templates/netwaybysidepad/images/educational_02-min.jpg" /> 
                     <span class="gs-tooltiptext hidden-phone" style="left: 0px"> </span>
                </div>

                <div class="span2 logo-customer" >       
                     <img class="lazy "  data-src="/templates/netwaybysidepad/images/educational_03-min.jpg" /> 
                     <span class="gs-tooltiptext hidden-phone" style="left: 0px"> </span>
                </div>
                
                <div class="span2 logo-customer" >       
                     <img class="lazy "  data-src="/templates/netwaybysidepad/images/educational_04-min.jpg" /> 
                     <span class="gs-tooltiptext hidden-phone" style="left: 0px"> </span>
                </div>                  

                <div class="span2 logo-customer">       
                     <img class="lazy "  data-src="/templates/netwaybysidepad/images/educational_05-min.jpg" /> 
                     <span class="gs-tooltiptext hidden-phone" style="left: 0px"> </span>
                </div>
                
                <div class="span2 logo-customer" >       
                     <img class="lazy "  data-src="/templates/netwaybysidepad/images/educational_06-min.jpg" /> 
                     <span class="gs-tooltiptext hidden-phone" style="left: 0px"> </span>
                </div>                
           </div>
           
     </div>
</div>
