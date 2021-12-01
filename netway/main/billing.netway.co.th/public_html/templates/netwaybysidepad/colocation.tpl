{php}
$templatePath   = $this->get_template_vars('template_path');
include($templatePath . 'colocation.tpl.php');
{/php}

<!-- ******************** Start AddThis ******************** -->
<div class="pathway-inpage">
	{include file='addthis.tpl'}
</div>
<!-- ******************** End AddThis ******************** -->
	
<div class="in-page clearbot sm colocation">
	<div class="row clearmar">
		<div class="bgtitle">
			<h1 style="font-size:16px; color:#333333;">Data Center &rsaquo; Colocation Server</h1>
		</div>
	</div>
	
	<div class="row-fluid">
		<div class="span12">
			<h2 class="acenter">Netway Data Center</h2>
		</div>
	</div>	
	
	<div class="row-fluid">
		<div class="datacenter-menu">
			<div class="span6">
				<a class="bdr" id="active" href="{$ca_url}colocation">
					Colocation Server<br>
					<span>บริการรับฝากวางเครื่องเซิร์ฟเวอร์</span>
				</a>
			</div>
			<div class="span6">
				<a class="bdr" href="{$ca_url}dedicatedserver">
					Dedicated Server<br>
					<span>บริการให้เช่าเครื่องเซิร์ฟเวอร์ส่วนตัว</span>
				</a>
			</div>
		</div>
	</div>
	
	<div class="row-fluid">
		<div class="span12 padtop10">
			<div><img src="{$template_dir}images/colocation-banner.jpg" alt="colocation" width="967" height="341" /></div>	
			<h2 class="title">Colocation Server <span>บริการรับฝากวางเครื่องเซิร์ฟเวอร์</span></h2>
			<p>สำหรับลูกค้าที่มี <b>Server</b> เองอยู่แล้ว แต่ต้องการฝากวางเครื่องไว้ที่ <b>Data Center</b> ของเรา เพื่อใช้งานเป็น <b>Web Server, Mail Server, Application Server</b> ฯลฯ เราพร้อมให้บริการด้วยอินเตอร์เน็ตความเร็วสูง ไม่จำกัดจำนวน <b>Data Transfer (Unlimited)</b> และ Bandwidth ที่คุณเลือกได้ตามความต้องการ พร้อมระบบตรวจสอบการใช้งาน Internet Traffic ในรูปแบบกราฟ และระบบแจ้งสถานะ <b>Server</b> ผ่าน Email ฟรี! พิเศษสำหรับลูกค้า Netway เท่านั้น</p>
		</div>
	</div>
	
	<div class="row-fluid">
		<div class="span12">
			<h2 class="title">Benefits <span> ประโยชน์ของการใช้บริการ Colocation Server </span></h2>
		</div>	
	</div>
	
	<div class="row-fluid benefits" style="padding-top:8px;">
		<div class="span4">
			<div class="span4 acenter"><img src="{$template_dir}images/icon-colo-price.gif" alt="colocation" width="76" height="76" /></div>
			<div class="span7">ต้นทุนต่ำกว่าการวาง Server ภายในสำนักงานเอง ไม่ต้องลงทุนทำห้อง Server</div>
		</div>
		<div class="span4">
			<div class="span4 acenter"><img src="{$template_dir}images/icon-datacenter-speed.gif" alt="colocation" width="78" height="77" /></div>
			<div class="span7">มีอินเตอร์เน็ตความเร็วสูงแบบ Fixed IP Address ฟรี 4 IP</div>
		</div>
		<div class="span4">
			<div class="span4 acenter"><img src="{$template_dir}images/icon-colo-data-transfer.gif" alt="colocation" width="76" height="76" /></div>
			<div class="span7">ไม่จำกัดจำนวน Data Transfer (Unlimited) และ Bandwidth ที่คุณเลือกได้ตามความต้องการ</div>
		</div>
		
		<div class="span4">
			<div class="span4 acenter"><img src="{$template_dir}images/icon-colo-state.gif" alt="colocation" width="76" height="76" /></div>
			<div class="span7">มีระบบตรวจสอบการใช้งาน Internet Traffic ในรูปแบบกราฟ และระบบแจ้งสถานะ Server ผ่าน Email ฟรี! </div>
		</div>
		<div class="span4">
			<div class="span4 acenter"><img src="{$template_dir}images/icon-colo-internet-traffic.gif" alt="colocation" width="76" height="76" /></div>
			<div class="span7">ติดต่อทีมงาน Support ได้หลายช่องทาง ทั้งโทรศัพท์, Email และ Ticket ตลอด 24 ชม.</div>
		</div>
		<div class="span4">
			<div class="span4 acenter"><img src="{$template_dir}images/icon-colo-data-manageserver.gif" alt="colocation" width="76" height="76" /></div>
			<div class="span7">ใช้บริการร่วมกับ Managed Server Services ได้ เสมือนเราเป็น System Admin ให้กับคุณ <a href="{$ca_url}managed_server_services">รายละเอียด...</a></div>
		</div>	
	</div>
	
	<div class="row-fluid" style="margin-top:-10px;">
		<div><div class="linetitle"><span>Colocation per Server</span></div></div>
	</div>
	
	<div class="row-fluid padtop10">
		<div class="span3">
			<div class="box">
				<h3>1U Rack </h3>
				<div class="padd">
					<div><span>Network :</span> 100 Mbps</div>
					<div><span>IP Address :</span> 4 IP</div>
					 <div class="acenter"><span class="price">{$colo1u}</span> Baht/Month</div> 
					<!--<div class="acenter"><span class="price">2,900</span> Baht/Month</div>-->
					<div class="acenter"><a href="https://netway.co.th/?cmd=cart&action=add&id=669" class="buycolo"><i class="fa fa-cart-plus" style="font-size:18px;"></i>Buy Now</a> <a href="https://docs.google.com/a/netway.co.th/forms/d/1zynQxccf4u0wRe57wdiVdCTEcho1HIsxM3VoY3YK8qg/viewform" class="buycolo" target="_blank"><i class="fa fa-file"></i>Quotation</a> </div>
				</div>
			</div>
			<div class="shadow"></div>
		</div>
		<div class="span3">
			<div class="box">
				<h3>2U Rack </h3>
				<div class="padd">
					<div><span>Network :</span> 100 Mbps</div>
					<div><span>IP Address :</span> 4 IP</div>
					 <div class="acenter"><span class="price">{$colo2u}</span> Baht/Month</div> 
					<!--<div class="acenter"><span class="price">4,900</span> Baht/Month</div>-->
					<div class="acenter"><a href="https://netway.co.th/?cmd=cart&action=add&id=668" class="buycolo"><i class="fa fa-cart-plus" style="font-size:18px;"></i>Buy Now</a> <a href="https://docs.google.com/a/netway.co.th/forms/d/1zynQxccf4u0wRe57wdiVdCTEcho1HIsxM3VoY3YK8qg/viewform" class="buycolo" target="_blank"><i class="fa fa-file"></i>Quotation</a> </div>
				</div>
			</div>
			<div class="shadow"></div>
		</div>
		<div class="span3">
			<div class="box">
				<h3>3U Rack </h3>
				<div class="padd">
					<div><span>Network :</span> 100 Mbps</div>
					<div><span>IP Address :</span> 4 IP</div>
					 <div class="acenter"><span class="price">{$colo3u}</span> Baht/Month</div> 
					<!--<div class="acenter"><span class="price">6,900</span> Baht/Month</div>-->
					<div class="acenter"><a href="https://netway.co.th/?cmd=cart&action=add&id=670" class="buycolo"><i class="fa fa-cart-plus" style="font-size:18px;"></i>Buy Now</a> <a href="https://docs.google.com/a/netway.co.th/forms/d/1zynQxccf4u0wRe57wdiVdCTEcho1HIsxM3VoY3YK8qg/viewform" class="buycolo" target="_blank"><i class="fa fa-file"></i>Quotation</a> </div>
				</div>
			</div>
			<div class="shadow"></div>
		</div>
		<div class="span3">
			<div class="box">
				<h3>4U Rack </h3>
				<div class="padd">
					<div><span>Network :</span> 100 Mbps</div>
					<div><span>IP Address :</span> 4 IP</div>
					 <div class="acenter"><span class="price">{$colo4u}</span> Baht/Month</div> 
					<!--<div class="acenter"><span class="price">8,900</span> Baht/Month</div>-->
					<div class="acenter"><a href="https://netway.co.th/?cmd=cart&action=add&id=671" class="buycolo"><i class="fa fa-cart-plus" style="font-size:18px;"></i>Buy Now</a> <a href="https://docs.google.com/a/netway.co.th/forms/d/1zynQxccf4u0wRe57wdiVdCTEcho1HIsxM3VoY3YK8qg/viewform" class="buycolo" target="_blank"><i class="fa fa-file"></i>Quotation</a> </div>
				</div>
			</div>
			<div class="shadow"></div>
		</div>
	</div>
	
	<div class="row-fluid  padtop10 aright">
		<div class="span12"><span class="star">*</span> ราคายังไม่รวมภาษีมูลค่าเพิ่ม 7%</div>
	</div>
	
	<div class="row-fluid padtop10">
		<div class="span4 clear-mp hidden-phone hidden-tablet"><img src="{$template_dir}images/colo-per-server.jpg" alt="colocation" width="262" height="224" /></div>
		<div class="span4 clear-mp feature">
			<h3>Unit Features</h3>
			<div><i class="fa fa-arrow-circle-right"></i> Data Transfer Unlimited</div>
			<div><i class="fa fa-arrow-circle-right"></i> Network port speed 100 Mbps</div>
			<div><i class="fa fa-arrow-circle-right"></i> Max. Domestic Bandwidth 100 Mbps</div>
			<div><i class="fa fa-arrow-circle-right"></i> Max. Inter Bandwidth 1 Mbps</div>
			<div><i class="fa fa-arrow-circle-right"></i> Network Operation Center 24 x 7 x 365</div>
			
		</div>
		<div class="span4 clear-mp feature">
			<h3>Data Center Facilities</h3>
			<div><i class="fa fa-arrow-circle-right"></i> UPS & Power Generator Backup</div>
			<div><i class="fa fa-arrow-circle-right"></i> Air Condition System</div>
			<div><i class="fa fa-arrow-circle-right"></i> Fire Suppression System</div>
			<div><i class="fa fa-arrow-circle-right"></i> Access Control System</div>
			<div><i class="fa fa-arrow-circle-right"></i> CCTV Security Monitoring</div>
		</div>
	</div>
	<div class="row-fluid">
		<div><div class="linetitle"><span>Colocation per Rack</span></div></div>
	</div>
	
	<div class="row-fluid padtop10">
		<div class="span4 hidden-phone hidden-tablet"><img src="{$template_dir}images/colo-per-rack.jpg" alt="colocation" width="279" height="258" /></div>
		<div class="span4">
			<div style="margin:0 10px;">
				<div class="box">
					<h3>Half-Rack (20U)</h3>
					<div class="padd">
						<div><span>Electric :</span> 10 Outlets</div>
						<div><span>IP Address :</span> 10 IP</div>
						<div><span>Network :</span>  100 Mbps x 10 Ports</div>
						<div><span>Max. Domestic Bandwidth :</span> 500 Mbps</div>
						<div><span>Max. Inter Bandwidth :</span> 2 Mbps</div>
						 <div class="acenter"><span class="price">{$colo20u}</span> Baht/Month</div> 
						<!--<div class="acenter"><span class="price">18,000</span> Baht/Month</div>-->
						<div class="acenter"><a href="https://netway.co.th/?cmd=cart&action=add&id=672" class="buycolo"><i class="fa fa-cart-plus" style="font-size:18px;"></i>Buy Now</a> <a href="https://docs.google.com/a/netway.co.th/forms/d/1zynQxccf4u0wRe57wdiVdCTEcho1HIsxM3VoY3YK8qg/viewform" class="buycolo" target="_blank"><i class="fa fa-file"></i>Quotation</a> </div>
					</div>
				</div>
				<div class="shadow2"></div>
			</div>
		</div>
		<div class="span4">
			<div style="margin:0 10px;">
				<div class="box">
					<h3>Full Rack (42U)</h3>
					<div class="padd">
						<div><span>Electric :</span>  15 Amp. / 20 Outlets</div>
						<div><span>IP Address :</span> 20 IP</div>
						<div><span>Network :</span>  100 Mbps x 20 Ports</div>
						<div><span>Max. Domestic Bandwidth :</span> 1 Gbps</div>
						<div><span>Max. Inter Bandwidth :</span> 4 Mbps</div>
						 <div class="acenter"><span class="price">{$colo42u}</span> Baht/Month</div>
						<!--<div class="acenter"><span class="price">35,000</span> Baht/Month</div> -->
						<div class="acenter"><a href="https://netway.co.th/?cmd=cart&action=add&id=673" class="buycolo"><i class="fa fa-cart-plus" style="font-size:18px;"></i>Buy Now</a> <a href="https://docs.google.com/a/netway.co.th/forms/d/1zynQxccf4u0wRe57wdiVdCTEcho1HIsxM3VoY3YK8qg/viewform" class="buycolo" target="_blank"><i class="fa fa-file"></i>Quotation</a></div>
					</div>
				</div>
				<div class="shadow2"></div>
			</div>
		</div>
	</div>
	
	<div class="row-fluid  padtop10 aright">
		<div class="span12"><span class="star">*</span> ราคายังไม่รวมภาษีมูลค่าเพิ่ม 7%</div>
	</div>
	
	<div class="row-fluid padtop10">
		<div class="span12"><h3>Additional Option</h3></div>
		<div class="span12 bdrbot padtop10">
			<div class="span9"><i class="fa fa-check-square-o"></i> Add IP Address x 1 IP </div> 
			<div class="span3"><span class="txtblue right">100 Baht/Month</span></div>
		</div>
		<div class="span12 bdrbot">
			<div class="span9"><i class="fa fa-check-square-o"></i> Add Network 100 Mbps x 1 Port </div> 
			<div class="span3"><span class="txtblue right">1,000 Baht/Month</span></div>
		</div>
		<div class="span12 bdrbot">
			<div class="span9"><i class="fa fa-check-square-o"></i> Dedicated Inter Bandwidth (upgrade) x 1 Mbps</div> 
			<div class="span3"><span class="txtblue right">5,500 Baht/Month</span></div>
		</div>
		<div class="span12 bdrbot">
			<div class="span9"><i class="fa fa-check-square-o"></i> Dedicated Domestic Bandwidth (upgrade) x 1 Gbps</div> 
			<div class="span3"><span class="txtblue right">15,000 Baht/Month</span></div>
		</div>
	</div>
	
	<div class="row-fluid padtop10" style="display:none;">
		<div class="span12"><h3>Upgrade Option</h3></div>
		<div class="span12 marbot">
			<div class="span6"><i class="fa fa-check-square-o"></i> Dedicated Inter Bandwidth 1 Mbps <br /> <span class="txtblue">5,500	Baht/Month</span></div>
			<div class="span6"><i class="fa fa-check-square-o"></i> Dedicated Inter Bandwidth 2 Mbps <br /> <span class="txtblue">11,000	Baht/Month</span></div>
		</div>
		<div class="span12">
			<div class="span6 "><i class="fa fa-check-square-o"></i> Dedicated Inter Bandwidth 3 Mbps <br /> <span class="txtblue">16,500 	Baht/Month</span></div>
			<div class="span6"><i class="fa fa-check-square-o"></i> Dedicated Inter Bandwidth 4 Mbps <br /> <span class="txtblue">22,000	Baht/Month</span></div>		
		</div>	
	</div>
	
	<div class="row-fluid  padtop10 aright" style="display:none;">
		<div class="span12"><span class="star">*</span> ราคายังไม่รวมภาษีมูลค่าเพิ่ม 7%</div>
	</div>
	
	<div class="row-fluid padtop10">
		<div class="span6 clear-mp border">
			<div class="span3 acenter"><i class="fa fa-cog"></i></div>
			<div class="span9 email txt-supermarket">ต้องการให้เราดูแลเครื่อง <b class="normal">Server</b> แทนคุณ
			<br />
			<a href="{$ca_url}managed_server_services" class="click">คลิก</a>
			</div>
		</div>
 		<div class="span6 clear-mp border">
			<div class="span3 acenter"><i class="fa fa-pencil-square-o"></i></div>
			<div class="span9 email txt-supermarket">เงื่อนไขการใช้บริการ <b class="normal">Colocation Server</b> <br />
			<a href="{$ca_url}terms_of_service" class="click">คลิก</a>
			</div>
		</div>
	</div>

	<div class="row-fluid txt20 padtop10">	
		<h3 class="span12 txtblue service">สนใจบริการ Colocation Server </h3>
		<div class="span12 contact">
			<i class="fa fa-phone"></i> &nbsp;&nbsp;โทร :  02 912 2558 - 64 <br>
			<i class="fa fa-envelope-o"></i> &nbsp;อีเมล : <a href="mailto:sales@netway.co.th" target="_blank">sales@netway.co.th</a>
		</div>
	</div>
	
</div>

<br clear="all" />
		

<script type="text/javascript" src="{$template_dir}js/jquery.number.min.js"></script>
<script language="javascript">
{literal}
$(document).ready( function () {
    
    getProductPrice('colo1u', 669);
    getProductPrice('colo2u', 668);
    getProductPrice('colo3u', 670);
    getProductPrice('colo4u', 671);
    getProductPrice('colo20u', 672);
    getProductPrice('colo42u', 673);
    
});

function getProductPrice (selectorId, productId)
{
    $.ajax({
        type    : 'GET',
        url     : 'https://netway.co.th/7944web/api.php?call=module&module=informationhandle&fn=getProductPrice&productId='+ productId +'&api_id=2c96d70f79f41a159134&api_key=b0b6ab88832d3a5b9ba2',
        dataType: 'jsonp',
        success : function (data) {
            var price       = $.number(data.m);
            $('#'+ selectorId +'').html(price);
        }
    });
}

{/literal}
</script>

{include file='notificationinfo.tpl'}
