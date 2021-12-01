<div class="lighterblue" style="padding:20px">
    <strong>{$lang.importlog}:</strong> <br />
    {if $logs}
        <div class="fs11" style="margin:5px 0px;-moz-box-shadow: inset 0 0 2px #888;-webkit-box-shadow: inset 0 0 2px #888;box-shadow: inner 0 0 2px #888;background:#F5F9FF;padding:10px;">
            <div style="max-height:300px;min-height:300px;height:300px;overflow:auto" >

                {foreach from=$logs item=log_line}
                    {if $log_line.error}
                        <font style="color:red">{$lang.Error}: {$log_line.text}</font><br />
                    {else}
                        {$log_line.text}<br />
                    {/if}
                {/foreach}
            </div>
        </div>

    {else}
        {$lang.nothingtodisplay}.
    {/if}
</div>
<div class="blu" style="padding: 10px;">
    <a href="?cmd=importaccounts" ><strong>&laquo; Back to server selection</strong></a>
</div>
