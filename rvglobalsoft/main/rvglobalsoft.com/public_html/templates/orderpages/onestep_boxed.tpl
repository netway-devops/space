{*
@@author:: HostBill team
@@name:: 4 Comparision boxes, one-step
@@description:: A One-Step checkout, where your client can pick package, configure it, add domains, addons, config options and signup, all on one page.
Nice clean template with current plan highlighted.
@@thumb:: images/onestep_boxed_thumb.png
@@img:: images/boxed_preview.png
*}
<div id="onestepcontainer">
<div id="ppicker">

{if $current_cat!='addons' && $current_cat!='transfer' && $current_cat!='register'}

	{if $products}
<input id="pidi" value="0" type="hidden" />
<script src="{$template_dir}js/jquery-ui-1.8.2.custom.min.js" type="text/javascript"></script>
<script type="text/javascript">
{literal}
function mainsubmit(formel) {
	var v=$('input[name="gateway"]:checked');
	if(v.length>0) {
		$(formel).append("<input type='hidden' name='gateway' value='"+v.val()+"' />");	
	}
        if($('input[name=domain]').length > 0 && $('input[name=domain]').attr('type') != 'radio')
            $(formel).append("<input type='hidden' name='domain' value='"+$('input[name=domain]').val()+"' />");

return true;
}

function onsubmit_2() {
$('#load-img').show();
	ajax_update('index.php?cmd=cart&'+$('#domainform2').serialize(),{layer:'ajax'},'#configer');
	return false;
}
function tabbme(el) {
	$(el).parent().find('li').removeClass('on');
	$('#options div.slidme').hide().find('input[type=radio]').removeAttr('checked');
	$('#options div.'+$(el).attr('class')).show().find('input[type=radio]').attr('checked','checked');
	$(el).addClass('on');
}

function on_submit() {

	

	
	if($("input[value='illregister']").is(':checked')) {
	//own
	ajax_update('index.php?cmd=checkdomain&action=checkdomain&product_id='+$('#product_id').val()+'&product_cycle='+$('#product_cycle').val()+'&'+$('.tld_register').serialize(),{layer:'ajax',sld:$('#sld_register').val()},'#updater2',true);
	} else if ($("input[value='illtransfer']").is(':checked')) {
	//transfer
	ajax_update('index.php?cmd=checkdomain&action=checkdomain&transfer=true&sld='+$('#sld_transfer').val()+'&tld='+$('#tld_transfer').val()+'&product_id='+$('#product_id').val()+'&product_cycle='+$('#product_cycle').val(),{layer:'ajax'},'#updater2',true);
	} else if ($("input[value='illupdate']").is(':checked')) {
		ajax_update('index.php?cmd=cart&domain=illupdate&sld_update='+$('#sld_update').val()+'&tld_update='+$('#tld_update').val(),{layer:'ajax'},'#configer');
		$('#load-img').show();
	} else if ($("input[value='illsub']").is(':checked')) {
		ajax_update('index.php?cmd=cart&domain=illsub&sld_subdomain='+$('#sld_subdomain').val(),{layer:'ajax'},'#configer');
		$('#load-img').show();
	}

	return false;
}
function applyCoupon() {
	ajax_update('?cmd=cart&addcoupon=true',$('#promoform').serializeArray(),'#configer');
	return false;
}
function simulateCart(forms, domaincheck) {
        $('#load-img').show();
        var urx = '?cmd=cart&';
        if(domaincheck) urx += '_domainupdate=1&';
	ajax_update(urx,$(forms).serializeArray(),'#configer');
}

function removeCoupon() {
	
	ajax_update('?cmd=cart',{removecoupon:'true'},'#configer');
	return false;
}
function changeProduct(pid) {
if(pid==$('#pidi').val())
	return;
$('#pidi').val(pid);
$('#pcontainer .boxorder').removeClass('box_active');
$('#pcontainer .boxorder[rel='+pid+']').addClass('box_active');

$('#errors').slideUp('fast',function(){
	$(this).find('span').remove();
});
$('#load-img').show();
$.post('?cmd=cart&cat_id={/literal}{$current_cat}{literal}',{id: pid},function(data){
var r = parse_response(data);

 $('#configer').html(r);
});
}

