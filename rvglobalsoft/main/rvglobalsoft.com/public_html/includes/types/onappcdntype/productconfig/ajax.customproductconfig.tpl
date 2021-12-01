{if $make=='getonappval' && $valx}
    {if $valx=='option21'} {*  edge groups  *}

        <select id="option21" multiple class="multi" name="options[option21][]">
            <option value="All" {if in_array('All',$defval)}selected="selected"{/if}>All</option>
            {foreach from=$modvalues item=value}
            <option value="{$value[0]}" {if in_array($value[0],$defval)}selected="selected"{/if}>{$value[1]}</option>
            {/foreach}
        </select>
    {elseif $valx=='option22'} {*  locations *}

        <select id="option22" multiple class="multi" name="options[option22][]">
            {foreach from=$modvalues item=value}
            <option value="{$value[0]}" {if in_array($value[0],$defval)}selected="selected"{/if}>{$value[1]}, price: {$value[2]}</option>
            {/foreach}
        </select>

     {elseif $valx=='option1'}    {*  user role  *}

        <select id="option1" name="options[option1]">
            {foreach from=$modvalues item=value}
            <option value="{$value[0]}" {if $value[0]==$defval}selected="selected"{/if}>{$value[1]}</option>
            {/foreach}
        </select>
    {/if}
{elseif $make=='importformel' && $fid}
<a href="#" onclick="return editCustomFieldForm('{$fid}','{$pid}')" class="editbtn orspace">Edit related form element</a>
<script type="text/javascript">editCustomFieldForm('{$fid}','{$pid}');</script>
{/if}