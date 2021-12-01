{include file="$tplPath/header.tpl"}

<p>
    <button type="button" onClick="exportsettinghandle_exportAllSetting();" class="btn btn-primary">Export all</button>
    Export ไปที่ path "{$savePath}"
</p>
<table cellspacing="0" cellpadding="3" border="0" width="100%" class="glike hover">
<tbody>
    <tr>      
        <th width="150">Filename</th>
        <th>Name</th>
    </tr>
</tbody>
<tbody>
{foreach from=$aSettings item=aSetting key=filename}
<tr id="{$filename}" class="aSetting" valign="top">
    <td>{$filename}</td>
    <td>{$aSetting.name}</td>
</tr>
{/foreach}
</tbody>
</table>

<script type="text/javascript">
{literal}
var exportFile  = '';
function exportsettinghandle_exportAllSetting ()
{
    if (! confirm('Confirm?')){
        return false;
    }

    exportsettinghandle_exportSetting();

}

function exportsettinghandle_exportSetting ()
{
    var obj     = $('.aSetting:visible').eq(0);
    exportFile  = obj.attr('id');
    console.log(exportFile);
    if (! exportFile) {
        alert('Done');
        return false;
    }
    $('#'+ exportFile +' td:first').addLoader();
    $.getJSON('?cmd=exportsettinghandle&action=export&filename='+ exportFile, function () {
        $('#'+ exportFile).hide();
        $('#preloader').remove();
        exportsettinghandle_exportSetting();
    });
}

{/literal}
</script>


{include file="$tplPath/footer.tpl"}