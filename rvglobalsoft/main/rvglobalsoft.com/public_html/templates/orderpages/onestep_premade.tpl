{*
@@author:: HostBill team
@@name:: Premade Sliders, One-step
@@description:: A One-Step checkout, where your client can pick package, configure it, add domains, addons, config options and signup, all on one page.
@@thumb:: onestep_premade/thumb.png
@@img:: onestep_premade/preview.png
*}
<link media="all" type="text/css" rel="stylesheet" href="{$orderpage_dir}onestep_premade/css/style.css" />
<script type="text/javascript" src="{$orderpage_dir}onestep_premade/js/slides.min.jquery.js"></script>
<script type="text/javascript" src="{$orderpage_dir}onestep_premade/js/raphael.js"></script>
<script type="text/javascript" src="{$orderpage_dir}onestep_premade/js/script.js"></script>


<div id="page" class="center">
    <!-- Slider -->
    <div class="slider-container left">
        <h2 class="openSansLightItalic">{$lang.planselection}<span></span></h2>
        <div class="slider-box center clearfix">
            <div class="slider-box-noise">

                <div class="slider-text-box center clearfix">
                    {foreach from=$products item=i name=loop key=k}
                        <span class="quickSandBold {if $i.id==$product.id}selected{/if} "><a href="#">{$i.name}<input type="hidden" value="{$i.id}" class="product_id" /></a></span>
                    {/foreach}
                </div>

                <div class="slider-separators-box center clearfix">
                    {foreach from=$products item=i name=loop key=k}
                        <div class="slider-separators-pack">
                            <span class="small-separator"></span>
                            <span class="small-separator"></span>
                            <span class="big-separator"></span>
                            <span class="small-separator"></span>
                            <span class="small-separator"></span>
                        </div>
                    {/foreach}

                </div>

                <div class="slider-top center">

                </div>
                <div class="slider-bg center">
                    <div class="slider-bg-grey">
                        <div class="slider-bg-blue left">
                        </div>
                        <div class="slider-bg-blue-scalable left">
                        </div>
                    </div>
                </div>

                <div class="slider-line center">
                    {*<div class="slider-line-grey left">
                    <div class="slider-line-blue left">
                    </div>
                    </div>*}
                    <div id="slider">
                    </div>
                </div>

                <div class="slider-shadow center">
                </div>

                <div class="slider-info">
                    <p class="openSansSemiBold">{$lang.movingslider} {$lang.from} <b>{foreach from=$products item=i name=loop key=k}{$i.name}{break}{/foreach}</b> {$lang.to}
                        <b>{foreach from=$products item=i name=loop key=k}{if $smarty.foreach.loop.last}{$i.name}{/if}{/foreach}</b> 
                        {$lang.plans}.</p>
                </div>
            </div>
        </div>
    </div>
    {if $opconfig.premade} 
        <div class="right-column right">
            <h2 class="openSansLightItalic">{$lang.aboutplan}<span></span></h2>
            <div class="about-plan left">
                <div class="about-plan-bglayer">
                </div>
                <div class="about-plan-layer">
                    {foreach from=$opconfig.premade item=madeitem key=index}
                        {if $madeitem.name}
                            <div id="about-p-{$index}" class="about-plan-details center" >
                                <h3 class="openSansBoldItalic">{$madeitem.name}</h3>
                                <p class="openSansItalic">
                                    {$madeitem.description}
                                </p>
                            </div>
                        {/if}
                    {/foreach}
                </div>
            </div>
        </div>
        <!-- Left Column -->
        <div class="left-column left">
            <!-- Predefinied Plans -->
            <h2 class="openSansLightItalic">{$lang.predefiniedplans}<span></span></h2>
            <div id="slides"> 
                <div class="definied-plans-list left">
                    {foreach from=$opconfig.premade item=madeitem key=index}
                        {if $madeitem.name}
                            <div id="p-{$index}" class="definied-plan left" style="background-image: url({$madeitem.icon})">
                                <div class="definied-plan-hover" rel="{$madeitem.package}">
                                    <span></span>
                                    <p class="openSansBoldItalic text-center">{$lang.selectthisplan}</p>
                                </div>
                            </div>
                        {/if}
                    {/foreach}
                </div>
            </div>
        </div>
    {/if}
    <script type="text/javascript">pop_slider();</script>
    <div id="update" class="clear">
        {include file="ajax.onestep_premade.tpl"}
    </div>
    
    <div id="checkout" class="left-column left" style="display:none;">
        <form action="?cmd=cart&cat_id={$current_cat}" method="post" id="orderform" onsubmit="return mainsubmit(this)">
            {if $gateways}
                <h2 class="openSansLightItalic">{$lang.choose_payment}<span></span></h2>
                <br />
                {if $gateways}
                        {foreach from=$gateways item=module key=mid name=payloop}
                            <div class="left openSansBoldItalic" style="padding:7px">
                                <input type="radio" name="gateway"  onclick="return pop_ccform($(this).val())" value="{$mid}" {if $submit && $submit.gateway==$mid||$mid==$paygateid}checked="checked"{elseif $smarty.foreach.payloop.first}checked="checked"{/if}/>
                                {$module}
                            </div>
                        {/foreach}
                    <div class="clear"></div>
                {/if}
                <br />
                <div id="gatewayform" {if $tax && $tax.total==0}style="display:none"{elseif $credit && $credit.total==0}style="display:none"{elseif $subtotal.total==0}style="display:none"{/if}>
                    {$gatewayhtml}
                    <script type="text/javascript"> reform_ccform(); </script>
                </div>
                <div class="clear"></div>
            {/if}
            <input type="hidden" name="make" value="order" />
            {if $logged=="1"}
                <h2 class="openSansLightItalic">{$lang.ContactInfo}<span></span></h2>
                <div class="newbox1">
                    {include file="drawclientinfo.tpl"}
                </div>
            {else}

                <h2 class="openSansLightItalic">{$lang.ContactInfo}<span></span></h2>
                <div class="clear"></div>
                <div class="cart-switch tabbme">
                    <span {if !$submit || !$submit.make || $submit.cust_method=='newone' || $submit.action!='login'}class="t1 active on"{else}class="t1"{/if} onclick="ajax_update('{$system_url}index.php?cmd=signup',{literal}{layer:'ajax'},'#updater2',true);$(this).parent().find('li.t2').removeClass('on');$(this).addClass('on');{/literal}" >
                        {$lang.newclient}</span>
                    <span {if $submit.cust_method=='login' || $submit.action=='login'}class="t2 active on"{else}class="t2"{/if} onclick="ajax_update('{$system_url}index.php?cmd=login',{literal}{layer:'ajax'},'#updater2',true);$(this).parent().find('li.t1').removeClass('on');$(this).addClass('on');{/literal}"}>
                                                                                    {$lang.alreadyclient}</span>
                    <div></div>
                </div>
                <div class="clear"></div>
                <div id="updater2" >
                    {if $submit.cust_method=='login'}
                        {include file='ajax.login.tpl}
                    {else}
                        {include file='ajax.signup.tpl}
                    {/if} 
                </div>
            {/if}
            
                <h2 class="openSansLightItalic">{$lang.cart_add}<span></span></h2>
                <br />
            <div class="newbox1">
                <textarea id="c_notes" {if !$submit.notes}onblur="if (this.value=='')this.value='{$lang.c_tarea}';" onfocus="if(this.value=='{$lang.c_tarea}')this.value='';"{/if} style="width:98%" rows="3"  name="notes">{if $submit.notes}{$submit.notes}{else}{$lang.c_tarea}{/if}</textarea>
            </div>
            <p>
                <br />
                {if $tos}
                    <input type="checkbox" value="1" name="tos"/> {$lang.tos1} <a href="{$tos}" target="_blank">{$lang.tos2}</a>
                {/if}
            </p>
        </form>
    </div>
</div>