<!-- Single button -->
<div class="btn-group">
    <button type="button" class="btn btn-sm btn-default" >
        Fraudrecord.com
    </button>
    <button type="button" class="btn btn-sm {if $fraudrecord[0]>0}btn-danger{else}btn-success{/if} dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
        {if isset($fraudrecord[0])}Score: <b>{$fraudrecord[0]}</b>{else}Not verified{/if} <span class="caret"></span>
    </button>

    <ul class="dropdown-menu">
        <li><a href="?cmd=fraudrecord&action=query&client_id={$client.client_id}">Query Fraudrecord DB</a></li>
        {if $fraudrecord[3]}
            <li><a href="https://www.fraudrecord.com/api/?showreport={$fraudrecord[3]}" target="_blank">Show report</a></li>
        {/if}
        <li><a href="?cmd=fraudrecord&action=report&client_id={$client.client_id}" onclick="{literal}$.facebox({ajax: $(this).attr('href')});{/literal}return false;">Submit report</a></li>
    </ul>
</div>