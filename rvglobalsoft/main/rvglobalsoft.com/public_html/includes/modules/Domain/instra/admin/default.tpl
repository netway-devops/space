<div>
    <div class="panel-heading">
        <div class="row">
            <div class="col-sm-6">
                <h3>Self-Assessment and Statement of Compliance</h3>
                <p><i>After creating the domain, please wait for it to be activated</i></p>
            </div>
            <div class="col-sm-1 text-right" style="margin-top: 7px">
                <span><strong>Domain:</strong></span>
            </div>
            <div class="col-sm-2">
                <input id="ote_domain" class="form-control" type="text">
            </div>
            <div class="col-sm-2 right">
                <button class="right btn btn-success btn-sm verification">Verification</button>
            </div>
        </div>

    </div>
        <table width="100%" cellspacing="0" cellpadding="3" border="0" class="table glike">
            <thead>
            <tr class="frow_">
                <th class="col-md-1" style="padding-left: 15px;"><label>Section No.</label></th>
                <th class="col-md-3"><label>Assessment Point</label></th>
                <th class="col-sm-8"><label>Compliance Status</label></th>
            </tr>
            </thead>
            <tbody>
            {foreach from=$methods item=method key=id}
                {if $id == '2.4.2'}
                    {assign var='wait' value='_wait'}
                {/if}
                <tr>
                    <td style="padding-left: 15px;"><label>{$id}</label></td>
                    <td><label>{$method}</label></td>
                    <td class="verify">
                        <button class="unverified{$wait} btn btn-default btn-sm" data-id="{$id}" onclick="validate(this,'{$id}')">Unverified</button>
                    </td>
                </tr>
            {/foreach}
            </tbody>
        </table>
</div>
{literal}
<script>
    $('.verification').on('click', function () {

        $('.unverified').each(function () {
            $(this).click();
        });

        setTimeout(function () {
            $('.unverified_wait').each(function () {
                $(this).click();
            });
        }, 180000);
    });

    function validate(self, id) {
        var parent = $(self).parents('td'),
            domain = $('#ote_domain').val();
        parent.addLoader();
        $.post('?cmd=instra&action=validateote', {id: id, domain: domain}, function (result) {
            var a = $(self).parent('.verify');
            a.html($(result));
            parent.hideLoader();
        });
    }
</script>
{/literal}


