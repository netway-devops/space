{literal}
    <script type="text/javascript">
        $(function () {
            $(document).on('input update', '.textarea-overlay-control textarea', function (e) {
                var self = $(this),
                    value = self.val(),
                    data = self.data();
                if (typeof data.initial === 'undefined') {
                    data.initial = value;
                }

                if (data.initial != value && !data.savebtn) {
                    data.savebtn = $('<a href="#" class="btn-overlay">Save</a>');
                    data.savebtn.on('click', function () {
                        var note = self.val();
                        data.initial = note;
                        self.prop('disabled', true).trigger('update');
                        $.post(window.location.href, {
                            id: data.id,
                            make: 'update',
                            note: note
                        }, function (data) {
                            parse_response(data);
                            self.prop('disabled', false);
                        })
                        return false;
                    })
                    self.before(data.savebtn)
                } else if (data.initial == value && data.savebtn) {
                    data.savebtn.remove();
                    data.savebtn = false;
                }
            }).find('textarea').trigger('update');
        })
    </script>
{/literal}
<a href="?cmd={$cmd}&action={$action}" id="currentlist" style="display:none"></a>
<table width="100%" cellspacing="0" cellpadding="3" border="0" style="" class="table glike">
    <tbody>
        <tr>
            <th><a href="?cmd={$cmd}&action={$action}&orderby=id|ASC" class="sortorder">Date</a></th>
            <th><a href="?cmd={$cmd}&action={$action}&orderby=aff_id|ASC" class="sortorder">Affiliate</a></th>
            <th>Address</th>
            <th><a href="?cmd={$cmd}&action={$action}&orderby=total|ASC" class="sortorder">{$lang.Amount}</a></th>
            <th style="width: 80px;"><a href="?cmd={$cmd}&action={$action}&orderby=paid|ASC" class="sortorder">Notes</a></th>
            <th style="width: 80px;"></th>
        </tr> 
    </tbody>

    <tbody id="updater">
        {include file='ajax.affiliates.tpl'}
    </tbody>

    <tbody id="psummary">
        <tr>

            <th colspan="9">
                {$lang.showing} <span id="sorterlow">{$sorterlow}</span> - <span id="sorterhigh">{$sorterhigh}</span> {$lang.of} <span id="sorterrecords">{$sorterrecords}</span>
            </th>
        </tr>
    </tbody>
</table> 