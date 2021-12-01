{php}
$templatePath   = $this->get_template_vars('template_path');
include($templatePath . 'ajax.login.tpl.php');
{/php}

<div id="loginFormContent">
<center>
    <table border="0" cellpadding="0" cellspacing="6">
        <tr>
            <td align="left">
                <label for="username" class="styled">{$lang.email}</label>
                <input type="text" name="username" value="{$submit.username}" class="styled"/>
            </td>
            <td align="left">
                <label for="password" class="styled">{$lang.password}</label>
                <input name="password" type="password"  class="styled"/>
            </td>
            <td align="left">
                <label for="loginbtn" class="btnfix styled">&nbsp;</label>
                <input name="loginbtn" class="btn padded" type="submit" style="font-weight:bold;" value="{$lang.login}">
            </td>
        </tr>
        <tr>
            <td colspan="3"><div id="loginFromMessage" align="center"></div></td>
        </tr>
        <tr>
            <td colspan="3">
                <a href="index.php?/root&action=passreminder" class="list_item" style="display: block;" target="_blank">{$lang.passreminder}</a>
                <a href="index.php?/signup/" id="signup" class="list_item" style="display: block;">{$lang.createaccount}</a>
            </td>
        </tr>
    </table>

    <input type="hidden" name="action" value="login"/>
    <input type="hidden" name="ipbsson" id="ipbsson" value=""/>
</center>
</div>
{literal}<script type="text/javascript">
    $('#signup').live('click', function(e) {
        e.preventDefault();
        $('#orderform').find('li.t1').click();
    });
    //$('#loginFormContent').addLoader();
    /*
    $.ajax({
         url        : '//forum.rvglobalsoft.com/sson.php?action=getSession',
         dataType   : 'jsonp', // Notice! JSONP <-- P (lowercase)
         success:function(json){
             $('#ipbsson').val(json.sessionId);
             $('#preloader','#loginFormContent').hide();
         }
    });
    */
   
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
                    var pid = {/literal}{$shoppingcart.0.product.id}{literal};
                    if(pid == 58){
                            var url = '{/literal}{$system_url}{literal}';
                            var clearurl = url + "index.php/cart&cart=clear&order=0";
                            $.post(url,function(data){
                                var urlstep3 = url+'index.php?cmd=order2factorhb&action=gotoStep3';
                                var urlStep4 = url+'index.php?cmd=order2factorhb&action=checkLogIn';
                                $.post(urlstep3,function(data){
                                    
                                    window.location.assign(urlStep4);
                                    
                                });   
                            });
                            
                    }else{
                        {/literal}{if $isReloadContent}{literal}
                        window.location.reload(false);
                        {/literal}{/if}{literal}
                    }
                } else {
                    $('#loginFromMessage').html('<small style="color:red;">'+ codes.ERROR +'</small>');
                }
            }
           
        });
       return false;
   });
   {/literal}{/if}{literal}
   
</script>{/literal}