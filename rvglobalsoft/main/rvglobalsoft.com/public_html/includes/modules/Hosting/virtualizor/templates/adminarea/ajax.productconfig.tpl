{*debug output=ajax like=defval}
{debug output=ajax like=modvalues*}
{if $valx=='server'} 
    <select class="multi" name="options[server][]" id="server" multiple="multiple" >
        <option value="Auto-Assign" {if in_array("Auto-Assign", $defval, true) || !$defval}selected="selected"{/if}>Auto-Assign</option>
        {foreach from=$modvalues item=tygroup key=title}
            <optgroup class="opt_{$title}" label="{if $title == 'xen'}Xen PV{elseif $title == 'xenhvm'}Xen HVM{elseif $title == 'openvz'}OpenVZ{elseif $title == 'kvm'}KVM{/if}">
                {foreach from=$tygroup item=value}
                    <option value="{$value.serid}" {if in_array($value.serid, $defval, true)}selected="selected"{/if}>{$value.server_name}</option>
                {/foreach}
            </optgroup>
        {/foreach}
    </select>
{elseif $valx=='servergroup'}
    <select id="servergroup" name="options[servergroup]">
        <option value="-1" selected="selected">--none--</option>
        {if $modvalues}
            {foreach from=$modvalues item=value}
                    <option value="{$value.sgid}" {if $defval == $value.sgid}selected="selected"{/if}>{$value.sg_name}</option>
            {/foreach}
        {/if}
    </select>
{elseif $valx=='option4'} 
    <select id="option4" name="options[option4]">
        {foreach from=$modvalues item=tygroup key=title}
            {counter name=ostplc print=false start=0 assign=ostplc}
            <optgroup class="opt_{$title}" label="{if $title == 'xen'}Xen PV{elseif $title == 'xen hvm'}Xen HVM{elseif $title == 'openvz'}OpenVZ{elseif $title == 'kvm'}KVM{/if}">
                {foreach from=$tygroup item=value}
                    {if $value}
                        {counter name=ostplc}
                        <option value="{$value.osid}" {if $defval == $value.osid}selected="selected"{/if}>{$value.name}</option>
                    {/if}
                {/foreach}
                {if !$ostplc}
                    <option calue="">-- no templates available --</option>
                {/if}
            </optgroup>
        {/foreach}
    </select>
{elseif $valx=='vpsplan'} 
    <select id="vpsplan" name="options[vpsplan]">
        {if $modvalues}
            {foreach from=$modvalues item=tygroup key=title}
                {assign value=$title|replace:' ':'' var=vtype}
                <optgroup class="opt_{$vtype}" label="{if $title == 'xen'}Xen PV{elseif $title == 'xenhvm'}Xen HVM{elseif $title == 'openvz'}OpenVZ{elseif $title == 'kvm'}KVM{/if}">
                    {foreach from=$tygroup item=value}
                        <option value="{$value.plid}" {if ( is_array($defval) && $defval[$vtype] == $value.plid) ||  $defval == $value}selected="selected"{/if}>{$value.plan_name}</option>
                    {/foreach}
                </optgroup>
            {/foreach}
        {else} <option value="{if is_array($defval) && $defval[$vtype]}{$defval[$vtype]}{elseif $defval}{$defval}{/if}" selected="selected">{if is_array($defval) && $defval[$vtype]}{$defval[$vtype]}{elseif $defval}{$defval}{else}--none--{/if}</option>
        {/if}
    </select>
    {literal}
        <script type="text/javascript" >
            filter_types();
        </script>
    {/literal}
{elseif $make=='importformel' && $fid}
    <a href="#" onclick="return editCustomFieldForm('{$fid}','{$pid}')" class="editbtn orspace">Edit related form element</a>
    {if $vartype=='os'}<a href="#" onclick="return updateOSList('{$fid}')" class="editbtn orspace">Update template list from OnApp</a>{/if}
{/if}
