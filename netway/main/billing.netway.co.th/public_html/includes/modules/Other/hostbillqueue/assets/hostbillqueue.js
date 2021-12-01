$(document).ready(function () {

    var msg = [
        "",
        " task is scheduled for this ",
        " task is running for this ",
        " task has failed for this  ",
        " task has finished for this "
    ];
    if (typeof Messenger.hbtype == 'undefined') {
        return;
    }

    $.getJSON('?cmd=hostbillqueue&action=getjob', {type: Messenger.hbtype, id: Messenger.hbid}, function (data) {
        if (data.token) {
            var description = data.human_description || data.description;
            message = Messenger().post({
                message: description + msg[data.status] + data.type,
                type: "info",
                hideAfter: false
            });
            message.task = data;
            updateTaskStatus(message);

        }
    });

    function updateTaskStatus(message) {
        var task = message.task,
            description = task.human_description || task.description,
            progress = $('<div class="progress" id="progress-queue" style="margin-top: 15px;">\n' +
                '            <svg width="1" height="28" viewBox="0 0 2 28">\n' +
                '                <text class="msg" text-anchor="middle" alignment-baseline="middle" x="0" y="14"></text>\n' +
                '            </svg>\n' +
                '            <div class="progress-bar progress-bar-striped active" role="progressbar" style="width:0;">\n' +
                '                <svg width="1" height="28" viewBox="0 0 2 28">\n' +
                '                    <text class="msg" text-anchor="middle" alignment-baseline="middle" x="0" y="14"></text>\n' +
                '                </svg>\n' +
                '            </div>\n' +
                '        </div>');

        $.getJSON('?cmd=queue&action=getjobstatus', {token: task.token}, function (data) {
            var retry = false;
            if (data.status) {
                switch (data.status) {
                    case '-1':
                        message.update({
                            type: "error",
                            message: "Job not found",
                            showCloseButton: true
                        });
                        break;
                    case '1':
                    case '2':
                        var pr = message.$el.find('.messenger-message .progress-bar');
                        var prIsset = pr.length;
                        if (prIsset) {
                            var width = pr.width();
                            var parentWidth = pr.offsetParent().width();
                            var w = Math.round(100 * width / parentWidth);
                        }
                        message.update({
                            message: description + msg[data.status] + task.type,
                            type: "info",
                        });
                        message.$el.find('.messenger-message').append(progress);
                        if (prIsset) {
                            progress.find(".progress-bar").css({width: w + '%'});
                            if (w < 80) {
                                progress.find(".progress-bar").css({transition: "none"}).animate({
                                    width: w + 10 + '%'
                                }, 5000);
                            } else {
                                progress.find(".progress-bar").css({width: "80%"});
                            }
                        } else {
                            progress.find(".progress-bar").css({transition: "none"}).animate({
                                width: '10%'
                            }, 5000);
                        }
                        retry = true;
                        break;
                    case '3':
                        message.update({
                            message: description + msg[data.status] + task.type,
                            type: "error",
                            showCloseButton: true
                        });
                        break;
                    case '4':
                        message.update({
                            message: description + msg[data.status] + task.type,
                            type: "success",
                            showCloseButton: true
                        });
                        Messenger().post({
                            message: "Some data may have changed, it is advised to <b>reload this page</b> before making any changes.",
                            type: "info",
                            hideAfter: false,
                            actions: {
                                cancel: {
                                    label: "Reload this page",
                                    action: function () {
                                        if(window.location.search.indexOf('&popstatus=1') < 0){
                                            window.location.search = window.location.search + '&popstatus=1'
                                        } else{
                                            window.location.reload();
                                        }
                                    }

                                }
                            }
                        });
                        break;

                }

            }
            if (retry) {
                window.setTimeout(function () {
                    updateTaskStatus(message);
                }, 2000);
            }
        });

    }


});