function submitTheForm() {
    $('form#cart3').find('input,select').each(function() {
        if(($(this).attr('type') != 'radio' && $(this).attr('type') != 'checkbox') || $(this).is(':checked') )
            $('#orderform').append('<input type="hidden" value="'+$(this).val()+'" name="'+$(this).attr('name')+'" />');

    });
    $('#orderform').submit();
}
{/literal}
</script>

<div class="left">
{foreach from=$categories item=i name=categories name=cats}
	{if $i.id != $current_cat}
		<a href="{$ca_url}cart/{$i.slug}/&amp;step={$step}{if $addhosting}&amp;addhosting=1{/if}">{$i.name}</a> {if !$smarty.foreach.cats.last}|{/if}
	{else}
	<strong>{$i.name}</strong> {if !$smarty.foreach.cats.last}|{/if}
	{/if}
{/foreach}

{if $logged=='1'} | {if $current_cat=='addons'}<strong>{else}<a href="{$ca_url}cart&amp;step={$step}&amp;cat_id=addons">{/if}{$lang.prodaddons}{if $current_cat=='addons'}</strong>{else}</a>{/if}{/if}
</div>
	
	{if count($currencies)>1}
	<div class="right">
<form action="" method="post" id="currform">
<input name="action" type="hidden" value="changecurr">
{$lang.Currency} <select name="currency" class="styled span2" onchange="$('#currform').submit()">
{foreach from=$currencies item=crx}
<option value="{$crx.id}" {if !$selcur && $crx.id==0}selected="selected"{elseif $selcur==$crx.id}selected="selected"{/if}>{if $crx.code}{$crx.code}{else}{$crx.iso}{/if}</option>
{/foreach}
</select>
</form></div>
{/if}
	<div class="clear"></div>

<div style="margin:15px 0px 20px;" id="pcontainer">
	{foreach from=$products item=i name=loop key=k}
			<div class="left {if $i.id==$product.id}box_active{/if} boxorder" rel="{$i.id}">
			<div class="headpart">
			<h1>{$i.name}</h1>
			<h3>
				{if $i.paytype=='Free'}
					{$lang.Free}
				{elseif $i.paytype=='Once'}
				<span style="vertical-align: top;">{$i.m|price:$currency}</span>
				{else}
				<!--
					{if $i.d!=0}
						--><span style="vertical-align: top;">{$i.d|price:$currency}</span><!--
					{elseif $i.w!=0}
						--><span style="vertical-align: top;">{$i.w|price:$currency}</span><!--
					{elseif $i.m!=0}
						--><span style="vertical-align: top;">{$i.m|price:$currency}</span><!--
					{elseif $i.q!=0}
						--><span style="vertical-align: top;">{$i.q|price:$currency}</span><!--	
					{elseif $i.s!=0}
						--><span style="vertical-align: top;">{$i.s|price:$currency}</span><!--	
					{elseif $i.a!=0}
						--><span style="vertical-align: top;">{$i.a|price:$currency}</span><!--	
					{elseif $i.b!=0}
						--><span style="vertical-align: top;">{$i.b|price:$currency}</span><!--	
					{elseif $i.t!=0}
						--><span style="vertical-align: top;">{$i.t|price:$currency}</span><!--	
					{elseif $i.p4!=0}
						--><span style="vertical-align: top;">{$i.p4|price:$currency}</span><!--
					{elseif $i.p5!=0}
						--><span style="vertical-align: top;">{$i.p5|price:$currency}</span><!--
					{/if}
					-->
				{/if}	/			
				<span style="vertical-align: middle;">
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
			</h3>
			
			</div>
			<div class="bodpart">
			{$i.description}
			</div>
			<a href="#" class="checksubmit" onclick="changeProduct({$i.id});return false;">{$lang.ordernow}</a>
			
			</div>
    {if ($k+1)%4==0 && !$smarty.foreach.loop.first}
    <div class="clear"></div>
    {/if}
	{/foreach}
	
	<div class="clear"></div>
	</div>

	
	{else}
	{foreach from=$categories item=i name=categories name=cats}

