$(function () {
    var tasklog_tpl = Handlebars.compile($('#import-tasklog-item')[0].innerHTML),
        log_tpl = Handlebars.compile($('#import-log-item')[0].innerHTML);

    var main = $('#progress-queue'),
        actionbox = $('#progress-actions');
    log = $('#logs');

    var jobstat = {};
    var statusmap = [
        ['unknown', '', ''],
        ['Pending', '', 'progress-bar-striped'],
        ['', 'list-group-item-info', 'progress-bar-striped'],
        ['Failed', 'list-group-item-danger', 'progress-bar-danger'],
        ['OK', 'list-group-item-success', 'progress-bar-success'],
        ['Cancelled', 'list-group-item-warning', 'progress-bar-warning']
    ];

    var log_formatter = function () {
        },
        pollUrl = '',
        poll = true;

    if (main.data('id')) {
        pollUrl = '?cmd=queue&action=progress&id=' + main.data('id');

        log_formatter = function (data) {
            var frag = '', logjob, i, token, st_data;

            if (data === undefined || data === null || !data.hasOwnProperty('log') || data.log === null) {
                return;
            }

            for (i = 0; i < data.log.length; i++) {
                logjob = data.log[i];
                token = logjob.data.token;
                st_data = statusmap[logjob.data.status];

                logjob.statusName = st_data[0];
                logjob.class = st_data[1];

                logjob.progressClass = 'progress-bar '
                    + st_data[2]
                    + (logjob.data.status < 3 ? ' active' : '');

                if (jobstat[token] === undefined) {
                    console.log('new', token, logjob.data.percent)
                    frag = tasklog_tpl(logjob) + frag;
                }

                if (jobstat[token] !== undefined && jobstat[token] !== logjob.data.percent) {
                    $('#' + token)
                        .attr('class', 'list-group-item log-item ' + logjob.class)
                        .find('.foreground').text(logjob.body + ': ' + logjob.data.message).end()
                        .find('.progress-bar')
                        .css('width', Math.max(1, logjob.data.percent) + '%')
                        .attr('class', logjob.progressClass);
                }

                jobstat[token] = logjob.data.percent;
            }

            if (frag !== '') {
                log.prepend(frag);
            }
        }
    }

    if (main.data('token')) {
        pollUrl = '?cmd=queue&action=taskprogress&token=' + main.data('token');

        log_formatter = function (data) {
            var frag = '', logjob, i, token, st_data;

            if (data === undefined || data === null || !data.hasOwnProperty('log') || data.log === null) {
                return;
            }

            for (i = 0; i < data.log.length; i++) {
                logjob = data.log[i];
                token = logjob.data.pos;

                if (jobstat[token] === undefined) {
                    console.log('new', token, logjob.data.percent)
                    frag = log_tpl(logjob) + frag;
                }
                jobstat[token] = logjob.data.pos;
            }

            if (frag !== '') {
                log.prepend(frag);
            }
        }
    }

    if (!pollUrl) {
        throw Error('Missing job token or queue progress id');
    }

    function update() {
        $.get(pollUrl).done(function (data) {
            if (!data.hasOwnProperty('percent')) {
                return;
            }

            var width = Math.max(1, data.percent),
                progresClass = 'progress-bar '
                    + statusmap[data.status][2]
                    + (data.status < 3 ? ' active' : '');

            main.find('.progress-bar')
                .css('width', width + '%')
                .attr('class', progresClass)
                .find('svg')
                .css('clip-path', 'polygon(0% 0%, ' + width + '% 0%, ' + width + '% 100%, 0 100%)');

            main.find('.msg').text(data.message);
            poll = data.status < 3;

            log_formatter(data);

            $.each(data.actions, function (i, act) {
                if (act.type !== 'btn') {
                    return;
                }

                var btn = $('#' + act.id);
                if (btn.length) {
                    return;
                }

                actionbox.append('<a id="' + act.id + '" href="'
                    + act.url + '" class="btn btn-default">' + act.label + '</a>');

                actionbox.show()
            })

        }).always(function () {
            if (poll) {
                setTimeout(update, 300)
            }
        })
    }

    log.on('click', 'li.log-item', function () {
        var dialog = bootbox.dialog({
            title: this.dataset.title,
            backdrop: true,
            onEscape: true,
            size: 'large',
            message: '<i class="fa fa-spin fa-spinner"></i> Loading...',
        });

        $.get(this.dataset.href, function (data) {
            $('.bootbox-body', dialog).html(data);
        });
        return false;
    });

    update();
});
