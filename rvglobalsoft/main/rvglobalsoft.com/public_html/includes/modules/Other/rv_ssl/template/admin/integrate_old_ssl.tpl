<style>
{literal}
.tdcenter{
    text-align: center;
    padding: 3px 5px 3px 5px;
    margin: 0px;
}

.tdheader{
    font-weight: bold;
    background-color: #BBB;
}
table {
    border: none;
    border-collapse: collapse;
}

table td {
    border-left: 1px solid #000;
    border-right: 1px solid #000;
}

table td:first-child {
    border-left: none;
}

table td:last-child {
    border-right: none;
}

{/literal}
</style>
<table width="100%" border="0" cellspacing="0" cellpadding="0" id="content_tb">
    <tbody>
        <tr>
            <td><h3>RV SSL Management</h3></td>
            <td class="searchbox"></td>
        </tr>
        <tr>
            <td class="leftNav">
                {if $submenuList}
                    {foreach from=$submenuList item=menu}
                    <a href="?cmd={$cmd}&module={$module}&action={$menu.action}&security_token={$security_token}" class="tstyled">{$menu.name}</a>
                    {/foreach}
                {/if}
            </td>
            <td  valign="top">
                <div id="bodycont" >
                    <div class="blu">
                        <h1>Integrate Old SSL order{if isset($partnerOrderId)} : {$partnerOrderId}{/if}</h1>
                        <br />
                        {if isset($update)}
                            {if $update}
                                <font color="green">Update successful...</font>
                            {else}
                                <font color="red">Cannot update...</font>
                            {/if}
                        {/if}
                        {if isset($aData)}
                        <table>
                            <tr>
                                <td class="tdcenter tdheader">ID</td>
                                <td class="tdcenter tdheader">Order ID</td>
                                <td class="tdcenter tdheader">Account Status</td>
                                <td class="tdcenter tdheader">Domain</td>
                                <td class="tdcenter tdheader">Billing Cycle</td>
                                <td class="tdcenter tdheader">Next Due Date</td>
                                <td class="tdcenter tdheader">Partner Order ID</td>
                                <td class="tdcenter tdheader">Symantec Status</td>
                                <td class="tdcenter tdheader">Symantec Order ID</td>
                                <td class="tdcenter tdheader">Action</td>
                            </tr>
                            {foreach from=$aData item=eachData key=key}
                            <tr>
                                <td class="tdcenter"><a href="index.php?cmd=accounts&action=edit&id={$eachData.id}" target="_blank">{$eachData.id}</a></td>
                                <td class="tdcenter">{$eachData.order_id}</td>
                                <td class="tdcenter"><span class="{$eachData.status}">{$eachData.status}</span></td>
                                <td class="tdcenter">{$eachData.domain}</td>
                                <td class="tdcenter">{$eachData.billingcycle}</td>
                                <td class="tdcenter">{$eachData.next_due}</td>
                                <td class="tdcenter">{$eachData.partner_order_id}</td>
                                <td class="tdcenter">{$eachData.symantec_status}</td>
                                <td class="tdcenter">{$eachData.authority_orderid}</td>
                                <td class="tdcenter">
                                    <form action="#" method="POST">
                                        <input name="integrateId" type="hidden" value="{$eachData.id}" />
                                        <input name="partnerOrderId" type="hidden" value="{$partnerOrderId}" />
                                        <input name="orderId" type="hidden" value="{$eachData.order_id}" />
                                        <input name="clientId" type="hidden" value="{$eachData.client_id}" />
                                        <input type="submit" value="Integrate" />
                                    </form>
                                </td>
                            </tr>
                            {/foreach}
                        </table>
                        <br /><br />
                        {/if}
                        <form action="#" method="POST">
                            <table>
                                <tr>
                                    <td>Partner Order ID</td>
                                    <td>&nbsp;<input type="text" name="partnerOrderId" value="{$partnerOrderId}"/>&nbsp;&nbsp;<input type="submit" value="Get Data" /></td>                         
                                </tr>
                            </table>
                        </form>
                        {if isset($getorderResponse)}
                        <br /><br />
                        <div style="border: 1px solid green; background-color: white; padding-left: 30px;">
                            <pre>{$getorderResponse|@print_r}</pre>
                        </div>
                        <br /><br />
                        {/if}
                    </div>
                </div>
            </td>
        </tr>
    </tbody>
</table>