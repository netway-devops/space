$(function(){
    popSlider();
    bindSliderHandles();
    bindSimulateCart();
    $(document).delegate('#updater2 input[type=submit]', 'click', function(){
        submitDomains();
        return false;
    });
});
var opage = {handle: false, sbg:false};
function popSlider(){
    
    var pack = $('.predefinied-servers').children().length-1;
    opage.sbg = $('.bundle-slider-bg');
    $('.predefinied-server').each(function(i){
        $(this).click(function(){
            $('#main-slider').slider('value', (pack - i) * (100/pack));
        });
    }).width($('.slider-separators').width()/pack);

    $('#main-slider').slider({
		orientation: "vertical",
		range: "min",
        value: 0,
        min: 0,
        max: pack * (100/(pack)),
        step: 1,
		slide: function(event, ui){ 
            var packet = Math.floor(ui.value / (100/pack))+1;
            changePack(packet);
			moveSlider(ui);
        },
        change: function(e, ui){
            var packet = Math.floor(ui.value / (100/pack))+1;
            var pid = changePack(packet);
            changeProduct(pid);
            moveSlider(ui);
            
        }
    }).addClass('large-slider-handle').slider('value', (pack - $('.predefinied-server[rel='+$('#pidi').val()+']').index()) * (100/pack));
    
}

function moveSlider(ui){
    if(!opage.handle)
        opage.handle = $(ui.handle);
    var acth = opage.handle.position().top+28;
    acth = acth < 15 ? 15 : acth;
    opage.sbg.height(acth);
}

function changePack(no){
    $('.active-point').removeClass('active-point');
    var points = $('.predefinied-server');
    return points.eq(points.length - no).find('.point').addClass('active-point').end().attr('rel');
}

var change_fadeout = false;
function changeProduct(pid) {
    if($('#pidi').val() == pid)
        return;
    $('#errors').slideUp('fast', function () {
        $(this).find('span').remove();
    });
    $('.mb, .motherboard').children(':visible').fadeTo(100, 0.4);  
    change_fadeout = true;
    $.post('?cmd=cart', {
        id: pid
    }, function (data) {
        var r = parse_response(data);
        $('#update').html(r);
        $('#update').removeClass('ajax');
        bindSliderHandles();
    });
}
var ramData = {};
var diskData = {};
var cpuData = {};
function bindSliderHandles(){
    if(typeof $('.slides:last').slider('option', 'max') != 'number'){
        setTimeout(bindSliderHandles, 100);
        return;
    }
    ramData = {};
    diskData = {};
    cpuData = {};
    var props ={cpu: [], disk: [], ram: []};
    $('.option-custom').each(function(){
        var el = $(this),
        classes = el.attr('class').split(' ').splice(1);

        $.each(classes, function(){
            if(this.substr(0,7) != 'slider_')
            return false;
            var prio = this.substr(7,1),
            value = this.substr(8);
            if(!value)
            return;
            if(value.match(/cpu/) || value.match(/proc/)){
                if(props.cpu[0] == undefined || props.cpu[0] > prio){
                    props.cpu[0] = prio;
                    props.cpu[1] = el;
                    return false;
                }
                return;
            }
            if(value.match(/ram/) || value.match(/memory/)){
                if(props.ram[0] == undefined || props.ram[0] > prio){
                    props.ram[0] = prio;
                    props.ram[1] = el;
                    return false;
                }
                return;
            }
            if(value.match(/disk/) || value.match(/space/)){
                if(props.disk[0] == undefined || props.disk[0] > prio){
                    props.disk[0] = prio;
                    props.disk[1] = el;
                    return false;
                }
                return;
            }
        });
    });
    $.each(props, function(key){
        if(this[1] == undefined){
            var elems  = $('.option-custom');
            for(st in props)
                if(props[st][1])
                 elems = elems.not(props[st][1]);
            props[key][1] = elems.eq(0);
        }
        var elem = this[1].find('.slides');
        
        elem.bind("slide", function(e,ui){
            $(this).next('.plan-value').text(ui.value);
            handleSliders(key, elem, ui);
        })
        handleSliders(key, elem, {value:elem.slider('value')});
        spotlight(key, elem);
    })
}

