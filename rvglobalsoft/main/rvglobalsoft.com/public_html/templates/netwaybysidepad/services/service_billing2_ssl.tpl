{if $service.allowsubmitcsr}
{literal}
<style>
.divTable {
    display:  table;
    width: 100%;
    background-color:#e4e4e4;
    border:0px solid  #dfdfdf;
    border-spacing:5px;
    padding:10px 0px;
    /*cellspacing:poor IE support for  this*/
    /* border-collapse:separate;*/
}
.divRow {
    display:table-row;
    width:auto;
}
.divCell {
    float:left;/*fix for  buggy browsers*/
    display:table-column;
    width:auto;
    text-align: left;
    padding-left: 10px;
    /* background-color:#ccc; */
}

#progressBar {
        width: 400px;
        height: 22px;
        border: 1px solid #111;
        background-color: #292929;
}
#progressBar div {
        height: 100%;
        color: #fff;
        text-align: right;
        line-height: 22px; /* same as #progressBar height if we want text middle aligned */
        width: 0;
        background-color: #0099ff;
}
</style>
<script type="text/javascript">
    $("#upload_csr").live( 'change', function () {
      $("#submit_upload_csr").click();
      $('#form_upload_csr').trigger("reset");
  });

  $("#form_upload_csr").submit(function(){
         var formObj = $(this);
                var formURL = formObj.attr("action");
                var formData = new FormData(this);
                $.ajax({
                    url: formURL,
                    type: 'POST',
                    data:  formData,
                    mimeType:"multipart/form-data",
                    contentType: false,
                    cache: false,
                    processData:false,
                    dataType: 'json',
                success: function(data)
                {
                    //console.log(data);
                    if (data.aResponse == undefined) {
                        alert('ERROR: Cannot get response!!');
                        return false;
                    } else {
                        aResponse = data.aResponse;
                    }

                    if (aResponse.status != undefined && aResponse.status == 'ERROR') {
                        alert('ERROR: ' + aResponse.message);
                        return false;
                    } else if (aResponse.status != undefined && aResponse.status == 'success') {
                       $("#csr_data").val(aResponse.message);
                    } else {
                        alert('ERROR: Cannot process !!');
                        return false;
                    }
                }
                });
  });

    function tosubmitCsr(id){
           $(".step0").hide();
           $(".step1").show();
        }

    $(document).ready(function(){

        $(".validate_button").click(function(){
            validateCsr('{/literal}{$service.ssl_id}{literal}',$("#csr_data").val());
            //$("#progressBar").show();
            $("#csr_errorblock").show();
        });
        $('.step1').hide();
        $('.step2').hide();
        $('.step3').hide();

        $(".back_on_step1").click(function(){
            $('.step0').show();
            $('.step1').hide();
            $('html, body').animate({ scrollTop: 0 }, 'fast');
        });

        $(".back_on_step2").click(function(){
            $('.step1').show();
            $('.step2').hide();
            $('.step3').hide();
            $('html, body').animate({ scrollTop: 0 }, 'fast');
        });

        $("#ch_same_address").change(function() {
            $(".not_same_address").toggle();
        });
                    /*order_id = {$service.order_id};
                    ssl_id = {$service.ssl_id};
        alert('{/literal}{$system_url}{literal}');
        alert('{/literal}{$service.order_id}{literal}');
        alert('{/literal}{$service.ssl_id}{literal}');*/
        $("#frmMr").submit(function(){
            var filteremail     = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9])+$/;
            //var validateSAN     = /^(www.)*([a-zA-Z0-9]{1,})[\.](([a-zA-Z0-9\-]{2,})|([a-zA-Z0-9\-]{2,}[\.]{1,}[a-zA-Z0-9\-]{2,})){1,}$/;
            var validateSAN = /^([a-zA-Z0-9\-]*\.){0,}[a-zA-Z0-9\-]*(\.[a-zA-Z\-]{2,5})?\.[a-zA-Z]{2,3}$/;
            var vaAlpha = /^([\d\w\s\.,]{0,})$/;
            vaAlpha = /^[a-zA-Z0-9\,\.\\\/\_\-\s]*$/;
            var validateContact = /^[a-zA-Z0-9\.\\\/\_\-\s]*$/;
            var validateOrganize = /^[a-zA-Z0-9\,\.\\\/\_\-\s@&!()\']*$/;
            var validateAddress = /^[a-zA-Z0-9\,\.\\\/\_\-\s@()\']*$/;
            var countryJPError = "We are really sorry, SSL Certificate in your order cannot be sold with any domain name contains a .JP extension, or administrative, billing or organizational address located in Japan.<br>Please contact <a href='https://rvglobalsoft.com/tickets/new&deptId=3'>RVStaff</a>";
            var sanSum = 0;
            var sanCount = 0;

            $("#admin_error_div").hide();
            $("#admin_error_text").html("");
            $("#tech_error_div").hide();
            $("#tech_error_text").html("");
            $('#adminContactDiv').css('height', '100%');
            $('#techContactDiv').css('height', '100%');
            $('#validate_button').prop('disabled', true);

            var commonName = $('#csr_commonname').text();
            var dnsChk = [];
            var pCode = '{/literal}{$service.ssl_productcode}{literal}';
            if(pCode == 'QuickSSLPremium'){
                validateSAN = /^(www.)*([a-zA-Z0-9\.]{1,})([a-zA-Z0-9]){1,}$/;
            }

            var sanDomain = $("input[name='dnsName[]']").map(function(){
                return $(this).val();
            }).get();

            var sanId = $("input[name='dnsName[]']").map(function(){
                    return $(this).attr('id');
            }).get();

            var sanCheck = {};
            var haveSAN = false;
            for(i = 0; i < sanDomain.length; i++){
                sanCheck[sanId[i]] = sanDomain[i];
                if(sanDomain[i].trim() != ''){
                    haveSAN = true;
                }
            }

            console.log(sanCheck);

            var support_san = '{/literal}{$supportSan}{literal}';

            if(typeof support_san != 'undefined' && support_san){
                var sanAdd = '{/literal}{$sanAmount}{literal}';
                var sanIncluded = '{/literal}{$sanFirst}{literal}';
                var sanChk = 0;
                sanSum = sanAdd+sanIncluded-1;
            }

            if(haveSAN){
                for(key in sanCheck){
                    var chkDomain = $('#' + key).val();
                    chkDomain = chkDomain.trim();
                    if(chkDomain != '' && pCode == 'QuickSSLPremium'){
                        chkDomain = chkDomain + '.' + commonName;
                    }
                    if(chkDomain == '' && sanAdd > 0){
                        alert("Please complete each domain name field before submitting form.");
                        $('#' + key).focus();
                        return false;
                    }

                    if(chkDomain != ''){
                        sanCount++;
                        if(dnsChk.indexOf(sanCheck[key]) >= 0 || sanCheck[key] == commonName){
                            alert('You cannot order the duplicated domain name.');
                            $('#' + key).focus();
                            return false;
                        } else if(!validateSAN.test(chkDomain)){
                            //alert($('#text' + key).text() + ' : invalid domain name.');
                            alert('Invalid domain name.');
                            $('#' + key).focus();
                            return false;
                        } else if(chkDomain.toLowerCase().substring(chkDomain.lastIndexOf('.'), chkDomain.length) == '.jp'){
                            alert('Sorry, any domain names registered with .jp extension as sample "' + chkDomain + '", will not be able to order SSL Certificate here.');
                            $('#sanDomain' + (i+1)).focus();
                            return false;
                        } else {
                            dnsChk.push(sanCheck[key]);
                        }
                    }
                    sanChk++;
                }
            } else if(support_san && sanAdd == 0 && sanSum > 0){
                alert('SAN package requires at least 1 domain name. Please insert the domain name in the field before submitting the order.');
                $('#dnsName_1').focus();
                return false;
            } else if(support_san && sanSum > 0 && sanAdd != sanCount){
                alert("Please complete each domain name field before submitting form.");
                $('#dnsName_1').focus();
                return false;
            }

            var organizeCheck = {o_name: 'Organization Name', o_phone: 'Phone Number', o_address: 'Address', o_city: 'City', o_state: 'State/Province', o_country: 'Country', o_postcode: 'Postal Code'};

            for(key in organizeCheck){
                if(typeof $('#' + key).val() != 'undefined' && $('#' + key).val() == '' && key != 'o_country'){
                    alert('Organize : Field \'' + organizeCheck[key] + '\' required.');
                    $('#' + key).focus();
                    return false;
                } else if(typeof $('#' + key).val() != 'undefined' && $('#' + key).val() == ''){
                    alert('Organize : Field \'' + organizeCheck[key] + '\' required, please select one.');
                    $('#' + key).focus();
                    return false;
                } else if(key == 'o_country' && typeof $('#' + key).val() != 'undefined' && $('#' + key).val() == 'JP'){
                    alert('We are really sorry, SSL Certificate in your order cannot be sold with any domain name contains a .JP extension, or administrative, billing or organizational address located in Japan.');
                    $('#' + key).focus();
                    return false;
                } else if(key == 'o_address' && validateAddress.test($("#" + key).val()) == false){
		        	alert('Field \'' + organizeCheck[key] + '\' invalid characters.');
		            $('#' + key).focus();
		            return false;
		        } else if((key == 'o_name') && validateOrganize.test($('#' + key).val()) == false){
		            alert('Field \'' + organizeCheck[key] + '\' invalid characters.');
		            $('#' + key).focus();
		            return false;
                } else if((key == 'o_city' || key == 'o_state') && vaAlpha.test($('#' + key).val()) == false){
                    alert('Organize : Field \'' + organizeCheck[key] + '\' require english only.');
                    $('#' + key).focus();
                    return false;
                } else if(typeof $('#' + key).val() != 'undefined' && key == 'o_phone' && $('#' + key).val().replace(/[^\+0-9\.]/g,'').trim().match(/.*[0-9]+.*/) == null){
                    alert('Field \'' + organizeCheck[key] + '\' have no numeric character.');
                    $('#' + key).focus();
                    return false;
                }
            }

            var contactCheck = {txt_name: 'First name', txt_lastname: 'Last name', txt_email: 'Email Address', txt_org: 'Organization Name', txt_job: 'Job Title', txt_address: 'Address', txt_city: 'City', txt_state: 'State/Region', txt_country: 'Country', txt_post: 'Postal Code', txt_tel: 'Phone Number'};

            for(key in contactCheck){
                if(typeof $('#' + key).val() != 'undefined' && $('#' + key).val() == ''){
                    alert('Field \'' + contactCheck[key] + '\' required.');
                    $('#' + key).focus();
                    return false;
                } else if(key == 'txt_country' && $('#' + key).val() == 'JP'){
                    alert('We are really sorry, SSL Certificate in your order cannot be sold with any domain name contains a .JP extension, or administrative, billing or organizational address located in Japan.');
                    $('#' + key).focus();
                    return false;
                } else if((key == 'txt_name' || key == 'txt_lastname' || key == 'txt_org' || key == 'txt_job' || key == 'txt_address' || key == 'txt_city' || key == 'txt_state') && (vaAlpha.test($('#' + key).val()) == false)){
                    alert('Field \'' + contactCheck[key] + '\' invalid characters.');
                    $('#' + key).focus();
                    return false;
                } else if(key == 'txt_tel' && $('#' + key).val().replace(/[^\+0-9\.]/g,'').trim().match(/.*[0-9]+.*/) == null){
                    alert('Field \'' + contactCheck[key] + '\' have no numeric character.');
                    $('#' + key).focus();
                    return false;
                }
            }


            if( $('#techInfoType').val() == 'sameAdmin'){
                $('#txt_name_1').val($('#txt_name').val());
                $('#txt_lastname_1').val($('#txt_lastname').val());
                $('#txt_email_1').val($('#txt_email').val());
                $('#txt_org_1').val($('#txt_org').val());
                $('#txt_address_1').val($('#txt_address').val());
                $('#txt_city_1').val($('#txt_city').val());
                $('#txt_state_1').val($('#txt_state').val());
                $('#txt_country_1').val($('#txt_country').val());
                $('#txt_post_1').val($('#txt_post').val());
                $('#txt_tel_1').val($('#txt_tel').val());
                $('#txt_job_1').val($('#txt_job').val());
                $('#txt_ext_1').val($('#txt_ext').val());
            } else {
                for(key in contactCheck){
                    if(typeof $('#' + key + '_1').val() != 'undefined' && $('#' + key + '_1').val() == ''){
                        alert('Field \'' + contactCheck[key] + '\' required.');
                        $('#' + key + '_1').focus();
                        return false;
                    } else if(key == 'txt_country' && $('#' + key + '_1').val() == 'JP'){
                        alert('We are really sorry, SSL Certificate in your order cannot be sold with any domain name contains a .JP extension, or administrative, billing or organizational address located in Japan.');
                        $('#' + key + '_1').focus();
                        return false;
                    } else if((key == 'txt_name' || key == 'txt_lastname' || key == 'txt_org' || key == 'txt_job' || key == 'txt_address' || key == 'txt_city' || key == 'txt_state') && (vaAlpha.test($('#' + key + '_1').val()) == false)){
                        alert('Field \'' + contactCheck[key] + '\' invalid characters.');
                        $('#' + key + '_1').focus();
                        return false;
                    } else if(key == 'txt_tel' && $('#' + key + '_1').val().replace(/[^\+0-9\.]/g,'').trim().match(/.*[0-9]+.*/) == null){
                        alert('Field \'' + contactCheck[key] + '\' have no numeric character.');
                        $('#' + key).focus();
                        return false;
                    }
                }
            }

            if(typeof $('#o_phone').val() != 'undefined'){
                $('#o_phone').val($('#o_phone').val().replace(/[^\+0-9\.]/g, ''));
            }
            $('#txt_tel').val($('#txt_tel').val().replace(/[^\+0-9\.]/g, ''));
            $('#txt_tel_1').val($('#txt_tel_1').val().replace(/[^\+0-9\.]/g, ''));
                    //updateCSR();
                    //return true;

            $('#loadingImg').show();

                $('#ojob').val('');
                    //}
                    //updateCSR();
                    //return true;

            var formObj = $(this);
            var formURL = formObj.attr("action");
            var formData = new FormData(this);
            $.ajax({
                url: formURL,
                type: 'POST',
                data:  formData,
                mimeType:"multipart/form-data",
                contentType: false,
                cache: false,
                processData:false,
                dataType: 'json',
                success: function(data)
                {
                    if (typeof data.aResponse == 'undefined') {
                        alert('ERROR: Cannot get response!!');
                        return false;
                    } else {
                        aResponse = data.aResponse;
                    }

                    if (aResponse.status != undefined && aResponse.status == 'ERROR') {
                        alert('ERROR: ' + aResponse.message);
                        return false;
                    } else if (aResponse.status != undefined && aResponse.status == 'success') {
                        alert(aResponse.message);
                        window.location.reload();
                    } else {
                        alert('ERROR: Cannot process !!');
                        return false;
                    }
                }
            });
        });

    });

    function validateCsr(sslId, csr)
    {
        $('.step1').addLoader();
        var RVL_BASEURL = "{/literal}{$system_url}{literal}";
        progress(10, $( '#progressBar'));
        writeCsrError('');
        $.ajax({
            type: "POST"
            , url: RVL_BASEURL
            , data: {
                cmd: 'module'
                , module: 'ssl'
                , action: 'ajax_parse_csr'
                , ssl_id: sslId
                , csr: csr
                }
            , success: function(data) {
                console.log(data);
                progress(40, $( '#progressBar'));
                if (data.aResponse == undefined) {
                    writeCsrError("Cannot get response from api!!");
                    return false;
                } else {
                    csrData = data.aResponse;
                }

                if (!csrData.Status) {
                    writeCsrError(csrData.Error[0].ErrorMessage);
                    return false;
                }

                if (csrData.Status != undefined && csrData.Status) {
                    progress(50, $('#progressBar'));
                    arrayCsrKey = ['CN', 'O', 'OU', 'L', 'ST', 'C', 'KeyAlgorithm', 'KeyLength', 'Signature'];
                    arrayCsrKey = ['CommonName', 'Organization', 'OrganizationUnit', 'Locality', 'State', 'Country', 'KeyAlgorithm', 'SignatureAlgorithm'];
                    if (csrData.Status != undefined) {
                        onError = 0;

                        if(csrData.CommonName.toLowerCase().search('.jp') == -1){
                            for(key in csrData){
                                if(csrData[key] == '' || typeof csrData[key] == 'undefined'){
                                    csrData[key] = '-';
                                }
                            }
                            $('#csr_commonname').text(csrData.CommonName);
                            $('#commonname').val(csrData.CommonName);
                            $('#csr_organization').text(csrData.Organization);
                            $('#csr_organization_unit').text(csrData.OrganizationUnit);
                            $('#csr_location').text(csrData.Locality);
                            $('#csr_state').text(csrData.State);
                            $('#csr_country').text(csrData.Country);
                            $('#csr_email').text(csrData.Email);
                            $('#csr_key_algorithm').text(csrData.KeyAlgorithm);
                            $('#csr_signature_algorithm').text(csrData.SignatureAlgorithm);
                            $('.sanCommonName').text('.' + csrData.CommonName);

                            if(csrData.DNSNames){
                                for(i = 0; i < csrData.DNSNames.length; i++){
                                    var count = i+1;
                                    if(csrData.DNSNames[i] != '-'){
                                        $('#dnsName_' + count).val(csrData.DNSNames[i]);
                                    } else {
                                        $('#dnsName_' + count).val('');
                                    }
                                }
                            }
                        } else {
                            writeCsrError("Sorry, any CSR generated with the common name as .jp extension as your \"" + csrData['CommonName'] + "\" cannot be ordered SSL Certificate here.");
                            onError = 1;
                        }


                        if (onError == 0) {
                            progress(60, $('#progressBar'));
                            $.ajax({
                                type: "POST"
                                , url: RVL_BASEURL
                                , data: {
                                    cmd: 'module'
                                    , module: 'ssl'
                                    , action: 'getwhoisdomain'
                                    , domain: csrData.CommonName
                                }
                                , success: function(data) {
                                    console.log(data);
                                    progress(80, $('#progressBar'));

                                   if (data.aResponse == undefined) {
                                                writeCsrError("Cannot get response from api!!");
                                                return false;
                                            }

                                    whoisData = data.aResponse;
                                    regrinfo = {
                                        owner: {},
                                        tech: {},
                                        admin: {}
                                    };

                                    if(typeof whoisData.admin != 'undefined'){
                                        if(typeof whoisData.admin.firstName != 'undefined'){
                                            $('#txt_name').val(whoisData.admin.firstName);
                                        }
                                        if(typeof whoisData.admin.lastName != 'undefined' && whoisData.admin.lastName != null){
                                            $('#txt_lastname').val(whoisData.admin.lastName);
                                        }
                                        if(typeof whoisData.admin.email != 'undefined' && whoisData.admin.email != null){
                                            $('#txt_email').val(whoisData.admin.email);
                                        }
                                        if(typeof whoisData.admin.organization != 'undefined' && whoisData.admin.organization != null){
                                            $('#txt_org').val(whoisData.admin.organization);
                                        }
                                        if(typeof whoisData.admin.address != 'undefined' && whoisData.admin.address != null){
                                            $('#txt_address').val(whoisData.admin.address);
                                        }
                                        if(typeof whoisData.admin.city != 'undefined' && whoisData.admin.city != null){
                                            $('#txt_city').val(whoisData.admin.city);
                                        }
                                        if(typeof whoisData.admin.state != 'undefined' && whoisData.admin.state != null){
                                            $('#txt_state').val(whoisData.admin.state);
                                        }
                                        if(typeof whoisData.admin.country != 'undefined' && whoisData.admin.country != null){
                                            $('#txt_country').val(whoisData.admin.country);
                                        }
                                        if(typeof whoisData.admin.postal != 'undefined' && whoisData.admin.postal != null){
                                            $('#txt_post').val(whoisData.admin.postal);
                                        }
                                        if(typeof whoisData.admin.phone != 'undefined' && whoisData.admin.phone != null){
                                            $('#txt_tel').val(whoisData.admin.phone);
                                        }
                                        $('#txt_job').val('');
                                        $('#txt_ext').val('');
                                    }

                                    if(typeof whoisData.owner != 'undefined'){
                                        if(typeof whoisData.owner.firstName != 'undefined' && whoisData.owner.firstName != null){
                                            $('#oname').val(whoisData.owner.firstName);
                                        }
                                        if(typeof whoisData.owner.lastName != 'undefined' && whoisData.owner.lastName != null){
                                            $('#olastname').val(whoisData.owner.lastName);
                                        }
                                        if(typeof whoisData.owner.email != 'undefined' && whoisData.owner.email != null){
                                            $('#oemail').val(whoisData.owner.email);
                                        }
                                        if(typeof whoisData.owner.organization != 'undefined' && whoisData.owner.organization != null){
                                            $('#oorg').val(whoisData.owner.organization);
                                        }
                                        if(typeof whoisData.owner.phone != 'undefined' && whoisData.owner.phone != null){
                                            $('#otel').val(whoisData.owner.phone);
                                        }
                                        if(typeof whoisData.owner.address != 'undefined' && whoisData.owner.address != null){
                                            $('#oaddress').val(whoisData.owner.address);
                                        }
                                        if(typeof whoisData.owner.city != 'undefined' && whoisData.owner.city != null){
                                            $('#ocity').val(whoisData.owner.city);
                                        }
                                        if(typeof whoisData.owner.state != 'undefined' && whoisData.owner.state != null){
                                            $('#ostate').val(whoisData.owner.state);
                                        }
                                        if(typeof whoisData.owner.country != 'undefined' && whoisData.owner.country != null){
                                            $('#ocountry').val(whoisData.owner.country);
                                        }
                                        if(typeof whoisData.owner.postal != 'undefined' && whoisData.owner.postal != null){
                                            $('#opost').val(whoisData.owner.postal);
                                        }
                                        $('#ojob').val('');
                                        $('#oext').val('');
                                    }

                                    $.ajax({
                                        type: "POST"
                                        , url: RVL_BASEURL
                                        , data: {
                                            cmd: 'module'
                                            , module: 'ssl'
                                            , action: 'ajax_getemaillist'
                                            , domain: csrData.CommonName
                                        }
                                        , success: function(data) {
                                            emailApprovalList = data.aResponse;
                                            emailApprovalOtp = '';
                                            var emailApprovalDup = [];
                                            var emailApprovalKey = [];

                                            for(i = 0; i < emailApprovalList.length; i++){
                                                splitEmail = emailApprovalList[i].split('@');
                                                if(typeof emailApprovalDup[splitEmail[1]] == 'undefined'){
                                                    emailApprovalDup[splitEmail[1]] = [];
                                                    emailApprovalKey.push(splitEmail[1]);
                                                }
                                                emailApprovalDup[splitEmail[1]].push(emailApprovalList[i]);
                                            }

                                            ind = 1;
                                            for(j = 0; j < emailApprovalKey.length; j++){
                                                headChk = 0;
                                                for(i = 0; i < emailApprovalDup[emailApprovalKey[j]].length; i++){
                                                    if(headChk == 0){
                                                        if(emailApprovalDup[emailApprovalKey[j]].length <= 2){
                                                            emailApprovalOtp = emailApprovalOtp + '<b>Registered Domain Contacts</b><br>';
                                                            headChk = 1;
                                                        } else {
                                                            switch(emailApprovalKey[j].split('.').length){
                                                                case 2:
                                                                    emailApprovalOtp = emailApprovalOtp + '<b>Level 2 Domain Addresses</b><br>';
                                                                    headChk = 1;
                                                                    break;
                                                                case 3:
                                                                    emailApprovalOtp = emailApprovalOtp + '<b>Level 3 Domain Addresses</b><br>';
                                                                    headChk = 1;
                                                                    break;
                                                                case 4:
                                                                    emailApprovalOtp = emailApprovalOtp + '<b>Level 4 Domain Addresses</b><br>';
                                                                    headChk = 1;
                                                                    break;
                                                            }
                                                        }
                                                    }
                                                    emailApprovalOtp = emailApprovalOtp
                                                        + '<label for="email_approval_' + ind + '">'
                                                        + '<input type="radio" id="email_approval_' + ind
                                                        + '" name="email_approval" value="'+ emailApprovalDup[emailApprovalKey[j]][i] +'" />'
                                                        + emailApprovalDup[emailApprovalKey[j]][i] + '</label><br>';
                                                    ind = ind+1;
                                                }
                                                emailApprovalOtp = emailApprovalOtp + '<br>';
                                            }

                                            $('#whois_emailinfo').html(emailApprovalOtp);
                                            $('#email_approval_1').attr('checked','checked');

                                            progress(90, $('#progressBar'));
                                            domainDetail = '';

                                            if (domainDetail == '') {
                                                 domainDetail = '<font color="red"><b>Cannot found domain owner in the WHOIS information for your domain name, please Update WHOIS Information.</b></font>';
                                            }

                                            $('#whois_domaininfo').html(domainDetail);
                                            progress(100, $('#progressBar'));
                                            $('.step1').hide();
                                            $('.step2').show();
                                            $('.step3').show();
                                            $("#progressBar").hide();
                                            $("#csr_errorblock").hide();
                                            $('#preloader').remove();
                                            $(".order_button").show();
                                            $(".back_on_step2").show();

                                            var clientContact = JSON.parse($('#client_login_info').val());
                                            $(".not_same_address").show();
                                            $('#techContactDiv').css('padding-bottom', '');
                                            $('#txt_name_1').val(clientContact.firstname);
                                            $('#txt_lastname_1').val(clientContact.lastname);
                                            $('#txt_email_1').val(clientContact.email);
                                            $('#txt_org_1').val(clientContact.companyname);
                                            $('#txt_address_1').val(clientContact.address);
                                            $('#txt_city_1').val(clientContact.city);
                                            $('#txt_state_1').val(clientContact.state);
                                            $('#txt_country_1').val(clientContact.country);
                                            $('#txt_post_1').val(clientContact.postcode);
                                            $('#txt_tel_1').val(clientContact.phonenumber);
                                            $('#txt_job_1').val(clientContact.job);
                                            $('#txt_ext_1').val(clientContact.ext);

                                            $('#techInfoType').change(function(){
                                                var firstname = $('#txt_name').val();
                                                var lastname = $('#txt_lastname').val();
                                                var email = $('#txt_email').val();
                                                var organization = $('#txt_org').val();
                                                var address = $('#txt_address').val();
                                                var city = $('#txt_city').val();
                                                var state = $('#txt_state').val();
                                                var country = $('#txt_country').val();
                                                var postal = $('#txt_post').val();
                                                var phone = $('#txt_tel').val();
                                                var title = $('#txt_job').val();
                                                var ext= $('#txt_ext').val();

                                                switch($('#techInfoType').val()){
                                                    case 'sameAdmin' :
                                                        $(".not_same_address").hide();
                                                        $('#techContactDiv').css('padding-bottom', '0px');
                                                        break;
                                                    case 'sameBilling' :
                                                        clientContact = JSON.parse($('#client_login_info').val());
                                                        $(".not_same_address").show();
                                                        $('#techContactDiv').css('padding-bottom', '');
                                                        firstname = clientContact.firstname;
                                                        lastname = clientContact.lastname;
                                                        email = clientContact.email;
                                                        organization = clientContact.companyname;
                                                        address = clientContact.address;
                                                        city = clientContact.city;
                                                        state = clientContact.state;
                                                        country = clientContact.country;
                                                        postal = clientContact.postcode;
                                                        phone = clientContact.phonenumber;
                                                        title = clientContact.job;
                                                        ext= clientContact.ext;
                                                        break;
                                                    case 'sameTech' :
                                                        $(".not_same_address").show();
                                                        $('#techContactDiv').css('padding-bottom', '');
                                                        firstname = whoisData.tech.firstName;
                                                        lastname = whoisData.tech.lastName;
                                                        email = whoisData.tech.email;
                                                        organization = whoisData.tech.organization;
                                                        address = whoisData.tech.address;
                                                        city = whoisData.tech.city;
                                                        state = whoisData.tech.state;
                                                        country = whoisData.tech.country;
                                                        postal = whoisData.tech.postal;
                                                        phone = whoisData.tech.phone;
                                                        title = '';
                                                        ext= '';
                                                        break;
                                                }
                                                $('#txt_name_1').val(firstname);
                                                $('#txt_lastname_1').val(lastname);
                                                $('#txt_email_1').val(email);
                                                $('#txt_org_1').val(organization);
                                                $('#txt_address_1').val(address);
                                                $('#txt_city_1').val(city);
                                                $('#txt_state_1').val(state);
                                                $('#txt_country_1').val(country);
                                                $('#txt_post_1').val(postal);
                                                $('#txt_tel_1').val(phone);
                                                $('#txt_job_1').val(title);
                                                $('#txt_ext_1').val(ext);
                                            });
                                        }, error: function(xhr,error){
                                            respError = $.parseJSON(xhr.responseText);
                                            alert("Generate email approval failed!! " + respError.message);
                                        }
                                    });
                                }
                                , error: function(xhr,error) {
                                    respError = $.parseJSON(xhr.responseText);
                                    alert( "Whois API connection has error!! " + respError.message);
                                }
                            });
                        }
                    } else {
                        writeCsrError("Cannot read data info from CSR!!");
                        return false;
                    }
                } else {
                    writeCsrError("Unknow status response!!");
                    return false;
                }
            }
            , error: function(xhr,error) {
                respError = $.parseJSON(xhr.responseText);
                alert( "Whois API connection has error!! " + respError.message);
            }
       });
    }
    function writeCsrError(msg)
    {
        if (msg == '') {
            $( '#csr_errorblock' ).html('');
            $( '#csr_errorblock' ).show();
        } else {
            $('#preloader').remove();
            $( '#csr_errorblock' ).html($( '#csr_errorblock' ).html() + '<p class="message-error"><font color=red><u>Error Message</u> : <br />' + msg + '</font></p>');
            $( '#csr_errorblock' ).css('background-color', '#EEE');
        }
    }

    function writeCsrData(id, val)
    {
        $( '#' + id + '_data').html(val);
    }

    function writeCsrStatus(id, val)
    {
        code = '';
        if (val == 0) {
            code = '';
            //code = '<img src="' + RVL_TEMPLATE_URL + 'images/action_disable.gif" />';
        }
        if (val == 1) {
            code = '';
           // code = '<img src="' + RVL_TEMPLATE_URL + 'images/action_enable.gif" />';
        }
        $( '#' + id + '_status').html(code);
    }

    function progress(percent, $element) {
        var progressBarWidth = percent * $element.width() / 100;
        $element.find('div').animate({ width: progressBarWidth }, 500).html(percent + '%&nbsp;');
    }


