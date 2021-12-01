<link href="{$template_dir}js/chosen/chosen.css" rel="stylesheet" media="all">
<script type="text/javascript" src="{$template_dir}js/chosen/chosen.min.js?v={$hb_version}"></script>
<div class="form-group">
    <label class="control-label">{$lang.Service}:</label>
    <select name="selected[services][]" class="specify chosen form-control" multiple data-type="services">
        <option value="all" selected>{$lang.allservices}</option>
        {foreach from=$criteria.services item=category key=id}
            <optgroup label="{$id}">
                {foreach from=$category item=service}
                    <option value="{$service.id}">{$service.name}</option>
                {/foreach}
            </optgroup>
        {/foreach}
    </select>
</div>
<div class="form-group">
    <label class="control-label">{$lang.Server}:</label>
    <select name="selected[servers][]" class="specify chosen form-control" multiple data-type="servers">
        <option value="all" selected>{$lang.allservers}</option>
        {foreach from=$criteria.servers item=server}
            <option value="{$server.id}">{$server.name}</option>
        {/foreach}
    </select>
</div>
<div class="form-group">
    <label class="control-label">{$lang.Countries}:</label>
    <select name="selected[countries][]" class="specify chosen form-control" multiple data-type="countries">
        <option value="all" selected>{$lang.allcountries}</option>
        {foreach from=$criteria.countries item=country}
            <option value="{$country.id}">{$country.name}</option>
        {/foreach}
    </select>
</div>

<div class="form-group">
    <label class="control-label">Include contacts:</label>
    <select name="contacts" class="specify chosen form-control"  >
        <option value="0" selected>Only allowed to receive support notifications</option>
        <option value="1" >All active contacts</option>
        <option value="-1" >No contacts, just main profiles</option>
    </select>
</div>

{adminwidget module="clients" section="emailcriterias"}

{literal}
<script>

    $(function () {
        $('.chosen').chosenedge({
            width: '100%',
            enable_split_word_search: true,
            search_contains: true
        }).on('change', function (e, data) {
            var select = $(this),
                values = select.val();

            if (jQuery.type(values) === 'null' || values.length === 0) {
                select.val(values).trigger('chosen:updated');
            } else if (values.indexOf('all') >= 0) {
                if (data.selected == 'all')
                    select.val(['all']).trigger('chosen:updated')
                else {
                    values.splice(values.indexOf('all'), 1);
                    select.val(values).trigger('chosen:updated');
                }
            }
        });

        var load = {/literal}{if $criteria}0{else}1{/if}{literal};
        if(load) {
            $('.specify').each(function () {
                getCriterias(this, $(this).data('type'));
            });
        }
    });

    function getCriterias(item, type) {
        $.post("?cmd=clients&action=sendmailcriterias", {type: type}, function (result) {
            $(item).append(result).trigger('chosen:updated');
        });
    }

    function checkAllItems(item, type) {
        var item_class = '.check_' + type;
        if ($(item).attr('checked')) {
            $(item_class).attr('checked', true);
            $(item_class).parent().parent().addClass('checkedRow');
        } else {
            $(item_class).attr('checked', false);
            $(item_class).parent().parent().removeClass('checkedRow');
        }
    }


   </script>{/literal}