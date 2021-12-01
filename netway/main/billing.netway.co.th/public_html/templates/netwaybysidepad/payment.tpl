{literal}
<style>   
     .payment_title{      
                      margin-top: 20px;      
                      margin-bottom: 20px;      
                      font-size: 20px;      
                      font-family: 'Prompt', sans-serif;      
                      color: #0052cd;  
      }
     .bg {
       
                background-repeat: no-repeat;
                background-size: cover;
                background-position: top;
                background-attachment: fixed;
                text-align: center;
                height: 300px;
                width: 100%;
            }    
     .bg-back {
            background: rgba(0, 24, 192, 0.5);
            height: 300px;
     } 

     li {
         line-height: 32px;
       }                
                      </style>
                      
{/literal}
{php}
$date_now = date("Y-m-d");
$date_show = '2020-07-29';
$this->assign('date_now',$date_now);
$this->assign('date_show',$date_show);
{/php}
<div class="bg hidden-phone lazy-hero" data-src="/templates/netwaybysidepad/images/bg-payment2018-min.png">
  <div class="bg-back"> 
        <div class="container" >
            <div class="row" style="padding: 50px 0 50px 0;">
                    
                   <center>
                   <h3 class="h3-titel-content g-txt36"  style="color: #FFF;">วิธีชำระเงินและภาษี</h3>
                   <small style="color: #fff; font-size: 16px;">(เราออกใบกำกับภาษีทุกบริการ)</small>
                   </center>
            </div>
        </div>
    </div>
 </div>

<div class="container">                      
<div class="pathway-inpage">
	{include file='addthis.tpl'}
