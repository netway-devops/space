{literal}
<style>
    .label-width-96 {
        min-width: 96%;
    }
    .label-width-100 {
        min-width: 100%;
    }
    .margin-top-7 {
        margin-top: 7px;
    }
</style>
{/literal}
{if !$categories}
<div class="clear alert alert-info">
    <div class="row no-gutter">
        <div class="col-lg-11">
            <b>{$lang.Note}:</b> {$lang.save_to_set_related_services}
        </div>
    </div>
</div><br>
{else}
<div class="clear form-settings">
    <div class="row no-gutter">
        <div class="col-lg-4">
            <label for="check-admin" class="label-width-96">
                {$lang.select_only_one}
                <small class="label-width-100">{$lang.select_only_one_desc}</small>
            </label>
        </div>
        <div class="col-lg-8">
            <input id="check-admin" type="checkbox" name="config[select_one]" value="1" {if $field.config.select_one}checked{/if}>
        </div>
    </div>
</div>
<div class="clear">
    <div class="row no-gutter">
        <div class="col-lg-4">
            <label class="nodescr label-width-96" for="field-type">
                {$lang.service_categories}
                <small class="label-width-100">{$lang.service_categories_desc}</small>
            </label>
        </div>
        <div class="col-lg-8 margin-top-7">
            <select class="chosen" name="config[categories][]" multiple>
                {foreach from=$categories item=category}
                    <option value="{$category.id}" {if in_array($category.id, $field.config.categories)}selected{/if}>{$category.name}</option>
                {/foreach}
            </select>
        </div>
    </div>
</div>
<div class="clear">
    <div class="row no-gutter">
        <div class="col-lg-4">
            <label class="nodescr label-width-96" for="field-type">
                {$lang.service_statuses}
                <small class="label-width-100">{$lang.service_statuses_desc}</small>
            </label>
        </div>
        <div class="col-lg-8 margin-top-7">
            <select class="chosen" name="config[statuses][]" multiple>
                {foreach from=$statuses item=status}
                    <option value="{$status}" {if (!$field.config.statuses && in_array($status, array('Pending', 'Active', 'Suspended')))
                    || (in_array($status, $field.config.statuses))}selected{/if}>{$status}</option>
                {/foreach}
            </select>
        </div>
    </div>
</div>
<div class="height"></div>
{literal}
<script>
    $('.chosen').chosenedge({width: '100%'});
    $('.chosen-container').on('click', function () {
       var h = $('.chosen-drop', this).height(),
           div = $('.height'),
           data = div.data('height');
       if (data && data > h)
           return false;
       div.css('min-height', h+'px').data('height', h);
    });
</script>
{/literal}
{/if}