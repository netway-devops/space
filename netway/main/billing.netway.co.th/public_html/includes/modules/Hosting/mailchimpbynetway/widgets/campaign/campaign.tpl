<h3>Campaign list</h3>

{if count($aLists)}

<div class="row">
    <table class="table">
    <thead>
    <tr>
        <th>#</th>
        <th>Campaign</th>
        <th>Sent</th>
        <th>Open</th>
    </tr>
    </thead>
    <tbody>
    {foreach from=$aLists key=key item=aList}
    <tr>
        <td>{$key+1}</td>
        <td>{$aList.title}</td>
        <td>{$aList.emails_sent}</td>
        <td>{$aList.tracking.opens}</td>
    </tr>
    {/foreach}
    </tbody>
    </table>
</div>

{else}

<div class="alert">
  <button type="button" class="close" data-dismiss="alert">&times;</button>
  <strong>ไม่มีข้อมูล!</strong> รายการ campaign ของคุณ
</div>

{/if}