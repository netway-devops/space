var Add_related_service = {
    /**
     * Default selection
     */
    defaultSelection: false,
    /**
     * Set default selection to new value
     *
     * @param default_value
     */
    setDefaultSelection: function (default_value) {
        this.defaultSelection = default_value;
    },
    /**
     * Execute adding related service selection
     */
    execute: function () {

        var defaultSelection = this.defaultSelection;

        /**
         * Add option
         *
         * @param option_text
         * @param value
         * @param $related_client_service
         */
        function add_option(option_text, value, $related_client_service) {
            var option = new Option(option_text, value);
            $(option).html(option_text);
            $related_client_service.append(option);
        }

        var $ticket_message = $(document.getElementById('ticketmessage'));

        $ticket_message.after(
            '<div>' +
            _trcslang.relatedservice + ': ' +
            '<select id="related_client_service" name="related_client_service">' +
            '</select>' +
            '</div>'
            );

        var $related_client_service = $(document.getElementById('related_client_service'));

        add_option(_trcslang.none, 0, $related_client_service);

        $.getJSON('?cmd=ticket_related_client_service', function (response) {
            var len = response.length;

            for (var i = 0; i < len; ++i) {
                var related = response[i];
                add_option(related.name, related.id, $related_client_service);
            }

            if (defaultSelection) {
                $('#related_client_service').val(defaultSelection);
            }
        });
    }
}
