$.fn.getType = function () {
    return this[0].tagName == "INPUT" ? this[0].type.toLowerCase() : this[0].tagName.toLowerCase();
};

function uniqueId() {
    return '_' + Math.random().toString(36).substr(2, 9);
}

function microtime() {
    return Date.now();
}

var LeftMenuEditor = {
    init: function (data) {
        console.log('data menuleft');
        console.log(data);
        $.menuTree.tree.tree({
            data: data,
            dragAndDrop: true,
            useContextMenu: false,
            autoOpen: true,
            onCreateLi: function (node, $li) {
                var icon = '',
                    shdetails = '',
                    node_url = '';

                if (node.conditions && node.conditions.customers && node.conditions.customers.value == '1')
                    shdetails += '<i class="fa fa-xs fa-lock" style="font-size: 12px; color: #C2C3C4; margin-left: 10px;"></i>';

                if (node.type == "section") {
                    $li.html('' +
                        '<table class="tc_li_table tc_li_table_section jqtree_common"><tbody><tr class="jqtree-element jqtree_common tc_item_id_' + node.id + '">\n' +
                        '<td class="tc_item_name jqtree-title jqtree_common" colspan="3" >Section: <b>' + node.name + '</b> <span class="tc_item_shdetails"> ' + shdetails + '</span></td>' +
                        '<td align="right" style="width: 320px;">\n' +
                        '<a href="#" class="btn btn-default btn-xs jqtree-element-link" onclick="LeftMenuEditor.addMenuItem(\'link\',\'' + node.id + '\');return false;"><span class="fa fa-link"></span> Add link</a>\n' +
                        '<a href="#" class="btn btn-default btn-xs jqtree-element-link" onclick="LeftMenuEditor.addMenuItem(\'list\',\'' + node.id + '\');return false;"><span class="fa fa-list"></span> Add list</a>\n' +
                        '<a href="#" class="btn btn-default btn-xs jqtree-element-link" onclick="LeftMenuEditor.editMenuItem(\'' + node.id + '\');return false;"><span class="fa fa-edit"></span> Edit</a>\n' +
                        '<a href="#" class="btn btn-default btn-xs jqtree-element-link" style="color: red;" onclick="LeftMenuEditor.removeMenuItem(\'' + node.id + '\');return false;"><span class="fa fa-trash-o"></span> Remove</a>' +
                        '</td>' +
                        '<td width="50px"><i style="color: #bbb;" class="fa fa-sort fa-xs"></i></td>' +
                        '</tr></tbody></table>' +
                        '');
                    $('.tc_li_table_section').css("border", "none");
                    $($li).css("border", "1px solid #eee");
                    $($li).css("margin", "20px 0");
                    $($li).css("background-color", "#fcfcfc");
                    $($li).css("box-shadow", "0 0 2px rgba(100,100,100,0.1)");
                } else if (node.type == "link") {
                    if (node.options && node.options.new_tab && node.options.new_tab.value == '1')
                        shdetails += '<i class="fa fa-xs fa-external-link" style="font-size: 12px; color: #C2C3C4; margin-left: 10px;"></i>';

                    if (node.url_type) {
                        if (node.url_type === 'system') {
                            node_url = $.menuTree.caurl + node.url;
                        } else if (node.url_type === 'custom') {
                            node_url = node.url;
                        }
                    }
                    $li.html('' +
                        '<table class="tc_li_table tc_li_table_item jqtree_common"><tbody><tr class="jqtree-element jqtree_common tc_item_id_' + node.id + '">\n' +
                        '<td class="tc_item_name jqtree-title jqtree_common" width="30%">Link: <b>' + node.name + '</b> <span class="tc_item_shdetails"> ' + shdetails + '</span></td>' +
                        '<td class="tc_item_icon" width="15%"><span>Icon:</span> <b>' + node.icon + '</b></td>' +
                        '<td class="tc_item_url"><span>URL:</span> <b><a href="' + node_url + '" target="_blank">' + node_url + '</a></b></td>' +
                        '<td align="right" style="width: 160px;">\n' +
                        '<a href="#" class="btn btn-default btn-xs jqtree-element-link" onclick="LeftMenuEditor.editMenuItem(\'' + node.id + '\');return false;"><span class="fa fa-edit"></span> Edit</a>\n' +
                        '<a href="#" class="btn btn-default btn-xs jqtree-element-link" style="color: red;" onclick="LeftMenuEditor.removeMenuItem(\'' + node.id + '\');return false;"><span class="fa fa-trash-o"></span> Remove</a>' +
                        '</td>' +
                        '<td width="50px"><i style="color: #bbb;" class="fa fa-sort fa-xs"></i></td>' +
                        '</tr></tbody></table>' +
                        '');
                } else if (node.type == "list") {
                    $li.html('' +
                        '<table class="tc_li_table tc_li_table_item jqtree_common"><tbody><tr class="jqtree-element jqtree_common tc_item_id_' + node.id + '">\n' +
                        '<td class="tc_item_name jqtree-title jqtree_common" width="30%">List: <b>' + node.name + '</b> <span class="tc_item_shdetails"> ' + shdetails + '</span></td>' +
                        '<td class="tc_item_icon" width="15%"><span>Icon:</span> <b>' + node.icon + '</b></td>' +
                        '<td class="tc_item_list"><span>List:</span> <b>' + node.list + '</b></td>' +
                        '<td align="right" style="width: 160px;">\n' +
                        '<a href="#" class="btn btn-default btn-xs jqtree-element-link" onclick="LeftMenuEditor.editMenuItem(\'' + node.id + '\');return false;"><span class="fa fa-edit"></span> Edit</a>\n' +
                        '<a href="#" class="btn btn-default btn-xs jqtree-element-link" style="color: red;" onclick="LeftMenuEditor.removeMenuItem(\'' + node.id + '\');return false;"><span class="fa fa-trash-o"></span> Remove</a>' +
                        '</td>' +
                        '<td width="50px"><i style="color: #bbb;" class="fa fa-sort fa-xs"></i></td>' +
                        '</tr></tbody></table>' +
                        '');
                }
            }
        }).on(
            'tree.move',
            function (event) {
                var mnt = event.move_info.moved_node.type;
                var tnt = event.move_info.target_node.type;
                var p = event.move_info.position;

                //section
                if (mnt === 'section' && p === 'inside') {
                    event.preventDefault();
                }
                if (mnt === 'section' && p === 'after' && tnt !== 'section') {
                    event.preventDefault();
                }

                //not section
                if (mnt !== 'section' && p === 'inside' && tnt !== 'section') {
                    event.preventDefault();
                }
            }
        ).on(
            'tree.click',
            function (event) {
                if (!event.click_event.srcElement.classList.contains('jqtree-element-link') && !event.click_event.srcElement.parentNode.classList.contains('jqtree-element-link')) {
                    $.menuTree.tree.tree('toggle', event.node);
                }
            }
        );
        $.menuTree.tree.defaultOptions = {
            "section": {},
            "list": {
                "open": {
                    "name": "Keep menu open",
                    "type": "checkbox",
                    "default": 1
                },
            },
            "link": {
                "new_tab": {
                    "name": "Open in a new tab",
                    "type": "checkbox",
                    "default": "0"
                }
            }
        };
        $.menuTree.tree.defaultConditions = {
            "section": {
                "customers": {
                    "name": "Type of customers",
                    "type": "select",
                    "options": {
                        "0": "For all customers",
                        "1": "Only for authorized customers",
                        "-1": "Only for not authorized customers"
                    }
                }
            },
            "list": {
                "customers": {
                    "name": "Type of customers",
                    "type": "select",
                    "options": {
                        "0": "For all customers",
                        "1": "Only for authorized customers",
                        "-1": "Only for not authorized customers"
                    }
                }
            },
            "link": {
                "customers": {
                    "name": "Type of customers",
                    "type": "select",
                    "options": {
                        "0": "For all customers",
                        "1": "Only for authorized customers",
                        "-1": "Only for not authorized customers"
                    }
                }
            }
        };
    },
    addMenuItem: function ($type, $parent_id = false) {
        let $params = {};
        let $parent = null;
        if ($parent_id !== false) {
            $parent = $.menuTree.tree.tree('getNodeById', $parent_id);
        }
        $params.id = microtime();
        $params.type = $type;
        $params.name = 'New menu ' + $type;
        $params.options = $.menuTree.tree.defaultOptions[$type];
        $params.conditions = $.menuTree.tree.defaultConditions[$type];

        switch ($type) {
            case "section":
                $params.children = [];
                break;
            case "link":
                $params.icon = '';
                $params.url = '';
                $params.url_type = '';
                break;
            case "list":
                $params.icon = '';
                break;
        }
        $.menuTree.tree.tree(
            'appendNode',
            $params,
            $parent
        );
        if ($parent_id !== false && $parent) {
            $.menuTree.tree.tree('openNode', $parent);
        }
    },
    removeMenuItem: function (node_id) {
        if (confirm('Are you sure?')) {
            var node = $.menuTree.tree.tree('getNodeById', node_id);
            $.menuTree.tree.tree('removeNode', node);
        }
    },
    editMenuItem: function (node_id) {
        $('#treeeditor-modal_menuleft').modal('show');

        var urlf, listf, id, md, md_name, tr, node;

        node = $.menuTree.tree.tree('getNodeById', node_id);
        tr = $('.tree-editor-menuleft .tc_item_id_' + id);
        md = $('.tc_item_modal_menuleft');

        md.find('input[name="tc_item_id"]').val(node.id);
        md.find('input[name="tc_item_name"]').val(node.name);

        tr.find('.tc_item_name').find('b').html(md_name);
        md.find('.tc_item_modal_additional').hide();

        if (node.type === 'link' || node.type === 'list') {
            md.find('input[name="tc_item_icon"]').val(node.icon);

            if (node.type === 'link') {
                md.find('.tc_item_modal_additional_link').show();
                md.find('input[name="tc_item_url_type"]').prop('checked', false);
                md.find('input[name="tc_item_url_type"][value="' + node.url_type + '"]').prop('checked', true);
                md.find('.tc_item_url_box').hide();
                urlf = md.find('input[name="tc_item_url"]').val('');
                if (node.url_type === 'system') {
                    md.find('.tc_item_url_box_system').show();
                    urlf = md.find('select[name="tc_item_url"]').val(node.url).change();
                } else if (node.url_type === 'custom') {
                    md.find('.tc_item_url_box_custom').show();
                    urlf = md.find('input[name="tc_item_url"]').val(node.url);
                }
            } else if (node.type === 'list') {
                md.find('.tc_item_modal_additional_list').show();
                md.find('select[name="tc_item_list"]').val(node.list).change();
            }
        }

        if (node.type === 'section') {
            md.find('.tc_item_modal_conditions').show();
        }

        md.find('.tc_item_custom_options').html('');
        if (!$.isEmptyObject(node.options)) {
            md.find('.tc_item_modal_options').show();
            $('.tc_item_custom_options').html(this.prepareItemElements(node.options));
        }

        md.find('.tc_item_custom_conditions').html('');
        if (!$.isEmptyObject(node.conditions)) {
            md.find('.tc_item_modal_conditions').show();
            $('.tc_item_custom_conditions').html(this.prepareItemElements(node.conditions));
        }

        this.handleTranslations(node.name);
    },
    prepareItemElements: function (elements) {
        return Utils.prepareItemElements(elements);
    },
    saveMenuItem: function () {
        $('#treeeditor-modal_menuleft').modal('hide');
        var md, id, md_name, tr, md_url_type, md_url, md_icon, md_options, md_conditions, md_list, node, shdetails = '';
        md = $('.tc_item_modal_menuleft');
        id = md.find('input[name="tc_item_id"]').val();
        md_name = md.find('input[name="tc_item_name"]').val();
        node = $.menuTree.tree.tree('getNodeById', id);
        tr = $('.tree-editor-menuleft .tc_item_id_' + id);
        md_options = md.find('.tc_item_modal_options').find('input, textarea, select');
        node = this.saveItemValues(node, md_options, 'options');

        md_conditions = md.find('.tc_item_modal_conditions').find('input, textarea, select');
        node = this.saveItemValues(node, md_conditions, 'conditions');

        if (node.type === 'link' || node.type === 'list') {


            md_icon = md.find('input[name="tc_item_icon"]').val();
            if (node.conditions.customers.value == '1')
                shdetails += '<i class="fa fa-xs fa-lock" style="font-size: 12px; color: #C2C3C4; margin-left: 10px;"></i>';

            if (node.type === 'link') {
                if (node.options.new_tab.value == '1')
                    shdetails += '<i class="fa fa-xs fa-external-link" style="font-size: 12px; color: #C2C3C4; margin-left: 10px;"></i>';

                md_url_type = md.find('input[name="tc_item_url_type"]:checked').val();
                if (md_url_type === 'system') {
                    md_url = md.find('select[name="tc_item_url"]').val();
                    tr.find('.tc_item_url').find('b').find('a').attr('href', $.menuTree.caurl + md_url).html($.menuTree.caurl + md_url);
                } else if (md_url_type === 'custom') {
                    md_url = md.find('input[name="tc_item_url"]').val();
                    tr.find('.tc_item_url').find('b').find('a').attr('href', md_url).html(md_url);
                }
                node.url = md_url;
                node.url_type = md_url_type;

            } else if (node.type === 'list') {
                md_list = md.find('select[name="tc_item_list"]').val();
                node.list = md_list;
                tr.find('.tc_item_list').find('b').html(md_list);
            }
            node.icon = md_icon;
            tr.find('.tc_item_icon').find('b').html(md_icon);
            tr.find('.tc_item_shdetails').html(shdetails);
        }
        tr.find('.tc_item_name').find('b').html(md_name);
        node.name = md_name;
    },
    saveItemValues: function (node, elements, where) {
        return Utils.prepareSaveNodeValue(node, elements, where);
    },
    handleTranslations: function ($name) {
        var parsed = Utils.handleTranslations($name);
        $('#l_editor_tc_item_name .translations').children().not('.taag').remove();
        $('#l_editor_tc_item_name .translations').append(parsed);
    },
};

