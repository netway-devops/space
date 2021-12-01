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
				<div class="pri-tab">กลไกการทำงานของ Symantec VIP </div>

				<div class="padbot padtop10">หากอธิบายอย่างง่ายๆ ระบบ <b>Symantec VIP</b> คือการที่ผู้ใช้ของคุณต้องกรอกรหัสผ่านอีกชุดหนึ่งซึ่งเป็นชุดที่ผู้ใช้คนนั้นเท่านั้นสามารถรับรู้ได้ เพราะเป็นรหัสที่สร้างจากแอพพลิเคชั่น <b>VIP Access</b> ที่ติดตั้งบนสมาร์ทโฟนของตนเอง จึงเป็นกลไกที่ดีที่สุดที่จะยืนยันว่ารหัสนั้นเป็นของผู้ใช้ตัวจริงที่มีสิทธิ์เข้าถึงทรัพยากรต่างๆ ในองค์กรนั้น</div>
				
				
			</div>
			{include file='notificationinfo.tpl'}