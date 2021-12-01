        <script type="text/javascript">{literal}
            function filterDtaus(num) {
                switch (num) {
                    case 0:
                        $('.dtaus_imported').show();
                        $('.dtaus_notimported').show();
                        break;
                    case 1:
                        $('.dtaus_imported').hide();
                        $('.dtaus_notimported').show();
                        break;
                    case 2:
                        $('.dtaus_imported').show();
                        $('.dtaus_notimported').hide();
                        break;
                }
            }
            $(document).ready(function(){
                $('#checkall').click(function() {
                    if($(this).is(":checked")) $('input[name="selected[]"]').attr('checked', true);
                    else $('input[name="selected[]"]').attr('checked', false);
                });
            });
        {/literal}</script>

<form action="" method="post">
<div class="lighterblue" style="padding: 10px">
    Filter:
    <input type="radio" value="0" name="filter" onchange="filterDtaus(0);" checked="checked" /> All &nbsp;
    <input type="radio" value="1"  name="filter" onchange="filterDtaus(1);" /> Not Imported &nbsp;
    <input type="radio" value="2"  name="filter" onchange="filterDtaus(2);" /> Imported &nbsp;
    <div style="padding: 10px">
        With selected: <input type="submit" name="import" value="Import to File" onclick='setTimeout("window.location.reload()", 2500);' />
        <input type="submit" name="delete" style="color: #cc0000" value="Delete" />
        <input type="submit" name="markimported" value="Mark as Imported" />
        <input type="submit" name="marknotimported" value="Mark as Not Imported" />
        <input type="submit" style="color: #009900; font-weight: bold;" value="Mark as Paid" onclick="return confirm1();" />
        <input type="submit" name="markunpaid" value="Mark as Unpaid" />
    </div>
</div>

    <div id="#bodycont">
	<div id="confirm_ord_delete" style="display:none" class="confirm_container">

	<div class="confirm_box">
		<h3>Mark as Paid</h3>
                <strong>Warning!</strong> Transactions marked already as paid will be not accounted.<br />
<br />


		<input type="radio" checked="checked" name="payinvoices" value="1" id="cc_hard"/> Mark as Paid and <strong>Create Transactions for invoices</strong><br />
		<input type="radio"  name="payinvoices" value="0" id="cc_soft"/> Only Mark as Paid<br />

		<br />
		<center><input type="submit" name="markpaid" value="{$lang.Apply}" style="font-weight:bold" />&nbsp;<input type="submit" value="{$lang.Cancel}" onclick="cancelsubmit2(); return false;"/></center>

	</div>
<script type="text/javascript">
{literal}
function confirm1() {
 $('#bodycont').css('position','relative');
             $('#confirm_ord_delete').width($('#bodycont').width()).height($('#bodycont').height()).show();
			 return false;
}
function cancelsubmit2() {
	$('#confirm_ord_delete').hide().parent().css('position','inherit');
}
{/literal}
</script>
</div>
<table width="100%" cellspacing="0" cellpadding="3" border="0" class="glike hover">
            <tbody>
              <tr>
                <th width="50"><input type="checkbox" id="checkall"/></th>
                <th width="80"></th>
                <th width="100">Payment Status</th>
                <th width="100">Date</th>
                <th width="70">Client</th>
                <th width="70">Invoice ID</th>
                <th width="50">Amount</th>
                <th width="100">Name</th>
                <th width="100">Bank Account</th>
                <th width="100">Bank Code</th>
                <th width="20"></th>
              </tr>
                {if !empty($transactions)}
                    {foreach from=$transactions item=t}
                    <tr class="{if $t.imported == '1'}dtaus_imported{else}dtaus_notimported{/if}">
                        <td><input type="checkbox" name="selected[]" value="{$t.id}" class="{$transaction.status}" /> #{$t.id}</td>
                        <td>{if $t.imported == '1'}Imported{else}<strong>Not Imported</strong>{/if}</td>
                        <td>{if $t.paid == '1'}<strong style="color:#00cc00">Paid</strong>{else}<strong style="color:#cc0000">Unpaid</strong>{/if}</td>
                        <td>{$t.date|dateformat:$date_format}</td>
                        <td><a href="?cmd=clients&amp;action=show&amp;id={$t.client_id}">#{$t.client_id} {$t.client_name}</a></td>
                        <td><a href="?cmd=invoices&amp;action=edit&amp;id={$t.invoice_id}" target="blank">#{$t.invoice_id}</a></td>
                        <td>&euro; {$t.amount} EUR</td>
                        <td>{$t.name}</td>
                        <td>{$t.bank_account}</td>
                        <td>{$t.bank_code}</td>
                        <td><a href="?cmd=module&amp;module={$module_id}&amp;delete=true&selected[]={$t.id}" onclick="if(!confirm('Do you really want to remove this entry?')) return false;" style="font-weight: bold; color:#cc0000">Delete</a></td>
                    </tr>
                    {/foreach}
                {else}
                <tr><td colspan="9" style="text-align: center; padding: 5px;"><strong>Nothing to display</strong></td></tr>
                {/if}

            </tbody>
</table>
    </div>
<div class="lighterblue" style="padding: 10px">
    <div style="padding: 10px">
        With selected: <input type="submit" name="import" value="Import to File" onclick='setTimeout("window.location.reload()", 2500);' /> 
        <input type="submit" name="delete" style="color: #cc0000" value="Delete" />
        <input type="submit" name="markimported" value="Mark as Imported" />
        <input type="submit" name="marknotimported" value="Mark as Not Imported" />
        <input type="submit" style="color: #009900; font-weight: bold;" value="Mark as Paid" onclick="return confirm1();" />
        <input type="submit" name="markunpaid" value="Mark as Unpaid" />
    </div>
</div>
</form>