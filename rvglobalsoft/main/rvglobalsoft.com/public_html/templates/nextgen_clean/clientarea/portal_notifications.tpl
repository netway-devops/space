{*
Browse notifications related to client
*}
<div class="bordered-section article">
    {if $notification}
        <h2>{$notification.subject}</h2>
        <div class="brcrm">
            <span class="annoucement_date left"><i class="icon-time"></i> {$lang.sent} {$notification.date_added|dateformat:$date_format}</span>
            <a href="{$ca_url}clientarea/portal_notifications/"  class="btn btn-mini right"><i class="icon-chevron-left"></i> {$lang.back}</a>
            <div class="clear"></div>
        </div>
        <div class="p19">
            <p >{$notification.body|httptohref}</p>
        </div>
    {else}
        <div class="spacing">
            <h2>{$lang.Notifications}</h2>
            <div class="table-box m15 overflow-h">
                <div class="table-header">
                </div>
                <a href="{$ca_url}clientarea&action=portal_notifications" id="currentlist" style="display:none" updater="#updater"></a>
                <input type="hidden" id="currentpage" value="0" />
                <table class="table table-bordered table-striped ">
                    <thead>
                    <tr>
                        <th width="170"><a href="{$ca_url}clientarea&action=portal_notifications&orderby=date_added|ASC"  class="sortorder"><i class="icon-sort"></i> {$lang.date}</a></th>
                        <th width="170"><a href="{$ca_url}clientarea&action=portal_notifications&orderby=subject|ASC"  class="sortorder"><i class="icon-sort"></i> {$lang.subject}</a></th>
                        <th width="170"><a href="{$ca_url}clientarea&action=portal_notifications&orderby=rel_id|ASC"  class="sortorder"><i class="icon-sort"></i> {$lang.relatedto}</a></th>
                    </tr>
                    </thead>
                    <tbody id="updater">
                    {include file='ajax/ajax.portal_notifications.tpl'}
                    </tbody>
                </table>
            </div>
        </div>
        <div class="clear"></div>
        <div class="right p19 pt0">
            <div class="pagelabel left ">{$lang.page}</div>
            <div class="btn-group right" data-toggle="buttons-radio" id="pageswitch">
                {section name=foo loop=$totalpages}
                    <button class="btn {if $smarty.section.foo.iteration==1}active{/if}">{$smarty.section.foo.iteration}</button>
                {/section}
            </div>
            <input type="hidden" id="currentpage" value="0" />
        </div>
        <div class="clear"></div>
    {/if}
</div>
