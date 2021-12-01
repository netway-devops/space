{include file="$tplPath/admin/header.tpl"}

<script defer src="https://use.fontawesome.com/releases/v5.0.6/js/all.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.5/css/bootstrap.min.css" integrity="sha384-AysaV+vQoT3kOAXZkl02PThvDr8HYKPZhNT5h/CXfBThSRXQ6jW5DO2ekP5ViFdi" crossorigin="anonymous">
<script src="{$smarty.const.BILLING_URL}/includes/modules/Site/producthandle/templates/js/jQuery-Plugin-To-Fix-Table-Headers-Columns-Sticky-js/src/sticky.js"></script>
<h2>Product Configuration</h2>

<table id="orderPage" class="table table-hover">
<thead class="thead-inverse">
<tr>
    <th rowspan="3">Product order page name</th>
    <th rowspan="3">Product Name</th>
    <th rowspan="3">Product ID</th>
    <th rowspan="3">ไม่อนุญาติให้ทำ Provision โดย Authorize Payment อย่างเดียวโดยที่ยังไม่ Capture Payment</th>
    <th colspan="36"><div align="center">Automation</div></th>
    <th rowspan="2" colspan="3" style="background-color: #333333"><div align="center">Invoice</div></th>
    <th rowspan="2" colspan="9" style="background-color: #666666"><div align="center">Reminder</div></th>
    <th rowspan="2" colspan="4" style="background-color: #333333"><div align="center">Email</div></th>
    
    
</tr>
    <th colspan="6" style="background-color: #333333"><div align="center">Create / Regis</div></th>
    <th colspan="6" style="background-color: #666666"><div align="center">Upgrade / Renew</div></th>
    <th colspan="6" style="background-color: #333333"><div align="center">Transfer In (Domain)</div></th>
    <th colspan="6" style="background-color: #666666"><div align="center">Suspend</div></th>
    <th colspan="6" style="background-color: #333333"><div align="center">Unsuspend</div></th>
    <th colspan="6" style="background-color: #666666"><div align="center">Terminate</div></th>
</tr>
<tr>
    <th>Automatic</th>
    <th>service catalog ID / name </th>
    <th>zendesk guide ID / name</th>
    <th>fulfillment fail ID (A)</th>
    <th>fulfillment sucess ID (B)</th>
    <th></th>
    
    <th>Automatic</th>
    <th>service catalog ID / name </th>
    <th>zendesk guide ID / name</th>
    <th>fulfillment fail ID (A)</th>
    <th>fulfillment sucess ID (B)</th>
    <th></th>
    
    <th>Automatic</th>
    <th>service catalog ID / name </th>
    <th>zendesk guide ID / name</th>
    <th>fulfillment fail ID (A)</th>
    <th>fulfillment sucess ID (B)</th>
    <th></th>
    
    <th>Automatic</th>
    <th>service catalog ID / name </th>
    <th>zendesk guide ID / name</th>
    <th>fulfillment fail ID (A)</th>
    <th>fulfillment sucess ID (B)</th>
    <th></th>
    
    <th>Automatic</th>
    <th>service catalog ID / name </th>
    <th>zendesk guide ID / name</th>
    <th>fulfillment fail ID (A)</th>
    <th>fulfillment sucess ID (B)</th>
    <th></th>
    
    <th>Automatic</th>
    <th>service catalog ID / name </th>
    <th>zendesk guide ID / name</th>
    <th>fulfillment fail ID (A)</th>
    <th>fulfillment sucess ID (B)</th>
    <th></th>
    
    <th>Generate invoices (days before the due date)</th>
    <th>Advanced due date settings</th>
    <th>Automatic Cancelation Requests Processing</th>
    
    <th>Send payment reminder emails</th>
    <th>Send unpaid invoice reminder</th>
    <th>Days to send unpaid reminder</th>
    <th>Send Ovderdue 1 reminder</th>
    <th>Days to send Ovderdue 1 reminder</th>
    <th>Send Ovderdue 2 reminder</th>
    <th>Days to send Ovderdue 2 reminder</th>
    <th>Send Ovderdue 3 reminder</th>
    <th>Days to send Ovderdue 3 reminder</th>
    
    <th>Account created email / Domain registration succeeded</th>
    <th>Account suspended email / Domain transfer initiated</th>
    <th>Account unsuspended email / Domain renewal succeeded</th>
    <th>Account terminated email / Expiring domain notification</th>
    
