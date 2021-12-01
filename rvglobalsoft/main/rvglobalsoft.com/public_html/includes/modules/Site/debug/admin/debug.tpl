{literal}
    <script src="templates/default/js/json-formatter.js"></script>
    <script src="templates/default/hbchat/media/soundmanager2-nodebug-jsmin.js"></script>

    <script type="text/javascript">
        $(function () {
            var level, tick, history, log, follow, pause, view_id, filter, filterMode, filterRegx, hasErrors;
            filter = $('#filter');
            level = $('#level');
            tick = $('#tick');

            view_id = Date.now();
            log = document.getElementById('debuglogs');

            follow = true;
            pause = false;
            hasErrors = false;
            history = [];

            soundManager.url ="templates/default/hbchat/media/swf/";
            soundManager.flashVersion = 9;
            soundManager.onready(function() {

                soundManager.createSound({
                    id:'newmsg',
                    url:"templates/default/hbchat/media/newchat.mp3"
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
                ctx.fillText(len, canvas.width/2, canvas.height/2, 15);

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
                log.appendChild(e);

                if (record.context && (!Array.isArray(record.context) || record.context.length)) {
                    var formatter = new JSONFormatter(record.context, 0, {hoverPreviewEnabled: true});
                    e.appendChild(formatter.render())
                }

                record.node = e;

                filterRegx.lastIndex = 0;
                record.filteredOut = filterMode === filterRegx.test(record.message);

                if(record.filteredOut){
                    e.classList.add("filer-out");
                    return;
                }

                if (follow)
                    log.scrollTop = log.scrollHeight;

                if(record.level_name === 'ERROR') {
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
                })
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
                    file = new File([text], {type:'text/plain'});
                    
                pom.setAttribute('href', window.URL.createObjectURL(file));
                pom.setAttribute('download', 'debug' + Date.now() + '.log');

                if (document.createEvent) {
                    var event = document.createEvent('MouseEvents');
                    event.initEvent('click', true, true);
                    pom.dispatchEvent(event);
                } else {
                    pom.click();
                }
            });

            filter.on('init keyup', function () {
                try {
                    let source = filter.val();
                    filterMode = source.indexOf('!') === 0;
                    filterRegx = new RegExp(source.replace(/^!/, ''), 'gi');
                }catch (e) {
                    console.warn(e.message.replace('Invalid regular expression: ', ''));
                    return;
                }

                for(let record of history){
                    filterRegx.lastIndex = 0;
                    let filterOut = filterMode === filterRegx.test(record.message);

                    if(record.filteredOut !== filterOut){
                        record.node.classList.toggle("filer-out", filterOut);
                        record.filteredOut = filterOut;
                    }
                }
            }).trigger('init');
        })
    </script>  
    <style>

        #logs-fixed{
            position: fixed;
            top: 80px;
            left: 0;
            width: 100%;
            bottom: 0;
            padding: 10px;
        }
        #logs-fixed .content{
            height: 80px;
            padding: 10px 0;
        }
        #debuglogs{
            height: calc(100% - 100px);
            width: 100%;
            font-family: monospace;
            overflow: scroll;
        }
        .log{
            padding: 4px 6px;
            border-top: 1px solid #d8d8d8;
        }
        .log:nth-child(2n){
            background: #eee;
        }
        .log-date{
            color: #888
        }
        .log-trace,
        .log-context{
            display: block;
            white-space: pre-wrap;
        }
        .label-DEBUG{
            background: #4e79f5;
        }
        .label-INFO{
            background: #00bcd4;
        }
        .label-WARNING{
            background: orange;
        }
        .label-ERROR{
            background: red;
        }
        .log .json-formatter-row .json-formatter-toggler:after{
            font-family: sans-serif;
            font-size: 10px
        }
        .log .json-formatter-row .json-formatter-string{
            white-space: pre-wrap;
        }
        .log .json-formatter-row{
            position: relative;
        }
        .log .json-formatter-row > a > .json-formatter-preview-text{
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            position: absolute;
        }
        .filer-out{
            display: none;
        }
    </style>
{/literal}
<div id="logs-fixed">
    <h1><div>Debugging page</div></h1>
    <div class="content">
        <div class="pull-right col-md-3">
            <input  class="form-control" id="filter" type="text" placeholder="Filter logs ...">
        </div>
        <div class="btn-group">
            <a href="#clear" class="btn btn-default" id="clear-logs">Clear</a>
            <a href="#pause" class="btn btn-default" id="pause-logs">Pause</a>
            <a href="#folow" class="btn btn-default active" id="follow-logs">Follow</a>
        </div>
        <a href="#Export" class="btn btn-default" id="hook-export">Export Log</a>
        <a href="#Hooks" class="btn btn-default" id="hook-logs">Hooks</a>
        <a href="?cmd=queue" class="btn btn-default">Queue</a>
        <a href="?cmd=root&action=phpinfo" class="btn btn-default" target="_blank">PHPInfo</a>
    </div>
    <div id="debuglogs"></div>
</div>


