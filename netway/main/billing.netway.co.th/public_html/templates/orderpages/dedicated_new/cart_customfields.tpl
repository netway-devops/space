	
{if $cf.items && $cf.type!='input' && $cf.type!='textarea' && $cf.type!='datepicker'}
    <div id="poptio_{$cf.id}" class="cart-option clearfx">
        <div class="option-title">
            <span class="{if $cf.key!=''}b {$cf.key}{/if}"></span>
            <a href="#" onclick="excol('{$cf.id}',this); return false;">
                <span class="s2">{$lang.seemoreoptions}</span>
                <span class="s5" style="display:none">{$lang.close}</span>
            </a>
            <strong>{$cf.name}:</strong>
            <span class="s2 picked_option">
                {if $cart_contents[1] && $cart_contents[1][$cf.id]}
                    {foreach from=$cart_contents[1][$cf.id] item=cit}
                        {$cit.itname}{break}
                    {/foreach}
                {elseif $cf.type=='qty' || $cf.type=='check'}{$lang.none}
                {else}
                    {foreach from=$cf.items item=cit}
                        {$cit.name}{break}
                    {/foreach}
                {/if}
            </span>

            
        </div>

        <div class="option-list" style="display:none" id="excol_{$cf.id}">
            <div class="hr"></div>
            <ul>
                {if $cf.type=='select' || $cf.type=='radio'}
                    {foreach from=$cf.items item=cit name=fconf}
                        <li >
                            <input type="radio" name="custom[{$cf.id}]" id="custom_field_{$cf.id} custom_field_{$cf.id}" {if $cf.config.conditionals}onclick="$('.custom_field_{$cf.id}').fieldLogic();"{/if} value="{$cit.id}" class="pconfig_ custom_field_{$cf.id}" {if $cart_contents[1]}{if $cart_contents[1][$cf.id][$cit.id]}checked="checked"{/if}{elseif $smarty.foreach.fconf.first}checked="checked"{/if} />
                            <span class="s1"><span>{$cit.name}</span> {if $cit.price!=0} (  + {$cit.price|price:$currency}){/if}</span>
                        </li>
                    {/foreach}
                {elseif $cf.type=='checkbox'}
                    {foreach from=$cf.items item=cit name=fconf}
                        <li >
                            <input type="checkbox" name="custom[{$cf.id}][{$cit.id}]" id="custom_field_{$cf.id}" value="1" class="pconfig_ custom_field_{$cf.id}" {if $cart_contents[1]}{if $cart_contents[1][$cf.id][$cit.id]}checked="checked"{/if}{elseif $smarty.foreach.fconf.first}checked="checked"{/if} >
                            <span class="s1"><span>{$cit.name}</span> {if $cit.price!=0} (  + {$cit.price|price:$currency}){/if}</span>
                        </li>
                    {/foreach}
                {elseif $cf.type=='qty'}
                    
                    <li > 
                        {foreach from=$cf.items item=cit}  
                        <input name="custom[{$cf.id}][{$cit.id}]" id="custom_field_{$cf.id}"  class="styled pinput_ custom_field_{$cf.id}" size="2" onchange="{if $cf.config.conditionals}$('#custom_field_{$cf.id}').fieldLogic();{/if}simulateCart();" value="{if $cart_contents[1][$cf.id]}{foreach from=$cart_contents[1][$cf.id] item=cit}{$cit.qty}{/foreach}{else}0{/if}" />
                        <span class="s1"><span>{$cit.name}</span> {if $cit.price!=0}(+ {$cit.price|price:$currency}){/if}</span>
                        {/foreach}
                    </li>
                {elseif $cf.type=='slider'}
                    <li >{assign value=$cart_contents var=contents}
                        {foreach from=$cf.items item=cit}
                        <input class="custom_field_{$cf.id}" name="custom[{$cf.id}][{$cit.id}]" value="{if $contents[1][$cf.id][$cit.id].qty}{$contents[1][$cf.id][$cit.id].qty}{else}{$cf.config.initialval}{/if}" 
                               type="text" style="display:none" id="custom_field_{$cf.id}"  
                               onchange="{if $cf.config.conditionals}$('.custom_field_{$cf.id}').fieldLogic();{/if}if (typeof(simulateCart)=='function')simulateCart('{if $cf_opt_formId && $cf_opt_formId != ''}{$cf_opt_formId}{else}#cart3{/if}');" variable="{$cf.variable}" />
                        <div id="custom_slider_{$cit.id}" class="slides left" style="margin:6px 20px 0px 20px !important;float:left !important;width:370px;">
                            <div class="sl"></div><div class="sr"></div>
                        </div>
                        <div id="custom_slider_{$cit.id}_value_indicator" style="font-weight:bold;font-size:14px;padding-top:3px;">{if $contents[1][$cf.id][$cit.id].qty}{$contents[1][$cf.id][$cit.id].qty}{else}{$cf.config.initialval}{/if}</div>

                        {if $cit.price!=0}<span style="padding-left:20px"> x {$cit.price|price:$currency}</span>{/if}
                        <script type="text/javascript">
                            {literal}
                                setTimeout(function(){
                                    var s= $('#custom_slider_{/literal}{$cit.id}{literal}');
                                    var sval= $('#custom_field_{/literal}{$cf.id}{literal}');
                                    var svalind= $('#custom_slider_{/literal}{$cit.id}{literal}_value_indicator');
                                    if(typeof($('#slider').slider)!='function'){
                                        s.hide();
                                        sval.show();
                                        svalind.hide();
                                        return false;
                                    }

                                    var maxval = parseInt('{/literal}{$cf.config.maxvalue}{literal}') || 100 ;
                                    var minval = parseInt('{/literal}{$cf.config.minvalue}{literal}') || 0;
                                    var stepval = parseInt('{/literal}{$cf.config.step}{literal}') || 1 ;
                                    var initialval=parseInt('{/literal}{$cf.config.initialval}{literal}') || 0;

                                    s.width(s.parent().width()-90).slider({
                                        min: minval ,max: maxval , value: sval.val() || initialval,step:stepval,range:"min", animate: true, stop:function(e,ui){
                                        var x = Math.floor(s.slider( "value" ));
                                        sval.val(x).trigger('change');
                                        svalind.html(x);
                                    }});
                                },200);
                                $(function(){
                                    $('#excol_{/literal}{$cf.id}{literal} .slides').css('width','85%');
                                    $('#custom_field_{/literal}{$cf.id}{literal}').addClass('pinput_').change(function(){
                                        $(this).blur();
                                    });
                                });
                            {/literal}
                        </script>
                        {/foreach}
                    </li>
                {else}
                    <li > {include file=$cf.configtemplates.cart}</li>
                {/if}
            </ul>
        </div>
    </div>
{/if}
{if $cf.items && ($cf.type=='input' || $cf.type=='textarea' || $cf.type=='datepicker')}
    <div id="poptio_{$cf.id}" class="cart-option clearfix">
        <div class="option-title">
            <span class="{if $cf.key!=''}b {$cf.key}{/if}"></span>
            <strong>{$cf.name}:</strong>

        </div>
        <div id="poptio_{$cf.id}">
            {if $cf.type=='textarea'}
                {foreach from=$cf.items item=cit}
                    <span class="{if $cf.key!=''}b {$cf.key}{/if}"></span>
                    <textarea name="custom[{$cf.id}][{$cit.id}]" id="custom_field_{$cf.id}"  class="styled pinput_ custom_field_{$cf.id}" style="width:99%" >{$cart_contents[1][$cf.id][$cit.id].val}</textarea> 
                {/foreach}
            {elseif $cf.type=='input'}
                {foreach from=$cf.items item=cit}
                    <span class="{if $cf.key!=''}b {$cf.key}{/if}"></span>
                    <input name="custom[{$cf.id}][{$cit.id}]" id="custom_field_{$cf.id} custom_field_{$cf.id}"   value="{$cart_contents[1][$cf.id][$cit.id].val}"  class="styled pinput_" type="text" />
                {/foreach}
            {else}
                {assign value=$cart_contents var=contents}
                <span class="{if $cf.key!=''}b {$cf.key}{/if}"></span>
                {include file=$cf.configtemplates.cart}
            {/if}

        </div>
    </div>
{/if}
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