<!-- ******************** Start AddThis ******************** -->
<div style="padding-top:8px;">
	
</div>
<!-- ******************** End AddThis ******************** -->


<script src="{$template_dir}js/tabs.js"  type="text/javascript"></script>

<div class="in-page private">
	<div class="row-fluid visible-desktop visible-tablet">
		<div class="bgtitle">
			<h1>Symantec VIP </h1>
		</div>
	</div>
	<div class="row-fluid">	
		<div class="visible-desktop visible-tablet">
			<div class="span3 padbot whmcpanel">
				<div class="bgtab-t">
					<h2 style="font-size:16px;">Symantec VIP</h2>
					<div class="bgtab">
						<ul class="menu">
							<li class="active bdrtnone" id="subject">Overview</li>
							<li id="learn">กลไกการทำงานของ Symantec VIP </li>
							<li id="gprice">เตรียมความพร้อมสำหรับ Symantec VIP </li>
							<li class="bdrbnone" id="tab4">ขั้นตอนการใช้งาน Symantec VIP</li>
						</ul>
					</div>
				</div>
				
				<div class="bggold">
					<div class="acenter"><img src="{$template_dir}images/cpanel.gif" width="203" height="54" alt="cpanel" /></div>
					<div style="font-size:14px;">ปลอดภัยด้วยระบบยืนยันตัวตน <br />ปกป้องเซิร์ฟเวอร์ของคุณด้วย Symantec VIP for WHM/cPanel </div>
					<div class="menu"><a href="{$ca_url}whmcpanel" class="detail">ดูรายละเอียด</a></div>
				</div>
				<div class="bgsteelblue">
					<div class="acenter"><img src="{$template_dir}images/wordpress.gif" width="203" height="57" alt="wordpress" /></div>
					<div style="font-size:14px;">เพื่มความมั่นใจในความปลอดภัย ของเว็บไซต์ด้วย Symantec VIP for WordPress</div>
					<div><a href="{$ca_url}wordpress" class="wordpress">ดูรายละเอียด</a></div>
					<div><a href="http://vip.netway.co.th/" class="wordpress" target="_blank">DEMO</a></div>
				</div>
			</div>
		</div>
		
		
		<div class="span9">
			
			<div style="" class="subject">
				{include file='netway2factor_overview.tpl'}
				<div class="clearit"></div>
			</div>
			
			<div style="display:none;" class="learn">
				{include file='netway2factor_mechanism.tpl'}
				<div class="clearit"></div>
			</div>
			
			<div style="display:none;" class="gprice">
				{include file='netway2factor_prepare.tpl'}
				<div class="clearit"></div>
			</div>
			
			<div style="display:none;" class="tab4">
				{include file='netway2factor_howto.tpl'}
				<div class="clearit"></div>
			</div>
			
			
			<div style="padding-top:10px;">
				<h3 class="txtdarkblue">สอบถามข้อมูลเพิ่มเติม</h3>
				<div><img src="https://netway.co.th/templates/netwaybysidepad/images/reseller-letter.gif" alt="" height="43" width="55">&nbsp;&nbsp;<b>อีเมล์ :</b> <a href="mailto:sales@netway.co.th">sales@netway.co.th</a></div>
			</div>
		</div>
		
		
	</div>
</div>
		
		

{include file='notificationinfo.tpl'}
