<div class="ticket-widget-btn" id="makeinternal">
    <a class="btn btn-default {$btnclass} {if $isinternal}btn-success{/if}" href="#makeinternal" >Make internal</a>
    <input type="hidden" id="isinternal" name="isinternal" value="{if $isinternal}1{else}0{/if}"/>

</div>
{literal}
<script>
    $('#makeinternal a').on('click', function () {
        var self = $(this);
        var ajax = {/literal}{if $ajax}true{else}false{/if}{literal};

        function handle(result) {
            if(ajax && result!=$('#isinternal').val()) {
                ajax_update('?cmd=tickets&action=menubutton',{
                    make:'toggleflag',
                    flag:16,
                    ticket_number:$('#ticket_number').val()
                });
            }

            if (!result) {
                $('#isinternal').val(0);
                self.removeClass('btn-success');

                return;
            }
            $('#isinternal').val(1);
            self.addClass('btn-success');
        }

        bootbox.dialog({
            title: 'Make internal',
            message: 'Internal ticket <strong>will not</strong> be available or sent to assigned customer. You can use it to collaborate with other staff members. Internal flag can be removed by staff at any given point',
            buttons: {
                cancel: {
                    label: '<i class="fa fa-unlock"></i> Disable',
                    className: 'btn-default',
                    callback: function (e) {
                        handle(0)
                    }
                },
                confirm: {
                    label: '<i class="fa fa-lock"></i> Enable',
                    className: 'btn-primary',
                    callback: function (e) {
                        handle(1)
                    }
                },
            },
        })
    });

</script>
{/literal}