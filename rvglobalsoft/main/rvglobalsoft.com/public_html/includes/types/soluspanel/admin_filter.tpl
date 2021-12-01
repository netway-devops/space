<tr>
                <td >{$lang.clientlastname}</td>
                <td ><input type="text" value="{$currentfilter.lastname}" size="25" name="filter[lastname]"/></td>

                <td>{$lang.Domain}</td>
                <td ><input type="text" value="{$currentfilter.domain}" size="25" name="filter[domain]"/></td>

                <td>{$lang.Service}</td>
                <td ><select name="filter[name]">
				<option value=''>{$lang.Any}</option>
				{foreach from=$advanced.products item=o}
                                <option value="{$o.name}" {if $currentfilter.name==$o.name}selected="selected"{/if}>{$o.catname} - {$o.name}</option>
				{/foreach}
				</select></td>


            </tr>
            <tr>

                <td>Status</td>
                <td >
                    <select name="filter[status]">
                        <option value=''>{$lang.Any}</option>
                        <option {if $currentfilter.status=='Pending'}selected="selected" {/if}>{$lang.Pending}</option>
                        <option {if $currentfilter.status=='Active'}selected="selected" {/if}>{$lang.Active}</option>
                        <option {if $currentfilter.status=='Suspended'}selected="selected" {/if}>{$lang.Suspended}</option>
                        <option {if $currentfilter.status=='Terminated'}selected="selected" {/if}>{$lang.Terminated}</option>
                        <option {if $currentfilter.status=='Cancelled'}selected="selected" {/if}>{$lang.Cancelled}</option>
                        <option {if $currentfilter.status=='Fraud'}selected="selected" {/if}>{$lang.Fraud}</option>
                    </select>
                </td>

                <td>{$lang.nextdue}</td>
                <td ><input type="text" value="{if $currentfilter.next_due}{$currentfilter.next_due|dateformat:$date_format}{/if}" size="15" name="filter[next_due]" class="haspicker"/></td>

                <td>{$lang.billingcycle}</td>
                <td >
                    <select name="filter[billingcycle]">
                        <option value=''>{$lang.Any}</option>
                        <option {if $currentfilter.billingcycle=='Free'}selected="selected" {/if} value="Free">{$lang.Free}</option>
                        <option {if $currentfilter.billingcycle=='One Time'}selected="selected" {/if} value="One Time">{$lang.OneTime}</option>
						<option {if $currentfilter.billingcycle=='Hourly'}selected="selected" {/if} value="Hourly">{$lang.Hourly}</option>
						<option {if $currentfilter.billingcycle=='Daily'}selected="selected" {/if} value="Daily">{$lang.Daily}</option>
						<option {if $currentfilter.billingcycle=='Weekly'}selected="selected" {/if} value="Weekly">{$lang.Weekly}</option>

                        <option {if $currentfilter.billingcycle=='Monthly'}selected="selected" {/if} value="Monthly">{$lang.Monthly}</option>
                        <option {if $currentfilter.billingcycle=='Quarterly'}selected="selected" {/if} value="Quarterly">{$lang.Quarterly}</option>
                        <option {if $currentfilter.billingcycle=='Semi-Annually'}selected="selected" {/if} value="Semi-Annually">{$lang.SemiAnnually}</option>
                        <option {if $currentfilter.billingcycle=='Annually'}selected="selected" {/if} value="Annually">{$lang.Annually}</option>
                        <option {if $currentfilter.billingcycle=='Biennially'}selected="selected" {/if} value="Bienially">{$lang.Biennially}</option>
						<option {if $currentfilter.billingcycle=='Triennially'}selected="selected" {/if}  value="Triennially">{$lang.Triennially}</option>
                    </select>
                </td>

            </tr>
<tr>
	<td>Type</td>
	<td><select name="filter[type]">
		<option value=''>{$lang.Any}</option>
		<option {if $currentfilter.type=='OpenVZ'}selected="selected"{/if} value='OpenVZ'>OpenVZ</option>
		<option {if $currentfilter.type=='Xen'}selected="selected"{/if} value='Xen'>Xen</option>
		<option {if $currentfilter.type=='KVN'}selected="selected"{/if} value='KVN'>KVN</option>
		<option {if $currentfilter.type=='Xen HVM'}selected="selected"{/if} value='Xen HVM'>Xen HVM</option>
		</select>
	</td>
	<td>
		CID/XID
	</td>
	<td>
		<input value='{$currentfilter.cidxid}' name="filter[cidxid]" />
	</td>
	<td>
		Username
	</td>
	<td>
		<input value='{$currentfilter.username}' name="filter[username]" />
	</td>
</tr>
<tr>
	<td>
		Operating System
	</td>
	<td>
		<input value='{$currentfilter.os}' name="filter[os]" />
	</td>
</tr>