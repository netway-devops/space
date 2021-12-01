<h3 class="title-b">{$lang.browseprod}</h3>


{if $current_cat!='addons' && $current_cat!='transfer' && $current_cat!='register'}

	{if $products}

{foreach from=$products item=i name=loop key=k}
<div class="bubble" style="display:none;">
	<div class="bubble_l"></div>
	<div class="bubble_c">{$i.name}</div>
	<div class="bubble_r"></div>
</div>		
	{/foreach}

<div class="shead">
	<div class="menu-prod">
		{foreach from=$categories item=i name=categories}

{if $i.id == $current_cat} <strong>{$i.name}</strong>{/if}{/foreach}

		{foreach from=$categories item=i name=categories name=cats}
		{if $i.id != $current_cat}
		<a href="{$ca_url}cart/{$i.slug}/&amp;step={$step}{if $addhosting}&amp;addhosting=1{/if}">{$i.name}</a> {if !$smarty.foreach.cats.last}{/if}
		{/if}
		{/foreach}
		
		{if $logged=='1'}  {if $current_cat=='addons'}<strong>{else}<a href="{$ca_url}cart&amp;step={$step}&amp;cat_id=addons">{/if}{$lang.prodaddons}{if $current_cat=='addons'}</strong>{else}</a>{/if}{/if}
	</div>	
	<div class="nw-host-border"></div>
	<div class="clear"></div>
</div>

