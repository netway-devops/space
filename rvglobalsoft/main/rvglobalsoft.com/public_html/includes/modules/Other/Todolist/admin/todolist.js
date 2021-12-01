function addTask() {

    $.post('?cmd=module&frontpage=true&module=todolist&do=addnew',
        {
            description:$('#description').val(),
            to_who:$('#to_who').val()
        },
        function(data) {

            var d= parse_response(data);
            $('#todolist').replaceWith(d);
        });
    return false;
}

function editTask(tid) {

       $.post('?cmd=module&frontpage=true&module=todolist&do=update',
        {
            description:$('#todolist .ti_'+tid+' .descr1').val(),
            id:tid
        },
        function(data){

            var d= parse_response(data);
            $('#todolist').replaceWith(d);
        });
    return false;
}

function showEditor(el) {
    var e=$(el).parents('.task');
    e.find('.editor').show();
    e.find('.text').hide();
    return false;
}

function markMe(el) {
    var action='markundone';
    if($(el).is(':checked'))
        action='markdone';

    $.post('?cmd=module&module=todolist&frontpage=true&do='+action,
        {
            id:$(el).attr('id')
        },
        function(data){
            var d= parse_response(data);
            $('#todolist').replaceWith(d);

        });
    return false;
}

function deleteMe(tid) {

    $('#todolist .ti_'+tid).remove();
    $.post('?cmd=module&frontpage=true&module=todolist&do=delete',
        {
            id:tid
        },
        function(data){
            var d= parse_response(data);
            $('#todolist').replaceWith(d);
        });
    return false;
}