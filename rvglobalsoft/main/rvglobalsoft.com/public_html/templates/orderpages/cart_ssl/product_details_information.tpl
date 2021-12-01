        <div{if !$support_san} class="col-md-12"><br>{else}>{/if}
            {if $support_san}
                <div align="left">
            {else}
                <div align="center">
            {/if}
            {if $support_san}
                <table>
                    <col width="50%" />
                    <col width="50%" />
                    <tr>
                        <td>
            {/if}
                            <table{if !$support_san} width="70%"{/if}>
                                <tr align="left">
                                    <td>{if $aSSL.validation_name}<img src="{$template_dir}images/checked.png"/><b> Validation:</b> {$aSSL.validation_name}{else}<img src="{$template_dir}images/non.png"/><b> Validation:</b> No{/if}</td>
                                    <td>{if $aSSL.issuance_time}<img src="{$template_dir}images/checked.png"/><b> Issuance time:</b> {$aSSL.issuance_time}{else}<img src="{$template_dir}images/non.png"/><b> Issuance time:</b> No{/if}</td>
                                </tr>
                                <tr align="left">
                                    <td>{if $aSSL.warranty}<img src="{$template_dir}images/checked.png"/><b> Warranty:</b> ${$aSSL.warranty|number_format}{else}<img src="{$template_dir}images/non.png"/><b> Warranty:</b> No{/if}</td>
                                    <td><img src="{$template_dir}images/{if $aSSL.green_addressbar}checked{else}non{/if}.png"/><b> 	Business name in browser:</b> {if $aSSL.green_addressbar}Yes{else}No{/if}</td>
                                </tr>
                                <tr align="left">
                                    <td><img src="{$template_dir}images/{if $aSSL.secure_subdomain}checked{else}non{/if}.png"/><b> Secure sub-domains:</b> {if $aSSL.secure_subdomain}Yes{else}No{/if}</td>
                                    <td>{if $support_san}<img src="{$template_dir}images/checked.png"/><b> Support for SAN (UC):</b> Yes{else}<img src="{$template_dir}images/non.png"/><b> Support for SAN (UC):</b> No{/if}</td>
                                </tr>
                                <tr align="left">
                                    <td><img src="{$template_dir}images/{if $aSSL.free_reissue}checked{else}non{/if}.png"/><b> Free Reissue:</b> {if $aSSL.free_reissue}Yes{else}No{/if}</td>
                                    <td>{if (false && $servMax <= 1 && $support_san) || $aSSL.licensing_multi_server}<img src="{$template_dir}images/checked.png"/><b> Unlimited server license:</b> Yes{else}<img src="{$template_dir}images/non.png"/><b> Unlimited server license:</b> No{/if}</td>
                                </tr>
                                <tr align="left">
                                    <td><img src="{$template_dir}images/{if $aSSL.malware_scan}checked{else}non{/if}.png"/><b> Malware Scanning:</b> {if $aSSL.malware_scan}Yes{else}No{/if}</td>
                                    <td>{if $aSSL.secureswww != '-1'}<img src="{$template_dir}images/{if $aSSL.secureswww}checked{else}non{/if}.png"/><b> Secures both with/without WWW:</b> {if $aSSL.secureswww}Yes{else}No{/if}{/if}</td>
                                </tr>
                            </table>
                        {if $support_san}</td>
                        <td>
                            <table style="background-color:#f5f5f5; border:1px solid #cbcbcb; padding:20px;">
                                <col width="33%" />
                                <col width="33%" />
                                <col width="33%" />
                                <tr>
                                    <td colspan="3"><p class="title" style="font-size:24px;">SAN Information</p></td>
                                </tr>
                                <tr>
                                    <td{if isset($sanPrice.$selectConract) && $sanMax == 0} width="50%"{/if}>
                                        <div>
                                            <div class="title" style="font-size:18px;">{$sanInclude} Domain{if $sanInclude > 1}s{/if}</div>
                                            <div style="font-size:13px; line-height:15px; margin-top:5px;">Domains included in the standard package.</div>
                                        </div>
                                    </td>
                                    {if isset($sanPrice.$selectConract) && $sanMax > 0}
                                    <td>
                                        <div>
                                            {if isset($sanPrice.$selectConract) && $sanMax > 0}<span class="title" style="font-size:18px;">$</span><span id="sanStatic" class="title" style="font-size:18px;">{$sanPrice[12]|number_format:2}{if strpos($aSSL.ssl_name, 'SAN Package') == false}*{/if}</span>{else}-{/if}
                                            <div style="font-size:13px; line-height:15px; margin-top:5px;">Price per each additional domain name per year.</div>
                                        </div>
                                    </td>
                                    {/if}
                                    <td{if isset($sanPrice.$selectConract) && $sanMax == 0} width="50%"{/if}>
                                        <div>
                                            <div class="title" style="font-size:18px;">{if $sanMax > 0}{$sanMax}{else}None{/if}</div>
                                            <div style="font-size:13px; line-height:15px; margin-top:5px;">Maximum additional domain names this package can cover.</div>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
                {/if}
            </div>
            <div class="clear"></div>
        </div>
        {if $support_san &&  isset($sanPrice.$selectConract) && $sanMax > 0 && strpos($aSSL.ssl_name, 'SAN Package') == false}
        <div align="right" style="font-size: 12px;">*Longer certificate period, save more.</div>
        {/if}