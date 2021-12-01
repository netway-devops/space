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
        background-image: url(https://netway.co.th/templates/netwaybysidepad/images/bg-office-bandwidth-min.png);
	    background-repeat: no-repeat;
	    background-size: cover;
        background-position: center;
        height: 300px;
    }  
      @media only all and (max-width: 768px) {
          section.hero {

            height:200px;
        }  
    }
     @media only all and (max-width: 480px) {  
        section.hero {
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
    letter-spacing: 0.03em;
    padding: 40px 0px 1px 17px;
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
     background-color: #f8f8f8 !important;
     border: 1px solid #e5e7f6;
     box-shadow: inset 0 1px 1px rgba(0,0,0,0.05);

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
                       <h2 class="re-txt-banner" style="font-size: 38px; font-weight: 600; margin-top: 150px; color: #191c3c;"> 
                           Bandwidth Calculator  
                       </h2>             
                    </div>
               </div>
              <div class="span5">
                <img src="https://netway.co.th/templates/netwaybysidepad/images/img-office-bandwidth-min.png" alt="Office365 Bandwidth" 
                style=" margin-top: 19px; max-width: 150%;">
            </div>
        </div>
         <div class="row visible-phone">
            <div class="span12">              
               <h2 class="nw-banner" style="font-size: 29px; font-weight: 600;margin-top:80px;     color: #191c3c;"> 
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
                        <h3 class="h3-titel-content txt36" >วิธีการตรวจสอบ Bandwidth</h3>
                            <span class="nw-2018-content-line"></span>
                    </center>
                </div>
            </div> 
            <div class="span12 dynamic-content hidden-phone">
                <p class="g-txt18" style="text-align: justify; padding: 0px 0px 0px 60px;">             
                     ขั้นตอนก่อนเริ่มใช้งาน Office 365 ควรมีการบริหารจัดการ Internet Bandwidth ภายในองค์กรเป็นลำดับแรก เพื่อไม่ให้เกิดผลกระทบกับระบบเน็ตเวิร์คที่ใช้อยู่ในปัจจุบัน โดยสามารถประมาณการ Internet Bandwidth เบื้องต้นเพียงแค่ระบุรายละเอียดที่ต้องการใช้งาน Office 365  ของคุณตามรายละเอียดด้านล่าง
                </p>    
            </div>
            <div class="span12 dynamic-content visible-phone">
                <p style="text-align: justify; line-height: 30px;font-size: 18px; padding: 0px 20px 0px 20px;">             
                      ขั้นตอนก่อนเริ่มใช้งาน Office 365 ควรมีการบริหารจัดการ Internet Bandwidth ภายในองค์กรเป็นลำดับแรก เพื่อไม่ให้เกิดผลกระทบกับระบบเน็ตเวิร์คที่ใช้อยู่ในปัจจุบัน โดยสามารถประมาณการ Internet Bandwidth เบื้องต้นเพียงแค่ระบุรายละเอียดที่ต้องการใช้งาน Office 365  ของคุณตามรายละเอียดด้านล่าง
                </p>    
            </div>
       
       </div>
    </div>
    <div class="row hidden-phone g-txt18" style="margin-top: 70px;">    
        <div class="container" style="margin-top: 70px;margin-bottom: 70px;">    
            <div class="span8">       
              <ul>
                <li class="tab table-row">
                    <div class="col col-1">จำนวนผู้ใช้งาน Office 365 ผ่าน Outlook Web Access (OWA)</div>
                    <div class="col col-2" > 
                        <input type="number" min='0'max='5000' name="q4" value="0" id="qty4" style="margin-bottom: 0px !important;height: 30px;width: 90px;text-align: center;"oninput="calBanwidth()" >
                    </div>
                    <p>User</p>
                </li>
                <li class="tab table-row">
                    <div class="col col-1">จำนวนผู้ใช้งาน Office 365 ผ่าน Outlook on Desktop</div>
                    <div class="col col-2" > 
                        <input type="number" min='0' max='5000' name="q6" value="0" id ="qty6" style="margin-bottom: 0px !important;height: 30px;width: 90px;text-align: center;"oninput="calBanwidth()" >
                  </div>
                    <p>User</p>
                </li>
                <li class="tab table-row">
                    <div class="col col-1">จำนวนผู้ใช้งาน SharePoint</div>
                    <div class="col col-2" > 
                        <input type="number"  min='0'max='5000' name="q8" value="0" id="qty8" style="margin-bottom: 0px !important;height: 30px;width: 90px;text-align: center;"oninput="calBanwidth()">
                    </div>
                    <p>User</p>
                    
                </li>
                <li class="tab table-row">
                    <div class="col col-1">จำนวนผู้ใช้งาน Skype Video Calling(High-Quality)</div>
                    <div class="col col-2" >
                        <input type="number" min='0' max='5000' name="q10" value="0" id="qty10"style="margin-bottom: 0px !important;height: 30px;width: 90px;text-align: center;"oninput="calBanwidth()" >
                    </div>
                    <p>User</p>
                </li> 
                <li class="tab table-row">
                    <div class="col col-1">จำนวนผู้ใช้งาน Skype Video Calling(HD)</div>
                    <div class="col col-2" > 
                        <input type="number" min='0' max='5000' name="q12" value="0" id="qty12" style="margin-bottom: 0px !important;height: 30px;width: 90px;text-align: center;"oninput="calBanwidth()" >
                    </div>
                    <p>User</p>
                </li>
                <li class="tab table-row">
                    <div class="col col-1">จำนวนผู้ใช้งาน Skype Group Video (3 People)</div>
                    <div class="col col-2" > 
                        <input type="number" min='0' max='5000' name="q14" value="0" id="qty14" style="margin-bottom: 0px !important;height: 30px;width: 90px;text-align: center;"oninput="calBanwidth()" >
                    </div>
                    <p>Group</p>
                </li>
                <li class="tab table-row">
                    <div class="col col-1">จำนวนผู้ใช้งาน Skype Group Video (5 People)</div>
                    <div class="col col-2" > 
                        <input type="number" min='0' max='5000' name="q16" value="0" id="qty16" style="margin-bottom: 0px !important;height: 30px;width: 90px;text-align: center;"oninput="calBanwidth()" >
                    </div>
                    <p>Group</p>
                </li>
                 <li class="tab table-row">
                    <div class="col col-1">จำนวนผู้ใช้งาน Skype Group Video (7+ People)</div>
                    <div class="col col-2" > 
                        <input type="number"min='0' max='5000' min="0" name="q18" value="0" id="qty18" style="margin-bottom: 0px !important;height: 30px;width: 90px;text-align: center;"oninput="calBanwidth()" >
                    </div>
                    <p>Group</p>
                </li>
              </ul>
           </div>
           <div class="span4" style="width: 450px;">    
               <ul>
                    <li class="tab table-header">
                        <div class="col col-1 g-tx18" style="flex-basis: 54%; font-size: 18px;"><i class="fa fa-arrow-circle-o-down" aria-hidden="true" style="font-size: 24px;"></i> Download (Mbps)</div>
                        <div class="col col-2 g-tx18" style="flex-basis: 46%; font-size: 18px;"><i class="fa fa-arrow-circle-o-up" aria-hidden="true" style="font-size: 24px;"></i> Upload   (Mbps)</div>
                    </li>
                    <li class="tab table-row cal-row" style="padding: 48px 48px 45px 38px;">
                        <div class="col col-1"><span id ='download' >0.00</span></div>
                        <div class="col col-2"><span id ='upload'   >0.00</span></div> 
                    </li>
                </ul>
                       <center>
                       <a href="https://support.netway.co.th/hc/th/requests/new?ticket_form_id=114093963072&request_subject= ขอข้อมูลเพิ่มเติมและราคาผลิตภัณฑ์  office 365   ">
                       <button class="btn-check-border" style=" margin-left: 10%; ">ขอข้อมูลและราคา  <i class="fa fa-chevron-right" aria-hidden="true"></i> </button></a>
                       </center>
           </div>     
  </div>  
</div>

<div class="row visible-phone" style="background: #ededed;margin-top: 70px; font-size: 0.9em;">    
        <div class="container" style="margin-top: 8px;margin-bottom: 25px;">    
                 <div class="span3" style=" margin-top: 30px;">    
               <ul style="margin: 0px;">
                    <li class="tab table-header">
                        <div class="col col-1"><i class="fa fa-arrow-circle-o-down" aria-hidden="true"></i> Download</div>
                        <div class="col col-2"><i class="fa fa-arrow-circle-o-up" aria-hidden="true"></i> Upload</div>
                    </li>
                    <li class="tab table-row cal-row" style="padding: 48px 48px 45px 38px;">
                        <div class="col col-1"><span id ='downloadP' >0.00</span></div>
                        <div class="col col-2"><span id ='uploadP'   >0.00</span></div> 
                    </li>
                </ul>
                       <center>
                       <a href="https://support.netway.co.th/hc/th/requests/new?ticket_form_id=114093963072&request_subject= ขอข้อมูลเพิ่มเติมและราคาผลิตภัณฑ์  office 365   ">
                       <button class="btn-check-border" style=" margin-left: 10%; ">ขอข้อมูลและราคา  <i class="fa fa-chevron-right" aria-hidden="true"></i> </button></a>
                       </center>
           </div>  
            <div class="span8">       
              <ul  style="margin: 0px">
                <li class="tab table-row">
                    <div class="col col-1">จำนวนผู้ใช้งาน Office 365 ผ่าน Outlook Web Access (OWA)</div>
                    <div class="col col-2" > 
                        <input type="number" min='0' name="q4" value="0" id="qtyP4" style="margin-bottom: 0px !important;height: 30px;width: 90px;text-align: center;"oninput="phone_calBanwidth()" >
                    </div>
                    <p style="margin-top: 14px;  margin-left: 10px;">User</p>
                </li>
                <li class="tab table-row">
                    <div class="col col-1">จำนวนผู้ใช้งาน Office 365 ผ่าน Outlook on Desktop</div>
                    <div class="col col-2" > 
                        <input type="number" min='0' name="q6" value="0" id ="qtyP6" style="margin-bottom: 0px !important;height: 30px;width: 90px;text-align: center;"oninput="phone_calBanwidth()" >
                  </div>
                  <p style="margin-top: 14px;  margin-left: 10px;">User</p>
                </li>
                <li class="tab table-row">
                    <div class="col col-1">จำนวนผู้ใช้งาน SharePoint</div>
                    <div class="col col-2" > 
                        <input type="number"  min='0' name="q8" value="0" id="qtyP8" style="margin-bottom: 0px !important;height: 30px;width: 90px;text-align: center;"oninput="phone_calBanwidth()">
                    </div>
                    <p style="margin-top: 14px;  margin-left: 10px;">User</p>
                </li>
                <li class="tab table-row">
                    <div class="col col-1">จำนวนผู้ใช้งาน Skype Video Calling(High-Quality)</div>
                    <div class="col col-2" >
                        <input type="number" min='0' name="q10" value="0" id="qtyP10"style="margin-bottom: 0px !important;height: 30px;width: 90px;text-align: center;"oninput="phone_calBanwidth()" >
                    </div>
                    <p style="margin-top: 14px;  margin-left: 10px;">User</p>
                </li> 
                <li class="tab table-row">
                    <div class="col col-1">จำนวนผู้ใช้งาน Skype Video Calling(HD)</div>
                    <div class="col col-2" > 
                        <input type="number" min='0' name="q12" value="0" id="qtyP12" style="margin-bottom: 0px !important;height: 30px;width: 90px;text-align: center;"oninput="phone_calBanwidth()" >
                    </div>
                    <p style="margin-top: 14px;  margin-left: 10px;">User</p>
                </li>
                <li class="tab table-row">
                    <div class="col col-1">จำนวนผู้ใช้งาน Skype Group Video (3 People)</div>
                    <div class="col col-2" > 
                        <input type="number" min='0' name="q14" value="0" id="qtyP14" style="margin-bottom: 0px !important;height: 30px;width: 90px;text-align: center;"oninput="phone_calBanwidth()" >
                    </div>
                    <p style="margin-top: 14px;  margin-left: 10px;">Group</p>
                </li>
                <li class="tab table-row">
                    <div class="col col-1">จำนวนผู้ใช้งาน Skype Group Video (5 People)</div>
                    <div class="col col-2" > 
                        <input type="number" min='0' name="q16" value="0" id="qtyP16" style="margin-bottom: 0px !important;height: 30px;width: 90px;text-align: center;"oninput="phone_calBanwidth()" >
                    </div>
                    <p style="margin-top: 14px;  margin-left: 10px;">Group</p>
                </li>
                 <li class="tab table-row">
                    <div class="col col-1">จำนวนผู้ใช้งาน Skype Group Video (7+ People)</div>
                    <div class="col col-2" > 
                        <input type="number"min='0' min="0" name="q18" value="0" id="qtyP18" style="margin-bottom: 0px !important;height: 30px;width: 90px;text-align: center;" oninput="phone_calBanwidth()">
                    </div>
                    <p style="margin-top: 14px;  margin-left: 10px;">Group</p>
                </li>
              </ul>
           </div>
         
  </div>  
</div>

{literal}
<script>

 $(document).ready(function(){
     
  $('#qty4, #qty6,#qty8,#qty10,#qty12,#qty14,#qty16,#qty18').keyup(function () { this.value = this.value.replace(/[^0-9]/g,''); });
  $('#qtyP4,#qtyP6,#qtyP8,#qtyP10,#qtyP12,#qtyP14,#qtyP16,#qtyP18').keyup(function () { this.value = this.value.replace(/[^0-9]/g,''); });      
  
 
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
            totalDown =parseFloat((download4+download6)+download8+download10+download12+download14+download16+download18).toFixed(2);
                document.getElementById("download").innerHTML = totalDown ;
            
            totalUp =parseFloat((upload4+upload6)+upload8+upload10+upload12+upload14+upload16+upload18).toFixed(2);
                document.getElementById("upload").innerHTML = totalUp ;
       }else{
           totalDown =parseFloat(download4+download8+download10+download12+download14+download16+download18).toFixed(2);
                document.getElementById("download").innerHTML = totalDown ;
           
           totalUp =parseFloat(upload4+upload8+upload10+upload12+upload14+upload16+upload18).toFixed(2);
                document.getElementById("upload").innerHTML = totalUp ;
        }
            
     if((result4 != 0 )|| (result6 != 0 )|| (result8 != 0 )|| (result10 != 0 )|| (result12 != 0) || (result14!= 0) ||  (result16 != 0 )|| (result18 != 0 ) ){
          $('.table-header').css('background','#ff480b') ;
          $('.btn-check-border').css('background','linear-gradient(90deg,#2948ff,#396afc)');
          $('.btn-check-border').css('color','#FFFFFF');
        }
      if((result4 == 0 )&& (result6 == 0 )&& (result8 == 0 )&& (result10 == 0 )&& (result12 == 0) && (result14== 0) &&  (result16 == 0 )&& (result18 == 0 )){
          $('.table-header').css('background','linear-gradient(to right, #3F5EFB, #445DF7)') ;
          $('.btn-check-border').css('background','transparent');
          $('.btn-check-border').css('color','#2948ff');
          
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
            totalDown =parseFloat((download4+download6)+download8+download10+download12+download14+download16+download18).toFixed(2);
                document.getElementById("downloadP").innerHTML = totalDown ;
            
            totalUp =parseFloat((upload4+upload6)+upload8+upload10+upload12+upload14+upload16+upload18).toFixed(2);
                document.getElementById("uploadP").innerHTML = totalUp ;
       }else{
           totalDown =parseFloat(download4+download8+download10+download12+download14+download16+download18).toFixed(2);
                document.getElementById("downloadP").innerHTML = totalDown ;
           
           totalUp =parseFloat(upload4+upload8+upload10+upload12+upload14+upload16+upload18).toFixed(2);
                document.getElementById("uploadP").innerHTML = totalUp ;
        }
}


 </script>
{/literal}