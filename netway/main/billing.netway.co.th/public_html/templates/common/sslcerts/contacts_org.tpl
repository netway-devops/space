<table class="sslcert-table sslcert-organization form-horizontal {$class}" >
    <tr>
        <td class="required">{$lang.en_orgname}</td>
        <td><input name="organization[name]" class="styled tipsing span3" value="{$organization.name}" title="{$lang.en_tip1}"/></td>
    </tr>
    <tr>
        <td class="required">{$lang.en_orgunit}</td>
        <td><input name="organization[unit]" class="styled tipsing span3" value="{$organization.unit}" title="{$lang.en_tip2}"/></td>
    </tr>
    <tr>
        <td class="required">{$lang.address}</td>
        <td><input name="organization[address1]" class="styled tipsing span3" value="{$organization.address1}" title="{$lang.en_tip3}"/></td>
    </tr>
    <tr>
        <td>{$lang.address2}</td>
        <td><input name="organization[address2]" class="styled tipsing span3" value="{$organization.address2}" title="{$lang.en_optional}"/></td>
    </tr>
    <tr>
        <td class="required">{$lang.city}</td>
        <td><input name="organization[locality]" class="styled tipsing span3" value="{$organization.locality}" title="{$lang.en_tip4}"/></td>
    </tr>
    <tr>
        <td class="required">{$lang.state}</td>
        <td><input name="organization[state]" class="styled tipsing span3" value="{$organization.state}" title="{$lang.en_tip5}"/></td>
    </tr>
    <tr>
        <td class="required">{$lang.postcode}</td>
        <td><input name="organization[postalcode]" class="styled tipsing span3" value="{$organization.postalcode}" title="{$lang.en_tip6} "/></td>
    </tr>
    <tr>
        <td class="required">{$lang.country}</td>
        <td>
            <select name="organization[country]" class="styled tipsing" title="{$lang.en_tip6} ">
                {foreach from=$countries key=k item=v}
                    <option value="{$k}" {if $organization.country==$k} selected="selected"{/if}>{$v}</option>
                {/foreach}
            </select>
        </td>
    </tr>
</table>