var FooterEditor = {
    init: function (data) {
        console.log('data footer');
        console.log(data);
        $.footerTree.tree.tree({
            data: data,
            dragAndDrop: true,
            useContextMenu: false,
            autoOpen: true,
            onCreateLi: function (node, $li) {
                var shdetails = '',
                    node_url = '';
                if (node.conditions && node.conditions.customers && node.conditions.customers.value == '1')
                    shdetails += '<i class="fa fa-xs fa-lock" style="font-size: 12px; color: #C2C3C4; margin-left: 10px;"></i>';
                if (node.options && node.options.new_tab && node.options.new_tab.value == '1')
                    shdetails += '<i class="fa fa-xs fa-external-link" style="font-size: 12px; color: #C2C3C4; margin-left: 10px;"></i>';
                if (node.url_type) {
                    if (node.url_type === 'system') {
                        node_url = $.footerTree.caurl + node.url;
                    } else if (node.url_type === 'custom') {
                        node_url = node.url;
                    }
                }
                $li.html('' +
                    '<table class="tc_li_table tc_li_table_item jqtree_common"><tbody><tr class="jqtree-element jqtree_common tc_item_id_' + node.id + '">\n' +
                    '<td class="tc_item_name jqtree-title jqtree_common" width="30%">Link: <b>' + node.name + '</b> <span class="tc_item_shdetails"> ' + shdetails + '</span></td>' +
                    '<td class="tc_item_url"><span>URL:</span> <b><a href="' + node_url + '" target="_blank">' + node_url + '</a></b></td>' +
                    '<td align="right" style="width: 160px;">\n' +
                    '<a href="#" class="btn btn-default btn-xs jqtree-element-link" onclick="FooterEditor.editMenuItem(\'' + node.id + '\');return false;"><span class="fa fa-edit"></span> Edit</a>\n' +
                    '<a href="#" class="btn btn-default btn-xs jqtree-element-link" style="color: red;" onclick="FooterEditor.removeMenuItem(\'' + node.id + '\');return false;"><span class="fa fa-trash-o"></span> Remove</a>' +
                    '</td>' +
                    '<td width="50px"><i style="color: #bbb;" class="fa fa-sort fa-xs"></i></td>' +
                    '</tr></tbody></table>' +
                    '');
            }
        }).on('tree.move', function (event) {
                var p = event.move_info.position;
                if (p === 'inside') {
                    event.preventDefault();
                }
            }
        ).on('tree.click', function (event) {
                if (!event.click_event.srcElement.classList.contains('jqtree-element-link') && !event.click_event.srcElement.parentNode.classList.contains('jqtree-element-link')) {
                    $.footerTree.tree.tree('toggle', event.node);
                }
            }
        );
        $.footerTree.tree.defaultOptions = {
            "link": {
                "new_tab": {
                    "name": "Open in a new tab",
                    "type": "checkbox",
                    "default": "0"
                }
            }
        };
        $.footerTree.tree.defaultConditions = {
            "link": {
                "customers": {
                    "name": "Type of customers",
                    "type": "select",
                    "options": {
                        "0": "For all customers",
                        "1": "Only for authorized customers",
                        "-1": "Only for not authorized customers"
                    }
                }
            }
        };
    },
    addMenuItem: function () {
        let $params = {};
        $params.id = microtime();
        $params.name = 'New menu link';
        $params.options = $.footerTree.tree.defaultOptions.link;
        $params.conditions = $.footerTree.tree.defaultConditions.link;
        $params.url = '';
        $params.url_type = '';
        $.footerTree.tree.tree(
            'appendNode',
            $params
        );
    },
    removeMenuItem: function (node_id) {
        if (confirm('Are you sure?')) {
            var node = $.footerTree.tree.tree('getNodeById', node_id);
            $.footerTree.tree.tree('removeNode', node);
        }
    },
    editMenuItem: function (node_id) {
        $('#treeeditor-modal_footer').modal('show');

        var urlf, listf, id, md, md_name, tr, node;

        node = $.footerTree.tree.tree('getNodeById', node_id);
        tr = $('.tree-editor-footer .tc_item_id_' + id);
        md = $('.tc_item_modal_footer');

        md.find('input[name="tc_item_id"]').val(node.id);
        md.find('input[name="tc_item_name"]').val(node.name);

        tr.find('.tc_item_name').find('b').html(md_name);
        md.find('.tc_item_modal_additional').hide();

        md.find('.tc_item_modal_additional_link').show();
        md.find('.tc_item_modal_icon').hide();
        md.find('input[name="tc_item_url_type"]').prop('checked', false);
        md.find('input[name="tc_item_url_type"][value="' + node.url_type + '"]').prop('checked', true);
        md.find('.tc_item_url_box').hide();
        urlf = md.find('input[name="tc_item_url"]').val('');
        if (node.url_type === 'system') {
            md.find('.tc_item_url_box_system').show();
            urlf = md.find('select[name="tc_item_url"]').val(node.url).change();
        } else if (node.url_type === 'custom') {
            md.find('.tc_item_url_box_custom').show();
            urlf = md.find('input[name="tc_item_url"]').val(node.url);
        }
        md.find('.tc_item_custom_options').html('');
        if (!$.isEmptyObject(node.options)) {
            md.find('.tc_item_modal_options').show();
            $('.tc_item_custom_options').html(this.prepareItemElements(node.options));
        }

        md.find('.tc_item_custom_conditions').html('');
        if (!$.isEmptyObject(node.conditions)) {
            md.find('.tc_item_modal_conditions').show();
            $('.tc_item_custom_conditions').html(this.prepareItemElements(node.conditions));
        }

        this.handleTranslations(node.name);
    },
    prepareItemElements: function (elements) {
        return Utils.prepareItemElements(elements);
    },
    saveMenuItem: function () {
        $('#treeeditor-modal_footer').modal('hide');
        var md, id, md_name, tr, md_url_type, md_url, md_options, md_conditions, md_list, node, shdetails = '';
        md = $('.tc_item_modal_footer');
        id = md.find('input[name="tc_item_id"]').val();
        md_name = md.find('input[name="tc_item_name"]').val();
        node = $.footerTree.tree.tree('getNodeById', id);
        tr = $('.tree-editor-footer .tc_item_id_' + id);
        md_options = md.find('.tc_item_modal_options').find('input, textarea, select');
        node = this.saveItemValues(node, md_options, 'options');

        md_conditions = md.find('.tc_item_modal_conditions').find('input, textarea, select');
        node = this.saveItemValues(node, md_conditions, 'conditions');

        if (node.conditions.customers.value == '1')
            shdetails += '<i class="fa fa-xs fa-lock" style="font-size: 12px; color: #C2C3C4; margin-left: 10px;"></i>';
        if (node.options.new_tab.value == '1')
            shdetails += '<i class="fa fa-xs fa-external-link" style="font-size: 12px; color: #C2C3C4; margin-left: 10px;"></i>';
        md_url_type = md.find('input[name="tc_item_url_type"]:checked').val();
        if (md_url_type === 'system') {
            md_url = md.find('select[name="tc_item_url"]').val();
            tr.find('.tc_item_url').find('b').find('a').attr('href', $.footerTree.caurl + md_url).html($.footerTree.caurl + md_url);
        } else if (md_url_type === 'custom') {
            md_url = md.find('input[name="tc_item_url"]').val();
            tr.find('.tc_item_url').find('b').find('a').attr('href', md_url).html(md_url);
        }
        node.url = md_url;
        node.url_type = md_url_type;
        tr.find('.tc_item_shdetails').html(shdetails);
        tr.find('.tc_item_name').find('b').html(md_name);
        node.name = md_name;
    },
    saveItemValues: function (node, elements, where) {
        return Utils.prepareSaveNodeValue(node, elements, where);
    },
    handleTranslations: function ($name) {
        var parsed = Utils.handleTranslations($name);
        $('#l_editor_tc_item_name .translations').children().not('.taag').remove();
        $('#l_editor_tc_item_name .translations').append(parsed);
    },
};

