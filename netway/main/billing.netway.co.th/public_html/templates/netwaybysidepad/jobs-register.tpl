
{php}
$templatePath   = $this->get_template_vars('template_path');
include($templatePath . 'jobs-register.php');

{/php}



{literal}
    
    <style>

#d1 {
    margin: 15px 32px;
    height: 485px;
    width: 585px;
    display: inline-block;
    overflow-x: hidden;
}
#d1i{
    margin: 0px;
    padding: 25px 70px;
    height: auto;
    width: 630px;
    display: block;
    overflow: hidden;
}

.join-us-banner{
    background-repeat: no-repeat;
    height: 750px;
    background-attachment: inherit;
    background-size: cover;
    background-position: center;
}
*[role="form"] {
    max-width: 685px;
    padding: 17px;
    height: 620px;
    margin: 0 auto;
    border-radius: 0.3em;
    background-color: #ededed5e;
    box-shadow:rgba(79, 79, 79, 0.65) 4px -2px 9px -1px;
}

*[role="form"] h1 { 
    font-family: 'Open Sans' , sans-serif;
    font-weight: 600;
    color: #000000;
    margin-top: 15px;
    text-align: center;
    text-transform: uppercase;
    letter-spacing: 1px;
}

.colInput > select {
    width: 300px;
    
}
.form-control {
    
    width: 300px;
    font-size: 16px;
    color: #555;
    background-color: #fff;
    background-image: none;
    border: 1px solid #ccc;
    border-radius: 4px;
    -webkit-box-shadow: inset 0 1px 1px rgba(0,0,0,.075);
    box-shadow: inset 0 1px 1px rgba(0,0,0,.075);
    -webkit-transition: border-color ease-in-out .15s,-webkit-box-shadow ease-in-out .15s;
    -o-transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;
    transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;
   
    box-shadow: inset 0 1px 1px rgba(0,0,0,.075);
   
}
textarea,input[type="text"],input[type="date"],input[type="number"], input[type="email"],input[type="tel"]{
    font-size: 16px;
    color: #555;
    padding: 16px 10px;
}

.form-horizontal .form-group {
    margin-right: 0px;
    margin-left: -15px;
    margin-bottom: 15px;
}


.form-horizontal .control-label {
    padding-top: 0px;
    margin-bottom: 0;
    text-align: right;
    font-size: 16px;
}

td.colName{
    padding-bottom: 0px;
    padding-top: 25px;
   
}
td.colInput{
    padding-bottom: 0px;
    padding-top: 8px;
   
}
@media (max-width: 480px){
    .join-us-banner {
        background-repeat: no-repeat;
        height: 640px;
        background-attachment: inherit;
        background-size: cover;
        background-position: center;
    }
    *[role="form"] {
        max-width: 346px;
        padding: 17px;
        height: 535px;
        margin: 0 auto;
        border-radius: 0.3em;
        background-color: #ededed5e;
        box-shadow: rgba(79, 79, 79, 0.65) 4px -2px 9px -1px;
    }
    #d1i {
        margin: 0px;
        padding: 0px 12px;
        height: auto;
        width: 260px;
        display: block;
        overflow: hidden;
    }
    #d1 {
        margin: 15px 17px;
        height: 360px;
        width: 282px;
        display: inline-block;
        overflow-x: hidden;
    }
    .form-horizontal select,.form-horizontal textarea,.form-horizontal input {
          width: 230px;
    }
    .colInput > input[type="radio"]{
        width: 27px;
    }
    td.colInput {
        padding-bottom: 0px;
        padding-top: 8px;
        font-size: 14px;
    } 
    
    
}

/*@media (max-width: 767px)
{
    .join-us-banner {
        background-repeat: no-repeat;
        height: 640px;
        background-attachment: inherit;
        background-size: cover;
        background-position: center;
    }
    *[role="form"] {
    max-width: 346px;
    padding: 17px;
    height: 535px;
    margin: 0 auto;
    border-radius: 0.3em;
    background-color: #ededed5e;
    box-shadow: rgba(79, 79, 79, 0.65) 4px -2px 9px -1px;
    }
    #d1i {
        margin: 0px;
        padding: 0px 12px;
        height: auto;
        width: 260px;
        display: block;
        overflow: hidden;
    }
    #d1 {
        margin: 15px 17px;
        height: 360px;
        width: 282px;
        display: inline-block;
        overflow-x: hidden;
    }
    .form-horizontal select,.form-horizontal textarea,.form-horizontal input {
          width: 230px;
    }
    td.colInput {
        padding-bottom: 0px;
        padding-top: 8px;
        font-size: 14px;
    }
        
}*/




