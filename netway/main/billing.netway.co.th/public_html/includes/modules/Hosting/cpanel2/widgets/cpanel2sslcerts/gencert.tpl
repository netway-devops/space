<div class="control-group">
    <label for="domains" id="lblDomains">
        {$lang.cpanel_gen_domains}
        <span class="extra">*</span>
    </label>
    <div class="row-fluid">
        <div class="span4">
            <select name="host">
                <option value="">{$lang.cpanel_gen_select_domain}</option>
                {foreach from=$domains item=domain}
                    <option value="{$domain}">{$domain}</option>
                {/foreach}
            </select>
        </div>
        <div class="span5">
            <div class="help-block">
                {$lang.cpanel_gen_select_domain2}
            </div>
        </div>
    </div>
</div>
<div class="control-group">
    <label for="city" id="lblCity"><span>{$lang.city}</span><span class="extra">*</span></label>
    <div class="row-fluid">
        <div class="span4">
            <input type="text" class="form-control" name="city" id="city" >
        </div>
        <div class="span5">
            <div class="help-block">{$lang.cpanel_gen_company}</div>
        </div>
    </div>
</div>
<div class="control-group">
    <label for="state" id="lblState"><span>{$lang.state}</span><span class="extra">*</span></label>
    <div class="row-fluid">
        <div class="span4">
            <input type="text" class="form-control" name="state" id="state">

        </div>
        <div class="span5">
            <div class="help-block">{$lang.cpanel_gen_company_state}</div>
        </div>
    </div>
</div>
<div class="control-group">
    <label for="country" id="lblCountry"><span>{$lang.country}</span><span class="extra">*</span></label>
    <div class="row-fluid">
        <div class="span4">
            <select class="form-control" name="country" id="country">
                <option value="">{$lang.cpanel_gen_choose_country}</option>
                {foreach from=$countrylist item=country key=iso}
                    <option value="{$iso}">{$country}</option>
                {/foreach}
            </select>

        </div>
        <div class="span5">
            <span class="help-block">{$lang.cpanel_gen_choose_country_desc}</span>
        </div>
    </div>
</div>
<div class="control-group">
    <label for="company" id="lblCompany"><span>{$lang.cpanel_gen_com}</span><span class="extra">*</span></label>
    <div class="row-fluid">
        <div class="span4">
            <input type="text" class="form-control" name="company" id="company">
        </div>
        <div class="span5">
            <div class="help-block">{$lang.cpanel_gen_com_desc}</div>
        </div>
    </div>
</div>
<div class="control-group">
    <label for="companydivision" id="lblCompanyDivision">{$lang.cpanel_gen_com_division}</label>
    <div class="row-fluid">
        <div class="span4">
            <input type="text" class="form-control" name="companydivision" id="companydivision">

        </div>
        <div class="span5">
            <div class="help-block">{$lang.cpanel_gen_provide1}</div>
        </div>
    </div>
</div>
<div class="control-group">
    <label for="email" id="lblEmail">{$lang.cpanel_gen_email}</label>
    <div class="row-fluid">
        <div class="span4">
            <input type="text" class="form-control" name="email" id="email">

        </div>
        <div class="span5">
            <span class="help-block">{$lang.cpanel_gen_provide2}</span>
        </div>
    </div>
</div>
<div class="control-group">
    <label for="pass" id="lblPass">{$lang.cpanel_gen_passphrase}</label>
    <div class="row-fluid">
        <div class="span4">
            <input type="password" class="form-control" name="pass" id="pass" >
        </div>
        <div class="span5">
            <span class="help-block">{$lang.cpanel_gen_passphrase_desc}</span>
        </div>
    </div>
</div>
<div class="control-group">
    <input type="hidden" value="csr" name="item" id="hidItem">
    <input type="hidden" value="{$lang.cpanel_gen_signing}" name="itemname" id="hidItemname">
    <input type="submit" title="{$lang.cpanel_gen_generate}" value="Generate" class="btn btn-flat-primary btn-primary" id="submit-button">
</div>
{securitytoken}