<div class="wbox" id="dnssec_widget">
    <div class="wbox_header">DNSSEC: {$domain.domain}</div>

    <div  class="wbox_content">
        <h4>DNSSEC for this zone is:
            {if $dnssec}
                <span class="label label-success">Enabled</span>
            {else}
                <span class="label label-danger">Disabled</span>
            {/if}</h4>

        Tools:<br>
        <a class="btn btn-default" href="{$ca_url}clientarea/services/{$service.slug}/{$service.id}/&act=dns_manage&domain_id={$domain.domain_id}"  > &laquo; {$lang.back}</a>
        {if $dnssec}
            <a class="btn btn-primary" href="{$widget_url}&widgetdo=rectify&security_token={$security_token}"  >Rectify Zone</a>
            <a class="btn btn-danger" href="{$widget_url}&widgetdo=remove&security_token={$security_token}" onclick="return confirm('Are you sure?');" >Disable DNSSEC</a>
        {else}
            <a class="btn btn-success" href="{$widget_url}&widgetdo=secure&security_token={$security_token}"  >Enable DNSSEC</a>
        {/if}

    </div>
</div>


{if $dnssec.keys}
    <div class="wbox" id="dnssec_widget">
        <div class="wbox_header">DNSSEC Keys</div>

        <div  class="wbox_content">
            <table class="table table-striped" width="100%">
                <tr>
                    <th width="10%">Key tag</th>
                    <th width="20%">Algorithm</th>
                    <th>Public key</th>
                </tr>
                {foreach from=$dnssec.keys item=ds}
                    <tr>
                        <td>{$ds.key_tag} - {$ds.flag}</td>
                        <td>{$ds.algorithm} - {$dnssec_algorithm[$ds.algorithm]}</td>
                        <td><input type="text" value="{$ds.public_key}" style="width:95%"/></td>
                    </tr>
                {/foreach}
            </table>
        </div>
    </div>

{/if}

{if $dnssec.ds}
    <div class="wbox" id="dnssec_widget">
        <div class="wbox_header">DNSSEC DS</div>

        <div  class="wbox_content">
            <table class="table table-striped" width="100%">
                <tr>
                    <th width="10%">Key tag</th>
                    <th width="20%">Algorithm</th>
                    <th width="20%">Digest type</th>
                    <th>Digest</th>
                </tr>
                {foreach from=$dnssec.ds item=ds}
                    <tr>
                        <td>{$ds.key_tag}</td>
                        <td>{$ds.algorithm} - {$dnssec_algorithm[$ds.algorithm]}</td>
                        <td>{$ds.digest_type} - {$dnssec_digest[$ds.digest_type]}</td>
                        <td><input type="text" value="{$ds.digest}" style="width:95%"/></td>
                    </tr>
                {/foreach}
            </table>
        </div>
    </div>
{/if}