
{include file="cart_smartwizard/header.tpl"}
{include file="cart_smartwizard/cart.summary.tpl"}
<!-- Left Column -->
<div class="left-column left">
    <div class="cart-container-sw">

        <!-- Hardware -->
        <div >
            {foreach from=$products item=i name=loop key=k}
                <div class="option-row center">
                    <div class="option-box left">
                        <h4 class="openSansBold left">{$i.name}</h4>
                        <p class="openSansRegular left">{include file='common/price.tpl' product=$i showcycle=true}</p>
                        <div class="open-box right">
                            {if $i.description}
                                <div class="arrow-box ">
                                    <span class="arrow-down"></span>
                                </div>
                            {/if}
                            <div class="order-btn-box openSansBold">
                                <form method="post" action="" class="parentform">
                                    <input type="hidden" name="action" value="add" />
                                    <input type="hidden" name="id" value="{$i.id}" />
                                    <a href="#" onclick="$(this).parent().submit(); return false;">{$lang.order}</a>
                                </form>
                            </div>
                        </div>
                    </div>
                    <div class="option-hidden-content left">
                        {$i.description}
                    </div>

                </div>
            {/foreach}
        </div>
        <!-- end -->
    </div>

    <div class="pagination-box">
        {include file='cart_smartwizard/pagination.tpl'}
    </div>

</div>

<div class="adventages-box left">
    {if $opconfig.advantages}
        <h1 class="openSansLight text-center">{$opconfig.advantages}</h1>
    {/if}
    <div class="adventages-underline center"></div>

    <div class="adventage left">
        <span class="automation-img center"></span>
        {if $opconfig.advantages1head}
            <h3 class="openSansSemiBold text-center">{$opconfig.advantages1head}</h3>
        {/if}
        {if $opconfig.advantages1text}
            <p class="openSansRegular text-center">{$opconfig.advantages1text}</p>
            {/if}
    </div>


    <div class="adventage left">
        <span class="complete-img center"></span>
        {if $opconfig.advantages2head}
            <h3 class="openSansSemiBold text-center">{$opconfig.advantages1head}</h3>
        {/if}
        {if $opconfig.advantages2text}
            <p class="openSansRegular text-center">{$opconfig.advantages2text}</p>
        {/if}
    </div>

    <div class="adventage left">
        <span class="billing-img center"></span>
        {if $opconfig.advantages3head}
            <h3 class="openSansSemiBold text-center">{$opconfig.advantages3head}</h3>
        {/if}
        {if $opconfig.advantages3text}
            <p class="openSansRegular text-center">{$opconfig.advantages3text}
            </p>
        {/if}
    </div>
</div>

<div class="clear"></div>