<div class="phonecall" style="display: none">
    <div class="table-header">
        <p><b>Schedule Verification Call</b></p>
    </div>
    <br>
    <div style="margin-left: 10px">A verification call with the administrative contact will be required before the issuance of certificate. The telephone number must be publically listed in an approved telephone directory. If you don't want to schedule verification call, you can also contact the SSL authority directly by using your order ID that shown in service details as a reference.</div>
    <br>
    <div id="phonecall_error" style="background-color: pink; display: none; width: 99%; margin-left: 10px"></div>
    <div style="margin-left: 10px">
        <b>Schedule Date and Time for Verification Call with SSL Authority</b>
    </div>
    <br>
    <form method="post" action="?cmd=module&module=ssl&action=ajax_submitphonecall" name="frmPhonecall" id="frmPhonecall" onsubmit="return false;">
    	<div style="margin-left: 10px">
    		Verification Call 1:<font color="red"> * </font><br><input type="text" id="txt_date1_from" name="txt_date1_from" placeholder="Select date and time" readonly="readonly" style="cursor: default" value="{$service.time_verify_from|date_format:'%Y-%m-%d %H:%M:%S'}"/>&nbsp; TO &nbsp;<input type="text" id="txt_date1_to" name="txt_date1_to" placeholder="Select date and time" readonly="readonly" style="cursor: default" value="{$service.time_verify_to|date_format:'%Y-%m-%d %H:%M:%S'}"/>
		    <select name="timezone_1">
		        <option value="-12">GMT-12</option>
		        <option value="-11">GMT-11</option>
		        <option value="-10">GMT-10</option>
		        <option value="-9">GMT-9</option>
		        <option value="-8">GMT-8</option>
		        <option value="-7">GMT-7</option>
		        <option value="-6">GMT-6</option>
		        <option value="-5">GMT-5</option>
		        <option value="-4">GMT-4</option>
		        <option value="-3">GMT-3</option>
		        <option value="-2">GMT-2</option>
		        <option value="-1">GMT-1</option>
		        <option value="0" selected="selected">GMT 0</option>
		        <option value="+1">GMT+1</option>
		        <option value="+2">GMT+2</option>
		        <option value="+3">GMT+3</option>
		        <option value="+4">GMT+4</option>
		        <option value="+5">GMT+5</option>
		        <option value="+6">GMT+6</option>
		        <option value="+7">GMT+7</option>
		        <option value="+8">GMT+8</option>
		        <option value="+9">GMT+9</option>
		        <option value="+10">GMT+10</option>
		        <option value="+11">GMT+11</option>
		        <option value="+12">GMT+12</option>
		    </select>
		</div>
		<div style="margin-left: 10px">Verification Call 2:<br><input type="text" id="txt_date2_from" name="txt_date2_from" placeholder="Select date and time" readonly="readonly" style="cursor: default" value="{$service.time_verify_from2|date_format:'%Y-%m-%d %H:%M:%S'}"/>&nbsp; TO &nbsp;<input type="text" id="txt_date2_to" name="txt_date2_to" placeholder="Select date and time" readonly="readonly" style="cursor: default" value="{$service.time_verify_to2|date_format:'%Y-%m-%d %H:%M:%S'}"/>
			<select name="timezone_2">
				<option value="-12">GMT-12</option>
		        <option value="-11">GMT-11</option>
		        <option value="-10">GMT-10</option>
		        <option value="-9">GMT-9</option>
		        <option value="-8">GMT-8</option>
		        <option value="-7">GMT-7</option>
		        <option value="-6">GMT-6</option>
		        <option value="-5">GMT-5</option>
		        <option value="-4">GMT-4</option>
		        <option value="-3">GMT-3</option>
		        <option value="-2">GMT-2</option>
		        <option value="-1">GMT-1</option>
		        <option value="0" selected="selected">GMT 0</option>
		        <option value="+1">GMT+1</option>
		        <option value="+2">GMT+2</option>
		        <option value="+3">GMT+3</option>
		        <option value="+4">GMT+4</option>
		        <option value="+5">GMT+5</option>
		        <option value="+6">GMT+6</option>
		        <option value="+7">GMT+7</option>
		        <option value="+8">GMT+8</option>
		        <option value="+9">GMT+9</option>
		        <option value="+10">GMT+10</option>
		        <option value="+11">GMT+11</option>
		        <option value="+12">GMT+12</option>
			</select>
		</div>
		<div style="margin-left: 10px">
			Extension Number:<br><input type="text"  name="ext_num" id="ext_num" placeholder="66x xxxx xxxx #extension" value="{$service.contact.ext_number}"/>
		</div>
		<input type="hidden" name="order_id" value="{$service.order_id}" />
		<div  style="margin-left: 150px;">
			<br>
			<input id="validate_button" class="back" type="button" value="Back">
			&nbsp; <input type="submit" value="Submit" id="validate_button"  class="submitphonecall" >
			&nbsp <input id="validate_button" class="phonecall_reset" type="reset" value="Reset" >
		</div>
    </form>
</div>

<div class="change_phonecall" style="display: none;">
	<div>
		<input id="validate_button" class="change_phonecall_button" type="button" value="Edit" onclick="tosubmitphonecall();">
	</div>
</div>