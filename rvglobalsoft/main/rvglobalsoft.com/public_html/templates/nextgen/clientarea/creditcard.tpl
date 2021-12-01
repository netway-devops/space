{*

Manage credit card on file, submit new credit card details

*}
{if $ccard.cardnum}
    <h2 class="bbottom">Credit card on file</h2>
            {/if}
<div class="p19">

            {if $ccard.cardnum}
            <h2></h2>
        <table width="100%" border="0"  cellspacing="0" class="table table-bordered">

            <tr><td align="right" width="160"><b>{$lang.cctype}</b></td><td>{$ccard.cardtype}</td></tr>
            <tr class="even"><td align="right"><b>{$lang.ccnum}</b></td><td>{$ccard.cardnum}</td></tr>
            <tr><td align="right"><b>{$lang.ccexpiry}</b></td><td>{$ccard.expdate}</td></tr>
            
        </table>

            <form action="" method="post" style="margin-bottom:0px;">
            {if $allow_storage}<a href="#newccdetails" data-toggle="modal" class="btn btn-info btn_add_new_card" >{$lang.changecc}</a>&nbsp; {/if}
            {if $allowremove}<input type="submit" name="removecard" value="{$lang.removecc}" onclick="return confirm('{$lang.removecc_confirm}')"  class="btn btn-danger"/>{/if}
        {securitytoken}</form>



            {else}
            <br/><br/>
            <center>{$lang.noccyet}
            <br/><br/>
                <div class="box-feature"><a href="#newccdetails" data-toggle="modal" class="btn_add_new_card"><span class="iconfont-plus-round iconfont-size5 silver" style=""></span></a>
                    <h1>{$lang.newcc}</h1>
                </div>
            </center>
            {/if}

    {if $gateway_redirect_url}
        <script>
            var url = "{$system_url}{$gateway_redirect_url}";
            {literal}
            $('.btn_add_new_card').click(function (e) {
                e.preventDefault();
                window.location.href = url;
            });
            {/literal}
        </script>
    {else}
        <div id="newccdetails" style="display:none" class="modal">
            <form action="" method="post" style="margin-bottom:0px;">

            <div class="modal-header">
                <a class="close-modal" data-dismiss="modal">×</a>
                <h3>{$lang.changeccdesc}</h3>
            </div>
            <div class="modal-body">
                <table width="100%" cellpadding="2">
                <tr><td width="150" >{$lang.cctype}</td><td>
                        <select name="cardtype">
                            {foreach from=$supportedcc item=cc}
                            <option>{$cc}</option>
                            {/foreach}
                        </select>
                    </td></tr>
                <tr><td >{$lang.ccnum}</td><td><input type="text" name="cardnum" size="25" /></td></tr>
                <tr><td >{$lang.ccexpiry}</td>
                    <td><input type="text" name="expirymonth" size="2" maxlength="2"  class="styled" style="width:30px;" /> /
                        <input type="text" name="expiryyear" size="2" maxlength="2"  class="styled" style="width:30px;"  /> (MM/YY)</td></tr>
            </table>
            </div>
            <div class="modal-footer">
                <a href="#" class="btn" data-dismiss="modal">{$lang.close}</a>
                <input type="submit" name="addcard" value="{$lang.savechanges}"  class="btn btn-info"/>
            </div>

        {securitytoken}
    </form>
            
        </div>
    {/if}
</div>