<div class="slidebg">
<!--start plan from thiavps.com-->

	     
    <div class="container private">
        <div class="span12 clear-mp">
            <div class="span3 clear-mp">
                <div style="padding-top:20px; padding-left:15px;"><img src="{$template_dir}images/price-img.jpg" alt="cloud vps" width="250" height="215" /></div>
				<nav class="jumpto-subnav"><div class="jumpto-title">Price Plan</div><ul class="jumpto-first"><li><a href="https://netway.co.th/cart/cloud-vps/#jumpto_0">Linux Server</a></li><li><a href="https://netway.co.th/cart/cloud-vps/#jumpto_1">Windows Server 2012</a></li><li><a href="https://netway.co.th/cart/cloud-vps/#jumpto_2">Ubuntu Server</a></li><li><a href="https://netway.co.th/cart/cloud-vps/#jumpto_3">Java Server</a></li><li><a href="https://netway.co.th/cart/cloud-vps/#jumpto_4">Cloud Files Server</a></li></ul></nav>
            </div>
            <div class="span9">
                <div class="page_container">
                    <div class="jumpto-block">
                        <div class="aleft marbot"><b class="font16 txtblue">เริ่มต้นที่ 1,500* บาทต่อเดือน</b> ด้วยคุณสมบัติและสเปคที่มีประสิทธิภาพและพร้อมใช้งาน คุณสามารถเลือกแพคเกจที่เราจัดให้ และเลือกที่จะตั้งค่าส่วนเสริมได้ตามที่คุณต้องการตามความจำเป็นในแต่ละช่วงเวลา** โดยทุกๆแพคเกจเราขอมอบ 2 IP Address โปรแกรม <b>Free Monitoring Services และ Remote Console with 2-Factor Authentication Login </b>ให้คุณได้ใช้งานโดยไม่เสียค่าใช้จ่ายใดๆเพิ่มเติม</div>
						<br />
                        <div class="marbot">
                            <h4 class="txtblue">Prompt Cloud VPS Package แพคเกจที่พร้อมใช้งาน </h4>
                            <div class="aleft">เราได้จัดสเปคที่พร้อมให้คุณใช้งานตามประเภทของเครื่อง Server และตามขนาดการใช้งานจริง ซึ่งในแต่ละแพคเกจนั้นเรายังมอบโปรแกรมต่างๆที่ใช้งานกับ Cloud VPS ให้คุณเพื่อเพิ่มประสิทธิภาพในการใช้งานให้ดียิ่งขึ้นและเต็มประสิทธิภาพอีกด้วย </div>
                        </div>
                        <div class="span12 price-logo clear-mp">
                            <span><img src="{$template_dir}images/logo-linux.jpg" alt="cloud vps" width="107" height="36" /></span>
                            <span><img src="{$template_dir}images/logo-windows-server.jpg" alt="cloud vps" width="168" height="28" /></span>
                            <span><img src="{$template_dir}images/ubuntu.jpg" alt="cloud vps" width="128" height="35" /></span>
                            <span><img src="{$template_dir}images/centOS.jpg" alt="cloud vps" width="124" height="36" /></span>
                            <span><img src="{$template_dir}images/owncloud.jpg" alt="cloud vps" width="112" height="43" /></span>
                        </div>
                    </div> 
                    
                     <div class="jumpto-block"><a name="jumpto_0"></a>
                        <h2 class="pri-tab">Linux Server</h2>
                        <div class="span4">
                            <div class="price-plan">
                                <div class="title-linux">Secured Linux (no control panel)</div>
                                <div class="space">
                                    <div>vCPU : 1 Core</div>
                                    <div>RAM : 1 GB </div>
                                    <div>DISK : 30 GB</div>
                                    <div class="price">ราคา : 1,500 บาท</div>
                                </div>
                                <div class="bg-price">
                                    <div class="bgbtn-click2"><a class="btn-click" href="index.php/?cmd=ordercloudvps&action=orderLinuxServer&plan=1"><span>สั่งซื้อ</span></a></div>
                                    <div class="bgbtn-click3"><a class="fancybox fancybox.iframe btn-click" href="http://thaivps.com/quotation.php"><span>ขอใบเสนอราคา</span></a></div>
                                </div>
                            </div>
                        </div>
                        <div class="span4">
                            <div class="price-plan">
                                <div class="title-linux">cPanel+skin plan A</div>
                                <div class="space">
                                    <div>vCPU : 1 Core</div>
                                    <div>RAM : 2 GB </div>
                                    <div>DISK : 30 GB</div>
                                    <div class="price">ราคา : 2,400 บาท</div>
                                </div>
                                <div class="bg-price">
                                    <div class="bgbtn-click2"><a href="index.php/?cmd=ordercloudvps&action=orderLinuxServer&plan=2" class="btn-click"><span>สั่งซื้อ</span></a></div>
                                    <div class="bgbtn-click3"><a class="fancybox fancybox.iframe btn-click" href="http://thaivps.com/quotation.php"><span>ขอใบเสนอราคา</span></a></div>
                                </div>
                            </div>
                        </div>
                        <div class="span4">
                            <div class="price-plan">
                                <div class="title-linux">cPanel+skin plan B</div>
                                <div class="space">
                                    <div>vCPU : 2 Cores</div>
                                    <div>RAM : 4 GB </div>
                                    <div>DISK : 50 GB</div>
                                    <div class="price">ราคา : 3,600 บาท</div>
                                </div>
                                <div class="bg-price">
                                    <div class="bgbtn-click2"><a href="index.php/?cmd=ordercloudvps&action=orderLinuxServer&plan=3" class="btn-click"><span>สั่งซื้อ</span></a></div>
                                    <div class="bgbtn-click3"><a class="fancybox fancybox.iframe btn-click" href="http://thaivps.com/quotation.php"><span>ขอใบเสนอราคา</span></a></div>
                                </div>
                            </div>
                        </div>
                        <div class="span4">
                            <div class="price-plan">
                                <div class="title-linux">Directadmin plan A</div>
                                <div class="space">
                                    <div>vCPU : 1 Core</div>
                                    <div>RAM : 2 GB </div>
                                    <div>DISK : 30 GB</div>
                                    <div class="price">ราคา : 2,350 บาท</div>
                                </div>
                                <div class="bg-price">
                                    <div class="bgbtn-click2"><a href="index.php/?cmd=ordercloudvps&action=orderLinuxServer&plan=4" class="btn-click"><span>สั่งซื้อ</span></a></div>
                                    <div class="bgbtn-click3"><a class="fancybox fancybox.iframe btn-click" href="http://thaivps.com/quotation.php"><span>ขอใบเสนอราคา</span></a></div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="span4">
                            <div class="price-plan">
                                <div class="title-linux">Directadmin plan B</div>
                                <div class="space">
                                    <div>vCPU : 2 Cores</div>
                                    <div>RAM : 4 GB </div>
                                    <div>DISK : 50 GB</div>
                                    <div class="price">ราคา : 3,550 บาท</div>
                                </div>
                                <div class="bg-price">
                                    <div class="bgbtn-click2"><a href="index.php/?cmd=ordercloudvps&action=orderLinuxServer&plan=5" class="btn-click"><span>สั่งซื้อ</span></a></div>
                                    <div class="bgbtn-click3"><a class="fancybox fancybox.iframe btn-click" href="http://thaivps.com/quotation.php"><span>ขอใบเสนอราคา</span></a></div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="clearit"></div>
                        
                        <div class="span12">
                            ทุก <b>Linux Plan</b> ติดตั้ง พร้อม package ต่อไปนี้ ฟรี 
                            <ul>
                                <li>Clamav Anti-virus</li>
                                <li>LAMP (linux-Apache-MySQL-PHP-PHPMyAdmin)</li>
                            </ul>
							<div><span class="star">**</span> ราคานี้ยังไม่รวมบริการ Managed Server Services 2,000 บาท/เดือน <span class="star">**</span> </div>
                        </div>
                        
                     </div>
                     
                     <div class="clearit"></div>
                     
                     <div class="jumpto-block"><a name="jumpto_1"></a>
                        <h2 class="pri-tab">Windows Server 2012</h2>
                
                        <div class="span4">
                            <div class="price-plan">
                                <div class="title-windows">Plan A</div>
                                <div class="space">
                                    <div>vCPU : 1 Core</div>
                                    <div>RAM : 2 GB </div>
                                    <div>DISK : 50 GB</div>
                                   <div class="price">ราคา : 2,700 บาท</div>
                                </div>
                                <div class="bg-price">
                                    <div class="bgbtn-click2"><a href="index.php/?cmd=ordercloudvps&action=orderWindowsServer&plan=1" class="btn-click"><span>สั่งซื้อ</span></a></div>
                                    <div class="bgbtn-click3"><a class="fancybox fancybox.iframe btn-click" href="http://thaivps.com/quotation.php"><span>ขอใบเสนอราคา</span></a></div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="span4">
                            <div class="price-plan">
                                <div class="title-windows">Plan B</div>
                                <div class="space">
                                    <div>vCPU : 2 Cores</div>
                                    <div>RAM : 2 GB </div>
                                    <div>DISK : 100 GB</div>
                                    <div class="price">ราคา : 3,700 บาท</div>
                                </div>
                                <div class="bg-price">
                                    <div class="bgbtn-click2"><a href="index.php/?cmd=ordercloudvps&action=orderWindowsServer&plan=2" class="btn-click"><span>สั่งซื้อ</span></a></div>
                                    <div class="bgbtn-click3"><a class="fancybox fancybox.iframe btn-click" href="http://thaivps.com/quotation.php"><span>ขอใบเสนอราคา</span></a></div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="span4">
                            <div class="price-plan">
                                <div class="title-windows">Plan C</div>
                                <div class="space">
                                    <div>vCPU : 2 Cores</div>
                                    <div>RAM : 4 GB </div>
                                    <div>DISK : 150 GB</div>
                                    <div class="price">ราคา : 4,700 บาท</div>
                                </div>
                                <div class="bg-price">
                                    <div class="bgbtn-click2"><a href="index.php/?cmd=ordercloudvps&action=orderWindowsServer&plan=3" class="btn-click"><span>สั่งซื้อ</span></a></div>
                                    <div class="bgbtn-click3"><a class="fancybox fancybox.iframe btn-click" href="http://thaivps.com/quotation.php"><span>ขอใบเสนอราคา</span></a></div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="clearit"></div>
                        
                        <div class="span12">
                                ทุก <b>Windows Plan</b> ติดตั้ง พร้อม package ต่อไปนี้ ฟรี 
                            <ul>    
                                <li>Microsoft SQL Server 2012 Express<span class="star">*</span></li>
                                <li>MailEnable Standard Edition</li>
                                <li>Clamav Anti-virus<span class="star">**</span></li>
                            </ul>
                            <div><span class="star">&nbsp;*</span> สามารถเปลี่ยนเป็น Microsoft SQL Server 2012 Business Intelligence ได้ ในราคา 1,000 บาท/เดือน / db</div>
                            <div><span class="star">**</span> สามารถเปลี่ยนเป็น Kaspersky Antivirus Endpoint Security 10 ได้ ในราคา 200 บาท/เดือน</div>
                        </div>
                        
                     </div>
                     
                     <div class="clearit"></div>
                     
                     <div class="jumpto-block"><a name="jumpto_2"></a>
                        <h2 class="pri-tab">Ubuntu Server</h2>
                        <div class="span4">
                            <div class="price-plan">
                                <div class="title-ubuntu">Plan A</div>
                                <div class="space">
                                    <div>vCPU : 1 Core</div>
                                    <div>RAM : 1 GB </div>
                                    <div>DISK : 30 GB</div>
                                    <div class="price">ราคา : 1,500  บาท</div>
                                </div>
                                <div class="bg-price">
                                    <div class="bgbtn-click2"><a href="index.php/?cmd=ordercloudvps&action=orderUbuntuServer&plan=1" class="btn-click"><span>สั่งซื้อ</span></a></div>
                                    <div class="bgbtn-click3"><a class="fancybox fancybox.iframe btn-click" href="http://thaivps.com/quotation.php"><span>ขอใบเสนอราคา</span></a></div>
                                </div>
                            </div>
                        </div>
                        <div class="span4">
                            <div class="price-plan">
                                <div class="title-ubuntu">Plan B</div>
                                <div class="space">
                                    <div>vCPU : 1 Core</div>
                                    <div>RAM : 2  GB </div>
                                    <div>DISK : 50  GB</div>
                                    <div class="price">ราคา : 1,950 บาท</div>
                                </div>
                                <div class="bg-price">
                                    <div class="bgbtn-click2"><a href="index.php/?cmd=ordercloudvps&action=orderUbuntuServer&plan=2" class="btn-click"><span>สั่งซื้อ</span></a></div>
                                    <div class="bgbtn-click3"><a class="fancybox fancybox.iframe btn-click" href="http://thaivps.com/quotation.php"><span>ขอใบเสนอราคา</span></a></div>
                                </div>
                            </div>
                        </div>
                        <div class="span4">
                            <div class="price-plan">
                                <div class="title-ubuntu">Plan C</div>
                                <div class="space">
                                    <div>vCPU : 2 Cores</div>
                                    <div>RAM : 4 GB </div>
                                    <div>DISK : 100 GB</div>
                                    <div class="price">ราคา : 3,450 บาท</div>
                                </div>
                                <div class="bg-price">
                                    <div class="bgbtn-click2"><a href="index.php/?cmd=ordercloudvps&action=orderUbuntuServer&plan=3" class="btn-click"><span>สั่งซื้อ</span></a></div>
                                    <div class="bgbtn-click3"><a class="fancybox fancybox.iframe btn-click" href="http://thaivps.com/quotation.php"><span>ขอใบเสนอราคา</span></a></div>
                                </div>
                            </div>
                        </div>
                        <div class="clearit"></div>
                        <div class="span12">
                            ทุก <b>Linux Plan</b> ติดตั้ง พร้อม package ต่อไปนี้ ฟรี 
                            <ul>
                                <li>Clamav Anti-virus</li>
                                <li>Linux, Apache, MySQL, PHP, PHPMyAdmin</li>
                            </ul>
							<div><span class="star">**</span> ราคานี้ยังไม่รวมบริการ Managed Server Services 2,000 บาท/เดือน <span class="star">**</span> </div>
                        </div>
                        <div class="clearit"></div>

                     </div>
                     
                     <div class="clearit"></div>
                     
                     <div class="jumpto-block"><a name="jumpto_3"></a>
                        <h2 class="pri-tab">Java Server</h2>
                
                        <div class="span4">
                            <div class="price-plan">
                                <div class="title-java">CentOS+cPanel+skin+tomcat <br />Plan A</div>
                                <div class="space">
                                    <div>vCPU : 2 Cores</div>
                                    <div>RAM : 4 GB </div>
                                    <div>DISK : 50 GB</div>
                                    <div class="price">ราคา : 3,600 บาท</div>
                                </div>
                                <div class="bg-price">
                                    <div class="bgbtn-click2"><a href="index.php/?cmd=ordercloudvps&action=orderJavaServer&plan=1" class="btn-click"><span>สั่งซื้อ</span></a></div>
                                    <div class="bgbtn-click3"><a class="fancybox fancybox.iframe btn-click" href="http://thaivps.com/quotation.php"><span>ขอใบเสนอราคา</span></a></div>
                                </div>
                            </div>
                        </div>
                        <div class="span4">
                            <div class="price-plan">
                                <div class="title-java">CentOS+cPanel+skin+tomcat <br />Plan B</div>
                                <div class="space">
                                    <div>vCPU : 4 Cores</div>
                                    <div>RAM : 4 GB </div>
                                    <div>DISK : 100 GB</div>
                                    <div class="price">ราคา : 5,100 บาท</div>
                                </div>
                                <div class="bg-price">
                                    <div class="bgbtn-click2"><a href="index.php/?cmd=ordercloudvps&action=orderJavaServer&plan=2" class="btn-click"><span>สั่งซื้อ</span></a></div>
                                    <div class="bgbtn-click3"><a class="fancybox fancybox.iframe btn-click" href="http://thaivps.com/quotation.php"><span>ขอใบเสนอราคา</span></a></div>
                                </div>
                            </div>
                        </div>
                        <div class="clearit"></div>
						<div class="col-md-12"><span class="star">**</span> ราคานี้ยังไม่รวมบริการ Managed Server Services 2,000 บาท/เดือน <span class="star">**</span> </div>
						<div class="clearit"></div>
                     </div>
                     
                      <div class="clearit"></div>
                      
                     <div class="jumpto-block"><a name="jumpto_4"></a>
                        <h2 class="pri-tab">Cloud Files Server</h2>
                        <div class="span4">
                            <div class="price-plan">
                                <div class="title-cloud">Plan A</div>
                                <div class="space">
                                    <div>vCPU : 1 Core</div>
                                    <div>RAM : 2 GB </div>
                                    <div>DISK : 100 GB</div>
                                    <div class="price">ราคา : 2,450 บาท</div>
                                </div>
                                <div class="bg-price">
                                    <div class="bgbtn-click2"><a href="index.php/?cmd=ordercloudvps&action=orderCloudFilesServer&plan=1" class="btn-click"><span>สั่งซื้อ</span></a></div>
                                    <div class="bgbtn-click3"><a class="fancybox fancybox.iframe btn-click" href="http://thaivps.com/quotation.php"><span>ขอใบเสนอราคา</span></a></div>
                                </div>
                            </div>
                        </div>
                        <div class="span4">
                            <div class="price-plan">
                                <div class="title-cloud">Plan B</div>
                                <div class="space">
                                    <div>vCPU : 2 Cores</div>
                                    <div>RAM : 4 GB </div>
                                    <div>DISK : 200 GB</div>
                                    <div class="price">ราคา : 4,450 บาท</div>
                                </div>
                                <div class="bg-price">
                                    <div class="bgbtn-click2"><a href="index.php/?cmd=ordercloudvps&action=orderCloudFilesServer&plan=2" class="btn-click"><span>สั่งซื้อ</span></a></div>
                                    <div class="bgbtn-click3"><a class="fancybox fancybox.iframe btn-click" href="http://thaivps.com/quotation.php"><span>ขอใบเสนอราคา</span></a></div>
                                </div>
                            </div>
                        </div>
                        
                        
                        <div class="clearit"></div>
                        <div class="span12"><span class="star">*</span> ราคาไม่รวมภาษีมูลค่าเพิ่ม 7% </div>
						<div class="clearit"></div>
						<div class="col-md-12"><span class="star">**</span> ราคานี้ยังไม่รวมบริการ Managed Server Services 2,000 บาท/เดือน <span class="star">**</span> </div>
                        <div class="clearit"></div>
                     </div>
                    </div> 
                </div><!-- Classpage_container -->
        </div><!-- Main -->
    </div><!-- Class Container -->
        

