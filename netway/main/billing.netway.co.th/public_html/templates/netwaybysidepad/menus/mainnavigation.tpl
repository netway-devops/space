<!------------------- Start Middle ----------------------------->
<div class="bgnavigator hidden-phone" style="padding-top:5px;" >
    <div class="container" style="">
        <nav id="global-menu" role="navigation" >
            <a style="font-family: 'superspace_regular'; padding-left: 5px; text-decoration: none; color: #c1c1c1;" href="#global-menu"  title="แสดงผลิตภัณฑ์ทั้งหมด">
                แสดงผลิตภัณฑ์ทั้งหมด 
                </a>
                <!--<i class="fa fa-chevron-down fa-2x" style="float: right; color: #FFFFFF; margin-top: -7px;"></i>-->

            <a style="font-family: 'superspace_regular'" href="#" title="แสดงผลิตภัณฑ์ทั้งหมด"> ผลิตภัณฑ์ทั้งหมด</a>
            <ul class="clearfix">
                <li><a href="http://www.siamdomain.com/" >Domain</a></li>
                <li><a href="http://www.siaminterhost.com" >Hosting</a></li>
                <li><a href="http://www.thaivps.com" >Cloud VPS - Dedicated</a></li>
                <li><a href="{$ca_url}email">E-Mail and Office</a></li>
                <li><a href="https://netwaystore.in.th/" >Software</a></li>
                <li><a href="https://ssl.in.th/" >SSL</a></li>
                <li><a href="http://netway.services">Customer Services</a></li>
            </ul>
        </nav>
    </div>
</div>
<div class="bgnav-mobile visible-phone" style="cursor: pointer;">
    <div class="navbar-default">
        <div class="navbar-header" data-toggle="collapse" data-target=".navall-collapse">
              <p style="font-family: 'superspace_regular'; font-size: 16px; padding-left: 5px; margin-top: 10px; text-decoration: none; color: #c1c1c1;">
                แสดงผลิตภัณฑ์ทั้งหมด
              </p>
        </div>
        <div class="navall-collapse collapse" style="height: 1px;overflow: hidden; ">
          <ul class="nav navbar-nav fright">
            <li><a style="font-family: 'superspace_regular'" href="http://www.siamdomain.com/" >Domain</a></li>
            <li><a style="font-family: 'superspace_regular'" href="http://www.siaminterhost.com" >Hosting</a></li>
            <li><a style="font-family: 'superspace_regular'" href="http://www.thaivps.com" >Cloud VPS - Dedicated</a></li>
            <li><a style="font-family: 'superspace_regular'" href="{$ca_url}email" {if $cmd=='email'}class="active"{/if}>E-Mail and Office</a></li>
            <li><a style="font-family: 'superspace_regular'" href="https://netwaystore.in.th/" >Software</a></li>
            <li><a style="font-family: 'superspace_regular'" href="https://ssl.in.th/" >SSL</a></li>
            <li><a style="font-family: 'superspace_regular'" href="http://netway.services" >Customer Services</a></li>
          </ul>

        </div><!--/.nav-collapse -->
    </div>
</div>
<!------------------- End Middle ----------------------------->
<div class="topmenu-nw hidden-phone setopacity0" id="main-nev-desktop" style="box-shadow: 0 2px 4px 0 rgba(0,0,0,0.16),0 2px 10px 0 rgba(0,0,0,0.12)!important; padding-bottom: 7px;">
<div class="container topmenu-nw hidden-phone setopacity0" id="main-nev-desktop">
		<div class="row-fluid">     
			<div class="span7" id="inside-1">
				<a href="{$ca_url}"><img src="{$template_dir}images/logo-netway-20th.png" width="152" height="54" /></a>
				<div class="inline-block">
				<nav id="inside-menu" role="navigation">
					<ul class="clearfix">
						<li style=""><a class="" href="{$ca_url}companyprofile"><font size="3">About us</font></a></li>
						
						<li><a href="#" onclick="gotoPartners();"><font size="3">Partners</font></a></li>
						<li><a href="{$ca_url}reseller"><font size="3">Reseller</font></a></li>
	                    <li><a href="http://blog.netway.co.th/" target="blognetway window"><font size="3">Blog news</font></a></li>
					    <li style="padding-top: 3px;"><a style="font-family: 'superspace_regular'" href="{$ca_url}jobs">ร่วมงานกับเรา</a></li>
					</ul>
				</nav>
				</div>
			</div>
			<div id="inside-2">
				<div class="right">
				<table cellspacing="0" cellpadding="4">
				  <tr>
					<td class="text-right hidden-phone"><span><a href="http://netway.co.th/order"><img src="{$template_dir}images/order.jpg" alt="สั่งซื้อ" width="118" height="45" /></a></span></td>
				  </tr> 
				</table>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="bgnav-mobile visible-phone" id="main-nev" style="cursor: pointer;">
    <div class="navbar-default">
        <div class="navbar-header">
            <div data-target=".navbar-collapse" data-toggle="collapse">
              <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target=".navbar-collapse">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
              </button>
              <p style="font-family: 'superspace_regular'; color: #ff852e; margin-left: 5px; font-size: 20px; margin-top: 2px;">Netway.co.th</p>
            </div>
        </div>
        <div class="navbar-collapse collapse" style="height: 1px;overflow: hidden; ">
    
          <ul class="nav navbar-nav fright">
          	<li><a style="font-family: 'superspace_regular'" href="">Home</a></li>
          	<li><a style="font-family: 'superspace_regular'" href="{$ca_url}companyprofile">About us</a></li>
          	<li><a style="font-family: 'superspace_regular'" href="#" onclick="gotoPartners();">Partners</a></li>
            <li><a style="font-family: 'superspace_regular'" href="{$ca_url}reseller">Reseller</a></li>
            <li><a style="font-family: 'superspace_regular'" href="http://blog.netway.co.th/" target="blognetway window">Blog news</a></li>
            <li><a style="font-family: 'superspace_regular'" href="{$ca_url}jobs">ร่วมงานกับเรา</a></li>
          </ul>
            
        </div><!--/.nav-collapse -->
    </div>
</div>
{literal}
<style>
	.fix-topmenu-phone  {
    	position: fixed;
    	width: 100%;
    	top: 0;
    	z-index: 9988;
   }
   .fix-topmenu-desktop  {
    	position: fixed;
    	width: 100%;
    	top: 0;
    	z-index: 9988;
    	box-shadow: 0 2px 4px 0 rgba(0,0,0,0.16),0 2px 10px 0 rgba(0,0,0,0.12)!important;
    	padding-bottom: 7px !important;
   }
   .fix-topmenu-alignLeft{
   		margin-left: 7% !important;
   }
   .fix-topmenu-alignRight{
   		margin-right: 7% !important;
   }
</style>
<script>

	$(window).scroll(function(e){
			if($(window).scrollTop() >= 130){
				$('#main-nev').addClass('fix-topmenu-phone');
				$('#main-nev-desktop').addClass('fix-topmenu-desktop');
				$('#main-nev-desktop').removeClass("setopacity0");
				//$('#inside-1').addClass('fix-topmenu-alignLeft');
				//$('#inside-2').addClass('fix-topmenu-alignRight');
			}else{
				$('#main-nev').removeClass("fix-topmenu-phone");
				$('#main-nev-desktop').removeClass("fix-topmenu-desktop");
				$('#main-nev-desktop').addClass("setopacity0");
				$('#inside-1').removeClass('fix-topmenu-alignLeft');
				$('#inside-2').removeClass('fix-topmenu-alignRight');
			}
	});

</script>
{/literal}

