<section class="section-account-header">
    <h1>{$lang.security}</h1>
</section>

<div class="nav-tabs-wrapper">
    <ul class="nav nav-tabs init-by-hash nav-slider horizontal d-flex justify-content-between flex-nowrap align-items-center" role="tablist">
        <li>
            <ul class="nav" role="tablist" id="SecurityTabs">
                <li class="nav-item active">
                    <a class="nav-link" id="ipaccess-tab" data-toggle="tab" href="#ipaccess" role="tab" aria-controls="ipaccess" aria-selected="true">{$lang.ipaccess}</a>
                </li>
                {if $acl.editsshkeys.visible}
                    <li class="nav-item">
                        <a class="nav-link" id="ssh-tab" data-toggle="tab" href="#ssh" role="tab" aria-controls="ssh" aria-selected="true">{$lang.shhkeys}</a>
                    </li>
                {/if}
            </ul>
        </li>
        <li class="d-none d-md-flex">
            <ul class="nav" id="addssh-btn" style="display: none;">
                {if $acl.editsshkeys.visible}
                    <li class="ml-3">
                        <a class="btn btn-success btn-sm" href="#addssh" data-toggle="modal">{$lang.add_new_ssh_key}</a>
                    </li>
                {/if}
            </ul>
        </li>
    </ul>
</div>

