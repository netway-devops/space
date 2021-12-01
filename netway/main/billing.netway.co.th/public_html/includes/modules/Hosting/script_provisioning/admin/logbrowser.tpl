<a name="scriptlogs"></a><div style="margin:10px 0px;">
    <ul class="accor">
        <li>
            <a>Script Provisioning Logs</a>
            <div class="sor">

                <div class="blu">

                    <div class="right">

                        <a class="btn btn-default btn-sm" href="?cmd=accounts&action=edit&id={$id}#scriptlogs">First page</a>
                        <a class="btn btn-default btn-sm" href="?cmd=accounts&action=edit&id={$id}&offset={$next_offset}#scriptlogs">Next page</a>
                    </div>
                    <div class="clear"></div>
                </div>

                    <table cellspacing="0" cellpadding="3" border="0" width="100%" class="table glike hover">
                        <tbody>
                        <tr>
                            <th>Date</th>
                            <th>Module</th>
                            <th>Level</th>
                            <th>Message</th>
                            <th>Metadata</th>

                        </tr>
                        </tbody>
                        <tbody >

                        {foreach from=$logs item=email key=r}
                            <tr>

                                <td>{$email.date|dateformat:$date_format}</td>
                                <td>{$email.module}</td>
                                <td><label class="label label-{if $email.level=='DEBUG'}default{elseif $email.level=='INFO'}primary{elseif $email.level=='WARNING'}warning{else}danger{/if}">{$email.level}</label></td>
                                <td>{$email.body}</td>

                                <td>{if $email.data!='null' && $email.data!='[]'}
                                        <a href="#" class="btn btn-xs btn-default"
                                           onclick="return showDebug('{$email.body|escape:'javascript'}','#metadata-{$r}')" >View</a>
                                    <div id="metadata-{$r}" style="display: none" ><pre>{$email.data|escape}</pre></div>{/if}</td>

                            </tr>
                            {foreachelse}
                            <tr><td colspan="5">{$lang.nothingtodisplay} </td></tr>
                        {/foreach}

                        </tbody>

                    </table>

                <div class="blu">

                    <div class="right">

                        <a class="btn btn-default btn-sm" href="?cmd=accounts&action=edit&id={$id}#scriptlogs">First page</a>
                        <a class="btn btn-default btn-sm" href="?cmd=accounts&action=edit&id={$id}&offset={$next_offset}#scriptlogs">Next page</a>
                    </div>
                    <div class="clear"></div>
                </div>
            </div>
        </li>
    </ul>
</div>
{literal}
    <script>
        function showDebug(msg,el) {
            bootbox.dialog({
                title: msg,
                onEscape: true,
                size: 'large',
                message: $(el).clone().show(),
            });
            return false;
        }
    </script>{/literal}