<!-- Validate error container -->
<div class="validate_error_container alert">
    <h4>กรุณาตรวจสอบข้อมูลต่อไปนี้</h4>
    <ul>
    {if isset($aError) && count($aError)}
    	{foreach from=$aError key=k item=v}
		<li><label for="{$k}" class="error" style="display: block;">{$v}</label></li>
		{/foreach}
	{/if}
    </ul>
</div>
{literal}
<script language="JavaScript">
$(document).ready(function() {
	
    var validateErrorContainer  = $('div.validate_error_container');
    // validate the form when it is submitted
    var validateErrorValidator  = $('#formSubmit').validate({
        errorContainer:         validateErrorContainer,
        errorLabelContainer:    $('ul', validateErrorContainer),
        wrapper:    'li',
		submitHandler: function(form) {
			if ($.isFunction(window.validateFormSubmitted)) {
				if (validateFormSubmitted()) {
					form.submit();
				} else {
					return false;
				}
			}
			form.submit();
		}
    });
	
    if(! $('div.validate_error_container ul li').length) {
		$('div.validate_error_container').hide();
	}
});
</script>
{/literal}