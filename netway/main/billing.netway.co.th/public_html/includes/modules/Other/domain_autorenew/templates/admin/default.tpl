<table border="0" cellspacing="0" cellpadding="0" width="100%" id="content_tb" {if $currentfilter}class="searchon"{/if}>
<tr>
    <td ><h3>Domain auto renew</h3></td>
    <td  class="searchbox">
        โดเมนที่มีการตั้งค่า auto renew ไว้ที่ registrar จะต่ออายุให้ทันทีเมื่อโดเมนจะหมดอายุ มี cron run ตรวจสอบข้อมูลนี้อยู่สม่ำเสมอ
    </td>
</tr>
<tr>
    <td class="leftNav">
        {include file="$tplPath/admin/leftmenu.tpl"}
    </td>
    <td valign="top" class="bordered">
    <div id="bodycont"> 
    
    <div style="display: block; clear: both;">
        {if count($aDatas)}
        {foreach from=$aDatas key=modName item=aData}
        {assign var="total" value=$aData|@count}
        <div style="display: block; float: left; margin: 5px; width: 400px; border: 1px solid #AAAAAA;">
            
            <table cellspacing="0" cellpadding="3" border="0" width="100%" class="glike hover">
            <thead>
                <tr>
                    <th>{$total} Domain(s) ที่ถูกตั้งค่า auto renew ที่ {$modName}</th>
                </tr>
            </thead>
            <tbody>
                {foreach from=$aData key=domainId item=arr}
                <tr>
                    <td><a href="?cmd=domains&action=edit&id={$arr.id}" target="_blank">{$arr.name}</a></td>
                </tr>
                {/foreach}
            </tbody>
            </table>

        </div>
        {/foreach}
        {/if}
        
    </div>
    
    </div>
    </td>
  </tr>
</table>

<script type="text/javascript">

</script>