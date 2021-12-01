<div align="center">
	<p>&nbsp;</p>
	<h1>เลือกเพื่อเข้าใช้งานระบบ Zendesk</h1>
	<form action="" method="post">
		<input type="hidden" name="2stepSSO" value="1" />
		{foreach from=$listAccounts item=value}
			<br><input {if $value.id == $accountsId} checked="checked" {assign var=name value=$value.zendesk_agent_name} {/if}type="radio" class="selectZDAccount" name="selectZDAccount" value="{$value.zendesk_agent}" /> <span>{$value.zendesk_agent_name}</span>
		{/foreach}
		<input type="hidden" id="zdAccountName" name="zdAccountName" value="{$name}" />
		<br><br>
		<input type="submit" value="Submit" />
	</form>
</div>
{literal}
<script>

	$('.selectZDAccount').change(function(){
		
		$('#zdAccountName').val($(this).next("span").text());
		
	});

</script>
{/literal}