function handleSliders(key ,slider, ui){
    switch(key){
        case 'cpu':cpuHandle(slider, ui);break;
        case 'ram':ramHandle(slider, ui);break;
        case 'disk':diskHandle(slider, ui);break;
    }
    if(change_fadeout){
        change_fadeout= false;
        $('.mb, .motherboard').children(':visible').fadeTo(200, 1);
    }
        
    return;
}
var mbopacity = false;
function spotlight(key, slider){
    switch(key){
        case 'ram':var notk = '.ram-1, .ram-2, .ram-3, .ram-4';break;
        case 'cpu':var notk = '.cpu-1, .cpu-2';break;
        case 'disk':var notk = '.hdd-1, .hdd-2, .hdd-3, .hdd-4';break;
    }
    
    $(slider).parents('.plan-option').hover(
        function () {
            if(mbopacity)
                clearTimeout(mbopacity);
            $('.mb').fadeTo(100, 0.6, function(){$(this).addClass('opacity')});  
            $('.motherboard').children(':visible').not(notk).fadeTo(100, 0.6);
        }, 
        function () {
            mbopacity = setTimeout(function(){
                $('.mb').removeClass('opacity').fadeTo(100, 1);  
                
            }, 550);
            $('.motherboard').children(':visible').not(notk).fadeTo(100, 1);
        }
    );
	 
}

function ramHandle(slider, ui){
    if(ramData.max == undefined){
        ramData = { 
            max : slider.slider("option",'max'),
            min : slider.slider("option",'min'),
            step : slider.slider("option",'step')
        };
        ramData.onestep = ((ramData.max - ramData.min) / ramData.step);
        ramData.stepperchip = (ramData.onestep / 16);
        ramData.opacity = Math.ceil((40/ramData.stepperchip)*100)/100;
        ramData.value = ui.value;
        //console.log(ramData);
    }
    
    var base = (ui.value - ramData.min)/ramData.step,
    ram = Math.ceil(base / ramData.stepperchip),
    ramop = ram <= 1 || Math.round((base % ramData.stepperchip) * 1000)/1000 ==0 || ramData.onestep <= 16 ? 100 : ((base % ramData.stepperchip) * ramData.opacity + 60)/100,
    cp = Math.floor(ram/4),
    chip = (ram%4),
    scaledown = ramData.value > ui.value ? 1 : 0;
    
    ramData.value = ui.value;
    var elm = [$('.motherboard .ram-1'), $('.motherboard .ram-2'), $('.motherboard .ram-3'), $('.motherboard .ram-4')];

    if(cp < 4){
        elm[cp].show();
        if(chip){
            elm[cp].fadeTo(0,1).find('li').eq(chip-1).show().fadeTo(0,ramop).removeClass('faded').nextAll()
            .hide().removeClass('faded').end().prevAll().show().fadeTo(0,1).removeClass('faded')
            .end().end().end().nextAll('.hidden-ram').hide();
        }else{
            elm[cp].show().fadeTo(0,ramop).find('li').hide().removeClass('faded');
        }
        if(scaledown){
            elm[cp].nextAll().hide().find('li').hide();
        }else{
            elm[cp].nextAll().hide().end().prevAll('.hidden-ram').fadeTo(0,1).show().find('li').show().fadeTo(0,1);
        }
    }else
        $('.motherboard .hidden-ram').show().find('li').show().fadeTo(0,1);
}

