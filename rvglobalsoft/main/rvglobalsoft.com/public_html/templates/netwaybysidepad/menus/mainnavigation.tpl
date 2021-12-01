
{literal}
		<script type="text/javascript">
		$(document).ready(function()
		{
			$("#firstpane .onClick").click(function()
			{
				$(this).css({backgroundImage:"url(down.png)"}).next(".chlidren").slideToggle(300).siblings(".chlidren").slideUp("slow");
				$(this).siblings().css({backgroundImage:"url(down.png)"});
			});
		});
		</script>



<script>

    $(window).scroll(function(e){
            if($(window).scrollTop() >= 130){
                $('#main-nev').addClass('fix-topmenu-phone');
                $('#main-nev-desktop').addClass('fix-topmenu-desktop');
                $('.topmenu-nw').removeClass('container');
                $('#inside-1').addClass('fix-topmenu-alignLeft');
                $('#inside-2').addClass('fix-topmenu-alignRight');
            }else{
                $('#main-nev').removeClass("fix-topmenu-phone");
                $('#main-nev-desktop').removeClass("fix-topmenu-desktop");
                $('#main-nev-desktop').removeClass("setopacity0");
                $('.topmenu-nw').addClass('container');
                $('#inside-1').removeClass('fix-topmenu-alignLeft');
                $('#inside-2').removeClass('fix-topmenu-alignRight');
            }
    });

    $(document).ready(function(){
        $('.topmenu-nw').removeClass("setopacity0");
    });

</script>



<style>
#inside-menu ul.dropdown-menu li.dropdown{
    padding:15px 0px;
    margin:0;
}
#inside-menu ul.dropdown-menu li.dropdown  a,
#inside-menu ul.dropdown-menu li.dropdown a:visited,
#inside-menu ul.dropdown-menu li.dropdown a:hover,
#inside-menu ul.dropdown-menu li.dropdown a:active {
    padding:5px 20px;
    margin:0;
    font-size:18px;
    display:block;
    width:100%;
    color:#333;
    background:#fff;
}
#inside-menu ul.dropdown-menu li.dropdown a.productactive,
#inside-menu ul.dropdown-menu li.dropdown a:hover,
#inside-menu ul.dropdown-menu li.dropdown a:active {
    color:#127642;
    background:#fff;
}

</style>

{/literal}

    <div class="bgnavigator">
        <div class="container">
            <div>
			  <div class="desktop-menu">
				<div id="mainmenu" class="clear-mp">
					<div class="span8 clear-mp">
						<a href="https://rvsitebuilder.com/" {if $cmd=='rvsitebuilder'}class="active"{/if} style="border-left:#1f1f1f solid 1px;">RVsitebuilder</a>
						<a href="https://rvskin.com/" {if $cmd=='rvskin'}class="active"{/if}>RVskin</a>
						<a href="https://rvssl.com/">RVssl</a>
					</div>
					<div class="span4 clear-mp" style="float:right;">
						<div class="nav-partner" style="float:right;">
                        	<a href="https://rvglobalsoft.zendesk.com/hc/en-us{if $logged=='1'}/requests{/if}" {if $cmd=='knowledgebase'}class="active"{/if} style="border-left:#1f1f1f solid 1px;">Support</a>
							<a data-toggle="dropdown" href="javascript:void(0)" {if $cmd=='partner'}class="active"{/if}>Partner <span class="white-caret"></span></a>
                            <ul class="dropdown-menu">
                                 <li><a href="https://rvsitebuilder.com/noc-partner/" class="nonebdr">RVsitebuilder NOC Partner</a></li>
                                 <li><a href="https://rvskin.com/nocpartner/" class="nonebdr">RVskin NOC Partner</a></li>
                                 <li><a href="https://rvssl.com/reseller/" class="nonebdr">SSL Reseller Program</a></li>
                            </ul>
						</div>
					</div>
				</div>
				<!--/.nav-collapse -->
			  </div>
			  <div class="clearit"></div>
			  <div id="firstpane" class="mobile-menu">
				  <ul class="mobile-menu">
						<li><a href="javascript:void(0)" class="onClick" style="padding:5px; margin:0;"><span class="bg-mobile">&nbsp;</span></a>
							<ul class="chlidren">
								<li class="{if $cmd=='root'}{/if}"><a href="https://rvsitebuilder.com/" {if $cmd=='rvsitebuilder'}class="active"{/if}>RVsitebuilder</a></li>
								<li><a href="https://rvskin.com/" {if $cmd=='rvskin'}class="active"{/if}>RVskin</a></li>
								<li><a href="https://rvssl.com/">RVssl</a></li>
                                <li><a href="https://rvglobalsoft.zendesk.com/hc/en-us" {if $cmd=='knowledgebase'}class="active"{/if}>Support</a></li>
								<li><a href="https://rvsitebuilder.com/noc-partner/">RVsitebuilder NOC Partner</a></li>
                                <li><a href="https://rvskin.com/nocpartner/">RVskin NOC Partner</a></li>
                                <li><a href="https://rvssl.com/login">SSL Reseller Program</a></li>
							</ul>
						</li>
				   </ul>
				   <div class="clearit"></div>
			  </div>
		</div>
	</div>
