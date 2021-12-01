{if !$mode}{literal}
    <script type="text/javascript">
        var actv_form = 0;
        $(function () {
            $('.form_container').hide().eq(0).show();
            $('.content .fleft > div').eq(0).addClass('actv');
            $('.content .fleft > div').each(function (x) {
                $(this).click(function () {
                    actv_form = x;
                    $('.form_container').hide().eq(x).show();
                    $('.content .fleft > div').removeClass('actv').eq(x).addClass('actv');
                });
            });
            $("a.vtip_description").vTip();
        });

        function test_connection(l) {
            var form = $(l).parents('form');
            var results = $(form).find('.test-results').addLoader();
            ajax_update("?cmd=module&module={/literal}{$moduleid}{literal}&mode=testcon&" + form.serialize(), {}, results, false)
            return false;
        }

        function submitList(form) {
            ajax_update("?cmd=module&module={/literal}{$moduleid}{literal}&mode=addlist&" + form.serialize(), false, function (data) {
                ajax_update("?cmd=module&module={/literal}{$moduleid}{literal}&refresh=1&", {}, "#treecont");
                $(document).trigger('close.facebox');
            });
        }

    </script>
{/literal}
    <table width="100%">
        <tr>
            <td class="fleft">
                <div>Add new list</div>
                {if $suported}
                    {foreach from=$suported item=api}
                        <div>{$api.modname}</div>
                    {/foreach}
                {/if}
            </td>
            <td class="fright">
                <h1 style="margin: 5px 10px -5px;">
                    Add {if $suported}or Import {/if}new IP {if $sublist}sublist to {$sublist.name}{else}List{/if}
                </h1>
                <hr />
                <form action="?cmd=module&module={$moduleid}" method="post" id="add-list-form" onsubmit="return false">
                    <input type="hidden" name="action" value="addlist"/>
                    {if $sublist}
                        <input type="hidden" name="sub" value="{$sublist.id}"/>
                    {/if}
                    {include file="list_form.tpl"}
                </form>

                {if $suported}
                    {foreach from=$suported item=api}
                        <div class="form_container">
                            <form action="?cmd=module&module={$moduleid}" method="post">
                                <input type="hidden" name="action" value="addlist"/>
                                {if $sublist}<input type="hidden" name="sub" value="{$sublist.id}" />{/if}
                                <input type="hidden" name="import" value="{$api.id}"/>

                                <div class="form-group" style="margin-top: 10px">

                                    <h4>Select App to import from</h4>


                                    <div class="input-group">
                                        <select name="import_server_id" class="form-control" style="margin-left: 0px">
                                            {foreach from=$api.apps item=appname key=appid}
                                                <option value="{$appid}">{$appname}</option>
                                            {/foreach}
                                        </select>
                                        <span class="input-group-btn">
                                            <button type="button" id="test" class="btn btn-default "
                                                    onclick="return test_connection(this)">Test Connection
                                            </button>
                                            <button type="submit" class="btn btn-success " name="mode" value="import"
                                                    onclick="return confirm('Are you sure?');">Start import
                                            </button>


                                        </span>
                                    </div>


                                </div>
                                <div class="form-group test-results">
                                    <br><br>
                                </div>
                            </form>

                        </div>
                    {/foreach}
                {/if}
            </td>
        </tr>
    </table>
    <div class="f-footer">
        <div class="left spinner" style="display: none;">
            <img src="ajax-loading2.gif">
        </div>
        <div class="right">
            <span class="bcontainer ">
                <a class="new_control greenbtn" onclick="$('.spinner').show();
                        submitList($('#add-list-form'));
                        return false;" href="#">
                    <span>Add list</span>
                </a>
            </span>
            <span class="bcontainer">
                <a class="submiter menuitm" href="#" onclick="$(document).trigger('close.facebox');
                        return false;">
                    <span>Close</span>
                </a>
            </span>
        </div>
        <div class="clear"></div>
    </div>
{elseif $mode == 'testcon'}
    {if $conection == 1}
        <span class="Successfull"><strong>Success!</strong></span>
    {else}<span class="error">Error: {$conection}</span>{/if}
{/if}