
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

<style type="text/css" rel="stylesheet">
ul.mobile-menu {
	margin:0px;
	padding:0px;
	position: relative; 
}
ul.mobile-menu li{
	margin:0px;
	padding:0px;
	text-align: left;
	list-style: none;
	position: relative;
}
ul.mobile-menu a {
	margin:0px;
	text-decoration:none;  
	display:block;
	padding:5px 10px;
	color: #fff; 
	background-color:#52a1da;
}
ul.mobile-menu a:hover, ul.mobile-menu .current {
	display:block;
	color: #fff;
	padding:5px 10px; 
	background-color:#52a1da; 
}


.onClick {
	cursor: pointer;
	position: relative; 
	padding:0; 
	margin:0;
}
.onClick span{	
	padding: 5px 10px; 
	display:block;
}
.chlidren {
	display:none;  
  	color:#fff;
 	background-color:#52a1da;
  	text-decoration:none;
  	width:100%;
  	left:0;
  	padding:0;
  	margin:0; 
}
.chlidren li a, .chlidren li a:visited, .chlidren li a:hover, .chlidren li a:active {
  	display:block;
  	color:#fff;
  	background-color:#52a1da; 
 	padding-top:7px;
  	padding-bottom:7px;
  	padding-left:20px;
  	text-decoration:none;
  	border-top:#a8c2d5 solid 1px;
	border-bottom:#a8c2d5 solid 0px;
	font-size:16px;
}
.chlidren li a:hover, .chlidren li a:active{
	background-color:#000; 
}
.chlidren ul li a, .chlidren ul li a:visited {
	background:#52a1da;
	padding-top:7px;
	padding-bottom:7px;
	padding-left:30px; 
	color:#fff;	  
	display:block;	
  	border-top:#a8c2d5 solid 1px;
	border-bottom:#a8c2d5 solid 0px;
}
.chlidren ul li a:hover, .chlidren ul li a:active {
 	background:#52a1da;
 	color: #fff;   
 	padding-top:7px;
  	padding-bottom:7px;
 	padding-left:30px;
  	border-top:#a8c2d5 solid 1px;
	border-bottom:#a8c2d5 solid 0px;
}
#global-menu2 ul, #global-menu2 ol{ list-style: none; margin:0; padding:2px 0 0px 0;}


		#global-menu2
		{
			width: 100%; /* 1000 */
			font-weight: 400;
			position: absolute;
			font-family:tahoma, Verdana, Arial, Helvetica, sans-serif; 
			font-size:14px; 
			z-index:20;
		}

			#global-menu2 > a
			{
				display: none;
			}

			#global-menu2 li
			{
				position: relative;
			}
				#global-menu2 li a
				{
					color: #3a3a3a;
					display: block; 
					text-decoration: none;
				}
				#global-menu2 li a:active
				{
					background-color: #52a1da !important;
				}

			#global-menu2 span:after
			{
				width: 0;
				height: 0;
				border: 0.313em solid transparent; /* 5 */
				border-bottom: none;
				border-top-color: #52a1da;
				content: '';
				vertical-align: middle;
				display: inline-block;
				position: relative;
				right: -0.313em; /* 5 */
			}

			/* first level */

			#global-menu2 > ul
			{
				height: 2.1em; /* 60 */
				background-color: #ffffff;
			}
				#global-menu2 > ul > li
				{
					width: auto;
					float: left;
					-webkit-transition: 0.7s;
					-moz-transition: 0.7s;
					transition: 0.7s;
				}
					#global-menu2 > ul > li > a
					{
						font-size: 0.85em; /* 24 */
						text-align: center;
						padding:6px 10px; 
						-webkit-transition: 0.7s;
						-moz-transition: 0.7s;
						transition: 0.7s;
					}
						#global-menu2 > ul > li:not( :last-child ) > a
						{
							border-right: 1px solid #cccccc;
						}
						#global-menu2 > ul > li:hover > a,
						#global-menu2 > ul:not( :hover ) > li.active > a
						{
							background-color: #52a1da; 
							color:#FFFFFF;
						}


				/* second level */

				#global-menu2 li ul
				{
					background-color: #52a1da;
					display: none;
					position: absolute;
					top: 100%; 
					width:470px;
					color:#fff;
				}
					#global-menu2 li:hover ul
					{
						display: block;
						left: 0;
						right: 0;
						padding:5px; 
						
						
						border: 1px solid #52a1da;
						border-top: 0;
						font-family:tahoma, Verdana, Arial, Helvetica, sans-serif;  
					}
						#global-menu2 li:not( :first-child ):hover ul
						{
							left: -1px;
						}
						#global-menu2 li ul a
						{
							border-top: 1px solid #52a1da;
							padding:2px 8px; 
							font-size:14px; 
							color:#FFFFFF;
						}
							#global-menu2 li ul li a:hover,
							#global-menu2 li ul:not( :hover ) li.active a
							{
								background-color: #52a1da;
								color:#000;
								padding:2px 8px;
							}


		@media only screen and ( max-width: 62.5em ) /* 1000 */
		{
			#global-menu2
			{
				width: 100%;
				position: static;
				margin: 0;
			}
		}

		@media only screen and ( max-width: 40em ) /* 640 */
		{
			
            .bgnavigator br { display:none;}
			#global-menu2
			{
				position: relative;
				top: auto;
				right: 0; 
				padding-bottom:5px;
			}
				#global-menu2 > a
				{
					width: 3.125em; /* 50 */
					height: 3.125em; /* 50 */
					text-align: left;
					text-indent: -9999px;
					background-color: #52a1da;
					position: relative; 
					margin:0 auto; 
					
				}
					#global-menu2 > a:before,
					#global-menu2 > a:after
					{
						position: absolute;
						border: 2px solid #fff;
						top: 35%;
						left: 25%;
						right: 25%;
						content: '';
					}
					#global-menu2 > a:after
					{
						top: 60%;
					}

				#global-menu2:not( :target ) > a:first-of-type,
				#global-menu2:target > a:last-of-type
				{
					display: block;
				}


			/* first level */

			#global-menu2 > ul
			{
				height: auto;
				display: none;
				position: absolute;
				left: 0;
				right: 0; 
			}
				#global-menu2:target > ul
				{
					display: block;  
				}
				#global-menu2 > ul > li
				{
					width: 100%;
					float: none;
				}
					#global-menu2 > ul > li > a
					{
						height: auto;
						text-align: left;
						padding: 0.5em 0.8em; /* 20 (24) */ 
						
					}
						#global-menu2 > ul > li:not( :last-child ) > a
						{
							border-right: none;
							border-bottom: 1px solid #c1c1c1; 
							
						}


				/* second level */

				#global-menu2 li ul
				{
					position: static;
					padding: 1.25em; /* 20 */
					padding-top: 0;
					color:#fff;
					width:100%;
				}
				#global-menu2 li ul li
				{
					padding: 3px;
				}
		}

