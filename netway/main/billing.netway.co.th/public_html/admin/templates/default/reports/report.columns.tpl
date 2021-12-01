<strong>Available columns</strong>
<div class="p5">
    <ul id="sortablea">
        {foreach from=$report.available_columns item=column}
            <li class="ui-state-highlight">{$column}<input type="hidden" name="columns[]" value="{$column}" /></li>
        {/foreach}
    </ul><div class="clear"></div>
</div>
<em>You can drag items between top/bottom list and change order</em><br/><br/>

<strong>Columns to export in report:</strong>
<div class="p5">
    <ul id="sortableb">

        {foreach from=$report.default_columns item=column}
            <li class="ui-state-highlight">{$column}<input type="hidden" name="export[]" value="{$column}" /></li>
        {/foreach}
    </ul>
    <div class="clear"></div>
</div>