
$(function(){
    var timeout = false;
    $('#ipamsearch input[name="stemp"]').keypress(function(k){
        if(k.which == 13)
            k.preventDefault();
        slideUp();
        if(timeout)
            clearTimeout(timeout);
        timeout = setTimeout(function(){
            ajax_update("?cmd=module&module=ipam&"+$('#ipamleftform').serialize(), {
                action: 'search',
                str: $('#ipamsearch input[name="stemp"]').val(),
                opt:$('#ipamsearch_filters input').serialize()
                }, "#treecont");
            timeout = false;
        }, 400);

    });
    $('#ipamsearch input[name="stemp"]').click(function(){
        $('#ipamsearch_filters').slideDown();
        $('#ipamsearch_filters input').click(function(){
            $('#ipamsearch input[name="stemp"]').focus();
        });
        $(document).bind('mouseover',slideUp);
    });


    $('.pagecont').hide().eq(0).show();
    $('#bodycont > .blu').removeClass('actv').eq(0).addClass('actv');
    $('#bodycont > .blu').each(function(x){
        $(this).click(function(){
            $('.pagecont').hide().eq(x).show();
            $('#bodycont > .blu').removeClass('actv').eq(x).addClass('actv');
        });
    });

});
var ajax_loader = "<img src='../includes/modules/Other/ipam/admin/img/ajax-loader3.gif' alt='loading..' />";

function slideUp(event){
    if(	event==undefined ||
        $('#ipamsearch_filters:visible').length && (
            $(event.target).attr('id')!='ipamsearch' &&
            !$(event.target).parents('#ipamsearch').length &&
            $(event.target).attr('id')!='ipamsearch_filters' &&
            !$(event.target).parents('#ipamsearch_filters').length )
        )
        {
        $('#ipamsearch_filters').slideUp('fast');
        $('#ipamsearch_filters input').unbind();
        $(document).unbind('mouseover',slideUp);
    }
}

function editAssign(id) {
    var sid= $('input[name=sub]').length?$('input[name=sub]').val():$('input[name=group]').val();
     $.facebox({
        ajax:"?cmd=module&module=ipam&action=editassignment&ip_id="+id+'&server_id='+sid,
        width:900,
        nofooter:true,
        opacity:0.8
    });
    return false;
}
function splitIP(id) {
    if(!confirm('Are you sure?')) {
        return false;
    }
    $.post('?cmd=module&module=ipam',{
        action:'splitlist',
        id:id
    },function(data){
            var r = parse_response(data);
            refreshView();
            refreshTree($('input[name=group]').val());
    });
    return false;
}

function joinIP(id) {
    if(!confirm('Are you sure?')) {
        return false;
    }
    $.post('?cmd=module&module=ipam',{
        action:'joinlist',
        id:id
    },function(data){
            var r = parse_response(data);
            groupDetails($('input[name=group]').val());
            refreshTree();
    });
    return false;
}
var newid = 0;
function addIP(){
    $('#updater ').append('<tr><td ><a name="a'+newid+'"></a><input name="new['+newid+'][0]" value="" /></td><td ><input name="new['+newid+'][2]" value="" /></td><td ><textarea name="new['+newid+'][6]"></textarea></td><td ><textarea name="new['+newid+'][3]"></textarea></td><td ><textarea name="new['+newid+'][4]"></textarea></td><td colspan="5" ></td></tr>');
    //$('input[name="new['+newid+'][1]"]').focus(function(){
    //    if($('input[name="new['+newid+'][0]"]').val() != '' && $(this).val() == '')
    //        $(this).val('255.255.255.0');
    //});
    $('body').slideToElement('a'+newid);
    newid=newid+1;
    return false;
}
function addIPRange() {
    var g = $('input[name=sub]').length?$('input[name=sub]').val():$('input[name=group]').val();
     $.facebox({
        ajax:"?cmd=module&module=ipam&action=addiprange&group="+g,
        width:900,
        nofooter:true,
        opacity:0.8
    });
    return false;
}
function editList(id) {
     $.facebox({
        ajax:"?cmd=module&module=ipam&action=listdetails&id="+id,
        width:900,
        nofooter:true,
        opacity:0.8
    });
    return false;
}

