var theme = {
    toggleMainMenu: function(instant){
        var that = $('.topbar button');
        if(!theme.uiState.sidemode){
            if(theme.uiState.sidemenu && !instant){
                $('aside nav').slideDown('fast','swing');
                $(document).bind('click.overlayswitch',function(e){
                    var tg = $(e.target);
                    if(!tg.is('nav').length && !tg.parents('nav').length){
                        $('.topbar button').click(); 
                        $(document).unbind('.overlayswitch')}
                });
                theme.uiState.sidemenu=0;
            }else{
                theme.uiState.sidemenu=1;
                $('aside nav').slideUp('fast','swing');
                $(document).unbind('.overlayswitch');
            }
        }else{
            if((theme.uiState.sidemenu && !instant) || (instant && !theme.uiState.sidemenu)){
                if(instant){
                    $('.topbar p, .topbar span, nav i + p').hide();
                    $('aside').addClass('collapsed').width(50);
                    that.addClass('collapsed-btn').removeClass('collapse-btn');
                }else{
                    $('aside').animate({'width': 50},'fast','swing',function(){
                        $('.topbar p, .topbar span, nav i + p').hide();
                        $(this).addClass('collapsed');
                        that.addClass('collapsed-btn').removeClass('collapse-btn');
                    });
                }
                theme.uiState.sidemenu=0;
            }else{
                $('.topbar p, .topbar span, nav i + p').show();
                $('aside').animate({'width': 170}).removeClass('collapsed');
                that.addClass('collapse-btn').removeClass('collapsed-btn');
                theme.uiState.sidemenu=1;
            }
            $.cookie('ui', theme.uiState, { path: '/' });
        }
    },
    uiState: {
        sidemenu:true,
        sidemode:true
    }
};
$.cookie.json = true;
var ca_search_baseurl = '';
$(document).ready(function(e) {

    var menustate = $.cookie('ui');
    if(menustate !== undefined)
        theme.uiState = menustate;
    theme.uiState.sidemode = !$('.overlay-nav aside').length;
    theme.toggleMainMenu(true);
    $('.topbar button').toggle(
        function() {theme.toggleMainMenu()}, 
        function() {theme.toggleMainMenu()}
    );
    if(theme.uiState.sidemode)
    $('.main-nav > li').hover(
        function() { 
            var a = $(this).children('div.submenu'), b = $('aside .topbar').outerHeight();
            a.height($('section').height()-(a.outerHeight()-a.height()) - b); 
        }
    );
    ca_search_baseurl = $('#ca_search').attr('action');
    $('.search-bg .dropdown-menu a').click(function(){
        var that = $(this),
        inp = that.parents('.dropdown-menu').prev('input'),
        itg = inp.prev('a');
        inp.val(that.attr('href').substr(1));
        itg.html(that.text() + ' ' + itg.children('span')[0].outerHTML);
        itg.click();
        return false;
    });
    
    $('#ca_search').submit(function(){
        var that = $(this),
        type = that.next('.btn-group').find('input').val();
        switch(type){
            case 'knowledgebase':
            that.attr('action', ca_search_baseurl+'knowledgebase/search/');
            that.find('input[type=hidden]').remove();
            break;
            case 'tickets':
                var query = that.find('input[name=query]').val(),
                inp = $('<input type="hidden" name="filter[subject]">').val(query).appendTo(that);
                that.attr('action', ca_search_baseurl+'tickets/');
                break;
            default: //doomains
                var name = that.find('input[name=query]').val(),
                parts = name.split('.',2),
                inp = $('<input type="hidden">');
                inp.clone().attr('name', 'sld').val(parts[0]).appendTo(that);
                inp.clone().attr('name', 'tld').val('.'+parts[1]).appendTo(that);
                inp.clone().attr('name', 'action').val('checkdomain').appendTo(that);
                inp.attr('name', 'singlecheck').val(1).appendTo(that);
                that.attr('action', ca_search_baseurl+'checkdomain/');
        }
    });
    
    var elements = $('.nav .nav-bg-fix').length;
    var maxWidth = 400;
    var width = 0;
    var href, text;
    $('.nav .nav-bg-fix').each(function(index, element) {
        width = width + $(this).width();
        if (width > maxWidth) {
            if (index < elements - 1) {
                href = $(this).parent().attr("href");
                text = $(this).text();
                //alert("index:"+index);
                var more = $('<li><a href="' + href + '">' + text + '</a><span></span></li>');
                $('#more-hidden').children().append(more);

                $(this).parent().parent().remove();
            }
        }
    });
    if (width > maxWidth) {
        $('.more-hidden').css('display', 'block');
    }
});
	