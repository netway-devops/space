{if $justparse && $check}
    <input type='hidden' name='domain' value='illregister'/>
    {include file="domains/ajax.checklist.tpl"}
    <div class="domain-order">
        <div class="button06" >
            <input type="submit" value="{$lang.ordernow}" />
        </div>
    </div>
    <script type="text/javascript">runBulkSearch();</script>
{elseif $suggestions}
    {include file="domains/ajax.suggestions.tpl"}
{elseif $check}
    {include file="domains/ajax.namecheck.tpl"}
{/if}