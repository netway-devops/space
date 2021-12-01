<div class="top-container left">
    {if $opconfig.slogan}
    <h1 class="openSansLight text-center">{$opconfig.slogan}</h1>
    {/if}
    <ul class="hosting-types center ubuntu clearfix">
        {foreach from=$categories item=i name=categories name=cats}
			{if $i.id != $current_cat}
                <li class="{if $smarty.foreach.cats.last && !$logged}last{/if}"><a href="{$ca_url}cart/{$i.slug}/&amp;step={$step}{if $addhosting}&amp;addhosting=1{/if}">{$i.name}</a></li>
            {else}
                <li class="{if $smarty.foreach.cats.last && !$logged}last{/if} active-hosting">{$i.name}</li>
			{/if}
		{/foreach}
    </ul>
</div>
<div class="menu-pattern clear left-column left">
    <div class="menu">
        <ul class="openSansBold text-center clearfix">
            <li class="{if $step < 1}active-menu{/if} first"><a href="{$ca_url}cart">{$lang.planselect}</a></li>
            <li class="{if $step == 1}active-menu{/if}">{if $step > 1}<a href="{$ca_url}cart&step=1">{/if}<span>{$lang.mydomains|wordwrap:5:'<br />'}</span>{if $step > 1}</a>{/if}</a></li>
            <li class="{if $step == 2}active-menu{/if}">{if $step > 2}<a href="{$ca_url}cart&step=2">{/if}<span>{$lang.productconfig2|wordwrap:15:'<br />'}</span>{if $step > 2}</a>{/if}</li>
            <li class="{if $step == 3}active-menu{/if}">{if $step > 3}<a href="{$ca_url}cart&step=3">{/if}<span>{$lang.productconfig|wordwrap:15:'<br />'}</span>{if $step > 3}</a>{/if}</li>
            <li class="last {if $step == 4}active-menu{/if}"><span>{$lang.ordersummary|wordwrap:15:'<br />'}</span></li>
        </ul>
    </div>
</div>