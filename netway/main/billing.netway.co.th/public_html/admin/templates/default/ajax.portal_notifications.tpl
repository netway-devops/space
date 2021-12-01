{if $action=='clientnotifications'}
    <div class="quicklist_logs">
        {include file='_common/quicklists_logs.tpl' active='portal_notifications' client_id=$client_id}
        {if $notifications}
            <table cellspacing="0" cellpadding="3" border="0" width="100%" class="table glike hover">
                <tbody>
                    <tr>
                        <th><a href="?cmd=portal_notifications&action=clientnotifications&id={$client_id}&orderby=subject|ASC" data-orderby="subject"  class="sortorder">{$lang.Subject}</a></th>
                        <th><a href="?cmd=portal_notifications&action=clientnotifications&id={$client_id}&orderby=client_id|ASC" data-orderby="client_id"  class="sortorder">Sended to</a></th>
                        <th width="170"><a href="?cmd=portal_notifications&action=clientnotifications&id={$client_id}&orderby=rel_type|ASC" data-orderby="rel_type"  class="sortorder">Relation Type</a></th>
                        <th width="170"><a href="?cmd=portal_notifications&action=clientnotifications&id={$client_id}&orderby=rel_id|ASC" data-orderby="rel_id"  class="sortorder">Relation Item</a></th>
                        <th><a href="?cmd=portal_notifications&action=clientnotifications&id={$client_id}&orderby=type|ASC" data-orderby="type"  class="sortorder">Type</a></th>
                        <th width="170"><a href="?cmd=portal_notifications&action=clientnotifications&id={$client_id}&orderby=date_added|ASC" data-orderby="date_added"  class="sortorder">{$lang.Date}</a></th>
                        <th width="170"><a href="?cmd=portal_notifications&action=clientnotifications&id={$client_id}&orderby=seen|ASC" data-orderby="seen"  class="sortorder">Seen</a></th>
                    </tr>
                </tbody>
                <tbody>
                {foreach from=$notifications item=item}
                    <tr>
                        <td><a href="?cmd=portal_notifications&action=show&id={$item.id}">{$item.subject}</a></td>
                        <td><a href="?cmd=clients&action=show&id={$item.client_id}">#{$item.client_id} {$item.firstname} {$item.lastname}</a></td>
                        <td>
                            {$item.rel_type|capitalize}
                        </td>
                        <td>
                            {if $item.url} <a href="{$item.url}">#{$item.rel_id}</a>
                            {elseif $item.rel_type && $item.rel_id} {$item.rel_id}
                            {else} -
                            {/if}
                        </td>
                        <td>
                            {$item.type|capitalize}
                        </td>
                        <td>{$item.date_added|dateformat:$date_format}</td>
                        <td>{if $item.seen}<span class="Successfull">Yes</span> ({$item.date_seen|dateformat:$date_format}){else}<span class="Failure">No</span>{/if}</td>
                    </tr>
                {/foreach}
                </tbody>
            </table>
            <div class="text-right" style="margin: 10px 0px;">
                <div style="display:inline-block">
                    <strong>{$lang.records_per_page}</strong>
                    <select name="notify_per_page" id="notify_per_page{$currentlist}">
                        <option value="10" {if $notify_per_page == 10}selected{/if}>10</option>
                        <option value="20" {if $notify_per_page == 20}selected{/if}>20</option>
                        <option value="50" {if $notify_per_page == 50}selected{/if}>50</option>
                        <option value="100" {if $notify_per_page == 100}selected{/if}>100</option>
                        <option value="100000" {if $notify_per_page == 100000}selected{/if}>All</option>
                    </select>
                </div>
                <div style="display:inline-block">
                    <center class="paginercontainer" >
                        <strong>{$lang.Page} </strong>
                        {section name=foo loop=$totalpages}
                            <a href='?cmd=portal_notifications&action=clientnotifications&id={$client_id}&page={$smarty.section.foo.iteration-1}' class="npaginer
                           {if $smarty.section.foo.iteration-1==$currentpage}
                               currentpage
                           {/if}"
                            >{$smarty.section.foo.iteration}</a>
                        {/section}
                    </center>
                </div>
                <div class="clear"></div>
            </div>
        {else}
            <strong>{$lang.nothingtodisplay}</strong>
        {/if}
        {literal}
            <script>
                function change_tab(link) {
                    $.post(link, false, function (result) {
                        $('.quicklist_logs').html(result);
                        pagination();
                    });
                }
            </script>
        {/literal}
        {if $notifications}
            <script>
                {literal}
                $(function () {
                    pagination();
                });
                function pagination() {
                    $('.paginercontainer', 'div.slide:visible').infinitepages();
                    FilterModal.bindsorter('{/literal}{$orderby.orderby}', '{$orderby.type}'{literal});
                }

                $('#notify_per_page{/literal}{$currentlist}{literal}').on('change', function () {
                    var form_client = {
                        notify_per_page: $(this).val(),
                        currentlist: {/literal}'{$currentlist}'{literal}
                    };
                    ajax_update("?cmd=portal_notifications&action=clientnotifications&id={/literal}{$client_id}{literal}", form_client, $('div.slide:visible'), true);
                });
                {/literal}
            </script>
        {/if}
    </div>
{elseif $action=='getadvanced'}
    <a href="?cmd=portal_notifications&resetfilter=1"  {if $currentfilter}style="display:inline"{/if}  class="freseter">{$lang.filterisactive}</a>
    <form class="searchform filterform" action="?cmd=portal_notifications" method="post" onsubmit="return filter(this)">
        {include file="_common/filters.tpl"}
        {securitytoken}
    </form>
    <script type="text/javascript">bindFreseter();</script>
{elseif $action=='show'}
    <table class="table" style="table-layout: fixed;">
        <tr>
            <td width="10%"><b>To</b></td>
            <td><a href="?cmd=clients&action=show&id={$notification.client_id}">#{$notification.client_id} {$notification.firstname} {$notification.lastname}</a></td>
        </tr>
        <tr>
            <td width="10%"><b>Date created</b></td>
            <td>{$notification.date_added|dateformat:$date_format}</td>
        </tr>
        <tr>
            <td width="10%"><b>{$lang.reltype}</b></td>
            <td>
                {if $notification.rel_type}
                    {if $lang[$notification.rel_type]}{$lang[$notification.rel_type]}
                    {else}{$notification.rel_type}
                    {/if}
                {else}
                    -
                {/if}
            </td>
        </tr>
        <tr>
            <td width="10%"><b>{$lang.relid}</b></td>
            <td>
                {if $notification.url} <a href="{$notification.url}">#{$notification.rel_id}</a>
                {elseif $notification.rel_type && $notification.rel_id} {$notification.rel_id}
                {else} -
                {/if}
            </td>
        </tr>
        <tr>
            <td width="10%"><b>{$lang.Subject}</b></td>
            <td>{$notification.subject}</td>
        </tr>
        <tr>
            <td width="10%"><b>Seen</b></td>
            <td>{if $notification.seen} <span style="color: green;">Yes</span> ({$notification.date_seen|dateformat:$date_format}) {else}No{/if}</td>
        </tr>
        <tr>
            <td width="10%"><b>Body</b></td>
            <td>{if $notification.body} {$notification.body} {else} - {/if}</td>
        </tr>
    </table>
{elseif $action=='default'}
    {if $notifications}
        {if $showall}
            <form action="" method="post" id="testform" ><input type="hidden" value="{$totalpages}" name="totalpages2" id="totalpages"/>
            <div class="blu">
                <div class="right"><div class="pagination"></div>
                </div>
                <div class="clear"></div>
            </div>
            <a href="?cmd=portal_notifications" id="currentlist" style="display:none" updater="#updater"></a>
            <table cellspacing="0" cellpadding="3" border="0" width="100%" class="table glike hover" style="table-layout: fixed;">
            <tbody>
                <tr>
                    <th><a href="?cmd=portal_notifications&orderby=subject|ASC"  class="sortorder">{$lang.Subject}</a></th>
                    <th><a href="?cmd=portal_notifications&orderby=client_id|ASC"  class="sortorder">Sended to</a></th>
                    <th width="170"><a href="?cmd=portal_notifications&orderby=rel_type|ASC"  class="sortorder">Relation Type</a></th>
                    <th width="170"><a href="?cmd=portal_notifications&orderby=rel_id|ASC"  class="sortorder">Relation Item</a></th>
                    <th><a href="?cmd=portal_notifications&orderby=type|ASC"  class="sortorder">Type</a></th>
                    <th width="170"><a href="?cmd=portal_notifications&orderby=date_added|ASC"  class="sortorder">{$lang.Date}</a></th>
                    <th width="170"><a href="?cmd=portal_notifications&orderby=seen|ASC"  class="sortorder">Seen</a></th>
                </tr>
            </tbody>
            <tbody id="updater">
        {/if}
        {foreach from=$notifications item=item}
            <tr>
                <td><a href="?cmd=portal_notifications&action=show&id={$item.id}">{$item.subject}</a></td>
                <td><a href="?cmd=clients&action=show&id={$item.client_id}">#{$item.client_id} {$item.firstname} {$item.lastname}</a></td>
                <td>
                    {$item.rel_type|capitalize}
                </td>
                <td>
                    {if $item.url} <a href="{$item.url}">#{$item.rel_id}</a>
                    {elseif $item.rel_type && $item.rel_id} {$item.rel_id}
                    {else} -
                    {/if}
                </td>
                <td>
                    {$item.type|capitalize}
                </td>
                <td>{$item.date_added|dateformat:$date_format}</td>
                <td>{if $item.seen}<span class="Successfull">Yes</span> ({$item.date_seen|dateformat:$date_format}){else}<span class="Failure">No</span>{/if}</td>
            </tr>
        {/foreach}
        {if $showall}
            </tbody>
            <tbody id="psummary">
            <tr>
                <th colspan="7">
                    {$lang.showing} <span id="sorterlow">{$sorterlow}</span> - <span id="sorterhigh">{$sorterhigh}</span> {$lang.of} <span id="sorterrecords">{$sorterrecords}</span>
                </th>
            </tr>
            </tbody>
            </table>
            <div class="blu">
                <div class="right"><div class="pagination"></div>
                </div>
                <div class="clear"></div>
            </div>
            {securitytoken}</form>
        {/if}
    {else}
        {if $showall}
            <p class="blu"> {$lang.nothingtodisplay} </p>
        {else}
            <tr>
                <td colspan="5"><p align="center" >{$lang.nothingtodisplay}</p></td>
            </tr>
        {/if}
    {/if}
{/if}
