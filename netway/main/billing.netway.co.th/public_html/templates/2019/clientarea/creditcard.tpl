{include file="components/billing_header.tpl"}

{include file="clientarea/top_nav.tpl" nav_type="billing"}

<section class="section-account">
    {if $ccard.cardnum}
        <div class="table-responsive table-borders table-radius">
            <table width="100%" border="0"  cellspacing="0" class="table">
                <tbody>
                <tr>
                    <td class="w-25">{$lang.cctype}</td>
                    <td>{$ccard.cardtype}</td>
                </tr>
                <tr class="even">
                    <td class="w-25">{$lang.ccnum}</td>
                    <td>{$ccard.cardnum}</td>
                </tr>
                <tr>
                    <td class="w-25">{$lang.ccexpiry}</td>
                    <td>{$ccard.expdate}</td>
                </tr>
                <tr>
                    <td class="w-25">{$lang.billing_contact}</td>
                    <td>{if $cadetails.firstname}{$cadetails.firstname} {$cadetails.lastname}{else}{$cadetails.companyname}{/if}  <a href="{$ca_url}profiles/">{$lang.change}</a></td>
                </tr>

                </tbody>
            </table>
        </div>
        <form action="" method="post" class="mt-4">
            {if $allow_storage}<a href="#newccdetails" data-toggle="modal" class="btn btn-primary btn_add_new_card" >{$lang.changecc}</a>&nbsp;{/if}
            {if $allowremove}<button class="btn btn-danger confirm_js" type="submit" name="removecard" data-confirm="{$lang.removecc_confirm}">{$lang.removecc}</button>{/if}
            {securitytoken}
        </form>
    {else}
        {$lang.noccyet}
        <hr>
        <a href="#newccdetails" class="btn btn-success btn_add_new_card" data-toggle="modal"><i class="icon-add"></i> {$lang.newcc}</a>
    {/if}
</section>

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
    <div id="newccdetails" class="modal fade fade2" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <form action="" method="post" novalidate>
                    <div class="modal-header">
                        <h4 class="modal-title font-weight-bold mt-2">{$lang.changeccdesc}</h4>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <i class="material-icons">cancel</i>
                        </button>
                    </div>
                    <div class="modal-body">
                        {include file="components/creditcard.tpl" need_ccv=$need_ccv}
                        {securitytoken}
                        <div class="w-100 mt-4">
                            <input type="hidden" name="addcard" value="1"/>
                            <button type="submit" class="btn btn-primary btn-lg w-100">{$lang.savechanges}</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
{/if}