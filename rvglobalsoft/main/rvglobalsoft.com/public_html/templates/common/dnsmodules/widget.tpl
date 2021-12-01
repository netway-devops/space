{if !$ips}

{$lang.rdnsnotavailable}

{else}
<form action="" method="post">
    <input type="hidden" name="make" value="uprdns" />
<table border="0" cellpadding="3" cellspacing="0" width="100%" class="fullscreen table" >
    <tr>
        <th width="120">IP</th>
        <th>{$lang.hostname}</th>
    </tr>
    {foreach from=$ips item=ip}

    <tr>
        <td style="padding-top:15px;font-weight:bold">{$ip.ipaddress}</td>
        <td>
            <input {if !$ip.ptrzone}disabled="disabled" value="Unable to load related .in-addr.arpa zone"{else}value="{$ip.ptrcontent}"{/if} type="text" name="rdns[{$ip.ipaddress}][ptrcontent]" style="width:350px;"/>
            {if $ip.ptrzone}
                <input type="hidden" name="rdns[{$ip.ipaddress}][oldptrcontent]" value="{$ip.ptrcontent}" />
                <input type="hidden" name="rdns[{$ip.ipaddress}][ptrhash]" value="{$ip.ptrhash}" />
                <input type="hidden" name="rdns[{$ip.ipaddress}][ptrid]" value="{$ip.ptrid}" />
                <input type="hidden" name="rdns[{$ip.ipaddress}][ptrzone]" value="{$ip.ptrzone}" />
                <input type="hidden" name="rdns[{$ip.ipaddress}][sid]" value="{$ip.server_id}" />
            {/if}
        </td>
    </tr>
    {/foreach}
</table>
    <div class="form-actions" style="text-align: center">


<input type="submit" style="font-weight:bold" value="Update Reverse DNS" class="btn btn-info ">
<div class="clear"></div>
</div>
</form>

{/if}