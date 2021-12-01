{php}
$templatePath   = $this->get_template_vars('template_path');
include($templatePath . '/login.tpl.php');
{/php}
{if $action=='passreminder'}


<div class="text-block clear clearfix login-tbl">
   <h5 class="login-title"><span>{$lang.didyouforget}</span></h5>  
<div class="overflow-fix">
	<div class="table-box">
    	<div class="table-header">
            <div class="right-btns">
                <a href="{$ca_url}clientarea/" rel="nofollow" class="clearstyle green-custom-btn btn"><i class="icon-white-add"></i> {$lang.login}</a>
            </div>
        	<p class="small-txt">{$lang.forgetintro}</p>
        </div>
        <form id="reminderForm" name="" action="" method="post">
        	<table class="table table-striped tb-details">
              <tr>
                  <td class="w25 grey-c">{$lang.forgetenter}</td>
                  <td><input type="text" name="email_remind"  value="{$sub_email}"></td>
              </tr>
              <tr id="invalidEmailContact" style="display: none; background-color: #FFFFCB;">
                  <td class="w25 grey-c">&nbsp;</td>
                  <td>ไม่พบ account ที่ใช้ email contact ตามที่ระบุ กรุณาติดต่อเจ้าหน้าที่</td>
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

<script language="javascript">
{literal}
$(document).ready( function () {
    $('#reminderForm').submit(function () {
        
        var email       = $('input[name="email_remind"]').val();
        
        $.post('?cmd=clienthandle&action=isClientAccessEmail', {email:email}, function (data) {
            if (data.indexOf("<!-- {") == 0) {
                var codes       = eval("(" + data.substr(data.indexOf("<!-- ") + 4, data.indexOf("-->") - 4) + ")");
                var oData       = codes.DATA;
                
                if ($.type(oData.clientId) == 'number') {
                    if (oData.clientId) {
                        $('#invalidEmailContact').hide();
                    } else {
                        $('#invalidEmailContact').show();
                        return false;
                    }
                }
                
            }
            
            $('#invalidEmailContact').hide();
            $('#reminderForm')[0].submit();
            
        });

        return false;
    });
    
});
{/literal}
</script>

{else}

<style type="text/css">
{literal}
a.social-button {
    display: block;
    padding-left: 20px;
    padding-right: 20px;
    font-weight: bold;
    float: left;
    margin-left: 10px;
    width: 85% !important;
    text-align: center;
}
input.login-textbox{
    height: 30px;
    width: 95%;
}
.btn-login{
    background-color: #00a8e6;
    color: #fff;
    width: 97%;
    border-radius: 2px;
    border: 1px;
    height: 45px;
}
.btn-login:hover{
    background-color: #c6dcff;
    color: #000;
}
.panel-info > .panel-heading {
color: #31708f;
background-color: #f5f5f5;
border-color: #dddddd;
}
.panel-info > .panel-body {
color: #31708f;
background-color: #f5f5f5;
border-color: #bce8f1;
}
.panel-info {
 border: #dddddd solid 1px;
}
{/literal}
</style>



<div class="container" style="max-width: 600px; min-width: 300px;">    
        <div id="loginbox" style="margin-top:50px;" class="mainbox col-md-6 col-md-offset-3 col-sm-8 col-sm-offset-2">                    
            <div class="panel panel-info">
                    <div class="panel-heading" style="text-align: center;"> 
                        <div class="panel-title"><h4>Login</h4></div>
                    </div>   
                    <div style="padding-top:30px" class="panel-body">
                    
                    <div class="row-fluid" style="text-align: center;">
                        <div class="span12" style="text-align: center;">
                              <a class="btn social-button" href="social-login.php?social=google" rel="nofollow"  style="background-color: #E14E3D;">
                                <span class="fa fa-google"></span> Login with Google
                              </a>
                        </div>
                    </div>
                    <div class="clearfix"><br></div>
                  
                    <div class="row-fluid">
                        <div class="span12">
                              <a class="btn social-button" href="social-login.php?social=microsoft" rel="nofollow"  style="background-color: #00A1F2; width:">
                                <span class="fa fa-windows"></span> Login with Microsoft
                              </a>
                        </div>
                    </div>
                    <div class="clearfix"><br></div>
                    <div class="row-fluid">
                        <div class="span12">
                              <a class="btn social-button" href="social-login.php?social=facebook" rel="nofollow" style="background-color: #395994;">
                                <span class="fa fa-facebook"></span> Login with Facebook
                              </a>
                        </div>
                    </div>
                    <div class="clearfix"><br></div>
                    <div class="row-fluid">
                        <div class="span12">
                            <form name="" action="" method="post" style="padding-left: 10px;">
                                  <div class="form-group">
                                    <label for="exampleInputEmail1"><b>Email address</b></label>
                                    <input class="login-textbox" type="text" name="username" value="{$submit.username}" />
                                  </div>
                                  <div class="form-group">
                                    <label for="exampleInputPassword1"><b>Password</b></label>
                                    <input class="login-textbox" name="password" type="password" />                                  
                                  </div>
                                  <div class="form-group">
                                      <a href="{$smarty.const.BILLING_URL}/root&action=passreminder" class="forget">Forgot Your Password?</a>
                                  </div>
                                  <br>
                                  <div class="form-group">
                                      <button type="submit" rel="nofollow" class="btn-login"><b>Login</b></button>&nbsp;&nbsp;
                                  </div>
                                  <br>
                                  <div class="form-group" style="text-align: center;">
                                      <a href="{$ca_url}signup/" rel="nofollow"><b>Register</b></a>
                                  </div>
                                  <input type="hidden" name="action" value="login"/>                        		
                        		{securitytoken}
                            </form>
                        </div>
                    </div>
                    <div class="clearfix"></div>
                    <div class="row-fluid">
                        <div class="span12">
                            <small style="padding-left: 20px;">* By signing up, you agree to our Terms of Use, <a href="{$smarty.const.CMS_URL}/policy"><b>Privacy Policy</b></a> and to receive Netway emails, newsletters & updates.</small>
                            <br><br>
                        </div>
                    </div>
                </div>                     
            </div>  
        </div>
    </div>

{/if}

</div>