<!--end plan from thiavps.com-->
</div>
<script src="{$template_dir}js/jquery-ui-1.8.2.custom.min.js" type="text/javascript"></script>
<!-- Edit Below -->
<!--script from thaivps.com-->
    <script type="text/javascript" src="//code.jquery.com/jquery-1.9.1.js"></script>
<!--script from thaivps.com-->

<script type="text/javascript">
{literal}
            $(document).ready( function() {
                $('a[class="fancybox fancybox.iframe btn-click"]').prop('href',function() {
                    $(this).prop('target','_blank');
                    var url = $(this).prop('href');
                    var pa  = $(this).parent().parent().parent();
                    var server = $(this).parent().parent().parent().parent().parent().children('h2').first().text();
                    var packName = pa.children().first().text();
                    var cpu = pa.children('.space').children('div').first().text();
                    var ram = pa.children('.space').children('div:eq(1)').text();
                    var disk = pa.children('.space').children('div:eq(2)').text();
                    var price = pa.children('.space').children('div:eq(3)').text();
                
                    url += "?pack="+packName;
                    url += "&cpu="+cpu;
                    url += "&ram="+ram;
                    url += "&disk="+disk;
                    url += "&price="+price;
                     url += "&server="+server;
                   return url;
                });
                
              });
              
              
