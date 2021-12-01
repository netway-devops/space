<div class="btn-group">
    <button type="button" class="btn btn-sm btn-default">
        FatturaPA
    </button>
    {if $filename}

    <button type="button" class="btn btn-sm btn-{if $file_exists}info{else}warning{/if} btn-tooltip" data-toggle="tooltip" data-placement="top" title="Progressivo: {$progressivo}{if $file_exists}{else}, not yet downloaded{/if}">
        <strong>{$filename}</strong>
    </button>

    {else}

        <button type="button" class="btn btn-sm btn-danger" >
            <strong>Not generated</strong>
        </button>
    {/if}

</div>

{literal}
<script>
    $(function () {
        $('.btn-tooltip').tooltip()
    })
</script>{/literal}