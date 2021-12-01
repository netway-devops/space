<tr><td ></td>
    <td>
        <table border="0" cellspacing="0" cellpadding="0" width="1200">
            <tr>
                <td class="sectionhead_ext open" width="400">Settings</td>
                <td width="40"></td>
                <td class="sectionhead_ext open" width="330">SOA Settings</td>
                <td width="40"></td>
                <td class="sectionhead_ext open" width="330">Nameservers</td>
            </tr>

            <tr>
                <td valign="top" style="padding:10px;" class="sectionbody">
                    <table border="0" cellspacing="0" cellpadding="3" width="100%">
                        <tr>
                            <td>
                                <b class="fs11">Max domains count: <a class="vtip_description" title="Maximum number of domains client can create trough clientarea interface"></a></b><br/>
                                <div id="config_domainnumber">
                                    <input type="text"  name="options[option1]" value="{$default.option1}" class="inp" style="width:250px;"/>
                                    <span class="fs11">
                                        <input type="checkbox" class="formchecker" rel="domainnumber">
                                        <a class="vtip_description" title="Allow client to adjust during order"></a>
                                    </span>
                                </div>
                            </td>
                        </tr>

                        <tr>
                            <td>
                                <b class="fs11">Use this template with each new zone</b> <a class="vtip_description" title="Select dns template that will be applied to each new zone created under this package. You can define DNS Templates in <b>Components</b> tab"></a><br/>
                                <select id="dnstpl_select" name="options[dns_template]" class="inp" style="width: 255px">
                                    <option value="">- {$lang.none} -</option>
                                    {if $default.dns_template}<option selected="selected" value="{$default.dns_template}">Loading..</option>{/if}
                                </select>
                            </td>
                        </tr>

                        <tr>
                            <td>
                                <b class="fs11">Record types: <a class="vtip_description" title="Record types that client can add in client portal. When the field is empty, all types of records that the module offers, will be available."></a></b><br/>
                                <select id="records" name="options[records][]" multiple class="chosen chosen-select">
                                    {foreach from=$records item=record}
                                        <option value="{$record}" {if in_array($record, $default.records)}selected{/if}>{$record}</option>
                                    {/foreach}
                                </select>
                            </td>
                        </tr>

                        <tr>
                            <td>
                                <b class="fs11">Default NS TTL: <a class="vtip_description" title="TTL For default NS records added with each new zone"></a></b><br/>
                                <input  name="options[nsttl]"  value="{$default.nsttl|default:"86400"}" class="inp" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <input type="checkbox" name="options[hide_billing]" value="1" {if $default.hide_billing == '1'}checked{/if}>
                                <b class="fs11">Hide billing info from DNS product</b>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <input type="checkbox" name="options[hide_zone_management]" value="1" {if $default.hide_zone_management == '1'}checked{/if}>
                                <b class="fs11">Hide ability to add new zones manually</b>
                            </td>
                        </tr>
                    </table>
                </td>
                <td ></td>
                <td valign="top" style="padding:10px;" class="sectionbody">
                    <table border="0" cellspacing="0" cellpadding="3" width="100%">
                        <tr>
                            <td>
                                <b class="fs11">Disallow SOA edit</b><br/>
                                <input type="checkbox"  name="options[disable_soa]" value="1"
                                       {if $default.disable_soa}checked{/if} />
                                Do not allow clients to edit SOA records.
                            </td>
                        </tr>
                         <tr>
                            <td>
                                <b class="fs11">SOA Email address</b><br/>
                                <input type="radio"  name="options[option6]" value="1" {if $default.option6=='1' || (!$default.option6 && $default.option6 != '0')}checked="checked"{/if} /> Use client email address <br />
                                <input type="radio"  name="options[option6]" value="0" {if $default.option6 == '0'}checked="checked"{/if} /> Use email address below:
                                <input type="text"  name="options[option7]" value="{$default.option7}" class="inp" style="width:250px;"/>
                            </td>
                        </tr>
                         <tr>
                            <td>
                                <b class="fs11">SOA Refresh</b><br/>
                                Default: <input type="text"  name="options[option8]" value="{if $default.option8!=''}{$default.option8}{else}{$options.option8.default}{/if}" class="inp" style="width:80px;"/>
                               Minimum: <input type="text"  name="options[option9]" value="{if $default.option9!=''}{$default.option9}{else}{$options.option9.default}{/if}" class="inp" style="width:80px;"/>
                            </td>
                        </tr>
                         <tr>
                            <td>
                                <b class="fs11">SOA Retry</b><br/>
                                Default: <input type="text"  name="options[option10]" value="{if $default.option10!=''}{$default.option10}{else}{$options.option10.default}{/if}" class="inp" style="width:80px;"/>
                                Minimum: <input type="text"  name="options[option11]" value="{if $default.option11!=''}{$default.option11}{else}{$options.option11.default}{/if}" class="inp" style="width:80px;"/>
                            </td>
                        </tr>
                         <tr>
                            <td>
                                <b class="fs11">SOA Expire</b><br/>
                                Default: <input type="text"  name="options[option12]" value="{if $default.option12!=''}{$default.option12}{else}{$options.option12.default}{/if}" class="inp" style="width:80px;"/>
                                Minimum: <input type="text"  name="options[option13]" value="{if $default.option13!=''}{$default.option13}{else}{$options.option13.default}{/if}" class="inp" style="width:80px;"/>
                            </td>
                        </tr>
                         <tr>
                            <td>
                                <b class="fs11">SOA TTL</b><br/>
                                Default: <input type="text"  name="options[option14]" value="{if $default.option14!=''}{$default.option14}{else}{$options.option14.default}{/if}" class="inp" style="width:80px;"/>
                                Minimum: <input type="text"  name="options[option15]" value="{if $default.option15!=''}{$default.option15}{else}{$options.option15.default}{/if}" class="inp" style="width:80px;"/>
                            </td>
                        </tr>
                    </table>
                </td>
                <td ></td>
                <td valign="top" style="padding:10px;" class="sectionbody">
                    <table border="0" cellspacing="0" cellpadding="3" width="100%">
                        <tr>
                            <td>
                                <table>
                                    <tr>
                                        <td>
                                            <b class="fs11">Nameserver 1:</b><br/>
                                            <input type="text"  name="options[option2]" value="{$default.option2}" class="inp" style="width:250px;"/>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td>
                                            <b class="fs11">Nameserver 1 IP:</b><br/>
                                            <input type="text"  name="options[option20]" value="{$default.option20}" class="inp" style="width:250px;"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <b class="fs11">Nameserver 2:</b><br/>
                                            <input type="text"  name="options[option3]" value="{$default.option3}" class="inp" style="width:250px;"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <b class="fs11">Nameserver 2 IP:</b><br/>
                                            <input type="text"  name="options[option30]" value="{$default.option30}" class="inp" style="width:250px;"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <b class="fs11">Nameserver 3:</b><br/>
                                            <input type="text"  name="options[option4]" value="{$default.option4}" class="inp" style="width:250px;"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <b class="fs11">Nameserver 3 IP:</b><br/>
                                            <input type="text"  name="options[option40]" value="{$default.option40}" class="inp" style="width:250px;"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <b class="fs11">Nameserver 4:</b><br/>
                                            <input type="text"  name="options[option5]" value="{$default.option5}" class="inp" style="width:250px;"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <b class="fs11">Nameserver 4 IP:</b><br/>
                                            <input type="text"  name="options[option50]" value="{$default.option50}" class="inp" style="width:250px;"/>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td>
                                <table>
                                    <tr>
                                        <td>
                                            <b class="fs11">Nameserver 5:</b><br/>
                                            <input type="text"  name="options[option26]" value="{$default.option26}" class="inp" style="width:250px;"/>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td>
                                            <b class="fs11">Nameserver 5 IP:</b><br/>
                                            <input type="text"  name="options[option60]" value="{$default.option60}" class="inp" style="width:250px;"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <b class="fs11">Nameserver 6:</b><br/>
                                            <input type="text"  name="options[option27]" value="{$default.option27}" class="inp" style="width:250px;"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <b class="fs11">Nameserver 6 IP:</b><br/>
                                            <input type="text"  name="options[option70]" value="{$default.option70}" class="inp" style="width:250px;"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <b class="fs11">Nameserver 7:</b><br/>
                                            <input type="text"  name="options[option28]" value="{$default.option28}" class="inp" style="width:250px;"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <b class="fs11">Nameserver 7 IP:</b><br/>
                                            <input type="text"  name="options[option80]" value="{$default.option80}" class="inp" style="width:250px;"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <b class="fs11">Nameserver 8:</b><br/>
                                            <input type="text"  name="options[option29]" value="{$default.option29}" class="inp" style="width:250px;"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <b class="fs11">Nameserver 8 IP:</b><br/>
                                            <input type="text"  name="options[option90]" value="{$default.option90}" class="inp" style="width:250px;"/>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        {literal}
        <script type="text/javascript">
            $(function(){
                var select = $('#dnstpl_select'),
                    val = select.val();
                select.children(':first-child').nextAll().remove();
                $('#dns_list li[id^=tpl_]').filter(function(){return !$(this).attr('id').match('tpl_n')}).each(function(){
                    var tpl = $(this),
                        id = tpl.attr('id').replace('tpl_',''),
                        name = tpl.find('.template_name span').text();
                    select.append('<option value="'+id+'">'+name+'</option>');
                });
                select.val(val);
            })
        </script>
        {/literal}
    </td>
</tr>
{literal}
    <script>
        $(function () {
            $("a.vtip_description").not('.vtip_applied').vTip();
            bindAppWithForms();
        });
        $('#records').chosenedge({
            enable_split_word_search: true,
            search_contains: true,
            width: '100%'
        }).on('change', function () {
            var select = $(this),
                values = select.val();

            select.val(values).trigger('chosen:updated');
        });
    </script>
{/literal}