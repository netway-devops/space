
{literal}
    <script type="text/javascript">
        $(function () {
            var type = $('#type').val();
            $('#contentbox').html(getRecordContentHtml(type));

            if(typeof $.fn.tooltip === 'function'){
                $('.vtip_description').tooltip();
            }
        });
    </script>
{/literal}
<form action="" method="POST">
    <input id="type" type="hidden" name="type" value="{$record.type}" />
    <input type="hidden" name="dom" value="{$domid}" />

    <div class="wbox">
        <div class="wbox_header"><strong>{$lang.editrecord}</strong></div>
        <div class="wbox_content">
            <div class="recordbox">
                <label>{$lang.name}:</label>
                <input type="text" name="name" value="{$record.name}" class="styled" {if $record.type == 'SOA'}readonly{/if} />
            </div>
            <div class="recordbox">
                <label>TTL</label>
                <select class="form-control w-auto styled" name="ttl" >
                    <option {if $record.ttl == '600'}selected="selected"{/if} value="600">10 {$lang.minutes}</option>
                    <option {if $record.ttl == '3600'}selected="selected"{/if} value="3600">1 {$lang.yhour}</option>
                    <option {if $record.ttl == '43200'}selected="selected"{/if}value="43200">12 {$lang.yhours}</option>
                    <option {if $record.ttl == '86400'}selected="selected"{/if} value="86400">24 {$lang.yhours}</option>
                    <option {if $record.ttl == '172800'}selected="selected"{/if} value="172800">48 {$lang.yhours}</option>
                </select> <a class="vtip_description" title="{$lang.ttlfeqdescription}"></a>
            </div>
            {if $record.type == 'MX' || $record.type == 'SRV'}
                <div class="recordbox">
                    <label>{$lang.priority}</label>
                    <input type="text" name="priority" value="{$record.priority}" class="form-control w-auto styled" /> <a class="vtip_description" title="{$lang.prioritysettingdesc}"></a>
                </div>
            {/if}
            <div class="recordbox">
                <label>{$lang.content}</label>
                <div id="contentbox">
                    {foreach from=$record.content item=content key=ky}
                        <input type="text" name="content[{$ky}]" class="form-control w-auto styled" value="{$content|escape}" /> <br>
                    {/foreach}
                </div>
            </div>
            <center>
                <input type="submit" class="btn btn-primary" name="submit" value="{$lang.submit}" style="padding:4px 3px;font-weight:bold;font-size:12px" /> &nbsp; &nbsp;
                <a href="{$service_url}{if $domid}&act=dns_manage&domain_id={$domid}{/if}">{$lang.cancel}</a>
            </center>
        </div>
    </div>
    {securitytoken}
</form>