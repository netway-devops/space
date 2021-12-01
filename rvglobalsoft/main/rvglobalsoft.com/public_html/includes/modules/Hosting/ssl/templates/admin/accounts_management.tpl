{include file=$csslocation}
<input id="hid_symantecStatus" type="hidden" value="{$accounts.symantec_status}" />
<input id="hid_base_url" type="hidden" value="{$system_url}7944web/index.php" />
<input id="hid_order_id" type="hidden" value="{$accounts.order_id}" />
<input id="hid_client_id" type="hidden" value="{$accounts.usr_id}" />
<input id="hid_domain_name" type="hidden" value="{$accounts.commonname}" />
<input id="hid_email_approval" type="hidden" value="{$accounts.email_approval}" />
<input id="hid_server_type" type="hidden" value="{$accounts.server_type}" />
<input id="hid_invoice_status" type="hidden" value="{$accounts.inv_status}" />
<input id="hid_ssl_type" type="hidden" value="{$accounts.ssl_type}" />
<input id="hid_cert_status" type="hidden" value="{$cert_status}" />
{php}
//echo '<pre>'; print_r($this->get_template_vars()); echo '</pre>';
//echo '<pre>'; print_r($this->get_template_vars('accounts')); echo '</pre>';
{/php}
<ul class="accor" id="ssl-accor">
        <li>
                <a href="#">SSL Order Details</a>
    <div style='background-color: #d4e6fc;'>
    <span id="preLoad"></span>
    <table cellspacing='2' cellpadding='3' border='0' width='100%'>
        <tr>
            <td><a href="javascript:void(0);" id="refreshpage" title="refresh page">&#8634;</a></td>
            <td>
                <div id="csrProcess" style="color:green;"></div>
                <div id="csrError" style="color:red;"></div>
            </td>
        </tr>
        <tr>
            <td class="td-state-process" style="width: 180px;">
                State Processing :
            </td>
            
            <td class="td-state-process" >
                <span id="statusOutput" ></span>
                {if $accounts.symantec_status != 'COMPLETED' && $accounts.symantec_status != 'REJECTED' }
                <select name="server_id" id="fix_status" >
                    {if $accounts.inv_status != 'Paid' }  
                    <option value="WAITING_SUBMIT_CSR">Waiting for submit CSR</option>
                    <option value="WAITING_SUBMIT_ORDER">Waiting for submit order</option>
                    {else}
                        <option value="WAITING_SUBMIT_ORDER">Waiting for submit order</option>
                        <option value="WF_DOMAIN_APPROVAL">Waiting for approval</option>	
                        <option value="COMPLETED">Completed</option>
                        <option value="REJECTED">Rejected</option>
                    {/if}
                </select>    
                {/if}
            </td>
            
        </tr>
        {if $accounts.symantec_status != 'WAITING_SUBMIT_CSR' &&
        $accounts.symantec_status != 'WAITING_SUBMIT_ORDER' &&
        $accounts.symantec_status != 'COMPLETED' &&
        $accounts.symantec_status != 'REJECTED'
        }
        <tr class="tr-manual-set-status">
            <td>Manual set Status : </td>
            <td>
                <span>
                    <select name="ssl_status" id="ssl_status">
                        <option value="0">Select</option>
                        <option value="AUTHORIZATION_FAILED">Customer submit phonecall</option>
                        <option value="WAITING_SUBMIT_DOCUMENT">Customer submit document</option>
                    </select>
                    <input class="all-button" type="button" value="Change Status" onclick="set_status('{$accounts.order_id}');"/>
                </span>
            </td>
        </tr>
        {/if}
        {if $accounts.inv_status != 'Paid'}
        <tr>
             <td>Payment Status : </td>
            <td><font color="red">Unpaid</font>&nbsp;&nbsp;&nbsp;<a href='?cmd=invoices#{$accounts.inv_id}' target='_blank'>link</a></td>
        </tr>
        {/if}
        {if $showorderid}
        <tr>
             <td class="td-order-id">Order Id : </td>
            <td class="td-order-id">{$accounts.order_id}</td>
        </tr>
        {/if}
        <tr>
            <td class="td-csr" style='vertical-align: top;'>
                CSR :
                <br />
                <span id='csrHide' style='color:#4370cd; display:none; cursor: pointer;' title="Hide CSR">(Hide)</span>
            </td>
            <td class="td-csr">
                <span id='csrShow' style='color:#4370cd; cursor: pointer;' title="Show CSR">(Show)</span>
                <textarea name='csr-area' id='csr-area' rows='27' cols='120' size='10px' style='resize:none; font-size:10px;' >{$accounts.csr}</textarea>
            </td>
        </tr>
        <tr>
            <td class="td-domaininfo">
                Domain :
            </td>
            <td class="td-domaininfo">
                <table border='0' width="100%" style='border-collapse: collapse;'>
                    <tr>
                        <td width="50%">
                            <span id="domainName"></span>
                        </td>
                        <td width="50%">
                            <span>Web Server Type : </span><span id="server-type-span"></span>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        {if $accounts.dns_name|@count > 0 && $accounts.dns_name[0] != ''}
        <tr>
        	<td class="td-dnsname" style="vertical-align: top;">
        		SANs ({$accounts.dns_name|@count}):
        	</td>
        	<td class="td-dnsname td-dnsname-data">
        		<table border="1" style="border-collapse: collapse;">
        		{foreach from=$accounts.dns_name item="dfoo"}
        		<tr><td>{$dfoo}</td></tr>
        		{/foreach}
        		</table>
        	</td>
        </tr>
        {/if}
        <tr>
            <td class="td-emailapproval">
                Email Approval :
            </td>
            <td class="td-emailapproval">
                <span id="emailapproval-select"></span>
            </td>
        </tr>
        <tr class="tr-symantec-info">
            <td>
                Symantec Order ID :
            </td>
            <td>
                <table border='0' width="100%" style='border-collapse: collapse;'>
                    <tr>
                        <td width="50%">
                            <input type="text" id = "authority_orderid" value="{$accounts.authority_orderid}" style="background-color:#ffffff;"  />
                        </td>
                        <td width="50%">
                            <span>Partner Order ID : </span><input id="partnerOrderId" type='text' value='{$accounts.partner_order_id}' style='background-color:#ffffff;'  />
                        </td>
                    <tr>
                </table>
            </td>
        </tr>
        <tr>
            <td style='vertical-align: top;' class="td-contact-table">
                Contact Info Table :
                <br />
                <span id='detailHide' style='color:#4370cd; display:none; cursor: pointer;' title="Hide Contact table">(Hide)</span>
            </td>
            <td class="td-contact-table">
                <span id='detailShow' style='color:#4370cd; cursor: pointer;' title="Show Contact table">(Show)</span>
                <table id="td-contact-table-content" border='1' style='border-collapse: collapse; margin: 10px 0 10px 0;'>
                    <tr>
                        <td class='detailTD' style="width:110px;">
                            Contact Info
                        </td>
                        <td class='detailTD' style="width:230px;">
                            Organization Contact Info
                        </td>
                        <td class='detailTD' style="width:230px;">
                            Admin Contact Info
                            <span id="adminQ">
                                <a href="#" onclick="return false">( ? )</a>
                            </span>
                            <div id="adminEVOVInfo" class="evovHelper">
                                <span>The administrative contact is the primary contact and will be contacted to assist in resolution of any questions about the order.
