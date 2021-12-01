<script type="text/javascript" src="{$type_dir}js/punycode.min.js"></script>
<script type="text/javascript" src="{$type_dir}js/script.js"></script>
{literal}
<script type="text/javascript">
    function ask() {
        if (!confirm('{/literal}{$lang.confirm_delrecord}{literal}'))
            return false;
    }
</script>
{/literal}

<div style="margin-bottom:1em">
    <div class="pull-left form-horizontal">
        <h4>{$lang.domain}: {$domain.domain}</h4>
    </div>
    <div class="pull-right form-horizontal">
        <span style="vertical-align: text-bottom;">{$lang.newrecord}</span>
        <select class="add_record" style="vertical-align: top;">
            {foreach from=$supported_types item=stype}
                <option value="{$stype}">{$stype}</option>
            {/foreach}
        </select>
        <a class="btn btn-primary" href="{$service_url}&act=add_record&dom={$domid}&type={$stype}">{$lang.Add}</a>
        <a class="btn btn-primary" href="{$service_url}&act=dns_templates&dom={$domid}">{$lang.dnstemplates}</a>
        {if $widgets}
            {foreach from=$widgets item=widg}
                <a class="btn btn-primary" href="{$service_url}&widget={$widg.name}{if $widg.id}&wid={$widg.id}{/if}&domain_id={$domid}">
                    {assign var=widg_name value="`$widg.name`_widget"}{if $lang[$widg_name]}{$lang[$widg_name]}{elseif $lang[$widg.name]}{$lang[$widg.name]}{elseif $widg.fullname}{$widg.fullname}{else}{$widg.name}{/if}
                </a>
            {/foreach}
        {/if}
        <a class="btn btn-primary" href="{$service_url}&act=import_records&dom={$domid}">
            {$lang.importzonecontents}
        </a>
        <a class="btn btn-default" href="{$service_url}">&laquo; {$lang.back}</a>
    </div>
    <div class="clear"></div>
</div>

<form action="{$service_url}&act=dns_manage&domain_id={$domid}" method="POST">
    {foreach from=$record_types item=ids key=type}
        {if $type=='SOA'}
            <table cellspacing="0" cellpadding="0" border="0" width="100%" class="display dns-records soa" style="margin-bottom:15px">
                <thead>
                    <tr>
                        <th colspan="6">{$lang.soarecord}</th>
                    </tr>
                </thead>
                    <tbody>
                        <tr>
                            <th>{$lang.name}</th>
                            <th>{$lang.priority}</th>
                            <th>TTL</th>
                            <th>{$lang.type}</th>
                            <th>{$lang.data}</th>
                            <th></th>
                        </tr>
                    </tbody>
                <tbody>
                    {foreach from=$records item=record}
                        {if in_array($record.id, $ids)}
                            <tr style="vertical-align:top">
                                <td><span class="overflow-e rr-name">{$record.name}</span></td>
                                <td>{$record.priority}</td>
                                <td>{$record.ttl}</td>
                                <td>{$record.type}</td>
                                <td>
                                    <span class="">{$record.content[0]} {$record.content[1]}</span>
                                    <div>
                                        <span style="color: #888">{$lang.serial}: </span>
                                        <span>{$record.content[2]};</span>
                                    </div>
                                    <div class="">
                                        <span style="color: #888">{$lang.refresh}: </span>
                                        <span>{$record.content[3]};</span>
                                    </div>
                                    <div class="">
                                        <span style="color: #888">{$lang.retry}: </span>
                                        <span>{$record.content[4]};</span>
                                    </div>
                                    <div>
                                        <span style="color: #888">{$lang.expire}: </span>
                                        <span>{$record.content[5]};</span>
                                    </div>
                                    <div class="">
                                        <span style="color: #888">{$lang.minimumttl}: </span>
                                        <span>{$record.content[6]}</span>
                                    </div>
                                </td>
                                <td>
                                    {if $allow_soa_edit}
                                        <a class="fs11"
                                           href="{$service_url}&act=edit_record&domain_id={$domid}&record={$record.id}"
                                           title="{$lang.edit}">{$lang.edit}
                                        </a>
                                    {/if}
                                </td>
                            </tr>
                        {/if}
                    {/foreach}
                </tbody>
            </table>
        {/if}
    {/foreach}
    {foreach from=$record_types item=ids key=type}
        {if $type!='SOA'}
            <table cellspacing="0" cellpadding="0" border="0" width="100%" class="display dns-records" style="margin-bottom:15px">
                <thead>
                    <tr>
                        <th align="left" colspan="6">{$type} {$lang.records}</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <th>{$lang.name}</th>
                        <th>{$lang.priority}</th>
                        <th>TTL</th>
                        <th>{$lang.type}</th>
                        <th>{$lang.data}</th>
                        <th></th>
                    </tr>
                </tbody>
                <tbody>
                    {foreach from=$records item=record name=rc}
                        {if in_array($record.id, $ids)}
                            <tr {if  $smarty.foreach.rc.index%2 == 0}class="even" {else}class="odd"{/if}>
                                <td><span class="overflow-e rr-name">{$record.name}</span></td>
                                <td>{$record.priority}</td>
                                <td>{$record.ttl}</td>
                                <td>{$record.type}</td>
                                <td align="left">
                                    <span class="overflow-e rr-content">
                                        {if is_array($record.content)}
                                            {foreach from=$record.content item=content name=row}
                                                {$content}&nbsp;
                                            {/foreach}
                                        {else}
                                            {$record.content}
                                        {/if}
                                    </span>
                                </td>
                                <td style="text-align: right">
                                    <div class="dns-actions">
                                        {if in_array($record.type,$supported_types) && isset($record.id)}
                                            <a class="fs11" href="{$service_url}&act=edit_record&domain_id={$domid}&record={$record.id}" title="{$lang.edit}">{$lang.edit}</a> |
                                            <a class="fs11 lmore" href="{$service_url}&act=dns_manage&domain_id={$domid}&delete={$record.id}&security_token={$security_token}" onclick="return ask()" title="{$lang.delete}">{$lang.delete}</a>
                                        {else}
                                            &nbsp;
                                        {/if}
                                    </div>
                                </td>
                            </tr>
                        {/if}
                    {/foreach}
                    <tr>
                        <td colspan="6" style="text-align:right">
                            <a href="{$service_url}&act=add_record&dom={$domid}&type={$type}" class="fs11 dns-add-record">{$lang.addnew} {$lang.record}</a>
                        </td>
                    </tr>
                </tbody>

            </table>
        {/if}
    {/foreach}

    <div style="margin-top:2em">
        <div class="pull-left form-horizontal dns-add-record-form">
            <span>{$lang.newrecord}</span>
            <select id="add_record">
                {foreach from=$supported_types item=stype}
                    <option value="{$stype}">{$stype}</option>
                {/foreach}
            </select>
            <a class="btn btn-primary"
               href="{$service_url}&act=add_record&dom={$domid}&type={$stype}">{$lang.Add}</a>
        </div>
        <div class="pull-right form-horizontal">
            <a class="btn btn-default" href="{$service_url}">
                &laquo; {$lang.back}</a>
        </div>
        <div class="clear"></div>
    </div>
    {securitytoken}
</form>