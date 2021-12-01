{foreach from=$c.items item=cit}
{literal}
    <script type="text/javascript">
        function idprotect_control(el) {
            var control = $('#idprotection'),
                form = $('#idprotection_purchase');

            if ($(el).is(':checked')) {
                control.val("1");
                form.val("1").attr('name', form.data('name'));
            } else {
                control.val("0");
                form.val("1").removeAttr('name');
            }
            return false;
        }

    </script>
{/literal}
    {if $details.status !== 'Pending'}
        <div class="idprotection-status">
            <div>
                <label>
                    <input type="radio" name="idprotection" value="1"
                           {if $details.idprotection == 1}checked{/if} hidden/>
                    <span class="label-livemode label label-success-invert"
                          data-value="1">{$lang.On}</span>
                </label>
                <label>
                    <input type="radio" name="idprotection" value="0"
                           {if $details.idprotection == 0}checked{/if} hidden/>
                    <span class="label-livemode label label-default-invert"
                          data-value="0">{$lang.Off}</span>
                </label>
            </div>
        </div>
    {else}
        <input name="idprotection" id="idprotection" value="{$details.idprotection}" type="hidden"/>
    {/if}
    <div class="idprotection-form">
        <input type="checkbox" id="idprotection_purchase" name="custom[{$kk}][{$cit.id}]"
               value="1" {if $c.values[$cit.id]}checked{/if} />

        <span class="vtip_description" >
            <span>
                Privacy protection will be automatically enabled during registration/transfer.
                If you enable "Manage Privacy" <b>client function</b>, only domains
                with this enabled will allow clients to access it.
            </span>
        </span>

        {if $admindata.access.viewOrdersPrices}
            {if $cit.price}({$cit.price|price:$currency:true:$forcerecalc}){/if}
        {/if}

    </div>
    {break}
{/foreach}
