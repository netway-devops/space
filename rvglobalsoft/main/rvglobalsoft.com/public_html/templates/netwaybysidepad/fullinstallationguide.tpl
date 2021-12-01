  
<div class="container">	
<div class="col-md-12">	
	<div>{include file="addthis.tpl"}</div>		
	<div class="rv_inpage rvlogin">	
		<div class="content">
			<h1>Instruction</h1>
			<p>Thank you for choosing RVLogin. In this guide we will guide you through individual steps taken for installing RVLogin after you get it from RVGlobalSoft.com.<br />  
			If you do not yet get the free license of RVLogin, please go to <a href="https://rvglobalsoft.com/rvlogin/">RVGlobalSoft.com/Rvlogin</a> first. 
			If you have problem with the installation, please ask our NEW support system from <a href="https://rvglobalsoft.com/tickets/new&deptId=1/tickets/new&deptId=1" target="_blank">HERE.</a> </p>
		</div>
		<div class="clear"></div>	
		<div class="content">
			<h2>STEP 1</h2>
			<div class="subtitle padb">1. After ordering RVLogin free license from RVGlobalSoft.com, install RVLogin via SSH (as root) by running the following command.</div>
			<div class="block">
				cd /usr/src; rm -fv rvlogininstall.sh; wget
	http://download.rvglobalsoft.com/rvloginin
	stall.sh; chmod +x rvlogininstall.sh; 
	./rvlogininstall.sh
			</div>
		</div>
		
		<div class="content">
			<h2>STEP 2</h2>
			<div class="subtitle">2. You will see a successful page like this:</div>
			<p class="padb">
				<div class="block">
				# Configure and setup database for RVLogin.<br />
########################################################################<br />
Configuring CPAN path... [ Completed ]<br />
RVLogin has been installed into WHM. [Skip]<br />
> Complete < .<br />
============Download License File============= <br />
rvlogin.lic<br />
mv: `rvlogin.lic' and `/usr/local/rvglobalsoft/rvlogin/rvlogin.lic' are the same file<br />
Install RVLogin has completed.<br />
Run on: xxxxxxxx

				</div>
			</p>
		</div>
		
		<div class="content">
			<h2>STEP 3</h2>
			<div class="subtitle">3. Go to your <span class="txtgold">WHM</span> &gt; <span class="txtgold">Plugins</span> &gt; <span class="txtgold">RVGlobalSoft Manager.</span> And 
configure RVLogin by clicking on RVLogin Manager icon.</div>
			<p class="acenter">
				<img src="{$template_dir}images/rvlogin-manager.jpg" alt="rvlogin" width="617" height="290" />
			</p>
			<p>You can create a URL for RVLogin Access as a Single sign-on server, 
such as yourdomainname.com. This will help you easy access to your 
Single sign-on server in one domain name browsing on URL tab as a 
website, instead of going to <span class="txtgold">WHM</span> &gt; <span class="txtgold">Plugins</span> &gt; <span class="txtgold">RVGlobalsoft Manager</span> &gt; <span class="txtgold">RVLogin Manager</span></p>
		</div>
		
		<div class="content">
			<h2>STEP 4</h2>
			<div class="subtitle">4. Create a URL for the single sign-on by going to <span class="txtgold">WHM</span> &gt; <span class="txtgold">Plugins</span> &gt; <span class="txtgold">RVGlobalsoft Manager</span> &gt; 
<span class="txtgold">RVLogin Manager.</span> Then, click on “WHM Single sign on” tab.</div>
			<p class="acenter">
				<img src="{$template_dir}images/rvlogin-whm-single-sign-on.jpg" alt="rvlogin" width="530" height="385" />
			</p>
		</div>
		
		<div class="content">
			<h2>STEP 5</h2>
			<div class="subtitle">5. Click “Create RVLogin Gateway Page” button to get past 
the intro page, and continue.</div>
			<p class="acenter">
				<img src="{$template_dir}images/rvlogin-gateway.jpg" alt="rvlogin" width="559" height="244" />
			</p>
		</div>
		<div class="content">
			<h2>STEP 6</h2>
			<div class="subtitle">6. On page “Your RVLogin Gateway URL”, insert your domain 
in RVLogin gateway URL field. And do the settings in the 
guide under the field.</div>
			<p class="acenter">
				<img src="{$template_dir}images/rvlogin-gateway-url.jpg" alt="rvlogin" width="716" height="296" />
			</p>
		</div>
		<div class="content">
			<div>Once you saved your gateway URL, it will lead you to this 
page for information.</div>
			<p class="acenter">
				<img src="{$template_dir}images/rvlogin-login-url.jpg" alt="rvlogin" width="710" height="241" />
			</p>
			<div>You can try to open your domain in browser.</div>
			<p class="acenter"><img src="{$template_dir}images/rvlogin-browser.jpg" alt="rvlogin" width="511" height="333" /></p>
			<p>Don’t forget to optimize your RVLogin with RV2Factor, because 
RVLogin for SSH will not be working if you do not have an active 
RV2Factor account.</p>
			
		</div>
		<div class="content acenter">
			<div class="subtitle padb">Get RV2Factor NOW: <a href="https://rvglobalsoft.com/installation/" class="link-rvlogin">www.rvglobalsoft.com/rv2factor.</a> </div>
			<h1 class="padb">Ask for Help?</h1>
			<div>Access our new Support Page <a href="https://rvglobalsoft.com/tickets/new&deptId=1/tickets/new&deptId=1" target="_blank">here.</a></div>
		</div>
		<div class="clear"></div>
		
	</div>
	<div class="clear"></div>
	<br /><br />
</div>
</div>

{include file='notificationinfo.tpl'}
