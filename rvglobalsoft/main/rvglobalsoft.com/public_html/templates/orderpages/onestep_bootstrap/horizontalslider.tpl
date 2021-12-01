{if $cf.items && $cf.type == 'slider'}
    {foreach from=$cf.items item=cit}
    <div class="slider-horizontal" id="horizontal_slider_{$cf.id}">
        <input 
            name="custom[{$cf.id}][{$cit.id}]"  
            value="{if $contents[1][$cf.id][$cit.id].qty}{$contents[1][$cf.id][$cit.id].qty}{else}{$cf.config.initialval}{/if}" 
            type="text" 
            style="display:none" 
            id="custom_field_{$cf.id}"  
            onchange="{if $cf.config.conditionals}change_field_{$cf.id}();{/if}if (typeof(simulateCart)=='function')simulateCart('#cart1');" 
            variable="{$cf.variable}" 
    />
    <div class="slider-background"></div>
    <div class="tooltip-arrow"></div>
    <div class="tooltip">
        <div class="tooltip-top tooltip-left"></div><div class="tooltip-top tooltip-right"></div>
        <div class="tooltip-mid">
            <div class="slider-value"></div>
            <div class="slider-name"></div>
        </div>
        <div class="tooltip-bottom tooltip-left"></div><div class="tooltip-bottom tooltip-right"></div>
    </div>
    <h3>{$cf.name}</h3>
    </div>
    <script type="text/javascript">
        
        {if $cf.config.conditionals}
        {literal}
        function change_field_{/literal}{$cf.id}{literal}() {
            var newval = $("#custom_field_{/literal}{$cf.id}{literal}").val();var setvals={};{/literal}{foreach from=$cf.config.conditionals item=cd name=cond}var t = $('#custom_field_{$cd.target}'); {if $cd.condition=='less'}var b=(newval < {$cd.conditionval});{elseif $cd.condition=='more'}var b=(newval > {$cd.conditionval});{else}var b=(newval == {$cd.conditionval});{/if}{literal}if(b) {{/literal}{if $cd.action!='setval'}t.parent().{$cd.action}();{if $cd.action=='hide'}t.val(""); {/if}{else}setvals[t.attr('id')]="{$cd.targetval}";{/if}{literal}}{/literal}{/foreach}{literal}else {{/literal}{foreach from=$cf.config.conditionals item=cd name=cond} {if $cd.action=='hide'}$('#custom_field_{$cd.target}').parent().show();{/if}{/foreach}{literal}}
            for (var k in setvals) {
                var t= $('#'+k);
                t.val(setvals[k]);
                if(typeof (t.slider)=='function' && t.next().hasClass('slides')) {
                    t.next().slider('value',setvals[k]);
                    t.next().next().html(setvals[k]);
                }
            }
        };{/literal}
        conditioncheck(change_field_{$cf.id});
        {/if}
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
                    change: function(event, ui) {tooltiph(max,min,ui);},
                    slide: function( event, ui ) {tooltiph(max,min,ui);},
                    stop: function(event, ui) { tooltiph(max,min,ui);
                        $('#custom_field_{/literal}{$cf.id}{literal}').val(ui.value).trigger('change');
                    }
                });

                $('#horizontal_slider_{/literal}{$cf.id}{literal} .ui-slider-handle').each(function(){
                    tooltiph(max,min,{handle:this, value:value})
                });
                $('#horizontal_slider_{/literal}{$cf.id}{literal} .tooltip').draggable({ axis: 'x',
                    start: function(e,ui){dragh(e,ui)},
                    drag: function(e,ui){dragh(e,ui)},
                    stop: function(event, ui) { tooltiph(max,min,ui);
                        $('#custom_field_{/literal}{$cf.id}{literal}').val($('#horizontal_slider_{/literal}{$cf.id}{literal} .slider-background').slider('value')).trigger('change');
                    }
                });
            });
        {/literal}
    </script>
    {/foreach}
{/if}