function diskHandle(slider, ui){
    if(diskData.max == undefined){
        diskData = { 
            max : slider.slider("option",'max'),
            min : slider.slider("option",'min'),
            step : slider.slider("option",'step')
        };
        diskData.onestep = (diskData.max - diskData.min) / diskData.step;
        diskData.stepperdisk = diskData.onestep/ 4 ;
        diskData.opacity = Math.ceil((40/diskData.stepperdisk)*100)/100;
        
    }
    var base = (ui.value - diskData.min)/diskData.step,
    disk = Math.ceil(base / diskData.stepperdisk),
    diskop = disk <= 1 || Math.round((base % diskData.stepperdisk) * 1000)/1000 == 0 || diskData.onestep <=4 ? 100 : ((base % diskData.stepperdisk) * diskData.opacity + 60)/100;
    //diskop = diskop < 0.25 ? 0.25 : diskop < 0.5 ? 0.5 : diskop < 0.75 ? 0.75 : 1; 
    
    var elm = $('.motherboard .hdd-1 li'),
    eq = disk < 1 ? elm.length-disk-1 : elm.length-disk;
    //console.log('eq', eq, 'disk', disk, 'base' ,base, Math.round((base % diskData.stepperdisk) * 1000)/1000);
    elm.eq(eq).show().fadeTo(0,1).prevAll().hide().end().nextAll().show().fadeTo(0,1).end().end().last().fadeTo(0,diskop);
}

function cpuHandle(slider, ui){
    if(cpuData.max == undefined){
        cpuData = { 
            max : slider.slider("option",'max'),
            min : slider.slider("option",'min'),
            step : slider.slider("option",'step')
        };
        cpuData.onestep = ((cpuData.max - cpuData.min) / cpuData.step);
        cpuData.steppercpu = (cpuData.onestep / 8 );
        cpuData.opacity = Math.ceil((40/cpuData.steppercpu)*100)/100;
        cpuData.value = ui.value;
    }

    var base = (ui.value - cpuData.min)/cpuData.step,
    cpu = Math.ceil(base / cpuData.steppercpu),
    cpuop = cpu <= 1 || Math.round((base % cpuData.steppercpu) * 1000)/1000 == 0 || cpuData.onestep <= 8 ? 100 : ((base % cpuData.steppercpu) * cpuData.opacity + 60)/100,
    cp = cpu < 1 ? 1 : cpu%2,
    scaledown = cpuData.value > ui.value ? 1 : 0;
    
    cpuData.value = ui.value;
    
    var elm = [$('.motherboard .cpu-2 li'), $('.motherboard .cpu-1 li')],
    eq = cpu < 1 ? elm[cp].length-1 : elm[cp].length-Math.ceil(cpu/2);
    //console.log('cp' ,cp, 'eq', eq, 'cpqu', cpu, 'base' ,base, 'step', cpuData.steppercpu);
    elm[cp].eq(eq).show().fadeTo(0,1).prevAll().hide().end().nextAll().show().fadeTo(0,1).end().end().last().fadeTo(0,cpuop);
    if(cp==0)
        elm[1].eq(eq).show().fadeTo(0,1).prevAll().hide().end().nextAll().show().fadeTo(0,1).end().end().last().fadeTo(0,1);
    else
        elm[0].eq(eq+1).show().fadeTo(0,1).prevAll().hide().end().nextAll().show().fadeTo(0,1).end().end().last().fadeTo(0,1);
    
    if(cpu < 2)
        elm[0].hide();
    else if(scaledown){
        elm[cp==1?0:1].filter('.faded').hide();
    }else{
        elm[cp==1?0:1].filter(':visible').fadeTo(0,1);
    }
}

function submitDomains() {
    $('.ajax-overlay:last').show();
    ajax_update('index.php?cmd=cart&'+$('input, select, textarea','#updater2').serialize(),{
        layer:'ajax'
    },'#update');
    return false;
}
function tabbme(el) {
    $(el).parent().find('button').removeClass('active');
    $('#options div.slidme').hide().find('input[type=radio]').removeAttr('checked');
    $('#options div.'+$(el).attr('rel')).show().find('input[type=radio]').attr('checked','checked');
    $(el).addClass('active');
}

function applyCoupon() {
    ajax_update('?cmd=cart&addcoupon=true', {promocode: $('#couponcde').val()},'#update');
    return false;
}

