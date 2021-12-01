$(function() {
    $('.rack-front').on('click', '.newitem', function() {
        addRItem.apply(this, [$(this).parents('.dragdrop').eq(0).data('position'), $(this).parents('tbody').data('location')]);
    });
    $('.rack-back').on('click', '.newitem', function() {
        addRItem.apply(this, [$(this).parents('.dragdrop').eq(0).data('position'),'Back']);
    });
    $('.rack-fside').on('click', '.newitem', function() {
        addRItem.apply(this, [$(this).parents('.dragdrop').eq(0).data('position'),'Side']);
    });
    $('.rack-mount').each(function() {
        var mount = $(this),
            side = mount.children(),
            units = $('#rowcols tr').length - 1;

        var getItemPos = function(e) {
            var ru = units + 1,
                t = $(e),
                right = side.is('.rack-side-r'),
                indexlist = t.prevAll().map(function() {
                    return parseInt($(this).attr('data-units')) || 1
                }),
                pos = 0;
            for (var i = 0; i < indexlist.length; i++)
                pos += indexlist[i];
            return [ru - pos + (ru * (right ? t.parent().index() : t.parent().nextAll().length)) - 1, right ? 'Rside' : 'Lside'];
        }
        side.on('click', '.newitem', function(e) {
            addRItem.apply(this, getItemPos(this));
        })
        var sortback = false,
            place = false;
        side.sortable({
            start: function(e, ui) {
                ui.placeholder.width(ui.helper.width());
                side.addClass('ui-sortable-active');
            },
            change: function(e, ui) {
                var id = ui.item.attr('data-id'),
                    parent = ui.item.parent();

                side.find('.newitem').show();
                if (!ui.placeholder.parent().is(parent)) {
                    var u = parseInt(ui.item.attr('data-units'));
                    if (isNaN(u) || u < 1)
                        return false;

                    if (!place.length) {
                        var p = [], tu = u;
                        while (tu--)
                            p.push('<div class="newitem"></div>');
                        place = $(p.join('')).insertAfter(ui.item);
                    }

                    var f = ui.placeholder.nextAll().filter(function() {
                        return !$(this).is('.rackitem')
                    });
                    if (f.length < u) {
                        ui.item.parent().children().each(function() {
                            var t = $(this);
                            if (t.position().top > ui.position.top + t.width() / 2) {
                                ui.placeholder.insertAfter(t);
                                if (place)
                                    place.remove();
                                place = false;
                                return false
                            }
                        });
                    } else {
                        f.slice(0, u).hide();
                    }
                } else if (ui.placeholder.parent().is(parent) && place.length) {
                    if (place)
                        place.remove();
                    place = false;
                }
            },
            update: function(e, ui) {
                var data = {
                    do: 'setnewpositions',
                    rack_id: $('#rack_id').val(),
                    vars: {},
                    location: 'None'
                };
                ui.item.parent().parent().find('.rackitem').each(function() {
                    var pos = getItemPos(this);
                    data.vars[pos[0] + 1] = $(this).attr('data-id');
                    data.location = pos[1];
                })
                ajax_update('?cmd=dedimgr', data);
            }, stop: function(e, ui) {
                place = false;
                ui.item.parent().children().filter(function() {
                    return !$(this).is(':visible')
                }).remove();
                ui.item.addClass('aftersort');
                side.removeClass('ui-sortable-active');
                setTimeout(function() {
                    ui.item.removeClass('aftersort');
                }, 100);
            },
            helper: function() {
                return '<span></span>'
            },
            tolerance: "pointer",
            forcePlaceholderSize: true,
            cancel: '.rackitem-menu',
            items: '.col-group > div',
            zIndex: '100'
        });
    });
    $(".sortable").sortable({
        change: function (e, ui) {
            var element_position = $(ui.item[0]).data('position'),
                sortable = $(this),
                statics = $('.static', this),
                units = ui.item.data('units');

            $(this).attr('data-original', element_position);
            var index = [];
            sortable.find("tr").each(function (i) {
                if ($(this).hasClass('static')){
                    index.push(i);
                }
            });
            statics.each(function (i) {
                var self = $(this),
                    position = self.data('position'),
                    pos = self.data('tr');

                if (element_position <= position){
                //     self.insertBefore($('tr', sortable).eq(pos+units));
                    self.insertAfter($('tr', sortable).eq(pos-units));
                }else{
                    self.insertAfter($('tr', sortable).eq(pos+units));
                }
            });
        },
        update: function(event, ui) {
            var total = $("#rowcols tr").length,
                i = 0,
                o = {},
                sortable = $(this),
                location = $(this).data('location');
            $(this).find('.dragdrop').each(function(n) {
                var that = $(this),
                    size = parseInt(that.attr('data-units')),
                    id = that.attr('data-id') || false,
                    pos = total - i - 1;
                that.attr('data-position', pos).data('position', pos);
                if (id)
                    o[total - i] = id;
                i = i + size;
            });
            var pos = ui.item.data('position'),
                pos_u = ui.item.data('units');
            pos_u = pos - pos_u;
            $(this).find("tr").each(function (i) {
                var or = $(this).data('original'),
                    u = $(this).data('units');
                u = or - u;
                if ((pos <= or && pos > u) || (pos_u < or && pos_u >= u)){
                    ui.item.data('break', 1);
                    o = [];
                    return false;
                }
            });
            ajax_update('?cmd=dedimgr', {
                do: 'setnewpositions',
                rack_id: $('#rack_id').val(),
                location: location,
                vars: o
            });
            setTimeout(function() {
                updatePositions(location);
            }, 100);
        },
        // handle: '.rackitem:not(.static)',
        cancel: '.static',
        helper: 'clone',
        items: '.dragdrop:not(.static)',
        start: function(e, ui) {
            ui.placeholder.height(ui.item.height());
            $(this).find("tr").each(function (i) {
                if ($(this).hasClass('static')){
                    $(this).attr('data-tr', i);
                }
            });
        },
        stop: function(e, ui) {
            if(ui.item.data('break') == 1){
                ui.item.data('break', 0);
                return false;
            }
            ui.item.find('.rackitem').addClass('aftersort');
            setTimeout(function() {
                ui.item.find('.rackitem').removeClass('aftersort');
            }, 100);
        }
    });
    $('#dedimgr').on('click', '.rackitem', function(e) {
        var that = $(this),
            itemlist = $('.rackitem');
        if (that.is('.aftersort'))
            return false;
        if (!that.is('.active')) {
            itemlist.removeClass('active');
            $('.rack-mount').removeClass('active');
        }
        that.toggleClass('active').parents('.rack-mount').toggleClass('active');
    }).on('dblclick', '.rackitem', function(e) {
        var that = $(this);
        window.location = "?cmd=dedimgr&do=itemeditor&item_id=" + $(this).data('id');
    });

    $('#dedimgr').on({
        mouseenter: function() {
            var that = $(this),
                itemlist = $('.rackitem');
            if (that.parents('.ui-sortable-active').length)
                return false;
            if (!itemlist.filter('.active').length) {
                that.addClass('hover');
            }
        },
        mouseleave: function() {
            var that = $(this);
            that.removeClass('hover');
        }}, '.rackitem');

    /*
     *
     */

    $('#dedimgr').on('click', '[data-action]', function(e) {

        var self = $(this);
        var handle = self.data('action');
        var id = self.parents('.rackitem, .rack').eq(0).data('id');

        if (handle.length && typeof window[handle] == 'function') {
            window[handle].call(this, id, e);
        }
        return false;
    })
});

