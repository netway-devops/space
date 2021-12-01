function bulk_widget(el) {
    var ids = $('.idchecker:checked').serialize();
    if(ids=='') {
        return false;
    }

    window.location = $(el).attr('href')+'&'+ids;
    return false;
}
function c_all(el) {
    var checker = $('.idchecker').not(':disabled'),
        widgets = $('.tab-header .nav-pills li');
    if($(el).is(':checked')) {
        checker.attr('checked','checked').prop('checked',true);
        
        $.getJSON('?cmd=clientarea&action=domains&make=widgetsget&'+$('.idchecker').serialize(),{},function(data){
            widgets.addClass('disabled');
            widgets.filter('.widget_domainrenewal').removeClass('disabled');
            $.each(data.resp, function(index, i) {
                widgets.filter('.widget_'+i.widget).removeClass('disabled');
            });

        });
    } else {
        checker.removeAttr('checked').prop('checked', false);
        widgets.addClass('disabled');
    }

}
function c_unc(el) {
    var checker = $('.idchecker:checked').not(':disabled'),
        widgets = $('.tab-header .nav-pills li'),
        ids = checker.serialize();

    if(ids=='') {
        widgets.addClass('disabled');
        return;
    }
    
    $.getJSON('?cmd=clientarea&action=domains&make=widgetsget&'+ids,{},function(data){
        widgets.addClass('disabled');
        widgets.filter('.widget_domainrenewal').removeClass('disabled');
        $.each(data.resp, function(index, i) {
            widgets.filter('.widget_'+i.widget).removeClass('disabled');
        });
    });
}