</div>
<div class="clearit"></div>



<div class="rvglobal-menu">
<div class="menu-shadow" id="main-nev-desktop">
    <div class="hidden-phone">
        <div class="container" style="background:#fff;">
            <div class="span8">

                <nav id="inside-menu" role="navigation"  style="margin-left:-30px;">
                    <ul class="clearfix">
                        <li><a href="{$ca_url}" class="nav-active">RVglobalsoft</a></li>
                        <li onmouseover="this.setAttribute('class','open'),this.setAttribute('className','open')" onmouseout="this.setAttribute('class',''),this.setAttribute('className','')" ><a href="javascript:void(0);" class="dropdown-toggle" data-toggle="dropdown" {if $cmd=='cpanel_licenses'}class="productactive"{/if}>Products <span class="caret"></span></a>
                            <ul class="dropdown-menu" style="background:#FFFFFF; margin-top:30px; width:200px; margin-left:170px;">
                                <li class="dropdown" style="z-index:1000;">
                                    <!--
                                    <a href="{$ca_url}cpanel_licenses/" {if $cmd=='cpanel_licenses'}class="productactive"{/if}>cPanel</a>
                                    <a href="{$ca_url}ispmanager/" {if $cmd=='ispmanager'}class="productactive"{/if}>ISPmanager</a>
                                    <a href="{$ca_url}litespeed/" {if $cmd=='litespeed'}class="productactive"{/if}>LiteSpeed</a>
                                    -->
                                    <a href="{$ca_url}cloudlinux/" {if $cmd=='cloudlinux'}class="productactive"{/if}>CloudLinux</a>
                                    <a href="{$ca_url}softaculous/" {if $cmd=='softaculous'}class="productactive"{/if}>Softaculous</a>
                                    <a href="{$ca_url}rvskin/" {if $cmd=='rvskin'}class="productactive"{/if}>RVskin</a>
                                    <a href="{$ca_url}rvsitebuilder/" {if $cmd=='rvsitebuilder'}class="productactive"{/if}>RVsitebuilder</a>
                                    <a href="https://www.rvssl.com/reseller/">RVssl</a>
                                    <a href="{$ca_url}virtualizor/" {if $cmd=='virtualizor'}class="productactive"{/if}>Virtualizor</a>
                                </li>
                              </ul>
                        </li>
                        <li><a href="{$ca_url}installation/" {if $cmd=='installation'}class="productactive"{/if}>Installation</a></li>
                        <li><a href="{$ca_url}why_us/" {if $cmd=='why_us'}class="productactive"{/if}>Why Us?</a></li>
                    </ul>
                </nav>

            </div>
            <div id="inside-2" style="padding-right:0px;">
                 <div class="text-right hidden-phone"  style="padding-right:0px;"><a href="{$ca_url}order/" style="padding-right:0px;"><img src="{$template_dir}images/btn-buynow.jpg" alt="order" width="170" height="52" /></a></div>
            </div>
        </div>
    </div>
</div>


<div class="container bgnav-mobile visible-phone" id="main-nev" style="cursor: pointer;">
    <div class="navbar-default">
        <div class="navbar-header">
            <div data-target=".navbar-collapse" data-toggle="collapse">
              <button type ="button" class="navbar-toggle collapsed pull-right btnnone" data-toggle="collapse" data-target=".navbar-collapse" style="border-radius:1px; width:44px; padding:0; margin-top:-5px; margin-right:5px;">
                <span><img src="{$template_dir}images/rvg-button-menu.gif" alt="order" width="40" height="29" /></span>
              </button>
              <p style="color: #fff; margin: 15px 0 15px 20px; font-size: 20px;">RVglobalsoft</p>
            </div>
        </div>
        <div class="navbar-collapse collapse">
          <ul class="nav navbar-nav">
            <li><a href="#"></a></li>
            <li class="mmenu"><a href="{$ca_url}cpanel_licenses/">Products</a></li>
             <!--
            <li class="msubmenu"><a href="{$ca_url}cpanel_licenses/">cPanel</a></li>
            <li class="msubmenu"><a href="{$ca_url}ispmanager/">ISPmanager</a></li>
            <li class="msubmenu"><a href="{$ca_url}litespeed/">LiteSpeed</a></li>
            -->
            <li class="msubmenu"><a href="{$ca_url}cloudlinux/">CloudLinux</a></li>
            <li class="msubmenu"><a href="{$ca_url}softaculous/">Softaculous</a></li>
            <li class="msubmenu"><a href="{$ca_url}rvskin/">RVskin</a></li>
            <li class="msubmenu"><a href="{$ca_url}rvsitebuilder/">RVsitebuilder</a></li>
            <li class="msubmenu"><a href="https://www.rvssl.com/reseller/">RVssl</a></li>
            <li class="msubmenu"><a href="{$ca_url}virtualizor/">Virtualizor</a></li>
            <li class="mmenu"><a href="{$ca_url}installation/">Installation</a></li>
            <li class="mmenu"><a href="{$ca_url}why_us/">Why Us?</a></li>
            <li class="mmenu"><a href="{$ca_url}order/">Order</a></li>
          </ul>

        </div><!--/.nav-collapse -->
    </div>
</div>

</div>


