      <link media="all" type="text/css" rel="stylesheet" href="{$template_dir}share/css/top-style.css" />
	  <div class="rv_bgheader">  
		<div id="header" class="container">
			<div>
				<div class="rv_header">
					<div class="rvlogo left"><a href="{$ca_url}"
					   title="Home"><img src="{$template_dir}share/images/rvlogo.gif" alt="" width="146" height="33" /></a>
					</div> 
					<div class="topmenu" style="white-space:nowrap;">
						<div class="btn-group" style="float:right;">
							
							<a href="{$ca_url}contact/">Contact Us | </a> 
							<button id="bg" data-toggle="dropdown" style="margin-top:-8px;">
	
								{if $logged=='1'}
								<i></i> {$login.firstname} {$login.lastname}
								{else}
								<i></i> {$lang.login}
								{/if}
								<span class="caret"></span>
							</button>
							<ul class="dropdown-menu  pull-right" style="margin-left:-100px; padding:5px; background:#f2f2f2;">
	
								{if $logged!='1'}
								<li><a href="{$ca_url}clientarea/" class="txtsub">{$lang.login}</a></li>
								<li><a href="{$ca_url}signup/">Register</a></li>
								{else}
								<li><a href="{$ca_url}clientarea/details/">{$lang.manageaccount}</a></li>
								<li><a href="https://rvglobalsoft.zendesk.com/access/logout?return_to=https%3A%2F%2Frvglobalsoft.com%2F">{$lang.logout}</a></li>
								{/if}
								{if $adminlogged}
								<li class="divider"></li>
								<li><a  href="{$admin_url}/index.php{if $login.id}?cmd=clients&amp;action=show&amp;id={$login.id}{/if}">{$lang.adminreturn}</a></li>
								{/if}
	
							</ul>
						</div>
					</div>     	 
				</div>
			</div>
     </div><!-- end header -->
</div>