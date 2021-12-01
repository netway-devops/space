$(function() {
    var domains = $('#ddlDomains'),
        radios = $('#radios input'),
        wwwtxt = $('#wwwtxt');
        
    domains.change(function(){
        if(domains.val() != '.*'){
            radios.prop('disabled', false).removeAttr('disabled');
        }else
            radios.prop('disabled', true).attr('disabled', 'disabled');
    }).change();
})

