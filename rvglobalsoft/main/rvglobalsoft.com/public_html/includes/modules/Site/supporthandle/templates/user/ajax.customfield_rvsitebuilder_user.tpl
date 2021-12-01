<div class="dotted-line-m"></div>
<label>Require Information</label><br />
<span> * You are able to delete the custom field by yourself. </span>

<div style="padding:14px;">
    
    <div class="row">
        &nbsp;
    </div>
    
    <div class="row">
        <div class="span4">Control panel URL:<em class='text-danger'>*</em></div>
        <div class="span8">
            <input type="text" name="cf[cpurl]" id="cf_cpurl" value="" size="20" required="required" style="height: 2.4em;" />
        </div>
    </div>
    
    <div class="row">
        <div class="span4">Control panel username:<em class='text-danger'>*</em></div>
        <div class="span8">
            <input type="text" name="cf[cpuser]" id="cf_cpuser" value="" size="20" required="required" style="height: 2.4em;" />
        </div>
    </div>
    
    <div class="row">
        <div class="span4">Password:<em class='text-danger'>*</em></div>
        <div class="span8">
            <input type="password" name="cf[cppassword]" id="cf_cppassword" value="" size="20" required="required" autocomplete="off" style="height: 2.4em;" />
        </div>
    </div>
    
    <div class="row">
        &nbsp;
    </div>
    
    <div class="row">
        <div class="span4">Problem on:</div>
        <div class="span4" style="text-align: center;">
            <label class="btn btn-block btn-small btn-info"><input type="radio" name="cf[problem]" id="cf_problem" value="RVSiteBuilder" checked="checked" /> RVSiteBuilder</label>
        </div>
        <div class="span4" style="text-align: center;">
            <label class="btn btn-block btn-small btn-info"><input type="radio" name="cf[problem]" id="cf_problem" value="PublishedWebsite" /> Published web site</label>
        </div>
    </div>
    
    <div class="row">
        &nbsp;
    </div>
        
    <div id="RVSiteBuilder">
        
        <div class="row">
            <div class="span4">RVSiteBuilder project name:<em class='requiredField'>*</em></div>
            <div class="span8">
                <input type="text" name="cf[rvproject]['RVSiteBuilder']" id="cf_rvproject" value="" size="20" title="required" style="height: 2.4em;" /> 
            </div>
        </div>
        <div class="row">
            <div class="span4">Step:<em class='requiredField'>*</em></div>
            <div class="span8">
                <input type="text" name="cf[rvstep]['RVSiteBuilder']" id="cf_rvstep" value="" size="20" title="required" class="span6" style="height: 2.4em;" /> 
            </div>
        </div>
        <div class="row">
            <div class="span4">Full published URL to the page in question:</div>
            <div class="span8">
                <input type="text" name="cf[rvurl_opt]['RVSiteBuilder']" id="cf_rvurl_opt" value="" size="20" style="height: 2.4em;" /> 
            </div>
        </div>

    </div>
    
    <div id="PublishedWebsite">
        
        <div class="row">
            <div class="span4">Full URL to the page in question:<em class='requiredField'>*</em></div>
            <div class="span8">
                <input type="text" name="cf[rvurl]['PublishedWebsite']" id="cf_rvurl" value="" size="20" title="required" style="height: 2.4em;" /> 
            </div>
        </div>
        <div class="row">
            <div class="span4">RVSiteBuilder project name:</div>
            <div class="span8">
                <input type="text" name="cf[rvproject_opt]['PublishedWebsite']" id="cf_rvproject_opt" value="" size="20" class="span6" style="height: 2.4em;" /> 
            </div>
        </div>
        <div class="row">
            <div class="span4">Step:</div>
            <div class="span8">
                <input type="text" name="cf[rvstep_opt]['PublishedWebsite']" id="cf_rvstep_opt" value="" size="20" class="span6" style="height: 2.4em;" /> <small>(Optional)</small>
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
    
    loadProblem();
    
});

function loadProblem ()
{
    $('#RVSiteBuilder,#PublishedWebsite').hide().find('div').each( function () {
        $(this).find('div input').removeAttr('required');
    });
    var problemVal      = $('input[name="cf\[problem\]"]:checked').val();
    $('#'+ problemVal +'').show().find('div').each( function () {
        $(this).find('div input[title="required"]').attr('required', 'required');
    });
}

{/literal}
</script>