$(function () {
    $('.rr-name, .rr-content').each(function () {
        var self = $(this),
            text = self.text().replace(/^\s*|\s*$/g, ''),
            unicode = punycode.toUnicode(text);

        if (text != unicode)
            self.attr('title', unicode).css({
                cursor: 'help',
                textDecoration: 'underline dotted #108BBC'
            })
    });

    $('#add_record, .add_record').change(function () {
        var self = $(this),
            link = self.next('a');
        link.attr('href', link.attr('href').replace(/type=[A-Z]+/, 'type=' + self.val()))
    }).change()
});

