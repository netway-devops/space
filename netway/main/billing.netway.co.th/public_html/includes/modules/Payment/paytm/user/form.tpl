<form name="form" id="paytm-form" method="POST" action="{$paytm_url}" target="_top">
    {foreach from=$paytm item=tm key=tm_name}
        <input type="hidden" name="{$tm_name}" value="{$tm}">
    {/foreach}
</form>
{literal}
    <script>
        $(function () {
            $('#paytm-form').submit();
        });
    </script>
{/literal}