var IPActions = {
    add_list: 'addlist',
    del_list: 'dellist',
    edit_list: 'listdetails',
    get_list: 'details',
    save: 'singlesave',
    del: 'dellip',
    search: 'search',
    target: '#ipamright',
    updater: '#updater',
    form: '#ipform',
    leftform: '#ipamleftform',
    treecontener: '#treecont',
    sorter: {
        list: '#currentlist',
        low: '#sorterlow',
        high: '#sorterhigh',
        records: '#sorterrecords',
        total: '#totalpages'
    },
    editform: [
        {
            type: 'input',
            name: 'ipaddress',
            title: 'IP Address',
        },
        {
            type: 'input',
            name: 'domains',
            title: 'Hostname',
        },
        {
            type: 'input',
            name: 'wanip',
            title: 'WAN IP',
        },
        {
            type: 'textarea',
            name: 'revdns',
            title: 'Reverse DNS',
        },
        {
            type: 'textarea',
            name: 'descripton',
            title: 'Description',
        }
    ]
}

var VLANActions = {
    add_list: 'vlan_addlist',
    del_list: 'vlan_dellist',
    edit_list: 'vlan_listdetails',
    get_list: 'vlan_details',
    save: 'vlan_singlesave',
    del: 'vlan_del',
    search: 'vlan_search',
    target: '#vlanright',
    updater: '#vlanupdater',
    form: '#vlanform',
    leftform: '#vlanleftform',
    treecontener: '#vlantreecont',
    sorter: {
        list: '#vlancurrentlist',
        low: '#vlansorterlow',
        high: '#vlansorterhigh',
        records: '#vlansorterrecords',
        total: '#vlantotalpages'
    },
    editform: [
        {
            type: 'input',
            name: 'vlan',
            title: 'VLAN ID',
        },
        {
            type: 'input',
            name: 'name',
            title: 'Name',
        },
        {
            type: 'textarea',
            name: 'descripton',
            title: 'Description',
        }
    ]
}

var LOGSActions = {
    target: '#logsright',
    updater: '#logsupdater',
    form: '#logsform',
    sorter: {
        list: '#logscurrentlist',
        low: '#logssorterlow',
        high: '#logssorterhigh',
        records: '#logssorterrecords',
        total: '#logstotalpages'
    },
}

ActSet = IPActions;

$(function () {
    var timeout = false;
    $('.ipam-search input[name="stemp"]').keypress(function (k) {
        var that = $(this);
        if (k.which == 13)
            k.preventDefault();
        slideUp();
        if (timeout)
            clearTimeout(timeout);
        timeout = setTimeout(function () {
            ajax_update("?cmd=module&module=ipam&" + $(ActSet.leftform).find('input, textarea, select').not('input[name=action]').serialize(), {
                action: ActSet.search,
                str: that.val(),
                opt: that.parent().next().find('input').serialize()
            }, ActSet.treecontener);
            timeout = false;
        }, 400);

    });

    $('.ipam-search input[name="stemp"]').click(function () {
        var that = $(this);
        that.parent().next().slideDown().find('input').click(function () {
            that.focus();
        });
        $(document).bind('mouseover', slideUp);
    });

   // $('.pagecont').hide().eq(0).show();
    console.log('bind1')
     $('#newshelfnav a').each(ipamMenuNav);

    refreshipamlogs();
});
var ajax_loader = "<img src='../includes/modules/Other/ipam/admin/img/ajax-loader3.gif' alt='loading..' />";

function ipamMenuNav(x) {
    var that = $(this);
    that.click(function () {
        if (x == 4)
            ActSet = LOGSActions;
        else if (x == 1)
            ActSet = VLANActions;
        else
            ActSet = IPActions;

    });
}

function refreshipamlogs() {
    $('#logsright').addLoader();
    ajax_update("?cmd=module&module=ipam&action=logs", false, function (data) {
        $('#logsright').replaceWith(parse_response(data));
        multipaginate();
    });
}

