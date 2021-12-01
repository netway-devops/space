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
                id="custom_field_{$cf.id}"  
                onchange="if (typeof(simulateCart)=='function')simulateCart('#cart0');" 
                variable="{$cf.variable}" 
            />
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
            {if $cf.config.conditionals}
            {literal}
            function change_field_{/literal}{$cf.id}{literal}() {
                var newval = $("#custom_field_{/literal}{$cf.id}{literal}").val();var setvals={};{/literal}{foreach from=$cf.config.conditionals item=cd name=cond}var t = $('#custom_field_{$cd.target}'); {if $cd.condition=='less'}var b=(newval < {$cd.conditionval});{elseif $cd.condition=='more'}var b=(newval > {$cd.conditionval});{else}var b=(newval == {$cd.conditionval});{/if}{literal}if(b) {{/literal}{if $cd.action!='setval'}t.parents('.item').{$cd.action}();{if $cd.action=='hide'}t.val(""); {/if}{else}setvals[t.attr('id')]="{$cd.targetval}";{/if}{literal}}{/literal}{/foreach}{literal}else {{/literal}{foreach from=$cf.config.conditionals item=cd name=cond} {if $cd.action=='hide'}$('#custom_field_{$cd.target}').parents('.item').show();{elseif $cd.action=='show'}$('#custom_field_{$cd.target}').parents('.item').hide();{/if}{/foreach}{literal}}
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