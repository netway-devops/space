<div class="tgnot_setup">
    {if $bot_config}
        {literal}
            <script>
                function removeBotConfig() {
                    ajax_update("?cmd=telegram&action=setup&make=remove_config", {}, '.tgnot_setup', true);
                }
            </script>
        {/literal}

        <div class="table-responsive table-borders table-radius mb-4" style="margin: 15px 0;">
            <table class="table layout-fixed stackable">
                <tbody>
                    <tr>
                        <td width="30%" class="inline-row"><b>Bot Token</b></td>
                        <td class="inline-row">{$bot_config.bot_token}</td>
                    </tr>
                    <tr>
                        <td width="30%" class="inline-row"><b>Chat ID</b></td>
                        <td class="inline-row">{$bot_config.chat_id}</td>
                    </tr>
                    <tr>
                        <td width="30%" class="inline-row"></td>
                        <td class="inline-row">
                            <a href="#" class="btn btn-danger btn-sm" onclick="if (confirm('Are you sure?'))removeBotConfig();return false;">{$lang.delete}</a>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    {else}

        <link rel="stylesheet" href="{$moduleurl}templates/jquery-steps.min.css">
        <script src="{$moduleurl}templates/jquery-steps.min.js"></script>

        {if $default_bot}
            {literal}
                <script>
                    $(function () {
                        var tk = $('#api_key');

                        var loaded = false,
                            key = false;

                        var tgsteps = $('#tgsteps').steps({
                            onChange: function (currentIndex, newIndex, stepDirection) {
                                if (currentIndex < newIndex) {
                                    switch (newIndex) {
                                        case 3:
                                            if (!tk.val().length)
                                                return false;

                                            if (loaded && tk.val() === key)
                                                return true;

                                            $('.step3-fail').hide();
                                            $('.step-btn').prop('disabled', true);
                                            $.ajax({
                                                type: 'POST',
                                                url: "?cmd=telegram&action=setup_group&make=obtain_chat_id",
                                                data: {api_key: tk.val()},
                                                dataType: 'JSON',
                                                success: function (data) {
                                                    var tbody = $('.table-chats tbody');
                                                    tbody.html('');
                                                    $.each(data, function(i, chat) {
                                                        var tr = $('<tr>');
                                                        $('<td>').html('<input type="radio" name="chat_id" value="'+data[i].chat_id+'">').appendTo(tr);
                                                        $('<td>').html(data[i].title).appendTo(tr);
                                                        $('<td>').html(data[i].chat_id).appendTo(tr);
                                                        tbody.append(tr);
                                                    });

                                                    loaded = true;
                                                    key = tk.val();
                                                    tgsteps.data('plugin_Steps').setStepIndex(3);
                                                    $('.step-btn').prop('disabled', false);
                                                },
                                                error: function () {
                                                    $('.step3-fail').show();
                                                    $('.step-btn').prop('disabled', false);
                                                }
                                            });
                                            return false;
                                    case 4:
                                        if (!tk.val().length)
                                            return false;

                                        var cid = $('.table-chats').find('input[name="chat_id"]:checked');

                                        $('input[name="option[Default Admin Bot Token]"]').val(tk.val());
                                        $('input[name="option[Default Admin Bot Chat ID]"]').val(cid.val());
                                        return true;
                                    }
                                }
                                return true;
                            },
                            onFinish: function () {
                                bootbox.hideAll();
                            }
                        });
                    });
                </script>
            {/literal}
        {else}
            {literal}
                <script>
                    $(function () {
                        var tk = $('#api_key'),
                                fn = $('.tg_data_firstname'),
                                ln = $('.tg_data_lastname'),
                                un = $('.tg_data_username'),
                                cd = $('.tg_data_chat_id'),
                                cid = $('#chat_id');

                        var loaded = false,
                                key = false;

                        var tgsteps = $('#tgsteps').steps({
                            onChange: function (currentIndex, newIndex, stepDirection) {
                                if (currentIndex < newIndex) {
                                    switch (newIndex) {
                                        case 3:
                                            if (!tk.val().length)
                                                return false;

                                            if (loaded && tk.val() === key)
                                                return true;

                                            $('.step3-fail').hide();
                                            $('.step-btn').prop('disabled', true);
                                            $.ajax({
                                                type: 'POST',
                                                url: "?cmd=telegram&action=setup&make=obtain_chat_id",
                                                data: {api_key: tk.val()},
                                                dataType: 'JSON',
                                                success: function (data) {
                                                    fn.html(data.firstname);
                                                    ln.html(data.lastname);
                                                    un.html(data.username);
                                                    cd.html(data.chat_id);
                                                    cid.val(data.chat_id);

                                                    loaded = true;
                                                    key = tk.val();
                                                    tgsteps.data('plugin_Steps').setStepIndex(3);
                                                    $('.step-btn').prop('disabled', false);
                                                },
                                                error: function () {
                                                    $('.step3-fail').show();
                                                    $('.step-btn').prop('disabled', false);
                                                }
                                            });
                                            return false;
                                    }
                                }
                                return true;
                            },
                            onFinish: function () {
                                ajax_update("?cmd=telegram&action=setup&make=finish_setup", $('#tgform').serialize(), '.tgnot_setup', true);
                            }
                        });
                    });
                </script>
            {/literal}
        {/if}

        {literal}
            <script>
                $(function () {
                    var tk = $('#api_key'),
                            fn = $('.tg_data_firstname'),
                            ln = $('.tg_data_lastname'),
                            un = $('.tg_data_username'),
                            cd = $('.tg_data_chat_id'),
                            cid = $('#chat_id');

                    var loaded = false,
                            key = false;

                    var tgsteps = $('#tgsteps').steps({
                        onChange: function (currentIndex, newIndex, stepDirection) {
                            console.log(currentIndex + ':' + newIndex);
                            if (currentIndex < newIndex) {
                                switch (newIndex) {
                                    case 3:
                                        if (!tk.val().length)
                                            return false;

                                        if (loaded && tk.val() === key)
                                            return true;

                                        $('.step3-fail').hide();
                                        $('.step-btn').prop('disabled', true);
                                        $.ajax({
                                            type: 'POST',
                                            url: "?cmd=telegram&action=setup&make=obtain_chat_id",
                                            data: {api_key: tk.val()},
                                            dataType: 'JSON',
                                            success: function (data) {
                                                fn.html(data.firstname);
                                                ln.html(data.lastname);
                                                un.html(data.username);
                                                cd.html(data.chat_id);
                                                cid.val(data.chat_id);

                                                loaded = true;
                                                key = tk.val();
                                                tgsteps.data('plugin_Steps').setStepIndex(3);
                                                $('.step-btn').prop('disabled', false);
                                            },
                                            error: function () {
                                                $('.step3-fail').show();
                                                $('.step-btn').prop('disabled', false);
                                            }
                                        });
                                        return false;
                                }
                            }
                            return true;
                        },
                        onFinish: function () {
                            ajax_update("?cmd=telegram&action=setup&make=finish_setup", $('#tgform').serialize(), '.tgnot_setup', true);
                        }
                    });
                });
            </script>
        {/literal}

        <form action="" method="POST" id="tgform" class="" style="margin-top: 10px;{if $bot_config}display:none{/if}">

            <div class="alert alert-warning">Use the mobile app for bot configuration!</div>

            <div class="step-app" id="tgsteps">
                <ul class="step-steps">
                    <li data-step-target="step1" style="display: none;"></li>
                    <li data-step-target="step2" style="display: none;"></li>
                    <li data-step-target="step3" style="display: none;"></li>
                    <li data-step-target="step4" style="display: none;"></li>
                    {if $default_bot}
                        <li data-step-target="step5" style="display: none;"></li>
                    {/if}
                </ul>
                <div class="step-content">
                    <div class="step-tab-panel" data-step="step1">

                        {if $default_bot}
                            <p>Here you can configure a bot that will send messages to the group created in the Telegram.</p>
                        {/if}

                        <h4><b>{$lang.step1_title}</b></h4>
                        <p>{$lang.step1_description}</p>
                    </div>
                    {if $default_bot}
                        <div class="step-tab-panel" data-step="step2">
                            <h4><b>2. Add the bot to the group</b></h4>
                            <p>Go to the group, click on group name, click on Add members, in the searchbox search for your bot like this: @my_bot, select your bot and click add.</p>
                            <p>After adding bot, make sure to post test message in group starting with <code>/</code> sign, ie: <code>/test</code></p>
                        </div>
                    {else}
                        <div class="step-tab-panel" data-step="step2">
                            <h4><b>{$lang.step2_title}</b></h4>
                        </div>
                    {/if}
                    <div class="step-tab-panel" data-step="step3">
                        <h4><b>{$lang.step3_title}</b></h4>
                        <input type="text" name="api_key" class="form-control" id="api_key" placeholder="Bot token">
                        {if $default_bot}
                            <div class="step3-fail" style="display: none;margin-top: 15px;">
                                <div class="alert alert-danger">Retrieving data failed. Please check Bot Token and check if the bot has been added to the group</div>
                            </div>
                        {else}
                            <div class="step3-fail" style="display: none;margin-top: 15px;">
                                <div class="alert alert-danger">{$lang.step3_fail}</div>
                            </div>
                        {/if}
                    </div>

                    {if $default_bot}
                        <div class="step-tab-panel" data-step="step4">
                            <h4><b>4. Please select your group</b></h4>
                            <div class="table-responsive table-borders table-radius mb-4" style="margin: 15px 0;">
                                <table class="table layout-fixed stackable table-chats">
                                    <thead>
                                        <tr>
                                            <th width="30px"></th>
                                            <th>Title</th>
                                            <th>Chat_id</th>
                                        </tr>
                                    </thead>
                                    <tbody></tbody>
                                </table>
                            </div>
                        </div>
                    {else}
                        <div class="step-tab-panel" data-step="step4">
                            <h4><b>{$lang.step4_title}</b></h4>
                            <div class="table-responsive table-borders table-radius mb-4" style="margin: 15px 0;">
                                <table class="table layout-fixed stackable">
                                    <tbody>
                                    <tr>
                                        <td width="30%" class="inline-row"><b>{$lang.firstname}</b></td>
                                        <td class="inline-row tg_data_firstname"></td>
                                    </tr>
                                    <tr>
                                        <td width="30%" class="inline-row"><b>{$lang.lastname}</b></td>
                                        <td class="inline-row tg_data_lastname"></td>
                                    </tr>
                                    <tr>
                                        <td width="30%" class="inline-row"><b>{$lang.username}</b></td>
                                        <td class="inline-row tg_data_username"></td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <input type="hidden" name="chat_id" id="chat_id" value="">
                    {/if}
                    {if $default_bot}
                        <div class="step-tab-panel" data-step="step5">
                            <h4><b>5. Save module configuration</b></h4>
                            <p>Your configuration is ready. Save the module configuration after closing this modal</p>
                        </div>
                    {/if}
                </div>
                <div class="step-footer">
                    <button data-step-action="prev" class="step-btn btn btn-default">{$lang.step_prev}</button>
                    <button data-step-action="next" class="step-btn btn btn-default">{$lang.step_next}</button>
                    <button data-step-action="finish" class="step-btn btn btn-default">{$lang.step_finish}</button>
                </div>
            </div>
            {securitytoken}
        </form>
    {/if}
</div>