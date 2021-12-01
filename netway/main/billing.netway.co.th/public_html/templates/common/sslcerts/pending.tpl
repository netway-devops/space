<link type="text/css" rel="stylesheet" href="templates/common/sslcerts/pending.css">
<form class="sslcert-config p19" action="" method="POST">
    <h2>{$lang.en_confcert}</h2>

    {if $certopt.csr}
        <div class="sslcert-section sslcert-csr">
            <strong class="sslcert-header">Certificate Signing Request (CSR)</strong>
            <div class="sslcert-csr-textarea">
                <textarea name="certdata[csr]">{$certdata.csr}</textarea>
            </div>
        </div>
    {/if}

    {if $certopt.server_type}
        <div class="sslcert-section sslcert-server">
            <strong class="sslcert-header">{$lang.en_servtype}</strong>
            <div class="sslcert-server-select">
                <select name="certdata[server_type]">
                    {foreach from=$certopt.server_type item=server key=key}
                        <option value="{$key}" {if $certdata.server_type==$key}selected{/if}>{$server}</option>
                    {/foreach}
                </select>
                {if $certopt.server_cnt}
                    <input type="text" value="{$certdata.server_cnt|default:1}" name="certdata[server_cnt]">
                {/if}
            </div>
        </div>
    {/if}

    {if $certopt.approver_email}
        <div class="sslcert-section sslcert-approver-email">
            <strong class="sslcert-header">{$lang.en_appemail}</strong>
            <div class="sslcert-approver-email-select">
                <select name="certdata[approver_email]">
                    {foreach from=$certopt.approver_email item=email}
                        <option value="{$email}" {if $certdata.approver_email==$email}selected{/if}>{$email}</option>
                    {/foreach}
                </select>
            </div>
        </div>
    {/if}


    <div class="sslcert-section  sslcert-organizarion">
        <strong class="sslcert-header">{$lang.organizationdetails}</strong>
        <div class="table form-horizontal">
            {if $certopt.organization_form}
                {include file=$certopt.organization_form}
            {else}
                {include file='templates/common/sslcerts/contacts_org.tpl'}
            {/if}
        </div>
    </div>

    <div class="sslcert-section sslcert-contacts">
        <strong class="sslcert-header">{$lang.contactdetails}</strong>

        {if $certopt.contact_form}
            <div class="sslcert-contact sslcert-contact-admin">
                <div class="table form-horizontal sslcert-contact-admin">
                    {include file=$certopt.contact_form type=admin}
                </div>
            </div>
            {if $certopt.contact_types}
                {*}<div class="sslcert-contact-copy">
                    <input type="checkbox" checked> Use admin contact for all other contacts.
                </div>{*}
                {foreach from=$certopt.contact_types item=ctype}
                    {if $ctype=='admin'}{continue}
                    {/if}
                    <div class="sslcert-contact sslcert-contact-{$ctype}">
                        <strong>{$lang[$ctype]}</strong>
                        <div class="table form-horizontal ">
                            {include file=$certopt.contact_form type=$ctype}
                        </div> 
                    </div>
                {/foreach}
            {/if}
        {else}
            <div class="sslcert-contact sslcert-contact-admin">
                <div class="table form-horizontal ">
                    {include file='templates/orderpages/common/contacts.tpl' type=admin}
                </div> 
            </div> 
            {*}<div class="sslcert-contact-copy">
                <input type="checkbox" checked> {$lang.en_copybill}
            </div>{*}
            <div class="sslcert-contact sslcert-contact-billing">
                <strong>{$lang.Billing}</strong>
                <div class="table form-horizontal ">
                    {include file='templates/common/sslcerts/contacts.tpl' type=billing }
                </div> 
            </div> 
            <div class="sslcert-contact sslcert-contact-tech">
                <strong>{$lang.Tech}</strong>
                <div class="table form-horizontal ">
                    {include file='templates/common/sslcerts/contacts.tpl' type=tech}
                </div> 
            </div> 
        {/if}
    </div>
    <div class="sslcert-action">
        <button type="subbmit" name="act" value="save" class="btn btn-primary">{$lang.savechanges}</button>
        {if $cancreate == 'ok'}
            <button type="subbmit" name="act" value="create" class="btn btn-primary">Create</button>
        {/if}
    </div>
    {securitytoken}
</form>
