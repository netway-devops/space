<div class="form-horizontal">
    <div class="form-group">
            <label class="control-label col-md-2">List name</label>
        <div class="col-md-6">
            <input type="text" class="form-control" name="name"
                   value="{$group.name}" required/>
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-md-2">Owner</label>
        <div class="col-md-6">
            <select class="form-control" name="client_id" id="client_id">
                <option value="0">None</option>
                {if $group.client_id}
                    <option value="{$group.client_id}" selected>
                        #{$group.client.id} {$group.client|@client}
                    </option>
                {/if}
            </select>
        </div>
    </div>
    {if $group.id}
        <div class="form-group">
            <label class="control-label col-md-2">Parent List</label>
            <div class="col-md-6">
                <select class="form-control" name="parent_id"
                        default="{$group.client_id}" id="parent_id">
                    <option value="0" {if !$group.parent_id || $group.parent_id=='0'}selected{/if}>
                        None
                    </option>
                    {foreach from=$servers item=server}
                        <option value="{$server.id}"
                                {if $group.parent_id==$server.id}selected{/if}>
                            {$server.name}
                        </option>
                    {/foreach}
                </select>
            </div>
        </div>
    {else}
        <div class="form-group">
            <label class="control-label col-md-2">IP Types</label>
            <div class="col-md-6">
                <select id="ipvtype" name="type" class="form-control" >
                    <option value="ipv4">IP v4</option>
                    <option value="ipv6">IP v6</option>
                </select>
            </div>
        </div>
    {/if}

    <div class="form-group">
        <label class="control-label col-md-2">Network</label>
        <div class="col-md-4">
            <input type="text" name="firstip" value="{$group.firstip}" class="form-control"/>
        </div>
        <div class="col-md-2">
            <select name="mask" id="mask" class="form-control">
                {if $group.mask}<option>{$group.mask}</option>{/if}
            </select>
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-md-2">Gateway</label>
        <div class="col-md-6">
            <input type="text" name="gateway" value="{$group.gateway}" class="form-control"/>
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-md-2">VLAN</label>
        <div class="col-md-6">
            <select class="form-control" name="vlan_id" default="{$group.vlan_id}" id="vlan_id"
                    load="?cmd=ipam&action=vlan">
                <option value="0" {if !$group.vlan_id || $group.vlan_id=='0'}selected{/if}>
                    None
                </option>
                {if $vlan}
                    <option value="{$vlan.id}" selected>
                        #{$vlan.vlan} {$vlan.name}
                    </option>
                {/if}
            </select>
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-md-2">DHCP</label>
        <div class="col-md-6">
            {if $dhcp}
                <select class="form-control" name="dhcp_id" id="dhcp_id">
                    <option value="0">None</option>
                    {foreach from=$dhcp item=app}
                        <option value="{$app.id}" {if $group.dhcp_id == $app.id}selected{/if}>
                            #{$app.id} {$app.name}</option>
                    {/foreach}
                </select>
            {else}
                <em>No DHCP App added yet</em>
            {/if}
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-md-2">Description</label>
        <div class="col-md-6">
            <textarea name="description" class="form-control">{$group.description|escape}</textarea>
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-md-2">PTR template</label>
        <div class="col-sm-6">
            <input type="text" class="form-control" name="ptr_template" value="{if $group.metadata.ptr_template}{$group.metadata.ptr_template}{/if}">
        </div>
    </div>

    {if ($group.id && !$group.parent_id) || !$sublist}
        <div class="form-group">
            <label class="control-label col-md-2">RIR</label>
            <div class="col-md-6">
                <select name="rir" class="form-control">
                    <option value="ARIN" {if $group.rir == 'ARIN'}selected{/if}>ARIN</option>
                    <option value="RIPE" {if $group.rir == 'RIPE'}selected{/if}>RIPE</option>
                </select>

                <input type="hidden" id="ripe_action" name="ripe_action" value="">
            </div>
        </div>
    {/if}
    {if $group.rir == 'RIPE'}
        <div class="form-group">
            <label class="control-label col-md-2">RIPE Toolkit</label>
            <div class="ripe col-md-10 " >
                {if $group.metadata.inetnum}
                    <strong>Inetnum: <a href="https://apps.db.ripe.net/db-web-ui/#/lookup?source=ripe&type=inetnum&key={$group.metadata.inetnum}" target="_blank" rel="noopener noreferer">{$group.metadata.inetnum}</a></strong><br/>
                    <button type="button" class="btn btn-primary btn-sm" onclick="ripe_act('update');">Update inetnum</button>
                    <button type="button" class="btn btn-danger btn-sm" onclick="var c = confirm('Are you sure you want to delete Inetnum?'); if (c) ripe_act('delete'); ">Delete inetnum</button>
                {else}
                    <button type="button" class="btn btn-success btn-sm" onclick="ripe_act('create');">Attempt create inetnum</button>
                {/if}
            </div>
        </div>
    {/if}

    <div class="form-group">
        <label class="control-label col-md-2">Auto-assign</label>
        <div class="col-md-6">
            <div class="checkbox-inline">
                <input type="checkbox" name="autoprovision" value="1"
                       {if $group.autoprovision=='1'}checked{/if}/>
                Mark this pool as available for automated IP provisioning.
            </div>
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-md-2">Private</label>
        <div class="col-md-6">
            <div class="checkbox-inline">
                <input type="checkbox" name="private" value="1"
                       {if $group.private=='1'}checked{/if}/>
                Mark this pool as private.
            </div>
        </div>
    </div>

    {if !$group.id}
    <div class="form-group">
        <label class="control-label col-md-2">Fill IP pool</label>
        <div class="col-md-6">
            <div class="checkbox-inline">
                <input type="checkbox" name="is_pool" id="is_pool" value="1" data-limit="{$insert_limit}"/>
                Generate IP list for this pool.
            </div>
        </div>
    </div>

    <div id="pool_settings" style="display:none">
        <div class="form-group">
            <label class="control-label col-md-2">Fill WAN IP</label>
            <div class="col-md-6">
                <div class="checkbox-inline">
                    <input type="checkbox" name="fillwanips" id="fillwanips" value="1" />
                    Generate and assign WAN IP for each IP in this pool.
                </div>
            </div>
        </div>

        <div class="form-group wanip">
            <label class="control-label col-md-2">WAN Network</label>
            <div class="col-md-4">
                <input type="text" name="wanip" value="" class="form-control"/>
            </div>
            <div class="col-md-2">
                <input type="text" id="ro-cidr" class="form-control" readonly/>
            </div>
        </div>
    </div>
    {/if}

