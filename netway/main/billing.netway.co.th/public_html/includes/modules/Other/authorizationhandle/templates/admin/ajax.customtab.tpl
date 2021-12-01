{if $action=='customtab'}
    {literal}
    <script type="text/javascript">

    </script>
    {/literal}
    
    <div class="blu" style="text-align:right">
        <form action="?cmd=quotationhandle&action=create" method="post">
            <input type="hidden" name="clientId" value="{$clientId}" />
            <input type="submit" value="เพิ่มข้อมูล" onclick="window.location='?cmd=quotationhandle&action=create&clientId={$clientId}';return false;"/>
            {securitytoken}
        </form>
    </div>

<table class="glike hover" border="0" cellpadding="3" cellspacing="0" width="100%">
<thead>
    <tr>
        <th>No</th>
        <th>Name</th>
        <th>Surname</th>
        <th>Position</th>
        <th>Email</th>
        <th>Phone</th>
        <th>ID Card</th>
        <th>Role</th>
        <th align="right" class="lastelb">&nbsp; </th>
    </tr>
</thead>

<tbody>
    <tr>
        <td>1</td>
        <td>Prasit</td>
        <td>Narkdee</td>
        <td>Manager</td>
        <td>prasit@netway.co.th</td>
        <td>0841112588</td>
        <td>
            <div class="attachment">
                <a href="?cmd=root&action=download&type=downloads&id=581">Download</a>
            </div>
        </td>
        <td>
            "Reboot
            Root access
            Onsite"
        </td>
        <td class="lastelb">
            <a class="delbtn right" onclick=" if (confirm('Are you sure you want to delete this note?')) AdminNotes.del(9677); return false;" href="#">
                <small>[Delete]</small>
            </a>
            <a class="editbtn-ico right" onclick=" if (confirm('Are you sure you want to delete this note?')) AdminNotes.del(9677); return false;" href="#">
                <small>[Delete]</small>
            </a>
        </td>
    </tr>
</tbody>
</table>
{/if}