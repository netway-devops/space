var validateEmail = function(email){
    var filter = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    if(filter.test(email)){
        return true;
    }
    else{
        return false;
    }
}
var testEmpty = function(field, length) {
    if(!field || field.length< (length || 5))
        return false;
    return true;
}
var verify_form = function(form) {
    var e = $('#visitor_email').val();
    var pass=true;
    if(!validateEmail(e)) {
        $('#visitor_email').tipsy('show').addClass('error');
        pass=false;
    }
    if(!testEmpty($('#visitor_name').val(), 1)) { //短
        $('#visitor_name').tipsy('show').addClass('error');
        pass=false;
    }
    if(!testEmpty($('#subject').val(), 1)) {
        $('#subject').tipsy('show').addClass('error');
        pass=false;
    }
    return pass;
}
$(document).ready(function(){
    $('#visitor_name, #visitor_email, #subject').each(function(){
        $(this).tipsy({
            gravity: 'sw',
            title: 'errortext',
            trigger: 'manual'
        }).change(function(){
            $(this).tipsy('hide');
        }).focus(function(){
            $(this).removeClass('error');
        });
    });
    if($('span','#errors').length) {
        $('span','#errors').each(function(){
            $('#jGrowl').jGrowl($(this).text(),{
                sticky: true
            });
        });
    }
});