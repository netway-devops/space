<link rel="stylesheet" href="https://billing.netway.co.th/templates/netwaybysidepad/css/font-awesome/css/style.css">

{if $action=='passreminder'}

<br />
<div class="text-block clear clearfix">
    <h5>{$lang.didyouforget}</h5>
<div class="overflow-fix">
	<div class="table-box">
    	<div class="table-header">
            <div class="right-btns">
                <a href="{$ca_url}clientarea/" class="clearstyle green-custom-btn btn"><i class="icon-white-add"></i> {$lang.login}</a>
            </div>
        	<p class="small-txt">{$lang.forgetintro}</p>
        </div>
        <form name="" action="" method="post">
        	<table class="table table-striped tb-details">
              <tr>
                  <td class="w25 grey-c">{$lang.forgetenter}</td>
                  <td><input type="text" name="email_remind"  value="{$sub_email}"></td>
              </tr>
              <tr>
              	<td></td>
                <td><button type="submit" class="green-custom-btn btn pull-right l-btn">{$lang.sendmepass}</button></td>
              </tr>
            </table>
            {securitytoken}
        </form>
    </div>
</div>
<br /><br />

{else}

<div class="text-block clear clearfix">
    <!-- <h5>{$lang.restricted}</h5>  -->
<div>
<div id="loginFormContent" class="overflow-fix">
	<div class="table-box" style="margin-top:40px; margin-bottom:40px;">
    	<div class="table-header">
        	<!-- <p class="small-txt">{$lang.restrictedarea}</p>-->
			<h5 style="margin:15px 20px 15px 30px;">Clients area sign in</h5>
        </div>
{literal}
<style type="text/css">
.rv-textbox {
 	border:#CCCCCC solid 1px;
}
button.rv-btnlogin {
 	padding:0 30px;
}
</style>
{/literal}

        <form name="" id="login-form" action="" method="post">
        <input type="hidden" name="ipbsson" id="ipbsson" value=""/>
		<table>
             <tr>
                 <td class="w25 grey-c">
					<div>
						 <div class="col-md-7 frm-padd-b">
							<div class="col-md-12 clear-mp">
								<div class="frm-block-l">
									<div class="col-md-4">
										<div>{$lang.email}</div>
										<div><input type="text" name="username" id="username" value="{$submit.username}" class="rv-textbox" /></div>
									</div>
									<div class="col-md-4" style="margin-right:0;">
										<div>{$lang.password}</div>
										<div><input name="password" type="password" id="password" class="rv-textbox" /></div>
									</div>
									<div class="col-md-2" style="margin-right:0;">
										<div>&nbsp;</div>
										<div><input type="hidden" name="action" value="login" /><button type="submit" id="signin_button" class="green-custom-btn btn pull-left l-btn frm-btn"><span>Sign in</span></button></div>
										<br clear="all" />
									</div>
								</div>
							</div>
							<br clear="all" />

							<div class="col-md-12"><a href="{$ca_url}root&amp;action=passreminder">{$lang.passreminder}</a></div>
							 
                             <div class="frm-block-l col-md-11">
                               <div class="row omb_row-sm-offset-3 omb_loginOr" style="position: relative;font-size: 1em;color: #959595;margin-top: 0em;margin-bottom: 1em;padding-top: 0.5em;padding-bottom: 0.5em;margin-left: -15px;margin-right: 0px;">
                                    <div class=" col-sm-12">
                                        <hr class="omb_hrOr" style="background-color: #cdcdcd;height: 1px;margin-top: 0px !important;margin-bottom: 0px !important;">
                                           <span class="omb_spanOr" style="
                                                display: block;
                                                position: absolute;
                                                left: 66%;
                                                top: -12px;
                                                margin-left: -14.5em;
                                                background-color: white;
                                                width: 12em;
                                                text-align: center;
                                                font-size: 16px;
                                                font-weight: 500;
                                                font-family: Oswald, Verdana, Arial, Helvetica, sans-serif;">
                                            Sign in with social media
                                            </span>
                                        </div>
                                        </div>
                                        <div class="text-center social-btn " style="height: auto;">
                                            <div class="col-md-12 hidden-phone" style="margin: 20px 0px 59px -14px;">    
                                                <a href="social-login.php?social=facebook" class="btn btn-primary btn-block col-md-3" style="margin-top: 5px; width: 9%;text-align: center;padding: 5px 0px;background: #3b5998;">
                                                    <i class="fa fa-facebook" style="font-size: 26px;"></i>
                                                </a>
                                                <a href="social-login.php?social=twitter" class="btn btn-info btn-block col-md-3" style="width: 9%;text-align: center;padding: 5px 0px;margin-left: 15px;background: #4eb3d7;display: none">
                                                    <i class="fa fa-twitter" style="padding-right: -1px;font-size: 26px;"></i>
                                                    </a>
                                                <a href="social-login.php?social=google" class="btn btn-danger btn-block col-md-3 " style=" width: 9%; padding: 5px 0px; margin-left : 15px;">
                                                    <i class="fa fa-google" style="font-size: 23px;padding-right: 7px; font-weight: 600;"></i>
                                                </a>
                                                 <a href="social-login.php?social=microsoft" class="btn btn-danger btn-block col-md-3 " style=" width: 9%;padding: 5px 0px;margin-left : 15px; background: #00A1F2">
                                                    <i class="fa fa-windows" aria-hidden="true" style="font-size: 25px;"></i>
                                                </a>
                                                <a href="social-login.php?social=linkedin" class="btn btn-danger btn-block col-md-3 " style=" width: 9%;padding: 5px 0px;margin-left : 15px; background: #347ab6;">
                                                    <i class="fa fa-linkedin" aria-hidden="true" style="font-size: 25px;"></i>
                                                </a>
                                                
                                            </div>
                                            <div class="col-md-12 visible-phone" style="margin-left: -140px;">    
                                                <a href="social-login.php?social=facebook" class="btn btn-primary  col-md-3" style="margin-top: 5px; width: 9%;text-align: center;padding: 5px 0px;background: #3b5998;">
                                                    <i class="fa fa-facebook" style="font-size: 26px;"></i>
                                                </a>
                                                <a href="social-login.php?social=twitter" class="btn btn-info  col-md-3" style="width: 9%;text-align: center;padding: 5px 0px;margin-left: 15px;background: #4eb3d7;display: none">
                                                    <i class="fa fa-twitter" style="padding-right: -1px;font-size: 26px;"></i>
                                                </a>
                                                <a href="social-login.php?social=google" class="btn btn-danger  col-md-3 " style=" width: 9%; padding: 5px 0px; margin-left : 15px;">
                                                    <i class="fa fa-google" style="font-size: 23px;padding-right: 7px; font-weight: 600;"></i>
                                                </a>
                                                <a href="social-login.php?social=microsoft" class="btn btn-danger  col-md-3 " style=" width: 9%;padding: 5px 0px;margin-left : 15px; background: #00A1F2">
                                                    <i class="fa fa-windows" aria-hidden="true" style="font-size: 25px;"></i>
                                                </a>
                                                <a href="social-login.php?social=linkedin" class="btn btn-danger  col-md-3 " style=" width: 9%;padding: 5px 0px;margin-left : 15px; background: #347ab6;">
                                                    <i class="fa fa-linkedin" aria-hidden="true" style="font-size: 25px;"></i>
                                                </a>
                                            </div>
                                         </div>
                                    </div>
                                       
							<br clear="all" />
							<div class="col-md-5">First time here? We recommend you to create your new account by clicking below button. </div>
							<br clear="all" />
							<br clear="all" />
							<div class="col-md-12"><a href="{$ca_url}signup/" class="green-custom-btn btn pull-left l-btn frm-btn"><span>Create new account</span></a></div>
							<br clear="all" />
						</div> 
						<div class="col-md-4 frm-block-r">
							<div class="col-md-3 clear-mp acenter"><img src="{$template_dir}images/icon-note.jpg" alt="" width="61" height="42" /></div>
							<div class="col-md-9 clear-mp">
								<p>This area is exclusively reserved for our partner(s) and reseller(s) who have registered your name and purposely sign off the contract for your own benefits.
								</p>
								<p>When you sign-in, an easy navigation will guide you how to manage your business and some other applications both under RVGlobalSoft’s license and partnership products and services at ease.</p>
								<br clear="all" />
							</div>
						</div>
					</div>
				</td>
			</tr>
		</table>
		<!--
		<table class="table table-striped tb-details">
              <tr>
                  <td class="w25 grey-c">{$lang.email}</td>
                  <td><input type="text" name="username" value="{$submit.username}"></td>
              </tr>
              <tr>
                  <td class="w25 grey-c">{$lang.password}</td>
                  <td><input name="password" type="password"></td>
              </tr>
              <tr>
              	<td>
                	<input type="hidden" name="action" value="login"/>
                    <div>
                        <a href="{$ca_url}root&amp;action=passreminder">{$lang.passreminder}</a><br />
                        <a href="{$ca_url}signup/">{$lang.createaccount}</a>
                    </div>
                </td>
                <td><button type="submit" class="green-custom-btn btn pull-right l-btn">{$lang.login}</button></td>
              </tr>
           </table>
		 	-->
            {securitytoken}
        </form>
    </div>
</div>
</div>
{literal}
<script type="text/javascript">
	
    $(document).ready(function(){
    	var url = "{/literal}{$ca_url}{literal}clientarea/";
       	$('#login-form').submit( function (e) {
           	$.post( url,
           		{
       			    username: $('#username').val(),
           			password: $('#password').val(),
           			action : 'login'
           		}
           		,function (data) {
        			var aResponse = data;
        			aResponse = aResponse.replace('<!-- ', '');
        			var test = aResponse.search(' -->');
        			aResponse = aResponse.substr(0, test);
        			if(JSON.parse(aResponse)){
        				aResponse = JSON.parse(aResponse);
        				if(aResponse.ERROR.length > 0){
        				} else {
            					location.reload();
        				}
        			}
           		}
           	);
        });
    });
   
</script>
 {/literal}
{/if}

</div>
