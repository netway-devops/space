{literal}
        <script type="text/javascript">
        $(function() {
            var type = $('#type').val();
            $('#contentbox').html(getRecordContentHtml(type));
            if(typeof $.fn.tooltip === 'function'){
                $('.vtip_description').tooltip();
            }
        });
        </script>
    {/literal}
    <form action="" method="POST">
        <input id="type" type="hidden" name="type" value="{$r_type}" />
        {if $domid}
            <input type="hidden" name="dom" value="{$domid}" />
        {/if}
        <div class="wbox">
            <div class="wbox_header"><strong>{$lang.addnew} '{$r_type}' {$lang.record}</strong></div>
            <div class="wbox_content">
                <div class="recordbox form-inline" style="line-height:26px">  
                    <label>{$lang.name}:</label>
                    {if $sected_domains}
                        <a href="#" class="editbtn" onclick="$('.owname').show();$(this).hide();$('input[name=\'namesover\']').val('1');return false">
                           {$lang.defaultnames}
                        </a>
                        <input type="hidden" value="0" name="namesover" >
                    {/if}
                    <input type="text" name="name" value="" class="form-control w-auto styled {if $sected_domains}owname{/if}" />{if $r_type != 'PTR' && !$sected_domains && $domname}.{$domname}{/if}
                </div>
                <div class="recordbox">
                    <label>TTL</label>
                    <select class="form-control w-auto styled" name="ttl" >
                        <option value="600">10 {$lang.minutes}</option>
                        <option value="3600">1 {$lang.yhour}</option>
                        <option value="43200">12 {$lang.yhours}</option>
                        <option value="86400">24 {$lang.yhours}</option>
                        <option value="172800">48 {$lang.yhours}</option>
                    </select> <a class="vtip_description" title="{$lang.ttlfeqdescription}"></a>
                </div>
                {if $r_type == 'MX' || $r_type == 'SRV'}
                    <div class="recordbox">
                        <label>{$lang.priority}</label>
                        <input type="text" name="priority" value="0" class="form-control w-auto styled" />
                        {if  $r_type == 'MX'}
                            <a class="vtip_description" title="{$lang.prioritysettingdesc}"></a>
                        {/if}
                    </div>
                {/if}
                <div class="recordbox">
                    <label>{$lang.content}</label>
                    <div id="contentbox">

                    </div>
                </div>
                <center>
                    <input type="submit" class="btn btn-primary" name="submit" value="{$lang.submit}" style="padding:4px 3px;font-weight:bold;font-size:12px" /> &nbsp; &nbsp;
                    <a href="{$service_url}{if $domid}&act=dns_manage&domain_id={$domid}{/if}">{$lang.cancel}</a>
                </center>
            </div>
        </div>

        {if $sected_domains}
            <div class="wbox">
                <div class="wbox_header">{$lang.bulkdomains}</div>
                <div class="wbox_content">
                    {foreach from=$sected_domains item=domain name=row}
                        <div {if  $smarty.foreach.row.index == 0}class="first"{/if}><input type="checkbox" value="{$domain.$domain_indent}" name="dom[]" checked="checked"/>
                            {$domain.domain}
                        </div>
                    {/foreach}
                </div>
            </div>
        {/if}
        {securitytoken}
    </form>