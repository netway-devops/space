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
                        <h1>Rate Exchange</h1>
                        <form action="?cmd={$cmd}&module={$module}&action=edit_rate_exchange&security_token={$security_token}" method="post" id="find_partner_id" >
                        
                        
                        <table cellspacing="0" cellpadding="3" border="0" width="100%" class="glike hover">
                            <tbody>
                                <tr>
                                    <th width="10%">Code</th>
                                    <th width="30%">Currency</th>
                                    <th width="10%">Rate Pre USD</th>
                                    <th></th>
                                </tr>
                            </tbody>
                            <tbody id="updater">
                            {foreach from=$aCurrency item=Currency}
                                {if $Currency.code != 'USD'}
                                <tr>
                                    <td>{$Currency.code}</td>
                                    <td>{$Currency.currency}</td>
                                    <td><input name="rate[{$Currency.code}]" class="inp" value="{$Currency.rate}" /></td>
                                    <td></td>
                                </tr>
                                {/if}
                            {/foreach}
                            </tbody>
                        </table>
                        <div class="clear"></div>
                            <div class="blu">
                            <div class="right"><div class="pagination"></div></div>
                            <div class="left menubar"><b>Action:</b>
                                <input type="hidden" name="do_edit" value="do_edit" />
                                <input type="submit" name="submit" value="Submit" />  <input type="reset" name="reset" value="Reset" />
                            </div>
                            <div class="clear"></div>
                            </div>
                        </form>
                    </div>
                </div>
            </td>
        </tr>
    </tbody>
</table>