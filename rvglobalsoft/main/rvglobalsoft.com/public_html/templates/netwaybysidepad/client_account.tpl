<div class="container client-area">	
	<div class="row-fluid">
		<div class="padd">
			<h2 class="txt-upper">Manage Your Profile</h2>
			<div class="clearit"></div>
		</div>
		
		<div class="account">
			<div class="span4 padd">
				<div class="manage-block acenter"><h2 class="icon-account">{$lang.mainaccount}</h2></div>
				<p>Manage your personal information, login password, and more details here.</p>
				<div>
					 <ul class="arrow-mid">
                    	<li><a href="{$ca_url}clientarea/details/" >{$lang.details} <span></span></a></li>
                   	 	<li><a href="{$ca_url}clientarea/password/" >{$lang.changepass} <span></span></a></li>
                    	<li><a href="{$ca_url}profiles/" >{$lang.managecontacts} <span></span></a></li>
                    	{if $enableFeatures.security=='on'}<li><a href="{$ca_url}clientarea/ipaccess/" >{$lang.security} <span></span></a></li>{/if}
                    	{if $enableFeatures.deposit!='off' }<li><a href="{$ca_url}clientarea/addfunds/">{$lang.addfunds} <span></span></a></li>{/if}
                	</ul>
				</div>
			</div>
			<div class="span4 padd">
				<div class="manage-block acenter"><h2 class="icon-billing">{$lang.billing}</h2></div>
				<p>Manage and update your billing information here. See the pending invoices and pay the bill to continue your license.</p>
				<div>
					<ul class="arrow-mid">
                   	 	<li><a href="{$ca_url}clientarea/invoices/">{$lang.invoices} <span></span></a></li>
                   	 	<li><a href="{$ca_url}clientarea/ccard/">{$lang.ccard} <span></span></a></li>
                	</ul>
				</div>
			</div>
			<div class="span4 padd">
				<div class="manage-block acenter"><h2 class="icon-history">{$lang.userhistory}</h2></div>
				<p>View the history of your profile here. <br />&nbsp;</p>
				<div>
					<ul class="arrow-mid">
						<li><a href="{$ca_url}clientarea/emails/">{$lang.emails} <span></span></a></li>
                    	<li><a href="{$ca_url}clientarea/history/">{$lang.logs} <span></span></a></li>
					</ul>
				</div>
			</div>
		</div>
	</div>
</div>

<div class="clear"></div>

<br /><br />


{include file='notificationinfo.tpl'}
