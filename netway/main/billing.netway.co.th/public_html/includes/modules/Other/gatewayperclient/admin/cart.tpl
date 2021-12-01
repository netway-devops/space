{include file="navbar.tpl"}

<script src="{$moduleurl}js/scripts.js"></script>

<link rel="stylesheet" href="{$moduleurl}css/style.css">

<div style="padding:15px;">
    <form action="?cmd=gatewayperclient&action=cart&type=cart" method="POST">
        <table id="tableform" cellpadding="5" style="width: 100%">

            <tbody>
            <tr>
                <td>
                    <label><b>Enabled Payment Gateways</b></label>
                    <p class="small-descr">
                        Select payment gateways that will be available in cart if no other rule apply
                    </p>
                </td>
                <td>
                    {include file="moduleconfig.tpl"}
                </td>
            </tr>
            </tbody>
        </table>
        <input type="hidden" name="type" value="cart">
        <input type="hidden" name="make" value="save">
        <button type="submit" class="btn btn-success" style="margin-top: 20px;">{$lang.savechanges}</button>
        {securitytoken}
    </form>
</div>