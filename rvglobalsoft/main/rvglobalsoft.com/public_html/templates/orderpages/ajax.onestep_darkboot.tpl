<input type="hidden" name="pidi" value="{$product.id}" id="product_id"/>

<div class="step_ step_0" style="display:block">
    {include file="onestep_darkboot/step0.tpl"}
</div>
{if ($cart_contents[0].domainoptions.register)=='1' && ($allowregister || $allowtransfer || $allowown || $subdomain)}
    <div class="step_ step_1">
        {include file="onestep_darkboot/step1.tpl"}
    </div>
{/if}
<div class="step_ step_2" >
    {include file="onestep_darkboot/step2.tpl"}
</div>
<div class="step_ step_3">
    {include file="onestep_darkboot/step3.tpl"}
</div>
<div id="summary" class="right-side">
    {include file="onestep_darkboot/sumary.tpl"}
</div>
<div class="shadow-buttom center clear">
</div>

<!-- Order Steps -->
<div class="order-steps clearfix">
    <div class="order-steps-box">
        <div class="order-steps-txt">
            <p>{$lang.ordersteps}</p>
        </div>
        <div class="order-steps-diagram">
            <div class="diagram clearfix">
                <div class="diagram-point active" onclick="continue_step(0)"></div>
                <div class="diagram-line active last"></div>
                {if ($cart_contents[0].domainoptions.register)=='1' && ($allowregister || $allowtransfer || $allowown || $subdomain)}
                    <div class="diagram-point" onclick="continue_step(Math.floor($(this).index()/2))"></div>
                    <div class="diagram-line"></div>
                {/if}
                <div class="diagram-point" onclick="continue_step(Math.floor($(this).index()/2))"></div>
                <div class="diagram-line"></div>

                <div class="diagram-point" onclick="continue_step(Math.floor($(this).index()/2))"></div>
                <div class="diagram-line"></div>

                <div class="diagram-point last"></div>
            </div>
            <div class="clearfix diagram-label">
                <span class="active last" onclick="continue_step($(this).index())">{$lang.planselection}</span>
                {if ($cart_contents[0].domainoptions.register)=='1' && ($allowregister || $allowtransfer || $allowown || $subdomain)}
                    <span onclick="continue_step($(this).index())">{$lang.domains}</span>
                {/if}
                <span onclick="continue_step($(this).index())">{$lang.serviceconfiguration}</span>
                <span onclick="continue_step($(this).index())">{$lang.ordersummary}</span>
                <span class="diagram-fix">{$lang.checkout}</span>
            </div>
        </div>
    </div>
    <div class="continue-button-bg">
        <a id="continue_step" class="text-center" href="#step1" onclick="return continue_step();">
            <div class="continue-button-mask">
                <div class="continue-button">
                    <span id="continue_text">{$lang.continue}</span>
                    <span id="checkout_text">{$lang.checkout}</span>
                </div>
            </div>
            <div class="continue-button-img"></div>
            <div class="continue-arrows-mask">
                <div class="continue-arrows">
                    <span class="continue-arrows-img"></span>
                </div>
            </div>
        </a>
    </div>
</div>
