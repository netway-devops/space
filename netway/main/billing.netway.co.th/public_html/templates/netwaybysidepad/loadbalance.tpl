 <div class="row-fluid" style="padding: 50px 20px 50px 20px;" >
       <div class="container">
           <div class="row">
             <div class="span12">
<!-- ******************** Start AddThis ******************** -->
<div class="pathway-inpage">
	{include file='addthis.tpl'}
</div>
<!-- ******************** End AddThis ******************** -->
<div class="in-page clearbot private">
	<div class="row-fluid padbot">	
		<div class="span5"><img src="{$template_dir}images/loadbalance-img.jpg" width="504" height="209" alt="" /></div>
		<div class="span7">
			<div class="loadbalance">
				<h1>Load Balance</h1>
				
				<h2>แก้ปัญหา “เว็บล่ม” </h2>
				<h3>เนื่องจากมี Session มากเกินลิมิตที่เครื่องจะรับไหว <br />หรือ Server ทำงานไม่ทัน</h3>
			
				<div><span class="loadbalance-icon"></span><a href="{$ca_url}loadbalance#load1"><i class="fa fa-info-circle" aria-hidden="true"></i> Load Balance คือ อะไร?</a></div>
				<div><span class="loadbalance-icon"></span><a href="{$ca_url}loadbalance#load2"><i class="fa fa-info-circle" aria-hidden="true"></i> ทำไมต้องใช้ Load Balance?</a></div>
				<div><span class="loadbalance-icon"></span><a href="{$ca_url}loadbalance#load3"><i class="fa fa-info-circle" aria-hidden="true"></i> แก้ปัญหาเซิร์ฟเวอร์ที่มี Workload สูง</a></div>
				<div><span class="loadbalance-icon"></span><a href="{$ca_url}loadbalance#load4"><i class="fa fa-info-circle" aria-hidden="true"></i> รูปแบบการทำงานของ Load Balance</a></div>
			</div>
		</div>
	</div>
	<div class="row-fluid" style="margin-top: 50px;"">	
		<div class="span12 padbot">
			<div class="pri-tab g-txt22" ><b>Load Balance</b></div>
			<hr/>
		</div>
	</div>
	<div class="row-fluid">	
		<div class="span12"  style="text-align: justify;">
			<p class="padbot">หาก <b>Web Server</b> ของคุณมีปัญหา <b>Workload</b> สูง ส่งผลให้เครื่องทำงานช้า หรือไม่สามารถทำงานได้เลยในช่วงที่มีผู้ใช้งานพร้อมๆ กันจำนวนมาก 
