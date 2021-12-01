{if $servers}
    {foreach from=$servers item=server}
        <li class="extendable  {if $tree[$server.id] == 1}open{/if} {if $server.private}private{/if}">
            <input type="hidden" name="tree[{$server.id}]" value="{$tree[$server.id]}" />
            <span class="extb" onclick="expand(this)" id="expandable_{$server.id}"></span>
            <span class="extt" onclick="groupDetails({$server.id})" >{$server.name}</span>
            <ul>
                {if is_array($server.sublist)}
                    {foreach from=$server.sublist item=entry}
                        <li class="extendable {if $tree[$entry.id] == 1}open{/if}">
                            <input type="hidden" name="tree[{$entry.id}]" value="{$tree[$entry.id]}" />
                            <span class="extb" onclick="expand(this)" id="expandable_{$entry.id}"></span>
                            <span class="extt" onclick="subDetails({$entry.id},{$server.id})">{$entry.name}</span>
                            <ul>
                                {foreach from=$entry.list item=ip}
                                    <li onclick="details(this,{$entry.id})">
                                        <span>{$ip}</span>
                                    </li>
                                {/foreach}
                            </ul>
                        </li>
                    {/foreach}
                {/if}
                {if is_array($server.list)}
                    {foreach from=$server.list item=entry}
                        <li onclick="details(this,{$server.id})">
                            <span>{$entry}</span>
                        </li>
                    {/foreach}
                {/if}
            </ul>
        </li>
    {/foreach}
{else}
    <li class="nothing">{$lang.nothingtodisplay}</li>
    <li class="nothing">Serched in:
        <ul>
            {foreach from=$options item=o key=name}
                <li>
                    {if $name == 'name'}List names
                    {elseif $name == 'ipaddress'}IP Address
                    {elseif $name == 'mask'}Netmasks
                    {elseif $name == 'domains'}Hostnames
                    {elseif $name == 'revdns'}Rev DNS
                    {elseif $name == 'descripton'}Descriptions
                    {elseif $name == 'lastupdate'}Last Update
                    {elseif $name == 'changedby'}Changed by
                    {elseif $name == 'flag'}With flag
                    {/if}
                </li>
            {/foreach}
        </ul>
    </li>
{/if}