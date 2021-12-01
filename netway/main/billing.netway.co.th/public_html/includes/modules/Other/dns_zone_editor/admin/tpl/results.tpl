{literal}
    <script>
        function ask() {
            if (!confirm('Do you really want to delete this record?'))
                return false;
        }

    </script>
{/literal}

<div class="dns-zone-header" style="margin-bottom: 10px">
    <div class="pull-right">
        <a class="btn btn-primary btn-sm"
           href="?cmd={$modulename}&action=import&server_id={$server_id}&zone_id={$zone_id}&security_token={$security_token}">
            Import Records
        </a>
        {if $dnssec == 'true'}
            <a class="btn btn-primary btn-sm"
               href="?cmd={$modulename}&action=dnssec&server_id={$server_id}&zone_id={$zone_id}&security_token={$security_token}">
                {$lang.managednssec}
            </a>
        {/if}
    </div>

    <a class="btn btn-default btn-sm"
       href="?cmd={$modulename}&action=show&server={$server_id}&security_token={$security_token}">Go Back</a>
</div>

<form action="?cmd={$modulename}&action=add" method="post" class="form-horizontal">
    <input type='hidden' name="server_id" value="{$server_id}" class="form-control" readonly>
    <input type='hidden' name="domain_id" value="{$zone_id}" class="form-control" readonly>
    <input type='hidden' name="server_name" value="{$server_name}" class="form-control" readonly>
    <input type='hidden' name="zone_name" value="{$zone_name}" class="form-control" readonly>

    <div class="row">
        <div class="form-group col-sm-2">
            <div class="col-sm-12">
                <label>{$lang.addnewrecord|default:'Add New Record'}</label>
                <div>
                    <div class="input-group">
                        <select name="type" class="form-control">
                            {foreach from=$types item=type key=id}
                                <option value="{$type}">{$type}</option>
                            {/foreach}
                        </select>
                        <div class="input-group-btn">
                            <button type="submit" value="true" class="btn btn-success">{$lang.Add}</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    {securitytoken}
</form>


{foreach from=$zone item=zon key=type}
    <h4><strong>{$type} {if $type=='SOA'}Record{else}Records{/if}</strong></h4>
    <table id="table-{$type}" class="table table-condensed dns-table">
        <thead>
            <tr class="active">
                <td class="dns-td-wide {if $type == 'PTR'}ptr{/if}">{$lang.Name}</td>
                <td class="dns-td">{$lang.priority}</td>
                <td class="dns-td">TTL</td>
                <td class="dns-td">{$lang.type|default:"Type"}</td>
                <td class="dns-td-wide">{$lang.Data|default:"Data"}</td>
                <td class="dns-td no-sort"></td>
            </tr>
        </thead>
        <tbody>
            {foreach from=$zon item=value key=id}
                <tr class="dns-tr-soa">
                    <td>{$value.name}</td>
                    <td>{$value.priority}</td>
                    <td>{$value.ttl}</td>
                    <td>{$value.type}</td>
                    {if is_array($value.content)}
                        <td align="left" style="padding-left: 1em">
                            {if $type=='SOA'}
                                {foreach from=$value.content item=item key=key}
                                    {if $key==1}{$item} (
                                    {elseif $key==2}
                                        <br>
                                        <div class="dns-content-soa">{$item};</div>
                                        <div>Serial</div>
                                    {elseif $key==3}
                                        <div class="dns-content-soa">{$item};</div>
                                        <div>Refresh</div>
                                    {elseif $key==4}
                                        <div class="dns-content-soa">{$item};</div>
                                        <div>Retry</div>
                                    {elseif $key==5}
                                        <div class="dns-content-soa">{$item};</div>
                                        <div>Expire</div>
                                    {elseif $key==6}
                                        <div class="dns-content-soa">{$item};</div>
                                        <div>Minimum TTL</div>
                                        )
                                    {else}
                                        {$item}
                                    {/if}
                                {/foreach}
                            {else}
                                {foreach from=$value.content item=item key=key}
                                    {$item}
                                {/foreach}
                            {/if}
                        </td>
                    {else}
                        <td>
                            <div style="max-width: 320px; overflow: auto">
                                {$value.content}
                            </div>
                        </td>
                    {/if}
                    <td>
                        <a href="?cmd={$modulename}&action=edit&record_id={$value.id}&server_id={$server_id}&domain_id={if $value.domain_id}{$value.domain_id}{else}{$zone_id}{/if}&security_token={$security_token}">{$lang.edit|ucfirst}</a>
                        {if $type != 'SOA'}
                            <a onclick="return ask()"
                               href="?cmd={$modulename}&action=delete&record_id={$value.id}&server_id={$server_id}&domain_id={if $value.domain_id}{$value.domain_id}{else}{$zone_id}{/if}&security_token={$security_token}">{$lang.delete|ucfirst}</a>
                        {/if}
                    </td>
                </tr>
            {/foreach}
        </tbody>
    </table>
    <hr>
{/foreach}

<div style="margin-top: 10px;">
    <a class="btn btn-default btn-sm"
       href="?cmd={$modulename}&action=show&server={$server_id}&security_token={$security_token}">Go Back</a>
</div>
{literal}
<script>
    $('.dns-table').each(function () {
        if ($(this).attr('id') !== 'table-SOA') {
            $(this).dataTable({
                "columnDefs": [ {
                    "targets"  : 'no-sort',
                    "orderable": false,
                    "order": []
                },
                {
                    "targets"  : 'ptr',
                    "type": 'num-html'
                }]
            });
        }
    });
</script>
{/literal}