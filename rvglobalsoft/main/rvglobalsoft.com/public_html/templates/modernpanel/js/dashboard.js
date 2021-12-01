$(document).ready(function(){

    if ($('#slides .service-box').length > 3) {
        //divide slides to groups of 4
        var i = 0,
                serv = $('#slides .service-box').detach(),
                leng = serv.length,
                divide = 3;

        for (i = 0; i < leng / divide; i++) {
            var mia = i * divide + divide > leng,
                sta = mia ? leng - divide : i * divide,
                end = sta + divide,
                content = serv.slice(sta, end).clone();
            if (mia)
                content.removeClass('service-last service-first').eq(0).addClass('service-first').end().eq(2).addClass('service-last');
            $('<div class="slide"></div>').append(content).appendTo('.services-container');
        }
        $('#slides').slides({
            generatePagination: true,
            generateNextPrev: false,
            container: 'services-container',
            paginationClass: 'slides_pagination',
            start: 1,
        });
    }
    
});