</style>
{/literal}	
<div class="container topmenu-nw">
	<div class="row-fluid">     
		<div class="span3"><a href="{$ca_url}"><img src="https://netway.co.th/templates/netwaybysidepad/images/logo-netway-color.gif" alt="" width="153" height="55" /></a></div>
		<div class="span9">
			<div class="right">
			<table border="0" cellspacing="0" cellpadding="4" align="center">
			  <tr>
				<td align="right"><span><img src="https://netway.co.th/templates/netwaybysidepad/images/support24-1.gif" alt="" width="45" height="47" /></span></td>
				<td nowrap="nowrap" align="left"><span class="hotline">HOT LINE</span><br /><span class="tel">0-2912-2558</span></td>
			  </tr> 
			</table>
			</div>
		</div>
	</div>
</div>
<div class="topmenubar"></div>
<div class="bgnavigator">
		<div class="container">
			<nav id="global-menu2" role="navigation">
				<a href="#global-menu2" title="Show navigation" id="global-menu2">Menu</a>
				<a href="#" title="Hide navigation">Menu</a>
				<ul class="clearfix">
					<li><a href="http://www.siamdomain.com/" target="siamdomain window">Domain</a></li>
					<li><a href="http://www.siaminterhost.com" target="siaminterhost window">Shared Hosting</a></li>
					<li><a href="{$ca_url}email" {if $cmd=='email'}class="active"{/if}>E-Mail Services</a></li>
					<li><a href="http://www.thaivps.com" target="thaivps window">Cloud Hosting </a></li>
					<li><a href="{$ca_url}colocation" {if $cmd=='colocation'}class="active"{/if}>Colocation</a></li>
					<li><a href="https://ssl.in.th/" target="ssl window">SSL</a></li>
					<li><a href="{$ca_url}security" {if $cmd=='security'}class="active"{/if}>Security</a></li>
					<li><a href="{$ca_url}managedservices" {if $cmd=='managedservices'}class="active"{/if}>Managed Services</a> </li> 
					<li><a href="{$ca_url}website_services" {if $cmd=='website_services'}class="active"{/if} title="รับทำเว็บไซต์"  aria-haspopup="true">Website Services</a> 
						<ul>
							<li>
							<div class="span8" style="float:left;"><img src="{$template_dir}images/submenu-img.jpg" alt="" width="134" height="107" /> บริการเสริมรองรับความหลากหลายให้ธุรกิจของคุณ เข้าถึงกลุ่มลูกค้าได้มากที่สุด <a href="{$ca_url}website" {if $cmd=='website'}class="active"{/if}>ดูรายเอียด</a></div>
							</li>
							<!--
							<li>
							<a href="{$ca_url}website" {if $cmd=='website'}class="active"{/if}> <img src="{$template_dir}images/submenu-img.jpg" alt="" width="45" height="47" /> รับออกแบบเว็บไซต์</a> </li>
							<li><a href="{$ca_url}website_ecommerce" {if $cmd=='website_ecommerce'}class="active"{/if}><img src="https://netway.co.th/templates/netwaybysidepad/images/support24-1.gif" alt="" width="45" height="47" /> รับทำเว็บ E-Commerce</a></li>
							<li><a href="{$ca_url}edm_webservice" {if $cmd=='edm_webservice'}class="active"{/if}><img src="https://netway.co.th/templates/netwaybysidepad/images/support24-1.gif" alt="" width="45" height="47" /> บริการโปรแกรม E-mail ประชาสัมพันธ์</a></li>
							-->
						</ul>
					</li>
					<li><a href="{$ca_url}marketing" {if $cmd=='marketing'}class="active"{/if}>Marketing</a></li>
					<li><a href="http://www.bizoncloud.in.th/" target="bizoncloud window">Training</a></li>
				</ul>
				<br clear="all" />
			</nav>
			<br clear="all" />
			</div>
		 <br clear="all" />
	</div>	