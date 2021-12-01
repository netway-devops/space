{literal}
    <script type="text/javascript">
        $(function () {
            var type = $('#type').val();
            var ht;
            if (types[type] !== undefined) {
                for (var i = 0; i < types[type].length; i++) {
                    ht = types[type][i][0];
                    if (types[type][i][1] !== undefined)
                        ht += '<a class="vtip_description" style="margin-left: 20px;" title="' + types[type][i][1] + '"></a>';
                        $('#contentbox'+i).append('<label class="control-label">'+ht+'</label>');
                }
            }

        });
    </script>
{/literal}
<div class="row">
    <form action="" method="post" class="form-horizontal">
        <input id="type" type='hidden' name="type" value="{$record.type}" class="form-control" readonly>
        <div class="form-group">
            <label class="col-sm-2 control-label">{$lang.Name}:</label>
            <div class="col-sm-4">
                {if $record.type == 'SOA'}
                    <input type="text" name="name" value="{$record.name}" class="form-control" readonly>
                {else}
                    <input type="text" name="name" value="{$record.name}" class="form-control">
                {/if}
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">TTL:</label>
            <div class="col-sm-4">
                <select name="ttl" class="form-control">
                    <option value="600" {if $record.ttl == 600}selected{/if}>10 {if isset($lang.minutes)}{$lang.minutes}{else}Minutes{/if}</option>
                    <option value="3600" {if $record.ttl == 3600}selected{/if}>1 {if isset($lang.yhour)}{$lang.yhour}{else}Hour{/if}</option>
                    <option value="43200" {if $record.ttl == 43200}selected{/if}>12 {if isset($lang.yhour)}{$lang.yhour}{else}Hour{/if}</option>
                    <option value="86400" {if $record.ttl == 86400}selected{/if}>24 {if isset($lang.yhour)}{$lang.yhour}{else}Hour{/if}</option>
                    <option value="172800" {if $record.ttl == 172800}selected{/if}>48 {if isset($lang.yhour)}{$lang.yhour}{else}Hour{/if}</option>
                </select>
            </div>
            <a href="#" class="vtip_description" title="TTL settings define the frequency of website content updates."></a>
        </div>


        {if $record.type == 'MX' || $record.type == 'SRV'}

            <div class="form-group">
                <label class="col-sm-2 control-label">Priority:</label>
                <div class="col-sm-4">
                    <input type="text" name="priority" value="{$record.priority}" class="form-control">
                </div>
            </div>

        {elseif $record.type == 'CAA'}

            <div class="form-group">
                <label class="col-sm-2 control-label">Flags:</label>
                <div class="col-sm-4">
                    <input type="number" min="0" max="255" name="flags" value="{$record.flags}" class="form-control">
                </div>
            </div>

            <div class="form-group">
                <label class="col-sm-2 control-label">Tag:</label>
                <div class="col-sm-4">
                    <select name="tag" class="form-control">
                        <option {if $record.tag == "issue"} selected="selected" {/if} value="issue">issue</option>
                        <option {if $record.tag == "issuewild"} selected="selected" {/if} value="issuewild">issuewild</option>
                        <option {if $record.tag == "iodef"} selected="selected" {/if} value="iodef">iodef</option>
                    </select>
                </div>
            </div>

        {else}
            <input type='hidden' name="priority" value="{$record.prio}" class="form-control" readonly>


        {/if}

        {foreach from=$record.content item=content key=id name=foo}
            <div class="form-group">
                {if $smarty.foreach.foo.first}
                    <label class="col-sm-2 control-label">{$lang.Content}:</label>
                {else}
                    <span class="col-sm-2"></span>
                {/if}
                <div class="col-sm-4">
                    <input type="text" name="content[{$id}]" value="{$content|escape}" class="form-control">
                </div>
                <div id="contentbox{$id}" class="col-sm-4">

                </div>
            </div>
        {/foreach}

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