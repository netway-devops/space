<link media="all" type="text/css" rel="stylesheet" href="{$orderpage_dir}fourbox2/style.css" />
<script src="{$orderpage_dir}fourbox2/jquery-ui-1.8.16.custom.min.js" type="text/javascript"></script>
<script src="{$orderpage_dir}fourbox2/scripts_box.js" type="text/javascript"></script>
<div id="cContent">
	<h3 class="title-b">{$lang.browseprod}</h3>
	<ul class="menu-prod">
		<li class="first active">
			{foreach from=$categories item=i name=categories}
				{if $i.id == $current_cat} <a href="{$ca_url}cart/{$i.slug}/&amp;step={$step}{if $addhosting}&amp;addhosting=1{/if}">{$i.name}</a>{/if}
			{/foreach}
		</li>
		{foreach from=$categories item=i name=categories name=cats}
			{if $i.id != $current_cat}
			<li class="{if $smarty.foreach.cats.last && !$logged}last{/if}"><a href="{$ca_url}cart/{$i.slug}/&amp;step={$step}{if $addhosting}&amp;addhosting=1{/if}">{$i.name}</a></li>
			{/if}
		{/foreach}
		{if $logged=='1'} <li class="last"><a href="{$ca_url}cart&amp;step={$step}&amp;cat_id=addons">{$lang.prodaddons}</a></li>{/if}
	</ul>	
	<div class="nw-host-border"></div>
	
	<div class="row-fluid">
		<div class="span12"><div><span class="txtdarkblue">Netway Communication</span> มีรายการ Hosting Plan ที่ตอบโจทย์ความต้องการที่หลากหลายของคุณ และเหมาะสำหรับทุกงบประมาณและขนาดขององค์กร หากคุณมี Promotional Code อยู่แล้วในมือ โปรดเตรียมไว้เพื่อใส่ลงในช่อง Promotional Code ในตอนที่คุณสั่งซื้อ </div></div>
	</div>
	
	<div class="row-fluid">
		<div class="cart-host">
			<div class="cart-host-title">ขั้นตอนการสั่งซื้อ</div>
			<div class="cart-host-content">
				<div class="span3 acenter"><img src="{$template_dir}images/hosting-cart.png" width="146" height="117" alt="hosting" /></div>
				<div class="span8">
					<div><img src="{$template_dir}images/hosting-arrow.png" width="16" height="16" alt="" /> เลือก Hosting Plan</div>
					<div><img src="{$template_dir}images/hosting-arrow.png" width="16" height="16" alt="" /> ตรวจสอบราคาและใส่ Promotional Code</div>
					<div><img src="{$template_dir}images/hosting-arrow.png" width="16" height="16" alt="" /> คลิก Order</div>
					<div><img src="{$template_dir}images/hosting-arrow.png" width="16" height="16" alt="" /> ชำระเงิน (<a href="{$ca_url}payment">ช่องทางการชำระเงินคลิกที่นี่</a>)</div>
				</div>
				<br clear="all" />
			</div>
		</div>
		<div class="span12 aright"><span class="star">ราคาดังกล่าว ยังไม่รวมภาษีมูลค่าเพิ่ม 7% &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></div>	
	</div>
    <div class="row-fluid acenter">
    	<div class="span8">
            <h3 class="clearit title-select">
            	<span>เลือก </span>
                {foreach from=$categories item=i name=categories}
                    {if $i.id == $current_cat} <span class="txtgold">{$i.name} Plan</span>{/if}
                {/foreach} 
                <span>ที่เหมาะสำหรับคุณ&nbsp;&nbsp;&nbsp;&nbsp;</span>
               
            </h3>
         </div>
      
         <div class="span4">
                {if $current_cat == 2 }
               	<a href="{$ca_url}cart/windows-hosting/&step=0"  class="btn-host">Windows hosting plan</a>
                {/if}
                {if $current_cat == 4 }
                <a href="{$ca_url}cart/linux-hosting/&step=0" class="btn-host">Linux hosting plan</a>
                {/if}
          </div>
        
    </div>
	<div class="fix con-inner">
			<div class="con-inner-middle">
			<div class="con-inner-middle1">
				<div class="box-titles">
					{if $opconfig.headertext!=''}
					<h3 class="box-title01">
						{$opconfig.headertext}
					</h3>
					{/if}
					{if $opconfig.subheadertext!=''}
					<h2 class="box-title02">
						{$opconfig.subheadertext}
					</h2>
					{/if}
				</div>

				{foreach from=$categories item=i name=categories name=cats}
				{if $i.id == $current_cat && $i.description!=''}
				{$i.description}
				{/if}
				{/foreach}
				
				{if $current_cat!='addons' && $current_cat!='transfer' && $current_cat!='register'}
				
				{if $products}
				
				{if count($currencies)>1}
				<form action="" method="post" id="currform"><p align="right" class="currencyinput">
				<input name="action" type="hidden" value="changecurr" />
				{$lang.Currency} <select name="currency" class="styled span2" onchange="$('#currform').submit()">
				{foreach from=$currencies item=crx}
				<option value="{$crx.id}" {if !$selcur && $crx.id==0}selected="selected"{elseif $selcur==$crx.id}selected="selected"{/if}>{if $crx.code}{$crx.code}{else}{$crx.iso}{/if}</option>
				{/foreach}
				</select>
				</p></form>
				{/if}
			
				{$j++}
				<div class='box828'>
				{foreach from=$products item=i}
						<div class="box-product">
							<div class="box-product-in">
								<div class="box-bell-top"><div></div></div>
								<div class="box-border1">
									<div class="box-border2">
										<div class="fix box-describe-con">
											<form name="form" action="" method="post">
											<input name="action" type="hidden" value="add" />
											<input name="id" type="hidden" value="{$i.id}" />
												<div class="box-head">
													{$i.name}
													<span>
													{if $i.paytype=='Free'}
												     {$lang.Free}
												      
													{elseif $i.paytype=='Once'}
														{$i.m|price:$currency} {$lang.once} {if $i.m_setup>0} + {$i.m_setup|price:$currency} {$lang.setupfee}{/if}
														{if $i.free_tlds.Once}{$lang.freedomain}{/if}
													{else}
													<!--
													{if $i.d!=0}
														-->{$i.d|price:$currency}<!--
													{elseif $i.w!=0}
														-->{$i.w|price:$currency}<!--
													{elseif $i.m!=0}
														-->{$i.m|price:$currency}<!--
													{elseif $i.q!=0}
														-->{$i.q|price:$currency}<!--	
													{elseif $i.s!=0}
														-->{$i.s|price:$currency}<!--	
													{elseif $i.a!=0}
														-->{$i.a|price:$currency}<!--	
													{elseif $i.b!=0}
														-->{$i.b|price:$currency}<!--	
													{elseif $i.t!=0}
														-->{$i.t|price:$currency}<!--
													{elseif $i.p4!=0}
														-->{$i.p4|price:$currency:false}<!--
													{elseif $i.p5!=0}
														-->{$i.p5|price:$currency:false}<!--
													{/if}
													-->/
												        
													{/if}					
													{if $i.paytype=='Free'}{elseif $i.paytype=='Once'}{$lang.once}{else}
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
													{/if}														
													</span>
												</div>
												<ul class="box-describe">
													<li>
														{if $i.description!=''}{$i.description}{/if}
													</li>
												</ul>

													<div class="button-con">
														<span class="button01">
															<span>
																<a href="javascript:void(0)" onclick="{literal}$(this).submit(){/literal}">
																	<input type="submit" value="{$lang.order}" style="font-weight:bold;" class="padded btn" />
																</a>									
															</span>
														</span>
													</div>
											</form>
										</div> 				
									</div> 				
								</div>
								<div class="box-bell-bottom"><div></div></div>
							</div> 				
						</div> 				
				{/foreach}
				</div>
			{else}
			<center>{$lang.nothing}</center>
			{/if}
			
			
			{/if}
		</div>
		</div>
	</div>

<script type="text/javascript">

max_height();

{if $opconfig.defaultselect!=0}
var defaultselect = parseInt({$opconfig.defaultselect})-1;
$('.box-product').eq(defaultselect).addClass('active');
{/if}
</script>

	<!-- MUSZĄ BYĆ WSZYSTKIE CHMURY	!!!!!	-->
	<div class="chmury">
		<div class="cloud-title">
			<div class="cloud-title-con">
				<ul class="cloud-desc">
					<li></li>
				</ul>
				<div class="cloud-arrow"></div>
			</div>
			<div class="fix cloud-bottom"></div>
		</div>								
	</div>	
</div>
	