var Utils = {
    prepareItemElements: function (elements) {
        var ret = '', val, options, selected;
        $.each(elements, function (item_key, item) {
            val = '';
            selected = '';
            switch (item.type) {
                case "checkbox":
                    if (typeof item.value === "undefined" && typeof item.default != "undefined" && item.default === '1') {
                        val = 'checked="checked"';
                    } else if (typeof item.value != "undefined" && item.value) {
                        val = 'checked="checked"';
                    }
                    ret = ret + '<input type="checkbox" value="1" ' + val + ' name="' + item_key + '"> ' + item.name + '<br><br>';
                    break;
                case "input":
                    if (typeof item.value === "undefined" && typeof item.default != "undefined" && item.default !== '') {
                        val = item.default;
                    } else if (typeof item.value != "undefined" && item.value) {
                        val = item.value;
                    }
                    ret = ret + '<input type="text"  name="' + item_key + '" placeholder="' + item.name + '"><br><br>';
                    break;
                case "textarea":
                    if (typeof item.value === "undefined" && typeof item.default != "undefined" && item.default !== '') {
                        val = item.default;
                    } else if (typeof item.value != "undefined" && item.value) {
                        val = item.value;
                    }
                    ret = ret + '<textarea name="' + item_key + '" placeholder="' + item.name + '"></textarea><br>';
                    break;
                case "select":
                    if (typeof item.value === "undefined" && typeof item.default != "undefined" && item.default !== '') {
                        selected = item.default;
                    } else if (typeof item.value != "undefined" && item.value) {
                        selected = item.value;
                    }
                    options = '';
                    $.each(item.options, function (opt_key, opt_name) {
                        val = (selected === opt_key ? 'selected="selected"' : '');
                        options += '<option ' + val + ' value="' + opt_key + '">' + opt_name + '</option>';
                    });
                    ret = ret + '<span>' + item.name + '</span> <br>';
                    ret = ret + '<select class="form-control" name="' + item_key + '">' + options + '</select><br>';
                    break;
                default:
            }
        });
        return ret;
    },
    prepareSaveNodeValue: function (node, elements, where) {
        $.each(elements, function (index, el) {
            var item_key = $(el).attr('name'),
                val = $(el).val(),
                type;
            type = $(el).getType();
            if (!(where in node)) {
                node[where] = {};
            }
            if (!(item_key in node[where])) {
                node[where][item_key] = {};
                node[where][item_key].value = '';
            }
            switch (type) {
                case "checkbox":
                    node[where][item_key].value = $(el).is(':checked') ? 1 : 0;
                    break;
                case "input":
                case "textarea":
                case "select":
                    node[where][item_key].value = val;
                    break;
                default:
            }
        });
        return node;
    },
    handleTranslations: function ($name) {
        const regex = /({\$lang\..*?})/gm;
        let $m;
        let $parsed = "";
        let $last;
        while (($m = regex.exec($name)) !== null) {
            if ($m.index === regex.lastIndex) {
                regex.lastIndex++;
            }
            $m.forEach((line, groupIndex) => {
                var $a = line;
                $a = $a.replace('{$lang.', '');
                $a = $a.replace('}', '');
                if ($a === $last)
                    return;
                $last = $a;
                $parsed = $parsed + '<a href="?cmd=langedit&action=bulktranslate&key=' + $a + '" target="_blank">' + line + '</a>';
            });
        }
        return $parsed;
    }
};

