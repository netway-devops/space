
<div class="container">	
	{include file='menus/rv2factornavigation.tpl'}
	
	
	<div class="rv2factor">
		<div class="row-fluid">
			<div class="span1">&nbsp;</div>
			<div class="span4 padtop acenter visible-desktop visible-tablet">
				<img src="{$template_dir}images/rv2factor-install.jpg" alt="" width="302" height="186" />
			</div>
			<div class="span7">
				<h1 class="install">HOW TO IMPLEMENT RV2Factor <span>For Your Network &amp; Applications</span></h1>
			</div>
		</div>
		
		
		<div class="row-fluid padtop">
			
			<h1 class="re-title">INSTALLATION</h1>
			<div class="tab_install">
				<div class="span4">
					<a href="{$ca_url}installation">RV2Factor on WHM/cPanel</a>
				</div>
				<div class="span4">
					<a href="{$ca_url}wordpress" class="active">RV2Factor on WORDPRESS</a>
				</div>
				<div class="span4">
					<a href="{$ca_url}hostbill">RV2Factor on HOSTBILL</a>
				</div>
				<div class="clearit"></div>
			</div>
		</div>
	
	<div>
		<div class="row-fluid tohow">
			<div class="span12">
				<h1 class="re-title">This installation requires:</h1>
				<div>1. <a href="https://rvglobalsoft.com/installation">RV2Factor for WHM</a> installed. (If you’re reseller/cPanel user, please contact your host provider to do this.)</div>
				<div>2. <a href="https://rvglobalsoft.com/knowledgebase/article/32/active-rv2factor-for-cpanel-users/">RV2Factor for cPanel Account</a> active. (If you’re reseller/cPanel user, please contact your host provider to do this.)</div>
				<div>3. <a href="https://rvglobalsoft.com/knowledgebase/article/259/enable-rv2factor-for-apps-under-cpanel-account/">RV2Factor for Apps</a> active.</div><br />
			</div>	
		</div>
		<div class="row-fluid tohow">
			<div class="span12"><a name="wordpress"></a>
				<h1 class="re-title">How to Install RV2Factor on WORDPRESS</h1>
				<h1 class="txtblue">After full install wordpress, install wordpress plugin:</h1>
				<div>1. Download file from <a href="http://download.rvglobalsoft.com/rvtwofactor_wordpress.zip">http://download.rvglobalsoft.com/rvtwofactor_wordpress.zip</a></div>
				<div>2. Install &amp; Activate Plugins</div>
				<h1 class="txtblue">STEPS IN DETAILS</h1>
				<p><img src="{$template_dir}images/details.png" alt="rv2factor details" width="1367" height="483" /></p>
				<p>3. Go to <b>Wordpress Admin &gt; Plugins &gt; Add New &gt; Upload</b></p>
				<p><img src="{$template_dir}images/upload.png" alt="rv2factor upload" width="1368" height="516" /></p>
				<p>4. Browse and locate your file in your computer.</p>
				<p><img src="{$template_dir}images/browse.png" alt="rv2factor browse" width="1312" height="590" /></p>
				<p>5. Click <b>"Install Now"</b>.</p>
				<p><img src="{$template_dir}images/install-now.png" alt="rv2factor" width="1362" height="460" /></p>
				<p>6. Click <b>"Activate Plugin"</b>. </p>
				<p><img src="{$template_dir}images/activate.png" alt="rv2factor" width="1364" height="448" /></p>
				<p>7. Click <b>"RV2Factor"</b> on the left navigation menu.</p>
				<p><img src="{$template_dir}images/navigation.png" alt="rv2factor" width="330" height="300" /></p>
				<p>8. Go to <b>Wordpress Admin &gt; RV2Factor &gt; Setting.</b> Click <b>"I Agree."</b></p>
				<p><img src="{$template_dir}images/wordpress-admin.png" alt="rv2factor" width="1350" height="606" /></p>
				<p>9. Click <b>"Save."</b> </p>
				<p><img src="{$template_dir}images/save.png" alt="rv2factor" width="1349" height="441" /></p>
				<p><b>NOTE :</b> If WordPress cannot find the Public Key , you should go directly to:<br />
<b>cPanel(user)  &gt; Software  &gt; RV2Factor  &gt; cPanel Apps management  &gt; Access key</b></p>
			</div>
		</div>
	</div>
	
	<div class="acenter">{include file='button.freetrail.tpl'}</div>
	</div>	
</div>
<div class="clear"></div>

<br /><br />


{include file='notificationinfo.tpl'}
