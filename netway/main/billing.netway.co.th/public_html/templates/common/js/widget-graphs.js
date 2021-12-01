$(function () {
    var from = $('#graph-from'),
        to = $('#graph-to'),
        format = 'Y-m-d\\TH:i:S\\Z';

    function removeLoader() {
        $(this).closest('.widget-graph-image-container')
            .removeClass('loading')
    }

    $('.widget-graph-image')
        .on('load', removeLoader)
        .each(function () {
            if (this.complete && this.naturalWidth > 0) {
                console.log('complete');
                removeLoader.call(this)
            }
        });

    if (from.length) {

        var picker = from.flatpickr({
            allowInput: true,
            enableTime: true,
            dateFormat: from.data().format + " H:i",
            maxDate: new Date(),
            plugins: [new rangePlugin({input: "#graph-to"})]
        });

        $('#graph-update').on('click', function () {
            var params_rex = /([\?&])(from|to|t)=[^&]+/g,
                params = {
                    from: picker.formatDate(picker.selectedDates[0], format),
                    to: picker.formatDate(picker.selectedDates[1], format),
                    t: (new Date()).getTime()
                };

            $('.widget-graph-image').each(function () {
                var img = $(this), match = null, key,
                    url = img.attr('src'),
                    new_url = url,
                    found = [];

                while ((match = params_rex.exec(url)) !== null) {
                    found.push(match[2])
                    new_url = new_url.replace(match[0], match[1] + match[2]
                        + '=' + encodeURIComponent(params[match[2]]))
                }

                for (key in params) {
                    if (found.indexOf(key) < 0) {
                        new_url += '&' + key + '=' + encodeURIComponent(params[key]);
                    }
                }

                img.closest('.widget-graph-image-container').addClass('loading');
                img.attr('src', new_url);
            });

            return false;
        });
    }

})