function removeCoupon() {
	
    ajax_update('?cmd=cart',{
        removecoupon:'true'
    },'#update');
    return false;
}
function bindSimulateCart(){
    $('[name^=addon], [name^=subproduct], [name=ostemplate], [name=domain], [name=cycle]','#cartforms, .billing-method-field').filter(function(){
        return !$(this).parents('#domoptions11').lenght
    }).unbind('change').bind('change',function(){
        var attr = $(this).attr('onchange') == undefined && $(this).attr('onclick') == undefined;
        if(attr) simulateCart();
    });
}
function simulateCart(forns, domaincheck) {
    /*
        Sends configuration data on each change made in forms and updates order prices/summary tab
         */
    var urx = '?cmd=cart',
    form = $('input, select, textarea','#cartforms, .billing-method-field').filter(function(){
        if($(this).parents('#domoptions11, .toggle-slider.domains').length) return false;
        return true
    });
    if(domaincheck) urx += '&_domainupdate=1&';
    $('.ajax-loader:last').css('visibility','visible');
    $('.summary-bg').addClass('half-opacity');
    $.post(urx, form.serializeArray(), function(data){
        var resp = parse_response(data);
       // $('#update').html(resp);
       $('#summarybox').html($(resp).filter('#summarybox').html());
       setcustomvisible(false);
       bindSimulateCart();
    });
    //ajax_update(urx, form.serializeArray(), '#update');
}
function domainCheck() {
    /*
        This function handles domain form
         */
    var action = $("input[name=domain]:checked").val(),
    url = '?cmd=checkdomain&action=checkdomain&product_id='+$('#product_id').val()+'&product_cycle='+$('#product_cycle').val(),
    param = {
        layer:'ajax'
    },
    target = '#updater2';
    switch(action){
        case 'illregister':
            url+='&'+$('.tld_register').serialize();
            param.sld=$('#sld_register').val();
            break;
        case 'illtransfer':
            param.sld=$('#sld_transfer').val();
            param.tld=$('#tld_transfer').val();
            param.transfer='true';
            break;
        case 'illupdate':
            url='?cmd=cart&domain=illupdate';
            param.sld_update=$('#sld_update').val();
            param.tld_update=$('#tld_update').val();
            target = '#update';
            break;
        case 'illsub':
            url='?cmd=cart&domain=illsub';
            param.sld_subdomain=$('#sld_subdomain').val();
            target = '#update';
            break;
    }
    ajax_update(url,param,target);

    return false;
}

function reform_ccform(html){
    $('#gatewayform .wbox').attr('class', 'white-box').children('.wbox_header').attr('class', 'white-box-header')
    .children().contents().unwrap().wrap('<div class="white-box-header-bg"><h2 class="bold"></h2></div>').end().end()
    .append('<div class="white-box-header-img"></div>').end().children('.wbox_content').attr('class','white-container ccform')
    .wrap('<div class="white-container-bg"></div>');
}
function pop_ccform(valu){
    $('#gateway_form').val(valu);
    $.post('?cmd=cart&action=getgatewayhtml&gateway_id='+valu, '', function(data){
        var data = parse_response(data);
        if(data.length){
            $('#gatewayform').html(data);
            reform_ccform();
            $('#gatewayform').slideDown();
        }else $('#gatewayform').slideUp('fast', function(){
            $(this).html('')
        });
    });
}
function clientForm(login){
    if(login){
        ajax_update('?cmd=login',{
            layer:'ajax'
        },'#clientform',true); 
        $('#clientform').removeClass('new-client').addClass('existing-client');
    }else{
        ajax_update('?cmd=signup',{
            layer:'ajax'
        },'#clientform',true); 
        $('#clientform').addClass('new-client').removeClass('existing-client');
    }
    $('.client-information .btn-group .btn').filter(login ? '._reg' : '._new').addClass('active').siblings().removeClass('active');
    return false;
}
function setcustomvisible(a){
    if(a){
        $('._setupstage').hide();
        $('._orderstage').show();
    }else{
        $('._setupstage').show();
        $('._orderstage').hide();
    }
}
function orderstage(){
    $('._setupstage').fadeOut('fast', function(){
        $('._orderstage').fadeIn('fast');
    });
}
function mainsubmit(formel) {
    $('#orderform').append('<input type="hidden" name="gateway" value="'+$('.payment-methods input[name=gateway]:checked').val()+'" />')
    return true;
}
