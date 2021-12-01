<script id="multiinput-item-template" type="text/x-custom-template">
    <div class="multiinput-box-item my-2">
        <input name="__itname" class="styled custom_field form-control" type="text" onchange="onchangeMultipleInput(this);"/>
        <a href="#" class="text-danger multiinput_removeInput" onclick="removeMultiInput($(this));return false;">Remove</a>
    </div>
</script>

<script src="{$system_url}includes/libs/configoptions/multiinput/multiinput.js?v={$hb_version}" type="text/javascript"></script>

{foreach from=$cf.items item=cit}
    {if $cf_opt_name && $cf_opt_name != ''}
        {assign var="itname" value=$cf_opt_name}
    {else}
        {assign var="itname" value="custom[`$cf.id`][`$cit.id`][]"}
    {/if}
    <div class="multiinput-box custom_field_{$cf.copy_of}" data-max="{$cf.config.maxinputs}" id="custom_field_{$cf.copy_of}" data-formid="{if $cf_opt_formId && $cf_opt_formId != ''}{$cf_opt_formId}{else}#cart3{/if}" data-itname="{$itname}" data-copyof="{$cf.copy_of}">
        {cartformvalue}
        {if $cfvalue.val}
            {foreach from=$cfvalue.val item=vall}
                <div class="multiinput-box-item my-2">
                    <input name="{$itname}" value="{$vall}" class="styled custom_field form-control" type="text" onchange="onchangeMultipleInput(this);"/>
                    <a href="#" class="text-danger multiinput_removeInput" onclick="removeMultiInput($(this));return false;">Remove</a>
                </div>
            {/foreach}
        {else}
            <div class="multiinput-box-item my-2">
                <input name="{$itname}" value="" class="styled custom_field form-control" type="text" onchange="onchangeMultipleInput(this);"/>
                <a href="#" class="text-danger multiinput_removeInput" onclick="removeMultiInput($(this));return false;">Remove</a>
            </div>
        {/if}
        <div class="multiinput_addInput my-3"><a href="#" onclick="addMultiInput($(this));return false;">Add more</a>
        </div>
    </div>
    <br/>
{/foreach}
