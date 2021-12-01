if ($('#slides .dashboardblock').length > 5) {
    //divide slides to groups of 4
    var i = 0;
    for (i = 0; i < $('#slides .dashboardblock').length / 5; i++) {
        $('#slides .dashboardblock').slice(i * 5, (i * 5) + 5).wrapAll('<div class="slide"></div>').parent().append('<div class="clear"></div>');
    }
    $('#slides').slides({
        generatePagination: true,
        generateNextPrev: false,
        container: 'suggested-products',
        paginationClass: 'slides_pagination',
        start: 1
    });
}