</div>
<div class="in-page clearbot">
	<div class="row clearmar">         
     
			<div class="row">	    
			<div class="paymemt">
			<div class="text-center" style="margin-top: 50px;">
				<a href="{$system_url}confirm-payment.php" class="btn-check" ><i class="fa fa-check-circle-o" aria-hidden="true"></i>&nbsp;&nbsp;ยืนยันการชำระเงิน</a> 
			</div>		
			
            <div class="pay_address">
                        <table class="tblfull">
                            <tbody><tr>
                            <td class="text-center top"><p class="lineheight22"><b class="txtblue">" บริษัท เน็ตเวย์ คอมมูนิเคชั่น จำกัด เป็นผู้ประกอบการจดทะเบียนภาษีมูลค่าเพิ่ม ตามประมวลรัษฎากร "</b></p></td>
                            </tr>
                        </tbody></table>
            </div>
   
            <h4 class="title" style="margin-top: 20px; font-weight: 500; font-family: 'Prompt', sans-serif; font-size: 22px; color: #5b749b;">คุณสามารถเลือกชำระค่าบริการได้ 6 วิธี </h4>            
            <hr/>
			<div class="payment_title" >1. ชำระเงินออนไลน์ผ่าน QR Payment</div>        
            <div class="row" style="background: #f3f3f2b3;">
                <div class="span8" style="margin-top: 15px;">
                     สามารถชำระค่าบริการเพียง <b>Scan QR Code</b> ในใบแจ้งหนี้ <span style="color:#008000"> สะดวก รวดเร็ว และไม่ต้องแจ้งยืนยันการชำระเงินอีกต่อไป</span>                 
                    <br/><br/>
                    <p class="text-left"><b>สามารถทำได้ ดังนี้</b>   </p>                  
                     <ol>                   
                         <li>ได้รับใบแจ้งหนี้ทาง Email</li>  
                         <li>Download ใบแจ้งหนี้ที่แนบไว้ใน Email เป็น File .pdf หรือ Download QR Code</li>
                         <li>เลือก App Bank ที่ต้องการชำระ สามารถใช้ App Bank ได้ทุกธนาคาร </li>
                         <li>Login App Bank </li>
                         <li>เลือก App Bank --> เลือก File</li>
                         <li>ระบบทำการดึงข้อมูล  และทำการใส่ยอดเงินที่ต้องการชำระเงิน</li>                   
                         <li>ทำตามขั้นตอนการชำระเงินจนเสร็จสมบูรณ์ </li>                  
                    </ol>                               
                </div>
                
            </div>          
            
            <hr/>   
			
			
			<div class="payment_title" >2. โอนเงินผ่านธนาคาร หรือตู้ ATM</div>
			<div class="visible-phone" style="background: #f2f2f2; font-size: 22px; font-family: 'Prompt', sans-serif; font-weight: 500;   font-weight: 500;">               <div class="text-center">ชื่อบัญชี "บริษัท เน็ตเวย์ คอมมูนิเคชั่น จำกัด"</div>            </div>
            <table class="tablepay restbl table hidden-phone">
				<tr class="res_tablespeed_bg ">
					<td colspan="4" class="tablepay_bg01"  style="background: #f2f2f2; font-size: 22px; font-family: 'Prompt', sans-serif; font-weight: 500;   font-weight: 500;"><div class="text-center">ชื่อบัญชี "บริษัท เน็ตเวย์ คอมมูนิเคชั่น จำกัด"</div></td>
				</tr>
            </table>  
			
			<table class="tablepay restbl table" style="line-height: 50px;">
				<thead>
				<tr class="tablespeed_bg">
					<th class="tablepay_bg02"><b>ธนาคาร</b></th>
					<th class="tablepay_bg03"><b>เลขที่บัญชีธนาคาร </b></th>
					<th class="tablepay_bg04"><b>ประเภทบัญชี</b></th>
					<th class="tablepay_bg05"><b>สาขา</b></th>
				</tr>
                </thead>
				<tr class="text-center odd">
					<td class="text-left"><img class="lazy" data-src="{$template_dir}images/bank/bbl.png" title="ธนาคารกรุงเทพ" alt="ธนาคารกรุงเทพ" height="32" width="32" />   ธนาคาร กรุงเทพ</td>
					<td>132-4-73947-1</td>
					<td>ออมทรัพย์</td>
					<td>บางซื่อ</td>
				</tr>
				<tr class="text-center">
					<td class="text-left"><img class="lazy" data-src="{$template_dir}images/bank/scb.png" title="ธนาคารไทยพาณิชย์" alt="ธนาคารไทยพาณิชย์" height="32" width="32" />   ธนาคาร ไทยพาณิชย์</td>
					<td class="tablepay_bg06">271-2-21268-6</td>
					<td class="tablepay_bg06">ออมทรัพย์</td>
					<td class="tablepay_bg06">เซ็นทรัล วงศ์สว่าง</td>
				</tr>
				<tr class="text-center odd">
					<td class="text-left"><img class="lazy" data-src="{$template_dir}images/bank/kb.png" title="ธนาคารกสิกรไทย" alt="ธนาคารกสิกรไทย" height="32" width="32" />   ธนาคาร กสิกรไทย</td>
					<td>779-2-21214-4</td>
					<td>ออมทรัพย์</td>
					<td>วงศ์สว่าง ทาวน์ เซ็นเตอร์</td>
				</tr>
			</table> 
			<p class="padd text-center"><span class="txtred-light">**</span> <b>หมายเหตุ :</b> ค่าธรรมเนียมในการโอนเงินเป็นความรับผิดชอบของลูกค้า ทางบริษัทฯ จะไม่รับผิดชอบในส่วนนี้ </p>
			<h4 class="title"  >หลังจากคุณทำการชำระเงินแล้ว สามารถยืนยันการชำระค่าบริการ ตามวิธีนี้</h4>
			{if $date_now < $date_show }
			<ul>
				<li>อีเมล์แจ้งมาที่ <a href="mailto:payment@netway.co.th" target="_blank" style="color: green;">payment@netway.co.th</a></li>
				<li>แฟกซ์สลิปใบโอนเงินมาที่หมายเลข (+66)2-912-2565  (กรุณาระบุหมายเลข Order หรือชื่อโดเมนเนมมาในสลิปใบโอนเงินด้วย)</li>
				<li>ยืนยันการชำระเงินออนไลน์ผ่านแบบฟอร์มของเราที่นี่ <a href="{$system_url}confirm-payment.php" style="color: green;">คลิกที่นี่</a></li>
				<li>โทรแจ้งเจ้าหน้าที่การเงินที่หมายเลข (+66)2-912-2558-64 </li>
			</ul>
			{else}
			<ul>
				<li>อีเมล์แจ้งมาที่ <a href="mailto:payment@netway.co.th" target="_blank" style="color: green;">payment@netway.co.th</a></li>
				<li>แฟกซ์สลิปใบโอนเงินมาที่หมายเลข (+66)2-055-1098  (กรุณาระบุหมายเลข Order หรือชื่อโดเมนเนมมาในสลิปใบโอนเงินด้วย)</li>
				<li>ยืนยันการชำระเงินออนไลน์ผ่านแบบฟอร์มของเราที่นี่ <a href="{$system_url}confirm-payment.php" style="color: green;">คลิกที่นี่</a></li>
				<li>โทรแจ้งเจ้าหน้าที่การเงินที่หมายเลข (+66)2-055-1095 </li>
			</ul>
			{/if}
			<div class="padtopbot"></div> 
			<hr/>
			<div class="payment_title" >3. ชำระเงินออนไลน์ผ่านบัตรเครดิต</div>        
			<div class="row">
                <div class="span7"> 
					ชำระค่าบริการผ่านบัตรเครดิต VISA, MASTERCARD ออนไลน์ได้ตลอด 24 ชั่วโมง                   
					<br/><br/>
					<p class="text-left"><b>สามารถทำได้ 2 วิธี ดังนี้</b>	</p>				  
					 <ol>					
    					 <li>Log in เข้าในระบบสมาชิก</li>					
    					 <li>
    					 หรือสามารถคลิก Link <a href="https://netway.co.th/kbank" style="color: green;"> https://netway.co.th/kbank</a> โดยไม่ต้องเข้าระบบสมาชิก
    					</li>				   
					</ol>								
				</div>
				<div class="span4 acenter"><img class="lazy" data-src="{$template_dir}images/icon_mcard.gif" alt="" height="73" width="119" />&nbsp;&nbsp;<img class="lazy" data-src="{$template_dir}images/icon_visa.gif" alt="" height="73" width="117" /></div>
			</div>			
			
			<hr/>	
	
			<div class="row">			
    			<div class="payment_title">4. ชำระเงินผ่านเช็ค</div>	   
                    <div class="span8">        
        			<p><b>ท่านสามารถชำระเงินผ่านเช็ค ด้วยการสั่งจ่ายในนามบริษัทดังรายละเอียดต่อไปนี้</b></p>
        			<div class="pay_address">
						<table class="tblfull">
							<tbody>
							{if $date_now < $date_show }
								<tr>
									<td class="text-left top">
										<p class="lineheight22"  style="line-height: 25px;">
											<b class="txtblue">บริษัท เน็ตเวย์ คอมมูนิเคชั่น จำกัด</b>
											<br /> 1518/5 อาคารเซียะชุน ชั้น 4 ถนนประชาราษฎร์ 1 แขวงวงศ์สว่าง เขตบางซื่อ กรุงเทพฯ 10800<br />
											<span class="txtorange">เลขประจำตัวผู้เสียภาษี 0135539003143  สำนักงานใหญ่</span> 
										</p>
									</td>
								</tr>
								<tr>
									<td class="text-left top">
										<p class="lineheight22"  style="line-height: 25px;">
											เรามีบริการรับเช็คที่สำนักงานหรือที่บ้านของคุณ (เฉพาะลูกค้าที่อาศัยอยู่ในเขตกรุงเทพฯ) <br/><u>สำหรับลูกค้าที่สั่งซื้อบริการเข้ามา<span class="txtdarkblue">ตั้งแต่ 5,000 บาทขึ้นไป</span></u> <br/> หากต้องการให้เข้าไปรับเช็ค กรุณาโทรแจ้งเจ้าหน้าที่ ได้ที่หมายเลข 
											<span class="txtdarkblue">(+66)2-912-2558</span> เพื่อนัดหมายวันและเวลา (จันทร์-ศุกร์)<br /><br />
										</p>
									</td>
								</tr>
								<tr>
									<td class="text-left top">
										<p class="lineheight22"  style="line-height: 25px;">
											<b>ที่อยู่สำหรับออกและจัดส่งหนังสือรับรองภาษี ณ ที่จ่าย</b><br /><br/>
											<b>บริษัท เน็ตเวย์ คอมมูนิเคชั่น จำกัด</b><br/>
											1518/5 อาคารเซียะชุน ชั้น 4 ถนนประชาราษฎร์ 1<br />แขวงวงศ์สว่าง เขตบางซื่อ กรุงเทพฯ 10800<br />
											เลขประจำตัวผู้เสียภาษี 0135539003143  สำนักงานใหญ่<br /><br />
											
											<b>Netway Communication Co.,Ltd.</b><br/>
											1518/5 CeaShun Building (4th Fl.) Pracharaj 1 Rd., Wongsawang,Bang Sue, Bangkok 10800 Thailand.<br/>
                    						Tel: (+66)2-912-2558 - 64<br>Fax: (+66)2-2912-2565<br/>
											Tax ID.0135539003143<br/><br/>
										</p>
									</td>
								</tr>
							{else}
								<tr>
									<td class="text-left top">
										<p class="lineheight22"  style="line-height: 25px;">
											<b class="txtblue">บริษัท เน็ตเวย์ คอมมูนิเคชั่น จำกัด</b>
											<br /> เลขที่ 57/25 หมู่ที่ 9 ตำบลบางพูด อำเภอปากเกร็ด จังหวัดนนทบุรี 11120<br />
											<span class="txtorange">เลขประจำตัวผู้เสียภาษี 0135539003143  สำนักงานใหญ่</span> 
										</p>
									</td>
								</tr>
								<tr>
									<td class="text-left top">
										<p class="lineheight22"  style="line-height: 25px;">
											เรามีบริการรับเช็คที่สำนักงานหรือที่บ้านของคุณ (เฉพาะลูกค้าที่อาศัยอยู่ในเขตกรุงเทพฯ) <br/><u>สำหรับลูกค้าที่สั่งซื้อบริการเข้ามา<span class="txtdarkblue">ตั้งแต่ 5,000 บาทขึ้นไป</span></u> <br/> หากต้องการให้เข้าไปรับเช็ค กรุณาโทรแจ้งเจ้าหน้าที่ ได้ที่หมายเลข 
											<span class="txtdarkblue">(+66)2-055-1095</span> เพื่อนัดหมายวันและเวลา (จันทร์-ศุกร์)<br /><br />
										</p>
									</td>
								</tr>
								<tr>
									<td class="text-left top">
										<p class="lineheight22"  style="line-height: 25px;">
											<b>ที่อยู่สำหรับออกและจัดส่งหนังสือรับรองภาษี ณ ที่จ่าย</b><br /><br/>
											<b>บริษัท เน็ตเวย์ คอมมูนิเคชั่น จำกัด</b><br/>
											เลขที่ 57/25 หมู่ที่ 9 ตำบลบางพูด อำเภอปากเกร็ด จังหวัดนนทบุรี 11120<br />
											เลขประจำตัวผู้เสียภาษี 0135539003143  สำนักงานใหญ่<br /><br />
											
											<b>Netway Communication Co.,Ltd.</b><br/>
											57/25 Village No.9, Bang Phut Sub-district,Pak Kret District, Nonthaburi Province 11120<br/>
											Tel: (+66)2-055-1095 <br> Fax: (+66)2-055-1098<br/>
											Tax ID.0135539003143<br/><br/>
										</p>
									</td>
									
								</tr>
							{/if}
							</tbody>
						</table>
        			</div>
                </div>                    
            </div>