Administrative person will be also used for Verification "Callbacks", that will be made for all Business/Extended Validation certificates. No callbacks will be made for Domain Validation Certificates.</span>
                            </div>
                        </td>
                        <td class='detailTD' style="width:230px;">
                            Technical Contact Info
                            <span id="techQ">
                                <a href="#" onclick="return false">( ? )</a>
                            </span>
                            <div id="techEVOVInfo" class="evovHelper">
                                <span>The Technical contact will receive the certificate and generally be the individual to install the certificate on the web server. Technical contact will also receive renewal notices.</span>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdOddHead">Firstname<span class="require-field"><font color="red"> *</font></span></td>
                        <td class="tdOddInner"><input class="organizationContact" id="ofirstname" type="text" style="width:95%; background-color:#ececec;" name="firstname" /></td>
                        <td class="tdOddInner"><input class="adminContact" id="afirstname" type="text" style="width:95%; background-color:#ececec;" name="firstname" /></td>
                        <td class="tdOddInner"><input class="techContact" id="tfirstname" type="text" style="width:95%; background-color:#ececec;" name="firstname" /></td>
                    </tr>
                    <tr>
                        <td class="tdEvenHead">Lastname<span class="require-field"><font color="red"> *</font></span></td>
                        <td class="tdEvenInner"><input class="organizationContact" id="olastname" type="text" style="width:95%; background-color:#fff;" name="lastname" /></td>
                        <td class="tdEvenInner"><input class="adminContact" id="alastname" type="text" style="width:95%; background-color:#fff;" name="lastname" /></td>
                        <td class="tdEvenInner"><input class="techContact" id="tlastname" type="text" style="width:95%; background-color:#fff;" name="lastname" /></td>
                    </tr>
                    <tr>
                        <td class="tdOddHead">Email<span class="require-field"><font color="red"> *</font></span></td>
                        <td class="tdOddInner"><input class="organizationContact" id="oemail" type="text" style="width:95%; background-color:#ececec;" name="email" /></td>
                        <td class="tdOddInner"><input class="adminContact" id="aemail" type="text" style="width:95%; background-color:#ececec;" name="email" /></td>
                        <td class="tdOddInner"><input class="techContact" id="temail" type="text" style="width:95%; background-color:#ececec;" name="email" /></td>
                    </tr>
                    <tr>
                        <td class="tdEvenHead">Organization Name<span class="require-field"><font color="red"> *</font></span></td>
                        <td class="tdEvenInner"><input class="organizationContact" id="oorganization" type="text" style="width:95%; background-color:#fff;" name="organization" /></td>
                        <td class="tdEvenInner"><input class="adminContact" id="aorganization" type="text" style="width:95%; background-color:#fff;" name="organization" /></td>
                        <td class="tdEvenInner"><input class="techContact" id="torganization" type="text" style="width:95%; background-color:#fff;" name="organization" /></td>
                    </tr>
                    <tr>
                        <td class="tdOddHead">Job Title<span class="require-field"><font color="red"> *</font></span></td>
                        <td class="tdOddInner"><input class="organizationContact" id="ojob" type="text" style="width:95%; background-color:#ececec;" name="job" /></td>
                        <td class="tdOddInner"><input class="adminContact" id="ajob" type="text" style="width:95%; background-color:#ececec;" name="job" /></td>
                        <td class="tdOddInner"><input class="techContact" id="tjob" type="text" style="width:95%; background-color:#ececec;" name="job" /></td>
                    </tr>
                    <tr>
                        <td class="tdEvenHead">Address<span class="require-field"><font color="red"> *</font></span></td>
                        <td class="tdEvenInner"><input class="organizationContact" id="oaddress" type="text" style="width:95%; background-color:#fff;" name="address" /></td>
                        <td class="tdEvenInner"><input class="adminContact" id="aaddress" type="text" style="width:95%; background-color:#fff;" name="address" /></td>
                        <td class="tdEvenInner"><input class="techContact" id="taddress" type="text" style="width:95%; background-color:#fff;" name="address" /></td>
                    </tr>
                    <tr>
                        <td class="tdOddHead">City<span class="require-field"><font color="red"> *</font></span></td>
                        <td class="tdOddInner"><input class="organizationContact" id="ocity" type="text" style="width:95%; background-color:#ececec;" name="city" /></td>
                        <td class="tdOddInner"><input class="adminContact" id="acity" type="text" style="width:95%; background-color:#ececec;" name="city" /></td>
                        <td class="tdOddInner"><input class="techContact" id="tcity" type="text" style="width:95%; background-color:#ececec;" name="city" /></td>
                    </tr>
                    <tr>
                        <td class="tdEvenHead">State/Region<span class="require-field"><font color="red"> *</font></span></td>
                        <td class="tdEvenInner"><input class="organizationContact" id="ostate" type="text" style="width:95%; background-color:#fff;" name="state_and_region" /></td>
                        <td class="tdEvenInner"><input class="adminContact" id="astate" type="text" style="width:95%; background-color:#fff;" name="state_and_region" /></td>
                        <td class="tdEvenInner"><input class="techContact" id="tstate" type="text" style="width:95%; background-color:#fff;" name="state_and_region" /></td>
                    </tr>
                    <tr>
                        <td class="tdOddHead">Country<span class="require-field"><font color="red"> *</font></span></td>
                        <td class="tdOddInner"><input class="organizationContact" id="ocountry" type="text" style="width:95%; background-color:#ececec;" name="country" /></td>
                        <td class="tdOddInner"><input class="adminContact" id="acountry" type="text" style="width:95%; background-color:#ececec;" name="country" /></td>
                        <td class="tdOddInner"><input class="techContact" id="tcountry" type="text" style="width:95%; background-color:#ececec;" name="country" /></td>
                    </tr>
                    <tr>
                        <td class="tdEvenHead">Postal Code<span class="require-field"><font color="red"> *</font></span></td>
                        <td class="tdEvenInner"><input class="organizationContact" id="opostcode" type="text" style="width:95%; background-color:#fff;" name="postcode" /></td>
                        <td class="tdEvenInner"><input class="adminContact" id="apostcode" type="text" style="width:95%; background-color:#fff;" name="postcode" /></td>
                        <td class="tdEvenInner"><input class="techContact" id="tpostcode" type="text" style="width:95%; background-color:#fff;" name="postcode" /></td>
                    </tr>
                    <tr>
                        <td class="tdOddHead">Telephone Number<span class="require-field"><font color="red"> *</font></span></td>
                        <td class="tdOddInner"><input class="organizationContact" id="ophone" type="text" style="width:95%; background-color:#ececec;" name="phone" /></td>
                        <td class="tdOddInner"><input class="adminContact" id="aphone" type="text" style="width:95%; background-color:#ececec;" name="phone" /></td>
                        <td class="tdOddInner"><input class="techContact" id="tphone" type="text" style="width:95%; background-color:#ececec;" name="phone" /></td>
                    </tr>
                    <tr>
                        <td class="tdEvenHead">Extension Number</td>
                        <td class="tdEvenInner"><input class="organizationContact" id="oext" type="text" style="width:95%; background-color:#fff;" name="ext" /></td>
                        <td class="tdEvenInner"><input class="adminContact" id="aext" type="text" style="width:95%; background-color:#fff;" name="ext" /></td>
                        <td class="tdEvenInner"><input class="techContact" id="text" type="text" style="width:95%; background-color:#fff;" name="ext" /></td>
                    </tr>
                    <tr id="tr-billingcontact"><td class="tdEvenInner"></td><td class="tdEvenInner"></td><td class="tdEvenInner"></td>
                    <td class="tdEvenInner">
                        <div align="center">
                           <a href="javascript:void(0);" id="billingContact">Use Billing Contact</a>
                        </div>
                    </td></tr>
                </table>
            </td>
        </tr>
        {if $accounts.symantec_status == 'COMPLETED' 
        ||  $accounts.symantec_status != 'COMPLETED' 
        && $accounts.inv_status != 'Unpaid' 
        && $accounts.symantec_status != 'WAITING_SUBMIT_CSR' 
        && $accounts.symantec_status != 'WAITING_SUBMIT_ORDER'}
        <tr class="tr-completed">
            <td style='vertical-align: top;'>
                Certificate Status :
            </td>
            <td>
                <table width="100%">
                    <tr>
                        <td width="50%">From HostBill : <span><font color="{if $cert_status_db == 'Cancelled' || $cert_status_db == 'Revoked' || $pending_revoke}red{else}green{/if}">{if $pending_revoke}Pending revoke approval{else}{$cert_status_db}{/if}</font></span></td>
                        <td width="50%">Real-time: <span><font color="{if $cert_status == 'Cancelled' || $cert_status == 'Revoked'}red{else}green{/if}">{$cert_status}</font></span></td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr class="tr-completed">
            <td style='vertical-align: top;'>
                CA Certificate :
            </td>
            <td>
                Type<br/>
                <input style='color:black; background-color:#ebebe4;' id ="caType" readonly value='{$accounts.type_ca}'/><br />
                CA Cert<br/>
                <textarea id='caCertFocus' rows='27' cols='90' size='10px' style='resize:none; font-size:10px; color:black; background-color:#ebebe4;' readonly>{$accounts.code_ca}</textarea>
            </td>
        </tr>
        <tr class="tr-completed">
            <td style='vertical-align: top;'>
                Certificate :
            </td>
            <td>
                <textarea id='servCertFocus' rows='27' cols='90' size='10px' style='resize:none; font-size:10px; color:black; background-color:#ebebe4;' readonly>{$accounts.code_certificate}</textarea>
            </td>
        </tr>
        {if $accounts.code_pkcs7 != ''}
        <tr class="tr-completed">
            <td style='vertical-align: top;'>
                PKCS7 :
            </td>
            <td>
                <textarea id='pkcs7Focus' rows='27' cols='90' size='10px' style='resize:none; font-size:10px; color:black; background-color:#ebebe4;' readonly>{$accounts.code_pkcs7}</textarea>
            </td>
        </tr>
        {/if}
        {if false}
        <tr class="tr-completed">
            <td style='vertical-align: top;'>
                PKCS12 :
            </td>
            <td>
                <textarea id='pkcs12Focus' rows='27' cols='90' size='10px' style='resize:none; font-size:10px; color:black; background-color:#ebebe4;' readonly></textarea>
            </td>
        </tr>
        <tr class="tr-completed">
            <td style='vertical-align: top;'>
                PKCS12<br />Encrypted Password :
            </td>
            <td>
                <textarea id='pkcs12PassFocus' rows='27' cols='90' size='10px' style='resize:none; font-size:10px; color:black; background-color:#ebebe4;' readonly></textarea>
            </td>
        </tr>
        {/if}
        <tr class="tr-completed">
            <td>
                Start Date :
            </td>
           <td>
            <input type="text" class="haspicker" value="{$accounts.date_created|date_format:"%d/%m/%Y"}"
            name="date_created" id = "date_created" size="12"/>
            </td>
        </tr>
        <tr class="tr-completed">
            <td>
                Expiration Date :
            </td>
            <td>
                <input type="text" class="haspicker" value="{$accounts.date_expire|date_format:"%d/%m/%Y"}" 
                name="date_expire" id = "date_expire" size="12"/>
               
            </td>
        </tr>
        {/if}
        {if $dev}
        <tr class="modify-order">
          <td>Modify Order : </td>
          <td>
            <select id="devOpt" name="devOpt">
             <option value="">--</option>
             {if $accounts.acct_status != 'Active' || isset($pending_reissue)}
	             <option value="Approve">Approve</option>
	             <option value="Cancel">Cancel</option>
	             <option value="Complete">Make Order Complete</option>
	         {else}
	         	<option value="standbyRevoke">Make Standby Revoke</option>
	         {/if}
            </select>
            <input type='button' id='modifyOrder' class="all-button" name='modifyOrder' value='Modify Order'/>
          </td>
        </tr>
        {/if}
        {if $accounts.symantec_status == 'AUTHORIZATION_FAILED' || $accounts.symantec_status == 'RV_WF_AUTHORIZATION'}
        <script src="{$system_url}includes/modules/Hosting/ssl/public_html/js/plugin/jquery.datePicker.js"></script>
        <tr>
            <td>
                Verification Call appointment :
            </td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>
                <div style='padding-left:20px'>Verification Call 1 <font color='red'>*</font> :</div>
            </td>
            <td>
                {php}
                $timeArray = array('08.30', '09.00','09.30','10.00','10.30','11.00','11.30','12.00','12.30','13.00','13.30','14.00','14.30','15.00','15.30','16.00','16.30','17.00','17.30');
                $gmtArray = array('-12', '-11', '-10', '-9', '-8', '-7', '-6', '-5', '-4', '-3', '-2', '-1', '+0','+1', '+2', '+3', '+4', '+5', '+6', '+7', '+8', '+9', '+10', '+11', '+12');
                $gmtValArray = array(12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0, -1, -2, -3, -4, -5, -6, -7, -8, -9, -10, -11, -12);
                {/php}
                {if $accounts.time_from == '' && $accounts.time_to == '' && $accounts.time_from2 == '' && $accounts.time_to2 == ''}
                    <input id='date_pick1' name='date_pick1' class="date-pick" value="{if $accounts.time_from == '' && $accounts.time_to == ''}No Detail{/if}"
                    {if $accounts.time_from == '' && $accounts.time_to == ''}
                        style='border:none; background-color:#d4e6fc;' size='10' readonly
                    {/if}
                    onchange='showTime();'/>
                    <select name='time-start' id='start'>
                    {php}
                        foreach($timeArray as $eachTime){
                            echo '<option value="' . $eachTime . '">' . $eachTime . '</option>';
                        }
                    {/php}
                    </select>
                    <span id='to'>to</span>
                    <select name='time-end' id='end'>
                    {php}
                        foreach($timeArray as $eachTime){
                            echo '<option value="' . $eachTime . '">' . $eachTime . '</option>';
                        }
                    {/php}
                    </select>
                    <span id='firstApp'></span>
                {elseif $accounts.time_from == '' && $accounts.time_to == '' && $accounts.time_from2 != '' && $accounts.time_to2 != ''}
                    <span id='firstApp'></span>
                    No Detail
                {else}
                    {php}
                        $accounts = $this->get_template_vars('accounts');
                        $from = $accounts['time_from'];
                        $to = $accounts['time_to'];
                        $exfrom = explode(' ', $from, 3);
                        $exto = explode(' ', $to);
                        $exfrom[0] = date('d M Y', strtotime($from));
                        echo "<span id='firstApp'>{$exfrom[0]} at $exfrom[1] - $exto[1] with $exfrom[2]</span>";
                    {/php}
                {/if}
            </td>
        </tr>
        <tr>
            <td>
                <font style='padding-left:20px'>Verification Call 2:</font>
            </td>
            <td>
                {if $accounts.time_from2 == '' && $accounts.time_to2 == '' && $accounts.time_from == '' && $accounts.time_to == ''}
                <input id='date_pick2' name='date_pick2' class="date-pick" value="{if $secondCallFrom == '' && $secondCallTo == ''}No Detail{/if}"
                {if $accounts.time_from2 == '' && $accounts.time_to2 == ''}
                style='border:none; background-color:#d4e6fc;' size='10' readonly
                {/if}
                onchange='showTime2();'/>
                    <select name='time-start2' id='start2'>
                        {php}
                        foreach($timeArray as $eachTime){
                            echo '<option value="' . $eachTime . '">' . $eachTime . '</option>';
                        }
                        {/php}
                    </select>
                    <span id='to2'>to</span>
                    <select name='time-end2' id='end2'>
                        {php}
                        foreach($timeArray as $eachTime){
                            echo '<option value="' . $eachTime . '">' . $eachTime . '</option>';
                        }
                        {/php}
                    </select>
                    <span id='secondApp'></span>
                {elseif $accounts.time_from != '' && $accounts.time_to != '' && $accounts.time_from2 == '' && $accounts.time_to2 == ''}
                    <span id='secondApp'></span>
                    No Detail
                {else}
                      {php}
                        $accounts = $this->get_template_vars('accounts');
                        $from = $accounts['time_from2'];
                        $to = $accounts['time_to2'];
                        $exfrom = explode(' ', $from, 3);
                        $exto = explode(' ', $to);
                        $exfrom[0] = date('d M Y', strtotime($from));
                        echo "<span id='firstApp'>{$exfrom[0]} at $exfrom[1] - $exto[1] with $exfrom[2]</span>";
                    {/php}
                {/if}
            </td>
        </tr>
        <tr>
            <td></td>
            <td>
                <select name='gmt' id='gmt'>
                {php}
                    for($i = 0; $i < sizeof($gmtArray); $i++){
                        echo '<option value="' . $gmtValArray[$i] . '"';
                        echo ($gmtArray[$i] == '+0') ? 'selected' : '';
                        echo ' >GMT ';
                        echo $gmtArray[$i];
                        echo '</option>';
                    }
                {/php}
                </select>
            </td>
        </tr>
        {/if}
        <tr class="tr-revoke">
            <td style="padding-top: 30px; vertical-align: top;">
                Revoke reason note:
            </td>
            <td style="padding-top: 30px;">
                <textarea id="revoke-reason" rows='8' cols='120' size='10px'>{$client_cancel_reason}</textarea>
            </td>
        </tr>
        <tr class="tr-revoke">
            <td style="padding-top: 30px; vertical-align: top;">
                Revoke reason type:
            </td>
            <td style="padding-top: 30px;">
                <select id="revoke-type">
                    <option value="key Compromise">Key compromise</option>
                </select>
            </td>
        </tr>
        <tr class="tr-action">
            <td style="padding-top: 30px;">
                Action :
            </td>
            <td style="padding-top: 30px;">
                    <input type='button' id="csr-submit" class="all-button" value='Save' />
                    <input type='button' id="submit-info" class="all-button" value='&nbsp;Submit&nbsp;' />
                    <input type='button' id="submit-order" class="all-button" value='&nbsp;Buy&nbsp;' {if $term == 1}disabled{else}disabled{/if}/>
                    <input type='button' id="edit-contact" class="all-button" value='&nbsp;Edit Contact&nbsp;' />
                    <input type='button' id="change-csr" class="all-button" value='Change CSR' {if $term == 1}disabled{/if}/>
                    <input type='button' id="change-email" class="all-button" value='Change & Check State' {if $term == 1}disabled{/if}/>
                    <input type='button' id="verify-call" class="all-button" value='&nbsp;Submit verification call&nbsp;' onclick='return validateTime();' {if $term == 1}disabled{/if}/>
                    <input type='button' id='check-status' class="all-button" value='&nbsp;Check State&nbsp;' {if $term == 1}disabled{else}disabled{/if}/>
                    <input type='button' id='button-reissue' class="all-button" value='&nbsp;Reissue&nbsp;' />
                    <input type='button' id='button-reissue-step2' class="all-button" value='&nbsp;Reissue&nbsp;' />
                    <input type='button' id='button-revoke-step2-back' class="all-button" value='&nbsp;Back&nbsp;' />
                    <input type='button' id='button-revoke-step2' class="all-button" value='&nbsp;Revoke&nbsp;'  style="color:#ff0000"/>
                    <input type='button' id="update-submit" class="all-button" value='Update Data' />
            </td>
        </tr>
    </table>
    </div>
    </li>
</ul>
</td>
</tr>
<tr>
<td valign="top" width="100%">
{include file=$jslocation}