function slideUp(event) {
    if (event == undefined ||
        $('.ipam-filters:visible').length && (
        !$(event.target).is('.ipam-search') &&
        !$(event.target).parents('.ipam-search').length &&
        !$(event.target).is('.ipam-filters') &&
        !$(event.target).parents('.ipam-filters').length)
        )
    {
        $('.ipam-filters').slideUp('fast');
        $('.ipam-filters input').unbind();
        $(document).unbind('mouseover', slideUp);
    }
}

function editAssign(id) {
    var sid = $('input[name=sub]').length ? $('input[name=sub]').val() : $('input[name=group]').val();
    $.facebox({
        ajax: "?cmd=module&module=ipam&action=editassignment&ip_id=" + id + '&server_id=' + sid,
        width: 900,
        nofooter: true,
        opacity: 0.5
    });
    return false;
}
function splitIP(id) {
    if (!confirm('Are you sure?')) {
        return false;
    }
    $.post('?cmd=module&module=ipam', {
        action: 'splitlist',
        id: id
    }, function (data) {
        var r = parse_response(data);
        refreshView();
        refreshTree($('input[name=group]').val());
    });
    return false;
}

function joinIP(id) {
    if (!confirm('Are you sure?')) {
        return false;
    }
    $.post('?cmd=module&module=ipam', {
        action: 'joinlist',
        id: id
    }, function (data) {
        var r = parse_response(data);
        groupDetails($('input[name=group]').val());
        refreshTree();
    });
    return false;
}

function addIPRange() {
    var g = $('input[name=sub]').length ? $('input[name=sub]').val() : $('input[name=group]').val();
    $.facebox({
        ajax: "?cmd=module&module=ipam&action=addiprange&group=" + g,
        width: 900,
        nofooter: true,
        opacity: 0.5
    });
    return false;
}
function editList(id) {
    $.facebox({
        ajax: "?cmd=module&module=ipam&action=listdetails&id=" + id,
        width: 900,
        nofooter: true,
        opacity: 0.5
    });
    return false;
}

function changename(id) {
    if (!$('#' + id + ' input').length) {
        $('#' + id).html('<input name="group_name" value="' + $('#' + id).text() + '" />')
        $('#' + id).next('a.editbtn').text('Save');
    } else {
        if (id == 'list')
            var gid = $('#ipform input[name="group"]').val();
        else
            var gid = $('#ipform input[name="sub"]').val();

        ajax_update("?cmd=module&module=ipam", {
            action: 'changename',
            name: $('#' + id + ' input').val(),
            group: gid
        }, function (data) {
            $('#' + id).text($('#' + id + ' input').val());
            $('#' + id).next('a.editbtn').text('Edit');
            refreshTree();
        });
    }
}

function toggleFlag(e, id) {
    ajax_update("?cmd=module&module=ipam", {
        action: 'singlesave',
        name: 'flag',
        id: $(e).parent().prevAll().andSelf().eq(0).find('div:first-child').text(),
        group: id,
        value: $(e).hasClass('active') ? 0 : 1
    }
    );
    $(e).toggleClass('active');
}

function delsublist() {
    if (!confirm('Are you sure you want to delete this Subist?'))
        return false;
    ajax_update("?cmd=module&module=ipam", {
        action: 'dellist',
        group: $('#ipform input[name="sub"]').val()
    }, "#ipamright");
    refreshTree();
}

function expand(a) {
    if ($(a).parent('.open').length)
        $(a).siblings('ul').slideUp('fast', function () {
            $(a).parent().removeClass('open').children('input').val('0');
        });
    else
        $(a).siblings('ul').slideDown('fast', function () {
            $(a).parent().addClass('open').children('input').val('1');
        });
}

function subDetails(subid, id) {
    ajax_update("?cmd=module&module=ipam", {
        action: 'details',
        group: id,
        sub: subid
    }, function (data) {
        $('#ipamright').html(data);
        bindEvents();
        multipaginate();
    });
}

function submitIPRange(form) {
    var form_data = form.serializeObject();
    ajax_update("?cmd=module&module=ipam", form_data, function (data) {
        refreshTree();
        refreshView();
console.log(form_data);
        if (form_data.group) {
            switch (form_data.action) {
                case 'editlist':
                    editlist(form_data.group);
                    break;
                case 'vlan_listdetails':
                    editlist(form_data.group);
                    break;
                default:
                    $(document).trigger('close.facebox');
            }
        }
    });
}

