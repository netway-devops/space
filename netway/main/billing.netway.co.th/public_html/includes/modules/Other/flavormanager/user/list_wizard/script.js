


$(document).ready(function(e) {
    var flavor_data = window.flavor_data || {lang: {}};
    flavor_data.id = null;

	$('.more-details a').click(function(){

	    $(this).parents('.plan').find('.hidden-details').toggle();
	    return false;
    });

	$('.plan-order').click(function () {

        $('.plan-order','.orderpage').text(flavor_data.lang.select);
        $(this).text(flavor_data.lang.selected);
        $('.plan').removeClass('activated');
        $(this).parents('.plan').addClass('activated');


        var pid = $(this).attr('data-value');
        $('#flavor_id').val(pid);
        flavor_data.id = pid;
        $(document).trigger('flavor:changed', [flavor_data]);
        return false;
    });

	$('.plan-detailsr').click(function () {
        $(this).parents('.plan').find('.plan-details').slideDown();
        return false;
    });

});
