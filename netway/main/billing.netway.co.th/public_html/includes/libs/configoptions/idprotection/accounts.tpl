{foreach from=$c.items item=cit}
    {*<pre>{$c|@print_r}</pre>*}
{literal}
    <script type="text/javascript">
        function {/literal}{$c.variable}{literal}_control(el) {
            var control = $('#{/literal}{$c.variable}{literal}'),
                form = $('#{/literal}{$c.variable}{literal}_purchase');

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
        <div class="{$c.variable}-status">
            <div>
                <label>
                    <input type="radio" name="{$c.variable}" value="1"
                           {if $details[$c.variable] == 1}checked{/if} hidden/>
                    <span class="label-livemode label label-success-invert"
                          data-value="1">{$lang.On}</span>
                </label>
                <label>
                    <input type="radio" name="{$c.variable}" value="0"
                           {if $details[$c.variable] == 0}checked{/if} hidden/>
                    <span class="label-livemode label label-default-invert"
                          data-value="0">{$lang.Off}</span>
                </label>
            </div>
        </div>
    {else}
        <input name="{$c.variable}" id="{$c.variable}" value="{$details[$c.variable]}" type="hidden"/>
    {/if}
    <div class="{$c.variable}-form">
        <input type="checkbox" id="{$c.variable}_purchase" name="custom[{$kk}][{$cit.id}]"
               value="1" {if $c.values[$cit.id]}checked{/if} />

        {if $c.variable == 'idprotection'}
            <span class="vtip_description" >
            <span>
                Privacy protection will be automatically enabled during registration/transfer.
                If you enable "Manage Privacy" <b>client function</b>, only domains
                with this enabled will allow clients to access it.
            </span>
        </span>
        {/if}

        {if $admindata.access.viewOrdersPrices}
            {if $cit.price}({$cit.price|price:$currency:true:$forcerecalc}){/if}
        {/if}

    </div>
    {break}
{/foreach}