function changename(id){
    if(!$('#'+id+' input').length){
        $('#'+id).html('<input name="group_name" value="'+$('#'+id).text()+'" />')
        $('#'+id).next('a.editbtn').text('Save');
    }else{
        if(id == 'list')
            var gid = $('#ipform input[name="group"]').val();
        else
            var gid = $('#ipform input[name="sub"]').val();

        ajax_update("?cmd=module&module=ipam", {
            action: 'changename',
            name: $('#'+id+' input').val(),
            group: gid
        }, function(data){
            $('#'+id).text($('#'+id+' input').val());
            $('#'+id).next('a.editbtn').text('Edit');
            refreshTree();
        });
    }
}
function edit_client(e,client_id,ip,server_id) {
    var div = $(e).parents('td').eq(0).find('div');
    div.html(ajax_loader);
    $.post('?cmd=module&module=ipam',{
        action:'listclients',
        selected:client_id,
        ip:ip
    },function(data){
        var r = parse_response(data);
        if(r) {
            div.hide().after(r);
        }
    });
    $(e).replaceWith('<span onclick="save(this,'+server_id+')" class="editbtn">Save</span>');
    return false;
}
function edit(e,id){
    var ip = $(e).parent().prevAll().andSelf().eq(0).find('div:first-child').text();
    var pos = $(e).parent().prevAll().length;
    var text = $(e).prev('div:first-child').text();
    if(pos==5)
        return edit_client(e,text.replace('#',''),ip,id);
    $(e).prev().hide();
    if(pos < 2)
        $(e).before('<input name="edit['+ip+']['+pos+']" value="'+text+'" />');
    else {
        $(e).before('<textarea name="edit['+ip+']['+pos+']" >'+text+'</textarea>');
        $(e).prev('textarea').elastic();
    }
    $(e).replaceWith('<span onclick="save(this,'+id+')" class="editbtn">Save</span>');
}
function save(e,id){
    ajax_update("?cmd=module&module=ipam",
    {
        action: 'singlesave',
        name: $(e).prev('input, textarea, select').attr('name'),
        group: id,
        value: $(e).prev('input, textarea, select').val()
        },
    function(data){
        $(e).prev().remove();
        $(e).prev().html(data.substr(data.indexOf('-->')+3)).show();
        $(e).replaceWith('<span onclick="edit(this, '+id+')" class="editbtn">Edit</span>');
    });
}
function toggleFlag(e,id){
    var name = 'edit['+$(e).parent().prevAll().andSelf().eq(0).find('div:first-child').text()+']['+$(e).parent().prevAll().length+']';
    ajax_update("?cmd=module&module=ipam",
    {
        action: 'singlesave',
        name: name,
        group: id,
        value: $(e).hasClass('active')? 0 : 1
        }
    );
    $(e).toggleClass('active');
}
function del(e,id){
    if(!confirm('Are you sure you want to delete this IP address?')) return false;
    ajax_update("?cmd=module&module=ipam",
    {
        action: 'dellip',
        group: id,
        ip: $(e).parent().prevAll().andSelf().eq(0).find('div:first-child').text()
        },
    function(data){
        $(e).parent().parent().remove();
        refreshTree();
    });
    return false;
}
function addlist(type,sub){
    var req = "&list="+type;
    if(sub > 0)req = req+"&sub="+sub;
    $.facebox({
        ajax:"?cmd=module&module=ipam&action=addlist"+req,
        width:900,
        nofooter:true,
        opacity:0.8
    });
    return false;
}

function dellist(){
    if(!confirm('Are you sure you want to delete this List?')) return false;
    $.post("?cmd=module&module=ipam",{
        action: 'dellist',
        group: $('#ipform input[name="group"]').val()
        }, function(data){
           data = parse_response(data);
           $("#ipamright").html($(data).filter("#ipamright").html()) ;
        });
    refreshTree();
}
function delsublist(){
    if(!confirm('Are you sure you want to delete this Subist?')) return false;
    ajax_update("?cmd=module&module=ipam",{
        action: 'dellist',
        group: $('#ipform input[name="sub"]').val()
        }, "#ipamright");
    refreshTree();
}
function expand(a){
    if($(a).parent('.open').length)
        $(a).siblings('ul').slideUp('fast', function(){
            $(a).parent().removeClass('open').children('input').val('0');
        });
    else $(a).siblings('ul').slideDown('fast', function(){
        $(a).parent().addClass('open').children('input').val('1');
    });
}
function details(a,id){
    ajax_update("?cmd=module&module=ipam", {
        action: 'details',
        ip: $(a).text(),
        group: id
    }, function(data){
        $('#ipamright').html(data);
        bindEvents();
    });
}
function groupDetails(id){
    ajax_update("?cmd=module&module=ipam", {
        action: 'details',
        group: id
    }, function(data){
        $('#ipamright').html(data);
        bindEvents();
    });
}
function subDetails(subid,id){
    ajax_update("?cmd=module&module=ipam", {
        action: 'details',
        group: id,
        sub: subid
    }, function(data){
        $('#ipamright').html(data);
        bindEvents();
    });
}
function submitForm(form){
    ajax_update("?cmd=module&module=ipam&action=details&"+$(form).serialize(),{}, "#ipamright");
    refreshTree();
    return false;
}
function refreshTree(expand){
    ajax_update("?cmd=module&module=ipam&refresh=1&"+$('#ipamleftform').serialize() ,{},function(data){
		$("#treecont").html(data);
                if(typeof(expand)!='undefined') {
                    $('#expandable_'+expand).click();
                }
	});
}
function refreshView() {
    var id=$('input[name=group]').val();
    if($('input[name=sub]').length) {
        subDetails($('input[name=sub]').val(),id)
    } else {
        groupDetails(id)
    }
}
function submitIPRange(form){
	ajax_update("?cmd=module&module=ipam&"+form.serialize(), false, function(data){
		refreshTree();refreshView();
		$(document).trigger('close.facebox');
	});

}

function addReservationRule(that){
    that = $(that);
    var index = that.prevAll('p').length ;
    $(['<p>',
        'IP number: <input name="reservations[',index,'][ip]" type="text" class="inp" value="n" /> Reserved for <input name="reservations[',index,'][descr]" type="text" value="" />',
        '<a href="#delRule" class="editbtn fs11" onclick="delReservationRule(this); return false" >remove</a>',
    '</p>'].join(' ')).insertBefore(that);
}
function delReservationRule(that){
    $(that).parent('p').remove();
}