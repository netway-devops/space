{literal}
    <style>
    .join-us-banner{
        height: 364px;
        background: url(https://netway.co.th/templates/netwaybysidepad/images/hot_pro.jpeg);
        background-repeat: no-repeat;
        background-size: contain;
        background-position: center;
        width: auto;
        background-attachment: initial;
    }

        .expo { width:100%;}
        
        ul > li {
            line-height: 30px;
        }
        .hot-pro{
            font-size: 16px;
            width: 340px;
            height: 30px !important;
        }.topic-label{
            font-size:16px;
        }
        .close-btn{
            color: #fff;
            background: #6d6b6b;
            text-shadow: none;
            width: 80px;
            border: 1px solid #15151500;
            padding: 9px 0px 9px 0px;
        }
        .close-btn:hover{
            color: #101010;
            background: #e0e0e0;
            border: 1px solid #565656;
        }
        .submit-btn{
            color: #fff;
            background: #004994;
            text-shadow: none;
            width: 80px !important;
            padding: 9px 0px 9px 0px;
            border: 1px solid #15151500;
            font-size:16px;
        }
        .submit-btn:hover{
          color: #101010;
          background: #e0e0e0;
          border: 1px solid #004994;  
         }
        .cancel-btn{
            color: #fff;
            background: #000;
            text-shadow: none;
            width: 80px !important;
            padding: 9px 0px 9px 0px;
            border: 1px solid #15151500;
            font-size:16px;
            text-transform: unset;
        }
        .cancel-btn:hover{
          color: #000;
          background: #fff;
          border: 1px solid #000;   
        }   
      
        .btn-cloud{
            background-color: #ffffff;
           border: 2px solid #ff3600;
            color: #ff3600;
            font-style: normal;
            font-size: 19px;
            padding: 7px 10px;
            margin-top: 17px;
            font-weight: 500;
            border-radius: 27px;
            
        }
         .btn-cloud:hover{
            background: linear-gradient(to right, #f7b733, #fc4a1a); 
            color: #fff;
            
        }
        .contact-hotpro{
            border: 1px solid #d0d0d0; 
            padding: 10px 20px;
            width: 475px;
            margin-left: 205px;
            border-radius: 14px;
            box-shadow: 1px 1px 9px 0px #c5c5c5;
        }
        @media screen and (max-width: 768px) {
            .join-us-banner{
                background: url(https://netway.co.th/templates/netwaybysidepad/images/hot_pro_phone.jpeg);
                background-repeat: no-repeat;
                background-size: contain;
                background-position: top;
                width: 100%;
                background-attachment: initial;
                height: 190px;
                margin: 0px 0px;
            }
        }
    </style>
    <script>
    $(document).ready(function () {
         
        $(".contact-hotpro").hide();
        $(".btn-cloud").click(function() {
            $(".contact-hotpro").toggle('slow');
        });
        $(".cancel").click(function(){
            $(".contact-hotpro").toggle( 'slow');
        });
        
    });
    function submitHotpro(){
        
            var subject = $('.subject-hotpro').val();
            var email   = $('.email-hotpro').val();
            var phone   = $('.phone-hotpro').val();
            var comment = $('.message-hotpro').val();
                    console.log(subject+''+email+''+phone+''+comment);
                    $.post( "?cmd=zendeskhandle&action=cloudHotPromo", 
                    {
                        subject  : subject,
                        name     : name ,
                        email    : email,
                        comment  : comment ,
                        phone    : phone 
                       
                    },function( data ) {
                        $('div.modal-body').html("<p  style=\"font-size: 18px;font-family: Roboto, Arial, sans-serif; margin: 28px 7px;\">Your information has been sent to our team to contact you back.</p>");
                        document.getElementById('contactForm').reset();
                        $('#alreadySend').modal('toggle');
                    });
    
    }

</script>
{/literal}
<div class=" container hidden-phone lazy-hero join-us-banner "> </div>
<div class=" container visible-phone lazy-hero join-us-banner "> </div>     
    <div class="row-fluid hidden-phone">
        <div class="container " style="margin-top: 50px;" >        
                <center>
                    <p class="h3-title-content re-topic" style="font-size:32px;margin: 50px 0px -12px 0px;letter-spacing: 3px;font-weight:600">โปรร้อนปรอทแตก <img src="/templates/netwaybysidepad/images/fire.png" style="width: 50px; height: auto;"></p>
                    <span class="nw-2018-content-line" > </span>
                </center>
                <p style="margin: 50px 0px 20px 20px;line-height: 33px;text-align: justify;font-size: 20px;font-weight: 500;color: #0e0e0e;">
                    <span style="color: #ed2124;font-weight: 600;font-size: 22px;letter-spacing: 1px;"> #โปรร้อนลดปรอทแตก!! </span><br>
                    อากาศที่ว่าร้อน ยังร้อนไม่เท่า #โปรร้อนปรอทแตก โปรโมชั่น Hot Hot แบบนี้สำหรับลูกค้าที่ซื้อ Cloud Server กับ Netway เท่านั้น 
                    <br>ไม่ว่าจะเป็น Basic VPS, VMware หรือ Dedicated Server<span style="font-size: 20px;font-weight: 600;"> เมื่อซื้อแบบ 1 ปี เราให้ใช้ ฟรีอีก 3 เดือน </span>
                </p>
                    <p style="font-size: 22px;font-weight: 600;color:red;letter-spacing: 1px;margin: 10px 0px 10px 20px;">ย้ำ! ซื้อ Cloud Server ราคาเริ่มต้น 5,389.20 บ./ปี แถมฟรี 3 เดือนนะคะ</p>
                 <p style="margin:0px 0px 20px 20px;line-height: 33px;text-align: justify;font-size: 20px;font-weight: 500;color: #0e0e0e;">  
                   และพิเศษยิ่งไปกว่านั้น คือ<img src="/templates/netwaybysidepad/images/freeword.png" style="width: 69px;margin: -13px 6px;"><b style="font-size: 19px;">Wireless Mouse</b> สีร้อนปรอทแตก ให้สำหรับทุก Order เลยค่ะ 
              </p>
                <br> <br>
          </div>
        </div>  
    <div class="row-fluid visible-phone">
        <div class="container " style="margin-top: 30px;" >        
                <center>
                    <p class="h3-title-content re-topic" style="font-size:27px;margin: 0px 10px -12px 21px;font-weight: 600">โปรร้อนปรอทแตก<img src="/templates/netwaybysidepad/images/fire.png" style="width: 50px; height: auto;"></p> 
                    <span class="nw-2018-content-line" > </span>
                </center>
             <p style="margin: 25px 10px 10px 10px;line-height: 30px;font-size: 18px;font-weight: 500;color: #0e0e0e;">
                <span style="color: #ed2124;font-weight: 600;font-size: 20px;letter-spacing: 1px;"> #โปรร้อนลดปรอทแตก!! </span><br>
                อากาศที่ว่าร้อน ยังร้อนไม่เท่า #โปรร้อนลดปรอทแตก โปรโมชั่น Hot Hot แบบนี้สำหรับลูกค้าที่ซื้อ Cloud Server กับ Netway เท่านั้น ไม่ว่าจะเป็น Basic VPS, VMware หรือ Dedicated Server 
                <br>
                <span style="font-size: 18px;font-weight: bold"> เมื่อซื้อแบบ 1 ปี เราให้ใช้ฟรี 3 เดือน</span> 
            </p>
             <p style="margin: 0px 10px 10px 10px;color: #ed2124;font-weight: 600;font-size: 20px;letter-spacing: 1px;">ย้ำ! ซื้อ Cloud Server ราคาเริ่มต้น 5,389.20 บ./ปี แถมฟรี 3 เดือนนะคะ</p>
             <p style="margin:0px 10px 0px 10px;line-height: 30px;font-size: 18px; font-weight: 500; color: #0e0e0e">
                <span style="color: #000000;font-size: 18px;font-weight: bold;">" พิเศษ " แถมฟรี Wireless Mouse </span> สำหรับทุก Orderเลยค่ะ</p>
                <br>
          </div>
        </div>     
            
    <div class="row-fluid hidden-phone">
        <div class="container"  style="margin-top:0px;margin-bottom: 0px;">             
         <div  style="margin-left: 25px;">
                        <img src="/templates/netwaybysidepad/images/210label.png" style="width: 215px; height: 35px;margin: 0px 0px 30px 0px;">
                        <p style="font-weight:600;margin: -57px 0px 0px 20px;text-align: left;font-size: 20px;color: #fff;">
                            เงื่อนไขโปรโมชั่น
                        </p> 
                        <p style="margin: 25px 0px 0px 0px;font-size: 18px;color: #000;line-height: 35px;">
                         <img src="/templates/netwaybysidepad/images/icons-tell.png" style="width: 30px;">&nbsp;&nbsp;ขอสงวนสิทธิ์ในการรับโปรโมชั่นให้กับลูกค้าที่สั่งซื้อเครื่องใหม่เท่านั้น <br>
                         <img src="/templates/netwaybysidepad/images/icons-tell.png" style="width: 30px;">&nbsp;&nbsp;สิ้นสุดโปรโมชั่น 31 พฤษภาคม 2562 
                        </p> 
                    </div>
                    <div  id="contact"  style="margin-left: 25px;">
                         <button  class="btn-cloud" > สนใจคลิก <i class="fa fa-chevron-right" aria-hidden="true"></i></button>
                    </div>
           </div>
        </div>     
        
         <div class="row-fluid visible-phone">
        <div class="container"  style="margin-top:0px;margin-bottom: 0px;">             
         <div  style="margin-left: 15px;margin-right: 10px;">
                        <img src="/templates/netwaybysidepad/images/210label.png" style="width: 100%; height: 40px;margin: 0px 0px 30px 0px;">
                        <p style="font-weight:600;margin:-57px 0px 0px -20px;font-size: 20px;color: #fff;text-align: center;">
                            เงื่อนไขโปรโมชั่น
                        </p> 
                        <p style="margin: 25px 0px 0px 0px;font-size: 18px;color: #000;line-height: 35px;">
                         <img src="/templates/netwaybysidepad/images/icons-tell.png" style="width: 28px;">&nbsp;&nbsp;ขอสงวนสิทธิ์ในการรับโปรโมชั่น<br>ให้กับลูกค้าที่สั่งซื้อเครื่องใหม่เท่านั้น <br>
                         <img src="/templates/netwaybysidepad/images/icons-tell.png" style="width: 28px;">&nbsp;&nbsp;สิ้นสุดโปรโมชั่น 31 พฤษภาคม 2562 
                        </p> 
                    </div>
                    <div  id="contact"  style="margin-left: 25px;">
                         <button  class="btn-cloud" > สนใจคลิก <i class="fa fa-chevron-right" aria-hidden="true"></i></button>
                    </div>
           </div>
        </div>  
        
        
            
        <div class="row-fluid form-hotpro hidden-phone"  >
            <div class="container"  style="margin-top: 30px;margin-bottom: 30px;">             
                <div id="contact-hotpro" class="contact-hotpro">
                    <div >
                        <p style="font-size: 18px;font-weight: 600">ขอใบเสนอราคา</p>
                    </div>
                    <form id="contactForm" name="contact"  method="post" onsubmit="submitHotpro()" >
                        <div class="" style="margin: 0px 15px;">                
                            <div class="form-group">
                                <label for="name" class="topic-label">Topic</label>
                                <input type="text" name="subject" class='hot-pro form-control  subject-hotpro' value="#โปรร้อนปรอทแตก" disabled>
                            </div>
                            <div class="form-group">
                                <label for="email" class="topic-label">Email Address</label>
                                <input type="email" name="email" class='hot-pro email-hotpro' required="required">
                            </div>
                            <div class="form-group"> 
                                <label for="name" class="topic-label">Phone Number</label>
                                <input type="tel" name="phone"  class='hot-pro  phone-hotpro'  minlength="9" maxlength="14" required="required">
                            </div>
                            <div class="">
                                <label for="message" class="topic-label" >Message</label>
                                <textarea name="message" class="message-hotpro"  style="font-size: 16px; width: 340px;height: 85px;"></textarea>
                            </div>                  
                        </div>
                        <div class="" style="margin: 0px 15px;">                  
                            <input type="button" name="cancel" value="Cancel" class="btn cancel-btn cancel"  />
                            <input type="submit" class="btn submit-btn"   value="ส่งข้อมูล">
                        </div>
                    </form>
                </div> 
            </div> 
        </div> 
        
        
        <div class="row-fluid form-hotpro visible-phone"  >
            <div class="container"  style="margin-top: 30px;margin-bottom: 30px;">             
                <div id="contact-hotpro" class="contact-hotpro" style="width: 339px;margin-left: 10px;margin-right: 10px;">
                    <div >
                        <p style="font-size: 18px;font-weight: 600">ขอใบเสนอราคา</p>
                    </div>
                    <form id="contactForm" name="contact"  method="post" onsubmit="submitHotpro()">
                        <div class="" style="margin: 0px 0px;">                
                            <div class="form-group">
                                <label for="name" class="topic-label">Topic</label>
                                <input type="text" name="subject" class='hot-pro form-control  subject-hotpro' value="#โปรร้อนปรอทแตก" disabled style="width: 308px;">
                            </div>
                            <div class="form-group">
                                <label for="email" class="topic-label">Email Address</label>
                                <input type="email" name="email" class='hot-pro email-hotpro' required="required" style="width: 308px;">
                            </div>
                            <div class="form-group"> 
                                <label for="name" class="topic-label">Phone Number</label>
                                <input type="tel" name="phone"  class='hot-pro  phone-hotpro'  minlength="9" maxlength="14" required="required" style="width: 308px;">
                            </div>
                            <div class="">
                                <label for="message" class="topic-label" >Message</label>
                                <textarea name="message" class="message-hotpro"  style="font-size: 16px; width: 308px;height: 72px;"></textarea>
                            </div>                  
                        </div>
                        <div class="" style="text-align: center;">                  
                            <input type="button" name="cancel" value="Cancel" class="btn cancel-btn cancel" style="padding: 5px 0px 5px 0px;" />
                            <input type="submit" class="btn submit-btn"   style="padding: 5px 0px 5px 0px;" value="ส่งข้อมูล">
                        </div>
                    </form>
                </div> 
            </div> 
        </div> 
                
    <div class="row-fluid ">
        <div class="container hidden-phone" style="margin-top: 0px ;margin-bottom: 0px;" >  
                <div >
                    <p style="margin: 0px 0px 20px 25px;  line-height: 28px;  text-align: left;font-size: 18px;">
                        <span style="font-size: 20px;">สนใจสอบถามข้อมูล <span style="color: #ed2124;">#โปรร้อนลดปรอทแตก</span> หรือสั่งซื้อ สามารถติดต่อ Netway Communication ได้ตลอด 24 ชม.</span> <br>
                         <img src="https://netway.co.th/templates/netwaybysidepad/images/icon_mail.png"  style="width: 42px;">
                         E-mail: <a href = "mailto:support@netway.co.th?subject=โปรร้อนลดปรอทแตก" >support@netway.co.th</a>
                        <br>
                        <img src="https://netway.co.th/templates/netwaybysidepad/images/icon_phone.png"style="width: 42px;"> 
                         Tel: 02-912-2558-64 
                    </p>
                </div>                 
        </div>  
        <div class="container visible-phone" style="margin-top: 0px ;margin-bottom: 0px;" >  
                <div >
                    <p style="margin: 0px 10px 0px 10px;  line-height: 28px;  text-align: left;">
                        <span style="font-size: 18px;">สนใจสอบถามข้อมูล <span style="color: #ed2124;">#โปรร้อนลดปรอทแตก</span> หรือสั่งซื้อ สามารถติดต่อ Netway Communication ได้ตลอด 24 ชม.</span> <br>
                         <img src="https://netway.co.th/templates/netwaybysidepad/images/icon_mail.png"  style="width: 32px;">
                        <span style="font-size: 16px;"> E-mail: <a href = "mailto:support@netway.co.th?subject=โปรร้อนลดปรอทแตก" >support@netway.co.th</span></a>
                        <br>
                        <img src="https://netway.co.th/templates/netwaybysidepad/images/icon_phone.png" style="width: 32px;"> 
                        <span style="font-size: 16px;"> Tel: 02-912-2558-64 </span>
                    </p>
                </div>                 
        </div>  
        
        
    </div>
    <div class="modal fade " id="alreadySend" role="dialog" aria-hidden="false" style="display: none;">
    <div >
      <img style="height: 90px;text-align: center;margin-top: 20px;" src="/templates/netwaybysidepad/images/checkmark-submit.png">
      <div class="modal-body hidden-phone" >
      
      </div>  
      <div class="modal-body visible-phone" >
      
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal" style ="font-size: 18px; margin-bottom: 7px;padding: 6px 15px 6px 15px;color: #fffcfc;background: #005426;font-weight: 500;text-shadow:unset;">
            OK
        </button>
      </div>
      </div>
    </div>
 
