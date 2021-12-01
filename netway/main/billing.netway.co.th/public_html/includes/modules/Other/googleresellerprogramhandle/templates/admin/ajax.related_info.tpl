<div>
    {if $aSubscriptions|@count}
    <em>GSuite</em>
     <input type="button" 
        onClick="{literal}$.get('?cmd=googleresellerprogramhandle&action=syncAccount&accountId={/literal}{$accountId}{literal}', function ( data ) {
            document.location = '?cmd=accounts&action=edit&id={/literal}{$accountId}{literal}';
        });{/literal}" name="syncAccount" value="Sync Account" class=" btn btn-default btn-sm" />
    <table class="table glike">
    <thead>
    <tr>
        <th>skuId</th>
        <th>planName</th>
        <th>numberOfSeats</th>
        <th>status</th>
        <th>endTime</th>
    </tr>
    <thead>
    <tbody>
    {foreach from=$aSubscriptions item=arr}
    <tr>
        <td>{$arr.skuId}</td>
        <td>{$arr.planName}</td>
        <td>{$arr.numberOfSeats}</td>
        <td>{$arr.status}</td>
        <td>{$arr.endTime|substr:0:10|date_format}</td>
    </tr>
    {/foreach}
    <tbody>
    <table>
    {/if}
</div>

