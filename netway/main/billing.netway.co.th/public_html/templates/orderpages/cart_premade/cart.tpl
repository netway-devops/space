<link rel="stylesheet" href="{$orderpage_dir}cart_premade/css/style.css">
<link rel="stylesheet" href="{$orderpage_dir}cart_premade/css/skin.css">
<link rel="stylesheet" href="{$orderpage_dir}cart_premade/css/jquery-ui-1.8.21.custom.css">
<link href='http://fonts.googleapis.com/css?family=PT+Sans:400,700|PT+Sans+Narrow:700' rel='stylesheet' type='text/css'>
<script src="{$orderpage_dir}cart_premade/js/jquery.jcarousel.min.js"></script>
<script src="{$orderpage_dir}cart_premade/js/script.js"></script>
<style>
.oldie .slider-circle{literal}{{/literal}
    behavior: url({$orderpage_dir}cart_premade/css/PIE.htc);
    border-radius: 12px;
    zoom:1;
    position:relative;
{literal}}{/literal}
</style>

<div id="cart-page" class="clearfix">
    <div class="page-header left">
        <ul class="hosting-types center ptSansRegular clearfix">
            {foreach from=$categories item=i name=cats}
                {if $i.id == $current_cat}
                    <li class="active-hosting-type ptSansRegular {if $smarty.foreach.cats.last}last{/if}">{$i.name}</li>
                {else}
                    <li class="{if $smarty.foreach.cats.last}last{/if}"><a href="{$ca_url}cart/{$i.slug}/&amp;step={$step}{if $addhosting}&amp;addhosting=1{/if}">{$i.name}</a></li>
                {/if}
            {/foreach}
        </ul>
        <div class="underline-top center"></div>
    </div>
    {if $opconfig.premade} 
        {counter name=media assign=media start=0 print=false}
        {foreach from=$opconfig.premade item=madeitem key=index}{if $madeitem.name}{counter name=media}{/if}{/foreach} 
        {if $media}
        <!-- Plan Selection -->
        <div class="plan-selection left content-{$media}">
            <h2 class="ptSansNarrowBold text-center">{$lang.predefiniedplans}</h2>
            <ul id="plan-slider" class="center jcarousel-skin">
                {foreach from=$opconfig.premade item=madeitem key=index}
                    {if $madeitem.name}
                        <li id="premade_{$madeitem.package|escape}_{$index}" onclick="setPlan('{$madeitem.package}')" title="{$madeitem.description}">
                            <div class="iemask">
                                <div class="iegrad">
                                    <div class="center premade-plan" style="background-image: url({$madeitem.icon})"></div>
                                    <span class="ptSansNarrowBold">{$madeitem.name}</span>
                                </div>
                            </div>
                            <div class="plan-tail"></div>
                        </li>
                    {/if}
                {/foreach} 
            </ul>
        </div>
        {/if}
    {/if}
    <!-- Plan Info -->
    <div class="plan-info left">
        <h2 class="ptSansNarrowBold text-center">{$lang.planselection}</h2>
        <div class="plan-box">

            <div class="plan-top clearfix">
                <div class="right-column right">
                    {if count($currencies)>1}
                        <form action="" method="post" id="currform">
                            <input name="action" type="hidden" value="changecurr">
                            <input name="currency" type="hidden" value="0">
                        </form>
                            <div class="btn-group">
                                <a class="btn dropdown-toggle ptSansNarrowBold" data-toggle="dropdown" href="#">{$lang.Currency}: {$currency.code} <span class="caret"></span></a>
                                <ul class="dropdown-menu">
                                {foreach from=$currencies item=crx}
                                    <li ><a href="#" onclick="$('#currform').find('[name=currency]').val('{$crx.id}').end().submit(); return false;" >{if $crx.code}{$crx.code}{else}{$crx.iso}{/if}</a></li>
                                {/foreach}
                            </ul>
                        </div>
                    {/if}
                    {foreach from=$products item=i name=loop key=k}
                        <div class="btn-group props_ props_{$k+1}" {if !$smarty.foreach.loop.first}style="display:none"{/if}>
                            <a class="btn dropdown-toggle ptSansNarrowBold" data-toggle="dropdown" href="#">
                                {if $i.paytype=='Free'}{$lang.Free}
                                {elseif $i.paytype=='Once'}{$lang.once}
                                {else}
                                    {foreach from=$i item=p_price key=p_cycle}
                                        {if $p_cycle == 'd' || $p_cycle == 'w' || $p_cycle == 'm' || $p_cycle == 'q' || $p_cycle == 's' || $p_cycle == 'a' || $p_cycle == 'b' || $p_cycle == 't' || $p_cycle == 'p4' || $p_cycle == 'p5'}
                                            {if $p_price > 0}
                                                {$lang.billing}: <span>{$lang.$p_cycle}</span> 
                                                {break}
                                            {/if}
                                        {/if}
                                    {/foreach}
                                {/if}
                            {if $i.paytype!='Free' && $i.paytype!='Once'}<span class="caret"></span>{/if}
                        </a>
                        {if $i.paytype!='Free' && $i.paytype!='Once'}
                            <ul class="dropdown-menu">
                                {foreach from=$i item=p_price key=p_cycle}
                                    {if $p_cycle == 'd' || $p_cycle == 'w' || $p_cycle == 'm' || $p_cycle == 'q' || $p_cycle == 's' || $p_cycle == 'a' || $p_cycle == 'b' || $p_cycle == 't' || $p_cycle == 'p4' || $p_cycle == 'p5'}
                                        {if $p_price > 0}
                                            <li rel="{$p_cycle}" onclick="changeCycle(this); return false">
                                                <a href="#" class="ptSansNarrowBold">
                                                    <span>
                                                        {if $p_price > 999}
                                                            {$p_price|price:$currency:true:false:false:0}
                                                        {else}
                                                            {$p_price|price:$currency:true:false:false}
                                                        {/if}
                                                    </span> 
                                                    <span>{$lang.$p_cycle}</span>
                                                </a>
                                            </li>
                                        {/if}
                                    {/if}
                                {/foreach}
                            </ul>
                        {/if}
                    </div>
                {/foreach}
            </div>
            <div class="left-column">
                <p class="ptSansNarrowBold">{$lang.optimalchoicefor}:</p>
                <img class="selected-plan-img" />
                <span class="selected-plan-name ptSansNarrowBold "></span>
            </div>

        </div>

        <div class="slider-box">
            <div class="slider-container center">
                <div class="slider-bg clearfix">
                    {foreach from=$products item=i key=k name=loop}
                        <div class="slider-circle-pos {if $smarty.foreach.loop.first}first{/if}">
                            <span id="point-{$k+1}" rel="{$k+1}" class="slider-circle{if $smarty.foreach.loop.first} slider-circle-active{/if}">
                                <span class="ptSansNarrowBold" onclick="setPlan('{$k+1}')">{$k+1}</span>
                                <div class="hitarea" onclick="setPlan('{$k+1}')"></div>
                            </span>
                        </div>
                    {/foreach}
                    <div id="slider" class="slider-line">
                    </div>
                    <script type="text/javascript">arangeSlider()</script>
                </div>
            </div>
        </div>
        <div class="plan-config clearfix">
            {foreach from=$products item=i name=loop key=k}
                {specs var="awords" string=$i.description}
            {/foreach}
            <div class="left-column clearfix">
                {foreach from=$awords item=j name=lla key=k}
                    {if $j.specs} 
                        {foreach from=$j.specs item=i name=ll key=ka}
                            <div class="config-option left props_ props_{$k+1}" {if !$smarty.foreach.lla.first}style="display:none"{/if}>
                                <span class="config-top-corner"></span>
                                <div class="config-name text-center">
                                    <p class="ptSansNarrowBold ">{$i[0]}</p>
                                    <span class="ptSansNarrowBold">{$i[1]}</span>
                                </div>
                                <span class="config-bottom-coner"></span>
                            </div>
                        {/foreach}        
                    {/if}
                {/foreach}
                <div class="config-option left block-inv"> </div>
            </div>
        </div>
    </div>
    <div class="bottom-corner">

        {foreach from=$products item=i name=loop key=k}

            <form method="post" action="" class="parentform" >
                <input type="hidden" name="action" value="add" />
                <input type="hidden" name="id" value="{$i.id}" />
                <div class="right clearfix order-button-up props_ props_{$k+1}" {if !$smarty.foreach.loop.first}style="display:none"{/if}>
                    <div class="order-button-pattern">
                        <div class="order-button">
                            <a href="#" class="ptSansNarrowBold" onclick="$(this).parents('.parentform').submit(); return false;">
                                {$lang.ordernow}
                            </a>
                            </form>

                        </div>
                    </div>
                    <div class="order-corner"><div></div></div>
                    <div class="total-price right">
                        <span class="ptSansNarrowBold">{$lang.totalprice}</span>
                            {if $i.paytype=='Free'}
                                <p class="ptSansNarrowBold">
                                {$lang.Free}
                                </p>
                                <input type="hidden" name="cycle" value="Free">
                            {elseif $i.paytype=='Once'}
                                <p class="ptSansNarrowBold">
                                {if $i.m > 999}
                                    {$i.m|price:$currency:true:false:false:0}
                                {else}
                                    {$i.m|price:$currency:true:false:false}
                                {/if}
                                </p>
                                <input type="hidden" name="cycle" value="Once">
                            {else}
                                {foreach from=$i item=p_price key=p_cycle}
                                    {if $p_cycle == 'd' || $p_cycle == 'w' || $p_cycle == 'm' || $p_cycle == 'q' || $p_cycle == 's' || $p_cycle == 'a' || $p_cycle == 'b' || $p_cycle == 't' || $p_cycle == 'p4' || $p_cycle == 'p5'}
                                        {if $p_price > 0}
                                            <p class="ptSansNarrowBold">
                                            {if $p_price > 999}
                                                {$p_price|price:$currency:true:false:false:0}
                                            {else}
                                                {$p_price|price:$currency:true:false:false}
                                            {/if}
                                            {$lang.$p_cycle}
                                            </p>
                                            <input type="hidden" name="cycle" value="{$p_cycle}">
                                            {break}
                                        {/if}
                                    {/if}
                                {/foreach}
                            {/if}
                    </div>
                </div>
            {/foreach}
            <div class="clear"></div>
            <div class="plan-info-shadow-left"></div>
            <div class="plan-info-shadow-right"></div>
    </div>
</div>
<!-- Features -->
<div class="features left">
    <div class="underline-top"></div>
    {if $opconfig.features}<h3 class="ptSansNarrowBold text-center">{$opconfig.features}</h3>{/if}

    <div class="feature-box left">
        <div class="complete-img center"></div>
        {if $opconfig.footer1head}<span class="ptSansNarrowBold text-center">{$opconfig.footer1head}</span>{/if}
        {if $opconfig.footer1text}<p class="ptSansRegular text-center">{$opconfig.footer1text}</p>{/if}
    </div>

    <div class="feature-box left">
        <div class="automation-img center"></div>
        {if $opconfig.footer2head}<span class="ptSansNarrowBold text-center">{$opconfig.footer2head}</span>{/if}
        {if $opconfig.footer2text}<p class="ptSansRegular text-center">{$opconfig.footer2text}</p>{/if}
    </div>

    <div class="feature-box left">
        <div class="payment-img center"></div>
        {if $opconfig.footer3head}<span class="ptSansNarrowBold text-center">{$opconfig.footer3head}</span>{/if}
        {if $opconfig.footer3text}<p class="ptSansRegular text-center">{$opconfig.footer3text}</p>{/if}
    </div>
</div>

</div>