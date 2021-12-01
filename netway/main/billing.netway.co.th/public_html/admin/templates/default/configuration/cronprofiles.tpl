<div id="newshelfnav" class="newhorizontalnav">
    <div class="list-1" >
        <ul>
            <li class="">
                <a href="?cmd=configuration&action=cron">{$lang.cronprofiles}</a>
            </li>
            <li class="active last">
                <a href="?cmd=configuration&action=cronprofiles"><span>Task Profiles</span></a>
            </li>

        </ul>
    </div>
    <div class="list-2">
        <div class="subm1 haveitems">
            <ul>
                <li><a href="#"   onclick="return addNewProfile();" >Add new profile</a></li>
                <li><a href="#"   onclick="$('.showhelp').show();return false;" >Show help</a></li>
            </ul>
        </div>
    </div>
</div>

{literal}
<script>
    function addNewProfile() {

    $('#addtask').toggle();
        return false;
    }

</script>
{/literal}

<div style="padding:10px">
    <div class="row">
        <div class="col-md-12">
            <div class="alert alert-info showhelp"><strong>Info:</strong> Cron profiles helps you improve cron performance - you can create multiple cron jobs for HostBill, and move tasks between profiles. <br>
                Ie.: You can create separate profile to run billing-related tasks, separate for provisioning/suspension, separate for hosting modules</div>


            <form method="post" action="">
                <input type="hidden" name="make" value="add" />
                <div class="box box-primary " id="addtask" style="{if !$viewaddform}display:none;{/if}">
                    <div class="box-header">
                        <h3 class="box-title">Add new profile</h3>

                    </div>
                    <div class="box-body">

                        <table border="0" cellpadding="6" cellspacing="0" width="500">
                            <tr>

                                <td align="right" class="light" style="width: 200px">Name: </td>
                                <td><input class="form-control" type="text" name="name" /></td>
                            </tr>

                            <tr>

                                <td align="right" class="light" >Description: <a class="vtip_description" title="This is admin-only description for reference"></a></td>
                                <td><textarea name="description" class="form-control"></textarea></td>
                            </tr>
                        </table>
                    </div>

                    <div class="box-footer clearfix no-border">

                        <button type="submit" class="btn btn-success btn-xs" ><span style="">Add new profile</span></button>
            <span class="orspace">{$lang.Or} <a href="#" class="editbtn" onclick="$('#addtask').slideUp();
                                return false;">{$lang.Cancel}</a></span>


                    </div>
                </div>
                {securitytoken}</form>


            <div class="box box-primary no-padding ">
                <div class="box-header">
                    <h3 class="box-title">Current profiles</h3>

                </div>
                <div class="box-body">
                    <table cellpadding="3" cellspacing="0" width="100%" class="whitetable " >
                        <tr>
                            <th>Name</th>
                            <th>Admin Description</th>
                            <th>Cron line to add</th>
                            <th width="20" ></th>
                        </tr>


                        {foreach from=$profiles item=profile}

                            <tr>
                                <td width="80">{$profile.name}</td>
                                <td>{$profile.description}</td>
                                <td>*/5 * * * * php -q {$cronpath} profile={$profile.name}</td>

                                <td width="20">
                                    <a href="?cmd=configuration&action=cronprofiles&make=delete&id={$profile.id}&security_token={$security_token}" class="delbtn" onclick="return confirm('Are you sure?');">Delete</a>
                                </td>
                            </tr>
                        {/foreach}
                   </table>

                </div>

                <div class="box-footer clearfix no-border">
                    <button type="submit" class="btn btn-success btn-xs" onclick="return addNewProfile();"><span style="">Add new profile</span></button>
                </div>
            </div>
        </div>
    </div>
</div>

