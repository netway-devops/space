{php}
	include_once $this->template_dir . '/cart_ssl/product_login.tpl.php';
{/php}
{literal}
<script type="text/javascript">
    

  $(document).ready(function(){
	var ssl_id = $('#sslid').val();
	var url = "{/literal}{$ca_url}{literal}cart/ssl&rvaction=chklogin&ssl_id="+encodeURIComponent(ssl_id);
  	
   	$('#loginbtn').click( function () {
   			
       		$('#loginFromMessage').html('<small>logging in ... </small>');
       		$.post( url, 
       				{ 	username: $('#username').val(), 
       					password: $('#password').val(), 
       					action : 'login' 
       				}
       				,function (data) {
    					parse_response(data);
    					console.log(data);
    					aResponse = data;
    					aResponse = aResponse.replace('<!-- ', '');
    					aResponse = aResponse.replace(' -->', '');
    					aResponse = JSON.parse(aResponse);
    					if(typeof aResponse.ERROR[0] != 'undefined' && aResponse.ERROR[0] != ''){
    					   $('#login-error-message-box').show();
    					   $('#login-error-message').html(aResponse.ERROR[0]);
    					   $('#loginFromMessage').html('');
    					} 
    					$('#errors').hide();
    					location.reload();
	       				
       				}
       				
       			);
           	
       	});
       	
       	$('#password').keypress(function(event) {
        if (event.which == 13) {
            event.preventDefault();
            $('#loginbtn').click();
        }
});
    });
</script>
{/literal}
<br />
<br />
<div id="loginFormContent">
    <div id="login-error-message-box" class="notifications alert alert-error" style="display: none;">
        <button type="button" class="close" data-dismiss="alert">×</button>
        <span id="login-error-message" ></span>
    </div>
<center>
    <form action="{$ca_url}cart/ssl&rvaction=chklogin&ssl_id={$ssl_id}" method="POST">
    <table border="0" cellpadding="0" cellspacing="0" class="loginFormSSL">
        <tr>
            <td align="right" valign="top" style="display:none;">
                <label for="username" class="styled">{$lang.email} </label>
            </td>
            <td align="left" valign="top">
                <input type="text" name="username" id="username" class="styled bg-email" placeholder="{$lang.email}" />
            </td>
         </tr>
         <tr>   
            <td align="right" valign="top" style="display:none;">
                <label for="password" class="styled">{$lang.password} </label>
            </td>
            <td align="left" valign="top">
                <input name="password" type="password" id="password" value=""  placeholder="{$lang.password}" class="styled bg-pass"/>
            </td>
         </tr>
         <tr> 
            <td align="right" valign="top" style="display:none;">
                <label for="loginbtn" class="btnfix styled">&nbsp;</label>
            </td>
            <td align="left" valign="top">
                <input name="loginbtn" class="btn padded green-custom-btn" type="submit" id="loginbtn" value="{$lang.login}" />
            </td>
        </tr>
        <tr>
            <td colspan="2"><div id="loginFromMessage" align="center"></div></td>
        </tr>
        <tr>
        	<td align="left" style="display:none;">&nbsp; </td>
            <td>
                <a href="index.php?/root&action=passreminder" class="list_item ssl-forgot-btn btn" target="_blank">{$lang.passreminder}</a><span class="hidden-phone">&nbsp;</span>
                <a href="index.php?/signup/" id="signup" class="list_item ssl-forgot-btn btn">&nbsp;&nbsp;&nbsp;&nbsp;{$lang.createaccount}&nbsp;&nbsp;&nbsp;&nbsp;</a>
            </td>
        </tr>
    </table>
    
	<input type="hidden" name="sslid" id="sslid" value="{$ssl_id}"/>
    <input type="hidden" name="action" value="login"/>
    <input type="hidden" name="ipbsson" id="ipbsson" value=""/>
    </form>
</center>


</div>
