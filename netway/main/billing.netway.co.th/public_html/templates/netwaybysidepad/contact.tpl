
{literal}
    <style>
        .bg {
       
                background-repeat: no-repeat;
                background-size: cover;
                background-position: top;
                background-attachment: fixed;
                text-align: center;
                height: 320px;
                width: 100%;
            }    
       .bg-back {
            background: rgba(0, 24, 192, 0.5);
            height: 320px;
        }
    </style>
{/literal}

{php}
$date_now = date("Y-m-d");
$date_show = '2020-07-29';
$this->assign('date_now',$date_now);
$this->assign('date_show',$date_show);
{/php}
<!-- ******************** Start AddThis ******************** -->
<div class="pathway-inpage">
	{include file='addthis.tpl'}
</div>
<!-- ******************** End AddThis ******************** -->   
<div class="bg hidden-phone lazy-hero" data-src="/templates/netwaybysidepad/images/bg-contectus.png">
  <div class="bg-back">   
        <div class="container" >
            <div class="row" style="padding: 80px 0 30px 0; text-align: center;">
				   <h3 class="h3-titel-content g-txt30"  style="color: #FFF;">ติดต่อเรา</h3>
            </div>
        </div>
    </div>
</div>   
<div class="container">
<div class="row-fluid">
<div class="row">  
 {if $date_now < $date_show }  
<div class="span6 hidden-phone">    
    <h3 class="h3-titel-content color-blue-aa"><b>บริษัท เน็ตเวย์ คอมมูนิเคชั่น จำกัด </b><br/>Netway Communication Co., Ltd.  </h3>
    <hr/>
    <p class="payment_title" style="font-size: 16px;  font-weight: 300; margin-bottom: 10px; ">ที่อยู่สำหรับออกและจัดส่งหนังสือรับรองภาษี ณ ที่จ่าย</p> 
     
    <p  class="g-txt16"  style="color: #555555; text-align: justify;">
    	<i class="fa fa-map-marker" aria-hidden="true"></i>  เลขที่ 1518/5 อาคารเซียะชุน ชั้น 4 ถนนประชาราษฏร์ 1 <br>แขวงวงศ์สว่าง เขตบางซื่อ กรุงเทพมหานคร 10800

    </p>
    <p class="g-txt16"  style="line-height: 30px; color: #555555;">
       <b>
        เลขประจำตัวผู้เสียภาษี 0135539003143 สำนักงานใหญ่
       </b>     
    <br/>
    <a href="tel:+6629122558" style="color: #555555;margin-left: 2px;"><i class="fa fa-phone" style="font-size: 23px;"></i>&nbsp;&nbsp;Phone : +662-912-2558 </a><br>
    <i class="fa fa-fax" aria-hidden="true"  style="font-size: 24px;"></i>&nbsp;&nbsp;Fax : +662-912-2565                            
    <br/> 
    <a href="mailto:support@netway.co.th" style="color: #555555;"> <i class="fa fa-envelope-o" style="font-size: 26px;"></i>&nbsp;&nbsp;E-mail : support@netway.co.th</a>  <br/>
    <img src="{$template_dir}images/line-icon.png" alt="" style="width: 35px;margin-left: -2px"><span style="margin-left: -3px;"> Line: <a href="http://bit.ly/line-netway"> @netway </a> (มี @ ด้านหน้า)</span>
    </p>
</div>  
<div class="span6 visible-phone" style="padding: 0 20px 0 20px;">    
    <h3 class="h3-titel-content color-blue-aa" style="font-size: 22px; text-align: justify;">บริษัท เน็ตเวย์ คอมมูนิเคชั่น จำกัด  <br/>Netway Communication Co., Ltd.  </h3>
    <hr/>
    <p class="payment_title" style="font-size: 16px;  font-weight: 300; margin-bottom: 10px; ">ที่อยู่สำหรับออกและจัดส่งหนังสือรับรองภาษี ณ ที่จ่าย</p> 
     
    <p  class="g-txt16"  style="color: #555555; text-align: justify;">
        <i class="fa fa-map-marker" aria-hidden="true"></i> เลขที่ 1518/5 อาคารเซียะชุน ชั้น 4<br>ถนนประชาราษฏร์ 1 แขวงวงศ์สว่าง<br>เขตบางซื่อ กรุงเทพมหานคร 10800
                                                                             
    </p>
    <p class="g-txt16"  style="line-height: 30px; color: #555555;">
       <b>
        เลขประจำตัวผู้เสียภาษี 0135539003143 สำนักงานใหญ่
       </b>     
    <br/>
    <a href="tel:+6629122558" style="color: #555555;"><i class="fa fa-phone"></i>&nbsp;&nbsp;Phone : +662-912-2558 </a><br/> <i class="fa fa-fax" aria-hidden="true"></i>&nbsp;&nbsp;Fax : +662-912-2565
    <br/> 
    <a href="mailto:support@netway.co.th" style="color: #555555;"> <i class="fa fa-envelope-o"></i>&nbsp;&nbsp;E-mail : support@netway.co.th</a>  <br/>
    <img src="{$template_dir}images/line-icon.png" alt="" style="width: 30px;margin-left: -2px"><span> Line: <a href="http://bit.ly/line-netway"> @netway </a> (มี @ ด้านหน้า)</span>
   
    </p>