var CodeEditor = {
    init: function (section, vr, type) {
        var editor = ace.edit("ace-" + section + "-" + vr);
        var textarea = $("#ace-" + section + "-" + vr + "-textarea").hide();

        editor.setTheme("ace/theme/chrome");
        editor.getSession().setValue(textarea.val());
        editor.getSession().setMode("ace/mode/" + type);
        editor.setOptions({
            minLines: 30,
            maxLines: 99999,
        });
        editor.getSession().on('change', function () {
            textarea.val(editor.getSession().getValue());
        });
    }
};

var Override = {
    add: function () {
        var main = $('.tc-overrides'),
            id = uniqueId(),
            html = '<table class="tc-overrides-item" data-id="' + id + '">\n' +
                '                    <tbody>\n' +
                '                        <tr>\n' +
                '                            <td width="40%">\n' +
                '                                <span>Source:</span>\n' +
                '                                <b class="tc-overrides-item-source"></b>\n' +
                '                            </td>\n' +
                '                            <td width="40%">\n' +
                '                                <span>Target:</span>\n' +
                '                                <b class="tc-overrides-item-target"></b>\n' +
                '                            </td>\n' +
                '                            <td align="right" style="width: 160px;">\n' +
                '                                <a href="#" class="btn btn-default btn_edit btn-xs" onclick="Override.edit(this);return false;"><span class="fa fa-edit"></span> Edit</a>\n' +
                '                                <a href="#" class="btn btn-default btn-xs" style="color: red;" onclick="Override.remove(this);return false;"><span class="fa fa-trash-o"></span> Remove</a>\n' +
                '                            </td>\n' +
                '                        </tr>\n' +
                '                    </tbody>\n' +
                '                </table>';
        main.append(html);
        main.find('.tc-overrides-item[data-id="' + id + '"]').find('a.btn_edit').trigger('click');
    },
    edit: function (el) {
        $('#item-override').modal('show');
        var md, sr, tr, id;
        md = $('.tc_override_modal');
        id = $(el).closest('.tc-overrides-item').attr('data-id');
        sr = $(el).closest('.tc-overrides-item').find('.tc-overrides-item-source');
        tr = $(el).closest('.tc-overrides-item').find('.tc-overrides-item-target');
        md.find('input[name="tc_override_id"]').val(id);
        md.find('input[name="tc_override_source"]').val(sr.html());
        md.find('input[name="tc_override_target"]').val(tr.html());
    },
    save: function () {
        $('#item-override').modal('hide');
        var md, sr, tr, id;
        md = $('.tc_override_modal');
        id = md.find('input[name="tc_override_id"]').val();
        sr = md.find('input[name="tc_override_source"]').val();
        tr = md.find('input[name="tc_override_target"]').val();
        $('.tc-overrides').find('.tc-overrides-item[data-id="' + id + '"]').find('.tc-overrides-item-source').html(sr);
        $('.tc-overrides').find('.tc-overrides-item[data-id="' + id + '"]').find('.tc-overrides-item-target').html(tr);
    },
    remove: function (el) {
        if (confirm('Are you sure?'))
            $(el).closest('.tc-overrides-item').remove();
    },
};

