{*debug output=ajax like=defval}
{debug output=ajax like=modvalues*}
{if $valx=='server'}
    <select class="form-control" name="options[server][]" id="server" multiple="multiple">
        <option value="Auto-Assign" {if in_array("Auto-Assign", $defval, true) || !$defval}selected="selected"{/if}>
            Auto-Assign
        </option>
        {foreach from=$modvalues item=tygroup key=title}
            <optgroup class="type_opt opt_{$title}"
                      label="{if $virttypes[$title]}{$virttypes[$title]}{else}{$title}{/if}">
                {foreach from=$tygroup item=value}
                    <option value="{$value.serid}"
                            {if in_array($value.serid, $defval, true)}selected="selected"{/if}>{$value.server_name}</option>
                {/foreach}
            </optgroup>
        {/foreach}
    </select>
{elseif $valx=='servergroup'}
    <select id="servergroup" name="options[servergroup][]" multiple class="form-control">
        <option class="odesc_ odesc_single_vm" value="-1" selected="selected">--none--</option>
        {if $modvalues}
            {foreach from=$modvalues item=value}
                <option value="{$value.sgid}"
                        {if (is_array($defval) && in_array($value.sgid, $defval)) || (!is_array($defval) && $defval == $value.sgid)}selected="selected"{/if}>{$value.sg_name}</option>
            {/foreach}
        {/if}
    </select>
{elseif $valx=='ippoolid' || $valx == 'internalippool' || $valx == 'recipe'  || $valx == 'bpid'}
    <select id="{$valx}" name="options[{$valx}]" class="form-control">
        <option value="">None</option>
        {foreach from=$modvalues item=value}
            <option value="{$value.id}"
                    {if $defval==$value.id}selected="selected"{/if}>{$value.name}</option>
        {/foreach}
    </select>
{elseif $valx=='mgs'}
    <select id="mgs" name="options[mgs][]" multiple class="form-control">
        {if $modvalues}
            {foreach from=$modvalues item=value}
                <option value="{$value.id}"
                        {if in_array($value.id, $defval)}selected="selected"{/if}>{$value.name}</option>
            {/foreach}
        {/if}
    </select>
{elseif $valx=='option4'}
    <select id="option4" name="options[option4]" class="form-control">
        {foreach from=$modvalues item=tygroup key=title}
            {counter name=ostplc print=false start=0 assign=ostplc}
            <optgroup class="type_opt opt_{$title}"
                      label="{if $virttypes[$title]}{$virttypes[$title]}{else}{$title}{/if}">
                {foreach from=$tygroup item=value}
                    {if $value}
                        {counter name=ostplc}
                        <option value="{$value.osid}"
                                {if $defval == $value.osid}selected="selected"{/if}>{$value.name}</option>
                    {/if}
                {/foreach}
                {if !$ostplc}
                    <option calue="">-- no templates available --</option>
                {/if}
            </optgroup>
        {/foreach}
    </select>
{elseif $valx=='vpsplan'}
    <select class="odesc_ odesc_single_vm disable_ disable_single_vm form-control" id="vpsplan" name="options[vpsplan]"
            onclick="return virtualizor.filter_types()">
        {if $modvalues}
            {foreach from=$modvalues item=tygroup key=title}
                {assign value=$title|replace:' ':'' var=vtype}
                <optgroup class="type_opt opt_{$title}"
                          label="{if $virttypes[$title]}{$virttypes[$title]}{else}{$title}{/if}">
                    {foreach from=$tygroup item=value}
                        <option value="{$value.plid}"
                                {if ( is_array($defval) && $defval[$title] == $value.plid) ||  $defval == $value.plid}selected="selected"{/if}>
                            {$value.plan_name}
                        </option>
                    {/foreach}
                </optgroup>
            {/foreach}
        {else}
            <option value="{if is_array($defval) && $defval[$title]}{$defval[$title]}{elseif $defval}{$defval}{/if}"
                    selected="selected">
                {if is_array($defval) && $defval[$title]}{$defval[$title]}
                {elseif $defval}{$defval}
                {else}--none--
                {/if}
            </option>
        {/if}
    </select>
    <div id="vpstypeplanscontainer" class="odesc_ odesc_cloud_vm disable_ disable_cloud_vm row">

        {foreach from=$modvalues item=tygroup key=title}
            <div class="type_opt opt_{$title} col-sm-6 col-md-4">
                <span>{if $virttypes[$title]}{$virttypes[$title]}{else}{$title}{/if}</span>
                <select name="options[vpsplan][{$title}]" class="form-control">
                    {if $tygroup}
                        {foreach from=$tygroup item=value}
                            <option value="{$value.plid}"
                                    {if (is_array($defval) && $defval[$title] == $value.plid) ||  $defval == $value.plid}selected="selected"{/if}>
                                {$value.plan_name}
                            </option>
                        {/foreach}
                    {else}
                        <option value="{if is_array($defval) && $defval[$title]}{$defval[$title]}{elseif $defval}{$defval}{/if}"
                                selected="selected">
                            {if is_array($defval) && $defval[$title]}{$defval[$title]}
                            {else}--none--
                            {/if}
                        </option>
                    {/if}
                </select>
            </div>
        {/foreach}
        <div class="type_opt opt_none col-md-12">
            Select at least one VPS type.
        </div>
    </div>
{literal}
    <script type="text/javascript">
        virtualizor.filter_types();
    </script>
{/literal}
{elseif $make=='importformel' && $fid}
    <a href="#" onclick="return editCustomFieldForm('{$fid}', '{$pid}')" class="editbtn orspace">Edit related form
        element</a>
    {if $vartype=='os'}<a href="#" onclick="return virtualizor.updateOSList('{$fid}')" class="editbtn orspace">Update
        template list
        from OnApp</a>{/if}
{/if}
