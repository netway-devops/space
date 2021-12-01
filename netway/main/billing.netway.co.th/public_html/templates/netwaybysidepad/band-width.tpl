{php}
$templatePath   = $this->get_template_vars('template_path');
include($templatePath . 'banwidth.php');
{/php}
{literal}
<style>
    #custom-search-form {
        margin:0;
        margin-top: 5px;
        padding: 0;
    }
 
    #custom-search-form .search-query {
        padding-right: 3px;
        padding-right: 4px \9;
        padding-left: 3px;
        padding-left: 4px \9;
        /* IE7-8 doesn't have border-radius, so don't indent the padding */
 
        margin-bottom: 0;
        -webkit-border-radius: 3px;
        -moz-border-radius: 3px;
        border-radius: 3px;
    }
 
    #custom-search-form button {
        border: 0;
        background: none;
        /** belows styles are working good */
        padding: 2px 5px;
        margin-top: 2px;
        position: relative;
        left: -28px;
        /* IE7-8 doesn't have border-radius, so don't indent the padding */
        margin-bottom: 0;
        -webkit-border-radius: 3px;
        -moz-border-radius: 3px;
        border-radius: 3px;
    }
 
    .search-query:focus + button {
        z-index: 3;   
    }
    input[type="search"].txt-kb {
        width: 205px;
        height: 25px;
        font-size: 16px;
        font-weight: 100;
        border-radius: 30px;
        margin-top: 15px;
    }
    .btn-search {
        border: none;
        color: #FFFFFF;
        background-color: #1473e6;
        padding: 8px 27px;
        font-size: 16px;
        font-weight: 600;
        text-decoration: none;
        margin-top: 15px;
        border-radius: 30px;
    }
    .btn-search:hover {
        border: none;
        color: #FFFFFF;
        background-color: #3899e4;
        padding: 8px 27px;
        font-size: 16px;
        font-weight: 600;
        text-decoration: none;
        margin-top: 15px;
        border-radius: 30px;
    }
    section.hero {     
        background: #FC466B;
        background: -webkit-linear-gradient(to right, #3F5EFB, #FC466B); 
        background: linear-gradient(to right, #3F5EFB, #FC466B);
        height: 300px;
    }  
      @media only all and (max-width: 768px) {
          section.hero {
            background: #FC466B;
            background: -webkit-linear-gradient(to right, #3F5EFB, #FC466B); 
            background: linear-gradient(to right, #3F5EFB, #FC466B);
        height:200px;
        }  
    }
     @media only all and (max-width: 480px) {  
        section.hero {
            background: #FC466B;
            background: -webkit-linear-gradient(to right, #3F5EFB, #FC466B); 
            background: linear-gradient(to right, #3F5EFB, #FC466B);
            height:200px;
        }
    }  
    .re-txt-banner {
        font-size: 32px;
        font-family: 'Prompt', sans-serif; 
        font-style: normal;
        font-weight: 500;
        color: #fff;
        margin-top: 10px;
    }
        
   
    .nw-banner {
        color: #FFF;
        text-align: center;
        font-size: 35px;
        font-family: 'Prompt', sans-serif;
        font-weight: bold;
        line-height: 40px;    
        background-color: transparent;
    }

/*button Calculator*/
.BUTTON_YPS {
    background-image: -webkit-linear-gradient(top, #001EE3, #0C0040);
    background-image: -moz-linear-gradient(top, #001EE3, #0C0040);
    background-image: -ms-linear-gradient(top, #001EE3, #0C0040);
    background-image: -o-linear-gradient(top, #001EE3, #0C0040);
    background-image: linear-gradient(to bottom, #001EE3, #0C0040);
    -webkit-border-radius: 20px;
    -moz-border-radius: 20px;
    border-radius: 20px;
    color: #FFFFFF;
    font-family: sans-serif;    
    font-size: 26px;
    font-weight: 700;
    padding: 29px;
    box-shadow: 0px 0px 11px 0px #000000;
    -webkit-box-shadow: 0px 0px 11px 0px #000000;
    -moz-box-shadow: 0px 0px 11px 0px #000000;
    border: solid #000000 0px;
    text-decoration: none;
    display: inline-block;
    cursor: pointer;
    width: 253px;
    margin: 26px 120px 10px 119px;
}

.BUTTON_YPS:hover {

    color: #FFFFFF;
    font-family: sans-serif;
    font-size: 26px;
    font-weight: 700;
    padding: 29px;
    width: 253px;
    margin: 26px 120px 10px 119px;
    background: #004F00;
    background-image: -webkit-linear-gradient(top, #004F00, #4E9C09);
    background-image: -moz-linear-gradient(top, #004F00, #4E9C09);
    background-image: -ms-linear-gradient(top, #004F00, #4E9C09);
    background-image: -o-linear-gradient(top, #004F00, #4E9C09);
    background-image: linear-gradient(to bottom, #004F00, #4E9C09);
    text-decoration: none;
 }


li.tab{
    border-radius: 3px; 
    padding: 25px 30px;
    display: flex;justify-content: space-between; 
    margin-bottom: 10px;
}
  li.table-header {
    background: linear-gradient(to right, #3F5EFB, #445DF7);
    font-size: 22px;
    color: #FFFFFF;
    text-transform: uppercase;
    letter-spacing: 0.03em;
    padding: 39px 54px 0px 17px;
    font-weight: bold;
    margin-bottom: 0px;
    height: 95px;
    font-family: sans-serif;
  }
  .cal-row{
    font-size: 32px;
    letter-spacing: 0.03em;
    padding: 59px 50px 0px 50px;
    font-weight: 500;
    margin-bottom: 30px;
    height: 142px;
    font-family: sans-serif;
}
  li.table-row {
    background-color: #ffffff;
    box-shadow: 0px 0px 9px 0px rgba(0,0,0,0.1);
  }
  .col-1 {
    flex-basis: 74%;
  }
  .col-2 {
    flex-basis: 26%;
  }
  
  
  @media all and (max-width: 767px) {
    .table-header {
      display: none;
    }
    .table-row{
      
    }
   
    .col {
        width: 100%;
    }
    .col {
      display: flex;
      padding: 10px 0;
     
    }
 }

</style>   
{/literal}
<section class="hero " >
        <div class="container" >
            <div class="row hidden-phone" >
                <div class="span7">
                    <div class="hero-inner">
                       <h2 class="re-txt-banner" style="font-size: 45px; font-weight: 300;margin-top: 150px; "> 
                           Bandwidth Calculator  
                       </h2>             
                    </div>
               </div>
              <div class="span5">
                <img src="https://netway.co.th/templates/netwaybysidepad/images/Video-Tutorials-min.png" alt="video-tutorial" 
                style=" margin-top: 50px;">
            </div>
        </div>
         <div class="row visible-phone">
            <div class="span12">              
               <h2 class="nw-banner" style="font-size: 38px; font-weight: 500;margin-top:80px; "> 
                    Bandwidth Calculator 
              </h2>                  
            </div>
           </div>    
        </div>
    </section>
    <div class="row-fluid">
        <div class="container">
            <div class="span12" style="margin-top:70px;  margin-bottom: 30px; color: #414141; font-weight:300; font-size: 20px;  line-height: 30px; ">
                <div class="span12">
                    <center>
                        <h3 class="h3-titel-content txt36" font-family:="" 'prompt',="" sans-serif;="">ตรวสอบ Bandwidth</h3>
                            <span class="nw-2018-content-line"></span>
                    </center>
                </div>
            </div> 
            <div class="span12 dynamic-content hidden-phone">
                <p style="text-align: justify; line-height: 30px;font-size: 20px;text-indent:35px;">             
                        ก่อนเริ่มใช้งาน Office 365 จะต้องวางแผนการใช้งาน Internet Bandwidth เสียก่อน 
                    เพื่อไม่ให้เกิดผลกระทบกับระบบเน็ตเวิร์คในปัจจุบัน <br/>โดยสามารถประมาณการ Internet Bandwidth เบื้องต้นได้ 
                    เพียงแค่ระบุรายละเอียดการใช้งาน Office 365 ตามรายละเอียดด้านล่าง
                </p>    
            </div>
            <div class="span12 dynamic-content visible-phone">
                <p style="text-align:left;line-height: 30px;font-size: 18px; text-indent:35px;padding: 0px 5px 0px 5px;">             
                        ก่อนเริ่มใช้งาน Office 365 จะต้องวางแผนการใช้งาน Internet Bandwidth เสียก่อน 
                    เพื่อไม่ให้เกิดผลกระทบกับระบบเน็ตเวิร์คในปัจจุบัน โดยสามารถประมาณการ Internet Bandwidth เบื้องต้นได้ 
                    เพียงแค่ระบุรายละเอียดการใช้งาน Office 365 ตามรายละเอียดด้านล่าง
                </p>    
            </div>
       
       </div>
    </div>
    <div class="row hidden-phone" style="background: #ededed;margin-top: 70px;">    
        <div class="container" style="margin-top: 70px;margin-bottom: 70px;">    
            <div class="span8">       
              <ul>
                <li class="tab table-row">
                    <div class="col col-1">จำนวนผู้ใช้งาน Office 365 ผ่าน Outlook Web Access (OWA)</div>
                    <div class="col col-2" > 
                        <input type="number" min='0' name="q4" value="0" id="qty4" style="margin-bottom: 0px !important;height: 30px;width: 90px;text-align: center;" >
                    </div>
                </li>
                <li class="tab table-row">
                    <div class="col col-1">จำนวนผู้ใช้งาน Office 365 ผ่าน Outlook on Desktop</div>
                    <div class="col col-2" > 
                        <input type="number" min='0' name="q6" value="0" id ="qty6" style="margin-bottom: 0px !important;height: 30px;width: 90px;text-align: center;" >
                  </div>
                </li>
                <li class="tab table-row">
                    <div class="col col-1">จำนวนผู้ใช้งาน Sharepoint</div>
                    <div class="col col-2" > 
                        <input type="number"  min='0' name="q8" value="0" id="qty8" style="margin-bottom: 0px !important;height: 30px;width: 90px;text-align: center;">
                    </div>
                </li>
                <li class="tab table-row">
                    <div class="col col-1">จำนวนผู้ใช้งาน Skype Video calling (high-quality)</div>
                    <div class="col col-2" >
                        <input type="number" min='0' name="q10" value="0" id="qty10"style="margin-bottom: 0px !important;height: 30px;width: 90px;text-align: center;" >
                    </div>
                </li> 
                <li class="tab table-row">
                    <div class="col col-1">จำนวนผู้ใช้งาน Skype Video calling (HD)</div>
                    <div class="col col-2" > 
                        <input type="number" min='0' name="q12" value="0" id="qty12" style="margin-bottom: 0px !important;height: 30px;width: 90px;text-align: center;" >
                    </div>
                </li>
                <li class="tab table-row">
                    <div class="col col-1">จำนวนผู้ใช้งาน Skype Group video (3 people)</div>
                    <div class="col col-2" > 
                        <input type="number" min='0' name="q14" value="0" id="qty14" style="margin-bottom: 0px !important;height: 30px;width: 90px;text-align: center;" >
                    </div>
                </li>
                <li class="tab table-row">
                    <div class="col col-1">จำนวนผู้ใช้งาน Skype Group video (5 people)</div>
                    <div class="col col-2" > 
                        <input type="number" min='0' name="q16" value="0" id="qty16" style="margin-bottom: 0px !important;height: 30px;width: 90px;text-align: center;" >
                    </div>
                </li>
                 <li class="tab table-row">
                    <div class="col col-1">จำนวนผู้ใช้งาน Skype Group video (7+ people)</div>
                    <div class="col col-2" > 
                        <input type="number"min='0' min="0" name="q18" value="0" id="qty18" style="margin-bottom: 0px !important;height: 30px;width: 90px;text-align: center;" >
                    </div>
                </li>
              </ul>
           </div>
           <div class="span4" style="width: 450px;">    
               <ul>
                    <li class="tab table-header">
                        <div class="col col-1">Download</div>
                        <div class="col col-2">Upload</div>
                    </li>
                    <li class="tab table-row cal-row" style="padding: 48px 48px 45px 38px;">
                        <div class="col col-1"><span id ='download' >0.00</span></div>
                        <div class="col col-2"><span id ='upload'   >0.00</span></div> 
                    </li>
                </ul>
                <button type="button" class=" mm BUTTON_YPS span5" >Calculator</button>
           </div>      
  </div>  
</div>

<div class="row visible-phone" style="background: #ededed;margin-top: 70px;">    
        <div class="container" style="margin-top: 8px;margin-bottom: 25px;">    
            <div class="span8">       
              <ul  style="margin: 0px">
                <li class="tab table-row">
                    <div class="col col-1">จำนวนผู้ใช้งาน Office 365 ผ่าน Outlook Web Access (OWA)</div>
                    <div class="col col-2" > 
                        <input type="number" min='0' name="q4" value="0" id="qtyP4" style="margin-bottom: 0px !important;height: 30px;width: 90px;text-align: center;" >
                    </div>
                </li>
                <li class="tab table-row">
                    <div class="col col-1">จำนวนผู้ใช้งาน Office 365 ผ่าน Outlook on Desktop</div>
                    <div class="col col-2" > 
                        <input type="number" min='0' name="q6" value="0" id ="qtyP6" style="margin-bottom: 0px !important;height: 30px;width: 90px;text-align: center;" >
                  </div>
                </li>
                <li class="tab table-row">
                    <div class="col col-1">จำนวนผู้ใช้งาน Sharepoint</div>
                    <div class="col col-2" > 
                        <input type="number"  min='0' name="q8" value="0" id="qtyP8" style="margin-bottom: 0px !important;height: 30px;width: 90px;text-align: center;">
                    </div>
                </li>
                <li class="tab table-row">
                    <div class="col col-1">จำนวนผู้ใช้งาน Skype Video calling (high-quality)</div>
                    <div class="col col-2" >
                        <input type="number" min='0' name="q10" value="0" id="qtyP10"style="margin-bottom: 0px !important;height: 30px;width: 90px;text-align: center;" >
                    </div>
                </li> 
                <li class="tab table-row">
                    <div class="col col-1">จำนวนผู้ใช้งาน Skype Video calling (HD)</div>
                    <div class="col col-2" > 
                        <input type="number" min='0' name="q12" value="0" id="qtyP12" style="margin-bottom: 0px !important;height: 30px;width: 90px;text-align: center;" >
                    </div>
                </li>
                <li class="tab table-row">
                    <div class="col col-1">จำนวนผู้ใช้งาน Skype Group video (3 people)</div>
                    <div class="col col-2" > 
                        <input type="number" min='0' name="q14" value="0" id="qtyP14" style="margin-bottom: 0px !important;height: 30px;width: 90px;text-align: center;" >
                    </div>
                </li>
                <li class="tab table-row">
                    <div class="col col-1">จำนวนผู้ใช้งาน Skype Group video (5 people)</div>
                    <div class="col col-2" > 
                        <input type="number" min='0' name="q16" value="0" id="qtyP16" style="margin-bottom: 0px !important;height: 30px;width: 90px;text-align: center;" >
                    </div>
                </li>
                 <li class="tab table-row">
                    <div class="col col-1">จำนวนผู้ใช้งาน Skype Group video (7+ people)</div>
                    <div class="col col-2" > 
                        <input type="number"min='0' min="0" name="q18" value="0" id="qtyP18" style="margin-bottom: 0px !important;height: 30px;width: 90px;text-align: center;" >
                    </div>
                </li>
              </ul>
           </div>
           <div class="span3" style=" margin-top: 30px;">    
               <ul style="margin: 0px;">
                    <li class="tab table-header">
                        <div class="col col-1">Download</div>
                        <div class="col col-2">Upload</div>
                    </li>
                    <li class="tab table-row cal-row" style="padding: 48px 48px 45px 38px;">
                        <div class="col col-1"><span id ='downloadP' >0.00</span></div>
                        <div class="col col-2"><span id ='uploadP'   >0.00</span></div> 
                    </li>
                </ul>
                <center >
                    <button  type="button" class="btn-readmore-2018 span5"  style=" font-size: 24px; width: 158px; height: 52px;margin-top: 22px;" >
                        Calculator
                    </button>
                </center>
           </div>      
  </div>  
</div>

{literal}
<script>

 $(document).ready(function(){
  $('#qty4, #qty6,#qty8,#qty10,#qty12,#qty14,#qty16,#qty18').keyup(function () { this.value = this.value.replace(/[^0-9]/g,''); });
  $('#qtyP4, #qtyP6,#qtyP8,#qtyP10,#qtyP12,#qtyP14,#qtyP16,#qtyP18').keyup(function () { this.value = this.value.replace(/[^0-9]/g,''); });      
  $('.BUTTON_YPS').click(function() {
   var $this = $(this);
    var loadingText = '<i class="fa fa-spinner fa-spin" style="font-size:20px"></i>&nbsp;Calculating...';
    if ($(this).html() !== loadingText) {
      $this.data('original-text', $(this).html());
      $this.html(loadingText);
    }
    setTimeout(function() {
      $this.html($this.data('original-text'));
   }, 500);

          calBanwidth();
   });
   $('.btn-readmore-2018').click(function() {
          phone_calBanwidth();
   });

});

function calBanwidth() {
   var result4 = $('#qty4').val();
   var result6 = $('#qty6').val();
   var result8 = $('#qty8').val();
   var result10 = $('#qty10').val();
   var result12 = $('#qty12').val();
   var result14 = $('#qty14').val();
   var result16 = $('#qty16').val();
   var result18 = $('#qty18').val();
   
   var download4 = $('#qty4').val()*0.0071;
   var download6 = $('#qty6').val()*0.0055+0.57;
   var download8  =  $('#qty8').val()*0.0032;
   var download10 = $('#qty10').val()*0.5;
   var download12 = $('#qty12').val()*1.5;
   var download14 = $('#qty14').val()*2;
   var download16 = $('#qty16').val()*4;
   var download18 = $('#qty18').val()*8;
   
   var upload4  = $('#qty4').val()*0.0023;
   var upload6  = $('#qty6').val()*0.0014;
   var upload8  = $('#qty8').val()*0;
   var upload10 = $('#qty10').val()*0.5;
   var upload12 = $('#qty12').val()*1.5;
   var upload14 = $('#qty14').val()*0.512;
   var upload16 = $('#qty16').val()*0.512;
   var upload18 = $('#qty18').val()*0.512;
   
   var totalDown = 0
   var totalUp   = 0
   
       if(result6 !=0){
            totalDown =parseFloat((download4+download6)+download8+download10+download12+download14+download16+download18).toFixed(3);
                document.getElementById("download").innerHTML = totalDown ;
            
            totalUp =parseFloat((upload4+upload6)+upload8+upload10+upload12+upload14+upload16+upload18).toFixed(3);
                document.getElementById("upload").innerHTML = totalUp ;
       }else{
           totalDown =parseFloat(download4+download8+download10+download12+download14+download16+download18).toFixed(3);
                document.getElementById("download").innerHTML = totalDown ;
           
           totalUp =parseFloat(upload4+upload8+upload10+upload12+upload14+upload16+upload18).toFixed(3);
                document.getElementById("upload").innerHTML = totalUp ;
        }
}

function phone_calBanwidth() {
   var result4 = $('#qtyP4').val();
   var result6 = $('#qtyP6').val();
   var result8 = $('#qtyP8').val();
   var result10 = $('#qtyP10').val();
   var result12 = $('#qtyP12').val();
   var result14 = $('#qtyP14').val();
   var result16 = $('#qtyP16').val();
   var result18 = $('#qtyP18').val();
   
   var download4 = $('#qtyP4').val()*0.0071;
   var download6 = $('#qtyP6').val()*0.0055+0.57;
   var download8 = $('#qtyP8').val()*0.0032;
   var download10 = $('#qtyP10').val()*0.5;
   var download12 = $('#qtyP12').val()*1.5;
   var download14 = $('#qtyP14').val()*2;
   var download16 = $('#qtyP16').val()*4;
   var download18 = $('#qtyP18').val()*8;
   
   var upload4  = $('#qtyP4').val()*0.0023;
   var upload6  = $('#qtyP6').val()*0.0014;
   var upload8  = $('#qtyP8').val()*0;
   var upload10 = $('#qtyP10').val()*0.5;
   var upload12 = $('#qtyP12').val()*1.5;
   var upload14 = $('#qtyP14').val()*0.512;
   var upload16 = $('#qtyP16').val()*0.512;
   var upload18 = $('#qtyP18').val()*0.512;
   
   var totalDown = 0
   var totalUp   = 0
   
       if(result6 !=0){
            totalDown =parseFloat((download4+download6)+download8+download10+download12+download14+download16+download18).toFixed(3);
                document.getElementById("downloadP").innerHTML = totalDown ;
            
            totalUp =parseFloat((upload4+upload6)+upload8+upload10+upload12+upload14+upload16+upload18).toFixed(3);
                document.getElementById("uploadP").innerHTML = totalUp ;
       }else{
           totalDown =parseFloat(download4+download8+download10+download12+download14+download16+download18).toFixed(3);
                document.getElementById("downloadP").innerHTML = totalDown ;
           
           totalUp =parseFloat(upload4+upload8+upload10+upload12+upload14+upload16+upload18).toFixed(3);
                document.getElementById("uploadP").innerHTML = totalUp ;
        }
}


 </script>
{/literal}