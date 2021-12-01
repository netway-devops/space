<div class="form_change_email" style="display: none;">
    <div class="table-header">
        <p><b>Change Email Approval</b></p>
    </div>
    <br>
    <div>Current Email Approval : {$service.contact.email_approval}</div>
    <div>
    	<form method="post" action="" name="frmchangeemail" id="frmchangeemail" onsubmit="return false;">
            New Email Approval : <select name="reemail_approval" id="reemail_approval"  style="width: 400px"></select><br>
            <input id="validate_button" class="back" type="button" value="Back">
            <input type="hidden" name="order_id" id="order_id" value="{$service.order_id}"/>
            &nbsp; <input type="submit" value="Submit" id="validate_button"  class="submitphonecall" >
        </form>
    </div>
</div>