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
                                    {if $opconfig.showothercat=='1' || !$opconfig}
                                {foreach from=$categories item=i name=categories name=cats}

{if $i.id != $current_cat}
<li class="{if $smarty.foreach.cats.last}last{/if}"><a href="{$ca_url}cart/{$i.slug}/&amp;step={$step}{if $addhosting}&amp;addhosting=1{/if}">{$i.name}</a></li>
{/if}
{/foreach}{/if}

			</ul>
			<div class="zone-belka"><div></div></div>
			<div class="zone-left">		
				<div class="sliders">
					<div class="slider-head">
						 {if count($currencies)>1}<form action="" method="post" id="currform">
<input name="action" type="hidden" value="changecurr"><span class="help-slid">
							<span class="help-slid1">
								<span class="quest">
								</span>
								<span>
							  


{$lang.Currency} <select name="currency" class="styled span2" onchange="$('#currform').submit()"  >
{foreach from=$currencies item=crx}
<option value="{$crx.id}" {if !$selcur && $crx.id==0}selected="selected"{elseif $selcur==$crx.id}selected="selected"{/if}>{if $crx.code}{$crx.code}{else}{$crx.iso}{/if}</option>
{/foreach}
</select>


								</span>
							</span>
						</span></form>{/if}
						<h2 class="title-brow1">{if $opconfig}{$opconfig.chooseplantext}{else}{$lang.chooseyourplan}{/if}</h2>
					</div>
					<div class="clear"></div>

					<div class="slider-pak" style="width:744px"><div id="slider" class="slide-content" ></div></div>
					<div class="clear"></div>
					<ul class="desc-list ram_list" style="width:820px">
                                            {foreach from=$products item=i name=loop key=k}
                                            <li style="width: {math equation="(820/x) - 1" x=$products|@count}px" {if $smarty.foreach.loop.first}class="active"{/if}><span >{$i.name}</span></li>
                                            {/foreach}
						
					
					</ul>
					<div class="linia"></div>
					<div class="configuration">
						<div class="kol-1">
							<h2 class="con-title">{if $opconfig}{$opconfig.configtext}{else}{$lang.yourconfiguration}:{/if}</h2>
							<div class="clear"></div>
							{foreach from=$products item=i name=loop key=k}
								{specs var="awords" string=$i.description}
							{/foreach}
							{foreach from=$awords item=j name=lla key=k}
							<div class="list-conf" {if $k!='0'}style="display:none"{/if}>
								
								{if $j.specs}
								<div class="kol-1-4">  <div class="bar-top"><div></div></div>   <div class="clear"></div>
									{foreach from=$j.specs item=i name=ll key=ka}
									<div class="{if $smarty.foreach.ll.first}kolz1{else}kolz2{/if} {if $smarty.foreach.ll.last} kolz_last{/if}">
										{$i[0]}: <br />
										<div>{$i[1]}</div>
									</div>
									{/foreach}        
									<div class="bar-bottom"></div>
								</div>{/if}	
							</div>
							{/foreach}
						</div>

                                            
						<div class="kol-2">
							<h2 class="con-title con-title1">{$lang.totalprice}:</h2>													
							<div class="clear"></div>
                                                         {foreach from=$products item=i name=loop key=k}
			<div class="pricetag" id="price_{$i.id}" {if $k!='0'}style="display:none"{/if}>
				<div class="total ">
				{if $i.paytype=='Free'}
					{$lang.Free}
				{elseif $i.paytype=='Once'}
				<sup>{$currency.sign}</sup>{$i.m|number_format:2}
				{else}
				<sup>{$currency.sign}</sup><!--
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
				{/if}
<span class="period">
				{if $i.paytype=='Free'}{$lang.Free}{elseif $i.paytype=='Once'}{$lang.once}{else}
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
				{/if}</span>
				</div>
				

					<a href="{$ca_url}cart&amp;action=add&amp;id={$i.id}&amp;cat_id={$current_cat}" class="button-order"><span>{$lang.ordernow}</span></a>
			</div>{/foreach}
						</div>
                                               
                			
					</div>
				</div>
			</div>
				<div class="zone-belka-dol"><div></div></div>

                                 {foreach from=$awords item=j name=lla key=k}
                               
                                <div class="features" {if $k!='0'}style="display:none"{/if}>
                                   {if $j.features}  <h2 class="title-brow title-brow2">{if $opconfig}{$opconfig.featurestext}{else}{$lang.hotfeatures}!{/if}</h2>
                                    <div class="linia linia-bottom"></div>
                                   {$j.features}  {/if}
                                </div>
                              
                                {/foreach}
	  </div>





	{if $products}





<script src="{$template_dir}js/jquery-ui-1.8.2.custom.min.js" type="text/javascript"></script>

<script type="text/javascript">
{literal}

function bindSlider() {
	$('.ram_list li').each(function(n){

                $(this).width(Math.floor($(this).width()));
		$(this).click(function(){
			scrollToEl(n);
                            $('.ram_list li').removeClass('active');
                             $(this).addClass('active');
			return false;		
		});
		
	});
	
	$('#slider').width(745);
	$('#slider').slider({min: 0, max: $('.ram_list li').length-1+0.4, value: 0,step:0.1,range:"min", animate: true, stop:function(e,ui){
			slidCb(true);
			
	},change: function(e, ui){	
			slidCb(false);
	},slide: function(e, ui){	
			slidCb(false);
	}
	});
}
function slidCb(magic) {
var x = Math.floor($('#slider').slider( "value" ));
			$('.ram_list li').removeClass('active');
			$('.pricetag').hide().eq(x).show();
                        $('.features').hide().eq(x).show();
			$('.list-conf').hide().eq(x).show();
                            $('.ram_list li').removeClass('active').eq(x).addClass('active');
			
}
function scrollToEl(ele) {
	$('#slider').slider("value", ele);

}
appendLoader('bindSlider');
{/literal}
</script>

	

	{/if}
	

</div>
	