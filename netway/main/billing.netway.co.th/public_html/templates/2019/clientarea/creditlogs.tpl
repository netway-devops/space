<section class="section-account-header">
    <h1>{$lang.userhistory}</h1>
</section>

{include file="clientarea/top_nav.tpl" nav_type="history"}

<section class="section-account">
    <a href="{$ca_url}clientarea/creditlogs/" id="currentlist" style="display:none" updater="#updater"></a>
    <input type="hidden" id="currentpage" value="0" />
    <div class="table-responsive table-borders table-radius">
        <table class="table tickets-table position-relative stackable">
            <thead>
                <tr>
                    <th><a href="{$ca_url}clientarea&action=creditlogs&orderby=date|ASC"  class="sortorder"><i class="material-icons size-sm sort-icon">unfold_more</i>{$lang.date}</a></th>
                    <th class="w60"><a href="{$ca_url}clientarea&action=creditlogs&orderby=description|ASC" class="sortorder"><i class="material-icons size-sm sort-icon">unfold_more</i>{$lang.Description}</a></th>
                    <th><a href="{$ca_url}clientarea&action=creditlogs&orderby=in|ASC"  class="sortorder"><i class="material-icons size-sm sort-icon">unfold_more</i>{$lang.increase}</a></th>
                    <th><a href="{$ca_url}clientarea&action=creditlogs&orderby=out|ASC"  class="sortorder"><i class="material-icons size-sm sort-icon">unfold_more</i>{$lang.decrease}</a></th>
                    <th><a href="{$ca_url}clientarea&action=creditlogs&orderby=balance|ASC"  class="sortorder"><i class="material-icons size-sm sort-icon">unfold_more</i>{$lang.creditafter}</a></th>
                    <th><a href="{$ca_url}clientarea&action=creditlogs&orderby=invoice_id|ASC"  class="sortorder"><i class="material-icons size-sm sort-icon">unfold_more</i>{$lang.related_invoice}</a></th>
                </tr>
            </thead>
            <tbody id="updater">
                {include file='ajax/ajax.creditlogs.tpl'}
            </tbody>
        </table>
    </div>
    {include file="components/pagination.tpl"}
</section>