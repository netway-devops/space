<script src="{$system_url}includes/modules/Hosting/ssl/widgets/reissue/reissue.js"></script>
{if !$reissue_success}
<div class="table-header">
    <p>Reissue : {$domain}</p>
</div>
<br />

<form id="reissue_form" action="{$form_url}" method="POST">
    <input name="order_id" type="hidden" id="order_id" value="{$service.order_id}" />
    <input type="hidden" id="system_url" value="{$system_url}" />
    {if !$reissuing}
    <input type="hidden" id="reissue-mail" value="{$reissue_email}" />
    <table id="reissue-table" class="table table-striped account-details-tb tb-sh">
        <!-- <tr>
            <th width="15%" style='border: 0; background: white;'></th>
            <th width="85%" style='border: 0; background: white;'></th>
        </tr> -->
       
         <tr>
            <td colspan="2" style="background-color: #f8fcfe; padding: 20px 7px 19px 7px;">
                <p  style="margin: -10px 0;">
                            The domain ownership rights should be confirmed prior to the certificate issuance The approval email will be sent to 5 administrative emails as the below list. 
                            Please don't miss to click the Owner Verification to confirm yourself on the email.
                            <br>
                            <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;admin@example.com
                            <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;administrator@example.com
                            <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;hostmaster@example.com
                            <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;postmaster@example.com
                            <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;webmaster@example.com  
                            <br>
                            <br>If you don't feel convenience to verify by E-mail Approval, you can choose 2 alternative ways:
                            <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1.HTTP Verification Method  
                            <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2.DNS Record Approval 
                            <br>By contacting to <a href="https://www.digicert.com/security-certificate-support/#Contact" target="_blank"> https://www.digicert.com/security-certificate-support/#Contact</a>,if the order processing is completed.
                          </p>
                          <br>   
            </td>
        </tr>

        <tr>
            <td style="vertical-align:top; background-color:#F7F7F7;">CSR : </td>
            <td class="cell-border no-bold" style="background-color:#F7F7F7;">
                <a href="" onclick="$('#upload_csr').click(); return false">
                        Upload CSR</a> or Paste one below : </div>
                <div class="format_textarea"><textarea rows="6" id="csr_data" name="csr_data" style="resize:vertical;">{$csr}</textarea> </div>
            </td>
        </tr>
        <tr>
        	<td style="vertical-align:top; background-color: #f7f7f7;">Hashing Algorithm : </td>
        	<td class="cell-border no-bold" style="background-color: #f7f7f7;">
        		<select name="hashing" style="width: auto;">
        			{foreach from=$hashing_data key=hashingKey item=hashingValue}
                        {if $hashingValue.visible}<option value="{$hashingKey}"{if !$hashingValue.enable} disabled{elseif ($hashing_algorithm == 'SHA2-256' && $hashingKey == 'SHA256-FULL-CHAIN') || ($hashing_algorithm == $hashingKey)} selected{/if}>{$hashingValue.name}</option>{/if}
                    {/foreach}
        		</select>
        	</td>
        </tr>
        {if isset($dnsNames)}
        {foreach from=$dnsNames key=index item=eachDNS}
        <tr>
        	<td style="vertical-align:top; background-color:#f7f7f7;">{if $index == 0}Manage SAN : {/if}</td>
            <td class="cell-border no-bold" style="background-color:#f7f7f7;">
            	<input type="text" id="dns{$index}" class="dns" name="dns[{$index}]" value="{$eachDNS}" {if isset($dnsNames_quicksslpremium)}style="text-align:right;"{/if}/>{if isset($dnsNames_quicksslpremium)}.{$quickpremiumdomain}{/if}
            	&nbsp;&nbsp;
            	<a href="javascript:void(0);" id="reset{$index}" name="{$resetDNS[$index]}" onclick="resetSAN(this);" style="{if $resetDNS[$index] == $eachDNS}display:none;{/if}">reset</a>
            </td>
        </tr>
        {/foreach}
        {/if}
        {if $validation == 1}
            <tr>
                <td style="vertical-align:top; background-color:#f7f7f7;">Email Approval : </td>
                <td class="cell-border no-bold" style="background-color:#f7f7f7;">
                    {$reissue_email}
                </td>
            </tr>
       
             
        {/if}
        <tr id="reissue-error-tr" {if !isset($reissue_error)}style="display:none;"{/if}>
            <td colspan="2"><span><font color="red" id="reissue-error-text">{$reissue_error}</font></span></td>
        </tr>
        <tr>
            <td colspan="2" style="background-color:#f7f7f7;">
                <div align="center">
                    <input id="validate_button" class="reissue_button" type="submit" value="Reissue" />
                </div></td>
        </tr>
    </table>
</form>
<form action="?cmd=module&module=ssl&action=upload_csr" method="post" enctype="multipart/form-data" id="form_upload_csr" name="form_upload_csr" onsubmit="return false;">
    <input type="file" id="upload_csr" name="upload_csr" style="visibility: hidden; width: 1px; height: 1px" multiple />
    <input name="submit_upload_csr" id="submit_upload_csr" type="submit" style="visibility: hidden;width: 1px; height: 1px"/>
    {else}
    <p id="reissueText">
            Your SSL Certificate Reissue request has been submitted to SSL Authenticator already. 
        {if $order_id|ssl_getproductvalidation == 1} 
            You should receive the Email Approval to approve the reissue and complete already.<br />
            <br />Not receive the Email Approval? Please click "Resend Validation Email" below and check your inbox again.
        {else}The process is currently in progress. You'll get contacted from the SSL Authenticator soon.
        {/if}
        {if $order_id|ssl_getproductvalidation == 1}
        <br /><br /><br />
        <span align="center">
            <input id="validate_button" style="width: 170px" name="resend_email" class="reissue_button" onclick="return confirm('Do you want to resend Email validation now ?');" 
            type="submit" value="Resend Validation Email"/>
        </span>
        {/if}
    </p>
    <script type="text/javascript">
        $('#reissueText').css('height', $('.nav-list').css('height'));
    </script>
</form>
    {/if}
{else}
<div align="center" style="height: 276px; color: green;">Reissue successful.</div>
{/if}
<script type="text/javascript">
{if isset($reissue_success) && $reissue_success}
        {literal}
        window.location.href = window.location.href
        {/literal}
{elseif isset($resend_error) && $resend_error != ''}
        {literal}
        alert('{/literal}{$resend_error}{literal}');
        {/literal}
{elseif isset($resend_success) && resend_success}
        {literal}
        alert('Resend Validation Email successful.');
        {/literal}
{/if}
</script>