{include file="head.tpl"}

<div style="padding:0 10px; margin-top: 15px;">

    <form action="" method="POST" id="doc-file">
        <div class="panel panel-default">
            <div class="panel-body">
                <div class="form-group">
                    <label for="">Name</label>
                    <input type="text" name="name" value="{$hook.name}" class="form-control"/>
                </div>
                <div class="form-group">
                    <label for="urlinput">URL to be called</label>
                    <input type="text" name="url" value="{$hook.url}" id="urlinput" class="form-control" required
                           pattern="https?://.+" placeholder="https://example.com/webhook"/>
                    <div class="checkbox">
                        <label>
                            <input type="checkbox" name="options[verifyssl]" value="1"
                                   {if $hook.options.verifyssl}checked{/if}>
                            Verify SSL certificate
                        </label>
                    </div>
                </div>
                <div class="row">
                    <div class="form-group col-md-6">
                        <label for="urlinput">Status</label>
                        <select class="form-control" name="options[active]">
                            <option value="1">Active</option>
                            <option value="0">Disabled</option>
                        </select>
                    </div>
                    <div class="form-group col-md-6">
                        <label for="urlinput">Request Content type</label>
                        <div class="radio">
                            <label>
                                <input type="radio" name="content" value="json"
                                       {if $hook.content == 'json'}checked{/if}>
                                application/json
                            </label>
                        </div>
                        <div class="radio">
                            <label>
                                <input type="radio" name="content" value="form"
                                       {if $hook.content == 'form'}checked{/if}>
                                application/x-www-form-urlencoded
                            </label>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <label>Events</label>
                    <select class="form-control" name="events[]" multiple id="select-events" data-placeholder="All events" >
                        <option value="all" {if !$hook.events}selected{/if} >All events</option>
                        {foreach from=$events item=group key=gname}
                            <optgroup label="{$gname}">
                                {foreach from=$group item=event key=handle}
                                    <option value="{$handle}" {if in_array($handle, $hook.events)}selected{/if} >{$event.name}</option>
                                {/foreach}
                            </optgroup>
                        {/foreach}
                    </select>
                </div>
            </div>
            <div class="panel-footer">
                <button class="btn btn-primary" type="submit" name="save" value="1">Save</button>
                or
                {if $hook.id}
                    <a href="?cmd={$modulename}&action=document&id={$hook.id}">Cancel</a>
                {else}
                    <a href="?cmd={$modulename}">Cancel</a>
                {/if}
            </div>
        </div>
        {securitytoken}
    </form>
</div>
<script type="text/javascript" src="{$moduleurl}webhooks.js"></script>