“เว็บล่ม” อยู่บ่อยๆ เนื่องจากมี session มากเกินลิมิตที่เครื่องจะรับไหว 
Server ทำงานไม่ทัน เกิดการแย่งกันใช้ทรัพยากรเครื่องระหว่าง <b>Web Server</b> และ <b>Database Server</b> ที่อยู่ภายในเครื่องเดียวกัน </p>
			<p>ไม่ว่าคุณจะต้องการระบบ <b>Web Server, Application Server</b> หรือ <b>Database Server</b> ที่มีประสิทธิภาพสูงแค่ไหน เพื่อแก้ปัญหาเหล่านี้ Netway สามารถออกแบบระบบเพื่อรองรับการทำงาน และบริหารจัดการระบบให้กับคุณได้ด้วยการทำ <b>Load Balance</b></p>
		</div>
	</div>
	<div class="row-fluid">	
		<div class="span12"><a name="load1"></a>
			<h2 class="domain-other-line"><span class="g-txt20">Load Balance คือ อะไร?</span></h2>
			<hr/>
			<div style="text-align: justify;"><b>Load Balance</b>  คือ ระบบเซิร์ฟเวอร์ที่มีประสิทธิภาพสูง รองรับการทำงานทีมีปริมาณงาน (Workload) เป็นจำนวนมากได้เป็นอย่างดี เกิดจากการนำเซิร์ฟเวอร์หลายๆ เครื่องที่มีหน้าที่การทำงานเดียวกันมาทำงานร่วมกันเพื่อกระจายปริมาณงานไปยังแต่ละเครื่อง โดยมีตัวบริหารจัดการที่ชื่อว่า <b>Load Balancer</b> ทำให้ระบบสามารถรองรับการทำงานหนักๆ ได้เป็นอย่างดี มีความยืดหยุ่นในการออกแบบระบบให้เหมาะกับทุกๆ สถานการณ์ เพื่อตอบสนองความต้องการของคุณอย่างแท้จริง</div>
		</div>
	</div>
	<div class="row-fluid">	
		<div class="span12"><a name="load2"></a>
			<h2 class="domain-other-line"><span class="g-txt20">ทำไมต้องใช้ Load Balance?</span></h2>
			<hr/>
			<div style="text-align: justify;">เพราะความต้องการใช้งานที่เพิ่มขึ้น ทำให้คุณต้องหาวิธีการรองรับ เพื่อไม่ให้เกิดปัญหา <b>Over Load</b> จนเครื่องเซิร์ฟเวอร์ของคุณทั้ง <b>Web Server, Application Server</b> หรือ <b>Database Server</b> ไม่สามารถให้บริการได้ การทำ <b>Server Load Balance</b> เป็นอีกวิธีการหนึ่งที่จะสามารถช่วยแก้ปัญหาได้ โดยที่ไม่จำเป็นต้องซื้อเครื่องที่ spec สูงมากๆ ซึ่งมีราคาแพงมาเปลี่ยนแทนเครื่องเดิม แต่สามารถใช้เครื่องที่ spec เท่าๆกันหลายเครื่อง มาทำงานร่วมกันแทน โดยการทำ <b>Load Balance</b> ในบางกรณีจะทำให้ได้ ระบบมีประสิทธิภาพสูงและความเสถียรมากกว่าการใช้เครื่องใหญ่ๆ เครื่องเดียวอีกด้วย </div>
		</div>
	</div>
	<div class="row-fluid">	
		<div class="span12"><a name="load3"></a>
			<h2 class="domain-other-line"><span class="g-txt20">แก้ไขปัญหาเซิร์ฟเวอร์ที่มี Workload สูง</span></h2>
			<hr/>
			<h3 class="g-txt18">1. A Dedicated Server</h3>
			<p class="padbot">สำหรับเว็บไซด์ที่มีผู้เข้าใช้งานเพิ่มขึ้นจนทำให้การวางเว็บไซด์ไว้บน <b>Shared Hosting</b> 
