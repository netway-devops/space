

{literal}
<style type="text/css">
#s1{
	display:none;
}
.pointer:link{ cursor:pointer; color:#000000;}
.pointer:hover{ cursor:pointer; color:#006699;}
</style>

<script type="text/javascript">
{scriptOpen:h}
function content(id){
submenu = document.getElementById('s'+id);
for(i=1;i<=10;i++){
if(i==id){
submenu.style.display="block";
} else {
document.getElementById('s'+i).style.display="none";
}
}
}


 $("a").click(function () {
          $("div").fadeIn(1000, function () {
            $("span").fadeIn(100);
          });
          return false;
        }); 
{scriptClose:h}
</script>
{/literal}


<!-- ******************** Start AddThis ******************** -->
<div class="pathway-inpage">
	{include file='addthis.tpl'}
</div>
<!-- ******************** End AddThis ******************** -->
	
<div class="in-page clearbot sm colocation">
	<div class="row clearmar">
		<div class="pathway">
			<h1 title="Managed Server Services">Managed Server Services</h1>
		</div>
	</div>

	<div class="row-fluid padtop10">
		<div class="span12">
			<div><img src="{$template_dir}images/managed-serverservice-banner.gif" alt="managed servers ervice" width="966" height="341" /></div>
			
			<p class="padtop10">บริการดูแลเครื่อง <b class="normal">Server</b> ที่คุณสามารถเลือกได้เองตามความต้องการ เพิ่มความปลอดภัย และสะดวกรวดเร็วให้กับคุณมากยิ่งขี้น ด้วยบริการ <b class="normal">Managed Server Services</b> ของเรา</p>

			<h2 class="acenter title"><img src="{$template_dir}images/icon-manageserver.gif" alt="managed servers ervice" width="55" height="55" /> เลือกการดูแล Server ที่ใช่สำหรับคุณ</h2>
			
			<div class="row-fluid">
				<div class="span4" style="padding:0; margin:0;">
					<div class="servermss">
						<h3 class="msstitle">Self-managed</h3>
						<div class="content">เหมาะกับผู้ที่จัดการ <b class="normal">Server</b> ได้เองทั้งหมด เช่น <b class="normal">Server Configuration</b>, <b class="normal">Server Hardening</b>, Upgrades & Patches, การจัดสรรทรัพยากรของ <b class="normal">Server</b>, การจัดการ Control Panel Software, การป้องกัน Virus และ Spam ฯลฯ </div>
					</div>
				</div>
				<div class="span4" style="padding:0; margin:0;">
					<div class="servermss">
						<h3 class="msstitle">Standard</h3>
						<div class="content" style="padding-bottom:58px;">เหมาะกับผู้ที่ดูแลระบบ Application ที่ใช้บน <b class="normal">Server</b> เองได้ แต่ต้องการผู้ช่วยมาดูแลเรื่องความปลอดภัย วิเคราะห์และแก้ไขปัญหาให้ใช้งานได้เป็นปกติเสมอ </div>
					</div>
				</div>
				<div class="span4" style="padding:0; margin:0;">
					<div class="servermss">
						<h3 class="msstitle">Premium</h3>
						<div class="content">เหมาะกับผู้ที่ต้องการให้เครื่องพร้อมใช้งานอยู่เสมอ โดยไม่ต้องยุ่งยากเรื่องการบริหารจัดการ และที่สำคัญคือเรื่องความปลอดภัย เพราะเราดูแลแทนคุณทั้งหมด วิเคราะห์และแก้ไขปัญหารวดเร็ว พร้อมรายงานผล (Report) การบริหารจัดการส่งให้คุณแบบรายเดือน</div>
					</div>
				</div>
			</div>
			<div class="manageshadow"><img src="{$template_dir}images/spacer.gif" alt="managed servers ervice" width="1" height="1" /></div>	
	</div>
	
	<div class="row-fluid">
		<div class="span12"><h2 class="acenter title">Managed Server Services Package</h2></div>
	</div>
	<div class="row-fluid">
		<div class="tbl mss-tblmobile">
				<table width="100%" border="0" cellspacing="0" cellpadding="5">
				   <tr class="tbl-row2">
					<td align="center" class="bdr-r" width="60%" nowrap="nowrap">Price Plan (per server)</td>
					<td align="center" class="bdr-r" width="13%" nowrap="nowrap">Self-managed</td>
					<td align="center" class="bdr-r" width="13%">Standard</td>
					<td align="center" width="13%">&nbsp; Premium &nbsp;</td>
				  </tr>
				  <tr class="tbl-odd">
					<td class="bdr-r priceplan"><b class="normal">Managed Virtual Server</b></td>
					<td class="bdr-r" align="center">None</td>
					<td class="bdr-r" align="center">1,000</td>
					<td align="center">2,000</td>
				  </tr>
				  <tr class="tbl-even">
					<td class="bdr-r priceplan" nowrap="nowrap"><b class="normal">Managed Colocation Server / Dedicated Server</b></td>
					<td class="bdr-r" align="center">None</td>
					<td class="bdr-r" align="center">1,000</td>
					<td align="center">3,000</td>
				  </tr>
				  <tr class="tbl-row2">
					<td align="center" class="bdr-r">Features*</td>
					<td align="center" class="bdr-r">Self-managed</td>
					<td align="center" class="bdr-r">Standard</td>
					<td align="center">Premium</td>
				  </tr>
				   <tr class="tbl-odd">
					<td class="bdr-r feature">OS Installation</td>
					<td class="bdr-r"><div class="ok"></div></td>
					<td class="bdr-r"><div class="ok"></div></td>
					<td><div class="ok"></div></td>
				  </tr>
				  <tr class="tbl-even">
					<td class="bdr-r feature">Installation Core Software Package</td>
					<td class="bdr-r"><div class="ok"></div></td>
					<td class="bdr-r"><div class="ok"></div></td>
					<td><div class="ok"></div></td>
				  </tr>
				   <tr class="tbl-odd">
					<td class="bdr-r feature">24x7x365 Phone, Email, Ticket System</td>
					<td class="bdr-r"><div class="ok"></div></td>
					<td class="bdr-r"><div class="ok"></div></td>
					<td><div class="ok"></div></td>
				  </tr>
				  <tr class="tbl-even">
					<td class="bdr-r feature">System Level Health Monitoring and Graphing</td>
					<td class="bdr-r">&nbsp;</td>
					<td class="bdr-r"><div class="ok"></div></td>
					<td><div class="ok"></div></td>
				  </tr>
				   <tr class="tbl-odd">
					<td class="bdr-r feature">System Level Monitoring Alerts & Notifications</td>
					<td class="bdr-r">&nbsp;</td>
					<td class="bdr-r"><div class="ok"></div></td>
					<td><div class="ok"></div></td>
				  </tr>
				  <tr class="tbl-even">
					<td class="bdr-r feature">15 Minute Initial Response Time Guarantee</td>
					<td class="bdr-r">&nbsp;</td>
					<td class="bdr-r"><div class="ok"></div></td>
					<td><div class="ok"></div></td>
				  </tr>
				   <tr class="tbl-odd">
					<td class="bdr-r feature">RBL Monitoring</td>
					<td class="bdr-r">&nbsp;</td>
					<td class="bdr-r"><div class="ok"></div></td>
					<td><div class="ok"></div></td>
				  </tr>
				  <tr class="tbl-even">
					<td class="bdr-r feature">System tweaks for Performance Tuning, Optimization and Security</td>
					<td class="bdr-r">&nbsp;</td>
					<td class="bdr-r">&nbsp;</td>
					<td><div class="ok"></div></td>
				  </tr>
				   <tr class="tbl-odd">
					<td class="bdr-r feature">Proactive Response & Restoration of Monitoring Events</td>
					<td class="bdr-r">&nbsp;</td>
					<td class="bdr-r">&nbsp;</td>
					<td><div class="ok"></div></td>
				  </tr>
				  <tr class="tbl-even">
					<td class="bdr-r feature">Operating System Updates & patches including kernel</td>
					<td class="bdr-r">&nbsp;</td>
					<td class="bdr-r">&nbsp;</td>
					<td><div class="ok"></div></td>
				  </tr>
				   <tr class="tbl-odd">
					<td class="bdr-r feature">Security Enhancements</td>
					<td class="bdr-r">&nbsp;</td>
					<td class="bdr-r">&nbsp;</td>
					<td><div class="ok"></div></td>
				  </tr>
				  <tr class="tbl-even">
					<td class="bdr-r feature">Virus and Spam Protection</td>
					<td class="bdr-r">&nbsp;</td>
					<td class="bdr-r">&nbsp;</td>
					<td><div class="ok"></div></td>
				  </tr>
				   <tr class="tbl-odd">
					<td class="bdr-r feature">Full Control Panel Support (cPanel, DirectAdmin, Plesk)</td>
					<td class="bdr-r">&nbsp;</td>
					<td class="bdr-r">&nbsp;</td>
					<td><div class="ok"></div></td>
				  </tr>
				  <tr class="tbl-even">
					<td class="bdr-r feature">Control Panel Updates and Patches</td>
					<td class="bdr-r">&nbsp;</td>
					<td class="bdr-r">&nbsp;</td>
					<td><div class="ok"></div></td>
				  </tr>
				   <tr class="tbl-odd">
					<td class="bdr-r feature" style="border-bottom:0;">Free Internal Migrations</td>
					<td class="bdr-r">&nbsp;</td>
					<td class="bdr-r">&nbsp;</td>
					<td><div class="ok"></div></td>
				  </tr>
				</table>
			</div>
	</div>
	
	<div class="row-fluid">
		<div class="span12">
			<p class="small"><font class="star">*</font> Managed Server Services for Dedicated Server included fully managed physical server at Netway IDC only.</p>
			<p>เราให้บริการ <b class="normal">Managed Server Services</b> ทั้งเครื่องที่อยู่ใน Netway IDC และภายนอก สำหรับเครื่องที่อยู่ภายนอกผู้ใช้บริการจะต้องดำเนินการจนกระทั่งให้เจ้าหน้าที่ของเราสามารถ Remote Access เข้าไปบริหารจัดการเครื่องได้ และราคาดังกล่าวนี้ไม่รวมถึงการ On-site Services</p>
		</div>
	</div>
	
	<div class="row-fluid mss-tblmobile" id="s1">
		<div class="span12">
			<h2 class="acenter title">Managed Server Services Features Detail </h2>
			<div>
				<table width="100%" border="0" cellspacing="0" cellpadding="5">
				   <tr class="tbl-row2">
					<td align="center" class="bdr-r" width="45%" nowrap="nowrap">Features</td>
					<td align="center" width="55%" nowrap="nowrap">Definition</td>
				  </tr>
				  <tr class="tbl-odd">
					<td class="bdr-r" nowrap="nowrap">OS Installation</td>
					<td nowrap="nowrap">ติดตั้ง Operating System (OS) สามารถเลือกได้ตามความต้องการ <br />ระหว่าง Linux (เช่น CentOS, Ubuntu Server) และ Windows Server</td>
				  </tr>
				  <tr class="tbl-even">
					<td class="bdr-r" nowrap="nowrap">Installation Core Software Package</td>
					<td>ติดตั้ง Software หลักตามความต้องการ เช่น Apache, Nginx, PHP, CMS</td>
				  </tr>
				   <tr class="tbl-odd">
					<td class="bdr-r">24x7x365 Phone, Email Ticket System</td>
					<td>สามารถติดต่อเจ้าหน้าที่ได้ตลอดเวลาทั้งทาง โทรศัพท์ Email และระบบ Ticket Support เพื่อขอรับบริการได้ตาม Managed Server Services ที่ลูกค้าเลือกใช้บริการ</td>
				  </tr>
				  <tr class="tbl-even">
					<td class="bdr-r">System Level Health Monitoring and Graphing</td>
					<td>ระบบการ Monitor เช่น CPU, RAM, Storage, Network Traffic แสดงผลในรูปแบบกราฟ</td>
				  </tr>
				   <tr class="tbl-odd">
					<td class="bdr-r">System Level Monitoring Alerts & Notifications</td>
					<td>ระบบการ Monitor Services ต่างๆ ของระบบ พร้อมกับมี Alert ไปยังผู้ดูแลระบบ</td>
				  </tr>
				  <tr class="tbl-even">
					<td class="bdr-r">15 Minute Initial Response Time Guarantee</td>
					<td>ตอบกลับ Ticket ภายใน 15 นาที</td>
				  </tr>
				   <tr class="tbl-odd">
					<td class="bdr-r">RBL Monitoring</td>
					<td>ตรวจสอบและแจ้งเตือน Real-time Blackhole List (RBL), แก้ไขปัญหา IP ติด Blacklist</td>
				  </tr>
				  <tr class="tbl-even">
					<td class="bdr-r">System tweaks for Performance Tuning and Optimization</td>
					<td>ทำการปรับแต่งระบบเพื่อให้ใช้งานเต็มประสิทธิภาพ</td>
				  </tr>
				   <tr class="tbl-odd">
					<td class="bdr-r">Proactive Response & Restoration of Monitoring Events</td>
					<td>ระบบการตรวจจับความผิดปกติต่าง ๆ ของระบบเพื่อความรวดเร็วในการแก้ปัญหา และความเสถียรของระบบ</td>
				  </tr>
				  <tr class="tbl-even">
					<td class="bdr-r">Operating System Updates & patches including kernel</td>
					<td>การ Update patch และ Kernel ของ OS</td>
				  </tr>
				   <tr class="tbl-odd">
					<td class="bdr-r">Security Enhancements</td>
					<td>ทำการปรับแต่งให้ระบบมี Security ที่แข็งแรง ปลอดภัย</td>
				  </tr>
				  <tr class="tbl-even">
					<td class="bdr-r">Virus and Spam Protection</td>
					<td>ทำระบบป้องกันไวรัส สแปม เพื่อความมั่นใจในการใช้บริการ</td>
				  </tr>
				   <tr class="tbl-odd">
					<td class="bdr-r">Full Control Panel Support (cPanel, DirectAdmin, Plesk)</td>
					<td>แนะนำ แก้ปัญหาการใช้งานของ Control Panel</td>
				  </tr>
				  <tr class="tbl-even">
					<td class="bdr-r">Control Panel Updates and Patches</td>
					<td>ทำการ Update หรือ Patch ระบบ Control Panel ให้ทันสมัยปลอดภัยเสมอ</td>
				  </tr>
				   <tr class="tbl-odd">
					<td class="bdr-r">Free Internal Migrations</td>
					<td>ย้ายระบบหรือข้อมูลภายในให้ฟรี เช่น เปลี่ยนจาก Shared Hosting มาใช้บริการ Cloud VPS</td>
				  </tr>
				  
				 </table>
			</div>
		</div>
	</div>
	
	<div class="row-fluid">
		<div class="span6 clear-mp border">
			<div class="span3 acenter"><img src="{$template_dir}images/icon-manage.gif" alt="managed servers ervice" width="81" height="58" /></div>
			<div class="span9 email">คำอธิบายการให้บริการ 
			<br />
			<h4 class="txt-terms">Managed Server Services Features Detail</h4>
			<div><a href="javascript:void(0)" onclick="javascript:content(1)" class="click">คลิก</a></div>
			</div>
		</div>
 		<div class="span6 clear-mp border">
			<div class="span3 acenter"><i class="fa fa-pencil-square-o"></i></div>
			<div class="span9 email">เงื่อนไขการให้บริการ <br />
			<h4 class="txt-terms">Terms of Services : Managed Server Services</h4>
			<a href="{$ca_url}terms_of_service_manageserver" class="click">คลิก</a>
			</div>
		</div>
	</div>
	
	<div class="row-fluid  txt20 padtop10">	
		<h2 class="span12 txtblue">สนใจบริการ Managed Server Services</h2>
		<div class="span12">
			<i class="fa fa-phone"></i> &nbsp;&nbsp;โทร :  02 912 2558 - 64 <br>
			<i class="fa fa-envelope-o"></i> &nbsp;อีเมล : <a href="mailto:sales@netway.co.th" target="_blank">sales@netway.co.th</a>
		</div>
	</div>
</div>
	
</div>

<br clear="all" />
		
		

{include file='notificationinfo.tpl'}
