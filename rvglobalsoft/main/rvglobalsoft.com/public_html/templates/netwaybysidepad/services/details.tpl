{php}
$templatePath   = $this->get_template_vars('template_path');
include($templatePath . 'services/details.tpl.php');
{/php}

<script type="text/javascript">
var caUrl       = '{$ca_url}';
var systemUrl   = '{$system_url}';
var accountId   = '{$service.id}';
</script>

<div><h3>{$service.name}</h3></div>

<div class="wrapper-bg">

    {include file='services/service_sidemenu.tpl'}

    <div class="services-content">
        <ul class="breadcrumb">

            <li><a href="{$ca_url}clientarea/">{$lang.clientarea}</a> <span>></span></li>
            <li><a href="{$ca_url}clientarea/services/{$service.slug}/">{$service.catname}</a> <span>></span></li>

            {if $widget}
                <li><a href="{$ca_url}clientarea/services/{$service.slug}/{$service.id}/">{$service.name}</a>  <span>&gt;</span></li>
                <li>
                    {if $lang[$widget.name]}
                        {$lang[$widget.name]}
                    {elseif $widget.fullname}
                        {$widget.fullname}
                    {else}
                        {$widget.name}
                    {/if}
                </li>
            {else}
                <li>{$service.name}</li>
            {/if}
        </ul>

        <div class="line-separaotr-m"></div>

        {if $widget.appendtpl}

            {include file=$widget.appendtpl}

        {else}
            <div class="row" style="padding: 15px;">

                <h4>Service Information</h4>
                <table class="table">
                <tbody>
                <tr>
                    <td width="20%">Status:</td>
                    <td><span class="label label-{$aService.status}">{$lang[$aService.status]}</span></td>
                </tr>
                <tr>
                    <td width="20%">Expire:</td>
                    <td>{if $aService.expire.expire == 'Jan 1, 1970'} - {else} {$aService.expire.expire} {/if}</td>
                </tr>
                <tr>
                    <td>IP Address:</td>
                    <td><strong>{$aService.ip}{if isset($aService.pub_ip)} ({$aService.pub_ip}){/if}</strong></td>
                </tr>
                {if preg_match("/litespeed/i", $aService.name) && isset($serial_number)}
                <tr>
                	<td>Serial Number:</td>
                	<td><strong>{$serial_number}</strong></td>
                {/if}
                </tbody>
                </table>

            </div>


            <div class="row" style="padding: 15px;">
                <a name="command"></a>

                <h4>Available Command</h4>
                <table class="table">
                <tbody>
                <tr>
                    <td width="20%">Action:</td>
                    <td>
                        {if 'changeip'|in_array:$aCommand}
                            {if $service.status == 'Active'}
                            <a href="{$ca_url}clientarea/services/licenses/{$service.id}/#command" onclick="changeIPAddress(); return false;" class="btn btn-small btn-success">Change IP</a>
                            {/if}
                        {/if}
                        {if 'cancel'|in_array:$aCommand}
                            {if $service.status != 'Terminated' && $service.status != 'Cancelled'}
                            <a href="{$ca_url}clientarea&action=services&service={$service.id}&cid={$service.category_id}&cancel" class="btn btn-small btn-danger" >Cancellation Request</a>
                            {/if}
                        {/if}
                    </td>
                </tr>
                </tbody>
                </table>

            </div>


            <div class="row" style="padding: 15px;">

                <div id="changeIP" class="well well-small" style="display: none;">

                <h4>Change IP Address</h4>

                <form id="formChangeIP">
                <table class="table">
                <tbody>
                <tr>
                    <td width="20%">From IP:</td>
                    <td><strong>{$aService.ip}</strong></td>
                </tr>
                <tr>
                    <td>To IP:</td>
                    <td><input type="text" name="ip" value="" class="input-medium" /></td>
                </tr>
                <tr>
                    <td></td>
                    <td><input type="submit" name="submit" value="Submit" class="btn btn-small btn-success" /></td>
                </tr>
                </tbody>
                </table>
                </form>

                </div>
            </div>


            <div class="row" style="padding: 15px;">

                <h4>Billing Information</h4>
                <table class="table">
                <tbody>
                    <tr>
                        <td width="20%">Next Due Date:</td>
                        <td>{$aService.next_due|date_format}</td>
                    </tr>
                    <tr>
                        <td>Billing Cycle:</td>
                        <td>{$aService.billingcycle}</td>
                    </tr>
                    <tr>
                        <td>Recurring Amount:</td>
                        <td>{$aService.total|price:$currency}</td>
                    </tr>
                </tbody>
                </table>

            </div>

        {/if}

    </div>

</div>


<script language="JavaScript">
{literal}

$(document).ready( function () {

    $('#formChangeIP').submit( function () {

        $('#formChangeIP').addLoader();
        $('#verifyMessage').remove();

        var ip          = $(this).find('input[name="ip"]').val();
        $.post(caUrl + '?cmd=productlicensehandle&action=changeip', {
            ip          : ip,
            accountId   : accountId
        }, function (data) {
            var codes   = queryResult(data);
            var result  = codes.RESULT;

            if (codes.RESULT == 'TRUE') {
                $('#formChangeIP').append('<span id="verifyMessage" class="text-info">'+ codes[result] +'</span>');
                document.location       = caUrl +'clientarea/services/licenses/'+ accountId +'/';
            } else {
                $('#formChangeIP').append('<span id="verifyMessage" class="text-error">'+ codes[result] +'</span>');
            }

            $('#preloader').remove();

        });

        return false;
    });

});

function changeIPAddress ()
{
    var isHref          = $('li').find('a:contains("Change IP")').attr('href');

    if (typeof isHref  !== "undefined") {
        document.location = caUrl + isHref;
        return false;
    }

    $('#changeIP').toggle();

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

{/literal}
</script>
