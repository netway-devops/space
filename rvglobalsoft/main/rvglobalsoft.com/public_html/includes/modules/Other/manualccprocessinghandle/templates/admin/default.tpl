{literal}
    <style type="text/css">
        .blank_state{
            background: url('{/literal}{$system_url}{literal}includes/modules/Other/manualccprocessing/admin/blank.png') no-repeat white;
            padding: 50px 0;
        }
    </style>
{/literal}

<h3>Manual Credit Card Processing</h3>

<table border="0" cellspacing="0" cellpadding="0" width="100%" id="content_tb">
<tr>
    <td><a href="?cmd=manualccprocessinghandle">Module Home</a></td>
    <td class="searchbox">
        <label> Filter &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </label>
        <label> <input type="radio" name="status" value="unpaid" onclick="document.location='?cmd=manualccprocessinghandle&status=unpaid';" {if !$status || $status == 'unpaid'} checked="checked" {/if} /> Unpaid </label> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
        <label> <input type="radio" name="status" value="paid" onclick="document.location='?cmd=manualccprocessinghandle&status=paid';" {if $status == 'paid'} checked="checked" {/if} /> Paid </label> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
        <label> <input type="radio" name="status" value="all" onclick="document.location='?cmd=manualccprocessinghandle&status=all';" {if $status == 'all'} checked="checked" {/if} /> All </label> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
        <label> <input type="radio" name="status" value="error" onclick="document.location='?cmd=manualccprocessinghandle&status=error';" {if $status == 'error'} checked="checked" {/if} /> Check error (Invoice เป็น CC Subscribe แต่ไม่มี Manual CC Processing record) </label> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
    
        <div style="display: block; float: right;">
            {$total} รายการ
        </div>
    </td>
</tr>
<tr>
    <td class="leftNav">
        <a href="?cmd=module&module=50">Manual CC Processing <br />(ตัวเดิมจาก hostbill)</a> 
    </td>
    <td valign="top" class="bordered">
    <div id="bodycont"> 

{if $list}
    
    {if $page != $prevPage}
    <div style="display: block; float: left;">
        <a href="?cmd=manualccprocessinghandle&status={$status}&page={$prevPage}" onclick="document.location='?cmd=manualccprocessinghandle&status={$status}&page={$prevPage}&sort={$sort}&order={$order}';" class="fadvanced">&lt;&lt; Prev</a>
    </div>
    {/if}
    {if $page != $nextPage}
    <div style="display: block; float: right;">
        <a href="?cmd=manualccprocessinghandle&status={$status}&page={$nextPage}" onclick="document.location='?cmd=manualccprocessinghandle&status={$status}&page={$nextPage}&sort={$sort}&order={$order}';" class="fadvanced">Next &gt;&gt;</a>
    </div>
    {/if}
    
    <table id="mccp" class="glike hover" cellpadding="0" cellspacing="0" border="0">
        <thead>
            <tr>
                <th>{$lang.invoice_id}</th>
                <th>{$lang.clientname}</th>
                <th>{$lang.Total}</th>
                <th>{$lang.Date}</th>
                <th><a href="?cmd=manualccprocessinghandle&status={$status}&sort=i.duedate&order={if $order == 'DESC'}ASC{else}DESC{/if}">{$lang.duedate}</a></th>
                <th>{$lang.Status}</th>
                <th>
                    {$lang.Action} 
                    <div style="float:right;font-weight:normal;font-size:11px;color:#535353;">
                        <span class="pord"></span>
                          Payment received
                    </div>
                </th>
            </tr>
        </thead>
        <tbody>
            {foreach from=$list item=inv}
                <tr class="{if $inv.status=='Processed'} compor {/if}">
                    <td><a href="?cmd=invoices&action=edit&id={$inv.invoice_id}">{$inv.invoice_id}</a></td>
                    <td><a href="?cmd=clients&action=show&id={$inv.client_id}">{$inv.firstname} {$inv.lastname}</a></td>
                    <td>{$inv.totalcur}</td>
                    <td>{$inv.date}</td>
                    <td>{$inv.duedate}</td>
                    <td>{$inv.status}</td>
                    <td>
                        {if $status != 'error'}
                        
                        {if $inv.status=='Unpaid' && $inv.state=='Pending' }
                            <a href="?cmd=module&module=50&action=process&id={$inv.id}" target="_blank" class="new_control greenbtn">
                                Process
                            </a>
                        {else}
                            <a href="?cmd=module&module=50&action=process&id={$inv.id}" target="_blank" class="menuitm">
                                {$lang.showdetails}
                            </a>
                        {/if}
                        {if $inv.state!='Processed'}
                            <a href="?cmd=module&module=50&action=delete&id={$inv.id}" target="_blank" class="menuitm">
                                {$lang.Delete}
                            </a>
                        {/if}
                        
                        {/if}
                    </td>
                </tr>
            {/foreach}
        </tbody>
    </table>
    
    {if $page != $prevPage}
    <div style="display: block; float: left;">
        <a href="?cmd=manualccprocessinghandle&status={$status}&page={$prevPage}" onclick="document.location='?cmd=manualccprocessinghandle&status={$status}&page={$prevPage}&sort={$sort}&order={$order}';" class="fadvanced">&lt;&lt; Prev</a>
    </div>
    {/if}
    {if $page != $nextPage}
    <div style="display: block; float: right;">
        <a href="?cmd=manualccprocessinghandle&status={$status}&page={$nextPage}" onclick="document.location='?cmd=manualccprocessinghandle&status={$status}&page={$nextPage}&sort={$sort}&order={$order}';" class="fadvanced">Next &gt;&gt;</a>
    </div>
    {/if}
    
{else}
    <div class="blank_state" >
        <div class="blank_info">
            <h3>There are no transactions yet.</h3>
            Here you will find all transactions marked for manual processing
            <div class="clear"></div>
        </div>
    </div>
{/if}


    </div>
    </td>
  </tr>
</table>