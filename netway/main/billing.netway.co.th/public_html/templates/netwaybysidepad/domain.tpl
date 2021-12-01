<link media="all" type="text/css" rel="stylesheet" href="{$template_dir}css/domainstyles.css" />
<script src="https://netway.co.th/includes/modules/Other/netway_common/public_html/js/domain/reserveword.js"></script>
<script src="https://netway.co.th/includes/modules/Other/netway_common/public_html/js/domain/punycode.js"></script>
<script src="https://netway.co.th/includes/modules/Other/netway_common/public_html/js/domain/domain.js"></script>

{literal}
<style type="text/css">
h1.title06, .kol-1, .kol-2, .linia1{ 
	display:none;
}
</style>
{/literal}

<script type="text/javascript">

{literal}
$(document).ready(function() {
	$.domain.init({id : '#container-code', type : 'order'});
});
{/literal}

</script>

<!-- ******************** Start AddThis ******************** -->
<div class="pathway-inpage">
	{include file='addthis.tpl'}
</div>
<!-- ******************** End AddThis ******************** -->
<div class="in-page clearbot">
	<div class="row clearmar">
		<div class="bgtitle" style="padding:1px 0 2px 15px;">
			<h1>Domain</h1>
		</div>
		<div>

			<div>	
				<ul class="bxslider" style="padding:0; margin:0;">
					<li style="padding:0; margin:0; list-style:none;"><img src="{$template_dir}images/banner-domain2.jpg" alt="domain"  /></li>
				</ul>
			</div>
		</div>
		<div class="row-fluid">
			<div class="domain-bgback">
			    <div style="padding-top:15px;">
			        <div class="span2" style="margin-top:5px;"><label><span class="sd-font"><input type="radio" name="transfer" id="transfer" value="0" checked="checked" onclick="$('#msgSearchDomain').text('ค้นหาโดเมนว่าง');" /> ต้องการจดโดเมนใหม่</span></label></div>
			        <div class="span2" style="margin-top:5px;"><label><span class="sd-font"><input type="radio" name="transfer" id="transfer" value="1" onclick="$('#msgSearchDomain').text('กรุณาระบุชื่อโดเมน');" /> ต้องการย้ายโดเมนมาที่ Netway</span></label></div>
			    </div>
			    <br />
				<div style="padding-top:15px;">
					<div class="span2" style="margin-top:5px;"><span id="msgSearchDomain" class="sd-font">ค้นหาโดเมนว่าง</span></div>
					<div id="cont">
						<!-- start search domain -->
						<div class="container-step1">
							<div id='container-code'></div>
							<div class="domain-after">
								<div class="kol-1"></div>
								<div class="kol-2"></div>
							</div>
						</div>
						<!-- end search domain -->
					</div>
				</div>
			</div>
		</div>
		
		<div>
			<!-- Start check domain-->
			<div id='container-diplays-ex'></div>
			<!-- End check domain-->
		</div>
		<div class="aright">*** สำหรับ <span style="color:#0e5d95;">.COM, .NET, .NAME, .CC และ .TV</span> สามารถค้นได้ทั้งชื่อโดเมนภาษาไทยและภาษาอังกฤษ</div>
		<div class="shmenu1">
			<div class="domain-bgdoc">เอกสารที่ต้องใช้เพื่อจดโดเมน &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href="http://www.siaminterhost.com/kb/index.php?x=&mod_id=2&id=22" target="_blank">คลิกที่นี่</a></div>
		</div>
		
		<div class="shmenu2">
			<div class="domain-bgdoc2"><a href="http://www.siaminterhost.com/kb/index.php?x=&mod_id=2&id=22" target="_blank">เอกสารการจดโดเมน คลิกที่นี่</a></div>
		</div>
		
		<div class="domain-bgblue">
			<h1>ขั้นตอนง่ายๆ ในการสั่งซื้อโดเมน</h1>
			<div class="span4 block acenter"><a href="https://netway.co.th/checkdomain/domain-registrations/"><img src="{$template_dir}images/domain-select.jpg" alt="domain" height="100" width="93" /> เลือกโดเมน</a></div>
			<div class="span4 block acenter"><a href="https://netway.co.th/checkdomain/domain-registrations/"><img src="{$template_dir}images/domain-buy.jpg" alt="domain" height="100" width="93" />สั่งซื้อ</a></div>
			<div class="span4 acenter"><a href="{$ca_url}{$paged.url}payment/"><img src="{$template_dir}images/domai-payment.jpg" alt="domain" height="100" width="93" />ชำระเงิน</a></div>
			<div class="clearit"></div>
		</div>
		<div class="domain-other-line"><span>บริการอื่นๆ เกี่ยวกับโดเมน</span></div>
		<div class="domain-other clear-mp">
			<div class="span4 acenter clear-mp">
				<div class="block">
					<div><a href="{$ca_url}{$paged.url}whois/"><img src="{$template_dir}images/domai-whois.jpg" alt="domain" height="142" width="138" /><br />ตรวจสอบโดเมนกับ 	Whois</a></div>
					<div class="padd"><a href="{$ca_url}{$paged.url}whois/" class="h-btn-domain">Click</a></div>
				</div>
			</div>
			<div class="span4 acenter clear-mp">
				<div class="block">
					<div><a href="https://netway.co.th/tickets/new/"><img src="{$template_dir}images/domai-move.jpg" alt="domain" height="142" width="138" /><br />บริการย้ายโดเมน</a></div>
					<div class="padd"><a href="{$ca_url}{$paged.url}transferdomain/" class="h-btn-domain">Click</a></div>
				</div>
			</div>
			<div class="span4 acenter clear-mp">
				<div class="block">
					<div><a href="{$ca_url}{$paged.url}suggestion/"><img src="{$template_dir}images/domai-suggest.jpg" alt="domain" height="142" width="138" /><br />บริการแนะนำโดเมน</a></div>
					<div class="padd"><a href="{$ca_url}{$paged.url}suggestion/" class="h-btn-domain">Click</a></div>
			
				</div>
			</div>
			<div class="clearit"></div>
		</div>
	</div>
</div>


{include file='notificationinfo.tpl'}