</style>

<script></script>
 
{/literal}
<div class="join-us-banner lazy-hero"  data-src="/templates/netwaybysidepad/images/bg-job2018-min.png" style="height: 300px;">
    <div>&nbsp;</div>
    <div class="row-fluid" style="height: 100%;">
        <div class="span4"></div>
        <div class="span4" align="center" style=" height: 100%;">
                <div style="margin: 70px 0 0 0; height: 70px; width: 100%;" align="center">
                    <p style="font-family: 'Prompt', sans-serif; font-size: 42px; opacity: 1; letter-spacing: 2px; padding-top:30px; color: #FFF;">
                        ร่วมงานกับเรา
                    </p>
                </div>
        </div>
        <div class="span4"></div>
    </div>
</div>  
<div class="row-fluid" >
    <div class="container hidden-phone" style="text-align: center;margin-top: 60px">        
        <p class="h3-title-content re-topic" style="font-family: 'Prompt', sans-serif;font-size: 32px;font-weight: 500;">Why Netway</p>               
    </div>
    <div class="container visible-phone" style="text-align: center;margin-top: 60px" >        
        <p class="h3-title-content re-topic" style="font-family: 'Prompt', sans-serif;font-size: 27px;font-weight: 500;">Why Netway</p>               
    </div>
    <div class=" container hidden-phone " style="margin-top: 20px;text-align: left;line-height: 26px;font-size: 21px;">
       <p>
       เริ่มต้นจากความเป็นผู้นำแห่งโลกออนไลน์ด้วยบริการรับจดโดเมน และเนื้อที่เพื่อสร้างเว็บไซต์ให้แก่บุคคลทั่วไปและองค์กรทุกขนาด 
       <br>จนถึงความเชี่ยวชาญด้านระบบความปลอดภัยที่หลายคนไว้วางใจเสมอมา ปัจจุบันหลายคนจึงเริ่มต้นมองหาโซลูชันด้านเว็บโฮสติ้งจาก <br>Netway Communication เสมอ 
       และด้วยความเอาใจใส่ที่ดีจากพนักงานและผู้เชี่ยวชาญที่เรามี ลูกค้าของเราจึงได้รับการดูแลอย่างเต็มที่ตลอด 24 ชั่วโมง
     </p>
    </div>
    <div class=" container visible-phone " style="margin-top: 20px;text-align: left;line-height: 26px;font-size: 14px;padding: 0px 3px 0px 9px;">
        <p>
       เริ่มต้นจากความเป็นผู้นำแห่งโลกออนไลน์ด้วยบริการรับจดโดเมนและเนื้อที่เพื่อสร้างเว็บไซต์ให้แก่บุคคลทั่วไปและองค์กรทุกขนาด 
       จนถึงความเชี่ยวชาญด้านระบบความปลอดภัยที่หลายคนไว้วางใจเสมอมา ปัจจุบันหลายคนจึงเริ่มต้นมองหาโซลูชันด้านเว็บโฮสติ้งจาก Netway Communication เสมอ 
       และด้วยความเอาใจใส่ที่ดีจากพนักงานและผู้เชี่ยวชาญที่เรามี ลูกค้าของเราจึงได้รับการดูแลอย่างเต็มที่เสมอตลอด 24 ชั่วโมง
     </p>
    </div>
</div>

