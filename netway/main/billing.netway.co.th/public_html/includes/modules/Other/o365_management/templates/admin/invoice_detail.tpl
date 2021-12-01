{include file="$tplPath/admin/header.tpl"}
{if $hasServersConf}
    <h3><b>Partner name:</b> {$partner_name}</h3>
    <table cellpadding="2" cellspacing="2" width="90%">
        <tr>
            <td><b>Invoice ID:</b></td>
            <td>{$aSummary.id}</td>
            <td><b>Date:</b></td>
            <td>{$aSummary.invoiceDate|date_format:"%b %e, %Y %T GMT %Z"}</td>
        </tr>
        <tr>
            <td><b>Period Start:</b></td>
            <td>{$aSummary.billingPeriodStartDate|date_format:"%b %e, %Y %T GMT %Z"}</td>
            <td><b>Period End:</b></td>
            <td>{$aSummary.billingPeriodEndDate|date_format:"%b %e, %Y %T GMT %Z"}</td>
        </tr>
        <tr>
            <td></td>
            <td></td>
            <td><b>Total Charges:</b></td>
            <td>{$aSummary.totalCharges} {$aSummary.currencyCode}</td>
        </tr>
    </table>
    <p></p>
    <div id="customers_invoice_table">กำลังโหลดสรุปข้อมูลการออก invoice สำหรับ customer(s). กรุณารอสักครู่...</div>

