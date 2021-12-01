<div class="row">
    <div class="col-sm-12">
        <h3>Marked columns will be visible in the summary list and in the exported file</h3>
        <form action="?cmd=inventory_manager&action=summary_columns" method="post">
            {foreach from=$columns item=column key=id}
                <div class="checkbox">
                    <label><input type="checkbox" name="column[]" value="{$id}" {if in_array($id, $used_columns)}checked{/if}>{$column}</label>
                </div>
            {/foreach}
            {securitytoken}
            <button type="submit" class="btn btn-sm btn-success" name="submit" value="1">Submit</button>
        </form>
    </div>
</div>