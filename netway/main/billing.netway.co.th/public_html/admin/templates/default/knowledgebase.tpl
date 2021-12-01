<link rel="stylesheet" href="{$template_dir}js/gui.elements.css" type="text/css" />
<script type="text/javascript" src="{$template_dir}js/tinymce/tiny_mce.js?v={$hb_version}"></script>
<script type="text/javascript" src="{$template_dir}js/tinymce/jquery.tinymce.js?v={$hb_version}"></script>
<script type="text/javascript" src="{$template_dir}js/jquery.elastic.min.js?v={$hb_version}"></script>
<script type="text/javascript" src="{$template_dir}js/jquery.dragsort-0.3.10.min.js?v={$hb_version}"></script>
<script type="text/javascript" src="{$template_dir}js/xregexp-all.js"></script>
{literal}
    <style>
        a.sorter-handler{
            cursor:n-resize
        }
        a.sorter-handler:active{
            border-color:#B0B0B0!important;
            background:#f2f2f2!important
        }
        ul.grab-sorter{
            border:solid 1px #ddd;
            border-bottom:none;
            position: relative;
        }
        ul.grab-sorter li{
            border-bottom:solid 1px #ddd;
            clear: both;
            background: #fff;
            width: 100%
        }

        ul.grab-sorter li div.actions,
        ul.grab-sorter li div.lastitm,
        ul.grab-sorter li div.name{
            float:left;
            padding: 10px 5px;
        }

        ul.grab-sorter li:after{
            content: ".";
            display: block;
            clear: both;
            visibility: hidden;
            line-height: 0;
            height: 0;
        }
        ul.grab-sorter li div.lastitm, ul.grab-sorter li div.lastitm-art{
            width:150px;
            float: right;
            min-height: 28px;
            padding: 4px 5px;
            background: #F0F0F3;
            color: #767679;
            box-sizing: content-box;
            box-shadow: 4px 0px 2px -2px rgba(0,0,0,0.1) inset;
        }
        ul.grab-sorter li div.lastitm-art{
            width:50%;
        }
        ul.grab-sorter li div.actions{
            height: 15px;
        }
        ul.grab-sorter li:hover div.lastitm, ul.grab-sorter li:hover{
            background: #FFFED1;
        }
        ul.grab-sorter li.placeHolder{
            height:35px;
            border:dashed 1px #999
        }
        .actions label{
            display:block
        }
        .actions a.menuitm .addsth{
            background-position: center center;
            padding: 0 7px;
        }
    </style>
{/literal}
{literal}
    <script type="text/javascript">
        var regex = new XRegExp("\\P{L}+", "g");
    </script>
{/literal}
{if $editor !== 'wysiwyg'}
    <script type="text/javascript" src="{$template_dir}js/ace/ace.js?v={$hb_version}"></script>
{/if}
<table border="0" cellspacing="0" cellpadding="0" width="100%" id="content_tb" {if $currentfilter}class="searchon"{/if}>
    <tr>
        <td ><h3>{$lang.Knowledgebase}</h3></td>
        <td></td>
    </tr>
    <tr>
        <td class="leftNav">
            <a href="?cmd=knowledgebase"  class="tstyled {if $action == 'default'}selected{/if}">{$lang.listcats}</a>
            <br /><br />
            <a href="?cmd=knowledgebase&action=addcategory"  class="tstyled {if $action=='addcategory'}selected{/if}">{$lang.addcat}</a>
            <a href="?cmd=knowledgebase&action=addarticle"  class="tstyled {if $action=='addarticle'}selected{/if}">{$lang.addarticle}</a>
        </td>
        <td  valign="top"  class="bordered">
            <div id="bodycont" style="">
                {if $action=='article' || $action=='addarticle' || $action=='category' || $action=='addcategory'}
                    <div class="blu">
                        <a href="?cmd={$cmd}"> <strong>{$lang.Knowledgebase}</strong> </a>
                        {if $action=='addcategory'}
                            &raquo; <strong>{$lang.addnewcat}</strong>
                        {/if}
                        {if $action=='addarticle'}
                            &raquo; <strong>{$lang.addnewarticle}</strong>
                        {/if}
                        {if $action=='article'}
                            &raquo; <strong>{$lang.Edit} {$lang.kbarticle}</strong>
                            <div style="display: inline-block; margin-left: 25px; float: right">
                                <span>Views: {if $reply.views}{$reply.views}{else}0{/if}</span>
                                <span style="margin-left: 20px;">Upvotes: {if $reply.upvotes}{$reply.upvotes}{else}0{/if}</span>
                                <span style="margin-left: 20px;">Downvotes: {if $reply.downvotes}{$reply.downvotes}{else}0{/if}</span>
                                <button style="margin-left: 20px;" class="btn btn-primary btn-sm" type="button" onclick="return assignService('');">Reset counters</button>
                            </div>
                        {/if}
                        {if $action=='category'}
                            &raquo; <strong>{$lang.Edit} {$lang.Category}</strong>
                        {/if}
                    </div>
                {/if}
                {if $action=='addarticle' || $action=='article'}
                    <div id="ResetCounters" style="display:none;" bootbox data-title="Reset counters"
                         data-formaction="?cmd=knowledgebase&action=article&id={$reply.id}">
                        <input type="hidden" name="make" value="{if $action=='article'}article{else}addarticle{/if}" />

                        <input type="hidden" name="cat_id" value="{$reply.cat_id}"/>
                        {if $reply.registered=='1'}<input type="hidden" name="registered" value="{$ticket.id}"/>{/if}
                        {foreach from=$langs item=lgname key=lgid name="loop"}
                            <input type="hidden" name="mode[{$lgid}]" value="{if $reply.mode.$lgid}{$reply.mode.$lgid}{else}0{/if}" />
                            <input type="hidden" name="title[{$lgid}]" value="{$reply.tag_title.$lgid}">
                            <input type="hidden" name="slug[{$lgid}]" value="{$reply.tag_slug.$lgid}">
                            <input type="hidden" name="body[{$lgid}]" value="{$reply.tag_body.$lgid}">
                        {/foreach}
                        {foreach from=$relations item=relation}
                            <input type="hidden" name="relations[]" value="{$relation}">
                        {/foreach}

                        <div class="form-group">
                            <label>Views</label>
                            <input type="number" value="{if $reply.views}{$reply.views}{else}0{/if}" name="views" min="0" class="form-control">
                        </div>
                        <div class="form-group">
                            <label>Upvotes</label>
                            <input type="number" value="{if $reply.upvotes}{$reply.upvotes}{else}0{/if}" name="upvotes" min="0" class="form-control">
                        </div>
                        <div class="form-group">
                            <label>Downvotes</label>
                            <input type="number" value="{if $reply.downvotes}{$reply.downvotes}{else}0{/if}" name="downvotes" min="0" class="form-control">
                        </div>
                        {securitytoken}
                    </div>
                    <form method="post" action="" id="articleform">
                        {if $categories}
                        <div class="container-fluid clear lighterblue" style="padding: 14px 20px;">
                            <div class="row">
                                <input type="hidden" name="make" value="{if $action=='article'}article{else}addarticle{/if}" />
                                <input type="hidden" name="views" value="{if $reply.views}{$reply.views}{else}0{/if}" />
                                <input type="hidden" name="upvotes" value="{if $reply.upvotes}{$reply.upvotes}{else}0{/if}" />
                                <input type="hidden" name="downvotes" value="{if $reply.downvotes}{$reply.downvotes}{else}0{/if}" />
                                <div class="col-sm-6">
                                    <div class="form-group ">
                                        <label>{$lang.Category}</label>
                                        <select name="cat_id" id="catpicker" class="inp form-control">
                                            {foreach from=$categories item=cat}
                                                <option value="{$cat.id}" {if $reply.cat_id==$cat.id}selected="selected" {/if}>{section loop=$cat.depth name=sect}&mdash;{/section} {$cat.name}</option>
                                            {/foreach}
                                        </select>
                                    </div>

                                    <div class="form-group">
                                        <label>{$lang.registeredonly}</label><br>
                                        <input type="checkbox" value="1" name="registered" class="form-check-input" {if $reply.registered=='1'}checked="checked"{/if} />
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-12">
                                    {foreach from=$langs item=lgname key=lgid name="loop"}
                                        <div class="row">
                                            <div class="form-group lang langid langid{$lgid} col-sm-6"  {if !$smarty.foreach.loop.first}style="display:none"{/if}>
                                                <label>{$lang.Title}</label> <small>({$lgname|capitalize})</small>
                                                {hbinput id="title" value=$reply.tag_title.$lgid style="" size="75" name="title[`$lgid`]" class="form-control"}
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="form-group lang langslug langslug{$lgid} col-sm-6"  {if !$smarty.foreach.loop.first}style="display:none"{/if}>
                                                <label>{$lang.Slug}</label> <small>({$lgname|capitalize})</small> <a href="#" class="vtip_description" title="This is a final part of URL leading to this article. ie: http://yourhostbill.com/?/knowledgebase/article/1/your-custom-slug/"></a>
                                                {hbinput id="slug" value=$reply.tag_slug.$lgid style="" size="75" name="slug[`$lgid`]" class="form-control"}
                                            </div>
                                        </div>
                                        <div class="form-group lang langtext langtext{$lgid}"  {if !$smarty.foreach.loop.first}style="display:none"{/if}>
                                            <label>{$lang.Description}</label><br>
                                            <input type="hidden" name="mode[{$lgid}]" value="{if $reply.mode.$lgid}{$reply.mode.$lgid}{else}0{/if}" />
                                            {if $editor === 'wysiwyg'}
                                                {hbwysiwyg value=$reply.tag_body.$lgid
                                                class="inp wysiw_editor form-control" cols="100" rows="8"
                                                name="body[`$lgid`]" featureset="full"
                                                additionaltabs=$language_tabs editortag="HTML"
                                                onclickplain="set_art_mode(this,0);"
                                                onclickeditor="set_art_mode(this,1);"}
                                            {else}
                                                {hbwysiwyg value=$reply.tag_body.$lgid
                                                class="inp wysiw_editor form-control" cols="100" rows="8"
                                                name="body[`$lgid`]" featureset="full"
                                                additionaltabs=$language_tabs editortag="HTML"
                                                editortype="ace" id=`$lgid`
                                                blockwysiwyg=false
                                                onclickplain="HBInputTranslate.aceOff(this,`$lgid`);"
                                                onclickeditor="HBInputTranslate.aceOn(this,`$lgid`);"
                                                }
                                            {/if}
                                        </div>
                                    {/foreach}
                                </div>
                            </div>
                            {adminwidget module="knowledgebase" section="forms"}
                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="form-group">
                                        <label>{$lang.related_articles}</label>
                                        <select id="select_article" name="relations[]" multiple class="form-control chosen">
                                            {foreach from=$categories item=category}
                                                <optgroup label="{$category.name}">
                                                    {foreach from=$category.articles item=item}
                                                        <option value="{$item.id}" {if in_array($item.id, $relations)}selected{/if}>{$item.title}</option>
                                                    {/foreach}
                                                </optgroup>
                                            {/foreach}
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="form-group">
                                        <label>{$lang.tags}</label>
                                        <div id="tagsInput" class="tags-form" data-tags="{$reply.tags|@json_encode|escape}"></div>
                                        <div id="tags" style="display: none">
                                            {foreach from=$tags item=tag}
                                                <input type="hidden" name="tags[]" value="{$tag}" />
                                            {/foreach}
                                        </div>
                                        {literal}
                                            <script type="text/javascript">
                                                $(function () {
                                                    $('#tagsInput').hbtags({
                                                        placeholder: 'Tags'
                                                    })
                                                        .on('tags.add', function (e, tag) {
                                                            $('#tags').append('<input type="hidden" name="tags[]" value="' + tag + '" />');
                                                        })
                                                        .on('tags.rem', function (e, tag) {
                                                            $('#tags input[value="' + tag + '"]').remove();
                                                        });
                                                });
                                            </script>
                                        {/literal}
                                    </div>
                                </div>
                            </div>
                        {literal}
                            <script type="text/javascript">
                                $(function () {
                                    $('.tabs_wysiw').each(function () {
                                       $(this).children().first().find('a').click();
                                    });
                                    $('textarea.wysiw_editor').each(function () {
                                        var self = $(this);
                                        if (self.data('aceeditor')) {
                                            self.on('keyup', function () {
                                                self.data('aceeditor').getSession().setValue(self.val());
                                            });
                                        }
                                    });
                                });

                                $('#title').keyup(function(){
                                    $('#slug').val(XRegExp.replace($(this).val(), regex, "-").toLowerCase());

                                });

                                if (HBInputTranslate.tinyMCEFull.plugins.split(',').indexOf('autoresize') == -1)
                                    HBInputTranslate.tinyMCEFull.plugins += ",autoresize";
                                function set_art_mode(that, mode) {
                                    $(that).parents('td').eq(0).children('input').val(mode);
                                }
                                $('textarea.wysiw_editor').elastic();
                                $('textarea.wysiw_editor').css('height', '150px');
                                $('.tabs_wysiw li').click(function() {
//                                    $('textarea.wysiw_editor').css('height', '150px');
                                    if ($(this).index() < 2) {
                                        var el = $(this).nextAll('.additional').eq($(this).parents('.langtext').prevAll('.langtext').length + 1);
                                        el.addClass('active');
                                        if ($(this).parent().index() == 1)
                                            el.find('a').css('background', '#F0F0EE');
                                        else
                                            el.find('a').css('background', '')
                                    } else {
                                        if ($(this).find('select').length) {
                                            return true;
                                        }
                                        var el = $('.lang').hide(),
                                            index = $(this).prevAll('.additional').length - 1;
                                        $('.langid').eq(index).show();
                                        $('.langslug').eq(index).show();
                                        $('.langtext').eq(index).show();
                                        el.find(".tabs_wysiw li.active:first").click();
                                        $('.tabs_wysiw li select').val(index + 1);

                                        if ($("input[name^='mode[']").eq(index).val() == 1)
                                            $('.tabs_wysiw:eq(' + index + ') li:eq(1) a').click();
                                    }
                                });
                                $('.lang').find(".tabs_wysiw li.active:first").click();
                                function art_preview(e) {
                                    e.preventDefault();
                                    $('#previewlang').val($('input[name^=title]:visible:first').attr('name').replace(/^title\[(.+)\]$/, '$1'));
                                    $('#articleform').attr('target', '_blank').attr('action', '../?cmd=knowledgebase&action=preview').submit();
                                    $('#articleform').removeAttr('target').attr('action', '');
                                }
                                if ($("input[name^='mode[']:first").val() == 1)
                                    $('.tabs_wysiw li:eq(1) a').click();

                                $('#select_article').chosenedge({
                                    enable_split_word_search: true,
                                    search_contains: true,
                                }).on('change', function (e, data) {});

                                $(function () {
                                    $('.wysiw_editor').parent().css('float', 'none');

                                    $('#ResetCounters').bootboxform().on('bootbox-form.shown', function (e, dialog) {
                                        $('select', dialog).chosenedge({
                                            width: "100%",
                                            enable_split_word_search: true,
                                            search_contains: true,
                                        });
                                    });
                                });

                                function assignService() {
                                    $('#ResetCounters').trigger('show');
                                }
                            </script>
                        {/literal}
                        <div class="blu">
                            <a href="?cmd=knowledgebase"  class="tload2"><strong>&laquo; {$lang.backtocats}</strong></a>
                            <input class="btn btn-success btn-sm" type="submit" value="{if $action=='article'}{$lang.savechanges}{else}{$lang.addarticle}{/if}" style="font-weight:bold" />
                            <input class="btn btn-primary btn-sm" type="submit" value="{$lang.preview|capitalize}" name="preview" onclick="art_preview(event);" />
                            <input class="btn btn-primary btn-sm"type="hidden" value="1" name="lang" id="previewlang" />
                            <input class="btn btn-primary btn-sm" type="submit" name="cancel" value="{$lang.Cancel}"  />
                        </div>
                        {securitytoken}
                    </form>
                {else}
                    <div class="blu">
                        {$lang.thereisnocats} - <a href="?cmd=knowledgebase&action=addcategory">{$lang.addnewcat}</a> {$lang.tostart}.
                        <br />
                        <a href="?cmd=knowledgebase"  class="tload2"><strong>&laquo; {$lang.backtocats}</strong></a>
                    </div>
                {/if}

                {elseif $action=='article'}
                    <form method="post" action="">
                        <div class="lighterblue" style="padding: 10px;">
                            <input type="hidden" name="make" value="article" />
                            <table cellpadding="1" width="800">
                                <tr>
                                    <td>{$lang.Category}:</td>
                                    <td>
                                        <select name="cat_id" id="catpicker" class="inp">
                                            {foreach from=$categories item=cat}
                                                <option value="{$cat.id}" {if $reply.cat_id==$cat.id}selected="selected" {/if}>{section loop=$cat.depth name=sect}&mdash;{/section} {$cat.name}</option>
                                            {/foreach}
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <td>{$lang.registeredonly}</td>
                                    <td>
                                        <input type="checkbox" value="1" name="registered" {if $reply.registered=='1'}checked="checked"{/if} />
                                    </td>
                                </tr>
                                <tr>
                                    <td>{$lang.Title}:</td>
                                    <td>
                                        {hbinput value=$reply.tag_title style="" size="75" name="title" class="inp"}
                                    </td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td>
                                        {hbwysiwyg value=$reply.tag_body style="width:700px;"
                                        class="inp wysiw_editor" cols="100" rows="6"
                                        id="prod_content" name="body" featureset="full"}
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="blu">
                            <a href="?cmd=knowledgebase"  class="tload2"><strong>&laquo; {$lang.backtocats}</strong></a>
                            <input class="btn btn-success btn-sm" type="submit" value="{$lang.savechanges}" style="font-weight:bold" />
                            <input class="btn btn-primary btn-sm" type="submit" name="{$lang.cancel}" value="{$lang.Cancel}"  />
                        </div>
                        {securitytoken}
                    </form>
                {elseif $action=='article_view'}
                    <ol class="breadcrumb" style="padding: 15px;">
                        {if !$categories.parent_cat && $categories.parent_cat != '0'}
                            <li class="breadcrumb-item active">{$lang.Knowledgebase}</li>
                        {else}
                            <li class="breadcrumb-item"><a href="?cmd=knowledgebase" >{$lang.Knowledgebase}</a></li>
                        {/if}
                        {foreach from=$path item=item}
                            <li class="breadcrumb-item">
                                <a href="?cmd=knowledgebase&cid={$item.id}" >{$item.name}</a>
                            </li>
                        {/foreach}
                    </ol>
                    <div class="container-fluid clear lighterblue" style="padding: 14px 20px;">
                        <div class="row">
                            <div class="col-sm-12">
                                <h1>{$article.title|ucfirst}</h1>
                                <article class="mt-5">
                                    <p>{$article.body}</p>
                                </article>
                            </div>
                        </div>
                    </div>
                    <div class="blu">
                        <a href="?cmd=knowledgebase"  class="tload2"><strong>&laquo; {$lang.backtocats}</strong></a>
                    </div>
                {elseif $action=='addcategory'}
                    <form method="post" action="">
                        <div class="container-fluid clear lighterblue" style="padding: 14px 20px;">
                            <div class="row">
                                <input type="hidden" name="make" value="addcategory" />
                                <div class="col-sm-6">
                                    <div class="form-group ">
                                        <label>{$lang.parentcat}</label>
                                        <select name="parent_cat" id="catpicker" class="inp form-control">
                                            <option value="0" {if $reply.parent_cat==0}selected="selected" {/if}>{$lang.topcategory}</option>
                                            {foreach from=$categories item=cat}
                                                <option value="{$cat.id}" {if $reply.parent_cat==$cat.id}selected="selected" {/if}>&mdash;{section loop=$cat.depth name=sect}&mdash;{/section} {$cat.name}</option>
                                            {/foreach}
                                        </select>
                                    </div>

                                    <div class="form-group">
                                        <label>{$lang.adminonly}</label><a class="vtip_description" title="All articles/categories under this category will not be seen by customers"></a><br>
                                        <input type="checkbox" value="1" name="admin_only" class="form-check-input" {if $reply.admin_only=='1'}checked="checked"{/if} />
                                    </div>
                                    <div class="form-group">
                                        <label>{$lang.registeredonly}</label><br>
                                        <input type="checkbox" value="1" name="options[]" class="form-check-input" {if $reply.options & 1}checked="checked"{/if} />
                                    </div>
                                    <div class="form-group">
                                        <label>{$lang.Name}</label>
                                        {hbinput id="name" value=$reply.tag_name style="" size="75" name="name" class="form-control"}
                                    </div>
                                    <div class="form-group">
                                        <label>{$lang.Slug}</label><a href="#" class="vtip_description" title="This is a final part of URL leading to this category. ie: http://yourhostbill.com/?/knowledgebase/category/1/your-custom-slug/"></a>
                                        {hbinput id="slug" value=$reply.slug style="" size="75" name="slug" class="form-control"}
                                    </div>
                                </div>
                                <div class="col-sm-12">
                                    <div class="form-group">
                                        <label>{$lang.Description}</label><br>
                                            {hbwysiwyg value=$reply.tag_description style="width:100%;" class="wysiw_editor form-control" cols="100" rows="8" id="prod_content" name="description" featureset="full"}
                                    </div>
                                </div>
                            </div>
                            {adminwidget module="knowledgebase" section="forms"}
                        </div>
                        {literal}
                            <script type="text/javascript">
                                $(function () {
                                    $('#prod_content').parent().css('float', 'none');
                                });
                                $('#name').keyup(function(){
                                    $('#slug').val(XRegExp.replace($(this).val(), regex, "-").toLowerCase());

                                });
                            </script>
                        {/literal}
                        <div class="blu">
                            <a href="?cmd=knowledgebase"  class="tload2"><strong>&laquo; {$lang.backtocats}</strong></a>
                            <input class="btn btn-success btn-sm" type="submit" value="{$lang.addcat}" style="font-weight:bold" />
                            <input class="btn btn-primary btn-sm" type="submit" name="cancel" value="{$lang.Cancel}"  />
                        </div>
                        {securitytoken}
                    </form>

                {elseif $action=='category'}
                    <form method="post" action="">
                        <div class="container-fluid clear lighterblue" style="padding: 14px 20px;">
                            <div class="row">
                                <input type="hidden" name="make" value="category" />
                                <div class="col-sm-6">
                                    <div class="form-group ">
                                        <label>{$lang.parentcat}</label>
                                        <select name="parent_cat" id="catpicker" class="inp form-control">
                                            <option value="0" {if $reply.parent_cat==0}selected="selected" {/if}>{$lang.topcategory}</option>
                                            {foreach from=$categories item=cat}
                                                <option value="{$cat.id}" {if $reply.parent_cat==$cat.id}selected="selected" {/if}>&mdash;{section loop=$cat.depth name=sect}&mdash;{/section} {$cat.name}</option>
                                            {/foreach}
                                        </select>
                                    </div>
                                    <div class="form-group">
                                        <label>{$lang.adminonly}</label><a class="vtip_description" title="All articles/categories under this category will not be seen by customers"></a><br>
                                        <input type="checkbox" value="1" name="admin_only" class="form-check-input" {if $reply.admin_only=='1'}checked="checked"{/if} />
                                    </div>
                                    <div class="form-group">
                                        <label>{$lang.registeredonly}</label><br>
                                        <input type="checkbox" value="1" name="options[]" class="form-check-input" {if $reply.options & 1}checked="checked"{/if} />
                                    </div>
                                    <div class="form-group">
                                        <label>{$lang.Name}</label>
                                        {hbinput id="name" value=$reply.tag_name style="" size="75" name="name" class="form-control"}
                                    </div>
                                    <div class="form-group">
                                        <label>{$lang.Slug}</label><a href="#" class="vtip_description" title="This is a final part of URL leading to this category. ie: http://yourhostbill.com/?/knowledgebase/category/1/your-custom-slug/"></a>
                                        {hbinput id="slug" value=$reply.slug style="" size="75" name="slug" class="form-control"}
                                    </div>
                                </div>
                                <div class="col-sm-12">
                                    <div class="form-group">
                                        <label>{$lang.Description}</label><br>
                                        {hbwysiwyg value=$reply.tag_description style="width:100%;" class="wysiw_editor form-control" cols="100" rows="8" id="prod_content" name="description" featureset="full"}
                                    </div>
                                </div>
                            </div>
                            {adminwidget module="knowledgebase" section="forms"}
                        {literal}
                            <script type="text/javascript">
                                $('#name').keyup(function(){
                                    $('#slug').val(XRegExp.replace($(this).val(), regex, "-").toLowerCase());

                                });
                                $(function () {
                                    $('.tabs_wysiw').parent().css('float', 'none');
                                });
                            </script>
                        {/literal}
                        <div class="blu">
                            <a href="?cmd=knowledgebase"  class="tload2"><strong>&laquo; {$lang.backtocats}</strong></a>
                            <input class="btn btn-success btn-sm" type="submit" value="{$lang.savechanges}" style="font-weight:bold" />
                            <input class="btn btn-primary btn-sm" type="submit" name="cancel" value="{$lang.Cancel}"  />
                        </div>
                        {securitytoken}
                    </form>
                {else}
                {if $categories.id == '0' && !$categories.categories && !$categories.parent_cat}
                    <div class="blank_state blank_kb">
                        <div class="blank_info">
                            <h1>{$lang.blank_kb}</h1>
                            {$lang.blank_kb_desc}
                            <div class="clear"></div>
                            <a class="new_add new_menu" href="?cmd=knowledgebase&action=addcategory" style="margin-top:10px">
                                <span>{$lang.addnewcat}</span></a>
                            <div class="clear"></div>
                        </div>
                    </div>
                {else}
                    <div class="newhorizontalnav" id="newshelfnav">
                        <div class="list-1">
                            <ul>
                                <li class="{if $action != 'tree' && $action != 'statistics'} active {/if}">
                                    <a href="?cmd={$cmd}">{$lang.listcats}</a>
                                </li>
                                <li class="{if $action == 'tree'} active {/if} last">
                                    <a href="?cmd={$cmd}&action=tree">{$lang.browseintree}</a>
                                </li>
                                <li class="{if $action == 'statistics'} active {/if}">
                                    <a href="?cmd={$cmd}&action=statistics">{$lang.statistics}</a>
                                </li>
                            </ul>
                        </div>
                        <div class="list-2">
                            <div class="navsubmenu haveitems">
                                <ul>
                                    <li class="list-2elem"><a href="?cmd={$cmd}&action=addcategory" ><span>{$lang.addnewcat}</span></a></li>
                                    <li class="list-2elem"><a href="?cmd={$cmd}&action=addarticle" ><span>{$lang.addnewarticle}</span></a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div class="nicerblu">
                        <div id="kbtree">
                            {include file="ajax.knowledgebase.tpl"}
                        </div>
                    </div>
                {/if}
                {literal}
                    <script type="text/javascript">
                        function set_sort() {
                            var list = $(this).parents(".grab-sorter");
                            var len = list.find('.sort-order').length;
                            list.find('.sort-order').each(function(i) {
                                $(this).val(len - i);
                            });

                            $.post("{/literal}?cmd={$cmd}&action=sort{literal}" , list.find('.sort-order').serializeObject());
                        }
                    </script>
                {/literal}
                {/if}
            </div>
        </td>
    </tr>
</table>
