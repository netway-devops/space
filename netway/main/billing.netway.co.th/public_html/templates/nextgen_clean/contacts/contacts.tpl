{*

    Manage contacts

*}
<h2 class="details2">{$lang.profiles}</h2>
<div class="ribbon form-horizontal">

    <div class="control-group">
        <label for="appendedPrependedInput" class="control-label left" style="width:auto">{$lang.profileinfo}</label>
        <div class="right">
            <a href="{$ca_url}profiles/add/" class="btn btn-success btn-large"><i class="icon-plus-sign icon-white"></i> {$lang.addnewprofile}</a>
        </div>
    </div>

</div>
<div class="ribbon-shadow-l"></div>
<div class="ribbon-shadow-r"></div>

{if $profiles}
    <div class="divider"></div>

    <a href="{$ca_url}profiles" id="currentlist" style="display:none" updater="#updater"></a>
    <table width="100%" cellspacing="0" cellpadding="0" border="0" class="table table-striped fullscreen">
        <colgroup class="firstcol"></colgroup>
        <colgroup class="alternatecol"></colgroup>
        <colgroup class="firstcol"></colgroup>
        <colgroup class="alternatecol"></colgroup>
        <colgroup class="firstcol"></colgroup>
        <tbody>
        <tr>

            <th><a href="{$ca_url}profiles/&orderby=firstname|ASC" class="sortorder">{$lang.firstname}</a></th>
            <th><a href="{$ca_url}profiles/&orderby=lastname|ASC" class="sortorder">{$lang.lastname}</a></th>
            <th><a href="{$ca_url}profiles/&orderby=email|ASC" class="sortorder"> {$lang.email}</a></th>
            <th><a href="{$ca_url}profiles/&orderby=lastlogin|ASC" class="sortorder">{$lang.lastlogin}</a></th>
            <th></th>
        </tr>
        </tbody>
        <tbody id="updater">
            {include file='ajax.profiles.tpl'}
        </tbody>
    </table>

    {if $totalpages>1}
        <div class="right p19 pt0">
            <div class="pagelabel left ">{$lang.page}</div>
            <div class="btn-group right" data-toggle="buttons-radio" id="pageswitch">
                {section name=foo loop=$totalpages}
                    <button class="btn {if $smarty.section.foo.iteration==1}active{/if}">{$smarty.section.foo.iteration}</button>
                {/section}
            </div>
            <input type="hidden" id="currentpage" value="0" />
        </div>
        <div class="clear"></div>
    {/if}


    <h2 class="details2">{$lang.billing_contact}</h2>

    <div class="brcrm">{$lang.billing_contact_descr}</div>
    <div class="p19">
        <form class="form-horizontal" method="post">
            <input type="hidden" name="do" value="set_billing_contact"/>
            <div class="control-group">
                <label class="control-label" for="billing_contact">
                    <strong>
                        {$lang.billing_contact}
                    </strong>
                </label>
                <div class="controls">
                    <select id="billing_contact_id" name="billing_contact_id" style="width: 90%">
                        <option value="0" {if !$clientdata.billing_contact_id}selected{/if}>{$lang.billing_contact_none}</option>
                        {foreach from=$profiles item=p name=ff}
                            <option value="{$p.id}" {if $p.id == $clientdata.billing_contact_id}selected{/if}>{$p.firstname} {$p.lastname}</option>
                        {/foreach}

                    </select>
                </div>
            </div>
            <center><button type="submit" class="btn btn-primary btn-small" name="submit">{$lang.savechanges}</button></center>

            {securitytoken}
        </form>
    </div>


{else}
    <div class="p19"> <h3>{$lang.nothing}</h3></div>
{/if}
