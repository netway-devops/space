$(function () {
    function check() {
        setTimeout(function () {
            $('.backup-pending').each(function () {
                $.get(window.location.href, function (data) {
                    $('#updater').html(parse_response(data));
                    check();
                })
                return false;
            })
        }, 5000)
    }
    check();
})