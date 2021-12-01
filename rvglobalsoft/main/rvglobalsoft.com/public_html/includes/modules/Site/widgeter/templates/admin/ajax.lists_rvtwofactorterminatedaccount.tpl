{php}
//echo '<pre>'; print_r($this->get_template_vars('aDatas')); echo '</pre>';
{/php}
<tbody class='centerAlign'>
{foreach from=$aDatas item=aData}
{if $aData.Account_ID == 'Account_ID'}{continue}{/if}
<tr>
    <td><a href="/7944web/index.php?cmd=accounts&action=edit&id={$aData.Account_ID}" target="_blank">{$aData.Account_ID}</a></td>
    <td><div align="center">{$aData.Order_ID}</div></td>
    <td><div align="center">{$aData.Product_ID}</div></td>
    <td><div align="center">
        {if $aData.Product_ID == '58'}
            WHM (Trial)
        {elseif $aData.Product_ID == '59'}
            WHM
        {elseif $aData.Product_ID == '60'}
            cPanel
        {elseif $aData.Product_ID == '61'}
            Apps
        {/if}
    </div></td>
    <td>
    {if $aData.Next_Due != '0000-00-00'}
        {php}
        $aData = $this->get_template_vars('aData');
        echo '<div align="center">' . date('d M Y', strtotime($aData['Next_Due'])) . '</div>';
        {/php}
    {else}
        <div align="center">-</div>
    {/if}
    </td>
    <td><div align="center">{$aData.Status}</div></td>
    <td>
        <div align="left">
        <!--<input type="text" onmouseover="this.select()" style="width:100%; background-color:#efefef; border:0px;" value="{$aData.Client_ID}-{$aData.Account_ID}-{$aData.Firstname}-{$aData.Lastname}{if $aData.Product_ID == 60}-cPanel{elseif $aData.Product_ID == 61}-Apps{/if}" readonly/>
        -->
        <div class="certName"><span>{$aData.CERT_NAME}</span></div>
        
        </div>
    </td>
    <td>
        <div align="center"><input type="button" value="Revoked" onclick="revoked({$aData.Account_ID});" class="new_control greenbtn" /></div>
    </td>
</tr>
{/foreach}
</tbody>

<script type="text/javascript">
sorterUpdate({$sorterlow},{$sorterhigh},{$sorterrecords});
{literal}
$(document).ready(function() {
    $('#totalpages').val({/literal}{$totalpages}{literal});
    $("div.pagination").pagination($("#totalpages").val());

    $('#filter').keyup(function() {
        var rex = new RegExp($(this).val(), 'i');
        $('.centerAlign tr').hide();
        $('.centerAlign tr').filter(function () {
            return rex.test($(this).text());
        }).show();
    }).show();
    
    $('.blu').hide();
});
function revoked(accountId){
    if(confirm('This certificate revoked on Symantec?')){
        $.ajax({
            url: '{/literal}{$system_url}{literal}7944web/index.php',
            type: 'POST',
            data: {
                cmd: 'module'
                , module: 'symantecvip'
                , action: 'revoked'
                , accountid: accountId
            },
            success: function(data){
                location.reload();
            }
        });
    }
}
{/literal}
</script>