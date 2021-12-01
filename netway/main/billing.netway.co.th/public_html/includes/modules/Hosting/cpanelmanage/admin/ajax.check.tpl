<div class="content" style="padding: 10px 10px 0 10px;">
    <div class="row">
        <div class="col-sm-12">
            {if !$queue}
                <div class="alert alert-danger" role="alert">Queue is disabled. To perform the check, enable the <b>HostBill Queue</b> module</div>
            {elseif $id}
                {include file="`$template_path`/queue/progress.tpl" embedded=true id=$id}
            {/if}
        </div>
    </div>
</div>
