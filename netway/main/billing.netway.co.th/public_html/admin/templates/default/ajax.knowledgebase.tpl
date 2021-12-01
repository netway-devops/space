{php}
$templatePath   = $this->get_template_vars('template_path');
include($templatePath . 'ajax.knowledgebase.tpl.php');
{/php}

{if $action=='getcat'}
    {if $category.name}
        <div class="hitarea collapsable-hitarea "></div><a class="folder" href="?cmd=knowledgebase&action=getcat&cid={$category.id}">{$category.name}</a> <a href="?cmd=knowledgebase&action=addarticle&cat_id={$category.id}" class="edit " style="margin-right:10px;">{$lang.addarticle}</a> <a href="?cmd=knowledgebase&action=category&cid={$category.id}" class="edit ">{$lang.Edit}</a> <a href="?cmd=knowledgebase&make=categorydelete&security_token={$security_token}&id={$category.id}" class="edit editbtn" onclick="return confirm('{$lang.deletecategoryconfirm}')">{$lang.delete}</a>
        <ul>
            {if $category.categories}
                {foreach from=$category.categories item=cat name=checklast}
                    <li class="closed expandable {if $smarty.foreach.checklast.last && !$category.posts}lastExpandable{/if}" id="folder_{$cat.id}">
                        <div class="hitarea closed-hitarea expandable-hitarea {if $smarty.foreach.checklast.last && !$category.posts}lastExpandable-hitarea{/if}"></div>
                        <a class="folder" href="?cmd=knowledgebase&action=getcat&cid={$cat.id}">{$cat.name}</a>
                        <a href="?cmd=knowledgebase&action=addarticle&cat_id={$cat.id}" class="edit " style="margin-right:10px;">{$lang.addarticle}</a> <a href="?cmd=knowledgebase&action=category&cid={$cat.id}" class="edit ">{$lang.Edit}</a> <a href="?cmd=knowledgebase&make=categorydelete&id={$cat.id}&security_token={$security_token}" class="edit editbtn" onclick="return confirm('{$lang.deletecategoryconfirm}')">{$lang.delete}</a></li>
                    {/foreach}
                {/if}

            {if $category.posts}
                {foreach from=$category.posts item=rep name=rechecklast}
                    <li class="{if $smarty.foreach.rechecklast.last}last{/if}"><a class="file" href="?cmd=knowledgebase&action=article&id={$rep.id}">{$rep.title}</a>
                        <a href="?cmd=knowledgebase&make=articledelete&id={$rep.id}&security_token={$security_token}" class="edit editbtn" onclick="return confirm('{$lang.deletearticleconfirm}')">{$lang.delete}</a> {$rep.body}</li>
                    {/foreach}
                {/if}
        </ul>
        <script type="text/javascript">bindPredefinied();</script>
    {/if}
{elseif $action=='getr' && $getid}
    {$system_url}index.php?cmd=knowledgebase&action=article&id={$getid}
{elseif $action=='default'}
    <ol class="breadcrumb">
        {if !$categories.parent_cat && $categories.parent_cat != '0'}
            <li class="breadcrumb-item active">Knowledgebase</li>
        {else}
            <li class="breadcrumb-item"><a href="?cmd=knowledgebase" >Knowledgebase</a></li>
        {/if}
        {foreach from=$path item=item}
            <li class="breadcrumb-item">
                <a href="?cmd=knowledgebase&cid={$item.id}" >{$item.name}</a>
            </li>
        {/foreach}
    </ol>

    <ul class="grab-sorter">
        {foreach from=$categories.categories item=cat name=loop}
            <li class="{if $smarty.foreach.loop.index%2==0}even{/if} sortable">
                <div class="actions">
                    {if 'acl:editKBase'|checkcondition}
                        <input type="hidden" name="order[cat][{$cat.id}]" value="{$cat.sort_order}" class="sort-order"/>
                        <a href="#" onclick="return false" class="sorter-handler menuitm menu-auto">
                            <span class="movesth" title="move">&nbsp;</span>
                        </a>
                        <a title="edit" href="?cmd=knowledgebase&action=category&cid={$cat.id}" class="menuitm menu-auto">
                            <span class="editsth"></span>
                        </a>
                        <a onclick="return confirm('{$lang.deletecategoriesconfirm}')"
                           href="?cmd=knowledgebase&make=categorydelete&id={$cat.id}&security_token={$security_token}" title="delete" class="menuitm menu-auto">
                            <span class="delsth"></span>
                        </a>
                    {/if}
                </div>
                <div class="name"><a href="?cmd=knowledgebase&cid={$cat.id}">{$cat.name}</a></div>
                <div class="lastitm-art fs11">
                    {if $cat.admin_only}<strong>{$lang.adminonly}</strong><br/>{/if}
                    {$cat.description|strip_tags|escape|truncate:255}
                </div>
            </li>
        {/foreach}
        <li class="{if $smarty.foreach.loop.index%2!=0}even{/if}">
            <div class="name">
                <a href="?cmd=knowledgebase&action=addcategory&parent_cat={$categories.id}" class="menuitm" title="{$lang.addnewcat}" >
                    <span class="addsth"></span> {$lang.addnewcat}
                </a>
            </div>
        </li>
    </ul>

    {if $categories.id || $categories.posts}
        <h4>Articles</h4>
        <ul class="grab-sorter">
            {foreach from=$categories.posts item=rep name=loop}
                <li class="{if $smarty.foreach.loop.index%2==0}even{/if} sortable">
                    <div class="actions">
                        {if 'acl:editKBase'|checkcondition}
                            <input type="hidden" name="order[art][{$rep.id}]" value="{$cat.sort_order}" class="sort-order"/>
                            <a href="#" onclick="return false" class="sorter-handler menuitm menu-auto">
                                <span class="movesth" title="move">&nbsp;</span>
                            </a>
                            <a title="edit" href="?cmd=knowledgebase&action=article&id={$rep.id}" class="menuitm menu-auto">
                                <span class="editsth"></span>
                            </a>
                            <a onclick="return confirm('{$lang.deletearticleconfirm}')"
                               href="?cmd=knowledgebase&make=articledelete&id={$rep.id}&security_token={$security_token}" title="delete" class="menuitm menu-auto">
                                <span class="delsth"></span>
                            </a>
                        {/if}
                        <a title="view" href="?cmd=knowledgebase&action=article_view&id={$rep.id}" class="menuitm menu-auto"><span class="preview">{$lang.view|default:"View"}</span></a>
                    </div>
                    <div class="name">{$rep.title}</div>
                    <div class="lastitm-art fs11">
                        <span>Views: {if $rep.views}{$rep.views}{else}0{/if}</span>
                        <span style="margin-left: 20px;">Upvotes: {if $rep.upvotes}{$rep.upvotes}{else}0{/if}</span>
                        <span style="margin-left: 20px;">Downvotes: {if $rep.downvotes}{$rep.downvotes}{else}0{/if}</span><br>
                        Article: {$rep.body}
                    </div>
                    <div class="right inlineTags" style="padding: 10px 5px;">
                        {foreach from=$rep.tags item=tag}
                            <span>{$tag}</span>
                        {/foreach}
                    </div>
                </li>
            {/foreach}
            {if $categories.id}
                <li class="{if $smarty.foreach.loop.index%2!=0}even{/if}">
                    <div class="name">
                        <a href="?cmd=knowledgebase&action=addarticle&cat_id={$categories.id}" class="menuitm" title="{$lang.addnewarticle}" >
                            <span class="addsth"></span> {$lang.addnewarticle}
                        </a>
                    </div>
                </li>
            {/if}
        </ul>
    {/if}
    {literal}
    <script type="text/javascript">
        $(function() {
            $(".grab-sorter").dragsort({
                dragSelector: "a.sorter-handler",
                dragBetween: false,
                itemSelector: 'li.sortable',
                placeHolderTemplate: "<li class='placeHolder'></li>",
                dragEnd: set_sort
            });
        });
    </script>
    {/literal}
{elseif $action == 'tree'}
    <div class="nicerblu">
        <div class="tree-block">
            {literal}
            <script>
                ajax_update("{/literal}?cmd={$cmd}&action=get_tree"{literal}, {}, '.tree-block', true);
            </script>
            {/literal}
        </div>
    </div>
{elseif $action=='get_tree' || $action=='browser' || $action=='getcat2'}
    <link rel="stylesheet" href="{$template_dir}js/tree/jqtree.css?v={$hb_version}">
    <script type="text/javascript" src="{$template_dir}js/tree/tree.jquery.js?v={$hb_version}"></script>
    <input type="text" id="jqitems_kb-search" class="input-sm jqitems-search" placeholder="Search..." >
    <div class="jqitems-tree"></div>
    {literal}
        <script>
            //retrieve data
            function retrieveData() {
                $.ajaxSetup({async:false});
                var returnData = null;
                $.post('?cmd=knowledgebase&action=get_tree&only_data=true',{},function (d) {returnData = d;});
                $.ajaxSetup({async:true});
                return $.parseJSON(returnData);
            }
            var kntree = $('.jqitems-tree'),
                filter = $('#jqitems_kb-search'),
                state = null,
                _filtering = false,
                data = retrieveData();

            kntree.tree({
                data: data,
                dragAndDrop: true,
                closedIcon: $('<i class="fa fa-folder"></i>'),
                openedIcon: $('<i class="fa fa-folder-open"></i>'),
                useContextMenu: false,
                onCreateLi: function(node, $li) {
                    var search = filter.val().toLowerCase();
                    var icon = '';
                    var html = '';
                    if (search !== '') {
                        $li.hide();
                        if (!node.is_cat) {
                            var value = node.name.toLowerCase();
                            var parent = node.parent;
                            if (value.indexOf(search) > -1) {
                                $li.show();
                                $li.find('.jqtree-title').addClass('jqtree-title-active');
                                while (typeof (parent.element) !== 'undefined') {
                                    kntree.tree('openNode', parent);
                                    $(parent.element).show().addClass('jqtree-filtered');
                                    parent = parent.parent;
                                }
                            }
                            if (!_filtering) {
                                _filtering = true;
                            }
                            if (!kntree.hasClass('jqtree-filtering')) {
                                kntree.addClass('jqtree-filtering');
                            }
                        }
                    } else {
                        if (_filtering) {
                            _filtering = false;
                        }
                        if (kntree.hasClass('jqtree-filtering')) {
                            kntree.removeClass('jqtree-filtering');
                        }
                    }
                    if (node.is_cat) {
                        icon = '<a class="jqtree-toggler jqtree_common jqtree-toggler-left" role="presentation" aria-hidden="true"><i class="fa fa-folder-open"></i></a>';
                        html += '<a href="?cmd=knowledgebase&action=category&cid='+ node.item_id +'" target="_blank" class="edit jqtree-element-link">edit</a>';
                        $li.not('.jqtree-folder').find('.jqtree-element').find('.jqtree-toggler').find('i').remove();
                        $li.not('.jqtree-folder').find('.jqtree-element').prepend(icon);
                        $li.find('.jqtree-element').append(html);
                    } else {
                        icon = '<a class="jqtree-toggler jqtree_common jqtree-toggler-left" role="presentation" aria-hidden="true"><i class="fa fa-newspaper-o"></i></a>';
                        html += '<a href="?cmd=knowledgebase&action=article&id='+ node.item_id +'" target="_blank" class="edit jqtree-element-link">edit</a>';
                        $li.find('.jqtree-element').prepend(icon);
                        $li.find('.jqtree-element').append(html);
                    }
                }
            }).on(
                'tree.move',
                function(event) {
                    if (filter.val().toLowerCase() == '') {
                        if (!event.move_info.target_node.is_cat && event.move_info.position  == 'inside')  {
                            event.preventDefault();
                        } else {
                            window.setTimeout(function () {
                                var json = kntree.tree('toJson');
                                $.post('{/literal}?cmd={$cmd}&action=update_tree{literal}', {tree:json},  function(data){parse_response(data)});
                            }, 200);
                        }
                    } else {
                        event.preventDefault();
                        alert('You can not move items while searching');
                    }
                }
            ).on(
                'tree.click',
                function(event) {
                    var node = event.node;
                    if (typeof node == 'object' && $('#replyarea').length && !node.is_cat)  {
                        $.post('?cmd=knowledgebase', {action: 'getr', id: node.item_id}, function(data) {
                            data = parse_response(data);
                            $('#replyarea').val($('#replyarea').val() + "\r\n" + data).focus();
                        });
                        return false;
                    } else {
                        if (event.click_event.srcElement.classList.contains('jqtree-element-link')){
                            event.click_event.preventDefault();
                            window.open(event.click_event.srcElement.href, '_blank');
                        } else {
                            kntree.tree('toggle', event.node);
                        }
                    }
                }
            ).on(
                'tree.open',
                function(e) {
                    if (filter.val().toLowerCase() == '') {
                        state = kntree.tree('getState');
                    }
                }
            ).on(
                'tree.close',
                function(e) {
                    if (filter.val().toLowerCase() == '') {
                        state = kntree.tree('getState');
                    }
                }
            );
            filter.keyup(function() {
                kntree.tree('loadData', data);
                console.log(filter.val().toLowerCase());
                if (filter.val().toLowerCase() == '') {
                    kntree.tree('setState', state);
                }
            });
        </script>
    {/literal}
{elseif $action=='statistics'}
    <div style="padding: 7px;">
        <table width="100%" cellspacing="0" cellpadding="3" border="0" class="whitetable" style="border:solid 1px #ddd;">
            <tbody>
            <tr>
                <th colspan="4" align="left">{$lang.Knowledgebase}</th>
            </tr>
            {foreach from=$statistics item=statistic}
                <tr class="havecontrols even ">
                    <td><a href="?cmd=reports&action=get&id={$statistic.id}">{$statistic.name}</a></td>
                    {if !($statistic.options & 1)}
                        <td width="60">
                            <a href="?cmd=reports&action=delete&id={$statistic.id}&security_token={$security_token}" style="float: right" onclick="return confirm('Are you sure you wish to remove this report?');" class="delbtn">Delete</a>
                        </td>
                    {else}
                        <td width="60">
                            <a href="?cmd=reports&action=customize&id={$statistic.id}&security_token={$security_token}" class="editbtn editgray">Customize</a>
                        </td>
                    {/if}
                </tr>
            {/foreach}
            </tbody>
        </table>
    </div>
{/if}