<div class="content">
    <div class="row text-center">
        <h4>{$lang.BuckarooSepa}</h4>
    </div>
    {if $key}
        <div class="row text-center">
            <a href="?cmd=buckaroo&action=remove_key" class="btn btn-danger btn-sm" onclick="return confirm('{$lang.RemoveTransactionKey_desc}');">{$lang.RemoveTransactionKey}</a>
            <button class="btn btn-info btn-sm" onclick="getKey();">{$lang.LookTransactionKey}</button>
        </div>
    {else}
        <div class="row text-center">
            <p>{$lang.BuckarooSepaKeyEmpty}</p>
        </div>
    {/if}
    <div id="transaction-key" class="row text-center" style="margin-top: 15px;">

    </div>
</div>
{literal}
    <script>
        function getKey() {
            $.post('?cmd=buckaroo&action=get_key',{},function (data) {
                $('#transaction-key').html(data);
            });
        }
    </script>
{/literal}