{include file="$tplPath/admin/header.tpl"}
{if $hasServersConf}

<div class="tab">
{foreach from=$aInvoices item="aData" key="k"}
  <button class="tablinks" onclick="openAzutePartner(event, '{$aData.partner_info.id}')">{$aData.partner_info.name}</button>
{/foreach}
</div>

{foreach from=$aInvoices item="aData" key="k"}
<div id="{$aData.partner_info.id}" class="tabcontent">
<table cellpadding="2" cellspacing="2" width="90%">
<tr>
    <th style="padding: 0 10px 0 0px; text-align: right;">Total: {$aData.invoices.totalCount} Item(s)</th>
</tr>
<tr>
    <td>
    <table cellpadding="2" cellspacing="2" border="1" width="100%">
        <tr style="text-align:center;">
            <th width="10%" style="text-align:center;">ID</th>
            <th width="20%" style="text-align:center;">Date</th>
            <th width="20%" style="text-align:center;">Period Start</th>
            <th width="20%" style="text-align:center;">Period End</th>
            <th width="10%" style="text-align:center;">Type</th>
            <th style="text-align:center;">Total Charges</th>
        </tr>
        {foreach from=$aData.invoices.items item="item" key="k"}
        <tr>
            <td style="padding: 0 0 0 5px;">
              <a href="?cmd=azure_partner_management&action=invoice_detail_mgr&tenant={$aData.connection.tenant}&app={$aData.connection.app}&partner_id={$aData.partner_info.id}&partner_name={$aData.partner_info.name|@urlencode}&invoice_id={$item.id}">{$item.id}</a>
            </td>
            <td style="padding: 0 0 0 5px;">{$item.invoiceDate|date_format:"%b %e, %Y %T GMT %Z"}</td>
            <td style="padding: 0 0 0 5px;">{$item.billingPeriodStartDate|date_format:"%b %e, %Y %T GMT %Z"}</td>
            <td style="padding: 0 0 0 5px;">{$item.billingPeriodEndDate|date_format:"%b %e, %Y %T GMT %Z"}</td>
            <td style="padding: 0 0 0 5px;">{$item.invoiceType}</td>
            <td style="text-align:right; padding: 0 10px 0 5px;">{$item.totalCharges} {$item.currencyCode}</td>
        </tr>
        {/foreach}
    </table>
    </td>
</tr>
</table>
</div>
{/foreach}
<style>
{literal}
/* Style the tab */
.tab {
  overflow: hidden;
  border: 1px solid #ccc;
  background-color: #f1f1f1;
}

/* Style the buttons that are used to open the tab content */
.tab button {
  background-color: inherit;
  float: left;
  border: none;
  outline: none;
  cursor: pointer;
  padding: 14px 16px;
  transition: 0.3s;
}

/* Change background color of buttons on hover */
.tab button:hover {
  background-color: #ddd;
}

/* Create an active/current tablink class */
.tab button.active {
  background-color: #ccc;
}

/* Style the tab content */
.tabcontent {
  display: none;
  padding: 6px 12px;
  border: 1px solid #ccc;
  border-top: none;
}
{/literal}
</style>

<script language="JavaScript">
{literal}
function openAzutePartner(evt, cityName) {
  // Declare all variables
  var i, tabcontent, tablinks;

  // Get all elements with class="tabcontent" and hide them
  tabcontent = document.getElementsByClassName("tabcontent");
  for (i = 0; i < tabcontent.length; i++) {
    tabcontent[i].style.display = "none";
  }

  // Get all elements with class="tablinks" and remove the class "active"
  tablinks = document.getElementsByClassName("tablinks");
  for (i = 0; i < tablinks.length; i++) {
    tablinks[i].className = tablinks[i].className.replace(" active", "");
  }

  // Show the current tab, and add an "active" class to the button that opened the tab
  document.getElementById(cityName).style.display = "block";
  evt.currentTarget.className += " active";
}
{/literal}
document.getElementById('{$aInvoices[0].partner_info.id}').click();
document.getElementById('{$aInvoices[0].partner_info.id}').style.display = "block";
document.getElementById('{$aInvoices[0].partner_info.id}').className += " active";
</script>


{else}
    <div class="imp_msg">
<strong>หมายเหตุ:</strong> <br>
App "Netway Azure Partner API" ไม่ได้ทำการ connection. โปรดไปที่เมนู Serrings/Apps Connections และทำการ Connection App "Netway Azure Partner API" ให้เสร็จก่อน.<br>
</div>
{/if}
{include file="$tplPath/admin/footer.tpl"}
