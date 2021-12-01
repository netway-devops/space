<a href="#" onclick="updateInventoryList();return false" class="btn btn-sm btn-primary">Load available inventory categories</a>
<br><br>
<script type="text/javascript">
    {literal}
    function updateInventoryList() {
        $('#facebox').unbind('ajaxStop');
        if($('#field_category_id').val()=='new')
            return;
        $('#inventorymanager-preloader1').show();
        var current = $('select[name="im_category[]"]').val();
        $.post('?cmd=inventory_manager&action=get_categories',{
            id:$('#product_id').val(),
            field_id:$('#field_category_id').val(),
            server_id:$('#serv_picker input[type=checkbox][name]:checked:eq(0)').val(),
            current: current
        },function(data){
            var r= parse_response(data);
            if (r === true) {
                r = "<h3>Cannot get Inventory Categories. Make sure Inventory Manager plugin is enabled.</h3>";
            }
            $('#inventorymanager-preloader1').hide();
            $('#inventoryarea').html(r);
        });
    }
    $(function () {
        $('#inventoryarea').parents('.tabb').css('overflow', 'visible');

        var conf = $('.form-option-config');
        conf.each(function (i) {
            var children = $(this).children(),
                value = $('input[name="items[' + i + '][variable_id]"]').val();
            $(children).each(function (index) {
                if (index !== 0) {
                    if (index === 2 && $('input[name="config[toggle][' + value + ']"]').val() === '0') {
                        return;
                    }
                    $(this).attr('onclick', false).attr('disabled', true).attr('href', '#').css('cursor', 'pointer');
                }
            });
        });
        $(".chosen").chosenedge({
            width: "100%",
            disable_search_threshold: 5,
            allow_single_deselect: true
        }).on('change', function (e, data) {
            var select = $(this),
                values = select.val();
            values.push(data['deselected']);
            select.val(values).trigger('chosen:updated');
            alert('Please load available inventory categories first.');
        });
        $('#config-new-value').hide();
    });
    {/literal}
</script>
{if $field.config.inventory.id}
    {foreach from=$field.config.inventory.id item=id}
        <input type="hidden" name="config[inventory][id][]" value="{$id}">
    {/foreach}
{else}
    <input type="hidden" name="config[inventory][id][]" value="">
{/if}
{if $field.config.inventory.name}
    {foreach from=$field.config.inventory.name item=name}
        <input type="hidden" name="config[inventory][name][]" value="{$name}">
    {/foreach}
{else}
    <input type="hidden" name="config[inventory][name][]" value="">
{/if}
<div class="toggle_content">
    {foreach from=$field.config.toggle item=toggle key=id}
        <input type="hidden" name="config[toggle][{$id}]" value="{$toggle}">
    {/foreach}
</div>
<div style="display: none;" id="inventorymanager-preloader1" class="onapp-preloader" ><img src="templates/default/img/ajax-loader3.gif"> Fetching data from Inventory Manager, please wait...<br>
    ...</div>
<div id="inventoryarea">
    {if $field.config.inventory.name}
        <div class="row">
            <div class="col-sm-8">
                <select name="im_category[]" multiple class="form-control chosen" style="margin-left: 0;">
                    {foreach from=$field.config.inventory.id item=id key=key}
                        <option value="{$id}" selected>{if is_array($field.config.inventory.name)}{$field.config.inventory.name[$key]}
                                {else}{$field.config.inventory.name}{/if}</option>
                    {/foreach}
                </select>
            </div>
        </div>
    {else}
        <h3>No inventory available yet, use button above to fetch inventory</h3>
    {/if}
</div>