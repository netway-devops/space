

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
				
                    <li><a href="{$ca_url}{$op.slug}">{$op.name}<span></span></a></li>
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
  
