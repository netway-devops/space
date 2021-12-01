(function ($) {

    /**
     * Generate opion text
     * @param 	related
     * @returns {string}
     */
    function generate_option_text(related) {

        // shared hosting - hosting A - domain.com
        var option_text = related.cat_name + ' - ' + related.prod_name;

        if (related.domain) {
            option_text += ' - ' + related.domain;
        }

        return option_text;
    }

    // save original bindTicketEvents
    var org_bindTicketEvents = window.bindTicketEvents;

    // proxy for bindTicketEvents in order to bind to that event
    window.bindTicketEvents = function () {

        // call original
        org_bindTicketEvents();

        var $tagsCont = $(document.getElementById('tagsCont'));

        // check if this is ticket view
        if ($tagsCont.length) {

            var ticket_id = $(document.getElementById('ticket_id')).val();
            var url = '?cmd=ticket_related_client_service&ticket_id=' + ticket_id;

            $.getJSON(url, function (related) {
                if (related && related.id) {
                    var link_url;

                    if (related.type == 'domain') {
                        link_url = '?cmd=domains&action=edit&id=' + related.id;

                    } else {
                        link_url = '?cmd=accounts&action=edit&id=' + related.id;
                    }

                    $tagsCont.after(
                        '<a href="' + link_url + '" id="ticket_related_service" target="_blank" style="display: block; margin: 10px 0 10px 0; font-weight:bold;">\
                         Related ' + related.type + ': ' + related.name + '</a>'
                        );
                }
            });

        }

    };

})(jQuery); // end IIFE wrapper