<script src="{$template_dir}js/jquery-ui-1.8.2.custom.min.js" type="text/javascript"></script>
<link media="all" type="text/css" rel="stylesheet" href="{$orderpage_dir}flexislider/style.css" />
<form method="post" action="" id="submitform">
<input type="hidden" name="action" value="add"/>
{foreach from=$products[0].sliders item=slider}
<input type="hidden" name="slider[{$slider.code}]" value="{$slider.value}" id="h_{$slider.code}"/>
{/foreach}
<input type="hidden" name="id" value="{$products[0].id}" id="product_id"/>
</form>

<script type="text/javascript">
    {if $products[0]}
        {if $products[0].d!=0}
						var base=31;
					{elseif $products[0].w!=0}
						var base=4;
					{elseif $products[0].m!=0}
						var base=1;
					{elseif $products[0].q!=0}
						var base=0.25;
					{elseif $products[0].s!=0}
						var base=0.16;
					{elseif $products[0].a!=0}
						var base=0.08;
					{elseif $products[0].b!=0}
						var base=0.04;
					{elseif $products[0].t!=0}
						var base=0.02;
					{/if}
        {literal}	$(function() { {/literal}
        {foreach from=$products[0].sliders item=slider}

            $( "#s_{$slider.code}" ).slider({literal}
                    {
			range: "min",
			value: {/literal}{$slider.value},
			min: {$slider.min_value},
			max: {$slider.max_value}{literal},
			step: 1,
                        animate:true,
                          slide: function( event, ui ) {
                                set_custom();
                                set_slider("{/literal}{$slider.code}{literal}",parseInt(ui.value),true);
				$( "#s_{/literal}{$slider.code}{literal} .ui-slider-range" ).addClass('catched');
			},
			start: function( event, ui ) {
                            set_custom();
				$( "#s_{/literal}{$slider.code}{literal} .ui-slider-range" ).addClass('catched');
			},
			stop: function( event, ui ) {
                                set_slider("{/literal}{$slider.code}{literal}",parseInt(ui.value),true);
				$( "#s_{/literal}{$slider.code}{literal} .ui-slider-range" ).removeClass('catched');
                                $( "#h_{/literal}{$slider.code}{literal}" ).val(parseInt(ui.value));
			}

		}
             {/literal}
            );
        {/foreach}
           {literal}	});  {/literal}
    {/if}
    {literal}
	
	$(document).ready(function(){
            {/literal}
        {foreach from=$products[0].sliders item=slider}
		$(".{$slider.code}_s_list li span").click(function(){literal}
                        {{/literal}
                            set_custom();
			 $( "#s_{$slider.code}" ).slider( "option", "value", parseInt($(this).text()) );
			 set_slider("{$slider.code}",parseInt($(this).text()),true);
                         $( "#h_{$slider.code}" ).val(parseInt($(this).text()));
		{literal}});{/literal}
	  {/foreach}

	{literal}});

        function set_custom() {
            var cid = {/literal}{foreach from=$products item=p}{foreach from=$p.sliders item=slider}{if $slider.custom=='1'}{$p.id}{break}{/if}{/foreach}{/foreach};{literal}
            set_product(cid);
        }
        var slides={
             {/literal}
        {foreach from=$products[0].sliders item=slider name=ss}
            {$slider.code}: {literal} { {/literal}
                price:{$slider.price}
           {literal} } {/literal} {if !$smarty.foreach.ss.last},{/if}

	  {/foreach}

	{literal}
        };
        function set_slider(id,val,setprice) {
              $( ".summary"+id+" .sum").text(val);
                         //calculate price
                if(setprice) {
                var price = 0.00;
                $.each(  slides, function(code,vla){
                    price += vla.price * parseFloat($( "#s_"+code ).slider( "option", "value"));
                });
                    price = price / base;
               
              price= price.toFixed(2);
                 $('#current_price').text(price); 
             }
        }
        function set_product(id) {
            $('#product_id').val(id);
            $('#p-list a').removeClass('active');
            $('#p-'+id).addClass('active');
            if(p[id]) {
                $('#packagename').text(p[id].name);
                if(!p[id].custom) {
                    $.each(  p[id].sliders, function(i, n){
                         $( "#s_"+i ).slider( "option", "value", parseInt(n) );
                      set_slider(""+i+"",n,false);
                     });
                       $('#current_price').text(parseFloat(p[id].price).toFixed(2));
                         //set price
                }else {
                    var price=0;
                    $.each(  slides, function(code,vla){
                        price += vla.price * parseFloat($( "#s_"+code ).slider( "option", "value"));
                    });
                    price = price / base;
                    price= price.toFixed(2);
                    $('#current_price').text(price);
                }
            }
            return false;
        }
        {/literal}
            var p=new Array();
            {foreach from=$products item=p}
            p[{$p.id}]={literal}{
                    price:{/literal}{if $p.m}{$p.m}{else}{$p.d}{/if},
                    name:"{$p.name}",
                    custom:{foreach from=$p.sliders item=slider}{if $slider.custom=='1'}true{break}{else}false{break}{/if}{/foreach}{literal},
                    sliders: { {/literal} {foreach from=$p.sliders item=slider name=ss}{$slider.code}:{$slider.value}{if !$smarty.foreach.ss.last},{/if}{/foreach}{literal} }
                }{/literal};
            {/foreach}
	</script>
