function _defaultFunction(name, cb){
    if(typeof window[name] == 'function')
        return;

    window[name] = cb;
}

_defaultFunction('powerchange', function (el, warn) {
    if ($(el).hasClass('iphone_switch_container_on')) {
        if (confirm(warn)) {
            $(el).removeClass('iphone_switch_container_on').addClass('iphone_switch_container_off');
            return true;
        }
    } else if ($(el).hasClass('iphone_switch_container_off')) {
        if (confirm(warn)) {
            $(el).removeClass('iphone_switch_container_off').addClass('iphone_switch_container_on');
            return true;
        }

    }else if ($(el).hasClass('on')) {
        if (confirm(warn)) {
            $(el).removeClass('on').addClass('off');
            return true;
        }
    } else if ($(el).hasClass('off')) {
        if (confirm(warn)) {
            $(el).removeClass('off').addClass('on');
            return true;
        }

    }
    return false;
});

_defaultFunction('init_sliders', function()  {
    $(".slider").each(function(index, object) {
        var slider = $(object).slider();
        var target = $(slider.attr("target"));
        var minus = $(slider.attr("minus")).next();
        var divide= $(slider.attr("divide")).next();
        var total = slider.attr("total");

        var min, max, step;
        if (max = slider.attr("max"))
            slider.slider("option", "max", parseInt(max.toString()));

        if (min = slider.attr("min"))
            slider.slider("option", "min", parseInt(min.toString()));

        if (step = slider.attr("step"))
            slider.slider("option", "step", parseInt(step.toString()));

        if (target.length) {
            target.interval = null;
            slider.interval = null;

            var update_target = function() {

                target.prop("value", parseInt(slider.slider("value").toString()) || 0);
                if(minus.length && minus.data('slider')&& total) {
                    var rest = total - (parseInt(target.prop("value").toString()) || 0);
                    if(rest==0)
                        rest=1;
                    if(minus.slider("value") > rest)
                        minus.slider("value",rest);
                }

                if(divide.length && divide.data('slider') && total) {
                    var tot = parseInt(total/(parseInt(target.prop("value").toString()) || 0));
                    if(divide.slider("value") > tot)
                        divide.slider("value",tot);
                    var v=divide.slider("value");
                    divide.slider("option", "max",tot);

                    divide.slider("value",v);
                }

                if(typeof update_metered_totals === 'function') {
                    update_metered_totals();
                }
            };

            var update_slider = function() {
                slider.slider("value", parseInt(target.prop("value").toString()) || 0);

            };

            slider.bind("slidestart", function() {
                slider.interval = setInterval(update_target, 200);
                update_target();
            });

            slider.bind("slidestop", function() {
                clearInterval(slider.interval);
                slider.interval = null;
            });

            slider.bind("slidechange", function() {
                if (target.interval == null) update_target();
            });

            target.bind("focusin", function() {
                target.interval = setInterval(update_slider, 300);
            });

            target.bind("focusout", function() {
                target.prop("value", parseInt(slider.slider("value").toString()) || 0);
                clearInterval(target.interval);
                target.interval = null;
            });

            update_slider();
        }
    });
});

_defaultFunction('filtertemplates',function (place) {
    var family = $('#virtual_machine_operating_system').val();
    var distro = $('#virtual_machine_operating_system_distro').val();
    if (place == 'family') {
        $('#virtual_machine_operating_system_distro option').remove();
        $('#virtual_machine_operating_system_distro').selectedIndex = 0;
        distro = distributions[family][0];
        for (var i = 0; i < distributions[family].length; i++) {
            $('#virtual_machine_operating_system_distro').append('<option value="' + distributions[family][i] + '">' + ucfirst(distributions[family][i]) + '</option>');
        }
    }
    $('#virtual_machine_template_id option').remove();
    //loadostemplates
    for (var i = 0; i < ostemplates.length; i++) {
        if (ostemplates[i].family == family && ostemplates[i].distro == distro) {
            $('#virtual_machine_template_id').append('<option value="' + ostemplates[i].id + '">' + ostemplates[i].name + '</option>');
        }
    }
    $('#virtual_machine_template_id').selectedIndex = 0;
    $('#virtual_machine_template_id').change();
    swapcheck($('#virtual_machine_template_id').val());
});

_defaultFunction('ucfirst', function (str) {
    str += '';
    var f = str.charAt(0).toUpperCase();
    return f + str.substr(1);
});

_defaultFunction('swapcheck',function (id) {
    if (!$('#swap-row').length)
        return;
    if (windows.length && windows[id]) {
        $('#swap-row').slideUp();
        $('#disk-row .slider').slider("option", "max", $('#disk-row .slider').slider("option", "max") + 1);
        $('#swap-row .slider').slider("option", "min", 0).slider("value", 0);
        $('#virtual_machine_swap_disk_size').val(0);
    } else if (!$('#swap-row').is(':visible')) {
        $('#swap-row').show();
        $('#swap-row .slider').slider("option", "min", 1).slider("value", 1);

        $('#disk-row .slider').slider("option", "max", $('#disk-row .slider').slider("option", "max") - 1);
        $('#virtual_machine_swap_disk_size').val(1);
    }
});

_defaultFunction('togglepwd', function () {
    var input = $('input[name="CreateVM[initial_root_password]"]'),
        toggle =  $('.vm-password-mask .icon');

    toggle.toggleClass('icon-eye-open icon-eye-close fa-eye fa-eye-slash');
    toggle.prop('title', toggle.is('.icon-eye-open') ? toggle.data('show') : toggle.data('hide'));
    input.prop('type', toggle.is('.icon-eye-open') ? 'password' : 'text');
    return false;
});