</div> 
<div class="span6">				
    <br />   
    <iframe src="https://www.google.com/maps/embed?pb=!1m14!1m8!1m3!1d3874.3233349426573!2d100.512742!3d13.819613!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x30e298db0a172a8d%3A0xe3d78f79d77622ee!2sNetway+Communication!5e0!3m2!1sen!2sth!4v1525257525812" width="100%" height="250" frameborder="0" style="border:0" allowfullscreen></iframe>   
    <a href="{$template_dir}share/doc/bigmap.pdf" class="btn-order-nnw pull-left" target="_blank" style="margin-top: 10px;">
        <i class="fa fa-arrow-circle-down" aria-hidden="true"></i> Download แผนที่ 
    </a>  
    
</div> 
{else}
<div class="span6 hidden-phone">    
    <h3 class="h3-titel-content color-blue-aa"><b>บริษัท เน็ตเวย์ คอมมูนิเคชั่น จำกัด </b><br/>Netway Communication Co., Ltd.  </h3>
    <hr/>
    <p class="payment_title" style="font-size: 16px;  font-weight: 300; margin-bottom: 10px; ">ที่อยู่สำหรับออกและจัดส่งหนังสือรับรองภาษี ณ ที่จ่าย</p> 
     
    <p  class="g-txt16"  style="color: #555555; text-align: justify;">
    	<i class="fa fa-map-marker" aria-hidden="true"></i>  เลขที่ 57/25 หมู่ที่ 9 ตำบลบางพูด อำเภอปากเกร็ด จังหวัดนนทบุรี 11120

    </p>
    <p class="g-txt16"  style="line-height: 30px; color: #555555;">
       <b>
        เลขประจำตัวผู้เสียภาษี 0135539003143 สำนักงานใหญ่
       </b>     
    <br/>
    <a href="tel:+6629122558" style="color: #555555;margin-left: 2px;"><i class="fa fa-phone" style="font-size: 23px;"></i>&nbsp;&nbsp;Phone : +662-055-1095 </a><br>
    <i class="fa fa-fax" aria-hidden="true"  style="font-size: 24px;"></i>&nbsp;&nbsp;Fax : +662-055-1098                            
    <br/> 
    <a href="mailto:support@netway.co.th" style="color: #555555;"> <i class="fa fa-envelope-o" style="font-size: 26px;"></i>&nbsp;&nbsp;E-mail : support@netway.co.th</a>  <br/>
    <img src="{$template_dir}images/line-icon.png" alt="" style="width: 35px;margin-left: -2px"><span style="margin-left: -3px;"> Line: <a href="http://bit.ly/line-netway"> @netway </a> (มี @ ด้านหน้า)</span>
    </p>
</div>      
<div class="span6 visible-phone" style="padding: 0 20px 0 20px;">    
    <h3 class="h3-titel-content color-blue-aa" style="font-size: 22px; text-align: justify;">บริษัท เน็ตเวย์ คอมมูนิเคชั่น จำกัด  <br/>Netway Communication Co., Ltd.  </h3>
    <hr/>
    <p class="payment_title" style="font-size: 16px;  font-weight: 300; margin-bottom: 10px; ">ที่อยู่สำหรับออกและจัดส่งหนังสือรับรองภาษี ณ ที่จ่าย</p> 
     
    <p  class="g-txt16"  style="color: #555555; text-align: justify;">
        <i class="fa fa-map-marker" aria-hidden="true"></i>  เลขที่ 57/25 หมู่ที่ 9 ตำบลบางพูด อำเภอปากเกร็ด จังหวัดนนทบุรี 11120                                                                      
    </p>
    <p class="g-txt16"  style="line-height: 30px; color: #555555;">
       <b>
        เลขประจำตัวผู้เสียภาษี 0135539003143 สำนักงานใหญ่
       </b>     
    <br/>
    <a href="tel:+6629122558" style="color: #555555;"><i class="fa fa-phone"></i>&nbsp;&nbsp;Phone : +662-055-1095 </a>
        <br/> <i class="fa fa-fax" aria-hidden="true"></i>&nbsp;&nbsp;Fax : +662-055-1098
    <br/> 
    <a href="mailto:support@netway.co.th" style="color: #555555;"> <i class="fa fa-envelope-o"></i>&nbsp;&nbsp;E-mail : support@netway.co.th</a>  <br/>
    <img src="{$template_dir}images/line-icon.png" alt="" style="width: 30px;margin-left: -2px"><span> Line: <a href="http://bit.ly/line-netway"> @netway </a> (มี @ ด้านหน้า)</span>
   
    </p>
</div> 
<div class="span6">				
       <br/>   
            <iframe src="https://www.google.com/maps/embed?pb=!1m14!1m8!1m3!1d3872.8132696212556!2d100.528968!3d13.9101069!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x0%3A0x0!2zMTPCsDU0JzM3LjEiTiAxMDDCsDMxJzQ5LjYiRQ!5e0!3m2!1sen!2sth!4v1594978855822!5m2!1sen!2sth" width="600" height="450" frameborder="0" style="border:0;" allowfullscreen="" aria-hidden="false" tabindex="0"></iframe>   
            <a href="{$template_dir}share/doc/new-map.pdf" class="btn-order-nnw pull-left" target="_blank" style="margin-top: 10px;"><i class="fa fa-arrow-circle-down" aria-hidden="true"></i> Download แผนที่ </a> 
        </div>  
</div>
{/if}    
    
</div>
</div>
<br clear="all" />
{include file="notifications.tpl"}