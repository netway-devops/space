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
        <div class="span4">Control panel type:<em class="text-danger">*</em></div>
        <div class="span8">
            <select name="cf[controlpanel_type]" id="cf_controlpanel_type">
                <option value="">-Please select-</option>
                <option value="cPanel">cPanel</option>
                <option value="DirectAdmin">DirectAdmin</option>
            </select>
        </div>
    </div>
    
    <div class="row">
        <div class="span4">Server IP or hostname:<em class='text-danger'>*</em></div>
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
            <input type="text" name="cf[sshport]" id="cf_sshport" value="" size="10" required="required" class="span4" style="height: 2.4em;" />
        </div>
    </div>
    
    <div class="row">
        &nbsp;
    </div>
    
    <div class="row">
        <div class="span4">Problem on:</div>
        <div class="span4" style="text-align: center;">
            <label class="btn btn-block btn-small btn-info"><input type="radio" name="cf[problem]" id="cf_problem" value="RVSiteBuilder" checked="checked" />RVSiteBuilder</label>
        </div>
        <div class="span4" style="text-align: center;">
            <label class="btn btn-block btn-small btn-info"><input type="radio" name="cf[problem]" id="cf_problem" value="RVSiteBuilderTryout" /> RVSiteBuilder Tryout</label>
        </div>
    </div>
    
    <div class="row">
        &nbsp;
    </div>
    
    <div class="row">
        <div class="span4">RVSiteBuilder Version:<em class='text-danger'>*</em></div>
        <div class="span8">
            <input type="text" name="cf[rvsversion]" id="cf_rvsversion" value="" size="6" required="required" class="span4" style="height: 2.4em;" />
        </div>
    </div>
    
    <div class="row">
        <div class="span4">Web Browser Name:<em class='requiredField'>*</em></div>
        <div class="span8">
            <input type="text" name="cf[browser_name]" id="cf_browser_name" value="" size="20" required="required" class="span4" style="height: 2.4em;" /> ex. IE,Firefox,Chrome,Safari
        </div>
    </div>
    
    <div class="row">
        <div class="span4">Web Browser Version:<em class='requiredField'>*</em></div>
        <div class="span8">
            <input type="text" name="cf[browser_version]" id="cf_browser_version" value="" size="6" required="required" class="span4" style="height: 2.4em;" /> ex. 9
        </div>
    </div>
    
    <div class="row">
        &nbsp;
    </div>
    
    <div class="row">
        <div class="span12">If the problem occurs on all accounts, please give one of them. </div>
    </div>
        
    <div id="RVSiteBuilder">
    
        <div class="row">
            <div class="span1">
                &nbsp;
            </div>
            <div class="span3" style="text-align: center;">
                <label class="btn btn-block btn-small btn-info"><input type="radio" name="cf[problemOn]" id="cf_problem_on" value="RVSiteBuilder Manager"> <b> RVSiteBuilder Manager</b></label>
            </div>
            <div class="span3" style="text-align: center;">
                <label class="btn btn-block btn-small btn-info"><input type="radio" name="cf[problemOn]" id="cf_problem_on" value="RVSiteBuilder end-user"><b> RVSiteBuilder end-user</b></label>
            </div>
            <div class="span3" style="text-align: center;">
                <label class="btn btn-block btn-small btn-info"><input type="radio" name="cf[problemOn]" id="cf_problem_on" value="Published web site"><b> Published web site</b></label>
            </div>
        </div>
        
        <div class="row">
            &nbsp;
        </div>
        
        <div class="createTicketOption" title="RVSiteBuilder Manager">
            
        </div>
        
        <div class="createTicketOption" title="RVSiteBuilder end-user">
            <div class="row">
                <div class="span4">Control panel username:<em class='requiredField'>*</em></div>
                <div class="span8">
                    <input type="text" name="cf[cpuser]['RVSiteBuilder end-user']" id="cf_cpuser" value="" size="20" class="span6" style="height: 2.4em;" /> 
                </div>
            </div>
            <div class="row">
                <div class="span4">RVSiteBuilder project name:<em class='requiredField'>*</em></div>
                <div class="span8">
                    <input type="text" name="cf[rvproject]['RVSiteBuilder end-user']" id="cf_rvproject" value="" size="20" class="span6" style="height: 2.4em;" /> 
                </div>
            </div>
            <div class="row">
                <div class="span4">Step:<em class='requiredField'>*</em></div>
                <div class="span8">
                    <input type="text" name="cf[rvstep]['RVSiteBuilder end-user']" id="cf_rvstep" value="" size="20" class="span6" style="height: 2.4em;" /> 
                </div>
            </div>
        </div>
        
        <div class="createTicketOption" title="Published web site">
            <div class="row">
                <div class="span4">cPanel username:<em class='requiredField'>*</em></div>
                <div class="span8">
                    <input type="text" name="cf[cpuser]['Published web site']" id="cf_cpuser" value="" size="20" class="span6" style="height: 2.4em;" /> 
                </div>
            </div>
            <div class="row">
                <div class="span4">Full URL to the page in question:<em class='requiredField'>*</em></div>
                <div class="span8">
                    <input type="text" name="cf[rvurl]['Published web site']" id="cf_rvurl" value="" size="20" style="height: 2.4em;" /> 
                </div>
            </div>
        </div>

    
    </div>
    
    <div id="RVSiteBuilderTryout">
    
        <div class="row">
            <div class="span1">
                &nbsp;
            </div>
            <div class="span3" style="text-align: center;">
                <label class="btn btn-block btn-small btn-info"><input type="radio" name="cf[problemOn]" id="cf_problem_on" value="Tryout Installation"> <b> Tryout Installation</b></label>
            </div>
            <div class="span3" style="text-align: center;">
                <label class="btn btn-block btn-small btn-info"><input type="radio" name="cf[problemOn]" id="cf_problem_on" value="RVSiteBuilder Tryout end-user"><b> RVSiteBuilder end-user</b></label>
            </div>
            <div class="span3" style="text-align: center;">
                <label class="btn btn-block btn-small btn-info"><input type="radio" name="cf[problemOn]" id="cf_problem_on" value="Published tryout web site"><b> Published tryout web site</b></label>
            </div>
        </div>
        
        <div class="row">
            &nbsp;
        </div>
        
        <div class="createTicketOption" title="Tryout Installation">
            <div class="row">
                <div class="span4">Domain name you want to enable tryout:<em class='requiredField'>*</em></div>
                <div class="span8">
                    <input type="text" name="cf[domain_try]['Tryout Installation']" id="cf_domain_try" value="" size="20" style="height: 2.4em;" /> 
                </div>
            </div>
        </div>
        
        <div class="createTicketOption" title="RVSiteBuilder Tryout end-user">
            <div class="row">
                <div class="span4">Control panel username:<em class='requiredField'>*</em></div>
                <div class="span8">
                    <input type="text" name="cf[cpuser_try]['RVSiteBuilder Tryout end-user']" id="cf_cpuser_try" value="" size="20" class="span6" style="height: 2.4em;" /> 
                </div>
            </div>
            <div class="row">
                <div class="span4">Tryout web site project name:<em class='requiredField'>*</em></div>
                <div class="span8">
                    <input type="text" name="cf[rvproject_try]['RVSiteBuilder Tryout end-user']" id="cf_rvproject_try" value="" size="20" class="span6" style="height: 2.4em;" /> 
                </div>
            </div>
            <div class="row">
                <div class="span4">Step:<em class='requiredField'>*</em></div>
                <div class="span8">
                    <input type="text" name="cf[rvstep_try]['RVSiteBuilder Tryout end-user']" id="cf_rvstep_try" value="" size="20" class="span6" style="height: 2.4em;" /> 
                </div>
            </div>
        </div>
        
        <div class="createTicketOption" title="Published tryout web site">
            <div class="row">
                <div class="span4">Control panel username:<em class='requiredField'>*</em></div>
                <div class="span8">
                    <input type="text" name="cf[cpuser_try]['Published tryout web site']" id="cf_cpuser_try" value="" size="20" class="span6" style="height: 2.4em;" /> 
                </div>
            </div>
            <div class="row">
                <div class="span4">Full URL to the page in question:<em class='requiredField'>*</em></div>
                <div class="span8">
                    <input type="text" name="cf[rvurl_try]['Published tryout web site']" id="cf_rvurl_try" value="" size="20" style="height: 2.4em;" /> 
                </div>
            </div>
        </div>
    
    </div>
    
    
</div>

<div class="dotted-line-m"></div>

<script language="JavaScript">
{literal}

$(document).ready( function () {
    
    $('input[name="cf\[problem\]"]').click( function () {
        loadProblem();
    });
    
    $('input[name="cf\[problemOn\]"]').click( function () {
        loadProblemOn();
    });
    
    $('input[name="cf\[authMethod\]"]').click( function () {
        displayAuthMethod();
    });
    
    loadProblem();
    loadProblemOn();
    
});

function loadProblem ()
{
    $('#RVSiteBuilder,#RVSiteBuilderTryout').hide();
    var problemVal      = $('input[name="cf\[problem\]"]:checked').val();
    $('#'+ problemVal +'').show();
}

function loadProblemOn ()
{
    $('.createTicketOption').hide().find('div').each( function () {
        $(this).find('div input').removeAttr('required');
    });
    var problemOnVal    = $('input[name="cf\[problemOn\]"]:checked').val();
    $('div[title="'+ problemOnVal +'"]').show().find('div').each( function () {
        $(this).find('div input').attr('required', 'required');
    });
}

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