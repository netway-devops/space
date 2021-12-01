$(document).ready(function() {

    var treestate = Cookies.get('colo-tree-state') ?  Cookies.get('colo-tree-state') : true;
    if(treestate=='true')
        treeToggle(treestate);

    $('#smarts2').SmartSearch({
        target: '#smartres2',
        url: '?cmd=dedimgr&action=searchdedimgr&lightweight=1',
        submitel: '#search_submiter2',
        results: '#smartres-results2',
        container: '#search_form_container2'
    });

    $('#newtype').change(function() {
        $('#addnewitem div').hide();
        $('#type_' + $(this).val()).show();
        if ($(this).val() == "server2") {
            $('#used_slots option:last').hide();
        } else {
            $('#used_slots option:last').show();
        }

    });

    $('.wall').children().hide().end().width($('.wall').width()).children().show();
    $('#floorview_switch').children().each(function(x) {
        $(this).click(function() {
            var that = $(this);
            that.addClass('activated')
            if (x == 0) {
                that.next().removeClass('activated');
                $('.wall').removeClass('list');
            } else {
                that.prev().removeClass('activated');
                $('.wall').addClass('list');
            }
            if (that.is('.activated'))
                $.get(that.attr('href'));
            return false;
        })
    }).filter('.activated').click();


});
function showDebugLog(msg,el) {
    bootbox.dialog({
        title: msg,
        onEscape: true,
        size: 'large',
        message: $(el).clone().show(),
    });
    return false;
}
function editRackItem(id) {
    $.facebox({
        ajax: '?cmd=module&module=' + $('#module_id').val() + '&do=itemeditor&item_id=' + id,
        width: 900,
        nofooter: true,
        opacity: 0.8,
        addclass: 'modernfacebox'
    });
    return false;
}

function treeToggle(val) {
    console.log(val);

    $('#treecontainer').toggle(val);
    var s = $('#treecontainer').is(':visible');
    Cookies.set('colo-tree-state', typeof val !== 'undefined' ? val : s);
    return false;
}
var monitoringtimeout;
function loadMonitoring(data) {

    var display = function(json) {
        $('#monitoringdata').html('');
        $('#monitoringbtn i').removeClass('fa-spin');
        $('#statuscol').addClass('extended');
        for (var i in json) {
            var ri = $('.rack-front .have_items[label=' + json[i].hash + ']').eq(0);
            if (ri.length) {
                console.log(ri);
                var p = ri.data('position'),
                    d = $('#statuscol td[pos=' + p + ']')
                        .attr('class', 'monitoring_' + json[i].status)
                        .text(json[i].status)
                        .data('label',$('.lbl',ri).text())
                        .data('json',json[i]);


                d.off('click').on('click',function(){
                    var dialog = bootbox.dialog({
                        title: $(this).data('label'),
                        message: buildMonitoring(null, $(this).data('json')),
                        size: 'large',
                        backdrop: true,
                        onEscape: true,
                        closeButton: true
                    })
                });
            }
        }
    };

    if (data)
        return display(data);

    clearTimeout(monitoringtimeout);
    $('#monitoringbtn i').addClass('fa-spin');
    var url = '?cmd=module&module=' + $('#module_id').val() + "&do=loadmonitoring";
    $.getJSON(url, function(data) {
        if (data && data.status) {
            display(data.status);
        }
        monitoringtimeout = setTimeout(loadMonitoring, 30000);
    });
}
function buildMonitoring(item, data) {
    var h = Mustache.to_html(MUSTACHE.status.join("\n"), data);
    return h;
}

function unlockAdder() {
    $('.canadd').removeClass('disabled');
    $('#addnewitem').html('').hide();
    $('.newitem').hide();
    return false;
}

function addColocation() {
    $.facebox({
        ajax: '?cmd=module&module=' + $('#module_id').val() + "&do=coloform",
        width: 900,
        nofooter: true,
        opacity: 0.8,
        addclass: 'modernfacebox'
    });
    return false;
}

function addVendor() {
    $.facebox({
        ajax: '?cmd=module&module=' + $('#module_id').val() + "&do=vendorform",
        width: 900,
        nofooter: true,
        opacity: 0.8,
        addclass: 'modernfacebox'
    });
    return false;
}

