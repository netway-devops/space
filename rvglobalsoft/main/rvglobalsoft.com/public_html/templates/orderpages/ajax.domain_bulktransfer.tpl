{if $justparse && $check}
    <input type='hidden' name='domain' value='illtransfer'/>
    {include file="domains/ajax.checklist.tpl"}
    <div class="domain-order">
        <div class="button06">
            <input type="submit" value="{$lang.transferselected}" />
        </div>
    </div>
    <script type="text/javascript">runBulkSearch();</script>
{elseif $check}
    {include file="domains/ajax.namecheck.tpl"}
{/if}