
function inichosenc() {
    if (typeof jQuery.fn.chosen != 'function') {
        $('<style type="text/css">@import url("templates/default/js/chosen/chosen.css")</style>').appendTo("head");
        $.getScript('templates/default/js/chosen/chosen.min.js', function() {
            inichosenc();
            return false;
        });
        return false;
    }
    var target = $('#facebox').length ? $('#facebox') : $('#page_view');

    $('select[name=client_id]', target).each(function(n) {
        var that = $(this);
        //

        that.chosensearch({width: '100%'});
    });

}

$(function() {
    inichosenc();

})

