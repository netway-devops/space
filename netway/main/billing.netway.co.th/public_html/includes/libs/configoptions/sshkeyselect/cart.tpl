{foreach from=$cf.items item=cit}
    <div class="ssh-key-control">
        {cartformvalue}
        {if !$cf.client_id}
            <label>{$lang.use_current_key_login}
                <a href="?cmd=login&redirect={'?cmd=cart&step=3'|escape:'url'}">{$lang.log_in}</a>
            </label>
            <br>
        {/if}
        {if $cf.ssh_keys}
            <div class="ssh-key-list">
                {foreach from=$cf.ssh_keys item=key}
                    <div class="ssh-key-list-item">
                        <input class="new_ssh_key custom_field custom_field_{$cf.id}" type="checkbox" value="{$key.id}"
                               name="{if $cf_opt_name && $cf_opt_name != ''}{$cf_opt_name}{else}custom{/if}[{$cf.id}][{$cit.id}][{$key.id}]"
                               data-field="{$cf.id}"
                               {if $cfvalue.val[$key.id]}checked{/if}
                        >
                        <span>{$key.name}</span>
                    </div>
                {/foreach}
            </div>
        {/if}
        <div class="ssh-key-new">
            {if $cf.ssh_keys}<input type="checkbox" {if $cfvalue.val.new}checked{/if} onchange="return;" />{/if}
            {$lang.enter_new_key}
        </div>
        <textarea
                name="{if $cf_opt_name && $cf_opt_name != ''}{$cf_opt_name}{else}custom{/if}[{$cf.id}][{$cit.id}][new]"
                id="custom_field_{$cf.id}"
                class="styled custom_field ssh_key_textarea custom_field_{$cf.id} textarea_{$cf.id}"
                placeholder="{$lang.enter_publi_ssh_key}"
                {if $cf.ssh_keys && !$cfvalue.val.new}disabled{/if}
            onchange="$(document).trigger('hbcart.changeform', [this]);if (typeof(simulateCart)=='function')simulateCart('{if $cf_opt_formId && $cf_opt_formId != ''}{$cf_opt_formId}{else}#cart3{/if}');"
        >{if is_array($cfvalue.val) && $cfvalue.val.new}{$cfvalue.val.new}{/if}</textarea>
    </div>
{/foreach}
{once}
{literal}
    <style>
        .ssh-key-control textarea{
            width: 100%;
            font-family: monospace;
            min-height: 90px;
            box-sizing: border-box;
        }
        .ssh-key-new, ssh-key-list-item{
            margin-bottom: 5px;
        }
        .ssh-key-list {
            margin-bottom: 10px;
        }
    </style>
    <script>
        $(function () {
            $('.ssh-key-new input').on('change', function () {
               var txtra =  $(this).closest('.ssh-key-control').find('textarea');

                txtra.prop('disabled', !this.checked);
                if(txtra.val().length > 7){
                    txtra.trigger('change');
                }
            })
        });
    </script>
{/literal}
{/once}

