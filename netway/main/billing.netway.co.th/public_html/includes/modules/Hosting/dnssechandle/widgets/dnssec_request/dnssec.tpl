<style type="text/css">
{literal}
.w60x { width: 60%;}
{/literal}
</style>

<section class="section-changelabel">
    <div class="wbox">
        <div class="wbox_header">DNSSEC Request Form</div>
        <div class="wbox_content">

<form id="dnssecForm" action="?cmd=dnssechandle&action=dnssecRequest" method="post">
<p>กรอกข้อมูลเพื่อขอใช้งาน DNSSEC</p>

<table class="table table-striped account-details-tb tb-sh">
<tbody>
<tr>
    <td class="w30"><label for="domain">Domain:</label></td>
    <td class="cell-border no-bold">
        <input name="domain" class="form-control inp w60x" value="{$domain}" readonly="readonly" required="required"  />
    </td>
</tr>
<tr>
    <td class="w30"><label for="domain">Status:</label></td>
    <td class="cell-border no-bold">
        {if $aCustomField.dnssec_status} 
        <span class="label {if $aCustomField.dnssec_status == 'processing'} label-warning  {else} label-Active {/if}"> {$aCustomField.dnssec_status}  </span> 
        {if $aCustomField.dnssec_status == 'processing'}
         &nbsp; (24 - 48 Hours)
        {/if}
        {else} none {/if}
    </td>
</tr>
{if $aCustomField.dnssec_info}
<tr>
    <td class="w30"><label for="domain">DS Records info:</label></td>
    <td class="cell-border no-bold">
        {$aCustomField.dnssec_info}
    </td>
</tr>
{/if}
<tr>
    <td class="w30"><label for="dnssec_keytag">DS Records KeyTag:</label></td>
    <td class="cell-border no-bold">
        <input name="dnssec_keytag" class="form-control inp w60x" value="{$aCustomField.dnssec_keytag}"  required="required" />
    </td>
</tr>
<tr>
    <td class="w30"><label for="dnssec_algorithm">DS Records Algorithm:</label></td>
    <td class="cell-border no-bold">
        <input name="dnssec_algorithm" class="form-control inp w60x" value="{$aCustomField.dnssec_algorithm}"  required="required" />
    </td>
</tr>
<tr>
    <td class="w30"><label for="dnssec_digest_type">DS Records Digest Type:</label></td>
    <td class="cell-border no-bold">
        <input name="dnssec_digest_type" class="form-control inp w60x" value="{$aCustomField.dnssec_digest_type}"  required="required" />
    </td>
</tr>
<tr>
    <td class="w30"><label for="dnssec_digest">DS Records Digest:</label></td>
    <td class="cell-border no-bold">
        <input name="dnssec_digest" class="form-control inp w60x" value="{$aCustomField.dnssec_digest}"  required="required" />
    </td>
</tr>
{if ! $aCustomField.dnssec_status || $aCustomField.dnssec_status == 'none'}
<tr>
    <td class="w30">&nbsp;</td>
    <td class="cell-border no-bold">
        <input type="hidden" name="make" value="submit"/>
        <input type="submit" class="btn btn-primary my-2 my-md-0 btn-w-100 btn-sm-w-auto" value="Request"/>
    </td>
</tr>
{/if}
</tbody>
</table>

<input type="hidden" name="accountId" value="{$accountId}" />
{securitytoken}
</form>

<script type="text/javascript">
{literal}
$(document).ready( function () {
    $('#dnssecForm').submit( function () {
        $.post($(this).attr('action'), $(this).serialize(), function (data) {
            var oData   = $.parseJSON(data.data);
            //console.log(oData);
            location.reload();
        });
        return false;
    });
});
{/literal}
</script>



        </div>
    </div>
</section>

