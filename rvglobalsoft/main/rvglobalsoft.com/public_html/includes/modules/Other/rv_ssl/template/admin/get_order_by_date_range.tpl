<script type="text/javascript" src="{$system_url}{$ca_url}templates/netwaybysidepad/js/jquery.datetimepicker.js"></script>
<link rel="stylesheet" type="text/css" href="{$system_url}{$ca_url}templates/netwaybysidepad/css/jquery.datetimepicker.css"/ >
<script type="text/javascript">
    {literal}
    $('document').ready(function(){
        $('.date-pick').datetimepicker();
    });
    {/literal}
</script>
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
                        <h1>Get Orders By date Range</h1>
                        <br />
                        {if isset($fDate) && isset($tDate) && isset($orderFound)}
                            Got {$orderFound} order(s) from {$fDate} to {$tDate}
                            <br /><br />
                            {if $orderFound > 0}
                                <table>
                                    <tr>
                                        <th class="tdcenter tdheader">Domain Name</th>
                                        <th class="tdcenter tdheader">Partner Order ID</th>
                                        <th class="tdcenter tdheader">Authority Order ID</th>
                                        <th class="tdcenter tdheader">Order State</th>
                                        <th class="tdcenter tdheader">Product Code</th>
                                        <th class="tdcenter tdheader">Order Date</th>
                                        <th class="tdcenter tdheader">Action</th>
                                    </tr>
                                {foreach from=$aData.GetOrdersByDateRangeResult.OrderDetails.OrderDetail item=eachData}
                                    <tr>
                                        <td class="tdcenter">{$eachData.OrderInfo.DomainName}</td>
                                        <td class="tdcenter">{$eachData.OrderInfo.PartnerOrderID}</td>
                                        <td class="tdcenter">{$eachData.OrderInfo.GeoTrustOrderID}</td>
                                        <td class="tdcenter">{$eachData.OrderInfo.OrderState}</td>
                                        <td class="tdcenter">{$eachData.OrderInfo.ProductCode}</td>
                                        <td class="tdcenter">{$eachData.OrderInfo.OrderDate|date_format:"%d %b %Y %R:%S"}</td>
                                        <td class="tdcenter">
                                            <form action="#" method="POST">
                                                <input type="hidden" name="partnerOrderID" value="{$eachData.OrderInfo.PartnerOrderID}" />
                                                <input type="hidden" name="fDate" value="{$fDate}" />
                                                <input type="hidden" name="tDate" value="{$tDate}" />
                                                <input type="submit" value="Get Full Data" />
                                            </form>
                                        
                                        </td>
                                        
                                    </tr>
                                {/foreach}
                                </table> 
                            {/if}
                            <br /><br />
                        {elseif isset($oData)}
                            <strong>Data of {$oData.GetOrderByPartnerOrderIDResult.OrderDetail.OrderInfo.PartnerOrderID} :</strong>
                            <br /><br />
                            <div style="border: 1px solid green; background-color: white; padding-left: 30px;">
                                <pre>{$oData|@print_r}</pre>
                            </div>
                            <br /><br />
                        {/if}
                        <form action="#" method="POST">
                            <input type="hidden" name="maction" value="1" />
                            <table>
                                <tr>
                                    <td>From</td>
                                    <td>&nbsp;<input type="text" name="fDate" class="date-pick" value="{$fDate}"/></td>
                                </tr>
                                <tr>
                                    <td>To</td>
                                    <td>&nbsp;<input type="text" name="tDate" class="date-pick" value="{$tDate}"/></td>
                                </tr>
                                <tr>
                                    <td colspan="2"><br /><input type="submit" value="submit" /></td>
                                </tr>
                            </table>
                        </form>
                    </div>
                </div>
            </td>
        </tr>
        
    </tbody>
</table>