<div class="row dns-package" style="padding: 20px;">
    <div class="col-md-12">
        <div class="row">
            <div class="row">
                <div class="col-md-4">
                    <label>DNS Service package</label>
                    <select name="configuration[package][{$new_id}]" class="form-control">
                        {if $packages}
                            {foreach from=$packages item=package}
                                <option  value="{$package.id}">&nbsp;{$package.name}&nbsp;</option>
                            {/foreach}
                        {else}
                            <option>No DNS management packages available</option>
                        {/if}
                    </select>
                </div>
                <div class="col-md-7">
                    <label>Domain Apps</label>
                    <select name="configuration[domain_apps][{$new_id}][]" class="form-control chosen-app" multiple>
                        {if $domain_apps}
                            <option selected value="all">All</option>
                            {foreach from=$domain_apps item=app}
                                <option value="{$app.id}">&nbsp;{$app.gname} - {$app.name}&nbsp;</option>
                            {/foreach}
                        {else}
                            <option>No Domain Apps available</option>
                        {/if}
                    </select>
                </div>
                <div class="col-md-1" style="margin-top: 25px;">
                    <button type="button" class="btn btn-sm btn-danger" onclick="remove_package(this);">Remove</button>
                </div>
            </div>
        </div>
    </div>
    <input type="hidden" class="count_package" value="{$new_id}">
</div>
<div class="next-dns-package"></div>
{literal}
    <script>
        $('.chosen-app').chosenedge({
            enable_split_word_search: true,
            search_contains: true,
        }).on('change', function (e, data) {
            var select = $(this),
                values = select.val();

            if (values.indexOf('all') >= 0) {
                if (data.selected == 'all')
                    select.val(['all']).trigger('chosen:updated')
                else {
                    values.splice(values.indexOf('all'), 1);
                    select.val(values).trigger('chosen:updated');
                }
            }
        });
    </script>
{/literal}