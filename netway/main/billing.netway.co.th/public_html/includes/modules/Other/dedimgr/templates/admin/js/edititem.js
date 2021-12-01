
function inichosen() {
    var target = $('#facebox').length ? $('#facebox') : $('#page_view');
    $('select[name=parent_id]', target).each(function (n) {
        var that = $(this);
        var selected = that.attr('default');
        $.get('?cmd=dedimgr&do=getjsonlist&rack_id=' + $('input[name=rack_id]', target).val() + '&item_id=' + $('#item_id', target).val(), function (data) {
            if (data.list != undefined) {
                for (var i in data.list) {
                    var name = data.list[i].label;
                    var select = selected == data.list[i].id ? 'selected="selected"' : '';
                    that.append('<option value="' + data.list[i].id + '" ' + select + '>' + name + '</option>');
                }
            }
            that.chosenedge({width: '100%'});
        });
    });
    $('select[name=pool_id]', target).each(function (n) {
        var that = $(this);
        var selected = that.attr('default');
        $.get('?cmd=dedimgr&do=getpoollist', function (data) {
            if (data.list != undefined) {
                for (var i in data.list) {
                    var name = data.list[i].name;
                    var select = selected == data.list[i].id ? 'selected="selected"' : '';
                    that.append('<option value="' + data.list[i].id + '" ' + select + '>' + name + '</option>');
                }
            }
            that.chosenedge({width: '100%'});
        });
    });
    $('select[name=build_id]', target).each(function (n) {
        var that = $(this);
        var selected = that.attr('default');
        $.get('?cmd=module&module=inventory_manager&action=getjsonbuilds', function (data) {
            if (data.list != undefined) {
                for (var i in data.list) {
                    var name = data.list[i].label;
                    var select = selected == data.list[i].id ? 'selected="selected"' : '';
                    if (selected == data.list[i].id)
                        reloadInventory(selected);
                    that.append('<option value="' + data.list[i].id + '" ' + select + '>' + name + '</option>');
                }
            }
            that.chosenedge({width: '100%'});
        });
    });
    $('select[name=client_id]', target).each(function (n) {
        var that = $(this);

        that.chosensearch({width: '100%'});
        reloadServices();

    });
    $('#configurations', target).delegate().delegate('a.rem', 'click', function () {
        $.get($(this).attr('href'), function (data) {
            $('#configurations', '#saveform').html(parse_response(data));
        });
        return false;
    });
}

function reloadServices() {
    var target = $('#facebox #saveform:visible').length ? $('#facebox') : $('#page_view');
    $.post('?cmd=dedimgr&do=getclientservices', {client_id: $("select[name=client_id]", target).val(), service_id: $('#account_id', target).val()}, function (data) {
        $('#related_service', target).html(parse_response(data));
        updateLayout();
    });
}

function editBladeItem(id) {
    var target = $('#facebox #saveform:visible').length ? $('#facebox') : $('#page_view');

    var postdata = {
        do: 'itemeditor',
        backview: target.is('#page_view') ? 'parent' : '',
        item_id: id
    };
    $('.spinner').show();
    $(document).trigger('close.facebox');
    setTimeout(function () {
        var box = function () {
            $.post('index.php?cmd=dedimgr', postdata, function (data) {
                $.facebox.reveal(parse_response(data))
            });
        }
        box.opacity = 0.9;
        box.nofooter = true;
        box.width = 900;
        box.addclass = 'modernfacebox';
        $.facebox(box);
    }, 1000);
    return false;
}

function createBladeEntry() {
    var postdata = {
        do: 'itemeditor',
        parent_id: $('#item_id').val(),
        addblade: true,
        item_id: 'new',
        position: 0,
        location: 'Blade',
        rack_id: $('input[name=rack_id]').val(),
        category_id: $('#blade_cat_id').val(),
        type_id: $('select[name=type_id]').val(),
        backview:  'parent'
    };

    $.post('index.php?cmd=dedimgr', postdata, function (data) {
        if(data.id) {
            window.location = 'index.php?cmd=dedimgr&do=itemeditor&item_id='+data.id
        }
    });


    return false;

}
function loadSubitems(el) {
    var v = $(el).val();
    if (v == '0')
        return false;
    var target = $('#facebox #saveform:visible').length ? $('#facebox') : $('.bootbox-body');

    $('#updater1', target).addLoader();
    $.post('?cmd=dedimgr&do=inventory&subdo=category', {category_id: v}, function (data) {
        $('#updater1', target).html(parse_response(data));
        updateLayout();
    });
    return false;
}

