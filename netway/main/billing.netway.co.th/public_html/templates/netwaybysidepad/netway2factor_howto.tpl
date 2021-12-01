 <nav class="hidden-desktop hidden-tablet" style="margin-top:10px;">
  <select class="primaryMenuSelect" onchange="window.open(this.options[this.selectedIndex].value,'_top')" style="width:100%;">
	<option value="" active="active">Menu:</option>
	<option value="{$ca_url}netway2factor_overview">Overview</option>
	<option value="{$ca_url}netway2factor_mechanism">กลไกการทำงานของ Symantec VIP </option>
	<option value="{$ca_url}netway2factor_prepare">เตรียมความพร้อมสำหรับ Symantec VIP  </option>
	<option value="{$ca_url}netway2factor_howto">ขั้นตอนการใช้งาน Symantec VIP </option>
	<option value="{$ca_url}whmcpanel">Symantec VIP for WHM/cPanel</option>
	<option value="{$ca_url}wordpress">Symantec VIP for WordPress</option>
	<option value="http://vip.netway.co.th/">DEMO</option>
  </select>
</nav>
		
<div class="private">
	<div class="pri-tab">ขั้นตอนการใช้งาน Symantec VIP </div>
	<div class="acenter padbot" style="padding-top:20px;"><img src="{$template_dir}images/2factor-signin.jpg" width="463" height="217" alt="2factor" /></div>
	<div>
		<ul class="ded">
			<li>สมัครสมาชิกกับ Netway <a href="https://netway.co.th/signup/">https://netway.co.th/signup/</a> และล็อคอินเข้าสู่ระบบ Netway</li>
			<li>ในหน้า Menu เลือกที่ Symantec VIP</li>
			<li>การเข้าใช้งานครั้งแรก ระบบจะให้คุณกรอก “Credential ID” ซึ่งคุณสามารถดูได้จากแอพลิเคชั่น VIP Access</li>
			<li>หลังจากนั้นใส่ตัวเลข “Security Code” ซึ่งดูได้จากแอพลิเคชั่น VIP Access เช่นกัน</li>
			<li>เมื่อล็อคอินสำเร็จ คุณสามารถที่จะควบคุมและจัดการ “Credential ID” ได้</li>
		</ul>
	</div>
	<div class="padbot padtop10"><b>เพียงแค่ 5 ขั้นตอนง่ายๆเท่านี้ ข้อมูลบัญชีของคุณก็จะปลอดภัย โดยที่ผู้อื่นไม่สามารถเข้าถึงได้อย่างแน่นอน</b></div>
	<div class="padbot padtop10"><div class="domain-other-line"><span>ดาวน์โหลด VIP Access เพื่อติดตั้งบนมือถือของคุณ</span></div></div>
	
	<div class="padtop10">
		<div class="span4 acenter">
			<h3 class="txtdarkblue padbot">iOS</h3>
			<a href="http://m.vip.symantec.com/home.v" target="_blank" class="download-demo"><img src="{$template_dir}images/2factor-appstore.jpg" width="190" height="283" alt="2factor" border="0" /></a></div>
		<div class="span4 acenter">
			<h3 class="txtdarkblue padbot">Andriod</h3>
			<a href="https://idprotect.vip.symantec.com/desktop/download.v" target="_blank" class="download-demo"><img src="{$template_dir}images/2factor-googleplay.jpg" width="190" height="283" alt="2factor" border="0" /></a></div>
		<div class="span4 acenter">
			<h3 class="txtdarkblue padbot">Windows Phone</h3>
			<a href="index.php/vip_access/" target="_blank" class="download-demo"><img src="{$template_dir}images/2factor-windows.jpg" width="190" height="283" alt="2factor" border="0" /></a></div>
	</div>
	<div class="clearit"></div>
</div>