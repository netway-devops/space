{if $make=='getonappval' && $valx}
    {if $valx=='vdc' || $valx=='profile'}
        <select id="{$valx}" name="options[{$valx}]">
            <option value="">--- Select ---</option>
            {foreach from=$modvalues item=value}
                <option value="{$value.name}" {if $value.name==$defval}selected="selected"{/if}>{$value.name}</option>
            {/foreach}
        </select>
    {elseif $valx=='role' ||  $valx=='pool' }
        <select id="{$valx}" name="options[{$valx}]">
            {if $valx=='pool'}
                <option value="" {if !$defval}selected{/if}>--- None ---</option>
            {/if}
            {foreach from=$modvalues item=value}
                <option value="{$value.name}" {if $value.name==$defval}selected="selected"{/if}>{$value.name}</option>
            {/foreach}
        </select>
    {elseif $valx=='externalnet'}
        <select id="{$valx}" name="options[{$valx}][]" multiple class="form-control">
            <option value=""
                    {if !$defvalt || in_array('', $defval)}selected{/if}>Auto
            </option>
            {foreach from=$modvalues item=value}
                <option value="{$value.name}" {if in_array($value.name,$defval)}selected="selected"{/if}>
                    {$value.name}
                    [{$value.used}/{$value.ips}]
                </option>
            {/foreach}
        </select>
    {elseif $valx=='storageprofile'}
        <div class="row hidden-xs hidden-sm">
            <div class="col-md-3">Name</div>
            <div class="col-md-2">
                Ram Storage
                <a class="vtip_description"
                   title="Increase storage profile limits by the amount of RAM selected for client VDC."></a>
            </div>
            <div class="col-md-7 formcheck">Storage Limit</div>
            <input id="storageprofile" type="hidden" value="{$defval|@json_encode|escape}">
        </div>
        {foreach from=$modvalues item=opt key=k}
            <div class="row">

                <div class="col-md-3">
                    <strong>{$k}</strong>
                    {if !isset($default.storageprofile.$k)}
                        <em class="fs11" style="color:red">Unsaved</em>
                    {/if}
                </div>
                <div class="col-md-2">
                    <input type="checkbox" name="options[storageprofile_ram][{$k}]"
                           value="1" {if $default.storageprofile_ram.$k}checked{/if} />
                    <span class="hidden-lg hidden-md"> Ram Storage </span>
                </div>
                <div class="col-md-7">
                    <div class="formcheck">
                        <input type="text" name="options[storageprofile][{$k}]" value="{$defval.$k}"
                               id="profile_{$k|md5}"
                               class="col-md-2"/>
                        <span class="fs11">
                            <input type="checkbox" class="formchecker" rel="profile_{$k|md5}" data-name="{$k}"/>
                            Allow client to adjust with slider during order
                        </span>
                    </div>
                    <div class="overhead">
                        Increase Storage Limit by
                        <input type="text" size="3" name="options[overhead][storageprofile][{$k}]"
                               value="{$default.overhead.storageprofile.$k|default:0}"
                                pattern="^[\d\.\,]+%?$"/>
                        <a class="vtip_description">
                            <span>
                                Increase storage profile limits by specific amount.
                                You can use percentage or fixed value, for example:
                                <ul>
                                    <li>10% - will increase allocation by 10 percent</li>
                                    <li>10 - will increase allocation by 10 units</li>
                                </ul>
                            </span>
                        </a>
                    </div>
                </div>
            </div>
            {foreachelse}
            <div class="row">
                <div class="col-md-12">
                    No storage policies found in vCloud.
                </div>
            </div>
        {/foreach}
    {/if}
{elseif $make=='importformel' && $fid}
    <a href="#" onclick="return editCustomFieldForm('{$fid}', '{$pid}')" class="editbtn orspace">Edit related form
        element</a>
    {if $vartype=='os'}<a href="#" onclick="return updateOSList('{$fid}')" class="editbtn orspace">Update template list
        from Proxmox</a>{/if}
    <script type="text/javascript">editCustomFieldForm('{$fid}', '{$pid}');</script>
{/if}