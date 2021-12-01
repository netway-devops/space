<div class="wbox" id="dnssec_widget">
    <div class="wbox_header">{$lang.dnssec}: {$domain.domain}</div>
    <div class="wbox_content">
        <h4>{$lang.dnssec_for_zone_is}
            {if $dnssec}
                <span class="badge badge-success">{$lang.dnssec_enabled}</span>
            {else}
                <span class="badge badge-danger">{$lang.dnssec_disabled}</span>
            {/if}</h4>
        {$lang.dnssec_tools}:
        <br>
        <a class="btn btn-default" href="{$ca_url}clientarea/services/{$service.slug}/{$service.id}/&act=dns_manage&domain_id={$domain.domain_id}">
            &laquo;{$lang.back}</a>
        {if $dnssec}
            <a class="btn btn-primary" href="{$widget_url}&widgetdo=rectify&security_token={$security_token}">{$lang.dnssec_rectify_zone}</a>
            <a class="btn btn-danger" href="{$widget_url}&widgetdo=remove&security_token={$security_token}" onclick="return confirm('Are you sure?');">{$lang.dnssec_disable}</a>
        {else}
            <a class="btn btn-success" href="{$widget_url}&widgetdo=secure&security_token={$security_token}">{$lang.dnssec_enable}</a>
        {/if}
    </div>
</div>
{if $dnssec.keys}
    <div class="wbox" id="dnssec_widget">
        <div class="wbox_header">{$lang.dnssec_keys}</div>
        <div class="wbox_content">
            <table class="table table-striped" width="100%">
                <tr>
                    <th width="10%">{$lang.dnssec_key_tag}</th>
                    <th width="20%">{$lang.algorithm}</th>
                    <th>{$lang.dnssec_public_key}</th>
                </tr>
                {foreach from=$dnssec.keys item=ds}
                    <tr>
                        <td>{$ds.key_tag} - {$ds.flag}</td>
                        <td>{$ds.algorithm} - {$dnssec_algorithm[$ds.algorithm]}</td>
                        <td><input class="form-control" type="text" value="{$ds.public_key}" style="width:95%"/></td>
                    </tr>
                {/foreach}
            </table>
        </div>
    </div>
{/if}

{if $dnssec.ds}
    <div class="wbox" id="dnssec_widget">
        <div class="wbox_header">{$lang.dnssec_ds}</div>
        <div class="wbox_content">
            <table class="table table-striped" width="100%">
                <tr>
                    <th width="10%">{$lang.dnssec_key_tag}</th>
                    <th width="20%">{$lang.algorithm}</th>
                    <th width="20%">{$lang.dnssec_digest_type}</th>
                    <th>{$lang.dnssec_digest}</th>
                </tr>
                {foreach from=$dnssec.ds item=ds}
                    <tr>
                        <td>{$ds.key_tag}</td>
                        <td>{$ds.algorithm} - {$dnssec_algorithm[$ds.algorithm]}</td>
                        <td>{$ds.digest_type} - {$dnssec_digest[$ds.digest_type]}</td>
                        <td><input class="form-control" type="text" value="{$ds.digest}" style="width:95%"/></td>
                    </tr>
                {/foreach}
            </table>
        </div>
    </div>
{/if}