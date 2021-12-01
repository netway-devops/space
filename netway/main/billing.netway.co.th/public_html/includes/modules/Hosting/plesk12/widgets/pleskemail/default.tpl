
<div >
    <div id="billing_info" class="wbox">
        <div class="wbox_header">{if $lang[$widget.name]}{$lang[$widget.name]}{elseif $widget.fullname}{$widget.fullname}{else}{$widget.name}{/if}</div>
        <div class="wbox_content">
            <form autocomplete="off" action="{$widget_url}&act={$act}" method="post">
                <table class="checker table table-striped" width="100%" cellspacing="0" cellpadding="0" border="0">
                    {counter start=1 skip=1 assign=even}
                    <thead>
                    <tr {counter}{if $even % 2 !=0}class="even"{/if} >
                        <td align="right">{$lang.account}</td>
                        <td align="center" style="width: 65px;">{$lang.usage}</td>
                        <td align="center">{$lang.managementfunctions}</a></td>
                    </tr>
                    </thead>
                    <tbody id="updater">
                    {if $listentrys}
                        {foreach from=$listentrys item=entry key=index}
                            <tr {counter}{if $even % 2 !=0}class="even"{/if}>
                                <td align="right">{$entry.email}</td>
                                <td align="center">
                                    <div>{$entry.quota.usage}/{$entry.quota.limit|filesize}</div>
                                    <div style="width:80%; height:8px; border:solid 1px #aaa; text-align:left; overflow:hidden">
                                        <div style="height:100%; width:{$entry.quota.percent}%; background-color:{if $entry.quota.percent < 50}#8FFF00{elseif $entry.quota.percent < 80}yellow{else}#FF4F4F{/if}; border"></div>
                                    </div>
                                </td>
                                <td align="center" class="eml_management_links">
                                    <a href="{$widget_url}&act={$act}#chang">{$lang.changepass}</a> |
                                    <a href="{$widget_url}&act={$act}#chang">{$lang.changequota}</a> |
                                    <a href="{$widget_url}&act={$act}#chang">{if $lang.plesk_changeforwarding}{$lang.plesk_changeforwarding}{else}Email Forward Setup{/if}</a> |
                                    <a href="{$widget_url}&act={$act}#chang">{if $lang.plesk_changealiases}{$lang.plesk_changealiases}{else}Email Aliases{/if}</a> |
                                    <a href="{$widget_url}&act={$act}#chang">{if $lang.plesk_changeautoreply}{$lang.plesk_changeautoreply}{else}Auto-Reply{/if}</a> |
                                    {*<a href="{$widget_url}&act={$act}#chang">{if $lang.changespamsettings}{$lang.changespamsettings}{else}Spam Settings{/if}</a> |*}
                                    <a href="{$widget_url}&act={$act}&deluser={$entry.id}&security_token={$security_token}"
                                       onclick="return confirm('{$lang.plesk_del_email}')">{$lang.delete}</a>
                                </td>

                            </tr>
                            <tr {if $even % 2 !=0}class="even"{/if} style="display:none">
                                <td align="right" ><input type="submit" name="savechange" value="{$lang.shortsave}" class="btn btn-primary"></td>
                                <td align="right" colspan="3" class="change_div">
                                    <input type="hidden" name="change[{$index}][user]" value="{$entry.login}">
                                    <input type="hidden" name="change[{$index}][domain]" value="{$entry.domain}">
                                    <input type="hidden" name="change[{$index}][oldquota]" value="{$entry.quota.limit}">
                                    <label class="label_row"><span class="column1">{$lang.quota}:</span>
                                        <span class="column2">
                                            {if $email_quota}
                                                <select name="change[{$index}][quota]" class="email_quota">
                                                    {if $entry.quota.limit|in_array:$email_quota || $entry.quota.limit == '∞'}
                                                        {foreach from=$email_quota item=quota}
                                                            {if $quota == 'custom'}
                                                                <option value="custom" >{$lang.custom}</option>
                                                            {elseif $quota == 'unlimited'}
                                                                <option value="-1" {if $entry.quota.limit == '∞'}selected="selected"{/if}>{$lang.unlimited}</option>
                                                            {else}
                                                                <option value="{$quota}" {if $entry.quota.limit == $quota && $entry.quota.limit != '-1'}selected="selected"{/if}>{if is_numeric($quota)}{$quota|filesize}{else}{$quota}{/if}</option>
                                                            {/if}
                                                        {/foreach}
                                                    {else}
                                                        {foreach from=$email_quota item=quota}
                                                        {if $quota == 'custom'}
                                                            <option value="custom" >{$lang.custom}</option>
                                                        {elseif $quota == 'unlimited'}
                                                            <option value="-1" {if $entry.quota.limit == '∞'}selected="selected"{/if}>{$lang.unlimited}</option>
                                                        {else}
                                                            <option value="{$quota}">{if is_numeric($quota)}{$quota|filesize}{else}{$quota}{/if}</option>
                                                        {/if}
                                                    {/foreach}
                                                            {if $entry.quota.limit != '∞'}
                                                                <option value="{$entry.quota.limit}" selected="selected">{$entry.quota.limit} {$lang.mb}</option>
                                                            {/if}
                                                    {/if}
                                                </select>
                                            {else}
                                                <select name="change[{$index}][quota]" class="email_quota">
                                                {if ($entry.quota.limit != 20) && ($entry.quota.limit != 50) && ($entry.quota.limit != 100) && ($entry.quota.limit != 250) && ($entry.quota.limit != 'unlimited')}<option value="{$entry.quota.limit}" selected="selected">{$entry.quota.limit} {$lang.mb}</option>{/if}
                                                <option value="20" {if $entry.quota.limit == 20}selected="selected"{/if}>20 {$lang.mb}</option>
                                                <option value="50" {if $entry.quota.limit == 50}selected="selected"{/if}>50 {$lang.mb}</option>
                                                <option value="100" {if $entry.quota.limit == 100}selected="selected"{/if}>100 {$lang.mb}</option>
                                                <option value="250" {if $entry.quota.limit == 250}selected="selected"{/if}>250 {$lang.mb}</option>
                                                </select>
                                            {/if}
                                        </span>
                                    </label>
                                </td>
                                <td class="change_div" align="right" colspan="3">
                                    <label class="label_row"><span class="column1">{$lang.password}:</span>
                                        <span class="column2"><input autocomplete="off" type="password" name="change[{$index}][passmain]" class="span2"></span>
                                    </label>
                                    <label class="label_row"><span class="column1">{$lang.confirmpassword}:</span>
                                        <span class="column2"><input autocomplete="off" type="password" name="change[{$index}][passcheck]" class="span2"></span>
                                    </label>

                                </td>
                                <td class="change_div" colspan="3">
                                    <input type="hidden" name="change[{$index}][oldforwarding]" value="{$entry.forwarding.enabled|escape}">
                                    <input type="hidden" name="change[{$index}][oldforwardingtext]" value="{$entry.forwarding.address|escape}">
                                    <label class="checkbox">
                                        <input id="check_forwarding" type="checkbox" name="change[{$index}][check-forwarding]" {if $entry.forwarding.enabled == 1}checked{/if}><span class="f-span">{if $lang.plesk_switchmailforwarding}{$lang.plesk_switchmailforwarding}{else}Switch on mail forwarding{/if}</span>
                                    </label>
                                    <br>
                                    <textarea id="text_forwarding" rows="3" name="change[{$index}][text-forwarding]" class="f-textarea">{$entry.forwarding.address|escape}</textarea>{if $lang.plesk_forwardinfo}{$lang.plesk_forwardinfo}{else}<span>Specify email addresses. You can type each address on a new line, or separate addresses with white spaces, commas, or semicolons.</span>{/if}
                                </td>
                                <td class="change_div" colspan="3">
                                    <label>{if $lang.emailalias}{$lang.emailalias}{else}Email alias{/if}</label>:<br>
                                    {if is_array($entry.alias)}
                                        {foreach from=$entry.alias item=alias key=key}
                                            <input type="hidden" name="change[{$index}][oldalias][{$key}]" value="{$alias|escape}">
                                            <label>
                                                <input type="text" name="change[{$index}][newalias][{$key}]" value="{$alias|escape}">@{$entry.domain}
                                                {if $key != 0}<a class="alias_remove" onclick="$(this).parent().remove();" data-key="{$key}">{$lang.remove}</a>{/if}
                                            </label>
                                        {/foreach}
                                    {else}
                                        <input type="hidden" name="change[{$index}][oldalias][0]" value="{$alias|escape}">
                                        <label>
                                            <input type="text" name="change[{$index}][newalias][0]" value="{$entry.alias|escape}">@{$entry.domain}
                                        </label>
                                    {/if}
                                    <div id="alias_content">
                                    </div>
                                    <input id="add_alias" type="button" class="btn btn-success" value="{$lang.add_alias}" data-domain="{$entry.domain}" data-index="{$index}" data-key="{$entry.alias|@count}">
                                </td>
                                <td class="change_div" colspan="3">
                                    <input type="hidden" name="change[{$index}][old-autoreply][enabled]" value="{$entry.autoresponder.enabled|escape}">
                                    <input type="hidden" name="change[{$index}][old-autoreply][subject]" value="{$entry.autoresponder.subject|escape}">
                                    <input type="hidden" name="change[{$index}][old-autoreply][content_type]" value="{$entry.autoresponder.content_type|escape}">
                                    <input id="a_charset" type="hidden" name="change[{$index}][old-autoreply][charset]" value="{$entry.autoresponder.charset|escape}">
                                    <input type="hidden" name="change[{$index}][old-autoreply][text]" value="{$entry.autoresponder.text|escape}">
                                    <input type="hidden" name="change[{$index}][old-autoreply][forward]" value="{$entry.autoresponder.forward|escape}">
                                    {*<input type="hidden" name="change[{$index}][old-autoreply][end-check]" value="{if $entry.autoresponder.end_date}on{else}off{/if}">*}
                                    {*<input type="hidden" name="change[{$index}][old-autoreply][end_date]" value="{$entry.autoresponder.end_date}">*}
                                    <label class="checkbox">
                                        <input id="check_autoreply" type="checkbox" name="change[{$index}][autoreply][enabled]" {if $entry.autoresponder.enabled == 'true'}checked{/if}><span class="f-span">{if $lang.plesk_switchautoreply}{$lang.plesk_switchautoreply}{else}Switch on auto-reply{/if}</span>
                                    </label><br><br>
                                    <label class="label_row">
                                        <span class="column1">{$lang.subject}:</span>
                                        <span class="column2"><input class="content_autoreply" type="text" name="change[{$index}][autoreply][subject]" value="{$entry.autoresponder.subject|escape}"></span>
                                    </label><br>
                                    <label class="column1">{if $lang.plesk_messageformat}{$lang.plesk_messageformat}{else}Message format{/if}:</label>
                                    <label class="radio">
                                        <input class="content_autoreply" type="radio" name="change[{$index}][autoreply][content_type]" {if $entry.autoresponder.content_type == 'text/plain'}checked{/if} value="text/plain"> {$lang.plesk_plaintext}
                                    </label>
                                    <label class="radio">
                                        <input class="content_autoreply" type="radio" name="change[{$index}][autoreply][content_type]" {if $entry.autoresponder.content_type == 'text/html'}checked{/if} value="text/html"> HTML
                                    </label><br>
                                    <label class="label_row">
                                        <span class="column1">{if $lang.plesk_encoding}{$lang.plesk_encoding}{else}Encoding{/if}:</span>
                                        <span class="column2"><select class="content_autoreply" id="autoreply_charset" name="change[{$index}][autoreply][charset]">
                                                <option value="437">437</option>
                                                <option value="500">500</option>
                                                <option value="500V1">500V1</option>
                                                <option value="850">850</option>
                                                <option value="851">851</option>
                                                <option value="852">852</option>
                                                <option value="855">855</option>
                                                <option value="856">856</option>
                                                <option value="857">857</option>
                                                <option value="860">860</option>
                                                <option value="861">861</option>
                                                <option value="862">862</option>
                                                <option value="863">863</option>
                                                <option value="864">864</option>
                                                <option value="865">865</option>
                                                <option value="866">866</option>
                                                <option value="866NAV">866NAV</option>
                                                <option value="869">869</option>
                                                <option value="874">874</option>
                                                <option value="904">904</option>
                                                <option value="1026">1026</option>
                                                <option value="1046">1046</option>
                                                <option value="1047">1047</option>
                                                <option value="8859_1">8859_1</option>
                                                <option value="8859_2">8859_2</option>
                                                <option value="8859_3">8859_3</option>
                                                <option value="8859_4">8859_4</option>
                                                <option value="8859_5">8859_5</option>
                                                <option value="8859_6">8859_6</option>
                                                <option value="8859_7">8859_7</option>
                                                <option value="8859_8">8859_8</option>
                                                <option value="8859_9">8859_9</option>
                                                <option value="10646-1:1993">10646-1:1993</option>
                                                <option value="10646-1:1993/UCS4">10646-1:1993/UCS4</option>
                                                <option value="ANSI_X3.4-1968">ANSI_X3.4-1968</option>
                                                <option value="ANSI_X3.4-1986">ANSI_X3.4-1986</option>
                                                <option value="ANSI_X3.4">ANSI_X3.4</option>
                                                <option value="ANSI_X3.110-1983">ANSI_X3.110-1983</option>
                                                <option value="ANSI_X3.110">ANSI_X3.110</option>
                                                <option value="ARABIC">ARABIC</option>
                                                <option value="ARABIC7">ARABIC7</option>
                                                <option value="ARMSCII-8">ARMSCII-8</option>
                                                <option value="ASCII">ASCII</option>
                                                <option value="ASMO-708">ASMO-708</option>
                                                <option value="ASMO_449">ASMO_449</option>
                                                <option value="BALTIC">BALTIC</option>
                                                <option value="BIG-5">BIG-5</option>
                                                <option value="BIG-FIVE">BIG-FIVE</option>
                                                <option value="BIG5-HKSCS">BIG5-HKSCS</option>
                                                <option value="BIG5">BIG5</option>
                                                <option value="BIG5HKSCS">BIG5HKSCS</option>
                                                <option value="BIGFIVE">BIGFIVE</option>
                                                <option value="BS_4730">BS_4730</option>
                                                <option value="CA">CA</option>
                                                <option value="CN-BIG5">CN-BIG5</option>
                                                <option value="CN-GB">CN-GB</option>
                                                <option value="CN">CN</option>
                                                <option value="CP-AR">CP-AR</option>
                                                <option value="CP-GR">CP-GR</option>
                                                <option value="CP-HU">CP-HU</option>
                                                <option value="CP037">CP037</option>
                                                <option value="CP038">CP038</option>
                                                <option value="CP273">CP273</option>
                                                <option value="CP274">CP274</option>
                                                <option value="CP275">CP275</option>
                                                <option value="CP278">CP278</option>
                                                <option value="CP280">CP280</option>
                                                <option value="CP281">CP281</option>
                                                <option value="CP282">CP282</option>
                                                <option value="CP284">CP284</option>
                                                <option value="CP285">CP285</option>
                                                <option value="CP290">CP290</option>
                                                <option value="CP297">CP297</option>
                                                <option value="CP367">CP367</option>
                                                <option value="CP420">CP420</option>
                                                <option value="CP423">CP423</option>
                                                <option value="CP424">CP424</option>
                                                <option value="CP437">CP437</option>
                                                <option value="CP500">CP500</option>
                                                <option value="CP737">CP737</option>
                                                <option value="CP775">CP775</option>
                                                <option value="CP813">CP813</option>
                                                <option value="CP819">CP819</option>
                                                <option value="CP850">CP850</option>
                                                <option value="CP851">CP851</option>
                                                <option value="CP852">CP852</option>
                                                <option value="CP855">CP855</option>
                                                <option value="CP856">CP856</option>
                                                <option value="CP857">CP857</option>
                                                <option value="CP860">CP860</option>
                                                <option value="CP861">CP861</option>
                                                <option value="CP862">CP862</option>
                                                <option value="CP863">CP863</option>
                                                <option value="CP864">CP864</option>
                                                <option value="CP865">CP865</option>
                                                <option value="CP866">CP866</option>
                                                <option value="CP866NAV">CP866NAV</option>
                                                <option value="CP868">CP868</option>
                                                <option value="CP869">CP869</option>
                                                <option value="CP870">CP870</option>
                                                <option value="CP871">CP871</option>
                                                <option value="CP874">CP874</option>
                                                <option value="CP875">CP875</option>
                                                <option value="CP880">CP880</option>
                                                <option value="CP891">CP891</option>
                                                <option value="CP903">CP903</option>
                                                <option value="CP904">CP904</option>
                                                <option value="CP905">CP905</option>
                                                <option value="CP912">CP912</option>
                                                <option value="CP915">CP915</option>
                                                <option value="CP916">CP916</option>
                                                <option value="CP918">CP918</option>
                                                <option value="CP920">CP920</option>
                                                <option value="CP922">CP922</option>
                                                <option value="CP930">CP930</option>
                                                <option value="CP932">CP932</option>
                                                <option value="CP933">CP933</option>
                                                <option value="CP935">CP935</option>
                                                <option value="CP936">CP936</option>
                                                <option value="CP937">CP937</option>
                                                <option value="CP939">CP939</option>
                                                <option value="CP949">CP949</option>
                                                <option value="CP950">CP950</option>
                                                <option value="CP1004">CP1004</option>
                                                <option value="CP1026">CP1026</option>
                                                <option value="CP1046">CP1046</option>
                                                <option value="CP1047">CP1047</option>
                                                <option value="CP1070">CP1070</option>
                                                <option value="CP1079">CP1079</option>
                                                <option value="CP1081">CP1081</option>
                                                <option value="CP1084">CP1084</option>
                                                <option value="CP1089">CP1089</option>
                                                <option value="CP1124">CP1124</option>
                                                <option value="CP1125">CP1125</option>
                                                <option value="CP1129">CP1129</option>
                                                <option value="CP1132">CP1132</option>
                                                <option value="CP1133">CP1133</option>
                                                <option value="CP1160">CP1160</option>
                                                <option value="CP1161">CP1161</option>
                                                <option value="CP1162">CP1162</option>
                                                <option value="CP1163">CP1163</option>
                                                <option value="CP1164">CP1164</option>
                                                <option value="CP1250">CP1250</option>
                                                <option value="CP1251">CP1251</option>
                                                <option value="CP1252">CP1252</option>
                                                <option value="CP1253">CP1253</option>
                                                <option value="CP1254">CP1254</option>
                                                <option value="CP1255">CP1255</option>
                                                <option value="CP1256">CP1256</option>
                                                <option value="CP1257">CP1257</option>
                                                <option value="CP1258">CP1258</option>
                                                <option value="CP1361">CP1361</option>
                                                <option value="CP10007">CP10007</option>
                                                <option value="CPIBM861">CPIBM861</option>
                                                <option value="CSA7-1">CSA7-1</option>
                                                <option value="CSA7-2">CSA7-2</option>
                                                <option value="CSASCII">CSASCII</option>
                                                <option value="CSA_T500-1983">CSA_T500-1983</option>
                                                <option value="CSA_T500">CSA_T500</option>
                                                <option value="CSA_Z243.4-1985-1">CSA_Z243.4-1985-1</option>
                                                <option value="CSA_Z243.4-1985-2">CSA_Z243.4-1985-2</option>
                                                <option value="CSA_Z243.419851">CSA_Z243.419851</option>
                                                <option value="CSA_Z243.419852">CSA_Z243.419852</option>
                                                <option value="CSDECMCS">CSDECMCS</option>
                                                <option value="CSEBCDICATDE">CSEBCDICATDE</option>
                                                <option value="CSEBCDICATDEA">CSEBCDICATDEA</option>
                                                <option value="CSEBCDICCAFR">CSEBCDICCAFR</option>
                                                <option value="CSEBCDICDKNO">CSEBCDICDKNO</option>
                                                <option value="CSEBCDICDKNOA">CSEBCDICDKNOA</option>
                                                <option value="CSEBCDICES">CSEBCDICES</option>
                                                <option value="CSEBCDICESA">CSEBCDICESA</option>
                                                <option value="CSEBCDICESS">CSEBCDICESS</option>
                                                <option value="CSEBCDICFISE">CSEBCDICFISE</option>
                                                <option value="CSEBCDICFISEA">CSEBCDICFISEA</option>
                                                <option value="CSEBCDICFR">CSEBCDICFR</option>
                                                <option value="CSEBCDICIT">CSEBCDICIT</option>
                                                <option value="CSEBCDICPT">CSEBCDICPT</option>
                                                <option value="CSEBCDICUK">CSEBCDICUK</option>
                                                <option value="CSEBCDICUS">CSEBCDICUS</option>
                                                <option value="CSEUCKR">CSEUCKR</option>
                                                <option value="CSEUCPKDFMTJAPANESE">CSEUCPKDFMTJAPANESE</option>
                                                <option value="CSGB2312">CSGB2312</option>
                                                <option value="CSHPROMAN8">CSHPROMAN8</option>
                                                <option value="CSIBM037">CSIBM037</option>
                                                <option value="CSIBM038">CSIBM038</option>
                                                <option value="CSIBM273">CSIBM273</option>
                                                <option value="CSIBM274">CSIBM274</option>
                                                <option value="CSIBM275">CSIBM275</option>
                                                <option value="CSIBM277">CSIBM277</option>
                                                <option value="CSIBM278">CSIBM278</option>
                                                <option value="CSIBM280">CSIBM280</option>
                                                <option value="CSIBM281">CSIBM281</option>
                                                <option value="CSIBM284">CSIBM284</option>
                                                <option value="CSIBM285">CSIBM285</option>
                                                <option value="CSIBM290">CSIBM290</option>
                                                <option value="CSIBM297">CSIBM297</option>
                                                <option value="CSIBM420">CSIBM420</option>
                                                <option value="CSIBM423">CSIBM423</option>
                                                <option value="CSIBM424">CSIBM424</option>
                                                <option value="CSIBM500">CSIBM500</option>
                                                <option value="CSIBM851">CSIBM851</option>
                                                <option value="CSIBM855">CSIBM855</option>
                                                <option value="CSIBM856">CSIBM856</option>
                                                <option value="CSIBM857">CSIBM857</option>
                                                <option value="CSIBM860">CSIBM860</option>
                                                <option value="CSIBM863">CSIBM863</option>
                                                <option value="CSIBM864">CSIBM864</option>
                                                <option value="CSIBM865">CSIBM865</option>
                                                <option value="CSIBM866">CSIBM866</option>
                                                <option value="CSIBM868">CSIBM868</option>
                                                <option value="CSIBM869">CSIBM869</option>
                                                <option value="CSIBM870">CSIBM870</option>
                                                <option value="CSIBM871">CSIBM871</option>
                                                <option value="CSIBM880">CSIBM880</option>
                                                <option value="CSIBM891">CSIBM891</option>
                                                <option value="CSIBM903">CSIBM903</option>
                                                <option value="CSIBM904">CSIBM904</option>
                                                <option value="CSIBM905">CSIBM905</option>
                                                <option value="CSIBM918">CSIBM918</option>
                                                <option value="CSIBM922">CSIBM922</option>
                                                <option value="CSIBM930">CSIBM930</option>
                                                <option value="CSIBM932">CSIBM932</option>
                                                <option value="CSIBM933">CSIBM933</option>
                                                <option value="CSIBM935">CSIBM935</option>
                                                <option value="CSIBM937">CSIBM937</option>
                                                <option value="CSIBM939">CSIBM939</option>
                                                <option value="CSIBM943">CSIBM943</option>
                                                <option value="CSIBM1026">CSIBM1026</option>
                                                <option value="CSIBM1124">CSIBM1124</option>
                                                <option value="CSIBM1129">CSIBM1129</option>
                                                <option value="CSIBM1132">CSIBM1132</option>
                                                <option value="CSIBM1133">CSIBM1133</option>
                                                <option value="CSIBM1160">CSIBM1160</option>
                                                <option value="CSIBM1161">CSIBM1161</option>
                                                <option value="CSIBM1163">CSIBM1163</option>
                                                <option value="CSIBM1164">CSIBM1164</option>
                                                <option value="CSIBM11621162">CSIBM11621162</option>
                                                <option value="CSISO4UNITEDKINGDOM">CSISO4UNITEDKINGDOM</option>
                                                <option value="CSISO10SWEDISH">CSISO10SWEDISH</option>
                                                <option value="CSISO11SWEDISHFORNAMES">CSISO11SWEDISHFORNAMES</option>
                                                <option value="CSISO14JISC6220RO">CSISO14JISC6220RO</option>
                                                <option value="CSISO15ITALIAN">CSISO15ITALIAN</option>
                                                <option value="CSISO16PORTUGESE">CSISO16PORTUGESE</option>
                                                <option value="CSISO17SPANISH">CSISO17SPANISH</option>
                                                <option value="CSISO18GREEK7OLD">CSISO18GREEK7OLD</option>
                                                <option value="CSISO19LATINGREEK">CSISO19LATINGREEK</option>
                                                <option value="CSISO21GERMAN">CSISO21GERMAN</option>
                                                <option value="CSISO25FRENCH">CSISO25FRENCH</option>
                                                <option value="CSISO27LATINGREEK1">CSISO27LATINGREEK1</option>
                                                <option value="CSISO49INIS">CSISO49INIS</option>
                                                <option value="CSISO50INIS8">CSISO50INIS8</option>
                                                <option value="CSISO51INISCYRILLIC">CSISO51INISCYRILLIC</option>
                                                <option value="CSISO58GB1988">CSISO58GB1988</option>
                                                <option value="CSISO60DANISHNORWEGIAN">CSISO60DANISHNORWEGIAN</option>
                                                <option value="CSISO60NORWEGIAN1">CSISO60NORWEGIAN1</option>
                                                <option value="CSISO61NORWEGIAN2">CSISO61NORWEGIAN2</option>
                                                <option value="CSISO69FRENCH">CSISO69FRENCH</option>
                                                <option value="CSISO84PORTUGUESE2">CSISO84PORTUGUESE2</option>
                                                <option value="CSISO85SPANISH2">CSISO85SPANISH2</option>
                                                <option value="CSISO86HUNGARIAN">CSISO86HUNGARIAN</option>
                                                <option value="CSISO88GREEK7">CSISO88GREEK7</option>
                                                <option value="CSISO89ASMO449">CSISO89ASMO449</option>
                                                <option value="CSISO90">CSISO90</option>
                                                <option value="CSISO92JISC62991984B">CSISO92JISC62991984B</option>
                                                <option value="CSISO99NAPLPS">CSISO99NAPLPS</option>
                                                <option value="CSISO103T618BIT">CSISO103T618BIT</option>
                                                <option value="CSISO111ECMACYRILLIC">CSISO111ECMACYRILLIC</option>
                                                <option value="CSISO121CANADIAN1">CSISO121CANADIAN1</option>
                                                <option value="CSISO122CANADIAN2">CSISO122CANADIAN2</option>
                                                <option value="CSISO139CSN369103">CSISO139CSN369103</option>
                                                <option value="CSISO141JUSIB1002">CSISO141JUSIB1002</option>
                                                <option value="CSISO143IECP271">CSISO143IECP271</option>
                                                <option value="CSISO150">CSISO150</option>
                                                <option value="CSISO150GREEKCCITT">CSISO150GREEKCCITT</option>
                                                <option value="CSISO151CUBA">CSISO151CUBA</option>
                                                <option value="CSISO153GOST1976874">CSISO153GOST1976874</option>
                                                <option value="CSISO646DANISH">CSISO646DANISH</option>
                                                <option value="CSISO2022CN">CSISO2022CN</option>
                                                <option value="CSISO2022JP">CSISO2022JP</option>
                                                <option value="CSISO2022JP2">CSISO2022JP2</option>
                                                <option value="CSISO2022KR">CSISO2022KR</option>
                                                <option value="CSISO2033">CSISO2033</option>
                                                <option value="CSISO5427CYRILLIC">CSISO5427CYRILLIC</option>
                                                <option value="CSISO5427CYRILLIC1981">CSISO5427CYRILLIC1981</option>
                                                <option value="CSISO5428GREEK">CSISO5428GREEK</option>
                                                <option value="CSISO10367BOX">CSISO10367BOX</option>
                                                <option value="CSISOLATIN1">CSISOLATIN1</option>
                                                <option value="CSISOLATIN2">CSISOLATIN2</option>
                                                <option value="CSISOLATIN3">CSISOLATIN3</option>
                                                <option value="CSISOLATIN4">CSISOLATIN4</option>
                                                <option value="CSISOLATIN5">CSISOLATIN5</option>
                                                <option value="CSISOLATIN6">CSISOLATIN6</option>
                                                <option value="CSISOLATINARABIC">CSISOLATINARABIC</option>
                                                <option value="CSISOLATINCYRILLIC">CSISOLATINCYRILLIC</option>
                                                <option value="CSISOLATINGREEK">CSISOLATINGREEK</option>
                                                <option value="CSISOLATINHEBREW">CSISOLATINHEBREW</option>
                                                <option value="CSKOI8R">CSKOI8R</option>
                                                <option value="CSKSC5636">CSKSC5636</option>
                                                <option value="CSMACINTOSH">CSMACINTOSH</option>
                                                <option value="CSNATSDANO">CSNATSDANO</option>
                                                <option value="CSNATSSEFI">CSNATSSEFI</option>
                                                <option value="CSN_369103">CSN_369103</option>
                                                <option value="CSPC8CODEPAGE437">CSPC8CODEPAGE437</option>
                                                <option value="CSPC775BALTIC">CSPC775BALTIC</option>
                                                <option value="CSPC850MULTILINGUAL">CSPC850MULTILINGUAL</option>
                                                <option value="CSPC862LATINHEBREW">CSPC862LATINHEBREW</option>
                                                <option value="CSPCP852">CSPCP852</option>
                                                <option value="CSSHIFTJIS">CSSHIFTJIS</option>
                                                <option value="CSUCS4">CSUCS4</option>
                                                <option value="CSUNICODE">CSUNICODE</option>
                                                <option value="CSWINDOWS31J">CSWINDOWS31J</option>
                                                <option value="CUBA">CUBA</option>
                                                <option value="CWI-2">CWI-2</option>
                                                <option value="CWI">CWI</option>
                                                <option value="CYRILLIC">CYRILLIC</option>
                                                <option value="DE">DE</option>
                                                <option value="DEC-MCS">DEC-MCS</option>
                                                <option value="DEC">DEC</option>
                                                <option value="DECMCS">DECMCS</option>
                                                <option value="DIN_66003">DIN_66003</option>
                                                <option value="DK">DK</option>
                                                <option value="DS2089">DS2089</option>
                                                <option value="DS_2089">DS_2089</option>
                                                <option value="E13B">E13B</option>
                                                <option value="EBCDIC-AT-DE-A">EBCDIC-AT-DE-A</option>
                                                <option value="EBCDIC-AT-DE">EBCDIC-AT-DE</option>
                                                <option value="EBCDIC-BE">EBCDIC-BE</option>
                                                <option value="EBCDIC-BR">EBCDIC-BR</option>
                                                <option value="EBCDIC-CA-FR">EBCDIC-CA-FR</option>
                                                <option value="EBCDIC-CP-AR1">EBCDIC-CP-AR1</option>
                                                <option value="EBCDIC-CP-AR2">EBCDIC-CP-AR2</option>
                                                <option value="EBCDIC-CP-BE">EBCDIC-CP-BE</option>
                                                <option value="EBCDIC-CP-CA">EBCDIC-CP-CA</option>
                                                <option value="EBCDIC-CP-CH">EBCDIC-CP-CH</option>
                                                <option value="EBCDIC-CP-DK">EBCDIC-CP-DK</option>
                                                <option value="EBCDIC-CP-ES">EBCDIC-CP-ES</option>
                                                <option value="EBCDIC-CP-FI">EBCDIC-CP-FI</option>
                                                <option value="EBCDIC-CP-FR">EBCDIC-CP-FR</option>
                                                <option value="EBCDIC-CP-GB">EBCDIC-CP-GB</option>
                                                <option value="EBCDIC-CP-GR">EBCDIC-CP-GR</option>
                                                <option value="EBCDIC-CP-HE">EBCDIC-CP-HE</option>
                                                <option value="EBCDIC-CP-IS">EBCDIC-CP-IS</option>
                                                <option value="EBCDIC-CP-IT">EBCDIC-CP-IT</option>
                                                <option value="EBCDIC-CP-NL">EBCDIC-CP-NL</option>
                                                <option value="EBCDIC-CP-NO">EBCDIC-CP-NO</option>
                                                <option value="EBCDIC-CP-ROECE">EBCDIC-CP-ROECE</option>
                                                <option value="EBCDIC-CP-SE">EBCDIC-CP-SE</option>
                                                <option value="EBCDIC-CP-TR">EBCDIC-CP-TR</option>
                                                <option value="EBCDIC-CP-US">EBCDIC-CP-US</option>
                                                <option value="EBCDIC-CP-WT">EBCDIC-CP-WT</option>
                                                <option value="EBCDIC-CP-YU">EBCDIC-CP-YU</option>
                                                <option value="EBCDIC-CYRILLIC">EBCDIC-CYRILLIC</option>
                                                <option value="EBCDIC-DK-NO-A">EBCDIC-DK-NO-A</option>
                                                <option value="EBCDIC-DK-NO">EBCDIC-DK-NO</option>
                                                <option value="EBCDIC-ES-A">EBCDIC-ES-A</option>
                                                <option value="EBCDIC-ES-S">EBCDIC-ES-S</option>
                                                <option value="EBCDIC-ES">EBCDIC-ES</option>
                                                <option value="EBCDIC-FI-SE-A">EBCDIC-FI-SE-A</option>
                                                <option value="EBCDIC-FI-SE">EBCDIC-FI-SE</option>
                                                <option value="EBCDIC-FR">EBCDIC-FR</option>
                                                <option value="EBCDIC-GREEK">EBCDIC-GREEK</option>
                                                <option value="EBCDIC-INT">EBCDIC-INT</option>
                                                <option value="EBCDIC-INT1">EBCDIC-INT1</option>
                                                <option value="EBCDIC-IS-FRISS">EBCDIC-IS-FRISS</option>
                                                <option value="EBCDIC-IT">EBCDIC-IT</option>
                                                <option value="EBCDIC-JP-E">EBCDIC-JP-E</option>
                                                <option value="EBCDIC-JP-KANA">EBCDIC-JP-KANA</option>
                                                <option value="EBCDIC-PT">EBCDIC-PT</option>
                                                <option value="EBCDIC-UK">EBCDIC-UK</option>
                                                <option value="EBCDIC-US">EBCDIC-US</option>
                                                <option value="EBCDICATDE">EBCDICATDE</option>
                                                <option value="EBCDICATDEA">EBCDICATDEA</option>
                                                <option value="EBCDICCAFR">EBCDICCAFR</option>
                                                <option value="EBCDICDKNO">EBCDICDKNO</option>
                                                <option value="EBCDICDKNOA">EBCDICDKNOA</option>
                                                <option value="EBCDICES">EBCDICES</option>
                                                <option value="EBCDICESA">EBCDICESA</option>
                                                <option value="EBCDICESS">EBCDICESS</option>
                                                <option value="EBCDICFISE">EBCDICFISE</option>
                                                <option value="EBCDICFISEA">EBCDICFISEA</option>
                                                <option value="EBCDICFR">EBCDICFR</option>
                                                <option value="EBCDICISFRISS">EBCDICISFRISS</option>
                                                <option value="EBCDICIT">EBCDICIT</option>
                                                <option value="EBCDICPT">EBCDICPT</option>
                                                <option value="EBCDICUK">EBCDICUK</option>
                                                <option value="EBCDICUS">EBCDICUS</option>
                                                <option value="ECMA-114">ECMA-114</option>
                                                <option value="ECMA-118">ECMA-118</option>
                                                <option value="ECMA-128">ECMA-128</option>
                                                <option value="ECMA-CYRILLIC">ECMA-CYRILLIC</option>
                                                <option value="ECMACYRILLIC">ECMACYRILLIC</option>
                                                <option value="ELOT_928">ELOT_928</option>
                                                <option value="ES">ES</option>
                                                <option value="ES2">ES2</option>
                                                <option value="EUC-CN">EUC-CN</option>
                                                <option value="EUC-JISX0213">EUC-JISX0213</option>
                                                <option value="EUC-JP-MS">EUC-JP-MS</option>
                                                <option value="EUC-JP">EUC-JP</option>
                                                <option value="EUC-KR">EUC-KR</option>
                                                <option value="EUC-TW">EUC-TW</option>
                                                <option value="EUCCN">EUCCN</option>
                                                <option value="EUCJP-MS">EUCJP-MS</option>
                                                <option value="EUCJP-OPEN">EUCJP-OPEN</option>
                                                <option value="EUCJP-WIN">EUCJP-WIN</option>
                                                <option value="EUCJP">EUCJP</option>
                                                <option value="EUCKR">EUCKR</option>
                                                <option value="EUCTW">EUCTW</option>
                                                <option value="FI">FI</option>
                                                <option value="FR">FR</option>
                                                <option value="GB">GB</option>
                                                <option value="GB2312">GB2312</option>
                                                <option value="GB13000">GB13000</option>
                                                <option value="GB18030">GB18030</option>
                                                <option value="GBK">GBK</option>
                                                <option value="GB_1988-80">GB_1988-80</option>
                                                <option value="GB_198880">GB_198880</option>
                                                <option value="GEORGIAN-ACADEMY">GEORGIAN-ACADEMY</option>
                                                <option value="GEORGIAN-PS">GEORGIAN-PS</option>
                                                <option value="GOST_19768-74">GOST_19768-74</option>
                                                <option value="GOST_19768">GOST_19768</option>
                                                <option value="GOST_1976874">GOST_1976874</option>
                                                <option value="GREEK-CCITT">GREEK-CCITT</option>
                                                <option value="GREEK">GREEK</option>
                                                <option value="GREEK7-OLD">GREEK7-OLD</option>
                                                <option value="GREEK7">GREEK7</option>
                                                <option value="GREEK7OLD">GREEK7OLD</option>
                                                <option value="GREEK8">GREEK8</option>
                                                <option value="GREEKCCITT">GREEKCCITT</option>
                                                <option value="HEBREW">HEBREW</option>
                                                <option value="HP-ROMAN8">HP-ROMAN8</option>
                                                <option value="HPROMAN8">HPROMAN8</option>
                                                <option value="HU">HU</option>
                                                <option value="IBM-856">IBM-856</option>
                                                <option value="IBM-922">IBM-922</option>
                                                <option value="IBM-930">IBM-930</option>
                                                <option value="IBM-932">IBM-932</option>
                                                <option value="IBM-933">IBM-933</option>
                                                <option value="IBM-935">IBM-935</option>
                                                <option value="IBM-937">IBM-937</option>
                                                <option value="IBM-939">IBM-939</option>
                                                <option value="IBM-943">IBM-943</option>
                                                <option value="IBM-1046">IBM-1046</option>
                                                <option value="IBM-1047">IBM-1047</option>
                                                <option value="IBM-1124">IBM-1124</option>
                                                <option value="IBM-1129">IBM-1129</option>
                                                <option value="IBM-1132">IBM-1132</option>
                                                <option value="IBM-1133">IBM-1133</option>
                                                <option value="IBM-1160">IBM-1160</option>
                                                <option value="IBM-1161">IBM-1161</option>
                                                <option value="IBM-1162">IBM-1162</option>
                                                <option value="IBM-1163">IBM-1163</option>
                                                <option value="IBM-1164">IBM-1164</option>
                                                <option value="IBM037">IBM037</option>
                                                <option value="IBM038">IBM038</option>
                                                <option value="IBM256">IBM256</option>
                                                <option value="IBM273">IBM273</option>
                                                <option value="IBM274">IBM274</option>
                                                <option value="IBM275">IBM275</option>
                                                <option value="IBM277">IBM277</option>
                                                <option value="IBM278">IBM278</option>
                                                <option value="IBM280">IBM280</option>
                                                <option value="IBM281">IBM281</option>
                                                <option value="IBM284">IBM284</option>
                                                <option value="IBM285">IBM285</option>
                                                <option value="IBM290">IBM290</option>
                                                <option value="IBM297">IBM297</option>
                                                <option value="IBM367">IBM367</option>
                                                <option value="IBM420">IBM420</option>
                                                <option value="IBM423">IBM423</option>
                                                <option value="IBM424">IBM424</option>
                                                <option value="IBM437">IBM437</option>
                                                <option value="IBM500">IBM500</option>
                                                <option value="IBM775">IBM775</option>
                                                <option value="IBM813">IBM813</option>
                                                <option value="IBM819">IBM819</option>
                                                <option value="IBM848">IBM848</option>
                                                <option value="IBM850">IBM850</option>
                                                <option value="IBM851">IBM851</option>
                                                <option value="IBM852">IBM852</option>
                                                <option value="IBM855">IBM855</option>
                                                <option value="IBM856">IBM856</option>
                                                <option value="IBM857">IBM857</option>
                                                <option value="IBM860">IBM860</option>
                                                <option value="IBM861">IBM861</option>
                                                <option value="IBM862">IBM862</option>
                                                <option value="IBM863">IBM863</option>
                                                <option value="IBM864">IBM864</option>
                                                <option value="IBM865">IBM865</option>
                                                <option value="IBM866">IBM866</option>
                                                <option value="IBM866NAV">IBM866NAV</option>
                                                <option value="IBM868">IBM868</option>
                                                <option value="IBM869">IBM869</option>
                                                <option value="IBM870">IBM870</option>
                                                <option value="IBM871">IBM871</option>
                                                <option value="IBM874">IBM874</option>
                                                <option value="IBM875">IBM875</option>
                                                <option value="IBM880">IBM880</option>
                                                <option value="IBM891">IBM891</option>
                                                <option value="IBM903">IBM903</option>
                                                <option value="IBM904">IBM904</option>
                                                <option value="IBM905">IBM905</option>
                                                <option value="IBM912">IBM912</option>
                                                <option value="IBM915">IBM915</option>
                                                <option value="IBM916">IBM916</option>
                                                <option value="IBM918">IBM918</option>
                                                <option value="IBM920">IBM920</option>
                                                <option value="IBM922">IBM922</option>
                                                <option value="IBM930">IBM930</option>
                                                <option value="IBM932">IBM932</option>
                                                <option value="IBM933">IBM933</option>
                                                <option value="IBM935">IBM935</option>
                                                <option value="IBM937">IBM937</option>
                                                <option value="IBM939">IBM939</option>
                                                <option value="IBM943">IBM943</option>
                                                <option value="IBM1004">IBM1004</option>
                                                <option value="IBM1026">IBM1026</option>
                                                <option value="IBM1046">IBM1046</option>
                                                <option value="IBM1047">IBM1047</option>
                                                <option value="IBM1089">IBM1089</option>
                                                <option value="IBM1124">IBM1124</option>
                                                <option value="IBM1129">IBM1129</option>
                                                <option value="IBM1132">IBM1132</option>
                                                <option value="IBM1133">IBM1133</option>
                                                <option value="IBM1160">IBM1160</option>
                                                <option value="IBM1161">IBM1161</option>
                                                <option value="IBM1162">IBM1162</option>
                                                <option value="IBM1163">IBM1163</option>
                                                <option value="IBM1164">IBM1164</option>
                                                <option value="IEC_P27-1">IEC_P27-1</option>
                                                <option value="IEC_P271">IEC_P271</option>
                                                <option value="INIS-8">INIS-8</option>
                                                <option value="INIS-CYRILLIC">INIS-CYRILLIC</option>
                                                <option value="INIS">INIS</option>
                                                <option value="INIS8">INIS8</option>
                                                <option value="INISCYRILLIC">INISCYRILLIC</option>
                                                <option value="ISIRI-3342">ISIRI-3342</option>
                                                <option value="ISIRI3342">ISIRI3342</option>
                                                <option value="ISO-2022-CN-EXT">ISO-2022-CN-EXT</option>
                                                <option value="ISO-2022-CN">ISO-2022-CN</option>
                                                <option value="ISO-2022-JP-2">ISO-2022-JP-2</option>
                                                <option value="ISO-2022-JP-3">ISO-2022-JP-3</option>
                                                <option value="ISO-2022-JP">ISO-2022-JP</option>
                                                <option value="ISO-2022-KR">ISO-2022-KR</option>
                                                <option value="ISO-8859-1">ISO-8859-1</option>
                                                <option value="ISO-8859-2">ISO-8859-2</option>
                                                <option value="ISO-8859-3">ISO-8859-3</option>
                                                <option value="ISO-8859-4">ISO-8859-4</option>
                                                <option value="ISO-8859-5">ISO-8859-5</option>
                                                <option value="ISO-8859-6">ISO-8859-6</option>
                                                <option value="ISO-8859-7">ISO-8859-7</option>
                                                <option value="ISO-8859-8">ISO-8859-8</option>
                                                <option value="ISO-8859-9">ISO-8859-9</option>
                                                <option value="ISO-8859-10">ISO-8859-10</option>
                                                <option value="ISO-8859-11">ISO-8859-11</option>
                                                <option value="ISO-8859-13">ISO-8859-13</option>
                                                <option value="ISO-8859-14">ISO-8859-14</option>
                                                <option value="ISO-8859-15">ISO-8859-15</option>
                                                <option value="ISO-8859-16">ISO-8859-16</option>
                                                <option value="ISO-10646">ISO-10646</option>
                                                <option value="ISO-10646/UCS2">ISO-10646/UCS2</option>
                                                <option value="ISO-10646/UCS4">ISO-10646/UCS4</option>
                                                <option value="ISO-10646/UTF-8">ISO-10646/UTF-8</option>
                                                <option value="ISO-10646/UTF8">ISO-10646/UTF8</option>
                                                <option value="ISO-CELTIC">ISO-CELTIC</option>
                                                <option value="ISO-IR-4">ISO-IR-4</option>
                                                <option value="ISO-IR-6">ISO-IR-6</option>
                                                <option value="ISO-IR-8-1">ISO-IR-8-1</option>
                                                <option value="ISO-IR-9-1">ISO-IR-9-1</option>
                                                <option value="ISO-IR-10">ISO-IR-10</option>
                                                <option value="ISO-IR-11">ISO-IR-11</option>
                                                <option value="ISO-IR-14">ISO-IR-14</option>
                                                <option value="ISO-IR-15">ISO-IR-15</option>
                                                <option value="ISO-IR-16">ISO-IR-16</option>
                                                <option value="ISO-IR-17">ISO-IR-17</option>
                                                <option value="ISO-IR-18">ISO-IR-18</option>
                                                <option value="ISO-IR-19">ISO-IR-19</option>
                                                <option value="ISO-IR-21">ISO-IR-21</option>
                                                <option value="ISO-IR-25">ISO-IR-25</option>
                                                <option value="ISO-IR-27">ISO-IR-27</option>
                                                <option value="ISO-IR-37">ISO-IR-37</option>
                                                <option value="ISO-IR-49">ISO-IR-49</option>
                                                <option value="ISO-IR-50">ISO-IR-50</option>
                                                <option value="ISO-IR-51">ISO-IR-51</option>
                                                <option value="ISO-IR-54">ISO-IR-54</option>
                                                <option value="ISO-IR-55">ISO-IR-55</option>
                                                <option value="ISO-IR-57">ISO-IR-57</option>
                                                <option value="ISO-IR-60">ISO-IR-60</option>
                                                <option value="ISO-IR-61">ISO-IR-61</option>
                                                <option value="ISO-IR-69">ISO-IR-69</option>
                                                <option value="ISO-IR-84">ISO-IR-84</option>
                                                <option value="ISO-IR-85">ISO-IR-85</option>
                                                <option value="ISO-IR-86">ISO-IR-86</option>
                                                <option value="ISO-IR-88">ISO-IR-88</option>
                                                <option value="ISO-IR-89">ISO-IR-89</option>
                                                <option value="ISO-IR-90">ISO-IR-90</option>
                                                <option value="ISO-IR-92">ISO-IR-92</option>
                                                <option value="ISO-IR-98">ISO-IR-98</option>
                                                <option value="ISO-IR-99">ISO-IR-99</option>
                                                <option value="ISO-IR-100">ISO-IR-100</option>
                                                <option value="ISO-IR-101">ISO-IR-101</option>
                                                <option value="ISO-IR-103">ISO-IR-103</option>
                                                <option value="ISO-IR-109">ISO-IR-109</option>
                                                <option value="ISO-IR-110">ISO-IR-110</option>
                                                <option value="ISO-IR-111">ISO-IR-111</option>
                                                <option value="ISO-IR-121">ISO-IR-121</option>
                                                <option value="ISO-IR-122">ISO-IR-122</option>
                                                <option value="ISO-IR-126">ISO-IR-126</option>
                                                <option value="ISO-IR-127">ISO-IR-127</option>
                                                <option value="ISO-IR-138">ISO-IR-138</option>
                                                <option value="ISO-IR-139">ISO-IR-139</option>
                                                <option value="ISO-IR-141">ISO-IR-141</option>
                                                <option value="ISO-IR-143">ISO-IR-143</option>
                                                <option value="ISO-IR-144">ISO-IR-144</option>
                                                <option value="ISO-IR-148">ISO-IR-148</option>
                                                <option value="ISO-IR-150">ISO-IR-150</option>
                                                <option value="ISO-IR-151">ISO-IR-151</option>
                                                <option value="ISO-IR-153">ISO-IR-153</option>
                                                <option value="ISO-IR-155">ISO-IR-155</option>
                                                <option value="ISO-IR-156">ISO-IR-156</option>
                                                <option value="ISO-IR-157">ISO-IR-157</option>
                                                <option value="ISO-IR-166">ISO-IR-166</option>
                                                <option value="ISO-IR-179">ISO-IR-179</option>
                                                <option value="ISO-IR-193">ISO-IR-193</option>
                                                <option value="ISO-IR-197">ISO-IR-197</option>
                                                <option value="ISO-IR-199">ISO-IR-199</option>
                                                <option value="ISO-IR-203">ISO-IR-203</option>
                                                <option value="ISO-IR-209">ISO-IR-209</option>
                                                <option value="ISO-IR-226">ISO-IR-226</option>
                                                <option value="ISO646-CA">ISO646-CA</option>
                                                <option value="ISO646-CA2">ISO646-CA2</option>
                                                <option value="ISO646-CN">ISO646-CN</option>
                                                <option value="ISO646-CU">ISO646-CU</option>
                                                <option value="ISO646-DE">ISO646-DE</option>
                                                <option value="ISO646-DK">ISO646-DK</option>
                                                <option value="ISO646-ES">ISO646-ES</option>
                                                <option value="ISO646-ES2">ISO646-ES2</option>
                                                <option value="ISO646-FI">ISO646-FI</option>
                                                <option value="ISO646-FR">ISO646-FR</option>
                                                <option value="ISO646-FR1">ISO646-FR1</option>
                                                <option value="ISO646-GB">ISO646-GB</option>
                                                <option value="ISO646-HU">ISO646-HU</option>
                                                <option value="ISO646-IT">ISO646-IT</option>
                                                <option value="ISO646-JP-OCR-B">ISO646-JP-OCR-B</option>
                                                <option value="ISO646-JP">ISO646-JP</option>
                                                <option value="ISO646-KR">ISO646-KR</option>
                                                <option value="ISO646-NO">ISO646-NO</option>
                                                <option value="ISO646-NO2">ISO646-NO2</option>
                                                <option value="ISO646-PT">ISO646-PT</option>
                                                <option value="ISO646-PT2">ISO646-PT2</option>
                                                <option value="ISO646-SE">ISO646-SE</option>
                                                <option value="ISO646-SE2">ISO646-SE2</option>
                                                <option value="ISO646-US">ISO646-US</option>
                                                <option value="ISO646-YU">ISO646-YU</option>
                                                <option value="ISO2022CN">ISO2022CN</option>
                                                <option value="ISO2022CNEXT">ISO2022CNEXT</option>
                                                <option value="ISO2022JP">ISO2022JP</option>
                                                <option value="ISO2022JP2">ISO2022JP2</option>
                                                <option value="ISO2022KR">ISO2022KR</option>
                                                <option value="ISO6937">ISO6937</option>
                                                <option value="ISO8859-1">ISO8859-1</option>
                                                <option value="ISO8859-2">ISO8859-2</option>
                                                <option value="ISO8859-3">ISO8859-3</option>
                                                <option value="ISO8859-4">ISO8859-4</option>
                                                <option value="ISO8859-5">ISO8859-5</option>
                                                <option value="ISO8859-6">ISO8859-6</option>
                                                <option value="ISO8859-7">ISO8859-7</option>
                                                <option value="ISO8859-8">ISO8859-8</option>
                                                <option value="ISO8859-9">ISO8859-9</option>
                                                <option value="ISO8859-10">ISO8859-10</option>
                                                <option value="ISO8859-11">ISO8859-11</option>
                                                <option value="ISO8859-13">ISO8859-13</option>
                                                <option value="ISO8859-14">ISO8859-14</option>
                                                <option value="ISO8859-15">ISO8859-15</option>
                                                <option value="ISO8859-16">ISO8859-16</option>
                                                <option value="ISO88591">ISO88591</option>
                                                <option value="ISO88592">ISO88592</option>
                                                <option value="ISO88593">ISO88593</option>
                                                <option value="ISO88594">ISO88594</option>
                                                <option value="ISO88595">ISO88595</option>
                                                <option value="ISO88596">ISO88596</option>
                                                <option value="ISO88597">ISO88597</option>
                                                <option value="ISO88598">ISO88598</option>
                                                <option value="ISO88599">ISO88599</option>
                                                <option value="ISO885910">ISO885910</option>
                                                <option value="ISO885911">ISO885911</option>
                                                <option value="ISO885913">ISO885913</option>
                                                <option value="ISO885914">ISO885914</option>
                                                <option value="ISO885915">ISO885915</option>
                                                <option value="ISO885916">ISO885916</option>
                                                <option value="ISO_646.IRV:1991">ISO_646.IRV:1991</option>
                                                <option value="ISO_2033-1983">ISO_2033-1983</option>
                                                <option value="ISO_2033">ISO_2033</option>
                                                <option value="ISO_5427-EXT">ISO_5427-EXT</option>
                                                <option value="ISO_5427">ISO_5427</option>
                                                <option value="ISO_5427:1981">ISO_5427:1981</option>
                                                <option value="ISO_5427EXT">ISO_5427EXT</option>
                                                <option value="ISO_5428">ISO_5428</option>
                                                <option value="ISO_5428:1980">ISO_5428:1980</option>
                                                <option value="ISO_6937-2">ISO_6937-2</option>
                                                <option value="ISO_6937-2:1983">ISO_6937-2:1983</option>
                                                <option value="ISO_6937">ISO_6937</option>
                                                <option value="ISO_6937:1992">ISO_6937:1992</option>
                                                <option value="ISO_8859-1">ISO_8859-1</option>
                                                <option value="ISO_8859-1:1987">ISO_8859-1:1987</option>
                                                <option value="ISO_8859-2">ISO_8859-2</option>
                                                <option value="ISO_8859-2:1987">ISO_8859-2:1987</option>
                                                <option value="ISO_8859-3">ISO_8859-3</option>
                                                <option value="ISO_8859-3:1988">ISO_8859-3:1988</option>
                                                <option value="ISO_8859-4">ISO_8859-4</option>
                                                <option value="ISO_8859-4:1988">ISO_8859-4:1988</option>
                                                <option value="ISO_8859-5">ISO_8859-5</option>
                                                <option value="ISO_8859-5:1988">ISO_8859-5:1988</option>
                                                <option value="ISO_8859-6">ISO_8859-6</option>
                                                <option value="ISO_8859-6:1987">ISO_8859-6:1987</option>
                                                <option value="ISO_8859-7">ISO_8859-7</option>
                                                <option value="ISO_8859-7:1987">ISO_8859-7:1987</option>
                                                <option value="ISO_8859-8">ISO_8859-8</option>
                                                <option value="ISO_8859-8:1988">ISO_8859-8:1988</option>
                                                <option value="ISO_8859-9">ISO_8859-9</option>
                                                <option value="ISO_8859-9:1989">ISO_8859-9:1989</option>
                                                <option value="ISO_8859-10">ISO_8859-10</option>
                                                <option value="ISO_8859-10:1992">ISO_8859-10:1992</option>
                                                <option value="ISO_8859-14">ISO_8859-14</option>
                                                <option value="ISO_8859-14:1998">ISO_8859-14:1998</option>
                                                <option value="ISO_8859-15">ISO_8859-15</option>
                                                <option value="ISO_8859-15:1998">ISO_8859-15:1998</option>
                                                <option value="ISO_8859-16">ISO_8859-16</option>
                                                <option value="ISO_8859-16:2001">ISO_8859-16:2001</option>
                                                <option value="ISO_9036">ISO_9036</option>
                                                <option value="ISO_10367-BOX">ISO_10367-BOX</option>
                                                <option value="ISO_10367BOX">ISO_10367BOX</option>
                                                <option value="ISO_69372">ISO_69372</option>
                                                <option value="IT">IT</option>
                                                <option value="JIS_C6220-1969-RO">JIS_C6220-1969-RO</option>
                                                <option value="JIS_C6229-1984-B">JIS_C6229-1984-B</option>
                                                <option value="JIS_C62201969RO">JIS_C62201969RO</option>
                                                <option value="JIS_C62291984B">JIS_C62291984B</option>
                                                <option value="JOHAB">JOHAB</option>
                                                <option value="JP-OCR-B">JP-OCR-B</option>
                                                <option value="JP">JP</option>
                                                <option value="JS">JS</option>
                                                <option value="JUS_I.B1.002">JUS_I.B1.002</option>
                                                <option value="KOI-7">KOI-7</option>
                                                <option value="KOI-8">KOI-8</option>
                                                <option value="KOI8-R">KOI8-R</option>
                                                <option value="KOI8-T">KOI8-T</option>
                                                <option value="KOI8-U">KOI8-U</option>
                                                <option value="KOI8">KOI8</option>
                                                <option value="KOI8R">KOI8R</option>
                                                <option value="KOI8U">KOI8U</option>
                                                <option value="KSC5636">KSC5636</option>
                                                <option value="L1">L1</option>
                                                <option value="L2">L2</option>
                                                <option value="L3">L3</option>
                                                <option value="L4">L4</option>
                                                <option value="L5">L5</option>
                                                <option value="L6">L6</option>
                                                <option value="L7">L7</option>
                                                <option value="L8">L8</option>
                                                <option value="L10">L10</option>
                                                <option value="LATIN-9">LATIN-9</option>
                                                <option value="LATIN-GREEK-1">LATIN-GREEK-1</option>
                                                <option value="LATIN-GREEK">LATIN-GREEK</option>
                                                <option value="LATIN1">LATIN1</option>
                                                <option value="LATIN2">LATIN2</option>
                                                <option value="LATIN3">LATIN3</option>
                                                <option value="LATIN4">LATIN4</option>
                                                <option value="LATIN5">LATIN5</option>
                                                <option value="LATIN6">LATIN6</option>
                                                <option value="LATIN7">LATIN7</option>
                                                <option value="LATIN8">LATIN8</option>
                                                <option value="LATIN10">LATIN10</option>
                                                <option value="LATINGREEK">LATINGREEK</option>
                                                <option value="LATINGREEK1">LATINGREEK1</option>
                                                <option value="MAC-CYRILLIC">MAC-CYRILLIC</option>
                                                <option value="MAC-IS">MAC-IS</option>
                                                <option value="MAC-SAMI">MAC-SAMI</option>
                                                <option value="MAC-UK">MAC-UK</option>
                                                <option value="MAC">MAC</option>
                                                <option value="MACCYRILLIC">MACCYRILLIC</option>
                                                <option value="MACINTOSH">MACINTOSH</option>
                                                <option value="MACIS">MACIS</option>
                                                <option value="MACUK">MACUK</option>
                                                <option value="MACUKRAINIAN">MACUKRAINIAN</option>
                                                <option value="MS-ANSI">MS-ANSI</option>
                                                <option value="MS-ARAB">MS-ARAB</option>
                                                <option value="MS-CYRL">MS-CYRL</option>
                                                <option value="MS-EE">MS-EE</option>
                                                <option value="MS-GREEK">MS-GREEK</option>
                                                <option value="MS-HEBR">MS-HEBR</option>
                                                <option value="MS-MAC-CYRILLIC">MS-MAC-CYRILLIC</option>
                                                <option value="MS-TURK">MS-TURK</option>
                                                <option value="MS932">MS932</option>
                                                <option value="MS936">MS936</option>
                                                <option value="MSCP949">MSCP949</option>
                                                <option value="MSCP1361">MSCP1361</option>
                                                <option value="MSMACCYRILLIC">MSMACCYRILLIC</option>
                                                <option value="MSZ_7795.3">MSZ_7795.3</option>
                                                <option value="MS_KANJI">MS_KANJI</option>
                                                <option value="NAPLPS">NAPLPS</option>
                                                <option value="NATS-DANO">NATS-DANO</option>
                                                <option value="NATS-SEFI">NATS-SEFI</option>
                                                <option value="NATSDANO">NATSDANO</option>
                                                <option value="NATSSEFI">NATSSEFI</option>
                                                <option value="NC_NC0010">NC_NC0010</option>
                                                <option value="NC_NC00-10">NC_NC00-10</option>
                                                <option value="NC_NC00-10:81">NC_NC00-10:81</option>
                                                <option value="NF_Z_62-010">NF_Z_62-010</option>
                                                <option value="NF_Z_62-010_(1973)">NF_Z_62-010_(1973)</option>
                                                <option value="NF_Z_62-010_1973">NF_Z_62-010_1973</option>
                                                <option value="NF_Z_62010">NF_Z_62010</option>
                                                <option value="NF_Z_62010_1973">NF_Z_62010_1973</option>
                                                <option value="NO">NO</option>
                                                <option value="NO2">NO2</option>
                                                <option value="NS_4551-1">NS_4551-1</option>
                                                <option value="NS_4551-2">NS_4551-2</option>
                                                <option value="NS_45511">NS_45511</option>
                                                <option value="NS_45512">NS_45512</option>
                                                <option value="OS2LATIN1">OS2LATIN1</option>
                                                <option value="OSF00010001">OSF00010001</option>
                                                <option value="OSF00010002">OSF00010002</option>
                                                <option value="OSF00010003">OSF00010003</option>
                                                <option value="OSF00010004">OSF00010004</option>
                                                <option value="OSF00010005">OSF00010005</option>
                                                <option value="OSF00010006">OSF00010006</option>
                                                <option value="OSF00010007">OSF00010007</option>
                                                <option value="OSF00010008">OSF00010008</option>
                                                <option value="OSF00010009">OSF00010009</option>
                                                <option value="OSF0001000A">OSF0001000A</option>
                                                <option value="OSF00010020">OSF00010020</option>
                                                <option value="OSF00010100">OSF00010100</option>
                                                <option value="OSF00010101">OSF00010101</option>
                                                <option value="OSF00010102">OSF00010102</option>
                                                <option value="OSF00010104">OSF00010104</option>
                                                <option value="OSF00010105">OSF00010105</option>
                                                <option value="OSF00010106">OSF00010106</option>
                                                <option value="OSF00030010">OSF00030010</option>
                                                <option value="OSF0004000A">OSF0004000A</option>
                                                <option value="OSF0005000A">OSF0005000A</option>
                                                <option value="OSF05010001">OSF05010001</option>
                                                <option value="OSF100201A4">OSF100201A4</option>
                                                <option value="OSF100201A8">OSF100201A8</option>
                                                <option value="OSF100201B5">OSF100201B5</option>
                                                <option value="OSF100201F4">OSF100201F4</option>
                                                <option value="OSF100203B5">OSF100203B5</option>
                                                <option value="OSF1002011C">OSF1002011C</option>
                                                <option value="OSF1002011D">OSF1002011D</option>
                                                <option value="OSF1002035D">OSF1002035D</option>
                                                <option value="OSF1002035E">OSF1002035E</option>
                                                <option value="OSF1002035F">OSF1002035F</option>
                                                <option value="OSF1002036B">OSF1002036B</option>
                                                <option value="OSF1002037B">OSF1002037B</option>
                                                <option value="OSF10010001">OSF10010001</option>
                                                <option value="OSF10020025">OSF10020025</option>
                                                <option value="OSF10020111">OSF10020111</option>
                                                <option value="OSF10020115">OSF10020115</option>
                                                <option value="OSF10020116">OSF10020116</option>
                                                <option value="OSF10020118">OSF10020118</option>
                                                <option value="OSF10020122">OSF10020122</option>
                                                <option value="OSF10020129">OSF10020129</option>
                                                <option value="OSF10020352">OSF10020352</option>
                                                <option value="OSF10020354">OSF10020354</option>
                                                <option value="OSF10020357">OSF10020357</option>
                                                <option value="OSF10020359">OSF10020359</option>
                                                <option value="OSF10020360">OSF10020360</option>
                                                <option value="OSF10020364">OSF10020364</option>
                                                <option value="OSF10020365">OSF10020365</option>
                                                <option value="OSF10020366">OSF10020366</option>
                                                <option value="OSF10020367">OSF10020367</option>
                                                <option value="OSF10020370">OSF10020370</option>
                                                <option value="OSF10020387">OSF10020387</option>
                                                <option value="OSF10020388">OSF10020388</option>
                                                <option value="OSF10020396">OSF10020396</option>
                                                <option value="OSF10020402">OSF10020402</option>
                                                <option value="OSF10020417">OSF10020417</option>
                                                <option value="PT">PT</option>
                                                <option value="PT2">PT2</option>
                                                <option value="R8">R8</option>
                                                <option value="ROMAN8">ROMAN8</option>
                                                <option value="RUSCII">RUSCII</option>
                                                <option value="SE">SE</option>
                                                <option value="SE2">SE2</option>
                                                <option value="SEN_850200_B">SEN_850200_B</option>
                                                <option value="SEN_850200_C">SEN_850200_C</option>
                                                <option value="SHIFT-JIS">SHIFT-JIS</option>
                                                <option value="SHIFT_JIS">SHIFT_JIS</option>
                                                <option value="SHIFT_JISX0213">SHIFT_JISX0213</option>
                                                <option value="SJIS-OPEN">SJIS-OPEN</option>
                                                <option value="SJIS-WIN">SJIS-WIN</option>
                                                <option value="SJIS">SJIS</option>
                                                <option value="SS636127">SS636127</option>
                                                <option value="ST_SEV_358-88">ST_SEV_358-88</option>
                                                <option value="T.61-8BIT">T.61-8BIT</option>
                                                <option value="T.61">T.61</option>
                                                <option value="T.618BIT">T.618BIT</option>
                                                <option value="TCVN-5712">TCVN-5712</option>
                                                <option value="TCVN">TCVN</option>
                                                <option value="TCVN5712-1">TCVN5712-1</option>
                                                <option value="TCVN5712-1:1993">TCVN5712-1:1993</option>
                                                <option value="TIS-620">TIS-620</option>
                                                <option value="TIS620-0">TIS620-0</option>
                                                <option value="TIS620.2529-1">TIS620.2529-1</option>
                                                <option value="TIS620.2533-0">TIS620.2533-0</option>
                                                <option value="TIS620">TIS620</option>
                                                <option value="TS-5881">TS-5881</option>
                                                <option value="TSCII">TSCII</option>
                                                <option value="UCS-2">UCS-2</option>
                                                <option value="UCS-2BE">UCS-2BE</option>
                                                <option value="UCS-2LE">UCS-2LE</option>
                                                <option value="UCS-4">UCS-4</option>
                                                <option value="UCS-4BE">UCS-4BE</option>
                                                <option value="UCS-4LE">UCS-4LE</option>
                                                <option value="UCS2">UCS2</option>
                                                <option value="UCS4">UCS4</option>
                                                <option value="UHC">UHC</option>
                                                <option value="UJIS">UJIS</option>
                                                <option value="UK">UK</option>
                                                <option value="UNICODE">UNICODE</option>
                                                <option value="UNICODEBIG">UNICODEBIG</option>
                                                <option value="UNICODELITTLE">UNICODELITTLE</option>
                                                <option value="US-ASCII">US-ASCII</option>
                                                <option value="US">US</option>
                                                <option value="UTF-7">UTF-7</option>
                                                <option value="UTF-8" selected="selected">UTF-8</option>
                                                <option value="UTF-16">UTF-16</option>
                                                <option value="UTF-16BE">UTF-16BE</option>
                                                <option value="UTF-16LE">UTF-16LE</option>
                                                <option value="UTF-32">UTF-32</option>
                                                <option value="UTF-32BE">UTF-32BE</option>
                                                <option value="UTF-32LE">UTF-32LE</option>
                                                <option value="UTF7">UTF7</option>
                                                <option value="UTF8">UTF8</option>
                                                <option value="UTF16">UTF16</option>
                                                <option value="UTF16BE">UTF16BE</option>
                                                <option value="UTF16LE">UTF16LE</option>
                                                <option value="UTF32">UTF32</option>
                                                <option value="UTF32BE">UTF32BE</option>
                                                <option value="UTF32LE">UTF32LE</option>
                                                <option value="VISCII">VISCII</option>
                                                <option value="WCHAR_T">WCHAR_T</option>
                                                <option value="WIN-SAMI-2">WIN-SAMI-2</option>
                                                <option value="WINBALTRIM">WINBALTRIM</option>
                                                <option value="WINDOWS-31J">WINDOWS-31J</option>
                                                <option value="WINDOWS-936">WINDOWS-936</option>
                                                <option value="WINDOWS-1250">WINDOWS-1250</option>
                                                <option value="WINDOWS-1251">WINDOWS-1251</option>
                                                <option value="WINDOWS-1252">WINDOWS-1252</option>
                                                <option value="WINDOWS-1253">WINDOWS-1253</option>
                                                <option value="WINDOWS-1254">WINDOWS-1254</option>
                                                <option value="WINDOWS-1255">WINDOWS-1255</option>
                                                <option value="WINDOWS-1256">WINDOWS-1256</option>
                                                <option value="WINDOWS-1257">WINDOWS-1257</option>
                                                <option value="WINDOWS-1258">WINDOWS-1258</option>
                                                <option value="WINSAMI2">WINSAMI2</option>
                                                <option value="WS2">WS2</option>
                                                <option value="YU">YU</option>
                                                </select></span>
                                    </label>
                                    <label class="label_row">
                                        <span class="column1">{if $lang.plesk_message}{$lang.plesk_message}{else}Message{/if}:</span>
                                        <span class="column2"><textarea class="content_autoreply autoreply-text" rows="3" name="change[{$index}][autoreply][text]" class="f-textarea">{$entry.autoresponder.text|escape}</textarea></span>
                                    </label>
                                    <label class="label_row">
                                        <span class="column1">{$lang.fwdto}</span>
                                        <span class="column2"><input class="content_autoreply" type="text" name="change[{$index}][autoreply][forward]" value="{$entry.autoresponder.forward|escape}"></span>
                                    </label>
                                    {*<label>*}
                                    {*{if $lang.sendautomatic}{$lang.sendautomatic}{else}Send an automatic response to a unique email address no more than (times a day){/if}*}
                                    {*<input type="number" name="change[{$index}][autoreply-sendautomate]" value="1" class="autoreply-number">*}
                                    {*</label>*}
                                    {*<label class="checkbox">*}
                                    {*<input type="checkbox" name="change[{$index}][autoreply][end-check]"{if $entry.autoresponder.end_date}checked{/if}>{if $lang.switchoff}{$lang.switchoff}{else}<span class="f-span">Switch off auto-reply on</span>{/if}*}
                                    {*</label>*}
                                    {*<label><input type="date" name="change[{$index}][autoreply][end_date]" value="{$entry.autoresponder.end_date}"></label>*}
                                </td>
                                {*<td class="change_div" colspan="3">*}
                                {*<label class="checkbox">*}
                                {*<input type="checkbox" name="change[{$index}][spam-on]"><span class="f-span">{if $lang.switchonspamfilterinf}{$lang.switchonspamfilterinf}{else}Switch on spam filtering for this email address{/if}</span>*}
                                {*</label>*}
                                {*<label class="checkbox">*}
                                {*<input type="checkbox" name="change[{$index}][spam-mark]"><span class="f-span">{if $lang.markspam}{$lang.markspam}{else}Mark spam messages by adding the following text to message subject{/if}</span>*}
                                {*</label>*}
                                {*<label>*}
                                {*<input type="text" name="change[{$index}][spam-mark-input]">*}
                                {*</label><br>*}
                                {*<label class="checkbox">*}
                                {*<input type="checkbox" name="change[{$index}][spam-delete]"><span class="f-span">{if $lang.deletespam}{$lang.deletespam}{else}Delete all spam messages{/if}</span>*}
                                {*</label><br>*}
                                {*<label class="checkbox">*}
                                {*<input type="checkbox" name="change[{$index}][spam-move]"><span class="f-span">{if $lang.movespam}{$lang.movespam}{else}Move spam to the Spam folder{/if}</span>*}
                                {*</label>*}
                                {*</td>*}
                            </tr>
                        {/foreach}
                    {else}
                        <tr {counter}{if $even % 2 !=0}class="even"{/if}>
                            <td align="center" colspan="3">{$lang.nothing}</td>&nbsp;
                        </tr>
                    {/if}
                    </tbody>
                    <tfoot>
                    <tr {counter}{if $even % 2 !=0}class="even"{/if}><td colspan="4">&nbsp;</td></tr>
                    <tr {counter}{if $even % 2 !=0}class="even"{/if}><td colspan="4">{$lang.addemailaccount}</td></tr>
                    <tr {counter}{if $even % 2 !=0}class="even"{/if}>
                        <td style="border:none" colspan="4" align="center">
                            <table style="float:left" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td style="text-align:right;border:none">{$lang.username}: </td>
                                    <td style="text-align:left; border:none"> <input class="span2" autocomplete="off" type="text" name="name" >@{if $listdomains|@count == 1}{$listdomains[0].domain}{elseif $listdomains|@count == 0}{$domain}{/if}
                                    </td>
                                </tr>
                                <tr>
                                    <td  style="text-align:right;border:none">{$lang.password}: </td>
                                    <td style="text-align:left;border:none"> <input class="span2" autocomplete="off" type="password" name="passmain" ></td>
                                </tr>
                                <tr>
                                    <td style="text-align:right;border:none">{$lang.confirmpassword}: </td>
                                    <td style="text-align:left;border:none"> <input class="span2" autocomplete="off" type="password" name="passcheck" ></td>
                                </tr>
                            </table>
                            <div style="float:left;padding:0 0 0 10px;vertical-align:middle">{$lang.quota}:<br>
                                {if $email_quota}
                                    <select name="quota" class="email_quota span2">
                                        {foreach from=$email_quota item=quota}
                                            {if $quota == 'custom'}
                                                <option value="custom" >{$lang.custom}</option>
                                            {elseif $quota == 'unlimited'}
                                                <option value="-1" >{$lang.unlimited}</option>
                                            {else}
                                                <option value="{$quota}" >{if is_numeric($quota)}{$quota|filesize}{else}{$quota}{/if}</option>
                                            {/if}
                                        {/foreach}
                                    </select>
                                {else}
                                    <select name="quota" class="email_quota span2">
                                        <option value="custom" >{$lang.custom}</option>
                                        <option selected="selected" value="20" >20 {$lang.mb}</option>
                                        <option value="50" >50 {$lang.mb}</option>
                                        <option value="100" >100 {$lang.mb}</option>
                                        <option value="250" >250 {$lang.mb}</option>
                                    </select>
                                {/if}
                            </div>
                            <div style="float:left; padding:15px 6px;vertical-align:middle"><input type="submit" name="save" value="{$lang.shortsave}" class="btn btn-primary"> </div>
                        </td></tr>
                    </tfoot>
                </table>
                {securitytoken}
            </form>
        </div>

    </div>
</div>
<script type="text/javascript" src="{$widgetdir_url}../widget.js"></script>
<link rel="stylesheet" type="text/css" href="{$widgetdir_url}../widget.css"  media="all">
