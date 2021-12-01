<link href='https://fonts.googleapis.com/css?family=Oswald:300' rel='stylesheet' type='text/css'>
<link href='http://fonts.googleapis.com/css?family=Cutive|Cuprum' rel='stylesheet' type='text/css'>
<div class="container-box rvlogin">
	<div class="rvlogin-bg">
		<div class="container">	
			<div class="padd">
				<h1><img src="{$template_dir}images/login-key.png" alt="rvlogin" width="85" height="91" /> UNLOCK</h1>
				<h2>The  Way you Manage and Control Server Admins’ Access. </h2>
				<h3><a href="https://rvglobalsoft.com/?cmd=cart&action=add&id=108" class="btn-rvlogin">Get RVLogin Now</a></h3>
				<h4 class="txtgray">* I also want RV2Factor with this as a default</h4>
			</div>
		</div>
	</div>
	
	<div class="container">
		<div>{include file="addthis.tpl"}</div>		
		<div class="rv_inpage" style="padding-top:40px;">
			<div class="row padtop">
				<div class="col-sm-6 padb">
					<img src="{$template_dir}images/rvlogin-whm.jpg" alt="rvlogin" width="542" height="250" />
				</div>
					
				<div class="col-sm-6">
					<h1 class="padb">RVLogin for WHM and SSH Single Sign-on</h1>
					<p class="padb">Behold. This RVLogin is a great tool for your server empire. Once ordered, you just install with ease on your RVLogin Gateway Server. Can’t wait for the breath-taking moment to experience this? Let’s manage, control, and secure your server pools now.</p>
					<p><a href="{$template_dir}doc/Installation.pdf" class="btn-download" target="_blank">Read full Installation <img src="{$template_dir}images/downloadpdf.gif" alt="download" width="40" height="34" /></a></p>
				</div>
			</div>
			<div class="line"></div>
			<div class="row">
				<div class="col-sm-6 padb">
					<img src="{$template_dir}images/rvlogin-installation.jpg" alt="rvlogin" width="482" height="317" />
				</div>
					
				<div class="col-sm-6">
					<h1 class="padb">1. Ordering and Installation of RVLogin</h1>
					<p class="padb">
						<ul class="arrow">
							<li>Before ordering and installing RVLogin, you MUST assign one cPanel Server as an RVLogin Gateway Server.</li> 
							<li>This Gateway Server will be your frontier for all server admins to use your single sign-on via a web-based portal gateway. </li>
							<li>You are required to supply IP Address of the Gateway Server  before submit your order.</li>
							<li>If you already allocated the resource for this, you should start ordering RVLogin from RVGlobalSoft. <a href="https://rvglobalsoft.com/?cmd=cart&action=add&id=108" class="lrvlogin">Order Now.</a> </li> 
						</ul>
					</p>
				</div>
			</div>
			<div class="line"></div>
			<div class="row">
				<div class="col-sm-6 padb">
					<img src="{$template_dir}images/rvlogin-whm-single-signon.jpg" alt="rvlogin" width="483" height="313" />
				</div>
					
				<div class="col-sm-6">
					<h1 class="padb">2. RVLogin for WHM Single Sign-on </h1>
					<div class="subtitle">Installation Quick Guide:</div>
					<p class="padb">
						<ol>
							<li>Register your account with RVGlobalSoft.com (If you have RVGlobalSoft Account, please go to next step).</li> 
							<li>Order RVLogin (Always Free!) from RVGlobalSoft.</li> 
							<li>Download and install RVLogin on your allocated RVLogin Gateway Server with the command below:
							<p>cd /usr/src; rm-f rvlogininstall.sh; wget http://download.rvglobalsoft.com/rvlogininstall.sh; chmod +x rvlogininstall.sh; ./rvlogininstall.sh</p>
							</li> 
							<li>Configure RVLogin by accessing WHM (as root) &gt; Plugins &gt; RVGlobalSoft Manager &gt; RVLogin Manager. </li> 
						</ol>
					</p>
				</div>
			</div>
			<div class="line"></div>
			<div class="row">
				<div class="col-sm-6 padb desktop-padt">
					<img src="{$template_dir}images/rvlogin-ssh-single-signon.jpg" alt="rvlogin" width="480" height="317" />
				</div>
					
				<div class="col-sm-6">
					<h1 class="padb">3. RVLogin for SSH Single Sing-on </h1>
					<div class="content padb">RVLogin for SSH Single Sign-on is fully-featured with such technologies as SSH Single Sign-on, RV2Factor (2-Factor Authentication) for SSH, and Server Access Control.</div>
					<div class="subtitle">Installation Quick Guide:</div>
					<p class="padb">
						<ol>
							<li>Register your account with RVGlobalSoft.com (If you have RVGlobalSoft Account, please go to next step).</li> 
							<li>Order RVLogin (Always Free!) from RVGlobalSoft.</li> 
							<li>Order RV2Factor from RVGlobalSoft.</li> 
							<li>Activate RV2Factor on RVLogin Gateway Server by following the steps in <a href="https://rvglobalsoft.com/installation/">RV2Factor program installation</a> </li> 
							<li>Download and install RVLogin on your allocated RVLogin Gateway Server with the command below:
							
							<p>cd /usr/src; rm-f rvlogininstall.sh; wget http://download.rvglobalsoft.com/rvlogininstall.sh; chmod +x rvlogininstall.sh; ./rvlogininstall.sh</p>
							</li> 
							
							<li>Configure RVLogin by accessing WHM (as root) > Plugins > RVGlobalSoft Manager > RVLogin Manager.</li> 
						</ol>
					</p>
				</div>
			</div>
			<div class="line"></div>
			<div class="row">
				<div class="col-sm-6 padb">
					<img src="{$template_dir}images/rvlogin-whm-single-signon.jpg" alt="rvlogin" width="483" height="313" />
				</div>
					
				<div class="col-sm-6">
					<h1 class="padb">4. Adding WHM /SSH Servers to RVLogin: </h1>
					<p class="padb">
						<ol>
							<li><span class="txtblue">[Action Required]</span> <span class="txtred">Add</span> WHM/SSH Server by accessing WHM (as root) > Plugins > RVGlobalSoft Manager > RVLogin Manager > Add Servers.</li> 
							<li><span class="txtblue">[Highly Recommended]</span> <span class="txtred">Disable</span> ssh direct root, after installing Single Sign-on for SSH.</li> 
							<li><span class="txtblue">[Optional]</span> <span class="txtred">Activate</span> RV2Factor on RVLogin Gateway Server by following the steps in <a href="https://rvglobalsoft.com/installation/">RV2Factor program installation</a></li> 
						</ol>
					</p>
				</div>
			</div>
			<link href='http://fonts.googleapis.com/css?family=Cutive' rel='stylesheet' type='text/css'>
			<div class="line"></div>
			
			<div class="row">
				<div class="col-md-12 acenter">
				<a href="https://rvglobalsoft.com/knowledgebase/"><img src="{$template_dir}images/need-reinforcements.jpg" alt="rvlogin" width="1129" height="288" /></a>
				</div>
			</div>
			
			<!--
			<div class="col-md-12">
				<div class="rvlogin-banner">
					<div class="col-sm-6 hidden-mobile">&nbsp;</div>
					<div class="col-sm-6" style="padding-top:40px;">
						<h1>Need Reinforcements?</h1>
						<h2>Our Tech Support Will Guide You Through.</h2>
						<div class="get">Get help on <span>RVLogin</span> with<br /> our NEW Support</div>
						<div><a href="#" class="btn">Access New Support</a></div>
					</div>
				</div>
			</div>
			-->
			
		</div>
		<div class="clear"></div>
		<br /><br /><br /><br /><br /><br />
	</div>
</div>
{include file='notificationinfo.tpl'}
