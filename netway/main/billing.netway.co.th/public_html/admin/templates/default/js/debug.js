$(function () {
    var level, tick, history, log, follow, pause, view_id, filter, filterTest, hasErrors;

    filter = $('#filter');
    level = $('#level');
    tick = $('#tick');

    view_id = Date.now();
    log = document.getElementById('debuglogs');

    follow = true;
    pause = false;
    hasErrors = false;
    history = [];
    filterTest = function(){return false;}

    soundManager.url = "templates/default/hbchat/media/swf/";
    soundManager.flashVersion = 9;
    soundManager.onready(function () {

        soundManager.createSound({
            id: 'newmsg',
            url: "templates/default/hbchat/media/newchat.mp3"
        });
    });

    function changeFavicon(src) {
        var link = document.querySelector("link[rel*='icon']") || document.createElement('link');
        link.type = 'image/x-icon';
        link.rel = 'shortcut icon';
        link.href = src;
        document.getElementsByTagName('head')[0].appendChild(link);
    }

    function generatefav() {
        var canvas = document.createElement('canvas');
        canvas.width = 16;
        canvas.height = 16;

        var ctx = canvas.getContext('2d');
        ctx.fillStyle = pause ? "#FD0" : (hasErrors ? "#F00" : "#EEE");
        ctx.fillRect(0, 0, 16, 16);

        ctx.fillStyle = hasErrors ? "#FFF" : "#000";
        ctx.font = 'bold 11px sans-serif';
        ctx.textBaseline = 'middle';
        ctx.textAlign = "center";
        var len = history.length,
            w = ctx.measureText(len).width;
        ctx.fillText(len, canvas.width / 2, canvas.height / 2, 15);

        changeFavicon(canvas.toDataURL("image/x-icon"))
    }


    function htmllog(record) {
        console.log(record);
        history.push(record);

        var html = '<span class="label label-' + record.level_name + '">' + record.level_name + '</span>\
                        <span class="log-date">' + record.datetime.date + '</span>\
                        <span class="log-msg">' + record.message + '</span>';

        if (record.trace)
            html += '<span class="log-trace">' + record.trace + '</span>';

        var e = document.createElement('div');
        e.className = 'log';
        e.innerHTML = html;
        e.tabIndex = -1;
        log.appendChild(e);

        if (record.context && (!Array.isArray(record.context) || record.context.length)) {
            var formatter = new JSONFormatter(record.context, 0, {hoverPreviewEnabled: true});
            e.appendChild(formatter.render())
        }

        record.node = e;
        record.filteredOut = filterTest(record);

        if (record.filteredOut) {
            e.classList.add("filer-out");
            return;
        }

        if (follow)
            log.scrollTop = log.scrollHeight;

        if (record.level_name === 'ERROR') {
            soundManager.getSoundById('newmsg').play()
            hasErrors = true;
        }
    }

    function pull() {
        if (pause)
            return setTimeout(pull, 1000);

        tick.attr('class', 'load');
        $('#taskMGR').taskQuickLoadShow();

        $.post('?cmd=debug&action=pull&lightweight=1', {
            level: level.val(),
            viewid: view_id
        }).done(function (data) {
            $('#taskMGR').taskQuickLoadHide();
            for (let logs of Object.values(data)) {
                for (let log of logs) {
                    htmllog(log)
                }
            }
            generatefav();
            setTimeout(pull, data.length ? 1000 : 5000)
        }).fail(function () {
            $('#taskMGR').taskQuickLoadHide();
            setTimeout(function () {
                tick.removeClass('load err');
            }, 1000);
            tick.addClass('err');
            setTimeout(pull, 5000)
        })
    }

    pull();

    $('#clear-logs').on('click', function () {
        while (log.firstChild) {
            log.removeChild(log.firstChild);
        }

        history = [];
        hasErrors = false;
        generatefav();
        return false;
    });

    $('#pause-logs').on('click', function () {
        var self = $(this);
        pause = !pause;
        self.toggleClass('active', pause);
        generatefav();
        return false;
    });

    $('#follow-logs').on('click', function () {
        var self = $(this);
        follow = !follow;
        self.toggleClass('active', follow);
        return false;
    });

    $('#hook-logs').on('click', function () {
        var dialog = bootbox.dialog({
            message: '<div class="text-center"><i class="fa fa-spin fa-spinner"></i> Loading...</div>',
            onEscape: true,
            backdrop: true
        });
        $.get('?cmd=debug&action=hooks&lightweight=1', function (data) {
            var body = $('.modal-body', dialog),
                formatter = new JSONFormatter(data, 1, {hoverPreviewEnabled: true});
            body.find('.text-center').remove();
            body[0].appendChild(formatter.render())
        });
        return false;
    });
    $('#search_hooks').bootboxform({
        formaction: '',
        callback: function (e, ele) {

            var val = $('input[name=hookname]', this).val(),
                dialog = this;

            $.get('?cmd=debug&action=modulehooks&lightweight=1&searchterm='+val, function (data) {
                var body = $('.modal-body .s-results', dialog),
                    formatter = new JSONFormatter(data, 1, {hoverPreviewEnabled: true});
                body.html(formatter.render())
            });
            return false;
        }
    });
    $('#module-hooks').on('click', function () {
        $('#search_hooks').trigger('show');
        return false;
    });


    $('#hook-export').on('click', function () {
        var text = '';
        for (var i = 0, l = history.length; i < l; i++) {
            var record = history[i];
            text += record.datetime.date + "\t" + record.level_name + "\t" + record.message.replace(/&amp;/g, '&').replace(/&lt;/g, '<').replace(/&gt;/g, '>');

            if (record.trace)
                text += "\n  " + record.trace.replace(/\n/g, "\n  ");

            if (record.context && (!Array.isArray(record.context) || record.context.length)) {
                text += "\n  " + JSON.stringify(record.context, undefined, 2).replace(/\n/g, "\n  ");
            }
            text += "\n";
        }

        var pom = document.createElement('a'),
            file = new File([text], {type: 'text/plain'});

        pom.setAttribute('href', window.URL.createObjectURL(file));
        pom.setAttribute('download', 'debug' + Date.now() + '.log');

        if (document.createEvent) {
            var event = document.createEvent('MouseEvents');
            event.initEvent('click', true, true);
            pom.dispatchEvent(event);
        } else {
            pom.click();
        }
        return false;
    });

    filter.on('init keyup', function () {
        try {
            let source = filter.val();
            if (!source.length) {
                filterTest = function (record) {
                    return false;
                }
            } else if (source.indexOf('$.') === 0) {
                filterTest = function (record) {
                    try {
                        return source.length > 2 && jsonpath.query(record.context, source, 1).length === 0;
                    } catch (e){
                        console.error('JsonPath error:', e)
                        return false;
                    }
                }
            } else {
                let filterMode = source.indexOf('!') === 0;
                let filterRegx = new RegExp(source.replace(/^!/, ''), 'gi');

                filterTest = function (record) {
                    filterRegx.lastIndex = 0;
                    return filterMode === filterRegx.test(record.message)
                }
            }

        } catch (e) {
            console.warn(e.message.replace('Invalid regular expression: ', ''));
            return;
        }

        for (let record of history) {

            let filterOut = filterTest(record);

            if (record.filteredOut !== filterOut) {
                record.node.classList.toggle("filer-out", filterOut);
                record.filteredOut = filterOut;
            }
        }
    }).trigger('init');

    var log_cursor = null;
    var log_section;

    function toggleDataView(state){
        if(!log_cursor){
            return false;
        }

        let target = log_cursor.classList.contains('json-formatter-row')
            && log_cursor || log_cursor.querySelector('.json-formatter-row');

        let isOpen = target.classList.contains('json-formatter-open');
        let toggle = target.querySelector('.json-formatter-toggler-link');

        if(state === undefined){
            state = !isOpen;
        }

        if(!toggle){
            return false;
        }

        if(isOpen !== state){
            toggle.click();
        }
        return isOpen !== state;
    }

    $(document).on('click', '.json-formatter-children > .json-formatter-row, #debuglogs > .log', function (e) {
        e.stopPropagation();
        log_cursor = this;
        log_section = this.parentElement;
        return false;
    });

    $(document).on('keydown', function (e) {
        if (!log_section) {
            log_section = log;
        }

        switch (e.keyCode) {
            case 38: //arrowUp
                if (!log_cursor) {
                    log_cursor = log_section.lastElementChild;
                } else if (log_cursor.previousElementSibling) {
                    log_cursor = log_cursor.previousElementSibling;
                } else {
                    log_cursor = log_section.firstElementChild;
                }
                break;
            case 40: //arrowDown
                if (!log_cursor) {
                    log_cursor = log_section.firstElementChild;
                } else if (log_cursor.nextElementSibling) {
                    log_cursor = log_cursor.nextElementSibling;
                } else {
                    log_cursor = log_section.lastElementChild;
                }
                break;
            case 39: //arrowRight
                if (!log_cursor) {
                    return;
                }

                if(toggleDataView(true)){
                    return false;
                }

                let subrow = log_cursor.querySelector('.json-formatter-children .json-formatter-row');
                if (subrow) {
                    log_cursor = subrow;
                    log_section = subrow.parentElement;
                }
                break;
            case 37: //arrowLeft
                if (!log_cursor) {
                    return;
                }

                if(toggleDataView(false)){
                    return false;
                }

                if(log_section === log){
                    return;
                }

                log_cursor = log_section.closest('.json-formatter-row');
                log_section = log_cursor.parentElement;

                break;
            case 13: //enter
                if(toggleDataView()){
                    return false;
                }
                break;
            case 67: //cC
                if(e.ctrlKey){
                    if(window.getSelection().toString()){
                        return;
                    }
                    let value = log_cursor.querySelector(
                        '.json-formatter-string, .json-formatter-number, .json-formatter-boolean'
                    );
                    if(value){
                        navigator.clipboard.writeText(value.textContent);
                    }
                } else{
                    return true;
                }
                break;
            default:
                console.log(e.keyCode, e);
                return;
        }

        if (log_cursor) {
            log_cursor.focus();
        }
        return false;
    });
});