<div class="tab-content" id="SecurityContent">
    <div class="tab-pane fade show active" id="ipaccess" role="tabpanel" aria-labelledby="ipaccess-tab">
        <section class="section-ipaccess">
            <a class="btn btn-success d-inline-block d-md-none" href="#addssh" data-toggle="modal">{$lang.add_new_ssh_key}</a>
            <div class="d-flex flex-row align-items-center security-myip">
                <div class="mr-3 security-myip-icon"><i class="material-icons">device_hub</i></div>
                <div class="d-flex flex-column align-items-start justify-content-center">
                    <span class="text-secondary"><small>{$lang.currentipadd}</small></span>
                    <h4>{$yourip}</h4>
                </div>
            </div>
            <h4 class="mt-5 mb-4">{$lang.ipaccess}</h4>
            <section class="input-self-box fluid">
                <form action="" method="post">
                    <input type="hidden" name="make" value="addrule" />
                    <div class="input-group d-flex align-items-center">
                        <input type="text" name="rule" class="form-control form-control-noborders" placeholder="{$lang.eg|default:"eg."} {$yourip}" required="required">
                        <span class="input-group-btn">
                            <button type="submit" class="btn btn-success btn-md"><span class="p-3 text-small">{$lang.addipsubnet}</span></button>
                        </span>
                        {securitytoken}
                    </div>
                </form>
            </section>
            <div class="table-responsive table-borders table-radius mb-4">
                <table class="table">
                    <thead>
                    <tr>
                        <th colspan="2">
                            {$lang.ipsubnet}
                        </th>
                    </tr>
                    </thead>
                    <tbody>
                    {foreach from=$rules item=rule name=rules}
                        <tr>
                            <td>
                                {if $rule.rule == 'all'}
                                    {$lang.allaccess}
                                {else}
                                    {$rule.rule}
                                {/if}
                            </td>
                            <td class="w-25 text-right">
                                <a href="{$ca_url}{$cmd}/{$action}/&make=delrule&id={$rule.id}"><i class="material-icons icon-info-color">delete</i></a>
                            </td>
                        </tr>
                        {foreachelse}
                        <tr>
                            <td>{$lang.norules} - {$lang.allaccess}</td>
                        </tr>
                    {/foreach}
                    </tbody>
                </table>
            </div>

            <div class="card accordion">
                <div class="card-header d-flex flex-row justify-content-between" id="headingOne">
                    <span>
                        {$lang.ruleformat}
                    </span>
                    <span class="font-weight-light text-uppercase text-muted cursor-pointer" data-toggle="collapse" data-target="#ipaccess_rules" aria-expanded="true" aria-controls="ipaccess_rules">{$lang.Hide}</span>
                </div>
                <div id="ipaccess_rules" class="collapse show" aria-labelledby="headingOne" data-parent="#ipaccess">
                    <div class="card-body text-small">
                        <ul class="pl-3  list-unstyled">
                            <li><strong>all</strong> - {$lang.keywordmatchingall}</li>
                            <li><strong>xxx.xxx.xxx.xxx</strong> - {$lang.singleiprule}</li>
                            <li><strong>xxx.xxx.xxx.xxx/M</strong> - {$lang.ipmaskrule}</li>
                            <li><strong>xxx.xxx.xxx.xxx/mmm.mmm.mmm.mmm</strong> - {$lang.ipmaskruledoted}</li>
                        </ul>
                        <div class="mt-4 mb-3 font-weight-bold pl-3">{$lang.examplerules}</div>
                        <ul class="pl-3 list-unstyled">
                            <li>{$lang.ruleexample1}</li>
                            <li>{$lang.ruleexample2}</li>
                        </ul>
                    </div>
                </div>
            </div>
        </section>
    </div>
    {if $acl.editsshkeys.visible}
    <div class="tab-pane fade" id="ssh" role="tabpanel" aria-labelledby="ssh-tab">
        <section class="section-ssh">
            <div class="account-info-container mt-15">
                <div class="clearfix">
                    {if $sshkeys}
                        <div class="table-responsive table-borders table-radius">
                            <table class="table position-relative stackable">
                                <thead>
                                    <tr>
                                        <th>{$lang.name}</th>
                                        <th>{$lang.fingerprint}</th>
                                        <th></th>
                                    </tr>
                                </thead>
                                <tbody>
                                {foreach from=$sshkeys key=key item=sshkey}
                                    <tr>
                                        <td data-label="{$lang.name}">
                                            {$sshkey.name}
                                        </td>
                                        <td data-label="{$lang.fingerprint}">
                                            {$sshkey.fingerprint}
                                        </td>
                                        <td class="text-md-right texl-left">
                                            <form method="post" action="">
                                                <button type="submit" name="submit" class="btn btn-danger btn-sm confirm_js" data-confirm="{$lang.remove_ssh_key_desc}">
                                                    <i class="material-icons text-white">delete</i>
                                                </button>
                                                <input type="hidden" name="delete[{$sshkey.id}]" value="1" >
                                                <input type="hidden" name="make" value="delete_ssh_key">
                                                {securitytoken}
                                            </form>
                                        </td>
                                    </tr>
                                {/foreach}
                                </tbody>
                            </table>
                        </div>
                    {else}
                        <h4 class="my-5">{$lang.nothing}</h4>
                    {/if}

                    <div id="addssh" class="modal fade fade2" tabindex="-1" role="dialog" aria-hidden="true">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content">
                                <form method="post" action="">
                                    <div class="modal-header">
                                        <h4 class="modal-title font-weight-bold mt-2">{$lang.add_new_ssh_key}</h4>
                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                            <i class="material-icons">cancel</i>
                                        </button>
                                    </div>
                                    <div class="modal-body">
                                        <div class="form-label-group mt-3">
                                            <input id="name" class="form-control" type="text" name="ssh_key[name]" placeholder="{$lang.name}" required>
                                            <label class="form-label-placeholder" for="name">{$lang.name}</label>
                                        </div>
                                        <div class="form-label-group mt-3">
                                            <textarea id="ssh" name="ssh_key[key]" rows="10" class="form-control" placeholder="{$lang.enter_publi_ssh_key}"></textarea>
                                        </div>
                                        {securitytoken}
                                        <div class="w-100  mt-4">
                                            <input type="hidden" name="make" value="add_ssh_key">
                                            <button type="submit" class="btn btn-primary btn-lg w-100">{$lang.submit}</button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div>
    {/if}
</div>