</tr>
</thead>
<tbody>
{assign var="catName" value=""}
{foreach from=$aCategory key=catId item=aCat}
{foreach from=$aProducts[$catId] key=productId item=aProduct}

{assign var="fulfillment_create_id" value=$aConfiguration[$productId].fulfillment_create_id}
{assign var="fulfillment_create_success" value=$aConfiguration[$productId].fulfillment_create_success}
{assign var="fulfillment_create_fail" value=$aConfiguration[$productId].fulfillment_create_fail}

{assign var="fulfillment_upgrade_id" value=$aConfiguration[$productId].fulfillment_upgrade_id}
{assign var="fulfillment_upgrade_success" value=$aConfiguration[$productId].fulfillment_upgrade_success}
{assign var="fulfillment_upgrade_fail" value=$aConfiguration[$productId].fulfillment_upgrade_fail}

{assign var="fulfillment_renew_id" value=$aConfiguration[$productId].fulfillment_renew_id}
{assign var="fulfillment_renew_success" value=$aConfiguration[$productId].fulfillment_renew_success}
{assign var="fulfillment_renew_fail" value=$aConfiguration[$productId].fulfillment_renew_fail}

{assign var="fulfillment_transfer_id" value=$aConfiguration[$productId].fulfillment_transfer_id}
{assign var="fulfillment_transfer_success" value=$aConfiguration[$productId].fulfillment_transfer_success}
{assign var="fulfillment_transfer_fail" value=$aConfiguration[$productId].fulfillment_transfer_fail}

{assign var="fulfillment_suspend_id" value=$aConfiguration[$productId].fulfillment_suspend_id}
{assign var="fulfillment_suspend_success" value=$aConfiguration[$productId].fulfillment_suspend_success}
{assign var="fulfillment_suspend_fail" value=$aConfiguration[$productId].fulfillment_suspend_fail}

{assign var="fulfillment_unsuspend_id" value=$aConfiguration[$productId].fulfillment_unsuspend_id}
{assign var="fulfillment_unsuspend_success" value=$aConfiguration[$productId].fulfillment_unsuspend_success}
{assign var="fulfillment_unsuspend_fail" value=$aConfiguration[$productId].fulfillment_unsuspend_fail}

{assign var="fulfillment_terminate_id" value=$aConfiguration[$productId].fulfillment_terminate_id}
{assign var="fulfillment_terminate_success" value=$aConfiguration[$productId].fulfillment_terminate_success}
{assign var="fulfillment_terminate_fail" value=$aConfiguration[$productId].fulfillment_terminate_fail}

