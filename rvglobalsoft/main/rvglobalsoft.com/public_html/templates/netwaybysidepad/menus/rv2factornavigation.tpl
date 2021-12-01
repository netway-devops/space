
<!-- *************** Start submenu *******************-->

<div class="col-md-12"> 
	 <div class="bgmenu-2factor">
		<div class="container">
			<nav class="hidden-desktop hidden-tablet tab_install" style="margin-top:10px;">
			  <select class="primaryMenuSelect" onchange="window.open(this.options[this.selectedIndex].value,'_top')" style="width:90%;">
				<option value="" active="active" >Menu:</option>
				<option value="{$system_url}?cmd=cart&action=add&id=58">Start your trial</option>
				<option value="{$ca_url}installation/">Installation</option>
				<option value="{$ca_url}resources/">Documentation</option>
				<option value="{$ca_url}pricing/">Price</option>
				<option value="{$ca_url}tickets/new&deptId=1">Support</option>
			  </select>
			</nav>
			<div class="visible-desktop visible-tablet">
				<div class="acenter tab2factor">
					<ul class="">
						<li class="icon-2fac-make active" id="tab1"><a href="{$system_url}?cmd=cart&action=add&id=58" {if $cmd=='demo'}class="active"{/if} target="_blank"><span>Start your trial</span></a></li>
						<li class="icon-2fac-install" id="tab2"><a href="{$ca_url}installation/" {if $cmd=='installation'}class="active"{/if}><span>Installation</span></a></li>
						<li class="icon-2fac-doc" id="tab3"><a href="{$ca_url}resources/" {if $cmd=='resources'}class="active"{/if}><span>Documentation</span></a></li>	
						<li class="icon-2fac-price" id="tab4"><a href="{$ca_url}pricing/" {if $cmd=='pricing'}class="active"{/if}><span>Price</span></a></li>
						<li class="icon-2fac-support" id="tab5"><a href="{$ca_url}tickets/new&deptId=1" target="_blank"><span>Support</span></a></li>
					</ul>
				</div>
			</div>
			
		</div>
	</div>
</div>
