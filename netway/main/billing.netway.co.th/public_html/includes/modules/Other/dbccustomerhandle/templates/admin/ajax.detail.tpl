
{if ! $customerNo}

<div class="form-horizontal">

    <div class="form-group">
        <div class="col-sm-1">
            <label for="dbcCustomerNo">เชื่อมต่อ DBC Customer</label>
        </div>
        <div class="col-sm-2">
            <input type="text" class="form-control" id="dbcCustomerNo" onkeypress="return ajaxDetail.verify(event);" placeholder="ระบุ Customer No. CD-0000001">
        </div>
        <div class="col-sm-1">
            <input type="button" value="ตรวจสอบ" onclick="ajaxDetail.verify(event);" class="btn btn-primary">
        </div>
        <div class="col-sm-4">
            <span class="dbcCustomerVerifyResult"></span>
        </div>
    </div>

</div>

<div id="customerInfo" class="well well-info" style="display: none;">

    <div class="row">
        <div class="col-sm-2">
            <span class="customerName"></span>
        </div>
        <div class="col-sm-6">
            <span class="customerAddress"></span>
            <span class="customerCity"></span>
            <span class="customerCounty"></span>
            <span class="customerPost_Code"></span>
        </div>
        <div class="col-sm-2">
            <span class="customerVAT_Registration_No"></span>
        </div>
    </div>

    <div align="center" class="row">
        <br />
        <div class="isConnectOtherClient" style="display: none;">
            <div class="alert alert-warning" role="alert">มีการเชื่อมอยู่กับ <span class="connectClientId"></span></div>
            <br />
        </div>
        <button type="button" id="confirmConnect" onclick="ajaxDetail.connect();" class="btn btn-success">
            <span class="glyphicon glyphicon-ok" aria-hidden="true"></span> ยืนยัน
        </button>
    </div>
    
</div>

{/if}

{if $customerNo}

<div class="well well-info">

    <div class="row">
        <div class="col-sm-4">
            <label>DBC Customer</label>
           
            <a href="{$dbcWebUrl}&bookmark=31%3bEgAAAAJ7%2f{$customerEtag}&page=21" target="_blank">{$customerNo}</a>
        </div>
        <div class="col-sm-4">
            <span class="label label-warning">&nbsp;</span> = ข้อมูลไม่ตรงกันระหว่าง Hostbill และ DBC
        </div>
    </div>
    <div class="row">
        <div class="col-sm-3">
            {if ! $aCustomer._Name}<span class="label label-warning">&nbsp;</span>{/if} 
            Name: <br />
            {$aCustomer.Name} <br />
            <span class="label label-info">{$aClient.companyname}</span>
        </div>
        <div class="col-sm-3">
            {if ! $aCustomer._Address}<span class="label label-warning">&nbsp;</span>{/if} 
            Address: <br />
            {$aCustomer.Address}<br />
            <span class="label label-info">{$aClient.address1}</span>
        </div>
        <div class="col-sm-3">
            {if ! $aCustomer._Address_2}<span class="label label-warning">&nbsp;</span>{/if} 
            Address 2: <br />
            {$aCustomer.Address_2}<br />
            <span class="label label-info">{$aClient.address2}</span>
        </div>
        <div class="col-sm-3">
            {if ! $aCustomer._VAT_Registration_No}<span class="label label-warning">&nbsp;</span>{/if} 
            VAT No: <br />
            {$aCustomer.VAT_Registration_No}<br />
            <span class="label label-info">{$aClient.taxid}</span>
        </div>
    </div>
    <div class="row">
        <div class="col-sm-3">
            {if ! $aCustomer._ContactName}<span class="label label-warning">&nbsp;</span>{/if} 
            ContactName: <br />
            {$aCustomer.ContactName}<br />
            <span class="label label-info">{$aClient.firstname} {$aClient.lastname}</span>
        </div>
        <div class="col-sm-3">
            {if ! $aCustomer._City}<span class="label label-warning">&nbsp;</span>{/if} 
            City: <br />
            {$aCustomer.City}<br />
            <span class="label label-info">{$aClient.city}</span>
        </div>
        <div class="col-sm-3">
            {if ! $aCustomer._County}<span class="label label-warning">&nbsp;</span>{/if} 
            County: <br />
            {$aCustomer.County}<br />
            <span class="label label-info">{$aClient.state}</span>
        </div>
        <div class="col-sm-3">
            {if ! $aCustomer._Post_Code}<span class="label label-warning">&nbsp;</span>{/if} 
            Post_Code: <br />
            {$aCustomer.Post_Code}<br />
            <span class="label label-info">{$aClient.postcode}</span>
        </div>
    </div>
    <div class="row">
        <div class="col-sm-3">
            {if ! $aCustomer._E_Mail}<span class="label label-warning">&nbsp;</span>{/if} 
            E_Mail: <br />
            {$aCustomer.E_Mail}<br />
            <span class="label label-info">{$aClient.email}</span>
        </div>
        <div class="col-sm-3">
            {if ! $aCustomer._Phone_No}<span class="label label-warning">&nbsp;</span>{/if}
            Phone_No: <br />
            {$aCustomer.Phone_No}<br />
            <span class="label label-info">{$aClient.phonenumber}</span>
        </div>
        <div class="col-sm-3">
            {if ! $aCustomer._Fax_No}<span class="label label-warning">&nbsp;</span>{/if} 
            Fax_No: <br />
            {$aCustomer.Fax_No}<br />
            <span class="label label-info">{$aClient.fax}</span>
        </div>
    </div>
    
    <div align="center" class="row">
        <br />
        <button type="button" onclick="ajaxDetail.update();" class="btn btn-success">
            <span class="glyphicon glyphicon-refresh" aria-hidden="true"></span> Update DBC Customer จากข้อมูล Hostbill
        </button>
        <br />
        ส่งไปล่าสุด {$aCustomer.sync_by} @{$aCustomer.sync_at}
    </div>
    