{if $i.id == $current_cat} <strong>{$i.name}</strong> {if !$smarty.foreach.cats.last}|{/if}
{else} <a href="{$ca_url}cart&amp;step={$step}&amp;cat_id={$i.id}{if $addhosting}&amp;addhosting=1{/if}">{$i.name}</a> {if !$smarty.foreach.cats.last}|{/if}
{/if}
{/foreach}

{if $logged=='1'} | {if $current_cat=='addons'}<strong>{else}<a href="{$ca_url}cart&amp;step={$step}&amp;cat_id=addons">{/if}{$lang.prodaddons}{if $current_cat=='addons'}</strong>{else}</a>{/if}{/if}


	{/if}
	
{/if}
	
</div>




<div id="configer">
{include file='ajax.onestep_boxed.tpl'}

</div>



<form action="?cmd=cart&cat_id={$current_cat}" method="post" id="orderform" onsubmit="return mainsubmit(this)">

    {if $gateways}
<div id="gatewayform" {if $tax && $tax.total==0}style="display:none"{elseif $credit && $credit.total==0}style="display:none"{elseif $subtotal.total==0}style="display:none"{/if}>
  {$gatewayhtml}
  </div>
<div class="clear"></div>
{/if}


  <input type="hidden" name="make" value="order" />





  {if $logged=="1"}
  <h3 class="modern">{$lang.ContactInfo}</h3>
    <div class="newbox1">

 {include file="drawclientinfo.tpl"}



  </div>


  {else}


  	<div class="newbox1header">
	<h3 class="modern">{$lang.ContactInfo}</h3>

	<ul class="wbox_menu tabbme">
		<li {if !isset($submit) || $submit.cust_method=='newone'}class="t1 on"{else}class="t1"{/if} onclick="{literal}ajax_update('index.php?cmd=signup',{layer:'ajax'},'#updater',true);$(this).parent().find('li.t2').removeClass('on');$(this).addClass('on');{/literal}" >

		{$lang.newclient}</li>
		<li {if $submit.cust_method=='login'}class="t2 on"{else}class="t2"{/if} onclick="{literal}ajax_update('index.php?cmd=login',{layer:'ajax'},'#updater',true);$(this).parent().find('li.t1').removeClass('on');$(this).addClass('on');{/literal}"}>
		{$lang.alreadyclient}</li>
	</ul>
	</div>
	<div class="newbox1">


  <div id="updater" >{if $submit.cust_method=='login'}
    {include file='ajax.login.tpl}
    {else}
    {include file='ajax.signup.tpl}
    {/if} </div>

	</div>



  {/if}
    <div class="newbox1header">
   <h3 class="modern">{$lang.cart_add}</h3>
    </div>

<div class="newbox1">
    <textarea id="c_notes" {if !$submit.notes}onblur="if (this.value=='')this.value='{$lang.c_tarea}';" onfocus="if(this.value=='{$lang.c_tarea}')this.value='';"{/if} style="width:98%" rows="3"  name="notes">{if $submit.notes}{$submit.notes}{else}{$lang.c_tarea}{/if}</textarea>
</div>




<p align="right">
  <br />

{if $tos}
<input type="checkbox" value="1" name="tos"/> {$lang.tos1} <a href="{$tos}" target="_blank">{$lang.tos2}</a>
  {/if}



 <a href="#" onclick="$('#orderform').submit();return false;" id="checksubmit">{$lang.checkout}</a>
</p>




</form>



</div>