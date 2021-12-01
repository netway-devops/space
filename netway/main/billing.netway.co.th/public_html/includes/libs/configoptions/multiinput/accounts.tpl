{once}
    <script id="multiinput-item-template" type="text/x-custom-template">
        <div class="multiinput-box-item">
            <input name="__itname" class="custom_field" type="text" onchange="onchangeMultipleInput(this);"/>
            <a href="#" class="text-danger multiinput_removeInput" onclick="removeMultiInput($(this));return false;">Remove</a>
        </div>
        <div class="clearfix"></div>
    </script>
    <script src="{$system_url}includes/libs/configoptions/multiinput/multiinput.js?v={$hb_version}" type="text/javascript"></script>
{/once}
{foreach from=$c.data item=cit key=id}
    {assign var="itname" value="custom[`$kk`][`$id`][]"}
    <div class="multiinput-box custom_field_{$c.copy_of}" data-max="{$c.config.maxinputs}" id="custom_field_{$c.copy_of}" data-formid="#cart3" data-itname="{$itname}" data-copyof="{$c.copy_of}">
        {foreach from=$cit|json_decode:1 item=key_id}
            <div class="multiinput-box-item">
                <input name="{$itname}" value="{$key_id}" class="custom_field" type="text" onchange="onchangeMultipleInput(this);"/>
                <a href="#" class="text-danger multiinput_removeInput" onclick="removeMultiInput($(this));return false;">Remove</a>
            </div>
            <div class="clearfix"></div>
        {/foreach}
        <div class="multiinput_addInput"><a href="#" onclick="addMultiInput($(this));return false;">Add more</a></div>
    </div>
    <br/>
{/foreach}
