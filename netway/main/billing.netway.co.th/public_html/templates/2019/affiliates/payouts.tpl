{include file="affiliates/top_nav.tpl"}

<h5 class="my-5">{$lang.voucherinfo}</h5>

<section class="section-affiliates">
    <div class="table-responsive table-borders table-radius">
        <input type="hidden" id="currentpage" value="0" />
        <a href="{$ca_url}affiliates&amp;action=payouts" id="currentlist" style="display:none" updater="#updater"></a>
        <input type="hidden" value="{$totalpages}" name="totalpages2" id="totalpages">
        <table class="table position-relative stackable">
            <thead>
                <tr>
                    <th><a href="?cmd=affiliates&action=payouts&orderby=date|ASC" class="sortorder"><i class="material-icons size-sm sort-icon">unfold_more</i>{$lang.date}</a></th>
                    <th><a href="?cmd=affiliates&action=payouts&orderby=amount|ASC" class="sortorder"><i class="material-icons size-sm sort-icon">unfold_more</i>{$lang.withdrawn}</a></th>
                    <th><a href="?cmd=affiliates&action=payouts&orderby=note|ASC" class="sortorder"><i class="material-icons size-sm sort-icon">unfold_more</i>{$lang.note}</a></th>
                </tr>
            </thead>
            <tbody id="updater">
                {include file='affiliates/ajax.payouts.tpl'}
            </tbody>
        </table>
    </div>
    {include file="components/pagination.tpl"}
</section>
