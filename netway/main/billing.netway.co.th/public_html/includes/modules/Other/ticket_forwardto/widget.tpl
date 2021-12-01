                        
<div class="ticket-widget-btn" id="forwardto">
    <a class="btn btn-default" href="#forwardto" >Forward Reply</a>

    <div class="modal-forms" style="display: none">
        <p>Enter email addresses where you want to send this reply. Addresses provided here will owerwrite ticket settings just for this message.</p>
        {if $predefined}
            <div class="form-group" >
                <label for="forawrd_to">To address</label>
                <select name="forawrd_to" class="form-control">
                    <option value="">Enter custom address</option>
                    {foreach from=$predefined item=addr}
                        <option value="{$addr}">{$addr}</option>
                    {/foreach}
                </select>
            </div>
            <div class="form-group" id="forawrdinput" >
                <input type="text" name="forawrd_to" class="form-control" id="forawrd_to" placeholder="joe@example.com">
            </div>
        {else}
            <div class="form-group" >
                <label for="forawrd_to">To address</label>
                <input type="text" name="forawrd_to"  class="form-control" id="forawrd_to" placeholder="joe@example.com">
            </div>
        {/if}

        <div class="form-group">
            <label for="forawrd_cc">CC address</label>
            <textarea type="text" name="forawrd_cc"  class="form-control" id="forawrd_cc" placeholder="joe@example.com, mike@example.com"></textarea>
        </div>
        <div class="form-group" >
            <label for="forawrd_bcc">BCC address</label>
            <textarea type="text" name="forawrd_bcc"  class="form-control" id="forawrd_bcc" placeholder="joe@example.com, mike@example.com"></textarea>
        </div>
    </div>
</div>

{literal}
    <script>

        $('#forwardto a').on('click', function () {
            var self = $(this),
                modalBody = $('#forwardto .modal-forms');

            function handle(result) {
                self.find('span').remove();
                if (!result) {
                    self.removeClass('btn-success')
                    return modalBody.find('input, textarea').val('');
                }
                var list = [];
                result.find('input, textarea, select').each(function () {
                    var self = $(this);
                    if (self.is(':disabled'))
                        return;
                    
                    var val = self.val().split(/[, ;]/).map(function (e) {
                        var l = e.replace(/^\s+|\s+$/g, '');
                        if (l.length && list.indexOf(l) == -1)
                            list.push(l)
                    });
                })

                if (!list.length) {
                    return handle(false);
                }

                list = list.join(', ');
                var slist = list;
                if (list.length > 40)
                    slist = list.substr(0, 38) + '...';

                modalBody.replaceWith(result.hide())
                console.log(result.find('select')[0])
                self.addClass('btn-success')
                    .append('<span> to <em title="' + list + '">' + slist + '</em></span>');
            }

            bootbox.dialog({
                title: 'Forward Reply',
                message: modalBody.clone().show(),
                buttons: {
                    cancel: {
                        label: 'Cancel',
                        className: 'btn-default',
                        callback: function (e) {
                            handle(false)
                        }
                    },
                    confirm: {
                        label: 'OK',
                        className: 'btn-primary',
                        callback: function (e) {
                            handle($(this).find('.modal-body'))
                        }
                    },
                },
            }).on('shown.bs.modal', function () {
                var modal = this,
                    predefined = $('select', modal);

                predefined.on('change', function () {

                    var box = $('#forawrdinput', modal),
                        input = box.find('input'),
                        value = predefined.val(),
                        visible = value == '';

                    predefined.children()
                        .removeAttr('selected')
                        .filter('[value="' + value + '"]')
                        .attr('selected', 'selected')
                        .prop('selected', true);

                    input.prop('disabled', !visible)
                    if (box.is(':visible') != visible)
                        box.slideToggle(200)

                    if (visible)
                        input.focus();
                });
            })
        });


    </script>
{/literal}