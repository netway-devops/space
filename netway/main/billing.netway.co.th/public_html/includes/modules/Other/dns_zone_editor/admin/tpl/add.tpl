{literal}
    <script type="text/javascript">
        $(function() {
            var type = $('#type').val();
            var ht;
            if(types[type]!==undefined){
                for(var i=0;i<types[type].length;i++){
                    ht = '<div class="form-group">';
                    if (i == 0){
                        ht += '<label class="col-sm-2 control-label">Content:</label>';
                    }else{
                        ht += '<span class="col-sm-2"></span>';
                    }
                    ht += '<div class="col-sm-4"><input name="content['+i+']" type="text" class="form-control" ></div><div id="contentbox\'+i+\'" class="col-sm-4"><label class="control-label"> ';
                    ht += types[type][i][0];
                    if(types[type][i][1]!==undefined)
                        ht += '<a class="vtip_description" style="margin-left: 20px;" title="'+types[type][i][1]+'"></a></label></div></div>';
                    ht += '<br>';

                    if(i==0) $('#contentbox').html(ht);
                    else $('#contentbox').append(ht);
                }
            }
        });
    </script>
{/literal}
<div class="row">
    <form action="" method="post" class="form-horizontal">
        <input id="type" type='hidden' name="type" value="{$params.type}" class="form-control" readonly>
        <input type='hidden' name="server_id" value="{$params.server_id}" class="form-control" readonly>
        <input type='hidden' name="domain_id" value="{$params.domain_id}" class="form-control" readonly>
        <div class="form-group">
            <label class="col-sm-2 control-label">{$lang.Name}:</label>
            <div class="col-sm-4">
                <input type="text" name="name" value="" class="form-control">
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">TTL:</label>
            <div class="col-sm-4">
                <select name="ttl" class="form-control">
                    <option value="600">10 {if isset($lang.minutes)}{$lang.minutes}{else}Minutes{/if}</option>
                    <option value="3600">1 {if isset($lang.yhour)}{$lang.yhour}{else}Hour{/if}</option>
                    <option value="43200">12 {if isset($lang.yhour)}{$lang.yhour}{else}Hour{/if}</option>
                    <option value="86400">24 {if isset($lang.yhour)}{$lang.yhour}{else}Hour{/if}</option>
                    <option value="172800">48 {if isset($lang.yhour)}{$lang.yhour}{else}Hour{/if}</option>
                </select>
            </div>
            <a href="#" class="vtip_description" title="TTL settings define the frequency of website content updates."></a>
        </div>

        {if $params.type == 'MX' || $params.type == 'SRV'}

            <div class="form-group">
                <label class="col-sm-2 control-label">Priority:</label>
                <div class="col-sm-4">
                    <input type="text" name="priority" value="" class="form-control">
                </div>
            </div>

        {elseif $params.type == 'CAA'}

            <div class="form-group">
                <label class="col-sm-2 control-label">Flags:</label>
                <div class="col-sm-4">
                    <input type="number" min="0" max="255" name="flags" value="" class="form-control">
                </div>
            </div>

            <div class="form-group">
                <label class="col-sm-2 control-label">Tag:</label>
                <div class="col-sm-4">
                    <select name="tag" class="form-control">
                        <option value="issue">issue</option>
                        <option value="issuewild">issuewild</option>
                        <option value="iodef">iodef</option>
                    </select>
                </div>
            </div>

        {else}
            <input type='hidden' name="priority" value="" class="form-control" readonly>

        {/if}
        <span id="contentbox">

        </span>

        <div class="form-group">
            <div class="col-sm-offset-2 col-sm-1">
                <button type="submit" name="submit" value="true" class="btn btn-success">{$lang.submit}</button>
            </div>
            <div class="col-sm-1" style="margin-top: 6px;">
                <a class="button" href="?cmd={$modulename}&action=show&zone_id={$params.domain_id}&server_id={$params.server_id}&security_token={$security_token}">Cancel</a>
            </div>
        </div>
        {securitytoken}
    </form>
</div>
