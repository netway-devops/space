<script src="{$template_dir}js/jquery-ui-1.8.2.custom.min.js" type="text/javascript"></script>
<script type="text/javascript">
	{literal}
	$(document).ready(function(){
	
		
		// Slider
                    $('.rating .text').each(function(n){
                        $(this).click(function(){
                            $('#slider').slider("value", (30 + (n*170)) );
                        });
                    });
                         $('.rating .stars').each(function(n){
                        $(this).click(function(){
                            $('#slider').slider("value", (30 + (n*170)) );
                        });
                    });
                function fnslide( ) {
				var opt = Math.floor($('#slider').slider( "value" )/144);
				var index = 0;
                              
				switch(opt){

					case 0: index = 0;
							break;
					case 1: index = 1;
							break;
					case 2: index = 2;
					
                                    break;
                                        default: 
					case 3: index = 3;
							break;
				}

				$(".option .text").removeClass("selected");
				$("#txt_"+(index+1)).addClass("selected");
				$(".price").hide().eq(index).show();
				$(".ordernow").hide().eq(index).show();
				$(".pr_pr").hide().eq(index).show();
                                    $(".l_ul").hide().eq(index).show();
                }
		$('#slider').slider({
			range: "min",
			value: 1,
			min: 1,
			max: 576,
			animate:true,
			change: fnslide
		});

	});
{/literal}
</script>

<link media="all" type="text/css" rel="stylesheet" href="{$orderpage_dir}_simple_slider/style.css" />
<link media="all" type="text/css" rel="stylesheet" href="{$orderpage_dir}slider/style.css" />
<div class="zone-all">
<h1 class="title-brow">{$lang.browseprod}</h1>
<div class="zone2">
			<ul class="menu-tabs">
				<li class="first">
                                    {foreach from=$categories item=i name=categories}
                                        {if $i.id == $current_cat} <a href="{$ca_url}cart/{$i.slug}/&amp;step={$step}{if $addhosting}&amp;addhosting=1{/if}">{$i.name}</a>{/if}
                                    {/foreach}
				</li>

                                {foreach from=$categories item=i name=categories name=cats}

{if $i.id != $current_cat}
<li class="{if $smarty.foreach.cats.last}last{/if}"><a href="{$ca_url}cart/{$i.slug}/&amp;step={$step}{if $addhosting}&amp;addhosting=1{/if}">{$i.name}</a></li>
{/if}
{/foreach}

			</ul>
			<div class="zone-belka"><div></div></div>
			<div class="zone-left">		
<div class="tab-container clearfix">  
	<div class="tab-content">
		<div class="rating clearfix">
      {foreach from=$products item=i name=loop}      
        <div class="option num{$smarty.foreach.loop.iteration}">
  				<div class="text {if $smarty.foreach.loop.iteration == 1}selected{/if}" id="txt_{$smarty.foreach.loop.iteration}">{$i.name}</div>
  				<div class="stars"></div>
  			</div>            
      {/foreach}					
		</div>
		
    <div class="slider-out">
			<div class="slider">
				<div id="slider"></div>
			</div>
		</div>
		
		<div class="info-out">
			<div class="info clearfix">
                            {foreach from=$products item=i name=loop key=k}
                                                    {specs var="awords" string=$i.description}
                                                   {/foreach}
                                                   {foreach from=$awords item=j name=lla key=k}
                                                    <ul class="l_ul" {if $k!='0'}style="display:none"{/if}>
                                        {if $j.specs} 
                                                  {foreach from=$j.specs item=i name=ll key=ka}

                                        <li class="l_{$ka}">
						<div class="title">{$i[0]}</div>
						<div class="value" id="disk_val">{$i[1]}</div>
					</li>
                                        {if !$smarty.foreach.ll.last}<li class="sep"></li>{/if}
                                              
                                                        {/foreach}        {/if}</ul>{/foreach}


				
			</div>
		</div>

	</div>
	<div class="price-box">
		<div class="price-inner">
			<div class="title">{$lang.pricinginfo}</div>
			<div class="price-out ">
				
                
           {foreach from=$products item=i name=loop key=k}
			<div class="price"  {if $k!='0'}style="display:none"{/if}>
        
        {if $i.paytype=='Free'}
					{$lang.Free}
				{elseif $i.paytype=='Once'}
				<sup>{$currency.sign}</sup>{$i.m|number_format:2}
				{else}
				<sup>{$currency.sign}</sup>
          <span id="price_val">
          <!--
					{if $i.d!=0}					
						-->{$i.d|price:$currency:false}<!--
					{elseif $i.w!=0}
						-->{$i.w|price:$currency:false}<!--
					{elseif $i.m!=0}
						-->{$i.m|price:$currency:false}<!--
					{elseif $i.q!=0}
						-->{$i.q|price:$currency:false}<!--
					{elseif $i.s!=0}
						-->{$i.s|price:$currency:false}<!--
					{elseif $i.a!=0}
						-->{$i.a|price:$currency:false}<!--
					{elseif $i.b!=0}
						-->{$i.b|price:$currency:false}<!--
					{elseif $i.t!=0}
						-->{$i.t|price:$currency:false}<!--
					{elseif $i.p4!=0}
						-->{$i.p4|price:$currency:false}<!--
					{elseif $i.p5!=0}
						-->{$i.p5|price:$currency:false}<!--
					{/if}
					-->
					</span>
				{/if}	</div>
				{/foreach}
          
				</div>
			
			
			<div class="text">
			{foreach from=$products item=i name=loop key=k}
				<span class="pr_pr" {if $k!='0'}style="display:none"{/if}>
			{if $i.paytype=='Free'}{$lang.Free}{elseif $i.paytype=='Once'}{$currency.code} {$lang.once}
			{else} {$currency.code}
				{if $i.d!=0}{$lang.d} 
				{elseif $i.w!=0}{$lang.w} 
				{elseif $i.m!=0}{$lang.m}
				{elseif $i.q!=0}{$lang.q}
				{elseif $i.s!=0}{$lang.s}
				{elseif $i.a!=0}{$lang.a}
				{elseif $i.b!=0}{$lang.b}
				{elseif $i.t!=0}{$lang.t}
				{elseif $i.p4!=0}{$lang.p4}
				{elseif $i.p5!=0}{$lang.p5}
				{/if}
			{/if}</span>{/foreach}
      </div>
			{foreach from=$products item=i name=loop key=k}<a class="button ordernow" href="{$ca_url}cart&amp;action=add&amp;id={$i.id}&amp;cat_id={$current_cat}" {if $k!='0'}style="display:none"{/if}><span>{$lang.ordernow}</span></a>{/foreach}
		</div>
	</div>
</div>
			</div>
				<div class="zone-belka-dol"><div></div></div>
	  </div>

</div>
	