หรือ <b>VPS Hosting</b> นั้นไม่สามารถรองรับได้ ต้องแยกออกมาใช้ <b>Dedicated Server</b> แทน ลูกค้าสามารถเลือกได้ตามความเหมาะสมของการใช้งาน โดยมีรายระเอียดของบริการ   <a href="https://netway.co.th/cloud" target="_blank" > อ่านเพิ่มเติมคลิก </a></p>
			<h3 class="g-txt18">2. Separate Web and Database Server</h3>
			<p class="padbot">หากคุณใช้งาน <b>Server</b> เครื่องเดียวเป็นทั้ง <b>Web Server</b> และ <b>Database Server</b> แล้วไม่สามารถรองรับการใช้งานของผู้ใช้จำนวนมากได้ ควรแยก <b>Database Server</b> ออกจาก <b>Web Server</b> เพื่อแยกหน้าที่การทำงานกันอย่างอิสระ ก็จะสามารถรองรับการทำงานได้มากขึ้น โดยมีรูปแบบการเชื่อมต่อดังนี้ </p>
			<p class="acenter" style="text-align: center;"><img src="{$template_dir}images/Separate-Web-and-Database-Server.png" width="204" height="397" alt="" style="margin-bottom: 30px;" /></p>
			<a name="load4"></a>
			<h3 class="g-txt18" >3. Load Balance System</h3>
			<p class="padbot" style="text-align: justify;">ในการทำ <b>Load Balance</b> นั้น เราสามารถออกแบบระบบเพื่อให้รองรับการทำงาน และบริหารจัดการระบบให้กับคุณได้หลากหลายรูปแบบ ทั้งนี้ขึ้นอยู่กับความเหมาะสมของแต่ละสถานการณ์ คุณสามารถให้เราทำการประเมินให้ก่อนได้ เพื่อให้ได้ระบบที่เสถียร รองรับจำนวนผู้ใช้งานที่มีปริมาณมาก และคุ้มค่ากับงบประมาณในการลงทุนมากที่สุด รูปแบบการทำงานของ <b>Load Balance</b> ดังตัวอย่างต่อไปนี้</p>
			
			<div style="padding-left:20px; margin-top: 30px;">
				<div><b>3.1 Load Balance - Multiple Web Server</b></div>
				<p class="padbot" style="margin-top: 10px;">สำหรับเว็บไซด์ขนาดใหญ่ที่มี Content ค่อนข้างตายตัว มีผู้เข้าชมพร้อมกันมากๆ เช่น เว็บข่าวสารออนไลน์, เว็บเปิดตัวหรือรีวิวสินค้า, เว็บข้อมูลการท่องเที่ยว หรือเว็บบล็อกที่มีผู้ติดตามมากๆ เป็นต้น</p>
				<p class="acenter" style="text-align: center;"><img src="{$template_dir}images/Multiple-Web-Server.png" width="596" height="392" alt=""  style="margin-bottom: 30px;"  /></p>
				
				<div><b>3.2 Load Balance - Multiple Web Server with Single Database Server</b></div>
				<p class="padbot" style="margin-top: 10px;">สำหรับเว็บไซด์ขนาดใหญ่ที่มี Centent ค่อนข้างตายตัว อยู่บน <b>Web Server</b> และมีการเชื่อมต่อกับ <b>Database Server</b> แยยกออกไปเพื่อให้รองรับการเรียกใช้งาน การประมวลผล และการจัดเก็บข้อมูลขั้นสูง เช่น เว็บ E-Commerce, เว็บประกาศซื้อ-ขาย, เว็บจองตั๋ว หรือเว็บดีลลดราคา เป็นต้น</p>
				<p class="acenter" style="text-align: center;"><img src="{$template_dir}images/Multiple.png" width="588" height="547" alt=""  style="margin-bottom: 30px;" /></p>
				
				<div><b>3.3 Load Balance - Multiple Web Server with HA Database Server</b></div>
				<p class="padbot" style="margin-top: 10px;">ระบบขนาดใหญ่ที่มีผู้เข้าใช้งานพร้อมกันจำนวนมาก มีการประมวลผลที่ Web Server สูงๆ ต้องการ High Availability  ในการเรียกใช้งาน Database หนักๆ เช่น ระบบประมูล ระบบจองตั๋ว ระบบรับสมัครออนไลน์ หรือ Social Network</p>
				<p class="acenter" style="text-align: center;"><img src="{$template_dir}images/multiple-Web.png" width="593" height="576" alt=""   style="margin-bottom: 30px;" /></p>
			</div>
		</div>
	</div>
	<div class="row-fluid">	
		<div class="span12">
			<h2 class="domain-other-line"><span class="g-txt20">Dedicated Bandwidth</span></h2>
			<hr/>
			<ul class="ded" style="text-align: justify;">
				<li>สำหรับระบบ <b>Load balance</b> ที่มีประสิทธิภาพ ควรอยู่บนระบบ Network ที่มีความเร็วเหมาะสมกับการใช้งาน อาจแยกส่วนการใช้งาน <b>Dedicated Bandwidth</b> ออกมาเพื่อให้รองรับ Traffic Connection ในปริมาณสูงๆ ได้ </li>
				<li>Netway Data Center มีความพร้อมให้บริการด้าน Networking ที่เสถียรภาพ สามารถปรับ <b>Bandwidth</b> ให้ยืดหยุ่นกับการใช้งานของท่านได้อย่างไม่มีขีดจำกัด </li>
				<li>หากต้องการให้เราช่วยประเมินการใช้งานและออกแบบระบบเซิร์ฟเวอร์ <b>Load balance</b> ให้ ติดต่อสอบถามได้ที่หมายเลข <i class="fa fa-phone"></i> 02-912-2558 หรือส่งอีเมล   <a href="mailto:support@netway.co.th"><i class="fa fa-envelope-o" "=""></i> support@netway.co.th</a> </li>
			</ul>
		</div>
	</div>
	
	
</div>


{include file='notificationinfo.tpl'}
		    </div>
		  </div>
		</div>
    </div>      
