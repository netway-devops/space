{php}
$templatePath   = $this->get_template_vars('template_path');
include($templatePath . 'ajax.login.tpl.php');
{/php}

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
    width: 97%;
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
                    <div id="loginFromMessage" align="center"></div>
                    <div class="panel-title"><h4>Login</h4></div>
                </div>   
                <div style="padding-top:30px" class="panel-body">
                
                <div class="row-fluid" style="text-align: center;">
                    <div class="span12" style="text-align: center;">
                          <a class="btn social-button" href="social-login.php?social=google&redirectUrl=https://netway.co.th/cart/&step=2" style="background-color: #E14E3D;">
                            <span class="fa fa-google"></span> Login with Google
                          </a>
                    </div>
                </div>
                <div class="clearfix"><br></div>
                <div class="row-fluid">
                    <div class="span12">
                          <a class="btn social-button" href="social-login.php?social=facebook&redirectUrl=https://netway.co.th/cart/&step=2" style="background-color: #395994;">
                            <span class="fa fa-facebook"></span> Login with Facebook
                          </a>
                    </div>
                </div>
                <div class="clearfix"><br></div>
                <div class="row-fluid">
                    <div class="span12">
                          <a class="btn social-button" href="social-login.php?social=microsoft&redirectUrl=https://netway.co.th/cart/&step=2" style="background-color: #00A1F2;">
                            <span class="fa fa-windows"></span> Login with Microsoft
                          </a>
                    </div>
                </div>
                <div class="clearfix"><br></div>
                <div class="row-fluid">
                    <div class="span12">
                              <div class="form-group">
                                <label for="exampleInputEmail1"><b>Email address</b></label>
                                <input class="login-textbox" type="text" name="username" value="{$submit.username}" />
                              </div>
                              <div class="form-group">
                                <label for="exampleInputPassword1"><b>Password</b></label>
                                <input class="login-textbox" name="password" type="password" />                                  
                              </div>
                              <div class="form-group">
                                  <a href="{$ca_url}root&amp;action=passreminder" class="forget">Forgot Your Password?</a>
                              </div>
                              <br>
                              <div class="form-group">
                                  <button type="submit" name="loginbtn" class="btn-login"><b>Login</b></button>&nbsp;&nbsp;
                              </div>
                              <br>
                              <div class="form-group" style="text-align: center;">
                                  <a href="{$ca_url}signup/"><b>Register</b></a>
                              </div>
                              <input type="hidden" name="action" value="login"/>                                
                            
                    </div>
                </div>
                <div class="clearfix"></div>
                <div class="row-fluid">
                    <div class="span12">
                        <br>
                        <small style="padding-left: 20px;">* By signing up, you agree to our Terms of Use, <a href="policy"><b>Privacy Policy</b></a> and to receive Netway emails, newsletters & updates.</small>
                        <br><br>
                    </div>
                </div>
            </div>                     
        </div>  
    </div>
</div>


{literal}<script type="text/javascript">
    function checkIsSocialLoginSuccess ()
    {
        $.getJSON('{/literal}{$ca_url}{literal}?cmd=clienthandle&action=islogin', function (data) {
            if (typeof data.data.id !== 'undefined') {
                window.location.reload(false);
            }
            setTimeout( function () {
                checkIsSocialLoginSuccess();
            }, 5000);
        });
    }
    $('.social-button').click( function () {
        checkIsSocialLoginSuccess();
    });
    
    $('#signup').live('click', function(e) {
        e.preventDefault();
        $('#orderform').find('li.t1').click();
    });
    
   {/literal}{if $isAjaxLogin}{literal}
   $('input[name="loginbtn"]').click( function () {
        $('#loginFromMessage').html('<small>logging in ... </small>');
        $.post('{/literal}{$ca_url}{literal}clientarea/', {
            username    : $('input[name="username"]').val(),
            password    : $('input[name="password"]').val(),
            action      : 'login'
        }, function (data) {
            parse_response(data);
            if (data.indexOf("<!-- {") == 0) {
                var codes = eval("(" + data.substr(data.indexOf("<!-- ") + 4, data.indexOf("-->") - 4) + ")");
                if (codes.ERROR.length == 0) {
                    {/literal}{if $isReloadContent}{literal}
                    window.location.reload(false);
                    {/literal}{/if}{literal}
                } else {
                    $('#loginFromMessage').html('<small style="color:red;">'+ codes.ERROR +'</small>');
                }
            }
        });
       return false;
   });
   {/literal}{/if}{literal}
   
</script>{/literal}