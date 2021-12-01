{foreach from=$forms item=field key=name}
    <div class="form-group {if $field.required}required{/if}" id="contact-{$type}-{$name}" >
        {if $field.type != 'radio' && $field.type != 'checkbox'}
            <label>
                {if $field.name}{$field.name}
                {elseif $lang[$field.lang]}{$lang[$field.lang]}
                {else}{$name|ucfirst}
                {/if}
            </label>
        {/if}
        {if $field.description}
            <a href="#" title="{$field.description}" class="vtip_description"></a>
        {/if}
        {if $field.type == 'select'}
            <select name="{$type}[{$name}]" class="form-control {$field.class}"
                    {if $field.required}required{/if}>
                {if !$field.required}<option value=""> - </option>{/if}
                {foreach from=$field.optgroups item=group}
                    <optgroup label="{if $group.name}{$group.name}{elseif $lang[$group.lang]}{$lang[$group.lang]}{else}{$group.lang}{/if}">
                        {foreach from=$group.options item=opt}
                            <option value="{$opt.value}" 
                                    {if $opt.value == $field.value}selected{/if}>
                                {if $opt.name}{$opt.name}
                                {elseif $lang[$opt.lang]}{$lang[$opt.lang]}
                                {else}{$opt.value|ucfirst}
                                {/if}
                            </option>
                        {/foreach}
                    </optgroup>
                {/foreach}
                {foreach from=$field.options item=opt}
                    <option value="{$opt.value}" 
                            {if $opt.value == $field.value}selected{/if}>
                        {if $opt.name}{$opt.name}
                        {elseif $lang[$opt.lang]}{$lang[$opt.lang]}
                        {else}{$opt.value|ucfirst}
                        {/if}
                    </option>
                {/foreach}
            </select>
        {elseif $field.type == 'textarea'}
            <textarea name="{$type}[{$name}]" 
                      {if $field.title}title="{$field.title}"{/if}
                      class="form-control {$field.class}">{$field.value}</textarea>
        {elseif $field.type == 'radio' || $field.type == 'checkbox'}
            {foreach from=$field.options item=opt}
                <div class="{$field.type}">
                    <label>
                        <input type="{$field.type}" value="{$opt.value}" 
                               name="{$type}[{$name}][]" 
                               class="{$field.class}" 
                               {if $field.value}checked{/if}>
                        {if $opt.name}{$opt.name}
                        {elseif $lang[$opt.lang]}{$lang[$opt.lang]}
                        {else}{$opt.value|ucfirst}
                        {/if}
                    </label>
                </div>
            {foreachelse}
                <div class="{$field.type}">
                    <label>
                        <input type="{$field.type}" 
                               value="{$field.value|default:1}" 
                               name="{$type}[{$name}]" 
                               class="{$field.class}" 
                               {if $field.value}checked{/if}>
                        {if $field.name}{$field.name}
                        {elseif $lang[$field.lang]}{$lang[$field.lang]}
                        {else}{$name|ucfirst}
                        {/if}
                    </label>
                </div>
            {/foreach}
        {elseif $field.type == 'datepicker'}
            <div class="datepicker">
                <input type="text" value="{$field.value}"
                       name="{$type}[{$name}]" 
                       {if $field.required}required{/if}
                       class="form-control haspicker {$field.class}">
            </div>
        {elseif $field.type == 'tpl'}
            {include file=$field.tpl}
        {else}
            <input type="text" value="{$field.value}"  name="{$type}[{$name}]" 
                   {if $field.required}required{/if}
                   class="form-control {$field.class}">
        {/if}
    </div>
    {if $name == 'copy'}
        {once}
        {literal}
            <script type="text/javascript">
                $(function () {
                    $('[name*="[copy]"]').on('change', function () {
                        var self = $(this),
                            check = self.is(':checked'),
                            targets = self.closest('.form-group').nextAll().not('script');
                        targets.toggle(!check).find('input, textarea,select').prop('disabled', check);
                    }).trigger('change');
                })
            </script>
        {/literal}
        {/once}
    {/if}
{/foreach}
