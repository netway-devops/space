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
        var task = message.task
            description = task.human_description || task.description;

        $.getJSON('?cmd=hostbillqueue&action=getjobstatus', {token: task.token}, function (data) {
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
                        message.update({
                            message: description + msg[data.status] + task.type,
                            type: "info"
                        });
                        retry = true;
                        break;
                    case '2':
                        message.update({
                            message: description + msg[data.status] + task.type,
                            type: "info"
                        });
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
                        messg = Messenger().post({
                            message: "Some data may have changed, it is advised to <b>reload this page</b> before making any changes.",
                            type: "info",
                            hideAfter: false,
                            actions: {
                                cancel: {
                                    label: "Reload this page",
                                    action: function () {
                                        window.location = window.location.href + '&popstatus=1';
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