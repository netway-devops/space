{php}
    include_once $this->template_dir . 'rvlicense/product_perpetual_btn.tpl.php';
{/php}
<!--  
{$aBtn|@debug_print_var}
-->
<div class="top-btm-padding">
<span {if not $aBtn.res} style="display:none;"{/if}>
<form method="POST" action="index.php?cmd=clientarea&rvaction=partner" style="display:inline-block;">
<input type="hidden" name="rvaction" value="partner"/>
<input type="hidden" name="rvcmd" value="rvskin_perpetual_license"/>
<input type="hidden" name="q_ded" value="{$aBtn.ded}"/>
<input type="hidden" name="q_vps" value="{$aBtn.vps}"/>
<button class="clearstyle btn green-custom-btn l-btn">
<i class="icon-shopping-cart icon-white"></i>
Add License(dedicated {$aBtn.ded}  )(vps {$aBtn.vps}  )</button>
 {securitytoken}
 </form>
</span>
</div>