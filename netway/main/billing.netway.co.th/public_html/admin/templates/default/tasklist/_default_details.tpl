<div>
    <label class="nodescr">Execute</label>
    <div class="row">
        <div class="form-group col-md-2">
            <input name="days" size="2"
                   value="{if isset($task.interval)}{$task.interval}{else}1{/if}"
                   type="number" class="form-control"/>
        </div>
        <div class="form-group col-md-2">
            <select name="interval_type" id="interval_type" class="form-control">
                <option value="DAY"
                        {if $task.interval_type=='DAY'}selected="selected"{/if}>
                    {$lang.days}
                </option>
                <option value="HOUR"
                        {if $task.interval_type=='HOUR'}selected="selected"{/if}>
                    {$lang.hours}
                </option>
                <option value="MINUTE"
                        {if $task.interval_type=='MINUTE'}selected="selected"{/if}
                        {if $task.when=='before' or !$task.id}style="display:none"{/if}>
                    {$lang.minutes}
                </option>
            </select>
        </div>
        <div class="form-group col-md-2">
            <select name="when" class="form-control tasklist-task-when">
                {if $task.havebefore}
                    <option value="before"
                            {if $task.when=='before'}selected="selected"{/if}>
                        {$lang.before}
                    </option>
                {/if}
                {if $task.haveafter}
                    <option value="after"
                            {if $task.when=='after'}selected="selected"{/if}>
                        {$lang.after}
                    </option>
                {/if}
            </select>
        </div>
        <div class="form-group col-md-4">
            {if $task.havebefore}
                <select name="what_before" id="what_before"
                        {if $task.when=='after'}style='display:none'{/if} class="form-control">
                    {foreach from=$task.events item=event key=eventname}
                        {if $event.before}
                            <option value="{$eventname}"
                                    {if $eventname==$task.event}selected="selected"{/if}>
                                {if $lang[$eventname]}{$lang[$eventname]}{else}{$eventname}{/if}
                            </option>
                        {/if}
                    {/foreach}
                </select>
            {/if}
            {if $task.haveafter}
                <select name="what_after" id="what_after"
                        {if $task.havebefore && $task.when!='after'}style="display:none"{/if}
                        class="form-control">
                    {foreach from=$task.events item=event key=eventname}
                        {if $event.after}
                            <option value="{$eventname}"
                                    {if $eventname==$task.event}selected="selected"{/if}>
                                {if $lang[$eventname]}{$lang[$eventname]}{else}{$eventname}{/if}
                            </option>
                        {/if}
                    {/foreach}
                </select>
            {/if}
        </div>
    </div>
</div>