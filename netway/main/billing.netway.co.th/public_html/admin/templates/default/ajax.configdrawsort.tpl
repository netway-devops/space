{if $field.id=='new'}
    <p class="alert alert-warning">
        <em>{$lang.savefirsterror}</em>
    </p>
{else}
    <ul id="customitemseditor" data-field-id="{$field.id}" class="grab-sorter list-group form-options">
        {if $field.items}
            {foreach from=$field.items item=item key=k}
                {if $item.id!=0}
                    <li class="form-option list-group-item clearfix">
                        <div class="col-xs-1 form-option-sort">
                            <input type="hidden" name="items[{$k}][id]" value="{$item.id}"/>
                            <input type="hidden" name="sort[]" value="{$item.id}" class="ser2"/>
                            <a onclick="return false" class="sorter-ha menuitm" href="#">
                                <i class="fa fa-sort"></i>
                            </a>
                        </div>
                        <div class="col-xs-8 form-option-name">
                            {hbinput value=$item.tag_name class="form-control" name="items[$k][name]"}
                        </div>
                        <div class="col-xs-3 form-option-config" style="text-align: right">
                            {if $field.type.info.pricing}
                                <a onclick="$('#fpricing_{$k}').toggle();$(this).toggleClass('activated');return false;" title="{$lang.enablepricing}" class="menuitm menu-auto  {if isset($item.d)}hasvalue{/if}" href="#">
                                    <i class="fa fa-usd"></i>
                                </a>
                            {/if}

                            <a onclick="$('#fvar_{$k}').toggle();$(this).toggleClass('activated');return false;" title="Advanced options" class="menuitm menu-auto {if $item.variable_id}hasvalue{/if}" href="#">
                                <i class="fa fa-cog"></i>
                            </a>

                            <a onclick="$('#fhide_{$k}').toggle();$('.fa',this).toggleClass('fa-toggle-on');$('.fa',this).toggleClass('fa-toggle-off');$('#fhide_{$k}_val').val($('#fhide_{$k}_val').val()=='1'? 0: 1);return false;"
                               title="Show / hide option" class="menuitm menu-auto" href="#">
                                <i class="fa {if $item.options & 1}fa-toggle-off{else}fa-toggle-on{/if}"></i>
                            </a>
                            <a onclick="return deleteItem(this)" title="delete"
                               class="menuitm menu-auto"
                               href="?cmd=configfields&action=deleteitem&id={$item.id}">
                                <i class="fa fa-trash-o"></i>
                            </a>
                        </div>
                        <div class="form-option-more">
                            <div style="{if !$item.options}display:none{/if}" id="fhide_{$k}">
                                <em>This value will be hidden from order-page.</em>
                                <input type="hidden" value="{$item.options}" name="items[{$k}][options]"
                                       id="fhide_{$k}_val">
                            </div>
                            <div style="display:none" id="fvar_{$k}">
                                <div class="form-group" style="margin-bottom: 20px;">
                                    <label>Value passed to App</label>
                                    <input type="hidden" value="{$item.copy_of}" name="items[{$k}][copy_of]">
                                    <input type="hidden" value="{$item.variable_id|escape}" name="items[{$k}][old_variable_id]">
                                    <input type="text" class="form-control"
                                           value="{$item.variable_id|escape}"
                                           name="items[{$k}][variable_id]">
                                </div>

                                <div class="form-group" style="margin-bottom: 20px;">
                                    <label>Value description</label>
                                    <input type="text" class="form-control" value="{$item.description|escape}" name="items[{$k}][description]">
                                </div>

                                {if $form_item_groups}
                                    <div class="form-group form_item_group" style="margin-bottom: 0">
                                        <label>Form item group</label>
                                        <select name="items[{$k}][group_id]" class="form-control" style="margin: 0 0 20px 0;">
                                            <option value="0">--None--</option>
                                            {foreach from=$form_item_groups item=gr}
                                                <option data-itgroup="{$gr.id}" value="{$gr.id}" {if $gr.id == $item.group_id}selected{/if}>{$gr.name}</option>
                                            {/foreach}
                                        </select>
                                    </div>
                                {/if}
                            </div>
                            {if $field.type.info.pricing}
                                <div style="display:none" id="fpricing_{$k}">
                                    <div class="checkbox">
                                        <label>
                                            <input type="checkbox" name="items[{$k}][pricing]" value="1"
                                                   {if isset($item.d)}checked="checked"{/if}
                                                   onclick="$('#fpricing_{$k}').find('.pricingtable').toggle()"
                                            />
                                            {$lang.enablepricing} - {$lang.chargeforvalue}
                                        </label>
                                    </div>
                                    {if $paytypeform}
                                        {include file="formbilling_`$paytypeform`.tpl"}
                                    {else}
                                        {include file='formbilling_Regular.tpl'}
                                    {/if}
                                </div>
                            {/if}
                        </div>
                    </li>
                {/if}
            {/foreach}
        {/if}
    </ul>
    <script type="text/javascript">latebindme();
        if (typeof updatePricingForms == 'function') updatePricingForms();
    </script>
    <div id="config-new-value" style="border:solid 1px #ddd;border-top:none;background:#F5F9FF;width:365px"
         class="left">
        <table width="100%" cellspacing="0" cellpadding="5" border="0">
            <tbody>
                <tr>
                    <td width="20" valign="top">
                        <div style="padding:5px 0px;">{$lang.New}:</div>
                    </td>
                    <td valign="top">
                        <input name="new_value_name" type="text" class="w250" style="margin:0px" value=""/>
                    </td>
                    <td align="right" valign="top">
                        <div style="padding:5px 0px;">
                            <a {if $field.id=='new'}
                                onclick="alert('{$lang.savefirsterror}'); return false;"
                            {else}
                                onclick="$(this).addClass('activated');return addNewConfigItemValue()"
                            {/if} class="new_control greenbtn" href="#">
                                <span>{$lang.Add}</span>
                            </a>
                        </div>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
    {if $premade}
        <div class="right  shownice" style="padding:15px ">
            <select name="premadeid" id="premadeid" style="margin:0px">
                <option value="0">Use pre-made values</option>
                {foreach from=$premade item=p}
                    <option>{$p}</option>
                {/foreach}
            </select>
            <div class="right" style="">
                <a class="new_control" href="#" onclick="return usePremade()">
                    <span><b>{$lang.submit}</b></span>
                </a>
            </div>
        </div>
    {/if}
{/if}
<div class="clear"></div>
<input type="hidden" id="lastitm" value="{$k+1}"/>
<script>
    var itemGroups = [{foreach from=$form_item_groups item=gr name=foo}{$gr.id}{if not $smarty.foreach.foo.last},{/if}{/foreach}];
    {literal}
    function checkItemGroups() {
        $(itemGroups).each(function () {
            var num = this;
            var selectedEl;
            var disable = false;
            $('#customitemseditor .form_item_group').find("option[data-itgroup='"+num+"']").each(function () {
                if ($(this).is(':selected')) {
                    selectedEl = $(this);
                    disable = true;
                    return false;
                }
            });
            $('#customitemseditor .form_item_group').find("option[data-itgroup='"+num+"']").not(selectedEl).prop('disabled', disable);
        });
    }
    $(function () {
        checkItemGroups();
        $('.form_item_group').on('change', function () {
            checkItemGroups();
        });
        $('.form_item_group option:disabled').on('click', function () {
            alert('You can not assign more than 1 item in one form to the same group!');
        });
    });
    {/literal}
</script>