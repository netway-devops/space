{literal}<style>
    .power_ok {font-weight:bold;background:#BBDD00;}
    .power_no {font-weight:bold;background:#AAAAAA;}
</style>{/literal}
Dedicated Servers &amp; Colocation Manager consist growing number of auxilary modules, below you can check configuration status of each one of them
<br/><br/>
<ul style="border:solid 1px #ddd;border-bottom:none;margin-bottom:15px" id="grab-sorter">

    {foreach from=$conf item=itm key=mod}
    <li style="background:#ffffff" class="power_row" ><div style="border-bottom:solid 1px #ddd;">
            <table width="100%" cellspacing="0" cellpadding="5" border="0">
                <tbody><tr>
                        <td width="80" valign="middle" align="center"  class="{if $itm.active && ($itm.noapp || $itm.server)}power_ok{else}power_no{/if}" ><b>{if $itm.active && ($itm.noapp || $itm.server)}OK{else}CHECK{/if}</b></td>

                        <td>
                            <h3>{$itm.name}</h3>
                            {if !$itm.active}Module hasnt been activated yet, to activate visit <a href="?cmd=managemodules">Settings->Modules</a> section
                            {elseif !$itm.noapp && !$itm.server} Module is active, but there is no connection defined in <a href="?cmd=servers">Settings->Apps</a> with this module and related device/service
                            {else}
                            Module is active and functional
                            {/if}

                        </td>
                    </tr>
                </tbody></table></div></li>
    {/foreach}
</ul>
<form action="?cmd=dedimgr&do=configuration&save=1" method="post">
    <div class="row">
        <div class="col-sm-12 col-md-5">
            <div class="form-group">
                <label>Clientarea visibility <a class="vtip_description" title="select what client is able to see in client portal"></a></label>
                <select name="clinetarea_visibility" class="form-control">
                    <option value="1" {if $config.clinetarea_visibility == 1}selected{/if}>Show entire rack belonging to customer with items assigned to him and unassigned</option>
                    <option value="2" {if $config.clinetarea_visibility == 2}selected{/if}>Show entire rack belonging to customer, only with items assigned to him</option>
                    <option value="3" {if $config.clinetarea_visibility == 3}selected{/if}>Show racks containining customer items, but not belonging to him</option>
                </select>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-sm-12">
            <button type="submit" class="btn btn-sm btn-success">{$lang.savechanges}</button>
        </div>
    </div>
    {securitytoken}
</form>
