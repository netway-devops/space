<link rel="stylesheet" href="{$template_dir}css/query-builder.default.css?v={$hb_version}" type="text/css" />
<script src="{$template_dir}js/querybuilder/query-builder.standalone.min.js?v={$hb_version}"></script>
<script src="{$template_dir}js/tasklist.js?v={$hb_version}" id="tasklist-js"
        data-place="{$place}"
        data-pid="{$product_id}"></script>

{if $tasks}
    <div class="service-task-list place-{$place|default:'services'}">
        <strong>Custom automation tasks</strong>
        <div class="panel">
            <ul>
                {foreach from=$tasks item=task}
                    <li class="havecontrols">
                        <div class="btn-group">
                            <a href="#" class="btn btn-default btn-xs" title="{$lang.Edit}" onclick="return HBTasklist.edit({$task.id}, {$product_id}{if $task.event == 'MetricTrigger'},'metrics'{/if});" >
                                <span class="fa fa-pencil"></span>
                            </a>
                            <a href="#" class="btn btn-default btn-xs" title="{$lang.Remove}" onclick="return HBTasklist.remove({$task.id});">
                                <span class="fa fa-trash"></span>
                            </a>
                        </div>
                        <span>
                            {if $task.event == 'MetricTrigger'}
                                {if $lang[$task.when]}  {$lang[$task.when]}
                                {else}  {$task.when}
                                {/if}

                                {$task.metric.name},
                                {if $task.metric.form}Form: {$task.metric.form.name},
                                {else}{$task.metric.limit} {$task.metric.unit}+,
                                {/if}
                                {$task.metric.trigger_period} {$lang.days}
                                -
                            {else}
                                {$task.interval}
                                {if $task.interval_type=='DAY'}{$lang.days}
                                {elseif $task.interval_type=='MINUTE'}{$lang.minutes}
                                {else}{$lang.hours}
                                {/if}

                                {if $lang[$task.when]}{$lang[$task.when]}
                                {else}{$task.when}
                                {/if}

                                {if $lang[$task.event]}{$lang[$task.event]}
                                {else}{$task.event}
                                {/if}
                                -
                            {/if}
                            {if $task.action_config.email_id}
                            <a href="?cmd=emailtemplates&action=edit&id={$task.action_config.email_id}" target="_blank">
                                {/if}
                                {if $task.langid} {$lang[$task.langid]}
                                {elseif $task.name}{$task.name}
                                {else}{$task.task}

                                {/if}
                                {if $task.action_config.email_id}</a>
                            {/if}
                        </span>
                    </li>
                {/foreach}
            </ul>
            <a id="addnew_addon_btn" onclick="return HBTasklist.assignNew();"
               class="btn btn-default btn-sm" href="#">
                <span class="fa fa-plus"></span> Add new custom task
            </a>
        </div>
    </div>
{/if}