function addReservationRule(that) {
    that = $(that);
    var index = that.prevAll('p').length;
    $(['<p>',
        'IP number: <input name="reservations[', index, '][ip]" type="text" class="inp" value="n" /> Reserved for <input name="reservations[', index, '][descr]" type="text" value="" />',
        '<a href="#delRule" class="editbtn fs11" onclick="delReservationRule(this); return false" >remove</a>',
        '</p>'].join(' ')).insertBefore(that);
}

function delReservationRule(that) {
    $(that).parent('p').remove();
}

function multipaginate() {
    $('div.pagination').each(function () {
        var that = $(this),
            total = that.parents('.pagecont').eq(0).find('input[name=totalpages2]').val(),
            current = that.data('lastpage') || 0;

        that.pagination(total, {
            current_page: current,
            callback: function (index) {

                if (!that.parents(ActSet.target).length)
                    return false;

                that.data('lastpage', index);
                $(ActSet.updater).addLoader();
                $('#checkall').attr('checked', false);

                $.post($(ActSet.sorter.list).attr('href'), {page: index}, function (data) {
                    var resp = parse_response(data);
                    if (resp) {
                        $(ActSet.updater).html(resp);
                        $('.check', ActSet.target).unbind('click');
                        $('.currentpage', ActSet.target).val(index);
                        $('.check', ActSet.target).click(checkEl)
                    }
                });
                return false
            }
        });
    });

    $("a.sortorder", ActSet.target).unbind('click').click(function () {
        var that = $(this),
            href = that.attr('href');
        $(ActSet.updater).addLoader();
        $('a.sortorder', ActSet.target).removeClass('asc');
        $('a.sortorder', ActSet.target).removeClass('desc');
        $('#checkall', ActSet.target).attr('checked', false);
        $(ActSet.sorter.list).attr('href', href);

        if (href.substring(href.lastIndexOf('|')) == '|ASC') {
            that.addClass('asc');
            that.attr('href', href.substring(0, href.lastIndexOf('|')) + '|DESC');
        } else {
            that.addClass('desc');
            that.attr('href', href.substring(0, href.lastIndexOf('|')) + '|ASC');
        }

        $.post($(ActSet.sorter.list).attr('href'), {page: (parseInt($('.pagination span.current', ActSet.target).eq(0).html()) - 1)}, function (data) {
            var resp = parse_response(data);
            if (resp) {
                $(ActSet.updater).html(resp);
                $('.check', ActSet.target).unbind('click').click(checkEl);
            }
        });

        return false;
    });
}

function sorterUpdate(low, high, total) {
    if (typeof (low) != 'undefined') {
        $(ActSet.sorter.low).html(low);
    }
    if (typeof (high) != 'undefined') {
        $(ActSet.sorter.high).html(high);
    }
    if (typeof (total) != 'undefined') {
        $(ActSet.sorter.records).html(total);
    }
}

function submitForm(form) {
    ajax_update("?cmd=module&module=ipam&action=" + ActSet.get_list, $(form).serializeObject(), ActSet.target);
    refreshTree();
    return false;
}
function refreshTree(expand) {
    ajax_update("?cmd=module&module=ipam&refresh=1", $(ActSet.leftform).serializeObject(), function (data) {
        $(ActSet.treecontener).html(data);
        if (typeof (expand) != 'undefined') {
            $('#expandable_' + expand).click();
        }
    });
}

function refreshView() {
    var id = $('input[name=group]', ActSet.target).val();
    if ($('input[name=sub]', ActSet.target).length) {
        subDetails($('input[name=sub]', ActSet.target).val(), id)
    } else {
        groupDetails(id)
    }
}

function details(a, id) {
    ajax_update("?cmd=module&module=ipam", {
        action: ActSet.get_list,
        ip: $(a).text(),
        group: id
    }, function (data) {
        $(ActSet.target).html(data);
        bindEvents();
        multipaginate();
    });
}

function groupDetails(id) {
    ajax_update("?cmd=module&module=ipam", {
        action: ActSet.get_list,
        group: id
    }, function (data) {
        $(ActSet.target).html(data);
        bindEvents();
        multipaginate();
    });
}

