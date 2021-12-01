function getRecordContentValues() {
    var values = [];
    $('input, textarea, select', '#contentbox').each(function () {
        var index = (this.name.match(/content\[(\d+)\]/) || ['', '0'])[1]
        values[parseInt(index)] = $(this).val();
    });
    return values;
}

function getRecordContentHtml(type) {
    var values = getRecordContentValues(),
        typedef = [];

    if (types[type] !== undefined) {
        typedef = types[type];
    } else {
        typedef = [{
            label: '',
            description: '',
            required: true,
            placeholder: '',
            pattern: '',
            type: 'text'
        }]
    }

    function quote(s, regex) {
        regex = regex || false;
        return ('' + s)
            .replace(/&/g, regex ? '\\x26' : '&amp;')
            .replace(/'/g, regex ? '\\x27' : '&apos;')
            .replace(/"/g, regex ? '\\x22' : '&quot;')
            .replace(/</g, regex ? '\\x3c' : '&lt;')
            .replace(/>/g, regex ? '\\x3e' : '&gt;');
    }

    function attr(index, list) {
        list = list || [];
        var attrs = ['name="content[' + index + ']"'], key;
        for ( key in typedef[index]) {
            if (list.indexOf(key) > -1) {
                attrs.push(key + '="' + quote(typedef[index][key], key === 'pattern') + '"');
            }
        }
        return attrs.join(' ');
    }

    function value(index, quoteStr) {
        if (values[index] === undefined)
            return '';

        quoteStr = quoteStr === undefined ? true : quoteStr;
        return quoteStr ? quote(values[index]) : values[index];
    }

    function options(index) {
        var html = '';
        $.each(typedef.options, function (key, val) {
            var selected = val.value === value(index) ? 'selected' : '';
            html += '<option value="' + quote(val.value) + '" ' + selected + '>'
                + quote(val.label)
                + '</option>'
        });
    }

    var i, html, rr, list = [];
    for (i = 0; i < typedef.length; i++) {
        rr = typedef[i];
        html = '<div class="content-input">';

        if (rr.type === 'select') {
            html += '<select class="styled" '
                + attr(i) + '>' + options(i) + '</select>';
        } else if (rr.type === 'textarea') {
            html += '<textarea class="styled" '
                + attr(i, ['placeholder', 'required'])
                + ' >' + value(i, false) + '</textarea>';
        } else {
            html += '<input type="' + rr.type + '" '
                + attr(i, ['placeholder', 'required'])
                + ' class="styled" value="' + value(i) + '" /> ';
        }

        html += quote(rr.label);
        if (rr.description) {
            html += '<a class="vtip_description" title="' + quote(rr.description) + '"></a>';
        }

        html += '</div>';
        list.push(html);
    }
    return list.join('');
}