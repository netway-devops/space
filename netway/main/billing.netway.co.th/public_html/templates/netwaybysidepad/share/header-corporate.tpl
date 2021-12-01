<link type="text/css" rel="stylesheet" media="screen" href="{$template_dir}css/font-awesome/css/style.css" />
<!-- Add fancyBox main JS and CSS files -->
<script type="text/javascript" src="https://netway.co.th/templates/netwaybysidepad/share/js/fancybox/jquery.fancybox.js?v=2.1.4"></script>
<link type="text/css" rel="stylesheet" media="screen" href="https://netway.co.th/templates/netwaybysidepad/share/js/fancybox/jquery.fancybox.css" />
<script type="text/javascript" src="https://netway.co.th/templates/netwaybysidepad/share/js/fancybox/fancybox.js"></script>

<div class="head-corporate hidden-phone">
	<div class="topmenu">
		<div class="container"> 	
			<div class="row-fluid">
             <div class="span6">
                    <span class="hotline hidden-phone"><b><i>HOT LINE :</i></b> 0-2912-2558 บริการ 24 ชั่วโมง</span>
             </div>
			<div class="span6"> 
				<div class="right">
					<ul id="navtop">  
						<li><a href="https://support.netway.co.th/hc/th"><i class="fa fa-question-circle"></i> <span class="hidden-phone">Support</span></a></li>
						<li><a href="{$ca_url}payment"><i class="fa fa-money"></i> <span class="hidden-phone">การชำระเงินและภาษี</span></a></li>
						<li><a href="{$ca_url}contact"><i class="fa fa-comments-o"></i> <span class="hidden-phone">ติดต่อเรา </span></a></li>
                        <li>
								{if $logged=='1'}
								<span style="display:block; cursor:pointer;"><i class="fa fa-sign-in"></i>  {$login.firstname} {$login.lastname}</span>
								{else}
								<a href="{$ca_url}clientarea/" rel="nofollow"><i class="fa fa-sign-in"></i> เข้าสู่ระบบ</a>
								{/if}
					  	<div class="btn-group" style="float:right; margin-top:0px;">
							
								<ul class="dropdown-menu  pull-right" style="margin-left:-100px; margin-top:0px; background:#f2f2f2;">

									{if $logged!='1'}
									{else}
									<li><a href="{$ca_url}clientarea/details/">{$lang.manageaccount}</a></li>
									<li><a href="https://support.netway.co.th/access/logout?return_to=https%3A%2F%2Fnetway.co.th%2F">{$lang.logout}</a></li>
									{/if}
									{if $adminlogged}
									<li class="divider"></li>
									<li><a  href="{$admin_url}/index.php{if $login.id}?cmd=clients&amp;action=show&amp;id={$login.id}{/if}">{$lang.adminreturn}</a></li>
									{/if}

								</ul>
							</div>
					  </li>
					</ul>   
				</div> 
			</div>
                      
                </div> 
			   <div class="clearit"></div>
			  </div>  
		</div>
	</div>

<div class="head-corporate-phone visible-phone">
		<span>
			<a href="{$ca_url}"><img src="{$template_dir}images/logo-netway-gray.png"/></a>
		</span>
	    <div class="right">
			<ul id="navtop">  
					<li><a href="https://support.netway.co.th/hc/th">
						<i class="fa fa-question-circle"></i>
						<span class="visible-phone" style="font-family: 'superspace_regular'">Support</span>
					</a>
					</li>
					<li><a href="{$ca_url}payment">
						<i class="fa fa-money"></i> 
						<span class="visible-phone" style="font-family: 'superspace_regular'">วิธีชำระเงิน</span>
					</a>
					</li>
			</ul>
		</div>
		<h4 style="color: #ffffff; padding: 0 0 0 5px; font-family: 'superspace_regular'">0-2912-2558 บริการ 24 ชั่วโมง</h4>
</div>
</div>
