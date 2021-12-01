<style>
{literal}
#content_tb th{
  background-color: #c2c2a3;
}
{/literal}
</style>
<table width="100%" border="0" cellspacing="0" cellpadding="0" id="content_tb">
    <tbody>
        <tr>
            <td><h3>RV SSL Management</h3></td>
            <td  class="searchbox"></td>
        </tr>
        <tr>
            <td class="leftNav">
                {if $submenuList}
                    {foreach from=$submenuList item=menu}
                    <a href="?cmd={$cmd}&module={$module}&action={$menu.action}&security_token={$security_token}" class="tstyled">{$menu.name}</a>
                    {/foreach}
                {/if}
            </td>
            <td valign="top" class="bordered">
                <div id="bodycont" >
                    <div class="blu">
                        <h1>Edit SSL Details{if $smarty.get.edit_option} / Edit Options{/if}</h1>
                        <form action="?cmd={$cmd}&module={$module}&action=edit_ssl_details&security_token={$security_token}{if $smarty.get.edit_option}&edit_option=1{/if}" method="post" id="find_partner_id" >
                        <div class="clear"></div>
                        <input type="hidden" name="do_action" value="edit_option" />
			            {if $smarty.get.edit_option}
			            	<br />
			            	<table cellspacing="0" cellpadding="3" border="0" width="60%" class="glike hover">
			            		<col width="50%" />
			            		<col width="50%" />
			            	{foreach from=$aSSLOptions item=eOption key=optionName}
			            		{assign var=optName value=$optionName|replace:"_":" "|ucfirst}
			            		{if $optionName == "green_address_bar" || $optionName == "secures_subdomain" || $optionName == "unlimit_server_license" || $optionName == "malware_scanning" || $optionName == "support_for_san" || $optionName == "secures_both" || $optionName == "strongest_security" || $optionName == "free_reissue"}
			            			{assign var=needKey value=true}
			            		{else}
			            			{assign var=needKey value=false}
			            		{/if}
			            		<tr>
			            			<th colspan="2"><p><span>{$optName}</span></p></th>
			            		</tr>
			            		<tr class="{$optionName}">
			            			{if $needKey}<td><b>Key</b></td>{/if}
			            			<td {if !$needKey}colspan="2"{/if}><b>{if !$needKey}Key / {/if}Value</b><span style="float: right;"><a href="javascript:void(0);" onclick="addInput('{$optionName}'{if !$needKey}, 1{/if});">Add</a></span></td>
			            		</tr>
			            		{foreach from=$eOption item=option key=val}
			            		<tr class="{$optionName}">
			            			{if $needKey}<td>{$val}</td>{/if}
			            			<td {if !$needKey}colspan="2"{/if}>
			            				{if $option != ""}{$option}{else}Null{/if}
			            				<input type="hidden" name="editopt[{$optionName}][{$val}]" value="{$option}" />
			            				<button type="button" id="delbut_{$optionName}_{$val}" style="float: right; color: red;" onclick="disabledRow('_{$optionName}_{$val}', this, 'editopt[{$optionName}][{$val}]')">Delete</button>
			            				<a id="undobut_{$optionName}_{$val}" href="javascript:void(0);" style="display:none; float: right;" onclick="undoRow('_{$optionName}_{$val}', this, 'editopt[{$optionName}][{$val}]')">Undo</a>
			            			</td>
			            		</tr>
			            		{/foreach}
			            		<tr>
			            			<td colspan="2" style="background-color: #e0ecff;"><div class="blu"></div></td>
			            		</tr>
			            	{/foreach}
			            	</table>
			            	<br />
			            	<input type="submit" value="Save" />
			            	<a href="?cmd={$cmd}&module={$module}&action=edit_ssl_details&security_token={$security_token}">Back</a>
			            {else}
                        <span id="showHead" style="border: 5px solid black; padding: 3px; position: fixed; left: 0; top:50%; font-size: 18px; background-color:red; cursor: pointer;">s<br/>h<br/>o<br/>w<br/> <br/>h<br/>e<br/>a<br/>d<br/>e<br/>r</span>
                        <table cellspacing="0" cellpadding="3" border="0" width="100%" class="glike hover">
                            <tbody>
                                <tr>
                                	<th></th>
                                    <th>Name</th>
                                    <th>Authority</th>
                                    <th>Validation</th>
                                    <th>Product Code</th>
                                    <th>Contract ID</th>
                                    <th>Assurance</th>
                                    <th>ECC: Strongest Security</th>
                                    <th>Free Reissue</th>
                                    <th>Green Address Bar</th>
                                    <th>Secures Subdomain</th>
                                    <th>Secures both with/without WWW</th>
                                    <th>Unlimited server license</th>
                                    <th>Malware Scanning</th>
                                    <th>Support For SAN</th>
                                    <th>Included Domains</th>
                                    <th>Additional Domains</th>
                                    <th>Additional Servers</th>
                                </tr>
                            </tbody>
                            <tbody id="updater">
                            {php}
                                $i = 0;
                                $this->assign('rowCount', $i);
                            {/php}
                            {foreach from=$aSSLDetail item=SSLDetail}
                                {assign var="product_class" value=$SSLDetail.ssl_name|replace:" ":"_"|replace:"(":"_"|replace:")":"_"|replace:"/":"_"}
                                <tr>
                                	<td class="{$product_class} {if $rowCount%2}tdodd{else}tdeven{/if}" style="{if $rowCount%2 == 1}background-color:#DDD;{/if}"><input type="checkbox" id="select_{$product_class}" onclick="selectRow('{$product_class}');"/></td>
                                    <td class="{$product_class} {if $rowCount%2}tdodd{else}tdeven{/if}" style="border-right: 1px solid black; {if $rowCount%2 == 1}background-color:#DDD;{/if}">{if $rowCount%2 == 1}<b>{/if}{$SSLDetail.ssl_name}{if $rowCount%2 == 1}</b>{/if}</td>
                                    <td class="{$product_class} {if $rowCount%2}tdodd{else}tdeven{/if}"{if $rowCount%2 == 1} style="background-color:#DDD;"{/if}>
                                        <select title="Authority" name="detail[{$SSLDetail.ssl_id}][ssl_authority_id]">
                                        <optgroup label = "Authority">
                                        {foreach from=$aAuthority item=Authority}
                                            <option value="{$Authority.ssl_authority_id}" {if $Authority.ssl_authority_id==$SSLDetail.ssl_authority_id}selected="selected"{/if}>{$Authority.authority_name}</option>
                                        {/foreach}
                                        </select>
                                    </td>
                                    <td class="{$product_class} {if $rowCount%2}tdodd{else}tdeven{/if}"{if $rowCount%2 == 1} style="background-color:#DDD;"{/if}>
                                        <select title="Validation" name="detail[{$SSLDetail.ssl_id}][ssl_validation_id]">
                                        <optgroup label = "Validation">
                                        {foreach from=$aValidation item=Validation}
                                            <option value="{$Validation.ssl_validation_id}" {if $Validation.ssl_validation_id==$SSLDetail.ssl_validation_id}selected="selected"{/if}>{$Validation.validation_name}</option>
                                        {/foreach}
                                        </select>
                                    </td>
                                    <td class="{$product_class} {if $rowCount%2}tdodd{else}tdeven{/if}"{if $rowCount%2 == 1} style="background-color:#DDD;"{/if}>
                                        <input name="detail[{$SSLDetail.ssl_id}][ssl_productcode]" class="inp" value="{$SSLDetail.ssl_productcode}"/>
                                    </td>
                                    <td class="{$product_class} {if $rowCount%2}tdodd{else}tdeven{/if}"{if $rowCount%2 == 1} style="background-color:#DDD;"{/if}>
                                        <input name="detail[{$SSLDetail.ssl_id}][ssl_contract_id]" class="inp" value="{$SSLDetail.ssl_contract_id}"/>
                                    </td>
                                    <td class="{$product_class} {if $rowCount%2}tdodd{else}tdeven{/if}"{if $rowCount%2 == 1} style="background-color:#DDD;"{/if}>
                                        <select title="Assurance" name="detail[{$SSLDetail.ssl_id}][ssl_assurance]">
                                        <optgroup label = "Assurance">
                                        {foreach from=$aSSLOptions.assurance item=Assurance}
                                            <option value="{$Assurance}" {if $Assurance==$SSLDetail.ssl_assurance}selected="selected"{/if}>{$Assurance}</option>
                                        {/foreach}
                                        </select>
                                    </td>
                                    <td class="{$product_class} {if $rowCount%2}tdodd{else}tdeven{/if}"{if $rowCount%2 == 1} style="background-color:#DDD;"{/if}>
                                        <select title="ECC: Strongest Security" name="detail[{$SSLDetail.ssl_id}][strongest_security]">
                                        <optgroup label = "ECC: Strongest Security">
                                        {foreach from=$aSSLOptions.strongest_security key=StrongVal item=StrongestSecurity}
                                            <option value="{$StrongVal}" {if $StrongVal==$SSLDetail.strongest_security}selected="selected"{/if}>{$StrongestSecurity}</option>
                                        {/foreach}
                                        </select>
                                    </td>
                                    <td class="{$product_class} {if $rowCount%2}tdodd{else}tdeven{/if}"{if $rowCount%2 == 1} style="background-color:#DDD;"{/if}>
                                        <select title="Free Reissue" name="detail[{$SSLDetail.ssl_id}][free_reissue]">
                                        <optgroup label = "Free Reissue">
                                        {foreach from=$aSSLOptions.free_reissue key=FreeVal item=FreeReissue}
                                            <option value="{$FreeVal}" {if $FreeVal==$SSLDetail.free_reissue}selected="selected"{/if}>{$FreeReissue}</option>
                                        {/foreach}
                                        </select>
                                    </td>
                                    <td class="{$product_class} {if $rowCount%2}tdodd{else}tdeven{/if}"{if $rowCount%2 == 1} style="background-color:#DDD;"{/if}>
                                        <select title="Green Address Bar" name="detail[{$SSLDetail.ssl_id}][green_addressbar]">
                                        <optgroup label = "Green Address Bar">
                                        {foreach from=$aSSLOptions.green_address_bar key=GreenVal item=GreenAddress}
                                        	<option value="{$GreenVal}" {if $GreenVal == $SSLDetail.green_addressbar}selected="selected"{/if}>{$GreenAddress}</option>
                                        {/foreach}
                                        </select>
                                    </td>
                                    <td class="{$product_class} {if $rowCount%2}tdodd{else}tdeven{/if}"{if $rowCount%2 == 1} style="background-color:#DDD;"{/if}>
                                        <select title="Secures Subdomain" name="detail[{$SSLDetail.ssl_id}][secure_subdomain]">
                                        <optgroup label = "Secures Subdomain">
                                        {foreach from=$aSSLOptions.secures_subdomain key=SecuresVal item=SecuresSubdomain}
                                        	<option value="{$SecuresVal}" {if $SecuresVal == $SSLDetail.secure_subdomain}selected="selected"{/if}>{$SecuresSubdomain}</option>
                                        {/foreach}
                                        </select>
                                    </td>
                                    <td class="{$product_class} {if $rowCount%2}tdodd{else}tdeven{/if}"{if $rowCount%2 == 1} style="background-color:#DDD;"{/if}>
                                        <select title="Secures both with/without WWW" name="detail[{$SSLDetail.ssl_id}][secureswww]">
                                        <optgroup label = "Secures both with/without WWW">
                                        {foreach from=$aSSLOptions.secures_both key=SecuresBothVal item=SecuresBoth}
                                        	<option value="{$SecuresBothVal}" {if $SecuresBothVal == $SSLDetail.secureswww}selected="selected"{/if}>{$SecuresBoth}</option>
                                        {/foreach}
                                        </select>
                                    </td>
                                    <td class="{$product_class} {if $rowCount%2}tdodd{else}tdeven{/if}"{if $rowCount%2 == 1} style="background-color:#DDD;"{/if}>
                                        <select title="Unlimited Server License" name="detail[{$SSLDetail.ssl_id}][licensing_multi_server]">
                                        <optgroup label = "Unlimited server license">
                                        {foreach from=$aSSLOptions.unlimit_server_license key=UnlimitVal item=UnlimitServer}
                                        	<option value="{$UnlimitVal}" {if $UnlimitVal == $SSLDetail.licensing_multi_server}selected="selected"{/if}>{$UnlimitServer}</option>
                                        {/foreach}
                                        </select>
                                    </td>
                                    <td class="{$product_class} {if $rowCount%2}tdodd{else}tdeven{/if}"{if $rowCount%2 == 1} style="background-color:#DDD;"{/if}>
                                        <select title="Malware Scanning" name="detail[{$SSLDetail.ssl_id}][malware_scan]">
                                        <optgroup label = "Malware Scanning">
                                        {foreach from=$aSSLOptions.malware_scanning key=MalwareVal item=MalwareScanning}
                                        	<option value="{$MalwareVal}" {if $MalwareVal == $SSLDetail.malware_scan}selected="selected"{/if}>{$MalwareScanning}</option>
                                        {/foreach}
                                        </select>
                                    </td>
                                    <td class="{$product_class} {if $rowCount%2}tdodd{else}tdeven{/if}"{if $rowCount%2 == 1} style="background-color:#DDD;"{/if}>
                                        <select title="Support For SAN" name="detail[{$SSLDetail.ssl_id}][support_for_san]">
                                        <optgroup label = "Support For SAN">
                                        {foreach from=$aSSLOptions.support_for_san key=SupportSanVal item=SupportSAN}
                                        	<option value="{$SupportSanVal}" {if $SupportSanVal == $SSLDetail.support_for_san}selected="selected"{/if}>{$SupportSAN}</option>
                                        {/foreach}
                                        </select>
                                    </td>
                                    <td class="{$product_class} {if $rowCount%2}tdodd{else}tdeven{/if}"{if $rowCount%2 == 1} style="background-color:#DDD;"{/if}>
                                    <input name="detail[{$SSLDetail.ssl_id}][san_startup_domains]" size="3" class="inp" value="{$SSLDetail.san_startup_domains}"/>
                                    </td>
                                    <td class="{$product_class} {if $rowCount%2}tdodd{else}tdeven{/if}"{if $rowCount%2 == 1} style="background-color:#DDD;"{/if}>
                                    <input name="detail[{$SSLDetail.ssl_id}][san_max_domains]" size="3" class="inp" value="{$SSLDetail.san_max_domains}"/>
                                    </td>
                                    <td class="{$product_class} {if $rowCount%2}tdodd{else}tdeven{/if}"{if $rowCount%2 == 1} style="background-color:#DDD;"{/if}>
                                    <input name="detail[{$SSLDetail.ssl_id}][san_max_servers]" size="3" class="inp" value="{$SSLDetail.san_max_servers}"/>
                                    </td>
                                </tr>
                                {if $rowCount%5 == 0 && $rowCount!= 0}
                                <tr class="tabHead" style="display:none;">
                                	<th></th>
                                    <th>Name</th>
                                    <th>Authority</th>
                                    <th>Validation</th>
                                    <th>Product Code</th>
                                    <th>Contract ID</th>
                                    <th>Assurance</th>
                                    <th>Key length</th>
                                    <th>Encryption Strength</th>
                                    <th>Green Address Bar</th>
                                    <th>Secures Subdomain</th>
                                    <th>Secures both with/without WWW</th>
                                    <th>Unlimited server license</th>
                                    <th>Malware Scanning</th>
                                    <th>Support For SAN</th>
                                    <th>Included Domains</th>
                                    <th>Additional Domains</th>
                                    <th>Additional Servers</th>
                                </tr>
                                {/if}
                                {php}
                                    $i = $this->get_template_vars('rowCount');
                                    $i++;
                                    $this->assign('rowCount', $i);
                                {/php}
                            {/foreach}
                            </tbody>
                        </table>
                        <div class="clear"></div>
                        <div class="blu">
                            <div class="right"><div class="pagination"></div></div>
                            <div class="left menubar"><b>Action:</b>
                                <input type="hidden" name="do_edit" value="do_edit" />
                                <input type="submit" name="submit" value="Submit" class="inp" />  <input type="reset" name="reset" value="Reset" class="inp" />
                            </div>
                            <br />
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="?cmd={$cmd}&module={$module}&action=edit_ssl_details&security_token={$security_token}&edit_option=1">Edit options</a>
                            <div class="clear"></div>
                        </div>
			            {/if}
                        </form>
                    </div>
                </div>
            </td>
        </tr>
    </tbody>
