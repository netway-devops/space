$(document).ready(function(){
    $('.contains').tooltip({
        track: true,
        delay: 0,
        showURL: false,
        showBody: " - ",
        fade: 20
    });


    $('#smarts2').SmartSearch({
				target: '#smartres2',
				url: '?cmd=module&module=dedimgr&action=searchdedimgr&lightweight=1',
				submitel: '#search_submiter2',
				results: '#smartres-results2',
				container: '#search_form_container2'
            });

  

    $('#newtype').change(function(){
        $('#addnewitem div').hide();
        $('#type_'+$(this).val()).show();
        if($(this).val()=="server2") {
            $('#used_slots option:last').hide();
        } else {
            $('#used_slots option:last').show();
        }

    });
    $('.im_del').click(function(){
        $('.rackitem').removeClass('activated');
        var answer = confirm('Are you sure you want to remove this item?');
        if (answer) {
            var id = $(this).parents('td').eq(0).attr('id').split('_')[1];
            var rack_id = $('#rack_id').val();
            window.location='?cmd=module&module='+$('#module_id').val()+'&do=rack&make=delitem&id='+id+'&rack_id='+rack_id;
        }
        return false;
    });
    $('.im_edit').click(function(){
        $('.rackitem').removeClass('activated');
        var id = $(this).parents('td').eq(0).attr('id').split('_')[1];
        var that=$(this).parents('td').eq(0).find('.rackitem');

         that.addClass('activated');

            editRackItem(id);

      
        return false;
    });
  
    

    $('.contains').hover(function(){
        $(this).find('.im_del div').show();
        $(this).find('.im_edit div').show();
        $(this).find('.im_sorthandle div').show();
    },function(){
        $(this).find('.im_del div').hide();
        $(this).find('.im_edit div').hide();
        $(this).find('.im_sorthandle div').hide();
    });
    $('.canadd').hover(function(){
        if(!$(this).hasClass('disabled'))
            $(this).find('.newitem').show();
    },function(){
        if(!$(this).hasClass('disabled'))
            $(this).find('.newitem').hide();
    });
});

function editRackItem(id) {
    $.facebox({
            ajax: '?cmd=module&module='+$('#module_id').val()+'&do=itemeditor&item_id='+id,
            width:900,
            nofooter:true,
            opacity:0.8,
            addclass:'modernfacebox'
        });
        return false;
}
var monitoringtimeout;
function loadMonitoring() {
    window.clearTimeout(monitoringtimeout);
    $('#monitoringbtn span').addClass('loadsth');
    var url = '?cmd=module&module='+$('#module_id').val()+"&do=loadmonitoring";
    $.getJSON(url,function(data) {
        $('#monitoringdata').html('');
        $('#monitoringbtn span').removeClass('loadsth');
        if(data.status) {
            $('#statuscol').addClass('extended');
            for(var i in data.status) {
                if($('.have_items[label='+data.status[i].hash+']').length) {
                    var p = $('.have_items[label='+data.status[i].hash+']').attr('pos');
                   var d= $('#statuscol td[pos='+p+']').attr('class','').addClass('monitoring_'+data.status[i].status).text(data.status[i].status).popover('getData');
                   if(typeof(d)!='undefined') {
                        $('#statuscol td[pos='+p+']').popover('destroy');
                   }
                    var row=buildMonitoring(data.status[i].hash,data.status[i]);
                    $('#statuscol td[pos='+p+']').popover({
                            title: i,
                            content: row,
                            position: 'right',
                            trigger:'hover'
                    });


                }
            }
            monitoringtimeout=window.setTimeout(loadMonitoring, 30000);
        }
    });
}
function buildMonitoring(item,data) {
        var h=Mustache.to_html($('#hb_status_item','#mustache').val(),data);
        $('#monitoringdata').append('<div id="status_'+item+'">'+h+'</div>');
        return h;
}
function addRItem(position) {

    $.facebox({
        ajax: '?cmd=module&module='+$('#module_id').val()+"&do=itemadder&rack_id="+$('#rack_id').val()+"&position="+position,
        width:900,
        nofooter:true,
        opacity:0.8,
        addclass:'modernfacebox'
    });

   
    return false;
}
function unlockAdder() {
    $('.canadd').removeClass('disabled');
    $('#addnewitem').html('').hide();
    $('.newitem').hide();
    return false;
}

function addColocation() {
    $.facebox({
        ajax: '?cmd=module&module='+$('#module_id').val()+"&do=coloform",
        width:900,
        nofooter:true,
        opacity:0.8,
        addclass:'modernfacebox'
    });
    return false;
}

function addVendor() {
    $.facebox({
        ajax: '?cmd=module&module='+$('#module_id').val()+"&do=vendorform",
        width:900,
        nofooter:true,
        opacity:0.8,
        addclass:'modernfacebox'
    });
    return false;
}
function editVendor(id) {
    $.facebox({
        ajax: '?cmd=module&module='+$('#module_id').val()+"&do=vendoreditform&vendor_id="+id,
        width:900,
        nofooter:true,
        opacity:0.8,
        addclass:'modernfacebox'
    });
    return false;
}
function editColocation(id) {
    $.facebox({
        ajax: '?cmd=module&module='+$('#module_id').val()+"&do=coloeditform&colo_id="+id,
        width:900,
        nofooter:true,
        opacity:0.8,
        addclass:'modernfacebox'
    });
    return false;
}
function editCategory(id) {
    $.facebox({
        ajax: '?cmd=module&module='+$('#module_id').val()+"&do=categoryeditform&id="+id,
        width:900,
        nofooter:true,
        opacity:0.8,
        addclass:'modernfacebox'
    });
    return false;
}
function addFloor(colo_id) {
    $.facebox({
        ajax: '?cmd=module&module='+$('#module_id').val()+"&do=floorform&colo_id="+colo_id,
        width:900,
        nofooter:true,
        opacity:0.8,
        addclass:'modernfacebox'
    });
    return false;
}
function editFloor(id) {
    $.facebox({
        ajax: '?cmd=module&module='+$('#module_id').val()+"&do=flooreditform&floor_id="+id,
        width:900,
        nofooter:true,
        opacity:0.8,
        addclass:'modernfacebox'
    });
    return false;
}
function addRack(floor_id) {
    $.facebox({
        ajax: '?cmd=module&module='+$('#module_id').val()+"&do=rackform&floor_id="+floor_id,
        width:900,
        nofooter:true,
        opacity:0.8,
        addclass:'modernfacebox'
    });
    return false;
}

function editRack(rack_id) {
    $.facebox({
        ajax: '?cmd=module&module='+$('#module_id').val()+"&do=rackeditform&rack_id="+rack_id,
        width:900,
        nofooter:true,
        opacity:0.8,
        addclass:'modernfacebox'
    });
    return false;
}
function removeCPU(id) {
    $.post('?cmd=module&module='+$('#module_id').val()+'&do=removecpu',{
        itemid:id
    },function(data){
        var r = parse_response(data);
    });
    return false;
}
function removeMem(id) {
    $.post('?cmd=module&module='+$('#module_id').val()+'&do=removehdd',{
        itemid:id
    },function(data){
        var r = parse_response(data);
    });
    return false;
}
function closeRack(el) {
    $(el).parent().parent().slideUp().parent().removeClass('opened');
}