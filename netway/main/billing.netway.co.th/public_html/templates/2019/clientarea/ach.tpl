{include file="components/billing_header.tpl"}

{include file="clientarea/top_nav.tpl" nav_type="billing"}

<section class="section-account">
    {if $ach.account}
        <div class="table-responsive table-borders table-radius">
            <table width="100%" border="0"  cellspacing="0" class="table">
                <tbody>
                <tr>
                    <td class="w-25">{$lang.type}</td>
                    <td>{$lang[$ach.type]}</td>
                </tr>
                <tr class="even">
                    <td class="w-25">{$lang.ach_account_number}</td>
                    <td>{$ach.account}</td>
                </tr>
                <tr>
                    <td class="w-25">{$lang.ach_routing_number}</td>
                    <td>{$ach.routing}</td>
                </tr>
                </tbody>
            </table>
        </div>
        <form action="" method="post" class="mt-4">
            {if $allow_storage}<a href="#newccdetails" data-toggle="modal" class="btn btn-primary" >{$lang.changeach}</a>&nbsp; {/if}
            {if $allowremove}
                <button type="submit" name="removeach" class="btn btn-danger confirm_js" data-confirm="{$lang.removeach_confirm}">{$lang.removeach}</button>
            {/if}
            {securitytoken}
        </form>
    {else}
        {$lang.noachyet}
        <hr>
        <a href="#newccdetails" class="btn btn-success" data-toggle="modal"><i class="icon-add"></i> {$lang.newach}</a>
    {/if}
    <div id="newccdetails" class="modal fade fade2" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <form action="" method="post">
                    <div class="modal-header">
                        <h4 class="modal-title font-weight-bold mt-2">{$lang.changeachdesc}</h4>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <i class="material-icons">cancel</i>
                        </button>
                    </div>
                    <div class="modal-body">
                        <input type="hidden" name="addach" value="1" />
                        <div class="table-responsive">
                            <table width="100%" cellpadding="2">
                                <tr>
                                    <td width="150" >{$lang.type}</td>
                                    <td>
                                        <select class="form-control" name="type">
                                            <option value="checkings">{$lang.checking}</option>
                                            <option value="savings">{$lang.savings}</option>
                                            <option value="business_checking">{$lang.business_checking}</option>
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <td >{$lang.ach_account_number}</td>
                                    <td><input class="form-control" type="text" name="account" size="25" /></td>
                                </tr>
                                <tr>
                                    <td >{$lang.ach_routing_number}</td>
                                    <td><input class="form-control" type="text" name="routing" size="25" /></td>
                                </tr>
                            </table>
                        </div>
                        {securitytoken}
                        <div class="w-100  mt-4">
                            <input type="hidden" name="addcard" value="1"/>
                            <button type="submit" class="btn btn-primary btn-lg w-100">{$lang.savechanges}</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</section>