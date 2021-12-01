{if $action=='default'}
    {if $pages}
        <table width="100%" cellspacing="0" cellpadding="3" border="0" style="" class="table glike">
            <tbody>
            <tr>
                <th width="20">ID</th>
                <th>{$lang.Title}</th>
                <th width="40%">URL</th>
                <th width="100"></th>
            </tr>
            {foreach from=$pages item=page}
                <tr>
                    <td>{$page.id}</td>
                    <td><a data-pjax href="?cmd=infopages&action=edit&id={$page.id}">{if !$page.visible}<em class="ishidden">{$page.title}</em>{else}{$page.title}{/if}</a> {if !$page.visible}<em class="ishidden fs11">{$lang.hidden}</em>{/if}</td>
                    <td><a target="blank" href="{$system_url}{$ca_url}page/{$page.url}/">{$system_url}{$ca_url}page/{$page.url}/</a></td>
                    <td style="text-align: right">
                            <a data-pjax  title="edit" href="?cmd=infopages&action=edit&id={$page.id}" class="menuitm menu-auto">
                                <span class="editsth"></span>
                            </a>
                            <a data-pjax href="?cmd=infopages&delete={$page.id}&security_token={$security_token}" onclick="return confirm('{$lang.deletepageconfirm}')" title="delete" class="menuitm menu-auto">
                                <span class="delsth"></span>
                            </a>

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
                        {hbinput value=$submit.title style="" class="form-control" size="75" name="title" id="categoryname"}
                    </div>
                    <div class="form-group">
                        <label>{$lang.info_page_url}</label><br>
                        <span>{$system_url}{$ca_url}page/</span><span class="changemeurl">{$page.url}</span>
                        <input  name="url" type="text" value="{$page.url}" id="category_slug_edit" style="display:none; width: 250px;" />
                        <a class="editbtn" onclick="return editslug(this)" href="#">{$lang.Edit}</a>
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
            <a href="?cmd=infopages" class="btn btn-sm btn-warning">{$lang.back|default:"Back"}</a>
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
                        <label>{$lang.info_page_url}</label><br>
                        <a href="{$system_url}{$ca_url}page/{$page.url}/" target="_blank">{$system_url}{$ca_url}page/<span class="changemeurl">{$page.url}</span></a>
                        <input  name="url" type="text" value="{$page.url}" id="category_slug_edit" style="display:none; width: 250px;" />
                        <a class="editbtn" onclick="return editslug(this)" href="#">{$lang.Edit}</a>
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
            <a href="?cmd=infopages" class="btn btn-sm btn-warning">{$lang.back|default:"Back"}</a>
        </div>{securitytoken}
    </form>
{/if}
{literal}
<script>
    function editslug(el) {
        $(el).hide();
        $('#category_slug_edit').show();
        $('.changemeurl').hide();
        return false;
    }

    $(function () {
        $('#categoryname').bind('keyup keydown change', function () {
            if ($(this).val() !== '') {
                var w = $(this).val().replace(/[^a-zA-Z0-9-_\s]+/g, '-').replace(/[\s]+/g, '-').toLowerCase();
                if (!$('#category_slug_edit').is(':visible')) {
                    $('#category_slug_edit').val(w);
                }
                $('.changemeurl').html(w);
            }
        });
    });

</script>
{/literal}