{literal}
    <script>
        function ask() {
            if (!confirm('Are you sure?'))
                return false;
        }

    </script>
{/literal}

<div class="row">
    <div class="col-md-4">
        <h2>
            <strong>{$lang.dnssecis}</strong>
            {if $status}
                <span class="label label-success" style="margin-left: 5px;">{$lang.Enabled}</span>
            {else}
                <span class="label label-default" style="margin-left: 5px;">{$lang.Disabled}</span>
            {/if}
        </h2>
    </div>
</div>
<br>
{if $status}
    <div class="row">
        <div class="col-sm-1" style="margin-left: 20px;">
            <a class="btn btn-default"
               href="?cmd={$modulename}&action=show&server_id={$server_id}&zone_id={$zone_id}&security_token={$security_token}">{if isset($lang.back)}{$lang.back}{else}Back{/if}</a>
        </div>
        <div class="col-sm-1">
            <a class="btn btn-primary"
               href="?cmd={$modulename}&action=dnssec&server_id={$server_id}&zone_id={$zone_id}&button=rectify&security_token={$security_token}">{$lang.rectifydnssec}</a>
        </div>
        <div class="col-sm-1">
            <a onclick="return ask()" class="btn btn-danger"
               href="?cmd={$modulename}&action=dnssec&server_id={$server_id}&zone_id={$zone_id}&button=disable&security_token={$security_token}">{$lang.disablednssec}</a>
        </div>
        {securitytoken}
    </div>
{else}
    <div class="row">
        <div class="col-sm-1" style="margin-left: 20px;">
            <a class="btn btn-default"
               href="?cmd={$modulename}&action=show&server_id={$server_id}&zone_id={$zone_id}&security_token={$security_token}">{if isset($lang.back)}{$lang.back}{else}Back{/if}</a>
        </div>
        <div class="col-sm-1">
            <a class="btn btn-success"
               href="?cmd={$modulename}&action=dnssec&server_id={$server_id}&zone_id={$zone_id}&button=enable&security_token={$security_token}">{$lang.enablednssec}</a>
        </div>
        {securitytoken}
    </div>
{/if}

{if $keys}
    <div class="panel panel-default" style="margin-top: 40px;">
        <div class="panel-heading">
            <h2 style="margin-top: 5px;"><strong>{$lang.dnsseckeys}</strong></h2>
        </div>
        <div class="panel-body">
            <div class="row" style="margin-left: 20px; margin-right: 20px;">
                <table class="table">
                    <thead>
                        <tr>
                            <th class="col-md-2">{$lang.keytag}</th>
                            <th class="col-md-2">{$lang.algorithm}</th>
                            <th class="col-md-8">{$lang.publickey}</th>
                        </tr>
                    </thead>
                    <tbody>
                        {foreach from=$keys item=key}
                            <tr>
                                <td>{$key.key_tag} - {$key.flag}</td>
                                <td>{$key.algorithm} - {$algorithm[$key.algorithm]}</td>
                                <td>
                                    <div class="col-md-12">
                                        <input class="form-control" type="text" value="{$key.public_key}"
                                               style="width: 95%;">
                                    </div>
                                </td>
                            </tr>
                        {/foreach}
                    </tbody>
                </table>
            </div>
        </div>
    </div>
{/if}

{if $ds}
    <div class="panel panel-default">
        <div class="panel-heading">
            <h2 style="margin-top: 5px;"><strong>{$lang.dnssecds}</strong></h2>
        </div>
        <div class="panel-body">
            <div class="row" style="margin-left: 20px; margin-right: 20px;">
                <table class="table">
                    <thead>
                        <tr>
                            <th class="col-md-2">{$lang.keytag}</th>
                            <th class="col-md-2">{$lang.algorithm}</th>
                            <th class="col-md-2">{$lang.digesttype}</th>
                            <th class="col-md-6">{$lang.digest}</th>
                        </tr>
                    </thead>
                    <tbody>
                        {foreach from=$ds item=value}
                            <tr>
                                <td>{$value.key_tag}</td>
                                <td>{$value.algorithm} - {$algorithm[$value.algorithm]}</td>
                                <td>{$value.digest_type} - {$digest[$value.digest_type]}</td>
                                <td>
                                    <div class="col-md-12">
                                        <input class="form-control" type="text" value="{$value.digest}"
                                               style="width: 95%;">
                                    </div>
                                </td>
                            </tr>
                        {/foreach}
                    </tbody>
                </table>
            </div>
        </div>
    </div>
{/if}
