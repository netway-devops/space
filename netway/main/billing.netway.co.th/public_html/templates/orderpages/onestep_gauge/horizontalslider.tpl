{if $cf.items && $cf.type == 'slider'}
    {foreach from=$cf.items item=cit}
    <div class="slider-horizontal" id="horizontal_slider_{$cf.id}">
        <input 
            name="custom[{$cf.id}][{$cit.id}]"  
            value="{if $contents[1][$cf.id][$cit.id].qty}{$contents[1][$cf.id][$cit.id].qty}{else}{$cf.config.initialval}{/if}" 
            type="text" 
            style="display:none" 
            id="custom_field_{$cf.id}"  class="custom_field_{$cf.id}"  
            onchange="{if $cf.config.conditionals}change_field_{$cf.id}();{/if}if (typeof(simulateCart)=='function')simulateCart('#cart1');" 
            variable="{$cf.variable}" 
        />
        
        <h3>{$cf.name} <span style="font-weight: normal" id="cdesc_{$cf.id}">x {if $contents[1][$cf.id][$cit.id].qty}{$contents[1][$cf.id][$cit.id].qty}{else}{$cf.config.initialval}{/if} {if $cit.price}({$cit.price|price:$currency}){/if}</span> </h3>
        
        <div class="slider-background"></div>
    </div>
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
    <script type="text/javascript">
        {literal}
            $(function(){
                {/literal}
                    var max = parseInt('{$cf.config.maxvalue}') || 100 ,
                    min = parseInt('{$cf.config.minvalue}') || 0,
                    step = parseInt('{$cf.config.step}') || 1 ,
                    value = parseInt('{if $contents[1][$cf.id][$cit.id].qty}{$contents[1][$cf.id][$cit.id].qty}{else}{$cf.config.initialval}{/if}') || 0;
                {literal}
                $('#horizontal_slider_{/literal}{$cf.id}{literal} .slider-background').slider({min: min ,max: max , value: value, step:step, 
                    range:"min", animate: true,
                    slide: function(event, ui) {
                        $('#cdesc_{/literal}{$cf.id}{literal}').text('x '+ui.value+' {/literal}{if $cit.price}({$cit.price|price:$currency}){/if}{literal}').trigger('change');
                    },
                    stop: function(event, ui) {
                        $('#custom_field_{/literal}{$cf.id}{literal}').val(ui.value).trigger('change');
                        $('#cdesc_{/literal}{$cf.id}{literal}').text('x '+ui.value+' {/literal}{if $cit.price}({$cit.price|price:$currency}){/if}{literal}').trigger('change');
                    }
                });
            });
        {/literal}
    </script>
    {/foreach}
{/if}