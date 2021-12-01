<section class="section-account-header">
    <h1>{$lang.accountdetails}</h1>
</section>

{include file="clientarea/top_nav.tpl" nav_type="details"}

<h5 class="my-5">{$lang.Settings_p}</h5>

<section class="section-account">
    <form class="form-horizontal" method="post">
        {foreach from=$settings item=option key=key name=settings}
            {if !$smarty.foreach.settings.first}
                <hr>
            {/if}
            <div class="control-group">
                <label class="control-label" for="{$key}">
                    <strong>{$option.title}</strong>
                    {if $option.tooltip}
                        <span class="vtip_description" title="{$option.tooltip|escape}"></span>
                    {/if}
                    {if $option.description}
                        {$option.description}
                    {/if}
                </label>
                <div class="controls">
                    {if $option.type == 'text' || $option.type == 'input'}
                        <input class="form-control" type="text" name="{$option.name}" id="{$key}" value="{$option.value|escape}">
                    {elseif $option.type == 'textarea'}
                        <textarea class="form-control" name="{$option.name}" id="{$key}">{$option.value|escape}</textarea>
                    {elseif $option.type == 'radio' || $option.type == 'checkbox'}
                        {foreach from=$option.items item=opt name=options}
                            {if $option.value !== ''}
                            <div class="form-check">
                                <input id="{$opt.value|escape}" type="{$option.type}" name="{$opt.name|escape}" value="{$opt.value|escape}"  {if $opt.selected}checked{/if}>
                                <label for="{$opt.value|escape}">{$opt.title}{if $opt.description}, {$opt.description}{/if}  </label>
                              </div>
                            {/if}
                        {/foreach}
                    {elseif $option.key == 'DefaultNameservers'}
                        <div class="form">
                            <input type="radio" name="configs[DefaultNameservers][switch]" value="off" {if $option.selected.switch == 'off' || $option.selected.switch == ''}checked{/if}>
                            {$lang.settings_nameservers_title1}
                            <br>
                            <input type="radio" name="configs[DefaultNameservers][switch]" value="on" {if $option.selected.switch == 'on'}checked{/if}>
                            {$lang.settings_nameservers_title2}
                            <br>
                            <br>
                            <div class="settings-nameservers" {if $option.selected.switch == 'on'} style="display: block;" {else} style="display: none;" {/if}>
                                <div class="settings-nameservers-items">
                                    <div class="form-group row">
                                        <label for="ns1" class="col-12 col-md-2 col-form-label">{$lang.nameserver} 1</label>
                                        <div class="col-12 col-md-6">
                                            <input id="ns1" class="form-control" placeholder="{$lang.nameserver} 1" type="text" name="configs[DefaultNameservers][items][0]" value="{$option.selected.items.0}">
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label for="ns2" class="col-12 col-md-2 col-form-label">{$lang.nameserver} 2</label>
                                        <div class="col-12 col-md-6">
                                            <input id="ns2" class="form-control" placeholder="{$lang.nameserver} 2" type="text" name="configs[DefaultNameservers][items][1]" value="{$option.selected.items.1}">
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label for="ns3" class="col-12 col-md-2 col-form-label">{$lang.nameserver} 3</label>
                                        <div class="col-12 col-md-6">
                                            <input id="ns3" class="form-control" placeholder="{$lang.nameserver} 3" type="text" name="configs[DefaultNameservers][items][2]" value="{$option.selected.items.2}">
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label for="ns4" class="col-12 col-md-2 col-form-label">{$lang.nameserver} 4</label>
                                        <div class="col-12 col-md-6">
                                            <input id="ns4" class="form-control" placeholder="{$lang.nameserver} 4" type="text" name="configs[DefaultNameservers][items][3]" value="{$option.selected.items.3}">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        {literal}
                            <script type="text/javascript">
                                $('input[type="radio"][name="configs[DefaultNameservers][switch]"]').change(function () {
                                    var el = $(this);
                                    if ($(el).val() == 'on') {
                                        $('.settings-nameservers').show();
                                    } else {
                                        $('.settings-nameservers').hide();
                                    }
                                });
                            </script>
                        {/literal}
                    {elseif $option.type == 'tpl'}
                        {include file=$option.tpl}
                    {else}
                        <select class="form-control" id="{$key}" name="{$option.name}">
                            {foreach from=$option.items item=opt}
                                {if $option.value !== ''}
                                    <option value="{$opt.value|escape}" {if $opt.selected}selected{/if} >
                                        {$opt.title}{if $opt.description}, {$opt.description}{/if}
                                    </option>
                                {/if}
                            {/foreach}
                        </select>
                    {/if}
                </div>
            </div>
        {/foreach}
        <div class="d-flex flex-row justify-content-center align-items-center">
            <button type="submit" class="btn btn-primary btn-lg btn-w-100 btn-md-w-auto my-4" name="submit">{$lang.savechanges}</button>
        </div>
        {securitytoken}
    </form>
</section>