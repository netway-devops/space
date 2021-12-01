{if $is_client}
    <div style="background: #f7f7f7;margin:-10px -5px 0px;padding: 15px 10px;">
    <strong>Related service:</strong>
    {if $service} <a href="?cmd={if $service.type=='account'}accounts{else}domains{/if}&action=edit&id={$service.id}" id="ticket_related_service" target="_blank" >
        {$service.name}</a>
    {else}None{/if}

    <button class="btn btn-xs btn-primary" onclick="return assignService('')">Change</button>
</div>
<div id="ChangeService" style="display:none;" bootbox data-title="Change related service"
     data-formaction="?cmd=ticket_related_client_service&action=change">
    <input name="make" value="1" type="hidden">

    <input type="hidden" name="ticket_number" value="{$ticket.ticket_number}"/>
    <input type="hidden" name="ticket_id" value="{$ticket.id}"/>

    <div class="form-group">
        <label>New service</label>
        <select name="service_id" class="form-control" style="min-width:180px">

            <option value="0" {if !$service}selected="selected"{/if}>None</option>
            {foreach from=$services item=s}
                <option value="{$s.id}" {if $service.id == $s.id|substr:1 && $service.type == $s.type}selected="selected"{/if}>{$s.name}</option>

            {/foreach}
        </select>
    </div>
    {securitytoken}
</div>
{literal}
<script>

    function assignService() {



        $('#ChangeService').trigger('show');
    }

    $(function(){
        $('#ChangeService').bootboxform().on('bootbox-form.shown', function (e, dialog) {
            $('select', dialog).chosenedge({
                width: "100%",
                enable_split_word_search: true,
                search_contains: true,
            });
        });
    });

</script>
{/literal}

{/if}