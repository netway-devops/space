{foreach from=$custom item=cf}
	{if $cf.items && $cf.type!='input' && $cf.type!='textarea' && $cf.type!='datepicker'}
		<li id="poptio_{$cf.id}" class="poption_">
			<div class="productsT" >
				<span class="bL"></span>
				<div class="cProductS">
					<p>
						<span class="{if $cf.key!=''}b {$cf.key}{/if}"></span>
						<span class="s1">{$cf.name}</span>
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
					</p>
					<a href="#" onclick="return excol('{$cf.id}',this)">
						<span class="s1"></span>
						<span class="s2">{$lang.seemoreoptions}</span>
						<span class="s5" style="display:none">{$lang.close}</span>
					</a>
				</div>
				<span class="bR"></span>
			</div>

			<div class="cPForm" style="display:none" id="excol_{$cf.id}">
				<ul>
					{if $cf.type=='select' || $cf.type=='radio'}
						{foreach from=$cf.items item=cit name=fconf}
							<li >
								<input onchange="change_field_{$cf.id}();" type="radio" name="custom[{$cf.id}]" value="{$cit.id}" class="pconfig_" {if $cart_contents[1]}{if $cart_contents[1][$cf.id][$cit.id]}checked="checked"{/if}{elseif $smarty.foreach.fconf.first}checked="checked"{/if} />
								<span class="s1"><span>{$cit.name}</span> {if $cit.price!=0} (  + {$cit.price|price:$currency}){/if}</span>
							</li>
						{/foreach}
                        {if $cf.config.conditionals}<script type="text/javascript">
                            {*minified version from libs/configfields*}
                            var change_field_{$cf.id}=function(){literal}{var a={};{/literal}var b=$("#excol_{$cf.id} input:checked").val();var c=[];var d=[];{foreach from=$cf.config.conditionals item=cd name=cond}c.push([{$cd.val},"{$cd.action}","{$cd.target}" {if $cd.targetval},"{$cd.targetval}"{/if}]);{/foreach}{literal}var e=null;for(var f=0;f<c.length;f++){e=$("#custom_field_"+c[f][2]);if(b==c[f][0]){if(c[f][1]=="hide")e.val("").parents('.poption_').hide();else if(c[f][1]=="show")e.parents('.poption_').show();else if(c[f][1]=="setval")a[e.attr("id")]=c[f][3];d[c[f][2]]=1}else if(d[c[f][2]]==undefined){if(c[f][1]=="hide")e.parents('.poption_').show();else if(c[f][1]=="show")e.val("").parents('.poption_').hide()}}for(var g in a){var e=$("#"+g);e.val(a[g]);if(typeof e.slider=="function"&&e.next().hasClass("slides")){e.next().slider("value",a[g]);e.next().next().html(a[g])}}}{/literal}
                            setTimeout(change_field_{$cf.id},200);
                        </script>{/if}
					{elseif $cf.type=='checkbox'}
						{foreach from=$cf.items item=cit name=fconf}
							<li >
								<input onchange="change_field_{$cf.id}();" type="checkbox" name="custom[{$cf.id}][{$cit.id}]" value="1" class="pconfig_" {if $cart_contents[1]}{if $cart_contents[1][$cf.id][$cit.id]}checked="checked"{/if}{elseif $smarty.foreach.fconf.first}checked="checked"{/if} >
								<span class="s1"><span>{$cit.name}</span> {if $cit.price!=0} (  + {$cit.price|price:$currency}){/if}</span>
							</li>
						{/foreach}
                        {if $cf.config.conditionals}<script type="text/javascript">
                            {*minified version from libs/configfields*}
                            var change_field_{$cf.id}=function(){literal}{var a={};{/literal}var b=$("#excol_{$cf.id} input:checked").val();var c=[];var d=[];{foreach from=$cf.config.conditionals item=cd name=cond}c.push([{$cd.val},"{$cd.action}","{$cd.target}" {if $cd.targetval},"{$cd.targetval}"{/if}]);{/foreach}{literal}var e=null;for(var f=0;f<c.length;f++){e=$("#custom_field_"+c[f][2]);if(b==c[f][0]){if(c[f][1]=="hide")e.val("").parents('.poption_').hide();else if(c[f][1]=="show")e.parents('.poption_').show();else if(c[f][1]=="setval")a[e.attr("id")]=c[f][3];d[c[f][2]]=1}else if(d[c[f][2]]==undefined){if(c[f][1]=="hide")e.parents('.poption_').show();else if(c[f][1]=="show")e.val("").parents('.poption_').hide()}}for(var g in a){var e=$("#"+g);e.val(a[g]);if(typeof e.slider=="function"&&e.next().hasClass("slides")){e.next().slider("value",a[g]);e.next().next().html(a[g])}}}{/literal}
                            setTimeout(change_field_{$cf.id},200);
                        </script>{/if}
					{elseif $cf.type=='qty'}
						<li > 
							{foreach from=$cf.items item=cit}  
                                <input name="custom[{$cf.id}][{$cit.id}]" class="styled pinput_" size="2"  value="{if $cart_contents[1][$cf.id]}{foreach from=$cart_contents[1][$cf.id] item=cit}{$cit.qty}{/foreach}{else}0{/if}" />
								<span class="s1"><span>{$cit.name}</span> {if $cit.price!=0}(+ {$cit.price|price:$currency}){/if}</span>
							{/foreach}
                            {if $cf.config.conditionals}
                            <script type="text/javascript">{literal}
                                function change_field_{/literal}{$cf.id}{literal}() {
                                    var newval = $("#custom_field_{/literal}{$cf.id}{literal}").val();var setvals={};{/literal}{foreach from=$cf.config.conditionals item=cd name=cond}var t = $('#custom_field_{$cd.target}'); {if $cd.condition=='less'}var b=(newval < {$cd.conditionval});{elseif $cd.condition=='more'}var b=(newval > {$cd.conditionval});{else}var b=(newval == {$cd.conditionval});{/if}{literal}if(b) {{/literal}{if $cd.action!='setval'}t.parents('.poption_').{$cd.action}();{if $cd.action=='hide'}t.val(""); {/if}{else}setvals[t.attr('id')]="{$cd.targetval}";{/if}{literal}}{/literal}{/foreach}{literal}else {{/literal}{foreach from=$cf.config.conditionals item=cd name=cond} {if $cd.action=='hide'}$('#custom_field_{$cd.target}').parents('.poption_').show();{elseif $cd.action=='show'}$('#custom_field_{$cd.target}').parents('.poption_').hide();{/if}{/foreach}{literal}}
                                    for (var k in setvals) {var t= $('#'+k);t.val(setvals[k]);if(typeof (t.slider)=='function' && t.next().hasClass('slides')) {t.next().slider('value',setvals[k]);t.next().next().html(setvals[k]);}}};{/literal}
							</script>
                             {/if}
						</li>
					{elseif $cf.type=='slider'}
						<li >{assign value=$cart_contents var=contents}
							{include file=$cf.configtemplates.cart}
							<script type="text/javascript">
								{literal}
								$(function(){
									$('#excol_{/literal}{$cf.id}{literal} .slides').css('width','85%');
									$('#custom_field_{/literal}{$cf.id}{literal}').addClass('pinput_').change(function(){
										$(this).blur();
									});
								});
								{/literal}
                                {if $cf.config.conditionals}
                                    {literal}
                                    function change_field_{/literal}{$cf.id}{literal}() {
                                        var newval = $("#custom_field_{/literal}{$cf.id}{literal}").val();var setvals={};{/literal}{foreach from=$cf.config.conditionals item=cd name=cond}var t = $('#custom_field_{$cd.target}'); {if $cd.condition=='less'}var b=(newval < {$cd.conditionval});{elseif $cd.condition=='more'}var b=(newval > {$cd.conditionval});{else}var b=(newval == {$cd.conditionval});{/if}{literal}if(b) {{/literal}{if $cd.action!='setval'}t.parents('.poption_').{$cd.action}();{if $cd.action=='hide'}t.val(""); {/if}{else}setvals[t.attr('id')]="{$cd.targetval}";{/if}{literal}}{/literal}{/foreach}{literal}else {{/literal}{foreach from=$cf.config.conditionals item=cd name=cond} {if $cd.action=='hide'}$('#custom_field_{$cd.target}').parents('.poption_').show();{elseif $cd.action=='show'}$('#custom_field_{$cd.target}').parents('.poption_').hide();{/if}{/foreach}{literal}}
                                        for (var k in setvals) {var t= $('#'+k);t.val(setvals[k]);if(typeof (t.slider)=='function' && t.next().hasClass('slides')) {t.next().slider('value',setvals[k]);t.next().next().html(setvals[k]);}}};{/literal}
                                {/if}
							</script>
						</li>
					{else}
						<li > {include file=$cf.configtemplates.cart}</li>
					{/if}
				</ul>
			</div>
		</li>
	{/if}
{/foreach}
{foreach from=$custom item=cf}
	{if $cf.items && ($cf.type=='input' || $cf.type=='textarea' || $cf.type=='datepicker')}
		<li id="poptio_{$cf.id}" class="poption_">
			<ul class="cfl">
				{if $cf.type=='textarea'}
					{foreach from=$cf.items item=cit}
						<li class="d-label">
							<span class="{if $cf.key!=''}b {$cf.key}{/if}"></span> {$cf.name}
						</li>
						<li class="input">
							<textarea name="custom[{$cf.id}][{$cit.id}]" id="custom_field_{$cf.id}"  class="styled pinput_" style="width:99%" >{$cart_contents[1][$cf.id][$cit.id].val}</textarea> 
						</li>
					{/foreach}
				{elseif $cf.type=='input'}
					{foreach from=$cf.items item=cit}
						<li class="d-label">
							<span class="{if $cf.key!=''}b {$cf.key}{/if}"></span> {$cf.name}
						</li>
						<li class="input">
							<input name="custom[{$cf.id}][{$cit.id}]" id="custom_field_{$cf.id}"   value="{$cart_contents[1][$cf.id][$cit.id].val}"  class="styled pinput_" type="text" />
						</li>
					{/foreach}
				{else}
					{assign value=$cart_contents var=contents}
					<li class="d-label">
						<span class="{if $cf.key!=''}b {$cf.key}{/if}"></span> {$cf.name}
					</li>
					<li class="input"> {include file=$cf.configtemplates.cart}</li>
				{/if}
				<li class="clear" style="float:none"><br/></li>
			</ul>
		</li>
	{/if}
{/foreach}