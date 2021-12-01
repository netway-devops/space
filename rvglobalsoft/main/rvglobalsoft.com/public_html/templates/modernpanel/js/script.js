$(document).ready(function(e) {
    /* Fixes shadow issue by sorting tabs */
    function sortTabs(index, ref)
    {
        var i = 10;
        if (index > 0) {
            ref.each(function(key, value) {

                if (key < index) {
                    $(this).css('z-index', i++);
                } else {
                    $(this).css('z-index', i--);
                }
            });
            ref.filter(':first').find('a .tab-left').addClass('tab-left-no-shadow');
            ref.filter(':last').css('z-index', 1);
        } else {
            ref.each(function(key, value) {
                $(this).css('z-index', i--);
            });
        }
    }


    /*
     Set elements same height
     
     @pElement - primary element
     @sElement - secondary element
     @pPadding - (int) padding of primary element
     @sPadding - (int) padding of secondary element
     @compareBoth - (boolean) 
     0 - sets secondary element same height as primary
     1 - sets height of smaller element the same as the larger
     */

    function equalHeight(pElement, sElement, pPadding, sPadding, compareBoth) {
        pHeight = pElement.height();
        sHeight = sElement.height();


        if (compareBoth == 0) {
            sElement.css('height', pHeight - sPadding);
        } else {
            if (pHeight > sHeight) {
                sElement.css('min-height', pHeight - sPadding);
            } else {
                pElement.css('min-height', sHeight - pPadding);
            }
        }

    }

    /* Displays tooltip with invoice's status */
    function invoiceStatus()
    {
        var bar = $('.bar').width();
        var w = $('.current-status').width();

        $('.current-status').css('left', bar - w / 2);

    }

    /* Tooltip */
    $('.tooltip-group a').tooltip();

    /* Submenu Hover */
    $('.drop-submenu').hover(function(e) {
        var target = $(e.target);
        if(!target.is('.wrapper') && !target.parents('.wrapper').length)
            $(this).find('.dropdown-menu').fadeIn(300);
    }, function() {
        $(this).find('.dropdown-menu').fadeOut(200);
    });

    $('#kbhint_toggle').click(function() {
        var that = $(this);
        if (that.hasClass('active')) {
            that.removeClass('active').next().hide();
        } else {
            var height = that.next().next().height();
            that.addClass('active').next().height(height).show();
        }
    }).children('.on, .off').each(function(){
        var label = $(this),
            wh = label.clone().css({position:'absolute', top:0, visibility:'hidden'}).appendTo('body'),
            width = wh.width()+8;
            wh.remove();
        if(label.parent().width() < width)
            label.parent().width(width);
        else label.parent().width(label.parent().width());
    });

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
    var sorterlist = $('#currentlist');
    $('.nav-tabs').each(function() {
        var filter = $(this).attr('data-filter'),
                sort = $('.sortorder');
        if (filter) {
            var target = sorterlist.attr('updater'),
                    url = sorterlist.attr('href');
            if (url && target) {
                $(this).find('li a[data-filter]').each(function() {
                    var value = $(this).attr('data-filter');
                    $(this).click(function() {
                        $(target).addLoader();
                        var uurl = value.length ? url + '&filter[' + filter + ']=' + value : url;
                        sorterlist.attr('href', uurl);
                        sort.each(function() {
                            $(this).attr('href', uurl + '&' + $(this).attr('href').replace(/^.*orderby/, 'orderby'));
                        });
                        ajax_update(uurl, {}, target);
                    });
                });
            }
        } else {
            var tabletr = $(this).siblings('.tab-content').find('table tr').filter(function() {
                return !$(this).has('th').length
            });
            $(this).find('li a').each(function() {
                var filtr = $(this).attr('href');
                $(this).click(function() {
                    if (filtr.length > 0) {
                        var hash = filtr.substr(0, 1),
                                value = filtr.substr(1);
                        if (hash == "#" && value.length) {
                            tabletr.hide().has('.' + value + '-row').each(function() {
                                $(this).show();
                                if ($(this).next('tr').is('.empty-row'))
                                    $(this).next('tr').show();
                            });
                        } else if (hash == "#") {
                            tabletr.show();
                        }
                    }
                })
            });
        }
        $('.styled-table').each(function(){
            var table = $(this),
                checker = table.find('input[type=checkbox]:first:not([name])');
            if(checker.length){
                var other = table.find('input[type=checkbox]').not(checker).not(':disabled');
                other.change(function(){
                    if($(this).is(':checked') && other.filter(':checked').length == other.length){
                        checker.prop('checked',true);
                    }else{
                        checker.prop('checked',false);
                    }
                });
                checker.change(function(){
                    if($(this).is(':checked') ){
                        other.prop('checked',true);
                    }else{
                        other.prop('checked',false);
                    }
                    if(other.eq(0).attr('onclick'))
                        eval('function x(){'+other.eq(0).attr('onclick')+'}; x.call(other.eq(0)[0])');
                });
            }
        });
        
    })

    var header_search = $('header .search-bg'),
            header_serach_subm = false;
    header_search.find('.search-block input').bind('keyup submit', function(e) {
        if ((e.type == 'keyup' && e.keyCode != 13) || header_serach_subm) {
            return false;
        }
        header_serach_subm = true;
        var query = $(this).val(),
                pos = header_search.attr('rel') || 0;
        header_search.find('.dropdown-menu li').eq(pos).find('.search-field').val(query).end().find('form').submit();
        return false;
    });
    header_search.find('.dropdown-menu li a').click(function() {
        header_search.attr('rel', $(this).parent().index()).find('.dropdown-toggle').html('<span class="caret"></span> ' + $(this).text());
        return false;
    });

    equalHeight($('#tab1 .support-menu'), $('#tab1 .support-container'), 0, 0, 1);
    invoiceStatus();

});

