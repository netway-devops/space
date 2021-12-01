<form action="" method="post">
    {include file="affiliates/configuration_header.tpl"}
    {if $campaigns}
        <div class="blu">
            <a href="?cmd={$cmd}&action={$action}" id="currentlist" style="display:none" updater="#updater"></a>
            <a href="" class="btn btn-sm btn-default" onclick="deleteCampaigns();return false;">Delete selected</a>
        </div>
        <table cellspacing="0" cellpadding="3" border="0" width="100%" class="table glike hover">
            <tbody>
                <tr>
                    <th><input type="checkbox" id="checkall"></th>
                    <th><a href="?cmd={$cmd}&action={$action}&orderby=id|ASC" class="sortorder">ID</a></th>
                    <th><a href="?cmd={$cmd}&action={$action}&orderby=campid|ASC"  class="sortorder">Campaign ID</a></th>
                    <th><a href="?cmd={$cmd}&action={$action}&orderby=name|ASC"  class="sortorder">Name</a></th>
                    <th><a href="?cmd={$cmd}&action={$action}&orderby=date_start|ASC"  class="sortorder">Start Date</a></th>
                    <th><a href="?cmd={$cmd}&action={$action}&orderby=date_end|ASC"  class="sortorder">End Date</a></th>
                    <th><a href="?cmd={$cmd}&action={$action}&orderby=status|ASC"  class="sortorder">Status</a></th>
                    <th><a href="?cmd={$cmd}&action={$action}&orderby=note|ASC"  class="sortorder">Note</a></th>
                    <th></th>
                </tr>
            </tbody>
            <tbody id="updater">
                {include file='ajax.affiliates.tpl'}
            </tbody>
            <tbody id="psummary">
            <tr>
                <th></th>
                <th colspan="9">
                    {$lang.showing} <span id="sorterlow">{$sorterlow}</span> - <span id="sorterhigh">{$sorterhigh}</span> {$lang.of} <span id="sorterrecords">{$sorterrecords}</span>
                </th>
            </tr>
            </tbody>
        </table>
        <div class="blu"></div>
    {else}
        <div class="blank_state blank_services">
            <div class="blank_info">
                <h1>{$lang.affcampaigns}</h1>
                {$lang.affcampaign_blank}
                <div class="clear"></div>
                <a class="new_add new_menu" href="?cmd={$cmd}&action=campaign" style="margin-top:10px">
                    <span>{$lang.addcampaign}</span></a>
                <div class="clear"></div>
            </div>
        </div>
    {/if}
    {securitytoken}
</form>
{literal}
    <script>
        function deleteCampaign(el, id) {
            if (!confirm('Are you sure you wish to remove this campaign?'))
                return;
            if (id) {
                $.post('?cmd=affiliates&action=campaign&make=delete_mass&security_token={/literal}{$security_token}{literal}', {ids:[id]}, function(data) {
                    var resp = parse_response(data);
                    if (resp) {
                        $(el).closest('tr').remove();
                    }
                });
            }
        }
        function deleteCampaigns() {
            var ids = [];
            $('.campaigns_selected:checked').each(function () {
                ids.push($(this).val());
            });
            if (ids.length > 0) {
                $.post('?cmd=affiliates&action=campaign&make=delete_mass&security_token={/literal}{$security_token}{literal}', {ids:ids}, function(data) {
                    var resp = parse_response(data);
                    if (resp && ids.length > 0) {
                        $('.campaigns_selected:checked').closest('tr').remove();
                    }
                });
            }
        }
    </script>    
{/literal}