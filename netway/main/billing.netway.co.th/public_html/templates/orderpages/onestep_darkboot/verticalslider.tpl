{counter name=vsliderc print=false assign=vslider start=0}
{foreach from=$custom item=cf name=vsliders}
    {if $cf.type == 'slider'}
        {if $vslider == $slider_num}
            {counter name=slidercounter start=0 assign=sliders}
            {foreach from=$custom item=cf}
                {if $sliders == $smarty.foreach.vsliders.index && $cf.items && $cf.type == 'slider'}
                    {foreach from=$cf.items item=cit}
                    <div class="slider-box" id="vertical_slider_{$cf.id}">
                        <input 
                            name="custom[{$cf.id}][{$cit.id}]"  
                            value="{if $contents[1][$cf.id][$cit.id].qty}{$contents[1][$cf.id][$cit.id].qty}{else}{$cf.config.initialval}{/if}" 
                            type="text" 
                            style="display:none" 
                            id="custom_field_{$cf.id}"  
                            onchange="{if $cf.config.conditionals}change_field_{$cf.id}();{/if}if (typeof(simulateCart)=='function')simulateCart('#cart0');" 
                            variable="{$cf.variable}" 
                            max="{$cf.config.maxvalue}"
                            min="{$cf.config.minvalue}"
                            step="{$cf.config.step}"
                            rel="{$cf.id}"
                        />
                        <div class="slider-bg center">
                            <div id="slider-{$cf.id}"></div>
                        </div>
                        <div class="slider-shadow center"></div>
                        <div class="clearfix automargin">
                            <div class="left-column left">
                                <p class="text-center">{$cf.name}</p>
                                <div class="slider-value center">
                                    <span id="amount-{$cf.id}" class="text-center">{if $contents[1][$cf.id][$cit.id].qty}{$contents[1][$cf.id][$cit.id].qty}{else}{$cf.config.initialval}{/if}</span>
                                </div>
                            </div>
                            <div class="right-column left">
                                <div class="slider-buttons-border">
                                    <div class="slider-outline-mask">
                                        <div class="slider-outline">
                                            <div class="slider-button-mask center">
                                                <div class="slider-buttons">
                                                    <div id="slider-{$cf.id}-up" class="button-up">
                                                        <span class="button-up-arrow"></span>
                                                    </div>
                                                    <div id="slider-{$cf.id}-down" class="button-down">
                                                        <span class="button-down-arrow"></span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
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
                    </script>
                    {/foreach}
                {/if}
                {counter name=slidercounter}
            {/foreach}
            
        {/if}
        {counter name=vsliderc}
    {/if}
{/foreach}