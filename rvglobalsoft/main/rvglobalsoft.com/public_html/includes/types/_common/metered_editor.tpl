<table  cellspacing="0" cellpadding="5" border="0" width="100%">
<tbody><tr>
<td  valign="top"><div style="padding:10px 0px;"><a onclick="$(this).parents('tr:eq(0)').hide();$('#metered_var_editor').show();return false;"  class="prices menuitm " href="#"><span class="addsth">Add new measured variable</span></a>
        </td>
</tr>
<tr id="metered_var_editor" style="display:none">
    <td>
        <table border="0" cellpadding="3" class="left" cellspacing="0" id="powerdnspanel_table">
<tbody><tr>
<td width="100" class="fs11"><span class="left">Variable *</span> <a class="vtip_description" title="Required, used by API, letters only"></a></td>
<td width="100" class="fs11"><span class="left">Name *</span> <a class="vtip_description" title="Name, displayed in GUI"></a></td>
<td width="60" class="fs11"><span class="left">Unit</span> </td>
<td width="250" class="fs11">Description</td>
<td></td>
</tr>
<tr>
<td><input type="text" class="inp" value="" name="newmetered[variable]"></td>
<td><input type="text" class="inp" value="" name="newmetered[name]"></td>
<td><input type="text" class="inp" value=""  style="width:55px" name="newmetered[unit_name]"></td>
<td><input type="text" style="width:250px" class="inp" value="" name="newmetered[description]"></td>
<td>
    <a onclick="return saveProductFull();"  class="prices menuitm " href="#"><span class="addsth">Add</span></a>
</td>
</tr>
</tbody></table>
    </td>
</tr>
</tbody></table> <input type="hidden"  value="" name="newmetered[rm]" id="rmvar">
{literal}
    <script>
        function rmMeteredVar(vr) {
            
            if(confirm('Are you sure you wish to delete this variable? It will be removed from all products with this type!')) {
                $('#rmvar').val(vr);
                saveProductFull();
            }
            
            return false;
        }
        </script>
        
        {/literal}