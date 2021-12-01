{include file='shelf.tpl'}
    <div class="container-fluid" style="padding-top:14px;padding-bottom:14px;">

        <form action="?cmd=plesk_service_plan_sync&action=addserver" method="post"  style="margin-bottom: 10px;">
            <input type="hidden" name="configuration_id" value="{$config.id}" />
            <div class="row">
                <div class="col-md-6">
                    <div class="form-group">
                        <label>Add plesk connection to this configuration</label>
                        <select name="server_id" data-placeholder="Select server" class="form-control chosen-search">
                            {foreach from=$apps item=app}
                                <option value="{$app.id}">{$app.group.name} - {$app.name}</option>
                            {/foreach}
                        </select>
                    </div>
                </div>

            </div>
            <div class="row">
                <div class="col-md-12">
                    <button type="submit" class="btn btn-primary btn-sm">Add this server</button>
                </div>
            </div>

            {securitytoken}
        </form>
        <hr>


        <h3>Plesk connections in this config: </h3>
        <ul class="list-group" style="margin-bottom: 10px;">

            {foreach from=$config.items item=app}

                <li class="list-group-item {if $config.source_id == $app.id}list-group-item-info{elseif $app.metadata.different || $app.metadata.missing || $app.metadata.addons.missing || $app.metadata.addons.different}list-group-item-warning{elseif $app.metadata.simmilar}list-group-item-success{/if}">
                    <div class="row">
                        <div class="col-md-3 text-right pull-right">

                            {if $config.source_id != $app.id}
                                <a class="btn btn-default btn-xs "  href="?cmd=plesk_service_plan_sync&action=setsource&id={$app.id}&config_id={$config.id}&security_token={$security_token}">
                                    <i class="fa fa-star-o"></i> Set as source
                                </a>

                                <a href="#" class="btn btn-xs btn-default" data-toggle="modal" data-target="#over{$app.id}">Setup overrides</a>
                                {else}
                            {/if}
                            <a class="btn btn-default btn-xs " onclick="return confirm('Are you sure you want to remove this connection?');" href="?cmd=plesk_service_plan_sync&action=rmconfigitem&id={$app.id}&security_token={$security_token}">
                                <i class="fa fa-remove"></i>
                            </a>
                        </div>

                        <div class="col-md-2">
                            <a href="?cmd=servers&action=edit&id={$app.server.id}" target="_blank">{$app.server.name}</a><br/>{if $app.server.ip}{$app.server.ip}{else}{$app.server.host}{/if}
                        </div>


                        {if $config.source_id != $app.id}
                        <div class="col-md-3">
                            Last scanned: {if $app.last_synch!='0000-00-00 00:00:00'}{$app.last_synch|dateformat:$date_format}{else}Never{/if}
                            {if  $app.metadata.versions} <br/>
                                Plesk version:  <code>{$app.metadata.versions.target.plesk_version}</code>
                            {/if}
                        </div>

                        <div class="col-md-4">

                            {if  $app.metadata.missing}Missing plans: <strong>{$app.metadata.missing|@count}</strong>{/if}
                            {if  $app.metadata.different}Different plans: <strong>{$app.metadata.different|@count}</strong>{/if}
                            {if  $app.metadata.addons.missing}Missing addons: <strong>{$app.metadata.addons.missing|@count}</strong>{/if}
                            {if  $app.metadata.addons.different}Different addons: <strong>{$app.metadata.addons.different|@count}</strong>{/if}


                            {if $app.metadata.missing || $app.metadata.different || $app.metadata.addons.missing || $app.metadata.addons.different}<br/>
                                <a href="#" class="btn btn-xs btn-default" data-toggle="modal" data-target="#diff{$app.id}">Show differences</a>
                                <a href="?cmd=plesk_service_plan_sync&action=syncitem&id={$app.id}&config_id={$config.id}&security_token={$security_token}" class="btn btn-xs btn-info" onclick="return confirm('Are you sure? Missing plans will be created, differences will be removed');">Synchronize</a>
                            {/if}
                            {if $app.last_save}Last synced: {$app.last_save|dateformat:$date_format}{/if}
                        </div>
                            {else}
                           <div class="col-md-3"> {if $plesk.plesk_version}Plesk version:  <code>{$plesk.plesk_version}</code>{/if}</div>
                            <div class="col-md-3"><h3><i class="fa fa-star"></i> Source server</h3></div>
                        {/if}
                    </div>
                </li>

                <div class="modal fade" id="diff{$app.id}">
                    <div class="modal-dialog modal-lg" role="document">
                        <div class="modal-content">

                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                <h4 class="modal-title" id="myModalLabel">Differences report for target: {$app.server.name}</h4>
                            </div>
                            <div class="modal-body ">

                                {if $app.metadata.missing}
                                    <div class="row">
                                        <div class="col-md-12">
                                            <h3>Following plans exist on source but are missing on target:</h3>
                                            {foreach from=$app.metadata.missing item=diff}
                                                Plan: <strong>{$diff.name}</strong> <br/>
                                            {/foreach}
                                        </div>
                                    </div>
                                {/if}

                                {if $app.metadata.different}
                                    <div class="row">
                                        <div class="col-md-12">
                                            <h3>Following plans exist on source and target, but with different config:</h3>
                                            {foreach from=$app.metadata.different item=diff}
                                                Plan: <strong>{$diff.source.name}</strong> <br/>
                                                Differences found in: <div class="well">
                                                {foreach from=$diff.differences key=k item=v}
                                                    {$k}<br/>
                                                {/foreach}</div>
                                            {/foreach}
                                        </div>
                                    </div>
                                 {/if}

                                {if $app.metadata.addons.missing}
                                    <div class="row">
                                        <div class="col-md-12">
                                            <h3>Following addons exist on source but are missing on target:</h3>
                                            {foreach from=$app.metadata.addons.missing item=diff}
                                                Addon: <strong>{$diff.name}</strong> <br/>
                                            {/foreach}
                                        </div>
                                    </div>
                                {/if}

                                {if $app.metadata.addons.different}
                                    <div class="row">
                                        <div class="col-md-12">
                                            <h3>Following addons exist on source and target, but with different config:</h3>
                                            {foreach from=$app.metadata.addons.different item=diff}
                                                Addon: <strong>{$diff.source.name}</strong> <br/>
                                                Differences found in: <div class="well">
                                                {foreach from=$diff.differences key=k item=v}
                                                    {$k}<br/>
                                                {/foreach}</div>
                                            {/foreach}
                                        </div>
                                    </div>
                                {/if}

                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal fade" id="over{$app.id}">
                    <div class="modal-dialog modal-lg" role="document">
                        <div class="modal-content">
                            <form action="?cmd=plesk_service_plan_sync&action=saveoverride&config_id={$config.id}&id={$app.id}" method="post">

                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                <h4 class="modal-title" id="myModalLabel">Setup plan synch overrides for: {$app.server.name}</h4>
                                <p>Use form below to enter plan overrides in dotted notation (one per line). Overrides set here will be prevented from overwritting when creating/updating <strong>plans & addons</strong> on this server, as well as when comparing it with target server. This feature is useful if you're syncing plesk with minor configuration/version/extensions differences preventing from saving synced plans.</p>
                                <strong>Sample overrides</strong>
                                <div class="well">limits.limit.max_webapps<br/>
                                    limits.limit.cgroups_cpu_usage<br/>
                                    limits.limit.cgroups_cpu_usage_soft</div>
                            </div>
                                <div class="modal-body ">
                                    <div class="form-group type">
                                        <label class="control-label" for="override">Override:</label>
                                        <textarea name="overrides"  class="form-control" rows="15">{$app.overrides}</textarea>
                                    </div>

                            </div>
                            <div class="modal-footer">
                                <button type="submit" class="btn btn-success"">Save changes</button>
                                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                            </div>
                            {securitytoken}
                            </form>
                        </div>
                    </div>
                </div>
                {foreachelse}
                None yet
            {/foreach}
        </ul>


        {if $config.source_id}

        <div class="row">
            <div class="col-md-12">
                <a href="?cmd=plesk_service_plan_sync&action=startsync&id={$config.id}&security_token={$security_token}" class="btn btn-success btn" onclick="return confirm('Are you sure?');">Scan for differences</a>
            </div>
        </div>

            {else}
            Source server is not set, synchronisation is not possible
        {/if}
    </div>