function editVendor(id) {
    $.facebox({
        ajax: '?cmd=module&module=' + $('#module_id').val() + "&do=vendoreditform&vendor_id=" + id,
        width: 900,
        nofooter: true,
        opacity: 0.8,
        addclass: 'modernfacebox'
    });
    return false;
}

function editColocation(id) {
    $.facebox({
        ajax: '?cmd=module&module=' + $('#module_id').val() + "&do=coloeditform&colo_id=" + id,
        width: 900,
        nofooter: true,
        opacity: 0.8,
        addclass: 'modernfacebox'
    });
    return false;
}

function editCategory(id) {
    $.facebox({
        ajax: '?cmd=module&module=' + $('#module_id').val() + "&do=categoryeditform&id=" + id,
        width: 900,
        nofooter: true,
        opacity: 0.8,
        addclass: 'modernfacebox'
    });
    return false;
}

function addFloor(colo_id) {
    $.facebox({
        ajax: '?cmd=module&module=' + $('#module_id').val() + "&do=floorform&colo_id=" + colo_id,
        width: 900,
        nofooter: true,
        opacity: 0.8,
        addclass: 'modernfacebox'
    });
    return false;
}

function editFloor(id) {
    $.facebox({
        ajax: '?cmd=module&module=' + $('#module_id').val() + "&do=flooreditform&floor_id=" + id,
        width: 900,
        nofooter: true,
        opacity: 0.8,
        addclass: 'modernfacebox'
    });
    return false;
}

function addRack(floor_id) {
    $.facebox({
        ajax: '?cmd=module&module=' + $('#module_id').val() + "&do=rackform&floor_id=" + floor_id,
        width: 900,
        nofooter: true,
        opacity: 0.8,
        addclass: 'modernfacebox'
    });
    return false;
}

function editRack(rack_id) {
    $.facebox({
        ajax: '?cmd=module&module=' + $('#module_id').val() + "&do=rackeditform&rack_id=" + rack_id,
        width: 900,
        nofooter: true,
        opacity: 0.8,
        addclass: 'modernfacebox'
    });
    return false;
}

function removeCPU(id) {
    $.post('?cmd=module&module=' + $('#module_id').val() + '&do=removecpu', {
        itemid: id
    }, function(data) {
        var r = parse_response(data);
    });
    return false;
}

function removeMem(id) {
    $.post('?cmd=module&module=' + $('#module_id').val() + '&do=removehdd', {
        itemid: id
    }, function(data) {
        var r = parse_response(data);
    });
    return false;
}

function closeRack(el) {
    $(el).parent().parent().slideUp().parent().removeClass('opened');
}


function getportdetails(id) {
    var url = '?cmd=dedimgr&do=getport&id=' + id;
    if ($('#facebox #saveform:visible').length) {
        $('.spinner:last').show();
        if (typeof closePortEditor == 'function')
            closePortEditor();
        $.get(url, function(data) {
            $('.spinner:last').hide();
            $('#porteditor').html(data).show();
        });
    } else {
        if (typeof closePortEditor == 'function')
            closePortEditor();
        $.facebox({
            ajax: url,
            width: 900,
            nofooter: true,
            opacity: 0.8,
            addclass: 'modernfacebox'
        });
    }
}
var MonitoringData = {},
    MUSTACHE = {
        status: [
            '<table border="0" cellspacing="0" cellpadding="3" width="100%" class="statustable">',
            '  <tr>',
            '    <th>Service</th>',
            '    <th>Status</th>',
            '    <th>Last Check</th>',
            '    <th>Duration</th>',
            '    <th>Attempt</th>',
            '    <th>Info</th>',
            '  </tr>',
            '  {{#services}}',
            '  <tr class="rowstatus-{{status}}">',
            '    <td>{{service}}</td>',
            '    <td>{{status}}</td>',
            '    <td>{{lastcheck}}</td>',
            '    <td>{{duration}}</td>',
            '    <td>{{attempt}}</td>',
            '    <td>{{info}}</td>',
            '    </tr>',
            '  {{/services}}',
            '</table>'
        ]}