function initRack() {
    $('#rackview_switch').children().each(function(x) {
        $(this).click(function() {
            var that = $(this);
            $('#' + that.addClass('activated').siblings().removeClass('activated').each(function() {
                $('#' + $(this).attr('data-rel')).hide();
            }).end().attr('data-rel')).show();
            if (that.is('.activated'))
                $.get(that.attr('href'));
            return false;
        })
    }).filter('.activated').click();

    var unitSize = 20;
    $('.rackitem').bind('updateus', function() {
        var that = $(this),
            clsu = that.attr('class').match(/server(\d+)u/),
            us = clsu ? parseInt(clsu[1]) : 1,
            v = that.parent().is('.rack-row');
        if (v)
            that.height(us * unitSize);
        else
            that.width(us * unitSize);
    }).trigger('updateus');

    var sidelength = $('#rowcols td').length * unitSize;
    $('.rack-mount').each(function() {
        var mount = $(this),
            side = mount.children();

        if (side.is('.rack-side-r')) {
            side.append(side.children().detach().get().reverse())
        }
        side.children().each(function() {
            fitRackItems($('.rackitem', this).eq(0));
        })

        side.width(sidelength);
        mount.height(sidelength).width(side.children().length * (unitSize + 4));
    });

    fitRackItems('.rack-front tr:first');
    fitRackItems('.rack-back tr:first');
    fitRackItems('.rack-fside tr:first');
}

