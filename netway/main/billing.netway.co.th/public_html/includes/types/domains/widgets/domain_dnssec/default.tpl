<div class="wbox" id="dnssec_widget">
    <div class="wbox_header">{$lang.dnssec}</div>



    <div  class="wbox_content">

        {if $dnssec_automation}
            <table cellspacing="0" cellpadding="0" border="0" width="100%" class="checker table table-striped" id="dnssec-list">
                <tbody>
                <tr>
                    <td>{$lang.dnssec_for_domain}
                        {if !$dnssec_list_key && !$dnssec_list_ds}
                            <span class="label label-danger badge badge-pill badge-danger">{$lang.disabled}</span>
                        {else}
                            <span class="label label-success badge badge-pill badge-success">{$lang.enabled}</span>
                        {/if}
                    </td>
                    <td class="text-right">
                        {if !$dnssec_list_key && !$dnssec_list_ds}
                            <a href="{$widget_url}&dnssec=enable&security_token={$security_token}" class="btn btn-success">{$lang.dnssec_enable}</a>
                        {else}
                            <a href="{$widget_url}&dnssec=disable&security_token={$security_token}" class="btn btn-danger" onclick="return confirm('{$lang.confirm_disable_dnssec}');">{$lang.dnssec_disable}</a>
                        {/if}
                        <button type="button" class="btn btn-primary dnssec-advanced">{$lang.advanced}</button>
                    </td>
                </tr>
                </tbody>
            </table>
        {/if}

        {if $dnssec_listed}
            <table cellspacing="0" cellpadding="0" border="0" width="100%" class="checker table table-striped" id="dnssec-list">
                {if $dnssec_list_ds}
                    <thead>
                        <tr>
                            <th>{$lang.dnssec_key_tag}</th>
                            <th>{$lang.dnssec_algorithm}</th>
                            <th>{$lang.dnssec_digest_type}</th>
                            <th>{$lang.dnssec_key_digest}</th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody id="dnssec-list-ds">
                        {foreach from=$dnssec_list_ds item=record}
                            <tr>
                                <td>{$record.key_tag}</td>
                                <td>{$record.algorithm} - {$dnssec_algorithm[$record.algorithm]|default:$record.algorithm}</td>
                                <td>{$record.digest_type} - {$dnssec_digest[$record.digest_type]|default:$record.digest_type}</td>
                                <td><div style="max-width: 200px; overflow: auto">{$record.digest}</div></td>
                                <td>
                                    <a href="{$widget_url}&widgetdo=update&remove={$record.id}&security_token={$security_roken}" class="delsth red f11" onclick="return confirm('{$lang.areyousure}');">{$lang.remove}</a>
                                </td>
                            </tr>
                        {/foreach}
                    </tbody>
                {/if}
                {if $dnssec_list_key}
                    <thead>
                        <tr>
                            <th>{$lang.dnssec_flags}</th>
                            <th>{$lang.dnssec_protocol}</th>
                            <th>{$lang.dnssec_algorithm}</th>
                            <th>{$lang.dnssec_public_key}</th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody id="dnssec-list-key">
                        {foreach from=$dnssec_list_key item=record}
                            <tr>
                                <td>{$dnssec_flag[$record.flag]|default:$record.flag}</td>
                                <td>{$dnssec_protocol[$record.protocol]|default:$record.protocol}</td>
                                <td>{$record.algorithm} - {$dnssec_algorithm[$record.algorithm]|default:$record.algorithm}</td>
                                <td><div style="max-width: 200px; overflow: auto">{$record.publickey}</div></td>
                                <td>
                                    <a href="{$widget_url}&widgetdo=update&remove={$record.id}&security_token={$security_roken}" class="delsth red f11"  onclick="return confirm('{$lang.areyousure}');">{$lang.remove}</a>
                                </td>
                            </tr>
                        {/foreach}
                    </tbody>
                {/if}
                {if !$dnssec_list_key && !$dnssec_list_ds}
                    {if !$dnssec_automation}
                        <tr>
                            <td>{$lang.dnssec_no_records}</td>
                        </tr>
                    {/if}
                {/if}
            </table>
        {/if}

        <form action="" method="post" class="form-horizontal" id="dnssec_form" {if $dnssec_automation}style="display: none;"{/if}>
            <input type="hidden" name="submit" value="1" />
            <input type="hidden" name="widgetdo" value="update" />

            <table cellspacing="0" cellpadding="0" border="0" width="100%" class="checker table table-striped" >
                {if $dnssec_form.type == 'DS'}
                    <tr>
                        <td> {$lang.dnssec_new_key_tag}:</td>
                        <td>
                            <input type="text" size="30" value="" name="dnssec_form[key_tag]"/>
                        </td>
                    </tr>
                    {if $dnssec_form.algorithm}
                        <tr>
                            <td> {$lang.dnssec_key_algorithm}:</td>
                            <td>
                                <select name="dnssec_form[algorithm]">
                                    {foreach from=$dnssec_form.algorithm item=alg}
                                        <option value="{$alg}">{$alg} - {$dnssec_algorithm[$alg]}</option>
                                    {/foreach}
                                </select>
                            </td>
                        </tr>
                    {/if}
                    {if $dnssec_form.digest_type}
                        <tr>
                            <td>{$lang.dnssec_digest_type}:</td>
                            <td>
                                <select name="dnssec_form[digest_type]">
                                    {foreach from=$dnssec_form.digest_type item=alg}
                                        <option value="{$alg}">{$alg} - {$dnssec_digest[$alg]}</option>
                                    {/foreach}
                                </select>
                            </td>
                        </tr>
                    {/if}
                    <tr>
                        <td>{$lang.dnssec_key_digest}:</td>
                        <td>
                            <textarea name="dnssec_form[digest]" cols="40"></textarea>
                        </td>
                    </tr>
                {else}

                    {if $dnssec_form.flag}
                        <tr>
                            <td> {$lang.dnssec_flags}:</td>
                            <td>
                                <select name="dnssec_form[flag]">
                                    {foreach from=$dnssec_form.flag item=alg}
                                        <option value="{$alg}">{$alg} - {$dnssec_flag[$alg]}</option>
                                    {/foreach}
                                </select>
                            </td>
                        </tr>
                    {/if}
                    {if $dnssec_form.protocol}
                        <tr>
                            <td> {$lang.dnssec_protocol}:</td>
                            <td>
                                <select name="dnssec_form[protocol]">
                                    {foreach from=$dnssec_form.protocol item=alg}
                                        <option value="{$alg}">{$alg} - {$dnssec_protocol[$alg]}</option>
                                    {/foreach}
                                </select>
                            </td>
                        </tr>
                    {/if}
                    {if $dnssec_form.algorithm}
                        <tr>
                            <td> {$lang.dnssec_key_algorithm}:</td>
                            <td>
                                <select name="dnssec_form[algorithm]">
                                    {foreach from=$dnssec_form.algorithm item=alg}
                                        <option value="{$alg}">{$alg} - {$dnssec_algorithm[$alg]}</option>
                                    {/foreach}
                                </select>
                            </td>
                        </tr>
                    {/if}
                    <tr>
                        <td>{$lang.dnssec_public_key}:</td>
                        <td>
                            <textarea name="dnssec_form[publickey]" cols="40"></textarea>
                        </td>
                    </tr>
                {/if}


                <tr class="even">
                    <td colspan="3" align="center">
                        <button class="btn btn-primary" type="submit">{$lang.shortsave}</button>
                        <span class="fs11">{$lang.or}</span>
                        <a href="{$ca_url}clientarea/domains/{if $details}{$details.id}/{$details.name}/{/if}" class="fs11">{$lang.cancel}</a>
                    </td>
                </tr>
            </table>
        </form>
    </div>
</div>
<script src="{$widget_dirurl}dnssec.js"></script>
