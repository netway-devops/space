<div class="order" style="display: block;">
    <div id="csrInformation">
        <div class="title" style="margin:13px 0 0 26px;">
            CSR:Information
        </div>
        <div class="CSRinformation2">
            {if true}
            <p style="padding-left:10px; text-indent:20px;">
                The Common Name field should be the Fully Qualified Domain Name (FQDN) or the Web address for which you plan to use your Certificate, e.g. the area of your site you wish customers to connect to using SSL. For example, an SSL Certificate issued for example-name.com will not be valid for www.example-name.com or for secure.example-name.com. If the Web address to be used for SSL is www.example-name.com, ensure that the common name submitted in the CSR is www.example-name.com; similarly, if the Web address to be used for SSL is secure.example-name.com, ensure that the common name submitted in the CSR is secure.example-name.com.
            </p>
            <p style="padding-left:10px; text-indent:20px;">
                If you want your domain name to be secured with SSL Certificate for both with and without "www". The CSR will need to be generated with "www" in the Common Name.
            </p>
            {/if}
            {if $supportSan}
                {if $sanFirst > 1}
                <p style="padding-left:10px; text-indent:20px;">
                    {$service.name} can include up to {$sanFirst-1} additional domain names in one certificate. These domain names are included in the certificate subject alternative name field and will be processed by browsers just like the common name. The second and third level domains can be different and internal host names / machine names are accepted as well.
                </p>
                {/if}
                <p style="padding-left:10px; text-indent:20px;">
                    {if $service.ssl_id == 44 || $service.ssl_name == 'GeoTrust QuickSSL Premium SAN Package'}
                    <b>Important</b> : The top and second level domains must be the same for each value in the SAN field.
                    {else}
                    <b>Important</b> : All fully qualified domains should be registered to the same organization.
                    {/if}
                </p>
                {if false}
                <p style="padding-left:10px; text-indent:20px;">
                    <b>Warning</b> : If you proceed with the enrollment without specifying additional domains you will be not be able to add additional domains on reissue of the certificate.
                </p>
                {/if}
            <hr>
            {/if}
            <table border="0">
                <tr>
                    <td width="160px">
                        <b>Common Name</b>
                    </td>
                    <td>
                        : <span id="csr_common_name" style="padding-left:10px;"></span>
                    </td>
                </tr>
                <tr>
                    <td width="160px">
                        <b>Organization</b>
                    </td>
                    <td>
                        : <span id="csr_organization" style="padding-left:10px;"></span>
                    </td>
                </tr>
                <tr>
                    <td width="160px"><b>Organization Unit</b></td>
                    <td>: <span id="csr_organization_unit" style="padding-left:10px;"></span></td>
                </tr>
                <tr>
                    <td width="160px"><b>City/Locality</b></td>
                    <td>: <span id="csr_locality" style="padding-left:10px;"></span></td>
                </tr>
                <tr>
                    <td width="160px"><b>State</b></td>
                    <td>: <span id="csr_state" style="padding-left:10px;"></span></td>
                </tr>
                <tr>
                    <td width="160px"><b>Country</b></td>
                    <td>: <span id="csr_country" style="padding-left:10px;"></span></td>
                </tr>
                <tr>
                    <td width="160px"><b>Key Algorithm</b></td>
                    <td>: <span id="csr_key_algorithm" style="padding-left:10px;"></span></td>
                </tr>
                <tr>
                    <td width="160px"><b>Signature Algorithm</b></td>
                    <td>: <span id="csr_signature_algorithm" style="padding-left:10px;"></span></td>
                </tr>
                {if isset($dnsNames)}
                    {php}
                        $sanInclude = $this->get_template_vars('sanIncluded');
                        $sanAdd = $this->get_template_vars('additionalAmount');
                        $count = 0;
                        $addCount = 0;
                    {/php}
                    {foreach from=$dnsNames item=eachDns}
                        <tr>
                            <td width="160px">
                                <b>
                                    {php}
                                        if($count < $sanInclude-1){
                                            echo '<span id="textsanDomain' . ++$count . '">Included Domain ' . $count;
                                            if($count == 1 || $sanAdd > 0){
                                                echo '<font color="red">*';
                                            }
                                            echo '</span>';
                                        } else {
                                            echo '<span id="textsanDomain' . ++$count . '">Additional Domain ' . ++$addCount . '<font color="red">*</font></span>';
                                        }
                                        $this->assign('SanCount', $count);
                                    {/php}
                                </b>
                            </td>
                            <td>: <input type="text" id="sanDomain{$SanCount}" name="sanDomain[]" style="padding-left:10px;" value="{if $eachDns != '-'}{$eachDns}{/if}"/>
                                {if $service.ssl_productcode == 'QuickSSLPremium' || $service.ssl_id == 44 || $service.ssl_name == 'GeoTrust QuickSSL Premium SAN Package'}
                                    <span class="dvSpecial"></span>
                                {/if}
                            </td>
                        </tr>
                    {/foreach}
                    {php}
                    if($count < $sanInclude-1){
                        for($i = $count; $i < $sanInclude-1; $i++){
                        {/php}
                            <tr>
                                <td width="160px">
                                    <b>
                                    {php}
                                        echo '<span id="textsanDomain' . ++$count . '">Included Domain ' . $count . '</span>';
                                        $this->assign('SanCount', $count);
                                    {/php}
                                    </b>
                                </td>
                                <td>: <input type="text" id="sanDomain{$SanCount}" name="sanDomain[]" style="padding-left:10px;" value=""/>
                                    {if $service.ssl_productcode == 'QuickSSLPremium' || $service.ssl_id == 44 || $service.ssl_name == 'GeoTrust QuickSSL Premium SAN Package'}
                                        <span class="dvSpecial"></span>
                                    {/if}
                                </td>
                            </tr>
                            {php}
                        }
                    }
                    {/php}
                {/if}
            </table>
        </div>
    </div>
    <div class="step3" style="display: block;">
        {if $validation_id == 1}
        <div class="title" style="margin:13px 0 0 26px; ">
            E-mail Approval:<font color="#FF0000">*</font>
        </div>
        <div class="emailApproval" style="padding-top: 5px;">
            <div>
                <font>
                    <hr>
                    <p style="padding-left: 15px; margin: -10px 0 -10px 0;">
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The Email Verification will be sent to the "Email Approval" you specified here. Please don't miss to click the Owner Verification to confirm yourself on the email. If you don't feel convenience to verify by E-mail Approval, you can choose 2 alternative ways:
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1.HTTP Verification Method  
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2.DNS Record Approval 
<br>By contacting to <a href="https://www.digicert.com/security-certificate-support/#Contact" target="_blank">https://www.digicert.com/security-certificate-support/#Contact</a>, if the order processing is completed.
                    </p>
                    <hr>
                </font>
            </div>
            <div style="padding-left:5px;">
                <div class="divCell" id="whois_emailinfo"></div>
            </div>
            <div class="clear"></div>
        </div>
        {else}
            <input type="hidden" name="email_approval" value="{$email_approval}" />
        {/if}
        {if $validation_id != 1 || ($validation_id == 1 && $sslDetail.ssl_productcode == 'SSL123')}
        <div class="title" style="margin:13px 0 0 26px; ">
            Organization Information:
        </div>
        <div class="contact_detail" style="padding-top: 5px; ">
            <div>
                <p style="padding-left: 15px; margin: 5px 0 5px 0;">
                    The information entered below about your company will appear in your certificate. Some of the information was obtained from the CSR you submitted. You may edit this information, but make sure this information matches what you want to appear in the certificate. Delays in approving your request may result if the information does not match what is listed in the Articles of Incorporation for your company, which has been recorded and maintained in official third-party databases.
                </p>
                <hr>
                <div>
                    Organization Name : <font color="red">*</font>
                </div>
                <div>
                    <input type="text" id="o_name" name="organize[name]" class="txtContact" style="width: 40%" value="{$contactDetail.organization.name}"/>
                </div>
                <div>
                    Phone Number : <font color="red">*</font>
                </div>
                <div>
                    <input type="text" id="o_phone" name="organize[phone]" class="txtContact" style="width: 40%" value="{$contactDetail.organization.phone}"/>
                </div>
                <div>
                    Address : <font color="red">*</font>
                </div>
                <div>
                    <input type="text" id="o_address" name="organize[address]" class="txtContact" style="width: 40%" value="{$contactDetail.organization.address}"/>
                </div>
                <div>
                    City : <font color="red">*</font>
                </div>
                <div>
                    <input type="text" id="o_city" name="organize[city]" class="txtContact" style="width: 40%" value="{$contactDetail.organization.city}"/>
                </div>
                <div>
                    State/Province : <font color="red">*</font>
                </div>
                <div>
                    <input type="text" id="o_state" name="organize[state]" class="txtContact" style="width: 40%" value="{$contactDetail.organization.state}"/>
                </div>
                <div>
                    Country : <font color="red">*</font>
                </div>
                <div>
                    <select id="o_country" name="organize[country]" style="width: 40%">
                        {foreach from=$service.country_list item=countryData}
                            <option value="{$countryData.code}"{if $contactDetail.organization.country == $countryData.code} selected{/if}>{$countryData.name}</option>
                        {/foreach}
                    </select>
                </div>
                <div>
                    Postal Code : <font color="red">*</font>
                </div>
                <div>
                    <input type="text" id="o_postcode" name="organize[postcode]" class="txtContact" style="width: 40%" value="{$contactDetail.organization.post_code}"/>
                </div>
                <hr>
            </div>
        </div>
        {/if}
        <div class="clear"></div>
        <table width="95%">
            <tr>
                <td valign="top">
                    <div class="title" style="margin:13px 0 0 26px;">Administrative Contact:</div>
                    <div id="adminContactDiv" class="contact_detail" style="width: 87%; height: 90%; padding-top: 20px;">
                        <div>The administrative contact is the primary contact and will be contacted to assist in resolution of any questions about the order.</div>
                        <div>Administrative person will be also used for Verification "Callbacks", that will be made for all Business/Extended Validation certificates. No callbacks will be made for Domain Validation Certificates.</div>
                        <hr>
                        <div id="admin_error_div" style="display:none; border:1px solid grey; padding:3px; background:#ECECEC; margin-bottom:10px;">
                            <span>
                                <font id="admin_error_text" color="red"></font>
                                <span></span>
                            </span>
                        </div>
                        <div>First name:<font color="red">*</font></div>
                        <div><input type="text" id="txt_name" name="admin[firstname]" class="txtContact" style="width: 100%" value="{$contactDetail.admin.firstname}" /></div>
                        <div>Last name:<font color="red">*</font></div>
                        <div><input type="text" id="txt_lastname" name="admin[lastname]" class="txtContact" style="width: 100%" value="{$contactDetail.admin.lastname}" /></div>
                        <div>Email Address:<font color="red">*</font></div>
                        <div><input type="text" id="txt_email" name="admin[email]" class="txtContact" style="width: 100%" value="{$contactDetail.admin.email}" /></div>
                        {if $service.is_symantec}
                        <div>Organization Name:<font color="red">*</font></div>
                        <div><input type="text" id="txt_organize" name="admin[organize]" class="txtContact" style="width: 100%" value="{$contactDetail.admin.organization_name}" /></div>
                        {/if}
                        <div>Job Title:<font color="red">*</font></div>
                        <div><input type="text" id="txt_job" name="admin[job]" class="txtContact" style="width: 100%" value="{$contactDetail.admin.job}" /></div>
                        {if $service.is_symantec}
                            <div>Address:<font color="red">*</font></div>
                            <div><input type="text" id="txt_address" name="admin[address]" class="txtContact" style="width: 100%" value="{$contactDetail.admin.address}" /></div>
                            <div>City:<font color="red">*</font></div>
                            <div><input type="text" id="txt_city" name="admin[city]" class="txtContact" style="width: 100%" value="{$contactDetail.admin.city}" /></div>
                            <div>State/Region:<font color="red">*</font></div>
                            <div><input type="text" id="txt_state" name="admin[state]" class="txtContact" style="width: 100%" value="{$contactDetail.admin.state}" /></div>
                            <div>Country:<font color="red">*</font></div>
                            <div>
                                <select name="admin[country]" id="txt_country" class="txtContact" style="width: 100%">
                                    {foreach from=$service.country_list item=countryData}
                                        <option value="{$countryData.code}"{if $contactDetail.admin.country == $countryData.code} selected{/if}>{$countryData.name}</option>
                                    {/foreach}
                                </select>
                            </div>
                            <div>Postal Code:<font color="red">*</font></div>
                            <div><input type="text" id="txt_post_code" name="admin[post_code]" class="txtContact" style="width: 100%" value="{$contactDetail.admin.postal_code}" /></div>
                        {/if}
                        <div>Phone number:<font color="red">*</font></div>
                        <div><input type="text" id="txt_tel" name="admin[phone]" class="txtContact" style="width: 100%" value="{$contactDetail.admin.phone}" /></div>
                        <div>Ext Number:</div>
                        <div><input type="text" id="txt_ext" name="admin[ext]" class="txtContact" style="width: 100%" value="{$contactDetail.admin.ext}" /></div>
                    </div>
                </td>
                <td valign="top">
                    <div class="title" style="margin:13px 0 0 26px;">Technical Contact Details:</div>
                    <div id="techContactDiv" class="contact_detail" style="width: 90%; height: 55%; padding-top: 20px;">
                        <div>The Technical contact will receive the certificate and generally be the individual to install the certificate on the web server. Technical contact will also receive renewal notices.</div>
                        <br>
                        <select id="techInfoType" style="margin:-10px 0 -10px 0; width:70%;">
                            <option value="sameBefore" selected>Same as current technical contact</option>
                            <option value="sameAdmin">Same as administrative contact</option>
                            <option value="sameBilling">Same as billing contact</option>
                            <option value="sameTech">Same as technical contact from whois</option>
                        </select>
                        <br>
                        <hr>
                        <div class="not_same_address" style="">
                            <div id="tech_error_div" style="display:none; border:1px solid grey; padding:3px; background:#ECECEC; margin-bottom:10px;">
                                <span>
                                    <font id="tech_error_text" color="red"></font>
                                    <span></span>
                                </span>
                            </div>
                            <div>First name:<font color="red">*</font></div>
                            <div><input type="text" id="txt_name_1" name="tech[firstname]" class="txtContact" style="width: 100%" value="{$contactDetail.tech.firstname}" /></div>
                            <div>Last name:<font color="red">*</font></div>
                            <div><input type="text" id="txt_lastname_1" name="tech[lastname]" class="txtContact" style="width: 100%" value="{$contactDetail.tech.lastname}" /></div>
                            <div>Email Address:<font color="red">*</font></div>
                            <div><input type="text" id="txt_email_1" name="tech[email]" class="txtContact" style="width: 100%" value="{$contactDetail.tech.email}" /></div>
                            {if $service.is_symantec}
                                <div>Organization Name:<font color="red">*</font></div>
                                <div><input type="text" id="txt_organize_1" name="tech[organize]" class="txtContact" style="width: 100%" value="{$contactDetail.tech.organization_name}" /></div>
                            {/if}
                            <div>Job Title:<font color="red">*</font></div>
                            <div><input type="text" id="txt_job_1" name="tech[job]" class="txtContact" style="width: 100%" value="{$contactDetail.tech.job}" /></div>
                            {if $service.is_symantec}
                                <div>Address:<font color="red">*</font></div>
                                <div><input type="text" id="txt_address_1" name="tech[address]" class="txtContact" style="width: 100%" value="{$contactDetail.tech.address}" /></div>
                                <div>City:<font color="red">*</font></div>
                                <div><input type="text" id="txt_city_1" name="tech[city]" class="txtContact" style="width: 100%" value="{$contactDetail.tech.city}" /></div>
                                <div>State/Region:<font color="red">*</font></div>
                                <div><input type="text" id="txt_state_1" name="tech[state]" class="txtContact" style="width: 100%" value="{$contactDetail.tech.state}" /></div>
                                <div>Country:<font color="red">*</font></div>
                                <div>
                                    <select name="tech[country]" id="txt_country_1" class="txtContact" style="width: 100%">
                                        {foreach from=$service.country_list item=countryData}
                                            <option value="{$countryData.code}"{if $contactDetail.tech.country == $countryData.code} selected{/if}>{$countryData.name}</option>
                                        {/foreach}
                                    </select>
                                </div>
                                <div>Postal Code:<font color="red">*</font></div>
                                <div><input type="text" id="txt_post_code_1" name="tech[post_code]" class="txtContact" style="width: 100%" value="{$contactDetail.tech.postal_code}" /></div>
                            {/if}
                            <div>Phone number:<font color="red">*</font></div>
                            <div><input type="text" id="txt_tel_1" name="tech[phone]" class="txtContact" style="width: 100%" value="{$contactDetail.tech.phone}" /></div>
                            <div>Ext Number:</div>
                            <div><input type="text" id="txt_ext_1" name="tech[ext]" class="txtContact" style="width: 100%" value="{$contactDetail.tech.ext}" /></div>
                        </div>
                    </div>
                </div>
                </td>
            </tr>
        </table>
    </div>
    <div style="padding-left: 30px"><br>
        <br><br>
    </div>
</div>