function loadItemEditor(el) {
    $('#bladeadd').hide();
    var v = $(el).val();
    if (v == '0')
        return false;

    $('#bladeadd').show();
    updateLayout();
    return false;
}

function reloadInventory(build_id) {
    var target = $('#facebox #saveform:visible').length ? $('#facebox') : $('#page_view');
    if (!build_id) {
        $('#inventorygrid', target).hide().html('');
        return;
    }
    $('#inventorygrid', target).html('');
    $.get('?cmd=inventory_manager&action=rackitem&build_id=' + build_id, function (data) {
        $('#inventorygrid', target).html(parse_response(data));
        updateLayout();
    });
}

function setports(group, all, count, type, dir) {
    var target = $('#facebox #saveform:visible').length ? $('#facebox') : $('#page_view');
    var s = type+"_"+dir+"_"+group;
    if (all > count) {
        if (!confirm('Are you sure you want to reduce the number of ports? The configured ports will be deleted without restoration.')) {
            return false;
        }
    }
    $.post('?cmd=dedimgr&do=setports', {
        group: group,
        count: count,
        type: type,
        direction: dir,
        item_id: $('#item_id', target).val()
    }, function (data) {
        $('#'+s, target).html(parse_response(data));
    });
}

function refreshports(type,dir) {

    var target = $('#facebox #saveform:visible').length ? $('#facebox') : $('#page_view');
    var s = type+"_"+dir;
    $.post('?cmd=dedimgr&do=setports', {
        item_id: $('#item_id', target).val(),
        type: type,
        direction: dir
    }, function (data) {

        $('#'+s, target).html(parse_response(data));
    });
}

function loadports(field, type, el) {
    if (!confirm('This operation may reset some of your ports settings. Do you want to proceed?'))
        return false;
    var target = $('#facebox #saveform:visible').length ? $('#facebox') : $('#page_view'),
        btn = $(el).children();
    $('#page_view').addLoader();
    $.post('?cmd=dedimgr&do=loadports', {
        item_id: $('#item_id', target).val(),
        app: $('select[name="field[' + field + ']"]', target).val(),
        type: type
    }, function (data) {
        parse_response(data);
        window.location='?cmd=dedimgr&action=itemeditor&subdo=connections&item_id='+$('#item_id', target).val();

    });
}

function loadItemMonitoring(manual) {
    var target = $('#facebox:visible').length ? $('#facebox') : $('#page_view');
    var hash = $('#item_hash', target).val();
    if (manual) {
        $('#itemmonitoring', target).addLoader();
        $.getJSON('?cmd=dedimgr&do=loadmonitoring&hash=' + hash, function (data) {
            if (data && data.status) {
                for (var i in data.status) {
                    if (hash == data.status[i].hash) {
                        $('#itemmonitoring', target).html(buildMonitoring(data.status[i].hash, data.status[i]));
                        updateLayout();
                    }
                }
            }
        });
    } else if ($('#monitoringdata #status_' + hash, target).length) {
        $('#itemmonitoring', target).html($('#monitoringdata #status_' + hash, target).html());
        updateLayout();
    } else if (MonitoringData[hash] !== undefined) {
        $('#itemmonitoring', target).html(buildMonitoring(hash, MonitoringData[hash]));
        updateLayout();
    }
}