</script>
{/literal}

{else}
    {if true || $service.symantec_status == 'AUTHORIZATION_FAILED' || $service.symantec_status == 'RV_WF_AUTHORIZATION'}
    <link rel="stylesheet" type="text/css" href="{$template_dir}css/jquery.datetimepicker.css"/ >
    <script src="{$template_dir}js/jquery.datetimepicker.js"></script>
    {literal}

    <script type="text/javascript">
        function tosubmitphonecall(){
            $(".step0").hide();
            $(".phonecall").show();
            $(".change_phonecall").hide();
            $('.changeemail_button').hide();
        }

        $( "#txt_date1_from" ).datetimepicker();
        $( "#txt_date1_to" ).datetimepicker();
        $( "#txt_date2_from" ).datetimepicker();
        $( "#txt_date2_to" ).datetimepicker();
        $(".phonecall_reset").click(function(){
           $("#phonecall_error").hide();
        });

        $(".back").click(function(){
            window.location.reload();
        });

        $("#frmPhonecall").submit(function(){
            if($( "#txt_date1_from" ).val() == ''){
                $( "#txt_date1_from" ).focus();
                $('#phonecall_error').html('<p class="message-error" style="margin-left: 10px;"><font color=red>Please select a verification call appointment.</font></p>');
                $('#phonecall_error').show();
                return false;
            }else if($( "#txt_date1_to" ).val() == ''){
                $( "#txt_date1_to" ).focus();
                $('#phonecall_error').html('<p class="message-error" style="margin-left: 10px;"><font color=red>Please select a verification call appointment.</font></p>');
                $('#phonecall_error').show();
                return false;
            }else if(Date.parse($( "#txt_date1_from" ).val()) <= Date.parse(Date())){
                $( "#txt_date1_from" ).focus();
                $('#phonecall_error').html('<p class="message-error" style="margin-left: 10px;"><font color=red>Verification call is incorrect.</font></p>');
                $('#phonecall_error').show();
                return false;
            }else if(Date.parse($( "#txt_date1_from" ).val()) > Date.parse($( "#txt_date1_to" ).val())){
                $( "#txt_date1_to" ).focus();
                $('#phonecall_error').html('<p class="message-error" style="margin-left: 10px;"><font color=red>Verification call is incorrect.</font></p>');
                $('#phonecall_error').show();
                return false;
            }else{
                if($( "#txt_date2_from" ).val() != ''){
                    if($( "#txt_date2_to" ).val() == ''){
                        $( "#txt_date2_to" ).focus();
                        $('#phonecall_error').html('<p class="message-error" style="margin-left: 10px;"><font color=red>Please select a verification call appointment.</font></p>');
                        $('#phonecall_error').show();
                        return false;
                    }else if(Date.parse($( "#txt_date2_from" ).val()) > Date.parse($( "#txt_date2_to" ).val())){
                        $( "#txt_date2_to" ).focus();
                        $('#phonecall_error').html('<p class="message-error" style="margin-left: 10px;"><font color=red>Verification call is incorrect.</font></p>');
                        $('#phonecall_error').show();
                        return false;
                    }
                }
                if($("#ext_num").val() != ''){
                    if(isNaN($("#ext_num").val())){
                        $("#ext_num").focus();
                        $('#phonecall_error').html('<p class="message-error" style="margin-left: 10px;"><font color=red>Extension number incorrect.</font></p>');
                        $('#phonecall_error').show();
                        return false;
                    }
                }
                var formObj = $(this);
                var formURL = formObj.attr("action");
                var formData = new FormData(this);
                $('.phonecall').addLoader();
                $.ajax({
                    url: formURL,
                    type: 'POST',
                    data:  formData,
                    mimeType:"multipart/form-data",
                    contentType: false,
                    cache: false,
                    processData:false,
                    dataType: 'json',
                success: function(data)
                {
                	$('#preloader').remove();
                    if (data.aResponse == undefined) {
                        alert('ERROR: Cannot get response!!');
                        return false;
                    } else {
                        aResponse = data.aResponse;
                    }

                    if (aResponse.status != undefined && aResponse.status == 'ERROR') {
                        alert('ERROR: ' + aResponse.message);
                        return false;
                    } else if (aResponse.status != undefined && aResponse.status == 'success') {
                        alert(aResponse.message);
                        window.location.reload();
                    } else {
                        alert('ERROR: Cannot process !!');
                        return false;
                    }
                }
                });
            }
        });
    if('{/literal}{$service.symantec_status}{literal}' == 'RV_WF_AUTHORIZATION'){
        if('{/literal}{$service.phonecall_1}{literal}' != ''){
            $(".change_phonecall").show();
        }
    }
    </script>
    {/literal}
    {/if}


        {if $service.symantec_status|strstr:'APPROVAL' || $service.symantec_status == 'WAITING_SUBMIT_ORDER' || $service.symantec_status|strstr:'FAILED'}
        {literal}
            <script type="text/javascript">
                $("#upload_csr").live( 'change', function () {
                      $("#submit_upload_csr").click();
                      $('#form_upload_csr').trigger("reset");
                  });

                  $("#form_upload_csr").submit(function(){
                         var formObj = $(this);
                                var formURL = formObj.attr("action");
                                var formData = new FormData(this);
                                $.ajax({
                                    url: formURL,
                                    type: 'POST',
                                    data:  formData,
                                    mimeType:"multipart/form-data",
                                    contentType: false,
                                    cache: false,
                                    processData:false,
                                    dataType: 'json',
                                success: function(data)
                                {
                                    //console.log(data);
                                    if (data.aResponse == undefined) {
                                        alert('ERROR: Cannot get response!!');
                                        return false;
                                    } else {
                                        aResponse = data.aResponse;
                                    }

                                    if (aResponse.status != undefined && aResponse.status == 'ERROR') {
                                        alert('ERROR: ' + aResponse.message);
                                        return false;
                                    } else if (aResponse.status != undefined && aResponse.status == 'success') {
                                       $("#csr_data").val(aResponse.message);
                                    } else {
                                        alert('ERROR: Cannot process !!');
                                        return false;
                                    }
                            }
                        });
                });

                var RVL_BASEURL = "{/literal}{$system_url}{literal}";
                $(".resubmit").show();
                {/literal}
                {if $service.symantec_status != 'WAITING_SUBMIT_ORDER'}
                    $('.editcontact_div').hide();
                {/if}
                {if !$service.symantec_status|strstr:'APPROVAL'}
                    $('.sendemail_button').hide();
                {/if}
                {if $service.ssl_validation_id == '2' || $service.ssl_validation_id == '3'}
                    $('.changeemail_button').hide();
                {/if}
                {literal}
                $(".back").click(function(){
                    window.location.reload();
                });

                $(".back_on_step1").click(function(){
                    window.location.reload();
                });

                $(".back_on_step2").click(function(){
                    $('.step1').show();
                    $('.step2').hide();
                    $('.step3').hide();
                    $('html, body').animate({ scrollTop: 0 }, 'fast');
                });

                $("#ch_same_address").change(function() {
                    $(".not_same_address").toggle();
                });



                $("#frmchangeemail").submit(function(){

                            $.ajax({
                            type: "POST"
                            , url: RVL_BASEURL
                            , data: {
                                cmd: 'module'
                                , module: 'ssl'
                                , action: 'change_email_approval'
                                , order_id: $("#order_id").val()
                                , email: $("#reemail_approval").val()
                            }
                            , success: function(data) {
                                if (data.aResponse == undefined) {
                                    alert('ERROR: Cannot get response!!');
                                    return false;
                                } else {
                                    aResponse = data.aResponse;
                                }

                                if (aResponse.status != undefined && aResponse.status == 'ERROR') {
                                    alert('ERROR: ' + aResponse.message);
                                    return false;
                                } else if (aResponse.status != undefined && aResponse.status == 'success') {
                                    alert(aResponse.message);
                                    window.location.reload();
                                } else {
                                    alert('ERROR: Cannot process !!');
                                    return false;
                                }
                            }
                        });
                });

                function editcontact(order_id){
                    $(".form_edit_contact").show();
                    $(".table-box1").hide();
                    $(".phonecall").hide();
                    $(".change_phonecall").hide();
                    $(".resubmit").hide()
                    $(".form_edit_contact").addLoader();

                    $.ajax({
                        type: 'POST'
                        , url: RVL_BASEURL
                        , data: {
                            cmd: 'module'
                            , module: 'ssl'
                            , action: 'ajax_get_country_list'
                        }, success: function(aData){
                            countryList = aData.aResponse;
                            $.ajax({
                                type: "POST"
                                , url: RVL_BASEURL
                                , data: {
                                    cmd: 'module'
                                    , module: 'ssl'
                                    , action: 'ajax_get_edit_contact'
                                    , order_id: order_id
                                }
                                , success: function(data) {
                                    $('#preloader').remove();
                                    aResponse = data.aResponse;
                                    $('#RV_BASEURL').val(RVL_BASEURL);
                                    $('#order_id').val(order_id);
                                    mainKeyOrg = [ 'Organization_Name', 'Phone_Number', 'Address', 'City', 'State_Province', 'Country', 'Postal_Code'];
                                    mainKey = [ 'First_Name', 'Last_Name', 'Email_Address', 'Job_Title', 'Address', 'City', 'State_Province', 'Country', 'Postal_Code', 'Phone_Number', 'Ext_Number'];
                                    var organize = '';
                                    var admin = '';
                                    var tech = '';
                                    if(typeof aResponse.organize != 'undefined'){
                                        $('.edit_organize_contact').show();
                                        organize = '<table>';
                                        for(eachOrgInd in mainKeyOrg){
                                            eachOrg = mainKeyOrg[eachOrgInd];
                                            if( typeof aResponse.organize[eachOrg] != 'undefined'){
                                            organize += '<tr><td>' + eachOrg.replace('_', ' ').replace('Ext', 'Ext.').replace('State ', 'State/');
                                            if(eachOrg != 'Ext_Number') organize += ' <font color="red">*</font>';
                                            organize += '</td><td>: ';

                                            if(eachOrg == 'Address'){
                                                   organize += '<textarea id="organize_' + eachOrg + '" name="edit_organize[' + eachOrg + ']" style= "width: 220px; height: 150px; resize: none;" >' + aResponse.organize[eachOrg] + '</textarea>';
                                            } else if(eachOrg != 'Country'){
                                                organize += '<input type="text" name="edit_organize[' + eachOrg + ']" id="organize_' + eachOrg + '" value="' + aResponse.organize[eachOrg] + '" />';
                                            } else {
                                                organize += '<select name="edit_organize[' + eachOrg + ']" id="organize_' + eachOrg  + '">'
                                                for(cCode in countryList){
                                                    organize += '<option value="' + countryList[cCode].code + '"';
                                                    if(countryList[cCode].code == aResponse.organize[eachOrg]) organize += ' selected';
                                                    organize += '>' + countryList[cCode].name + '</option>';
                                                }
                                                organize += '</select>';
                                            }
                                            organize += '</td></tr>';
                                            }
                                        }
                                        organize += '</table>';
                                    }
                                    if(typeof aResponse.admin != 'undefined'){
                                        $('.edit_admin_contact').show();
                                        admin = '<table>';
                                        for(eachAdminIndex in mainKey){
                                            eachAdmin = mainKey[eachAdminIndex];
                                            if(typeof aResponse.admin[eachAdmin] != 'undefined'){
                                                admin += '<tr><td>' + eachAdmin.replace('_', ' ').replace('Ext', 'Ext.').replace('State ', 'State/');
                                                if(eachAdmin != 'Ext_Number') admin += ' <font color="red">*</font>';
                                                admin += '</td><td>: ';

                                                if(eachAdmin == 'Address'){
                                                    admin += '<textarea id="admin_' + eachAdmin + '" name="edit_admin[' + eachAdmin + ']" style= "width: 220px; height: 150px; resize: none;" >' + aResponse.admin[eachAdmin] + '</textarea>';
                                                } else if(eachAdmin == 'Country'){
                                                    admin += '<select id="admin_' + eachAdmin  + '" name="edit_admin[' + eachAdmin + ']">'
                                                    for(cCode in countryList){
                                                        admin += '<option value="' + countryList[cCode].code + '"';
                                                        if(countryList[cCode].code == aResponse.admin[eachAdmin]) admin += ' selected';
                                                        admin += '>' + countryList[cCode].name + '</option>';
                                                    }
                                                    admin += '</select>';
                                                } else {
                                                    admin += '<input type="text" id="admin_' + eachAdmin + '" name="edit_admin[' + eachAdmin + ']" value="' + aResponse.admin[eachAdmin] + '"/>';
                                                }
                                                admin += '</td></tr>';
                                            }
                                        }
                                        admin += '</table>';
                                    }
                                    if(typeof aResponse.tech != 'undefined'){
                                        $('.edit_tech_contact').show();
                                        tech = '<table>';
                                        for(eachTechIndex in mainKey){
                                            eachTech = mainKey[eachTechIndex];
                                            if(typeof aResponse.tech[eachTech] != 'undefined'){
                                                tech += '<tr><td>' + eachTech.replace('_', ' ').replace('Ext', 'Ext.').replace('State ', 'State/');
                                                if(eachTech != 'Ext_Number') tech += ' <font color="red">*</font>';
                                                tech += '</td><td>: ';
                                                if(eachTech == 'Address'){
                                                    tech += '<textarea id="tech_' + eachTech + '" name="edit_tech[' + eachTech + ']" style= "width: 220px; height: 150px; resize: none;">' + aResponse.tech[eachTech] + '</textarea>';
                                                } else if(eachTech == 'Country'){
                                                    tech += '<select id="tech_' + eachTech  + '" name="edit_tech[' + eachTech + ']">'
                                                    for(cCode in countryList){
                                                        tech += '<option value="' + countryList[cCode].code + '"';
                                                        if(countryList[cCode].code == aResponse.tech[eachTech]) tech += ' selected';
                                                        tech += '>' + countryList[cCode].name + '</option>';
                                                    }
                                                    tech += '</select>';
                                                } else {
                                                    tech += '<input type="text" id="tech_' + eachTech + '" name="edit_tech[' + eachTech + ']" value="' + aResponse.tech[eachTech] + '" />';
                                                }
                                                tech += '</td></tr>';
                                            }
                                        }
                                        tech += '</table>';
                                    }
                                    $('#edit_organize_div').html(organize);
                                    $('#edit_admin_div').html(admin);
                                    $('#edit_tech_div').html(tech);
                                    console.log(aResponse);
                                }
                            });
                        }
                    });
                }

                function changeemail(order_id){
                    $(".form_change_email").show();
                    $(".table-box1").hide();
                    $(".phonecall").hide();
                    $(".change_phonecall").hide();
                    $(".resubmit").hide();
                    //$(".form_change_email").addLoader();
                    $.ajax({
                                type: "POST"
                                , url: RVL_BASEURL
                                , data: {
                                    cmd: 'module'
                                    , module: 'ssl'
                                    , action: 'ajax_getemaillist'
                                    , domain: '{/literal}{$service.contact.domain_name}{literal}'
                                }
                                , success: function(data) {
                                    console.log(data);
                                    var emailList = data.aResponse;
                                    for(i in emailList){
                                        $('#reemail_approval').append('<option val='+emailList[i]+'>'+emailList[i]+'</option>');
                                    }
                                    $('#preloader').remove();
                                }
                     });

                    /*$("#reemail_approval").val('{/literal}{$service.contact.email_approval}{literal}');
                    $("#reemail_approval").select();
                    $("#reemail_approval").focus();*/
                }

                function sendemail(order_id){
                    if(confirm('Do you want to resend Email validation now ?')){
                        $('.table-box1').addLoader();
                        $(".resubmit").hide();
                        $.ajax({
                        type: "POST"
                        , url: RVL_BASEURL
                        , data: {
                            cmd: 'module'
                            , module: 'ssl'
                            , action: 'resend_email_validation'
                            , order_id: order_id
                        }
                        , success: function(data) {
                           $('#preloader').remove();
                           $(".showaa").show("slow");
                           $(".showaa").slideUp("slow");
                            $(".resubmit").show();
                                if (data.aResponse == undefined) {
                                    alert('ERROR: Cannot get response!!');
                                    return false;
                                } else {
                                        aResponse = data.aResponse;
                                }

                                if (aResponse.status != undefined && aResponse.status == 'ERROR') {
                                    alert('ERROR: ' + aResponse.message);
                                    return false;
                                } else if (aResponse.status != undefined && aResponse.status == 'success') {
                                    alert(aResponse.message);
                                    window.location.reload();
                                } else {
                                    alert('ERROR: Cannot process !!');
                                    return false;
                                }
                            }
                        });
                    }
                }

                function resubmitcsr(order_id){
                     $(".step0").hide();
                     $(".step1").show();
                     $(".resubmit").hide()
                     $("#resubmit_csr").val('1');
                }

                $("#frmMr").submit(function(){
                    var filteremail     = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9])+$/;
                    if ($('#varidate').val()!="1"){
                        if ($("#txt_name").val()=='') {
                            alert("Field '\First Name'\ is requied.");
                            $("#txt_name").focus();
                            return false;
                        } else if ($("#txt_lastname").val()=='') {
                            alert("Field '\Last name'\ is requied.");
                            $("#txt_lastname").focus();
                            return false;
                        } else if($("#txt_org").val()=='') {
                            alert("Field '\Organization Name'\ is requied.");
                            $("#txt_org").focus();
                            return false;
                        } else if($("#txt_email").val()=='') {
                            alert("Field '\Email Address'\ is requied.");
                            $("#txt_email").focus();
                            return false;
                        }  else if(!filteremail.test($("#txt_email").val())) {
                            alert("Please enter a valid email address.");
                            $("#txt_email").focus();
                            $("#txt_email").select();
                            return false;
                        } else if ($("#txt_job").val()=='') {
                            alert("Field '\Job Title'\ is requied.");
                            $("#txt_job").focus();
                            return false;
                        } else if ($("#txt_address").val()=='') {
                            alert("Field '\Address'\ is requied.");
                            $("#txt_address").focus();
                            return false;
                        } else if ($("#txt_city").val()=='') {
                            alert("Field '\City'\ is requied.");
                            $("#txt_city").focus();
                            return false;
                        } else if ($("#txt_state").val()=='') {
                            alert("Field '\State/Region'\ is requied.");
                            $("#txt_state").focus();
                            return false;
                        } else if ($("#txt_country").val()=='') {
                            alert("Field '\Country'\ is requied.");
                            $("#txt_country").focus();
                            return false;
                        } else if ($("#txt_post").val()=='') {
                            alert("Field '\Postal Code'\ is requied.");
                            $("#txt_post").focus();
                            return false;
                        } else if ($("#txt_tel").val()=='') {
                            alert("Field '\Last name'\ is requied.");
                            $("#txt_tel").focus();
                            return false;
                        } else if($("#txt_ext").val() != '' && isNaN($("#txt_ext").val())){
                                 alert("Invalid '\Ext Number.'\ ");
                                 $("#txt_ext").focus();
                                 $("#txt_ext").select();
                                 return false;
                        } else {
                            if( ! $("#ch_same_address").is(':checked')){
                                if ($("#txt_name_1").val()=='') {
                                    alert("Field '\First Name'\ is requied.");
                                    $("#txt_name_1").focus();
                                    return false;
                                } else if ($("#txt_lastname_1").val()=='') {
                                    alert("Field '\Last name'\ is requied.");
                                    $("#txt_lastname_1").focus();
                                    return false;
                                } else if($("#txt_email_1").val()=='') {
                                    alert("Field '\Email Address'\ is requied.");
                                    $("#txt_email_1").focus();
                                    return false;
                                } else if(!filteremail.test($("#txt_email_1").val())) {
                                    alert("Please enter a valid email address.");
                                    $("#txt_email_1").focus();
                                    $("#txt_email_1").select();
                                    return false;
                                }else if($("#txt_org_1").val()=='') {
                                    alert("Field '\Organization Name'\ is requied.");
                                    $("#txt_org_1").focus();
                                    return false;
                                }  else if ($("#txt_job_1").val()=='') {
                                    alert("Field '\Job Title'\ is requied.");
                                    $("#txt_job_1").focus();
                                    return false;
                                } else if ($("#txt_address_1").val()=='') {
                                    alert("Field '\Address'\ is requied.");
                                    $("#txt_address_1").focus();
                                    return false;
                                } else if ($("#txt_city_1").val()=='') {
                                    alert("Field '\City'\ is requied.");
                                    $("#txt_city_1").focus();
                                    return false;
                                } else if ($("#txt_state_1").val()=='') {
                                    alert("Field '\State/Region'\ is requied.");
                                    $("#txt_state_1").focus();
                                    return false;
                                } else if ($("#txt_country_1").val()=='') {
                                    alert("Field '\Country'\ is requied.");
                                    $("#txt_country_1").focus();
                                    return false;
                                } else if ($("#txt_post_1").val()=='') {
                                    alert("Field '\Postal Code'\ is requied.");
                                    $("#txt_post_1").focus();
                                    return false;
                                } else if ($("#txt_tel_1").val()=='') {
                                    alert("Field '\Last name'\ is requied.");
                                    $("#txt_tel_1").focus();
                                    return false;
                                } else if($("#txt_ext_1").val() != ''){
                                     if(isNaN($("#txt_ext_1").val())){
                                         alert("Invalid '\Ext Number.'\ ");
                                         $("#txt_ext_1").focus();
                                         $("#txt_ext_1").select();
                                         return false;
                                     }
                                }
                            }
                    //updateCSR();
                    //return true;
                        }
                    }
                var formObj = $(this);
                var formURL = formObj.attr("action");
                var formData = new FormData(this);
                $.ajax({
                    url: formURL,
                    type: 'POST',
                    data:  formData,
                    mimeType:"multipart/form-data",
                    contentType: false,
                    cache: false,
                    processData:false,
                    dataType: 'json',
                success: function(data)
                {
                    if (data.aResponse == undefined) {
                            alert('ERROR: Cannot get response!!');
                            return false;
                        } else {
                            aResponse = data.aResponse;
                        }

                    if (aResponse.status != undefined && aResponse.status == 'ERROR') {
                        alert('ERROR: ' + aResponse.message);
                        return false;
                    } else if (aResponse.status != undefined && aResponse.status == 'success') {
                        alert(aResponse.message);
                        window.location.reload();
                    } else {
                        alert('ERROR: Cannot process !!');
                        return false;
                    }
                }
            });
        });

            function validateCsr(sslId, csr)
    {
        $('.step1').addLoader();
        var RVL_BASEURL = "{/literal}{$system_url}{literal}";
        progress(10, $( '#progressBar'));
        writeCsrError('');
        $.ajax({
            type: "POST"
            , url: RVL_BASEURL
            , data: {
                cmd: 'module'
                , module: 'ssl'
                , action: 'decodecsr'
                , ssl_id: sslId
                , csrData: csr
                }
            , success: function(data) {
                console.log(data);
                progress(40, $( '#progressBar'));
                if (data.aResponse == undefined) {
                    writeCsrError("Cannot get response from api!!");
                    return false;
                } else {
                    aResponse = data.aResponse;
                }

                if (aResponse.csrData.status.parseStatus != undefined && aResponse.csrData.status.parseStatus == '0') {
                    writeCsrError(aResponse.csrData.error[0].message);
                    return false;
                }

                if (aResponse.status != undefined && aResponse.status == 'success') {
                    progress(50, $('#progressBar'));
                    arrayCsrKey = ['CN', 'O', 'OU', 'L', 'ST', 'C', 'KeyAlgorithm', 'KeyLength', 'Signature'];
                    if (aResponse.csrData != undefined) {
                        onError = 0;
                        csrData = aResponse.csrData;
                        validateData = aResponse.validateData;

                        for (key in arrayCsrKey) {
                            id = 'csr_' + arrayCsrKey[key].toLowerCase();
                            writeCsrStatus(id, '');
                            if (csrData[arrayCsrKey[key]] != undefined) {
                                writeCsrData(id, csrData[arrayCsrKey[key]]);
                                if (id == 'csr_cn') {
                                    $('#commonname').val(csrData[arrayCsrKey[key]]);
                                }
                            } else {
                                writeCsrData(id, '');
                            }

                            if (validateData[arrayCsrKey[key]] != undefined) {
                                writeCsrError(validateData[arrayCsrKey[key]]['message']);
                                writeCsrStatus(id, 0);
                                onError = 1;
                            } else {
                                writeCsrStatus(id, 1);
                            }
                        }

                        var parts = aResponse.csrData.CN.split('.');
                        var subdomain = parts.shift();
                        var upperleveldomain = parts.join('.');

                        if (onError == 0) {
                            progress(60, $('#progressBar'));
                            $.ajax({
                                type: "POST"
                                , url: RVL_BASEURL
                                , data: {
                                    cmd: 'module'
                                    , module: 'ssl'
                                    , action: 'getwhoisdomain'
                                    , domain: aResponse.csrData.CN
                                }
                                , success: function(data) {
                                    console.log(data);
                                    progress(80, $('#progressBar'));

                                    if (data.aResponse == undefined) {
                                        writeCsrError("Cannot get response from api!!");
                                        return false;
                                    }
                                    if (data.aResponse.regrinfo.owner == undefined){
                                        writeCsrError("Your CSR contains a challenge phrase. Adding a challenge phrase to a CSR is not a secure practice. Please generate a new CSR that does not contain a challenge phrase.");
                                        return false;
                                    }

                                    whoisData = data.aResponse;
                                    regrinfo = {
                                        owner: {},
                                        tech: {},
                                        admin: {}
                                    };


                                    if (whoisData.regrinfo.owner != undefined) {
                                        regrinfo.owner = whoisData.regrinfo.owner;
                                    }

                                    if (whoisData.regrinfo.admin != undefined) {
                                        regrinfo.admin = whoisData.regrinfo.admin;
                                    }

                                    if (whoisData.regrinfo.tech != undefined) {
                                        regrinfo.tech = whoisData.regrinfo.tech;
                                    }

                                    aEmail = {};
                                    if (whoisData.regrinfo.domain == undefined) {
                                        writeCsrError('Cannot get whois data!!');
                                        return 1;
                                    }

                                    /*if (regrinfo.owner.email != undefined) {
                                        aEmail[regrinfo.owner.email] = 'Registrant Email';
                                    }*/

                                    if (regrinfo.admin.email != undefined) {
                                        if (aEmail[regrinfo.admin.email] == undefined) {
                                            aEmail[regrinfo.admin.email] = 'Administrative Email';
                                        }
                                    }

                                    if (regrinfo.tech.email != undefined ) {
                                        if (aEmail[regrinfo.tech.email] == undefined) {
                                            aEmail[regrinfo.tech.email] = 'Technical Email';
                                        }
                                    }

                                    emailApprovalOtp = '';
                                    count = 1;
                                    for (k in aEmail) {
                                        emailApprovalOtp = emailApprovalOtp
                                            + '<label for="email_approval_' + count + '">'
                                            + '<input type="radio" id="email_approval_' + count
                                            + '" name="email_approval" value="' + k + '" />'
                                            +  k + ' (' + aEmail[k] + ')</label><br>';
                                        count = count +1;
                                    }

                                    setAdminEmail = 'admin@' + whoisData.regrinfo.domain.name;
                                    setAdministratorEmail = 'administrator@' + whoisData.regrinfo.domain.name;
                                    setWebmasterEmail = 'webmaster@' + whoisData.regrinfo.domain.name;
                                    setHostmasterEmail = 'hostmaster@' + whoisData.regrinfo.domain.name;
                                    setPostmasterEmail = 'postmaster@' + whoisData.regrinfo.domain.name;
                                    setTecEmail = regrinfo.tech.email;

                                    emailApprovalOtp = emailApprovalOtp
                                        + '<label for="email_approval_' + count + '">'
                                        + '<input type="radio" id="email_approval_' + count
                                        + '" name="email_approval" value="'+ setTecEmail +'" />'
                                        + setTecEmail + '(Technical Email)</label><br>';

                                    count = count +1;

                                    emailApprovalOtp = emailApprovalOtp
                                        + '<label for="email_approval_' + count + '">'
                                        + '<input type="radio" id="email_approval_' + count
                                        + '" name="email_approval" value="'+ setAdminEmail +'" />'
                                        + setAdminEmail + '</label><br>';

                                    count = count +1;

                                    emailApprovalOtp = emailApprovalOtp
                                        + '<label for="email_approval_' + count + '">'
                                        + '<input type="radio" id="email_approval_' + count
                                        + '" name="email_approval" value="'+ setAdministratorEmail +'" />'
                                        + setAdministratorEmail + '</label><br>';

                                    count = count +1;

                                    emailApprovalOtp = emailApprovalOtp
                                        + '<label for="email_approval_' + count + '">'
                                        + '<input type="radio" id="email_approval_' + count
                                        + '" name="email_approval" value="'+ setWebmasterEmail +'" />'
                                        + setWebmasterEmail + '</label><br>';

                                    count = count +1;

                                    emailApprovalOtp = emailApprovalOtp
                                        + '<label for="email_approval_' + count + '">'
                                        + '<input type="radio" id="email_approval_' + count
                                        + '" name="email_approval" value="'+ setHostmasterEmail +'" />'
                                        + setHostmasterEmail + '</label><br>';

                                    count = count +1;

                                     emailApprovalOtp = emailApprovalOtp
                                        + '<label for="email_approval_' + count + '">'
                                        + '<input type="radio" id="email_approval_' + count
                                        + '" name="email_approval" value="'+ setPostmasterEmail +'" />'
                                        + setPostmasterEmail + '</label><br>';

                                    count = count +1;

                                    $('#whois_emailinfo').html(emailApprovalOtp);
                                    $('#email_approval_1').attr('checked','checked');


                                    progress(90, $('#progressBar'));
                                    domainDetail = '';

                                   if (regrinfo.owner.name != undefined) {
                                        domainDetail = domainDetail + regrinfo.owner.name + '<br />';
                                        var name = regrinfo.owner.name;
                                        var resultname = name.split(" ");
                                        $("#DVfirstname").val(resultname[0]);
                                        $("#DVlastname").val(resultname[1]);
                                        $("#txt_name").val(resultname[0]);
                                        $("#txt_lastname").val(resultname[1]);
                                    }

                                    if (regrinfo.admin.name != undefined) {
                                        domainDetail = domainDetail + regrinfo.admin.name + '<br />';
                                        var name = regrinfo.admin.name;
                                        var resultname = name.split(" ");
                                        $("#adminfirstname").val(resultname[0]);
                                        $("#adminlastname").val(resultname[1]);
                                    }

                                    if (regrinfo.owner.organization != undefined) {
                                        domainDetail = domainDetail + regrinfo.owner.organization + '<br />';
                                        $("#DVorganization").val(regrinfo.owner.organization);
                                        $("#txt_org").val(regrinfo.owner.organization);
                                    }

                                    if (regrinfo.admin.organization != undefined) {
                                        domainDetail = domainDetail + regrinfo.admin.organization + '<br />';
                                        $("#adminorganization").val(regrinfo.admin.organization);
                                    }

                                    if (regrinfo.owner.address.address != undefined) {
                                        if (regrinfo['owner']['address']['address']['address'] != undefined) {
                                            domainDetail = domainDetail + regrinfo['owner']['address']['address']['address'] + ' ';
                                            $("#DVaddress").val(regrinfo['owner']['address']['address']['address']);
                                            $('#txt_address').val(regrinfo['owner']['address']['address']['address']);
                                        }

                                        if (regrinfo['owner']['address']['address']['city'] != undefined) {
                                            domainDetail = domainDetail + regrinfo['owner']['address']['address']['city'] + ' ';
                                            $("#DVcity").val(regrinfo['owner']['address']['address']['city']);
                                            $('#txt_city').val(regrinfo['owner']['address']['address']['city']);
                                        }

                                        if (regrinfo['owner']['address']['address']['country'] != undefined) {
                                            domainDetail = domainDetail + regrinfo['owner']['address']['address']['country'] + ' ';
                                            $("#DVcountry").val(regrinfo['owner']['address']['address']['country']);
                                            $('#txt_country  option[value='+regrinfo['owner']['address']['address']['country']+']').attr('selected','selected');
                                        }

                                        if (regrinfo['owner']['address']['address']['pcode'] != undefined) {
                                            domainDetail = domainDetail + regrinfo['owner']['address']['address']['pcode'] + '<br />';
                                            $("#DVpcode").val(regrinfo['owner']['address']['address']['pcode']);
                                            $('#txt_post').val(regrinfo['owner']['address']['address']['pcode']);
                                        }

                                        if (regrinfo['owner']['address']['address']['state'] != undefined) {
                                            domainDetail = domainDetail + regrinfo['owner']['address']['state'] + '<br />';
                                            $("#DVstate").val(regrinfo['owner']['address']['state']);
                                            $('#txt_state').val(regrinfo['owner']['address']['address']['state']);
                                        }

                                        if (regrinfo['owner']['phone'] != undefined) {
                                            domainDetail = domainDetail + 'Phone: ' + regrinfo['owner']['phone'] + '<br />';
                                            $("#DVphone").val(regrinfo['owner']['phone']);
                                            $('#txt_tel').val(regrinfo['owner']['phone']);
                                        }

                                        if (regrinfo['owner']['fax'] != undefined) {
                                            domainDetail = domainDetail + 'Fax: ' + regrinfo['owner']['fax'] + '<br />';
                                        }
                                    }else{
                                        if(regrinfo.owner.address != undefined){
                                            if (regrinfo['owner']['address']['street'] != undefined) {
                                                domainDetail = domainDetail + regrinfo['owner']['address']['street'][0] + ' ';
                                                $("#DVaddress").val(regrinfo['owner']['address']['street'][0]);
                                                $('#txt_address').val(regrinfo['owner']['address']['street'][0]);
                                            }

                                            if (regrinfo['owner']['address']['city'] != undefined) {
                                                domainDetail = domainDetail + regrinfo['owner']['address']['city'] + ' ';
                                                $("#DVcity").val(regrinfo['owner']['address']['city']);
                                                $('#txt_city').val(regrinfo['owner']['address']['city']);
                                            }

                                            if (regrinfo['owner']['address']['country'] != undefined) {
                                                domainDetail = domainDetail + regrinfo['owner']['address']['country'] + ' ';
                                                $("#DVcountry").val(regrinfo['owner']['address']['country']);
                                                $('#txt_country  option[value='+regrinfo['owner']['address']['country']+']').attr('selected','selected');
                                            }

                                            if (regrinfo['owner']['address']['pcode'] != undefined) {
                                                domainDetail = domainDetail + regrinfo['owner']['address']['pcode'] + '<br />';
                                                $("#DVpcode").val(regrinfo['owner']['address']['pcode']);
                                                $('#txt_post').val(regrinfo['owner']['address']['pcode']);
                                            }

                                            if (regrinfo['owner']['address']['state'] != undefined) {
                                                domainDetail = domainDetail + regrinfo['owner']['address']['state'] + '<br />';
                                                $("#DVstate").val(regrinfo['owner']['address']['state']);
                                                $('#txt_state').val(regrinfo['owner']['address']['state']);
                                            }

                                            if (regrinfo['owner']['phone'] != undefined) {
                                                domainDetail = domainDetail + 'Phone: ' + regrinfo['owner']['phone'] + '<br />';
                                                $("#DVphone").val(regrinfo['owner']['phone']);
                                                $('#txt_tel').val(regrinfo['owner']['phone']);
                                            }
                                        }
                                    }

                                    if (regrinfo.admin.address.address != undefined) {
                                        if (regrinfo['admin']['address']['address']['address'] != undefined) {
                                            domainDetail = domainDetail + regrinfo['admin']['address']['address']['address'] + ' ';
                                            $("#adminaddress").val(regrinfo['admin']['address']['address']['address']);
                                        }

                                        if (regrinfo['admin']['address']['address']['city'] != undefined) {
                                            domainDetail = domainDetail + regrinfo['admin']['address']['address']['city'] + ' ';
                                            $("#admincity").val(regrinfo['admin']['address']['address']['city']);
                                        }

                                        if (regrinfo['admin']['address']['address']['country'] != undefined) {
                                            domainDetail = domainDetail + regrinfo['admin']['address']['address']['country'] + ' ';
                                            $("#admincountry").val(regrinfo['admin']['address']['address']['country']);
                                        }

                                        if (regrinfo['admin']['address']['address']['pcode'] != undefined) {
                                            domainDetail = domainDetail + regrinfo['admin']['address']['address']['pcode'] + '<br />';
                                            $("#adminpcode").val(regrinfo['admin']['address']['address']['pcode']);
                                        }

                                        if (regrinfo['admin']['address']['address']['state'] != undefined) {
                                            domainDetail = domainDetail + regrinfo['admin']['address']['state'] + '<br />';
                                            $("#adminstate").val(regrinfo['admin']['address']['state']);
                                        }

                                        if (regrinfo['admin']['phone'] != undefined) {
                                            domainDetail = domainDetail + 'Phone: ' + regrinfo['admin']['phone'] + '<br />';
                                            $("#adminphone").val(regrinfo['admin']['phone']);
                                        }

                                        if (regrinfo['admin']['fax'] != undefined) {
                                            domainDetail = domainDetail + 'Fax: ' + regrinfo['admin']['fax'] + '<br />';
                                        }
                                    }else{
                                        if(regrinfo.admin.address != undefined){
                                            if (regrinfo['admin']['address']['street'] != undefined) {
                                                domainDetail = domainDetail + regrinfo['admin']['address']['street'][0] + ' ';
                                                $("#adminaddress").val(regrinfo['admin']['address']['street'][0]);
                                            }

                                            if (regrinfo['admin']['address']['city'] != undefined) {
                                                domainDetail = domainDetail + regrinfo['admin']['address']['city'] + ' ';
                                                $("#admincity").val(regrinfo['admin']['address']['city']);
                                            }

                                            if (regrinfo['admin']['address']['country'] != undefined) {
                                                domainDetail = domainDetail + regrinfo['admin']['address']['country'] + ' ';
                                                $("#admincountry").val(regrinfo['admin']['address']['country']);
                                            }

                                            if (regrinfo['admin']['address']['pcode'] != undefined) {
                                                domainDetail = domainDetail + regrinfo['admin']['address']['pcode'] + '<br />';
                                                $("#adminpcode").val(regrinfo['admin']['address']['pcode']);
                                            }

                                            if (regrinfo['admin']['address']['state'] != undefined) {
                                                domainDetail = domainDetail + regrinfo['admin']['address']['state'] + '<br />';
                                                $("#adminstate").val(regrinfo['admin']['address']['state']);
                                            }

                                            if (regrinfo['admin']['phone'] != undefined) {
                                                domainDetail = domainDetail + 'Phone: ' + regrinfo['admin']['phone'] + '<br />';
                                                $("#adminphone").val(regrinfo['admin']['phone']);
                                            }

                                            if (regrinfo['admin']['fax'] != undefined) {
                                                domainDetail = domainDetail + 'Fax: ' + regrinfo['admin']['fax'] + '<br />';
                                            }
                                        }
                                    }

                                    if (regrinfo['owner']['email'] != undefined) {
                                        domainDetail = domainDetail + 'Email: ' + regrinfo['owner']['email'] + '<br />';
                                         $('#txt_email').val(regrinfo['owner']['email']);
                                    }
                                    if (regrinfo['admin']['email'] != undefined) {
                                        $("#adminemail").val(regrinfo['admin']['email']);
                                    }

                                    if (domainDetail == '') {
                                         domainDetail = '<font color="red"><b>Cannot found domain owner in the WHOIS information for your domain name, please Update WHOIS Information.</b></font>';

                                    }

                                    $('#whois_domaininfo').html(domainDetail);
                                    progress(100, $('#progressBar'));
                                    $('.step1').hide();
                                    $('.step2').show();
                                    $('.step3').show();
                                    $("#progressBar").hide();
                                    $("#csr_errorblock").hide();
                                    $('#preloader').remove();
                                    $(".order_button").show();
                                    $(".back_on_step2").show();
                                }
                                , error: function(xhr,error) {
                                    respError = $.parseJSON(xhr.responseText);
                                    alert( "Whois API connection has error!! " + respError.message);
                                }
                            });
                        }
                    } else {
                        writeCsrError("Cannot read data info from CSR!!");
                        return false;
                    }
                } else {
                    writeCsrError("Unknow status response!!");
                    return false;
                }
            }
            , error: function(xhr,error) {
                respError = $.parseJSON(xhr.responseText);
                alert( "Whois API connection has error!! " + respError.message);
            }
       });
    }


            $(".validate_button").click(function(){
            validateCsr('{/literal}{$service.ssl_id}{literal}',$("#csr_data").val());
            //$("#progressBar").show();
            $("#csr_errorblock").show();
            });

            function writeCsrError(msg)
            {
                if (msg == '') {
                    $( '#csr_errorblock' ).html('');
                    $( '#csr_errorblock' ).hide();
                } else {
                    $('#preloader').remove();
                    $( '#csr_errorblock' ).html($( '#csr_errorblock' ).html() + '<p class="message-error"><font color=red><u>Error Message</u> : <br />' + msg + '</font></p>');
                    $( '#csr_errorblock' ).css('background-color', '#EEE');
                }
            }

            function writeCsrData(id, val)
            {
                $( '#' + id + '_data').html(val);
            }

            function writeCsrStatus(id, val)
            {
                code = '';
                if (val == 0) {
                    code = '';
                    //code = '<img src="' + RVL_TEMPLATE_URL + 'images/action_disable.gif" />';
                }
                if (val == 1) {
                    code = '';
                   // code = '<img src="' + RVL_TEMPLATE_URL + 'images/action_enable.gif" />';
                }
                $( '#' + id + '_status').html(code);
            }

            function progress(percent, $element) {
                var progressBarWidth = percent * $element.width() / 100;
                $element.find('div').animate({ width: progressBarWidth }, 500).html(percent + '%&nbsp;');
            }
    </script>
    <style>
