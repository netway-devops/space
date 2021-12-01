{if $cf.items && $cf.type == 'slider'}
    {foreach from=$cf.items item=cit}
        <div class="small-slider-box slider-{$slideno}">
            <div class="small-slider-bg">
                <div class="small-slider-top-layer">
                    <p>{if $contents[1][$cf.id][$cit.id].qty}{$contents[1][$cf.id][$cit.id].qty}{else}{$cf.config.initialval}{/if}</p>
                    <div class="small-slider">
                        <div class="small-slider-handle"></div>
                    </div>
                    <input 
                           name="custom[{$cf.id}][{$cit.id}]"  
                           value="{if $contents[1][$cf.id][$cit.id].qty}{$contents[1][$cf.id][$cit.id].qty}{else}{$cf.config.initialval}{/if}" 
                           type="hidden" 
                           style="display:none" 
                           id="custom_field_{$cf.id}"  class="custom_field_{$cf.id}" 
                           onchange="if (typeof(simulateCart)=='function')simulateCart('#cart0');" 
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
                </div>
            </div>
            <p>{$cf.name}</p>
        </div>
        <script type="text/javascript">
            _oSmall.slider.push( {literal}{{/literal}
                max : parseInt('{$cf.config.maxvalue}') || 100 ,
                min : parseInt('{$cf.config.minvalue}') || 0,
                step : parseInt('{$cf.config.step}') || 1 ,
                value : parseInt('{if $contents[1][$cf.id][$cit.id].qty}{$contents[1][$cf.id][$cit.id].qty}{else}{$cf.config.initialval}{/if}') || 0,
                variable : "{$cf.variable}",
                id : 'custom_field_{$cf.id}'
            {literal}}){/literal};
        </script>
    {/foreach}
{/if}