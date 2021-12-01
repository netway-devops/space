{php}
$templatePath   = $this->get_template_vars('template_path');
include($templatePath . 'menus/menu.dropdown.cart.tpl.php');
{/php}

<div class="submenu">
<div class="submenu-header">
    <h4>{$lang.placeorder}</h4>
    <p>{$lang.checkoffersphrase}</p>
</div>
    <!-- First box with links-->
    <div class="nav nav-list">
        <div class="nav-submenu">
            <ul>
                {foreach from=$orderpages item=op}
                	{if $op.slug != 'licenses'}
                    <li><a href="{$ca_url}
                    	{if $op.slug == 'ssl'}cart/ssl/
                    	{elseif $op.slug == 'rv2factor'}{if $2faURL != ''}{$2faURL}{else}?cmd=cart&action=add&id=58{/if}
                    	{elseif $op.slug == 'licenses'}cart/licenses/
                    	{else}cart/free/
                    	{/if}">
                    		{$op.name}<span></span></a></li>
                    {else}
                    	<li>
                    		<a href="{$ca_url}cart/licenses/">{$op.name}<span></span></a>
                    		<ul style="padding: 0px;">
	                    	{foreach from=$product_license key=l_type item=eLicense}
	                    		<li><a href="javascript:void(0);" style="cursor: default;">{$l_type}</a></li>
	                    		<ul style="padding: 0px;">
	                    		{foreach from=$eLicense item=eItem}
	                    		    {if $eItem.id == 111}
	                    		    <li style="display: none"><a style="font-weight: initial;" href="{$ca_url}?cmd=cart&action=add&id={$eItem.id}">{$eItem.name}<span></span></a></li>
	                    			{else}<li><a style="font-weight: initial;" href="{$ca_url}?cmd=cart&action=add&id={$eItem.id}">{$eItem.name}<span></span></a></li>
	                    		    {/if}
	                    		{/foreach}
	                    		</ul>
	                    	{/foreach}
	                    	</ul>
                    	</li>

                    {/if}
                {/foreach}
            </ul>
        </div>
    </div>
    <div class="center-btn">
    <a href="{$ca_url}cart/" class="btn support-btn l-btn">
        <i class="icon-support-home"></i>
        {$lang.proceedtocart}
    </a>
    </div>
</div>