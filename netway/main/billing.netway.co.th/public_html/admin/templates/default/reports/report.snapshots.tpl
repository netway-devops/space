{literal}
    <script>
        $('.widget-series-snapshot-selector').on('change', function () {
            var self = $(this),
                    selected = self.find('option:selected'),
                    selected_val = selected.attr('data-value');

            $('.widget-series-snapshot-data').hide().parent().val('');
            if (selected_val) {
                $('.widget-series-snapshot-data').hide().parent().show();
                $('.widget-series-snapshot-data[data-snapshot="' + selected_val + '"]').show();
            } else {
                $('.widget-series-snapshot-data').hide().parent().hide();
            }
        })
    </script>
{/literal}
<strong>Snapshots:</strong>
{if $snapshots}
    <div class="form-group">
        <select class="form-control widget-series-snapshot-selector">
            <option value="">--select--</option>
            {foreach from=$snapshots item=snapshot}
                {if $snapshot.snapshot_datas}
                    <option data-value="{$snapshot.id}" {if $selected_snapshot_data.snapshot_id == $snapshot.id}selected="selected"{/if}>{$snapshot.name}</option>
                {/if}
            {/foreach}
        </select>
    </div>
    <div class="form-group">
        <select name="snapshot_data_id" class="form-control">
            {foreach from=$snapshots item=snapshot}
                {if $snapshot.snapshot_datas}
                    {foreach from=$snapshot.snapshot_datas item=data}
                        <option class="widget-series-snapshot-data" data-snapshot="{$data.snapshot_id}" value="{$data.id}" {if $selected_snapshot_data.id == $data.id}selected="selected"{else}style="display:none;"{/if}>Export: {$data.created_at}</option>
                    {/foreach}
                {/if}
            {/foreach}
        </select>
    </div>
    <div class="clear"></div>
{else}
    <em>none</em>
{/if}