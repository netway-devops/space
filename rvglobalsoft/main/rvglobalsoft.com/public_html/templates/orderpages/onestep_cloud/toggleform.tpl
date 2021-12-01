{if $cf.items && $cf.type == 'slider'}
    {foreach from=$cf.items item=cit}
        <div class="slider-horizontal clearfix" id="horizontal_slider_{$cf.id}">
            <input 
                name="custom[{$cf.id}][{$cit.id}]"  
                value="{if $contents[1][$cf.id][$cit.id].qty}{$contents[1][$cf.id][$cit.id].qty}{else}{$cf.config.initialval}{/if}" 
                type="hidden" 
                style="display:none" class="custom_field_{$cf.id}"
                id="custom_field_{$cf.id}"  
                onchange="if (typeof(simulateCart)=='function')simulateCart('#cart1');" 
                variable="{$cf.variable}" 
                />
            <div class="server-option-box">
                <div class="server-option-left"></div>
                <div class="server-option-middle">
                    <div class="server-option-border"></div>
                    <div class="server-option-text clearfix">
                        <div class="setup-arrows" >
                            <div class="setup-arrow-up" ></div>
                            <div class="setup-arrow-down"></div>
                        </div>
                        <div class="slider-icon {$cf.key}"></div>
                        <p>{$cf.name} <span>{if $contents[1][$cf.id][$cit.id].qty}{$contents[1][$cf.id][$cit.id].qty}{else}{$cf.config.initialval}{/if}</span></p>
                    </div>
                </div>
                <div class="server-option-right"></div>
            </div>
        </div>
        <script type="text/javascript">
                sliders.push({literal}{{/literal}
                max : parseInt('{$cf.config.maxvalue}') || 100 ,
                min : parseInt('{$cf.config.minvalue}') || 0,
                step : parseInt('{$cf.config.step}') || 1 ,
                value : parseInt('{if $contents[1][$cf.id][$cit.id].qty}{$contents[1][$cf.id][$cit.id].qty}{else}{$cf.config.initialval}{/if}') || 0,
                id: '{$cf.id}'{literal}}{/literal});
        </script>
        {cartfieldlogic}
        {if $cf.config.conditionals}
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
    {/foreach}
{/if}