{include file="header.tpl"}

<form method="post" action="?cmd={$modulename}&action={$action}" style="padding: 10px 0;" class="flavor-form">
    {if $action=="edit"}
        <input type="hidden" name="id" value="{$entry.id}"/>
        <input type="hidden" name="edit" value="1"/>
    {else}
        <input type="hidden" name="add" value="1"/>
    {/if}


    <div style="padding: 0 10px; margin: 10px">
        {if $action === 'add'}
            <div class="form-group">
                <label>Flavor Type</label>
                <select name="type" class="form-control" id="typepick">
                    <option value="0">VM Flavor</option>
                    <option value="1" {if $entry.type==1}selected{/if} >Storage Flavor</option>
                    <option value="2" {if $entry.type==2}selected{/if} >IP Flavor</option>
                </select>
            </div>
        {else}
            <input type="hidden" id="typepick" name="type"
                   value="{$entry.type}"/>
        {/if}

        <div class="form-group">
            <label>Name</label>
            <a class="vtip_description" title="Customer will see this flavor name"></a>
            <input type="text" value="{$entry.name}" name="name" class="form-control"/>
        </div>

        <div class="form-group">
            <div class="checkbox">
                <label>
                    <input type="checkbox" value="1" name="enabled" {if $entry.enabled}checked{/if} />
                    Enable - Tick for clients to see this flavor
                </label>
            </div>
        </div>

        <div class="row">
            <div class="form-group col-md-6">
                <label>
                    <b class="tabs VM">Price per hour</b>
                    <b class="tabs STORAGE">Price for 1 GB per hour</b>
                    <b class="tabs IP">Price for 1 IP per hour</b>
                </label>
                <a class="vtip_description"
                   title="Monthly charge will be automatically calculated based on this setting"></a>
                <input type="text" value="{$entry.price_on|default:1}" name="price_on" class="form-control"/>
            </div>
            <div class="form-group col-md-6 tabs VM">
                <label>Price per hour when server is powered down</label>
                <input type="text" value="{$entry.price_off|default:0}" name="price_off" class="form-control"/>
            </div>
            <div class="form-group col-md-6 tabs VM">
                <label>Maximum billable hours in month</label>
                <a class="vtip_description"
                   title="After reaching set value no additional charges will be generated for related VM. Set to 0 to disable."></a>
                <input type="number" value="{$entry.hours_max|default:0}" name="hours_max" class="form-control"/>
            </div>
        </div>
        <div class="form-group">
            <label>Description</label>
            <a class="vtip_description">
                <span>
                    Clients will see this description, use this to describe
                    flavor values as clients will not see variable values below
                </span>
            </a>
            <textarea name="description" class="form-control" style="height:100px;">{$entry.description}</textarea>
        </div>

        <div>
            <h2>Module specific settings</h2>
            <hr/>
        </div>
        <div class="row">
            {foreach from=$modules item=modulename key=moduleid name=flam}
                <div class="mod-variables col-md-6 ">
                    <div class="panel panel-default">
                        <div class="panel-heading">{$modulename}</div>
                        <div class="panel-body">
                            {foreach from=$variables item=group key=vartype}
                                <div class="variables tabs {$vartype}">
                                    {foreach from=$group item=mods key=key}
                                        {if $mods[$moduleid]}
                                            <div class="variable-key form-group clearfix" data-key="{$key}">
                                                <label class="modframe mod_{$moduleid}">{$mods[$moduleid].name}</label>

                                                {if $mods[$moduleid].tpl_path}{include file=$mods[$moduleid].tpl_path}
                                                {elseif $mods[$moduleid].tpl_source}{$mods[$moduleid].tpl_source}
                                                {else}
                                                    <input type="text" value="{$entry.limits.$key}"
                                                           name="limits[{$key}]"
                                                           class="form-control"/>
                                                {/if}
                                            </div>
                                        {/if}
                                    {/foreach}
                                </div>
                            {/foreach}
                        </div>
                    </div>
                </div>
            {/foreach}
            <div id="empty-alert" class="col-md-12">
                <div class="panel panel-default">
                    <div class="panel-body">{$lang.nothingtodisplay}</div>
                </div>
            </div>
        </div>

        <div class="clearfix">
            <button type="subbmit" class="btn btn-primary">Save Changes</button>
        </div>
    </div>
    {securitytoken}
</form>
{literal}
    <style>
        .flavor-form .form-group {
            line-height: 1.5em;
        }
    </style>
    <script type="text/javascript">
        $(function () {
            var modvars = $('.mod-variables'),
                tabs = $('.tabs'),
                type = $('#typepicked'),
                empty = $('#empty-alert'),
                variables = {};

            $('.variable-key').each(function () {
                var self = $(this),
                    key = self.data('key');

                if (!variables[key])
                    variables[key] = self;
                else
                    variables[key] = variables[key].add(self);
            }).find('select, input, textarea')
                .on('input', function () {
                    var self = $(this),
                        varbox = self.closest('.variable-key'),
                        key = varbox.data('key');

                    variables[key].not(varbox[0])
                        .find('input, select, textarea').val(self.val())
                });

            $('#typepick').on('change init',function () {
                var to = ['VM', 'STORAGE', 'IP'][$(this).val() || 0];

                modvars.show();
                tabs.hide()
                    .find('input, select, textarea').prop('disabled', true);

                tabs.filter('.' + to).show()
                    .find('input, select, textarea').prop('disabled', false);

                modvars.filter(function () {
                    return $('.form-group:visible', this).length === 0
                }).hide();

                empty.toggle(!modvars.filter(':visible').length);
                return false;
            }).trigger('init');
        })

    </script>
{/literal}