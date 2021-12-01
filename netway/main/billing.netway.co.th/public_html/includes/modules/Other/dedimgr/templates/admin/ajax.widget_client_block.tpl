{if $items}
    <table cellspacing="0" cellpadding="3" border="0" width="100%" class="table glike hover" style="margin-top: 25px;">
        <tbody>
        <tr>
            <th><a href="?cmd={$module}&action=client_items&client={$client_id}" class="sortorder" data-orderby="id">ID</a></th>
            <th><a href="?cmd={$module}&action=client_items&client={$client_id}" class="sortorder" data-orderby="label">Label</a></th>
            <th><a href="?cmd={$module}&action=client_items&client={$client_id}" class="sortorder" data-orderby="category">Item Category</a></th>
            <th><a href="?cmd={$module}&action=client_items&client={$client_id}" class="sortorder" data-orderby="type">Item Type</a></th>
            <th><a href="?cmd={$module}&action=client_items&client={$client_id}" class="sortorder" data-orderby="colocation">Colocation</a></th>
            <th><a href="?cmd={$module}&action=client_items&client={$client_id}" class="sortorder" data-orderby="rack">Rack</a></th>
            <th><a href="?cmd={$module}&action=client_items&client={$client_id}" class="sortorder" data-orderby="position">Position</a></th>
        </tr>
        </tbody>
        <tbody >
        {foreach from=$items item=item}
            <tr>
                <td><a href="?cmd=dedimgr&do=itemeditor&item_id={$item.id}">{$item.id}</a></td>
                <td>{$item.label}</td>
                <td><a href="?cmd=dedimgr&do=inventory&subdo=category&category_id={$item.category_id}">{$item.category}</a></td>
                <td><a href="?cmd=dedimgr&do=inventory&subdo=category&category_id={$item.category_id}&part=itemconfig&item_id={$item.type_id}">{$item.type}</a></td>
                <td><a href="?cmd=dedimgr&do=floors&colo_id={$item.colocation_id}">{$item.colocation}</a></td>
                <td><a href="?cmd=dedimgr&do=rack&rack_id={$item.rack_id}">{$item.rack}</a></td>
                <td>{$item.position}</td>
            </tr>
        {/foreach}
        </tbody>
    </table>
    {if $totalpages}
        <div class="text-center" style="margin-top: 10px;">
            <div style="display:inline-block">
                <strong>{$lang.records_per_page}</strong>
                <select name="dcim_per_page" id="dcim_per_page">
                    <option value="10" {if $dcim_per_page == 10}selected{/if}>10</option>
                    <option value="20" {if $dcim_per_page == 20}selected{/if}>20</option>
                    <option value="50" {if $dcim_per_page == 50}selected{/if}>50</option>
                    <option value="100" {if $dcim_per_page == 100}selected{/if}>100</option>
                    <option value="100000" {if $dcim_per_page == 100000}selected{/if}>All</option>
                </select>
            </div>
            <div style="display:inline-block">
                <center class="blu paginercontainer" >
                    <strong>{$lang.Page} </strong>
                    {section name=foo loop=$totalpages}
                        <a href='?cmd={$module}&action=client_items&client={$client_id}&page={$smarty.section.foo.iteration-1}' class="npaginer
                               {if $smarty.section.foo.iteration-1==$currentpage}
                                   currentpage
                               {/if}"
                        >{$smarty.section.foo.iteration}</a>
                    {/section}
                </center>
            </div>
        </div>
        <script>
            $('.paginercontainer', 'div.slide:visible').infinitepages();
            FilterModal.bindsorter('{$orderby.orderby}', '{$orderby.type}');
            {literal}
            $('#dcim_per_page').on('change', function () {
                var form_client = {dcim_per_page: $(this).val()};
                ajax_update("?cmd={/literal}{$module}{literal}&action=client_items&client={/literal}{$client_id}{literal}", form_client, $('div.slide:visible'), true);
            });
            {/literal}
        </script>
    {/if}
{else}
    <p style="text-align: center; margin-top: 25px;">
        {$lang.nothingtodisplay}
    </p>
{/if}