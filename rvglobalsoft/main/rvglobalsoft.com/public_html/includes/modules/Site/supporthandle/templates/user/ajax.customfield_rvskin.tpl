<div class="dotted-line-m"></div>
<label>Require Information</label><br />
<span> * You are able to delete the custom field by yourself. </span>

<div style="padding:14px;">
    
    <div class="row">
        <div class="span12">
            <ul>
                <li>SSH access is not required but frequently the problem can only be resolved on SSH. If you do not submit here, we may request it in order to help on the issue.</li>
                <li>Our office IP addresses are 203.78.98.212. Make sure our IP can SSH to your server.</li>
            </ul>
        </div>
    </div>
    
    <div class="row">
        <div class="span6"><strong>SSH Authentication Method:</strong></div>
        <div class="span6">
        </div>
    </div>
    <div class="row">
        <div class="span4">
            <label class="btn btn-block btn-small btn-info"><input type="radio" name="cf[authMethod]" id="cf_auth_method" value="Root Password" checked="checked" />Provide password for root.</label>
        </div>
        <div class="span6">
            <label class="btn btn-block btn-small btn-info"><input type="radio" name="cf[authMethod]" id="cf_auth_method" value="SSH Key" />Install RVGlobalSoft provided SSH Key for root.</label> 
                            
        </div>
        <div class="span2">
            <label class="btn btn-block btn-small btn-info"><input type="radio" name="cf[authMethod]" id="cf_auth_method" value="None" />None</label>
        </div>
    </div>
    
    <div class="row">
        &nbsp;
    </div>
    
    <div class="row">
        <div class="span4">Server IP or hostname:<em class="text-danger">*</em></div>
        <div class="span8">
            <input type="text" name="cf[hostname]" id="cf_hostname" value="" size="20" required="required" style="height: 2.4em;" />
        </div>
    </div>
    
    <div class="row">
        <div class="span4">Root password:<em class='text-danger'>*</em></div>
        <div class="span8">
            <input type="password" name="cf[rootpassword]" id="cf_rootpassword" value="" size="20" required="required" autocomplete="off" style="height: 2.4em;" />
        </div>
    </div>
    
    <div class="row">
        <div class="span4">Wheel user for su/sudo:</div>
        <div class="span8">
            <input type="text" name="cf[user]" id="cf_user" value="" size="20" style="height: 2.4em;" />
        </div>
    </div>
    
    <div class="row">
        <div class="span4">Wheel password:</div>
        <div class="span8">
            <input type="password" name="cf[password]" id="cf_password" value="" size="20" autocomplete="off" style="height: 2.4em;" />
        </div>
    </div>
    
    <div class="row">
        <div class="span4">SSH port:<em class='text-danger'>*</em></div>
        <div class="span8">
            <input type="text" name="cf[sshport]" id="cf_sshport" value="" size="10" class="span4" style="height: 2.4em;" />
        </div>
    </div>
    
    
    
    
</div>

<div class="dotted-line-m"></div>


<script language="JavaScript">
{literal}

$(document).ready( function () {

    $('input[name="cf\[authMethod\]"]').click( function () {
        displayAuthMethod();
    });
    
});

function displayAuthMethod ()
{
    var authMethodVal   = $('input[name="cf\[authMethod\]"]:checked').val();
    
    if (authMethodVal == 'Root Password') {
        $('#cf_hostname').attr('required', 'required').parent().parent().show();
        $('#cf_rootpassword').attr('required', 'required').parent().parent().show();
        $('#cf_user').parent().parent().show();
        $('#cf_password').parent().parent().show();
        $('#cf_sshport').attr('required', 'required').parent().parent().show();
        
    } else if (authMethodVal == 'SSH Key') {
        $('#cf_hostname').attr('required', 'required').parent().parent().show();
        $('#cf_rootpassword').removeAttr('required').parent().parent().hide();
        $('#cf_user').parent().parent().hide();
        $('#cf_password').parent().parent().hide();
        $('#cf_sshport').attr('required', 'required').parent().parent().show();
    } else {
        $('#cf_hostname').removeAttr('required').parent().parent().hide();
        $('#cf_rootpassword').removeAttr('required').parent().parent().hide();
        $('#cf_user').parent().parent().hide();
        $('#cf_password').parent().parent().hide();
        $('#cf_sshport').removeAttr('required').parent().parent().hide();
        
    }
}

{/literal}
</script>