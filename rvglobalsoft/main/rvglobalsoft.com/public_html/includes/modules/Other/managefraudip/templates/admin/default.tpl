<div style="padding-left: 200px">
<div class="blu">
    <table border="0" width="100%" cellpadding="0" cellspacing="0">
        <tbody>
            <tr>
                <td width="50%" align="left"><strong>fraud ip List</strong></td>
                <td width="50%" align="right"><a href="#" class="editbtn" onclick="addFraudIp();" >Add new task</a></td>
            </tr>
        </tbody>
    </table>
</div>
<div class="nicerblu" id="addtask" style="padding: 15px;display: none;">
    <center>
        <form method="post" action="?cmd=managefraudip&action=addFraudIp">
            <table border="0" cellpadding="6" cellspacing="0">
                <tbody>
                    <tr>
                        <td><strong>Fraud IP</strong></td>
                        <td>
                            <input type='text' name='ip'/>    
                        </td>
                         <td><strong>Note</strong></td>
                        <td>
                            <textarea name='note' ></textarea>
                        </td>
                        <td>
                            <input type="submit" value="Add new task" style="font-weight:bold" class="submitme"> <span class="orspace">Or <a href="#" class="editbtn" onclick="$('#addtask').slideUp();return false;">Cancel</a></span>
                        </td>
                    </tr>
                </tbody>
            </table>
        </form>
     </center>
 {literal}  
<script type="text/javascript">
       
    function addFraudIp() {
        $('#addtask').ShowNicely();
        return false;
    }
</script>
 {/literal} 
<script type="text/javascript" src="https://rvglobalsoft.com/7944web/templates/default/js/facebox/facebox.js"></script>
<link rel="stylesheet" href="https://rvglobalsoft.com/7944web/templates/default/js/facebox/facebox.css" type="text/css">
</div>


<div id="ticketbody" style="padding:15px;">
    <table cellpadding="3" cellspacing="0" width="100%" class="whitetable" style="table-layout:fixed;">
        <tr>
            <th>Fraud IP</th>
            <th style="width: 250px;overflow: hidden;text-overflow: ellipsis;">Note</th>
            <th>Who</th>
            <th width="40"></th>
        </tr>
        {if $data}
        {foreach from=$data key=myId item=item name=num}
        <tr class="{if $smarty.foreach.num.index%2 == 0}even{/if}  havecontrols">
            <td>{$item.ip}</td>
            <td style="width: 250px;word-wrap:break-word;">{$item.note}</td>
            <td>{$item.who}</td>
            <td width="40"><a href='?cmd=managefraudip&action=deleteFraudIp&id={$item.id}' >delete</a></td>
        </tr>
        {/foreach}
        {/if}
    </table>
</div>
</div>