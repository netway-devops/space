<div class="tabs tab-default">
    <div  class="newhorizontalnav">

        <div class="list-2">
            <div class="subm1 haveitems " style="">
                <ul>
                    <li >
                        {if $action == 'default'}
                            <a href="#" class="count_hidden_servers"><span>Show unoffered TLDs (<i>0</i>)</span></a>
                        {else}
                            <a href="?cmd=whoisservers"><span>Show TLDs</span></a>
                        {/if}
                    </li>
                    <li class="{if in_array($action, array('add', 'edit'))}active{/if}">
                        <a {if $action != 'add' }href="?cmd=whoisservers&action=add"{/if}><span>{if $action == 'edit'}{$entry.id|upper}{else}New TLD{/if}</span></a>
                    </li>
                    <li >
                        <a href="#" onclick="$('#confirm_lookup').trigger('show');return false;" ><span>Bulk update Lookup Engine</span></a>
                    </li>
                    <li >
                        <a href="#" onclick="$('#confirm_whois').trigger('show');return false;"><span>Bulk update Whois Engine</span></a>
                    </li>
                </ul>
            </div>
        </div>

    </div>
    <table class="whitetable" width="100%" cellspacing=0>
        <tr>
            <th style="width: 160px">TLD</th>
            <th>Host</th>
            <th  style="text-align: center">Lookop Engine</th>
            <th style="text-align: center">Whois Engine</th>
            <th>IANA DB</th>
            <th style="width: 160px"></th>
        </tr>
        {foreach from=$list item=server}
            <tr {if !$server.show} data-server-hidden style="display: none;" class="havecontrols" {else} class="havecontrols" {/if}>
                <td style="padding-left: 10px" {if !$server.show} class="server_hidden_name" {/if}>
                    <a name=".{$server.tld}"></a>
                    <a href="?cmd=whoisservers&action=edit&id={$server.tld|upper}">.{$server.tld|upper}</a>
                </td>
                <td {if !$server.show} class="server_hidden_name" {/if}>
                    {$server.server}
                </td>
                <td align="center">{if $server.lookup_engine >0}{$lookup_engines[$server.lookup_engine]}{elseif $server.lookup_engine == -1}Core: DNS{else}Core: Whois{/if}</td>
                <td align="center">{if $server.whois_engine}{$whois_engines[$server.whois_engine]}{else}Core{/if}</td>
                <td><a href="http://www.iana.org/domains/root/db/{$server.ptld}.html" target="_blank" rel="noreferrer nofollow noindex">IANA .{$server.tld|upper}</a></td>
                <td>
                    <div class="pull-right">
                        <a href="?cmd=whoisservers&action=edit&id={$server.tld|upper}" class="menuitm menu-auto">
                            <span style="color: red">{$lang.Edit}</span>
                        </a>
                        {if $server.file}
                            <a title="Remove custom definition" class="menuitm menu-auto" href="?cmd=whoisservers&action=delete&id={$server.tld}&security_token={$security_token}" onclick="return confirm('Are you sure you want to remove this entry?');">
                                <span class="delsth"></span>
                            </a>
                        {else}
                            <a title="Default whois entry" class="menuitm menu-auto disabled">
                                <span class="delsth"></span>
                            </a>
                        {/if}

                    </div>
                </td>
            </tr>
        {/foreach}
    </table>
</div>

{literal}
    <style>
        .server_hidden_name {
            opacity: .8;
            font-style: italic;
        }
    </style>
    <script>
        $(function () {
            var count = $('[data-server-hidden]').length;
            if (count) {
                $('.count_hidden_servers i').html(parseInt(count));
            } else {
                $('.count_hidden_servers i').html(parseInt(0));
            }
            $('.count_hidden_servers').on('click', function () {
                  $('[data-server-hidden]').toggle();
            });
        })
    </script>
{/literal}