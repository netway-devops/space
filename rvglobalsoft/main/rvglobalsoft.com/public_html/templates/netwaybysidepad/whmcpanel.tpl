
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
					<a href="{$ca_url}installation"class="active">RV2Factor on WHM/cPanel</a>
				</div>
				<div class="span4">
					<a href="{$ca_url}wordpress">RV2Factor on WORDPRESS</a>
				</div>
				<div class="span4">
					<a href="{$ca_url}hostbill">RV2Factor on HOSTBILL</a>
				</div>
				<div class="clearit"></div>
			</div>
		</div>
		
	<div>
		<div class="row-fluid tohow">
			<div class="span12"><a name="whm"></a>
				<h1 class="re-title">How to Install RV2Factor on WHM</h1>
				<p>To enable RV2Factor on cPanel, you just install RV2Factor on WHM first. If you want to assign quotas of RV2Factor on the tab menu “cPanel & App Management” on our WHM. Consult the tutorials on <a href="{$ca_url}resources/"><b>“Resources”</b> section.</a></p>
				<p>1. Download the Installation Package and by running this command on your server:</p>
				<p style="border:#CCCCCC solid 1px; padding:15px; background:#EBEBEB;">cd /usr/src; rm -f rv2factorinstall.sh; wget http://download.rvglobalsoft.com/rv2factorinstall.sh; chmod +x rv2factorinstall.sh; ./rv2factorinstall.sh</p>
				<p>2. Go to <b>WHM &gt; Plugins &gt; RVGlobalSoft Manager &gt; RV2Factor Manager</b></p>
				<p>3. Click <b>"Accept"</b> the Plugin License Agreement, and then <b>"Submit"</b>.</p>
				<p><img src="{$template_dir}images/rvmanager.png" alt="rv2factor installation" width="1280" height="780" /></p>
				<p>4. Go to  <b>WHM &gt; RVGlobalSoft Manager &gt; Settings &gt; API Key Setup and configure the API Key Setup. </b>Use your registered email and the Secret Key for Control Panel, which can be obtained from <a href="https://rvglobalsoft.com/">RVGlobalSoft.com</a> </p>
				<p><img src="{$template_dir}images/api.png" alt="rv2factor api" width="1280" height="780" /></p>
				<p>5. To obtain the registered email and Secret Key for Control Panel, <b>login to RVGlobalSoft.com &gt; Secret Key Generator &gt; Secret Key for Control Panel.</b> </p>
				<p><b>IMPORTANT :  <span class="txtred">Do not click</span> "Generate Secret Key and Access Key” if you do not want to. It is used when you re-configure with your system. For the first-time installation, leave this button untouched.</b> 
</p>
				<p><img src="{$template_dir}images/control.png" alt="rv2factor control" width="1280" height="780" /></p>
				<p>6. Go back to <b>WHM &gt; RVGlobalSoft Manager &gt; Settings &gt; API Key Setup.</b> And insert the registered email and Secret Key for Control Panel to these fields below.</p>
				<p><img src="{$template_dir}images/whm.png" alt="rv2factor whm" width="1280" height="780" /></p>
				<p>7. Wait for verification process.</p>
				<p><img src="{$template_dir}images/process.png" alt="rv2factor process" width="678" height="190" /></p>
				<p>8. Go to <b>WHM &gt; RVGlobalSoft Manager &gt; RV2Factor Manager &gt; WHM Management</b></p>
				<p><img src="{$template_dir}images/first-whm-management.png" alt="rv2factor Management" width="1278" height="872" /></p>
				<p><img src="{$template_dir}images/management.png" alt="rv2factor Management" width="1280" height="780" /></p>
				<p>9. To implement RV2Factor for your WHM users, make sure that your RV2Factor for WHM is “enabled.”</p>
				<p><img src="{$template_dir}images/disable.png" alt="rv2factor disable" width="638" height="392" /></p>
				<p>10. Then, click “Add RV2Factor Account” button on the top right. </p>
				<p><img src="{$template_dir}images/account.png" alt="rv2factor account" width="638" height="392" /></p>
				<p>11. If you already ordered the RV2Factor Account, the system will allow you to add the first credential into your WHM. </p>
				<p>12. If you do not have sufficient RV2Factor account, you should order RV2Factor Account from RVGlobalSoft.com First. Click “Order Now” to order RV2Factor.</p>
				<p><img src="{$template_dir}images/ordernow.png" alt="rv2factor account" width="602" height="221" /></p>
				<p>13. After you click “Add RV2Factor Account”, you will be prompted by a pop up window. Insert your Credential ID and put the device name in the field “Note” to remind you of the credential ID. Click OK. Learn more about Credential ID from “About VIP ACCESS” on the website. </p>
				<p><img src="{$template_dir}images/credentialid.png" alt="rv2factor credentialid" width="602" height="221" /></p>
				<p>14. Then, you will be asked to insert the security code generated by your VIP Access from your mobile phone.</p>
				<p><img src="{$template_dir}images/security.png" alt="rv2factor security" width="602" height="221" /></p>
				<p>15. After validation is done successfully, you will be confirmed by this popup window.</p>
				<p><img src="{$template_dir}images/ok.png" alt="rv2factor security" width="602" height="221" /></p>
			</div>
		</div>
	</div>
	<div class="acenter">{include file='button.freetrail.tpl'}</div>
	</div>	
</div>
<div class="clear"></div>

<br /><br />


{include file='notificationinfo.tpl'}
