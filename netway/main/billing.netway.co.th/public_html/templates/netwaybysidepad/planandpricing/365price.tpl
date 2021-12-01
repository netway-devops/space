<script>
$(document).ready(function(){
    $('a[data-toggle="tab"]').click(function(event) {
        $('a[data-toggle="tab"]').removeClass('active');
        $(this).addClass('active');
    });
    $('a[data-toggle="tab"]').removeClass('active'); 
    $('.cat'+'{current_cat}').click(); 
    $('.cat'+'{current_cat}').addClass('active');
});
</script>
<style>
    

    section.hero {
                /*background-color: orange;*/
                background-position: top center;
                background-repeat: no-repeat;
                text-align: center;
                width: 100%;
                background:url('https://netway.co.th/templates/netwaybysidepad/images/bg-main-office365-min.png');
                background-repeat: no-repeat;
                background-size: cover;
                background-attachment: fixed;
                background-position: center;
                
    
            } 
       .vdo {
               
                background-color: #01aff1;
                background-position: top center;
                background-repeat: no-repeat;
                text-align: center;
                width: 100%;
                /*background: url('https://netway.co.th/templates/netwaybysidepad/images/bg-dynamicvdo-min.png');*/
                background-repeat: no-repeat;
                background-size: cover;
                background-attachment: fixed;
                background-position: center;
                
    
            }   
            
       .nw-product-title{
               text-align: center;
       } 
       .features {
            
            top: 0px;
            border: 1px solid rgb(0, 82, 250);
            padding: 20px 20px 20px 20px;
            margin-top: 30px;
         }
       .dep {
        
             height: 250px;
             top: 0px;
             border: 1px solid #0b4ab3;
             padding: 30px 10px 30px 10px;
             margin-bottom: 70px;
             margin-top: 20px;
             background: #fff;
         
       }
         .dep:hover {
        
             height: 250px;
             top: 0px;
             border: 2px solid #0b4ab3;
             padding: 30px 10px 30px 10px;
             margin-bottom: 70px;
             margin-top: 20px;
             background: #fff;
         
       }
        .features:hover {
     
            top: 0px;
            border: 2px solid #0078D7;
            padding: 20px 20px 20px 20px;
            margin-top: 30px;
         }

         .licen-topic{
            color: #0052cd; 
            font-weight: 300; 
            font-family: 'Prompt', sans-serif;
        }      
            
        .re-txt-banner {
            font-size: 32px;
            font-family: 'Prompt', sans-serif; 
            font-style: normal;
            font-weight: 500;
            color: #fff;
            margin-top: 10px;
            text-shadow: 2px 2px 4px #212127;

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
       
    body{
        overflow:-moz-scrollbars-vertical;
        overflow-x: hidden;
        overflow-y: scroll;
    }
    ul.f {
      list-style: none;
      padding: 0;
      margin-top: 20px;
    }
    ul.f  > li {
      font-size: 15px;
      margin-top: 5px;
     
    }
    ul.f > li:before {
      content: "\f00c"; /* FontAwesome Unicode */
      font-family: FontAwesome;
      display: inline-block;
      margin-left: -1.3em; /* same as padding-left set on li */
      width: 1.3em; /* same as padding-left set on li */
      color: #ccc;
    }
    
    p.nw-product-title {
        font-style: normal;
        font-weight: 500;
        color: #002050;
        font-size: 16px;
        font-family: 'Prompt', sans-serif;
    }
    .title {
       
        font-style: normal;
        font-weight: 500;
        color: #0052cc;
        height: auto;
        display: block;
        text-align: center;
        padding-top: 25px;
        
    }
    
    .logo {
    background-position: center;
    background-image: url('https://netway.co.th/templates/netwaybysidepad/images/hexagon-min.png');

    background-repeat: no-repeat;
    height: 66px;
    width: 77px;
    text-align: center;
    position: relative;
    margin-bottom: 40px;
    margin-top: -63px;
    }
    
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
    background: #fff;
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
.plan {
   background-color: transparent;
   color: #2F36CF;  
   margin: 50px 0% 50px 0%;
   border-radius: 3px;
   border: 1px solid #fff;
   display: inline-block;
   font-style: normal;
   font-size: 18px;
   padding: 15px 20px;
   text-decoration: none;
   margin-top: 34px;    
   
}
.plan:hover {
   background-color: transparent;
   color: #FF5744;  
   margin: 50px 0% 50px 0%;
   border-radius: 3px;
   border: 1px solid #fff;
   display: inline-block;
   font-style: normal;
   font-size: 18px;
   padding: 15px 20px;
   text-decoration: none;
   margin-top: 34px;    
   
}
.nav li.x {
   color: #717171;
}
.nav li.x.active a {
   color: #0052cd;
   background: #f8f8f8;
}

a > button.pricing { 
    padding: 20px 20px 20px 20px;
    margin-right: 10px;
    background-color: #F5F5F5;
    color: #555;
    border: 2px solid #AEAEAE;
    font-size: 22px;
    font-weight: 100;

}

 
button.pricing:active  ,button.pricing:hover ,button.pricing:focus {
    padding: 20px 20px 20px 20px;
    margin-right: 10px;
    background-color: #737373;
    color: #FFF;
    border: 2px solid #737373;
    font-size: 22px;
    font-weight: 100;
}

.detail_plan{
     padding: 20px 10px 20px 10px;
}
/*End Departmental Modules */

.txt-price-top  {
    font-size: 34px;
    line-height: normal;
    font-weight: bold;
    color: #ff562f;
    margin-bottom: 30px;
    
}

.txt-price-small  {
    font-size: 22px;
    line-height: normal;
    font-weight: inherit;
    color: #333;
    
}
.txt-price-detill {
    font-size: 15px;
    font-weight: 300;
    color: #0060ac;
}
.txt-titel-pro {
    font-size: 15px;
    font-weight: 700;
    color: #d83b01;
}
.txt-namepro {
    font-size: 12px;
}
.btn-buy {
    color: #fff;
    padding: .55em 1.5em;
    background-color: #0f5bda;
    border-color: #0f5bda;
    transition: background-color .5s;
    border: 1px solid;
    font-size: 18px;
    width: 180px;
}
.btn-buy:hover {
    color: #fff;
    padding: .55em 1.5em;
    background-color: #448aff;
    border-color: #448aff;
    transition: background-color .5s;
    border: 1px solid;
    font-size: 18px;
    width: 180px;
}
.btn-try {
    color: #fff;
    padding: .55em 1.5em;
    background-color: #999;
    border-color: #999;
    transition: background-color .5s;
    border: 1px solid;
    font-size: 18px;
    width: 180px;

}
.btn-try:hover {
    color: #fff;
    padding: .55em 1.5em;
    background-color: #737373;
    border-color: #737373;
    transition: background-color .5s;
    border: 1px solid;
    font-size: 18px;
    width: 180px;

}
.i-product{
        float: left;

}
.img-icon {
    background-size : 48px 48px;
    height: 48px;
    width:  48px;
    margin-bottom: -10px;

}

.bg-Access  {
    background-image : url('https://netway.co.th/templates/netwaybysidepad/images/Office365-Access-home-min.png');
}
.bg-Access-BS  {
    background-image : url('https://netway.co.th/templates/netwaybysidepad/images/Office365-Access-business-min.png');
}
.bg-Excel {
    background-image : url('https://netway.co.th/templates/netwaybysidepad/images/Office365-Excel-min.png');
}
.bg-Exchange  {
    background-image : url('https://netway.co.th/templates/netwaybysidepad/images/Office365-Exchange-min.png');
}
.bg-OneDrive  {
    background-image : url('https://netway.co.th/templates/netwaybysidepad/images/Office365-OneDrive-min.png');
}
.bg-OneNote {
    background-image : url('https://netway.co.th/templates/netwaybysidepad/images/Office365-OneNote-min.png');
}
.bg-Outlook {
    background-image : url('https://netway.co.th/templates/netwaybysidepad/images/Office365-Outlook-min.png');
}
.bg-Publisher {
    background-image : url('https://netway.co.th/templates/netwaybysidepad/images/Office365-Publisher-min.png');
}
.bg-PowerPoint {
    background-image : url('https://netway.co.th/templates/netwaybysidepad/images/Office365-PowerPoint-min.png');
}
.bg-SharePoint   {
    background-image : url('https://netway.co.th/templates/netwaybysidepad/images/Office365-SharePoint-min.png');
}
.bg-Skype  {
    background-image : url('https://netway.co.th/templates/netwaybysidepad/images/Office365-Sky.png');
}
.bg-Skype-BS  {
    background-image : url('https://netway.co.th/templates/netwaybysidepad/images/Office365-Sky-for-Business.png');
}
.bg-Teams   {
    background-image : url('https://netway.co.th/templates/netwaybysidepad/images/Office365-Teams-min.png');
}
.bg-Word {
    background-image : url('https://netway.co.th/templates/netwaybysidepad/images/Office365-Wold-min.png');
}
.row-gray  {
    background-color: #f2f2f2; 
}
.row-white  {
    background-color: #fff;     
}
.padding-row-plan {
    padding: 30px 20px 30px 20px;
}
.padding-row-plan > .fa-check {

    font-size: 22px;
    color: #107C10;
    font-weight: 100;
    margin-top: 10px;

}     
.padding-row-plan > p {
   margin-top: 10px;
}
.gs-tooltiptext{
   background: #fff;
   left: 80px;
}
.gs-tooltip {
   color: #ooo !important;
}
select.plan-office365 {
    margin-top: 20px;
    margin-bottom: 20px;
    font-size: 20px;
    height: 45px;
    color: #000;
}
div.promotion {
    background-color: #ff580d;
    padding: 10px 10px 10px 10px;
    text-align: center;
    color: #fff;
    width: 250px;  
}
.fa-info-circle{
    color: #ccc;
}
a:hover {
     text-decoration: none;
}

ul.menu-office365 {
    list-style-type: none;
    margin: 0;
    padding: 0;
    overflow: hidden;
    background-color: #f8f8f8;
}

ul.menu-office365 > li {
    float: left;
    border:2px solid #AEAEAE;
    margin-right: 5px;
    background-color: #F5F5F5;
    color: #505050;
    
    
}

ul.menu-office365 > li:last-child {
    border-right:2px solid #AEAEAE;
    background-color: #F5F5F5;
    color: #505050;
}

ul.menu-office365 > li a {
    display: block;
    color: #505050;
    text-align: center;
    padding: 14px 16px;
    text-decoration: none;
    font-size: 20px;
}

ul.menu-office365 > li a:hover:not(.active) {
    background-color: #999;
    color: #ff;
}

ul.menu-office365 > li > .active {
    background-color: #737373;
    color: #FFF;
}
.container-office365 {
  margin: 0 auto;
  padding: 40px;
  width: 80%;
  color: #333;
  background: #419be0;
}

.container-office365 > .slick-slide {
  text-align: center;
  color: #419be0;
  background: white;
}

</style>

    <div class="row-fluid"  style="background-color: #f8f8f8;"> 
      <div class="container"style="margin-top: 20px; margin-bottom: 50px;" >
        <div class="row">
               <div class="span12 dynamic-content"   >
                 <center>
                     <h3 class="h3-title-content g-txt32 re-topic" >Plan & Pricing </h3>
                        <span class="nw-2018-content-line" style="margin-bottom: 50px;"></span>
                 </center>          
                </div>
       </div>

  <!-- hidden phone -->      
  <div class="row hidden-phone">
      <div class="span12">
         <ul class="menu-office365">
      <li><a data-toggle="tab" href="#home" class="active cat36">สำหรับใช้งานที่บ้าน</a></li>
      <li><a data-toggle="tab" href="#Business" class="cat54">สำหรับธุรกิจ </a></li>
        </ul>
     </div>
  </div>
       <div class="row hidden-phone">
         <div class="span12">
  <hr style="margin: -2px 0; border-top: 5px solid #AEAEAE;">
  
  <div class="tab-content"><!-- tab-plan&pricing -->
    
    <div id="home" class="tab-pane fade in active"><!-- id Office365 for Home  -->
     <div class="row"  style="margin-top: 40px;">
         <div class="span3 " style="height: 500px;">
            <div class="detail_plan">
             <p class="g-txt16" style="color: #000;">กำลังมองหาอะไรเพิ่มเติมใช่ไหม</p>
             <br/>
             
             <p class="g-txt16">ดูตัวเลือกสำหรับ:</p>
             <p class="g-txt16 "><a href="#">นักเรียน</a> | <a href="#">Mac</a></p>
             
             <br/>
             <a href="#"><p class="g-txt16 color-blue-a">Office 365 <br/>สำหรับใช้งานที่บ้านคืออะไร</p></a>
             
            </div>
         </div>
         <div class="span3" ><!-- Office 365 Home Plan 1 -->
             <div class="plan-gs" style="height: 970px; text-align: center;">
                <p class="color-blue-s txt-price-top">฿{price.664.a}</p>
                <p style=" margin-top: -25px;    margin-bottom: 25px;">(ต่อปี)</p>
                <p class="txt-price-small">Office 365 Home</p>
                <button class="btn-buy" style="margin-top: 30px; margin-bottom: 10px;">ซื้อทันที</button>
                <button class="btn-try" style="margin-top: 10px; margin-bottom: 20px;">ทดลองใช้ฟรี</button>
                <a href="#"><p class="txt-price-detill">หรือซื้อในราคา ฿289.99 ต่อเดือน  <i class="fa fa-chevron-circle-right" aria-hidden="true"></i></p></a>
                <hr style="border-top: 2px solid #cccccc;"/>
                <p  class="g-txt16"  style="padding: 10px 0 20px 0; font-size: 15px;">เหมาะที่สุดสำหรับใช้งานในครอบครัว รวมแอปพลิถึงเคชัน Office <br/>สำหรับผู้ใช้สูงสุด 5 ราย <p>
                
                <!-- Title Product Group Office 365 Home 0 -->
                <p class="txt-titel-pro" style="text-align: left; margin-bottom: 20px;" >รวมแอปพลิเคชั่น Office </p>
                
                <!-- row 0 -->
                <div class="i-product" style="padding: 10px 33px 10px 0;">
                <div class="img-icon bg-Word"></div><!-- img -->
                <br/>
                <p class="txt-namepro">Word</p>
                </div>
                
                <div class="i-product" style="padding: 10px 33px 10px 0;">
                <div class="img-icon bg-Excel"></div><!-- img -->
                <br/>
                <p class="txt-namepro">Excel</p>
                </div>
                
                <div class="i-product" style="padding: 10px 0 10px 0;">
                <div class="img-icon bg-PowerPoint"></div><!-- img -->
                <br/>
                <p class="txt-namepro">PowerPoint</p>
                </div>
                <!-- / row 0 -->
                
                <!-- row 1 -->
                <div class="i-product" style="padding: 10px 33px 10px 0;">
                <div class="img-icon bg-OneNote"></div><!-- img -->
                <br/>
                <p class="txt-namepro">OneNote</p>
                </div>
                
                <div class="i-product" style="padding: 10px 33px 10px 0;">
                <div class="img-icon bg-Outlook"></div><!-- img -->
                <br/>
                <p class="txt-namepro">Outlook</p>
                </div>
                
                <div class="i-product" style="padding: 10px 0 10px 0;">
                <div class="img-icon bg-Publisher"></div><!-- img -->
                <br/>
                <p class="txt-namepro" style="width: 60px;">Publisher (พีซีเท่านั้น)</p>
                </div>
                <!-- / row 1 -->
                
                <!-- row 2 -->
                <div class="i-product" style="padding: 10px 20px 10px 0;">
                <div class="img-icon bg-Access"></div><!-- img -->
                <br/>
                <p class="txt-namepro" style="width: 60px;">Acesss (พีซีเท่านั้น)</p>
                </div>
                
                <div class="i-product" style="padding: 10px 20px 10px 0;">
                <div class="img-icon"></div><!-- img -->
                <br/>
                <p class="txt-namepro">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
                </div>
                
                <div class="" style="padding: 10px  20px 10px 0;">
                <div class="img-icon "></div><!-- img -->
                <br/>
                <p class="txt-namepro">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
                </div>
                <!-- / row 2 -->
                
                
                
                 <!-- Title Product Group Office 365 Home 1 -->
                <br/><br/><br/>
                <p class="txt-titel-pro" style="text-align: left; margin-top: 50px;">รวมบริการ </p>
                
                <!-- row 3 -->
                <div class="i-product" style="padding: 10px 33px 10px 0;">
                <div class="img-icon bg-OneDrive"></div><!-- img -->
                <br/>
                <p class="txt-namepro" >OneDrive</p>
                </div>
                
                <div class="i-product" style="padding: 10px 33px 10px 0;">
                <div class="img-icon bg-Skype"></div><!-- img -->
                <br/>
                <p class="txt-namepro  ">Skype</p>
                </div>
                
                <div class="i-product" style="padding: 10px 0 10px 0;">
                <div class="img-icon "></div><!-- img -->
                <br/>
                <p class="txt-namepro">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </p>
                </div>
                <!-- / row 3 -->
                
                </div>
         </div>
        
  
        <div class="span3" ><!-- Office 365 Home Plan 2 -->
             <div class="plan-gs" style="height: 970px; text-align: center;">
                <p class="color-blue-s txt-price-top">฿{price.749.a} </p>
                <p style=" margin-top: -25px;    margin-bottom: 25px;">(ต่อปี)</p>
                <p class="txt-price-small">Office 365 Persopnal</p>
                <button class="btn-buy" style="margin-top: 30px; margin-bottom: 81px;">ซื้อทันที</button>
         
                <a href="#"><p class="txt-price-detill">หรือซื้อในราคา ฿209.99 ต่อเดือน  <i class="fa fa-chevron-circle-right" aria-hidden="true"></i></p></a>
                <hr style="border-top: 2px solid #cccccc;"/>
                <p  class="g-txt16"  style="padding: 10px 0 20px 0; font-size: 15px;">เหมาะที่สุดสำหรับใช้งานคนเดียว รวมถึงแอปพลิเคชัน Office <br/>สำหรับผู้ใช้ 1 ราย <p>
                
                <!-- Title Product Group Office 365 Home 0 -->
                <p class="txt-titel-pro" style="text-align: left; margin-bottom: 20px;" >รวมแอปพลิเคชั่น Office </p>
                
                <!-- row 0 -->
                <div class="i-product" style="padding: 10px 33px 10px 0;">
                <div class="img-icon bg-Word"></div><!-- img -->
                <br/>
                <p class="txt-namepro">Word</p>
                </div>
                
                <div class="i-product" style="padding: 10px 33px 10px 0;">
                <div class="img-icon bg-Excel"></div><!-- img -->
                <br/>
                <p class="txt-namepro">Excel</p>
                </div>
                
                <div class="i-product" style="padding: 10px 0 10px 0;">
                <div class="img-icon bg-PowerPoint"></div><!-- img -->
                <br/>
                <p class="txt-namepro">PowerPoint</p>
                </div>
                <!-- / row 0 -->
                
                <!-- row 1 -->
                <div class="i-product" style="padding: 10px 33px 10px 0;">
                <div class="img-icon bg-OneNote"></div><!-- img -->
                <br/>
                <p class="txt-namepro">OneNote</p>
                </div>
                
                <div class="i-product" style="padding: 10px 33px 10px 0;">
                <div class="img-icon bg-Outlook"></div><!-- img -->
                <br/>
                <p class="txt-namepro">Outlook</p>
                </div>
                
                <div class="i-product" style="padding: 10px 0 10px 0;">
                <div class="img-icon bg-Publisher"></div><!-- img -->
                <br/>
                <p class="txt-namepro" style="width: 60px;">Publisher (พีซีเท่านั้น)</p>
                </div>
                <!-- / row 1 -->
                
                <!-- row 2 -->
                <div class="i-product" style="padding: 10px 33px 10px 0;">
                <div class="img-icon bg-Access"></div><!-- img -->
                <br/>
                <p class="txt-namepro" style="width: 60px;">Acesss (พีซีเท่านั้น)</p>
                </div>
                
                <div class="i-product" style="padding: 10px 33px 10px 0;">
                <div class="img-icon"></div><!-- img -->
                <br/>
                <p class="txt-namepro">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
                </div>
                
                <div class="" style="padding: 10px  0 10px 0;">
                <div class="img-icon "></div><!-- img -->
                <br/>
                <p class="txt-namepro">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
                </div>
                <!-- / row 2 -->
                
                
                
                 <!-- Title Product Group Office 365 Home 1 -->
                <br/><br/><br/>
                <p class="txt-titel-pro" style="text-align: left; margin-top: 50px;">รวมบริการ </p>
                
                <!-- row 3 -->
                <div class="i-product" style="padding: 10px 33px 10px 0;">
                <div class="img-icon bg-OneDrive"></div><!-- img -->
                <br/>
                <p class="txt-namepro" >OneDrive</p>
                </div>
                
                <div class="i-product" style="padding: 10px 33px 10px 0;">
                <div class="img-icon bg-Skype"></div><!-- img -->
                <br/>
                <p class="txt-namepro  ">Skype</p>
                </div>
                
                <div class="i-product" style="padding: 10px 0px 10px 0;">
                <div class="img-icon "></div><!-- img -->
                <br/>
                <p class="txt-namepro">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </p>
                </div>
                <!-- / row 3 -->
                
                </div>
         </div>
     
        <div class="span3" ><!-- Office 365 Home Plan 3 -->
             <div class="plan-gs" style="height: 970px; text-align: center;">
                <p class="color-blue-s txt-price-top">฿4,299.00 </p>
                <p style=" margin-top: -25px;    margin-bottom: 25px;">(การซื้อครั้งเดียว)</p>
                <p class="txt-price-small">Office Home & Student 2016 for PC</p>
                <button class="btn-buy" style="margin-top: 2px; margin-bottom: 101px;">ซื้อทันที</button>
              
                <hr style="border-top: 2px solid #cccccc;"/>
                <p  class="g-txt16"  style="padding: 10px 0 20px 0; font-size: 15px;">เหมาะที่สุดสำหรับใช้งานคนเดียวด้วยความต้องการพื้นฐาน <br/>รวมถึงแอปพลิเคชัน Office<p>
                
                <!-- Title Product Group Office 365 Home 0 -->
                <p class="txt-titel-pro" style="text-align: left; margin-bottom: 20px;" >รวมแอปพลิเคชั่น Office </p>
                
                <!-- row 0 -->
                <div class="i-product" style="padding: 10px 33px 10px 0;">
                <div class="img-icon bg-Word"></div><!-- img -->
                <br/>
                <p class="txt-namepro">Word</p>
                </div>
                
                <div class="i-product" style="padding: 10px 33px 10px 0;">
                <div class="img-icon bg-Excel"></div><!-- img -->
                <br/>
                <p class="txt-namepro">Excel</p>
                </div>
                
                <div class="i-product" style="padding: 10px 0 10px 0;">
                <div class="img-icon bg-PowerPoint"></div><!-- img -->
                <br/>
                <p class="txt-namepro">PowerPoint</p>
                </div>
                <!-- / row 0 -->
                
                <!-- row 1 -->
                <div class="i-product" style="padding: 10px 33px 10px 0;">
                <div class="img-icon bg-OneNote"></div><!-- img -->
                <br/>
                <p class="txt-namepro">OneNote</p>
                </div>
                
                <div class="i-product" style="padding: 10px 33px 10px 0;">
                <div class="img-icon "></div><!-- img -->
                <br/>
                <p class="txt-namepro"></p>
                </div>
                
                <div class="i-product" style="padding: 10px 0 10px 0;">
                <div class="img-icon "></div><!-- img -->
                <br/>
                <p class="txt-namepro" style="width: 60px;"></p>
                </div>
                <!-- / row 1 -->
                
                <!-- row 2 -->
                <div class="i-product" style="padding: 10px 20px 10px 0;">
                <div class="img-icon "></div><!-- img -->
                <br/>
                <p class="txt-namepro" style="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
                </div>
                
                <div class="i-product" style="padding: 10px 20px 10px 0;">
                <div class="img-icon"></div><!-- img -->
                <br/>
                <p class="txt-namepro">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
                </div>
                
                <div class="" style="padding: 10px  20px 10px 0;">
                <div class="img-icon "></div><!-- img -->
                <br/>
                <p class="txt-namepro">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
                </div>
                <!-- / row 2 -->
                
                
                
                 <!-- Title Product Group Office 365 Home 1 -->
                <br/><br/><br/>
                <p class="txt-titel-pro" style="text-align: left; margin-top: -13px;">รวมบริการ </p>
                <p class="g-txt16" style="margin-top: 10px; text-align:left;">(ไม่รวม)</p>
                
                </div>
         </div>
         
    
    
    </div>
    <div class="hidden-phone;"> <hr style="border-top: 2px solid #E4E4E4; margin-bottom: -1px;"/></div>
    <div class="row row-gray" >
       <div class="span3" >
           <div class="padding-row-plan gs-tooltip" style="color: #333;">
                            แอป Office แบบพรีเมี่ยมที่ติดตั้งอย่างเต็มรูปแบบพร้อมฟีเจอร์ใหม่พิเศษทุกเดือน &nbsp;<i class="fa fa-info-circle" aria-hidden="true"></i>
              <span class="gs-tooltiptext hidden-phone"> เข้ากันได้กับ Windows 7 หรือใหม่กว่า Office 2016 for Mac ต้องการ Mac OS X 10.10 จำเป็นต้องมีบัญชี Microsoft</span>
            </div>
       </div>
       <div class="span3" >
           <div class="padding-row-plan" style="text-align: center;">
           
                <img src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png" width="35px" />   
             
           </div>
       </div>
       <div class="span3" >
           <div class="padding-row-plan" style="text-align: center;">
             
              <img src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png" width="35px" /> 
             
           </div>
       </div>
       <div class="span3" >
           <div class="padding-row-plan">
                            แอป Office คลาสสิกที่ติดตั้งอย่างเต็มรูปแบบ
           </div>
       </div>
    </div>
    
    
     <div class="row row-white" >
       <div class="span3" >
           <div class="padding-row-plan gs-tooltip" style="color: #333;">
                           รวมแอป  &nbsp;<i class="fa fa-info-circle" aria-hidden="true"></i>
             <span class="gs-tooltiptext hidden-phone">ความพร้อมใช้งานของแอปและฟีเจอร์แตกต่างกันไปตามอุปกรณ์, แพลตฟอร์ม, และภาษา</span>   
           </div>
       </div>
       <div class="span3" >
           <div class="padding-row-plan gs-tooltip" style="text-align: center; color: #333;">
                Word, Excel, PowerPoint, OneNote, Outlook, Publisher, Access 
                 &nbsp;<i class="fa fa-info-circle" aria-hidden="true"></i>
                 <span class="gs-tooltiptext hidden-phone" style="left: 10px; top: 78px;">Publisher และ Access มีพร้อมให้ใช้งานบนพีซีเท่านั้น</span> 
           </div>
       </div>
       <div class="span3" >
           <div class="padding-row-plan gs-tooltip" style="text-align: center; color: #333;">
             
              Word, Excel, PowerPoint, OneNote, Outlook, Publisher, Access 
               &nbsp;<i class="fa fa-info-circle" aria-hidden="true"></i>
                 <span class="gs-tooltiptext hidden-phone"  style="left: 10px; top: 78px;">Publisher และ Access มีพร้อมให้ใช้งานบนพีซีเท่านั้น</span> 
             
           </div>
       </div>
       <div class="span3" >
           <div class="padding-row-plan">
              Word, Excel, PowerPoint, OneNote
           </div>
       </div>
    </div>
    
    
     <div class="row row-gray" >
       <div class="span3" >
           <div class="padding-row-plan">
                          ที่เก็บข้อมูลบนระบบคลาวด์ของ OneDrive ขนาด 1 TB สำหรับผู้ใช้แต่ละราย
           </div>
       </div>
       <div class="span3" >
           <div class="padding-row-plan" style="text-align: center;">
           
                <img src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png" width="35px" /> 
                <p>สำหรับสูงสุด 5 คน</p>
             
           </div>
       </div>
       <div class="span3" >
           <div class="padding-row-plan" style="text-align: center;">
             
              <img src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png" width="35px" /> 
              <p>สำหรับสูงสุด 1 คน</p>
           </div>
       </div>
       <div class="span3" >
           <div class="padding-row-plan">
                         
           </div>
       </div>
    </div>
    
     <div class="row row-white" >
       <div class="span3" >
           <div class="padding-row-plan">
                ที่เก็บข้อมูลบนระบบคลาวด์ของ OneDrive ขนาด 1 TB สำหรับผู้ใช้แต่ละราย
           </div>
       </div>
       <div class="span3" >
           <div class="padding-row-plan" style="text-align: center;">
           
                <img src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png" width="35px" /> 
              <p>สำหรับสูงสุด 5 คน</p>
             
           </div>
       </div>
       <div class="span3" >
           <div class="padding-row-plan" style="text-align: center;">
             
            <img src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png" width="35px" /> 
              <p>สำหรับสูงสุด 1 คน</p>
             
           </div>
       </div>
       <div class="span3" >
           <div class="padding-row-plan">
              Word, Excel, PowerPoint, OneNote
           </div>
       </div>
    </div>
    
     
     <div class="row row-gray" >
       <div class="span3" >
           <div class="padding-row-plan gs-tooltip"  style="color: #333;">
                                             ด้วย Skype โทรไปยังโทรศัพท์มือถือและโทรศัพท์บ้าน 60 นาทีต่อเดือนต่อผู้ใช้ (<a href="#" style="color: #01aff1;">มีข้อยกเว้น</a>)
               &nbsp;<i class="fa fa-info-circle" aria-hidden="true"></i>
               <span class="gs-tooltiptext hidden-phone" style="left: 150px;">จำเป็นต้องใช้บัญชี Skype ไม่รวมหมายเลขพิเศษ หมายเลขพรีเมียม หมายเลขที่ไม่สามารถระบุประเทศได้ โทรไปยังโทรศัพท์มือถือสำหรับประเทศที่เลือกเท่านั้น นาที Skype พร้อมใช้งานในประเทศที่เลือก</span>            
           </div>
       </div>
       <div class="span3" >
           <div class="padding-row-plan" style="text-align: center;">
           
                <img src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png" width="35px" /> 
                <p>สำหรับสูงสุด 5 คน</p>
             
           </div>
       </div>
       <div class="span3" >
           <div class="padding-row-plan" style="text-align: center;">
             
              <img src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png" width="35px" /> 
              <p>สำหรับสูงสุด 1 คน</p>
           </div>
       </div>
       <div class="span3" >
           <div class="padding-row-plan">
                         
           </div>
       </div>
    </div>
    
    
    
     <div class="row row-white" >
       <div class="span3" >
           <div class="padding-row-plan">
                การสนับสนุน Microsoft ผ่านการพูดคุยหรือโทรศัพท์โดยไม่มีค่าใช้จ่ายเพิ่มเติมผ่านการสมัครใช้งานของคุณ
           </div>
       </div>
       <div class="span3" >
           <div class="padding-row-plan" style="text-align: center;">
           
                <img src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png" width="35px" /> 
           
             
           </div>
       </div>
       <div class="span3" >
           <div class="padding-row-plan" style="text-align: center;">
             
            <img src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png" width="35px" /> 
             
             
           </div>
       </div>
       <div class="span3" >
           <div class="padding-row-plan">
                           รวมสำหรับ 60 วัน
           </div>
       </div>
    </div>
    
      <div class="row row-gray" >
       <div class="span3" >
           <div class="padding-row-plan">
                          สิทธิ์การใช้งานสำหรับการใช้งานที่บ้าน
           </div>
       </div>
       <div class="span3" >
           <div class="padding-row-plan" style="text-align: center;">
                <img src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png" width="35px" />      
           </div>
       </div>
       <div class="span3" >
           <div class="padding-row-plan" style="text-align: center;">           
              <img src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png" width="35px" />               
           </div>
       </div>
       <div class="span3" style="text-align: center;" >
           <div class="padding-row-plan">
                <img src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png" width="35px" />          
           </div>
       </div>
    </div>
    
     <div class="row row-white" >
       <div class="span3" >
           <div class="padding-row-plan">
                            วิธีการซื้อ
           </div>
       </div>
       <div class="span3" >
           <div class="padding-row-plan gs-tooltip" style="text-align: center;  color: #333;" >
           
                          ซื้อการสมัครสมาชิกแบบ<br/>รายปีหรือรายเดือน
          &nbsp;<i class="fa fa-info-circle" aria-hidden="true"></i>                 
         <span class="gs-tooltiptext hidden-phone"  style="left: 10px; top: 78px;">Publisher และ Access มีพร้อมให้ใช้งานบนพีซีเท่านั้น</span>   
             
           </div>
       </div>
       <div class="span3" >
           <div class="padding-row-plan gs-tooltip" style="text-align: center;  color: #333;" >
           
                          ซื้อการสมัครสมาชิกแบบ<br/>รายปีหรือรายเดือน
          &nbsp;<i class="fa fa-info-circle" aria-hidden="true"></i>                 
         <span class="gs-tooltiptext hidden-phone"  style="left: 10px; top: 78px;">Publisher และ Access มีพร้อมให้ใช้งานบนพีซีเท่านั้น</span>   
             
           </div>
       </div>
       <div class="span3" style="text-align: center;" >
           <div class="padding-row-plan">
                          การซื้อครั้งเดียว
           </div>
       </div>
    </div>
    
   <hr style="border-top: 2px solid #E4E4E4; margin-bottom: -25px; margin-top: 0px;">   
   <div class="row"  style="margin-top: 40px;">
         <div class="span3 " style="height: 500px;">
            <div class="detail_plan">
        
                 
            </div>
         </div>
         <div class="span3" ><!-- Office 365 Home Plan 1 -->
             <div class="plan-gs" style="height: 350px; text-align: center;">
                <p class="color-blue-s txt-price-top">฿2,899.00 </p>
                <p style=" margin-top: -25px;    margin-bottom: 25px;">(ต่อปี)</p>
                <p class="txt-price-small">Office 365 Home</p>
                <button class="btn-buy" style="margin-top: 30px; margin-bottom: 10px;">ซื้อทันที</button>
                <button class="btn-try" style="margin-top: 10px; margin-bottom: 20px;">ทดลองใช้ฟรี</button>
                <a href="#"><p class="txt-price-detill">หรือซื้อในราคา ฿289.99 ต่อเดือน  <i class="fa fa-chevron-circle-right" aria-hidden="true"></i></p></a>
                <hr style="border-top: 2px solid #cccccc;"/>
               
                <center>
                <a href="#"><p class="txt-price-detill" style="font-size: 18px;">เรียนรู้เพิ่มเติม  <i class="fa fa-chevron-right" aria-hidden="true"></i></p></a>
                </center>
                </div>
         </div>
        
  
        <div class="span3" ><!-- Office 365 Home Plan 2 -->
             <div class="plan-gs" style="height: 350px; text-align: center;">
                <p class="color-blue-s txt-price-top">฿2,099.00 </p>
                <p style=" margin-top: -25px;    margin-bottom: 25px;">(ต่อปี)</p>
                <p class="txt-price-small">Office 365 Persopnal</p>
                <button class="btn-buy" style="margin-top: 30px; margin-bottom: 81px;">ซื้อทันที</button>
         
                <a href="#"><p class="txt-price-detill">หรือซื้อในราคา ฿209.99 ต่อเดือน  <i class="fa fa-chevron-circle-right" aria-hidden="true"></i></p></a>
                <hr style="border-top: 2px solid #cccccc;"/>
               
                <center>
                <a href="#"><p class="txt-price-detill" style="font-size: 18px;">เรียนรู้เพิ่มเติม  <i class="fa fa-chevron-right" aria-hidden="true"></i></p></a>
                </center>
                
                </div>
         </div>
     
        <div class="span3" ><!-- Office 365 Home Plan 3 -->
             <div class="plan-gs" style="height: 350px; text-align: center;">
                <p class="color-blue-s txt-price-top">฿4,299.00 </p>
                <p style=" margin-top: -25px;    margin-bottom: 25px;">(การซื้อครั้งเดียว)</p>
                <p class="txt-price-small">Office Home & Student 2016 for PC</p>
                <button class="btn-buy" style="margin-top: 2px; margin-bottom: 101px;">ซื้อทันที</button>
              
                <hr style="border-top: 2px solid #cccccc;"/>
               
                <center>
                <a href="#"><p class="txt-price-detill" style="font-size: 18px;">เรียนรู้เพิ่มเติม <i class="fa fa-chevron-right" aria-hidden="true"></i></p></a>
                </center>
                
  
           </div>
         
    
    
       </div>    
  </div>
</div> 
 <!-- / HOME -->
 
 <!-- id Office365 for Business  -->
 <div id="Business" class="tab-pane fade in ">
     <div class="row"  style="margin-top: 40px;">
         <div class="span3 " style="height: 500px;">
            <div class="detail_plan">
                 <p class="g-txt16" style="color: #000;">กำลังมองหาอะไรเพิ่มเติมใช่ไหม</p>
                 <br/>
                 
                 <p class="g-txt16">ดูตัวเลือกสำหรับ:</p>
                 <p class="g-txt16 "><a href="#" class="color-blue-a" >ดูตัวเลือกสำหรับองค์กร</a></p>
                 
                 <br/>
                 <a href="#"><p class="g-txt16 color-blue-a">Office 365 สำหรับธุรกิจคืออะไร</p></a>
                 <br/>
                 <a herf="#"><p class="g-txt16"><i class="qode_icon_font_awesome fa fa-comments-o txt18" style="border:none; vertical-align: baseline !important; width:15px; color: #2c415e;"></i>&nbsp;&nbsp;สนทนากับฝ่ายขาย</p></a>
                 <a herf="#"><p class="g-txt16"><i class="qode_icon_font_awesome fa fa-phone txt18" style="border:none; vertical-align: baseline !important; width:15px; color: #2c415e;"></i>&nbsp;&nbsp;0-2912-2558 – 64</p></a>
                 <a herf="#"><p class="g-txt16"><i class="qode_icon_font_awesome fa fa-envelope txt18" style="border:none; vertical-align: baseline !important; width:15px; color: #2c415e;"></i>&nbsp;&nbsp;ติดต่อเรา</p></a>
                 
            </div>
         </div>
         <div class="span3" ><!-- Office 365 Business Plan 1 -->
             <div class="plan-gs" style="height: 1065px; text-align: center;">
                <p class="color-blue-s txt-price-top"  style="margin-top: 60px;">$8.25 </p>
                <p style=" margin-top: -25px;    margin-bottom: 25px;">ผู้ใช้/เดือน</p>
                <p class="txt-price-small" style="font-size: 18px;">(ข้อตกลงแบบรายปี)</p>
               <select class="plan-office365" name="">
      <option value="#">1 ปี $8.25 ผู้ใช้/เดือน</option>
      <option value="#">1เดือน $10.00  ผู้ใช้/เดือน</option>
    </select>
                <p class="txt-price-small">Office 365 Business</p>
                <button class="btn-buy" style="margin-top: 58px; margin-bottom: 10px;">ซื้อทันที</button>
                <p style=" margin-top: 5px;    margin-bottom: 25px; font-size: 15px;">ราคายังไม่รวมภาษี</p>
               
                <hr style="border-top: 2px solid #cccccc;"/>
                <p  class="g-txt16"  style="padding: 10px 0 20px 0; font-size: 15px;" >ดีที่สุดสำหรับธุรกิจที่ต้องการแอปพลิเคชัน Office รวมถึงที่จัดเก็บและการแชร์ไฟล์ในระบบคลาวด์ <br/>ไม่รวมอีเมลระดับธุรกิจ<p>
                
                <!-- Title Product Group Office 365 Home 0 -->
                <p class="txt-titel-pro" style="text-align: left; margin-bottom: 20px;" >รวมแอปพลิเคชั่น Office </p>
                
                <!-- row 0 -->
                <div class="i-product" style="padding: 10px 33px 10px 0;">
                <div class="img-icon bg-Outlook"></div><!-- img -->
                <br/>
                <p class="txt-namepro">Outlook</p>
                </div>
                
                <div class="i-product" style="padding: 10px 33px 10px 0;">
                <div class="img-icon bg-Word"></div><!-- img -->
                <br/>
                <p class="txt-namepro">Word</p>
                </div>
                
                <div class="i-product" style="padding: 10px 0 10px 0;">
                <div class="img-icon bg-Excel"></div><!-- img -->
                <br/>
                <p class="txt-namepro">Excel</p>
                </div>
                
                
                <!-- / row 0 -->
                
                <!-- row 1 -->
                <div class="i-product" style="padding: 10px 33px 10px 0;">
                <div class="img-icon bg-PowerPoint"></div><!-- img -->
                <br/>
                <p class="txt-namepro" style="width: 40px;">PowerPoint</p>
                </div>
                
                <div class="i-product" style="padding: 10px 33px 10px 0;">
                <div class="img-icon bg-OneNote"></div><!-- img -->
                <br/>
                <p class="txt-namepro">OneNote</p>
                </div>
                
                <div class="i-product" style="padding: 10px 0 10px 0;">
                <div class="img-icon bg-Access"></div><!-- img -->
                <br/>
                <p class="txt-namepro" style="width: 60px;">Acesss (พีซีเท่านั้น)</p>
                </div>
                <!-- / row 1 -->

                 <!-- Title Product Group Office 365 Business 1 -->
                <br/><br/><br/>
                <p class="txt-titel-pro" style="text-align: left; margin-top: 50px;">รวมบริการ </p>
                
                <!-- row 3 -->
                <div class="i-product" style="padding: 10px 33px 10px 0;">
                <div class="img-icon bg-OneDrive"></div><!-- img -->
                <br/>
                <p class="txt-namepro" >OneDrive</p>
                </div>
                
                <div class="i-product" style="padding: 10px 33px 10px 0;">
                <div class="img-icon"></div><!-- img -->
                <br/>
                <p class="txt-namepro  "></p>
                </div>
                
                <div class="i-product" style="padding: 10px 0 10px 0;">
                <div class="img-icon "></div><!-- img -->
                <br/>
                <p class="txt-namepro">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </p>
                </div>
                <!-- / row 3 -->
                
                </div>
         </div>
        
        <div class="span3" ><!-- Office 365 Business Plan 1 -->
             <div class="promotion gs-tooltip span12">
                                                ข้อเสนอพิเศษ: <u>ประหยัด 20%</u><br/><p style="font-size: 15px;">ในระยะเวลาจำกัดเท่านั้น <i class="fa fa-info-circle" aria-hidden="true"></i></p>
                <span class="gs-tooltiptext hidden-phone" style="margin-top: 2px; margin-left: 130px;">ข้อเสนอพิเศษในระยะเวลาจำกัดเท่านั้นสำหรับการสมัครใช้งานรายปี</span>  
             </div>
             <div class="plan-gs" style="height: 1065px; text-align: center;">
                <p class="color-blue-s txt-price-top" style="margin-top: 60px;">$10.00 </p>
                <p style=" margin-top: -25px;    margin-bottom: 25px;">ผู้ใช้/เดือน</p>
                <p class="txt-price-small" style="font-size: 18px;">(ข้อตกลงแบบรายปี)</p>
               <select class="plan-office365" name="">
                  <option value="#">1 ปี $10.00 ผู้ใช้/เดือน</option>
                  <option value="#">1เดือน $10.00  ผู้ใช้/เดือน</option>
                </select>
                <p class="txt-price-small">Office 365 Business Premium</p>
                <button class="btn-buy" style="margin-top: 30px; margin-bottom: 10px;">ซื้อทันที</button>
                <p style=" margin-top: 5px;    margin-bottom: 25px; font-size: 15px;">ราคายังไม่รวมภาษี</p>
               
                <hr style="border-top: 2px solid #cccccc;"/>
                <p  class="g-txt16"  style="padding: 10px 0 36px 0; font-size: 15px; ">ดีที่สุดสำหรับธุรกิจที่ต้องการอีเมลระดับธุรกิจ แอปพลิเคชัน Office และบริการทางธุรกิจอื่นๆ<p>
                
                <!-- Title Product Group Office 365 Business 0 -->
                <p class="txt-titel-pro" style="text-align: left; margin-bottom: 20px;" >รวมแอปพลิเคชั่น Office </p>
                
                <!-- row 0 -->
                <div class="i-product" style="padding: 10px 33px 10px 0;">
                <div class="img-icon bg-Outlook"></div><!-- img -->
                <br/>
                <p class="txt-namepro">Outlook</p>
                </div>
                
                <div class="i-product" style="padding: 10px 33px 10px 0;">
                <div class="img-icon bg-Word"></div><!-- img -->
                <br/>
                <p class="txt-namepro">Word</p>
                </div>
                
                <div class="i-product" style="padding: 10px 0 10px 0;">
                <div class="img-icon bg-Excel"></div><!-- img -->
                <br/>
                <p class="txt-namepro">Excel</p>
                </div>
                
                
                <!-- / row 0 -->
                
                <!-- row 1 -->
                <div class="i-product" style="padding: 10px 33px 10px 0;">
                <div class="img-icon bg-PowerPoint"></div><!-- img -->
                <br/>
                <p class="txt-namepro" style="width: 40px;">PowerPoint</p>
                </div>
                
                <div class="i-product" style="padding: 10px 33px 10px 0;">
                <div class="img-icon bg-OneNote"></div><!-- img -->
                <br/>
                <p class="txt-namepro">OneNote</p>
                </div>
                
                <div class="i-product" style="padding: 10px 0 10px 0;">
                <div class="img-icon bg-Access"></div><!-- img -->
                <br/>
                <p class="txt-namepro" style="width: 60px;">Acesss (พีซีเท่านั้น)</p>
                </div>
                <!-- / row 1 -->

                 <!-- Title Product Group Office 365 Business 1 -->
                <br/><br/><br/>
                <p class="txt-titel-pro" style="text-align: left; margin-top: 50px;">รวมบริการ </p>
                
                <!-- row 3 -->
                <div class="i-product" style="padding: 10px 33px 10px 0;">
                <div class="img-icon  bg-Exchange"></div><!-- img -->
                <br/>
                <p class="txt-namepro  ">Exchange</p>
                </div>
                
                
                <div class="i-product" style="padding: 10px 33px 10px 0;">
                <div class="img-icon bg-OneDrive"></div><!-- img -->
                <br/>
                <p class="txt-namepro" >OneDrive</p>
                </div>
                
                <div class="i-product" style="padding: 10px 0 10px 0;">
                <div class="img-icon bg-SharePoint"></div><!-- img -->
                <br/>
                <p class="txt-namepro  ">SharePoint</p>
                </div>
                
                <div class="i-product" style="padding: 10px 24px 10px 0;">
                <div class="img-icon bg-Skype-BS"></div><!-- img -->
                <br/>
                <p class="txt-namepro" style="width: 60px;">Skype for Business </p>
                </div>
                
                
                <div class="i-product" style="padding: 10px 33px 10px 0;">
                <div class="img-icon bg-Teams" title="Microsoft Teams (ภาษาอังกฤษ)"></div><!-- img -->
                <br/>
                <p class="txt-namepro" style="width: 60px;">Microsoft Teams  </p>
                </div>
                <!-- / row 3 -->
                
                </div>
         </div>
       
     
        <div class="span3" ><!-- Office 365 Business Plan 1 -->
             <div class="promotion gs-tooltip span12">
                                                ข้อเสนอพิเศษ: <u>ประหยัด 50%</u><br/><p style="font-size: 15px;">ในระยะเวลาจำกัดเท่านั้น <i class="fa fa-info-circle" aria-hidden="true"></i></p>
                <span class="gs-tooltiptext hidden-phone" style="margin-top: 2px; margin-left: -187px; ">ข้อเสนอพิเศษในระยะเวลาจำกัดเท่านั้นสำหรับการสมัครใช้งานรายปี</span>  
             </div>
             <div class="plan-gs" style="height: 1065px; text-align: center;">
                <p class="color-blue-s txt-price-top" style="margin-top: 60px;">$2.50 </p>
                <p style=" margin-top: -25px;    margin-bottom: 25px;">ผู้ใช้/เดือน</p>
                <p class="txt-price-small" style="font-size: 18px;">(ข้อตกลงแบบรายปี)</p>
               <select class="plan-office365">
                  <option value="#">1 ปี $2.50 ผู้ใช้/เดือน</option>
                  <option value="#">1เดือน $3.00  ผู้ใช้/เดือน</option>
                </select>
                <p class="txt-price-small">Office 365 Business Essentials</p>
                <button class="btn-buy" style="margin-top: 30px; margin-bottom: 10px;">ซื้อทันที</button>
                <p style=" margin-top: 5px;    margin-bottom: 25px; font-size: 15px;">ราคายังไม่รวมภาษี</p>
               
                <hr style="border-top: 2px solid #cccccc;"/>
                <p  class="g-txt16"  style="padding: 10px 0 36px 0; font-size: 15px;">ดีที่สุดสำหรับธุรกิจที่ต้องการอีเมลระดับธุรกิจและบริการทางธุรกิจอื่นๆ ไม่รวมแอปพลิเคชัน Office<p>
                
                <!-- Title Product Group Office 365 Home 0 -->
                <p class="txt-titel-pro" style="text-align: left; margin-bottom: 20px;" >รวมแอปพลิเคชั่น Office </p>
                <div class="gs-tooltip"  style="text-align: left; width: 100%;">
                    (ไม่รวม)  &nbsp;<i class="fa fa-info-circle" aria-hidden="true"></i>
                    <span class="gs-tooltiptext hidden-phone" style="margin-top: 2px; margin-left: -155px; padding: 20px 10px 20px 10px;">แผนนี้ใช้งานร่วมกับ Office, Office 2013 <br/>และ Office 2011 for Mac เวอร์ชันล่าสุด Office เวอร์ชันก่อนหน้า เช่น Office 2010 และ Office 2007 อาจใช้งานร่วมกับ Office 365 โดยมีฟังก์ชันการทำงานที่ลดลง ความเข้ากันได้กับ Office นี้ไม่รวมแผน Exchange Online Kiosk หรือ Office 365 F1</span>
                </div>

                 <!-- Title Product Group Office 365 Home 1 -->
                <br/><br/><br/>
                <p class="txt-titel-pro" style="text-align: left; margin-top: 165px;">รวมบริการ </p>
                
                <!-- row 3 -->
                <div class="i-product" style="padding: 10px 33px 10px 0;">
                <div class="img-icon  bg-Exchange"></div><!-- img -->
                <br/>
                <p class="txt-namepro  ">Exchange</p>
                </div>
                
                
                <div class="i-product" style="padding: 10px 33px 10px 0;">
                <div class="img-icon bg-OneDrive"></div><!-- img -->
                <br/>
                <p class="txt-namepro" >OneDrive</p>
                </div>
                
                <div class="i-product" style="padding: 10px 0px 10px 0;">
                <div class="img-icon bg-SharePoint"></div><!-- img -->
                <br/>
                <p class="txt-namepro  ">SharePoint</p>
                </div>
                
                <div class="i-product" style="padding: 10px 24px 10px 0;">
                <div class="img-icon bg-Skype-BS"></div><!-- img -->
                <br/>
                <p class="txt-namepro" style="width: 60px;">Skype for Business </p>
                </div>
                
                
                <div class="i-product" style="padding: 10px 33px 10px 0;">
                <div class="img-icon bg-Teams" title="Microsoft Teams (ภาษาอังกฤษ)"></div><!-- img -->
                <br/>
                <p class="txt-namepro" style="width: 60px;">Microsoft Teams  </p>
                </div>
                <!-- / row 3 -->
                
                </div>
         </div>
         
    
    
    </div>
    <div class="hidden-phone;"> <hr style="border-top: 2px solid #E4E4E4; margin-bottom: -1px;"/></div>
    <div class="row row-gray" >
       <div class="span3" >
           <div class="padding-row-plan ">
                                         การโฮสต์อีเมลด้วยกล่องจดหมายขนาด 50 GB และที่อยู่โดเมนอีเมลแบบกำหนดเอง                   
           </div>
       </div>
       <div class="span3" >
           <div class="padding-row-plan" style="text-align: center;">
           
                
             
           </div>
       </div>
       <div class="span3" >
           <div class="padding-row-plan" style="text-align: center;">
             
              <img src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png" width="35px" /> 
             
           </div>
       </div>
       <div class="span3" >
           <div class="padding-row-plan" style="text-align: center;">
              <img src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png" width="35px" />   
           </div>
       </div>
    </div>
    
    
     <div class="row row-white" >
       <div class="span3" >
           <div class="padding-row-plan">
                 แอปพลิเคชัน Office 2016 เวอร์ชันบนเดสก์ท็อป: Outlook, Word, Excel, PowerPoint, OneNote <br/>(รวมถึง Access และ Publisher สำหรับพีซีเท่านั้น)
           </div>
       </div>
       <div class="span3" >
           <div class="padding-row-plan" style="text-align: center;">
           
                <img src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png" width="35px" />  
             
           </div>
       </div>
       <div class="span3" >
           <div class="padding-row-plan" style="text-align: center;">
             
              <img src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png" width="35px" />  
             
           </div>
       </div>
       <div class="span3" >
           <div class="padding-row-plan">
             
           </div>
       </div>
    </div>
    
    
     <div class="row row-gray" >
       <div class="span3" >
           <div class="padding-row-plan">
                         Word, Excel และ PowerPoint เวอร์ชันบนเว็บ
           </div>
       </div>
       <div class="span3" >
           <div class="padding-row-plan" style="text-align: center;">
           
                <img src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png" width="35px" /> 
               
             
           </div>
       </div>
       <div class="span3" >
           <div class="padding-row-plan" style="text-align: center;">      
              <img src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png" width="35px" /> 
              <p>รวมถึง Outlook เวอร์ชันบนเว็บ</p>
           </div>
       </div>
       <div class="span3" >
           <div class="padding-row-plan" style="text-align: center;">
              <img src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png" width="35px" /> 
              <p>รวมถึง Outlook เวอร์ชันบนเว็บ</p>         
           </div>
       </div>
    </div>
    
     <div class="row row-white" >
       <div class="span3" >
           <div class="padding-row-plan gs-tooltip" style="color: #333;">
                                      หนึ่งสิทธิ์การใช้งานครอบคลุมโทรศัพท์ 5 เครื่อง แท็บเล็ต 5 เครื่อง และพีซีหรือ Mac 5 เครื่องต่อผู้ใช้
             &nbsp;<i class="fa fa-info-circle" aria-hidden="true"></i>
             <span class="gs-tooltiptext hidden-phone" style="margin-top: 20px; margin-left: 60spx; padding: 20px 10px 20px 10px;">
                                              แผนนี้ใช้งานร่วมกับ Office, Office 2013 <br/>และ Office 2011 for Mac เวอร์ชันล่าสุด Office เวอร์ชันก่อนหน้า เช่น Office 2010 และ Office 2007 อาจใช้งานร่วมกับ Office 365 โดยมีฟังก์ชันการทำงานที่ลดลง ความเข้ากันได้กับ Office นี้ไม่รวมแผน Exchange Online Kiosk หรือ Office 365 F1
                                            เข้ากันได้กับ Windows 7 หรือใหม่กว่า Office 2016 for Mac ต้องใช้ Mac OS X 10.10              </span>     
           </div>
       </div>
       <div class="span3" >
           <div class="padding-row-plan" style="text-align: center;">
           
                <img src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png" width="35px" /> 
             
             
           </div>
       </div>
       <div class="span3" >
           <div class="padding-row-plan" style="text-align: center;">
             
            <img src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png" width="35px" /> 
              
             
           </div>
       </div>
       <div class="span3" >
           <div class="padding-row-plan">
             
           </div>
       </div>
    </div>
    
     
     <div class="row row-gray" >
       <div class="span3" >
           <div class="padding-row-plan">
                                   ที่จัดเก็บไฟล์และการแชร์ไฟล์ด้วยที่เก็บข้อมูลของ OneDrive <br/>ขนาด 1 TB
           </div>
       </div>
       <div class="span3" >
           <div class="padding-row-plan" style="text-align: center;">
           
                <img src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png" width="35px" /> 
             
             
           </div>
       </div>
       <div class="span3" >
           <div class="padding-row-plan" style="text-align: center;">
             
              <img src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png" width="35px" /> 
             
           </div>
       </div>
       <div class="span3" >
           <div class="padding-row-plan" style="text-align: center;">
              <img src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png" width="35px" />            
           </div>
       </div>
    </div>
    
    
    
     <div class="row row-white" >
       <div class="span3" >
           <div class="padding-row-plan">
                                               อินทราเน็ตทั่วทั้งองค์กรและทีมไซต์ด้วย SharePoint
           </div>
       </div>
       <div class="span3" >
           <div class="padding-row-plan" style="text-align: center;">
           
                
           
             
           </div>
       </div>
       <div class="span3" >
           <div class="padding-row-plan" style="text-align: center;">
             
            <img src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png" width="35px" /> 
             
             
           </div>
       </div>
       <div class="span3" >
           <div class="padding-row-plan" style="text-align: center;">
                           <img src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png" width="35px" /> 
           </div>
       </div>
    </div>
    
      <div class="row row-gray" >
       <div class="span3" >
           <div class="padding-row-plan gs-tooltip" style="color: #333;">
                                      การประชุมแบบวิดีโอและออนไลน์สำหรับผู้คนสูงสุด 250 คน
             &nbsp;<i class="fa fa-info-circle" aria-hidden="true"></i>
             <span class="gs-tooltiptext hidden-phone" style="margin-top: 20px; margin-left: 60spx; padding: 20px 10px 20px 10px;">
                                            สำหรับการโทรแบบ HD จำเป็นต้องใช้ฮาร์ดแวร์ HD ที่เข้ากันได้และการเชื่อมต่อแบบบรอดแบนด์ที่มีความเร็วอย่างน้อย 4 Mbps  </span>     
           </div>
       </div>
       <div class="span3" >
           <div class="padding-row-plan" style="text-align: center;">
                  
           </div>
       </div>
       <div class="span3" >
           <div class="padding-row-plan" style="text-align: center;">           
              <img src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png" width="35px" />               
           </div>
       </div>
       <div class="span3" style="text-align: center;" >
           <div class="padding-row-plan">
                <img src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png" width="35px" />          
           </div>
       </div>
    </div>
    
     <div class="row row-white" >
       <div class="span3" >
           <div class="padding-row-plan gs-tooltip" style="color: #333;">
                                      ฮับสำหรับการทำงานเป็นทีมเพื่อเชื่อมต่อทีมของคุณกับ Microsoft Teams
             &nbsp;<i class="fa fa-info-circle" aria-hidden="true"></i>
             <span class="gs-tooltiptext hidden-phone" style="margin-top: 20px; margin-left: 60spx; padding: 20px 10px 20px 10px;">
                                           ขณะนี้ Microsoft Teams ยังไม่ถูกแปลเป็นภาษาของคุณและยังคงเป็นภาษาอังกฤษ  </span>     
           </div>
       </div>
       <div class="span3" >
           <div class="padding-row-plan" style="text-align: center;" >
           </div>
       </div>
       
       <div class="span3" >
           <div class="padding-row-plan" style="text-align: center;" >
             
                <img src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png" width="35px" />                   
           </div>
       </div>
       
       <div class="span3" style="text-align: center;" >
           <div class="padding-row-plan">
              <img src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png" width="35px" />          
            
           </div>
       </div>
    </div>
    
    <div class="row row-white" >
       <div class="span3" >
           <div class="padding-row-plan " >
                                     ให้ลูกค้าเข้าถึงและพัฒนาความสัมพันธ์กับลูกค้าด้วย Outlook Customer Manager
           </div>
       </div>
       <div class="span3" >
           <div class="padding-row-plan" style="text-align: center;" >
           </div>
       </div>
       
       <div class="span3" >
           <div class="padding-row-plan" style="text-align: center;" >
             
                <img src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png" width="35px" />                   
           </div>
       </div>
       
       <div class="span3" style="text-align: center;" >
           <div class="padding-row-plan">
              
           </div>
       </div>
    </div>
    
    <div class="row row-gray" >
       <div class="span3" >
           <div class="padding-row-plan " >
                                     จัดการธุรกิจของคุณได้ดีขึ้นด้วย Microsoft Bookings
           </div>
       </div>
       <div class="span3" >
           <div class="padding-row-plan" style="text-align: center;" >
           </div>
       </div>
       
       <div class="span3" >
           <div class="padding-row-plan" style="text-align: center;" >
             
                <img src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png" width="35px" />                   
           </div>
       </div>
       
       <div class="span3" style="text-align: center;" >
           <div class="padding-row-plan">
              
           </div>
       </div>
    </div>
    <div class="row row-white" >
       <div class="span3" >
           <div class="padding-row-plan " >
                                     จัดการงานและการทำงานเป็นทีมด้วย Microsoft Planner
           </div>
       </div>
       <div class="span3" >
           <div class="padding-row-plan" style="text-align: center;" >
           </div>
       </div>
       
       <div class="span3" >
           <div class="padding-row-plan" style="text-align: center;" >
             
                <img src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png" width="35px" />                   
           </div>
       </div>
       
       <div class="span3" style="text-align: center;" >
           <div class="padding-row-plan">
              <img src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png" width="35px" />                   
           
           </div>
       </div>
    </div>
    
   <div class="row row-gray" >
       <div class="span3" >
           <div class="padding-row-plan " >
                                    จัดการกำหนดการและงานประจำวันด้วย Microsoft StaffHub
           </div>
       </div>
       <div class="span3" >
           <div class="padding-row-plan" style="text-align: center;" >
           </div>
       </div>
       
       <div class="span3" >
           <div class="padding-row-plan" style="text-align: center;" >
             
                <img src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png" width="35px" />                   
           </div>
       </div>
       
       <div class="span3" style="text-align: center;" >
           <div class="padding-row-plan">
              
           </div>
       </div>
    </div> 
    
    <div class="row row-white" >
       <div class="span3" >
           <div class="padding-row-plan " >
                   จำนวนผู้ใช้สูงสุด
           </div>
       </div>
       <div class="span3" >
           <div class="padding-row-plan" style="text-align: center;" >
           300
           </div>
       </div>
       
       <div class="span3" >
           <div class="padding-row-plan" style="text-align: center;" >
           300  
           </div>
       </div>
       
       <div class="span3" style="text-align: center;" >
           <div class="padding-row-plan">
           300   
           </div>
       </div>
    </div>
    
    <div class="row row-gray" >
       <div class="span3" >
           <div class="padding-row-plan " >
                                 การสนับสนุนการปรับใช้ FastTrack ด้วยการซื้อ 50 สิทธิ์ขึ้นไปโดยไม่มีค่าใช้จ่ายเพิ่มเติม
           </div>
       </div>
       <div class="span3" >
           <div class="padding-row-plan" style="text-align: center;" >
           
           <img src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png" width="35px" />                   
          
           </div>
       </div>
       
       <div class="span3" >
           <div class="padding-row-plan" style="text-align: center;" >
             
                <img src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png" width="35px" />                   
           </div>
       </div>
       
       <div class="span3" style="text-align: center;" >
           <div class="padding-row-plan">
                <img src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png" width="35px" />                   
          
           </div>
       </div>
    </div> 
    
    <div class="row row-white" >
       <div class="span3" >
           <div class="padding-row-plan " >
                                 การสนับสนุนทางโทรศัพท์และเว็บไซต์ทุกวันตลอด 24 ชั่วโมง
           </div>
       </div>
       <div class="span3" >
           <div class="padding-row-plan" style="text-align: center;" >
           
           <img src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png" width="35px" />                   
          
           </div>
       </div>
       
       <div class="span3" >
           <div class="padding-row-plan" style="text-align: center;" >
             
                <img src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png" width="35px" />                   
           </div>
       </div>
       
       <div class="span3" style="text-align: center;" >
           <div class="padding-row-plan">
                <img src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png" width="35px" />                   
          
           </div>
       </div>
    </div>
    
    <div class="row row-gray" >
       <div class="span3" >
           <div class="padding-row-plan " >
                                 ได้รับอนุญาตสำหรับการใช้งานเชิงพาณิชย์
           </div>
       </div>
       <div class="span3" >
           <div class="padding-row-plan" style="text-align: center;" >
           
           <img src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png" width="35px" />                   
          
           </div>
       </div>
       
       <div class="span3" >
           <div class="padding-row-plan" style="text-align: center;" >
             
                <img src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png" width="35px" />                   
           </div>
       </div>
       
       <div class="span3" style="text-align: center;" >
           <div class="padding-row-plan">
                <img src="https://netway.co.th/templates/netwaybysidepad/images/check-icon-office365-min.png" width="35px" />                   
          
           </div>
       </div>
    </div>
  <hr style="border-top: 2px solid #E4E4E4; margin-bottom: -25px; margin-top: 0px;">    
  <!-- Start detail_plan -->  
   <div class="row"  style="margin-top: 40px;">
         <div class="span3 " style="height: 500px;">
            <div class="detail_plan">
        
                 
            </div>
         </div>
         <div class="span3" ><!-- Office 365 Home Plan 1 -->
             <div class="plan-gs" style="height: 500px; text-align: center;">
                <p class="color-blue-s txt-price-top">$8.25 </p>
                <p style=" margin-top: -25px;    margin-bottom: 25px;">ผู้ใช้/เดือน</p>
                <p class="txt-price-small" style="font-size: 18px;">(ข้อตกลงแบบรายปี)</p>
               <select class="plan-office365" name="">
                  <option value="#">1 ปี $8.25 ผู้ใช้/เดือน</option>
                  <option value="#">1เดือน $10.00  ผู้ใช้/เดือน</option>
                </select>
                <p class="txt-price-small">Office 365 Business</p>
                <button class="btn-buy" style="margin-top: 86px; margin-bottom: 10px;">ซื้อทันที</button>
                <p style=" margin-top: 5px;    margin-bottom: 25px; font-size: 15px;">ราคายังไม่รวมภาษี</p>
               
                <hr style="border-top: 2px solid #cccccc;"/>
                
                <center>
                <a href="#"><p class="txt-price-detill" style="font-size: 18px;">ทดลองใช้ฟรี  <i class="fa fa-chevron-right" aria-hidden="true"></i></p></a>
                <br/>
                <a href="#"><p class="txt-price-detill" style="font-size: 18px;">เรียนรู้เพิ่มเติม  <i class="fa fa-chevron-right" aria-hidden="true"></i></p></a>
                </center>
                </div>
         </div>
        
  
        <div class="span3" ><!-- Office 365 Home Plan 2 -->
             <div class="plan-gs" style="height: 500px; text-align: center;">
                <p class="color-blue-s txt-price-top">$10.00 </p>
                <p style=" margin-top: -25px;    margin-bottom: 25px;">ผู้ใช้/เดือน</p>
                <p class="txt-price-small" style="font-size: 18px;">(ข้อตกลงแบบรายปี)</p>
               <select class="plan-office365" name="">
                  <option value="#">1 ปี $10.00 ผู้ใช้/เดือน</option>
                  <option value="#">1เดือน $10.00  ผู้ใช้/เดือน</option>
                </select>
                <p class="txt-price-small">Office 365 Business Premium</p>
                <button class="btn-buy" style="margin-top: 58px; margin-bottom: 10px;">ซื้อทันที</button>
                
                <p style=" margin-top: 5px;    margin-bottom: 25px; font-size: 15px;">ราคายังไม่รวมภาษี</p>
                
                
                <hr style="border-top: 2px solid #cccccc;"/>
                <center>
                <a href="#"><p class="txt-price-detill" style="font-size: 18px;">ทอลองใช้ฟรี  <i class="fa fa-chevron-right" aria-hidden="true"></i></p></a>
                <br/>
                <a href="#"><p class="txt-price-detill" style="font-size: 18px;">เรียนรู้เพิ่มเติม  <i class="fa fa-chevron-right" aria-hidden="true"></i></p></a>
                </center>
                
                </div>
         </div>
     
        <div class="span3" ><!-- Office 365 Home Plan 3 -->
             <div class="plan-gs" style="height: 500px; text-align: center;">
                 <p class="color-blue-s txt-price-top" >$2.50 </p>
                <p style=" margin-top: -25px;    margin-bottom: 25px;">ผู้ใช้/เดือน</p>
                <p class="txt-price-small" style="font-size: 18px;">(ข้อตกลงแบบรายปี)</p>
               <select class="plan-office365" name="">
                  <option value="#">1 ปี $5.50 ผู้ใช้/เดือน</option>
                  <option value="#">1เดือน $3.00  ผู้ใช้/เดือน</option>
                </select>
                <p class="txt-price-small">Office 365 Business Essentials</p>
                <button class="btn-buy" style="margin-top: 57px; margin-bottom: 10px;">ซื้อทันที</button>
                <p style=" margin-top: 5px;    margin-bottom: 25px; font-size: 15px;">ราคายังไม่รวมภาษี</p>
                <hr style="border-top: 2px solid #cccccc;"/>
                <center>
                <a href="#"><p class="txt-price-detill" style="font-size: 18px;">เรียนรู้เพิ่มเติม <i class="fa fa-chevron-right" aria-hidden="true"></i></p></a>
                </center>
                
  
           </div>
         
    
    
       </div>
         
  </div>
</div> 
<!-- Business  -->

    <div id="Student" class="tab-pane fade">
      <h3>&nbsp;&nbsp;&nbsp;</h3>
      <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
    </div>
         </div>
       </div>
   
      </div>
  </div>
