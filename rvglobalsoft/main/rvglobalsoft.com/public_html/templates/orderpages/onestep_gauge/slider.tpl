{counter name=slidercounter start=0 assign=sliders}
{foreach from=$custom item=cf}
    {if $sliders == $slideno && $cf.items && $cf.type == 'slider'}
        {foreach from=$cf.items item=cit}
        <div class="slider-box left {if $slideno==2}last{/if}">
            <input 
                name="custom[{$cf.id}][{$cit.id}]"  
                value="{if $contents[1][$cf.id][$cit.id].qty}{$contents[1][$cf.id][$cit.id].qty}{else}{$cf.config.initialval}{/if}" 
                type="text" 
                style="display:none" 
                id="custom_field_{$cf.id}"  class="custom_field_{$cf.id}"
                onchange="if (typeof(simulateCart)=='function')simulateCart('#cart0');" 
                variable="{$cf.variable}" 
            />
        {if $cf.config.conditionals}
            {cartfieldlogic}
            <script type="text/javascript">
            $('.custom_field_{$cf.id}').fieldLogic({literal}{{/literal}type: '{$cf.type}'{literal}}{/literal},[{foreach from=$cf.config.conditionals item=cd name=cond}{literal}{{/literal}
                 value: '{$cd.targetval}',
                 condition_type: '{$cd.condition}',
                 target: '.custom_field_{$cd.target}',
                 condition: '{if $cd.conditionval}{$cd.conditionval}{else}{$cd.val}{/if}',
                 action: '{$cd.action}'
                 {literal}}{/literal}{if !$smarty.foreach.cond.last},{/if}{/foreach}]);
            </script>
        {/if}
            <div class="circle-slider center" id="circle_slider_{$cf.id}">
                <div style="display: none" id="animtrap_{$cf.id}"></div>
                {*<div class="circle-top"></div>*}
                <table class="add-val" cellpadding=0 cellpsacing=0>
                    <tr>
                        <td>
                            <div class="disc-val">{if $contents[1][$cf.id][$cit.id].qty}{$contents[1][$cf.id][$cit.id].qty}{else}{$cf.config.initialval}{/if}</div>
                            <div class="info-val">{$cf.name}</div>
                        </td>
                    </tr>
                </table>
                <div class="min-max clearfix">
                    <span class="left">{$lang.min}</span>
                    <span class="right">{$lang.max}</span>
                </div>
            </div>
            <div class="slider">
                <div id="slider_{$cf.id}"></div>
            </div>
        </div>
        <script type="text/javascript">
            {literal}$(function(){{/literal}
            var max = parseInt('{$cf.config.maxvalue}') || 100 ,
            min = parseInt('{$cf.config.minvalue}') || 0,
            step = parseInt('{$cf.config.step}') || 1 ,
            value = parseInt('{if $contents[1][$cf.id][$cit.id].qty}{$contents[1][$cf.id][$cit.id].qty}{else}{$cf.config.initialval}{/if}') || 0;
            create_slider(min, max, step, value, '{$cf.id}');
            {literal}});{/literal}
        </script>
        {/foreach}
    {/if}
    {counter name=slidercounter}
{/foreach}