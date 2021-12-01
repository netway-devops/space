
<div class="row">
    <div class="span12">
        <p>Please specify an IP Address in the following field.</p>
        <table class="table">
        <tbody>
            <tr>
                <td>IP Address</td>
                <td>
                    <input type="hidden" id="product" name="product" value="cpanel" />
                    <input type="hidden" id="productId" name="product_id" value="0" />
                    <input type="hidden" name="order_type" value="Register" />
                    <input type="text" id="ipaddress" name="ipaddress" value="" onchange="verifyProductLicense('cpanel', this.value);" placeholder="Require IP Address" />
                </td>
                <td>
                    <div id="verify"><img src="{$system_url}templates/netwaybysidepad/img/ajax-loading2.gif" align="left" /> &nbsp; Validating the IP Address</div>
                </td>
            </tr>
            <tr class="verifyMessage">
                <td></td>
                <td>
                    <div id="verifyMessage"></div>
                </td>
                <td></td>
            </tr>
            <tr class="orderType">
                <td>Order type</td>
                <td colspan="2">
                    <div id="orderType"></div>
                </td>
            </tr>
            <tr class="serverType">
                <td>Server type</td>
                <td colspan="2">
                    <label><input type="radio" name="server_type" value="VPS" onclick="getBillingCycle()" /> VPS</label>
                    <span>&nbsp;&nbsp;&nbsp;</span>
                    <label><input type="radio" name="server_type" value="Dedicated" onclick="getBillingCycle()" /> Dedicated</label>
                </td>
            </tr>
            <tr class="billingCycle">
                <td>Billng cycle</td>
                <td>
                    <select name="billing_cycle" id="billingCycle" onchange="changeBillingCycle();">
                    </select>
                </td>
                <td></td>
            </tr>
            <tr><td colspan="3"></td></tr>
        </tbody>
        </table>
    </div>

</div>


