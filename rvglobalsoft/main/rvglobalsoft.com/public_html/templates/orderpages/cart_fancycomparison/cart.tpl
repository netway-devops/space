<link media="all" type="text/css" rel="stylesheet" href="{$orderpage_dir}cart_fancycomparison/css/style.css" />
<script type="text/javascript" src="{$orderpage_dir}cart_fancycomparison/js/script.js"></script>


<div id="page" class="left">
	{if $opconfig.header}
        <h1 class="openSansRegular text-center">{$opconfig.header}</h1>
    {/if}
    {if $opconfig.subheader}
        <h2 class="openSansRegular text-center">{$opconfig.subheader}</h2>
    {/if}
    {if count($currencies)>1}
        <form action="" method="post" id="currform">
            <p align="right" style="margin-right:25px">
                <input name="action" type="hidden" value="changecurr">
                {$lang.Currency} <select name="currency" class="styled span2" onchange="$('#currform').submit()">
                    {foreach from=$currencies item=crx}
                        <option value="{$crx.id}" {if !$selcur && $crx.id==0}selected="selected"{elseif $selcur==$crx.id}selected="selected"{/if}>{if $crx.code}{$crx.code}{else}{$crx.iso}{/if}</option>
                    {/foreach}
                </select>
            </p>
        </form>
    {/if}
    <!-- Servers -->
    <div class="servers left">
    <ul style="display: none" id="planfeat">
        {$opconfig.plandesc}
    </ul>
    {foreach from=$products item=i name=loop key=k name=loop}
        {if $smarty.foreach.loop.index % 4 == 0}<div class="clear"></div>{/if}
    	<div class="column left">
        	<div class="column-header">
            	<h3 class="openSansRegular bold text-center">{$i.name}</h3>
                <div class="price openSansBold text-center">
                    
                    {$currency.sign}<span>{include file='common/price.tpl' product=$i hideall=true}</span>
                     /{include file="common/cycle.tpl" product=$i}
                </div>
                {if $opconfig.ribbon == $smarty.foreach.loop.index}
                <div class="ribbon">
                    <p class="openSansBold text-center packdescr"></p>
                    <div class="ribbon-bg"></div>
                    <div class="ribbon-t"></div>
                </div>
                {else}
                <p class="openSansLight center text-center packdescr"></p>
                {/if}
                <script type="text/javascript"> var packinex = {$k};</script>
            </div>
            
            {$i.description}

            <div class="order-now center">
                <form method="post" action="" class="parentform">
                    <input type="hidden" name="action" value="add" />
                    <input type="hidden" name="id" value="{$i.id}" />
                    <a href="#" class="openSansBold text-center" onclick="event.preventDefault(); $(this).parent().submit();">
                        {$lang.ordernow}
                    </a>
                </form>
                
            </div>
            <div class="order-now-shadow">
            </div>
        </div>
      {/foreach}  
    </div>
    
    <!-- Information -->
    <div class="information left">
        {if $opconfig.footer1head || $opconfig.footer1text}
    	<div class="information-box left">
        	<div class="support-info left">
            	<div class="support-icon center">
                </div>
            </div>
            <div class="information-details left">
                {if $opconfig.footer1head}
            	<h4 class="openSansBoldItalic">{$opconfig.footer1head}</h4>
                {/if}
                {if $opconfig.footer1text}
                <p class="openSansRegular">
                    {$opconfig.footer1text}
                </p>
                {/if}
				{if $opconfig.footer1url}
				<div class="information-button">
                	<a href="{$opconfig.footer1url}" class="openSansBold text-center">{$lang.tellmemore} <small class="openSansRegular">>></small></a>
                </div>
                {/if}
            </div>
        </div>
        <div class="information-shadow left">
        </div>
        {/if}
        {if $opconfig.footer2head || $opconfig.footer2text}
        <div class="information-box left">
        	<div class="support-info left">
            	<div class="tech-support-icon center">
                </div>
            </div>
            <div class="information-details left">
                {if $opconfig.footer2head}
            	<h4 class="openSansBoldItalic">{$opconfig.footer2head}</h4>
                {/if}
                {if $opconfig.footer2text}
                <p class="openSansRegular">
                    {$opconfig.footer2text}
                </p>
                {/if}
                {if $opconfig.footer2url}
				<div class="information-button">
                	<a href="{$opconfig.footer2url}" class="openSansBold text-center">{$lang.tellmemore} <small class="openSansRegular">>></small></a>
                </div>
                {/if}
            </div>
        </div>
        {/if}
    </div>
    
    <!-- Contact Message -->
    <div class="contact-msg left">
    	<div class="third-layer center">
        	<div class="second-layer">
            	<div class="first-layer">
                	<p class="openSansLight text-center">{$lang.haventfoundstilllooking}?! <a href="?cmd=tickets&action=new" class="openSansRegular"> {$lang.leaveusamessage} »</a></p>
                </div>
            </div>
        </div>
    </div>
    
</div>