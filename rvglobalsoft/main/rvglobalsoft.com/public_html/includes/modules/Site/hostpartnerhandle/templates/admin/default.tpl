
 <div class="container" style="width: 750px">
    <div class="ticketmsg ticketmain" style="margin-bottom:10px;">
        <div style="display:block">
        {if $data}
        <h1>Requester to approval company</h1>
            <table class="table glike hover" border="0" cellspacing="0" cellpadding="3" style=" border: 1px solid black !important;font-size: 16px;">
             
                <tbody>
                    <tr>
                        <td>Client ID</td>
                        <td class="cell-border clientID">
                            {$data.client_id}
                        </td>
                    </tr>
                    <tr>
                        <td>Name </td>
                        <td class="cell-border">
                            {$data.firstname}&nbsp;{$data.lastname}
                        </td>
                    </tr>
                    <tr>
                        <td>Email </td>
                        <td class="cell-border">
                            {$data.email}
                        </td>
                    </tr>
                    <tr>
                        <td>Country </td>
                        <td class="cell-border">
                           {if $data.country == 'AF'}{$data.country|replace:'AF':'Afghanistan'}
                                            {elseif $data.country == 'AX'}{$data.country|replace:'AX':'Aland Islands'}
                                            {elseif $data.country == 'AL'}{$data.country|replace:'AL':'Albania'}
                                            {elseif $data.country == 'DZ'}{$data.country|replace:'DZ':'Algeria'}
                                            {elseif $data.country == 'AS'}{$data.country|replace:'AS':'American'}
                                            {elseif $data.country == 'AD'}{$data.country|replace:'AD':'Andorra'}
                                            {elseif $data.country == 'AO'}{$data.country|replace:'AO':'Angola'}
                                            {elseif $data.country == 'AI'}{$data.country|replace:'AI':'Anguilla'}
                                            {elseif $data.country == 'AG'}{$data.country|replace:'AG':'Antigua And Barbuda'}
                                            {elseif $data.country == 'AR'}{$data.country|replace:'AR':'Argentina'}
                                            {elseif $data.country == 'AM'}{$data.country|replace:'AM':'Armenia'}
                                            {elseif $data.country == 'AW'}{$data.country|replace:'AW':'Aruba'}
                                            {elseif $data.country == 'AQ'}{$data.country|replace:'AQ':'Antarctica'}
                                            {elseif $data.country == 'AU'}{$data.country|replace:'AU':'Australia'}
                                            {elseif $data.country == 'AT'}{$data.country|replace:'AT':'Austria'}
                                            {elseif $data.country == 'AZ'}{$data.country|replace:'AZ':'Azerbaijan'}
                                            {elseif $data.country == 'BS'}{$data.country|replace:'BS':'Bahamas'}
                                            {elseif $data.country == 'BH'}{$data.country|replace:'BH':'Bahrain'}
                                            {elseif $data.country == 'BD'}{$data.country|replace:'BD':'Bangladesh'}
                                            {elseif $data.country == 'BB'}{$data.country|replace:'BB':'Barbados'}
                                            {elseif $data.country == 'BY'}{$data.country|replace:'BY':'Belarus'}
                                            {elseif $data.country == 'BE'}{$data.country|replace:'BE':'Belgium'}
                                            {elseif $data.country == 'BZ'}{$data.country|replace:'BZ':'Belize'}
                                            {elseif $data.country == 'BJ'}{$data.country|replace:'BJ':'Benin'}
                                            {elseif $data.country == 'BM'}{$data.country|replace:'BM':'Bermuda'}
                                            {elseif $data.country == 'BT'}{$data.country|replace:'BT':'Bhutan'}
                                            {elseif $data.country == 'BO'}{$data.country|replace:'BO':'Bolivia'}
                                            {elseif $data.country == 'BA'}{$data.country|replace:'BA':'Bosnia And Herzegovina'}
                                            {elseif $data.country == 'BW'}{$data.country|replace:'BW':'Botswana'}
                                            {elseif $data.country == 'BV'}{$data.country|replace:'BV':'Bouvet'}
                                            {elseif $data.country == 'BR'}{$data.country|replace:'BR':'Brazil'}
                                            {elseif $data.country == 'IO'}{$data.country|replace:'IO':'British Indian Ocean Territory'}
                                            {elseif $data.country == 'BN'}{$data.country|replace:'BN':'Brunei Darussalam'}
                                            {elseif $data.country == 'BG'}{$data.country|replace:'BG':'Bulgaria'}
                                            {elseif $data.country == 'BF'}{$data.country|replace:'BF':'Burkina Faso'}
                                            {elseif $data.country == 'BI'}{$data.country|replace:'BI':'Burundi'}
                                            {elseif $data.country == 'KH'}{$data.country|replace:'KH':'Cambodia'}
                                            {elseif $data.country == 'CM'}{$data.country|replace:'CM':'Cameroon'}
                                            {elseif $data.country == 'CA'}{$data.country|replace:'CA':'Canada'}
                                            {elseif $data.country == 'CV'}{$data.country|replace:'CV':'Cape Verde'}
                                            {elseif $data.country == 'KY'}{$data.country|replace:'KY':'Cayman Islands'}
                                            {elseif $data.country == 'CF'}{$data.country|replace:'CF':'Central African Republic'}
                                            {elseif $data.country == 'TD'}{$data.country|replace:'TD':'Chad'}
                                            {elseif $data.country == 'CL'}{$data.country|replace:'CL':'Chile'}
                                            {elseif $data.country == 'CN'}{$data.country|replace:'CN':'China'}
                                            {elseif $data.country == 'CX'}{$data.country|replace:'CX':'Christmas Island'}
                                            {elseif $data.country == 'CC'}{$data.country|replace:'CC':'Cocos (Keeling) Islands'}
                                            {elseif $data.country == 'CO'}{$data.country|replace:'CO':'Colombia'}
                                            {elseif $data.country == 'KM'}{$data.country|replace:'KM':'Comoros'}
                                            {elseif $data.country == 'CG'}{$data.country|replace:'CG':'Congo'}
                                            {elseif $data.country == 'CD'}{$data.country|replace:'CD':'Congo, Democratic Republic'}
                                            {elseif $data.country == 'CK'}{$data.country|replace:'CK':'Cook Islands'}
                                            {elseif $data.country == 'CR'}{$data.country|replace:'CR':'Costa Rica'}
                                            {elseif $data.country == 'HR'}{$data.country|replace:'HR':'Croatia'}
                                            {elseif $data.country == 'CU'}{$data.country|replace:'CU':'Cuba'}
                                            {elseif $data.country == 'CY'}{$data.country|replace:'CY':'Cyprus'}
                                            {elseif $data.country == 'CZ'}{$data.country|replace:'CZ':'Czech Republic'}
                                            {elseif $data.country == 'DK'}{$data.country|replace:'DK':'Denmark'}
                                            {elseif $data.country == 'DM'}{$data.country|replace:'DM':'Dominica'}
                                            {elseif $data.country == 'DO'}{$data.country|replace:'DO':'Dominican Republic'}
                                            {elseif $data.country == 'EC'}{$data.country|replace:'EC':'Ecuador'}
                                            {elseif $data.country == 'EE'}{$data.country|replace:'EE':'Estonia'}
                                            {elseif $data.country == 'EG'}{$data.country|replace:'EG':'Egypt'}
                                            {elseif $data.country == 'ES'}{$data.country|replace:'ES':'Spain'}
                                            {elseif $data.country == 'FI'}{$data.country|replace:'FI':'Finland'}
                                            {elseif $data.country == 'FR'}{$data.country|replace:'FR':'France'}
                                            {elseif $data.country == 'GB'}{$data.country|replace:'GB':'United Kingdom'}
                                            {elseif $data.country == 'GH'}{$data.country|replace:'GH':'Ghana'} 
                                            {elseif $data.country == 'GR'}{$data.country|replace:'GR':'Greece'} 
                                            {elseif $data.country == 'GT'}{$data.country|replace:'GT':'Guatemala'} 
                                            {elseif $data.country == 'HK'}{$data.country|replace:'HK':'Hong Kong'} 
                                            {elseif $data.country == 'HR'}{$data.country|replace:'HR':'Croatia'} 
                                            {elseif $data.country == 'HU'}{$data.country|replace:'HU':'Hungary'} 
                                            {elseif $data.country == 'ID'}{$data.country|replace:'ID':'Indonesia'} 
                                            {elseif $data.country == 'IE'}{$data.country|replace:'IE':'Ireland'} 
                                            {elseif $data.country == 'IL'}{$data.country|replace:'IL':'Israel'} 
                                            {elseif $data.country == 'IN'}{$data.country|replace:'IN':'India'}
                                            {elseif $data.country == 'IT'}{$data.country|replace:'IT':'Italy'} 
                                            {elseif $data.country == 'JP'}{$data.country|replace:'JP':'Japan'}
                                            {elseif $data.country == 'KE'}{$data.country|replace:'KE':'Kenya'} 
                                            {elseif $data.country == 'LK'}{$data.country|replace:'LK':'Falkland Islands (Malvinas)'}
                                            {elseif $data.country == 'LU'}{$data.country|replace:'LU':'Luxembourg'} 
                                            {elseif $data.country == 'MX'}{$data.country|replace:'MX':'Mexico'}
                                            {elseif $data.country == 'MY'}{$data.country|replace:'MY':'Malaysia'} 
                                            {elseif $data.country == 'NL'}{$data.country|replace:'NL':'Netherlands'}
                                            {elseif $data.country == 'NO'}{$data.country|replace:'NO':'Norway'} 
                                            {elseif $data.country == 'NZ'}{$data.country|replace:'NZ':'New Zealand'}
                                            {elseif $data.country == 'NG'}{$data.country|replace:'NG':'Nigeria'}
                                            {elseif $data.country == 'PH'}{$data.country|replace:'PH':'Philippines'} 
                                            {elseif $data.country == 'PK'}{$data.country|replace:'PK':'Pakistan'}
                                            {elseif $data.country == 'PL'}{$data.country|replace:'PL':'Poland'} 
                                            {elseif $data.country == 'RO'}{$data.country|replace:'RO':'Romania'}
                                            {elseif $data.country == 'RS'}{$data.country|replace:'RS':'Serbia'}
                                            {elseif $data.country == 'SG'}{$data.country|replace:'SG':'Singapore'}
                                            {elseif $data.country == 'TH'}{$data.country|replace:'TH':'Thailand'}
                                            {elseif $data.country == 'TR'}{$data.country|replace:'TR':'Turkey'}
                                            {elseif $data.country == 'UA'}{$data.country|replace:'UA':'Ukraine'}
                                            {elseif $data.country == 'US'}{$data.country|replace:'US':'United States'}    
                                            {elseif $data.country == 'ZA'}{$data.country|replace:'ZA':'Kazakhstan'}
                                            {else}{$data.country}  
                            {/if}
                        </td>
                    </tr>
                    <tr>
                        <td>Company Name</td>
                        <td class="cell-border">{$data.company_name} </td>
                    </tr>
                    <tr>
                        <td>Logo</td>
                        <td class="cell-border">{if $data.logo ==''}-{else}<img src="/templates/netwaybysidepad/images/{$data.logo} "alt="" style="max-height: 100px;max-width: 300px;">{/if}</td>
                    </tr>
                    <tr>
                        <td>Website URL</td>
                        
                        <td class="cell-border"><a href="https://www.{$data.web_url|replace:'www.':''}" target="_blank">{$data.web_url} </a></td>
                    </tr>
                   <tr>
                        <td>Brief Info</td>
                        <td class="cell-border">{$data.title} </td>
                    </tr>
                    <tr>
                        <td>Client Detail</td>
                        <td class="cell-border"><a href="?cmd=clients&action=show&id={$data.client_id}" target="_blank">Detail</a></td>
                    </tr>
                    <tr>
                        <td>Status</td>
                        <td class="cell-border">
                            {if $data.status == 0}
                            <span style="color: red">Waiting for Approval</span>
                          {else}
                          <span style="color: green">Already Approved</span>
                          {/if}
                       </td>
                    </tr>
                    {if $data.status == 0}
                    <tr>
                        <td colspan="2">
                       <center><button type="submit" class="approve" onclick="approve()">Approve</button> </center>
                       </td>
                    </tr>   
                  {/if}
                </tbody>
            </table>
            {/if}

        </div>  
        
 <!-- start edit -->
         {if $EditCompany}   
         <div style='margin-top:50px;'> 
       
             <h1>Requester to approval edit details company</h1>
            <table class="table glike hover" border="0" cellspacing="0" cellpadding="3" style=" border: 1px solid black !important;font-size: 16px;">
             
                <tbody>
                    <tr>
                        <td>Client ID</td>
                        <td class="cell-border clientID">
                            {$EditCompany.client_id}
                        </td>
                    </tr>
                    <tr>
                        <td>Name </td>
                        <td class="cell-border">
                            {$EditCompany.firstname}&nbsp;{$EditCompany.lastname}
                        </td>
                    </tr>
                    <tr>
                        <td>Email </td>
                        <td class="cell-border">
                            {$EditCompany.email}
                        </td>
                    </tr>
                    <tr>
                        <td>Country </td>
                        <td class="cell-border">
                            {if $EditCompany.country == 'AF'}{$EditCompany.country|replace:'AF':'Afghanistan'}
                                            {elseif $EditCompany.country == 'AX'}{$EditCompany.country|replace:'AX':'Aland Islands'}
                                            {elseif $EditCompany.country == 'AL'}{$EditCompany.country|replace:'AL':'Albania'}
                                            {elseif $EditCompany.country == 'DZ'}{$EditCompany.country|replace:'DZ':'Algeria'}
                                            {elseif $EditCompany.country == 'AS'}{$EditCompany.country|replace:'AS':'American'}
                                            {elseif $EditCompany.country == 'AD'}{$EditCompany.country|replace:'AD':'Andorra'}
                                            {elseif $EditCompany.country == 'AO'}{$EditCompany.country|replace:'AO':'Angola'}
                                            {elseif $EditCompany.country == 'AI'}{$EditCompany.country|replace:'AI':'Anguilla'}
                                            {elseif $EditCompany.country == 'AG'}{$EditCompany.country|replace:'AG':'Antigua And Barbuda'}
                                            {elseif $EditCompany.country == 'AR'}{$EditCompany.country|replace:'AR':'Argentina'}
                                            {elseif $EditCompany.country == 'AM'}{$EditCompany.country|replace:'AM':'Armenia'}
                                            {elseif $EditCompany.country == 'AW'}{$EditCompany.country|replace:'AW':'Aruba'}
                                            {elseif $EditCompany.country == 'AQ'}{$EditCompany.country|replace:'AQ':'Antarctica'}
                                            {elseif $EditCompany.country == 'AU'}{$EditCompany.country|replace:'AU':'Australia'}
                                            {elseif $EditCompany.country == 'AT'}{$EditCompany.country|replace:'AT':'Austria'}
                                            {elseif $EditCompany.country == 'AZ'}{$EditCompany.country|replace:'AZ':'Azerbaijan'}
                                            {elseif $EditCompany.country == 'BS'}{$EditCompany.country|replace:'BS':'Bahamas'}
                                            {elseif $EditCompany.country == 'BH'}{$EditCompany.country|replace:'BH':'Bahrain'}
                                            {elseif $EditCompany.country == 'BD'}{$EditCompany.country|replace:'BD':'Bangladesh'}
                                            {elseif $EditCompany.country == 'BB'}{$EditCompany.country|replace:'BB':'Barbados'}
                                            {elseif $EditCompany.country == 'BY'}{$EditCompany.country|replace:'BY':'Belarus'}
                                            {elseif $EditCompany.country == 'BE'}{$EditCompany.country|replace:'BE':'Belgium'}
                                            {elseif $EditCompany.country == 'BZ'}{$EditCompany.country|replace:'BZ':'Belize'}
                                            {elseif $EditCompany.country == 'BJ'}{$EditCompany.country|replace:'BJ':'Benin'}
                                            {elseif $EditCompany.country == 'BM'}{$EditCompany.country|replace:'BM':'Bermuda'}
                                            {elseif $EditCompany.country == 'BT'}{$EditCompany.country|replace:'BT':'Bhutan'}
                                            {elseif $EditCompany.country == 'BO'}{$EditCompany.country|replace:'BO':'Bolivia'}
                                            {elseif $EditCompany.country == 'BA'}{$EditCompany.country|replace:'BA':'Bosnia And Herzegovina'}
                                            {elseif $EditCompany.country == 'BW'}{$EditCompany.country|replace:'BW':'Botswana'}
                                            {elseif $EditCompany.country == 'BV'}{$EditCompany.country|replace:'BV':'Bouvet'}
                                            {elseif $EditCompany.country == 'BR'}{$EditCompany.country|replace:'BR':'Brazil'}
                                            {elseif $EditCompany.country == 'IO'}{$EditCompany.country|replace:'IO':'British Indian Ocean Territory'}
                                            {elseif $EditCompany.country == 'BN'}{$EditCompany.country|replace:'BN':'Brunei Darussalam'}
                                            {elseif $EditCompany.country == 'BG'}{$EditCompany.country|replace:'BG':'Bulgaria'}
                                            {elseif $EditCompany.country == 'BF'}{$EditCompany.country|replace:'BF':'Burkina Faso'}
                                            {elseif $EditCompany.country == 'BI'}{$EditCompany.country|replace:'BI':'Burundi'}
                                            {elseif $EditCompany.country == 'KH'}{$EditCompany.country|replace:'KH':'Cambodia'}
                                            {elseif $EditCompany.country == 'CM'}{$EditCompany.country|replace:'CM':'Cameroon'}
                                            {elseif $EditCompany.country == 'CA'}{$EditCompany.country|replace:'CA':'Canada'}
                                            {elseif $EditCompany.country == 'CV'}{$EditCompany.country|replace:'CV':'Cape Verde'}
                                            {elseif $EditCompany.country == 'KY'}{$EditCompany.country|replace:'KY':'Cayman Islands'}
                                            {elseif $EditCompany.country == 'CF'}{$EditCompany.country|replace:'CF':'Central African Republic'}
                                            {elseif $EditCompany.country == 'TD'}{$EditCompany.country|replace:'TD':'Chad'}
                                            {elseif $EditCompany.country == 'CL'}{$EditCompany.country|replace:'CL':'Chile'}
                                            {elseif $EditCompany.country == 'CN'}{$EditCompany.country|replace:'CN':'China'}
                                            {elseif $EditCompany.country == 'CX'}{$EditCompany.country|replace:'CX':'Christmas Island'}
                                            {elseif $EditCompany.country == 'CC'}{$EditCompany.country|replace:'CC':'Cocos (Keeling) Islands'}
                                            {elseif $EditCompany.country == 'CO'}{$EditCompany.country|replace:'CO':'Colombia'}
                                            {elseif $EditCompany.country == 'KM'}{$EditCompany.country|replace:'KM':'Comoros'}
                                            {elseif $EditCompany.country == 'CG'}{$EditCompany.country|replace:'CG':'Congo'}
                                            {elseif $EditCompany.country == 'CD'}{$EditCompany.country|replace:'CD':'Congo, Democratic Republic'}
                                            {elseif $EditCompany.country == 'CK'}{$EditCompany.country|replace:'CK':'Cook Islands'}
                                            {elseif $EditCompany.country == 'CR'}{$EditCompany.country|replace:'CR':'Costa Rica'}
                                            {elseif $EditCompany.country == 'HR'}{$EditCompany.country|replace:'HR':'Croatia'}
                                            {elseif $EditCompany.country == 'CU'}{$EditCompany.country|replace:'CU':'Cuba'}
                                            {elseif $EditCompany.country == 'CY'}{$EditCompany.country|replace:'CY':'Cyprus'}
                                            {elseif $EditCompany.country == 'CZ'}{$EditCompany.country|replace:'CZ':'Czech Republic'}
                                            {elseif $EditCompany.country == 'DK'}{$EditCompany.country|replace:'DK':'Denmark'}
                                            {elseif $EditCompany.country == 'DM'}{$EditCompany.country|replace:'DM':'Dominica'}
                                            {elseif $EditCompany.country == 'DO'}{$EditCompany.country|replace:'DO':'Dominican Republic'}
                                            {elseif $EditCompany.country == 'EC'}{$EditCompany.country|replace:'EC':'Ecuador'}
                                            {elseif $EditCompany.country == 'EE'}{$EditCompany.country|replace:'EE':'Estonia'}
                                            {elseif $EditCompany.country == 'EG'}{$EditCompany.country|replace:'EG':'Egypt'}
                                            {elseif $EditCompany.country == 'ES'}{$EditCompany.country|replace:'ES':'Spain'}
                                            {elseif $EditCompany.country == 'FI'}{$EditCompany.country|replace:'FI':'Finland'}
                                            {elseif $EditCompany.country == 'FR'}{$EditCompany.country|replace:'FR':'France'}
                                            {elseif $EditCompany.country == 'GB'}{$EditCompany.country|replace:'GB':'United Kingdom'}
                                            {elseif $EditCompany.country == 'GH'}{$EditCompany.country|replace:'GH':'Ghana'} 
                                            {elseif $EditCompany.country == 'GR'}{$EditCompany.country|replace:'GR':'Greece'} 
                                            {elseif $EditCompany.country == 'GT'}{$EditCompany.country|replace:'GT':'Guatemala'} 
                                            {elseif $EditCompany.country == 'HK'}{$EditCompany.country|replace:'HK':'Hong Kong'} 
                                            {elseif $EditCompany.country == 'HR'}{$EditCompany.country|replace:'HR':'Croatia'} 
                                            {elseif $EditCompany.country == 'HU'}{$EditCompany.country|replace:'HU':'Hungary'} 
                                            {elseif $EditCompany.country == 'ID'}{$EditCompany.country|replace:'ID':'Indonesia'} 
                                            {elseif $EditCompany.country == 'IE'}{$EditCompany.country|replace:'IE':'Ireland'} 
                                            {elseif $EditCompany.country == 'IL'}{$EditCompany.country|replace:'IL':'Israel'} 
                                            {elseif $EditCompany.country == 'IN'}{$EditCompany.country|replace:'IN':'India'}
                                            {elseif $EditCompany.country == 'IT'}{$EditCompany.country|replace:'IT':'Italy'} 
                                            {elseif $EditCompany.country == 'JP'}{$EditCompany.country|replace:'JP':'Japan'}
                                            {elseif $EditCompany.country == 'KE'}{$EditCompany.country|replace:'KE':'Kenya'} 
                                            {elseif $EditCompany.country == 'LK'}{$EditCompany.country|replace:'LK':'Falkland Islands (Malvinas)'}
                                            {elseif $EditCompany.country == 'LU'}{$EditCompany.country|replace:'LU':'Luxembourg'} 
                                            {elseif $EditCompany.country == 'MX'}{$EditCompany.country|replace:'MX':'Mexico'}
                                            {elseif $EditCompany.country == 'MY'}{$EditCompany.country|replace:'MY':'Malaysia'} 
                                            {elseif $EditCompany.country == 'NL'}{$EditCompany.country|replace:'NL':'Netherlands'}
                                            {elseif $EditCompany.country == 'NO'}{$EditCompany.country|replace:'NO':'Norway'} 
                                            {elseif $EditCompany.country == 'NZ'}{$EditCompany.country|replace:'NZ':'New Zealand'}
                                            {elseif $EditCompany.country == 'NG'}{$EditCompany.country|replace:'NG':'Nigeria'}    
                                            {elseif $EditCompany.country == 'PH'}{$EditCompany.country|replace:'PH':'Philippines'} 
                                            {elseif $EditCompany.country == 'PK'}{$EditCompany.country|replace:'PK':'Pakistan'}
                                            {elseif $EditCompany.country == 'PL'}{$EditCompany.country|replace:'PL':'Poland'} 
                                            {elseif $EditCompany.country == 'RO'}{$EditCompany.country|replace:'RO':'Romania'}
                                            {elseif $EditCompany.country == 'RS'}{$EditCompany.country|replace:'RS':'Serbia'}
                                            {elseif $EditCompany.country == 'SG'}{$EditCompany.country|replace:'SG':'Singapore'}
                                            {elseif $EditCompany.country == 'TH'}{$EditCompany.country|replace:'TH':'Thailand'}
                                            {elseif $EditCompany.country == 'TR'}{$EditCompany.country|replace:'TR':'Turkey'}
                                            {elseif $EditCompany.country == 'UA'}{$EditCompany.country|replace:'UA':'Ukraine'}
                                            {elseif $EditCompany.country == 'US'}{$EditCompany.country|replace:'US':'United States'}    
                                            {elseif $EditCompany.country == 'ZA'}{$EditCompany.country|replace:'ZA':'Kazakhstan'}
                                            {else}{$EditCompany.country}  
                                            {/if}
                        </td>
                    </tr>
                    <tr>
                        <td>Company Name</td>
                        <td class="cell-border">{$EditCompany.company_name} </td>
                    </tr>
                    <tr>
                        <td>Logo</td>
                        <td class="cell-border">{if $EditCompany.logo ==''}-{else}<img src="/templates/netwaybysidepad/images/{$EditCompany.logo} "alt="" style="max-height: 100px;max-width: 300px;">{/if}</td>
                    </tr>
                    <tr>
                        <td>Website URL</td>
                        
                        <td class="cell-border"><a href="https://www.{$EditCompany.web_url|replace:'www.':''}" target="_blank">{$EditCompany.web_url} </a></td>
                    </tr>
                   <tr>
                        <td>Brief Info</td>
                        <td class="cell-border">{$EditCompany.title} </td>
                    </tr>
                    <tr>
                        <td>Client Detail</td>
                        <td class="cell-border"><a href="?cmd=clients&action=show&id={$EditCompany.client_id}" target="_blank">Detail</a></td>
                    </tr>
                    <tr>
                        <td>New Submitted Detail</td>
                        <td class="cell-border">
                            {if $EditCompany.status_edit_company == 0}
                            <span style="color: red">Waiting for Approval Edit Details</span>
                           {else}
                            <span style="color: green">Already Approved</span>
                          {/if}
                          
                       </td>
                    </tr>
                    {if $EditCompany.status_edit_company == 0}
                    <tr>
                        <td colspan="2">
                       <center><button type="submit" class="approve" onclick="approveEditData()">Approve</button> </center>
                       </td>
                    </tr>
                 
                {/if}
                </tbody>
            </table>
          {/if}
      
    </div> 
