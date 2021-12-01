<div class="module_config_tab {if $module.main}module-loaded{/if}" data-key="{$kl}"
     {if !$module.main}style="display:none"{/if}>
    <div class="form-horizontal">
        <div class="form-group module-group">
            <label class="col-md-2 control-label">{$lang.third_party_app}</label>
            <div class="col-md-5 col-lg-6">
                <select name="modules[{$kl}][module]" class="form-control modulepicker">
                    <option value="0" {if !$module.module}selected="selected" {/if}>{$lang.none}</option>
                    {foreach from=$modules item=mod}
                        {if $mod.id!='-1'}
                            <option value="{$mod.id}"
                                    {if $module.module==$mod.id}selected="selected" {/if}>{$mod.modname}</option>
                        {/if}
                    {/foreach}
                    <option value="new" style="font-weight:bold">Show non-activated modules</option>
                </select>
            </div>

            <div class="col-md-5 col-lg-4">
                <a class="btn btn-default module-connect" href="#ConnectApp">
                    <i class="fa fa-plus"></i> Connect more apps
                </a>
            </div>

        </div>
    </div>
    <div class="loadable">
        {if $module.module && $module.main}
            {include file='services/ajax.configmodule.tpl'}
        {/if}
    </div>
</div>