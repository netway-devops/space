<div class="bordered" style='margin: 0 200px 0 200px;'>
    <div align="center" style="padding-top:20px;">
        <h1><u>SSL Symantec Api Status</u></h1>
        <br />
        <table style='background-color:#e5e5e5; table-layout:fixed;'>
            <col width='150px'>
            <col width='150px'>
            <col width='150px'>
            <col width='150px'>
            <tr>
                <th align='left'>Partner Code<th>
                <td align='center'>{$symantecApiInfo.partner_code}</td> 
            </tr>
            <tr>
                <th align='left'>API Username<th>
                <td align='center'>{$symantecApiInfo.username}</td> 
            </tr>
            <tr>
                <th align='left'>Contract ID<th>
                <td align='center'>{$symantecApiInfo.contractId}</td> 
            </tr>
            <tr>
                <th align='left'>SanBox Mode<th>
                <td align='center' style='padding-bottom:10px'>{$symantecApiInfo.mode}</td> 
            </tr>
        </table>
        <br /><br />
        <table style='background-color:#e5e5e5; table-layout:fixed;'>
            <col width='100px'>
            <col width='100px'>
            <col width='100px'>
            <tr>
                <th align='left'>Module</th>
                <th align='center'>Status</th>
           </tr>
            <tr>
                <th align='left' class='thright' >Hello</th>
                <td align='center'>{$hello}</td>
            </tr>
            <tr>
                <th align='left' class='thright' >GetUserAgreement</th>
                <td align='center' style='padding-bottom:10px'>{$userAgreement}</td>
            </tr>
        </table>
        <br /><br />
        <table style='background-color:#e5e5e5; table-layout:fixed;'>
            <col width='100px'>
            <col width='100px'>
            <tr>
                <th colspan="2">CRON Table</th>
            </tr>
            <tr>
                <th align='left'>Name</th>
                <th align='center'>Last run</th>
           </tr>
           {foreach from=$cronTask item=eachTask}
            <tr>
                <td align='left' class='thright' >{$eachTask.name}</td>
                <td align='center' style='padding-bottom:10px'>{$eachTask.lastrun}</td>
            </tr>
            {/foreach}
        </table>
        <br /><br />
        <br />
        <br />
    </div>
</div>





















<style>
{literal}
    th,td{
        padding-top:20px;
    }
    .thright{
        padding-right:250px;
    }
{/literal}
</style>