</table>

<script type="text/javascript">
    {literal}
        $(document).ready(function(){
        	$('.tabHead').hide();
        });

        $('#showHead').click(function(){
            if($('.tabHead').css('display') == 'none'){
                $('.tabHead').show();
                $('#showHead').css('background-color', 'green');
                $('#showHead').css('color', 'white');
            } else {
                $('.tabHead').hide();
                $('#showHead').css('background-color', 'red');
                $('#showHead').css('color', 'black');
            }
        });

        function selectRow(rowClass)
        {
            if($("#select_" + rowClass).is(':checked')){
            	$('.' + rowClass).css('background-color', '#a3c2c2');
            } else {
                if($('.' + rowClass).attr('class').search('tdodd') >= 0){
                	$('.' + rowClass).css('background-color', '#DDD');
                } else {
                	$('.' + rowClass).css('background-color', '#efefef');
                }
            }
        }

        function addInput(opt, needkey)
        {
            needkey = (typeof needkey != "undefined") ? needkey : 0;
            if(needkey){
            	$("." + opt).last().after("<tr><td><input type='text' name='editopt[" + opt + "][]' /></td><td><button onclick='removeAddRow(this);' style='float:right; color: red;' type='button'>x</button></td></tr>");
            } else {
            	$("." + opt).last().after("<tr><td><input type='text' name='editopt[" + opt + "][this_is_key][]' /></td><td><input type='text' name='editopt[" + opt + "][this_is_val][]' /><button onclick='removeAddRow(this);' style='float:right; color: red;' type='button'>x</button></td></tr>");
            }
        }

        function disabledRow(button, that, name)
        {
            $("input[name='" + name + "']").attr("disabled", true);
            $(that).hide();
            $("#undobut" + button).show();
        }

        function undoRow(button, that, name)
        {
        	$("input[name='" + name + "']").attr("disabled", false);
        	$(that).hide();
            $("#delbut" + button).show();
        }

        function removeAddRow(that)
        {
            $(that).closest('tr').remove();
        }
    {/literal}
</script>