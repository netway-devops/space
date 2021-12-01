    {literal}

<style type="text/css">
    .progress_1 {
        background:#f0f0f0;padding:10px 15px;
    }
    .progress_1 div.p {
        float: left;
        margin-right:15px;
        color:#c4bdbc;
    }
    .progress_1 div.act, .progress_1 div.p.act {
        font-weight:bold;
        color:#0162a0;
    }
    .progress_1 div.done, .progress_1 div.p.done {

        color:#727272;
    }
    .progress_2 {
        padding:5px 15px;
        background:#f7f7f7;
        color:#565656;
    }
    .alert, .progress_2.alert {
        background:#FFFBCC;
        color:#FF6600;
    }
    .progress_2 .inf {
        color:#0162a0;
    }
    .alert .inf, .progress_2.alert .inf {
        color:red;
    }
</style>    {/literal}

<div style="margin:10px 0px;">
	<div class="progress_1">
		<div class="p {if $details.status=='Pending'}act{elseif $cert_status_progress>1}done{/if}">1. Create order</div>
		<div class="p {if $cert_status_progress>2}done{elseif $cert_status_progress==2}act{/if}">2. Configuration required</div>
		<div class="p {if $cert_status_progress>3}done{elseif $cert_status_progress==4}act{/if}">3. Processing order</div>
		<div class="p {if $cert_status_progress>4}done{elseif $cert_status_progress==4}act{/if}">4. Certificate issued</div>
		{if $cert_id}<div class="p act" style="float:right">ServerTastic Order ID: {$cert_id}</div>{/if}
		<div class="clear"></div>
	</div>
	<div class="progress_2 {if !$cert_status_progress}alert{/if}">
	{if $details.status=='Pending'}
		<strong class="inf">Info:</strong> If you've <a href="?cmd=services&action=product&id={$details.product_id}" target="_blank">set auto-create On</a>, order will be placed in ServerTastic automatically after receiving payment from client.
		If you wish to do it manually use "Create" button.
	{elseif  $cert_status}
		<strong class="inf">Info:</strong> {$cert_status_description}
	{/if}
   {if $details.status=='Active'} <br/><strong class="inf">Note:</strong> To update current order status use "Synchronize" button above {/if}

	</div>
</div>