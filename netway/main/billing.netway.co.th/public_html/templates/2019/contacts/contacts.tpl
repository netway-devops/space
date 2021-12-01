<section class="section-account-header">
    <h1>{$lang.profiles}</h1>
</section>
<div class="d-flex justify-content-between align-items-center">
    <h5 class="my-4">{$lang.profileinfo}</h5>
    <a href="{$ca_url}profiles/add/" class="btn btn-sm btn-success">{$lang.addnewprofile} </a>
</div>
<section class="section-account">

    <a href="{$ca_url}profiles/" id="currentlist" style="display:none" updater="#updater"></a>
    <input type="hidden" id="currentpage" value="0" />
    <div class="table-responsive table-borders table-radius">
        <table class="table tickets-table position-relative stackable">
            <thead>
            <tr>
                <th><a href="{$ca_url}profiles/&orderby=firstname|ASC" data-sorter="orderby"><i class="material-icons size-sm sort-icon">unfold_more</i>{$lang.firstname} #</a></th>
                <th><a href="{$ca_url}profiles/&orderby=lastname|ASC" data-sorter="orderby"><i class="material-icons size-sm sort-icon">unfold_more</i>{$lang.lastname}</a></th>
                <th><a href="{$ca_url}profiles/&orderby=email|ASC" data-sorter="orderby"><i class="material-icons size-sm sort-icon">unfold_more</i> {$lang.email}</a></th>
                <th class="noncrucial"><a href="{$ca_url}profiles/&orderby=lastlogin|ASC" data-sorter="orderby"><i class="material-icons size-sm sort-icon">unfold_more</i>{$lang.lastlogin}</a></th>
                <th></th>
            </tr>
            </thead>
            <tbody id="updater">
                {include file='ajax.profiles.tpl'}
            </tbody>
        </table>
    </div>

    {include file="components/pagination.tpl"}

</section>

<section class="section-account-header billing-contact">
    <h1>{$lang.billing_contact}</h1>
</section>

<div class="d-flex justify-content-between align-items-center billing-contact">
    <h5 class="my-4">{$lang.billing_contact_descr}</h5>
</div>


<section class="billing-contact">
        <form class="form-horizontal" method="post">
            <input type="hidden" name="do" value="set_billing_contact"/>
            <div class="control-group">
                <label class="control-label" for="billing_contact">
                    <strong>
                        {$lang.billing_contact}
                    </strong>
                </label>
                <div class="controls">
                    <select id="billing_contact_id" name="billing_contact_id" class="form-control">
                        <option value="0" {if !$clientdata.billing_contact_id}selected{/if}>{$lang.billing_contact_none}</option>
                        {foreach from=$profiles item=p name=ff}
                            <option value="{$p.id}" {if $p.id == $clientdata.billing_contact_id}selected{/if}>{$p.firstname} {$p.lastname}</option>
                        {/foreach}

                    </select>
                </div>
            </div>
            <div class="d-flex flex-row justify-content-center align-items-center">
                <button type="submit" class="btn btn-primary btn-lg btn-w-100 btn-md-w-auto my-4" name="submit">{$lang.savechanges}</button>
            </div>
            {securitytoken}
        </form>
</section>

