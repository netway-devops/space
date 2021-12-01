<style>
    {literal}
    .checkout_btn {
        height: 80px;
        padding: 0;
        margin: 10px;
        vertical-align: top;
        width: 110px;
        background:none;
        border-radius: 3px;
    }
    .checkout_btn:hover {
        filter: brightness(90%);
    }
    {/literal}
</style>
<div style="text-align: center">
    <h3>{$lang.choose_payment_method}</h3>
    {foreach from=$providers item=provider name=loop}
        {if $smarty.foreach.loop.index%6==0}
            <br>
        {/if}
        <form style="display: inline-block" method='POST' action="{$provider.url}">
            {foreach from=$provider.parameters item=parameter}
                <input type='hidden' name='{$parameter.name}' value='{$parameter.value}' />
            {/foreach}
            <button class="checkout_btn"><img src="{$provider.svg}"></button>
        </form>
    {/foreach}
</div>