<tr class="tableRow {if $catName != $aCat.name}  {/if}" title="{$aCat.name} --- &gt; {$aProduct.name|strip_tags}">
    <td>
        {if $catName != $aCat.name}
        <a href="?cmd=services&action=category&id={$catId}" target="_blank">{$aCat.name}</a>
        {assign var="catName" value=$aCat.name}
        {/if}
    </td>
    <td><a href="?cmd=services&action=product&id={$productId}" target="_blank">{$aProduct.name}</a></td>
    <td>{$aProduct.id}</td>
    <td>{if $aProduct.provision_with_capture}<i class="fas fa-check-circle" style="color: green;"></i>{/if}</td>
    
    <td>
        {if $aProduct.type == 9}
        {if $aAutomation[$productId].EnableAutoRegisterDomain == 'off'}<i class="fas fa-times-circle" style="color: red;"></i>{else}<i class="fas fa-check-circle" style="color: green;"></i>{/if}
        {else}
        {if $aProduct.autosetup}<i class="fas fa-check-circle" style="color: green;"></i>{else}<i class="fas fa-times-circle" style="color: red;"></i>{/if}
        {/if}
    </td>
    <td>
        {if $aConfiguration[$productId].fulfillment_create_id}<a href="?cmd=servicecataloghandle&action=view&id={$aConfiguration[$productId].fulfillment_create_id}" target="_blank">{$aConfiguration[$productId].fulfillment_create_id} / {$aServiceCatalog[$fulfillment_create_id].title}</a>{/if}
    </td>
    <td>
        {if $aConfiguration[$productId].fulfillment_create_id}{if $aServiceCatalog[$fulfillment_create_id].zendesk_guide_id}<a href="https://pdi-netway.zendesk.com/hc/th/articles/{$aServiceCatalog[$fulfillment_create_id].zendesk_guide_id}" target="_blank">{$aServiceCatalog[$fulfillment_create_id].zendesk_guide_id} / {$aServiceCatalog[$fulfillment_create_id].title}</a>{/if}{/if}
    </td>
    <td>
        {if $aConfiguration[$productId].fulfillment_create_success}<a href="?cmd=servicecataloghandle&action=view&id={$aConfiguration[$productId].fulfillment_create_id}" target="_blank">{$aConfiguration[$productId].fulfillment_create_success} / {$aProcessGroup[$fulfillment_create_success].name}</a>{/if}
    </td>
    <td>
        {if $aConfiguration[$productId].fulfillment_create_fail}<a href="?cmd=servicecataloghandle&action=view&id={$aConfiguration[$productId].fulfillment_create_id}" target="_blank">{$aConfiguration[$productId].fulfillment_create_fail} / {$aProcessGroup[$fulfillment_create_fail].name}</a>{/if}
    </td>
    <td></td>
    
    <td>
        {if $aProduct.type == 9}
        {if $aAutomation[$productId].EnableAutoRenewDomain == 'off'}<i class="fas fa-times-circle" style="color: red;"></i>{else}<i class="fas fa-check-circle" style="color: green;"></i>{/if}
        {else}
        {if $aAutomation[$productId].EnableAutoUpgrades == 'off'}<i class="fas fa-times-circle" style="color: red;"></i>{else}<i class="fas fa-check-circle" style="color: green;"></i>{/if}
        {/if}
    </td>
    <td>
        {if $aProduct.type == 9}
        {if $aConfiguration[$productId].fulfillment_renew_id}<a href="?cmd=servicecataloghandle&action=view&id={$aConfiguration[$productId].fulfillment_renew_id}" target="_blank">{$aConfiguration[$productId].fulfillment_renew_id} / {$aServiceCatalog[$fulfillment_renew_id].title}</a>{/if}
        {else}
        {if $aConfiguration[$productId].fulfillment_upgrade_id}<a href="?cmd=servicecataloghandle&action=view&id={$aConfiguration[$productId].fulfillment_upgrade_id}" target="_blank">{$aConfiguration[$productId].fulfillment_upgrade_id} / {$aServiceCatalog[$fulfillment_upgrade_id].title}</a>{/if}
        {/if}
    </td>
    <td>
        {if $aProduct.type == 9}
        {if $aConfiguration[$productId].fulfillment_renew_id}{if $aServiceCatalog[$fulfillment_renew_id].zendesk_guide_id}<a href="https://pdi-netway.zendesk.com/hc/th/articles/{$aServiceCatalog[$fulfillment_renew_id].zendesk_guide_id}" target="_blank">{$aServiceCatalog[$fulfillment_renew_id].zendesk_guide_id} / {$aServiceCatalog[$fulfillment_renew_id].title}</a>{/if}{/if}
        {else}
        {if $aConfiguration[$productId].fulfillment_upgrade_id}{if $aServiceCatalog[$fulfillment_upgrade_id].zendesk_guide_id}<a href="https://pdi-netway.zendesk.com/hc/th/articles/{$aServiceCatalog[$fulfillment_upgrade_id].zendesk_guide_id}" target="_blank">{$aServiceCatalog[$fulfillment_upgrade_id].zendesk_guide_id} / {$aServiceCatalog[$fulfillment_upgrade_id].title}</a>{/if}{/if}
        {/if}
    </td>
    <td>
        {if $aProduct.type == 9}
        {if $aConfiguration[$productId].fulfillment_renew_success}<a href="?cmd=servicecataloghandle&action=view&id={$aConfiguration[$productId].fulfillment_renew_id}" target="_blank">{$aConfiguration[$productId].fulfillment_renew_success} / {$aProcessGroup[$fulfillment_renew_success].name}</a>{/if}
        {else}
        {if $aConfiguration[$productId].fulfillment_upgrade_success}<a href="?cmd=servicecataloghandle&action=view&id={$aConfiguration[$productId].fulfillment_upgrade_id}" target="_blank">{$aConfiguration[$productId].fulfillment_upgrade_success} / {$aProcessGroup[$fulfillment_upgrade_success].name}</a>{/if}
        {/if}    
    </td>
    <td>
        {if $aProduct.type == 9}
        {if $aConfiguration[$productId].fulfillment_renew_fail}<a href="?cmd=servicecataloghandle&action=view&id={$aConfiguration[$productId].fulfillment_renew_id}" target="_blank">{$aConfiguration[$productId].fulfillment_renew_fail} / {$aProcessGroup[$fulfillment_renew_fail].name}</a>{/if}
        {else}
        {if $aConfiguration[$productId].fulfillment_upgrade_fail}<a href="?cmd=servicecataloghandle&action=view&id={$aConfiguration[$productId].fulfillment_upgrade_id}" target="_blank">{$aConfiguration[$productId].fulfillment_upgrade_fail} / {$aProcessGroup[$fulfillment_upgrade_fail].name}</a>{/if}
        {/if}    
    </td>
    <td></td>

    <td>
        {if $aProduct.type == 9}
        {if $aAutomation[$productId].EnableAutoTransferDomain == 'off'}<i class="fas fa-times-circle" style="color: red;"></i>{else}<i class="fas fa-check-circle" style="color: green;"></i>{/if}
        {/if}
    </td>
    <td>
        {if $aProduct.type == 9}
        {if $aConfiguration[$productId].fulfillment_transfer_id}<a href="?cmd=servicecataloghandle&action=view&id={$aConfiguration[$productId].fulfillment_transfer_id}" target="_blank">{$aConfiguration[$productId].fulfillment_transfer_id} / {$aServiceCatalog[$fulfillment_transfer_id].title}</a>{/if}
        {/if}
    </td>
    <td>
        {if $aProduct.type == 9}
        {if $aConfiguration[$productId].fulfillment_transfer_id}{if $aServiceCatalog[$fulfillment_transfer_id].zendesk_guide_id}<a href="https://pdi-netway.zendesk.com/hc/th/articles/{$aServiceCatalog[$fulfillment_transfer_id].zendesk_guide_id}" target="_blank">{$aServiceCatalog[$fulfillment_transfer_id].zendesk_guide_id} / {$aServiceCatalog[$fulfillment_transfer_id].title}</a>{/if}{/if}
        {/if}
    </td>
    <td>
        {if $aProduct.type == 9}
        {if $aConfiguration[$productId].fulfillment_transfer_success}<a href="?cmd=servicecataloghandle&action=view&id={$aConfiguration[$productId].fulfillment_transfer_id}" target="_blank">{$aConfiguration[$productId].fulfillment_transfer_success} / {$aProcessGroup[$fulfillment_transfer_success].name}</a>{/if}
        {/if}    
    </td>
    <td>
        {if $aProduct.type == 9}
        {if $aConfiguration[$productId].fulfillment_transfer_fail}<a href="?cmd=servicecataloghandle&action=view&id={$aConfiguration[$productId].fulfillment_transfer_id}" target="_blank">{$aConfiguration[$productId].fulfillment_transfer_fail} / {$aProcessGroup[$fulfillment_transfer_fail].name}</a>{/if}
        {/if}    
    </td>
    <td></td>
    
    <td>
        {if $aProduct.type != 9}
        {if $aAutomation[$productId].EnableAutoSuspension == 'on'}<i class="fas fa-check-circle" style="color: green;"></i> {$aAutomation[$productId].AutoSuspensionPeriod} {else}<i class="fas fa-times-circle" style="color: red;"></i>{/if}
        {/if}
    </td>
    <td>
        {if $aProduct.type != 9}
        {if $aConfiguration[$productId].fulfillment_suspend_id}<a href="?cmd=servicecataloghandle&action=view&id={$aConfiguration[$productId].fulfillment_suspend_id}" target="_blank">{$aConfiguration[$productId].fulfillment_suspend_id} / {$aServiceCatalog[$fulfillment_suspend_id].title}</a>{/if}
        {/if}
    </td>
    <td>
        {if $aProduct.type != 9}
        {if $aConfiguration[$productId].fulfillment_suspend_id}{if $aServiceCatalog[$fulfillment_suspend_id].zendesk_guide_id}<a href="https://pdi-netway.zendesk.com/hc/th/articles/{$aServiceCatalog[$fulfillment_suspend_id].zendesk_guide_id}" target="_blank">{$aServiceCatalog[$fulfillment_suspend_id].zendesk_guide_id} / {$aServiceCatalog[$fulfillment_suspend_id].title}</a>{/if}{/if}
        {/if}
    </td>
    <td>
        {if $aProduct.type != 9}
        {if $aConfiguration[$productId].fulfillment_suspend_success}<a href="?cmd=servicecataloghandle&action=view&id={$aConfiguration[$productId].fulfillment_suspend_id}" target="_blank">{$aConfiguration[$productId].fulfillment_suspend_success} / {$aProcessGroup[$fulfillment_suspend_success].name}</a>{/if}
        {/if}    
    </td>
    <td>
        {if $aProduct.type != 9}
        {if $aConfiguration[$productId].fulfillment_suspend_fail}<a href="?cmd=servicecataloghandle&action=view&id={$aConfiguration[$productId].fulfillment_suspend_id}" target="_blank">{$aConfiguration[$productId].fulfillment_suspend_fail} / {$aProcessGroup[$fulfillment_suspend_fail].name}</a>{/if}
        {/if}    
    </td>
    <td></td>
        
    <td>
        {if $aProduct.type != 9}
        {if $aAutomation[$productId].EnableAutoUnSuspension == 'off'}<i class="fas fa-times-circle" style="color: red;"></i>{else}<i class="fas fa-check-circle" style="color: green;"></i>{/if}
        {/if}
    </td>
    <td>
        {if $aProduct.type != 9}
        {if $aConfiguration[$productId].fulfillment_unsuspend_id}<a href="?cmd=servicecataloghandle&action=view&id={$aConfiguration[$productId].fulfillment_unsuspend_id}" target="_blank">{$aConfiguration[$productId].fulfillment_unsuspend_id} / {$aServiceCatalog[$fulfillment_unsuspend_id].title}</a>{/if}
        {/if}
    </td>
    <td>
        {if $aProduct.type != 9}
        {if $aConfiguration[$productId].fulfillment_unsuspend_id}{if $aServiceCatalog[$fulfillment_unsuspend_id].zendesk_guide_id}<a href="https://pdi-netway.zendesk.com/hc/th/articles/{$aServiceCatalog[$fulfillment_unsuspend_id].zendesk_guide_id}" target="_blank">{$aServiceCatalog[$fulfillment_unsuspend_id].zendesk_guide_id} / {$aServiceCatalog[$fulfillment_unsuspend_id].title}</a>{/if}{/if}
        {/if}
    </td>
    <td>
        {if $aProduct.type != 9}
        {if $aConfiguration[$productId].fulfillment_unsuspend_success}<a href="?cmd=servicecataloghandle&action=view&id={$aConfiguration[$productId].fulfillment_unsuspend_id}" target="_blank">{$aConfiguration[$productId].fulfillment_unsuspend_success} / {$aProcessGroup[$fulfillment_unsuspend_success].name}</a>{/if}
        {/if}    
    </td>
    <td>
        {if $aProduct.type != 9}
        {if $aConfiguration[$productId].fulfillment_unsuspend_fail}<a href="?cmd=servicecataloghandle&action=view&id={$aConfiguration[$productId].fulfillment_unsuspend_id}" target="_blank">{$aConfiguration[$productId].fulfillment_unsuspend_fail} / {$aProcessGroup[$fulfillment_unsuspend_fail].name}</a>{/if}
        {/if}    
    </td>
    <td></td>
    
    <td>
        {if $aProduct.type != 9}
        {if $aAutomation[$productId].EnableAutoTermination == 'on'}<i class="fas fa-check-circle" style="color: green;"></i> {$aAutomation[$productId].AutoTerminationPeriod} {else}<i class="fas fa-times-circle" style="color: red;"></i>{/if}
        {/if}
    </td>
    <td>
        {if $aProduct.type != 9}
        {if $aConfiguration[$productId].fulfillment_terminate_id}<a href="?cmd=servicecataloghandle&action=view&id={$aConfiguration[$productId].fulfillment_terminate_id}" target="_blank">{$aConfiguration[$productId].fulfillment_terminate_id} / {$aServiceCatalog[$fulfillment_terminate_id].title}</a>{/if}
        {/if}
    </td>
    <td>
        {if $aProduct.type != 9}
        {if $aConfiguration[$productId].fulfillment_terminate_id}{if $aServiceCatalog[$fulfillment_terminate_id].zendesk_guide_id}<a href="https://pdi-netway.zendesk.com/hc/th/articles/{$aServiceCatalog[$fulfillment_terminate_id].zendesk_guide_id}" target="_blank">{$aServiceCatalog[$fulfillment_terminate_id].zendesk_guide_id} / {$aServiceCatalog[$fulfillment_terminate_id].title}</a>{/if}{/if}
        {/if}
    </td>
    <td>
        {if $aProduct.type != 9}
        {if $aConfiguration[$productId].fulfillment_terminate_success}<a href="?cmd=servicecataloghandle&action=view&id={$aConfiguration[$productId].fulfillment_terminate_id}" target="_blank">{$aConfiguration[$productId].fulfillment_terminate_success} / {$aProcessGroup[$fulfillment_terminate_success].name}</a>{/if}
        {/if}    
    </td>
    <td>
        {if $aProduct.type != 9}
        {if $aConfiguration[$productId].fulfillment_terminate_fail}<a href="?cmd=servicecataloghandle&action=view&id={$aConfiguration[$productId].fulfillment_terminate_id}" target="_blank">{$aConfiguration[$productId].fulfillment_terminate_fail} / {$aProcessGroup[$fulfillment_terminate_fail].name}</a>{/if}
        {/if}    
    </td>
    <td></td>
    
    <td class="table-warning">
        {if $aProduct.type == 9}
        {if isset($aAutomation[$productId].RenewInvoice)}<i class="fas fa-times-circle" style="color: red;"></i>{else}{if $aAutomation[$productId].InvoiceGeneration}{$aAutomation[$productId].InvoiceGeneration}{else}{$aAutomation.InvoiceGeneration}{/if}{/if}
        {else}
        {if $aAutomation[$productId].InvoiceGeneration}{$aAutomation[$productId].InvoiceGeneration}{else}<i class="fas fa-times-circle" style="color: red;"></i>{/if}
        {/if}
    </td>
    <td class="table-warning">{if $aAutomation[$productId].AdvancedDueDate}<i class="fas fa-check-circle" style="color: green;"></i>{/if}</td>
    <td class="table-warning">{if $aAutomation[$productId].AutoProcessCancellations}<i class="fas fa-check-circle" style="color: green;"></i>{/if}</td>
    
    <td>{if $aAutomation[$productId].SendPaymentReminderEmails == 'on'}<i class="fas fa-check-circle" style="color: green;"></i>{/if}</td>
    <td>{if $aAutomation[$productId].InvoiceUnpaidReminder}<i class="fas fa-check-circle" style="color: green;"></i>{/if}</td>
    <td>{if $aAutomation[$productId].InvoiceUnpaidReminder}{$aAutomation[$productId].InvoiceUnpaidReminder}{/if}</td>
    <td>{if $aAutomation[$productId].1OverdueReminder}<i class="fas fa-check-circle" style="color: green;"></i>{/if}</td>
    <td>{if $aAutomation[$productId].1OverdueReminder}{$aAutomation[$productId].1OverdueReminder}{/if}</td>
    <td>{if $aAutomation[$productId].2OverdueReminder}<i class="fas fa-check-circle" style="color: green;"></i>{/if}</td>
    <td>{if $aAutomation[$productId].2OverdueReminder}{$aAutomation[$productId].2OverdueReminder}{/if}</td>
    <td>{if $aAutomation[$productId].3OverdueReminder}<i class="fas fa-check-circle" style="color: green;"></i>{/if}</td>
    <td>{if $aAutomation[$productId].3OverdueReminder}{$aAutomation[$productId].3OverdueReminder}{/if}</td>
    
    <td class="table-warning">
        {if $aProduct.type == 9}
        {if $aEmailTemplate[$productId].AfterRegistrarRegistration.email_id}<a href="?cmd=emailtemplates&action=edit&id={$aEmailTemplate[$productId].AfterRegistrarRegistration.email_id}" target="_blank">{$aEmailTemplate[$productId].AfterRegistrarRegistration.email_id} / {$aEmailTemplate[$productId].AfterRegistrarRegistration.subject}</a>{/if}
        {else}
        {if $aEmailTemplate[$productId].ProductAccountCreated.email_id}<a href="?cmd=emailtemplates&action=edit&id={$aEmailTemplate[$productId].ProductAccountCreated.email_id}" target="_blank">{$aEmailTemplate[$productId].ProductAccountCreated.email_id} / {$aEmailTemplate[$productId].ProductAccountCreated.subject}</a>{/if}
        {/if}
    </td>
    <td class="table-warning">
        {if $aProduct.type == 9}
        {if $aEmailTemplate[$productId].AfterRegistrarTransfer.email_id}<a href="?cmd=emailtemplates&action=edit&id={$aEmailTemplate[$productId].AfterRegistrarTransfer.email_id}" target="_blank">{$aEmailTemplate[$productId].AfterRegistrarTransfer.email_id} / {$aEmailTemplate[$productId].AfterRegistrarTransfer.subject}</a>{/if}
        {else}
        {if $aEmailTemplate[$productId].SuspendAccount.email_id}<a href="?cmd=emailtemplates&action=edit&id={$aEmailTemplate[$productId].SuspendAccount.email_id}" target="_blank">{$aEmailTemplate[$productId].SuspendAccount.email_id} / {$aEmailTemplate[$productId].SuspendAccount.subject}</a>{/if}
        {/if}
    </td>
    <td class="table-warning">
        {if $aProduct.type == 9}
        {if $aEmailTemplate[$productId].AfterRegistrarRenewal.email_id}<a href="?cmd=emailtemplates&action=edit&id={$aEmailTemplate[$productId].AfterRegistrarRenewal.email_id}" target="_blank">{$aEmailTemplate[$productId].AfterRegistrarRenewal.email_id} / {$aEmailTemplate[$productId].AfterRegistrarRenewal.subject}</a>{/if}
        {else}
        {if $aEmailTemplate[$productId].UnsuspendAccount.email_id}<a href="?cmd=emailtemplates&action=edit&id={$aEmailTemplate[$productId].UnsuspendAccount.email_id}" target="_blank">{$aEmailTemplate[$productId].UnsuspendAccount.email_id} / {$aEmailTemplate[$productId].UnsuspendAccount.subject}</a>{/if}
        {/if}
    </td>
    <td class="table-warning">
        {if $aProduct.type == 9}
        {if $aEmailTemplate[$productId].expiringDomain.email_id}<a href="?cmd=emailtemplates&action=edit&id={$aEmailTemplate[$productId].expiringDomain.email_id}" target="_blank">{$aEmailTemplate[$productId].expiringDomain.email_id} / {$aEmailTemplate[$productId].expiringDomain.subject}</a>{/if}
        {else}
        {if $aEmailTemplate[$productId].AfterModuleTerminate.email_id}<a href="?cmd=emailtemplates&action=edit&id={$aEmailTemplate[$productId].AfterModuleTerminate.email_id}" target="_blank">{$aEmailTemplate[$productId].AfterModuleTerminate.email_id} / {$aEmailTemplate[$productId].AfterModuleTerminate.subject}</a>{/if}
        {/if}
    </td>
    