var newid = 0;
function add() {
    var htadd = []
    var anchor = '<a name="a' + newid + '"></a>'
    $.each(ActSet.editform, function (i, form) {
        var name = 'new[' + newid + '][' + form.name + ']';
        switch (form.type) {
            case 'textarea':
                htadd.push('<td>' + anchor + '<textarea name="' + name + '"></textarea></td>');
                break;
            case 'input':
                htadd.push('<td>' + anchor + '<input type="text" name="' + name + '" /></td>');
                break;
            default:
                htadd.push('<td>' + anchor + '</td>');
        }
        anchor = '';
    })

    var len = 0,
        inlen = htadd.length;
    $(ActSet.updater).parent('table').find('tr:first td').each(function () {
        len += parseInt($(this).attr('colspan')) || 1;
    });

    //for(var i = inlen; i<len; i++)
    htadd.push('<td colspan="' + (len - inlen) + '"></td>');
    $(ActSet.updater).append('<tr>' + htadd.join('') + '</tr>');
    $('body').slideToElement('a' + newid);
    newid = newid + 1;
    return false;
}

function edit(e, id) {
    var self = $(e),
        ip = self.parent().prevAll().andSelf().eq(0).find('div:first-child').text(),
        pos = self.parent().prevAll().length,
        text = self.prev('div:first-child').text(),
        form = ActSet.editform[pos];

    if (!form)
        return false;

    self.prev().hide();
    var edit;

    switch (form.type) {
        case 'input':
            edit = $('<input name="edit[' + ip + '][' + form.name + ']" value="' + text + '" />');
            edit.insertBefore(e).keypress(function (e) {
                return e.which != 13
            });
            break;
        case 'textarea':
            var edit = $('<textarea name="edit[' + ip + '][' + form.name + ']" >' + text + '</textarea>');
            edit.insertBefore(self).elastic();
            break;
    }
    self.replaceWith('<span onclick="save(this,\'' + id + '\',\'' + ip + '\',\'' + form.name + '\')" \
        class="editbtn">Save</span>');
}

function save(e, gid, id, field) {
    ajax_update("?cmd=module&module=ipam", {
        action: ActSet.save,
        name: field,
        id: id,
        group: gid,
        value: $(e).prev('input, textarea, select').val()
    },
        function (data) {
            $(e).prev().remove();
            $(e).prev().html(data.substr(data.indexOf('-->') + 3)).show();
            $(e).replaceWith('<span onclick="edit(this, \'' + gid + '\')" class="editbtn">Edit</span>');
        });
}

function del(e, id) {
    if (!confirm('Are you sure you want to delete this IP address?'))
        return false;
    ajax_update("?cmd=module&module=ipam", {
        action: ActSet.del,
        group: id,
        ip: $(e).parent().prevAll().andSelf().eq(0).find('div:first-child').text()
    },
        function (data) {
            $(e).parent().parent().remove();
            refreshTree();
        });
    return false;
}

function addlist(type, sub) {
    var req = "&list=" + type;
    if (sub > 0)
        req = req + "&sub=" + sub;
    $.facebox({
        ajax: "?cmd=module&module=ipam&action=" + ActSet.add_list + req,
        width: 900,
        nofooter: true,
        opacity: 0.5
    });
    return false;
}

function editlist(id) {
    $.facebox({
        ajax: "?cmd=module&module=ipam&action=" + ActSet.edit_list + "&id=" + id,
        width: 900,
        nofooter: true,
        opacity: 0.5
    });
    return false;
}

function dellist() {
    if (!confirm('Are you sure you want to delete this List?'))
        return false;
    $.post("?cmd=module&module=ipam", {
        action: ActSet.del_list,
        group: $(ActSet.form + ' input[name="group"]').val()
    }, function (data) {
        data = parse_response(data);
        $(ActSet.target).html($(data).filter(ActSet.target).html());
    });
    refreshTree();
}

function advEdit(sid, id) {
    $.facebox({
        ajax: "?cmd=module&module=ipam&action=editip&server=" + sid + "&id=" + id,
        width: 900,
        nofooter: true,
        opacity: 0.5
    });
    return false;
}
