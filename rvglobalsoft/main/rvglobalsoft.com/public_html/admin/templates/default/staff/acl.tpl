<div class="panel panel-default">
    <div class="panel-heading">
        <strong>{$lang.privileges}</strong>
    </div>
    <div class="panel-body" id="privileges">
        <div class="subhead">
            <strong>{$lang.premadepriv}</strong>
            <a href="#none" class="label label-default">{$lang.none}</a>
             &nbsp; &nbsp; &nbsp; <a href="#sales">Sales</a> 
             &nbsp; &nbsp; &nbsp; <a href="#operation">Operation technic</a> 
             &nbsp; &nbsp; &nbsp; <a href="#noc">NOC</a> 
             &nbsp; &nbsp; &nbsp; <a href="#accountant">Accountant</a> 
             &nbsp; &nbsp; &nbsp; <a href="#fullfillment">Fullfillment</a> 
            <!--
            <a href="#accounting" class="label label-default">{$lang.accounting}</a>
            <a href="#staff" class="label label-default">{$lang.Administrators}</a>
            -->
            <a href="#full" class="label label-default">{$lang.full_acces}</a>
        </div>
        {foreach from=$aStaffPrivs item=privs key=group}
        {*foreach from=$staff_privs item=privs key=group*}
            <div class="acl-group checkbox-group">
                <label class="legend">
                    <input type="checkbox" />{if isset($lang.$group)}{$lang.$group}{else}{$group}{/if}
                </label>
                <div class="fieldset">
                    {foreach from=$privs item=privopt key=priv name=loop}
                        <label {if $details.teamAccess[$privopt]}data-team="{$details.teamAccess[$privopt]|@json_encode|escape}"{/if} >
                            <input type="checkbox" name="access[]" value="{$privopt}" class="checker topChecker"
                                   {if $details.teamAccess[$privopt]}disabled{/if}
                                   {if $details.access && $privopt|in_array:$details.access}checked{/if}/>
                            {if $lang.$privopt}{$lang.$privopt}
                            {elseif isset($aWidgets.$privopt)}{$aWidgets.$privopt}
                            {elseif isset($aMenus.$privopt)}{assign var="x" value=$aMenus.$privopt}{if isset($lang.$x)}{$lang.$x}{else}{$aMenus.$privopt}{/if}
                            {elseif isset($aCategories.$privopt)}{$aCategories.$privopt}
                            {elseif isset($aSpecials.$privopt)}{$aSpecials.$privopt}
                            {else}{$privopt}{/if}
                        </label>
                        
                        {if isset($aExtendPrivs.$group.$privopt)}
                            {foreach from=$aExtendPrivs.$group.$privopt key=extKey item=extName}
                            <label class="{$privopt}" style="background-color:#ebb5b5;"><input type="checkbox" name="access[]" value="{$extKey}" class="checker" {if $details.access && $extKey|in_array:$details.access}checked="checked"{/if}/> {$extName}</label>
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
