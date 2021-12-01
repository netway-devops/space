<i class="slbd">{if $service.label} - {/if}</i><i class="slb">{$service.label}</i><i class="slbe" data-placeholder="Label" data-id="{$service.id}"> {$lang.editlabel}</i>{once}
    {literal}
    <script type="text/javascript">
        if (typeof $.fn.caret != 'function') {
            var caret = document.createElement('script');
            caret.setAttribute('src', '{/literal}{$template_dir}../common/js/jquery.caret.js{literal}');
                    document.head.appendChild(caret);
                }

            $(function() {
                var body = $('body'),
                    bodyoff = parseInt(body.css('border-top-width').replace(/[^\d].*$/,'')) 
                        + parseInt(body.css('padding-top').replace(/[^\d].*$/,'')) 
                        + parseInt(body.css('padding-top').replace(/[^\d].*$/,''));

                $(document).on('click', '.slbe', function() {
                    var self = $(this),
                        label = self.prev(),
                        slbd = label.prev(),
                        ctl = self.add(label).css('visibility', 'hidden'),
                        lab = label.text();


                    self.add(label).css('visibility', 'hidden');
                    self.parents('a').eq(0).bind('click.slb', function(e) {
                        e.preventDefault();
                        self.parents('a').eq(0).unbind('.slb');
                    });

                    lab = !lab.length ? self.data('placeholder') + ' ' + ($('i.slb').filter(function() {
                        return $(this).text().length
                    }).length + 1) : lab;
                    label.text(lab);
                    slbd.text(' - ');

                    var off = label.offset(),
                        input = $('<input type="text" class="slbi" />').val(lab)
                        .appendTo('body').css({
                        color: label.css('color'),
                        fontSize: label.css('font-size'),
                        fontStyle: label.css('font-style'),
                        fontWeight: label.css('font-weight'),
                        fontFamily: label.css('font-family'),
                        height: label.height(),
                        left: off.left,
                        top: off.top + bodyoff,
                        width: label.text(lab + 'w').width()
                    });
                    input.bind('keydown keyup blur', function(e) {
                        e.stopPropagation();
                        var val = input.val();
                        var c = input.caret();
                        if (e.keyCode == 46 || e.keyCode == 8) {
                            val = val.replace(/\s{2,}/g, ' ');
                            input.val(val);
                        } else if (val.length > 40 && e.keyCode != 37 && e.keyCode != 39)
                            return false;

                        if (e.type == 'keydown') {
                            input.data('c', c);
                            input.width(label.text(val + 'w').width());
                            if (e.keyCode != 32)
                                return true;
                            if (!val[c - 1] || val[c - 1] == ' ' || val[c] == ' ')
                                return false;
                            return true;
                        }
                        if (e.keyCode == 46 || e.keyCode == 8)
                            input.caret(input.data('c') - 1);

                        slbd.text(val.length ? ' - ' : '');

                        if (e.keyCode == 13 || e.type == 'blur') {
                            ctl.css('visibility', '');
                            label.text(val)
                            input.remove();
                            $.post('?cmd=clientarea&action=label', {id: self.data('id'), servicelabel: val})
                            return false;
                        }
                        return false;
                    }).focus().caret(-1);
                    return false;
                });
            });
    </script>
    <style>
        i.slbe{
            visibility: hidden;
            color: red;
            text-decoration: none;
            font-size: 90%
        }
        td:hover i.slbe{
            visibility: visible;
        }
        input.slbi{
            position: absolute!important;
            background: none!important;
            box-shadow: none!important;
            border: none!important;
            /* color:inherit!important;*/
            padding: 0 0 0 0!important;
            margin: 0 0 0 0!important;
            vertical-align: baseline!important;
            z-index: 500
        }
    </style>
{/literal}
{/once}