function tabbMenu() {
    var target = $('#facebox:visible').length ? $('#facebox') : $('#page_view');
    if ($('#lefthandmenu', target).length) {
        var menu = $('#lefthandmenu', target),
            links = menu.children(),
            tabbs = $('#facebox .tabb');
        links.each(function () {
            var that = $(this);
            $(this).click(function (e) {
                links.removeClass('picked active');
                that.addClass('picked active');
                var href = that.attr('href').match(/[^#]+/)[0];
                tabbs.hide().filter(function () {
                    return $(this).attr('data-tab') == href
                }).show().find('h3').each(function () {
                    var h = $(this);
                    if (!h.find('.name').length)
                        $('<span></span>').attr('class', 'name').text(' - ' + $('#item_name', '#facebox').val()).appendTo(h);
                    return false;
                });
                updateLayout();
                return false;
            });
        }).eq(0).click();
    }
}

function updateLayout() {
    // console.error('updateLayout')
    //
    // if ($('#page_view').length) {
    //     return false;
    //     var height = 0;
    //     $('#page_view .tabb').each(function () {
    //         height += $(this).height();
    //     });
    //     $('#page_view .conv_content').height(height / 2);
    // } else {
    //     var menu = $('#lefthandmenu'),
    //         tab = $('.conv_content'),
    //         h1 = tab.height() - (menu.outerHeight() - menu.height()),
    //         h2 = menu.children().length * 30;
    //     menu.height(h1 < h2 ? h2 : h1);
    // }
}

function changeHardwareApp(select, type) {
    var that = $(select);
    if (that.val() == 'new') {
        window.open('?cmd=dedimgr&do=newhardwareapp&type=' + type).focus();
        that.val(0);
    }

}

function moveItemHndle() {

    var target = $('#facebox:visible').length ? $('#facebox') : $('#page_view'),
        item_id = $('#item_id', target).val(),
        rack_id = $('#move_rack', target).val();

    function insertOptions(list, select) {
        select = $(select, target);

        select.children().not('[value=""]').remove();
        $.each(list, function () {
            select.append('<option value="' + this.id + '">' + this.name + '</option>');
        });
        select.parent().show().nextAll('.form-group').hide();
        updateLayout();
        $('#move_item', target).fadeTo(100, 1);
    }

    function change(data, to) {
        var self = $(this.toString(), target);

        self.change(function () {
            self.parent().nextAll('.form-group').hide();

            if (!self.val().length)
                return setLink();

            target = $('#facebox:visible').length ? $('#facebox') : $('#page_view');
            item_id = $('#item_id', target).val();
            rack_id = $('#move_rack', target).val();
            data.id = self.val();
            if (rack_id)
                data.rack_id = rack_id;//for orientation needed;

            $('#move_item', target).fadeTo(200, 0.4);

            $.post('?cmd=dedimgr&action=treecomponent', data, function (data) {
                insertOptions(eval(data), to);
                setLink();
            })
        });
    }

    function setLink() {
        var link = $('#move_tolocation', target),
            rack = $('#move_rack', target).val(),
            ori = $('#move_orientation', target).val(),
            pos = $('#move_position', target).val();

        if (!rack || !pos) {
            link.addClass('disabled');
            return false;
        }
        link.removeClass('disabled');
        link.attr('href', '?cmd=dedimgr&action=moveitem&rack_id=' + rack
            + '&position=' + pos
            + '&orientation=' + ori
            + '&item_id=' + item_id
            + '&security_token=' + link.data('token'));
        return true;
    }

    $('#move_item', target).fadeTo(200, 0.4);
    $.get('?cmd=dedimgr&action=treecomponent', function (data) {
        insertOptions(eval(data), '#move_colocation')
    });

    change.call('#move_colocation', {lv: 0}, '#move_floor');
    change.call('#move_floor', {lv: 1}, '#move_rack');
    change.call('#move_rack', {lv: 2, empty: 1, item_id: item_id}, '#move_orientation');
    change.call('#move_orientation', {lv: 3, empty: 1, rack_id: $('#move_rack').val()}, '#move_position');
    $('#move_position', target).change(setLink);
}

function graphManagement() {
    var target = $('#facebox:visible').length ? $('#facebox') : $('#page_view'),
        item_id = $('#item_id', target).val(),
        mgrview = $('#graph-mgr', target),
        btn = $('#graph-assign', mgrview),
        updaterview = $('#graph-updater', target)
        ;

    function insertOptions(list, select, sub) {
        select = $(select, target);
        var group = select.parent(),
            nextgroup = group.nextAll('.form-group'),
            i = 1;


        if (sub == null || sub == 1) {
            select.children().not('[value=""]').remove();
        }

        $.each(list, function () {
            select.append('<option '
                + (this.subitems ? 'data-sub="' + i + '"' : '')
                + (sub ? 'data-issub="' + sub + '"' : '')
                + ' value="' + this.id + '">' + this.name + '</option>');
            if (this.subitems) {
                insertOptions(this.subitems, nextgroup.find('select')[0], i++)
            }
        })

        if (sub == null) {
            group.show()
            nextgroup.hide();
            updateLayout();
            mgrview.fadeTo(100, 1);
        }
        select.trigger('chosen:updated')
    }

    function toggleButton() {
        var app = $('#graph-app', target),
            device = $('#graph-device', target).val(),
            port = $('#graph-port', target).val();

        if (!app || !device || !port) {
            btn.addClass('disabled');
            return false;
        }
        btn.removeClass('disabled');
    }

    //in case of listSwitches ports
    function handleSubitems(to, sub) {
        var nextform = $(to),
            alloptios = nextform.children('option');

        alloptios.hide().prop('disable', true);
        alloptios.filter('[data-issub="' + sub + '"]')
            .show().prop('disable', false)

        nextform.trigger('chosen:update');
        nextform.parent().show();
        toggleButton();
        return true;
    }

    //load options from app
    //it may return siple options 
    // - in that case we will request graphs for device later
    //or option with subitems like ports -> handleSubitems
    function change(to) {
        var self = $(this.toString(), target);
        self.change(function () {
            $(to).parent().hide();
            if (!self.val().length) {
                toggleButton();
                return false;
            }

            var sub = self.children(':selected').data('sub');
            if (sub) {
                return handleSubitems.call(self, to, sub);
            }

            var data = {
                server_id: $('#graph-app').val(),
                device_id: $('#graph-device').val()
            }
            self.parent().nextAll('.form-group').hide();

            mgrview.fadeTo(200, 0.4);
            $.post('?cmd=dedimgr&action=graphs_src', data, function (data) {
                insertOptions(data, to);
                toggleButton();
            })
        });
    }
    change.call('#graph-app', '#graph-device');
    change.call('#graph-device', '#graph-port');
    $('#graph-port').on('change', toggleButton);

    updaterview.on('click', '.btn-unassign', function () {
        var post = updaterview.find('input').serializeForm();
        post.unassign = 1;
        post.item_id = item_id;
        updaterview.fadeTo(200, 0.4);
        $.post('?cmd=dedimgr&action=graphs_man', post, function (data) {
            data = parse_response(data)
            updaterview.html(data);
            updaterview.fadeTo(200, 1);
        });
    });

    btn.on('click', function () {
        if (btn.is('.disabled'))
            return false;

        var server_id = $('#graph-app', target).val(),
            device = $('#graph-device', target),
            graph = $('#graph-port', target),
            post = [];
        updaterview.fadeTo(200, 0.4);

        graph.children(':selected').each(function () {
            var opt = $(this);
            
            if(opt.val() == '')
                return;
            
            post.push({
                server_id: server_id,
                device_id: device.val(),
                port_id: opt.val(),
                name: 'Device: ' + device.children(':selected').text()
                    + ', graph: ' + opt.text()
            })
        })
        graph.val('').trigger('chosen:updated');
        
        $.post('?cmd=dedimgr&action=graphs_man', {
            assign: 1,
            item_id: item_id,
            graphs: post
        }, function (data) {
            data = parse_response(data)
            updaterview.html(data);
            updaterview.fadeTo(200, 1);
        })
        return false;
    });
    
    $('#graph-app, #graph-device, #graph-port', target).chosenedge({width: '100%'});
}

$(document).ready(function () {

    function setports(group, all, count, type, dir) {
        var target = $('#facebox #saveform:visible').length ? $('#facebox') : $('#page_view');
        var s = type+"_"+dir+"_"+group;
        if (all > count) {
            if (!confirm('Are you sure you want to reduce the number of ports? The configured ports will be deleted without restoration.')) {
                return false;
            }
        }
        $.post('?cmd=dedimgr&do=setports', {
            group: group,
            count: count,
            type: type,
            direction: dir,
            item_id: $('#item_id', target).val()
        }, function (data) {
            $('#'+s, target).html(parse_response(data));
        });
    }

    $('.portDeleteGroup').live('click',function (e) {
        e.preventDefault();
        if (!confirm('Are you sure you want to remove the group? The ports will be deleted without restoration.')) {
            return false;
        }
        var group = $(this).attr('data-group_id');
        $.post('?cmd=dedimgr&do=removeitemgroup', {
            group: group,
        }, function (data) {
            var r = parse_response(data);
            if(r) {
                window.location.reload(false);
            }
        });
    });

    $('.portAddNewGroup').live('click',function (e) {
        e.preventDefault();
        var type = $(this).attr('data-type');
        var direction = $(this).attr('data-direction');
        var item_id = $(this).attr('data-item_id');
        bootbox.dialog({
            title: 'Add New Group',
            message:    '<form action="?cmd=dedimgr&action=additemgroup" method="POST">\n' +
                        '    <input type="hidden" name="item_id" value="'+item_id+'">\n' +
                        '    <input type="hidden" name="type" value="'+type+'">\n' +
                        '    <input type="hidden" name="direction" value="'+direction+'">\n' +
                        '    <label for="">Group name</label>\n' +
                        '    <input type="text" name="name" value="" class="form-control">\n' +
                        '</form>',
            buttons: {
                cancel: {
                    label: 'Cancel',
                    className: 'btn-default'
                },
                ok: {
                    label: 'Submit',
                    className: 'btn-success',
                    callback: function(){
                        var form = $(this).find('.bootbox-body form');
                        $(form).submit();
                    }
                }
            }
        })
    });

    $(document).on('click', '.portEditGroupLabel',function (e) {
        e.preventDefault();
        var label = $(this).attr('data-label');
        var item_id = $(this).attr('data-item_id');
        if ($(this).attr('data-group_id')) {
            var group_id = $(this).attr('data-group_id');
            var message = '<form action="?cmd=dedimgr&action=editcustomgrouplabel" method="POST">\n' +
                '    <input type="hidden" name="group_id" value="'+group_id+'">\n' +
                '    <input type="hidden" name="item_id" value="'+item_id+'">\n' +
                '    <label for="">Group name</label>\n' +
                '    <input type="text" name="label" value="'+label+'" class="form-control">\n' +
                '</form>';
        } else {
            var type = $(this).attr('data-type');
            var direction = $(this).attr('data-direction');
            var message = '<form action="?cmd=dedimgr&action=editgrouplabel" method="POST">\n' +
                '    <input type="hidden" name="item_id" value="'+item_id+'">\n' +
                '    <input type="hidden" name="type" value="'+type+'">\n' +
                '    <input type="hidden" name="direction" value="'+direction+'">\n' +
                '    <label for="">Group name</label>\n' +
                '    <input type="text" name="label" value="'+label+'" class="form-control">\n' +
                '</form>';
        }

        bootbox.dialog({
            title: 'Edit Group label',
            message: message,
            buttons: {
                cancel: {
                    label: 'Cancel',
                    className: 'btn-default'
                },
                ok: {
                    label: 'Save',
                    className: 'btn-success',
                    callback: function(){
                        var form = $(this).find('.bootbox-body form');
                        $(form).submit();
                    }
                }
            }
        })
    });
});

$(function () {
    inichosen();
    loadItemMonitoring();
    tabbMenu();
    updateLayout();
    moveItemHndle();
    graphManagement();

    // $('#facebox_overlay').hide();
    // $('#facebox').draggable();
    $('body').bootboxform();;

    $('.vtip_description', '#facebox').vTip();
    $('.connector.hastitle', '#facebox').vTip();
})