</div> 
{literal}
<style>
tr{
    border-left: 1px solid #aba8a8;
    border-right: 1px solid #aba8a8;

}
td{
    border-left: 1px solid #aba8a8;
    border-right: 1px solid #aba8a8;
    border-top: 1px solid #aba8a8 !important;
}
*{
  box-sizing: border-box;
}

.container {
  padding: 16px;
  background-color: white;
  
}


input[type=text], input[type=password] {
  width: 100%;
  padding: 15px;
  margin: 5px 0 22px 0;
  display: inline-block;
  border: none;
  background: #f1f1f1;
}

input[type=text]:focus, input[type=password]:focus {
  background-color: #ddd;
  outline: none;
}

hr {
  border: 1px solid #f1f1f1;
  margin-bottom: 25px;
}


.approve {
  background-color: #FFFFFF;
  color: #00681C;
  padding: 9px 0px;
  margin: 5px 0;
  border: none;
  cursor: pointer;
  width: 22%;
  font-size : 18px;
  border: 1px solid #0E7300;
}

.approve:hover {
  background-color: #4CAF50;
  color: white;  
  font-size : 18px;
  border: 1px solid #0E7300;
}

a {
  color: dodgerblue;
}

.signin {
  background-color: #f1f1f1;
  text-align: center;
}
</style>
 <script type="text/javascript">
    function approve() {
        var clientID = $('.clientID').text();  
        console.log(clientID);
        $.post( "?cmd=hostpartnerhandle&action=ApproveCompany", 
        {
            clientID        : clientID
        },function(data) {
          location.reload();
   });
}

function approveEditData() {
        var clientID = $('.clientID').text();  
        console.log(clientID);
        $.post( "?cmd=hostpartnerhandle&action=EditCompany", 
        {
            clientID        : clientID
        },function(data) {
          location.reload();
   });
}
    </script>
{/literal}
    
