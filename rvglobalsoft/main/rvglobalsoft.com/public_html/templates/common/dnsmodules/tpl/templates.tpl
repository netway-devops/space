{literal}
    <script type="text/javascript">
        var start = false;
        $(document).ready(function () {

            $("#nitems strong").click(function () {
                $(this).parent().find('input').click();
                return false;
            });

            $('#nitems input').click(function () {
                $('.disabled').removeClass('disabled');

                $('#nitems .nitem').removeClass('niselected');
                $(this).parent().addClass('niselected');
                var id = $(this).val();
                $('.oitem').hide();
                $('.oitem_' + id).fadeIn('fast');

            }).eq(0).click();

        });

    </script>
    <style type="text/css">
        #dns_templ {list-style:none; padding:0; margin:0}
        #dns_templ li {padding:2px 10px; cursor:pointer; font-weight:bold}
        #dns_templ li:hover , #dns_templ li.active {color:#026BeB}
        #dns_prev {border:solid 1px #bbb; min-height:250px; margin-bottom:20px}

    </style>
{/literal}
<form id="mform" action="{$service_url}&act=dns_templates" method="post">
    {if $sected_domains}
        <div class="wbox"><div class="wbox_header">{$lang.bulkdomains}</div>
            <div class="wbox_content">
                {foreach from=$sected_domains item=domain name=row}
                    <div {if  $smarty.foreach.row.index == 0}class="first"{/if}><input type="checkbox" value="{$domain.id}" name="dom[]" checked="checked"/>
                        {$domain.name}
                    </div>
                {/foreach}
            </div></div>
        {/if}

    <h3>{$lang.availabletemplates}</h3>
    <table border="0" cellpadding="0" cellspacing="0" width="100%" class="ntable">
        <tr>
            <td valign="top" width="33%" style="padding:10px 0px;" id="nitems">

                {foreach from=$templates item=template key=name}
                    <div class="nitem">
                        <input type="radio" name="template" value="{$template[0].id}"/>
                        <strong>{$template[0].template}</strong>
                    </div>
                {/foreach}
            </td>
            <td valign="top" class="orderbox1" id="orderitems">
                <div class="oitem">
                    {$lang.selectoavailablednstempl}
                </div>
                {foreach from=$templates item=template key=tid name=floop}
                    <div class="oitem oitem_{$tid}" style="display:none;">
                        <table cellspacing="0" cellpadding="0" border="0" width="100%" class="display">
                            <col class="col-name" />
                            <col class="col-ttl" />
                            <col class="col-priority" />
                            <col class="col-type" />
                            <col class="col-content" />
                            <thead >
                                <tr>
                                    <th>{$lang.name}</th>
                                    <th>TTL</th>
                                    <th>{$lang.priority}</th>
                                    <th>{$lang.type}</th>
                                    <th>{$lang.content}</th>
                                </tr>
                            </thead>

                            <tbody >
                                {foreach from=$template item=record}
                                    <tr>
                                        <td><span class="overflow-e">{$record.name}</span></td>
                                        <td>{$record.ttl}</td>
                                        <td>{$record.priority}</td>
                                        <td>{$record.type}</td>
                                        <td><span class="overflow-e">{$record.content}</span></td>
                                    </tr>
                                {/foreach}
                            </tbody>
                        </table>
                    </div>

                {/foreach}
            </td>
        </tr>
        <tr>
            <td></td>
            <td class="orderbox2">
                <table width="100%" cellspacing="0">
                    <tbody>
                    <tr>
                        <td width="70%" class="orderbox3" style="text-align: right">
                            <div class="form-group pull-left">
                                <div class="checkbox">
                                    <input type="checkbox" name="reset" value="1">
                                    {$lang.dns_template_reset}
                                </div>
                            </div>
                            <button type="submit"
                                    onclick="return  $('input[name=template]:checked').val() !== undefined"
                                    value="1"
                                    name="submit" class="btn btn-primary disabled">
                                {$lang.applytemplate}
                            </button>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </td>
        </tr>
    </table>
    {securitytoken}
</form>