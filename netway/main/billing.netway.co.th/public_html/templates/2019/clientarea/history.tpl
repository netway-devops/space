<section class="section-account-header">
    <h1>{$lang.userhistory}</h1>
</section>

{include file="clientarea/top_nav.tpl" nav_type="history"}

<h5 class="my-5">{$lang.accountlogssectionhistory}</h5>

<section class="section-account">
    <a href="{$ca_url}clientarea/history/" id="currentlist" style="display:none" updater="#updater"></a>
    <input type="hidden" id="currentpage" value="0" />
    <div class="table-responsive table-borders table-radius">
        <table class="table tickets-table position-relative stackable">
            <thead>
                <tr>
                    <th><a href="{$ca_url}clientarea&action=history&orderby=date|ASC"  class="sortorder"><i class="material-icons size-sm sort-icon">unfold_more</i>{$lang.date}</a></th>
                    <th class="w-50"><a href="{$ca_url}clientarea&action=history&orderby=description|ASC" class="sortorder"><i class="material-icons size-sm sort-icon">unfold_more</i>{$lang.Description}</a></th>
                    <th><a href="{$ca_url}clientarea&action=history&orderby=result|ASC"  class="sortorder"><i class="material-icons size-sm sort-icon">unfold_more</i>{$lang.status}</a></th>
                    <th></th>
                </tr>
            </thead>
            <tbody id="updater">
                {include file='ajax/ajax.history.tpl'}
            </tbody>
        </table>
    </div>
    {include file="components/pagination.tpl"}
</section>
