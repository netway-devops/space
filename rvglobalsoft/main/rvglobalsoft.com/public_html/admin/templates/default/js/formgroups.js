(function ($, window) {

    if(window.hasOwnProperty('formGroupsScriptLoaded')){
        return;
    }

    window.formGroupsScriptLoaded = true;
    var group_data = {
        ajax_update_mode: false,
        type: 'form_item_group',
        param: 'form_id',
        form_param: 'forms',
        group: {},
        suggestions: {}
    };

    var last_search_string, last_search_end_offset = 0, search_result,
        results_container;

    var remove_list_input, remove_list = [];
    var applied_container, token, type_name;
    var init_state = $.Deferred();

    var hbrs = Handlebars.create(),
        tpl_forms, tpl_applied;

    function _render() {
        applied_container.html(tpl_applied({
            items: Object.keys(group_data.group.applied).length ? group_data.group.applied : null,
            form_param: group_data.form_param,
            url: _url('unapply')
        }))
    }

    function _render_search(offset, limit){
        offset = parseInt(offset) || 0;
        limit = parseInt(limit) || 100;
        last_search_end_offset = offset + limit;

        var subset = {},
            clean = offset === 0,
            next_offset = offset + limit;

        var item, group, hidden = 0;
        for(group of Object.values(search_result)){
            for(item of group){
                if(offset > 0){
                    offset--;
                    continue;
                }
                if(limit <= 0){
                   hidden++;
                   continue;
                }

                limit--;
                if(!subset.hasOwnProperty(item.prodname)){
                    subset[item.prodname] = [];
                }
                subset[item.prodname].push(item);
            }
        }

        last_search_end_offset -= limit;

        var msg = last_search_string ? "No results" : "Type in search form to list possible options" ;
        if (group_data.group.hasOwnProperty('type_id')) {
            msg += ' for ' + type_name + ' type';
        }

        var html = tpl_forms({
            suggested: Object.keys(subset).length ? subset : null,
            next_offset: next_offset,
            hidden: hidden,
            nothing_msg: msg,
            url: _url('apply')
        });

        if(clean){
            results_container.html(html);
        }else{
            results_container.find('.form-group-item-group-more').replaceWith(html)
        }
    }

    function _find_suggestion(id){
        var key, group;
        for(group of Object.keys(group_data.suggestions)){
            for(key of Object.keys(group_data.suggestions[group])){
                if(group_data.suggestions[group][key].id === id){
                    return {
                        item: group_data.suggestions[group][key],
                        group: group,
                        index: key
                    };
                }
            }
        }
    }

    function _ignore(result, status){
        if(group_data.type === 'form_item_group'){
            group_data.suggestions[result.group].ignore = status;
        } else {
            result.item.ignore = status;
        }
    }

    function _act(type, id){
        if(group_data.ajax_update_mode){
            return _request(type, id);
        }

        if(type === 'apply'){
            _act_apply(id)
        } else {
            _act_unapply(id)
        }

        last_search_string = null;
        last_search_end_offset = 0;
        _render();
        _search();
    }

    function _act_apply(id) {
        var result = _find_suggestion(id);
        if(!result){
            return;
        }

        _ignore(result, true);
        group_data.group.applied[id] = result.item;

        var rmindex = remove_list.indexOf(id);
        if(rmindex >= 0){
            remove_list.splice(rmindex, 1);
            remove_list_input.val(remove_list.join(','));
        }
    }

    function _act_unapply(id){
        var applied = group_data.group.applied[id];
        if(!applied){
            return;
        }

        var result = _find_suggestion(id);
        if(result){
            _ignore(result, false);
        }else{
            if(!group_data.suggestions.hasOwnProperty(applied.group)){
                group_data.suggestions[applied.prodname] = [];
            }
            group_data.suggestions[applied.prodname].push(applied);
        }

        if(!applied.hasOwnProperty('unapplied')){
            remove_list.push(id);
            remove_list_input.val(remove_list.join(','));
        }
        delete group_data.group.applied[id];
    }


    function _url(type, id) {
        type = type || 'apply';
        id = id || '';

        return'?cmd=formgroups&action=' + type + '_' + group_data.type
            + '&group_id=' + group_data.group.id
            + '&security_token=' + token
            + '&' + group_data.param + '=' + id;
    }

    function _request(type, id){
        var container = $('.ajax_container').addLoaders();

        $.get(_url(type, id)).done(function (data) {
            last_search_string = null;
            setFormGroupDara(data);
            _render();
            _search();
            container.hideLoader();
        })
    }

    function _search() {
        var string = $('.search_forms').val().trim().toLowerCase(),
            exact = $('.search_form_exact').is(':checked') === true;

        if(last_search_string !== null){
            last_search_end_offset = 0;
        }
        if(last_search_string === string){
            return;
        }

        last_search_string = string;
        //console.time('formSearch');
        search_result = {};

        if (string === '') {
            _render_search(0, last_search_end_offset);
            //console.timeEnd('formSearch');
            return;
        }

        var group, item, searchname;
        for(group of Object.values(group_data.suggestions)){
            if(group.hasOwnProperty('ignore') && group.ignore){
                continue;
            }
            for(item of group){
                if(item.hasOwnProperty('ignore') && item.ignore){
                    continue;
                }
                if(group_data.group.hasOwnProperty('type_id') && group_data.group.type_id !== item.type){
                    continue;
                }
                searchname = (exact ? item.name : item.fullname).toLowerCase();
                if(exact ? searchname !== string : searchname.indexOf(string) < 0){
                    continue;
                }
                if(!search_result.hasOwnProperty(item.prodname)){
                    search_result[item.prodname] = [];
                }
                search_result[item.prodname].push(item);
            }
        }
        _render_search(0, last_search_end_offset);
        //console.timeEnd('formSearch');
    }

    function _name(...arg){
        return arg.filter(function (e) {
            return e !== undefined;
        }).join(' - ')
    }


    function _normalize_data(data){
        group_data = $.extend(group_data, data);
        //group_data.ajax_update_mode = group_data.group.id !== 'new';

        var applied_tmp,
            forms_type = group_data.group.hasOwnProperty('forms');

        group_data.group.applied = {};
        if(forms_type){
            group_data.form_param = 'forms';
            applied_tmp = group_data.group['forms'];
        } else {
            group_data.form_param = 'items';
            applied_tmp = group_data.group['items'];
        }

        var key, index, obj;
        for(key of Object.keys(group_data.suggestions)){
            for(index of Object.keys(group_data.suggestions[key])){
                obj = group_data.suggestions[key][index];
                obj.prodname = key;
                obj.name = obj.hasOwnProperty('item_name') ?
                    obj['item_name'] : obj['form_name'];

                obj.fullname = _name(obj['form_name'], obj['item_name']);
                obj.unapplied = true;
            }
        }

        for(key of Object.keys(applied_tmp)){
            obj = applied_tmp[key];
            if(typeof obj !== 'object'){
                obj = _find_suggestion(obj);
                if(!obj){
                    continue;
                }
                _ignore(obj, false);
                obj = obj.item;
            }

            if(forms_type){
                obj.name = obj['form_name'];
                obj.prodname = obj['category_name'] + ' - #' + obj['product_id'] + ' ' + obj['product_name'];
            }else{
                obj.name = obj['item_name'];
                obj.prodname = obj['category_name'] + ' - ' + obj['product_name']
                    + ' - #' + obj['form_id'] + ' ' + obj['form_name'];
            }

            obj.fullname = _name(obj['form_name'], obj['item_name']);
            group_data.group.applied[obj.id] = obj;
        }
    }

    window.setFormGroupDara = function(data) {
        $('.ajax_container').addLoaders();
        $.get('?cmd=formgroups&action=suggestions&type=' + data.type, function (getdata) {
            _normalize_data($.extend(data, getdata));
            $('.ajax_container').hideLoader();
            init_state.resolve();
        })
    };

    $(function () {
        var tpl_dom = $('#forms-template');
        if(!tpl_dom.length){
            return false;
        }

        tpl_forms = hbrs.compile(tpl_dom.html());
        tpl_applied = hbrs.compile($('#applied-template').html());

        results_container = $('#result-container');
        applied_container = $('#applied-container');
        token = $('input[name=security_token]').val();
        remove_list_input = $('#form-group-remove-list');

        var type_select = $('#type_id');
        var $document = $(document);

        $('.chosen[data-chosen]').chosenedge({
            width: "100%",
            search_contains: true,
        });

        $document.on('change keyup', '.search_forms', _search);
        $document.on('change', '.search_form_exact', function () {
            last_search_string = null;
            _search();
        });

        $document.on('click', '.do-apply',function (e) {
            _act('apply', this.dataset.id);
            return false;
        });
        $document.on('click', '.do-unapply',function (e) {
            if(!group_data.ajax_update_mode || confirm(group_data.confirm)){
                _act('unapply', this.dataset.id);
            }
            return false;
        });

        $document.on('click', '.form-group-item-group-more', function () {
            _render_search(this.dataset.offset)
        });

        type_name = $('#type_name').text().trim();
        type_select.chosenedge().change(function () {
            group_data.group.type_id = this.value;
            type_name = type_select.find(':selected').text().trim();
            last_search_string = null;
            _search();
        }).trigger('change');

        $('input.can_view').each(function () {
            var self = $(this),
                output = $('input.if_can_view');
            if (!$(self).is(':checked')) {
                $(output).prop('disabled', true);
                $(output).prop('checked', false);
            }
            $(self).on('change', function () {
                if ($(self).is(':checked')) {
                    $(output).prop('disabled', false);
                } else {
                    $(output).prop('disabled', true);
                    $(output).prop('checked', false);
                }
            });
        });

        $('#checkall').on('change', function () {
            var i = $('input.if_can_view'),
                f = $('input[name="flags[]"]');
            if ($(this).is(':checked')) {
                i.prop('disabled', false);
                f.not(':disabled').prop('checked', true);
            } else {
                f.not(':disabled').prop('checked', false);
                i.prop('disabled', true);
            }
        });

        var checck = true;
        $('input[name="flags[]"]').each(function () {
            if (!$(this).is(':checked')) {
                checck = false;
                return false;
            }
        });
        $('#checkall').prop('checked', checck);

        init_state.done(function () {
            _render();
        });
    });
})(jQuery, window);