{literal}
    <style type="text/css">
        #msgcomposer input, #msgcomposer select, #msgcomposer textarea {
            float: none !important;
            clear: none !important;
            margin: auto !important;
        }

        .pricingtable input {
            float: none !important;
            margin: 0px !important;
        }

        .modernfacebox .form input, .modernfacebox .form select {
            margin: 2px 0 20px 10px !important;
        }

    </style>
{/literal}
<div id="formcontainer">
    <div id="formloader" style="background:#fff;padding:10px;">
        <form action="" method="post" id="saveform">
            <input type="hidden" name="product_id" value="{$product_id}"/>
            <input type="hidden" name="make" value="savechanges"/>
            <input type="hidden" name="action" value="savetask"/>
            <input type="hidden" name="id" value="{$task.id}"/>
            <input type="hidden" name="place" value="{$place}"/>

            <div class="tabb">
                {if $task.id}
                    <h3 style="margin:0px;">Edit task: {$task.name}</h3>
                    <div class="clear"></div>
                    <div style="margin:10px 0px">

                    </div>
                {else}
                    <h3 style="margin:0px;">Create new custom automation task</h3>
                    <div class="clear">
                        <small>You can schedule any taks to be executed automatically on certain events</small>
                    </div>
                {/if}

                <div id="task-errors" class="alert alert-danger" style="display: none;"></div>

                <div style="margin:10px 0px">
                    {if $task.id}
                        <div class="form-group">
                            <label class="nodescr">Task:</label>
                            <input type="text" disabled="disabled"
                                   value="{if $task.langid}{$lang[$task.langid]}{else}{$task.name}{/if}"
                                   class="form-control"/>
                        </div>
                    {else}
                        <div class="form-group">
                            <label class="nodescr">Task:</label>
                            <select class="form-control" name="task" id="tasklist-type" >
                                <option value="0">Select task type</option>
                                {foreach from=$tasks item=task key=k}
                                    <option value="{$k}">
                                        {if $task.langid}{$lang[$task.langid]}{else}{$task.name}{/if}
                                    </option>
                                {/foreach}
                            </select>
                        </div>
                    {/if}

                    <div id="taskoptions" class="tasklist-task-details">
                        {if $task.id}
                            {include file="tasklist/ajax.details.tpl"}
                        {/if}
                    </div>

                    {if !$task.id && $premade}
                        <div id="usepredefined" class="shownice tasklist-task-none" style="padding:5px; margin: -5px">
                            <div class="form-group">
                                <label>Premade tasks</label>
                                <div class="helper-block">
                                    To save configuration time you can use premade tasks
                                </div>
                                <select class="form-control" id="premade_val" name="premade">
                                    <option value="0">None</option>
                                    {foreach from=$premade item=p}
                                        <option value="{$p.file}">{$p.name}</option>
                                    {/foreach}
                                </select>
                            </div>
                        </div>
                    {/if}
                </div>
            </div>

            {securitytoken}
        </form>

        <div id="msgcomposer"></div>
    </div>
    <div class="dark_shelf dbottom">
        <div class="left spinner">
            <img src="ajax-loading2.gif">
        </div>
        <div class="pull-right">
            <span id="savechanges" style="display:none">
                <span class="btn btn-success btn-sm">
                    {if $task.id}
                        {$lang.savechanges}
                    {else}
                        {$lang.addnewtask}
                    {/if}
                </span>
                <span>{$lang.Or}</span>
            </span>
            <span class="btn btn-default btn-sm btn-close">
                <span>{$lang.Close}</span>
            </span>
        </div>
        <div class="clear"></div>
    </div>
</div>