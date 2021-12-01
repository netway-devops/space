{include file='header.tpl'}


{if $servers}
{literal}
    <script type="text/javascript">

        $(function () {


            $('.chosenedge').chosenedge({
                width: '100%',
                enable_split_word_search: true,
                search_contains: true,
            });
        })

    </script>
{/literal}
    <form action="?cmd=cpanel_synchronize&action=results" method="post">
        <input type="hidden" name="submit" value="1" />

        <div class="container-fluid" style="margin-top: 10px">
            <div class="row">
                <div class="col-md-12">
                    <div class="form-group">
                        <label>Select WHM Server:</label>
                        <select name="server_list[]" id="server_list"  class="form-control chosenedge">
                            {foreach from=$servers item=group  key=group_name}
                                <optgroup label="{$group_name}">
                                    {foreach from=$group item=srvr}
                                        <option value="{$srvr.id}" {if $selected_server == $srvr.id}selected="selected"{/if}>
                                            {$srvr.name}
                                            {if $srvr.ip} - {$srvr.ip}{elseif $srvr.host} - {$srvr.host}{/if}
                                        </option>
                                    {/foreach}
                                </optgroup>
                            {/foreach}
                        </select>
                    </div>

                    <div class="form-group">
                        <label>Send report to staff: (optional) </label>
                        <select name="admin_list[]" id="admin_list" multiple class="form-control chosenedge">
                            {foreach from=$admins item=adm}
                                        <option value="{$adm.id}" >
                                            {$adm.firstname} {$adm.lastname} - {$adm.email}
                                        </option>
                            {/foreach}
                        </select>
                    </div>

                </div>
            </div>
        </div>
        <div class="blu" style="padding: 10px 15px">
            <button id="import-continue" type="submit" value="1" class="btn btn-primary" type="submit">
                Continue
            </button>
            {securitytoken}
        </div>
    </form>
{else}
    {$lang.firstaddserver}
    <a href="?cmd=servers&action=add">{$lang.clickhere}</a>
    {$lang.toadd}
{/if}



