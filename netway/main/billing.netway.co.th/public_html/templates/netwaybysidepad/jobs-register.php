<?php

 $emailTo = "hr@netwaygroup.com";
 $subject = "JobApply";

if(isset($_POST['submit']) && $_POST['submit'] == 'Send'){
    $position   = isset( $_POST['position']) ? $_POST['position'] : '';  
    $title      = isset( $_POST['title']) ? $_POST['title'] : ''; 
    $firstName  = isset( $_POST['firstname']) ? $_POST['firstname'] : '-';   
    $lastName   = isset( $_POST['lastname']) ? $_POST['lastname'] : '-'; 
    $nickName   = isset( $_POST['nickname']) ? $_POST['nickname'] : '-';  
    $firstThai  = isset( $_POST['firstThai']) ? $_POST['firstThai'] : '-';
    $lastThai   = isset( $_POST['lastThai']) ? $_POST['lastThai'] : '-';  
    $nicknameThai   = isset( $_POST['nickThai']) ? $_POST['nickThai'] : '-';   
    $birthday   = isset( $_POST['bday']) ? date('m-d-Y', strtotime($_POST['bday'])) : '-';    
    $age        = isset( $_POST['age']) ? $_POST['age'] : 0;  
    $national   = isset( $_POST['national']) ? $_POST['national'] : '-';
    $phone      = isset( $_POST['phone']) ? $_POST['phone'] : 0;
    $backUpPhone  = isset( $_POST['backupphone']) ? $_POST['backupphone'] : 0; 
    $email      = isset( $_POST['email']) ? $_POST['email'] : '';
    $degree     = isset( $_POST['degree']) ? $_POST['degree'] : '';
    $university = isset( $_POST['university']) ? $_POST['university'] : '-';
    $address    = isset( $_POST['address']) ? $_POST['address'] : '-';
    $datestart  = isset( $_POST['datestart']) ? date('m-d-Y', strtotime($_POST['datestart'])) : '-';
    $flexible   = isset( $_POST['flexible']) ? $_POST['flexible'] : '-';
 
     if($position =='accounting' ){
        $position ='Admin Accounting';
     }else if($position =='backEnd'){
        $position = 'Backend Developer (PHP)';
     }else if($position =='content'){
        $position ='Content Marketer';
     }else if($position =='fontEnd'){
        $position ='Front-End Developer';
     }else if($position =='fullstack'){
        $position ='Full-Stack Developer';
     }else if($position =='htmlEditor'){
        $position ='HTML Editor';
     }else if($position =='it-support'){
        $position ='IT Support';
     }else if($position =='office365'){
        $position ='Office 365 Specialist';
     }else if($position =='php-dev'){
        $position ='PHP Developer';
     }else if($position =='saleAdmin'){
        $position ='Sale Admin';
     }else if($position =='technicalSupport'){
        $position ='Technical Support';
     }else if($position =='webDesigner'){
        $position ='Web Designer';
     }
     else if($position =='webProgrammer'){
        $position ='Web Programmer (.NET)';
     }else{
        $position ='Windows System Administrator';
     }

     if($title =='Mr.'){
         $titleThai = 'นาย';
     }if ($title =='Miss'){
         $titleThai = 'นางสาว';
     }
     if($title =='Mrs.'){
         $titleThai = 'นาง';
     }
     if ($degree == 'bachelor'){
        $degree = 'ปริญญาตรี';
    }else if ($degree == 'master'){
        $degree = 'ปริญญาโท';
    
    }else if ($degree == 'master'){
        $degree = 'ปริญญาโท';
    }
    else{
        $degree = 'อื่นๆ';
    }

    $message  = "Position (แหน่งงานที่สมัคร) :  ".$position."\n";
    $message .= "Firstname : \t".$title ." ".$firstName."\n"."Last Name : \t".$lastName."\nNickname:\t".$nickName."\n";
    $message .= "ชื่อ (ภาษาไทย) : \t".$titleThai ." ".$firstThai."\nนามสกุล (ภาษาไทย):\t".$lastThai."\nชื่อเล่น (ภาษาไทย):\t".$nicknameThai."\n"; 
    $message .= "Date of Birth (วันเกิด) : \t".$birthday."\nAge (อายุ): \t".$age."\nNationality (สัญชาติ):\t".$national."\n"; 
    $message .= "Mobile Number (เบอร์โทรศัพท์) : \t".$phone."\nEmergency Number (เบอร์สำรอง): \t".$backUpPhone."\n";
    $message .= "Email: \t".$email."\n";
    $message .= "Education Lavel (ระดับการศึกษา) :\t ".$degree."\n";
    $message .= "University/Institute(มหาวิทยาลัย/สถาบัน):\t ".$university."\n";
    $message .= "Current Address(ที่อยุ่ปัจจุบัน) :\t ".$address."\n";
    $message .= "Date of start(วันที่พร้อมเริ่มงาน) : \t".$datestart."\n";
    $message .= "Able to work in flexible shifts? :\t ".$flexible."\n";
    $header =  "From: ".$email ;

      if(mail($emailTo, $subject, $message,$header)) {
          echo "<script type='text/javascript'>alert('Thank you for contacting us! We will contact you as soon as we review your message');</script>";
       }else{
          header("HTTP/1.1 301 Moved Permanently");      
          header('Location: https://netway.co.th/jobs');
          exit(); 
     
      }
}     
















