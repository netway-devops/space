

<select style="display: none"
    class="pconfig_ custom_field_{$cf.copy_of}"
    multiple 
    id="multiple_field_{$cf.id}"
    name="multiple_field_{$cf.id}">

    {foreach from=$cf.items item=cit name=nit}
        <option
            data-val="{$cit.copy_of}"
            value="{$cit.id}"
            {cartformvalue}{if $cfvalue}selected="selected"{/if}
            >{$cit.name} {if $cit.price!=0}(
            {if $cit.fee!=0} {$cit.fee|price:$currency} {$lang[$cit.recurring]}{/if}
            {if $cit.setup!=0} {$cit.setup|price:$currency} {$lang.setupfee}{/if}
            ){/if}</option>
        {/foreach}
</select>
<div style="display:none" id="hidden_field_group_{$cf.id}">
    {foreach from=$cf.items item=cit name=nit}
        <input name="{if $cf_opt_name && $cf_opt_name != ''}{$cf_opt_name}{else}custom{/if}[{$cf.id}][{$cit.id}]"  
               value="1"
               id="hidden_field_itm_{$cit.id}"
               type="checkbox" {cartformvalue} {if $cfvalue}checked="checked"{/if} 
               style="display:none"
               />
    {/foreach}

</div>
{once}
<script type="text/javascript" src="{$system_url}includes/libs/configoptions/multicheckbox/multiple-select.js"></script>
<link rel="stylesheet" href="{$system_url}includes/libs/configoptions/multicheckbox/multiple-select.css" />
{/once}
{literal}        
    <script type="text/javascript">
        if (!$.fn.multipleSelect) {
            $('body').append('<script type="text/javascript" src="{/literal}{$system_url}{literal}includes/libs/configoptions/multicheckbox/multiple-select.js">');
            $('body').append('<link rel="stylesheet" href="{/literal}{$system_url}{literal}includes/libs/configoptions/multicheckbox/multiple-select.css">');
        }
        (function() {
            var blockRefresh = false;
            if (typeof (simulateCart) == 'function') {
                var orgSimulateCart = window.simulateCart;
                simulateCart = function() {
                    if(blockRefresh)
                        return false;
                    orgSimulateCart.apply(this, arguments)
                }
            }

            $("#multiple_field_{/literal}{$cf.id}{literal}").multipleSelect({
                width: 320,
                filter: true,
                multiple: true,
                selectAll: false,
                multipleWidth: 250,
                onOpen: function() {
                    console.log('block by {/literal}{$cf.id}{literal}');
                    blockRefresh = true;
                },
                onClose: function() {
                    console.log('un-block {/literal}{$cf.id}{literal}');
                    blockRefresh = false;
                    $('#hidden_field_group_{/literal}{$cf.id}{literal} input').removeAttr('checked');
                    var w = $('#multiple_field_{/literal}{$cf.id}{literal}').val();
                    if (w) {
                        for (var i in w) {
                           // $('#hidden_field_itm_' + w[i]).attr('checked', 'checked');
                            $('#hidden_field_itm_' + w[i]).prop('checked', true);
                        }
                    }
                    if (typeof (simulateCart) == 'function') {
                        simulateCart('{/literal}{if $cf_opt_formId && $cf_opt_formId != ''}{$cf_opt_formId}{else}#cart3{/if}{literal}');
                    }
                }
            });
        })()

    </script>
{/literal}