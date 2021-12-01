{if $categories}
    <div class="row">
        <div class="col-sm-8">
            <select name="im_category[]" multiple class="form-control chosen">
                {foreach from=$categories item=category key=id}
                    <option value="{$id}" {if in_array($id, $current)}selected{/if}>#{$id} - {$category}</option>
                {/foreach}
            </select>
        </div>
        <div class="col-sm-2">
            <button type="button" style="margin-top: 2px;" class="btn btn-success btn-sm" onclick="addValue();">Add Values</button>
        </div>
    </div>

{literal}
    <script>
        $(function () {
            $(".chosen").chosenedge({
                width: "100%",
                disable_search_threshold: 5,
                allow_single_deselect: true
            });
            $('#inventoryarea').parents('.tabb').css('overflow', 'visible');
        });

        function addValue() {
            var select = $('select[name="im_category[]"]');
            var im_category_ids = select.val();
            var im_category_name = [];
            select.find("option:selected").each(function () {
               if ($(this).length)
                   im_category_name.push($(this).text());
            });
            $.post('?cmd=inventory_manager&action=add_value', {
                field_category_id: $('#field_category_id').val(),
                im_category_ids: im_category_ids
            }, function (data) {
                var r = parse_response(data);
                $('.toggle_content').append(r);
                var ids = $('input[name="config[inventory][id][]"]'),
                    first = ids.first(),
                    names = $('input[name="config[inventory][name][]"]'),
                    nfirst = names.first();
                $.each(im_category_ids, function (i, v) {
                    first.val(v);
                    first.clone().appendTo(first.parent());
                });
                ids.remove();
                $.each(im_category_name, function (i, v) {
                    console.log(v);
                    nfirst.val(v);
                    nfirst.clone().appendTo(nfirst.parent());
                });
                names.remove();
                saveChangesField();
            });
        }
    </script>
{/literal}
{/if}