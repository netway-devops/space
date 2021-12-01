<table width="100%" border="0" cellspacing="0" cellpadding="0" id="content_tb">
    <tbody>
        <tr>
            <td><h3>RV SSL Management</h3></td>
            <td  class="searchbox"></td>
        </tr>
        <tr>
            <td class="leftNav">
                {if $submenuList}
                    {foreach from=$submenuList item=menu}
                    <a href="?cmd={$cmd}&module={$module}&action={$menu.action}&security_token={$security_token}" class="tstyled">{$menu.name}</a>
                    {/foreach}
                {/if}
            </td>
            <td  valign="top" class="bordered">
                <div id="bodycont" >
                    <div class="blu">
                        <h1>Find Account(s) by Authority Order ID</h1>
                        <p>
                            <form action="?cmd={$cmd}&module={$module}&action=find_order&security_token={$security_token}" method="post" id="find_partner_id" >
                                <b>Authority Order ID:</b> <input name="partner_id" id="partner_id" value="{$partner_id}" />
                                <input type="submit" value="Find" style="font-weight:bold" />
                            </form>
                        </p>
                        {if $results}
                        <div class="right"><div class="pagination">Found {$cResults} Record(s)</div></div>
                        <div class="clear"></div>
                        <table cellspacing="0" cellpadding="3" border="0" width="100%" class="glike hover">
                            <tbody>
                                <tr>
                                    <th>Authority Order ID</th>
                                    <th>Account #</th>
                                    <th>Client Name</th>
                                    <th>SSL Product</th>
                                    <th>Authority Order State</th>
                                    <th>Account Status</th>
                                </tr>
                            </tbody>
                            <tbody id="updater">
                            {foreach from=$results item=row}
                                <tr>
                                    <td>{$row.symantec_order_id}</td>
                                    <td><a href="?cmd=accounts&action=edit&id={$row.accounts_id}&list=all">{$row.accounts_id}</a></td>
                                    <td><a href="?cmd=clients&action=show&id={$row.client_id}">{$row.firstname} {$row.lastname}</a></td>
                                    <td>{$row.ssl_name}</td>
                                    <td>
                                        {if !$row.partner_order_id}
                                            It's order with out automation.
                                        {else}
                                        {$row.symantec_status}
                                        {/if}
                                    </td>
                                    <td>{$row.status}</td>
                                </tr>
                            {/foreach}
                            </tbody>
                        </table>
                        <div class="clear"></div>
                        {/if}
                    </div>
                </div>
            </td>
        </tr>
    </tbody>
</table>