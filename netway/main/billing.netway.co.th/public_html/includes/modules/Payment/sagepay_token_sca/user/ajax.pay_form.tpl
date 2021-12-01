{if $sgpay.Status == '3DAUTH'}
    <form action="{$sgpay.ACSURL}" method="post" class="sagepay-box-form">
        <input type="hidden" name="creq" value="{$sgpay.CReq}"/>
        <p>Please click button below to proceed to 3D secure.</p>
        <button type="submit" class="btn btn-primary w-100">{$lang.continue}</button>
    </form>
    {literal}
        <script>
            $(function () {
                $('.sagepay-box-form').submit();
            })
        </script>
    {/literal}
{elseif $sgpay === true || is_string($sgpay)}
    {literal}
        <script>
            $(function () {
                location.reload();
            })
        </script>
    {/literal}
{/if}
