<link media="all" type="text/css" rel="stylesheet" href="{$system_url}includes/types/dnsservice/style.css" />
<a href="?cmd=clientarea&amp;action=services" id="currentlist" style="display:none" updater="#updater"></a>
<table cellspacing="0" cellpadding="0" border="0" width="100%" class="display">
    <thead>
        <tr>
            <th>{$lang.service}</th>
            <th width="50">{$lang.zones}</th>
            <th width="100">{$lang.nextinvoicetotal}</th>
            <th width="100">{$lang.nextdue}</th>
            <th width="90">{$lang.status}</th>
        </tr>
    </thead>
    <tbody id="updater">

        {foreach from=$services item=service name=foo}
        <tr {if $smarty.foreach.foo.index%2==0}class="odd"{/if}>
            <td ><a href="{$ca_url}clientarea/{$action}/{$opdetails.slug}/{$service.id}/"> {$service.name}</a></td>
            <td>{$service.domains}</td>
            <td>{if $service.billingcycle=='Free' || $service.billingcycle=='One Time'}---{else}{$service.total|price:$currency}{/if}</td>
            <td>{if $service.billingcycle=='Free' || $service.billingcycle=='One Time'}---{else}{$service.next_due|dateformat:$date_format}{/if}</td>
            <td><span class="{$service.status}">{$lang[$service.status]}</span></td>
        </tr>
        {/foreach}
    </tbody>
</table>