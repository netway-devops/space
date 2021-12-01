<p>
    Select which of the existing field will act as QTY value for this drop down field
</p>
<div class="form-group" >
    <label>Linked QTY/Slider field</label>
    <select class="form-control" name="config[link]" style="float: none; padding: 6px 12px; margin: 0"
        id="link_id" data-id="{$field.id}">
        <option value="0"> ---</option>
        {if $field.config.link}
            <option value="{$field.config.link}" selected>{$field.config.link_name}</option>
        {/if}
    </select>
    <input type="hidden" id="link_name_id" name="config[link_name]" value="{$field.config.link_name}">
</div>
{literal}
<script type="text/javascript">
    (function () {
        var field = $('#link_id'),
            name = $('#link_name_id');

        field.on('change', function(){
            name.val(field.val() > 0 ? field.find(':selected').text() : '');
        })
        $.post("?cmd=configfields&action=getotherfields", {
            field_id: field.data('id'), types: ['slider', 'sliderinput', 'qty']
        }, function(data){
            var html = $('<option value="0"> ---</option>' + parse_response(data));
            html.filter('[value="'+field.val()+'"]').prop('selected', true);
            field.html(html);
        });
    })();
</script>
{/literal}