function updatePositions(location){
    location = location.toLowerCase();
    if (location == 'side'){
        location = 'fside';
    }
    var f_items = $('.rack-'+location+' tr.have_items'),
        total = $("#rowcols tr").length - 1,
        sortable = $('.sortable'),
        original = $('.rack-'+location+' tbody').attr('data-original');

    f_items.each(function () {
        var data = {
            id: $(this).data('id'),
            position: $(this).data('position'),
            units: $(this).data('units') - 1,
            original: original,
            total: total
        };
        if (location != 'fside'){
            upositons('fside', data, sortable);
        }
        upositons('back', data, sortable);

        sortable.each(function () {
            var i = 0,
                t = total;
            $(this).find('.dragdrop').each(function(n) {
                var that = $(this),
                    size = parseInt(that.attr('data-units')),
                    pos = t - i;
                that.attr('data-position', pos).data('position', pos);
                i = i + size;
            });
        });
    });
}

function upositons(location, data) {
    var loc = $('.rack-'+location+' tr[data-id="'+data.id+'"]');
    if (data.original > data.position){
        data.position -= data.units;
    }
    var issett= $('.rack-'+location+' tr[data-position="'+data.position+'"]');
    if (data.original < data.position){
        loc.insertBefore(issett);
    }else{
        loc.insertAfter(issett);
    }
    $(loc).attr('data-original', data.position);
}

function fitRackItems(item) {
    var rackitem = $(item);
    while (rackitem.length) {
        var u = parseInt(rackitem.attr('data-units')),
            i = rackitem.index();
        if (!isNaN(u)) {
            rackitem.nextAll(':lt(' + (u - 1) + ')').remove();
        }
        rackitem = rackitem.next();
    }
}

function addRItem(position, location) {
    location = location || 'Front';
    $.facebox({
        ajax: '?cmd=module&module=' + $('#module_id').val() + "&do=itemadder&rack_id=" + $('#rack_id').val() + "&position=" + position + '&location=' + location,
        width: 900,
        nofooter: true,
        opacity: 0.8,
        addclass: 'modernfacebox'
    });
    return false;
}

/*
function copyRackItem(id, e) {
    var org = $('#item_' + id),
        newitem = org.clone(),
        view = $('#rack_view'),
        selfpos = $(this).offset();


    newitem.appendTo(view).css({
        position: 'absolute'
    });

    function destroy() {
        newitem.remove();
        view.off('.cloneitem');
        $(document).off('.cloneitem');
    }

    function closeMenu() {
        newitem.children().removeClass('active').removeClass('hover');
        org.children().removeClass('active').removeClass('hover');
    }

    function setIds(id) {
        if (!id || id.lengtth == 0)
            newitem.find('.lbl').text(newitem.find('.lbl').text() + ' (Copy)');

        newitem.find('[href]').each(function() {
            var link = $(this);
            link.attr('href', link.attr('href').replace(/([?&])(item_id|id)=\d+/, '$1$2=' + id));
        })
    }

    setIds('');
    newitem.offset(selfpos);
    view.on('mousemove.cloneitem', function(e) {
        var pos = {
            top: e.pageY + 10,
            left: e.pageX + 10
        };
        newitem.offset(pos);
    })

    $('.newitem', view).on('click.cloneitem', function(e) {
        e.stopImmediatePropagation();
        var self = $(this),
            position = 0,
            location = 'Front';

        if (self.parent().is('.canadd')) {
            position = self.parent().parent().data('position');
            location = 'Front';

            var td = $(this).parent();
            newitem.data('revert', td);
            td.replaceWith(newitem);
        }

        newitem.css({position: 'static'});
        view.off('.cloneitem');
        $(document).off('.cloneitem');

        $.post('?cmd=module&module=' + $('#module_id').val() + "&do=cloneitem", {
            rack_id: $('#rack_id').val(),
            item_id: id,
            position: position,
            location: location,
        }, function(re) {
            if (!re.id)
                newitem.replaceWith(newitem.data('revert'));
            setIds(re.id)
        });
    })

    $(document).on('click.cloneitem', function(e) {
        if (org.find(e.target).length)
            return false;
        destroy();
    })newitem
    setTimeout(closeMenu, 10);
    return false;
}
*/
function expandRack(direction) {
    var target = $('.rack-side-' + direction);
    if (target.length) {
        var u = $("#rowcols tr").length,
            c = [];
        while (u--)
            c.push('<div class="newitem"></div>');
        target.append('<div class="col-group">' + c.join('') + '</div>').parent().width(target.parent().width() + 24);
    }

    return false;
}

