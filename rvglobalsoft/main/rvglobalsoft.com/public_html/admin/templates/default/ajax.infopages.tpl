{if $action=='default'}
    {if $pages}
        <table width="100%" cellspacing="0" cellpadding="3" border="0" style="" class="table glike">
            <tbody>
            <tr>
                <th>{$lang.Title}</th>
                <th>URL</th>
                <th></th>
            </tr>
            {foreach from=$pages item=page}
                <tr>
                    <td><a data-pjax href="?cmd=infopages&action=edit&id={$page.id}">{$page.title}</a></td>
                    <td><a target="blank" href="{$system_url}?/page/{$page.url}/">{$system_url}?/page/{$page.url}/</a></td>
                    <td width="16"><a data-pjax href="?cmd=infopages&delete={$page.id}&security_token={$security_token}" onclick="return confirm('{$lang.deletepageconfirm}')" class="delbtn">delete</a></td>
                </tr>
            {/foreach}
            </tbody>
        </table>
    {else}
        <div class="blank_state blank_news">
            <div class="blank_info">
                <h1>{$lang.blank_kb}</h1>
                {$lang.blank_kb_desc}
                <div class="clear"></div>
                <a class="new_add new_menu" href="?cmd=infopages&action=new" data-pjax style="margin-top:10px">
                    <span>{$lang.addnewpage}</span></a>
                <div class="clear"></div>
            </div>
        </div>
    {/if}
{elseif $action=='new'}
    <form method="post">
        <div style="padding: 10px;" class="lighterblue">
            <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <label>{$lang.pagetitle}</label><br>
                        {hbinput value=$submit.title style="" class="form-control" size="75" name="title"}
                    </div>
                    <div class="form-group">
                        <label>{$lang.Visible}</label><br>
                        <input type="checkbox" value="1" name="visible" class="form-check-input" {if $reply.registered=='1'}checked="checked"{/if} />
                    </div>
                </div>
                <div class="col-sm-12">
                    <div class="form-group">
                        <label>{$lang.Content}</label><br>
                        {hbwysiwyg wrapper="infopages" value=$page.tag_content style="width:100%;" class="inp wysiw_editor form-control" cols="100" rows="6" id="prod_content" name="content" featureset="full"}
                    </div>
                </div>
            </div>
            {adminwidget module="infopages" section="forms"}
        </div>
        <div class="blu">
            <input type="submit" style="font-weight: bold;" value="{$lang.addnewpage}" name="save" class="btn btn-primary btn-sm" />
        </div>{securitytoken}
    </form>
{elseif $action=='edit'}
    <form method="post">
        <div style="padding: 10px;" class="lighterblue">
            <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <label>{$lang.pagetitle}</label><br>
                        {hbinput value=$page.tag_title style="" class="form-control" size="75" name="title"}
                    </div>
                    <div class="form-group">
                        <label>{$lang.Visible}</label><br>
                        <input type="checkbox" value="1" name="visible" class="form-check-input" {if $page.visible}checked="checked"{/if} />
                    </div>
                </div>
                <div class="col-sm-12">
                    <div class="form-group">
                        <label>{$lang.Content}</label><br>
                        {hbwysiwyg wrapper="infopages" value=$page.tag_content style="width:100%;" class="inp wysiw_editor form-control" cols="100" rows="6" id="prod_content" name="content" featureset="full"}
                    </div>
                </div>
            </div>
            {adminwidget module="infopages" section="forms"}
        </div>
        <div class="blu">
            <input type="submit" style="font-weight: bold;" value="{$lang.savechanges}" name="save"  class="btn btn-primary btn-sm"/>
        </div>{securitytoken}
    </form>
{/if}