<section class="section-account-header">
    <h1>{$lang.userhistory}</h1>
</section>

{include file="clientarea/top_nav.tpl" nav_type="history"}

<section class="section-account">
    {if $notification}
        <div class="d-flex flex-row justify-content-between align-items-end">
            <div class="align-bottom">
                <h2 class="align-bottom break-word">{$notification.subject}</h2>
            </div>
        </div>
        <div class="content-view-details d-flex flex-row justify-content-between align-items-center">
            <span class="badges-group">
                <span class="badge badge-details">{$notification.date_added|dateformat:$date_format}</span>
                {if $notification.url}
                    <span class="badge badge-details">
                        {if $lang[$notification.rel_type]}{$lang[$notification.rel_type]}
                        {else}{$notification.rel_type}
                        {/if}
                        <a href="{$notification.url}">#{$notification.rel_id}</a>
                    </span>
                {/if}
            </span>
        </div>
        <div class="my-4">{$notification.body|httptohref|nl2br}</div>
    {else}
        <a href="{$ca_url}clientarea/portal_notifications/&checkall=1&security_token={$security_token}" class="btn btn-sm btn-secondary mb-4" >
            {$lang.markallasread}
        </a>
        <a href="{$ca_url}clientarea/portal_notifications/" id="currentlist" style="display:none" updater="#updater"></a>
        <input type="hidden" id="currentpage" value="0" />
        <div class="table-responsive table-borders table-radius">
            <table class="table notifications-table position-relative stackable">
                <thead>
                    <tr>
                        <th width="170"><a href="{$ca_url}clientarea&action=portal_notifications&orderby=date_added|ASC" data-sorter="orderby"  class="sortorder"><i class="material-icons size-sm sort-icon">unfold_more</i> {$lang.date}</a></th>
                        <th width="170"><a href="{$ca_url}clientarea&action=portal_notifications&orderby=subject|ASC" data-sorter="orderby"  class="sortorder"><i class="material-icons size-sm sort-icon">unfold_more</i> {$lang.subject}</a></th>
                        <th width="170"><a href="{$ca_url}clientarea&action=portal_notifications&orderby=rel_id|ASC" data-sorter="orderby"  class="sortorder"><i class="material-icons size-sm sort-icon">unfold_more</i> {$lang.relatedto}</a></th>
                    </tr>
                </thead>
                <tbody id="updater">
                    {include file='ajax/ajax.portal_notifications.tpl'}
                </tbody>
            </table>
        </div>
        {include file="components/pagination.tpl"}
    {/if}
</section>