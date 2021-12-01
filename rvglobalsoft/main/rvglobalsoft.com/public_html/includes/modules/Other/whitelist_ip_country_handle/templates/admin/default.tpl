<div style="padding-left: 200px">
    
<div class="blu">
    <table border="0" width="100%" cellpadding="0" cellspacing="0">
        <tbody>
            <tr>
                <td width="50%" align="left">
                    <h3>Whitelist ip</h3>
                    <p>อนุญาติให้สามารถสั่งซื้อ license ของ IP ต่อไปนี้ได้</p>
                </td>
                <td width="50%" align="right"><a href="#" class="editbtn" onclick="addIp();" >Add IP</a></td>
            </tr>
        </tbody>
    </table>
</div>

<div class="nicerblu" id="addip" style="padding: 15px;display: none;">
    <center>
        <form method="post" action="?cmd=whitelist_ip_country_handle&action=add">
            <table border="0" cellpadding="6" cellspacing="0">
                <tbody>
                    <tr>
                        <td><strong>IP Address</strong></td>
                        <td>
                            <input type='text' name='ipaddress'/>    
                        </td>
                        <td>
                            <input type="submit" value="Add IP" style="font-weight:bold" class="submitme"> <span class="orspace">Or <a href="#" class="editbtn" onclick="$('#addip').slideUp();return false;">Cancel</a></span>
                        </td>
                    </tr>
                </tbody>
            </table>
        </form>
     </center>
 {literal}  
<script type="text/javascript">
       
    function addIp() {
        $('#addip').ShowNicely();
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
            <th>IP Address</th>
            <th width="40"></th>
        </tr>
        {foreach from=$data key=k item=item}
        <tr class="{if $smarty.foreach.num.index%2 == 0}even{/if}  havecontrols">
            <td>{$item.ip_start}</td>
            <td width="40"><a href='?cmd=whitelist_ip_country_handle&action=delete&id={$item.id}' >delete</a></td>
        </tr>
        {/foreach}
    </table>
</div>

</div>