var Orderpage = {
    edit: function (el) {
        $('#item-orderpage').modal('show');
        var md, ic, id, path;
        md = $('.tc_orderpage_modal');
        id = $(el).closest('.tc-orderpage-item').attr('data-id');
        ic = $(el).closest('.tc-orderpage-item').find('.tc-orderpage-item-icon');
        path = $('.tc-orderpages').attr('data-icons_path');
        md.find('input[name="tc_orderpage_id"]').val(id);
        md.find('input[name="tc_orderpage_icon"]').val(ic.html());
        if (ic.html().length > 0) {
            md.find('.tc_orderpage_icon_url').attr('src', path + ic.html());
        } else {
            md.find('.tc_orderpage_icon_url').hide();
        }
    },
    save: function () {
        $('#item-orderpage').modal('hide');
        var md, ic, id, path;
        md = $('.tc_orderpage_modal');
        id = md.find('input[name="tc_orderpage_id"]').val();
        ic = md.find('input[name="tc_orderpage_icon"]').val();
        path = $('.tc-orderpages').attr('data-icons_path');
        $('.tc-orderpages').find('.tc-orderpage-item[data-id="' + id + '"]').find('.tc-orderpage-item-icon').html(ic);
        $('.tc-orderpages').find('.tc-orderpage-item[data-id="' + id + '"]').find('.tc-orderpage-item-icon-url').show().attr('src', path + ic);
    },
    show_icons: function () {
        $('#orderpage-icons').modal('show');
    },
    select_icon: function (name) {
        $('#orderpage-icons').modal('hide');

        var md, path;
        md = $('.tc_orderpage_modal');
        path = $('.tc-orderpages').attr('data-icons_path');
        md.find('input[name="tc_orderpage_icon"]').val(name);
        md.find('.tc_orderpage_icon_url').show().attr('src', path + name);
    }
};