function bindSlider() {
	$('.slix li').each(function(n){
		$(this).click(function(){
			scrollToEl(n);
			return false;		
		});
		$(this).hover(function(){	
			$('.bubble').eq(n).show();
		},function(){
		$('.bubble').fadeOut('fast');
		});
	});
	$('.bubble').each(function(n){
		$(this).css('top',$('.slix li').eq(n).offset().top-30);
		$(this).css('left',$('.slix li').eq(n).offset().left);
	});
	$('#slider').width($('.slix').width()-40);
	$('#slider').slider({min: 0, max: ($('.slix li').length-1)+0.4, value: 0,step:0.1,range:"min", animate: true, stop:function(e,ui){		   
			slidCb(true);
			
	},change: function(e, ui){	
			slidCb(false);
	},slide: function(e, ui){	
			slidCb(false);
	}
	});
}
function slidCb(magic) {
var x = Math.floor($('#slider').slider( "value" ));
			$('.slix li').removeClass('active');
			$('.pricetag').hide();
			$('.pricetag').eq(x).show();
			$('.descriptionx').hide();
			$('.descriptionx').eq(x).show();
			for(var a=0;a<x+1;a++) {
				$('.slix li').eq(a).addClass('active');				
			}
			if(magic) {
			$('.bubble').eq(x).fadeIn('fast',function(){
			setTimeout("$('.bubble').eq("+x+").fadeOut('slow');",550);
				
				});
			}
}
function scrollToEl(ele) {
	$('#slider').slider("value", ele);

}
appendLoader('bindSlider');
{/literal}
</script>

	
	{else}
	{foreach from=$categories item=i name=categories name=cats}

{if $i.id == $current_cat} <strong>{$i.name}</strong> {if !$smarty.foreach.cats.last}|{/if}
{else} <a href="{$ca_url}cart&amp;step={$step}&amp;cat_id={$i.id}{if $addhosting}&amp;addhosting=1{/if}">{$i.name}</a> {if !$smarty.foreach.cats.last}|{/if}
{/if}
{/foreach}

{if $logged=='1'} | {if $current_cat=='addons'}<strong>{else}<a href="{$ca_url}cart&amp;step={$step}&amp;cat_id=addons">{/if}{$lang.prodaddons}{if $current_cat=='addons'}</strong>{else}</a>{/if}{/if}


	{/if}
	
{/if}
	