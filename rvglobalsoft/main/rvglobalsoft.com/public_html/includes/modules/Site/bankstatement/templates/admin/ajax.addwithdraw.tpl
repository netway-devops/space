<form id="formSubmit" method="post">
{securitytoken}
<input type="hidden" name="cmd" value="{$cmd}" />
<input type="hidden" name="action" value="addwithdraw" />

<h3 style="border-bottom:1px solid #CCCCCC;">บันทึกการฝากถอนเงินออกจากธนาคาร</h3>
{include file="$tplClientPath/netway/validateinfo.tpl"}
<table border="0" cellspacing="2" cellpadding="2" width="100%">
<tbody>
    <tr valign="top">
        <td width="250">ฝากหรือถอนผ่านธนาคาร:</td>
        <td>
        <select name="type">
        	<option value="ฝาก"> ฝาก </option>
			<option value="ถอน"> ถอน </option>
        </select>
		&nbsp;
        <select name="payment" class="required" title="กรุณาเลือกธนาคาร">
            <option value="">--- ผ่านธนาคาร ---</option>
			{foreach from=$aBankTransfer key=k item=name}
            <option value="{$k}"> {$name} </option>
			{/foreach}
        </select>
        </td>
    </tr>
	<tr>
		<td>&nbsp;</td>
		<td>
			<label><input type="radio" name="format" value="เงินสด" checked="checked" onclick="$('.formatExt').hide();" /> เงินสด</label>
			<label><input type="radio" name="format" value="เช็คธนาคาร" onclick="$('.formatExt').show();" /> เช็คธนาคาร</label>
			<div class="formatExt" style="display:none; border:1px solid #E0ECFF; background-color:#F5F9FF; padding:3px;">
			    กรุณาระบุข้อมูลของเช็ค
				<p><label>หมายเลข:</label> <input type="text" id="formatExtNumber" name="formatExt[number]" value="" /></p>
				<p><label>ธนาคาร:</label>
				<select name="formatExt[bank]" id="formatExtBank" />
				    <option value="">--- เลือก ---</option>
					{foreach from=$aBankName item=name}
					<option value="{$name}"> {$name} </option>
					{/foreach}
				</select>
				</p>
			</div>
		</td>
	</tr>
    <tr>
        <td align="right">จำนวนเงิน:</td>
        <td>
            <input type="text" name="amount" value="" class="required" title="กรุณาระบุจำนวนเงิน" /> บาท
        </td>
    </tr>
    <tr>
        <td align="right">วันเดือนปีที่มีการทำรายการ:</td>
        <td>
            <input type="text" name="date" value=""  class="haspicker required" title="กรุณาระบุวันที่" />
        </td>
    </tr>
    <tr>
        <td align="right">Bank Balance log:</td>
        <td>
            <textarea name="log" cols="80" rows="4" ></textarea>
			<br />
            ใช้ในกรณีที่ต้องการระบุข้อมูลเพิ่มเติม เช่น จ่ายค่าโทรศัพท์แบบตัดยอดบัญชี, อัตราแลกเปลี่ยน เป้นต้น
        </td>
    </tr>
	
</tbody>
</table>

<div style="text-align: center; margin-bottom: 7px; padding: 15px 0px;" class="p6">
    <a onclick="$('#savechanges').click(); return false;" href="#" class="new_control greenbtn"><span>ลงบันทึกรายการ</span></a>
    <span class="orspace fs11">Or</span> <a onclick="$('.addWithdraw').toggle(); return false;" class="editbtn" href="#">Cancel</a>
    <input type="submit" name="save" style="display:none" id="savechanges" value="เพิ่ม">
    <input type="hidden" name="save" value="1">
</div>
</form>

{literal}
<script language="JavaScript">
function validateFormSubmitted () {
    var fVal    = $('#formSubmit input[name="format"]:checked').val();
    if (fVal != 'เช็คธนาคาร') {
        return true;
    }
	if ($('#formatExtNumber').val() == '') {
		alert('กรุณาระบุหมายเลขเช็ค');
		return false;
	}
    if ($('#formatExtBank').val() == '') {
        alert('กรุณาระบุเช็คของธนาคารอะไร');
		return false;
    }
	return true;
}
</script>
{/literal}