$(function () {
    $('#theme_config_form').on('submit', function () {
        if ($('li[data-id="left_menu"]').is('.active')) {
            $('#theme_config_form').append('<textarea style="display: none;" name="left_menu">' + $.menuTree.tree.tree('toJson') + '</textarea>');
        }
        if ($('li[data-id="footer"]').is('.active')) {
            $('#theme_config_form').append('<textarea style="display: none;" name="footer">' + $.footerTree.tree.tree('toJson') + '</textarea>');
        }

        if ($('li[data-id="overrides"]').is('.active')) {
            var overrides = [];
            $('.tc-overrides-item').each(function () {
                overrides.push({
                    source: $(this).find('.tc-overrides-item-source').html(),
                    target: $(this).find('.tc-overrides-item-target').html()
                });
            });
            overrides = JSON.stringify(overrides);
            $('#theme_config_form').append('<textarea style="display: none;" name="overrides">' + overrides + '</textarea>');
        }

        if ($('li[data-id="orderpages"]').is('.active')) {
            var orderpages = {};
            $('.tc-orderpage-item').each(function () {
                var id = $(this).attr('data-id');
                orderpages[id] ={
                    id: id,
                    icon: $(this).find('.tc-orderpage-item-icon').html()
                };
            });
            orderpages = JSON.stringify(orderpages);
            $('#theme_config_form').append('<textarea style="display: none;" name="orderpages">' + orderpages + '</textarea>');
        }
    });

    $($('.tc_item_modal_menuleft').find('input[name="tc_item_name"]')).on('change input', function () {
        if ($(this).val() != '')
            LeftMenuEditor.handleTranslations($(this).val());
    });

    $($('.tc_item_modal_footer').find('input[name="tc_item_name"]')).on('change input', function () {
        if ($(this).val() != '')
            FooterEditor.handleTranslations($(this).val());
    });

    $('.tc-overrides').find('.tc-overrides-item').each(function () {
        var el = $(this);
        el.attr('data-id', uniqueId());
    });

    $('.colorSelector').each(function () {
        var self = $(this),
            parent = self.closest('.colorpicker-box'),
            input = parent.find('input'),
            value = self.attr('data-value');

        self.ColorPicker({
            onSubmit: function (hsb, hex, rgb, el) {
                $(el).val('#' + hex).ColorPickerHide();
            },
            onChange: function (hsb, hex, rgb) {
                self.css('backgroundColor', '#' + hex);
                input.val('#' + hex);
            },
            livePreview: true,
            color: value
        });
    });
    $('.colorSelector_input').on('input', function () {
        var self = $(this),
            val = $(this).val(),
            parent = self.closest('.colorpicker-box'),
            box = parent.find('.colorSelector');

        box.css('backgroundColor', val).ColorPickerSetColor(val);
    });
});
