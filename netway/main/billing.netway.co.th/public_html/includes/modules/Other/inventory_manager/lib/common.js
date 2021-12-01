function parseSubmit(response, postdata) {
    var data = response.responseText;
    var codes = eval('(' + data.substr(data.indexOf('<!-- ') + 4, data.indexOf('-->') - 4) + ')');
    var pass = true;
    var msg = "";
    for (var i = 0; i < codes.ERROR.length; i++) {
        msg += codes.ERROR[i];
        pass = false;
    }
    return [pass, msg]
}

function onFaceboxSubmit() {
    $(document).trigger('before.ivtmn.submit');
    var facebox = $('#facebox'),
        form = facebox.find('#submitform');

    var subitem = $('.ui-subgrid .ui-state-highlight'),
        grid = $('#list2');

    $.post(form.attr('action'), form.serializeArray(), function (data, status, xhr) {
        $.facebox.close()
        if (xhr.getResponseHeader("content-type").match('application/json') && data.rows) {

            grid.setGridParam({
                datatype: 'local',
                data: data
            }).trigger('reloadGrid')
                .setGridParam({
                    datatype: 'json',
                });
            jqGridInfos(grid);
            return;
        }

        parse_response(data);
        if (subitem.length)
            subitem.parents('.ui-subgrid:first').prev().find('td:first').trigger('click').trigger('click');
        else {
            grid.trigger("reloadGrid")
        }

    })
    return false;
}

function helptoggle() {
    $('#helpcontainer > .menuitm').toggle();
    $('#helpcontainer .blank_state_smaller').eq(0).toggle();
    return false;
}


function getportdetails(url) {
    $('.spinner').show();
    $('#porteditor').hide().html('');
    $.get(url, function (data) {
        $('.spinner').hide();
        $('#porteditor').html(data).show();
    });
}

function highlight() {
    var post = $.extend({}, this.p.postData),
        search = this.p.search === true;
    if (post.sn && post.sn.length) {
        search = true;
        post.searchField = 'sn';
        post.searchString = post.sn;
    }
    if (search === true) {
        for (var i = 0; i < this.p.colModel.length; i++) {
            if (this.p.colModel[i].index == post.searchField) {
                $('>tbody>tr.jqgrow>td:nth-child(' + (i + 1) +
                    ')', this).highlight(post.searchString);
            }
        }
    }
}

function printQr() {
    var printp = window.open(document.getElementById('qrcodeimage').src + '&print=1', '_blank')
    printp.onload = function () {
        printp.print();
    };
    return false;
}

function showFacebox(url) {
    $.facebox({
        ajax: url,
        width: 900,
        nofooter: true,
        opacity: 0.8,
        addclass: 'modernfacebox'
    });
    return false;
}

function showFaceboxPost(url, data) {
    data = data || {};
    $.facebox.loading(0.8);
    $('#facebox .footer').remove();
    $('#facebox .body').width(900)
    $('#facebox').addClass('modernfacebox');
    $.post(url, data, function (data) {
        $.facebox.reveal(data)
    });
    return false;
}

function jqFaceboxForm(title, action, cols, colnames, row) {
    row = row || {};
    var tab = {
        title: title,
        forms: [],
        values: row
    },
    sepc = {
        tabs: [tab],
        action: action
    };
    $.each(cols, function (i, col) {
        if (!col.editable)
            return;

        var name = colnames[i] || col.name || 'no_name',
            index = col.name || col.index || '',
            value = row && row[index] || '';

        tab.forms.push({
            name: name,
            index: index,
            value: value,
            type: col.edittype || 'text',
            placeholder: col.placeholder,
            tpl: col.tpl
        });
    })

    $.facebox.loading(0.8);
    $('#facebox .footer').remove();
    $('#facebox .body').width(900)
    $('#facebox').addClass('modernfacebox');
    $.facebox.dynamic(sepc)
}
function jqGridAddEditBeforeInitData(gridElem, gridspec) {
    var grid = $(gridElem),
        init = function (e) {
            var row = grid.getRowData(grid.getGridParam('selrow'));
            jqFaceboxForm("Shipping",
                'index.php?cmd=inventory_manager&action=shipping&oper=edit&id=' + row.id,
                gridspec.colModel,
                gridspec.colNames,
                row);
            return false;
        };

    grid.off('jqGridAddEditBeforeInitData')
        .on('jqGridAddEditBeforeInitData', init);
}

function jqGridSetupOnEdit(name, gridElem, gridspec) {
    var grid = $(gridElem),
        init = function (e) {
            var row = grid.getRowData(grid.getGridParam('selrow'));
            jqFaceboxForm(name,
                gridspec.editurl + '&oper=edit&id=' + row.id,
                gridspec.colModel,
                gridspec.colNames,
                row);
            return false;
        };

    grid.off('jqGridAddEditBeforeInitData')
        .on('jqGridAddEditBeforeInitData', init);
}

function jqGridOnAdd(name, gridspec) {
    jqFaceboxForm(name,
        gridspec.editurl + '&oper=add',
        gridspec.colModel,
        gridspec.colNames);
    return false;
}
var jqGridInfos_t;
function jqGridInfos(grid) {
    //may be called by multiple events
    clearTimeout(jqGridInfos_t);
    jqGridInfos_t = setTimeout(function () {
        var i, l,
            $grid = $(grid),
            task = $('#taskMGR'),
            data = $grid.getGridParam('data');

        if (!data || !data.userdata) {
            data = $grid.getGridParam('userData')
        }else
            data = data.userdata;

        if (data.errors)
            for (i = 0, l = data.errors.length; i < l; i++) {
                task.taskMgrAddError(data.errors[i]);
            }

        if (data.infos)
            for (i = 0, l = data.infos.length; i < l; i++) {
                task.taskMgrAddError(data.infos[i]);
            }
    }, 200);
}

function setjGridHeight() {
    $("#list2").jqGrid('setGridHeight', $(window).height() - $('.ui-jqgrid-bdiv').offset().top -
        ($('#bodycont').offset().top + $('#bodycont').height() - $('#pager2').offset().top + $('#pager2').height()))
}

