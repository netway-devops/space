{if $action=='cactivity'}
    <div class="quicklist_logs">
        {include file='_common/quicklists_logs.tpl' active='clientactivity' client_id=$client_id}
        {if $logs}
            <table cellspacing="0" cellpadding="3" border="0" width="100%" class="table glike hover">
                <tbody>
                    <tr>
                        <th width="150"><a href="?cmd=clientactivity&action=cactivity&id={$client_id}&orderby=lastname|ASC" data-orderby="lastname"  class="sortorder">{$lang.Client}</a></th>
                        <th width="150"><a href="?cmd=clientactivity&action=cactivity&id={$client_id}&orderby=date|ASC" data-orderby="date"  class="sortorder">{$lang.Date}</a></th>
                        <th ><a href="?cmd=clientactivity&action=cactivity&id={$client_id}&orderby=description|ASC" data-orderby="description"  class="sortorder">{$lang.Action}</a></th>
                        <th width="150"><a href="?cmd=clientactivity&action=cactivity&id={$client_id}&orderby=ip|ASC" data-orderby="ip"  class="sortorder">IP</a></th>
                        <th width="150"><a href="?cmd=clientactivity&action=cactivity&id={$client_id}&orderby=admin_name|ASC" data-orderby="admin_name"  class="sortorder">Logged staff</a></th>
                    </tr>
                </tbody>
                <tbody >
                {foreach from=$logs item=log}
                    <tr>
                        <td><a href="?cmd=clients&action=show&id={$log.client_id}">{$log.firstname} {$log.lastname}</a> {if $log.parent_id}(Contact){/if}</td>
                        <td>{$log.date|dateformat:$date_format}</td>
                        <td>{$log.description}</td>
                        <td>{$log.ip}</td>
                        <td>{$log.admin_name}</td>
                    </tr>
                {/foreach}
                </tbody>
            </table>
        {if $totalpages}
            <div class="text-right" style="margin: 10px 0px;">
                <div style="display:inline-block">
                    <strong>{$lang.records_per_page}</strong>
                    <select name="activity_per_page" id="activity_per_page{$currentlist}">
                        <option value="10" {if $activity_per_page == 10}selected{/if}>10</option>
                        <option value="20" {if $activity_per_page == 20}selected{/if}>20</option>
                        <option value="50" {if $activity_per_page == 50}selected{/if}>50</option>
                        <option value="100" {if $activity_per_page == 100}selected{/if}>100</option>
                        <option value="100000" {if $activity_per_page == 100000}selected{/if}>All</option>
                    </select>
                </div>
                <div style="display:inline-block">
                    <center class=" paginercontainer" >
                        <strong>{$lang.Page} </strong>
                        {section name=foo loop=$totalpages}
                            <a href='?cmd=clientactivity&action=cactivity&id={$client_id}&page={$smarty.section.foo.iteration-1}' class="npaginer
                    {if $smarty.section.foo.iteration-1==$currentpage}
                    currentpage
                    {/if}"
                            >{$smarty.section.foo.iteration}</a>
                        {/section}
                    </center>
                </div>
                <div class="clear"></div>
            </div>
            <script> $('.paginercontainer','div.slide:visible').infinitepages();
                FilterModal.bindsorter('{$orderby.orderby}','{$orderby.type}');
                {literal}
                $('#activity_per_page{/literal}{$currentlist}{literal}').on('change', function () {
                    var form_client = {
                        activity_per_page: $(this).val(),
                        currentlist: {/literal}'{$currentlist}'{literal}
                    };
                    ajax_update("?cmd=clientactivity&action=cactivity&id={/literal}{$client_id}{literal}", form_client, $('div.slide:visible'), true);
                });
                {/literal}
            </script>
        {/if}
        {else}
            <strong>{$lang.nothingtodisplay}</strong>
        {/if}
    </div>
{elseif $action=='getadvanced'}
    <a href="?cmd=clientactivity&resetfilter=1"  {if $currentfilter}style="display:inline"{/if}  class="freseter">{$lang.filterisactive}</a>
    <form class="searchform filterform" action="?cmd=clientactivity" method="post" onsubmit="return filter(this)">
        {include file="_common/filters.tpl"}
        {securitytoken}
    </form>
    <script type="text/javascript">bindFreseter();</script>
{/if}
