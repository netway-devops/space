<link media="all" type="text/css" rel="stylesheet" href="{$orderpage_dir}sslcertificates/style.css" />
{include file='sslcertificates/cprogress.tpl'}
<form id="mform" action="" method="post">
    <input type="hidden" name="make" value="continue" />
    <input type="hidden" name="organization[name]" value="{$customdata.organization.name}" id="i_O"/>
    <input type="hidden" name="organization[unit]" value="{$customdata.organization.unit}" id="i_OU"/>
    <input type="hidden" name="organization[address1]" value="{$customdata.organization.address1}" id="i_STREET" />
    <input type="hidden" name="organization[locality]" value="{$customdata.organization.locality}" id="i_L"/>
    <input type="hidden" name="organization[state]" value="{$customdata.organization.state}"  id="i_S"/>
    <input type="hidden" name="organization[postalcode]" value="{$customdata.organization.postalcode}" id="i_PostalCode"/>
    <input type="hidden" name="organization[country]" value="{$customdata.organization.country}" id="i_C"/>
    {if !$nocsr}{* GET CSR OR COMMONNAME *}
        <div class="blue-pad">
            <h4>{$lang.step} 2</h4>
            <h3>{$lang.submit_csr}</h3>
        </div>
        <div class="step-info">{$lang.en_step2intro}</div>

        <div id="wtcsr" class="white-box step-csr clearfix" {if $customdata.nocsr=='0'}style="display:none;"{/if}>
            <div class="left">
                <h3>{$lang.en_wtfcsr}</h3>
                <div class="strike-line"></div>
                {$lang.en_wtfdescr}
            </div>
            <div class="right">
                <h4>{$lang.en_csrex}</h4>
                <br />
                <div class="well pre-formated" >
                    -----BEGIN CERTIFICATE REQUEST-----<br />
                    MIIWtjCCAR8CAQAwdjELMAkGA1UEBhMCVVMxDTALBgNVBAgTBFV0YWgxDzANBgNVBAcTBkxpbmRvbjEVMBMGA1UEChMMRGlnaUN123QgSW5jMREwDwYDVQQLEwhEaWdpQ2VydDEdMBsGA1UEAxMUZXhhbXBsZS5kaWdpY2VydC5jb20wg11wDQYJKoZIhvcNAQEBBQAD3f32MIGJAo24ALxG0R0gERgRkL2vTqcZfbCwlWBGVRjgaeJMaFCPQGri/DVvTeF9Yi8YZql54vewJIpLFwTDZcB+tRkcw+dFUrQa82cTjToJ+8yBDO2uwfUiiUfqbnGW1XpFA9rlaKBaakmGHasFIDprBFA6EH6nvJk122b302SYrtnNM68VNX3AgMBAAGgADANBgkqhkiG9w0BAQQFgAOBgQAphzI6acorHL3voml27jXheyvXnEuTv6xEUQHui1hEm1KG2ZNzGhZ4idznrHz+qzqQ962Nk7JATnEECO7DZ6xEQr5ycLcvMHzJgd0BkFYy2x0zvv6gVV6S9hu0b5NYCfW9q6lESMNcnjy0k/Dny/gcWPxDEUE8UjzGrVMUlZZcjA==<br />
                    -----END CERTIFICATE REQUEST-----
                </div>
            </div>
        </div>

        <div class="white-box clearfix step-csr-input" {if $customdata.nocsr=='1' || !$customdata}style="display:none;"{/if} id="csrplace" >
            <div class="left">
                <h4>{$lang.en_servsoft}</h4><br />
                <select size="2" id="servers_types" name="server_software">
                    {if $csr_servers}
                        {foreach from=$csr_servers item=server key=pos name=csrsr}
                            <option value="{$pos}" {if $smarty.foreach.csrsr.first}selected="selected"{/if}>{$server}</option>
                        {/foreach}
                    {/if}
                </select>
            </div>
            <div class="right">
                <h4>{$lang.en_pastecsr}</h4><br />
                <div class="well" >
                    <textarea id="csrbox" name="csr">{$customdata.csr}</textarea>
                </div>
            </div>
        </div>
        <div  id="nocsr" class="greenbox">
            <table border="0" width="100%" cellspacing="0">
                <tr>
                    <td width="33%"></td>
                    <td><input type="checkbox" name="nocsr" value="1" {if $customdata.nocsr=='1' || !$customdata}checked="checked"{/if}/> <span class="clicky"><strong>{$lang.en_donthave}</strong></span></td>
                </tr>
                <tr>
                    <td  width="33%"></td>
                    <td><input type="checkbox" name="yescsr" value="1" {if $customdata.nocsr=='0'}checked="checked"{/if}/> <span class="clicky"><strong>{$lang.en_csrhave}</strong></span></td>
                </tr>
            </table>
        </div>
    {else}{* GET COMMON NAME *}
        <div class="blue-pad">
            <h4>{$lang.step} 2</h4>
            <h3>{$lang.en_step2nocsr}</h3>
        </div>
        <div class="step-info">{$lang.en_step2intronocsr}</div>
    {/if} {*END IF*}
        <div class="white-box clearfix form-horizontal step-common" >
            <strong>{$lang.en_commonname} </strong>*
            <input id="cn" name="cn" value="{$customdata.cn}" class="styled" size="30" style="font-weight:bold;"/>
            <a href="#" id="btn_submit" class="btn btn-custom btn-custom-inline right {if $customdata.cn=='' || !$customdata.cn}disabled{/if}" onclick="return step2.submitmform(this)">{$lang.continuetostep} 3 &raquo;</a>
        </div>
        <div class="step-info">{$lang.en_comdesc}</div>
    </form>
    <div class="clear"></div>

    <script type="text/javascript">
        step2.init();
    </script>