$(function () {
    if (window.location.hash && window.location.hash.match(/^#e\d+$/))
        showFacebox('?cmd=inventory_manager&action=entity&id=' + window.location.hash.match(/^#e(\d+)$/)[1])

    $('#smarts2').SmartSearch({
        target: '#smartres2',
        url: '?cmd=inventory_manager&action=search&lightweight=1',
        submitel: '#search_submiter2',
        results: '#smartres-results2',
        container: '#search_form_container2'
    });
});

var DefaultGRID = {
    autowidth: true,
    datatype: "json",
    rowNum: perPageRows ? perPageRows : 50,
    height: 'auto',
    rowList: [50, 100, 150],
    pager: '#pager2',
    sortname: 'id',
    viewrecords: true,
    sortorder: "desc"
}

var GridTemplates = {
    vendors: {
        grid: $.extend({}, DefaultGRID, {
            url: 'index.php?cmd=inventory_manager&action=vendors',
            editurl: 'index.php?cmd=inventory_manager&action=vendors',
            colNames: [' ', 'ID', 'Code', 'Name', 'Contact', 'Description'],
            colModel: [
                {name: 'myac', width: 80, fixed: true, sortable: false, resize: false, formatter: 'actions', formatoptions: {editformbutton: true, keys: true}},
                {name: 'id', index: 'id', width: 55, editable: false, editoptions: {readonly: true, size: 10}},
                {name: 'code', index: 'code', width: 80, editable: true, editoptions: {size: 10}},
                {name: 'name', index: 'name', width: 90, editable: true, editoptions: {size: 25}},
                {name: 'contact', index: 'contact', width: 100, editable: true, edittype: "textarea", editoptions: {rows: "5", cols: "35"}},
                {name: 'description', index: 'description', width: 100, sortable: false, editable: true, edittype: "textarea", editoptions: {rows: "5", cols: "35"}}
            ],
            gridComplete: function () {
                jqGridSetupOnEdit("Edit Vendor", this, GridTemplates.vendors.grid)
            }
        }),
        nav: [
            {
                addfunc: function () {
                    jqGridOnAdd("Add Vendor", GridTemplates.vendors.grid);
                },
                edit: false
            }, //options
            {height: 380, reloadAfterSubmit: true, afterSubmit: parseSubmit, closeAfterEdit: true, closeOnEscape: true}, // edit options
            {height: 380, reloadAfterSubmit: true, afterSubmit: parseSubmit, closeAfterAdd: true, closeOnEscape: true}, // add options
            {reloadAfterSubmit: true}, // del options
            {} // search options
        ]
    },
    fields: {
        grid: $.extend({}, DefaultGRID, {
            url: 'index.php?cmd=inventory_manager&action=fields',
            editurl: 'index.php?cmd=inventory_manager&action=fields',
            colNames: [' ', 'ID', 'Name', 'Variable', 'Type', 'Description'],
            colModel: [
                {name: 'myac', width: 50, fixed: true, sortable: false, resize: true, formatter: 'actions', formatoptions: {editformbutton: true, keys: true}},
                {name: 'id', index: 'id', width: 55, editable: false, editoptions: {readonly: true, size: 10}},
                {name: 'name', index: 'name', width: 80, editable: true, editoptions: {size: 10}},
                {name: 'variable', index: 'variable', editrules:{required:true}, width: 90, editable: true, editoptions: {size: 25}},
                {name: 'type', index: 'type', width: 100, options: {input:'Input'}, editable: true, edittype:'select', formatter:'select', editoptions:{value:"input:Input;textarea:Textarea;date:Date"}},
                {name: 'description', index: 'description', width: 100, sortable: false, editable: true, edittype: "textarea", editoptions: {rows: "5", cols: "35"}}
            ],
            multiselect: true,
            multiboxonly: true,
            gridComplete: function () {
                jqGridSetupOnEdit("Edit Item Field", this, GridTemplates.fields.grid)
            }
        }),
        nav: [
            {
                addfunc: function () {
                    jqGridOnAdd("Add Item Field", GridTemplates.fields.grid);
                },
                edit: false
            }, //options
            {height: 380, reloadAfterSubmit: true, afterSubmit: parseSubmit, closeAfterEdit: true, closeOnEscape: true},
            {height: 380, reloadAfterSubmit: true, afterSubmit: parseSubmit, closeAfterAdd: true, closeOnEscape: true},
            {reloadAfterSubmit: true},
            {}
        ]
    },
    shipping: {
        grid: $.extend({}, DefaultGRID, {
            url: 'index.php?cmd=inventory_manager&action=shipping',
            editurl: 'index.php?cmd=inventory_manager&action=shipping',
            colNames: [' ', 'ID', 'Name', 'Description', 'Tracking URL'],
            colModel: [
                {name: 'myac', width: 80, fixed: true, sortable: false,
                    resize: false, formatter: 'actions',
                    formatoptions: {editformbutton: true, keys: true}},
                {name: 'id', index: 'id', width: 55, editable: false,
                    editoptions: {readonly: true, size: 10, }},
                {name: 'name', index: 'name', width: 90, editable: true,
                    editoptions: {size: 25}},
                {name: 'description', index: 'description', width: 100,
                    editable: true, edittype: "textarea",
                    editoptions: {rows: "5", cols: "35"}},
                {name: 'tracking_url', index: 'tracking_url', width: 100,
                    sortable: false, editable: true, edittype: "textarea",
                    editoptions: {rows: "5", cols: "35"}}
            ],
            gridComplete: function () {
                jqGridSetupOnEdit("Shipping", this, GridTemplates.shipping.grid)
                jqGridInfos(this)
            }
        }),
        nav: [
            {
                addfunc: function () {
                    jqGridOnAdd("Shipping", GridTemplates.shipping.grid);
                },
                edit: false
            }, //options
            {height: 380, reloadAfterSubmit: true, afterSubmit: parseSubmit, closeAfterEdit: true, closeOnEscape: true}, // edit options
            {height: 380, reloadAfterSubmit: true, afterSubmit: parseSubmit, closeAfterAdd: true, closeOnEscape: true}, // add options
            {reloadAfterSubmit: true}, // del options
            {} // search options
        ]
    },
    settings: {
        grid: $.extend({}, DefaultGRID, {
            url: 'index.php?cmd=inventory_manager&action=settings',
            editurl: 'index.php?cmd=inventory_manager&action=settings',
            loadui: 'block',
            ajaxRowOptions: {async: true},
            colNames: ['ID', 'Setting', 'Value', 'Description'],
            colModel: [
                {name: 'id', index: 'id', hidden: true, editable: false, editoptions: {readonly: true, size: 10}},
                {name: 'name', index: 'name', width: 90, editable: false, editoptions: {size: 25}},
                {name: 'value', index: 'value', width: 90, editable: true, formatter: "checkbox", formatoptions: {disabled: true}, edittype: 'checkbox', editoptions: {value: "True:False"}},
                {name: 'description', index: 'description', width: 500, sortable: false, editable: false}
            ],
            gridComplete: function () {
                var self = $(this),
                    ids = $(this).jqGrid('getDataIDs');
                for (var i = 0; i < ids.length; i++) {
                    self.editRow(ids[i], false);
                }
                self.on('change', '.editable', function (e) {
                    var row_id = $(this).closest('tr').attr('id');
                    self[0].grid.beginReq();

                    self.saveRow(row_id, {
                        aftersavefunc: function () {
                            self[0].grid.endReq();
                            self.editRow(row_id, false);
                        }
                    });

                })
            },
        }),
        nav: [
            {search: false, del: false, add: false, edit: false}, //options
            {height: 280, reloadAfterSubmit: true, afterSubmit: parseSubmit, closeAfterEdit: true, closeOnEscape: true}, // edit options
            {}, // add options
            {}, // del options
            {} // search options
        ]
    },
    producers: {
        grid: $.extend({}, DefaultGRID, {
            url: 'index.php?cmd=inventory_manager&action=producers',
            editurl: 'index.php?cmd=inventory_manager&action=producers',
            colNames: ['', 'ID', 'Code', 'Name', 'Website', 'Description'],
            colModel: [
                {name: 'myac', width: 80, fixed: true, sortable: false, resize: false, formatter: 'actions', formatoptions: {editformbutton: true, keys: true}},
                {name: 'id', index: 'id', width: 55, editable: false, editoptions: {readonly: true, size: 10}},
                {name: 'code', index: 'code', width: 80, editable: true, editoptions: {size: 10}},
                {name: 'name', index: 'name', width: 90, editable: true, editoptions: {size: 25}},
                {name: 'website', index: 'website', formatter: 'link', width: 100, editable: true, editoptions: {size: 25}},
                {name: 'description', index: 'description', width: 100, sortable: false, editable: true, edittype: "textarea", editoptions: {rows: "5", cols: "35"}}
            ],
            gridComplete: function () {
                jqGridSetupOnEdit("Edit Manufacturer", this, GridTemplates.producers.grid)
            }
        }),
        nav: [
            {
                addfunc: function () {
                    jqGridOnAdd("Add Manufacturer", GridTemplates.producers.grid);
                },
                edit: false
            }, //options
            {height: 280, reloadAfterSubmit: true, afterSubmit: parseSubmit, closeAfterEdit: true, closeOnEscape: true}, // edit options
            {height: 280, reloadAfterSubmit: true, afterSubmit: parseSubmit, closeAfterAdd: true, closeOnEscape: true}, // add options
            {reloadAfterSubmit: true}, // del options
            {} // search options
        ]
    },
    deliveries: {
        grid: $.extend({}, DefaultGRID, {
            url: 'index.php?cmd=inventory_manager&action=deliveries',
            editurl: 'index.php?cmd=inventory_manager&action=deliveries',
            colNames: ['', 'ID', 'Date', 'Total (cost)', 'Order ID',
                'Invoice ID', 'Items', 'Vendor', 'Shipping', 'Entered By'],
            colModel: [
                {name: 'myac', width: 10, sortable: false, search: false, resize: false},
                {name: 'id', index: 'id', width: 55},
                {name: 'date', index: 'date', width: 90},
                {name: 'total', index: 'total', width: 90, formatter: 'currency', formatoptions: currencySettings},
                {name: 'order_id', index: 'order_id', width: 90},
                {name: 'invoice_id', index: 'invoice_id', width: 90},
                {name: 'items', index: 'items', width: 55, search: false},
                {name: 'vendor', index: 'vendor', width: 55},
                {name: 'shipping', index: 'shipping', width: 80,
                    formatter: function (cellvalue, options, rowObject) {
                        if (rowObject.tracking_num && rowObject.tracking_url) {
                            var track = rowObject.tracking_url;

                            if (track.indexOf('%number%') === -1)
                                track += rowObject.tracking_num;
                            else
                                track = track.replace(/%number%/g, rowObject.tracking_num)

                            return '<a href="' + track + '" target="_blank">'
                                + rowObject.tracking_num + '</a>';
                        }
                        return cellvalue || 'None';
                    }},
                {name: 'received_by', index: 'received_by', width: 80}
            ],
            subGrid: true,
            sortorder: "asc",
            multiselect: true,
            multiboxonly: true,
            gridComplete: function () {
                var ids = $(this).jqGrid('getDataIDs');
                for (var i = 0; i < ids.length; i++) {
                    var cl = ids[i];
                    be = "<div title='Edit selected row' style='float:left;cursor:pointer;' class='ui-pg-div ui-inline-edit'  onclick='showFacebox(\"?cmd=inventory_manager&action=newdelivery&id=" + cl + "\")'><span class='ui-icon ui-icon-pencil'></span></div>";
                    $(this).jqGrid('setRowData', ids[i], {myac: be});
                }
            },
            subGridOptions: {
                "plusicon": "ui-icon-triangle-1-e",
                "minusicon": "ui-icon-triangle-1-s",
                "openicon": "ui-icon-arrowreturn-1-e"
            },
            subGridRowExpanded: function (subgrid_id, row_id) {
// we pass two parameters
// subgrid_id is a id of the div tag created whitin a table data
// the id of this elemenet is a combination of the "sg_" + id of the row
// the row_id is the id of the row
// If we wan to pass additinal parameters to the url we can use
// a method getRowData(row_id) - which returns associative array in type name-value
// here we can easy construct the flowing
                var subgrid_table_id, pager_id, category_id = row_id;
                subgrid_table_id = subgrid_id + "_t";
                pager_id = "p_" + subgrid_table_id;
                $("#" + subgrid_id).html("<table id='" + subgrid_table_id + "' class='scroll' ></table><div id='" + pager_id + "' class='scroll'></div>").css('margin', 5);
                jQuery("#" + subgrid_table_id).jqGrid($.extend({}, DefaultGRID, {
                    url: 'index.php?cmd=inventory_manager&action=inventorylist&delivery_id=' + category_id,
                    editurl: 'index.php?cmd=inventory_manager&action=inventorylist&delivery_id=' + category_id,
                    colNames: [' ', 'ID', 'Name', 'Manufacturer', 'S/N', 'Price', 'Retail Price', 'Guarantee', 'Support', 'Location', 'Status'],
                    colModel: [
                        {name: 'myac', width: 10, sortable: false, search: false, resize: false},
                        {name: 'id', index: 'id', hidden: true, search: false},
                        {name: 'name', index: 'name', width: 80},
                        {name: 'manufacturer', index: 'manufacturer', width: 80},
                        {name: 'sn', index: 'sn', width: 80},
                        {name: 'price', index: 'price', width: 80, formatter: 'currency', formatoptions: currencySettings},
                        {name: 'retail_price', index: 'retail_price', width: 80, formatter: 'currency', formatoptions: currencySettings},
                        {name: 'guarantee', index: 'guarantee', width: 90},
                        {name: 'support', index: 'support', width: 90},
                        {name: 'localisation', index: 'localisation', width: 90},
                        {name: 'status', index: 'status', width: 80}
                    ],
                    pager: pager_id,
                    sortname: 'name',
                    multiselect: true,
                    multiboxonly: true,
                    gridComplete: function () {
                        var ids = jQuery("#" + subgrid_table_id).jqGrid('getDataIDs');
                        for (var i = 0; i < ids.length; i++) {
                            var cl = ids[i];
                            be = "<div title='Edit selected row' style='float:left;cursor:pointer;' class='ui-pg-div ui-inline-edit'  onclick='showFacebox(\"?cmd=inventory_manager&action=entity&id=" + cl + "\")'><span class='ui-icon ui-icon-pencil'></span></div>";
                            jQuery("#" + subgrid_table_id).jqGrid('setRowData', ids[i], {myac: be});
                        }
                    }

                }));
                jQuery("#" + subgrid_table_id).jqGrid('navGrid', "#" + pager_id,
                    {edit: false, add: false}, //options editfunc:function(id){console.log(id)}
                    {}, // edit options
                    {height: 380, reloadAfterSubmit: true}, // add options
                    {reloadAfterSubmit: true}, // del options
                    {} // search options
                );
            }
        }),
        nav: [
            {edit: false, del: true, search: true, add: false}, //options
            {}, // edit options
            {}, // add options
            {reloadAfterSubmit: true}, // del options
            {} // search options
        ]
    },
    deployments: {
        grid: $.extend({}, DefaultGRID, {
            url: 'index.php?cmd=inventory_manager&action=deployments',
            editurl: 'index.php?cmd=inventory_manager&action=deployments',
            colNames: ['', 'ID', 'Name', 'Description', 'Active use', 'Status'],
            colModel: [
                {name: 'myac', width: 10, sortable: false, search: false, resize: false},
                {name: 'id', index: 'id', width: 55},
                {name: 'name', index: 'name', width: 90},
                {name: 'description', index: 'description', width: 120},
                {name: 'inuse', index: 'inuse', width: 55, search: false},
                {name: 'status', index: 'status', width: 90}

            ],
            subGrid: true,
            sortorder: "asc",
            multiselect: true,
            multiboxonly: true,
            subGridOptions: {
                "plusicon": "ui-icon-triangle-1-e",
                "minusicon": "ui-icon-triangle-1-s",
                "openicon": "ui-icon-arrowreturn-1-e"
            }, gridComplete: function () {
                var ids = $(this).jqGrid('getDataIDs');
                for (var i = 0; i < ids.length; i++) {
                    var cl = ids[i];
                    var be = "<div title='Edit selected row' style='float:left;cursor:pointer;' class='ui-pg-div ui-inline-edit'  onclick='showFacebox(\"?cmd=inventory_manager&action=newproduct&id=" + cl + "\")'><span class='ui-icon ui-icon-pencil'></span></div>";
                    $(this).jqGrid('setRowData', ids[i], {myac: be});
                }
            },
            subGridRowExpanded: function (subgrid_id, row_id) {
//debugger;
                var subgrid_table_id, pager_id, category_id = row_id;
                subgrid_table_id = subgrid_id + "_t";
                pager_id = "p_" + subgrid_table_id;
                $("#" + subgrid_id).html("<table id='" + subgrid_table_id + "' class='scroll' ></table><div id='" + pager_id + "' class='scroll'></div>").css('margin', 5);
                jQuery("#" + subgrid_table_id).jqGrid({
                    url: 'index.php?cmd=inventory_manager&action=deploymentitems&deployment_id=' + category_id,
                    editurl: 'index.php?cmd=inventory_manager&action=deploymentitems&deployment_id=' + category_id,
                    autowidth: true,
                    datatype: "json",
                    colNames: ['ID', 'Category', 'Name', 'Code', 'Items in stock'],
                    colModel: [
                        {name: 'id', index: 'id', hidden: true, search: false},
                        {name: 'category', index: 'category', width: 80},
                        {name: 'name', index: 'name', width: 120},
                        {name: 'code', index: 'code', width: 80},
                        {name: 'totl', index: 'totl', width: 80}

                    ],
                    rowNum: 10,
                    height: '100%',
                    rowList: [10, 20, 30],
                    pager: pager_id,
                    sortname: 'name',
                    viewrecords: true,
                    sortorder: "desc",
                    multiselect: true,
                    multiboxonly: true,
                    gridComplete: function () {
                        var ids = jQuery("#" + subgrid_table_id).jqGrid('getDataIDs');
                        for (var i = 0; i < ids.length; i++) {
                            var cl = ids[i];
                            be = "<div title='Edit selected row' style='float:left;cursor:pointer;' class='ui-pg-div ui-inline-edit'  onclick='showFacebox(\"?cmd=inventory_manager&action=entity&id=" + cl + "\")'><span class='ui-icon ui-icon-pencil'></span></div>";
                            jQuery("#" + subgrid_table_id).jqGrid('setRowData', ids[i], {myac: be});
                        }
                    }

                });
                jQuery("#" + subgrid_table_id).jqGrid('navGrid', "#" + pager_id,
                    {edit: false, add: false, del: true, search: false}, //options editfunc:function(id){console.log(id)}
                    {}, // edit options
                    {height: 380, reloadAfterSubmit: true}, // add options
                    {reloadAfterSubmit: true}, // del options
                    {} // search options
                );
            }
        }),
        nav: [
            {edit: false, del: true, search: true, add: false}, //options
            {}, // edit options
            {}, // add options
            {reloadAfterSubmit: true}, // del options
            {} // search options
        ]
    },
    inventory: {
        grid: $.extend({}, {}, DefaultGRID, {
            url: 'index.php?cmd=inventory_manager&action=inventory',
            editurl: 'index.php?cmd=inventory_manager&action=categories',
            colNames: ['', 'ID', 'Name', 'All Items', 'Unused items', 'Description'],
            colModel: [
                {name: 'myac', width: 10, sortable: false, resize: false},
                {name: 'id', index: 'id', width: 55, editable: false, editoptions: {readonly: true, size: 10}},
                {name: 'name', index: 'name', width: 90, editable: true, editoptions: {size: 25}},
                {name: 'items', index: 'items', width: 55, editable: false, editoptions: {readonly: true, size: 10}},
                {name: 'freeitems', index: 'freeitems', width: 55, editable: false, editoptions: {readonly: true, size: 10}},
                {name: 'description', index: 'description', width: 100, sortable: false, editable: true, edittype: "textarea", editoptions: {rows: "5", cols: "35"}}
            ],
            subGrid: true,
            sortorder: "asc",
            gridComplete: function () {
                var ids = $(this).jqGrid('getDataIDs');
                for (var i = 0; i < ids.length; i++) {
                    var cl = ids[i];
                    be = "<div title='Category listing' style='float:left;cursor:pointer;' class='ui-pg-div ui-inline-edit'  onclick='window.location=\"?cmd=inventory_manager&action=inventorylist&category_id=" + cl + "\"'><span class='ui-icon ui-icon-folder-open'></span></div>";
                    $(this).jqGrid('setRowData', ids[i], {myac: be});
                }
            },
            subGridOptions: {
                "plusicon": "ui-icon-triangle-1-e",
                "minusicon": "ui-icon-triangle-1-s",
                "openicon": "ui-icon-arrowreturn-1-e"
            },
            subGridRowExpanded: function (subgrid_id, row_id) {
                var subgrid_table_id, pager_id, category_id = row_id;
                subgrid_table_id = subgrid_id + "_t";
                pager_id = "p_" + subgrid_table_id;
                $("#" + subgrid_id).html("<table id='" + subgrid_table_id + "' class='scroll' ></table><div id='" + pager_id + "' class='scroll'></div>").css('margin', 5);
                jQuery("#" + subgrid_table_id).jqGrid($.extend({}, DefaultGRID, DefaultGRID, {
                    url: 'index.php?cmd=inventory_manager&action=inventorylist&category_id=' + category_id,
                    editurl: 'index.php?cmd=inventory_manager&action=inventorylist&category_id=' + category_id,
                    colNames: [' ', 'ID', 'Name', 'Manufacturer', 'Vendor', 'SN',
                        'Price', 'Retail Price', 'Guarantee', 'Support',
                        'Location', 'Tested', 'Status'],
                    colModel: [
                        {name: 'myac', width: 15, sortable: false, search: false, resize: false},
                        {name: 'id', index: 'id', hidden: true, search: false},
                        {name: 'name', index: 'name', width: 80},
                        {name: 'manufacturer', index: 'manufacturer', width: 80},
                        {name: 'vendor', index: 'vendor', width: 80},
                        {name: 'sn', index: 'sn', width: 80},
                        {name: 'price', index: 'price', width: 80,
                            formatter: 'currency', formatoptions: currencySettings},
                        {name: 'retail_price', index: 'retail_price', width: 80,
                            formatter: 'currency', formatoptions: currencySettings},
                        {name: 'guarantee', index: 'guarantee', width: 90},
                        {name: 'support', index: 'support', width: 90},
                        {name: 'localisation', index: 'localisation', width: 90},
                        {name: 'tested', index: 'tested', align: 'center',
                            width: 40, formatter: function (cellvalue, options, rowObject) {
                                return '<span ' + (cellvalue == 1 ? 'class="fa fa-lg fa-check-circle" title="Tested / Wroking"' : 'class="fa fa-lg fa-exclamation-circle" title="Not Tested / Broken"') + '></span>'
                            }},
                        {name: 'status', index: 'status', width: 80}
                    ],
                    pager: pager_id,
                    multiselect: true,
                    multiboxonly: true,
                    sortname: 'name',
                    gridComplete: function () {
                        var ids = jQuery("#" + subgrid_table_id).jqGrid('getDataIDs');
                        for (var i = 0; i < ids.length; i++) {
                            var cl = ids[i];
                            be = "<div title='Edit selected row' style='float:left;cursor:pointer;' class='ui-pg-div ui-inline-edit'  onclick='showFacebox(\"?cmd=inventory_manager&action=entity&id=" + cl + "\")'><span class='ui-icon ui-icon-pencil'></span></div>";
                            jQuery("#" + subgrid_table_id).jqGrid('setRowData', ids[i], {myac: be});
                        }
                    }

                }));
                jQuery("#" + subgrid_table_id).jqGrid('navGrid', "#" + pager_id,
                    {edit: false, add: false}, //options editfunc:function(id){console.log(id)}
                    {}, // edit options
                    {height: 380, reloadAfterSubmit: true}, // add options
                    {reloadAfterSubmit: true}, // del options
                    {} // search options
                );
            }
        }),
        nav: [
            {edit: false, del: false, search: false, add: false}, //options
            {}, // edit options
            {}, // add options
            {reloadAfterSubmit: true}, // del options
            {} // search options
        ]
    },
    inventorylist: {
        grid: $.extend({}, DefaultGRID, {
            url: 'index.php?cmd=inventory_manager&action=inventorylist&category_id=',
            editurl: 'index.php?cmd=inventory_manager&action=inventorylist&category_id=',
            colNames: [' ', 'ID', 'Name', 'Manufacturer', 'Vendor', 'SN', 'Price', 'Retail Price', 'Guarantee', 'Support', 'Location', 'Status'],
            colModel: [
                {name: 'myac', width: 10, sortable: false, search: false, resize: false},
                {name: 'id', index: 'id', hidden: true},
                {name: 'name', index: 'name', width: 80},
                {name: 'manufacturer', index: 'manufacturer', width: 80},
                {name: 'vendor', index: 'vendor', width: 80},
                {name: 'sn', index: 'sn', width: 80},
                {name: 'price', index: 'price', width: 80, formatter: 'currency',
                    formatoptions: currencySettings},
                {name: 'retail_price', index: 'retail_price', width: 80,
                    formatter: 'currency', formatoptions: currencySettings},
                {name: 'guarantee', index: 'guarantee', width: 90},
                {name: 'support', index: 'support', width: 90},
                {name: 'localisation', index: 'localisation', width: 90},
                {name: 'status', index: 'status', width: 80}
            ],
            multiselect: true,
            multiboxonly: true,
            gridComplete: function () {

                var ids = $(this).jqGrid('getDataIDs');
                for (var i = 0; i < ids.length; i++) {
                    var cl = ids[i];
                    be = "<div title='Edit selected row' style='float:left;cursor:pointer;' class='ui-pg-div ui-inline-edit'  onclick='showFacebox(\"?cmd=inventory_manager&action=entity&id=" + cl + "\")'><span class='ui-icon ui-icon-pencil'></span></div>";
                    $(this).jqGrid('setRowData', ids[i], {myac: be});
                }
            }
        }),
        nav: [
            {edit: false, add: false}, //options editfunc:function(id){console.log(id)}
            {}, // edit options
            {height: 380, reloadAfterSubmit: true}, // add options
            {reloadAfterSubmit: true}, // del options
            {} // search options
        ]
    },
    categories: {
        grid: {
            url: 'index.php?cmd=inventory_manager&action=categories',
            editurl: 'index.php?cmd=inventory_manager&action=categories',
            autowidth: true,
            width: null,
            shrinkToFit: true,
            datatype: "json",
            colNames: ['', 'ID', 'Name', 'Description', 'Notification', 'Low QTY'],
            colModel: [
                {name: 'myac', width: 80, fixed: true, sortable: false,
                    resize: false, formatter: 'actions', search: false,
                    formatoptions: {editformbutton: true, keys: true}},
                {name: 'id', index: 'id', width: 55, editable: false,
                    editoptions: {readonly: true, size: 10}},
                {name: 'name', index: 'name', width: 90, editable: true,
                    editoptions: {size: 25}},
                {name: 'description', index: 'description', width: 100,
                    sortable: false, editable: true, edittype: "textarea",
                    editoptions: {rows: "5", cols: "35"}},
                {name: 'notify', index: 'notify', width: 90, editable: true, editrules: {required: true},
                    formatter: "select", formatoptions: { value: "0:Disabled;1:Enabled" },
                    edittype: "checkbox", editoptions: { value: "1:0", defaultValue: "0" }},
                {name: 'low_qty', index: 'low_qty', width: 90, editable: true,
                    editoptions: {size: 25}, sorttype: 'number'}
            ],
            gridComplete: function () {
                jqGridSetupOnEdit("Edit Category", this, GridTemplates.categories.grid)
            },
            rowNum: 50,
            height: 100,
            rowList: [50, 100, 150],
            pager: '#pager2',
            sortname: 'id',
            subGrid: true,
            viewrecords: true,
            sortorder: "desc",
            subGridOptions: {
                "plusicon": "ui-icon-triangle-1-e",
                "minusicon": "ui-icon-triangle-1-s",
                "openicon": "ui-icon-arrowreturn-1-e"
            },
            subGridRowExpanded: function (subgrid_id, row_id) {
                var subgrid_table_id = subgrid_id + "_t",
                    pager_id = "p_" + subgrid_table_id,
                    url = "index.php?cmd=inventory_manager&action=ihtype&category_id=" + row_id,
                    gridspec = {
                        url: url,
                        editurl: url,
                        datatype: "json",
                        autowidth: true,
                        colNames: ['', 'ID', 'Code', 'Name', 'Description',
                            'Default commission rate', ''],
                        colModel: [
                            {name: 'myac', width: 80, fixed: true, sortable: false, resize: false, formatter: 'actions', search: false,
                                formatoptions: {editformbutton: true, keys: true}},
                            {name: 'id', index: 'id', width: 35, editable: false, editoptions: {readonly: true, size: 10}},
                            {name: 'code', index: 'code', width: 80, editable: true, editoptions: {size: 10}},
                            {name: 'name', index: 'name', width: 90, editable: true, editoptions: {size: 25}},
                            {name: 'description', index: 'description', width: 100, sortable: false, editable: true, edittype: "textarea", editoptions: {rows: "5", cols: "35"}},
                            {name: 'rate', index: 'rate', width: 35,
                                formatter: function (cellvalue, options, rowObject) {
                                    console.log('rate formatter', rowObject)
                                    if (rowObject.rate_type == 'fixed')
                                        return $.fn.fmatter.currency(cellvalue, {currency: currencySettings});
                                    return cellvalue + '%'
                                },
                                unformat: function (cellvalue, options, cellobject) {
                                    return cellvalue.replace(/[^\d.]+/g, '')
                                },
                                tpl: '<input type="text" name="{{index}}" value="{{value}}" placeholder="{{placeholder}}" class="col-md-4" />\
                                    <select name="rate_type" class="col-md-4">\
                                        <option value="percent">% Percent</option>\n\
                                        <option value="fixed" {{#eq \'fixed\' values.rate_type}}selected{{/eq}}>Fixed</option>\n\
                                    </select>',
                                sortable: false, editable: true},
                            {name: 'rate_type', index: 'rate_type', hidden: true}
                        ],
                        gridComplete: function () {
                            jqGridSetupOnEdit("Edit Item Type", this, gridspec)
                        },
                        rowNum: 20,
                        rowList: [20, 50, 75],
                        pager: pager_id,
                        sortname: 'id',
                        sortorder: "asc",
                        height: '100%'
                    };
                $("#" + subgrid_id).html("<table id='" + subgrid_table_id + "' class='scroll' ></table><div id='" + pager_id + "' class='scroll'></div>").css('margin', 5);
                jQuery("#" + subgrid_table_id).jqGrid(gridspec);
                jQuery("#" + subgrid_table_id).jqGrid('navGrid', "#" + pager_id,
                    {
                        addfunc: function () {
                            jqGridOnAdd("Add Item Type", gridspec);
                        },
                        edit: false,
                        search: false},
                    {height: 380, width: 400, reloadAfterSubmit: true, afterSubmit: parseSubmit, closeAfterEdit: true, closeOnEscape: true}, // edit options
                    {height: 380, width: 400, reloadAfterSubmit: true, afterSubmit: parseSubmit, closeAfterAdd: true, closeOnEscape: true});
            }
        },
        nav: [
            {
                addfunc: function () {
                    jqGridOnAdd("Add Category", GridTemplates.categories.grid);
                },
                edit: false
            }, //options
            {height: 380, width: 400, reloadAfterSubmit: true, afterSubmit: parseSubmit, closeAfterEdit: true, closeOnEscape: true}, // edit options
            {height: 380, width: 400, reloadAfterSubmit: true, afterSubmit: parseSubmit, closeAfterAdd: true, closeOnEscape: true}, // add options
            {reloadAfterSubmit: true}, // del options
            {} // search options
        ]
    },
    builds: {
        grid: {
            url: 'index.php?cmd=inventory_manager&action=builds',
            editurl: 'index.php?cmd=inventory_manager&action=builds',
            autowidth: true,
            datatype: "json",
            colNames: ['', 'Build ID', 'Date added', 'Product Name', 'S/N', 'Related Account', 'Related Client'],
            colModel: [
                {name: 'myac', width: 10, sortable: false, search: false, resize: false},
                {name: 'id', index: 'id', width: 55},
                {name: 'date', index: 'date', width: 100},
                {name: 'product', index: 'product'},
                {name: 'sn',hidden: true, search: true, hidedlg:true, searchoptions: {
                    searchhidden: true
                }},
                {name: 'account_link', index: 'account_link', width: 120, search: false},
                {name: 'client_link', index: 'client_link', width: 120, search: false},
            ],
            rowNum: 10,
            height: 500,
            rowList: [10, 20, 30],
            pager: '#pager2',
            sortname: 'id',
            subGrid: true,
            viewrecords: true,
            sortorder: "asc",
            gridComplete: function () {
                var ids = $(this).jqGrid('getDataIDs');
                for (var i = 0; i < ids.length; i++) {
                    var cl = ids[i];
                    be = "<div title='Finish build/deliver' style='float:left;cursor:pointer;' class='ui-pg-div ui-inline-edit'  onclick='showFacebox(\"?cmd=inventory_manager&action=newbuild&id=" + cl + "\")'><span class='ui-icon ui-icon-circle-check'></span></div>";
                    $(this).jqGrid('setRowData', ids[i], {myac: be});
                }
            },
            subGridOptions: {
                "plusicon": "ui-icon-triangle-1-e",
                "minusicon": "ui-icon-triangle-1-s",
                "openicon": "ui-icon-arrowreturn-1-e"
            },
            subGridRowExpanded: function (subgrid_id, row_id) {

                var subgrid_table_id = subgrid_id + "_t",
                    pager_id = "p_" + subgrid_table_id,
                    category_id = row_id,
                    gridspec = {
                        url: 'index.php?cmd=inventory_manager&action=buildlist&build_id=' + category_id,
                        editurl: 'index.php?cmd=inventory_manager&action=buildlist&build_id=' + category_id,
                        autowidth: true,
                        datatype: "json",
                        colNames: [' ', 'ID', 'S/N', 'Category', 'Name',
                            'Manufacturer', 'Price', 'Retail Price',
                            'Location', 'Tested', 'Status'],
                        colModel: [
                            {name: 'myac', width: 10, sortable: false, search: false, resize: false},
                            {name: 'id', index: 'id', hidden: true, search: false},
                            {name: 'sn', index: 'sn', width: 80},
                            {name: 'category', index: 'category', width: 80},
                            {name: 'name', index: 'name', width: 80},
                            {name: 'manufacturer', index: 'manufacturer', width: 80},
                            {name: 'price', index: 'price', width: 80, formatter: 'currency', formatoptions: currencySettings},
                            {name: 'retail_price', index: 'retail_price', width: 80, formatter: 'currency', formatoptions: currencySettings},
                            {name: 'localisation', index: 'localisation', width: 90},
                            {name: 'tested', index: 'tested', align: 'center',
                                width: 40, formatter: function (cellvalue, options, rowObject) {
                                    return '<span ' + (cellvalue == 1 ? 'class="fa fa-lg fa-check-circle" title="Tested / Wroking"' : 'class="fa fa-lg fa-exclamation-circle" title="Not Tested / Broken"') + '></span>'
                                }},
                            {name: 'status', index: 'status', width: 80}
                        ],
                        rowNum: 50,
                        height: '100%',
                        rowList: [50, 100, 150],
                        pager: pager_id,
                        sortname: 'name',
                        viewrecords: true,
                        multiselect: true,
                        multiboxonly: true,
                        sortorder: "desc",
                        gridComplete: function () {
                            var ids = jQuery("#" + subgrid_table_id).jqGrid('getDataIDs');
                            for (var i = 0; i < ids.length; i++) {
                                var cl = ids[i];
                                be = "<div title='Edit selected row' style='float:left;cursor:pointer;' class='ui-pg-div ui-inline-edit'  onclick='showFacebox(\"?cmd=inventory_manager&action=entity&id=" + cl + "\")'><span class='ui-icon ui-icon-pencil'></span></div>";
                                jQuery("#" + subgrid_table_id).jqGrid('setRowData', ids[i], {myac: be});
                            }
                        }
                    };

                if (GridTemplates.builds.grid.url.indexOf('finished') !== -1) {
                    //remove tested column
                    gridspec.colModel.splice(9, 1);
                    gridspec.colNames.splice(9, 1)
                }

                $("#" + subgrid_id).html("<table id='" + subgrid_table_id + "' class='scroll' ></table><div id='" + pager_id + "' class='scroll'></div>").css('margin', 5);

                jQuery("#" + subgrid_table_id).jqGrid(gridspec);
                jQuery("#" + subgrid_table_id).jqGrid('navGrid', "#" + pager_id,
                    {edit: false, add: false}, //options editfunc:function(id){console.log(id)}
                    {}, // edit options
                    {height: 380, reloadAfterSubmit: true}, // add options
                    {reloadAfterSubmit: true, msg: "Are you sure you wish to remove \r\n this item from build?  \r\nIts status will change to 'In Stock'."}, // del options
                    {} // search options
                );
            }
        },
        nav: [
            {edit: false, del: true, search: true, add: false}, //options
            {}, // edit options
            {}, // add options
            {reloadAfterSubmit: true, msg: "Are you sure you wish to remove \r\n this  build? \r\n All contents will change status to 'In Stock'"}, // del options
            {} // search options
        ]
    }
}

GridTemplates['itemsearch'] = {
    grid: $.extend({}, GridTemplates.inventorylist.grid, {
        url: 'index.php?cmd=inventory_manager&action=inventorylist',
        editurl: 'index.php?cmd=inventory_manager&action=inventorylist',
        beforeRequest: function (a) {
            $(this).jqGrid('setGridParam', {
                 postData:
                     {
                         sn: $('#itemsearch').val(),
                         name: $('#itemsearchname').val(),
                         vendor: $('#itemsearchvendor').val(),
                         manufacturer: $('#itemsearchmanufacturer').val(),
                         status: $('#itemsearchstatus').val(),
                         localisation: $('#itemsearchlocation').val()
                    }
            });
        }
    }),
    nav: GridTemplates.inventorylist.nav
}


GridTemplates['guarantee'] = {
    grid: $.extend({}, GridTemplates.inventorylist.grid, {
        url: 'index.php?cmd=inventory_manager&action=guarantee',
        editurl: 'index.php?cmd=inventory_manager&action=guarantee',
    }),
    nav: GridTemplates.inventorylist.nav
}

GridTemplates['support'] = {
    grid: $.extend({}, GridTemplates.inventorylist.grid, {
        url: 'index.php?cmd=inventory_manager&action=support',
        editurl: 'index.php?cmd=inventory_manager&action=support',
    }),
    nav: GridTemplates.inventorylist.nav
}

GridTemplates['lowqty'] = {
    grid: $.extend({}, DefaultGRID, {
        url: "index.php?cmd=inventory_manager&action=lowqty",
        editurl: "index.php?cmd=inventory_manager&action=lowqty",
        datatype: "json",
        autowidth: true,
        colNames: ['', 'ID', 'Code', 'Name', 'Category', 'Description'],
        colModel: [
            {name: 'priority', index: 'priority', width: 5, editable: false, editoptions: {size: 1}},
            {name: 'id', index: 'id', width: 25, editable: false, editoptions: {readonly: true, size: 1}},
            {name: 'code', index: 'code', width: 80, editable: true, editoptions: {size: 10}},
            {name: 'name', index: 'name', width: 90, editable: true, editoptions: {size: 25}},
            {name: 'catname', index: 'catname', width: 90, editable: true, editoptions: {size: 25}},
            {name: 'description', index: 'description', width: 100, sortable: false, editable: true, edittype: "textarea", editoptions: {rows: "5", cols: "35"}}
        ],
        rowNum: 10,
        rowList: [10, 20, 50],
        sortname: 'sort',
        sortorder: "asc",
        loadonce: true,
        gridComplete: function () {
            var ids = $(this).jqGrid('getDataIDs');
            for (var i = 0; i < ids.length; i++) {
                var cl = ids[i],
                    data = $(this).jqGrid('getRowData', ids[i]),
                    priority = parseInt(data.priority),
                    color = priority == 1 ? '#D90404' : (priority == 2 ? '#E38700' : '#93927B'),
                    be = "<span class='fa fa-warning' style=\"color:" + color + "\"></span>";
                if (!isNaN(priority))
                    $(this).jqGrid('setRowData', ids[i], {priority: be});
            }
        }
    }),
    nav: [
        {search: false, del: false, add: false, edit: false}, //options
        {height: 280, reloadAfterSubmit: true, afterSubmit: parseSubmit, closeAfterEdit: true, closeOnEscape: true}, // edit options
        {}, // add options
        {}, // del options
        {} // search options
    ]
}