<div class="join-us-banner lazy-hero" data-src="/templates/netwaybysidepad/images/joinjob2.jpg">
   
    <div class="row-fluid" style="margin-top: 25px;" >
           <div class="container " style="margin-top: 45px; margin-bottom: 20px;" >
                <form class="form-horizontal" role="form" method="post" action="" enctype="multipart/form-data">  
                    <h1 class="hidden-phone" style="font-size: 26px !important">Personal Information</h1>
                    <h1 class="visible-phone" style="font-size: 22px !important">Personal Information</h1>
                      <div id="d1" style="background-color:#ffffffbd;">
                        <div id="d1i">
                            <table class="">
                                <tr>
                                    <td class="colName"> <b>Select the position to apply (เลือกตำแหน่งงานที่คุณสนใจสมัคร)</b> </td>
                                </tr>
                                <tr>
                                    <td class="colInput">
                                        <select name="position" required >
                                            <option   value="">Position</option>
                                            <option   value="accounting">Admin Accounting </option>
                                            <option   value="backEnd">Backend Developer (PHP)</option>
                                            <option   value="content">Content Marketer</option>
                                            <option   value="fontEnd">Front-End Developer</option>
                                            <option   value="fullstack">Full-Stack Developer</option>
                                            <option   value="htmlEditor">HTML Editor</option>
                                            <option   value="it-support">IT Support</option>
                                            <option   value="office365">Office 365 Specialist</option>
                                            <option   value="php-dev">PHP Developer</option>
                                            <option   value="saleAdmin">Sale Admin</option>
                                            <option   value="technicalSupport">Technical Support</option>
                                            <option   value="webDesigner" >Web Designer</option>
                                            <option   value="webProgrammer">Web Programmer (.NET)</option>
                                            <option   value="windowsAdmin">Windows System Administrator</option>
                                        </select>
                                    </td>
                                </tr>
                                  <tr>
                                    <td class="colName"> <b>Title (คำนำหน้า)</b> </td>
                                </tr>
                                <tr>
                                    <td class="colInput hidden-phone">  
                                        <input  type="radio" name="title" value="Mr."   required > &nbsp;Mr. (นาย) 
                                        <input type="radio" name="title" value="Miss"  style ="margin-left: 20px;" > &nbsp;Miss (นางสาว) 
                                        <input type="radio" name="title" value="Mrs."   style ="margin-left: 20px;" > &nbsp;Mrs.(นาง)     
                                    </td>
                                    <td class="colInput visible-phone">  
                                        <input  type="radio" name="title" value="Mr."   required > &nbsp;Mr. (นาย) 
                                        <br><input type="radio" name="title" value="Miss"   > &nbsp;Miss (นางสาว) 
                                        <br><input type="radio" name="title" value="Mrs."   > &nbsp;Mrs.(นาง)     
                                    </td>
                                </tr>
                                <tr>
                                    <td class="colName"> <b>First name (English)</b></td>
                                </tr>
                                <tr>
                                    <td class="colInput"> 
                                        <input type="text" name="firstname" class="form-control"  required>                                
                                    </td>
                                </tr>
                                <tr>
                                    <td class="colName"><b>Last name (English)</b></td>
                                </tr>
                                <tr>
                                    <td  class="colInput">
                                        <input type="text" name="lastname" class="form-control"  required>
                                    </td>
                                </tr>
                                <tr>
                                    <td  class="colName"> <b>Nickname (English)</b> </td>
                                </tr>
                                <tr>
                                    <td  class="colInput">
                                        <input type="text" name="nickname" class="form-control"  required>
                                    </td>
                                </tr>
                                <tr>
                                    <td  class="colName"> <b>ชื่อ (ภาษาไทย)</b></td>
                                </tr>
                                <tr>
                                    <td  class="colInput">
                                        <input type="text" name="firstThai" class="form-control" required>
                                    </td>
                                </tr>
                                <tr>
                                    <td  class="colName"> <b>นามสกุล (ภาษาไทย)</b> </td>
                                </tr>
                                <tr>
                                    <td  class="colInput">
                                        <input type="text" name="lastThai" class="form-control" required>
                                    </td>
                                </tr>
                                <tr>
                                    <td  class="colName"> <b>ชื่อเล่น (ภาษาไทย)</b></td>
                                </tr>
                                <tr>
                                    <td  class="colInput">
                                         <input type="text" name="nickThai" class="form-control" required>
                                    </td >
                                </tr>
                                <tr>
                                    <td class="colName" > <b>Date of Birth (วันเกิด)</b></td>
                                </tr>
                                 <tr>
                                    <td  class="colInput">
                                         <input type="date" name="bday" class="form-control" min="1970-01-01"   required>
                                    </td>
                                </tr>
                               <tr>
                                    <td  class="colName"><b>Age (อายุ)</b></td>
                                </tr>
                                <tr>
                                    <td  class="colInput">
                                        <input type="number" name="age" class="form-control"  min="23" max="40" required>
                                    </td>
                                </tr>
                                <tr>
                                    <td  class="colName"><b>Nationality (สัญชาติ)</b> </td>
                                </tr>
                                <tr>
                                    <td  class="colInput">
                                         <input type="text" name="national" class="form-control" required>
                                    </td>
                                </tr>
                                 <tr>
                                    <td  class="colName"> <b>Mobile Number (เบอร์โทรศัพท์)</b></td>
                                </tr>
                                <tr>
                                    <td  class="colInput">
                                        <input type="number" name="phone"  pattern="/^-?\d+\.?\d*$/" onKeyPress="if(this.value.length==10) return false;"  class="form-control" required/>
                                    </td>
                                </tr>
                                <tr>
                                    <td  class="colName"> <b>Emergency Number (เบอร์สำรองหรือเบอร์ติดต่อฉุกเฉิน)</b> </td>
                                </tr>
                                <tr>
                                    <td  class="colInput">
                                        <input type="number" name="backupphone" pattern="/^-?\d+\.?\d*$/" onKeyPress="if(this.value.length==10) return false;"   class="form-control" required/>
                                    </td>
                                </tr>
                                <tr>
                                    <td  class="colName"> <b>Email</b> </td>
                                </tr>
                                <tr>
                                    <td  class="colInput">
                                        <input type="email"  class="form-control" name= "email" required >
                                    </td>
                                </tr>
                               <tr>
                                    <td  class="colName"><b>Education Lavel (ระดับการศึกษา)</b></td>
                                </tr>
                                <tr>
                                    <td  class="colInput">
                                        <select name="degree" required>
                                            <option   value="">ระดับการศึกษา</option>
                                            <option   value="bachelor"> ปริญญาตรี</option>
                                            <option   value="master"> ปริญญาโท</option>
                                            <option   value="doctor"> ปริญญาเอก</option>
                                            <option   value="certificate">ปวช.-ปวส.</option>
                                            <option   value="other">อื่นๆ</option>
                                        </select>
                                    </td>
                                </tr>
                                 <tr>
                                    <td  class="colName"> <b>University/Institute(มหาวิทยาลัย/สถาบัน)</b></td>
                                </tr>
                                <tr>
                                    <td  class="colInput">
                                        <input type="text" name="university" placeholder="กรุณาระบุชื่อมหาวิทยาลัย/สถาบัน" class="form-control" required>
                                    </td>
                                </tr>
                                <tr>
                                    <td  class="colName">  <b>Current Address(ที่อยุ่ปัจจุบัน)</b> </td>
                                </tr>
                                <tr>
                                    <td  class="colInput">
                                        <textarea rows="4" cols="50" name ="address"  class="form-control" required> </textarea>
                                    </td>
                                </tr>
                                <tr>
                                    <td  class="colName"><b>Date of start(วันที่พร้อมเริ่มงาน)</b> </td>
                                </tr>
                                <tr>
                                    <td  class="colInput">
                                        <input type="date" name="datestart" class="form-control" required>
                                    </td>
                                </tr>
                                <tr>
                                    <td  class="colName"> <b>Able to work in flexible shifts?</b> (ท่านสามารถทำงานเป็นกะได้ หรือ ไม่ )</b></td>
                                </tr>
                                <tr>
                                    <td  class="colInput">
                                      <input type="radio" name="flexible" value="yes" checked> Yes 
                                      <input type="radio" name="flexible" value="no" style="margin-left: 20px;"> No
                                    </td>
                                </tr>
                                <tr>
                                    <td  class="colName">
                                      <input type="submit" name ='submit' class="btn btn-primary btn-block" value='Send'>
                                    </td>
                                </tr>
                               
                            </table>
                        </form> <!-- /form -->
                    </div> <!-- ./container -->
                </div>
            </div> 
        </div>
</div>    
