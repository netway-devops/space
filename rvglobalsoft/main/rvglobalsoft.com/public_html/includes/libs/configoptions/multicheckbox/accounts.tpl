



<select  
    class="pconfig_ custom_field_{$kk}" 
    multiple 
    id="multiple_field_{$kk}"
    name="multiple_field_{$kk}" {if $cmd == 'orders' && $c.options & 1}required{/if}>

    {foreach from=$c.items item=cit}
        <option 
            value="{$cit.id}"
            {if $c.values[$cit.id]}selected="selected"{/if} 
            >{$cit.name}
                {if $admindata.access.viewOrdersPrices}
                    {if $cit.price}({$cit.price|price:$currency:true:$forcerecalc}){/if}
                {/if}
        </option>
    {/foreach}
</select>
<div style="display:none" id="hidden_field_group_{$kk}">
    {foreach from=$c.items item=cit}
        <input name="custom[{$kk}][{$cit.id}]" 
               value="1"
               id="hidden_field_itm_{$cit.id}"
               data-id="{$cit.id}"
               type="checkbox" {if $c.values[$cit.id]}checked="checked"{/if}
               style="display:none"
               />
    {/foreach}

</div>


{literal}        
    <style>
        #ticketbody .tab_container {
            overflow:visible;
        }</style>
    <script type="text/javascript">
        if (!$.multipleSelect) {
            $('body').append('<script type="text/javascript" src="{/literal}{$system_url}{literal}includes/libs/configoptions/multicheckbox/multiple-select.js">');
            $('body').append('<link rel="stylesheet" href="{/literal}{$system_url}{literal}includes/libs/configoptions/multicheckbox/multiple-select.css">');
        }
        $("#multiple_field_{/literal}{$kk}{literal}").multipleSelect({
            width: 320,
            filter: true,
            multiple: true,
            selectAll: false,
            multipleWidth: 250,
            onClick: function (ev) {
                var itm = $('#hidden_field_itm_' + ev.value);
                !ev.checked && itm.removeAttr('checked') || itm.attr('checked', 'checked');
                itm.prop('checked', false)
            },
            onClose: function () {
                var checkedlist = $('#multiple_field_{/literal}{$kk}{literal}').val();
                $('#hidden_field_group_{/literal}{$kk}{literal} input').each(function(){
                    var self = $(this),
                        checked = checkedlist.indexOf(self.data('id').toString()) !== -1;
                    !checked && self.removeAttr('checked') || self.attr('checked', 'checked');
                    self.prop('checked', checked)
                })
            }
        });
    </script>
{/literal}