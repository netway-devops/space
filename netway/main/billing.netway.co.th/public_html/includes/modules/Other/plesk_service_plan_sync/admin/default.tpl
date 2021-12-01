{include file='shelf.tpl'}
<form action="" method="post" >
    <div class="container-fluid" style="padding-top:14px;padding-bottom:14px;">

        <div class="row">
            <div class="col-md-12">


                {if !$configs}<div class="blank_state_smaller blank_forms" >
                    <div class="blank_info">
                        <h1>To start, create new configuration</h1>
                       You can have multiple plan synchronization scenarios, depending on your preferences  (ie separate configuration for windows and separate for linux plesk installations).

                        <br/>
                         <a href="#" data-toggle="modal" data-target="#assign-client" class="btn btn-success">Add new configuration</a>

                    </div>
                </div>
                {else}


                    <ul class="list-group" style="margin-bottom: 10px;">

                        {foreach from=$configs item=config}

                        <li class="list-group-item">
                            <div class="row">
                                <div class="col-md-2 text-right pull-right">

                                    <a class="btn btn-default btn-xs "  href="?cmd=plesk_service_plan_sync&action=config&id={$config.id}">
                                        <i class="fa fa-pencil"></i>
                                    </a>
                                    <a class="btn btn-default btn-xs " onclick="return confirm('Are you sure?');" href="?cmd=plesk_service_plan_sync&action=rmconfig&id={$config.id}&security_token={$security_token}">
                                        <i class="fa fa-trash"></i>
                                    </a>
                                </div>

                                <div class="col-md-7">
                                    <a href="?cmd=plesk_service_plan_sync&action=config&id={$config.id}"><strong>{$config.name}</strong></a>
                                </div>
                                <div class="col-md-3">
                                    <code>{$config.type}</code>
                                </div>

                            </div>
                        </li>

                        {/foreach}
                    </ul>
                {/if}


                <div class="form-group">

                </div>
            </div>



        </div>
    </div>
    {securitytoken}
</form>



<div class="modal fade" tabindex="-1" role="dialog" id="assign-client">
    <form action="?cmd=plesk_service_plan_sync&action=addconfig" method="post">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                                aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">Create new configuration</h4>
                </div>
                <div class="modal-body">

                    <div class="form-group">
                        <label>Enter name </label>
                        <input class="form-control" name="name" type="text" placeholder="My configuration 1" />
                    </div>
                    <div class="form-group">
                        <label>Handled Plesk types</label>
                        <select class="form-control" name="type">
                            <option value="Linux">Linux</option>
                            <option value="Windows">Windows</option>
                        </select>
                    </div>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    <button type="submit" class="btn btn-primary client-assign">Add configuration</button>
                </div>
            </div><!-- /.modal-content -->
        </div>
        {securitytoken}
    </form>
</div>