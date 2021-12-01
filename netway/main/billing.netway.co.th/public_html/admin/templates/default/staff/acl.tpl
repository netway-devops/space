<div class="panel panel-default">
    <div class="panel-heading">
        <strong>{$lang.privileges}</strong>
    </div>
    <div class="panel-body" id="privileges">
        <div class="subhead">
            <strong>{$lang.premadepriv}</strong>
            <a href="#none" class="label label-default">{$lang.none}</a>
            <a href="#accounting" class="label label-default">{$lang.accounting}</a>
            <a href="#staff" class="label label-default">{$lang.Administrators}</a>
            <a href="#full" class="label label-default">{$lang.full_acces}</a>
        </div>
        {foreach from=$staff_privs item=privs key=group}
            <div class="acl-group checkbox-group">
                <label class="legend">
                    <input type="checkbox"/>{$lang.$group} {if ! $lang.$group}{$group}{/if}
                </label>
                <div class="fieldset">
                    {foreach from=$privs item=privopt key=priv name=loop}

                    {assign var="isExisted" value=0}
                    {foreach from=$aExtendPrivs.$group item=arr}
                        {if isset($arr.$privopt)}{assign var="isExisted" value=1}{break}{/if}
                    {/foreach}
                    {if $isExisted}
                        {continue}
                    {/if}

                        <label {if $details.teamAccess[$privopt]}data-team="{$details.teamAccess[$privopt]|@json_encode|escape}"{/if} {if $risk_acl[$privopt]}class="text-danger"{/if}>
                            <input type="checkbox" name="access[]" value="{$privopt}" class="checker"
                                   {if $details.teamAccess[$privopt]}disabled{/if}
                                   {if $details.access && $privopt|in_array:$details.access}checked{/if}/>

                            {if $lang.$privopt}{$lang.$privopt}{else}{$privopt}{/if}
                            {if $risk_acl[$privopt]} {assign var="risk2" value=$risk_acl.$privopt}<i class="fa fa-exclamation-circle riskyacl " title="{$lang.$risk2}"></i>{/if}


                        </label>

{* custom code มีการเพิ่ม aExtendPrivs *}

                        {if isset($aExtendPrivs.$group.$privopt)}
                            {foreach from=$aExtendPrivs.$group.$privopt key=extKey item=extName}
                            <label class="{$privopt}" style="background-color:#ebb5b5;">
                                <input type="checkbox" name="access[]" value="{$extKey}" class="checker" {if $details.access && $extKey|in_array:$details.access}checked="checked"{/if}/> 
                                {$extName}
                            </label>
                            {/foreach}
                        {/if}

                    {/foreach}
                </div>
            </div>
        {/foreach}
    </div>
    <div class="panel-footer">
        <button type="submit" value="1" name="save"
                class="btn btn-primary">{$lang.savechanges}</button>
        <span
                class="orspace">{$lang.Or} <a href="?cmd=editadmins" class="editbtn">{$lang.Cancel}</a></span>
    </div>
</div>