</tr>
{/foreach}
{/foreach}
</tbody>
</table>

<pre>

ประเภท Fulfillment
A - auto - ตอน order fulfillment fail (จะมี send email addon ให้ เพื่อให้ click เพื่อส่ง email เช่น แจ้ง จดโดเมนเสร็จ/ สร้าง hosting account แล้ว เป็นต้น)
B - auto - ตอน provision plugin สร้างให้อัตโนมัติ เช่น จด .th, VPS resize disk  (ส่วนงานนี้ยังไม่เสร็จ, จะทำหลัง approval module ระหว่างนี้ให้ทำ manual ไปก่อน)
C - manual - ตอน order provision เพิ่มเติม เช่น ย้ายโฮส, ย้ายโดเมน    
D - manual - ตอนลูกค้าร้องขอ เช่น reset password (รอ approval addon ให้)

</pre>

<script>
{literal}
$(document).ready( function () {
    $('#orderPage').sticky( {
        cellWidth   : 200,
        cellHeight  : 30,
        columnCount : 0,
        offset  : { top: 10, left: 10 },
        scrollContainer : window,
    });
    
    $('.tableRow').click( function () {
        $(this).toggleClass('table-success');
    });
});
{/literal}
</script>

{include file="$tplPath/admin/footer.tpl"}