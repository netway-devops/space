{php}
$templatePath   = $this->get_template_vars('template_path');
include($templatePath . 'request_trial.tpl.php');
{/php}


<script language="javascript">

var caUrl       = '{$ca_url}';
var productId   = '{$productId}';

{literal}

$(document).ready( function () {
    
    $('#loginModal').on('hidden', function () {
        $('#preloader').remove();
    });
    
    $('#ajaxFormLogin').submit( function () {
        $('#ajaxFormLogin').addLoader();
        
        var email       = $('input[name="username"]').val();
        var password    = $('input[name="password"]').val();
        
        $.post(caUrl + '?cmd=requesttrialhandle&action=login', {
            email       :email,
            password    :password
            }, function (data) {
            
            var codes   = queryResult(data);
            var result  = codes.RESULT[0];
            
            if (result.success) {
                $('#ajaxFormLogin')[0].submit();
                setTimeout(function () {
                    location.reload();
                    $('#preloader').remove();
                }, 3000);
            } else {
                alert('Result '+ result.error.join(' ') +' ');
                $('#preloader').remove();
            }
            
        });
        
        return false;
    });
    
});

function sendRequestTrial ()
{
    $('#formRequest').addLoader();
    
    $.get(caUrl + '?cmd=requesttrialhandle&action=isClient', function (data) {
        var codes   = queryResult(data);
        
        var ip          = $('#ipaddress').val();
        var type        = $('input[name="server_type"]:checked').val();
        
        if (! validateIPaddress(ip)) {
            $('#loginModal').modal('hide');
            
            alert("You have entered an invalid IP address!");
            
            $('#preloader').remove();
            return false;
        }
        
        if (codes.RESULT == 0) {
            $('#preloader').remove();
            return false;
        }
        
        $('#loginModal').modal('hide');
        
        $.post(caUrl + '?cmd=requesttrialhandle&action=send', {
            ip          :ip,
            type        :type,
            id          :productId
            }, function (data) {
            var codes   = queryResult(data);
            if(codes.INFO[0] == 'ticketcreatednfo'){
                $.post(caUrl + '?cmd=requesttrialhandle&action=sendcpanel', {id: productId});
            }
            
            $('#preloader').remove();
            
            $('#requestResult').show();
            $('#formRequest').hide();
            
            
        });
        
    });
    
    return false;
}

function queryResult (data)
{
    var codes   = {};
    if (data.indexOf("<!-- {") == 0) {
        codes   = eval("(" + data.substr(data.indexOf("<!-- ") + 4, data.indexOf("-->") - 4) + ")");
    }
    return codes;
}

function validateIPaddress(ipaddress) 
{
    if (/^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$/.test(ipaddress))
    {
        return true;
    }
    return false;
}

{/literal}
</script>


<!-- Modal -->
<div id="loginModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-header">
    <h3 id="myModalLabel">Require client account</h3>
  </div>
  <div class="modal-body">
    <form id="ajaxFormLogin" action="{$system_url}request_trial" method="post" target="_blank">
        {assign var="onlycustomer" value="1"}
        {include file="ajax.login.tpl"}
    </form>
  </div>
  <div class="modal-footer">
    <button class="btn" data-dismiss="modal" aria-hidden="true">Close</button>
  </div>
</div>

<div class="container">
    
    <h1>Request trial</h1>
    
    <div id="requestResult" class="alert" style="display: none;">
        <h4>Success</h4>
        <p>Your request has been send success.</p>
    </div>
    
    <form id="formRequest" class="form-horizontal well well-small">
    
    <div class="control-group">
        <hr />
    </div>
    <div class="control-group">
        <label class="control-label" for="productName">Request trial for:</label>
        <div class="controls">
            <strong>{$aProduct.name}</strong>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label" for="ipaddress">IP Address:</label>
        <div class="controls">
            <input type="text" id="ipaddress" name="ipaddress" required="required" placeholder="Require">
        </div>
    </div>
    <div class="control-group">
        <label class="control-label" for="serverType">Server Type:</label>
        <div class="controls">
            <label><input type="radio" name="server_type" value="Dedicated" checked="checked" /> Dedicated &nbsp;&nbsp;&nbsp;&nbsp; </label>
            <label><input type="radio" name="server_type" value="VPS" /> VPS &nbsp;&nbsp;&nbsp;&nbsp; </label>
        </div>
    </div>
    <div class="control-group">
        <hr />
    </div>
    <div class="control-group">
        <label class="control-label">&nbsp;</label>
        <div class="controls">
            <a href="javascript:return false;" onclick="sendRequestTrial();" class="btn btn-success" data-toggle="modal" data-target="#loginModal">Submit</a>
        </div>
    </div>
    
    </form>
    
</div>