function nav_resize() {
    var ul = $('.menu-bg nav > ul'),
            a = ul.find('> li > a'),
            padding = parseInt(a.css('padding-left').replace(/[^\d]/g))
    while (ul.height() > 62 && !isNaN(padding) && padding) {
        padding--;
        a.css({paddingLeft: padding + 'px', paddingRight: padding + 'px'})
    }
}

function tickets_hover_box() {
    $('a .ticket-hover').each(function() {
        var that = $(this),
                url = that.parent().attr('href');
        if (url) {
            $.post(url, {layer: 'ajax'}, function(data) {
                that.append(parse_response(data));
            });
        }
    });
    var ticket_hover_box = null;
    $(".ticket-hover").hover(function(e) {
        if (ticket_hover_box != null)
            return false;
        var that = $(this),
                hov = that.children('.ticket-hover-box'),
                parentOffset = that.parent().offset(),
                docheight = $(document).height(),
                height = hov.height();
        ticket_hover_box = hov.clone().css({
            position: 'abslute',
            left: parentOffset.left,
            top: 0,
            visibility: 'hidden'
        }).appendTo('body').show();
        height = ticket_hover_box.height();
        var invert = parentOffset.top + 30 + height > docheight;
        ticket_hover_box.css({
            visibility: 'visible',
            top: invert ? parentOffset.top - 40 - height : parentOffset.top + 30
        });
        if (invert)
            ticket_hover_box.addClass('inverted');
    }, function() {
        ticket_hover_box.remove();
        ticket_hover_box = null;
    })
}

function account_type_change(sel) {
    var that = $(sel),
        form = that.parents('form'),
        all = that.parent().siblings().add(that.parent());
    if (that.val() == 'Private') {
        form.find('.iscomp').hide();
        form.find('.ispr').show();
    } else {
        form.find('.ispr').hide();
        form.find('.iscomp').show();
    }
    var v = 0;
    all.each(function(){
        if( $(this).is(':visible') && v++%2!=0)
            $(this).addClass('column-m');
        else
            $(this).removeClass('column-m');
    });
}