<script language="JavaScript">
var callLink = [
{foreach from=$aSummary.invoiceDetails item="aData" key="k"}
"?cmd=azure_partner_management&action=invoice_customers_items_detail_mgr&tenant={$aRequest.tenant}&app={$aRequest.app}&m={$aData.links.self.method}&u={$aData.links.self.uri|@urlencode}&h={$aData.links.self.headers|@json_encode}",
{/foreach}
]
{literal}
async function getInvoiceCustomersItemsDetail(url) {
    return new Promise(async(resolve, reject) => {
        try {
            $.get(url, function(data, status){
                resolve(data)
            });
        } catch(error) {
            reject(error)
        }
    })
}
async function buildDataInvoiceForCustomers() {
    try {
    let invoiceForCustomers = {}
    for (let index in callLink) {
        try {
            let result = await getInvoiceCustomersItemsDetail(callLink[index]);
            if (result.data != undefined && result.data.items != undefined) {
                console.log(result.data.links.self.uri, result.data.items)
                for (let inv_index in result.data.items) {
                    let item = result.data.items[inv_index];
                    if (invoiceForCustomers[item.customerId] == undefined) {
                        invoiceForCustomers[item.customerId] = {
                            customerId: item.customerId,
                            customerName: item.customerName,
                            domainName: item.domainName,
                            items: []
                        }
                    }
                    switch(item.billingProvider) {
                        case "office":
                            invoiceForCustomers[item.customerId].items.push({
                                'orderId': item.orderId,
                                'itemName': item.offerName, // ชื่อ item
                                'billingCycleType': item.billingCycleType, // รอบบิล
                                'chargeStartDate': item.chargeStartDate, // วันที่เรื่มต้น
                                'chargeEndDate': item.chargeEndDate, // วันที่สิ้นสุด
                                'unitPrice': item.unitPrice, // ราคาต่อหน่วย
                                'quantity': item.quantity, // ปริมาณ
                                'pretaxCharges': item.subtotal, // รวมราคา
                                'totalOtherDiscount': item.totalOtherDiscount, // ส่วนลด
                                'tax': item.tax, // ภาษี
                                'postTaxTotal': item.totalForCustomer, //หลังจากบวกภาษี
                                'currency': item.currency, // สกุลเงิน
                                'billingProvider': 'office',
                                'chargeType': item.chargeType
                            });
                            break;
                        case "azure":
                            if (item.postTaxTotal != undefined) {
                                invoiceForCustomers[item.customerId].items.push({
                                    'orderId': item.orderId,
                                    'itemName': item.serviceName + ' ' + item.resourceName + ' ' + item.unit, // ok 
                                    'billingCycleType': item.billingCycleType, //ok
                                    'chargeStartDate': item.chargeStartDate, // ok
                                    'chargeEndDate': item.chargeEndDate, // ok
                                    'unitPrice': item.listPrice, // ok
                                    'quantity': item.overageQuantity,
                                    'totalOtherDiscount': item.totalOtherDiscount ? item.totalOtherDiscount : 0,
                                    'pretaxCharges': item.pretaxCharges, // ok
                                    'tax': item.taxAmount, //ok
                                    'postTaxTotal': item.postTaxTotal,
                                    'currency': item.currency, // ok
                                    'billingProvider': 'azure',
                                    'chargeType': item.chargeType
                                });
                            }
                            break;
                    }
                }
            }
        } catch (error) {
            console.warn(error)
        }
    }

    for (let index in invoiceForCustomers) {
        if (invoiceForCustomers[index].items != undefined) {
            let charges = 0;
            let currency;
            let invoiceCustomer = invoiceForCustomers[index]
            for (let itemIndex in invoiceCustomer.items) {
                let item = invoiceCustomer.items[itemIndex];
                charges += item.postTaxTotal ? item.postTaxTotal : 0;
                currency = item.currency
            }
            invoiceForCustomers[index].totalCharges = charges
            invoiceForCustomers[index].currencyCode = currency
        }
    }

    console.log(invoiceForCustomers)
    let _table_ = document.createElement('table')
    let _tr_ = document.createElement('tr')
    let _th_ = document.createElement('th')
    let _td_ = document.createElement('td')
    let _b_ = document.createElement('b')
    let table, tr, th, td;
    let tableMain = _table_.cloneNode(false)
    tableMain.border = "0";
    tableMain.width = "100%";
    for (let index in invoiceForCustomers) {
        let trMain = _tr_.cloneNode(false);
        let tdMain = _td_.cloneNode(false);

        table = _table_.cloneNode(false)
        table.width = "100%";

        tr = _tr_.cloneNode(false);

        td = _td_.cloneNode(false);
        td.width = '3%';
        td.style = "text-align:right; padding: 0 10px 0 5px; font-weight: bold;"
        td.appendChild(document.createTextNode('ID:'));
        tr.appendChild(td)

        td = _td_.cloneNode(false);
        td.width = '27%';
        td.style = "text-align:left;"
        td.appendChild(document.createTextNode(invoiceForCustomers[index].customerId));
        tr.appendChild(td)

        td = _td_.cloneNode(false);
        td.width = '10%';
        td.style = "text-align:right; padding: 0 10px 0 5px; font-weight: bold;"
        td.appendChild(document.createTextNode('Customer name:'));
        tr.appendChild(td)

        td = _td_.cloneNode(false);
        td.width = '20%';
        td.style = "text-align:left;"
        td.appendChild(document.createTextNode(invoiceForCustomers[index].customerName));
        tr.appendChild(td)

        td = _td_.cloneNode(false);
        td.width = '10%';
        td.style = "text-align:right; padding: 0 10px 0 5px; font-weight: bold;"
        td.appendChild(document.createTextNode('Domain name:'));
        tr.appendChild(td);
        
        td = _td_.cloneNode(false);
        td.appendChild(document.createTextNode(invoiceForCustomers[index].domainName));
        tr.appendChild(td);

        table.appendChild(tr);

        tr = _tr_.cloneNode(false);

        td = _td_.cloneNode(false);
        td.appendChild(document.createTextNode(''));
        tr.appendChild(td)

        td = _td_.cloneNode(false);
        td.appendChild(document.createTextNode(''));
        tr.appendChild(td)

        td = _td_.cloneNode(false);
        td.appendChild(document.createTextNode(''));
        tr.appendChild(td)

        td = _td_.cloneNode(false);
        td.appendChild(document.createTextNode(''));
        tr.appendChild(td)

        td = _td_.cloneNode(false);
        td.style = "text-align:right; padding: 0 10px 0 5px; font-weight: bold;"
        td.appendChild(document.createTextNode('Total Charges:'));
        tr.appendChild(td);
        
        td = _td_.cloneNode(false);
        td.appendChild(document.createTextNode(invoiceForCustomers[index].totalCharges + ' ' + invoiceForCustomers[index].currencyCode));
        tr.appendChild(td);

        table.appendChild(tr);


        tr = _tr_.cloneNode(false);
        td = _td_.cloneNode(false);        
        td.colSpan = "6";

        let itemTable, itemTr, itemTh, itemTd;

        itemTable = _table_.cloneNode(false)
        itemTable.width = "100%";
        itemTable.border = "1";

        itemTr = _tr_.cloneNode(false);

        itemTh = _th_.cloneNode(false);
        itemTh.width = "10%";
        itemTh.style = "text-align:center";
        itemTh.appendChild(document.createTextNode('Orfer ID'));
        itemTr.appendChild(itemTh);

        itemTh = _th_.cloneNode(false);
        itemTh.style = "text-align:center";
        itemTh.appendChild(document.createTextNode('Billing Date/Cycle Type'));
        itemTr.appendChild(itemTh);

        itemTh = _th_.cloneNode(false);
        itemTh.width = "8%";
        itemTh.style = "text-align:center";
        itemTh.appendChild(document.createTextNode('Cycle'));
        itemTr.appendChild(itemTh);

        itemTh = _th_.cloneNode(false);
        itemTh.width = "25%";
        itemTh.style = "text-align:center";
        itemTh.appendChild(document.createTextNode('Item'));
        itemTr.appendChild(itemTh);

        itemTh = _th_.cloneNode(false);
        itemTh.width = "8%";
        itemTh.style = "text-align:center";
        itemTh.appendChild(document.createTextNode('Unit Price'));
        itemTr.appendChild(itemTh);

        itemTh = _th_.cloneNode(false);
        itemTh.width = "5%";
        itemTh.style = "text-align:center";
        itemTh.appendChild(document.createTextNode('Quantity'));
        itemTr.appendChild(itemTh);

        itemTh = _th_.cloneNode(false);
        itemTh.width = "5%";
        itemTh.style = "text-align:center";
        itemTh.appendChild(document.createTextNode('Discount'));
        itemTr.appendChild(itemTh);

        itemTh = _th_.cloneNode(false);
        itemTh.width = "5%";
        itemTh.style = "text-align:center";
        itemTh.appendChild(document.createTextNode('Tax'));
        itemTr.appendChild(itemTh);

        itemTh = _th_.cloneNode(false);
        itemTh.width = "8%";
        itemTh.style = "text-align:center";
        itemTh.appendChild(document.createTextNode('Total Charges'));
        itemTr.appendChild(itemTh);

        itemTable.appendChild(itemTr);
        for (let itemIndex in invoiceForCustomers[index].items) {
            let item = invoiceForCustomers[index].items[itemIndex];
            itemTr = _tr_.cloneNode(false);

            itemTd = _td_.cloneNode(false);
            itemTd.appendChild(document.createTextNode(item.orderId));
            itemTr.appendChild(itemTd);

            let chargeStartDate = moment(item.chargeStartDate);
            let chargeEndDate = moment(item.chargeEndDate);
            itemTd = _td_.cloneNode(false);
            itemTd.style = "padding: 0 0px 0 10px;"
            itemTd.appendChild(document.createTextNode(chargeStartDate.format("MMM DD YYYY hh:mm:ss Z") + ' - ' + chargeEndDate.format("MMM DD YYYY hh:mm:ss Z")));
            itemTr.appendChild(itemTd);

            itemTd = _td_.cloneNode(false);
            itemTd.style = "padding: 0 0px 0 10px;"
            itemTd.appendChild(document.createTextNode(item.billingCycleType));
            itemTr.appendChild(itemTd);

            itemTd = _td_.cloneNode(false);
            itemTd.style = "padding: 0 0px 0 10px;"
            itemTd.appendChild(document.createTextNode(item.itemName));
            itemTr.appendChild(itemTd);

            itemTd = _td_.cloneNode(false);
            itemTd.style = "text-align:right; padding: 0 10px 0 5px;"
            itemTd.appendChild(document.createTextNode(item.unitPrice + ' ' + item.currency));
            itemTr.appendChild(itemTd);

            itemTd = _td_.cloneNode(false);
            itemTd.style = "text-align:right; padding: 0 10px 0 5px;"
            itemTd.appendChild(document.createTextNode(item.quantity));
            itemTr.appendChild(itemTd);

            itemTd = _td_.cloneNode(false);
            itemTd.style = "text-align:right; padding: 0 10px 0 5px;"
            itemTd.appendChild(document.createTextNode(item.totalOtherDiscount + ' ' + item.currency));
            itemTr.appendChild(itemTd);

            itemTd = _td_.cloneNode(false);
            itemTd.style = "text-align:right; padding: 0 10px 0 5px;"
            itemTd.appendChild(document.createTextNode(item.tax + ' ' + item.currency));
            itemTr.appendChild(itemTd);

            itemTd = _td_.cloneNode(false);
            itemTd.style = "text-align:right; padding: 0 10px 0 5px;"
            itemTd.appendChild(document.createTextNode(item.postTaxTotal + ' ' + item.currency));
            itemTr.appendChild(itemTd);

            itemTable.appendChild(itemTr);
        }

        td.appendChild(itemTable);
        tr.appendChild(td);
        table.appendChild(tr);

        tr = _tr_.cloneNode(false);

        td = _td_.cloneNode(false);
        td.appendChild(document.createTextNode(' '));
        tr.appendChild(td)

        td = _td_.cloneNode(false);
        td.appendChild(document.createTextNode(''));
        tr.appendChild(td)

        td = _td_.cloneNode(false);
        td.appendChild(document.createTextNode(''));
        tr.appendChild(td)

        td = _td_.cloneNode(false);
        td.appendChild(document.createTextNode(''));
        tr.appendChild(td)

        td = _td_.cloneNode(false);
        td.appendChild(document.createTextNode(''));
        tr.appendChild(td);
        table.appendChild(tr);

        tdMain.appendChild(table);
        trMain.appendChild(tdMain);
        tableMain.appendChild(trMain);
    }
    var divContainer = document.getElementById("customers_invoice_table");
    divContainer.innerHTML = "";
    divContainer.appendChild(tableMain);
    } catch (error) {
        console.warn(error);
    }
}
buildDataInvoiceForCustomers();
{/literal}
</script>


{else}
    <div class="imp_msg">
<strong>หมายเหตุ:</strong> <br>
App "Netway Azure Partner API" ไม่ได้ทำการ connection. โปรดไปที่เมนู Serrings/Apps Connections และทำการ Connection App "Netway Azure Partner API" ให้เสร็จก่อน.<br>
</div>
{/if}
{include file="$tplPath/admin/footer.tpl"}
