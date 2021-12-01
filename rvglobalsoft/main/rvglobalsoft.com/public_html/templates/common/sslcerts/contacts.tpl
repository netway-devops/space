<table class="sslcert-table sslcert-contact sslcert-contact-{$type} {$class} form-horizontal">
    <tr>
        <td class="required">{$lang.company} / {$lang.en_jobtitle}</td>
        <td>
            <input name="{$type}[OrgName]"  class="styled span2 contact-org" value="{if $contact.OrgName}{$contact.OrgName}{else}{$clientdata.companyname}{/if}" /> /
            <input name="{$type}[JobTitle]" class="styled span1 contact-job" value="{if $contact.JobTitle}{$contact.JobTitle}{else}{$clientdata.jobtitle}{/if}"/>
        </td>
    </tr>
    <tr>
        <td class="required">{$lang.firstname}</td>
        <td><input name="{$type}[FName]"  value="{if $contact.FName}{$contact.FName}{else}{$clientdata.firstname}{/if}" class="styled span3"/></td>
    </tr>
    <tr>
        <td class="required">{$lang.lastname}</td>
        <td><input name="{$type}[LName]"  value="{if $contact.LName}{$contact.LName}{else}{$clientdata.lastname}{/if}" class="styled span3"/></td>
    </tr>
    <tr>
        <td class="required">{$lang.address}</td>
        <td><input name="{$type}[Address1]" value="{if $contact.Address1}{$contact.Address1}{else}{$clientdata.address1}{/if}" class="styled span3"/></td>
    </tr>
    <tr>
        <td>{$lang.address2}</td>
        <td><input name="{$type}[Address2]"  value="{if $contact.Address2}{$contact.Address2}{else}{$clientdata.address2}{/if}" class="styled span3"/></td>
    </tr>
    <tr>
        <td class="required">{$lang.city}</td>
        <td><input name="{$type}[City]" value="{if $contact.City}{$contact.City}{else}{$clientdata.city}{/if}" class="styled span3"/></td>
    </tr>
    <tr>
        <td class="required">{$lang.state} / {$lang.postcode}</td>
        <td>
            <div class="form-inline">
                <input class="styled span2 contact-state" name="{$type}[State]"  
                       value="{if $contact.State}{$contact.State}{else}{$clientdata.state}{/if}" /> 
                / 
                <input class="styled span1 contact-zip" name="{$type}[PostalCode]"  
                       value="{if $contact.PostalCode}{$contact.PostalCode}{else}{$clientdata.postcode}{/if}" size="6"/>
                <input type="hidden" name="{$type}[StateProvinceChoice]" value="S" />
            </div>
        </td>
    </tr>
    <tr>
        <td class="required">{$lang.country}</td>
        <td>
            <select name="{$type}[Country]" class="styled span3">
                {foreach from=$countries key=k item=v}
                    <option value="{$k}" {if $contact.Country && $contact.Country==$k}selected="selected"{elseif !$contact.Country && $clientdata.country==$k}selected="selected"{/if}>
                        {$v}
                    </option>
                {/foreach}
            </select>
        </td>
    </tr>
    <tr>
        <td class="required">{$lang.email}</td>
        <td>
            <input  name="{$type}[EmailAddress]" class="styled span3" 
                    value="{if $contact.EmailAddress}{$contact.EmailAddress}{else}{$clientdata.email}{/if}"/>
        </td>
    </tr>
    <tr>
        <td class="required">{$lang.phone}</td>
        <td class="form-inline">
            + 
            <input size="2" name="{$type}[PreFix]" class="styled span1 contact-prefix" 
                   value="{if $contact.PreFix}{$contact.PreFix}{else}{$clientdata.phonecode}{/if}"/> 
            . 
            <input name="{$type}[Phone]"  value="{if $contact.Phone}{$contact.Phone}{else}{$clientdata.phonenumber}{/if}" class="styled span2 contact-phone"/>
        </td>
    </tr>
    <tr>
        <td>Fax</td>
        <td class="form-inline">
            + 
            <input size="2" name="{$type}[FPreFix]" class="styled span1 contact-prefix" 
                   value="{if $contact.FPreFix}{$contact.FPreFix}{/if}" />
            . 
            <input name="{$type}[Fax]"  value="{if $contact.Fax}{$contact.Fax}{/if}" class="styled span2 contact-phone"/>
        </td>
    </tr>
</table>