<div style="padding:20px 30px;background:#ffffff;">
{foreach from=$categories item=i name=categories name=cats}

{if $i.id == $current_cat} <strong>{$i.name}</strong> {if !$smarty.foreach.cats.last}|{/if}
{else} <a href="{$ca_url}cart&amp;step={$step}&amp;cat_id={$i.id}{if $addhosting}&amp;addhosting=1{/if}">{$i.name}</a> {if !$smarty.foreach.cats.last}|{/if}
{/if}
{/foreach}

{if $logged=='1'} | {if $current_cat=='addons'}<strong>{else}<a href="{$ca_url}cart&amp;step={$step}&amp;cat_id=addons">{/if}{$lang.prodaddons}{if $current_cat=='addons'}</strong>{else}</a>{/if}{/if}

</div>

<div class="zone-all">
	<div class="zone1">
		
		<div class="clear"></div>
		<ul class="option-link" id="p-list">
			{foreach from=$products item=p name=fe}
			<li><a href="#" {if $smarty.foreach.fe.first}class="active"{/if} onclick="return set_product({$p.id});" id="p-{$p.id}"><span>{$p.name}</span></a></li>
                        {/foreach}
		</ul>

	</div>
		<div class="clear"></div>
	<div>
		<div class="zone2" {foreach from=$categories item=i name=categories name=cats}{if $i.id == $current_cat && $i.description!=''}style="padding-top:25px;"{/if}{/foreach}>
                    {foreach from=$categories item=i name=categories name=cats}
{if $i.id == $current_cat && $i.description!=''}
<div class="slider-desc">{$i.description}</div>
{/if}
{/foreach}
                    
						
			
			<div class="zone-left">
				<div class="sliders">
                                        {foreach from=$products[0].sliders item=slider}
                                    <h3 class="slider-title">{$slider.name} ({$slider.unit})</h3>
					<div class="slider-pak"><div id="s_{$slider.code}" class="slide-content"></div></div>
					<div class="clear"></div>
					<ul class="desc-list ram_list {$slider.code}_s_list">
                                            {foreach from=$slider.steps item=v }
                                             <li><span>{$v}</span></li>
                                            {/foreach}
                                               
                                                    
                                                
					</ul>
					<div class="clear"></div>

                                        {/foreach}

				</div>
			</div>
			<div class="zone-right">
					<h3 class="zone-right-title" id="packagename">{$products[0].name}</h3>
					
                                         {foreach from=$products[0].sliders item=slider name=foo}
                                        <div class="summary summary{$slider.code}">
						<span class="sum">
							{$slider.value}
						</span>
						<br />
						<span>{$slider.name} ({$slider.unit})</span>
					 </div>
                                        {if !$smarty.foreach.foo.last}<div class="line"></div>{/if}
                                         {/foreach}
					
					 
					
					 <br />
					 <br />
					<div class="zone-right-title summary-title">{$currency.sign}<span id="current_price"><!--
                                        {if $products[0].d!=0}
						-->{$products[0].d|price:$currency:false}<!--
					{elseif $products[0].w!=0}
						-->{$products[0].w|price:$currency:false}<!--
					{elseif $products[0].m!=0}
						-->{$products[0].m|price:$currency:false}<!--
					{elseif $products[0].q!=0}
						-->{$products[0].q|price:$currency:false}<!--
					{elseif $products[0].s!=0}
						-->{$products[0].s|price:$currency:false}<!--
					{elseif $products[0].a!=0}
						-->{$products[0].a|price:$currency:false}<!--
					{elseif $products[0].b!=0}
						-->{$products[0].b|price:$currency:false}<!--
					{elseif $products[0].t!=0}
						-->{$products[0].t|price:$currency:false}<!--
					{elseif $products[0].p4!=0}
						-->{$products[0].p4|price:$currency:false}<!--
					{elseif $products[0].p5!=0}
						-->{$products[0].p5|price:$currency:false}<!--
					{/if}--></span> {$currency.code}	
                                        <span class="smallerspan"><!--
                                        {if $products[0].d!=0}
						-->{$lang.d}<!--
					{elseif $products[0].w!=0}
						-->{$lang.w}<!--
					{elseif $products[0].m!=0}
                         -->{$lang.m}<!--
					{elseif $products[0].q!=0}
						-->{$lang.q}<!--
					{elseif $products[0].s!=0}
						-->{$lang.s}<!--
					{elseif $products[0].a!=0}
						-->{$lang.a}<!--
					{elseif $products[0].b!=0}
						-->{$lang.b}<!--
					{elseif $products[0].t!=0}
						-->{$lang.t}<!--
				    {elseif $products[0].p4!=0}
						-->{$lang.p4}<!--
				    {elseif $products[0].p5!=0}
						-->{$lang.p5}<!--
					{/if}--></span>
                                        </div>
					<a href="#" onclick="$('#submitform').submit();return false" class="green-button"><span>{$lang.ordernow}</span></a>
			</div>

		</div>
	  </div>
</div>