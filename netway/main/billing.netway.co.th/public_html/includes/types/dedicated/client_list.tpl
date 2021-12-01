{if $custom_overrides.dedicated_client_list}
    {include file=$custom_overrides.dedicated_client_list}
{else}

    {if !$ajax}
    <a href="{$ca_url}clientarea&amp;action=services&amp;cid={$cid}" id="currentlist" style="display:none" updater="#updater"></a>
    <input type="hidden" id="currentpage" value="0" />
    <div class="bordered-section article"><a href="?cmd=clientarea&amp;action=services" id="currentlist" style="display:none" updater="#updater"></a>
        <table cellspacing="0" cellpadding="0" border="0" width="100%" class="styled table table-striped fullscreen stackable">
            <colgroup class="firstcol"></colgroup>

            <colgroup class="alternatecol"></colgroup>
            <colgroup class="firstcol"></colgroup>
            <colgroup class="alternatecol"></colgroup>
            <colgroup class="firstcol"></colgroup>
            <colgroup class="alternatecol"></colgroup>
            <thead>
                <tr>
                    <th>{$lang.service}</th>
                    <th width="70">{$lang.hostname}</th>
                    <th width="90">{$lang.ipadd}</th>


                    <th width="119">{$lang.status}</th>
                    <th width="150">{$lang.nextdue}</th>
                    <th width="20"></th>
                </tr>
            </thead>
            <tbody id="updater">
    {/if}
                {foreach from=$services item=service name=foo}
                <tr {if $smarty.foreach.foo.index%2 == 0}class="even"{/if}>
                    <td>
                        <a  href="?cmd=clientarea&amp;action={$action}&amp;service={$service.id}">
                            <div class="left">
                                <strong>{$service.name}</strong>
                            </div>

                            {if $service.tags}
                                <div class="right">
                                    {foreach from=$service.tags item=tag}
                                        <span class="label label-success fs11 ">{$tag}</span>
                                    {/foreach}
                                </div>
                            {/if}
                            <span class="clear"></span>
                        </a>
                    </td>
                    <td><a href="?cmd=clientarea&amp;action={$action}&amp;service={$service.id}" style="text-decoration:none">{$service.domain}</a> </td>
                    <td align="center text-left text-md-center">{if $service.ip && $service.ip!='0.0.0.0'}{$service.ip}{else}-{/if}</td>
                    <td ><span class="{$service.status} label label-{$service.status}">{$lang[$service.status]}</span></td>
                    <td >{if $service.next_due!=0}{$service.next_due|dateformat:$date_format}{else}-{/if}</td>
                    <td align="center text-left text-md-center"><a href="?cmd=clientarea&amp;action={$action}&amp;service={$service.id}" class="view3">{$lang.view}</a></td>
                </tr>
                {/foreach}
    {if !$ajax}
            </tbody>
        </table>
    </div>
    {/if}
{/if}