.divTable {
    display:  table;
    width: 100%;
    background-color:#e4e4e4;
    border:0px solid  #dfdfdf;
    border-spacing:5px;
    padding:10px 0px;
    /*cellspacing:poor IE support for  this*/
    /* border-collapse:separate;*/
}
.divRow {
    display:table-row;
    width:auto;
}
.divCell {
    float:left;/*fix for  buggy browsers*/
    display:table-column;
    width:auto;
    text-align: left;
    padding-left: 10px;
    /* background-color:#ccc; */
}

#progressBar {
        width: 400px;
        height: 22px;
        border: 1px solid #111;
        background-color: #292929;
}
#progressBar div {
        height: 100%;
        color: #fff;
        text-align: right;
        line-height: 22px; /* same as #progressBar height if we want text middle aligned */
        width: 0;
        background-color: #0099ff;
}
</style>
        {/literal}
    {/if}

        <script type="text/javascript">
		    {literal}
            function tosubmit_doc(){
                $(".table-box1").hide();
                $(".form_submit_document").show();
            }
            $(".back").click(function(){
                window.location.reload();
            });

            $("#frmsubmitdocument").submit(function(){
                var formObj = $(this);
                var formURL = formObj.attr("action");
                var formData = new FormData(this);
                $.ajax({
                    url: formURL,
                    type: 'POST',
                    data:  formData,
                    mimeType:"multipart/form-data",
                    contentType: false,
                    cache: false,
                    processData:false,
                    dataType: 'json',
                success: function(data)
                {
                    console.log(data);
                    if (data.aResponse == undefined) {
                        alert('ERROR: Cannot get response!!');
                        return false;
                    } else {
                        aResponse = data.aResponse;
                    }

                    if (aResponse.status != undefined && aResponse.status == 'ERROR') {
                        alert('ERROR: ' + aResponse.message);
                        return false;
                    } else if (aResponse.status != undefined && aResponse.status == 'success') {
                        alert(aResponse.message);
                        window.location.reload();
                    } else {
                        alert('ERROR: Cannot process !!');
                        return false;
                    }
                }
                });
            });

		    {/literal}
        </script>

    <script type="text/javascript">
        $(".step1").hide();
        $(".step2").hide();
        $(".step3").hide();
    </script>