<hr/>
<div class="padtopbot"></div> 
            <div class="payment_title" >5. ชำระเงินด้วยบัญชี PromptPay</div>    
		   
		   		
				<div class="row">
					<div class="span2">    
                    <img class="lazy" data-src="{$template_dir}images/promptpay.jpg" alt="promptpay" width= "150px" style="    margin-top: -10px;" />
                    </div>
					<div class="span7">
						<p class="text-left" >
								หมายเลขพร้อมเพย์ 0135539003143 (เลขประจำตัวผู้เสียภาษี)<br>
								บริษัท เน็ตเวย์ คอมมูนิเคชั่น จำกัด
						</p>
					</div>					
					<div class="span2">					 						    
					  <img class="lazy" data-src="{$template_dir}images/netway_prompt_pay_qr.png" width="100px" />							
					</div>
					
				</div>
			<hr/>
			<div class="row">              
			     <div class="span12">
    				 <div class="payment_title">6. ชำระเงินผ่าน PayPal</div>                 
    				 <p style="margin-left: 30px;">วิธีการชำระเงินและรับชำระเงินแบบออนไลน์ที่ปลอดภัยและง่ายยิ่งขึ้น บริการที่ให้คุณชำระด้วยวิธีที่ต้องการ รวมถึงการชำระเงินผ่านบัตรเครดิต บัญชีธนาคาร เครดิตผู้ซื้อ หรือยอดคงเหลือในบัญชี โดยไม่ต้องเปิดเผยข้อมูลทางการเงินให้กับบุคคลอื่น</p>
    				 </div>            
    		</div>
    		<div class="row">
    					<div class="span2 acenter">
    					<img class="lazy" data-src="{$template_dir}images/paypal.gif" alt="Netway" height="62" width="230" style="    margin-bottom: 20px;
        margin-top: 20px;" />
    					</div>
    					<div class="span10">
        					<p class="text-left">
        						<h4 class="title">สามารถทำได้ดังนี้</h4>
        						<ol>
        							<li>เข้าสู่ระบบสมาชิก Paypal <a href="https://www.paypal.com/th/signin" style="color: green;">(https://www.paypal.com/th/signin)</a></li>
        							<li>เลือกวิธีชำระเงิน/ โอนเงิน ไปที่ Account: billing@netway.co.th </li>
        						</ol>                      				
        						<p class="para txtcommemt"><b>**หมายเหตุ**</b></p>							
        						<p class="para textindent">ในกรณีที่บริษัทของคุณมีหนังสือรับรองภาษีหัก ณ ที่จ่าย โปรดนำส่งเอกสารดังกล่าวให้แก่บริษัทก่อน เมื่อได้รับเอกสารรับรองภาษีหัก ณ ที่จ่ายแล้ว บริษัท Netway Communication จะดำเนินการส่งใบเสร็จรับเงิน/ใบกำกับภาษีให้ตามที่อยู่ของคุณทันที</p>				<p class="para textindent">อนึ่ง หากคุณชำระค่าบริการเรียบร้อยแล้ว แต่ยังไม่ยืนยันการชำระค่าบริการตามวิธีการที่ระบุไว้ข้างต้น บริษัทจะไม่สามารถปิดยอดค่าบริการ ต่ออายุ หรือส่งใบเสร็จรับเงินให้ท่านได้ เนื่องจากไม่สามารถตรวจสอบยอดได้ว่าเป็นรายการโอนเงินของคุณหรือไม่ เพราะในแต่ละวันมีธุรกรรมโอนเงินผ่านบัญชีต่าง ๆ ของบริษัทเป็นจำนวนมาก</p>          
        					</p>
    					</div>
				    </div>
				    <hr/>
			</div></div>
			
		</div>
	</div>
</div>
</div>

{include file='notificationinfo.tpl'}

