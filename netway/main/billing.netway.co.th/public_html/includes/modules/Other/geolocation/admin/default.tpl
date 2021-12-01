<script type="text/javascript" src="{$moduleurl}script.js"></script>
<link media="all" type="text/css" rel="stylesheet" href="{$moduleurl}styles.css"/>

<div class="newhorizontalnav" id="newshelfnav">
    <div class="list-1">
        <ul>
            <li {if !$action || $action == 'default'}class="active"{/if}>
                <a href="?cmd=geolocation"><span>Geo Rules</span></a>
            </li>
            {*<li class="last{if $action == 'database'} active{/if}">*}
                {*<a href="?cmd=geolocation&action=database"><span>Geo Database</span></a>*}
            {*</li>*}
        </ul>
    </div>
</div>
<div class="sectioncontent geo-rules">
    <div id="geo-list" {if !$rules}style="display:none"{/if}>
        <ul class="grab-sorter{if !$rules} empty blank_news{/if}"  >
            {include file='ajax.default.tpl'}
        </ul>
        <a id="addnew_btn" onclick="geolocation.newform(); return false;" class="new_control" href="#">
            <span class="addsth">Create new geo rules</span>
        </a>
    </div>
    {if !$rules}
        <div id="blank_state" class="blank_state blank_news">
            <div class="blank_info">
                <h1> Target your customers directly based on their location </h1>
                With HostBill you can set appropriate user language, currency or available gateways for your client basing on their location
                <div class="clear"></div>
                <a class="new_add new_menu" href="#" onclick="geolocation.newform(); $('#blank_state').hide(); $('#geo-list').show(); return false;" style="margin-top:10px">
                    <span>Add new rule</span></a>
                <div class="clear"></div>
            </div>
        </div>
    {/if}
    <form action="?cmd=geolocation&action=add" method="post" onsubmit="geolocation.submit(this); return false;" style="display: none;" id="geoform">
        <div class="geo-new-rule">
            <div class="geo-loc left">
                <h3>Location <img src="{$template_dir}img/ajax-loader3.gif" style="display:none" class="ajax-load" /></h3>
                <label>
                    <span>Country</span>
                    <select name="country" class="load-values inp">
                        <option value=""> Not selected </option>
                        {foreach from=$countries item=country key=code}
                            <option value="{$code}">{$country}</option>
                        {/foreach}
                    </select>
                </label>
                <label>
                    <span>Region</span>
                    <input type="text" name="region" class="load-values inp">
                    {*<select name="region" class="load-values inp">*}
                    {*<option value=""> All </option>*}
                    {*</select>*}
                </label>
                <label>
                    <span>City</span>
                    <input type="text" name="city" class="load-values inp">
                    {*<select name="city" class="load-values inp">*}
                    {*<option value=""> All </option>*}
                    {*</select>*}
                </label>
            </div>
            <div class="geo-actions left">
                <h3>Actions</h3>
                <label>
                    <span>Set language</span>
                    <select name="language" class="inp">
                        <option value=""> Default </option>
                        {foreach from=$languages item=language}
                            <option value="{$language}"> {$language|capitalize} </option>
                        {/foreach}
                    </select>
                </label>
                <label>
                    <span>Set currency</span>
                    <select name="currency" class="inp">
                        {foreach from=$currencies item=crr}
                            <option value="{$crr.id}"> {$crr.code} {if $crr.sign}( {$crr.sign} ){/if} </option>
                        {/foreach}
                    </select>
                </label>
                <div class="geo-label-lkie">
                    <span>Payment gateways</span>
                    {if $modules}
                        <label><input class="geo-all-gates" type="checkbox" name="gates[]" checked="checked" value="all" onchange="geolocation.gates(this);" /> All gateways</label>
                        <div class="geo-gates" style="display:none">
                            {foreach from=$modules item=gateway key=id}
                                <label><input type="checkbox" name="gates[]" checked="checked" value="{$id}" onchange="geolocation.gates(this);"/> {$gateway}</label>
                            {/foreach}
                        </div>
                    {else}
                        <a href="?cmd=managemodules&action=payment"> No active payment gateways</a>
                    {/if}
                </div>
            </div>
            <div class="clear"></div>
            <input type="submit" class="btn btn-success btn-sm" value="Submit"/>
            <input type="submit" class="btn btn-default btn-sm" onclick="geolocation.cancel(); return false;" value="Cancel"/>
        </div>
        {securitytoken}
    </form>
</div>

