<div class="row" style="margin-bottom: 20px;">

    <div class="col-md-3">
        <div class="stat-item">
            <div class="stat-data Open"><span class="Open">{$stats.income|price:$stats.currency_id}</span></div>
            <div class="stat-label">Transactions  Income</div>
        </div>
    </div>

    <div class="col-md-3">
        <div class="stat-item">
            <div class="stat-data Paid"><span class="Paid">{$stats.invoice_paid|price:$stats.currency_id}</span></div>
            <div class="stat-label">{$stats.paid} {$lang.invoicespaid}</div>
        </div>
    </div>
    <div class="col-md-3">
        <div class="stat-item">
            <div class="stat-data "><span class="Unpaid">{$stats.invoice_unpaid|price:$stats.currency_id}</span></div>
            <div class="stat-label">{$stats.unpaid} {$lang.invoicesdue}</div>
        </div>
    </div>

    <div class="col-md-3">
        <div class="stat-item">
            <div class="stat-data "><span class="Cancelled">{$stats.invoice_cancelled|price:$stats.currency_id}</span></div>
            <div class="stat-label">{$stats.cancelled} {$lang.invoicescancel}</div>
        </div>
    </div>

</div>
{literal}
<style>

</style>
{/literal}

<table border="0" cellpadding="3" cellspacing="0" width="100%">
    <tr>
        <td><strong>{$lang.Credit}</strong></td>
        <td >
            <div class="editline left" style="margin-right:10px">
                
            {if isset($aStats.credit_swap)}
              <strong>{$stats.credit|price:$stats.currency_id}</strong> &nbsp;
              ถูกสำรองไว้อีก <strong>{$aStats.credit_swap|price:$stats.currency_id}</strong> &nbsp;
              <a id="swapCredit" class="editbtn" href="?cmd=clienthandle&amp;action=swapcredit&amp;client_id={$client_id}">คืนค่า</a>
              <div style="color:#5F2A80;">* จะต้องคืนค่าที่ถูกสำรองนี้ให้กับ credit ของ client เพื่อให้สามารถนำไปใช้ได้</div>
              <script language="JavaScript">
              {literal}
              $(document).ready(function () {
                  $('#swapCredit').click(function() {
                      if (confirm('ยืนยันการคืนค่า Credit ให้ลูกค้า โดยลูกค้าจะมี credit รวมทั้งหมด = {/literal}{$aStats.credit_total|price:$stats.currency_id}{literal} ?')) {
                          $.post($(this).attr('href'), function() {
                              document.location = '{/literal}{$admin_url}{literal}/?cmd=clients&action=show&id={/literal}{$client_id}{literal}';
                          });
                      }
                      return false;
                  });
              });
              {/literal}
              </script>
            {else}
        
                <div class="a1 editor-line input-group" style="display:none;">
                    <input name="credit" type="text" style="width:80px;" value="{$client.credit}" />
                    <span class="input-group-btn">
                        <button class="btn btn-success btn-sm" type="button" onclick="$('#clientsavechanges').click(); return false">Save</button>
                    </span>
                </div>
            </div>
            <span class="a2  livemode" onclick="$('.secondtd').show();
                    $('.tdetails').hide();
                    $('.a2').hide();
                    $('.a1').show();
                    return false;"> <strong class="">{$client.credit|price:$stats.currency_id}</strong></span>
            <span class="a2 ">{if isset($admindata.access.editClients)}<a href="#" class="btn btn-default btn-sm" onclick="$('.secondtd').show();
                    $('.tdetails').hide();
                    $('.a2').hide();
                    $('.a1').show();
                    return false;">{$lang.Edit}</a>{/if}</span>
            <span class="fs11 btn-group ">
                {if isset($admindata.access.editClients)}
                <a class="btn btn-default btn-sm" href="?cmd=transactions&amp;action=add&amp;related_client_id={$client_id}">{$lang.addcredit}</a>
                {/if}
                <a class="btn btn-default btn-sm" href="?cmd=clientcredit&filter[client_id]={$client_id}" target="_blank">Credit log</a>

            {/if}
            <div style="color:#884431;">(ได้ปิดการจ่ายด้วย credit อัตโนมัติสำหรับ order ที่มี renew domain รวมอยู่ด้วย)</div>


            </span>
        </td>
    </tr>

    {if $stats.accounts}
        {foreach from=$stats.accounts item=acct key=k}
            {assign var="descr" value="_hosting"}
            {assign var="baz" value="$k$descr"}
            <tr>
                <td><strong>{if $lang.$baz}{$lang.$baz}{else}{$k}{/if}</strong>	</td>
                <td>{$acct}</td>
            </tr>
        {/foreach}
    {/if}

    <tr>
        <td><strong>{$lang.Domains}</strong>	</td>
        <td>{$stats.domain}</td>
    </tr>
    <tr>
        <td><strong>{$lang.supptickets}</strong>	</td>
        <td>{$stats.ticket}</td>
    </tr>
    

</table>