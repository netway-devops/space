{literal}
<style>
#error {
margin:10px;background:#F2DEDE;border-radius:4px;border:solid 1px #EED3D7;color:#B94A48;
font-size:13px;font-family:"Helvetica Neue",Helvetica,Arial,sans-serif;line-height:18px;
padding:14px;text-shadow:0 1px 0 rgba(255, 255, 255, 0.5);
}
.alert-success {
border-radius:4px;border:solid 1px green;
padding:14px;text-shadow:0 1px 0 rgba(255, 255, 255, 0.5);
}
</style>
{/literal}

<script type="text/javascript" language="javascript" src="{$template_dir}rvlicense/script_change_ip.js"></script>

<div class="alert-success sta_ok" style="display:none;">
<span id="txt_response_yes"></span>
</div>
<div id="error"class="sta_no" style="display:none;">
<span id="txt_response_no"></span>
</div>

<form name="frmchangeip" onsubmit="action_chageip();return false;"id="frmchangeip" method="post"  action="">
<input type="hidden" name="acc_id" value="{$acc_id}">
<input type="hidden" name="server_id" value="{$server_id}">
<input type="hidden" name="cmd" id="cmd" value="{$cmd}">
<input type="hidden" name="isNat" id="isNat" value="">
<!-- server_type =  for rvsitebuilder -->
<input type="hidden" name="server_type"  value="{$server_type}">
<table>
<tr>
      <td width="120" align="right" nowrap="nowrap"><label>From Server IP :</label></td>
      <td>
        <span id="frm_ip">{$frm_ip}</span>
      </td>
</tr>
<tr>
      <td width="120" align="right" nowrap="nowrap"><label>To Server IP :</label></td>
      <td>
        <input  type="text" name="to_ip" id="to_ip" value="{$to_ip}"size="18" >
      </td>
</tr>
<tbody id="pb_ip" {if $frm_pbip == '' || $frm_ip == $frm_pbip}style="display: none"{/if}>
<tr>
      <td width="120" align="right" nowrap="nowrap"><label>From Public IP :</label></td>
      <td>
        <span id="frm_ip">{$frm_pbip}</span>
      </td>
</tr>
<tr>
      <td width="120" align="right" nowrap="nowrap"><label>To Public IP :</label></td>
      <td>
        <input  type="text" name="to_pbip" id="to_pbip" value="{$to_pbip}"size="18" ><font color="red" id="pbip_error" style="display: none"> Invalid Public IP.</font>
      </td>
</tr>
</tbody>
<tr>
    <td colspan="2" align="center">
    <input type="button" name="bu_changeip" id="bu_changeip" onclick="action_chageip();" value="Change IP" style="display: "/>
    </td>
</tr>
</table>
</form>