{include file="components/billing_header.tpl"}

{include file="clientarea/top_nav.tpl" nav_type="billing"}

<section class="section-invoices">
    <a href="{$ca_url}clientarea/estimates/" id="currentlist" style="display:none" updater="#updater"></a>
    <input type="hidden" id="currentpage" value="0" />
    <div class="table-responsive table-borders table-radius">
        <table class="table invoices-table position-relative stackable">
            <thead>
            <tr>
                <th><a href="{$ca_url}clientarea&amp;action=estimates&amp;orderby=status|ASC" data-sorter="orderby"><i class="material-icons size-sm sort-icon">unfold_more</i>{$lang.status}</a></th>
                <th><a href="{$ca_url}clientarea&amp;action=estimates&amp;orderby=id|ASC"  data-sorter="orderby"><i class="material-icons size-sm sort-icon">unfold_more</i>{$lang.Estimate}</a></th>
                <th><a href="{$ca_url}clientarea&amp;action=estimates&amp;orderby=total|ASC"  data-sorter="orderby"><i class="material-icons size-sm sort-icon">unfold_more</i>{$lang.total}</a></th>
                <th><a href="{$ca_url}clientarea&amp;action=estimates&amp;orderby=date_expires|ASC"  data-sorter="orderby"><i class="material-icons size-sm sort-icon">unfold_more</i>{$lang.expiration_date}</a></th>
                <th  class="noncrucial"></th>
            </tr>
            </thead>
            <tbody id="updater">
            {include file='ajax/ajax.estimates.tpl'}
            </tbody>
        </table>
    </div>

    {include file="components/pagination.tpl"}

</section>