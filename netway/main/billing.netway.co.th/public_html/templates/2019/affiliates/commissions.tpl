{include file="affiliates/top_nav.tpl"}

<h5 class="my-5">{$lang.referals_t}</h5>

<section class="section-affiliates">
    <div class="table-responsive table-borders table-radius">
        <a href="{$ca_url}affiliates&amp;action=commissions" id="currentlist" style="display:none" updater="#updater"></a>
        <input type="hidden" value="{$totalpages}" name="totalpages2" id="totalpages">
        <input type="hidden" id="currentpage" value="0" />
        <table class="table position-relative stackable">
            <thead>
                <tr>
                    <th><a href="?cmd=affiliates&action=commissions&orderby=date_created|ASC" class="sortorder"><i class="material-icons size-sm sort-icon">unfold_more</i>{$lang.signupdate}</a></th>
                    <th><a href="?cmd=affiliates&action=commissions&orderby=total|ASC" class="sortorder"><i class="material-icons size-sm sort-icon">unfold_more</i>{$lang.services}</a></th>
                    <th><a href="?cmd=affiliates&action=commissions&orderby=commission|ASC" class="sortorder"><i class="material-icons size-sm sort-icon">unfold_more</i>{$lang.commission}</a></th>
                    <th><a href="?cmd=affiliates&action=commissions&orderby=paid|ASC" class="sortorder"><i class="material-icons size-sm sort-icon">unfold_more</i>{$lang.status}</a></th>
                </tr>
            </thead>
            <tbody id="updater">
                {include file="affiliates/ajax.commissions.tpl"}
            </tbody>
        </table>
    </div>
    {include file="components/pagination.tpl"}
</section>