</div>
{literal}
    <script type="text/javascript">
        function ripe_act(action) {
            var action_obj = $('#ripe_action');
            action_obj.val(action);
            var form = action_obj.parents('form'),
                url = $(form).attr('action'),
                data = $(form).serializeObject(),
                id = data.group;
            $(form).parents('table').addLoader();
            $.post(url, data, function (data) {
                parse_response(data);
                return editlist(id);
            });

        }
        function maskopt(base, selected) {
            var html = '', value;
            for (var i = 0; base >= 0 && i < 129; i++) {
                value = '/' + base;
                html += '<option value="' + value + '" '
                    + (selected === value ? 'selected' : '')
                    + '>' + value + ' (' + Math.pow(2, i) + ')' + '</option>';
                base--;
            }
            return html;
        }

        function inichosen() {
            $('#client_id', '#facebox').chosensearch({width: '100%'});
            $("#parent_id").chosenedge({width: '100%'});

            $('#vlan_id').each(function (n) {
                var that = $(this),
                    set = that.attr('default');
                $.get('?cmd=ipam&action=vlan_lists', function (data) {
                    $.each(data.vlangroups, function () {
                        var optg = this,
                            optgh = $('<optgroup label="' + optg.name + '"></optgroup>').appendTo(that);
                        $.each(optg.list, function () {
                            $('<option value="' + this.id + '" >#' + this.vlan + ' ' + this.name + '</option>')
                                .prop('selected', set == this.id).appendTo(optgh);
                        })
                    });
                    that.chosenedge({width: '100%'});
                });
            });

        }

        $(function () {
            var fill_pool = $('#is_pool'),
                mask_select = $('#mask'),
                mask_size = 'ipv4';

            mask_select.change(function () {
                var mask = mask_select.val() || '/128';
                $('#ro-cidr').val(mask)
                fill_pool
                    .prop('disabled', Math.pow(2,  mask_size - mask.substr(1)) > fill_pool.data('limit'))
                    .trigger('change')
            }).trigger('change');

            $('#ipvtype').on('change', function () {
                var ip = $(this).val(),
                    value = mask_select.val();

                mask_size = ip === 'ipv4' ? 32 : 128;
                mask_select.html(maskopt(mask_size, value));
                mask_select.trigger('change').show();

            }).trigger('change');

            $("#fillwanips").on('change', function () {
                $('.wanip').toggle($(this).is(':checked'));
                return false;
            }).trigger('change');

            fill_pool.on('change', function () {
                $('#pool_settings').toggle(fill_pool.is(':checked') && !fill_pool.is(':disabled'));
            })

            inichosen();
        });

    </script>
{/literal}