{/if}

{if $reissue_action}
<script type="text/javascript">
{literal}
//==================================REISSUE=============================================
$(document).ready(function(){
    var base_url = '{/literal}{$system_url}{literal}' + 'index.php';
    var account_location = base_url + '/clientarea/services/ssl/{/literal}{$service.id}{literal}/';
    var order_id = '{/literal}{$service.order_id}{literal}';

    $("#upload_csr").live( 'change', function () {
        $("#submit_upload_csr").click();
        $('#form_upload_csr').trigger("reset");
    });

    $("#form_upload_csr").submit(function(){
        var formObj = $(this);
        var formURL = formObj.attr("action");
        var formData = new FormData(this);

        $.ajax({
            url: formURL,
            type: 'POST',
            data:  formData,
            mimeType:"multipart/form-data",
            contentType: false,
            cache: false,
            processData:false,
            dataType: 'json',
            success: function(data){
                console.log(data);
                if (data.aResponse == undefined) {
                    alert('ERROR: Cannot get response!!');
                    return false;
                } else {
                    aResponse = data.aResponse;
                }

                if (aResponse.status != undefined && aResponse.status == 'ERROR') {
                    alert('ERROR: ' + aResponse.message);
                    return false;
                } else if (aResponse.status != undefined && aResponse.status == 'success') {
                    $("#csr_data").val(aResponse.message);
                } else {
                    alert('ERROR: Cannot process !!');
                    return false;
                }
            }
        });
    });

    $('.reissue_button').click(function(){
        var csr = $('#csr_data').val();
        var email = $('#reissue-mail').val();
        var errorText = '';
        $('#reissue-error-text').text('');
        $('#reissue-error-tr').hide();
        $('#reissue-table').addLoader();

        if(csr != ''){
            $.ajax({
                url: base_url,
                type: 'POST',
                data: {
                    cmd: 'module',
                    module: 'ssl',
                    action: 'ajax_reissue',
                    order_id: order_id,
                    csr: csr,
                    email: email
                },
                success: function(data){
                    aResponse = data.aResponse;
                    console.log(aResponse);
                    if(aResponse['status']){
                        window.location.href = account_location;
                    } else {
                        for(i = 0; i < aResponse['error'].length; i++){
                            errorText = errorText + aResponse['error'][i]['ErrorField'] + ' Error(' + aResponse['error'][i]['ErrorCode'] + ') : ' + aResponse['error'][i]['ErrorMessage'] + '<br>';
                        }
                        $('#reissue-error-tr').show();
                        $('#reissue-error-text').html(errorText);
                    }
                    $('#preloader').remove();
                }
            });
        } else {
            $('#reissue-error-tr').show();
            $('#reissue-error-text').html('CSR Error: Please insert CSR.');
            $('#preloader').remove();
        }
    });
});
//==================================REISSUE=============================================
  {/literal}
  </script>
  {/if}