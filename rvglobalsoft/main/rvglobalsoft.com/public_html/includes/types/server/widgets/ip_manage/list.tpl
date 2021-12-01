{if !$ips}

    IP management is not available for your IP addresses at the moment.

{else}
    <form action="" method="post">
        <input type="hidden" name="make" value="update" />
        <table border="0" cellpadding="3" cellspacing="0" width="100%" class="fullscreen table form-horizontal" >
            <tr>
                <th width="120">IP</th>
                <th>Description</th>
            </tr>
            {foreach from=$ips item=ip}
                <tr>
                    <td style="padding-top:15px;font-weight:bold">{$ip.ipaddress}</td>
                    <td>
                        {if $ip.status == 'reserved'}
                            {$ip.client_description}
                        {else}
                            <textarea style="height:1.5em" name="notes[{$ip.ipaddress}]">{$ip.client_description}</textarea>
                        {/if}
                    </td>
                </tr>
            {/foreach}
        </table>
        <div class="form-actions" style="text-align: center">


            <input type="submit" style="font-weight:bold" value="{$lang.shortsave}" class="btn btn-info" >
            <div class="clear"></div>
        </div>
    </form>

{/if}