</div>


{/if}


<script language="JavaScript">
{literal}
var AjaxDetail      = function () {
};

AjaxDetail.prototype.verify     = function (e) {
    var customerNo  = $('#dbcCustomerNo').val();
    
    if (e.type == 'click' || (e.type == 'keypress' && e.keyCode == 13)) {
        $('#customerInfo').hide();
        $('.dbcCustomerVerifyResult').html('');
        $('.isConnectOtherClient').hide();
        $('#confirmConnect').show();
        if (customerNo) {
            $.getJSON('?cmd=dbccustomerhandle&action=getCustomerByNo&customerNo='+ customerNo, function (data) {
                var data = data.hasOwnProperty('data') ?  data.data : {};
                if (data.hasOwnProperty('No')) {
                    $('.customerName').html(data.Name);
                    $('.customerAddress').html(data.Address);
                    $('.customerCity').html(data.City);
                    $('.customerCounty').html(data.County);
                    $('.customerPost_Code').html(data.Post_Code);
                    $('.customerVAT_Registration_No').html(data.VAT_Registration_No);
                    $('#customerInfo').show();
                    
                    if (data.hasOwnProperty('client_id')) {
                        $('.isConnectOtherClient').show();
                        $('.connectClientId').html('<a href="?cmd=clients&action=show&id='+ data.client_id +'" target="_blank">#'+ data.client_id +'</a>');
                        $('#confirmConnect').hide();
                    }
                    
                } else {
                    $('.dbcCustomerVerifyResult').html('ไม่พบข้อมูล');
                }
            });
        }
        
        return false;
    }
    
};

AjaxDetail.prototype.update     = function () {
    var clientId    = {/literal}{$clientId}{literal};
    
    if (confirm('ยืนยันการ Sync ข้อมูลจาก Hostbill ไป DBC')) {
        $.post('?cmd=dbccustomerhandle&action=syncCustomer', {
            clientId    : clientId,
        }, function (data) {
            location.reload();
        });
    }
    return false;
};

AjaxDetail.prototype.connect     = function () {
    var customerNo  = $('#dbcCustomerNo').val();
    var clientId    = {/literal}{$clientId}{literal};
    
    $.post('?cmd=dbccustomerhandle&action=connectCustomer', {
        clientId    : clientId,
        customerNo  : customerNo,
    }, function (data) {
        location.reload();
    });
    return false;
};

var ajaxDetail  = new AjaxDetail();

{/literal}
</script>
