<div class="wbox">
    <div class="wbox_header">{$lang.dnsmanagement}:</div>
    <div  class="wbox_content">
        {if $DNSmanagement.redirect}
            <div style="text-align: center; padding: 20px;">
                {if $DNSmanagement.url}{$lang.Click} <a href="{$DNSmanagement.url}" target="_blank">{$lang.here}</a> {$lang.tomanage}
            {else}{$lang.tryagainorsup}{/if}
        </div>
    {else}
        {literal}
            <script type="text/javascript">
                function priority_input(that) {
                    var prioin = $(that).parents('tr').find('.priorityin');
                    console.log(prioin);
                    $(that).val() == 'MX' || $(that).val() == 'SRV' ? prioin.prop('disabled', false).removeAttr('disabled') : prioin.prop('disabled', true).attr('disabled', 'disabled');
                }
                function record_toggle(elm){
                    var that = $(elm).parents('tr').eq(0);
                    if(!that.data('delete')){
                        var b = that.find('.recordhost').clone().addClass('clone').hide().val('');
                        that.find('input, select').prop('disable',true).attr('disabled','disabled');
                        b.insertAfter(elm);
                        that.data('delete',true);
                        $(elm).addClass('active');
                    }else{
                        that.find('.recordhost.clone').remove();
                        that.find('input, select').prop('disable',false).removeAttr('disabled');
                        that.data('delete',false);
                         $(elm).removeClass('active');
                    }
                }
            </script>
        {/literal}
        <form action="" method="post">
            <input type="hidden" name="submit" value="1" />
            <input type="hidden" name="widgetdo" value="updateDNSmanagement" />


            <table cellspacing="0" cellpadding="0" border="0" width="100%" class="checker table table-striped">
                {foreach from=$DNSmanagement.hosts key=number item=host name=frea}
                    {if $host.ttl}{assign var=ttl value=true}{/if}
                {/foreach}

                <tr>
                    <th>{$lang.hostname}</th>
                    <th style="width:40px">{$lang.priority}</th>
                    {if $ttl}
                        <th style="width:70px">{$lang.ttl|default:"TTL"}</th>
                    {/if}
                    <th style="width:40px">{$lang.recordtype}</th>
                    <th >{$lang.addresss}</th>
                    <th style="width:40px"></th>
                </tr>

                {foreach from=$DNSmanagement.hosts key=number item=host name=frea}
                    <tr {if $smarty.foreach.frea.iteration%2==0}class="even"{/if}>
                        <td>
                            <input type="text" class="styled recordhost" style="display: block;width: 95%" size="15" value="{$host.hostname|escape}" name="updateDNSmanagement[HostName{$number}]"/>
                        </td>
                        <td>
                            <input type="text" class="priorityin" style="width: 50px" size="3" {if $host.recordtype != 'MX' && $host.recordtype != 'SRV'}disabled="disabled"{/if} value="{$host.priority}" name="updateDNSmanagement[Priority{$number}]"/>
                        </td>
                        {if $ttl}
                            <td><input type="text" class="styled" style="display: block;width: 70px" value="{$host.ttl|escape}" name="updateDNSmanagement[TTL{$number}]"/></td>
                        {/if}
                        <td><select name="updateDNSmanagement[RecordType{$number}]"  class="span2 styled" onchange="priority_input(this)">
                                {foreach from=$DNSmanagement.records item=record}
                                    <option {if $host.recordtype == $record}selected="selected"{/if}>{$record}</option>
                                {/foreach}
                            </select>
                        </td>
                        <td><input type="text" class="styled" style="display: block;width: 95%" size="15" value="{$host.address|escape}" name="updateDNSmanagement[Address{$number}]"/></td>
                        <td><a class="btn btn-sm btn-danger deleteico" href="#" onclick="record_toggle(this); return false;"><i class="icon icon-trash delbtn material-icons notranslate">{if $tpl_name|strpos:"2019" !== false}delete{/if}</i></a></td>
                    </tr>
                {/foreach}
                <tr><td colspan="5"><strong>{$lang.newrecord}:</strong></td></tr>
                <tr>
                    <td><input type="text" class="styled" style="display: block;width: 95%" size="15" value="{$update.newHostName}" name="updateDNSmanagement[newHostName]"/></td>
                    <td>
                        <input type="text" class="priorityin" style="width: 50px" {if $DNSmanagement.records[0] != 'MX' && $DNSmanagement.records[0] != 'SRV'}disabled="disabled"{/if} size="3" name="updateDNSmanagement[newPriority]" value="{$update.newPriority}"/>
                    </td>
                    {if $ttl}
                        <td><input type="text" class="styled"  style="width: 70px;" name="updateDNSmanagement[newTTL]" value="{$update.newTTL}"/></td>
                    {/if}
                    <td><select  name="updateDNSmanagement[newRecordType]" class="span2 styled" onchange="priority_input(this)">
                            {foreach from=$DNSmanagement.records item=record}
                                <option {if $update.newRecordType == $record}selected{/if}>{$record}</option>
                            {/foreach}
                        </select>
                    </td>
                    <td colspan="2"><input type="text" class="styled" style="display: block;width: 95%" size="15" name="updateDNSmanagement[newAddress]" value="{$update.newAddress}"/></td>
                </tr>

                <tr  class="even"><td colspan="5" align="center"> <input type="submit"  value="{$lang.savechanges}" style="font-weight:bold" class=" btn btn-primary"/>
                        <span class="fs11">{$lang.or}</span> <a href="{$ca_url}clientarea/domains/{$details.id}/{$details.name}/" class="fs11">{$lang.cancel}</a></td></tr>
            </table>


        </form>
    {/if}
</div>
</div>