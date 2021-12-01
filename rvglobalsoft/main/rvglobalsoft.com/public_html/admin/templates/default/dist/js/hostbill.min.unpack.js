/*! hostbill 2020-03-31 */

function isEmpty(e) {
    for (var t in e)
        if (e.hasOwnProperty(t)) return !1;
    return !0
}

function ajax_update(e, t, n, i, s) {
    $("#taskMGR").taskQuickLoadShow(), "string" == typeof n && n && i && !s && $(n).html('<center><img src="ajax-loading.gif" /></center>'), void 0 != t && isEmpty(t) && (t = {
        empty1m: "param"
    }), $.post(e, t, function(e) {
        $("#taskMGR").taskQuickLoadHide();
        var t = parse_response(e);
        0 == t ? "string" == typeof n && n && !s && $(n).html("") : "function" == typeof n ? (this.resp = t, n.apply(this, arguments)) : n && !s && "string" == typeof t ? $(n).html(t) : n && s && $(n).append(t)
    })
}

function accordion() {
    $("#accordion  div.sor").hide(), $("#accordion  div.sor:first").show(), $("#accordion  li a:first").addClass("opened"), $("#accordion li a").click(function() {
        var e = $(this).next();
        return e.is("div") && e.is(":visible") ? ($("#accordion li a").removeClass("opened"), e.hide(), !1) : e.is("div") && !e.is(":visible") ? ($("#accordion li a").removeClass("opened"), e.show().prev().addClass("opened"), !1) : void 0
    })
}

function pops() {
    ajax_update("index.php", {
        stack: "pop"
    }, function() {
        initload = 1
    }), setTimeout(function() {
        0 == initload && $("#taskMGR").taskMgrProgress(1)
    }, 400)
}

function sorterUpdate(e, t, n, i) {
    if (void 0 !== e && $("#sorterlow").html(e), void 0 !== t && $("#sorterhigh").html(t), void 0 !== n && $("#sorterrecords").html(n), void 0 !== i && $("div.pagination").length) {
        var s = parseInt($(".pagination span.current").length && $(".pagination span.current").eq(0).html() || 1) - 1;
        $("div.pagination").html("").pagination(i, {
            current_page: s,
            initial_page: s
        })
    }
}

function parse_response(dta, options) {
    options = $.extend({
        info: function(e) {
            $("#taskMGR").taskMgrAddInfo(e)
        },
        error: function(e) {
            $("#taskMGR").taskMgrAddError(e)
        }
    }, options || {});
    var data = dta.trim();
    if (0 !== data.indexOf("\x3c!-- {")) return !1;
    var codes = eval("(" + data.substr(data.indexOf("\x3c!-- ") + 4, data.indexOf("--\x3e") - 4) + ")"),
        i = 0;
    for (i = 0; i < codes.ERROR.length; i++) options.error(codes.ERROR[i]);
    for (i = 0; i < codes.INFO.length; i++) options.info(codes.INFO[i]);
    if (codes.EVAL)
        for (i = 0; i < codes.EVAL.length; i++) eval(codes.EVAL[i]);
    codes.STACK > 0 && ($("#taskMGR").taskMgrProgress(100 - codes.STACK), setTimeout("pops()", 10)), 0 == codes.STACK && codes.INFO.length > 0 && $(".submiter").length > 0 && $("#currentlist").length > 0 && $(".pagination span.current").length > 0 && ajax_update($("#currentlist").attr("href") + "&page=" + (parseInt($(".pagination span.current").eq(0).html()) - 1), {
        once: "1"
    }, $("#currentlist").attr("updater"), !1);
    var retu = data.substr(data.indexOf("--\x3e") + 3, data.length);
    return "" == retu && (retu = !0), retu
}

function filter(e) {
    if ($("#currentlist").length > 0) {
        var t = $("#content_tb");
        return t.length && t.addClass("searchon"), $("#updater").addLoader(), ajax_update($("#currentlist").attr("href") + "&" + $(e).serialize(), {
            page: parseInt($(".pagination span.current").eq(0).html()) - 1
        }, "#updater"), $(".filter-actions z, .freseter").css({
            display: "inline"
        }), !1
    }
    return !0
}

function appendLoader(e) {
    loadelements.loaders[loadelements.loaders.length] = e
}

function bindClientEvents() {
    var e = $("#client_id", "#bodycont").val();
    $(".clDropdown", "#bodycont").click(function() {
        return !1
    }), $("body").bootboxform(), $("#clientform").submit(function() {
        return $("#old_currency_id").val() == $("#currency_id").val() || ($("#confirm_curr_change").trigger("show"), !1)
    }), $("#sendmail").click(function() {
        if ("custom" != $("#mail_id").val()) return $.post("?cmd=clients&action=sendmail", {
            mail_id: $("#mail_id").val(),
            id: e
        }, parse_response), !1;
        window.location.href = "?cmd=sendmessage&type=clients&selected=" + $("#client_id").val()
    }), $("#sendsms").click(function() {
        if ("custom" != $("#sms_id").val()) return $.post("?cmd=clients&action=sendsms", {
            sms_id: $("#sms_id").val(),
            id: e
        }, parse_response), !1;
        window.location.href = "?cmd=sendmessage&type=clients&sms=true&selected=" + $("#client_id").val()
    }), $("#tdetail a", "#bodycont").click(function() {
        return $(".secondtd", "#bodycont").toggle(), $(".tdetails", "#bodycont").toggle(), $(".a1", "#tdetail").toggle(), $(".a2", "#tdetail").toggle(), !1
    }), $(".livemode", "#bodycont").hover(function() {
        $(this).append('<a href="#" onclick="return false;" class="manuedit">' + lang.edit + "</a>")
    }, function() {
        $(this).find(".manuedit").remove()
    }).click(function() {
        $("#tdetail a").click()
    }), $(".label-livemode", "#bodycont").click(function() {
        $("#tdetail a").click()
    }), $(".clDropdown", "#bodycont").dropdownMenu({}, function(t, n, i) {
        "OpenTicket" == (t = t.substr(t.lastIndexOf("/") + 1)) ? window.location.href = "?cmd=tickets&action=new&client_id=" + e: "CreateInvoice" == t ? window.location.href = "?cmd=invoices&action=createinvoice&client_id=" + e : "PlaceOrder" == t ? window.location.href = "?cmd=orders&action=add&related_client_id=" + e : "SendNewPass" == t ? ajax_update("?cmd=clients&action=show&make=resetpass&id=" + e, !1) : "CloseAccount" == t ? $("#confirm_cacc_close").trigger("show") : "AnonymizeAccount" == t ? $("#confirm_cacc_anonymize").trigger("show") : "ArchiveAccount" == t ? $("#confirm_cacc_archive").trigger("show") : "DetailsRequest" == t ? $("#gdpr_request").trigger("show") : "DeleteAccount" == t ? $("#confirm_cacc_delete").trigger("show") : "EditNotes" == t ? AdminNotes.show() : "EnableAffiliate" == t ? window.location.href = "?cmd=affiliates&action=activate&client_id=" + e : "DeleteContact" == t ? confirm(lang.deleteprofileheading) && (window.location.href = "?cmd=clients&make=deleteprofile&client_id=" + e + "&parent_id=" + $("#parent_id").val()) : "ConvertToClient" == t && confirm(lang.convertclientheading) && (window.location.href = "?cmd=clients&action=convertcontact&client_id=" + e)
    }), setTimeout(function() {
        $("#client_id").length > 0 && $("#client_stats").length > 0 && ajax_update("?cmd=clients&action=loadstatistics&id=" + $("#client_id", "#bodycont").val(), {}, "#client_stats")
    }, 30)
}

function bindServicesEvents() {
    $(".addcustom").click(function() {
        return $("#customfield").toggle(), !1
    }), $(".iseditable", "#bodycont").click(function() {
        var e = $(this).parents(".editor-container").eq(0);
        return e.find(".editor").show(), e.find(".org-content").hide(), $(this).parents("tbody.sectioncontent").find(".sectionhead .savesection").show(), !1
    })
}

function tload2() {
    var e = window;
    return e.location.hash && "#" != e.location.hash && (e.clearInterval(checkUrlInval), e.location.hash = ""), ajax_update($(this).attr("href"), {}, "#bodycont"), $(this).attr("rel") && (e.location.hash = $(this).attr("rel").replace(/\s/g, ""), checkUrlInval = setInterval(function() {
        e.location.hash && "#" != e.location.hash || (e.clearInterval(checkUrlInval), $("#backto").length > 0 && ajax_update($("#backto").attr("href"), {}, "#bodycont"), e.location.hash = "")
    }, 200)), !1
}

function bindPredefinied() {
    $("a.file").unbind("click"), setTimeout(function() {
        $(".treeview").undelegate("a.folder, .hitarea", "click").delegate("a.folder, .hitarea", "click", function() {
            var e = $(this).parent(),
                t = !1;
            if ((e.hasClass("expandable") || e.hasClass("collapsable")) && (e.toggleClass("expandable").toggleClass("collapsable"), e.children("div.hitarea").toggleClass("collapsable-hitarea").toggleClass("expandable-hitarea"), (e.hasClass("lastExpandable") || e.hasClass("lastCollapsable")) && (t = !0, e.toggleClass("lastExpandable").toggleClass("lastCollapsable"), e.children("div.hitarea").toggleClass("lastExpandable-hitarea").toggleClass("lastCollapsable-hitarea"))), e.hasClass("collapsable")) {
                if ($(this).hasClass("hitarea")) var n = $(this).siblings("a").attr("href");
                else n = $(this).attr("href");
                ajax_update(n, {}, function(n) {
                    var i = parse_response(n);
                    $("#" + e.attr("id")).html(i), t && e.children("div.hitarea").addClass("lastCollapsable-hitarea")
                })
            } else e.find("ul").remove();
            return !1
        })
    }, 50)
}

function bindFreseter() {
    $(".haspicker").datePicker({
        startDate: startDate
    }), $("a.freseter", "#content_tb").unbind("click"), $("a.freseter", "#content_tb").click(function() {
        $("a.freseter").hide(), $("form.filterform").each(function() {
            this.reset()
        });
        var e = $("#content_tb");
        return e.length && e.removeClass("searchon"), !$("#currentlist").length || (ajax_update($("#currentlist").attr("href"), {
            page: parseInt($(".pagination span.current").eq(0).html()) - 1,
            resetfilter: "1"
        }, "#updater"), !1)
    })
}

function lateInvoiceBind() {}

function invoiceItemsSubmit() {
    var e = $(this).parent().parent(),
        t = $("#invoice_id").val();
    if ($(e).attr("id")) {
        var n = $(e).attr("id").replace("line_", ""),
            i = parseFloat($(e).find(".invqty").eq(0).val()) * parseFloat(e.find(".invamount").eq(0).val());
        e.find("#ltotal_" + n).html((Math.round(100 * i) / 100).toFixed(2))
    }
    $.post("?cmd=invoices&action=updatetotals&" + $("#itemsform").serialize(), {
        id: t
    }, function(e) {
        var n = parse_response(e);
        n && ($("#updatetotals").html(n), ajax_update("?cmd=invoices&action=getdetailsmenu", {
            id: t
        }, "#detcont"))
    })
}

function bindInvoiceDetForm() {
    lateInvoiceBind();
    var e = $("#invoice_id").val();
    $(".haspicker").datePicker({
        startDate: startDate
    }), $("#standardinvoice").length && ($("#standardinvoice").is(":checked") ? ($(".standardinvoice").show(), $(".recurringinvoice").hide(), $("#is_recurring").val(0)) : ($(".recurringinvoice").show(), $(".standardinvoice").hide(), $("#is_recurring").val(1))), $(".removeTrans").unbind("click"), $(".removeTrans").click(function() {
        var e = $(this);
        return confirm("Do you really want to delete this transaction?") && $.post($(this).attr("href"), {
            empty1mc: "param"
        }, function(t) {
            1 == parse_response(t) && (e.parent().parent().slideUp("fast", function() {
                $(this).remove()
            }), $(".invitem").eq(0).change())
        }), !1
    }), $("#updateclietndetails").unbind("click").click(function() {
        $("a", ".tdetail").eq(0).click(), ajax_update("?cmd=invoices&action=changething&make=updateclientdetails&id=" + e), ajax_update("?cmd=invoices&action=edit&list=all&id=" + e, {}, "#bodycont")
    })
}

function bindDomainEvents() {
    $("body").bootboxform(), $(".toLoad").click(function() {
        return $("#dommanager").show(), $("#man_content").html('<center><img src="ajax-loading.gif" /></center>'), $("#man_title").html($(this).attr("value")), $.post("?cmd=domains&action=" + $(this).attr("name"), {
            val: $(this).attr("value"),
            id: $("#domain_id").val(),
            name: $("#domain_name").val()
        }, function(e) {
            $("#man_content").scrollToEl("#man_content");
            var t = parse_response(e);
            t && "" != t ? $("#man_content").html(t) : $("#man_content").html(" ")
        }), !1
    }), $(".livemode").not("tr").hover(function() {
        $(this).append('<a href="#" onclick="return false;" class="manuedit">' + lang.edit + "</a>")
    }, function() {
        $(this).find(".manuedit").remove()
    }).not("tr").click(function() {
        $(".changeMode").eq(0).is(":checked") ? $(".changeMode").removeAttr("checked").eq(0).trigger("change") : $(".changeMode").attr("checked", "checked").eq(0).trigger("change")
    }), $("#bodycont .changeMode").change(function() {
        var e = 0;
        $(this).is(":checked") ? (e = 1, $.post("?cmd=domains&action=manualmode", {
            mode: e,
            id: $("#domain_id").val()
        }, function(e) {
            parse_response(e) && ($(".changeMode").attr("checked", "checked"), $(".manumode").show(), $(".livemode").hide(), $("#domainname").removeAttr("readonly"), $("#epp_code").show())
        })) : $.post("?cmd=domains&action=manualmode", {
            mode: e,
            id: $("#domain_id").val()
        }, function(e) {
            parse_response(e) && ($(".changeMode").removeAttr("checked"), $(".livemode").show(), $(".manumode").hide(), $(".pen").hide(), $(".nep").show(), $("#domainname").attr("readonly", "readonly"), $("#epp_code").hide())
        })
    }), $(".setStatus", "#bodycont").click(function() {
        return !1
    }), $("#ChangeOwner").bootboxform().on("bootbox-form.shown", function(e, t) {
        $("select", t).chosensearch()
    }), $(".setStatus", "#bodycont").dropdownMenu({}, function(e, t, n) {
        "AdminNotes" == (e = e.substr(e.lastIndexOf("/") + 1)) ? AdminNotes.show(): "ChangeOwner" == e ? $("#ChangeOwner").trigger("show") : "RequestCancellation" == e && $("#RequestCancellation").trigger("show")
    }), $("#sendmail").click(function() {
        if ("custom" != $("#mail_id").val()) return $.post("?cmd=domains&action=sendmail", {
            mail_id: $("#mail_id").val(),
            id: $("#domain_id").val()
        }, function(e) {
            parse_response(e)
        }), !1;
        window.location.href = "?cmd=sendmessage&type=domains&selected=" + $("#domain_id").val()
    })
}

function bindAccountEvents() {
    $("body").bootboxform(), $(".toLoad").click(function() {
        return $("#dommanager").show(), $("#man_content").html('<center><img src="ajax-loading.gif" /></center>'), $("#man_title").html($(this).attr("value")), $.post("?cmd=accounts&action=" + $(this).attr("name"), {
            val: $(this).attr("value"),
            id: $("#account_id").val()
        }, function(e) {
            var t = parse_response(e);
            t && "" != t ? $("#man_content").html(t) : $("#man_content").html(" ")
        }), !1
    }), $(".livemode").not("tr").not("input[type=submit]").hover(function() {
        $(this).append('<a href="#" onclick="return false;" class="manuedit">' + lang.edit + "</a>")
    }, function() {
        $(this).find(".manuedit").remove()
    }).click(function() {
        $(".changeMode").eq(0).is(":checked") ? $("#changeMode").removeAttr("checked").eq(0).trigger("change") : $("#changeMode").attr("checked", "checked").eq(0).trigger("change")
    }), $("#changeMode").change(function() {
        var e = 0;
        $(this).is(":checked") ? (e = 1, $.post("?cmd=accounts&action=manualmode", {
            mode: e,
            id: $("#account_id").val()
        }, function(e) {
            parse_response(e) && ($("#changeMode").attr("checked", "checked"), $(".h_manumode").removeAttr("disabled"), $("#passchange").show(), $(".manumode").show(), $(".livemode").hide())
        })) : $.post("?cmd=accounts&action=manualmode", {
            mode: e,
            id: $("#account_id").val()
        }, function(e) {
            parse_response(e) && ($("#changeMode").removeAttr("checked"), $(".h_manumode").attr("disabled", "disabled"), $(".livemode").show(), $(".manumode").hide(), void 0 != $("#product_id option[def]") && ($(':input[id="product_id"]')[0].selectedIndex = $("#product_id option[def]")[0].index), void 0 != $("#server_id option[def]") && ($(':input[id="server_id"]')[0].selectedIndex = $("#server_id option[def]")[0].index))
        })
    }), $("#product_id").change(function() {
        return $.post("?cmd=accounts&action=getservers", {
            server_id: $("#server_id").val(),
            product_id: $(this).val(),
            manumode: $("#server_id").hasClass("manumode") ? "1" : "0",
            show: $(".changeMode").eq(0).is(":checked") ? "1" : "0"
        }, function(e) {
            var t = parse_response(e);
            t && $("#serversload").html(t)
        }), !1
    }), $("#sendmail").click(function() {
        if ("custom" != $("#mail_id").val()) return $.post("?cmd=accounts&action=sendmail", {
            mail_id: $("#mail_id").val(),
            id: $("#account_id").val()
        }, function(e) {
            parse_response(e)
        }), !1;
        window.location.href = "?cmd=sendmessage&type=accounts&selected=" + $("#account_id").val()
    }), $(".setStatus").click(function() {
        return !1
    }), $(".setStatus").dropdownMenu({}, function(e, t, n) {
        if ("AdminNotes" == (e = e.substr(e.lastIndexOf("/") + 1))) AdminNotes.show();
        else if ("OverrideSuspension" == e) $("#OverrideSuspension").trigger("show");
        else if ("SetCommitmentPeriod" == e) $("#SetCommitmentPeriod").trigger("show");
        else if ("ChangeOwner" == e) $("#ChangeOwner").trigger("show");
        else if ("RequestCancellation" == e) $("#RequestCancellation").trigger("show");
        else if ("Delete" == e) {
            if ($("#testform input[class=check]:checked").length < 1) return alert("Nothing checked"), !1;
            confirm1()
        }
    }), $("#account_id").length > 0 && ajax_update("?cmd=accounts&action=getacctaddons", {
        id: $("#account_id").val()
    }, "#loadaddons")
}

function bindInvoiceEvents() {
    var e = window;
    "" != e.location.hash && e.location.hash && "#" == e.location.hash.substr(0, 1) && $("#invoice_id").length < 1 && "#" != e.location.hash && ajax_update("?cmd=invoices&action=edit&list=all&id=" + window.location.hash.substr(1), {}, "#bodycont");
    var t = $("#invoice_id").val();
    $("a.tload2").click(tload2), setTimeout("lateInvoiceBind()", 30), setTimeout("bindInvoiceDetForm()", 30), $(".setStatus").unbind("click").click(function() {
        return !1
    }).dropdownMenu({}, function(n, i, s, r) {
        if ("Paid" == (n = n.substr(n.lastIndexOf("/") + 1)) || "Unpaid" == n || "Cancelled" == n || "Refunded" == n || "Credited" == n || "Collections" == n) ConfirmInvoiceEdit(function() {
            $.post("?cmd=invoices&action=changething&make=setstatus", {
                status: n,
                id: t
            }, function(e) {
                var t = parse_response(e);
                0 != t && null != t && ($("#invoice_status").data("status", n).html(r).attr({
                    class: n
                }), $(".addPayment").removeClass("disabled"), $("#hd1_m li").removeClass("disabled"), $("#hd2_m li").removeClass("disabled"), toggleStatusActions())
            })
        });
        else if ("SplitItems" == n) {
            if ($(".invitem_checker").length < 2 || $(".invitem_checker:checked").length < 1) return;
            var o = $(".invitem_checker:checked").serialize();
            $.getJSON("?cmd=invoices&action=split&" + o, {
                id: t
            }, function(e) {
                e.id && ($("#taskMGR").taskMgrAddInfo("Invoice split success"), ajax_update("?cmd=invoices&action=edit&list=all&id=" + e.id, {}, "#bodycont"), window.location.hash = "#" + e.id)
            })
        } else if ("AddNote" == n) $("#inv_notes").focus();
        else if ("SendReminder2" == n) {
            if ($("#testform input[class=check]:checked").length < 1) return alert("Nothing checked"), !1;
            ajax_update("?cmd=invoices&action=bulkreminder&" + $("#testform").serialize(), {
                stack: "push"
            })
        } else if ("AddPrintQueue" == n || "RemovePrintQueue" == n || "MarkAsPrinted" == n || "MarkAsNotPrinted" == n) $.post("?cmd=invoices&action=changething&make=printqueue", {
            id: t,
            type: n
        }, function(e) {
            var t = parse_response(e);
            0 != t && null != t && ($(".invoice_flag, .print-status").hide(), "AddPrintQueue" == n ? $(".flag2, .flag3, .print-status-notprinted").show() : "RemovePrintQueue" == n ? $(".flag1, .flag3").show() : "MarkAsPrinted" == n ? $(".flag4, .print-status-printed").show() : "MarkAsNotPrinted" == n && $(".flag2, .flag3, .print-status-notprinted").show())
        });
        else if ("MarkCancelled" == n) $(".markcancelled").eq(0).click();
        else if ("downloadPDF" == n) e.location.href = "?action=download&invoice=" + t;
        else if ("EditNumber" == n) {
            var a = $("#invoice_number"),
                l = a.text();
            bootbox.prompt({
                title: "Edit invoice number",
                inputType: "text",
                value: l,
                callback: function(e) {
                    if (null === e || l == e) return !0;
                    ConfirmInvoiceEdit(function() {
                        $.post("?cmd=invoices&action=changething&make=changenumber", {
                            id: t,
                            number: e
                        }, function(e) {
                            parse_response(e)
                        }), a.text(e)
                    })
                }
            }), $("#paid_invoice_line .editbtn").click()
        } else "GenerateFinalId" == n ? e.location.href = "?cmd=invoices&action=menubutton&id=" + t + "&make=finalid&security_token=" + $("input[name=security_token]").val() : "LockInvoice" == n || "UnlockInvoice" == n ? e.location.href = "?cmd=invoices&action=menubutton&id=" + t + "&make=" + ("UnlockInvoice" == n ? "unlock" : "lock") + "&security_token=" + $("input[name=security_token]").val() : "EditDetails" == n ? $(".tdetail a").click() : "SendInvoice" == n ? $.post("?cmd=invoices&action=changething&make=sendinvoice", {
            id: t
        }, function(e) {
            parse_response(e)
        }) : "IssueRefund" == n ? $("#refunds").load("?cmd=invoices&action=refundsmenu&invoice_id=" + t, function(e) {
            $("#refunds").show()
        }) : "IssueCreditNote" == n ? $("#refunds").load("?cmd=invoices&action=creditnotesmenu&invoice_id=" + t, function(e) {
            $("#refunds").show()
        }) : "ChangeCurrency" == n ? $("#change-currency").trigger("show") : "MergeInvoices" == n ? $.ajax({
            type: "POST",
            url: "?cmd=invoices&action=merge&invoice_id=" + t,
            success: function(e) {
                bootbox.dialog({
                    message: e,
                    title: "Merge client invoices",
                    backdrop: !0,
                    buttons: {
                        close: {
                            label: "Close",
                            className: "btn-default"
                        },
                        success: {
                            label: "Submit",
                            className: "btn-success",
                            callback: function() {
                                var e = $('select[name="mergeselected[]"]').serialize();
                                return $.ajax({
                                    type: "POST",
                                    url: "?cmd=invoices&action=merge&invoice_id=" + t,
                                    data: e,
                                    success: function(e) {
                                        location.reload()
                                    }
                                }), !1
                            }
                        }
                    }
                })
            }
        }) : "CreateBulkPayment" == n ? $.ajax({
            type: "POST",
            url: "?cmd=invoices&action=bulk_payment&invoice_id=" + t,
            success: function(n) {
                bootbox.dialog({
                    message: n,
                    title: "Create bulk payment invoice",
                    backdrop: !0,
                    buttons: {
                        close: {
                            label: "Close",
                            className: "btn-default"
                        },
                        success: {
                            label: "Submit",
                            className: "btn-success",
                            callback: function() {
                                var n = $('select[name="bulkselected[]"]').serialize();
                                return $.ajax({
                                    type: "POST",
                                    url: "?cmd=invoices&action=bulk_payment&invoice_id=" + t,
                                    data: n,
                                    success: function(t) {
                                        var n = $("'" + t + "'"),
                                            i = $(n).filter("#bpinvoice_id").val();
                                        $.isNumeric(i) ? e.location.href = "?cmd=invoices&action=edit&id=" + i : location.reload()
                                    }
                                }), !1
                            }
                        }
                    }
                })
            }
        }) : "CreateInvoice" == n ? e.location.href = "?cmd=invoices&action=createinvoice&client_id=" + $("#client_id").val() : "SendReminder" == n ? $.post("?cmd=invoices&action=changething&make=sendreminder", {
            id: t
        }, function(e) {
            parse_response(e)
        }) : "SendOverdue" == n ? $.post("?cmd=invoices&action=changething&make=sendoverduenotice", {
            id: t
        }, function(e) {
            parse_response(e)
        }) : "SendMessage" == n && (e.location.href = "?cmd=sendmessage&type=invoices&selected=" + t)
    }), toggleStatusActions(), $(".recstatus").click(function() {
        if ($(this).hasClass("activated")) return !1;
        var e = "Active";
        return $(this).hasClass("recoff") && (e = "Stopped"), $(".recstatus").removeClass("activated"), $(this).addClass("activated"), $.post("?cmd=invoices&action=changething&make=changerecstatus", {
            id: t,
            recstatus: e
        }, function(e) {
            parse_response(e)
        }), !1
    }), $(".sendInvoice").click(function() {
        return $.post("?cmd=invoices&action=changething&make=sendinvoice", {
            id: t
        }, function(e) {
            parse_response(e)
        }), !1
    }), $(".deleteInvoice").click(function() {
        return confirm("Do you really want to delete this invoice?") && ($(this).attr("href") ? $.post($(this).attr("href"), {
            empty1mc: "param"
        }, function(e) {
            parse_response(e);
            $("#currentpage").eq(0).change()
        }) : $.post("?cmd=invoices&action=menubutton&make=deleteinvoice", {
            id: t
        }, function(t) {
            1 == parse_response(t) && (e.location.href = "?cmd=clients&action=show&id=" + $("#client_id").val() + "&picked_tab=invoices")
        })), !1
    }), $(".invoiceUnlock").click(function() {
        var e = this;
        return $.post($(this).attr("href"), {
            empty1mc: "param"
        }, function(t) {
            parse_response(t);
            $("a[href=UnlockInvoice]").attr("href", "LockInvoice").text("Lock invoice"), $(e).hide()
        }), !1
    })
}

function bindNewOrderEvents() {
    $(".inv_gen_check").click(function() {
        $(this).is(":checked") ? $("#invsend").removeAttr("disabled") : $("#invsend").removeAttr("checked").attr("disabled", "disabled")
    }), $(".get_prod_btn").change(function() {
        var e = $("#product_id");
        if ("new" == $(e).val()) window.location = "?cmd=services&action=addproduct", $(e).val($("select[name='" + $(e).attr("name") + "'] option:first").val());
        else {
            var t = "";
            if ($("#client_id").length > 0) {
                if ("new" == $("#client_id").val()) return void(window.location = "?cmd=newclient");
                t = "&client_id=" + $("#client_id").val()
            }
            $("#prod_loader").show(), ajax_update("?cmd=orders&action=get_product" + t, {
                product_id: $("#product_id").val()
            }, "#product_details")
        }
    }), $(".new_gat_btn").change(function() {
        "new" == $(this).val() && (window.location = "?cmd=managemodules&action=payment", $(this).val($("select[name='" + $(this).attr("name") + "'] option:first").val()))
    }), $(".setStatus").dropdownMenu({}, function(e, t, n, i) {
        switch (e = e.substr(e.lastIndexOf("/") + 1)) {
            case "add_discount":
                alert("discount"), $(".dis_menu_el").addClass("hidden").hide(), $(".aff_menu_el").hasClass("hidden") && $(".setStatus").hide();
                break;
            case "assign_aff":
                alert("affiliate"), $(".aff_menu_el").addClass("hidden").hide(), $(".dis_menu_el").hasClass("hidden") && $(".setStatus").hide()
        }
    }), $("#extend_notes").click(function() {
        $(this).hide(), $('textarea[name="order_notes"]').show()
    }), $("#add_dom_btn").click(function() {
        alert("add another domain")
    }), bindCheckAvailOrd()
}

function bindCheckAvailOrd() {
    $(".check_avail").click(function() {
        var e = $('meta[name="csrf-token"]').attr("content");
        $(".avail_result").html('<img src="ajax-loading2.gif" />'), ajax_update("?cmd=orders&action=whois", {
            security_token: e,
            domain: $("#domain_sld").val() + $("#domain_tld").val(),
            type: $("input[name='domain_action']:checked").val()
        }, ".avail_result")
    })
}

function lateEstimatesBind() {}

function estimatesItemsSubmit() {
    var e = $(this).parent().parent(),
        t = $(e).attr("id").replace("line_", ""),
        n = $("#estimate_id").val();
    e.find("#ltotal_" + t).html((parseFloat($(e).find(".invqty").eq(0).val()) * parseFloat(e.find(".invamount").eq(0).val())).toFixed(2)), $.post("?cmd=estimates&action=updatetotals&" + $("#itemsform").serialize(), {
        id: n
    }, function(e) {
        var t = parse_response(e);
        t && ($("#updatetotals").html(t), ajax_update("?cmd=estimates&action=getdetailsmenu", {
            id: n
        }, "#detcont"))
    })
}

function bindEstimatesDetForm() {
    function e() {
        $("#products").hide(), $("#products").html(""), $("#rmliner").show(), $("#addliners").show(), $("#catoptions_container").hide(), $("#addliners2").hide(), $("#catoptions option").each(function() {
            $(this).removeAttr("selected")
        }), $("#catoptions option").eq(1).attr("selected", "selected")
    }
    lateEstimatesBind();
    var t = $("#estimate_id").val();
    $(".haspicker").datePicker({
        startDate: startDate
    }), $("#catoptions").unbind("change").change(function() {
        "-1" == $(this).val() ? (ajax_update("?cmd=estimates&action=getblank", {}, "#products"), $("#products").show(), $("#rmliner").hide()) : "-2" == $(this).val() ? (ajax_update("?cmd=estimates&action=getaddon", {
            currency_id: $("#currency_id").val()
        }, "#products"), $("#products").show(), $("#rmliner").hide()) : $(this).val() > "0" && (ajax_update("?cmd=estimates&action=getproduct", {
            cat_id: $(this).val(),
            currency_id: $("#currency_id").val()
        }, "#products"), $("#products").show(), $("#rmliner").hide())
    }), $("#prodcanc").unbind("click"), $(".prodok").unbind("click").click(function() {
        if ($("#nline").length > 0 && "" != $("#nline").val()) {
            var e = 0;
            $("#nline_tax").is(":checked") && (e = 1), $("#main-invoice").addLoader(), $.post("?cmd=estimates&action=addline", {
                line: $("#nline").val(),
                tax: e,
                price: $("#nline_price").val(),
                qty: $("#nline_qty").val(),
                id: t
            }, function(e) {
                var t = parse_response(e);
                t && ($("#addliners").before(t), $("#nline").val(""), $("#nline_price").val(""), $("#nline_tax").removeAttr("checked"), $("#detailsform").eq(0).submit())
            })
        } else $("#product_id").length > 0 ? $.post("?cmd=estimates&action=addline", {
            product: $("#product_id").val(),
            id: t
        }, function(e) {
            var t = parse_response(e);
            t && ($("#addliners").before(t), $("#detailsform").eq(0).submit())
        }) : $("#addon_id").length > 0 && ($("#main-invoice").addLoader(), $.post("?cmd=estimates&action=addline", {
            addon: $("#addon_id").val(),
            id: t
        }, function(e) {
            var t = parse_response(e);
            t && ($("#addliners").before(t), $("#detailsform").eq(0).submit())
        }));
        $("#prodcanc").click()
    }), $("#prodcanc").click(function() {
        e()
    }), $("#rmliner").click(function() {
        e()
    })
}

function bindEstimatesEvents() {
    var e = $("#estimate_id").val();
    $("#estsubject").focus(function() {
        $(this).addClass("sub_hover")
    }).blur(function() {
        $(this).removeClass("sub_hover")
    }).change(function() {
        var t = $(this).val();
        $.post("?cmd=estimates&action=changething&make=addsubject", {
            id: e,
            subject: t
        }, function(e) {
            parse_response(e)
        })
    }), $("#changeowner").click(function() {
        return $("#curr_det").hide(), $("#client_container").show(), ajax_update("?cmd=estimates&action=changeowner&client_id=" + $("#client_id").val() + "&estimate_id=" + e, !1, "#client_container"), !1
    }), $("#new_estimate_button").click(function() {
        $("#new_estimate").hasClass("shown") ? $("#new_estimate").hide().removeClass("shown") : $("#new_estimate").hasClass("content_loaded") ? $("#new_estimate").show().addClass("shown") : ($("#new_estimate").show().addClass("shown"), ajax_update("?cmd=estimates&action=getclients", {}, "#new_estimate", !0), $("#new_estimate").addClass("content_loaded"))
    }), $("#est_notes").bind("textchange", function() {
        $(this).addClass("notes_changed"), $("#notes_submit").show()
    }), $("#est_admin_notes").bind("textchange", function() {
        $(this).addClass("notes_changed"), $("#admin_notes_submit").show()
    }), $("#notes_submit input").click(function() {
        var t = $("#est_notes").val();
        return $(this).parent().hide(), $("#est_notes").removeClass("notes_changed"), $.post("?cmd=estimates&action=changething&make=addnotes", {
            id: e,
            notes: t
        }, function(e) {
            parse_response(e)
        }), !1
    }), $("#admin_notes_submit input").click(function() {
        var t = $("#est_admin_notes").val();
        return $(this).parent().hide(), $("#est_admin_notes").removeClass("notes_changed"), $.post("?cmd=estimates&action=changething&make=addprivatenotes", {
            id: e,
            notes_private: t
        }, function(e) {
            parse_response(e)
        }), !1
    }), $(".sendEstimate").click(function() {
        $.post("?cmd=estimates&action=changething&make=sendestimate", {
            id: e
        }, function(e) {
            parse_response(e), $("#hd1_m li").removeClass("disabled"), $("li.act_sent").addClass("disabled"), $("#estimate_status").html($("li.act_sent a").html()), $("#estimate_status").attr({
                class: "Sent"
            })
        })
    }), $(".setStatus").dropdownMenu({}, function(t, n, i, s) {
        "Draft" == (t = t.substr(t.lastIndexOf("/") + 1)) || "Sent" == t || "Accepted" == t || "Invoiced" == t || "Dead" == t ? $.post("?cmd=estimates&action=changething&make=setstatus", {
            status: t,
            id: e
        }, function(e) {
            var n = parse_response(e);
            0 != n && null != n && ("Invoiced" == t ? ($("button.invoiced_").attr("disabled", "disabled"), $(".invoiced_").addClass("disabled")) : ($("button.invoiced_").removeAttr("disabled"), $(".invoiced_").removeClass("disabled")), $("#estimate_status").html(s), $("#estimate_status").attr({
                class: t
            }), $("#hd1_m li").removeClass("disabled"), $("li.act_" + t.toLowerCase()).addClass("disabled"), "Dead" == t || "Draft" == t ? $("#clientlink").hide() : $("#clientlink").ShowNicely(), toggleStatusActions())
        }) : "EditDetails" == t ? $(".tdetail a").click() : "CreateInvoice" == t ? $.post("?cmd=estimates&action=createinvoice", {
            id: e
        }, function(e) {
            parse_response(e)
        }) : "downloadPDF" == t ? window.location.href = "?action=download&estimate=" + e : "ChangeCurrency" == t ? $("#change-currency").trigger("show") : "CreateInvoice" == t && (window.location.href = "?cmd=estimates&action=edit&make=createinvoice&id=" + e)
    }), toggleStatusActions(), $("#addliner").click(function() {
        return $("#addliners2").show(), $("#catoptions_container").show(), $("#addliners").hide(), !1
    }), $(".deleteEstimate").click(function() {
        return confirm("Do you really want to delete this estimate?") && ($(this).attr("href") ? $.post($(this).attr("href"), {
            empty1mc: "param"
        }, function(e) {
            parse_response(e);
            $("#currentpage").eq(0).change()
        }) : $.post("?cmd=estimates&action=menubutton&make=deleteestimate", {
            id: e
        }, function(e) {
            1 == parse_response(e) && (window.location.href = "?cmd=clients&action=show&id=" + $("#client_id").val() + "&picked_tab=estimates")
        })), !1
    }), bindEstimatesDetForm()
}

function bindTicketEvents() {
    function e() {
        return $(".ticketnotesremove").length < 2 && ($("#ticketnotebox").slideUp(), $(".badd").show()), $(this).parents("tr").eq(0).hide(), ajax_update("?cmd=tickets", {
            make: "removenote",
            action: "menubutton",
            id: t,
            noteid: this.hash.slice(1)
        }, function(t) {
            $("#ticketnotes").html(t), $(".ticketnotesremove").bind("click", e)
        }), !1
    }
    var t = $("#ticket_number").val(),
        n = window,
        i = document,
        s = $("#backredirect").val();
    ticket.initPoll(), ticket.zenMode(), $("#ticketsubmitter").click(function() {
        ticket.autopoll = !1
    }), $("#showlatestreply").click(function() {
        var e = "";
        return $(this).attr("rel") ? (e = $(this).attr("rel"), $(this).removeAttr("rel")) : e = $("#recentreplies input.viewtime:last").val(), ajax_update("?cmd=tickets", {
            action: "menubutton",
            make: "getrecent",
            viewtime: e,
            id: $("#ticket_number").val()
        }, "#recentreplies", !1, !0), $("#justadded").hide(), !1
    }), "" != n.location.hash && n.location.hash && "#" == n.location.hash.substr(0, 1) && $("#ticket_id").length < 1 && "#" != n.location.hash && ajax_update("?cmd=tickets&action=view&list=all&num=" + window.location.hash.substr(1), {
        brc: s
    }, "#bodycont"), $(".scroller").click(function() {
        var e = $("[name=" + $(this).attr("href").substr(1) + "]");
        if (e.length) {
            var t = e.offset().top;
            return $("html,body").animate({
                scrollTop: t - 100
            }, 500, "swing", function() {
                $("#replyarea").focus()
            }), !1
        }
    }), $("#replyarea").keydown(function() {
        $("#draftinfo .controls").is(":visible") || "" == $("#replyarea").val() || ($("#draftinfo .controls").show(), $("#draftinfo .draftdate").show())
    }), $("#ticketnotessave").click(function() {
        var n = $("input,textarea", ".admin-note-new").serializeObject();
        return n.make = "savenotes", n.action = "menubutton", n.id = t, ajax_update("?cmd=tickets", n, function(t) {
            $("#ticketnotes").html(t), $(".ticketnotesremove").bind("click", e)
        }), $("#ticketnotesarea").val(""), !1
    }), $("#ticketnotesfile").click(function() {
        var e = {},
            t = $('<div class="result"><input type="file" data-upload="?cmd=downloads&action=upload" /></div>').appendTo(".admin-note-new .admin-note-attach").bind("fileuploadsend", function(n, i) {
                t.children().hide();
                for (var s in i.files) e[s] = $('<div class="upload-result"><a class="attachment" >' + i.files[s].name + '</a> <span class="ui-autocomplete-loading" style="padding: 10px;"></span></div>').appendTo(t)
            }).bind("fileuploadalways", function(n, i) {
                t.children("input").remove();
                for (var s in i.result)
                    if (e[s]) {
                        var r = e[s];
                        r.children("span").remove(), i.result[s].error ? r.append("<span>" + i.result[s].error + "</span>") : (r.append('<input name="attachments[]" value="' + i.result[s].hash + '" type="hidden"/>'), $('<a href="#" class="editbtn"></a>').append("<small>&#91;Remove&#93;</small>").appendTo(r).click(function() {
                            return $.post(i.result[s].delete_url), r.remove(), !1
                        }))
                    }
            });
        return fileupload_init(), !1
    }), t && ajax_update("?cmd=tickets", {
        action: "menubutton",
        make: "loadnotes",
        id: t
    }, function(t) {
        $("#ticketnotes").html(t), $(".ticketnotesremove").bind("click", e)
    }), $(".attach").click(function() {
        return $("#attachments").show(), $("#attachments").append('<br/><input type="file" size="50" name="attachments[]" class="attachment"/>'), !1
    }), $("#reply-form, #newticketform").each(function() {
        var e = $(this);
        e.fileuploadui($.extend({
            dataType: "json",
            dropZone: e
        }, e.data()))
    }), $(".deleteTicket").click(function() {
        return confirm("Do you really want to delete this ticket?") && $.post("?cmd=tickets&action=menubutton&make=deleteticket", {
            tnum: t
        }, function(e) {
            1 == parse_response(e) && $(".tload.selected").trigger("click")
        }), !1
    }), $(".deletereply").click(function() {
        var e = confirm("Do you really want to delete this reply?"),
            n = $(this).attr("href").substr($(this).attr("href").lastIndexOf("/") + 1);
        return e && $.post("?cmd=tickets&action=menubutton&make=deletereply", {
            rid: n,
            tnum: t
        }, function(e) {
            1 == parse_response(e) && $("#reply_" + n).slideUp("slow", function() {
                $(this).remove()
            })
        }), !1
    }), $("#ticket_editform").submit(function(e) {
        e.preventDefault();
        var t = this;
        return $.post("?cmd=tickets&" + $(this).serialize(), {}, function(e) {
            1 == parse_response(e) && ($("#ticket_editdetails").hide(), ajax_update($(t).attr("action"), {
                brc: s
            }, "#bodycont"))
        }), !1
    }), $("a.editTicket").click(function(e) {
        e.preventDefault();
        var n = [400, 260];
        if ($(".tdetails").data("cls") && (n = [230, ""]), $(".tdetails tr").show(), $(".tdetails").animate({
                width: n[0]
            }, {
                queue: !0
            }).data("cls", 400 == n[0]).find("input[name], select[name]").each(function() {
                var e = $(this);
                e.unbind(".edit").bind("change.edit", function() {
                    e.is("select") ? e.prev().text(e.children('[value="' + e.val() + '"]').text()) : e.prev().text(e.val())
                }), e.parents("td").eq(0).children(":first").toggle().siblings().toggle();
                var t = $(this).val();
                !e.parents(".sh_row").length || t.length && (!e.is("select") || "0" != t && 0 != t) || e.parents(".sh_row").hide()
            }), 400 == n[0]) $(".tdetails tr").show();
        else {
            $(".tdetails tr.sh_row.force").hide();
            var i = $("input[name], select[name], textarea[name], button[name]", ".tdetails").serializeObject();
            i.action = "menubutton", i.make = "edit_ticket", i.ticket_number = t, $.post("?cmd=tickets", i, function(e) {
                $.post("?cmd=tickets&action=view&list=all&num=" + t, {
                    brc: s
                }, function(e) {
                    var t = $("#replyarea").val();
                    (e = parse_response(e)) && $("#bodycont").html($(e).find("#replyarea").val(t).end())
                })
            })
        }
        $(".tdetails table tr:first td:last").animate({
            width: n[1]
        }, {
            queue: !0
        })
    }), $("a.editor").click(function(e) {
        e.preventDefault();
        var t = $(this).attr("href");
        void 0 != typeof t && "#" != t || (t = "");
        var n = $(this).parents(".ticketmsg");
        return $.post("?cmd=tickets&action=menubutton&make=getreply", {
            rid: "" == t ? $("#ticket_id").val() : t,
            rtype: "" == t ? "ticket" : "reply"
        }, function(e) {
            if (void 0 != typeof e.reply) var i = $("#msgbody" + t, n).height();
            $("#editbody" + t, n).show().children("textarea").height(i).val(e.reply).elastic(), $("#msgbody" + t, n).hide(), $(".editbytext", n).hide()
        }), !1
    }), $("a.editorsubmit").click(function(e) {
        e.preventDefault();
        var t = $(this).attr("href");
        void 0 != typeof t && "#" != t || (t = "");
        var n = $(this).parents(".ticketmsg");
        return $.post("?cmd=tickets&action=menubutton&make=editreply", {
            rid: "" == t ? $("#ticket_id").val() : t,
            rtype: "" == t ? "ticket" : "reply",
            body: $("#editbody" + t, n).children("textarea").val()
        }, function(e) {
            var i = parse_response(e);
            $("#msgbody" + t, n).replaceWith(i).show();
            $("#editbody" + t, n).hide()
        }), !1
    }), $(".quoter").click(function() {
        var e = "reply";
        "reply" != $(this).attr("type") && (e = "ticket");
        var t = $(this).attr("href").substr($(this).attr("href").lastIndexOf("/") + 1);
        return $.post("?cmd=tickets&action=menubutton&make=quote", {
            rid: t,
            rtype: e
        }, function(e) {
            var t = parse_response(e);
            if ("string" == typeof t) {
                var n = $("#replyarea").val();
                $("#replyarea").val(n + "\r\n" + t), $(".scroller").trigger("click")
            }
        }), !1
    }), $(".tdetail a").click(function() {
        return $(".tdetails").toggle(), $(".a1").toggle(), $(".a2").toggle(), !1
    }), $(".ticketmsg").mouseup(function() {
        "" != (i.selection ? i.selection.createRange().text : i.getSelection()) ? $(this).find(".quoter2").show(): $(this).find(".quoter2").hide()
    }), $(".quoter2").click(function() {
        var e = i.selection ? i.selection.createRange().text : i.getSelection().toString(),
            t = $("#replyarea").val();
        return $("#replyarea").val(t + "\r\n>" + e.replace(/\n/g, "\n>") + "\r\n"), $(".scroller").trigger("click"), !1
    }), $(".setStatus").dropdownMenu({}, function(e, n, r, o) {
        e = e.substr(e.lastIndexOf("/") + 1);
        var a = $(r.target).data("color");
        if ("000000" === a && (a = !1), -1 != e.lastIndexOf("status|")) e = e.substr(e.lastIndexOf("|") + 1), $.post("?cmd=tickets&action=menubutton&make=setstatus", {
            status: e,
            id: t
        }, function(t) {
            var n = parse_response(t);
            0 != n && null != n && ($("#ticket_status").html(o), 0 == a ? $("#ticket_status").removeAttr("style") : $("#ticket_status").css("color", "#" + a), $("#ticket_status").attr({
                class: e
            }), $("#hd1_m li").removeClass("disabled"), $("li.act_" + e.toLowerCase()).addClass("disabled"), "Closed" == e ? ($("#replytable").hide(), $("#backto").click()) : $("#replytable").show())
        });
        else if ("Low" == e || "Medium" == e || "High" == e || "Critical" == e) $.post("?cmd=tickets&action=menubutton&make=setpriority", {
            priority: e,
            id: t
        }, function(t) {
            var n = parse_response(t);
            0 != n && null != n && ($("#hd4_m li").removeClass("disabled"), $("#ticket_status").parent().attr("class", "").addClass("prior_" + e), $("#ticketbody").attr("class", "").addClass("prior_" + e), $("li.opt_" + e.toLowerCase()).addClass("disabled"))
        });
        else if ("Unread" == e) ajax_update("?cmd=tickets&action=menubutton&make=markunread", {
            id: t
        });
        else if ("ShowLog" == e) ajax_update("?cmd=tickets&action=menubutton&make=showlog", {
            id: $("#ticket_id").val()
        }, "#ticket_log"), $("#ticket_log").show(), $("#ticket_editdetails").hide();
        else if ("ChangeParent" == e) {
            var l = $("#changeparent-modal"),
                c = l.find(".modal-body");
            ajax_update("?cmd=tickets&action=menubutton&make=ticketparent", {
                id: t
            }, function(e) {
                c.html(e), $("select[name=parent_id]", c).chosensearch({
                    width: "100%",
                    placeholder_text: "Search for ticket number of subject",
                    enable_split_word_search: !0,
                    search_contains: !0,
                    type: "Tickets",
                    args: {
                        type: "Tickets"
                    },
                    none_option: {
                        name: "None",
                        value: 0,
                        query: ""
                    }
                }), l.modal()
            })
        } else if ("blockBody" == e) {
            var d = i.selection ? i.selection.createRange().text : i.getSelection().toString();
            ajax_update("?cmd=tickets&action=menubutton&make=addban", {
                tnum: t,
                type: "body",
                text: d
            })
        } else "blockEmail" == e ? ajax_update("?cmd=tickets&action=menubutton&make=addban", {
            tnum: t,
            type: "email"
        }) : "blockSubject" == e ? ajax_update("?cmd=tickets&action=menubutton&make=addban", {
            tnum: t,
            type: "subject"
        }) : "share:" == e.substr(0, 6) ? $.post("?cmd=tickets&action=menubutton&make=share", {
            tnum: t,
            uuid: e.substr(6)
        }, function(e) {
            return parse_response(e), ajax_update("?cmd=tickets&action=view&list=all&num=" + t, {
                brc: s
            }, "#bodycont"), !1
        }) : "unshare" == e ? $.post("?cmd=tickets&action=menubutton&make=unshare", {
            tnum: t
        }, function(e) {
            ajax_update("?cmd=tickets&action=view&list=all&num=" + t, {
                brc: s
            }, "#bodycont")
        }) : "assign:" != e.substr(0, 7) && "subscr:" != e.substr(0, 7) || $.post("?cmd=tickets&action=menubutton&make=assign", {
            tnum: t,
            id: e.substr(7)
        }, function(e) {
            return parse_response(e), ajax_update("?cmd=tickets&action=view&list=all&num=" + t, {
                brc: s
            }, function(e) {
                var t = $("textarea, select, input[type!=hidden]", "#replytable form").serializeObject();
                $("#bodycont").html(parse_response(e)), $.each(t, function(e) {
                    var t = $("[name=" + e + "]", "#replytable form");
                    t.is("[type=checkbox]") ? t.prop("checked", "on" == this.toString()) : t.val(this.toString())
                })
            }), !1
        })
    }), $(i).mouseup(function() {
        "" != (i.selection ? i.selection.createRange().text : i.getSelection()) ? $(".highlighter").removeClass("disabled"): ($(".highlighter").addClass("disabled"), $(".quoter2").hide())
    }), $("#client_picker").change(function() {
        switch ($(this).removeClass("err"), $("#emailrow").hide(), $("#emailrow2").hide(), $("#emailrow3").hide(), $("#emailrow4").hide(), $(this).val()) {
            case "-1":
                $("#emailrow").show(), $("#emailrow2").show();
                break;
            case "-2":
                $("#emailrow3").show();
                break;
            case "0":
                break;
            default:
                $("#contactloader").html(""), $("#emailrow4").show(), ajax_update("?cmd=tickets&action=clientcontacts", {
                    id: $(this).val()
                }, "#contactloader")
        }
    }), $("#newticketform").submit(function() {
        return "0" != $("#client_picker").val() || ($("#client_picker").addClass("err"), !1)
    });
    var r = $('<div class="showmore">... show full quoted text</div>');
    $(".msgwrapper > div > blockquote").each(function() {
        $(this).height() > 60 && $(this).append(r.clone().click(function() {
            $(this).parent().css({
                height: "auto"
            }), $(this).remove()
        })).height(60)
    });
    var o = $(".ticketmsg:gt(0)").not(":last, .tpinned");
    if (o.length > 3) {
        var a = $('<div class="ticketmsg tmsgwarn"><h2>Click here to show (' + o.length + ") other messages</h2></div>").click(function() {
            $(".ticketmsg:hidden").show(), $(this).remove()
        });
        o.hide().eq(0).before(a)
    }
    t == parseInt(t) && $(document).trigger("HostBill.ticketload", [t, $("#ticket_id").val()])
}

function checkEl() {
    var e = $(this).parent().parent();
    $(this).is(":checked") ? e.addClass("checkedRow") : e.removeClass("checkedRow")
}

function bindEvents(e) {
    if (void 0 !== e);
    else {
        window.pjaxloadtimes || (window.pjaxloadtimes = [new Date - ts]);
        var t = window.pjaxloadtimes.reduce(function(e, t) {
            return e + t
        }) / window.pjaxloadtimes.length;
        console.log(t), $(document).off("click.pjax pjax:send pjax:complete pjax:beforeReplace").pjax("a[data-pjax]", "#bodycont", {
            timeout: 2 * t
        }).on("pjax:send", function() {
            window.pjaxstamp = new Date, $("#taskMGR").taskQuickLoadShow()
        }).on("pjax:beforeReplace", function(e, t, n) {
            8 == t[0].nodeType && (parse_response("\x3c!--" + t[0].textContent + "--\x3e"), t[0].textContent = "PJAX")
        }).on("pjax:complete", function(e, t, n) {
            window.pjaxloadtimes.push(new Date - window.pjaxstamp), $("#taskMGR").taskQuickLoadHide(), bindEvents(!0)
        })
    }
    var n = $("#bodycont >*:first");
    if (n.data("eventBind")) return 1;
    $(".leftNav", "#body-content").off("click.leftNav").on("click.leftNav", "a[data-pjax].tstyled", function() {
        $(".leftNav a", "#body-content").removeClass("selected"), $(this).addClass("selected")
    }), bindFreseter();
    var i = $(window),
        s = $("#back-to-top"),
        r = document.body.scrollHeight - ($(".pagination:last").position() || {
            top: 0
        }).top < 55;
    i.on("scroll", function() {
        var e = i.scrollTop(),
            t = i.height();
        s.toggleClass("show", e > 100).toggleClass("margin", r && document.body.scrollHeight - (t + e) < 55)
    }), s.on("click", function(e) {
        e.preventDefault(), $("html,body").animate({
            scrollTop: 0
        }, 300)
    }), n.data("eventBind", 1), console.log("bindEvents"), $("#updater").on("click", ".check", checkEl), $(".vtip_description").vTip(), $(".hpLinks").dropdownMenu({
        movement: 5
    }, function(e) {
        window.location = e
    }), $(".linkDirectly").click(function() {
        return window.location = $(this).attr("href"), !1
    }), $(".havecontrols").hover(function() {
        $(this).find(".controls").show()
    }, function() {
        $(this).find(".controls").hide()
    }), $("a.sortorder").click(function() {
        return $("#updater").addLoader(), $("a.sortorder").removeClass("asc"), $("a.sortorder").removeClass("desc"), $("#checkall").attr("checked", !1), $("#currentlist").attr("href", $(this).attr("href")), "|ASC" == $(this).attr("href").substring($(this).attr("href").lastIndexOf("|")) ? ($(this).addClass("asc"), $(this).attr("href", $(this).attr("href").substring(0, $(this).attr("href").lastIndexOf("|")) + "|DESC")) : ($(this).addClass("desc"), $(this).attr("href", $(this).attr("href").substring(0, $(this).attr("href").lastIndexOf("|")) + "|ASC")), $.post($("#currentlist").attr("href"), {
            page: parseInt($(".pagination span.current").eq(0).html()) - 1
        }, function(e) {
            var t = parse_response(e);
            t && ($("#updater").html(t), $(".check").unbind("click").click(checkEl))
        }), !1
    }), $("#checkall").click(function() {
        $(this).is(":checked") ? $(".check").prop("checked", !0).parent().parent().addClass("checkedRow") : $(".check").prop("checked", !1).parent().parent().removeClass("checkedRow")
    }), $("div.pagination").pagination($("#totalpages").val()), $(".confirm_it").on("click.confirm_it", function() {
        if (!confirm("Are you sure you want to perform this action?")) return !1
    }), $(".submiter").on("click.submiter", function() {
        if ($(this).hasClass("confirm") && !confirm("Are you sure you want to perform this action?")) return !1;
        $(this).hasClass("formsubmit") || $("#updater").addLoader(), $("#checkall").removeAttr("checked").prop("checked", !1);
        var e = "";
        "push" == $(this).attr("queue") && (e = "push");
        var t = "";
        return $(".pagination span.current").length > 0 && (t = "&page=" + (parseInt($(".pagination span.current").eq(0).html()) - 1)), $(this).hasClass("formsubmit") ? (window.location = $("#currentlist").attr("href") + t + "&" + $("#testform").serialize() + "&" + $(this).attr("name"), !1) : ($.post($("#currentlist").attr("href") + t + "&" + $("#testform").serialize() + "&" + $(this).attr("name"), {
            stack: e
        }, function(e) {
            var t = parse_response(e);
            t && $("#updater").html(t)
        }), !1)
    }), $("a.nav_el").each(function(e) {
        var t = $(this);
        t.off("click.nav_el").on("click.nav_el", function() {
            if (t.hasClass("direct")) return !0;
            if (t.hasClass("nav_sel")) return t.removeClass("nav_sel").removeClass("minim"), $("a.nav_el").eq(0).addClass("nav_sel"), $("div.slide").eq(e).hide(), $("div.slide").eq(0).show(), !1;
            $("#client_tab").find("div.slide").hide();
            var n = $("#client_tab").find("div.slide").eq(e);
            return "Loading" != n.html() ? n.show() : (ajax_update($(this).attr("href"), {}, "div.slide:eq(" + e + ")"), n.show()), $("a.nav_el").removeClass("nav_sel").removeClass("minim"), t.addClass("nav_sel"), e > 0 && t.addClass("minim"), !1
        })
    }), $("[load]").each(function(e) {
        var t = $(this);
        if (t.data("loaded") || t.data("loading")) return !1;
        if (t.data("loading", 1), "clients" == t.attr("load")) return Chosen.find(), !1;
        if (t.is("select")) var n = $('<option class="search_loading" style="padding:0 0 0 20px"> Loading</option>').appendTo(this);
        $.get(t.attr("load"), function(e) {
            t.data("loaded", !0).data("loading", 0).append(e), void 0 !== n && n.remove()
        })
    }), $("#clientnav-wrapper").bootstrapResponsiveTabs()
}

function bindQConfigEvents() {
    $("#change_pass").click(function() {
        var e = $(this).parents("form").find("input[name='password1']").val(),
            t = $(this).parents("form").find("input[name='password2']").val();
        $("#qc_update").addLoader(), ajax_update("?action=saveqc&make=changepass", {
            password1: e,
            password2: t,
            qc_page: "Admin_Pass"
        }, "#qc_update")
    }), $(".activate_item").click(function() {
        var e = $(this).parent().find("input[name='type']").val();
        if ("Payment" == e || "Hosting" == e || "Domain" == e) {
            $("#qc_update").addLoader();
            ajax_update("?action=saveqc&make=activate", {
                filename: $(this).parent().find("select[name='modulename']").val(),
                type: e,
                qc_page: e
            }, "#qc_update")
        } else if ("Servers" == e) {
            $("#qc_update").addLoader();
            ajax_update("?action=saveqc&make=addserver", {
                name: $(this).parent().find("input[name='name']").val(),
                qc_page: "Servers"
            }, "#qc_update")
        }
    }), $(".getconfig").click(function() {
        var e = $(this).parents("form").find("input[name='id']").val(),
            t = $(this).parents("form").find("input[name='type']").val();
        if ("Payment" == t) var n = ".payconfig_" + e;
        else if ("Domain" == t) n = ".domconfig_" + e;
        else {
            if ("Servers" != t) return !1;
            n = ".srvconfig_" + e
        }
        return $(n).hasClass("shown") ? ($(this).html("Show Config"), $(n).hide(), $(n).removeClass("shown")) : ($(this).html("Hide Config"), $(n).show(), $(n).addClass("shown")), !1
    }), $(".deactivatemod").click(function() {
        var e = $(this).parents("form").find("input[name='id']").val(),
            t = $(this).parents("form").find("input[name='type']").val();
        $("#qc_update").addLoader(), ajax_update("?action=saveqc&make=deactivate", {
            id: e,
            qc_page: t
        }, "#qc_update")
    }), $(".savemod").click(function() {
        var e = $(this).parents("form").find("input[name='id']").val(),
            t = $(this).parents("form").find("input[name='type']").val(),
            n = $(this).parents("form").serialize();
        $("#qc_update").addLoader(), ajax_update("?action=saveqc&make=savemodule&" + n, {
            id: e,
            qc_page: t
        }, "#qc_update")
    }), $(".saveserver").click(function() {
        var e = $(this).parents("form").find("input[name='id']").val(),
            t = $(this).parents("form").serialize();
        $("#qc_update").addLoader(), ajax_update("?action=saveqc&make=saveserver&" + t, {
            id: e,
            qc_page: "Servers"
        }, "#qc_update")
    }), $(".removeserver").click(function() {
        var e = $(this).parents("form").find("input[name='id']").val();
        confirm("Do You really want to remove this server?") && ($("#qc_update").addLoader(), ajax_update("?action=saveqc&make=removeserver", {
            id: e,
            qc_page: "Servers"
        }, "#qc_update"))
    })
}

function send_msg(e) {
    return "clients" == e && $("input[class=check]:checked").length < 1 || "allclients" != e && 0 == $("input[class=check]:checked").length ? (alert("Nothing checked."), !1) : ($("#testform").removeAttr("action"), $("#testform").attr("action", "?cmd=sendmessage"), $("#testform").append('<input type="hidden" name="type" value="' + e + '" />'), $("#testform").submit(), !1)
}! function(e, t) {
    "object" == typeof module && "object" == typeof module.exports ? module.exports = e.document ? t(e, !0) : function(e) {
        if (!e.document) throw new Error("jQuery requires a window with a document");
        return t(e)
    } : t(e)
}("undefined" != typeof window ? window : this, function(e, t) {
    function n(e) {
        var t = !!e && "length" in e && e.length,
            n = oe.type(e);
        return "function" !== n && !oe.isWindow(e) && ("array" === n || 0 === t || "number" == typeof t && t > 0 && t - 1 in e)
    }

    function i(e, t, n) {
        if (oe.isFunction(t)) return oe.grep(e, function(e, i) {
            return !!t.call(e, i, e) !== n
        });
        if (t.nodeType) return oe.grep(e, function(e) {
            return e === t !== n
        });
        if ("string" == typeof t) {
            if (ge.test(t)) return oe.filter(t, e, n);
            t = oe.filter(t, e)
        }
        return oe.grep(e, function(e) {
            return oe.inArray(e, t) > -1 !== n
        })
    }

    function s(e, t) {
        do {
            e = e[t]
        } while (e && 1 !== e.nodeType);
        return e
    }

    function r() {
        K.addEventListener ? (K.removeEventListener("DOMContentLoaded", o), e.removeEventListener("load", o)) : (K.detachEvent("onreadystatechange", o), e.detachEvent("onload", o))
    }

    function o() {
        (K.addEventListener || "load" === e.event.type || "complete" === K.readyState) && (r(), oe.ready())
    }

    function a(e, t, n) {
        if (void 0 === n && 1 === e.nodeType) {
            var i = "data-" + t.replace(Se, "-$1").toLowerCase();
            if ("string" == typeof(n = e.getAttribute(i))) {
                try {
                    n = "true" === n || "false" !== n && ("null" === n ? null : +n + "" === n ? +n : $e.test(n) ? oe.parseJSON(n) : n)
                } catch (e) {}
                oe.data(e, t, n)
            } else n = void 0
        }
        return n
    }

    function l(e) {
        var t;
        for (t in e)
            if (("data" !== t || !oe.isEmptyObject(e[t])) && "toJSON" !== t) return !1;
        return !0
    }

    function c(e, t, n, i) {
        if (Ce(e)) {
            var s, r, o = oe.expando,
                a = e.nodeType,
                l = a ? oe.cache : e,
                c = a ? e[o] : e[o] && o;
            if (c && l[c] && (i || l[c].data) || void 0 !== n || "string" != typeof t) return c || (c = a ? e[o] = G.pop() || oe.guid++ : o), l[c] || (l[c] = a ? {} : {
                toJSON: oe.noop
            }), "object" != typeof t && "function" != typeof t || (i ? l[c] = oe.extend(l[c], t) : l[c].data = oe.extend(l[c].data, t)), r = l[c], i || (r.data || (r.data = {}), r = r.data), void 0 !== n && (r[oe.camelCase(t)] = n), "string" == typeof t ? null == (s = r[t]) && (s = r[oe.camelCase(t)]) : s = r, s
        }
    }

    function d(e, t, n) {
        if (Ce(e)) {
            var i, s, r = e.nodeType,
                o = r ? oe.cache : e,
                a = r ? e[oe.expando] : oe.expando;
            if (o[a]) {
                if (t && (i = n ? o[a] : o[a].data)) {
                    s = (t = oe.isArray(t) ? t.concat(oe.map(t, oe.camelCase)) : t in i ? [t] : (t = oe.camelCase(t)) in i ? [t] : t.split(" ")).length;
                    for (; s--;) delete i[t[s]];
                    if (n ? !l(i) : !oe.isEmptyObject(i)) return
                }(n || (delete o[a].data, l(o[a]))) && (r ? oe.cleanData([e], !0) : re.deleteExpando || o != o.window ? delete o[a] : o[a] = void 0)
            }
        }
    }

    function u(e, t, n, i) {
        var s, r = 1,
            o = 20,
            a = i ? function() {
                return i.cur()
            } : function() {
                return oe.css(e, t, "")
            },
            l = a(),
            c = n && n[3] || (oe.cssNumber[t] ? "" : "px"),
            d = (oe.cssNumber[t] || "px" !== c && +l) && De.exec(oe.css(e, t));
        if (d && d[3] !== c) {
            c = c || d[3], n = n || [], d = +l || 1;
            do {
                d /= r = r || ".5", oe.style(e, t, d + c)
            } while (r !== (r = a() / l) && 1 !== r && --o)
        }
        return n && (d = +d || +l || 0, s = n[1] ? d + (n[1] + 1) * n[2] : +n[2], i && (i.unit = c, i.start = d, i.end = s)), s
    }

    function h(e) {
        var t = je.split("|"),
            n = e.createDocumentFragment();
        if (n.createElement)
            for (; t.length;) n.createElement(t.pop());
        return n
    }

    function p(e, t) {
        var n, i, s = 0,
            r = void 0 !== e.getElementsByTagName ? e.getElementsByTagName(t || "*") : void 0 !== e.querySelectorAll ? e.querySelectorAll(t || "*") : void 0;
        if (!r)
            for (r = [], n = e.childNodes || e; null != (i = n[s]); s++) !t || oe.nodeName(i, t) ? r.push(i) : oe.merge(r, p(i, t));
        return void 0 === t || t && oe.nodeName(e, t) ? oe.merge([e], r) : r
    }

    function f(e, t) {
        for (var n, i = 0; null != (n = e[i]); i++) oe._data(n, "globalEval", !t || oe._data(t[i], "globalEval"))
    }

    function m(e) {
        Me.test(e.type) && (e.defaultChecked = e.checked)
    }

    function g(e, t, n, i, s) {
        for (var r, o, a, l, c, d, u, g = e.length, v = h(t), _ = [], y = 0; y < g; y++)
            if ((o = e[y]) || 0 === o)
                if ("object" === oe.type(o)) oe.merge(_, o.nodeType ? [o] : o);
                else if (Le.test(o)) {
            for (l = l || v.appendChild(t.createElement("div")), c = (Ne.exec(o) || ["", ""])[1].toLowerCase(), u = He[c] || He._default, l.innerHTML = u[1] + oe.htmlPrefilter(o) + u[2], r = u[0]; r--;) l = l.lastChild;
            if (!re.leadingWhitespace && Ae.test(o) && _.push(t.createTextNode(Ae.exec(o)[0])), !re.tbody)
                for (r = (o = "table" !== c || Fe.test(o) ? "<table>" !== u[1] || Fe.test(o) ? 0 : l : l.firstChild) && o.childNodes.length; r--;) oe.nodeName(d = o.childNodes[r], "tbody") && !d.childNodes.length && o.removeChild(d);
            for (oe.merge(_, l.childNodes), l.textContent = ""; l.firstChild;) l.removeChild(l.firstChild);
            l = v.lastChild
        } else _.push(t.createTextNode(o));
        for (l && v.removeChild(l), re.appendChecked || oe.grep(p(_, "input"), m), y = 0; o = _[y++];)
            if (i && oe.inArray(o, i) > -1) s && s.push(o);
            else if (a = oe.contains(o.ownerDocument, o), l = p(v.appendChild(o), "script"), a && f(l), n)
            for (r = 0; o = l[r++];) Ie.test(o.type || "") && n.push(o);
        return l = null, v
    }

    function v() {
        return !0
    }

    function _() {
        return !1
    }

    function y() {
        try {
            return K.activeElement
        } catch (e) {}
    }

    function b(e, t, n, i, s, r) {
        var o, a;
        if ("object" == typeof t) {
            "string" != typeof n && (i = i || n, n = void 0);
            for (a in t) b(e, a, n, i, t[a], r);
            return e
        }
        if (null == i && null == s ? (s = n, i = n = void 0) : null == s && ("string" == typeof n ? (s = i, i = void 0) : (s = i, i = n, n = void 0)), !1 === s) s = _;
        else if (!s) return e;
        return 1 === r && (o = s, (s = function(e) {
            return oe().off(e), o.apply(this, arguments)
        }).guid = o.guid || (o.guid = oe.guid++)), e.each(function() {
            oe.event.add(this, t, s, i, n)
        })
    }

    function w(e, t) {
        return oe.nodeName(e, "table") && oe.nodeName(11 !== t.nodeType ? t : t.firstChild, "tr") ? e.getElementsByTagName("tbody")[0] || e.appendChild(e.ownerDocument.createElement("tbody")) : e
    }

    function x(e) {
        return e.type = (null !== oe.find.attr(e, "type")) + "/" + e.type, e
    }

    function k(e) {
        var t = Ge.exec(e.type);
        return t ? e.type = t[1] : e.removeAttribute("type"), e
    }

    function C(e, t) {
        if (1 === t.nodeType && oe.hasData(e)) {
            var n, i, s, r = oe._data(e),
                o = oe._data(t, r),
                a = r.events;
            if (a) {
                delete o.handle, o.events = {};
                for (n in a)
                    for (i = 0, s = a[n].length; i < s; i++) oe.event.add(t, n, a[n][i])
            }
            o.data && (o.data = oe.extend({}, o.data))
        }
    }

    function $(e, t) {
        var n, i, s;
        if (1 === t.nodeType) {
            if (n = t.nodeName.toLowerCase(), !re.noCloneEvent && t[oe.expando]) {
                s = oe._data(t);
                for (i in s.events) oe.removeEvent(t, i, s.handle);
                t.removeAttribute(oe.expando)
            }
            "script" === n && t.text !== e.text ? (x(t).text = e.text, k(t)) : "object" === n ? (t.parentNode && (t.outerHTML = e.outerHTML), re.html5Clone && e.innerHTML && !oe.trim(t.innerHTML) && (t.innerHTML = e.innerHTML)) : "input" === n && Me.test(e.type) ? (t.defaultChecked = t.checked = e.checked, t.value !== e.value && (t.value = e.value)) : "option" === n ? t.defaultSelected = t.selected = e.defaultSelected : "input" !== n && "textarea" !== n || (t.defaultValue = e.defaultValue)
        }
    }

    function S(e, t, n, i) {
        t = Z.apply([], t);
        var s, r, o, a, l, c, d = 0,
            u = e.length,
            h = u - 1,
            f = t[0],
            m = oe.isFunction(f);
        if (m || u > 1 && "string" == typeof f && !re.checkClone && Qe.test(f)) return e.each(function(s) {
            var r = e.eq(s);
            m && (t[0] = f.call(this, s, r.html())), S(r, t, n, i)
        });
        if (u && (c = g(t, e[0].ownerDocument, !1, e, i), s = c.firstChild, 1 === c.childNodes.length && (c = s), s || i)) {
            for (o = (a = oe.map(p(c, "script"), x)).length; d < u; d++) r = c, d !== h && (r = oe.clone(r, !0, !0), o && oe.merge(a, p(r, "script"))), n.call(e[d], r, d);
            if (o)
                for (l = a[a.length - 1].ownerDocument, oe.map(a, k), d = 0; d < o; d++) r = a[d], Ie.test(r.type || "") && !oe._data(r, "globalEval") && oe.contains(l, r) && (r.src ? oe._evalUrl && oe._evalUrl(r.src) : oe.globalEval((r.text || r.textContent || r.innerHTML || "").replace(Ke, "")));
            c = s = null
        }
        return e
    }

    function T(e, t, n) {
        for (var i, s = t ? oe.filter(t, e) : e, r = 0; null != (i = s[r]); r++) n || 1 !== i.nodeType || oe.cleanData(p(i)), i.parentNode && (n && oe.contains(i.ownerDocument, i) && f(p(i, "script")), i.parentNode.removeChild(i));
        return e
    }

    function D(e, t) {
        var n = oe(t.createElement(e)).appendTo(t.body),
            i = oe.css(n[0], "display");
        return n.detach(), i
    }

    function E(e) {
        var t = K,
            n = et[e];
        return n || ("none" !== (n = D(e, t)) && n || ((t = ((Ze = (Ze || oe("<iframe frameborder='0' width='0' height='0'/>")).appendTo(t.documentElement))[0].contentWindow || Ze[0].contentDocument).document).write(), t.close(), n = D(e, t), Ze.detach()), et[e] = n), n
    }

    function P(e, t) {
        return {
            get: function() {
                if (!e()) return (this.get = t).apply(this, arguments);
                delete this.get
            }
        }
    }

    function O(e) {
        if (e in mt) return e;
        for (var t = e.charAt(0).toUpperCase() + e.slice(1), n = ft.length; n--;)
            if ((e = ft[n] + t) in mt) return e
    }

    function M(e, t) {
        for (var n, i, s, r = [], o = 0, a = e.length; o < a; o++)(i = e[o]).style && (r[o] = oe._data(i, "olddisplay"), n = i.style.display, t ? (r[o] || "none" !== n || (i.style.display = ""), "" === i.style.display && Pe(i) && (r[o] = oe._data(i, "olddisplay", E(i.nodeName)))) : (s = Pe(i), (n && "none" !== n || !s) && oe._data(i, "olddisplay", s ? n : oe.css(i, "display"))));
        for (o = 0; o < a; o++)(i = e[o]).style && (t && "none" !== i.style.display && "" !== i.style.display || (i.style.display = t ? r[o] || "" : "none"));
        return e
    }

    function N(e, t, n) {
        var i = ut.exec(t);
        return i ? Math.max(0, i[1] - (n || 0)) + (i[2] || "px") : t
    }

    function I(e, t, n, i, s) {
        for (var r = n === (i ? "border" : "content") ? 4 : "width" === t ? 1 : 0, o = 0; r < 4; r += 2) "margin" === n && (o += oe.css(e, n + Ee[r], !0, s)), i ? ("content" === n && (o -= oe.css(e, "padding" + Ee[r], !0, s)), "margin" !== n && (o -= oe.css(e, "border" + Ee[r] + "Width", !0, s))) : (o += oe.css(e, "padding" + Ee[r], !0, s), "padding" !== n && (o += oe.css(e, "border" + Ee[r] + "Width", !0, s)));
        return o
    }

    function A(e, t, n) {
        var i = !0,
            s = "width" === t ? e.offsetWidth : e.offsetHeight,
            r = rt(e),
            o = re.boxSizing && "border-box" === oe.css(e, "boxSizing", !1, r);
        if (s <= 0 || null == s) {
            if (((s = ot(e, t, r)) < 0 || null == s) && (s = e.style[t]), nt.test(s)) return s;
            i = o && (re.boxSizingReliable() || s === e.style[t]), s = parseFloat(s) || 0
        }
        return s + I(e, t, n || (o ? "border" : "content"), i, r) + "px"
    }

    function j(e, t, n, i, s) {
        return new j.prototype.init(e, t, n, i, s)
    }

    function H() {
        return e.setTimeout(function() {
            gt = void 0
        }), gt = oe.now()
    }

    function L(e, t) {
        var n, i = {
                height: e
            },
            s = 0;
        for (t = t ? 1 : 0; s < 4; s += 2 - t) i["margin" + (n = Ee[s])] = i["padding" + n] = e;
        return t && (i.opacity = i.width = e), i
    }

    function F(e, t, n) {
        for (var i, s = (R.tweeners[t] || []).concat(R.tweeners["*"]), r = 0, o = s.length; r < o; r++)
            if (i = s[r].call(n, t, e)) return i
    }

    function R(e, t, n) {
        var i, s, r = 0,
            o = R.prefilters.length,
            a = oe.Deferred().always(function() {
                delete l.elem
            }),
            l = function() {
                if (s) return !1;
                for (var t = gt || H(), n = Math.max(0, c.startTime + c.duration - t), i = 1 - (n / c.duration || 0), r = 0, o = c.tweens.length; r < o; r++) c.tweens[r].run(i);
                return a.notifyWith(e, [c, i, n]), i < 1 && o ? n : (a.resolveWith(e, [c]), !1)
            },
            c = a.promise({
                elem: e,
                props: oe.extend({}, t),
                opts: oe.extend(!0, {
                    specialEasing: {},
                    easing: oe.easing._default
                }, n),
                originalProperties: t,
                originalOptions: n,
                startTime: gt || H(),
                duration: n.duration,
                tweens: [],
                createTween: function(t, n) {
                    var i = oe.Tween(e, c.opts, t, n, c.opts.specialEasing[t] || c.opts.easing);
                    return c.tweens.push(i), i
                },
                stop: function(t) {
                    var n = 0,
                        i = t ? c.tweens.length : 0;
                    if (s) return this;
                    for (s = !0; n < i; n++) c.tweens[n].run(1);
                    return t ? (a.notifyWith(e, [c, 1, 0]), a.resolveWith(e, [c, t])) : a.rejectWith(e, [c, t]), this
                }
            }),
            d = c.props;
        for (! function(e, t) {
                var n, i, s, r, o;
                for (n in e)
                    if (i = oe.camelCase(n), s = t[i], r = e[n], oe.isArray(r) && (s = r[1], r = e[n] = r[0]), n !== i && (e[i] = r, delete e[n]), (o = oe.cssHooks[i]) && "expand" in o) {
                        r = o.expand(r), delete e[i];
                        for (n in r) n in e || (e[n] = r[n], t[n] = s)
                    } else t[i] = s
            }(d, c.opts.specialEasing); r < o; r++)
            if (i = R.prefilters[r].call(c, e, d, c.opts)) return oe.isFunction(i.stop) && (oe._queueHooks(c.elem, c.opts.queue).stop = oe.proxy(i.stop, i)), i;
        return oe.map(d, F, c), oe.isFunction(c.opts.start) && c.opts.start.call(e, c), oe.fx.timer(oe.extend(l, {
            elem: e,
            anim: c,
            queue: c.opts.queue
        })), c.progress(c.opts.progress).done(c.opts.done, c.opts.complete).fail(c.opts.fail).always(c.opts.always)
    }

    function B(e) {
        return oe.attr(e, "class") || ""
    }

    function q(e) {
        return function(t, n) {
            "string" != typeof t && (n = t, t = "*");
            var i, s = 0,
                r = t.toLowerCase().match(we) || [];
            if (oe.isFunction(n))
                for (; i = r[s++];) "+" === i.charAt(0) ? (i = i.slice(1) || "*", (e[i] = e[i] || []).unshift(n)) : (e[i] = e[i] || []).push(n)
        }
    }

    function Y(e, t, n, i) {
        function s(a) {
            var l;
            return r[a] = !0, oe.each(e[a] || [], function(e, a) {
                var c = a(t, n, i);
                return "string" != typeof c || o || r[c] ? o ? !(l = c) : void 0 : (t.dataTypes.unshift(c), s(c), !1)
            }), l
        }
        var r = {},
            o = e === qt;
        return s(t.dataTypes[0]) || !r["*"] && s("*")
    }

    function W(e, t) {
        var n, i, s = oe.ajaxSettings.flatOptions || {};
        for (i in t) void 0 !== t[i] && ((s[i] ? e : n || (n = {}))[i] = t[i]);
        return n && oe.extend(!0, e, n), e
    }

    function z(e) {
        return e.style && e.style.display || oe.css(e, "display")
    }

    function U(e, t, n, i) {
        var s;
        if (oe.isArray(t)) oe.each(t, function(t, s) {
            n || Vt.test(e) ? i(e, s) : U(e + "[" + ("object" == typeof s && null != s ? t : "") + "]", s, n, i)
        });
        else if (n || "object" !== oe.type(t)) i(e, t);
        else
            for (s in t) U(e + "[" + s + "]", t[s], n, i)
    }

    function V() {
        try {
            return new e.XMLHttpRequest
        } catch (e) {}
    }

    function X() {
        try {
            return new e.ActiveXObject("Microsoft.XMLHTTP")
        } catch (e) {}
    }

    function Q(e) {
        return oe.isWindow(e) ? e : 9 === e.nodeType && (e.defaultView || e.parentWindow)
    }
    var G = [],
        K = e.document,
        J = G.slice,
        Z = G.concat,
        ee = G.push,
        te = G.indexOf,
        ne = {},
        ie = ne.toString,
        se = ne.hasOwnProperty,
        re = {},
        oe = function(e, t) {
            return new oe.fn.init(e, t)
        },
        ae = /^[\s\uFEFF\xA0]+|[\s\uFEFF\xA0]+$/g,
        le = /^-ms-/,
        ce = /-([\da-z])/gi,
        de = function(e, t) {
            return t.toUpperCase()
        };
    oe.fn = oe.prototype = {
        jquery: "1.12.4",
        constructor: oe,
        selector: "",
        length: 0,
        toArray: function() {
            return J.call(this)
        },
        get: function(e) {
            return null != e ? e < 0 ? this[e + this.length] : this[e] : J.call(this)
        },
        pushStack: function(e) {
            var t = oe.merge(this.constructor(), e);
            return t.prevObject = this, t.context = this.context, t
        },
        each: function(e) {
            return oe.each(this, e)
        },
        map: function(e) {
            return this.pushStack(oe.map(this, function(t, n) {
                return e.call(t, n, t)
            }))
        },
        slice: function() {
            return this.pushStack(J.apply(this, arguments))
        },
        first: function() {
            return this.eq(0)
        },
        last: function() {
            return this.eq(-1)
        },
        eq: function(e) {
            var t = this.length,
                n = +e + (e < 0 ? t : 0);
            return this.pushStack(n >= 0 && n < t ? [this[n]] : [])
        },
        end: function() {
            return this.prevObject || this.constructor()
        },
        push: ee,
        sort: G.sort,
        splice: G.splice
    }, oe.extend = oe.fn.extend = function() {
        var e, t, n, i, s, r, o = arguments[0] || {},
            a = 1,
            l = arguments.length,
            c = !1;
        for ("boolean" == typeof o && (c = o, o = arguments[a] || {}, a++), "object" == typeof o || oe.isFunction(o) || (o = {}), a === l && (o = this, a--); a < l; a++)
            if (null != (s = arguments[a]))
                for (i in s) e = o[i], o !== (n = s[i]) && (c && n && (oe.isPlainObject(n) || (t = oe.isArray(n))) ? (t ? (t = !1, r = e && oe.isArray(e) ? e : []) : r = e && oe.isPlainObject(e) ? e : {}, o[i] = oe.extend(c, r, n)) : void 0 !== n && (o[i] = n));
        return o
    }, oe.extend({
        expando: "jQuery" + ("1.12.4" + Math.random()).replace(/\D/g, ""),
        isReady: !0,
        error: function(e) {
            throw new Error(e)
        },
        noop: function() {},
        isFunction: function(e) {
            return "function" === oe.type(e)
        },
        isArray: Array.isArray || function(e) {
            return "array" === oe.type(e)
        },
        isWindow: function(e) {
            return null != e && e == e.window
        },
        isNumeric: function(e) {
            var t = e && e.toString();
            return !oe.isArray(e) && t - parseFloat(t) + 1 >= 0
        },
        isEmptyObject: function(e) {
            var t;
            for (t in e) return !1;
            return !0
        },
        isPlainObject: function(e) {
            var t;
            if (!e || "object" !== oe.type(e) || e.nodeType || oe.isWindow(e)) return !1;
            try {
                if (e.constructor && !se.call(e, "constructor") && !se.call(e.constructor.prototype, "isPrototypeOf")) return !1
            } catch (e) {
                return !1
            }
            if (!re.ownFirst)
                for (t in e) return se.call(e, t);
            for (t in e);
            return void 0 === t || se.call(e, t)
        },
        type: function(e) {
            return null == e ? e + "" : "object" == typeof e || "function" == typeof e ? ne[ie.call(e)] || "object" : typeof e
        },
        globalEval: function(t) {
            t && oe.trim(t) && (e.execScript || function(t) {
                e.eval.call(e, t)
            })(t)
        },
        camelCase: function(e) {
            return e.replace(le, "ms-").replace(ce, de)
        },
        nodeName: function(e, t) {
            return e.nodeName && e.nodeName.toLowerCase() === t.toLowerCase()
        },
        each: function(e, t) {
            var i, s = 0;
            if (n(e))
                for (i = e.length; s < i && !1 !== t.call(e[s], s, e[s]); s++);
            else
                for (s in e)
                    if (!1 === t.call(e[s], s, e[s])) break; return e
        },
        trim: function(e) {
            return null == e ? "" : (e + "").replace(ae, "")
        },
        makeArray: function(e, t) {
            var i = t || [];
            return null != e && (n(Object(e)) ? oe.merge(i, "string" == typeof e ? [e] : e) : ee.call(i, e)), i
        },
        inArray: function(e, t, n) {
            var i;
            if (t) {
                if (te) return te.call(t, e, n);
                for (i = t.length, n = n ? n < 0 ? Math.max(0, i + n) : n : 0; n < i; n++)
                    if (n in t && t[n] === e) return n
            }
            return -1
        },
        merge: function(e, t) {
            for (var n = +t.length, i = 0, s = e.length; i < n;) e[s++] = t[i++];
            if (n != n)
                for (; void 0 !== t[i];) e[s++] = t[i++];
            return e.length = s, e
        },
        grep: function(e, t, n) {
            for (var i = [], s = 0, r = e.length, o = !n; s < r; s++) !t(e[s], s) !== o && i.push(e[s]);
            return i
        },
        map: function(e, t, i) {
            var s, r, o = 0,
                a = [];
            if (n(e))
                for (s = e.length; o < s; o++) null != (r = t(e[o], o, i)) && a.push(r);
            else
                for (o in e) null != (r = t(e[o], o, i)) && a.push(r);
            return Z.apply([], a)
        },
        guid: 1,
        proxy: function(e, t) {
            var n, i, s;
            if ("string" == typeof t && (s = e[t], t = e, e = s), oe.isFunction(e)) return n = J.call(arguments, 2), i = function() {
                return e.apply(t || this, n.concat(J.call(arguments)))
            }, i.guid = e.guid = e.guid || oe.guid++, i
        },
        now: function() {
            return +new Date
        },
        support: re
    }), "function" == typeof Symbol && (oe.fn[Symbol.iterator] = G[Symbol.iterator]), oe.each("Boolean Number String Function Array Date RegExp Object Error Symbol".split(" "), function(e, t) {
        ne["[object " + t + "]"] = t.toLowerCase()
    });
    var ue = function(e) {
        function t(e, t, n, i) {
            var s, r, o, a, l, c, u, p, f = t && t.ownerDocument,
                m = t ? t.nodeType : 9;
            if (n = n || [], "string" != typeof e || !e || 1 !== m && 9 !== m && 11 !== m) return n;
            if (!i && ((t ? t.ownerDocument || t : L) !== P && E(t), t = t || P, M)) {
                if (11 !== m && (c = me.exec(e)))
                    if (s = c[1]) {
                        if (9 === m) {
                            if (!(o = t.getElementById(s))) return n;
                            if (o.id === s) return n.push(o), n
                        } else if (f && (o = f.getElementById(s)) && j(t, o) && o.id === s) return n.push(o), n
                    } else {
                        if (c[2]) return G.apply(n, t.getElementsByTagName(e)), n;
                        if ((s = c[3]) && y.getElementsByClassName && t.getElementsByClassName) return G.apply(n, t.getElementsByClassName(s)), n
                    }
                if (y.qsa && !Y[e + " "] && (!N || !N.test(e))) {
                    if (1 !== m) f = t, p = e;
                    else if ("object" !== t.nodeName.toLowerCase()) {
                        for ((a = t.getAttribute("id")) ? a = a.replace(ve, "\\$&") : t.setAttribute("id", a = H), r = (u = k(e)).length, l = de.test(a) ? "#" + a : "[id='" + a + "']"; r--;) u[r] = l + " " + h(u[r]);
                        p = u.join(","), f = ge.test(e) && d(t.parentNode) || t
                    }
                    if (p) try {
                        return G.apply(n, f.querySelectorAll(p)), n
                    } catch (e) {} finally {
                        a === H && t.removeAttribute("id")
                    }
                }
            }
            return $(e.replace(re, "$1"), t, n, i)
        }

        function n() {
            function e(n, i) {
                return t.push(n + " ") > b.cacheLength && delete e[t.shift()], e[n + " "] = i
            }
            var t = [];
            return e
        }

        function i(e) {
            return e[H] = !0, e
        }

        function s(e) {
            var t = P.createElement("div");
            try {
                return !!e(t)
            } catch (e) {
                return !1
            } finally {
                t.parentNode && t.parentNode.removeChild(t), t = null
            }
        }

        function r(e, t) {
            for (var n = e.split("|"), i = n.length; i--;) b.attrHandle[n[i]] = t
        }

        function o(e, t) {
            var n = t && e,
                i = n && 1 === e.nodeType && 1 === t.nodeType && (~t.sourceIndex || z) - (~e.sourceIndex || z);
            if (i) return i;
            if (n)
                for (; n = n.nextSibling;)
                    if (n === t) return -1;
            return e ? 1 : -1
        }

        function a(e) {
            return function(t) {
                return "input" === t.nodeName.toLowerCase() && t.type === e
            }
        }

        function l(e) {
            return function(t) {
                var n = t.nodeName.toLowerCase();
                return ("input" === n || "button" === n) && t.type === e
            }
        }

        function c(e) {
            return i(function(t) {
                return t = +t, i(function(n, i) {
                    for (var s, r = e([], n.length, t), o = r.length; o--;) n[s = r[o]] && (n[s] = !(i[s] = n[s]))
                })
            })
        }

        function d(e) {
            return e && void 0 !== e.getElementsByTagName && e
        }

        function u() {}

        function h(e) {
            for (var t = 0, n = e.length, i = ""; t < n; t++) i += e[t].value;
            return i
        }

        function p(e, t, n) {
            var i = t.dir,
                s = n && "parentNode" === i,
                r = R++;
            return t.first ? function(t, n, r) {
                for (; t = t[i];)
                    if (1 === t.nodeType || s) return e(t, n, r)
            } : function(t, n, o) {
                var a, l, c, d = [F, r];
                if (o) {
                    for (; t = t[i];)
                        if ((1 === t.nodeType || s) && e(t, n, o)) return !0
                } else
                    for (; t = t[i];)
                        if (1 === t.nodeType || s) {
                            if (c = t[H] || (t[H] = {}), l = c[t.uniqueID] || (c[t.uniqueID] = {}), (a = l[i]) && a[0] === F && a[1] === r) return d[2] = a[2];
                            if (l[i] = d, d[2] = e(t, n, o)) return !0
                        }
            }
        }

        function f(e) {
            return e.length > 1 ? function(t, n, i) {
                for (var s = e.length; s--;)
                    if (!e[s](t, n, i)) return !1;
                return !0
            } : e[0]
        }

        function m(e, t, n, i, s) {
            for (var r, o = [], a = 0, l = e.length, c = null != t; a < l; a++)(r = e[a]) && (n && !n(r, i, s) || (o.push(r), c && t.push(a)));
            return o
        }

        function g(e, n, s, r, o, a) {
            return r && !r[H] && (r = g(r)), o && !o[H] && (o = g(o, a)), i(function(i, a, l, c) {
                var d, u, h, p = [],
                    f = [],
                    g = a.length,
                    v = i || function(e, n, i) {
                        for (var s = 0, r = n.length; s < r; s++) t(e, n[s], i);
                        return i
                    }(n || "*", l.nodeType ? [l] : l, []),
                    _ = !e || !i && n ? v : m(v, p, e, l, c),
                    y = s ? o || (i ? e : g || r) ? [] : a : _;
                if (s && s(_, y, l, c), r)
                    for (d = m(y, f), r(d, [], l, c), u = d.length; u--;)(h = d[u]) && (y[f[u]] = !(_[f[u]] = h));
                if (i) {
                    if (o || e) {
                        if (o) {
                            for (d = [], u = y.length; u--;)(h = y[u]) && d.push(_[u] = h);
                            o(null, y = [], d, c)
                        }
                        for (u = y.length; u--;)(h = y[u]) && (d = o ? J(i, h) : p[u]) > -1 && (i[d] = !(a[d] = h))
                    }
                } else y = m(y === a ? y.splice(g, y.length) : y), o ? o(null, a, y, c) : G.apply(a, y)
            })
        }

        function v(e) {
            for (var t, n, i, s = e.length, r = b.relative[e[0].type], o = r || b.relative[" "], a = r ? 1 : 0, l = p(function(e) {
                    return e === t
                }, o, !0), c = p(function(e) {
                    return J(t, e) > -1
                }, o, !0), d = [function(e, n, i) {
                    var s = !r && (i || n !== S) || ((t = n).nodeType ? l(e, n, i) : c(e, n, i));
                    return t = null, s
                }]; a < s; a++)
                if (n = b.relative[e[a].type]) d = [p(f(d), n)];
                else {
                    if ((n = b.filter[e[a].type].apply(null, e[a].matches))[H]) {
                        for (i = ++a; i < s && !b.relative[e[i].type]; i++);
                        return g(a > 1 && f(d), a > 1 && h(e.slice(0, a - 1).concat({
                            value: " " === e[a - 2].type ? "*" : ""
                        })).replace(re, "$1"), n, a < i && v(e.slice(a, i)), i < s && v(e = e.slice(i)), i < s && h(e))
                    }
                    d.push(n)
                }
            return f(d)
        }
        var _, y, b, w, x, k, C, $, S, T, D, E, P, O, M, N, I, A, j, H = "sizzle" + 1 * new Date,
            L = e.document,
            F = 0,
            R = 0,
            B = n(),
            q = n(),
            Y = n(),
            W = function(e, t) {
                return e === t && (D = !0), 0
            },
            z = 1 << 31,
            U = {}.hasOwnProperty,
            V = [],
            X = V.pop,
            Q = V.push,
            G = V.push,
            K = V.slice,
            J = function(e, t) {
                for (var n = 0, i = e.length; n < i; n++)
                    if (e[n] === t) return n;
                return -1
            },
            Z = "checked|selected|async|autofocus|autoplay|controls|defer|disabled|hidden|ismap|loop|multiple|open|readonly|required|scoped",
            ee = "[\\x20\\t\\r\\n\\f]",
            te = "(?:\\\\.|[\\w-]|[^\\x00-\\xa0])+",
            ne = "\\[" + ee + "*(" + te + ")(?:" + ee + "*([*^$|!~]?=)" + ee + "*(?:'((?:\\\\.|[^\\\\'])*)'|\"((?:\\\\.|[^\\\\\"])*)\"|(" + te + "))|)" + ee + "*\\]",
            ie = ":(" + te + ")(?:\\((('((?:\\\\.|[^\\\\'])*)'|\"((?:\\\\.|[^\\\\\"])*)\")|((?:\\\\.|[^\\\\()[\\]]|" + ne + ")*)|.*)\\)|)",
            se = new RegExp(ee + "+", "g"),
            re = new RegExp("^" + ee + "+|((?:^|[^\\\\])(?:\\\\.)*)" + ee + "+$", "g"),
            oe = new RegExp("^" + ee + "*," + ee + "*"),
            ae = new RegExp("^" + ee + "*([>+~]|" + ee + ")" + ee + "*"),
            le = new RegExp("=" + ee + "*([^\\]'\"]*?)" + ee + "*\\]", "g"),
            ce = new RegExp(ie),
            de = new RegExp("^" + te + "$"),
            ue = {
                ID: new RegExp("^#(" + te + ")"),
                CLASS: new RegExp("^\\.(" + te + ")"),
                TAG: new RegExp("^(" + te + "|[*])"),
                ATTR: new RegExp("^" + ne),
                PSEUDO: new RegExp("^" + ie),
                CHILD: new RegExp("^:(only|first|last|nth|nth-last)-(child|of-type)(?:\\(" + ee + "*(even|odd|(([+-]|)(\\d*)n|)" + ee + "*(?:([+-]|)" + ee + "*(\\d+)|))" + ee + "*\\)|)", "i"),
                bool: new RegExp("^(?:" + Z + ")$", "i"),
                needsContext: new RegExp("^" + ee + "*[>+~]|:(even|odd|eq|gt|lt|nth|first|last)(?:\\(" + ee + "*((?:-\\d)?\\d*)" + ee + "*\\)|)(?=[^-]|$)", "i")
            },
            he = /^(?:input|select|textarea|button)$/i,
            pe = /^h\d$/i,
            fe = /^[^{]+\{\s*\[native \w/,
            me = /^(?:#([\w-]+)|(\w+)|\.([\w-]+))$/,
            ge = /[+~]/,
            ve = /'|\\/g,
            _e = new RegExp("\\\\([\\da-f]{1,6}" + ee + "?|(" + ee + ")|.)", "ig"),
            ye = function(e, t, n) {
                var i = "0x" + t - 65536;
                return i != i || n ? t : i < 0 ? String.fromCharCode(i + 65536) : String.fromCharCode(i >> 10 | 55296, 1023 & i | 56320)
            },
            be = function() {
                E()
            };
        try {
            G.apply(V = K.call(L.childNodes), L.childNodes), V[L.childNodes.length].nodeType
        } catch (e) {
            G = {
                apply: V.length ? function(e, t) {
                    Q.apply(e, K.call(t))
                } : function(e, t) {
                    for (var n = e.length, i = 0; e[n++] = t[i++];);
                    e.length = n - 1
                }
            }
        }
        y = t.support = {}, x = t.isXML = function(e) {
            var t = e && (e.ownerDocument || e).documentElement;
            return !!t && "HTML" !== t.nodeName
        }, E = t.setDocument = function(e) {
            var t, n, i = e ? e.ownerDocument || e : L;
            return i !== P && 9 === i.nodeType && i.documentElement ? (P = i, O = P.documentElement, M = !x(P), (n = P.defaultView) && n.top !== n && (n.addEventListener ? n.addEventListener("unload", be, !1) : n.attachEvent && n.attachEvent("onunload", be)), y.attributes = s(function(e) {
                return e.className = "i", !e.getAttribute("className")
            }), y.getElementsByTagName = s(function(e) {
                return e.appendChild(P.createComment("")), !e.getElementsByTagName("*").length
            }), y.getElementsByClassName = fe.test(P.getElementsByClassName), y.getById = s(function(e) {
                return O.appendChild(e).id = H, !P.getElementsByName || !P.getElementsByName(H).length
            }), y.getById ? (b.find.ID = function(e, t) {
                if (void 0 !== t.getElementById && M) {
                    var n = t.getElementById(e);
                    return n ? [n] : []
                }
            }, b.filter.ID = function(e) {
                var t = e.replace(_e, ye);
                return function(e) {
                    return e.getAttribute("id") === t
                }
            }) : (delete b.find.ID, b.filter.ID = function(e) {
                var t = e.replace(_e, ye);
                return function(e) {
                    var n = void 0 !== e.getAttributeNode && e.getAttributeNode("id");
                    return n && n.value === t
                }
            }), b.find.TAG = y.getElementsByTagName ? function(e, t) {
                return void 0 !== t.getElementsByTagName ? t.getElementsByTagName(e) : y.qsa ? t.querySelectorAll(e) : void 0
            } : function(e, t) {
                var n, i = [],
                    s = 0,
                    r = t.getElementsByTagName(e);
                if ("*" === e) {
                    for (; n = r[s++];) 1 === n.nodeType && i.push(n);
                    return i
                }
                return r
            }, b.find.CLASS = y.getElementsByClassName && function(e, t) {
                if (void 0 !== t.getElementsByClassName && M) return t.getElementsByClassName(e)
            }, I = [], N = [], (y.qsa = fe.test(P.querySelectorAll)) && (s(function(e) {
                O.appendChild(e).innerHTML = "<a id='" + H + "'></a><select id='" + H + "-\r\\' msallowcapture=''><option selected=''></option></select>", e.querySelectorAll("[msallowcapture^='']").length && N.push("[*^$]=" + ee + "*(?:''|\"\")"), e.querySelectorAll("[selected]").length || N.push("\\[" + ee + "*(?:value|" + Z + ")"), e.querySelectorAll("[id~=" + H + "-]").length || N.push("~="), e.querySelectorAll(":checked").length || N.push(":checked"), e.querySelectorAll("a#" + H + "+*").length || N.push(".#.+[+~]")
            }), s(function(e) {
                var t = P.createElement("input");
                t.setAttribute("type", "hidden"), e.appendChild(t).setAttribute("name", "D"), e.querySelectorAll("[name=d]").length && N.push("name" + ee + "*[*^$|!~]?="), e.querySelectorAll(":enabled").length || N.push(":enabled", ":disabled"), e.querySelectorAll("*,:x"), N.push(",.*:")
            })), (y.matchesSelector = fe.test(A = O.matches || O.webkitMatchesSelector || O.mozMatchesSelector || O.oMatchesSelector || O.msMatchesSelector)) && s(function(e) {
                y.disconnectedMatch = A.call(e, "div"), A.call(e, "[s!='']:x"), I.push("!=", ie)
            }), N = N.length && new RegExp(N.join("|")), I = I.length && new RegExp(I.join("|")), t = fe.test(O.compareDocumentPosition), j = t || fe.test(O.contains) ? function(e, t) {
                var n = 9 === e.nodeType ? e.documentElement : e,
                    i = t && t.parentNode;
                return e === i || !(!i || 1 !== i.nodeType || !(n.contains ? n.contains(i) : e.compareDocumentPosition && 16 & e.compareDocumentPosition(i)))
            } : function(e, t) {
                if (t)
                    for (; t = t.parentNode;)
                        if (t === e) return !0;
                return !1
            }, W = t ? function(e, t) {
                if (e === t) return D = !0, 0;
                var n = !e.compareDocumentPosition - !t.compareDocumentPosition;
                return n || (1 & (n = (e.ownerDocument || e) === (t.ownerDocument || t) ? e.compareDocumentPosition(t) : 1) || !y.sortDetached && t.compareDocumentPosition(e) === n ? e === P || e.ownerDocument === L && j(L, e) ? -1 : t === P || t.ownerDocument === L && j(L, t) ? 1 : T ? J(T, e) - J(T, t) : 0 : 4 & n ? -1 : 1)
            } : function(e, t) {
                if (e === t) return D = !0, 0;
                var n, i = 0,
                    s = e.parentNode,
                    r = t.parentNode,
                    a = [e],
                    l = [t];
                if (!s || !r) return e === P ? -1 : t === P ? 1 : s ? -1 : r ? 1 : T ? J(T, e) - J(T, t) : 0;
                if (s === r) return o(e, t);
                for (n = e; n = n.parentNode;) a.unshift(n);
                for (n = t; n = n.parentNode;) l.unshift(n);
                for (; a[i] === l[i];) i++;
                return i ? o(a[i], l[i]) : a[i] === L ? -1 : l[i] === L ? 1 : 0
            }, P) : P
        }, t.matches = function(e, n) {
            return t(e, null, null, n)
        }, t.matchesSelector = function(e, n) {
            if ((e.ownerDocument || e) !== P && E(e), n = n.replace(le, "='$1']"), y.matchesSelector && M && !Y[n + " "] && (!I || !I.test(n)) && (!N || !N.test(n))) try {
                var i = A.call(e, n);
                if (i || y.disconnectedMatch || e.document && 11 !== e.document.nodeType) return i
            } catch (e) {}
            return t(n, P, null, [e]).length > 0
        }, t.contains = function(e, t) {
            return (e.ownerDocument || e) !== P && E(e), j(e, t)
        }, t.attr = function(e, t) {
            (e.ownerDocument || e) !== P && E(e);
            var n = b.attrHandle[t.toLowerCase()],
                i = n && U.call(b.attrHandle, t.toLowerCase()) ? n(e, t, !M) : void 0;
            return void 0 !== i ? i : y.attributes || !M ? e.getAttribute(t) : (i = e.getAttributeNode(t)) && i.specified ? i.value : null
        }, t.error = function(e) {
            throw new Error("Syntax error, unrecognized expression: " + e)
        }, t.uniqueSort = function(e) {
            var t, n = [],
                i = 0,
                s = 0;
            if (D = !y.detectDuplicates, T = !y.sortStable && e.slice(0), e.sort(W), D) {
                for (; t = e[s++];) t === e[s] && (i = n.push(s));
                for (; i--;) e.splice(n[i], 1)
            }
            return T = null, e
        }, w = t.getText = function(e) {
            var t, n = "",
                i = 0,
                s = e.nodeType;
            if (s) {
                if (1 === s || 9 === s || 11 === s) {
                    if ("string" == typeof e.textContent) return e.textContent;
                    for (e = e.firstChild; e; e = e.nextSibling) n += w(e)
                } else if (3 === s || 4 === s) return e.nodeValue
            } else
                for (; t = e[i++];) n += w(t);
            return n
        }, (b = t.selectors = {
            cacheLength: 50,
            createPseudo: i,
            match: ue,
            attrHandle: {},
            find: {},
            relative: {
                ">": {
                    dir: "parentNode",
                    first: !0
                },
                " ": {
                    dir: "parentNode"
                },
                "+": {
                    dir: "previousSibling",
                    first: !0
                },
                "~": {
                    dir: "previousSibling"
                }
            },
            preFilter: {
                ATTR: function(e) {
                    return e[1] = e[1].replace(_e, ye), e[3] = (e[3] || e[4] || e[5] || "").replace(_e, ye), "~=" === e[2] && (e[3] = " " + e[3] + " "), e.slice(0, 4)
                },
                CHILD: function(e) {
                    return e[1] = e[1].toLowerCase(), "nth" === e[1].slice(0, 3) ? (e[3] || t.error(e[0]), e[4] = +(e[4] ? e[5] + (e[6] || 1) : 2 * ("even" === e[3] || "odd" === e[3])), e[5] = +(e[7] + e[8] || "odd" === e[3])) : e[3] && t.error(e[0]), e
                },
                PSEUDO: function(e) {
                    var t, n = !e[6] && e[2];
                    return ue.CHILD.test(e[0]) ? null : (e[3] ? e[2] = e[4] || e[5] || "" : n && ce.test(n) && (t = k(n, !0)) && (t = n.indexOf(")", n.length - t) - n.length) && (e[0] = e[0].slice(0, t), e[2] = n.slice(0, t)), e.slice(0, 3))
                }
            },
            filter: {
                TAG: function(e) {
                    var t = e.replace(_e, ye).toLowerCase();
                    return "*" === e ? function() {
                        return !0
                    } : function(e) {
                        return e.nodeName && e.nodeName.toLowerCase() === t
                    }
                },
                CLASS: function(e) {
                    var t = B[e + " "];
                    return t || (t = new RegExp("(^|" + ee + ")" + e + "(" + ee + "|$)")) && B(e, function(e) {
                        return t.test("string" == typeof e.className && e.className || void 0 !== e.getAttribute && e.getAttribute("class") || "")
                    })
                },
                ATTR: function(e, n, i) {
                    return function(s) {
                        var r = t.attr(s, e);
                        return null == r ? "!=" === n : !n || (r += "", "=" === n ? r === i : "!=" === n ? r !== i : "^=" === n ? i && 0 === r.indexOf(i) : "*=" === n ? i && r.indexOf(i) > -1 : "$=" === n ? i && r.slice(-i.length) === i : "~=" === n ? (" " + r.replace(se, " ") + " ").indexOf(i) > -1 : "|=" === n && (r === i || r.slice(0, i.length + 1) === i + "-"))
                    }
                },
                CHILD: function(e, t, n, i, s) {
                    var r = "nth" !== e.slice(0, 3),
                        o = "last" !== e.slice(-4),
                        a = "of-type" === t;
                    return 1 === i && 0 === s ? function(e) {
                        return !!e.parentNode
                    } : function(t, n, l) {
                        var c, d, u, h, p, f, m = r !== o ? "nextSibling" : "previousSibling",
                            g = t.parentNode,
                            v = a && t.nodeName.toLowerCase(),
                            _ = !l && !a,
                            y = !1;
                        if (g) {
                            if (r) {
                                for (; m;) {
                                    for (h = t; h = h[m];)
                                        if (a ? h.nodeName.toLowerCase() === v : 1 === h.nodeType) return !1;
                                    f = m = "only" === e && !f && "nextSibling"
                                }
                                return !0
                            }
                            if (f = [o ? g.firstChild : g.lastChild], o && _) {
                                for (y = (p = (c = (d = (u = (h = g)[H] || (h[H] = {}))[h.uniqueID] || (u[h.uniqueID] = {}))[e] || [])[0] === F && c[1]) && c[2], h = p && g.childNodes[p]; h = ++p && h && h[m] || (y = p = 0) || f.pop();)
                                    if (1 === h.nodeType && ++y && h === t) {
                                        d[e] = [F, p, y];
                                        break
                                    }
                            } else if (_ && (y = p = (c = (d = (u = (h = t)[H] || (h[H] = {}))[h.uniqueID] || (u[h.uniqueID] = {}))[e] || [])[0] === F && c[1]), !1 === y)
                                for (;
                                    (h = ++p && h && h[m] || (y = p = 0) || f.pop()) && ((a ? h.nodeName.toLowerCase() !== v : 1 !== h.nodeType) || !++y || (_ && ((d = (u = h[H] || (h[H] = {}))[h.uniqueID] || (u[h.uniqueID] = {}))[e] = [F, y]), h !== t)););
                            return (y -= s) === i || y % i == 0 && y / i >= 0
                        }
                    }
                },
                PSEUDO: function(e, n) {
                    var s, r = b.pseudos[e] || b.setFilters[e.toLowerCase()] || t.error("unsupported pseudo: " + e);
                    return r[H] ? r(n) : r.length > 1 ? (s = [e, e, "", n], b.setFilters.hasOwnProperty(e.toLowerCase()) ? i(function(e, t) {
                        for (var i, s = r(e, n), o = s.length; o--;) e[i = J(e, s[o])] = !(t[i] = s[o])
                    }) : function(e) {
                        return r(e, 0, s)
                    }) : r
                }
            },
            pseudos: {
                not: i(function(e) {
                    var t = [],
                        n = [],
                        s = C(e.replace(re, "$1"));
                    return s[H] ? i(function(e, t, n, i) {
                        for (var r, o = s(e, null, i, []), a = e.length; a--;)(r = o[a]) && (e[a] = !(t[a] = r))
                    }) : function(e, i, r) {
                        return t[0] = e, s(t, null, r, n), t[0] = null, !n.pop()
                    }
                }),
                has: i(function(e) {
                    return function(n) {
                        return t(e, n).length > 0
                    }
                }),
                contains: i(function(e) {
                    return e = e.replace(_e, ye),
                        function(t) {
                            return (t.textContent || t.innerText || w(t)).indexOf(e) > -1
                        }
                }),
                lang: i(function(e) {
                    return de.test(e || "") || t.error("unsupported lang: " + e), e = e.replace(_e, ye).toLowerCase(),
                        function(t) {
                            var n;
                            do {
                                if (n = M ? t.lang : t.getAttribute("xml:lang") || t.getAttribute("lang")) return (n = n.toLowerCase()) === e || 0 === n.indexOf(e + "-")
                            } while ((t = t.parentNode) && 1 === t.nodeType);
                            return !1
                        }
                }),
                target: function(t) {
                    var n = e.location && e.location.hash;
                    return n && n.slice(1) === t.id
                },
                root: function(e) {
                    return e === O
                },
                focus: function(e) {
                    return e === P.activeElement && (!P.hasFocus || P.hasFocus()) && !!(e.type || e.href || ~e.tabIndex)
                },
                enabled: function(e) {
                    return !1 === e.disabled
                },
                disabled: function(e) {
                    return !0 === e.disabled
                },
                checked: function(e) {
                    var t = e.nodeName.toLowerCase();
                    return "input" === t && !!e.checked || "option" === t && !!e.selected
                },
                selected: function(e) {
                    return e.parentNode && e.parentNode.selectedIndex, !0 === e.selected
                },
                empty: function(e) {
                    for (e = e.firstChild; e; e = e.nextSibling)
                        if (e.nodeType < 6) return !1;
                    return !0
                },
                parent: function(e) {
                    return !b.pseudos.empty(e)
                },
                header: function(e) {
                    return pe.test(e.nodeName)
                },
                input: function(e) {
                    return he.test(e.nodeName)
                },
                button: function(e) {
                    var t = e.nodeName.toLowerCase();
                    return "input" === t && "button" === e.type || "button" === t
                },
                text: function(e) {
                    var t;
                    return "input" === e.nodeName.toLowerCase() && "text" === e.type && (null == (t = e.getAttribute("type")) || "text" === t.toLowerCase())
                },
                first: c(function() {
                    return [0]
                }),
                last: c(function(e, t) {
                    return [t - 1]
                }),
                eq: c(function(e, t, n) {
                    return [n < 0 ? n + t : n]
                }),
                even: c(function(e, t) {
                    for (var n = 0; n < t; n += 2) e.push(n);
                    return e
                }),
                odd: c(function(e, t) {
                    for (var n = 1; n < t; n += 2) e.push(n);
                    return e
                }),
                lt: c(function(e, t, n) {
                    for (var i = n < 0 ? n + t : n; --i >= 0;) e.push(i);
                    return e
                }),
                gt: c(function(e, t, n) {
                    for (var i = n < 0 ? n + t : n; ++i < t;) e.push(i);
                    return e
                })
            }
        }).pseudos.nth = b.pseudos.eq;
        for (_ in {
                radio: !0,
                checkbox: !0,
                file: !0,
                password: !0,
                image: !0
            }) b.pseudos[_] = a(_);
        for (_ in {
                submit: !0,
                reset: !0
            }) b.pseudos[_] = l(_);
        return u.prototype = b.filters = b.pseudos, b.setFilters = new u, k = t.tokenize = function(e, n) {
            var i, s, r, o, a, l, c, d = q[e + " "];
            if (d) return n ? 0 : d.slice(0);
            for (a = e, l = [], c = b.preFilter; a;) {
                i && !(s = oe.exec(a)) || (s && (a = a.slice(s[0].length) || a), l.push(r = [])), i = !1, (s = ae.exec(a)) && (i = s.shift(), r.push({
                    value: i,
                    type: s[0].replace(re, " ")
                }), a = a.slice(i.length));
                for (o in b.filter) !(s = ue[o].exec(a)) || c[o] && !(s = c[o](s)) || (i = s.shift(), r.push({
                    value: i,
                    type: o,
                    matches: s
                }), a = a.slice(i.length));
                if (!i) break
            }
            return n ? a.length : a ? t.error(e) : q(e, l).slice(0)
        }, C = t.compile = function(e, n) {
            var s, r = [],
                o = [],
                a = Y[e + " "];
            if (!a) {
                for (n || (n = k(e)), s = n.length; s--;)(a = v(n[s]))[H] ? r.push(a) : o.push(a);
                (a = Y(e, function(e, n) {
                    var s = n.length > 0,
                        r = e.length > 0,
                        o = function(i, o, a, l, c) {
                            var d, u, h, p = 0,
                                f = "0",
                                g = i && [],
                                v = [],
                                _ = S,
                                y = i || r && b.find.TAG("*", c),
                                w = F += null == _ ? 1 : Math.random() || .1,
                                x = y.length;
                            for (c && (S = o === P || o || c); f !== x && null != (d = y[f]); f++) {
                                if (r && d) {
                                    for (u = 0, o || d.ownerDocument === P || (E(d), a = !M); h = e[u++];)
                                        if (h(d, o || P, a)) {
                                            l.push(d);
                                            break
                                        }
                                    c && (F = w)
                                }
                                s && ((d = !h && d) && p--, i && g.push(d))
                            }
                            if (p += f, s && f !== p) {
                                for (u = 0; h = n[u++];) h(g, v, o, a);
                                if (i) {
                                    if (p > 0)
                                        for (; f--;) g[f] || v[f] || (v[f] = X.call(l));
                                    v = m(v)
                                }
                                G.apply(l, v), c && !i && v.length > 0 && p + n.length > 1 && t.uniqueSort(l)
                            }
                            return c && (F = w, S = _), g
                        };
                    return s ? i(o) : o
                }(o, r))).selector = e
            }
            return a
        }, $ = t.select = function(e, t, n, i) {
            var s, r, o, a, l, c = "function" == typeof e && e,
                u = !i && k(e = c.selector || e);
            if (n = n || [], 1 === u.length) {
                if ((r = u[0] = u[0].slice(0)).length > 2 && "ID" === (o = r[0]).type && y.getById && 9 === t.nodeType && M && b.relative[r[1].type]) {
                    if (!(t = (b.find.ID(o.matches[0].replace(_e, ye), t) || [])[0])) return n;
                    c && (t = t.parentNode), e = e.slice(r.shift().value.length)
                }
                for (s = ue.needsContext.test(e) ? 0 : r.length; s-- && (o = r[s], !b.relative[a = o.type]);)
                    if ((l = b.find[a]) && (i = l(o.matches[0].replace(_e, ye), ge.test(r[0].type) && d(t.parentNode) || t))) {
                        if (r.splice(s, 1), !(e = i.length && h(r))) return G.apply(n, i), n;
                        break
                    }
            }
            return (c || C(e, u))(i, t, !M, n, !t || ge.test(e) && d(t.parentNode) || t), n
        }, y.sortStable = H.split("").sort(W).join("") === H, y.detectDuplicates = !!D, E(), y.sortDetached = s(function(e) {
            return 1 & e.compareDocumentPosition(P.createElement("div"))
        }), s(function(e) {
            return e.innerHTML = "<a href='#'></a>", "#" === e.firstChild.getAttribute("href")
        }) || r("type|href|height|width", function(e, t, n) {
            if (!n) return e.getAttribute(t, "type" === t.toLowerCase() ? 1 : 2)
        }), y.attributes && s(function(e) {
            return e.innerHTML = "<input/>", e.firstChild.setAttribute("value", ""), "" === e.firstChild.getAttribute("value")
        }) || r("value", function(e, t, n) {
            if (!n && "input" === e.nodeName.toLowerCase()) return e.defaultValue
        }), s(function(e) {
            return null == e.getAttribute("disabled")
        }) || r(Z, function(e, t, n) {
            var i;
            if (!n) return !0 === e[t] ? t.toLowerCase() : (i = e.getAttributeNode(t)) && i.specified ? i.value : null
        }), t
    }(e);
    oe.find = ue, oe.expr = ue.selectors, oe.expr[":"] = oe.expr.pseudos, oe.uniqueSort = oe.unique = ue.uniqueSort, oe.text = ue.getText, oe.isXMLDoc = ue.isXML, oe.contains = ue.contains;
    var he = function(e, t, n) {
            for (var i = [], s = void 0 !== n;
                (e = e[t]) && 9 !== e.nodeType;)
                if (1 === e.nodeType) {
                    if (s && oe(e).is(n)) break;
                    i.push(e)
                }
            return i
        },
        pe = function(e, t) {
            for (var n = []; e; e = e.nextSibling) 1 === e.nodeType && e !== t && n.push(e);
            return n
        },
        fe = oe.expr.match.needsContext,
        me = /^<([\w-]+)\s*\/?>(?:<\/\1>|)$/,
        ge = /^.[^:#\[\.,]*$/;
    oe.filter = function(e, t, n) {
        var i = t[0];
        return n && (e = ":not(" + e + ")"), 1 === t.length && 1 === i.nodeType ? oe.find.matchesSelector(i, e) ? [i] : [] : oe.find.matches(e, oe.grep(t, function(e) {
            return 1 === e.nodeType
        }))
    }, oe.fn.extend({
        find: function(e) {
            var t, n = [],
                i = this,
                s = i.length;
            if ("string" != typeof e) return this.pushStack(oe(e).filter(function() {
                for (t = 0; t < s; t++)
                    if (oe.contains(i[t], this)) return !0
            }));
            for (t = 0; t < s; t++) oe.find(e, i[t], n);
            return n = this.pushStack(s > 1 ? oe.unique(n) : n), n.selector = this.selector ? this.selector + " " + e : e, n
        },
        filter: function(e) {
            return this.pushStack(i(this, e || [], !1))
        },
        not: function(e) {
            return this.pushStack(i(this, e || [], !0))
        },
        is: function(e) {
            return !!i(this, "string" == typeof e && fe.test(e) ? oe(e) : e || [], !1).length
        }
    });
    var ve, _e = /^(?:\s*(<[\w\W]+>)[^>]*|#([\w-]*))$/;
    (oe.fn.init = function(e, t, n) {
        var i, s;
        if (!e) return this;
        if (n = n || ve, "string" == typeof e) {
            if (!(i = "<" === e.charAt(0) && ">" === e.charAt(e.length - 1) && e.length >= 3 ? [null, e, null] : _e.exec(e)) || !i[1] && t) return !t || t.jquery ? (t || n).find(e) : this.constructor(t).find(e);
            if (i[1]) {
                if (t = t instanceof oe ? t[0] : t, oe.merge(this, oe.parseHTML(i[1], t && t.nodeType ? t.ownerDocument || t : K, !0)), me.test(i[1]) && oe.isPlainObject(t))
                    for (i in t) oe.isFunction(this[i]) ? this[i](t[i]) : this.attr(i, t[i]);
                return this
            }
            if ((s = K.getElementById(i[2])) && s.parentNode) {
                if (s.id !== i[2]) return ve.find(e);
                this.length = 1, this[0] = s
            }
            return this.context = K, this.selector = e, this
        }
        return e.nodeType ? (this.context = this[0] = e, this.length = 1, this) : oe.isFunction(e) ? void 0 !== n.ready ? n.ready(e) : e(oe) : (void 0 !== e.selector && (this.selector = e.selector, this.context = e.context), oe.makeArray(e, this))
    }).prototype = oe.fn, ve = oe(K);
    var ye = /^(?:parents|prev(?:Until|All))/,
        be = {
            children: !0,
            contents: !0,
            next: !0,
            prev: !0
        };
    oe.fn.extend({
        has: function(e) {
            var t, n = oe(e, this),
                i = n.length;
            return this.filter(function() {
                for (t = 0; t < i; t++)
                    if (oe.contains(this, n[t])) return !0
            })
        },
        closest: function(e, t) {
            for (var n, i = 0, s = this.length, r = [], o = fe.test(e) || "string" != typeof e ? oe(e, t || this.context) : 0; i < s; i++)
                for (n = this[i]; n && n !== t; n = n.parentNode)
                    if (n.nodeType < 11 && (o ? o.index(n) > -1 : 1 === n.nodeType && oe.find.matchesSelector(n, e))) {
                        r.push(n);
                        break
                    }
            return this.pushStack(r.length > 1 ? oe.uniqueSort(r) : r)
        },
        index: function(e) {
            return e ? "string" == typeof e ? oe.inArray(this[0], oe(e)) : oe.inArray(e.jquery ? e[0] : e, this) : this[0] && this[0].parentNode ? this.first().prevAll().length : -1
        },
        add: function(e, t) {
            return this.pushStack(oe.uniqueSort(oe.merge(this.get(), oe(e, t))))
        },
        addBack: function(e) {
            return this.add(null == e ? this.prevObject : this.prevObject.filter(e))
        }
    }), oe.each({
        parent: function(e) {
            var t = e.parentNode;
            return t && 11 !== t.nodeType ? t : null
        },
        parents: function(e) {
            return he(e, "parentNode")
        },
        parentsUntil: function(e, t, n) {
            return he(e, "parentNode", n)
        },
        next: function(e) {
            return s(e, "nextSibling")
        },
        prev: function(e) {
            return s(e, "previousSibling")
        },
        nextAll: function(e) {
            return he(e, "nextSibling")
        },
        prevAll: function(e) {
            return he(e, "previousSibling")
        },
        nextUntil: function(e, t, n) {
            return he(e, "nextSibling", n)
        },
        prevUntil: function(e, t, n) {
            return he(e, "previousSibling", n)
        },
        siblings: function(e) {
            return pe((e.parentNode || {}).firstChild, e)
        },
        children: function(e) {
            return pe(e.firstChild)
        },
        contents: function(e) {
            return oe.nodeName(e, "iframe") ? e.contentDocument || e.contentWindow.document : oe.merge([], e.childNodes)
        }
    }, function(e, t) {
        oe.fn[e] = function(n, i) {
            var s = oe.map(this, t, n);
            return "Until" !== e.slice(-5) && (i = n), i && "string" == typeof i && (s = oe.filter(i, s)), this.length > 1 && (be[e] || (s = oe.uniqueSort(s)), ye.test(e) && (s = s.reverse())), this.pushStack(s)
        }
    });
    var we = /\S+/g;
    oe.Callbacks = function(e) {
        e = "string" == typeof e ? function(e) {
            var t = {};
            return oe.each(e.match(we) || [], function(e, n) {
                t[n] = !0
            }), t
        }(e) : oe.extend({}, e);
        var t, n, i, s, r = [],
            o = [],
            a = -1,
            l = function() {
                for (s = e.once, i = t = !0; o.length; a = -1)
                    for (n = o.shift(); ++a < r.length;) !1 === r[a].apply(n[0], n[1]) && e.stopOnFalse && (a = r.length, n = !1);
                e.memory || (n = !1), t = !1, s && (r = n ? [] : "")
            },
            c = {
                add: function() {
                    return r && (n && !t && (a = r.length - 1, o.push(n)), function t(n) {
                        oe.each(n, function(n, i) {
                            oe.isFunction(i) ? e.unique && c.has(i) || r.push(i) : i && i.length && "string" !== oe.type(i) && t(i)
                        })
                    }(arguments), n && !t && l()), this
                },
                remove: function() {
                    return oe.each(arguments, function(e, t) {
                        for (var n;
                            (n = oe.inArray(t, r, n)) > -1;) r.splice(n, 1), n <= a && a--
                    }), this
                },
                has: function(e) {
                    return e ? oe.inArray(e, r) > -1 : r.length > 0
                },
                empty: function() {
                    return r && (r = []), this
                },
                disable: function() {
                    return s = o = [], r = n = "", this
                },
                disabled: function() {
                    return !r
                },
                lock: function() {
                    return s = !0, n || c.disable(), this
                },
                locked: function() {
                    return !!s
                },
                fireWith: function(e, n) {
                    return s || (n = [e, (n = n || []).slice ? n.slice() : n], o.push(n), t || l()), this
                },
                fire: function() {
                    return c.fireWith(this, arguments), this
                },
                fired: function() {
                    return !!i
                }
            };
        return c
    }, oe.extend({
        Deferred: function(e) {
            var t = [
                    ["resolve", "done", oe.Callbacks("once memory"), "resolved"],
                    ["reject", "fail", oe.Callbacks("once memory"), "rejected"],
                    ["notify", "progress", oe.Callbacks("memory")]
                ],
                n = "pending",
                i = {
                    state: function() {
                        return n
                    },
                    always: function() {
                        return s.done(arguments).fail(arguments), this
                    },
                    then: function() {
                        var e = arguments;
                        return oe.Deferred(function(n) {
                            oe.each(t, function(t, r) {
                                var o = oe.isFunction(e[t]) && e[t];
                                s[r[1]](function() {
                                    var e = o && o.apply(this, arguments);
                                    e && oe.isFunction(e.promise) ? e.promise().progress(n.notify).done(n.resolve).fail(n.reject) : n[r[0] + "With"](this === i ? n.promise() : this, o ? [e] : arguments)
                                })
                            }), e = null
                        }).promise()
                    },
                    promise: function(e) {
                        return null != e ? oe.extend(e, i) : i
                    }
                },
                s = {};
            return i.pipe = i.then, oe.each(t, function(e, r) {
                var o = r[2],
                    a = r[3];
                i[r[1]] = o.add, a && o.add(function() {
                    n = a
                }, t[1 ^ e][2].disable, t[2][2].lock), s[r[0]] = function() {
                    return s[r[0] + "With"](this === s ? i : this, arguments), this
                }, s[r[0] + "With"] = o.fireWith
            }), i.promise(s), e && e.call(s, s), s
        },
        when: function(e) {
            var t, n, i, s = 0,
                r = J.call(arguments),
                o = r.length,
                a = 1 !== o || e && oe.isFunction(e.promise) ? o : 0,
                l = 1 === a ? e : oe.Deferred(),
                c = function(e, n, i) {
                    return function(s) {
                        n[e] = this, i[e] = arguments.length > 1 ? J.call(arguments) : s, i === t ? l.notifyWith(n, i) : --a || l.resolveWith(n, i)
                    }
                };
            if (o > 1)
                for (t = new Array(o), n = new Array(o), i = new Array(o); s < o; s++) r[s] && oe.isFunction(r[s].promise) ? r[s].promise().progress(c(s, n, t)).done(c(s, i, r)).fail(l.reject) : --a;
            return a || l.resolveWith(i, r), l.promise()
        }
    });
    var xe;
    oe.fn.ready = function(e) {
        return oe.ready.promise().done(e), this
    }, oe.extend({
        isReady: !1,
        readyWait: 1,
        holdReady: function(e) {
            e ? oe.readyWait++ : oe.ready(!0)
        },
        ready: function(e) {
            (!0 === e ? --oe.readyWait : oe.isReady) || (oe.isReady = !0, !0 !== e && --oe.readyWait > 0 || (xe.resolveWith(K, [oe]), oe.fn.triggerHandler && (oe(K).triggerHandler("ready"), oe(K).off("ready"))))
        }
    }), oe.ready.promise = function(t) {
        if (!xe)
            if (xe = oe.Deferred(), "complete" === K.readyState || "loading" !== K.readyState && !K.documentElement.doScroll) e.setTimeout(oe.ready);
            else if (K.addEventListener) K.addEventListener("DOMContentLoaded", o), e.addEventListener("load", o);
        else {
            K.attachEvent("onreadystatechange", o), e.attachEvent("onload", o);
            var n = !1;
            try {
                n = null == e.frameElement && K.documentElement
            } catch (e) {}
            n && n.doScroll && function t() {
                if (!oe.isReady) {
                    try {
                        n.doScroll("left")
                    } catch (n) {
                        return e.setTimeout(t, 50)
                    }
                    r(), oe.ready()
                }
            }()
        }
        return xe.promise(t)
    }, oe.ready.promise();
    var ke;
    for (ke in oe(re)) break;
    re.ownFirst = "0" === ke, re.inlineBlockNeedsLayout = !1, oe(function() {
            var e, t, n, i;
            (n = K.getElementsByTagName("body")[0]) && n.style && (t = K.createElement("div"), (i = K.createElement("div")).style.cssText = "position:absolute;border:0;width:0;height:0;top:0;left:-9999px", n.appendChild(i).appendChild(t), void 0 !== t.style.zoom && (t.style.cssText = "display:inline;margin:0;border:0;padding:1px;width:1px;zoom:1", re.inlineBlockNeedsLayout = e = 3 === t.offsetWidth, e && (n.style.zoom = 1)), n.removeChild(i))
        }),
        function() {
            var e = K.createElement("div");
            re.deleteExpando = !0;
            try {
                delete e.test
            } catch (e) {
                re.deleteExpando = !1
            }
            e = null
        }();
    var Ce = function(e) {
            var t = oe.noData[(e.nodeName + " ").toLowerCase()],
                n = +e.nodeType || 1;
            return (1 === n || 9 === n) && (!t || !0 !== t && e.getAttribute("classid") === t)
        },
        $e = /^(?:\{[\w\W]*\}|\[[\w\W]*\])$/,
        Se = /([A-Z])/g;
    oe.extend({
            cache: {},
            noData: {
                "applet ": !0,
                "embed ": !0,
                "object ": "clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"
            },
            hasData: function(e) {
                return !!(e = e.nodeType ? oe.cache[e[oe.expando]] : e[oe.expando]) && !l(e)
            },
            data: function(e, t, n) {
                return c(e, t, n)
            },
            removeData: function(e, t) {
                return d(e, t)
            },
            _data: function(e, t, n) {
                return c(e, t, n, !0)
            },
            _removeData: function(e, t) {
                return d(e, t, !0)
            }
        }), oe.fn.extend({
            data: function(e, t) {
                var n, i, s, r = this[0],
                    o = r && r.attributes;
                if (void 0 === e) {
                    if (this.length && (s = oe.data(r), 1 === r.nodeType && !oe._data(r, "parsedAttrs"))) {
                        for (n = o.length; n--;) o[n] && 0 === (i = o[n].name).indexOf("data-") && a(r, i = oe.camelCase(i.slice(5)), s[i]);
                        oe._data(r, "parsedAttrs", !0)
                    }
                    return s
                }
                return "object" == typeof e ? this.each(function() {
                    oe.data(this, e)
                }) : arguments.length > 1 ? this.each(function() {
                    oe.data(this, e, t)
                }) : r ? a(r, e, oe.data(r, e)) : void 0
            },
            removeData: function(e) {
                return this.each(function() {
                    oe.removeData(this, e)
                })
            }
        }), oe.extend({
            queue: function(e, t, n) {
                var i;
                if (e) return t = (t || "fx") + "queue", i = oe._data(e, t), n && (!i || oe.isArray(n) ? i = oe._data(e, t, oe.makeArray(n)) : i.push(n)), i || []
            },
            dequeue: function(e, t) {
                t = t || "fx";
                var n = oe.queue(e, t),
                    i = n.length,
                    s = n.shift(),
                    r = oe._queueHooks(e, t);
                "inprogress" === s && (s = n.shift(), i--), s && ("fx" === t && n.unshift("inprogress"), delete r.stop, s.call(e, function() {
                    oe.dequeue(e, t)
                }, r)), !i && r && r.empty.fire()
            },
            _queueHooks: function(e, t) {
                var n = t + "queueHooks";
                return oe._data(e, n) || oe._data(e, n, {
                    empty: oe.Callbacks("once memory").add(function() {
                        oe._removeData(e, t + "queue"), oe._removeData(e, n)
                    })
                })
            }
        }), oe.fn.extend({
            queue: function(e, t) {
                var n = 2;
                return "string" != typeof e && (t = e, e = "fx", n--), arguments.length < n ? oe.queue(this[0], e) : void 0 === t ? this : this.each(function() {
                    var n = oe.queue(this, e, t);
                    oe._queueHooks(this, e), "fx" === e && "inprogress" !== n[0] && oe.dequeue(this, e)
                })
            },
            dequeue: function(e) {
                return this.each(function() {
                    oe.dequeue(this, e)
                })
            },
            clearQueue: function(e) {
                return this.queue(e || "fx", [])
            },
            promise: function(e, t) {
                var n, i = 1,
                    s = oe.Deferred(),
                    r = this,
                    o = this.length,
                    a = function() {
                        --i || s.resolveWith(r, [r])
                    };
                for ("string" != typeof e && (t = e, e = void 0), e = e || "fx"; o--;)(n = oe._data(r[o], e + "queueHooks")) && n.empty && (i++, n.empty.add(a));
                return a(), s.promise(t)
            }
        }),
        function() {
            var e;
            re.shrinkWrapBlocks = function() {
                if (null != e) return e;
                e = !1;
                var t, n, i;
                return (n = K.getElementsByTagName("body")[0]) && n.style ? (t = K.createElement("div"), i = K.createElement("div"), i.style.cssText = "position:absolute;border:0;width:0;height:0;top:0;left:-9999px", n.appendChild(i).appendChild(t), void 0 !== t.style.zoom && (t.style.cssText = "-webkit-box-sizing:content-box;-moz-box-sizing:content-box;box-sizing:content-box;display:block;margin:0;border:0;padding:1px;width:1px;zoom:1", t.appendChild(K.createElement("div")).style.width = "5px", e = 3 !== t.offsetWidth), n.removeChild(i), e) : void 0
            }
        }();
    var Te = /[+-]?(?:\d*\.|)\d+(?:[eE][+-]?\d+|)/.source,
        De = new RegExp("^(?:([+-])=|)(" + Te + ")([a-z%]*)$", "i"),
        Ee = ["Top", "Right", "Bottom", "Left"],
        Pe = function(e, t) {
            return e = t || e, "none" === oe.css(e, "display") || !oe.contains(e.ownerDocument, e)
        },
        Oe = function(e, t, n, i, s, r, o) {
            var a = 0,
                l = e.length,
                c = null == n;
            if ("object" === oe.type(n)) {
                s = !0;
                for (a in n) Oe(e, t, a, n[a], !0, r, o)
            } else if (void 0 !== i && (s = !0, oe.isFunction(i) || (o = !0), c && (o ? (t.call(e, i), t = null) : (c = t, t = function(e, t, n) {
                    return c.call(oe(e), n)
                })), t))
                for (; a < l; a++) t(e[a], n, o ? i : i.call(e[a], a, t(e[a], n)));
            return s ? e : c ? t.call(e) : l ? t(e[0], n) : r
        },
        Me = /^(?:checkbox|radio)$/i,
        Ne = /<([\w:-]+)/,
        Ie = /^$|\/(?:java|ecma)script/i,
        Ae = /^\s+/,
        je = "abbr|article|aside|audio|bdi|canvas|data|datalist|details|dialog|figcaption|figure|footer|header|hgroup|main|mark|meter|nav|output|picture|progress|section|summary|template|time|video";
    ! function() {
        var e = K.createElement("div"),
            t = K.createDocumentFragment(),
            n = K.createElement("input");
        e.innerHTML = "  <link/><table></table><a href='/a'>a</a><input type='checkbox'/>", re.leadingWhitespace = 3 === e.firstChild.nodeType, re.tbody = !e.getElementsByTagName("tbody").length, re.htmlSerialize = !!e.getElementsByTagName("link").length, re.html5Clone = "<:nav></:nav>" !== K.createElement("nav").cloneNode(!0).outerHTML, n.type = "checkbox", n.checked = !0, t.appendChild(n), re.appendChecked = n.checked, e.innerHTML = "<textarea>x</textarea>", re.noCloneChecked = !!e.cloneNode(!0).lastChild.defaultValue, t.appendChild(e), (n = K.createElement("input")).setAttribute("type", "radio"), n.setAttribute("checked", "checked"), n.setAttribute("name", "t"), e.appendChild(n), re.checkClone = e.cloneNode(!0).cloneNode(!0).lastChild.checked, re.noCloneEvent = !!e.addEventListener, e[oe.expando] = 1, re.attributes = !e.getAttribute(oe.expando)
    }();
    var He = {
        option: [1, "<select multiple='multiple'>", "</select>"],
        legend: [1, "<fieldset>", "</fieldset>"],
        area: [1, "<map>", "</map>"],
        param: [1, "<object>", "</object>"],
        thead: [1, "<table>", "</table>"],
        tr: [2, "<table><tbody>", "</tbody></table>"],
        col: [2, "<table><tbody></tbody><colgroup>", "</colgroup></table>"],
        td: [3, "<table><tbody><tr>", "</tr></tbody></table>"],
        _default: re.htmlSerialize ? [0, "", ""] : [1, "X<div>", "</div>"]
    };
    He.optgroup = He.option, He.tbody = He.tfoot = He.colgroup = He.caption = He.thead, He.th = He.td;
    var Le = /<|&#?\w+;/,
        Fe = /<tbody/i;
    ! function() {
        var t, n, i = K.createElement("div");
        for (t in {
                submit: !0,
                change: !0,
                focusin: !0
            }) n = "on" + t, (re[t] = n in e) || (i.setAttribute(n, "t"), re[t] = !1 === i.attributes[n].expando);
        i = null
    }();
    var Re = /^(?:input|select|textarea)$/i,
        Be = /^key/,
        qe = /^(?:mouse|pointer|contextmenu|drag|drop)|click/,
        Ye = /^(?:focusinfocus|focusoutblur)$/,
        We = /^([^.]*)(?:\.(.+)|)/;
    oe.event = {
        global: {},
        add: function(e, t, n, i, s) {
            var r, o, a, l, c, d, u, h, p, f, m, g = oe._data(e);
            if (g) {
                for (n.handler && (n = (l = n).handler, s = l.selector), n.guid || (n.guid = oe.guid++), (o = g.events) || (o = g.events = {}), (d = g.handle) || ((d = g.handle = function(e) {
                        return void 0 === oe || e && oe.event.triggered === e.type ? void 0 : oe.event.dispatch.apply(d.elem, arguments)
                    }).elem = e), a = (t = (t || "").match(we) || [""]).length; a--;) p = m = (r = We.exec(t[a]) || [])[1], f = (r[2] || "").split(".").sort(), p && (c = oe.event.special[p] || {}, p = (s ? c.delegateType : c.bindType) || p, c = oe.event.special[p] || {}, u = oe.extend({
                    type: p,
                    origType: m,
                    data: i,
                    handler: n,
                    guid: n.guid,
                    selector: s,
                    needsContext: s && oe.expr.match.needsContext.test(s),
                    namespace: f.join(".")
                }, l), (h = o[p]) || ((h = o[p] = []).delegateCount = 0, c.setup && !1 !== c.setup.call(e, i, f, d) || (e.addEventListener ? e.addEventListener(p, d, !1) : e.attachEvent && e.attachEvent("on" + p, d))), c.add && (c.add.call(e, u), u.handler.guid || (u.handler.guid = n.guid)), s ? h.splice(h.delegateCount++, 0, u) : h.push(u), oe.event.global[p] = !0);
                e = null
            }
        },
        remove: function(e, t, n, i, s) {
            var r, o, a, l, c, d, u, h, p, f, m, g = oe.hasData(e) && oe._data(e);
            if (g && (d = g.events)) {
                for (c = (t = (t || "").match(we) || [""]).length; c--;)
                    if (a = We.exec(t[c]) || [], p = m = a[1], f = (a[2] || "").split(".").sort(), p) {
                        for (u = oe.event.special[p] || {}, h = d[p = (i ? u.delegateType : u.bindType) || p] || [], a = a[2] && new RegExp("(^|\\.)" + f.join("\\.(?:.*\\.|)") + "(\\.|$)"), l = r = h.length; r--;) o = h[r], !s && m !== o.origType || n && n.guid !== o.guid || a && !a.test(o.namespace) || i && i !== o.selector && ("**" !== i || !o.selector) || (h.splice(r, 1), o.selector && h.delegateCount--, u.remove && u.remove.call(e, o));
                        l && !h.length && (u.teardown && !1 !== u.teardown.call(e, f, g.handle) || oe.removeEvent(e, p, g.handle), delete d[p])
                    } else
                        for (p in d) oe.event.remove(e, p + t[c], n, i, !0);
                oe.isEmptyObject(d) && (delete g.handle, oe._removeData(e, "events"))
            }
        },
        trigger: function(t, n, i, s) {
            var r, o, a, l, c, d, u, h = [i || K],
                p = se.call(t, "type") ? t.type : t,
                f = se.call(t, "namespace") ? t.namespace.split(".") : [];
            if (a = d = i = i || K, 3 !== i.nodeType && 8 !== i.nodeType && !Ye.test(p + oe.event.triggered) && (p.indexOf(".") > -1 && (p = (f = p.split(".")).shift(), f.sort()), o = p.indexOf(":") < 0 && "on" + p, t = t[oe.expando] ? t : new oe.Event(p, "object" == typeof t && t), t.isTrigger = s ? 2 : 3, t.namespace = f.join("."), t.rnamespace = t.namespace ? new RegExp("(^|\\.)" + f.join("\\.(?:.*\\.|)") + "(\\.|$)") : null, t.result = void 0, t.target || (t.target = i), n = null == n ? [t] : oe.makeArray(n, [t]), c = oe.event.special[p] || {}, s || !c.trigger || !1 !== c.trigger.apply(i, n))) {
                if (!s && !c.noBubble && !oe.isWindow(i)) {
                    for (l = c.delegateType || p, Ye.test(l + p) || (a = a.parentNode); a; a = a.parentNode) h.push(a), d = a;
                    d === (i.ownerDocument || K) && h.push(d.defaultView || d.parentWindow || e)
                }
                for (u = 0;
                    (a = h[u++]) && !t.isPropagationStopped();) t.type = u > 1 ? l : c.bindType || p, (r = (oe._data(a, "events") || {})[t.type] && oe._data(a, "handle")) && r.apply(a, n), (r = o && a[o]) && r.apply && Ce(a) && (t.result = r.apply(a, n), !1 === t.result && t.preventDefault());
                if (t.type = p, !s && !t.isDefaultPrevented() && (!c._default || !1 === c._default.apply(h.pop(), n)) && Ce(i) && o && i[p] && !oe.isWindow(i)) {
                    (d = i[o]) && (i[o] = null), oe.event.triggered = p;
                    try {
                        i[p]()
                    } catch (e) {}
                    oe.event.triggered = void 0, d && (i[o] = d)
                }
                return t.result
            }
        },
        dispatch: function(e) {
            e = oe.event.fix(e);
            var t, n, i, s, r, o = [],
                a = J.call(arguments),
                l = (oe._data(this, "events") || {})[e.type] || [],
                c = oe.event.special[e.type] || {};
            if (a[0] = e, e.delegateTarget = this, !c.preDispatch || !1 !== c.preDispatch.call(this, e)) {
                for (o = oe.event.handlers.call(this, e, l), t = 0;
                    (s = o[t++]) && !e.isPropagationStopped();)
                    for (e.currentTarget = s.elem, n = 0;
                        (r = s.handlers[n++]) && !e.isImmediatePropagationStopped();) e.rnamespace && !e.rnamespace.test(r.namespace) || (e.handleObj = r, e.data = r.data, void 0 !== (i = ((oe.event.special[r.origType] || {}).handle || r.handler).apply(s.elem, a)) && !1 === (e.result = i) && (e.preventDefault(), e.stopPropagation()));
                return c.postDispatch && c.postDispatch.call(this, e), e.result
            }
        },
        handlers: function(e, t) {
            var n, i, s, r, o = [],
                a = t.delegateCount,
                l = e.target;
            if (a && l.nodeType && ("click" !== e.type || isNaN(e.button) || e.button < 1))
                for (; l != this; l = l.parentNode || this)
                    if (1 === l.nodeType && (!0 !== l.disabled || "click" !== e.type)) {
                        for (i = [], n = 0; n < a; n++) void 0 === i[s = (r = t[n]).selector + " "] && (i[s] = r.needsContext ? oe(s, this).index(l) > -1 : oe.find(s, this, null, [l]).length), i[s] && i.push(r);
                        i.length && o.push({
                            elem: l,
                            handlers: i
                        })
                    }
            return a < t.length && o.push({
                elem: this,
                handlers: t.slice(a)
            }), o
        },
        fix: function(e) {
            if (e[oe.expando]) return e;
            var t, n, i, s = e.type,
                r = e,
                o = this.fixHooks[s];
            for (o || (this.fixHooks[s] = o = qe.test(s) ? this.mouseHooks : Be.test(s) ? this.keyHooks : {}), i = o.props ? this.props.concat(o.props) : this.props, e = new oe.Event(r), t = i.length; t--;) e[n = i[t]] = r[n];
            return e.target || (e.target = r.srcElement || K), 3 === e.target.nodeType && (e.target = e.target.parentNode), e.metaKey = !!e.metaKey, o.filter ? o.filter(e, r) : e
        },
        props: "altKey bubbles cancelable ctrlKey currentTarget detail eventPhase metaKey relatedTarget shiftKey target timeStamp view which".split(" "),
        fixHooks: {},
        keyHooks: {
            props: "char charCode key keyCode".split(" "),
            filter: function(e, t) {
                return null == e.which && (e.which = null != t.charCode ? t.charCode : t.keyCode), e
            }
        },
        mouseHooks: {
            props: "button buttons clientX clientY fromElement offsetX offsetY pageX pageY screenX screenY toElement".split(" "),
            filter: function(e, t) {
                var n, i, s, r = t.button,
                    o = t.fromElement;
                return null == e.pageX && null != t.clientX && (s = (i = e.target.ownerDocument || K).documentElement, n = i.body, e.pageX = t.clientX + (s && s.scrollLeft || n && n.scrollLeft || 0) - (s && s.clientLeft || n && n.clientLeft || 0), e.pageY = t.clientY + (s && s.scrollTop || n && n.scrollTop || 0) - (s && s.clientTop || n && n.clientTop || 0)), !e.relatedTarget && o && (e.relatedTarget = o === e.target ? t.toElement : o), e.which || void 0 === r || (e.which = 1 & r ? 1 : 2 & r ? 3 : 4 & r ? 2 : 0), e
            }
        },
        special: {
            load: {
                noBubble: !0
            },
            focus: {
                trigger: function() {
                    if (this !== y() && this.focus) try {
                        return this.focus(), !1
                    } catch (e) {}
                },
                delegateType: "focusin"
            },
            blur: {
                trigger: function() {
                    if (this === y() && this.blur) return this.blur(), !1
                },
                delegateType: "focusout"
            },
            click: {
                trigger: function() {
                    if (oe.nodeName(this, "input") && "checkbox" === this.type && this.click) return this.click(), !1
                },
                _default: function(e) {
                    return oe.nodeName(e.target, "a")
                }
            },
            beforeunload: {
                postDispatch: function(e) {
                    void 0 !== e.result && e.originalEvent && (e.originalEvent.returnValue = e.result)
                }
            }
        },
        simulate: function(e, t, n) {
            var i = oe.extend(new oe.Event, n, {
                type: e,
                isSimulated: !0
            });
            oe.event.trigger(i, null, t), i.isDefaultPrevented() && n.preventDefault()
        }
    }, oe.removeEvent = K.removeEventListener ? function(e, t, n) {
        e.removeEventListener && e.removeEventListener(t, n)
    } : function(e, t, n) {
        var i = "on" + t;
        e.detachEvent && (void 0 === e[i] && (e[i] = null), e.detachEvent(i, n))
    }, oe.Event = function(e, t) {
        if (!(this instanceof oe.Event)) return new oe.Event(e, t);
        e && e.type ? (this.originalEvent = e, this.type = e.type, this.isDefaultPrevented = e.defaultPrevented || void 0 === e.defaultPrevented && !1 === e.returnValue ? v : _) : this.type = e, t && oe.extend(this, t), this.timeStamp = e && e.timeStamp || oe.now(), this[oe.expando] = !0
    }, oe.Event.prototype = {
        constructor: oe.Event,
        isDefaultPrevented: _,
        isPropagationStopped: _,
        isImmediatePropagationStopped: _,
        preventDefault: function() {
            var e = this.originalEvent;
            this.isDefaultPrevented = v, e && (e.preventDefault ? e.preventDefault() : e.returnValue = !1)
        },
        stopPropagation: function() {
            var e = this.originalEvent;
            this.isPropagationStopped = v, e && !this.isSimulated && (e.stopPropagation && e.stopPropagation(), e.cancelBubble = !0)
        },
        stopImmediatePropagation: function() {
            var e = this.originalEvent;
            this.isImmediatePropagationStopped = v, e && e.stopImmediatePropagation && e.stopImmediatePropagation(), this.stopPropagation()
        }
    }, oe.each({
        mouseenter: "mouseover",
        mouseleave: "mouseout",
        pointerenter: "pointerover",
        pointerleave: "pointerout"
    }, function(e, t) {
        oe.event.special[e] = {
            delegateType: t,
            bindType: t,
            handle: function(e) {
                var n, i = e.relatedTarget,
                    s = e.handleObj;
                return i && (i === this || oe.contains(this, i)) || (e.type = s.origType, n = s.handler.apply(this, arguments), e.type = t), n
            }
        }
    }), re.submit || (oe.event.special.submit = {
        setup: function() {
            if (oe.nodeName(this, "form")) return !1;
            oe.event.add(this, "click._submit keypress._submit", function(e) {
                var t = e.target,
                    n = oe.nodeName(t, "input") || oe.nodeName(t, "button") ? oe.prop(t, "form") : void 0;
                n && !oe._data(n, "submit") && (oe.event.add(n, "submit._submit", function(e) {
                    e._submitBubble = !0
                }), oe._data(n, "submit", !0))
            })
        },
        postDispatch: function(e) {
            e._submitBubble && (delete e._submitBubble, this.parentNode && !e.isTrigger && oe.event.simulate("submit", this.parentNode, e))
        },
        teardown: function() {
            if (oe.nodeName(this, "form")) return !1;
            oe.event.remove(this, "._submit")
        }
    }), re.change || (oe.event.special.change = {
        setup: function() {
            if (Re.test(this.nodeName)) return "checkbox" !== this.type && "radio" !== this.type || (oe.event.add(this, "propertychange._change", function(e) {
                "checked" === e.originalEvent.propertyName && (this._justChanged = !0)
            }), oe.event.add(this, "click._change", function(e) {
                this._justChanged && !e.isTrigger && (this._justChanged = !1), oe.event.simulate("change", this, e)
            })), !1;
            oe.event.add(this, "beforeactivate._change", function(e) {
                var t = e.target;
                Re.test(t.nodeName) && !oe._data(t, "change") && (oe.event.add(t, "change._change", function(e) {
                    !this.parentNode || e.isSimulated || e.isTrigger || oe.event.simulate("change", this.parentNode, e)
                }), oe._data(t, "change", !0))
            })
        },
        handle: function(e) {
            var t = e.target;
            if (this !== t || e.isSimulated || e.isTrigger || "radio" !== t.type && "checkbox" !== t.type) return e.handleObj.handler.apply(this, arguments)
        },
        teardown: function() {
            return oe.event.remove(this, "._change"), !Re.test(this.nodeName)
        }
    }), re.focusin || oe.each({
        focus: "focusin",
        blur: "focusout"
    }, function(e, t) {
        var n = function(e) {
            oe.event.simulate(t, e.target, oe.event.fix(e))
        };
        oe.event.special[t] = {
            setup: function() {
                var i = this.ownerDocument || this,
                    s = oe._data(i, t);
                s || i.addEventListener(e, n, !0), oe._data(i, t, (s || 0) + 1)
            },
            teardown: function() {
                var i = this.ownerDocument || this,
                    s = oe._data(i, t) - 1;
                s ? oe._data(i, t, s) : (i.removeEventListener(e, n, !0), oe._removeData(i, t))
            }
        }
    }), oe.fn.extend({
        on: function(e, t, n, i) {
            return b(this, e, t, n, i)
        },
        one: function(e, t, n, i) {
            return b(this, e, t, n, i, 1)
        },
        off: function(e, t, n) {
            var i, s;
            if (e && e.preventDefault && e.handleObj) return i = e.handleObj, oe(e.delegateTarget).off(i.namespace ? i.origType + "." + i.namespace : i.origType, i.selector, i.handler), this;
            if ("object" == typeof e) {
                for (s in e) this.off(s, t, e[s]);
                return this
            }
            return !1 !== t && "function" != typeof t || (n = t, t = void 0), !1 === n && (n = _), this.each(function() {
                oe.event.remove(this, e, n, t)
            })
        },
        trigger: function(e, t) {
            return this.each(function() {
                oe.event.trigger(e, t, this)
            })
        },
        triggerHandler: function(e, t) {
            var n = this[0];
            if (n) return oe.event.trigger(e, t, n, !0)
        }
    });
    var ze = / jQuery\d+="(?:null|\d+)"/g,
        Ue = new RegExp("<(?:" + je + ")[\\s/>]", "i"),
        Ve = /<(?!area|br|col|embed|hr|img|input|link|meta|param)(([\w:-]+)[^>]*)\/>/gi,
        Xe = /<script|<style|<link/i,
        Qe = /checked\s*(?:[^=]|=\s*.checked.)/i,
        Ge = /^true\/(.*)/,
        Ke = /^\s*<!(?:\[CDATA\[|--)|(?:\]\]|--)>\s*$/g,
        Je = h(K).appendChild(K.createElement("div"));
    oe.extend({
        htmlPrefilter: function(e) {
            return e.replace(Ve, "<$1></$2>")
        },
        clone: function(e, t, n) {
            var i, s, r, o, a, l = oe.contains(e.ownerDocument, e);
            if (re.html5Clone || oe.isXMLDoc(e) || !Ue.test("<" + e.nodeName + ">") ? r = e.cloneNode(!0) : (Je.innerHTML = e.outerHTML, Je.removeChild(r = Je.firstChild)), !(re.noCloneEvent && re.noCloneChecked || 1 !== e.nodeType && 11 !== e.nodeType || oe.isXMLDoc(e)))
                for (i = p(r), a = p(e), o = 0; null != (s = a[o]); ++o) i[o] && $(s, i[o]);
            if (t)
                if (n)
                    for (a = a || p(e), i = i || p(r), o = 0; null != (s = a[o]); o++) C(s, i[o]);
                else C(e, r);
            return (i = p(r, "script")).length > 0 && f(i, !l && p(e, "script")), i = a = s = null, r
        },
        cleanData: function(e, t) {
            for (var n, i, s, r, o = 0, a = oe.expando, l = oe.cache, c = re.attributes, d = oe.event.special; null != (n = e[o]); o++)
                if ((t || Ce(n)) && (s = n[a], r = s && l[s])) {
                    if (r.events)
                        for (i in r.events) d[i] ? oe.event.remove(n, i) : oe.removeEvent(n, i, r.handle);
                    l[s] && (delete l[s], c || void 0 === n.removeAttribute ? n[a] = void 0 : n.removeAttribute(a), G.push(s))
                }
        }
    }), oe.fn.extend({
        domManip: S,
        detach: function(e) {
            return T(this, e, !0)
        },
        remove: function(e) {
            return T(this, e)
        },
        text: function(e) {
            return Oe(this, function(e) {
                return void 0 === e ? oe.text(this) : this.empty().append((this[0] && this[0].ownerDocument || K).createTextNode(e))
            }, null, e, arguments.length)
        },
        append: function() {
            return S(this, arguments, function(e) {
                if (1 === this.nodeType || 11 === this.nodeType || 9 === this.nodeType) {
                    w(this, e).appendChild(e)
                }
            })
        },
        prepend: function() {
            return S(this, arguments, function(e) {
                if (1 === this.nodeType || 11 === this.nodeType || 9 === this.nodeType) {
                    var t = w(this, e);
                    t.insertBefore(e, t.firstChild)
                }
            })
        },
        before: function() {
            return S(this, arguments, function(e) {
                this.parentNode && this.parentNode.insertBefore(e, this)
            })
        },
        after: function() {
            return S(this, arguments, function(e) {
                this.parentNode && this.parentNode.insertBefore(e, this.nextSibling)
            })
        },
        empty: function() {
            for (var e, t = 0; null != (e = this[t]); t++) {
                for (1 === e.nodeType && oe.cleanData(p(e, !1)); e.firstChild;) e.removeChild(e.firstChild);
                e.options && oe.nodeName(e, "select") && (e.options.length = 0)
            }
            return this
        },
        clone: function(e, t) {
            return e = null != e && e, t = null == t ? e : t, this.map(function() {
                return oe.clone(this, e, t)
            })
        },
        html: function(e) {
            return Oe(this, function(e) {
                var t = this[0] || {},
                    n = 0,
                    i = this.length;
                if (void 0 === e) return 1 === t.nodeType ? t.innerHTML.replace(ze, "") : void 0;
                if ("string" == typeof e && !Xe.test(e) && (re.htmlSerialize || !Ue.test(e)) && (re.leadingWhitespace || !Ae.test(e)) && !He[(Ne.exec(e) || ["", ""])[1].toLowerCase()]) {
                    e = oe.htmlPrefilter(e);
                    try {
                        for (; n < i; n++) 1 === (t = this[n] || {}).nodeType && (oe.cleanData(p(t, !1)), t.innerHTML = e);
                        t = 0
                    } catch (e) {}
                }
                t && this.empty().append(e)
            }, null, e, arguments.length)
        },
        replaceWith: function() {
            var e = [];
            return S(this, arguments, function(t) {
                var n = this.parentNode;
                oe.inArray(this, e) < 0 && (oe.cleanData(p(this)), n && n.replaceChild(t, this))
            }, e)
        }
    }), oe.each({
        appendTo: "append",
        prependTo: "prepend",
        insertBefore: "before",
        insertAfter: "after",
        replaceAll: "replaceWith"
    }, function(e, t) {
        oe.fn[e] = function(e) {
            for (var n, i = 0, s = [], r = oe(e), o = r.length - 1; i <= o; i++) n = i === o ? this : this.clone(!0), oe(r[i])[t](n), ee.apply(s, n.get());
            return this.pushStack(s)
        }
    });
    var Ze, et = {
            HTML: "block",
            BODY: "block"
        },
        tt = /^margin/,
        nt = new RegExp("^(" + Te + ")(?!px)[a-z%]+$", "i"),
        it = function(e, t, n, i) {
            var s, r, o = {};
            for (r in t) o[r] = e.style[r], e.style[r] = t[r];
            s = n.apply(e, i || []);
            for (r in t) e.style[r] = o[r];
            return s
        },
        st = K.documentElement;
    ! function() {
        function t() {
            var t, d, u = K.documentElement;
            u.appendChild(l), c.style.cssText = "-webkit-box-sizing:border-box;box-sizing:border-box;position:relative;display:block;margin:auto;border:1px;padding:1px;top:1%;width:50%", n = s = a = !1, i = o = !0, e.getComputedStyle && (d = e.getComputedStyle(c), n = "1%" !== (d || {}).top, a = "2px" === (d || {}).marginLeft, s = "4px" === (d || {
                width: "4px"
            }).width, c.style.marginRight = "50%", i = "4px" === (d || {
                marginRight: "4px"
            }).marginRight, (t = c.appendChild(K.createElement("div"))).style.cssText = c.style.cssText = "-webkit-box-sizing:content-box;-moz-box-sizing:content-box;box-sizing:content-box;display:block;margin:0;border:0;padding:0", t.style.marginRight = t.style.width = "0", c.style.width = "1px", o = !parseFloat((e.getComputedStyle(t) || {}).marginRight), c.removeChild(t)), c.style.display = "none", (r = 0 === c.getClientRects().length) && (c.style.display = "", c.innerHTML = "<table><tr><td></td><td>t</td></tr></table>", c.childNodes[0].style.borderCollapse = "separate", (t = c.getElementsByTagName("td"))[0].style.cssText = "margin:0;border:0;padding:0;display:none", (r = 0 === t[0].offsetHeight) && (t[0].style.display = "", t[1].style.display = "none", r = 0 === t[0].offsetHeight)), u.removeChild(l)
        }
        var n, i, s, r, o, a, l = K.createElement("div"),
            c = K.createElement("div");
        c.style && (c.style.cssText = "float:left;opacity:.5", re.opacity = "0.5" === c.style.opacity, re.cssFloat = !!c.style.cssFloat, c.style.backgroundClip = "content-box", c.cloneNode(!0).style.backgroundClip = "", re.clearCloneStyle = "content-box" === c.style.backgroundClip, (l = K.createElement("div")).style.cssText = "border:0;width:8px;height:0;top:0;left:-9999px;padding:0;margin-top:1px;position:absolute", c.innerHTML = "", l.appendChild(c), re.boxSizing = "" === c.style.boxSizing || "" === c.style.MozBoxSizing || "" === c.style.WebkitBoxSizing, oe.extend(re, {
            reliableHiddenOffsets: function() {
                return null == n && t(), r
            },
            boxSizingReliable: function() {
                return null == n && t(), s
            },
            pixelMarginRight: function() {
                return null == n && t(), i
            },
            pixelPosition: function() {
                return null == n && t(), n
            },
            reliableMarginRight: function() {
                return null == n && t(), o
            },
            reliableMarginLeft: function() {
                return null == n && t(), a
            }
        }))
    }();
    var rt, ot, at = /^(top|right|bottom|left)$/;
    e.getComputedStyle ? (rt = function(t) {
        var n = t.ownerDocument.defaultView;
        return n && n.opener || (n = e), n.getComputedStyle(t)
    }, ot = function(e, t, n) {
        var i, s, r, o, a = e.style;
        return n = n || rt(e), "" !== (o = n ? n.getPropertyValue(t) || n[t] : void 0) && void 0 !== o || oe.contains(e.ownerDocument, e) || (o = oe.style(e, t)), n && !re.pixelMarginRight() && nt.test(o) && tt.test(t) && (i = a.width, s = a.minWidth, r = a.maxWidth, a.minWidth = a.maxWidth = a.width = o, o = n.width, a.width = i, a.minWidth = s, a.maxWidth = r), void 0 === o ? o : o + ""
    }) : st.currentStyle && (rt = function(e) {
        return e.currentStyle
    }, ot = function(e, t, n) {
        var i, s, r, o, a = e.style;
        return n = n || rt(e), null == (o = n ? n[t] : void 0) && a && a[t] && (o = a[t]), nt.test(o) && !at.test(t) && (i = a.left, (r = (s = e.runtimeStyle) && s.left) && (s.left = e.currentStyle.left), a.left = "fontSize" === t ? "1em" : o, o = a.pixelLeft + "px", a.left = i, r && (s.left = r)), void 0 === o ? o : o + "" || "auto"
    });
    var lt = /alpha\([^)]*\)/i,
        ct = /opacity\s*=\s*([^)]*)/i,
        dt = /^(none|table(?!-c[ea]).+)/,
        ut = new RegExp("^(" + Te + ")(.*)$", "i"),
        ht = {
            position: "absolute",
            visibility: "hidden",
            display: "block"
        },
        pt = {
            letterSpacing: "0",
            fontWeight: "400"
        },
        ft = ["Webkit", "O", "Moz", "ms"],
        mt = K.createElement("div").style;
    oe.extend({
        cssHooks: {
            opacity: {
                get: function(e, t) {
                    if (t) {
                        var n = ot(e, "opacity");
                        return "" === n ? "1" : n
                    }
                }
            }
        },
        cssNumber: {
            animationIterationCount: !0,
            columnCount: !0,
            fillOpacity: !0,
            flexGrow: !0,
            flexShrink: !0,
            fontWeight: !0,
            lineHeight: !0,
            opacity: !0,
            order: !0,
            orphans: !0,
            widows: !0,
            zIndex: !0,
            zoom: !0
        },
        cssProps: {
            float: re.cssFloat ? "cssFloat" : "styleFloat"
        },
        style: function(e, t, n, i) {
            if (e && 3 !== e.nodeType && 8 !== e.nodeType && e.style) {
                var s, r, o, a = oe.camelCase(t),
                    l = e.style;
                if (t = oe.cssProps[a] || (oe.cssProps[a] = O(a) || a), o = oe.cssHooks[t] || oe.cssHooks[a], void 0 === n) return o && "get" in o && void 0 !== (s = o.get(e, !1, i)) ? s : l[t];
                if ("string" == (r = typeof n) && (s = De.exec(n)) && s[1] && (n = u(e, t, s), r = "number"), null != n && n == n && ("number" === r && (n += s && s[3] || (oe.cssNumber[a] ? "" : "px")), re.clearCloneStyle || "" !== n || 0 !== t.indexOf("background") || (l[t] = "inherit"), !(o && "set" in o && void 0 === (n = o.set(e, n, i))))) try {
                    l[t] = n
                } catch (e) {}
            }
        },
        css: function(e, t, n, i) {
            var s, r, o, a = oe.camelCase(t);
            return t = oe.cssProps[a] || (oe.cssProps[a] = O(a) || a), (o = oe.cssHooks[t] || oe.cssHooks[a]) && "get" in o && (r = o.get(e, !0, n)), void 0 === r && (r = ot(e, t, i)), "normal" === r && t in pt && (r = pt[t]), "" === n || n ? (s = parseFloat(r), !0 === n || isFinite(s) ? s || 0 : r) : r
        }
    }), oe.each(["height", "width"], function(e, t) {
        oe.cssHooks[t] = {
            get: function(e, n, i) {
                if (n) return dt.test(oe.css(e, "display")) && 0 === e.offsetWidth ? it(e, ht, function() {
                    return A(e, t, i)
                }) : A(e, t, i)
            },
            set: function(e, n, i) {
                var s = i && rt(e);
                return N(0, n, i ? I(e, t, i, re.boxSizing && "border-box" === oe.css(e, "boxSizing", !1, s), s) : 0)
            }
        }
    }), re.opacity || (oe.cssHooks.opacity = {
        get: function(e, t) {
            return ct.test((t && e.currentStyle ? e.currentStyle.filter : e.style.filter) || "") ? .01 * parseFloat(RegExp.$1) + "" : t ? "1" : ""
        },
        set: function(e, t) {
            var n = e.style,
                i = e.currentStyle,
                s = oe.isNumeric(t) ? "alpha(opacity=" + 100 * t + ")" : "",
                r = i && i.filter || n.filter || "";
            n.zoom = 1, (t >= 1 || "" === t) && "" === oe.trim(r.replace(lt, "")) && n.removeAttribute && (n.removeAttribute("filter"), "" === t || i && !i.filter) || (n.filter = lt.test(r) ? r.replace(lt, s) : r + " " + s)
        }
    }), oe.cssHooks.marginRight = P(re.reliableMarginRight, function(e, t) {
        if (t) return it(e, {
            display: "inline-block"
        }, ot, [e, "marginRight"])
    }), oe.cssHooks.marginLeft = P(re.reliableMarginLeft, function(e, t) {
        if (t) return (parseFloat(ot(e, "marginLeft")) || (oe.contains(e.ownerDocument, e) ? e.getBoundingClientRect().left - it(e, {
            marginLeft: 0
        }, function() {
            return e.getBoundingClientRect().left
        }) : 0)) + "px"
    }), oe.each({
        margin: "",
        padding: "",
        border: "Width"
    }, function(e, t) {
        oe.cssHooks[e + t] = {
            expand: function(n) {
                for (var i = 0, s = {}, r = "string" == typeof n ? n.split(" ") : [n]; i < 4; i++) s[e + Ee[i] + t] = r[i] || r[i - 2] || r[0];
                return s
            }
        }, tt.test(e) || (oe.cssHooks[e + t].set = N)
    }), oe.fn.extend({
        css: function(e, t) {
            return Oe(this, function(e, t, n) {
                var i, s, r = {},
                    o = 0;
                if (oe.isArray(t)) {
                    for (i = rt(e), s = t.length; o < s; o++) r[t[o]] = oe.css(e, t[o], !1, i);
                    return r
                }
                return void 0 !== n ? oe.style(e, t, n) : oe.css(e, t)
            }, e, t, arguments.length > 1)
        },
        show: function() {
            return M(this, !0)
        },
        hide: function() {
            return M(this)
        },
        toggle: function(e) {
            return "boolean" == typeof e ? e ? this.show() : this.hide() : this.each(function() {
                Pe(this) ? oe(this).show() : oe(this).hide()
            })
        }
    }), oe.Tween = j, (j.prototype = {
        constructor: j,
        init: function(e, t, n, i, s, r) {
            this.elem = e, this.prop = n, this.easing = s || oe.easing._default, this.options = t, this.start = this.now = this.cur(), this.end = i, this.unit = r || (oe.cssNumber[n] ? "" : "px")
        },
        cur: function() {
            var e = j.propHooks[this.prop];
            return e && e.get ? e.get(this) : j.propHooks._default.get(this)
        },
        run: function(e) {
            var t, n = j.propHooks[this.prop];
            return this.options.duration ? this.pos = t = oe.easing[this.easing](e, this.options.duration * e, 0, 1, this.options.duration) : this.pos = t = e, this.now = (this.end - this.start) * t + this.start, this.options.step && this.options.step.call(this.elem, this.now, this), n && n.set ? n.set(this) : j.propHooks._default.set(this), this
        }
    }).init.prototype = j.prototype, (j.propHooks = {
        _default: {
            get: function(e) {
                var t;
                return 1 !== e.elem.nodeType || null != e.elem[e.prop] && null == e.elem.style[e.prop] ? e.elem[e.prop] : (t = oe.css(e.elem, e.prop, "")) && "auto" !== t ? t : 0
            },
            set: function(e) {
                oe.fx.step[e.prop] ? oe.fx.step[e.prop](e) : 1 !== e.elem.nodeType || null == e.elem.style[oe.cssProps[e.prop]] && !oe.cssHooks[e.prop] ? e.elem[e.prop] = e.now : oe.style(e.elem, e.prop, e.now + e.unit)
            }
        }
    }).scrollTop = j.propHooks.scrollLeft = {
        set: function(e) {
            e.elem.nodeType && e.elem.parentNode && (e.elem[e.prop] = e.now)
        }
    }, oe.easing = {
        linear: function(e) {
            return e
        },
        swing: function(e) {
            return .5 - Math.cos(e * Math.PI) / 2
        },
        _default: "swing"
    }, oe.fx = j.prototype.init, oe.fx.step = {};
    var gt, vt, _t = /^(?:toggle|show|hide)$/,
        yt = /queueHooks$/;
    oe.Animation = oe.extend(R, {
            tweeners: {
                "*": [function(e, t) {
                    var n = this.createTween(e, t);
                    return u(n.elem, e, De.exec(t), n), n
                }]
            },
            tweener: function(e, t) {
                oe.isFunction(e) ? (t = e, e = ["*"]) : e = e.match(we);
                for (var n, i = 0, s = e.length; i < s; i++) n = e[i], R.tweeners[n] = R.tweeners[n] || [], R.tweeners[n].unshift(t)
            },
            prefilters: [function(e, t, n) {
                var i, s, r, o, a, l, c, d = this,
                    u = {},
                    h = e.style,
                    p = e.nodeType && Pe(e),
                    f = oe._data(e, "fxshow");
                n.queue || (null == (a = oe._queueHooks(e, "fx")).unqueued && (a.unqueued = 0, l = a.empty.fire, a.empty.fire = function() {
                    a.unqueued || l()
                }), a.unqueued++, d.always(function() {
                    d.always(function() {
                        a.unqueued--, oe.queue(e, "fx").length || a.empty.fire()
                    })
                })), 1 === e.nodeType && ("height" in t || "width" in t) && (n.overflow = [h.overflow, h.overflowX, h.overflowY], "inline" === ("none" === (c = oe.css(e, "display")) ? oe._data(e, "olddisplay") || E(e.nodeName) : c) && "none" === oe.css(e, "float") && (re.inlineBlockNeedsLayout && "inline" !== E(e.nodeName) ? h.zoom = 1 : h.display = "inline-block")), n.overflow && (h.overflow = "hidden", re.shrinkWrapBlocks() || d.always(function() {
                    h.overflow = n.overflow[0], h.overflowX = n.overflow[1], h.overflowY = n.overflow[2]
                }));
                for (i in t)
                    if (s = t[i], _t.exec(s)) {
                        if (delete t[i], r = r || "toggle" === s, s === (p ? "hide" : "show")) {
                            if ("show" !== s || !f || void 0 === f[i]) continue;
                            p = !0
                        }
                        u[i] = f && f[i] || oe.style(e, i)
                    } else c = void 0;
                if (oe.isEmptyObject(u)) "inline" === ("none" === c ? E(e.nodeName) : c) && (h.display = c);
                else {
                    f ? "hidden" in f && (p = f.hidden) : f = oe._data(e, "fxshow", {}), r && (f.hidden = !p), p ? oe(e).show() : d.done(function() {
                        oe(e).hide()
                    }), d.done(function() {
                        var t;
                        oe._removeData(e, "fxshow");
                        for (t in u) oe.style(e, t, u[t])
                    });
                    for (i in u) o = F(p ? f[i] : 0, i, d), i in f || (f[i] = o.start, p && (o.end = o.start, o.start = "width" === i || "height" === i ? 1 : 0))
                }
            }],
            prefilter: function(e, t) {
                t ? R.prefilters.unshift(e) : R.prefilters.push(e)
            }
        }), oe.speed = function(e, t, n) {
            var i = e && "object" == typeof e ? oe.extend({}, e) : {
                complete: n || !n && t || oe.isFunction(e) && e,
                duration: e,
                easing: n && t || t && !oe.isFunction(t) && t
            };
            return i.duration = oe.fx.off ? 0 : "number" == typeof i.duration ? i.duration : i.duration in oe.fx.speeds ? oe.fx.speeds[i.duration] : oe.fx.speeds._default, null != i.queue && !0 !== i.queue || (i.queue = "fx"), i.old = i.complete, i.complete = function() {
                oe.isFunction(i.old) && i.old.call(this), i.queue && oe.dequeue(this, i.queue)
            }, i
        }, oe.fn.extend({
            fadeTo: function(e, t, n, i) {
                return this.filter(Pe).css("opacity", 0).show().end().animate({
                    opacity: t
                }, e, n, i)
            },
            animate: function(e, t, n, i) {
                var s = oe.isEmptyObject(e),
                    r = oe.speed(t, n, i),
                    o = function() {
                        var t = R(this, oe.extend({}, e), r);
                        (s || oe._data(this, "finish")) && t.stop(!0)
                    };
                return o.finish = o, s || !1 === r.queue ? this.each(o) : this.queue(r.queue, o)
            },
            stop: function(e, t, n) {
                var i = function(e) {
                    var t = e.stop;
                    delete e.stop, t(n)
                };
                return "string" != typeof e && (n = t, t = e, e = void 0), t && !1 !== e && this.queue(e || "fx", []), this.each(function() {
                    var t = !0,
                        s = null != e && e + "queueHooks",
                        r = oe.timers,
                        o = oe._data(this);
                    if (s) o[s] && o[s].stop && i(o[s]);
                    else
                        for (s in o) o[s] && o[s].stop && yt.test(s) && i(o[s]);
                    for (s = r.length; s--;) r[s].elem !== this || null != e && r[s].queue !== e || (r[s].anim.stop(n), t = !1, r.splice(s, 1));
                    !t && n || oe.dequeue(this, e)
                })
            },
            finish: function(e) {
                return !1 !== e && (e = e || "fx"), this.each(function() {
                    var t, n = oe._data(this),
                        i = n[e + "queue"],
                        s = n[e + "queueHooks"],
                        r = oe.timers,
                        o = i ? i.length : 0;
                    for (n.finish = !0, oe.queue(this, e, []), s && s.stop && s.stop.call(this, !0), t = r.length; t--;) r[t].elem === this && r[t].queue === e && (r[t].anim.stop(!0), r.splice(t, 1));
                    for (t = 0; t < o; t++) i[t] && i[t].finish && i[t].finish.call(this);
                    delete n.finish
                })
            }
        }), oe.each(["toggle", "show", "hide"], function(e, t) {
            var n = oe.fn[t];
            oe.fn[t] = function(e, i, s) {
                return null == e || "boolean" == typeof e ? n.apply(this, arguments) : this.animate(L(t, !0), e, i, s)
            }
        }), oe.each({
            slideDown: L("show"),
            slideUp: L("hide"),
            slideToggle: L("toggle"),
            fadeIn: {
                opacity: "show"
            },
            fadeOut: {
                opacity: "hide"
            },
            fadeToggle: {
                opacity: "toggle"
            }
        }, function(e, t) {
            oe.fn[e] = function(e, n, i) {
                return this.animate(t, e, n, i)
            }
        }), oe.timers = [], oe.fx.tick = function() {
            var e, t = oe.timers,
                n = 0;
            for (gt = oe.now(); n < t.length; n++)(e = t[n])() || t[n] !== e || t.splice(n--, 1);
            t.length || oe.fx.stop(), gt = void 0
        }, oe.fx.timer = function(e) {
            oe.timers.push(e), e() ? oe.fx.start() : oe.timers.pop()
        }, oe.fx.interval = 13, oe.fx.start = function() {
            vt || (vt = e.setInterval(oe.fx.tick, oe.fx.interval))
        }, oe.fx.stop = function() {
            e.clearInterval(vt), vt = null
        }, oe.fx.speeds = {
            slow: 600,
            fast: 200,
            _default: 400
        }, oe.fn.delay = function(t, n) {
            return t = oe.fx ? oe.fx.speeds[t] || t : t, n = n || "fx", this.queue(n, function(n, i) {
                var s = e.setTimeout(n, t);
                i.stop = function() {
                    e.clearTimeout(s)
                }
            })
        },
        function() {
            var e, t = K.createElement("input"),
                n = K.createElement("div"),
                i = K.createElement("select"),
                s = i.appendChild(K.createElement("option"));
            (n = K.createElement("div")).setAttribute("className", "t"), n.innerHTML = "  <link/><table></table><a href='/a'>a</a><input type='checkbox'/>", e = n.getElementsByTagName("a")[0], t.setAttribute("type", "checkbox"), n.appendChild(t), (e = n.getElementsByTagName("a")[0]).style.cssText = "top:1px", re.getSetAttribute = "t" !== n.className, re.style = /top/.test(e.getAttribute("style")), re.hrefNormalized = "/a" === e.getAttribute("href"), re.checkOn = !!t.value, re.optSelected = s.selected, re.enctype = !!K.createElement("form").enctype, i.disabled = !0, re.optDisabled = !s.disabled, (t = K.createElement("input")).setAttribute("value", ""), re.input = "" === t.getAttribute("value"), t.value = "t", t.setAttribute("type", "radio"), re.radioValue = "t" === t.value
        }();
    var bt = /\r/g,
        wt = /[\x20\t\r\n\f]+/g;
    oe.fn.extend({
        val: function(e) {
            var t, n, i, s = this[0]; {
                if (arguments.length) return i = oe.isFunction(e), this.each(function(n) {
                    var s;
                    1 === this.nodeType && (null == (s = i ? e.call(this, n, oe(this).val()) : e) ? s = "" : "number" == typeof s ? s += "" : oe.isArray(s) && (s = oe.map(s, function(e) {
                        return null == e ? "" : e + ""
                    })), (t = oe.valHooks[this.type] || oe.valHooks[this.nodeName.toLowerCase()]) && "set" in t && void 0 !== t.set(this, s, "value") || (this.value = s))
                });
                if (s) return (t = oe.valHooks[s.type] || oe.valHooks[s.nodeName.toLowerCase()]) && "get" in t && void 0 !== (n = t.get(s, "value")) ? n : "string" == typeof(n = s.value) ? n.replace(bt, "") : null == n ? "" : n
            }
        }
    }), oe.extend({
        valHooks: {
            option: {
                get: function(e) {
                    var t = oe.find.attr(e, "value");
                    return null != t ? t : oe.trim(oe.text(e)).replace(wt, " ")
                }
            },
            select: {
                get: function(e) {
                    for (var t, n, i = e.options, s = e.selectedIndex, r = "select-one" === e.type || s < 0, o = r ? null : [], a = r ? s + 1 : i.length, l = s < 0 ? a : r ? s : 0; l < a; l++)
                        if (((n = i[l]).selected || l === s) && (re.optDisabled ? !n.disabled : null === n.getAttribute("disabled")) && (!n.parentNode.disabled || !oe.nodeName(n.parentNode, "optgroup"))) {
                            if (t = oe(n).val(), r) return t;
                            o.push(t)
                        }
                    return o
                },
                set: function(e, t) {
                    for (var n, i, s = e.options, r = oe.makeArray(t), o = s.length; o--;)
                        if (i = s[o], oe.inArray(oe.valHooks.option.get(i), r) > -1) try {
                            i.selected = n = !0
                        } catch (e) {
                            i.scrollHeight
                        } else i.selected = !1;
                    return n || (e.selectedIndex = -1), s
                }
            }
        }
    }), oe.each(["radio", "checkbox"], function() {
        oe.valHooks[this] = {
            set: function(e, t) {
                if (oe.isArray(t)) return e.checked = oe.inArray(oe(e).val(), t) > -1
            }
        }, re.checkOn || (oe.valHooks[this].get = function(e) {
            return null === e.getAttribute("value") ? "on" : e.value
        })
    });
    var xt, kt, Ct = oe.expr.attrHandle,
        $t = /^(?:checked|selected)$/i,
        St = re.getSetAttribute,
        Tt = re.input;
    oe.fn.extend({
        attr: function(e, t) {
            return Oe(this, oe.attr, e, t, arguments.length > 1)
        },
        removeAttr: function(e) {
            return this.each(function() {
                oe.removeAttr(this, e)
            })
        }
    }), oe.extend({
        attr: function(e, t, n) {
            var i, s, r = e.nodeType;
            if (3 !== r && 8 !== r && 2 !== r) return void 0 === e.getAttribute ? oe.prop(e, t, n) : (1 === r && oe.isXMLDoc(e) || (t = t.toLowerCase(), s = oe.attrHooks[t] || (oe.expr.match.bool.test(t) ? kt : xt)), void 0 !== n ? null === n ? void oe.removeAttr(e, t) : s && "set" in s && void 0 !== (i = s.set(e, n, t)) ? i : (e.setAttribute(t, n + ""), n) : s && "get" in s && null !== (i = s.get(e, t)) ? i : null == (i = oe.find.attr(e, t)) ? void 0 : i)
        },
        attrHooks: {
            type: {
                set: function(e, t) {
                    if (!re.radioValue && "radio" === t && oe.nodeName(e, "input")) {
                        var n = e.value;
                        return e.setAttribute("type", t), n && (e.value = n), t
                    }
                }
            }
        },
        removeAttr: function(e, t) {
            var n, i, s = 0,
                r = t && t.match(we);
            if (r && 1 === e.nodeType)
                for (; n = r[s++];) i = oe.propFix[n] || n, oe.expr.match.bool.test(n) ? Tt && St || !$t.test(n) ? e[i] = !1 : e[oe.camelCase("default-" + n)] = e[i] = !1 : oe.attr(e, n, ""), e.removeAttribute(St ? n : i)
        }
    }), kt = {
        set: function(e, t, n) {
            return !1 === t ? oe.removeAttr(e, n) : Tt && St || !$t.test(n) ? e.setAttribute(!St && oe.propFix[n] || n, n) : e[oe.camelCase("default-" + n)] = e[n] = !0, n
        }
    }, oe.each(oe.expr.match.bool.source.match(/\w+/g), function(e, t) {
        var n = Ct[t] || oe.find.attr;
        Tt && St || !$t.test(t) ? Ct[t] = function(e, t, i) {
            var s, r;
            return i || (r = Ct[t], Ct[t] = s, s = null != n(e, t, i) ? t.toLowerCase() : null, Ct[t] = r), s
        } : Ct[t] = function(e, t, n) {
            if (!n) return e[oe.camelCase("default-" + t)] ? t.toLowerCase() : null
        }
    }), Tt && St || (oe.attrHooks.value = {
        set: function(e, t, n) {
            if (!oe.nodeName(e, "input")) return xt && xt.set(e, t, n);
            e.defaultValue = t
        }
    }), St || (xt = {
        set: function(e, t, n) {
            var i = e.getAttributeNode(n);
            if (i || e.setAttributeNode(i = e.ownerDocument.createAttribute(n)), i.value = t += "", "value" === n || t === e.getAttribute(n)) return t
        }
    }, Ct.id = Ct.name = Ct.coords = function(e, t, n) {
        var i;
        if (!n) return (i = e.getAttributeNode(t)) && "" !== i.value ? i.value : null
    }, oe.valHooks.button = {
        get: function(e, t) {
            var n = e.getAttributeNode(t);
            if (n && n.specified) return n.value
        },
        set: xt.set
    }, oe.attrHooks.contenteditable = {
        set: function(e, t, n) {
            xt.set(e, "" !== t && t, n)
        }
    }, oe.each(["width", "height"], function(e, t) {
        oe.attrHooks[t] = {
            set: function(e, n) {
                if ("" === n) return e.setAttribute(t, "auto"), n
            }
        }
    })), re.style || (oe.attrHooks.style = {
        get: function(e) {
            return e.style.cssText || void 0
        },
        set: function(e, t) {
            return e.style.cssText = t + ""
        }
    });
    var Dt = /^(?:input|select|textarea|button|object)$/i,
        Et = /^(?:a|area)$/i;
    oe.fn.extend({
        prop: function(e, t) {
            return Oe(this, oe.prop, e, t, arguments.length > 1)
        },
        removeProp: function(e) {
            return e = oe.propFix[e] || e, this.each(function() {
                try {
                    this[e] = void 0, delete this[e]
                } catch (e) {}
            })
        }
    }), oe.extend({
        prop: function(e, t, n) {
            var i, s, r = e.nodeType;
            if (3 !== r && 8 !== r && 2 !== r) return 1 === r && oe.isXMLDoc(e) || (t = oe.propFix[t] || t, s = oe.propHooks[t]), void 0 !== n ? s && "set" in s && void 0 !== (i = s.set(e, n, t)) ? i : e[t] = n : s && "get" in s && null !== (i = s.get(e, t)) ? i : e[t]
        },
        propHooks: {
            tabIndex: {
                get: function(e) {
                    var t = oe.find.attr(e, "tabindex");
                    return t ? parseInt(t, 10) : Dt.test(e.nodeName) || Et.test(e.nodeName) && e.href ? 0 : -1
                }
            }
        },
        propFix: {
            for: "htmlFor",
            class: "className"
        }
    }), re.hrefNormalized || oe.each(["href", "src"], function(e, t) {
        oe.propHooks[t] = {
            get: function(e) {
                return e.getAttribute(t, 4)
            }
        }
    }), re.optSelected || (oe.propHooks.selected = {
        get: function(e) {
            var t = e.parentNode;
            return t && (t.selectedIndex, t.parentNode && t.parentNode.selectedIndex), null
        },
        set: function(e) {
            var t = e.parentNode;
            t && (t.selectedIndex, t.parentNode && t.parentNode.selectedIndex)
        }
    }), oe.each(["tabIndex", "readOnly", "maxLength", "cellSpacing", "cellPadding", "rowSpan", "colSpan", "useMap", "frameBorder", "contentEditable"], function() {
        oe.propFix[this.toLowerCase()] = this
    }), re.enctype || (oe.propFix.enctype = "encoding");
    var Pt = /[\t\r\n\f]/g;
    oe.fn.extend({
        addClass: function(e) {
            var t, n, i, s, r, o, a, l = 0;
            if (oe.isFunction(e)) return this.each(function(t) {
                oe(this).addClass(e.call(this, t, B(this)))
            });
            if ("string" == typeof e && e)
                for (t = e.match(we) || []; n = this[l++];)
                    if (s = B(n), i = 1 === n.nodeType && (" " + s + " ").replace(Pt, " ")) {
                        for (o = 0; r = t[o++];) i.indexOf(" " + r + " ") < 0 && (i += r + " ");
                        s !== (a = oe.trim(i)) && oe.attr(n, "class", a)
                    }
            return this
        },
        removeClass: function(e) {
            var t, n, i, s, r, o, a, l = 0;
            if (oe.isFunction(e)) return this.each(function(t) {
                oe(this).removeClass(e.call(this, t, B(this)))
            });
            if (!arguments.length) return this.attr("class", "");
            if ("string" == typeof e && e)
                for (t = e.match(we) || []; n = this[l++];)
                    if (s = B(n), i = 1 === n.nodeType && (" " + s + " ").replace(Pt, " ")) {
                        for (o = 0; r = t[o++];)
                            for (; i.indexOf(" " + r + " ") > -1;) i = i.replace(" " + r + " ", " ");
                        s !== (a = oe.trim(i)) && oe.attr(n, "class", a)
                    }
            return this
        },
        toggleClass: function(e, t) {
            var n = typeof e;
            return "boolean" == typeof t && "string" === n ? t ? this.addClass(e) : this.removeClass(e) : oe.isFunction(e) ? this.each(function(n) {
                oe(this).toggleClass(e.call(this, n, B(this), t), t)
            }) : this.each(function() {
                var t, i, s, r;
                if ("string" === n)
                    for (i = 0, s = oe(this), r = e.match(we) || []; t = r[i++];) s.hasClass(t) ? s.removeClass(t) : s.addClass(t);
                else void 0 !== e && "boolean" !== n || ((t = B(this)) && oe._data(this, "__className__", t), oe.attr(this, "class", t || !1 === e ? "" : oe._data(this, "__className__") || ""))
            })
        },
        hasClass: function(e) {
            var t, n, i = 0;
            for (t = " " + e + " "; n = this[i++];)
                if (1 === n.nodeType && (" " + B(n) + " ").replace(Pt, " ").indexOf(t) > -1) return !0;
            return !1
        }
    }), oe.each("blur focus focusin focusout load resize scroll unload click dblclick mousedown mouseup mousemove mouseover mouseout mouseenter mouseleave change select submit keydown keypress keyup error contextmenu".split(" "), function(e, t) {
        oe.fn[t] = function(e, n) {
            return arguments.length > 0 ? this.on(t, null, e, n) : this.trigger(t)
        }
    }), oe.fn.extend({
        hover: function(e, t) {
            return this.mouseenter(e).mouseleave(t || e)
        }
    });
    var Ot = e.location,
        Mt = oe.now(),
        Nt = /\?/,
        It = /(,)|(\[|{)|(}|])|"(?:[^"\\\r\n]|\\["\\\/bfnrt]|\\u[\da-fA-F]{4})*"\s*:?|true|false|null|-?(?!0\d)\d+(?:\.\d+|)(?:[eE][+-]?\d+|)/g;
    oe.parseJSON = function(t) {
        if (e.JSON && e.JSON.parse) return e.JSON.parse(t + "");
        var n, i = null,
            s = oe.trim(t + "");
        return s && !oe.trim(s.replace(It, function(e, t, s, r) {
            return n && t && (i = 0), 0 === i ? e : (n = s || t, i += !r - !s, "")
        })) ? Function("return " + s)() : oe.error("Invalid JSON: " + t)
    }, oe.parseXML = function(t) {
        var n, i;
        if (!t || "string" != typeof t) return null;
        try {
            e.DOMParser ? (i = new e.DOMParser, n = i.parseFromString(t, "text/xml")) : ((n = new e.ActiveXObject("Microsoft.XMLDOM")).async = "false", n.loadXML(t))
        } catch (e) {
            n = void 0
        }
        return n && n.documentElement && !n.getElementsByTagName("parsererror").length || oe.error("Invalid XML: " + t), n
    };
    var At = /#.*$/,
        jt = /([?&])_=[^&]*/,
        Ht = /^(.*?):[ \t]*([^\r\n]*)\r?$/gm,
        Lt = /^(?:GET|HEAD)$/,
        Ft = /^\/\//,
        Rt = /^([\w.+-]+:)(?:\/\/(?:[^\/?#]*@|)([^\/?#:]*)(?::(\d+)|)|)/,
        Bt = {},
        qt = {},
        Yt = "*/".concat("*"),
        Wt = Ot.href,
        zt = Rt.exec(Wt.toLowerCase()) || [];
    oe.extend({
        active: 0,
        lastModified: {},
        etag: {},
        ajaxSettings: {
            url: Wt,
            type: "GET",
            isLocal: /^(?:about|app|app-storage|.+-extension|file|res|widget):$/.test(zt[1]),
            global: !0,
            processData: !0,
            async: !0,
            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
            accepts: {
                "*": Yt,
                text: "text/plain",
                html: "text/html",
                xml: "application/xml, text/xml",
                json: "application/json, text/javascript"
            },
            contents: {
                xml: /\bxml\b/,
                html: /\bhtml/,
                json: /\bjson\b/
            },
            responseFields: {
                xml: "responseXML",
                text: "responseText",
                json: "responseJSON"
            },
            converters: {
                "* text": String,
                "text html": !0,
                "text json": oe.parseJSON,
                "text xml": oe.parseXML
            },
            flatOptions: {
                url: !0,
                context: !0
            }
        },
        ajaxSetup: function(e, t) {
            return t ? W(W(e, oe.ajaxSettings), t) : W(oe.ajaxSettings, e)
        },
        ajaxPrefilter: q(Bt),
        ajaxTransport: q(qt),
        ajax: function(t, n) {
            function i(t, n, i, s) {
                var r, u, _, y, w, k = n;
                2 !== b && (b = 2, l && e.clearTimeout(l), d = void 0, a = s || "", x.readyState = t > 0 ? 4 : 0, r = t >= 200 && t < 300 || 304 === t, i && (y = function(e, t, n) {
                    for (var i, s, r, o, a = e.contents, l = e.dataTypes;
                        "*" === l[0];) l.shift(), void 0 === s && (s = e.mimeType || t.getResponseHeader("Content-Type"));
                    if (s)
                        for (o in a)
                            if (a[o] && a[o].test(s)) {
                                l.unshift(o);
                                break
                            }
                    if (l[0] in n) r = l[0];
                    else {
                        for (o in n) {
                            if (!l[0] || e.converters[o + " " + l[0]]) {
                                r = o;
                                break
                            }
                            i || (i = o)
                        }
                        r = r || i
                    }
                    if (r) return r !== l[0] && l.unshift(r), n[r]
                }(h, x, i)), y = function(e, t, n, i) {
                    var s, r, o, a, l, c = {},
                        d = e.dataTypes.slice();
                    if (d[1])
                        for (o in e.converters) c[o.toLowerCase()] = e.converters[o];
                    for (r = d.shift(); r;)
                        if (e.responseFields[r] && (n[e.responseFields[r]] = t), !l && i && e.dataFilter && (t = e.dataFilter(t, e.dataType)), l = r, r = d.shift())
                            if ("*" === r) r = l;
                            else if ("*" !== l && l !== r) {
                        if (!(o = c[l + " " + r] || c["* " + r]))
                            for (s in c)
                                if ((a = s.split(" "))[1] === r && (o = c[l + " " + a[0]] || c["* " + a[0]])) {
                                    !0 === o ? o = c[s] : !0 !== c[s] && (r = a[0], d.unshift(a[1]));
                                    break
                                }
                        if (!0 !== o)
                            if (o && e.throws) t = o(t);
                            else try {
                                t = o(t)
                            } catch (e) {
                                return {
                                    state: "parsererror",
                                    error: o ? e : "No conversion from " + l + " to " + r
                                }
                            }
                    }
                    return {
                        state: "success",
                        data: t
                    }
                }(h, y, x, r), r ? (h.ifModified && ((w = x.getResponseHeader("Last-Modified")) && (oe.lastModified[o] = w), (w = x.getResponseHeader("etag")) && (oe.etag[o] = w)), 204 === t || "HEAD" === h.type ? k = "nocontent" : 304 === t ? k = "notmodified" : (k = y.state, u = y.data, r = !(_ = y.error))) : (_ = k, !t && k || (k = "error", t < 0 && (t = 0))), x.status = t, x.statusText = (n || k) + "", r ? m.resolveWith(p, [u, k, x]) : m.rejectWith(p, [x, k, _]), x.statusCode(v), v = void 0, c && f.trigger(r ? "ajaxSuccess" : "ajaxError", [x, h, r ? u : _]), g.fireWith(p, [x, k]), c && (f.trigger("ajaxComplete", [x, h]), --oe.active || oe.event.trigger("ajaxStop")))
            }
            "object" == typeof t && (n = t, t = void 0), n = n || {};
            var s, r, o, a, l, c, d, u, h = oe.ajaxSetup({}, n),
                p = h.context || h,
                f = h.context && (p.nodeType || p.jquery) ? oe(p) : oe.event,
                m = oe.Deferred(),
                g = oe.Callbacks("once memory"),
                v = h.statusCode || {},
                _ = {},
                y = {},
                b = 0,
                w = "canceled",
                x = {
                    readyState: 0,
                    getResponseHeader: function(e) {
                        var t;
                        if (2 === b) {
                            if (!u)
                                for (u = {}; t = Ht.exec(a);) u[t[1].toLowerCase()] = t[2];
                            t = u[e.toLowerCase()]
                        }
                        return null == t ? null : t
                    },
                    getAllResponseHeaders: function() {
                        return 2 === b ? a : null
                    },
                    setRequestHeader: function(e, t) {
                        var n = e.toLowerCase();
                        return b || (e = y[n] = y[n] || e, _[e] = t), this
                    },
                    overrideMimeType: function(e) {
                        return b || (h.mimeType = e), this
                    },
                    statusCode: function(e) {
                        var t;
                        if (e)
                            if (b < 2)
                                for (t in e) v[t] = [v[t], e[t]];
                            else x.always(e[x.status]);
                        return this
                    },
                    abort: function(e) {
                        var t = e || w;
                        return d && d.abort(t), i(0, t), this
                    }
                };
            if (m.promise(x).complete = g.add, x.success = x.done, x.error = x.fail, h.url = ((t || h.url || Wt) + "").replace(At, "").replace(Ft, zt[1] + "//"), h.type = n.method || n.type || h.method || h.type, h.dataTypes = oe.trim(h.dataType || "*").toLowerCase().match(we) || [""], null == h.crossDomain && (s = Rt.exec(h.url.toLowerCase()), h.crossDomain = !(!s || s[1] === zt[1] && s[2] === zt[2] && (s[3] || ("http:" === s[1] ? "80" : "443")) === (zt[3] || ("http:" === zt[1] ? "80" : "443")))), h.data && h.processData && "string" != typeof h.data && (h.data = oe.param(h.data, h.traditional)), Y(Bt, h, n, x), 2 === b) return x;
            (c = oe.event && h.global) && 0 == oe.active++ && oe.event.trigger("ajaxStart"), h.type = h.type.toUpperCase(), h.hasContent = !Lt.test(h.type), o = h.url, h.hasContent || (h.data && (o = h.url += (Nt.test(o) ? "&" : "?") + h.data, delete h.data), !1 === h.cache && (h.url = jt.test(o) ? o.replace(jt, "$1_=" + Mt++) : o + (Nt.test(o) ? "&" : "?") + "_=" + Mt++)), h.ifModified && (oe.lastModified[o] && x.setRequestHeader("If-Modified-Since", oe.lastModified[o]), oe.etag[o] && x.setRequestHeader("If-None-Match", oe.etag[o])), (h.data && h.hasContent && !1 !== h.contentType || n.contentType) && x.setRequestHeader("Content-Type", h.contentType), x.setRequestHeader("Accept", h.dataTypes[0] && h.accepts[h.dataTypes[0]] ? h.accepts[h.dataTypes[0]] + ("*" !== h.dataTypes[0] ? ", " + Yt + "; q=0.01" : "") : h.accepts["*"]);
            for (r in h.headers) x.setRequestHeader(r, h.headers[r]);
            if (h.beforeSend && (!1 === h.beforeSend.call(p, x, h) || 2 === b)) return x.abort();
            w = "abort";
            for (r in {
                    success: 1,
                    error: 1,
                    complete: 1
                }) x[r](h[r]);
            if (d = Y(qt, h, n, x)) {
                if (x.readyState = 1, c && f.trigger("ajaxSend", [x, h]), 2 === b) return x;
                h.async && h.timeout > 0 && (l = e.setTimeout(function() {
                    x.abort("timeout")
                }, h.timeout));
                try {
                    b = 1, d.send(_, i)
                } catch (e) {
                    if (!(b < 2)) throw e;
                    i(-1, e)
                }
            } else i(-1, "No Transport");
            return x
        },
        getJSON: function(e, t, n) {
            return oe.get(e, t, n, "json")
        },
        getScript: function(e, t) {
            return oe.get(e, void 0, t, "script")
        }
    }), oe.each(["get", "post"], function(e, t) {
        oe[t] = function(e, n, i, s) {
            return oe.isFunction(n) && (s = s || i, i = n, n = void 0), oe.ajax(oe.extend({
                url: e,
                type: t,
                dataType: s,
                data: n,
                success: i
            }, oe.isPlainObject(e) && e))
        }
    }), oe._evalUrl = function(e) {
        return oe.ajax({
            url: e,
            type: "GET",
            dataType: "script",
            cache: !0,
            async: !1,
            global: !1,
            throws: !0
        })
    }, oe.fn.extend({
        wrapAll: function(e) {
            if (oe.isFunction(e)) return this.each(function(t) {
                oe(this).wrapAll(e.call(this, t))
            });
            if (this[0]) {
                var t = oe(e, this[0].ownerDocument).eq(0).clone(!0);
                this[0].parentNode && t.insertBefore(this[0]), t.map(function() {
                    for (var e = this; e.firstChild && 1 === e.firstChild.nodeType;) e = e.firstChild;
                    return e
                }).append(this)
            }
            return this
        },
        wrapInner: function(e) {
            return oe.isFunction(e) ? this.each(function(t) {
                oe(this).wrapInner(e.call(this, t))
            }) : this.each(function() {
                var t = oe(this),
                    n = t.contents();
                n.length ? n.wrapAll(e) : t.append(e)
            })
        },
        wrap: function(e) {
            var t = oe.isFunction(e);
            return this.each(function(n) {
                oe(this).wrapAll(t ? e.call(this, n) : e)
            })
        },
        unwrap: function() {
            return this.parent().each(function() {
                oe.nodeName(this, "body") || oe(this).replaceWith(this.childNodes)
            }).end()
        }
    }), oe.expr.filters.hidden = function(e) {
        return re.reliableHiddenOffsets() ? e.offsetWidth <= 0 && e.offsetHeight <= 0 && !e.getClientRects().length : function(e) {
            if (!oe.contains(e.ownerDocument || K, e)) return !0;
            for (; e && 1 === e.nodeType;) {
                if ("none" === z(e) || "hidden" === e.type) return !0;
                e = e.parentNode
            }
            return !1
        }(e)
    }, oe.expr.filters.visible = function(e) {
        return !oe.expr.filters.hidden(e)
    };
    var Ut = /%20/g,
        Vt = /\[\]$/,
        Xt = /\r?\n/g,
        Qt = /^(?:submit|button|image|reset|file)$/i,
        Gt = /^(?:input|select|textarea|keygen)/i;
    oe.param = function(e, t) {
        var n, i = [],
            s = function(e, t) {
                t = oe.isFunction(t) ? t() : null == t ? "" : t, i[i.length] = encodeURIComponent(e) + "=" + encodeURIComponent(t)
            };
        if (void 0 === t && (t = oe.ajaxSettings && oe.ajaxSettings.traditional), oe.isArray(e) || e.jquery && !oe.isPlainObject(e)) oe.each(e, function() {
            s(this.name, this.value)
        });
        else
            for (n in e) U(n, e[n], t, s);
        return i.join("&").replace(Ut, "+")
    }, oe.fn.extend({
        serialize: function() {
            return oe.param(this.serializeArray())
        },
        serializeArray: function() {
            return this.map(function() {
                var e = oe.prop(this, "elements");
                return e ? oe.makeArray(e) : this
            }).filter(function() {
                var e = this.type;
                return this.name && !oe(this).is(":disabled") && Gt.test(this.nodeName) && !Qt.test(e) && (this.checked || !Me.test(e))
            }).map(function(e, t) {
                var n = oe(this).val();
                return null == n ? null : oe.isArray(n) ? oe.map(n, function(e) {
                    return {
                        name: t.name,
                        value: e.replace(Xt, "\r\n")
                    }
                }) : {
                    name: t.name,
                    value: n.replace(Xt, "\r\n")
                }
            }).get()
        }
    }), oe.ajaxSettings.xhr = void 0 !== e.ActiveXObject ? function() {
        return this.isLocal ? X() : K.documentMode > 8 ? V() : /^(get|post|head|put|delete|options)$/i.test(this.type) && V() || X()
    } : V;
    var Kt = 0,
        Jt = {},
        Zt = oe.ajaxSettings.xhr();
    e.attachEvent && e.attachEvent("onunload", function() {
        for (var e in Jt) Jt[e](void 0, !0)
    }), re.cors = !!Zt && "withCredentials" in Zt, (Zt = re.ajax = !!Zt) && oe.ajaxTransport(function(t) {
        if (!t.crossDomain || re.cors) {
            var n;
            return {
                send: function(i, s) {
                    var r, o = t.xhr(),
                        a = ++Kt;
                    if (o.open(t.type, t.url, t.async, t.username, t.password), t.xhrFields)
                        for (r in t.xhrFields) o[r] = t.xhrFields[r];
                    t.mimeType && o.overrideMimeType && o.overrideMimeType(t.mimeType), t.crossDomain || i["X-Requested-With"] || (i["X-Requested-With"] = "XMLHttpRequest");
                    for (r in i) void 0 !== i[r] && o.setRequestHeader(r, i[r] + "");
                    o.send(t.hasContent && t.data || null), n = function(e, i) {
                        var r, l, c;
                        if (n && (i || 4 === o.readyState))
                            if (delete Jt[a], n = void 0, o.onreadystatechange = oe.noop, i) 4 !== o.readyState && o.abort();
                            else {
                                c = {}, r = o.status, "string" == typeof o.responseText && (c.text = o.responseText);
                                try {
                                    l = o.statusText
                                } catch (e) {
                                    l = ""
                                }
                                r || !t.isLocal || t.crossDomain ? 1223 === r && (r = 204) : r = c.text ? 200 : 404
                            }
                        c && s(r, l, c, o.getAllResponseHeaders())
                    }, t.async ? 4 === o.readyState ? e.setTimeout(n) : o.onreadystatechange = Jt[a] = n : n()
                },
                abort: function() {
                    n && n(void 0, !0)
                }
            }
        }
    }), oe.ajaxSetup({
        accepts: {
            script: "text/javascript, application/javascript, application/ecmascript, application/x-ecmascript"
        },
        contents: {
            script: /\b(?:java|ecma)script\b/
        },
        converters: {
            "text script": function(e) {
                return oe.globalEval(e), e
            }
        }
    }), oe.ajaxPrefilter("script", function(e) {
        void 0 === e.cache && (e.cache = !1), e.crossDomain && (e.type = "GET", e.global = !1)
    }), oe.ajaxTransport("script", function(e) {
        if (e.crossDomain) {
            var t, n = K.head || oe("head")[0] || K.documentElement;
            return {
                send: function(i, s) {
                    (t = K.createElement("script")).async = !0, e.scriptCharset && (t.charset = e.scriptCharset), t.src = e.url, t.onload = t.onreadystatechange = function(e, n) {
                        (n || !t.readyState || /loaded|complete/.test(t.readyState)) && (t.onload = t.onreadystatechange = null, t.parentNode && t.parentNode.removeChild(t), t = null, n || s(200, "success"))
                    }, n.insertBefore(t, n.firstChild)
                },
                abort: function() {
                    t && t.onload(void 0, !0)
                }
            }
        }
    });
    var en = [],
        tn = /(=)\?(?=&|$)|\?\?/;
    oe.ajaxSetup({
        jsonp: "callback",
        jsonpCallback: function() {
            var e = en.pop() || oe.expando + "_" + Mt++;
            return this[e] = !0, e
        }
    }), oe.ajaxPrefilter("json jsonp", function(t, n, i) {
        var s, r, o, a = !1 !== t.jsonp && (tn.test(t.url) ? "url" : "string" == typeof t.data && 0 === (t.contentType || "").indexOf("application/x-www-form-urlencoded") && tn.test(t.data) && "data");
        if (a || "jsonp" === t.dataTypes[0]) return s = t.jsonpCallback = oe.isFunction(t.jsonpCallback) ? t.jsonpCallback() : t.jsonpCallback, a ? t[a] = t[a].replace(tn, "$1" + s) : !1 !== t.jsonp && (t.url += (Nt.test(t.url) ? "&" : "?") + t.jsonp + "=" + s), t.converters["script json"] = function() {
            return o || oe.error(s + " was not called"), o[0]
        }, t.dataTypes[0] = "json", r = e[s], e[s] = function() {
            o = arguments
        }, i.always(function() {
            void 0 === r ? oe(e).removeProp(s) : e[s] = r, t[s] && (t.jsonpCallback = n.jsonpCallback, en.push(s)), o && oe.isFunction(r) && r(o[0]), o = r = void 0
        }), "script"
    }), oe.parseHTML = function(e, t, n) {
        if (!e || "string" != typeof e) return null;
        "boolean" == typeof t && (n = t, t = !1), t = t || K;
        var i = me.exec(e),
            s = !n && [];
        return i ? [t.createElement(i[1])] : (i = g([e], t, s), s && s.length && oe(s).remove(), oe.merge([], i.childNodes))
    };
    var nn = oe.fn.load;
    oe.fn.load = function(e, t, n) {
        if ("string" != typeof e && nn) return nn.apply(this, arguments);
        var i, s, r, o = this,
            a = e.indexOf(" ");
        return a > -1 && (i = oe.trim(e.slice(a, e.length)), e = e.slice(0, a)), oe.isFunction(t) ? (n = t, t = void 0) : t && "object" == typeof t && (s = "POST"), o.length > 0 && oe.ajax({
            url: e,
            type: s || "GET",
            dataType: "html",
            data: t
        }).done(function(e) {
            r = arguments, o.html(i ? oe("<div>").append(oe.parseHTML(e)).find(i) : e)
        }).always(n && function(e, t) {
            o.each(function() {
                n.apply(this, r || [e.responseText, t, e])
            })
        }), this
    }, oe.each(["ajaxStart", "ajaxStop", "ajaxComplete", "ajaxError", "ajaxSuccess", "ajaxSend"], function(e, t) {
        oe.fn[t] = function(e) {
            return this.on(t, e)
        }
    }), oe.expr.filters.animated = function(e) {
        return oe.grep(oe.timers, function(t) {
            return e === t.elem
        }).length
    }, oe.offset = {
        setOffset: function(e, t, n) {
            var i, s, r, o, a, l, c = oe.css(e, "position"),
                d = oe(e),
                u = {};
            "static" === c && (e.style.position = "relative"), a = d.offset(), r = oe.css(e, "top"), l = oe.css(e, "left"), ("absolute" === c || "fixed" === c) && oe.inArray("auto", [r, l]) > -1 ? (o = (i = d.position()).top, s = i.left) : (o = parseFloat(r) || 0, s = parseFloat(l) || 0), oe.isFunction(t) && (t = t.call(e, n, oe.extend({}, a))), null != t.top && (u.top = t.top - a.top + o), null != t.left && (u.left = t.left - a.left + s), "using" in t ? t.using.call(e, u) : d.css(u)
        }
    }, oe.fn.extend({
        offset: function(e) {
            if (arguments.length) return void 0 === e ? this : this.each(function(t) {
                oe.offset.setOffset(this, e, t)
            });
            var t, n, i = {
                    top: 0,
                    left: 0
                },
                s = this[0],
                r = s && s.ownerDocument;
            if (r) return t = r.documentElement, oe.contains(t, s) ? (void 0 !== s.getBoundingClientRect && (i = s.getBoundingClientRect()), n = Q(r), {
                top: i.top + (n.pageYOffset || t.scrollTop) - (t.clientTop || 0),
                left: i.left + (n.pageXOffset || t.scrollLeft) - (t.clientLeft || 0)
            }) : i
        },
        position: function() {
            if (this[0]) {
                var e, t, n = {
                        top: 0,
                        left: 0
                    },
                    i = this[0];
                return "fixed" === oe.css(i, "position") ? t = i.getBoundingClientRect() : (e = this.offsetParent(), t = this.offset(), oe.nodeName(e[0], "html") || (n = e.offset()), n.top += oe.css(e[0], "borderTopWidth", !0), n.left += oe.css(e[0], "borderLeftWidth", !0)), {
                    top: t.top - n.top - oe.css(i, "marginTop", !0),
                    left: t.left - n.left - oe.css(i, "marginLeft", !0)
                }
            }
        },
        offsetParent: function() {
            return this.map(function() {
                for (var e = this.offsetParent; e && !oe.nodeName(e, "html") && "static" === oe.css(e, "position");) e = e.offsetParent;
                return e || st
            })
        }
    }), oe.each({
        scrollLeft: "pageXOffset",
        scrollTop: "pageYOffset"
    }, function(e, t) {
        var n = /Y/.test(t);
        oe.fn[e] = function(i) {
            return Oe(this, function(e, i, s) {
                var r = Q(e);
                if (void 0 === s) return r ? t in r ? r[t] : r.document.documentElement[i] : e[i];
                r ? r.scrollTo(n ? oe(r).scrollLeft() : s, n ? s : oe(r).scrollTop()) : e[i] = s
            }, e, i, arguments.length, null)
        }
    }), oe.each(["top", "left"], function(e, t) {
        oe.cssHooks[t] = P(re.pixelPosition, function(e, n) {
            if (n) return n = ot(e, t), nt.test(n) ? oe(e).position()[t] + "px" : n
        })
    }), oe.each({
        Height: "height",
        Width: "width"
    }, function(e, t) {
        oe.each({
            padding: "inner" + e,
            content: t,
            "": "outer" + e
        }, function(n, i) {
            oe.fn[i] = function(i, s) {
                var r = arguments.length && (n || "boolean" != typeof i),
                    o = n || (!0 === i || !0 === s ? "margin" : "border");
                return Oe(this, function(t, n, i) {
                    var s;
                    return oe.isWindow(t) ? t.document.documentElement["client" + e] : 9 === t.nodeType ? (s = t.documentElement, Math.max(t.body["scroll" + e], s["scroll" + e], t.body["offset" + e], s["offset" + e], s["client" + e])) : void 0 === i ? oe.css(t, n, o) : oe.style(t, n, i, o)
                }, t, r ? i : void 0, r, null)
            }
        })
    }), oe.fn.extend({
        bind: function(e, t, n) {
            return this.on(e, null, t, n)
        },
        unbind: function(e, t) {
            return this.off(e, null, t)
        },
        delegate: function(e, t, n, i) {
            return this.on(t, e, n, i)
        },
        undelegate: function(e, t, n) {
            return 1 === arguments.length ? this.off(e, "**") : this.off(t, e || "**", n)
        }
    }), oe.fn.size = function() {
        return this.length
    }, oe.fn.andSelf = oe.fn.addBack, "function" == typeof define && define.amd && define("jquery", [], function() {
        return oe
    });
    var sn = e.jQuery,
        rn = e.$;
    return oe.noConflict = function(t) {
        return e.$ === oe && (e.$ = rn), t && e.jQuery === oe && (e.jQuery = sn), oe
    }, t || (e.jQuery = e.$ = oe), oe
}),
function(e) {
    "function" == typeof define && define.amd ? define(["jquery"], e) : e(jQuery)
}(function(e) {
    e.ui = e.ui || {};
    e.ui.version = "1.12.1";
    var t = 0,
        n = Array.prototype.slice;
    e.cleanData = function(t) {
        return function(n) {
            var i, s, r;
            for (r = 0; null != (s = n[r]); r++) try {
                (i = e._data(s, "events")) && i.remove && e(s).triggerHandler("remove")
            } catch (e) {}
            t(n)
        }
    }(e.cleanData), e.widget = function(t, n, i) {
        var s, r, o, a = {},
            l = t.split(".")[0],
            c = l + "-" + (t = t.split(".")[1]);
        return i || (i = n, n = e.Widget), e.isArray(i) && (i = e.extend.apply(null, [{}].concat(i))), e.expr[":"][c.toLowerCase()] = function(t) {
            return !!e.data(t, c)
        }, e[l] = e[l] || {}, s = e[l][t], r = e[l][t] = function(e, t) {
            if (!this._createWidget) return new r(e, t);
            arguments.length && this._createWidget(e, t)
        }, e.extend(r, s, {
            version: i.version,
            _proto: e.extend({}, i),
            _childConstructors: []
        }), o = new n, o.options = e.widget.extend({}, o.options), e.each(i, function(t, i) {
            e.isFunction(i) ? a[t] = function() {
                function e() {
                    return n.prototype[t].apply(this, arguments)
                }

                function s(e) {
                    return n.prototype[t].apply(this, e)
                }
                return function() {
                    var t, n = this._super,
                        r = this._superApply;
                    return this._super = e, this._superApply = s, t = i.apply(this, arguments), this._super = n, this._superApply = r, t
                }
            }() : a[t] = i
        }), r.prototype = e.widget.extend(o, {
            widgetEventPrefix: s ? o.widgetEventPrefix || t : t
        }, a, {
            constructor: r,
            namespace: l,
            widgetName: t,
            widgetFullName: c
        }), s ? (e.each(s._childConstructors, function(t, n) {
            var i = n.prototype;
            e.widget(i.namespace + "." + i.widgetName, r, n._proto)
        }), delete s._childConstructors) : n._childConstructors.push(r), e.widget.bridge(t, r), r
    }, e.widget.extend = function(t) {
        for (var i, s, r = n.call(arguments, 1), o = 0, a = r.length; o < a; o++)
            for (i in r[o]) s = r[o][i], r[o].hasOwnProperty(i) && void 0 !== s && (e.isPlainObject(s) ? t[i] = e.isPlainObject(t[i]) ? e.widget.extend({}, t[i], s) : e.widget.extend({}, s) : t[i] = s);
        return t
    }, e.widget.bridge = function(t, i) {
        var s = i.prototype.widgetFullName || t;
        e.fn[t] = function(r) {
            var o = "string" == typeof r,
                a = n.call(arguments, 1),
                l = this;
            return o ? this.length || "instance" !== r ? this.each(function() {
                var n, i = e.data(this, s);
                return "instance" === r ? (l = i, !1) : i ? e.isFunction(i[r]) && "_" !== r.charAt(0) ? (n = i[r].apply(i, a)) !== i && void 0 !== n ? (l = n && n.jquery ? l.pushStack(n.get()) : n, !1) : void 0 : e.error("no such method '" + r + "' for " + t + " widget instance") : e.error("cannot call methods on " + t + " prior to initialization; attempted to call method '" + r + "'")
            }) : l = void 0 : (a.length && (r = e.widget.extend.apply(null, [r].concat(a))), this.each(function() {
                var t = e.data(this, s);
                t ? (t.option(r || {}), t._init && t._init()) : e.data(this, s, new i(r, this))
            })), l
        }
    }, e.Widget = function() {}, e.Widget._childConstructors = [], e.Widget.prototype = {
        widgetName: "widget",
        widgetEventPrefix: "",
        defaultElement: "<div>",
        options: {
            classes: {},
            disabled: !1,
            create: null
        },
        _createWidget: function(n, i) {
            i = e(i || this.defaultElement || this)[0], this.element = e(i), this.uuid = t++, this.eventNamespace = "." + this.widgetName + this.uuid, this.bindings = e(), this.hoverable = e(), this.focusable = e(), this.classesElementLookup = {}, i !== this && (e.data(i, this.widgetFullName, this), this._on(!0, this.element, {
                remove: function(e) {
                    e.target === i && this.destroy()
                }
            }), this.document = e(i.style ? i.ownerDocument : i.document || i), this.window = e(this.document[0].defaultView || this.document[0].parentWindow)), this.options = e.widget.extend({}, this.options, this._getCreateOptions(), n), this._create(), this.options.disabled && this._setOptionDisabled(this.options.disabled), this._trigger("create", null, this._getCreateEventData()), this._init()
        },
        _getCreateOptions: function() {
            return {}
        },
        _getCreateEventData: e.noop,
        _create: e.noop,
        _init: e.noop,
        destroy: function() {
            var t = this;
            this._destroy(), e.each(this.classesElementLookup, function(e, n) {
                t._removeClass(n, e)
            }), this.element.off(this.eventNamespace).removeData(this.widgetFullName), this.widget().off(this.eventNamespace).removeAttr("aria-disabled"), this.bindings.off(this.eventNamespace)
        },
        _destroy: e.noop,
        widget: function() {
            return this.element
        },
        option: function(t, n) {
            var i, s, r, o = t;
            if (0 === arguments.length) return e.widget.extend({}, this.options);
            if ("string" == typeof t)
                if (o = {}, i = t.split("."), t = i.shift(), i.length) {
                    for (s = o[t] = e.widget.extend({}, this.options[t]), r = 0; r < i.length - 1; r++) s[i[r]] = s[i[r]] || {}, s = s[i[r]];
                    if (t = i.pop(), 1 === arguments.length) return void 0 === s[t] ? null : s[t];
                    s[t] = n
                } else {
                    if (1 === arguments.length) return void 0 === this.options[t] ? null : this.options[t];
                    o[t] = n
                }
            return this._setOptions(o), this
        },
        _setOptions: function(e) {
            var t;
            for (t in e) this._setOption(t, e[t]);
            return this
        },
        _setOption: function(e, t) {
            return "classes" === e && this._setOptionClasses(t), this.options[e] = t, "disabled" === e && this._setOptionDisabled(t), this
        },
        _setOptionClasses: function(t) {
            var n, i, s;
            for (n in t) s = this.classesElementLookup[n], t[n] !== this.options.classes[n] && s && s.length && (i = e(s.get()), this._removeClass(s, n), i.addClass(this._classes({
                element: i,
                keys: n,
                classes: t,
                add: !0
            })))
        },
        _setOptionDisabled: function(e) {
            this._toggleClass(this.widget(), this.widgetFullName + "-disabled", null, !!e), e && (this._removeClass(this.hoverable, null, "ui-state-hover"), this._removeClass(this.focusable, null, "ui-state-focus"))
        },
        enable: function() {
            return this._setOptions({
                disabled: !1
            })
        },
        disable: function() {
            return this._setOptions({
                disabled: !0
            })
        },
        _classes: function(t) {
            function n(n, r) {
                var o, a;
                for (a = 0; a < n.length; a++) o = s.classesElementLookup[n[a]] || e(), o = t.add ? e(e.unique(o.get().concat(t.element.get()))) : e(o.not(t.element).get()), s.classesElementLookup[n[a]] = o, i.push(n[a]), r && t.classes[n[a]] && i.push(t.classes[n[a]])
            }
            var i = [],
                s = this;
            return t = e.extend({
                element: this.element,
                classes: this.options.classes || {}
            }, t), this._on(t.element, {
                remove: "_untrackClassesElement"
            }), t.keys && n(t.keys.match(/\S+/g) || [], !0), t.extra && n(t.extra.match(/\S+/g) || []), i.join(" ")
        },
        _untrackClassesElement: function(t) {
            var n = this;
            e.each(n.classesElementLookup, function(i, s) {
                -1 !== e.inArray(t.target, s) && (n.classesElementLookup[i] = e(s.not(t.target).get()))
            })
        },
        _removeClass: function(e, t, n) {
            return this._toggleClass(e, t, n, !1)
        },
        _addClass: function(e, t, n) {
            return this._toggleClass(e, t, n, !0)
        },
        _toggleClass: function(e, t, n, i) {
            i = "boolean" == typeof i ? i : n;
            var s = "string" == typeof e || null === e,
                r = {
                    extra: s ? t : n,
                    keys: s ? e : t,
                    element: s ? this.element : e,
                    add: i
                };
            return r.element.toggleClass(this._classes(r), i), this
        },
        _on: function(t, n, i) {
            var s, r = this;
            "boolean" != typeof t && (i = n, n = t, t = !1), i ? (n = s = e(n), this.bindings = this.bindings.add(n)) : (i = n, n = this.element, s = this.widget()), e.each(i, function(i, o) {
                function a() {
                    if (t || !0 !== r.options.disabled && !e(this).hasClass("ui-state-disabled")) return ("string" == typeof o ? r[o] : o).apply(r, arguments)
                }
                "string" != typeof o && (a.guid = o.guid = o.guid || a.guid || e.guid++);
                var l = i.match(/^([\w:-]*)\s*(.*)$/),
                    c = l[1] + r.eventNamespace,
                    d = l[2];
                d ? s.on(c, d, a) : n.on(c, a)
            })
        },
        _off: function(t, n) {
            n = (n || "").split(" ").join(this.eventNamespace + " ") + this.eventNamespace, t.off(n).off(n), this.bindings = e(this.bindings.not(t).get()), this.focusable = e(this.focusable.not(t).get()), this.hoverable = e(this.hoverable.not(t).get())
        },
        _delay: function(e, t) {
            var n = this;
            return setTimeout(function() {
                return ("string" == typeof e ? n[e] : e).apply(n, arguments)
            }, t || 0)
        },
        _hoverable: function(t) {
            this.hoverable = this.hoverable.add(t), this._on(t, {
                mouseenter: function(t) {
                    this._addClass(e(t.currentTarget), null, "ui-state-hover")
                },
                mouseleave: function(t) {
                    this._removeClass(e(t.currentTarget), null, "ui-state-hover")
                }
            })
        },
        _focusable: function(t) {
            this.focusable = this.focusable.add(t), this._on(t, {
                focusin: function(t) {
                    this._addClass(e(t.currentTarget), null, "ui-state-focus")
                },
                focusout: function(t) {
                    this._removeClass(e(t.currentTarget), null, "ui-state-focus")
                }
            })
        },
        _trigger: function(t, n, i) {
            var s, r, o = this.options[t];
            if (i = i || {}, n = e.Event(n), n.type = (t === this.widgetEventPrefix ? t : this.widgetEventPrefix + t).toLowerCase(), n.target = this.element[0], r = n.originalEvent)
                for (s in r) s in n || (n[s] = r[s]);
            return this.element.trigger(n, i), !(e.isFunction(o) && !1 === o.apply(this.element[0], [n].concat(i)) || n.isDefaultPrevented())
        }
    }, e.each({
        show: "fadeIn",
        hide: "fadeOut"
    }, function(t, n) {
        e.Widget.prototype["_" + t] = function(i, s, r) {
            "string" == typeof s && (s = {
                effect: s
            });
            var o, a = s ? !0 === s || "number" == typeof s ? n : s.effect || n : t;
            "number" == typeof(s = s || {}) && (s = {
                duration: s
            }), o = !e.isEmptyObject(s), s.complete = r, s.delay && i.delay(s.delay), o && e.effects && e.effects.effect[a] ? i[t](s) : a !== t && i[a] ? i[a](s.duration, s.easing, r) : i.queue(function(n) {
                e(this)[t](), r && r.call(i[0]), n()
            })
        }
    });
    e.widget, e.extend(e.expr[":"], {
        data: e.expr.createPseudo ? e.expr.createPseudo(function(t) {
            return function(n) {
                return !!e.data(n, t)
            }
        }) : function(t, n, i) {
            return !!e.data(t, i[3])
        }
    }), e.fn.scrollParent = function(t) {
        var n = this.css("position"),
            i = "absolute" === n,
            s = t ? /(auto|scroll|hidden)/ : /(auto|scroll)/,
            r = this.parents().filter(function() {
                var t = e(this);
                return (!i || "static" !== t.css("position")) && s.test(t.css("overflow") + t.css("overflow-y") + t.css("overflow-x"))
            }).eq(0);
        return "fixed" !== n && r.length ? r : e(this[0].ownerDocument || document)
    }, e.ui.ie = !!/msie [\w.]+/.exec(navigator.userAgent.toLowerCase());
    var i = !1;
    e(document).on("mouseup", function() {
        i = !1
    });
    e.widget("ui.mouse", {
        version: "1.12.1",
        options: {
            cancel: "input, textarea, button, select, option",
            distance: 1,
            delay: 0
        },
        _mouseInit: function() {
            var t = this;
            this.element.on("mousedown." + this.widgetName, function(e) {
                return t._mouseDown(e)
            }).on("click." + this.widgetName, function(n) {
                if (!0 === e.data(n.target, t.widgetName + ".preventClickEvent")) return e.removeData(n.target, t.widgetName + ".preventClickEvent"), n.stopImmediatePropagation(), !1
            }), this.started = !1
        },
        _mouseDestroy: function() {
            this.element.off("." + this.widgetName), this._mouseMoveDelegate && this.document.off("mousemove." + this.widgetName, this._mouseMoveDelegate).off("mouseup." + this.widgetName, this._mouseUpDelegate)
        },
        _mouseDown: function(t) {
            if (!i) {
                this._mouseMoved = !1, this._mouseStarted && this._mouseUp(t), this._mouseDownEvent = t;
                var n = this,
                    s = 1 === t.which,
                    r = !("string" != typeof this.options.cancel || !t.target.nodeName) && e(t.target).closest(this.options.cancel).length;
                return !(s && !r && this._mouseCapture(t)) || (this.mouseDelayMet = !this.options.delay, this.mouseDelayMet || (this._mouseDelayTimer = setTimeout(function() {
                    n.mouseDelayMet = !0
                }, this.options.delay)), this._mouseDistanceMet(t) && this._mouseDelayMet(t) && (this._mouseStarted = !1 !== this._mouseStart(t), !this._mouseStarted) ? (t.preventDefault(), !0) : (!0 === e.data(t.target, this.widgetName + ".preventClickEvent") && e.removeData(t.target, this.widgetName + ".preventClickEvent"), this._mouseMoveDelegate = function(e) {
                    return n._mouseMove(e)
                }, this._mouseUpDelegate = function(e) {
                    return n._mouseUp(e)
                }, this.document.on("mousemove." + this.widgetName, this._mouseMoveDelegate).on("mouseup." + this.widgetName, this._mouseUpDelegate), t.preventDefault(), i = !0, !0))
            }
        },
        _mouseMove: function(t) {
            if (this._mouseMoved) {
                if (e.ui.ie && (!document.documentMode || document.documentMode < 9) && !t.button) return this._mouseUp(t);
                if (!t.which)
                    if (t.originalEvent.altKey || t.originalEvent.ctrlKey || t.originalEvent.metaKey || t.originalEvent.shiftKey) this.ignoreMissingWhich = !0;
                    else if (!this.ignoreMissingWhich) return this._mouseUp(t)
            }
            return (t.which || t.button) && (this._mouseMoved = !0), this._mouseStarted ? (this._mouseDrag(t), t.preventDefault()) : (this._mouseDistanceMet(t) && this._mouseDelayMet(t) && (this._mouseStarted = !1 !== this._mouseStart(this._mouseDownEvent, t), this._mouseStarted ? this._mouseDrag(t) : this._mouseUp(t)), !this._mouseStarted)
        },
        _mouseUp: function(t) {
            this.document.off("mousemove." + this.widgetName, this._mouseMoveDelegate).off("mouseup." + this.widgetName, this._mouseUpDelegate), this._mouseStarted && (this._mouseStarted = !1, t.target === this._mouseDownEvent.target && e.data(t.target, this.widgetName + ".preventClickEvent", !0), this._mouseStop(t)), this._mouseDelayTimer && (clearTimeout(this._mouseDelayTimer), delete this._mouseDelayTimer), this.ignoreMissingWhich = !1, i = !1, t.preventDefault()
        },
        _mouseDistanceMet: function(e) {
            return Math.max(Math.abs(this._mouseDownEvent.pageX - e.pageX), Math.abs(this._mouseDownEvent.pageY - e.pageY)) >= this.options.distance
        },
        _mouseDelayMet: function() {
            return this.mouseDelayMet
        },
        _mouseStart: function() {},
        _mouseDrag: function() {},
        _mouseStop: function() {},
        _mouseCapture: function() {
            return !0
        }
    }), e.ui.plugin = {
        add: function(t, n, i) {
            var s, r = e.ui[t].prototype;
            for (s in i) r.plugins[s] = r.plugins[s] || [], r.plugins[s].push([n, i[s]])
        },
        call: function(e, t, n, i) {
            var s, r = e.plugins[t];
            if (r && (i || e.element[0].parentNode && 11 !== e.element[0].parentNode.nodeType))
                for (s = 0; s < r.length; s++) e.options[r[s][0]] && r[s][1].apply(e.element, n)
        }
    }, e.ui.safeActiveElement = function(e) {
        var t;
        try {
            t = e.activeElement
        } catch (n) {
            t = e.body
        }
        return t || (t = e.body), t.nodeName || (t = e.body), t
    }, e.ui.safeBlur = function(t) {
        t && "body" !== t.nodeName.toLowerCase() && e(t).trigger("blur")
    };
    e.widget("ui.draggable", e.ui.mouse, {
        version: "1.12.1",
        widgetEventPrefix: "drag",
        options: {
            addClasses: !0,
            appendTo: "parent",
            axis: !1,
            connectToSortable: !1,
            containment: !1,
            cursor: "auto",
            cursorAt: !1,
            grid: !1,
            handle: !1,
            helper: "original",
            iframeFix: !1,
            opacity: !1,
            refreshPositions: !1,
            revert: !1,
            revertDuration: 500,
            scope: "default",
            scroll: !0,
            scrollSensitivity: 20,
            scrollSpeed: 20,
            snap: !1,
            snapMode: "both",
            snapTolerance: 20,
            stack: !1,
            zIndex: !1,
            drag: null,
            start: null,
            stop: null
        },
        _create: function() {
            "original" === this.options.helper && this._setPositionRelative(), this.options.addClasses && this._addClass("ui-draggable"), this._setHandleClassName(), this._mouseInit()
        },
        _setOption: function(e, t) {
            this._super(e, t), "handle" === e && (this._removeHandleClassName(), this._setHandleClassName())
        },
        _destroy: function() {
            (this.helper || this.element).is(".ui-draggable-dragging") ? this.destroyOnClear = !0 : (this._removeHandleClassName(), this._mouseDestroy())
        },
        _mouseCapture: function(t) {
            var n = this.options;
            return !(this.helper || n.disabled || e(t.target).closest(".ui-resizable-handle").length > 0) && (this.handle = this._getHandle(t), !!this.handle && (this._blurActiveElement(t), this._blockFrames(!0 === n.iframeFix ? "iframe" : n.iframeFix), !0))
        },
        _blockFrames: function(t) {
            this.iframeBlocks = this.document.find(t).map(function() {
                var t = e(this);
                return e("<div>").css("position", "absolute").appendTo(t.parent()).outerWidth(t.outerWidth()).outerHeight(t.outerHeight()).offset(t.offset())[0]
            })
        },
        _unblockFrames: function() {
            this.iframeBlocks && (this.iframeBlocks.remove(), delete this.iframeBlocks)
        },
        _blurActiveElement: function(t) {
            var n = e.ui.safeActiveElement(this.document[0]);
            e(t.target).closest(n).length || e.ui.safeBlur(n)
        },
        _mouseStart: function(t) {
            var n = this.options;
            return this.helper = this._createHelper(t), this._addClass(this.helper, "ui-draggable-dragging"), this._cacheHelperProportions(), e.ui.ddmanager && (e.ui.ddmanager.current = this), this._cacheMargins(), this.cssPosition = this.helper.css("position"), this.scrollParent = this.helper.scrollParent(!0), this.offsetParent = this.helper.offsetParent(), this.hasFixedAncestor = this.helper.parents().filter(function() {
                return "fixed" === e(this).css("position")
            }).length > 0, this.positionAbs = this.element.offset(), this._refreshOffsets(t), this.originalPosition = this.position = this._generatePosition(t, !1), this.originalPageX = t.pageX, this.originalPageY = t.pageY, n.cursorAt && this._adjustOffsetFromHelper(n.cursorAt), this._setContainment(), !1 === this._trigger("start", t) ? (this._clear(), !1) : (this._cacheHelperProportions(), e.ui.ddmanager && !n.dropBehaviour && e.ui.ddmanager.prepareOffsets(this, t), this._mouseDrag(t, !0), e.ui.ddmanager && e.ui.ddmanager.dragStart(this, t), !0)
        },
        _refreshOffsets: function(e) {
            this.offset = {
                top: this.positionAbs.top - this.margins.top,
                left: this.positionAbs.left - this.margins.left,
                scroll: !1,
                parent: this._getParentOffset(),
                relative: this._getRelativeOffset()
            }, this.offset.click = {
                left: e.pageX - this.offset.left,
                top: e.pageY - this.offset.top
            }
        },
        _mouseDrag: function(t, n) {
            if (this.hasFixedAncestor && (this.offset.parent = this._getParentOffset()), this.position = this._generatePosition(t, !0), this.positionAbs = this._convertPositionTo("absolute"), !n) {
                var i = this._uiHash();
                if (!1 === this._trigger("drag", t, i)) return this._mouseUp(new e.Event("mouseup", t)), !1;
                this.position = i.position
            }
            return this.helper[0].style.left = this.position.left + "px", this.helper[0].style.top = this.position.top + "px", e.ui.ddmanager && e.ui.ddmanager.drag(this, t), !1
        },
        _mouseStop: function(t) {
            var n = this,
                i = !1;
            return e.ui.ddmanager && !this.options.dropBehaviour && (i = e.ui.ddmanager.drop(this, t)), this.dropped && (i = this.dropped, this.dropped = !1), "invalid" === this.options.revert && !i || "valid" === this.options.revert && i || !0 === this.options.revert || e.isFunction(this.options.revert) && this.options.revert.call(this.element, i) ? e(this.helper).animate(this.originalPosition, parseInt(this.options.revertDuration, 10), function() {
                !1 !== n._trigger("stop", t) && n._clear()
            }) : !1 !== this._trigger("stop", t) && this._clear(), !1
        },
        _mouseUp: function(t) {
            return this._unblockFrames(), e.ui.ddmanager && e.ui.ddmanager.dragStop(this, t), this.handleElement.is(t.target) && this.element.trigger("focus"), e.ui.mouse.prototype._mouseUp.call(this, t)
        },
        cancel: function() {
            return this.helper.is(".ui-draggable-dragging") ? this._mouseUp(new e.Event("mouseup", {
                target: this.element[0]
            })) : this._clear(), this
        },
        _getHandle: function(t) {
            return !this.options.handle || !!e(t.target).closest(this.element.find(this.options.handle)).length
        },
        _setHandleClassName: function() {
            this.handleElement = this.options.handle ? this.element.find(this.options.handle) : this.element, this._addClass(this.handleElement, "ui-draggable-handle")
        },
        _removeHandleClassName: function() {
            this._removeClass(this.handleElement, "ui-draggable-handle")
        },
        _createHelper: function(t) {
            var n = this.options,
                i = e.isFunction(n.helper),
                s = i ? e(n.helper.apply(this.element[0], [t])) : "clone" === n.helper ? this.element.clone().removeAttr("id") : this.element;
            return s.parents("body").length || s.appendTo("parent" === n.appendTo ? this.element[0].parentNode : n.appendTo), i && s[0] === this.element[0] && this._setPositionRelative(), s[0] === this.element[0] || /(fixed|absolute)/.test(s.css("position")) || s.css("position", "absolute"), s
        },
        _setPositionRelative: function() {
            /^(?:r|a|f)/.test(this.element.css("position")) || (this.element[0].style.position = "relative")
        },
        _adjustOffsetFromHelper: function(t) {
            "string" == typeof t && (t = t.split(" ")), e.isArray(t) && (t = {
                left: +t[0],
                top: +t[1] || 0
            }), "left" in t && (this.offset.click.left = t.left + this.margins.left), "right" in t && (this.offset.click.left = this.helperProportions.width - t.right + this.margins.left), "top" in t && (this.offset.click.top = t.top + this.margins.top), "bottom" in t && (this.offset.click.top = this.helperProportions.height - t.bottom + this.margins.top)
        },
        _isRootNode: function(e) {
            return /(html|body)/i.test(e.tagName) || e === this.document[0]
        },
        _getParentOffset: function() {
            var t = this.offsetParent.offset(),
                n = this.document[0];
            return "absolute" === this.cssPosition && this.scrollParent[0] !== n && e.contains(this.scrollParent[0], this.offsetParent[0]) && (t.left += this.scrollParent.scrollLeft(), t.top += this.scrollParent.scrollTop()), this._isRootNode(this.offsetParent[0]) && (t = {
                top: 0,
                left: 0
            }), {
                top: t.top + (parseInt(this.offsetParent.css("borderTopWidth"), 10) || 0),
                left: t.left + (parseInt(this.offsetParent.css("borderLeftWidth"), 10) || 0)
            }
        },
        _getRelativeOffset: function() {
            if ("relative" !== this.cssPosition) return {
                top: 0,
                left: 0
            };
            var e = this.element.position(),
                t = this._isRootNode(this.scrollParent[0]);
            return {
                top: e.top - (parseInt(this.helper.css("top"), 10) || 0) + (t ? 0 : this.scrollParent.scrollTop()),
                left: e.left - (parseInt(this.helper.css("left"), 10) || 0) + (t ? 0 : this.scrollParent.scrollLeft())
            }
        },
        _cacheMargins: function() {
            this.margins = {
                left: parseInt(this.element.css("marginLeft"), 10) || 0,
                top: parseInt(this.element.css("marginTop"), 10) || 0,
                right: parseInt(this.element.css("marginRight"), 10) || 0,
                bottom: parseInt(this.element.css("marginBottom"), 10) || 0
            }
        },
        _cacheHelperProportions: function() {
            this.helperProportions = {
                width: this.helper.outerWidth(),
                height: this.helper.outerHeight()
            }
        },
        _setContainment: function() {
            var t, n, i, s = this.options,
                r = this.document[0];
            this.relativeContainer = null, s.containment ? "window" !== s.containment ? "document" !== s.containment ? s.containment.constructor !== Array ? ("parent" === s.containment && (s.containment = this.helper[0].parentNode), (i = (n = e(s.containment))[0]) && (t = /(scroll|auto)/.test(n.css("overflow")), this.containment = [(parseInt(n.css("borderLeftWidth"), 10) || 0) + (parseInt(n.css("paddingLeft"), 10) || 0), (parseInt(n.css("borderTopWidth"), 10) || 0) + (parseInt(n.css("paddingTop"), 10) || 0), (t ? Math.max(i.scrollWidth, i.offsetWidth) : i.offsetWidth) - (parseInt(n.css("borderRightWidth"), 10) || 0) - (parseInt(n.css("paddingRight"), 10) || 0) - this.helperProportions.width - this.margins.left - this.margins.right, (t ? Math.max(i.scrollHeight, i.offsetHeight) : i.offsetHeight) - (parseInt(n.css("borderBottomWidth"), 10) || 0) - (parseInt(n.css("paddingBottom"), 10) || 0) - this.helperProportions.height - this.margins.top - this.margins.bottom], this.relativeContainer = n)) : this.containment = s.containment : this.containment = [0, 0, e(r).width() - this.helperProportions.width - this.margins.left, (e(r).height() || r.body.parentNode.scrollHeight) - this.helperProportions.height - this.margins.top] : this.containment = [e(window).scrollLeft() - this.offset.relative.left - this.offset.parent.left, e(window).scrollTop() - this.offset.relative.top - this.offset.parent.top, e(window).scrollLeft() + e(window).width() - this.helperProportions.width - this.margins.left, e(window).scrollTop() + (e(window).height() || r.body.parentNode.scrollHeight) - this.helperProportions.height - this.margins.top] : this.containment = null
        },
        _convertPositionTo: function(e, t) {
            t || (t = this.position);
            var n = "absolute" === e ? 1 : -1,
                i = this._isRootNode(this.scrollParent[0]);
            return {
                top: t.top + this.offset.relative.top * n + this.offset.parent.top * n - ("fixed" === this.cssPosition ? -this.offset.scroll.top : i ? 0 : this.offset.scroll.top) * n,
                left: t.left + this.offset.relative.left * n + this.offset.parent.left * n - ("fixed" === this.cssPosition ? -this.offset.scroll.left : i ? 0 : this.offset.scroll.left) * n
            }
        },
        _generatePosition: function(e, t) {
            var n, i, s, r, o = this.options,
                a = this._isRootNode(this.scrollParent[0]),
                l = e.pageX,
                c = e.pageY;
            return a && this.offset.scroll || (this.offset.scroll = {
                top: this.scrollParent.scrollTop(),
                left: this.scrollParent.scrollLeft()
            }), t && (this.containment && (this.relativeContainer ? (i = this.relativeContainer.offset(), n = [this.containment[0] + i.left, this.containment[1] + i.top, this.containment[2] + i.left, this.containment[3] + i.top]) : n = this.containment, e.pageX - this.offset.click.left < n[0] && (l = n[0] + this.offset.click.left), e.pageY - this.offset.click.top < n[1] && (c = n[1] + this.offset.click.top), e.pageX - this.offset.click.left > n[2] && (l = n[2] + this.offset.click.left), e.pageY - this.offset.click.top > n[3] && (c = n[3] + this.offset.click.top)), o.grid && (s = o.grid[1] ? this.originalPageY + Math.round((c - this.originalPageY) / o.grid[1]) * o.grid[1] : this.originalPageY, c = n ? s - this.offset.click.top >= n[1] || s - this.offset.click.top > n[3] ? s : s - this.offset.click.top >= n[1] ? s - o.grid[1] : s + o.grid[1] : s, r = o.grid[0] ? this.originalPageX + Math.round((l - this.originalPageX) / o.grid[0]) * o.grid[0] : this.originalPageX, l = n ? r - this.offset.click.left >= n[0] || r - this.offset.click.left > n[2] ? r : r - this.offset.click.left >= n[0] ? r - o.grid[0] : r + o.grid[0] : r), "y" === o.axis && (l = this.originalPageX), "x" === o.axis && (c = this.originalPageY)), {
                top: c - this.offset.click.top - this.offset.relative.top - this.offset.parent.top + ("fixed" === this.cssPosition ? -this.offset.scroll.top : a ? 0 : this.offset.scroll.top),
                left: l - this.offset.click.left - this.offset.relative.left - this.offset.parent.left + ("fixed" === this.cssPosition ? -this.offset.scroll.left : a ? 0 : this.offset.scroll.left)
            }
        },
        _clear: function() {
            this._removeClass(this.helper, "ui-draggable-dragging"), this.helper[0] === this.element[0] || this.cancelHelperRemoval || this.helper.remove(), this.helper = null, this.cancelHelperRemoval = !1, this.destroyOnClear && this.destroy()
        },
        _trigger: function(t, n, i) {
            return i = i || this._uiHash(), e.ui.plugin.call(this, t, [n, i, this], !0), /^(drag|start|stop)/.test(t) && (this.positionAbs = this._convertPositionTo("absolute"), i.offset = this.positionAbs), e.Widget.prototype._trigger.call(this, t, n, i)
        },
        plugins: {},
        _uiHash: function() {
            return {
                helper: this.helper,
                position: this.position,
                originalPosition: this.originalPosition,
                offset: this.positionAbs
            }
        }
    }), e.ui.plugin.add("draggable", "connectToSortable", {
        start: function(t, n, i) {
            var s = e.extend({}, n, {
                item: i.element
            });
            i.sortables = [], e(i.options.connectToSortable).each(function() {
                var n = e(this).sortable("instance");
                n && !n.options.disabled && (i.sortables.push(n), n.refreshPositions(), n._trigger("activate", t, s))
            })
        },
        stop: function(t, n, i) {
            var s = e.extend({}, n, {
                item: i.element
            });
            i.cancelHelperRemoval = !1, e.each(i.sortables, function() {
                this.isOver ? (this.isOver = 0, i.cancelHelperRemoval = !0, this.cancelHelperRemoval = !1, this._storedCSS = {
                    position: this.placeholder.css("position"),
                    top: this.placeholder.css("top"),
                    left: this.placeholder.css("left")
                }, this._mouseStop(t), this.options.helper = this.options._helper) : (this.cancelHelperRemoval = !0, this._trigger("deactivate", t, s))
            })
        },
        drag: function(t, n, i) {
            e.each(i.sortables, function() {
                var s = !1,
                    r = this;
                r.positionAbs = i.positionAbs, r.helperProportions = i.helperProportions, r.offset.click = i.offset.click, r._intersectsWith(r.containerCache) && (s = !0, e.each(i.sortables, function() {
                    return this.positionAbs = i.positionAbs, this.helperProportions = i.helperProportions, this.offset.click = i.offset.click, this !== r && this._intersectsWith(this.containerCache) && e.contains(r.element[0], this.element[0]) && (s = !1), s
                })), s ? (r.isOver || (r.isOver = 1, i._parent = n.helper.parent(), r.currentItem = n.helper.appendTo(r.element).data("ui-sortable-item", !0), r.options._helper = r.options.helper, r.options.helper = function() {
                    return n.helper[0]
                }, t.target = r.currentItem[0], r._mouseCapture(t, !0), r._mouseStart(t, !0, !0), r.offset.click.top = i.offset.click.top, r.offset.click.left = i.offset.click.left, r.offset.parent.left -= i.offset.parent.left - r.offset.parent.left, r.offset.parent.top -= i.offset.parent.top - r.offset.parent.top, i._trigger("toSortable", t), i.dropped = r.element, e.each(i.sortables, function() {
                    this.refreshPositions()
                }), i.currentItem = i.element, r.fromOutside = i), r.currentItem && (r._mouseDrag(t), n.position = r.position)) : r.isOver && (r.isOver = 0, r.cancelHelperRemoval = !0, r.options._revert = r.options.revert, r.options.revert = !1, r._trigger("out", t, r._uiHash(r)), r._mouseStop(t, !0), r.options.revert = r.options._revert, r.options.helper = r.options._helper, r.placeholder && r.placeholder.remove(), n.helper.appendTo(i._parent), i._refreshOffsets(t), n.position = i._generatePosition(t, !0), i._trigger("fromSortable", t), i.dropped = !1, e.each(i.sortables, function() {
                    this.refreshPositions()
                }))
            })
        }
    }), e.ui.plugin.add("draggable", "cursor", {
        start: function(t, n, i) {
            var s = e("body"),
                r = i.options;
            s.css("cursor") && (r._cursor = s.css("cursor")), s.css("cursor", r.cursor)
        },
        stop: function(t, n, i) {
            var s = i.options;
            s._cursor && e("body").css("cursor", s._cursor)
        }
    }), e.ui.plugin.add("draggable", "opacity", {
        start: function(t, n, i) {
            var s = e(n.helper),
                r = i.options;
            s.css("opacity") && (r._opacity = s.css("opacity")), s.css("opacity", r.opacity)
        },
        stop: function(t, n, i) {
            var s = i.options;
            s._opacity && e(n.helper).css("opacity", s._opacity)
        }
    }), e.ui.plugin.add("draggable", "scroll", {
        start: function(e, t, n) {
            n.scrollParentNotHidden || (n.scrollParentNotHidden = n.helper.scrollParent(!1)), n.scrollParentNotHidden[0] !== n.document[0] && "HTML" !== n.scrollParentNotHidden[0].tagName && (n.overflowOffset = n.scrollParentNotHidden.offset())
        },
        drag: function(t, n, i) {
            var s = i.options,
                r = !1,
                o = i.scrollParentNotHidden[0],
                a = i.document[0];
            o !== a && "HTML" !== o.tagName ? (s.axis && "x" === s.axis || (i.overflowOffset.top + o.offsetHeight - t.pageY < s.scrollSensitivity ? o.scrollTop = r = o.scrollTop + s.scrollSpeed : t.pageY - i.overflowOffset.top < s.scrollSensitivity && (o.scrollTop = r = o.scrollTop - s.scrollSpeed)), s.axis && "y" === s.axis || (i.overflowOffset.left + o.offsetWidth - t.pageX < s.scrollSensitivity ? o.scrollLeft = r = o.scrollLeft + s.scrollSpeed : t.pageX - i.overflowOffset.left < s.scrollSensitivity && (o.scrollLeft = r = o.scrollLeft - s.scrollSpeed))) : (s.axis && "x" === s.axis || (t.pageY - e(a).scrollTop() < s.scrollSensitivity ? r = e(a).scrollTop(e(a).scrollTop() - s.scrollSpeed) : e(window).height() - (t.pageY - e(a).scrollTop()) < s.scrollSensitivity && (r = e(a).scrollTop(e(a).scrollTop() + s.scrollSpeed))), s.axis && "y" === s.axis || (t.pageX - e(a).scrollLeft() < s.scrollSensitivity ? r = e(a).scrollLeft(e(a).scrollLeft() - s.scrollSpeed) : e(window).width() - (t.pageX - e(a).scrollLeft()) < s.scrollSensitivity && (r = e(a).scrollLeft(e(a).scrollLeft() + s.scrollSpeed)))), !1 !== r && e.ui.ddmanager && !s.dropBehaviour && e.ui.ddmanager.prepareOffsets(i, t)
        }
    }), e.ui.plugin.add("draggable", "snap", {
        start: function(t, n, i) {
            var s = i.options;
            i.snapElements = [], e(s.snap.constructor !== String ? s.snap.items || ":data(ui-draggable)" : s.snap).each(function() {
                var t = e(this),
                    n = t.offset();
                this !== i.element[0] && i.snapElements.push({
                    item: this,
                    width: t.outerWidth(),
                    height: t.outerHeight(),
                    top: n.top,
                    left: n.left
                })
            })
        },
        drag: function(t, n, i) {
            var s, r, o, a, l, c, d, u, h, p, f = i.options,
                m = f.snapTolerance,
                g = n.offset.left,
                v = g + i.helperProportions.width,
                _ = n.offset.top,
                y = _ + i.helperProportions.height;
            for (h = i.snapElements.length - 1; h >= 0; h--) c = (l = i.snapElements[h].left - i.margins.left) + i.snapElements[h].width, u = (d = i.snapElements[h].top - i.margins.top) + i.snapElements[h].height, v < l - m || g > c + m || y < d - m || _ > u + m || !e.contains(i.snapElements[h].item.ownerDocument, i.snapElements[h].item) ? (i.snapElements[h].snapping && i.options.snap.release && i.options.snap.release.call(i.element, t, e.extend(i._uiHash(), {
                snapItem: i.snapElements[h].item
            })), i.snapElements[h].snapping = !1) : ("inner" !== f.snapMode && (s = Math.abs(d - y) <= m, r = Math.abs(u - _) <= m, o = Math.abs(l - v) <= m, a = Math.abs(c - g) <= m, s && (n.position.top = i._convertPositionTo("relative", {
                top: d - i.helperProportions.height,
                left: 0
            }).top), r && (n.position.top = i._convertPositionTo("relative", {
                top: u,
                left: 0
            }).top), o && (n.position.left = i._convertPositionTo("relative", {
                top: 0,
                left: l - i.helperProportions.width
            }).left), a && (n.position.left = i._convertPositionTo("relative", {
                top: 0,
                left: c
            }).left)), p = s || r || o || a, "outer" !== f.snapMode && (s = Math.abs(d - _) <= m, r = Math.abs(u - y) <= m, o = Math.abs(l - g) <= m, a = Math.abs(c - v) <= m, s && (n.position.top = i._convertPositionTo("relative", {
                top: d,
                left: 0
            }).top), r && (n.position.top = i._convertPositionTo("relative", {
                top: u - i.helperProportions.height,
                left: 0
            }).top), o && (n.position.left = i._convertPositionTo("relative", {
                top: 0,
                left: l
            }).left), a && (n.position.left = i._convertPositionTo("relative", {
                top: 0,
                left: c - i.helperProportions.width
            }).left)), !i.snapElements[h].snapping && (s || r || o || a || p) && i.options.snap.snap && i.options.snap.snap.call(i.element, t, e.extend(i._uiHash(), {
                snapItem: i.snapElements[h].item
            })), i.snapElements[h].snapping = s || r || o || a || p)
        }
    }), e.ui.plugin.add("draggable", "stack", {
        start: function(t, n, i) {
            var s, r = i.options,
                o = e.makeArray(e(r.stack)).sort(function(t, n) {
                    return (parseInt(e(t).css("zIndex"), 10) || 0) - (parseInt(e(n).css("zIndex"), 10) || 0)
                });
            o.length && (s = parseInt(e(o[0]).css("zIndex"), 10) || 0, e(o).each(function(t) {
                e(this).css("zIndex", s + t)
            }), this.css("zIndex", s + o.length))
        }
    }), e.ui.plugin.add("draggable", "zIndex", {
        start: function(t, n, i) {
            var s = e(n.helper),
                r = i.options;
            s.css("zIndex") && (r._zIndex = s.css("zIndex")), s.css("zIndex", r.zIndex)
        },
        stop: function(t, n, i) {
            var s = i.options;
            s._zIndex && e(n.helper).css("zIndex", s._zIndex)
        }
    });
    e.ui.draggable;
    e.widget("ui.droppable", {
        version: "1.12.1",
        widgetEventPrefix: "drop",
        options: {
            accept: "*",
            addClasses: !0,
            greedy: !1,
            scope: "default",
            tolerance: "intersect",
            activate: null,
            deactivate: null,
            drop: null,
            out: null,
            over: null
        },
        _create: function() {
            var t, n = this.options,
                i = n.accept;
            this.isover = !1, this.isout = !0, this.accept = e.isFunction(i) ? i : function(e) {
                return e.is(i)
            }, this.proportions = function() {
                if (!arguments.length) return t || (t = {
                    width: this.element[0].offsetWidth,
                    height: this.element[0].offsetHeight
                });
                t = arguments[0]
            }, this._addToManager(n.scope), n.addClasses && this._addClass("ui-droppable")
        },
        _addToManager: function(t) {
            e.ui.ddmanager.droppables[t] = e.ui.ddmanager.droppables[t] || [], e.ui.ddmanager.droppables[t].push(this)
        },
        _splice: function(e) {
            for (var t = 0; t < e.length; t++) e[t] === this && e.splice(t, 1)
        },
        _destroy: function() {
            var t = e.ui.ddmanager.droppables[this.options.scope];
            this._splice(t)
        },
        _setOption: function(t, n) {
            if ("accept" === t) this.accept = e.isFunction(n) ? n : function(e) {
                return e.is(n)
            };
            else if ("scope" === t) {
                var i = e.ui.ddmanager.droppables[this.options.scope];
                this._splice(i), this._addToManager(n)
            }
            this._super(t, n)
        },
        _activate: function(t) {
            var n = e.ui.ddmanager.current;
            this._addActiveClass(), n && this._trigger("activate", t, this.ui(n))
        },
        _deactivate: function(t) {
            var n = e.ui.ddmanager.current;
            this._removeActiveClass(), n && this._trigger("deactivate", t, this.ui(n))
        },
        _over: function(t) {
            var n = e.ui.ddmanager.current;
            n && (n.currentItem || n.element)[0] !== this.element[0] && this.accept.call(this.element[0], n.currentItem || n.element) && (this._addHoverClass(), this._trigger("over", t, this.ui(n)))
        },
        _out: function(t) {
            var n = e.ui.ddmanager.current;
            n && (n.currentItem || n.element)[0] !== this.element[0] && this.accept.call(this.element[0], n.currentItem || n.element) && (this._removeHoverClass(), this._trigger("out", t, this.ui(n)))
        },
        _drop: function(t, n) {
            var i = n || e.ui.ddmanager.current,
                r = !1;
            return !(!i || (i.currentItem || i.element)[0] === this.element[0]) && (this.element.find(":data(ui-droppable)").not(".ui-draggable-dragging").each(function() {
                var n = e(this).droppable("instance");
                if (n.options.greedy && !n.options.disabled && n.options.scope === i.options.scope && n.accept.call(n.element[0], i.currentItem || i.element) && s(i, e.extend(n, {
                        offset: n.element.offset()
                    }), n.options.tolerance, t)) return r = !0, !1
            }), !r && (!!this.accept.call(this.element[0], i.currentItem || i.element) && (this._removeActiveClass(), this._removeHoverClass(), this._trigger("drop", t, this.ui(i)), this.element)))
        },
        ui: function(e) {
            return {
                draggable: e.currentItem || e.element,
                helper: e.helper,
                position: e.position,
                offset: e.positionAbs
            }
        },
        _addHoverClass: function() {
            this._addClass("ui-droppable-hover")
        },
        _removeHoverClass: function() {
            this._removeClass("ui-droppable-hover")
        },
        _addActiveClass: function() {
            this._addClass("ui-droppable-active")
        },
        _removeActiveClass: function() {
            this._removeClass("ui-droppable-active")
        }
    });
    var s = e.ui.intersect = function() {
        function e(e, t, n) {
            return e >= t && e < t + n
        }
        return function(t, n, i, s) {
            if (!n.offset) return !1;
            var r = (t.positionAbs || t.position.absolute).left + t.margins.left,
                o = (t.positionAbs || t.position.absolute).top + t.margins.top,
                a = r + t.helperProportions.width,
                l = o + t.helperProportions.height,
                c = n.offset.left,
                d = n.offset.top,
                u = c + n.proportions().width,
                h = d + n.proportions().height;
            switch (i) {
                case "fit":
                    return c <= r && a <= u && d <= o && l <= h;
                case "intersect":
                    return c < r + t.helperProportions.width / 2 && a - t.helperProportions.width / 2 < u && d < o + t.helperProportions.height / 2 && l - t.helperProportions.height / 2 < h;
                case "pointer":
                    return e(s.pageY, d, n.proportions().height) && e(s.pageX, c, n.proportions().width);
                case "touch":
                    return (o >= d && o <= h || l >= d && l <= h || o < d && l > h) && (r >= c && r <= u || a >= c && a <= u || r < c && a > u);
                default:
                    return !1
            }
        }
    }();
    e.ui.ddmanager = {
        current: null,
        droppables: {
            default: []
        },
        prepareOffsets: function(t, n) {
            var i, s, r = e.ui.ddmanager.droppables[t.options.scope] || [],
                o = n ? n.type : null,
                a = (t.currentItem || t.element).find(":data(ui-droppable)").addBack();
            e: for (i = 0; i < r.length; i++)
                if (!(r[i].options.disabled || t && !r[i].accept.call(r[i].element[0], t.currentItem || t.element))) {
                    for (s = 0; s < a.length; s++)
                        if (a[s] === r[i].element[0]) {
                            r[i].proportions().height = 0;
                            continue e
                        }
                    r[i].visible = "none" !== r[i].element.css("display"), r[i].visible && ("mousedown" === o && r[i]._activate.call(r[i], n), r[i].offset = r[i].element.offset(), r[i].proportions({
                        width: r[i].element[0].offsetWidth,
                        height: r[i].element[0].offsetHeight
                    }))
                }
        },
        drop: function(t, n) {
            var i = !1;
            return e.each((e.ui.ddmanager.droppables[t.options.scope] || []).slice(), function() {
                this.options && (!this.options.disabled && this.visible && s(t, this, this.options.tolerance, n) && (i = this._drop.call(this, n) || i), !this.options.disabled && this.visible && this.accept.call(this.element[0], t.currentItem || t.element) && (this.isout = !0, this.isover = !1, this._deactivate.call(this, n)))
            }), i
        },
        dragStart: function(t, n) {
            t.element.parentsUntil("body").on("scroll.droppable", function() {
                t.options.refreshPositions || e.ui.ddmanager.prepareOffsets(t, n)
            })
        },
        drag: function(t, n) {
            t.options.refreshPositions && e.ui.ddmanager.prepareOffsets(t, n), e.each(e.ui.ddmanager.droppables[t.options.scope] || [], function() {
                if (!this.options.disabled && !this.greedyChild && this.visible) {
                    var i, r, o, a = s(t, this, this.options.tolerance, n),
                        l = !a && this.isover ? "isout" : a && !this.isover ? "isover" : null;
                    l && (this.options.greedy && (r = this.options.scope, (o = this.element.parents(":data(ui-droppable)").filter(function() {
                        return e(this).droppable("instance").options.scope === r
                    })).length && ((i = e(o[0]).droppable("instance")).greedyChild = "isover" === l)), i && "isover" === l && (i.isover = !1, i.isout = !0, i._out.call(i, n)), this[l] = !0, this["isout" === l ? "isover" : "isout"] = !1, this["isover" === l ? "_over" : "_out"].call(this, n), i && "isout" === l && (i.isout = !1, i.isover = !0, i._over.call(i, n)))
                }
            })
        },
        dragStop: function(t, n) {
            t.element.parentsUntil("body").off("scroll.droppable"), t.options.refreshPositions || e.ui.ddmanager.prepareOffsets(t, n)
        }
    }, !1 !== e.uiBackCompat && e.widget("ui.droppable", e.ui.droppable, {
        options: {
            hoverClass: !1,
            activeClass: !1
        },
        _addActiveClass: function() {
            this._super(), this.options.activeClass && this.element.addClass(this.options.activeClass)
        },
        _removeActiveClass: function() {
            this._super(), this.options.activeClass && this.element.removeClass(this.options.activeClass)
        },
        _addHoverClass: function() {
            this._super(), this.options.hoverClass && this.element.addClass(this.options.hoverClass)
        },
        _removeHoverClass: function() {
            this._super(), this.options.hoverClass && this.element.removeClass(this.options.hoverClass)
        }
    });
    e.ui.droppable, e.widget("ui.selectable", e.ui.mouse, {
        version: "1.12.1",
        options: {
            appendTo: "body",
            autoRefresh: !0,
            distance: 0,
            filter: "*",
            tolerance: "touch",
            selected: null,
            selecting: null,
            start: null,
            stop: null,
            unselected: null,
            unselecting: null
        },
        _create: function() {
            var t = this;
            this._addClass("ui-selectable"), this.dragged = !1, this.refresh = function() {
                t.elementPos = e(t.element[0]).offset(), t.selectees = e(t.options.filter, t.element[0]), t._addClass(t.selectees, "ui-selectee"), t.selectees.each(function() {
                    var n = e(this),
                        i = n.offset(),
                        s = {
                            left: i.left - t.elementPos.left,
                            top: i.top - t.elementPos.top
                        };
                    e.data(this, "selectable-item", {
                        element: this,
                        $element: n,
                        left: s.left,
                        top: s.top,
                        right: s.left + n.outerWidth(),
                        bottom: s.top + n.outerHeight(),
                        startselected: !1,
                        selected: n.hasClass("ui-selected"),
                        selecting: n.hasClass("ui-selecting"),
                        unselecting: n.hasClass("ui-unselecting")
                    })
                })
            }, this.refresh(), this._mouseInit(), this.helper = e("<div>"), this._addClass(this.helper, "ui-selectable-helper")
        },
        _destroy: function() {
            this.selectees.removeData("selectable-item"), this._mouseDestroy()
        },
        _mouseStart: function(t) {
            var n = this,
                i = this.options;
            this.opos = [t.pageX, t.pageY], this.elementPos = e(this.element[0]).offset(), this.options.disabled || (this.selectees = e(i.filter, this.element[0]), this._trigger("start", t), e(i.appendTo).append(this.helper), this.helper.css({
                left: t.pageX,
                top: t.pageY,
                width: 0,
                height: 0
            }), i.autoRefresh && this.refresh(), this.selectees.filter(".ui-selected").each(function() {
                var i = e.data(this, "selectable-item");
                i.startselected = !0, t.metaKey || t.ctrlKey || (n._removeClass(i.$element, "ui-selected"), i.selected = !1, n._addClass(i.$element, "ui-unselecting"), i.unselecting = !0, n._trigger("unselecting", t, {
                    unselecting: i.element
                }))
            }), e(t.target).parents().addBack().each(function() {
                var i, s = e.data(this, "selectable-item");
                if (s) return i = !t.metaKey && !t.ctrlKey || !s.$element.hasClass("ui-selected"), n._removeClass(s.$element, i ? "ui-unselecting" : "ui-selected")._addClass(s.$element, i ? "ui-selecting" : "ui-unselecting"), s.unselecting = !i, s.selecting = i, s.selected = i, i ? n._trigger("selecting", t, {
                    selecting: s.element
                }) : n._trigger("unselecting", t, {
                    unselecting: s.element
                }), !1
            }))
        },
        _mouseDrag: function(t) {
            if (this.dragged = !0, !this.options.disabled) {
                var n, i = this,
                    s = this.options,
                    r = this.opos[0],
                    o = this.opos[1],
                    a = t.pageX,
                    l = t.pageY;
                return r > a && (n = a, a = r, r = n), o > l && (n = l, l = o, o = n), this.helper.css({
                    left: r,
                    top: o,
                    width: a - r,
                    height: l - o
                }), this.selectees.each(function() {
                    var n = e.data(this, "selectable-item"),
                        c = !1,
                        d = {};
                    n && n.element !== i.element[0] && (d.left = n.left + i.elementPos.left, d.right = n.right + i.elementPos.left, d.top = n.top + i.elementPos.top, d.bottom = n.bottom + i.elementPos.top, "touch" === s.tolerance ? c = !(d.left > a || d.right < r || d.top > l || d.bottom < o) : "fit" === s.tolerance && (c = d.left > r && d.right < a && d.top > o && d.bottom < l), c ? (n.selected && (i._removeClass(n.$element, "ui-selected"), n.selected = !1), n.unselecting && (i._removeClass(n.$element, "ui-unselecting"), n.unselecting = !1), n.selecting || (i._addClass(n.$element, "ui-selecting"), n.selecting = !0, i._trigger("selecting", t, {
                        selecting: n.element
                    }))) : (n.selecting && ((t.metaKey || t.ctrlKey) && n.startselected ? (i._removeClass(n.$element, "ui-selecting"), n.selecting = !1, i._addClass(n.$element, "ui-selected"), n.selected = !0) : (i._removeClass(n.$element, "ui-selecting"), n.selecting = !1, n.startselected && (i._addClass(n.$element, "ui-unselecting"), n.unselecting = !0), i._trigger("unselecting", t, {
                        unselecting: n.element
                    }))), n.selected && (t.metaKey || t.ctrlKey || n.startselected || (i._removeClass(n.$element, "ui-selected"), n.selected = !1, i._addClass(n.$element, "ui-unselecting"), n.unselecting = !0, i._trigger("unselecting", t, {
                        unselecting: n.element
                    })))))
                }), !1
            }
        },
        _mouseStop: function(t) {
            var n = this;
            return this.dragged = !1, e(".ui-unselecting", this.element[0]).each(function() {
                var i = e.data(this, "selectable-item");
                n._removeClass(i.$element, "ui-unselecting"), i.unselecting = !1, i.startselected = !1, n._trigger("unselected", t, {
                    unselected: i.element
                })
            }), e(".ui-selecting", this.element[0]).each(function() {
                var i = e.data(this, "selectable-item");
                n._removeClass(i.$element, "ui-selecting")._addClass(i.$element, "ui-selected"), i.selecting = !1, i.selected = !0, i.startselected = !0, n._trigger("selected", t, {
                    selected: i.element
                })
            }), this._trigger("stop", t), this.helper.remove(), !1
        }
    }), e.widget("ui.sortable", e.ui.mouse, {
        version: "1.12.1",
        widgetEventPrefix: "sort",
        ready: !1,
        options: {
            appendTo: "parent",
            axis: !1,
            connectWith: !1,
            containment: !1,
            cursor: "auto",
            cursorAt: !1,
            dropOnEmpty: !0,
            forcePlaceholderSize: !1,
            forceHelperSize: !1,
            grid: !1,
            handle: !1,
            helper: "original",
            items: "> *",
            opacity: !1,
            placeholder: !1,
            revert: !1,
            scroll: !0,
            scrollSensitivity: 20,
            scrollSpeed: 20,
            scope: "default",
            tolerance: "intersect",
            zIndex: 1e3,
            activate: null,
            beforeStop: null,
            change: null,
            deactivate: null,
            out: null,
            over: null,
            receive: null,
            remove: null,
            sort: null,
            start: null,
            stop: null,
            update: null
        },
        _isOverAxis: function(e, t, n) {
            return e >= t && e < t + n
        },
        _isFloating: function(e) {
            return /left|right/.test(e.css("float")) || /inline|table-cell/.test(e.css("display"))
        },
        _create: function() {
            this.containerCache = {}, this._addClass("ui-sortable"), this.refresh(), this.offset = this.element.offset(), this._mouseInit(), this._setHandleClassName(), this.ready = !0
        },
        _setOption: function(e, t) {
            this._super(e, t), "handle" === e && this._setHandleClassName()
        },
        _setHandleClassName: function() {
            var t = this;
            this._removeClass(this.element.find(".ui-sortable-handle"), "ui-sortable-handle"), e.each(this.items, function() {
                t._addClass(this.instance.options.handle ? this.item.find(this.instance.options.handle) : this.item, "ui-sortable-handle")
            })
        },
        _destroy: function() {
            this._mouseDestroy();
            for (var e = this.items.length - 1; e >= 0; e--) this.items[e].item.removeData(this.widgetName + "-item");
            return this
        },
        _mouseCapture: function(t, n) {
            var i = null,
                s = !1,
                r = this;
            return !this.reverting && (!this.options.disabled && "static" !== this.options.type && (this._refreshItems(t), e(t.target).parents().each(function() {
                if (e.data(this, r.widgetName + "-item") === r) return i = e(this), !1
            }), e.data(t.target, r.widgetName + "-item") === r && (i = e(t.target)), !!i && (!(this.options.handle && !n && (e(this.options.handle, i).find("*").addBack().each(function() {
                this === t.target && (s = !0)
            }), !s)) && (this.currentItem = i, this._removeCurrentsFromItems(), !0))))
        },
        _mouseStart: function(t, n, i) {
            var s, r, o = this.options;
            if (this.currentContainer = this, this.refreshPositions(), this.helper = this._createHelper(t), this._cacheHelperProportions(), this._cacheMargins(), this.scrollParent = this.helper.scrollParent(), this.offset = this.currentItem.offset(), this.offset = {
                    top: this.offset.top - this.margins.top,
                    left: this.offset.left - this.margins.left
                }, e.extend(this.offset, {
                    click: {
                        left: t.pageX - this.offset.left,
                        top: t.pageY - this.offset.top
                    },
                    parent: this._getParentOffset(),
                    relative: this._getRelativeOffset()
                }), this.helper.css("position", "absolute"), this.cssPosition = this.helper.css("position"), this.originalPosition = this._generatePosition(t), this.originalPageX = t.pageX, this.originalPageY = t.pageY, o.cursorAt && this._adjustOffsetFromHelper(o.cursorAt), this.domPosition = {
                    prev: this.currentItem.prev()[0],
                    parent: this.currentItem.parent()[0]
                }, this.helper[0] !== this.currentItem[0] && this.currentItem.hide(), this._createPlaceholder(), o.containment && this._setContainment(), o.cursor && "auto" !== o.cursor && (r = this.document.find("body"), this.storedCursor = r.css("cursor"), r.css("cursor", o.cursor), this.storedStylesheet = e("<style>*{ cursor: " + o.cursor + " !important; }</style>").appendTo(r)), o.opacity && (this.helper.css("opacity") && (this._storedOpacity = this.helper.css("opacity")), this.helper.css("opacity", o.opacity)), o.zIndex && (this.helper.css("zIndex") && (this._storedZIndex = this.helper.css("zIndex")), this.helper.css("zIndex", o.zIndex)), this.scrollParent[0] !== this.document[0] && "HTML" !== this.scrollParent[0].tagName && (this.overflowOffset = this.scrollParent.offset()), this._trigger("start", t, this._uiHash()), this._preserveHelperProportions || this._cacheHelperProportions(), !i)
                for (s = this.containers.length - 1; s >= 0; s--) this.containers[s]._trigger("activate", t, this._uiHash(this));
            return e.ui.ddmanager && (e.ui.ddmanager.current = this), e.ui.ddmanager && !o.dropBehaviour && e.ui.ddmanager.prepareOffsets(this, t), this.dragging = !0, this._addClass(this.helper, "ui-sortable-helper"), this._mouseDrag(t), !0
        },
        _mouseDrag: function(t) {
            var n, i, s, r, o = this.options,
                a = !1;
            for (this.position = this._generatePosition(t), this.positionAbs = this._convertPositionTo("absolute"), this.lastPositionAbs || (this.lastPositionAbs = this.positionAbs), this.options.scroll && (this.scrollParent[0] !== this.document[0] && "HTML" !== this.scrollParent[0].tagName ? (this.overflowOffset.top + this.scrollParent[0].offsetHeight - t.pageY < o.scrollSensitivity ? this.scrollParent[0].scrollTop = a = this.scrollParent[0].scrollTop + o.scrollSpeed : t.pageY - this.overflowOffset.top < o.scrollSensitivity && (this.scrollParent[0].scrollTop = a = this.scrollParent[0].scrollTop - o.scrollSpeed), this.overflowOffset.left + this.scrollParent[0].offsetWidth - t.pageX < o.scrollSensitivity ? this.scrollParent[0].scrollLeft = a = this.scrollParent[0].scrollLeft + o.scrollSpeed : t.pageX - this.overflowOffset.left < o.scrollSensitivity && (this.scrollParent[0].scrollLeft = a = this.scrollParent[0].scrollLeft - o.scrollSpeed)) : (t.pageY - this.document.scrollTop() < o.scrollSensitivity ? a = this.document.scrollTop(this.document.scrollTop() - o.scrollSpeed) : this.window.height() - (t.pageY - this.document.scrollTop()) < o.scrollSensitivity && (a = this.document.scrollTop(this.document.scrollTop() + o.scrollSpeed)), t.pageX - this.document.scrollLeft() < o.scrollSensitivity ? a = this.document.scrollLeft(this.document.scrollLeft() - o.scrollSpeed) : this.window.width() - (t.pageX - this.document.scrollLeft()) < o.scrollSensitivity && (a = this.document.scrollLeft(this.document.scrollLeft() + o.scrollSpeed))), !1 !== a && e.ui.ddmanager && !o.dropBehaviour && e.ui.ddmanager.prepareOffsets(this, t)), this.positionAbs = this._convertPositionTo("absolute"), this.options.axis && "y" === this.options.axis || (this.helper[0].style.left = this.position.left + "px"), this.options.axis && "x" === this.options.axis || (this.helper[0].style.top = this.position.top + "px"), n = this.items.length - 1; n >= 0; n--)
                if (i = this.items[n], s = i.item[0], (r = this._intersectsWithPointer(i)) && i.instance === this.currentContainer && !(s === this.currentItem[0] || this.placeholder[1 === r ? "next" : "prev"]()[0] === s || e.contains(this.placeholder[0], s) || "semi-dynamic" === this.options.type && e.contains(this.element[0], s))) {
                    if (this.direction = 1 === r ? "down" : "up", "pointer" !== this.options.tolerance && !this._intersectsWithSides(i)) break;
                    this._rearrange(t, i), this._trigger("change", t, this._uiHash());
                    break
                }
            return this._contactContainers(t), e.ui.ddmanager && e.ui.ddmanager.drag(this, t), this._trigger("sort", t, this._uiHash()), this.lastPositionAbs = this.positionAbs, !1
        },
        _mouseStop: function(t, n) {
            if (t) {
                if (e.ui.ddmanager && !this.options.dropBehaviour && e.ui.ddmanager.drop(this, t), this.options.revert) {
                    var i = this,
                        s = this.placeholder.offset(),
                        r = this.options.axis,
                        o = {};
                    r && "x" !== r || (o.left = s.left - this.offset.parent.left - this.margins.left + (this.offsetParent[0] === this.document[0].body ? 0 : this.offsetParent[0].scrollLeft)), r && "y" !== r || (o.top = s.top - this.offset.parent.top - this.margins.top + (this.offsetParent[0] === this.document[0].body ? 0 : this.offsetParent[0].scrollTop)), this.reverting = !0, e(this.helper).animate(o, parseInt(this.options.revert, 10) || 500, function() {
                        i._clear(t)
                    })
                } else this._clear(t, n);
                return !1
            }
        },
        cancel: function() {
            if (this.dragging) {
                this._mouseUp(new e.Event("mouseup", {
                    target: null
                })), "original" === this.options.helper ? (this.currentItem.css(this._storedCSS), this._removeClass(this.currentItem, "ui-sortable-helper")) : this.currentItem.show();
                for (var t = this.containers.length - 1; t >= 0; t--) this.containers[t]._trigger("deactivate", null, this._uiHash(this)), this.containers[t].containerCache.over && (this.containers[t]._trigger("out", null, this._uiHash(this)), this.containers[t].containerCache.over = 0)
            }
            return this.placeholder && (this.placeholder[0].parentNode && this.placeholder[0].parentNode.removeChild(this.placeholder[0]), "original" !== this.options.helper && this.helper && this.helper[0].parentNode && this.helper.remove(), e.extend(this, {
                helper: null,
                dragging: !1,
                reverting: !1,
                _noFinalSort: null
            }), this.domPosition.prev ? e(this.domPosition.prev).after(this.currentItem) : e(this.domPosition.parent).prepend(this.currentItem)), this
        },
        serialize: function(t) {
            var n = this._getItemsAsjQuery(t && t.connected),
                i = [];
            return t = t || {}, e(n).each(function() {
                var n = (e(t.item || this).attr(t.attribute || "id") || "").match(t.expression || /(.+)[\-=_](.+)/);
                n && i.push((t.key || n[1] + "[]") + "=" + (t.key && t.expression ? n[1] : n[2]))
            }), !i.length && t.key && i.push(t.key + "="), i.join("&")
        },
        toArray: function(t) {
            var n = this._getItemsAsjQuery(t && t.connected),
                i = [];
            return t = t || {}, n.each(function() {
                i.push(e(t.item || this).attr(t.attribute || "id") || "")
            }), i
        },
        _intersectsWith: function(e) {
            var t = this.positionAbs.left,
                n = t + this.helperProportions.width,
                i = this.positionAbs.top,
                s = i + this.helperProportions.height,
                r = e.left,
                o = r + e.width,
                a = e.top,
                l = a + e.height,
                c = this.offset.click.top,
                d = this.offset.click.left,
                u = "x" === this.options.axis || i + c > a && i + c < l,
                h = "y" === this.options.axis || t + d > r && t + d < o,
                p = u && h;
            return "pointer" === this.options.tolerance || this.options.forcePointerForContainers || "pointer" !== this.options.tolerance && this.helperProportions[this.floating ? "width" : "height"] > e[this.floating ? "width" : "height"] ? p : r < t + this.helperProportions.width / 2 && n - this.helperProportions.width / 2 < o && a < i + this.helperProportions.height / 2 && s - this.helperProportions.height / 2 < l
        },
        _intersectsWithPointer: function(e) {
            var t, n, i = "x" === this.options.axis || this._isOverAxis(this.positionAbs.top + this.offset.click.top, e.top, e.height),
                s = "y" === this.options.axis || this._isOverAxis(this.positionAbs.left + this.offset.click.left, e.left, e.width);
            return !(!i || !s) && (t = this._getDragVerticalDirection(), n = this._getDragHorizontalDirection(), this.floating ? "right" === n || "down" === t ? 2 : 1 : t && ("down" === t ? 2 : 1))
        },
        _intersectsWithSides: function(e) {
            var t = this._isOverAxis(this.positionAbs.top + this.offset.click.top, e.top + e.height / 2, e.height),
                n = this._isOverAxis(this.positionAbs.left + this.offset.click.left, e.left + e.width / 2, e.width),
                i = this._getDragVerticalDirection(),
                s = this._getDragHorizontalDirection();
            return this.floating && s ? "right" === s && n || "left" === s && !n : i && ("down" === i && t || "up" === i && !t)
        },
        _getDragVerticalDirection: function() {
            var e = this.positionAbs.top - this.lastPositionAbs.top;
            return 0 !== e && (e > 0 ? "down" : "up")
        },
        _getDragHorizontalDirection: function() {
            var e = this.positionAbs.left - this.lastPositionAbs.left;
            return 0 !== e && (e > 0 ? "right" : "left")
        },
        refresh: function(e) {
            return this._refreshItems(e), this._setHandleClassName(), this.refreshPositions(), this
        },
        _connectWith: function() {
            var e = this.options;
            return e.connectWith.constructor === String ? [e.connectWith] : e.connectWith
        },
        _getItemsAsjQuery: function(t) {
            function n() {
                a.push(this)
            }
            var i, s, r, o, a = [],
                l = [],
                c = this._connectWith();
            if (c && t)
                for (i = c.length - 1; i >= 0; i--)
                    for (s = (r = e(c[i], this.document[0])).length - 1; s >= 0; s--)(o = e.data(r[s], this.widgetFullName)) && o !== this && !o.options.disabled && l.push([e.isFunction(o.options.items) ? o.options.items.call(o.element) : e(o.options.items, o.element).not(".ui-sortable-helper").not(".ui-sortable-placeholder"), o]);
            for (l.push([e.isFunction(this.options.items) ? this.options.items.call(this.element, null, {
                    options: this.options,
                    item: this.currentItem
                }) : e(this.options.items, this.element).not(".ui-sortable-helper").not(".ui-sortable-placeholder"), this]), i = l.length - 1; i >= 0; i--) l[i][0].each(n);
            return e(a)
        },
        _removeCurrentsFromItems: function() {
            var t = this.currentItem.find(":data(" + this.widgetName + "-item)");
            this.items = e.grep(this.items, function(e) {
                for (var n = 0; n < t.length; n++)
                    if (t[n] === e.item[0]) return !1;
                return !0
            })
        },
        _refreshItems: function(t) {
            this.items = [], this.containers = [this];
            var n, i, s, r, o, a, l, c, d = this.items,
                u = [
                    [e.isFunction(this.options.items) ? this.options.items.call(this.element[0], t, {
                        item: this.currentItem
                    }) : e(this.options.items, this.element), this]
                ],
                h = this._connectWith();
            if (h && this.ready)
                for (n = h.length - 1; n >= 0; n--)
                    for (i = (s = e(h[n], this.document[0])).length - 1; i >= 0; i--)(r = e.data(s[i], this.widgetFullName)) && r !== this && !r.options.disabled && (u.push([e.isFunction(r.options.items) ? r.options.items.call(r.element[0], t, {
                        item: this.currentItem
                    }) : e(r.options.items, r.element), r]), this.containers.push(r));
            for (n = u.length - 1; n >= 0; n--)
                for (o = u[n][1], i = 0, c = (a = u[n][0]).length; i < c; i++)(l = e(a[i])).data(this.widgetName + "-item", o), d.push({
                    item: l,
                    instance: o,
                    width: 0,
                    height: 0,
                    left: 0,
                    top: 0
                })
        },
        refreshPositions: function(t) {
            this.floating = !!this.items.length && ("x" === this.options.axis || this._isFloating(this.items[0].item)), this.offsetParent && this.helper && (this.offset.parent = this._getParentOffset());
            var n, i, s, r;
            for (n = this.items.length - 1; n >= 0; n--)(i = this.items[n]).instance !== this.currentContainer && this.currentContainer && i.item[0] !== this.currentItem[0] || (s = this.options.toleranceElement ? e(this.options.toleranceElement, i.item) : i.item, t || (i.width = s.outerWidth(), i.height = s.outerHeight()), r = s.offset(), i.left = r.left, i.top = r.top);
            if (this.options.custom && this.options.custom.refreshContainers) this.options.custom.refreshContainers.call(this);
            else
                for (n = this.containers.length - 1; n >= 0; n--) r = this.containers[n].element.offset(), this.containers[n].containerCache.left = r.left, this.containers[n].containerCache.top = r.top, this.containers[n].containerCache.width = this.containers[n].element.outerWidth(), this.containers[n].containerCache.height = this.containers[n].element.outerHeight();
            return this
        },
        _createPlaceholder: function(t) {
            var n, i = (t = t || this).options;
            i.placeholder && i.placeholder.constructor !== String || (n = i.placeholder, i.placeholder = {
                element: function() {
                    var i = t.currentItem[0].nodeName.toLowerCase(),
                        s = e("<" + i + ">", t.document[0]);
                    return t._addClass(s, "ui-sortable-placeholder", n || t.currentItem[0].className)._removeClass(s, "ui-sortable-helper"), "tbody" === i ? t._createTrPlaceholder(t.currentItem.find("tr").eq(0), e("<tr>", t.document[0]).appendTo(s)) : "tr" === i ? t._createTrPlaceholder(t.currentItem, s) : "img" === i && s.attr("src", t.currentItem.attr("src")), n || s.css("visibility", "hidden"), s
                },
                update: function(e, s) {
                    n && !i.forcePlaceholderSize || (s.height() || s.height(t.currentItem.innerHeight() - parseInt(t.currentItem.css("paddingTop") || 0, 10) - parseInt(t.currentItem.css("paddingBottom") || 0, 10)), s.width() || s.width(t.currentItem.innerWidth() - parseInt(t.currentItem.css("paddingLeft") || 0, 10) - parseInt(t.currentItem.css("paddingRight") || 0, 10)))
                }
            }), t.placeholder = e(i.placeholder.element.call(t.element, t.currentItem)), t.currentItem.after(t.placeholder), i.placeholder.update(t, t.placeholder)
        },
        _createTrPlaceholder: function(t, n) {
            var i = this;
            t.children().each(function() {
                e("<td>&#160;</td>", i.document[0]).attr("colspan", e(this).attr("colspan") || 1).appendTo(n)
            })
        },
        _contactContainers: function(t) {
            var n, i, s, r, o, a, l, c, d, u, h = null,
                p = null;
            for (n = this.containers.length - 1; n >= 0; n--)
                if (!e.contains(this.currentItem[0], this.containers[n].element[0]))
                    if (this._intersectsWith(this.containers[n].containerCache)) {
                        if (h && e.contains(this.containers[n].element[0], h.element[0])) continue;
                        h = this.containers[n], p = n
                    } else this.containers[n].containerCache.over && (this.containers[n]._trigger("out", t, this._uiHash(this)), this.containers[n].containerCache.over = 0);
            if (h)
                if (1 === this.containers.length) this.containers[p].containerCache.over || (this.containers[p]._trigger("over", t, this._uiHash(this)), this.containers[p].containerCache.over = 1);
                else {
                    for (s = 1e4, r = null, o = (d = h.floating || this._isFloating(this.currentItem)) ? "left" : "top", a = d ? "width" : "height", u = d ? "pageX" : "pageY", i = this.items.length - 1; i >= 0; i--) e.contains(this.containers[p].element[0], this.items[i].item[0]) && this.items[i].item[0] !== this.currentItem[0] && (l = this.items[i].item.offset()[o], c = !1, t[u] - l > this.items[i][a] / 2 && (c = !0), Math.abs(t[u] - l) < s && (s = Math.abs(t[u] - l), r = this.items[i], this.direction = c ? "up" : "down"));
                    if (!r && !this.options.dropOnEmpty) return;
                    if (this.currentContainer === this.containers[p]) return void(this.currentContainer.containerCache.over || (this.containers[p]._trigger("over", t, this._uiHash()), this.currentContainer.containerCache.over = 1));
                    r ? this._rearrange(t, r, null, !0) : this._rearrange(t, null, this.containers[p].element, !0), this._trigger("change", t, this._uiHash()), this.containers[p]._trigger("change", t, this._uiHash(this)), this.currentContainer = this.containers[p], this.options.placeholder.update(this.currentContainer, this.placeholder), this.containers[p]._trigger("over", t, this._uiHash(this)), this.containers[p].containerCache.over = 1
                }
        },
        _createHelper: function(t) {
            var n = this.options,
                i = e.isFunction(n.helper) ? e(n.helper.apply(this.element[0], [t, this.currentItem])) : "clone" === n.helper ? this.currentItem.clone() : this.currentItem;
            return i.parents("body").length || e("parent" !== n.appendTo ? n.appendTo : this.currentItem[0].parentNode)[0].appendChild(i[0]), i[0] === this.currentItem[0] && (this._storedCSS = {
                width: this.currentItem[0].style.width,
                height: this.currentItem[0].style.height,
                position: this.currentItem.css("position"),
                top: this.currentItem.css("top"),
                left: this.currentItem.css("left")
            }), i[0].style.width && !n.forceHelperSize || i.width(this.currentItem.width()), i[0].style.height && !n.forceHelperSize || i.height(this.currentItem.height()), i
        },
        _adjustOffsetFromHelper: function(t) {
            "string" == typeof t && (t = t.split(" ")), e.isArray(t) && (t = {
                left: +t[0],
                top: +t[1] || 0
            }), "left" in t && (this.offset.click.left = t.left + this.margins.left), "right" in t && (this.offset.click.left = this.helperProportions.width - t.right + this.margins.left), "top" in t && (this.offset.click.top = t.top + this.margins.top), "bottom" in t && (this.offset.click.top = this.helperProportions.height - t.bottom + this.margins.top)
        },
        _getParentOffset: function() {
            this.offsetParent = this.helper.offsetParent();
            var t = this.offsetParent.offset();
            return "absolute" === this.cssPosition && this.scrollParent[0] !== this.document[0] && e.contains(this.scrollParent[0], this.offsetParent[0]) && (t.left += this.scrollParent.scrollLeft(), t.top += this.scrollParent.scrollTop()), (this.offsetParent[0] === this.document[0].body || this.offsetParent[0].tagName && "html" === this.offsetParent[0].tagName.toLowerCase() && e.ui.ie) && (t = {
                top: 0,
                left: 0
            }), {
                top: t.top + (parseInt(this.offsetParent.css("borderTopWidth"), 10) || 0),
                left: t.left + (parseInt(this.offsetParent.css("borderLeftWidth"), 10) || 0)
            }
        },
        _getRelativeOffset: function() {
            if ("relative" === this.cssPosition) {
                var e = this.currentItem.position();
                return {
                    top: e.top - (parseInt(this.helper.css("top"), 10) || 0) + this.scrollParent.scrollTop(),
                    left: e.left - (parseInt(this.helper.css("left"), 10) || 0) + this.scrollParent.scrollLeft()
                }
            }
            return {
                top: 0,
                left: 0
            }
        },
        _cacheMargins: function() {
            this.margins = {
                left: parseInt(this.currentItem.css("marginLeft"), 10) || 0,
                top: parseInt(this.currentItem.css("marginTop"), 10) || 0
            }
        },
        _cacheHelperProportions: function() {
            this.helperProportions = {
                width: this.helper.outerWidth(),
                height: this.helper.outerHeight()
            }
        },
        _setContainment: function() {
            var t, n, i, s = this.options;
            "parent" === s.containment && (s.containment = this.helper[0].parentNode), "document" !== s.containment && "window" !== s.containment || (this.containment = [0 - this.offset.relative.left - this.offset.parent.left, 0 - this.offset.relative.top - this.offset.parent.top, "document" === s.containment ? this.document.width() : this.window.width() - this.helperProportions.width - this.margins.left, ("document" === s.containment ? this.document.height() || document.body.parentNode.scrollHeight : this.window.height() || this.document[0].body.parentNode.scrollHeight) - this.helperProportions.height - this.margins.top]), /^(document|window|parent)$/.test(s.containment) || (t = e(s.containment)[0], n = e(s.containment).offset(), i = "hidden" !== e(t).css("overflow"), this.containment = [n.left + (parseInt(e(t).css("borderLeftWidth"), 10) || 0) + (parseInt(e(t).css("paddingLeft"), 10) || 0) - this.margins.left, n.top + (parseInt(e(t).css("borderTopWidth"), 10) || 0) + (parseInt(e(t).css("paddingTop"), 10) || 0) - this.margins.top, n.left + (i ? Math.max(t.scrollWidth, t.offsetWidth) : t.offsetWidth) - (parseInt(e(t).css("borderLeftWidth"), 10) || 0) - (parseInt(e(t).css("paddingRight"), 10) || 0) - this.helperProportions.width - this.margins.left, n.top + (i ? Math.max(t.scrollHeight, t.offsetHeight) : t.offsetHeight) - (parseInt(e(t).css("borderTopWidth"), 10) || 0) - (parseInt(e(t).css("paddingBottom"), 10) || 0) - this.helperProportions.height - this.margins.top])
        },
        _convertPositionTo: function(t, n) {
            n || (n = this.position);
            var i = "absolute" === t ? 1 : -1,
                s = "absolute" !== this.cssPosition || this.scrollParent[0] !== this.document[0] && e.contains(this.scrollParent[0], this.offsetParent[0]) ? this.scrollParent : this.offsetParent,
                r = /(html|body)/i.test(s[0].tagName);
            return {
                top: n.top + this.offset.relative.top * i + this.offset.parent.top * i - ("fixed" === this.cssPosition ? -this.scrollParent.scrollTop() : r ? 0 : s.scrollTop()) * i,
                left: n.left + this.offset.relative.left * i + this.offset.parent.left * i - ("fixed" === this.cssPosition ? -this.scrollParent.scrollLeft() : r ? 0 : s.scrollLeft()) * i
            }
        },
        _generatePosition: function(t) {
            var n, i, s = this.options,
                r = t.pageX,
                o = t.pageY,
                a = "absolute" !== this.cssPosition || this.scrollParent[0] !== this.document[0] && e.contains(this.scrollParent[0], this.offsetParent[0]) ? this.scrollParent : this.offsetParent,
                l = /(html|body)/i.test(a[0].tagName);
            return "relative" !== this.cssPosition || this.scrollParent[0] !== this.document[0] && this.scrollParent[0] !== this.offsetParent[0] || (this.offset.relative = this._getRelativeOffset()), this.originalPosition && (this.containment && (t.pageX - this.offset.click.left < this.containment[0] && (r = this.containment[0] + this.offset.click.left), t.pageY - this.offset.click.top < this.containment[1] && (o = this.containment[1] + this.offset.click.top), t.pageX - this.offset.click.left > this.containment[2] && (r = this.containment[2] + this.offset.click.left), t.pageY - this.offset.click.top > this.containment[3] && (o = this.containment[3] + this.offset.click.top)), s.grid && (n = this.originalPageY + Math.round((o - this.originalPageY) / s.grid[1]) * s.grid[1], o = this.containment ? n - this.offset.click.top >= this.containment[1] && n - this.offset.click.top <= this.containment[3] ? n : n - this.offset.click.top >= this.containment[1] ? n - s.grid[1] : n + s.grid[1] : n, i = this.originalPageX + Math.round((r - this.originalPageX) / s.grid[0]) * s.grid[0], r = this.containment ? i - this.offset.click.left >= this.containment[0] && i - this.offset.click.left <= this.containment[2] ? i : i - this.offset.click.left >= this.containment[0] ? i - s.grid[0] : i + s.grid[0] : i)), {
                top: o - this.offset.click.top - this.offset.relative.top - this.offset.parent.top + ("fixed" === this.cssPosition ? -this.scrollParent.scrollTop() : l ? 0 : a.scrollTop()),
                left: r - this.offset.click.left - this.offset.relative.left - this.offset.parent.left + ("fixed" === this.cssPosition ? -this.scrollParent.scrollLeft() : l ? 0 : a.scrollLeft())
            }
        },
        _rearrange: function(e, t, n, i) {
            n ? n[0].appendChild(this.placeholder[0]) : t.item[0].parentNode.insertBefore(this.placeholder[0], "down" === this.direction ? t.item[0] : t.item[0].nextSibling), this.counter = this.counter ? ++this.counter : 1;
            var s = this.counter;
            this._delay(function() {
                s === this.counter && this.refreshPositions(!i)
            })
        },
        _clear: function(e, t) {
            function n(e, t, n) {
                return function(i) {
                    n._trigger(e, i, t._uiHash(t))
                }
            }
            this.reverting = !1;
            var i, s = [];
            if (!this._noFinalSort && this.currentItem.parent().length && this.placeholder.before(this.currentItem), this._noFinalSort = null, this.helper[0] === this.currentItem[0]) {
                for (i in this._storedCSS) "auto" !== this._storedCSS[i] && "static" !== this._storedCSS[i] || (this._storedCSS[i] = "");
                this.currentItem.css(this._storedCSS), this._removeClass(this.currentItem, "ui-sortable-helper")
            } else this.currentItem.show();
            for (this.fromOutside && !t && s.push(function(e) {
                    this._trigger("receive", e, this._uiHash(this.fromOutside))
                }), !this.fromOutside && this.domPosition.prev === this.currentItem.prev().not(".ui-sortable-helper")[0] && this.domPosition.parent === this.currentItem.parent()[0] || t || s.push(function(e) {
                    this._trigger("update", e, this._uiHash())
                }), this !== this.currentContainer && (t || (s.push(function(e) {
                    this._trigger("remove", e, this._uiHash())
                }), s.push(function(e) {
                    return function(t) {
                        e._trigger("receive", t, this._uiHash(this))
                    }
                }.call(this, this.currentContainer)), s.push(function(e) {
                    return function(t) {
                        e._trigger("update", t, this._uiHash(this))
                    }
                }.call(this, this.currentContainer)))), i = this.containers.length - 1; i >= 0; i--) t || s.push(n("deactivate", this, this.containers[i])), this.containers[i].containerCache.over && (s.push(n("out", this, this.containers[i])), this.containers[i].containerCache.over = 0);
            if (this.storedCursor && (this.document.find("body").css("cursor", this.storedCursor), this.storedStylesheet.remove()), this._storedOpacity && this.helper.css("opacity", this._storedOpacity), this._storedZIndex && this.helper.css("zIndex", "auto" === this._storedZIndex ? "" : this._storedZIndex), this.dragging = !1, t || this._trigger("beforeStop", e, this._uiHash()), this.placeholder[0].parentNode.removeChild(this.placeholder[0]), this.cancelHelperRemoval || (this.helper[0] !== this.currentItem[0] && this.helper.remove(), this.helper = null), !t) {
                for (i = 0; i < s.length; i++) s[i].call(this, e);
                this._trigger("stop", e, this._uiHash())
            }
            return this.fromOutside = !1, !this.cancelHelperRemoval
        },
        _trigger: function() {
            !1 === e.Widget.prototype._trigger.apply(this, arguments) && this.cancel()
        },
        _uiHash: function(t) {
            var n = t || this;
            return {
                helper: n.helper,
                placeholder: n.placeholder || e([]),
                position: n.position,
                originalPosition: n.originalPosition,
                offset: n.positionAbs,
                item: n.currentItem,
                sender: t ? t.element : null
            }
        }
    })
}),
function(e, t) {
    if ("function" == typeof define && define.amd) define(["exports", "jquery"], function(e, n) {
        return t(e, n)
    });
    else if ("undefined" != typeof exports) {
        var n = require("jquery");
        t(exports, n)
    } else t(e, e.jQuery || e.Zepto || e.ender || e.$)
}(this, function(e, t) {
    function n(e, n) {
        function s(e, t, n) {
            return e[t] = n, e
        }

        function r(e, t) {
            for (var n, r = e.match(i.key); void 0 !== (n = r.pop());)
                if (i.push.test(n)) {
                    t = s({}, function(e) {
                        void 0 === l[e] && (l[e] = 0);
                        return l[e]++
                    }(e.replace(/\[\]$/, "")), t)
                } else i.fixed.test(n) ? t = s({}, n, t) : i.named.test(n) && (t = s({}, n, t));
            return t
        }

        function o() {
            return a
        }
        var a = {},
            l = {};
        this.addPair = function(s) {
            if (!i.validate.test(s.name)) return this;
            var o = r(s.name, function(e) {
                switch (t('[name="' + e.name + '"]', n).attr("type")) {
                    case "checkbox":
                        return "on" === e.value || e.value;
                    default:
                        return e.value
                }
            }(s));
            return a = e.extend(!0, a, o), this
        }, this.addPairs = function(t) {
            if (!e.isArray(t)) throw new Error("formSerializer.addPairs expects an Array");
            for (var n = 0, i = t.length; n < i; n++) this.addPair(t[n]);
            return this
        }, this.serialize = o, this.serializeJSON = function() {
            return JSON.stringify(o())
        }
    }
    var i = {
        validate: /^[a-z_][a-z0-9_]*(?:\[(?:\d*|[a-z0-9_]+)\])*$/i,
        key: /[a-z0-9_]+|(?=\[\])/gi,
        push: /^$/,
        fixed: /^\d+$/,
        named: /^[a-z0-9_]+$/i
    };
    return n.patterns = i, n.serializeObject = function() {
        return new n(t, this).addPairs(this.serializeArray()).serialize()
    }, n.serializeJSON = function() {
        return new n(t, this).addPairs(this.serializeArray()).serializeJSON()
    }, void 0 !== t.fn && (t.fn.serializeForm = n.serializeObject, t.fn.serializeJSON = n.serializeJSON), e.FormSerializer = n, n
}),
function(e, t, n, i) {
    e.fn.serializeObject = function() {
        var t = {},
            n = this.serializeArray();
        return e.each(n, function() {
            void 0 !== t[this.name] ? (t[this.name].push || (t[this.name] = [t[this.name]]), t[this.name].push(this.value || "")) : t[this.name] = this.value || ""
        }), t
    }
}(jQuery, window, document),
function(e, t) {
    "object" == typeof exports && "object" == typeof module ? module.exports = t() : "function" == typeof define && define.amd ? define([], t) : "object" == typeof exports ? exports.Handlebars = t() : e.Handlebars = t()
}(this, function() {
    return function(e) {
        function t(i) {
            if (n[i]) return n[i].exports;
            var s = n[i] = {
                exports: {},
                id: i,
                loaded: !1
            };
            return e[i].call(s.exports, s, s.exports, t), s.loaded = !0, s.exports
        }
        var n = {};
        return t.m = e, t.c = n, t.p = "", t(0)
    }([function(e, t, n) {
        "use strict";

        function i() {
            var e = h();
            return e.compile = function(t, n) {
                return l.compile(t, n, e)
            }, e.precompile = function(t, n) {
                return l.precompile(t, n, e)
            }, e.AST = o.default, e.Compiler = l.Compiler, e.JavaScriptCompiler = c.default, e.Parser = a.parser, e.parse = a.parse, e
        }
        var s = n(1).default;
        t.__esModule = !0;
        var r = s(n(2)),
            o = s(n(35)),
            a = n(36),
            l = n(41),
            c = s(n(42)),
            d = s(n(39)),
            u = s(n(34)),
            h = r.default.create,
            p = i();
        p.create = i, u.default(p), p.Visitor = d.default, p.default = p, t.default = p, e.exports = t.default
    }, function(e, t) {
        "use strict";
        t.default = function(e) {
            return e && e.__esModule ? e : {
                default: e
            }
        }, t.__esModule = !0
    }, function(e, t, n) {
        "use strict";

        function i() {
            var e = new o.HandlebarsEnvironment;
            return c.extend(e, o), e.SafeString = a.default, e.Exception = l.default, e.Utils = c, e.escapeExpression = c.escapeExpression, e.VM = d, e.template = function(t) {
                return d.template(t, e)
            }, e
        }
        var s = n(3).default,
            r = n(1).default;
        t.__esModule = !0;
        var o = s(n(4)),
            a = r(n(21)),
            l = r(n(6)),
            c = s(n(5)),
            d = s(n(22)),
            u = r(n(34)),
            h = i();
        h.create = i, u.default(h), h.default = h, t.default = h, e.exports = t.default
    }, function(e, t) {
        "use strict";
        t.default = function(e) {
            if (e && e.__esModule) return e;
            var t = {};
            if (null != e)
                for (var n in e) Object.prototype.hasOwnProperty.call(e, n) && (t[n] = e[n]);
            return t.default = e, t
        }, t.__esModule = !0
    }, function(e, t, n) {
        "use strict";

        function i(e, t, n) {
            this.helpers = e || {}, this.partials = t || {}, this.decorators = n || {}, a.registerDefaultHelpers(this), l.registerDefaultDecorators(this)
        }
        var s = n(1).default;
        t.__esModule = !0, t.HandlebarsEnvironment = i;
        var r = n(5),
            o = s(n(6)),
            a = n(10),
            l = n(18),
            c = s(n(20));
        t.VERSION = "4.0.11";
        t.COMPILER_REVISION = 7;
        t.REVISION_CHANGES = {
            1: "<= 1.0.rc.2",
            2: "== 1.0.0-rc.3",
            3: "== 1.0.0-rc.4",
            4: "== 1.x.x",
            5: "== 2.0.0-alpha.x",
            6: ">= 2.0.0-beta.1",
            7: ">= 4.0.0"
        };
        var d = "[object Object]";
        i.prototype = {
            constructor: i,
            logger: c.default,
            log: c.default.log,
            registerHelper: function(e, t) {
                if (r.toString.call(e) === d) {
                    if (t) throw new o.default("Arg not supported with multiple helpers");
                    r.extend(this.helpers, e)
                } else this.helpers[e] = t
            },
            unregisterHelper: function(e) {
                delete this.helpers[e]
            },
            registerPartial: function(e, t) {
                if (r.toString.call(e) === d) r.extend(this.partials, e);
                else {
                    if (void 0 === t) throw new o.default('Attempting to register a partial called "' + e + '" as undefined');
                    this.partials[e] = t
                }
            },
            unregisterPartial: function(e) {
                delete this.partials[e]
            },
            registerDecorator: function(e, t) {
                if (r.toString.call(e) === d) {
                    if (t) throw new o.default("Arg not supported with multiple decorators");
                    r.extend(this.decorators, e)
                } else this.decorators[e] = t
            },
            unregisterDecorator: function(e) {
                delete this.decorators[e]
            }
        };
        var u = c.default.log;
        t.log = u, t.createFrame = r.createFrame, t.logger = c.default
    }, function(e, t) {
        "use strict";

        function n(e) {
            return s[e]
        }

        function i(e) {
            for (var t = 1; t < arguments.length; t++)
                for (var n in arguments[t]) Object.prototype.hasOwnProperty.call(arguments[t], n) && (e[n] = arguments[t][n]);
            return e
        }
        t.__esModule = !0, t.extend = i, t.indexOf = function(e, t) {
            for (var n = 0, i = e.length; n < i; n++)
                if (e[n] === t) return n;
            return -1
        }, t.escapeExpression = function(e) {
            if ("string" != typeof e) {
                if (e && e.toHTML) return e.toHTML();
                if (null == e) return "";
                if (!e) return e + "";
                e = "" + e
            }
            return o.test(e) ? e.replace(r, n) : e
        }, t.isEmpty = function(e) {
            return !e && 0 !== e || !(!c(e) || 0 !== e.length)
        }, t.createFrame = function(e) {
            var t = i({}, e);
            return t._parent = e, t
        }, t.blockParams = function(e, t) {
            return e.path = t, e
        }, t.appendContextPath = function(e, t) {
            return (e ? e + "." : "") + t
        };
        var s = {
                "&": "&amp;",
                "<": "&lt;",
                ">": "&gt;",
                '"': "&quot;",
                "'": "&#x27;",
                "`": "&#x60;",
                "=": "&#x3D;"
            },
            r = /[&<>"'`=]/g,
            o = /[&<>"'`=]/,
            a = Object.prototype.toString;
        t.toString = a;
        var l = function(e) {
            return "function" == typeof e
        };
        l(/x/) && (t.isFunction = l = function(e) {
            return "function" == typeof e && "[object Function]" === a.call(e)
        }), t.isFunction = l;
        var c = Array.isArray || function(e) {
            return !(!e || "object" != typeof e) && "[object Array]" === a.call(e)
        };
        t.isArray = c
    }, function(e, t, n) {
        "use strict";

        function i(e, t) {
            var n = t && t.loc,
                o = void 0,
                a = void 0;
            n && (e += " - " + (o = n.start.line) + ":" + (a = n.start.column));
            for (var l = Error.prototype.constructor.call(this, e), c = 0; c < r.length; c++) this[r[c]] = l[r[c]];
            Error.captureStackTrace && Error.captureStackTrace(this, i);
            try {
                n && (this.lineNumber = o, s ? Object.defineProperty(this, "column", {
                    value: a,
                    enumerable: !0
                }) : this.column = a)
            } catch (e) {}
        }
        var s = n(7).default;
        t.__esModule = !0;
        var r = ["description", "fileName", "lineNumber", "message", "name", "number", "stack"];
        i.prototype = new Error, t.default = i, e.exports = t.default
    }, function(e, t, n) {
        e.exports = {
            default: n(8),
            __esModule: !0
        }
    }, function(e, t, n) {
        var i = n(9);
        e.exports = function(e, t, n) {
            return i.setDesc(e, t, n)
        }
    }, function(e, t) {
        var n = Object;
        e.exports = {
            create: n.create,
            getProto: n.getPrototypeOf,
            isEnum: {}.propertyIsEnumerable,
            getDesc: n.getOwnPropertyDescriptor,
            setDesc: n.defineProperty,
            setDescs: n.defineProperties,
            getKeys: n.keys,
            getNames: n.getOwnPropertyNames,
            getSymbols: n.getOwnPropertySymbols,
            each: [].forEach
        }
    }, function(e, t, n) {
        "use strict";
        var i = n(1).default;
        t.__esModule = !0, t.registerDefaultHelpers = function(e) {
            s.default(e), r.default(e), o.default(e), a.default(e), l.default(e), c.default(e), d.default(e)
        };
        var s = i(n(11)),
            r = i(n(12)),
            o = i(n(13)),
            a = i(n(14)),
            l = i(n(15)),
            c = i(n(16)),
            d = i(n(17))
    }, function(e, t, n) {
        "use strict";
        t.__esModule = !0;
        var i = n(5);
        t.default = function(e) {
            e.registerHelper("blockHelperMissing", function(t, n) {
                var s = n.inverse,
                    r = n.fn;
                if (!0 === t) return r(this);
                if (!1 === t || null == t) return s(this);
                if (i.isArray(t)) return t.length > 0 ? (n.ids && (n.ids = [n.name]), e.helpers.each(t, n)) : s(this);
                if (n.data && n.ids) {
                    var o = i.createFrame(n.data);
                    o.contextPath = i.appendContextPath(n.data.contextPath, n.name), n = {
                        data: o
                    }
                }
                return r(t, n)
            })
        }, e.exports = t.default
    }, function(e, t, n) {
        "use strict";
        var i = n(1).default;
        t.__esModule = !0;
        var s = n(5),
            r = i(n(6));
        t.default = function(e) {
            e.registerHelper("each", function(e, t) {
                function n(t, n, r) {
                    c && (c.key = t, c.index = n, c.first = 0 === n, c.last = !!r, d && (c.contextPath = d + t)), l += i(e[t], {
                        data: c,
                        blockParams: s.blockParams([e[t], t], [d + t, null])
                    })
                }
                if (!t) throw new r.default("Must pass iterator to #each");
                var i = t.fn,
                    o = t.inverse,
                    a = 0,
                    l = "",
                    c = void 0,
                    d = void 0;
                if (t.data && t.ids && (d = s.appendContextPath(t.data.contextPath, t.ids[0]) + "."), s.isFunction(e) && (e = e.call(this)), t.data && (c = s.createFrame(t.data)), e && "object" == typeof e)
                    if (s.isArray(e))
                        for (var u = e.length; a < u; a++) a in e && n(a, a, a === e.length - 1);
                    else {
                        var h = void 0;
                        for (var p in e) e.hasOwnProperty(p) && (void 0 !== h && n(h, a - 1), h = p, a++);
                        void 0 !== h && n(h, a - 1, !0)
                    }
                return 0 === a && (l = o(this)), l
            })
        }, e.exports = t.default
    }, function(e, t, n) {
        "use strict";
        var i = n(1).default;
        t.__esModule = !0;
        var s = i(n(6));
        t.default = function(e) {
            e.registerHelper("helperMissing", function() {
                if (1 !== arguments.length) throw new s.default('Missing helper: "' + arguments[arguments.length - 1].name + '"')
            })
        }, e.exports = t.default
    }, function(e, t, n) {
        "use strict";
        t.__esModule = !0;
        var i = n(5);
        t.default = function(e) {
            e.registerHelper("if", function(e, t) {
                return i.isFunction(e) && (e = e.call(this)), !t.hash.includeZero && !e || i.isEmpty(e) ? t.inverse(this) : t.fn(this)
            }), e.registerHelper("unless", function(t, n) {
                return e.helpers.if.call(this, t, {
                    fn: n.inverse,
                    inverse: n.fn,
                    hash: n.hash
                })
            })
        }, e.exports = t.default
    }, function(e, t) {
        "use strict";
        t.__esModule = !0, t.default = function(e) {
            e.registerHelper("log", function() {
                for (var t = [void 0], n = arguments[arguments.length - 1], i = 0; i < arguments.length - 1; i++) t.push(arguments[i]);
                var s = 1;
                null != n.hash.level ? s = n.hash.level : n.data && null != n.data.level && (s = n.data.level), t[0] = s, e.log.apply(e, t)
            })
        }, e.exports = t.default
    }, function(e, t) {
        "use strict";
        t.__esModule = !0, t.default = function(e) {
            e.registerHelper("lookup", function(e, t) {
                return e && e[t]
            })
        }, e.exports = t.default
    }, function(e, t, n) {
        "use strict";
        t.__esModule = !0;
        var i = n(5);
        t.default = function(e) {
            e.registerHelper("with", function(e, t) {
                i.isFunction(e) && (e = e.call(this));
                var n = t.fn;
                if (i.isEmpty(e)) return t.inverse(this);
                var s = t.data;
                return t.data && t.ids && ((s = i.createFrame(t.data)).contextPath = i.appendContextPath(t.data.contextPath, t.ids[0])), n(e, {
                    data: s,
                    blockParams: i.blockParams([e], [s && s.contextPath])
                })
            })
        }, e.exports = t.default
    }, function(e, t, n) {
        "use strict";
        var i = n(1).default;
        t.__esModule = !0, t.registerDefaultDecorators = function(e) {
            s.default(e)
        };
        var s = i(n(19))
    }, function(e, t, n) {
        "use strict";
        t.__esModule = !0;
        var i = n(5);
        t.default = function(e) {
            e.registerDecorator("inline", function(e, t, n, s) {
                var r = e;
                return t.partials || (t.partials = {}, r = function(s, r) {
                    var o = n.partials;
                    n.partials = i.extend({}, o, t.partials);
                    var a = e(s, r);
                    return n.partials = o, a
                }), t.partials[s.args[0]] = s.fn, r
            })
        }, e.exports = t.default
    }, function(e, t, n) {
        "use strict";
        t.__esModule = !0;
        var i = n(5),
            s = {
                methodMap: ["debug", "info", "warn", "error"],
                level: "info",
                lookupLevel: function(e) {
                    if ("string" == typeof e) {
                        var t = i.indexOf(s.methodMap, e.toLowerCase());
                        e = t >= 0 ? t : parseInt(e, 10)
                    }
                    return e
                },
                log: function(e) {
                    if (e = s.lookupLevel(e), "undefined" != typeof console && s.lookupLevel(s.level) <= e) {
                        var t = s.methodMap[e];
                        console[t] || (t = "log");
                        for (var n = arguments.length, i = Array(n > 1 ? n - 1 : 0), r = 1; r < n; r++) i[r - 1] = arguments[r];
                        console[t].apply(console, i)
                    }
                }
            };
        t.default = s, e.exports = t.default
    }, function(e, t) {
        "use strict";

        function n(e) {
            this.string = e
        }
        t.__esModule = !0, n.prototype.toString = n.prototype.toHTML = function() {
            return "" + this.string
        }, t.default = n, e.exports = t.default
    }, function(e, t, n) {
        "use strict";

        function i(e, t, n, i, s, o, a) {
            function l(t) {
                var s = arguments.length <= 1 || void 0 === arguments[1] ? {} : arguments[1],
                    r = a;
                return !a || t == a[0] || t === e.nullContext && null === a[0] || (r = [t].concat(a)), n(e, t, e.helpers, e.partials, s.data || i, o && [s.blockParams].concat(o), r)
            }
            return l = r(n, l, e, a, i, o), l.program = t, l.depth = a ? a.length : 0, l.blockParams = s || 0, l
        }

        function s() {
            return ""
        }

        function r(e, t, n, i, s, r) {
            if (e.decorator) {
                var o = {};
                t = e.decorator(t, o, n, i && i[0], s, r, i), c.extend(t, o)
            }
            return t
        }
        var o = n(23).default,
            a = n(3).default,
            l = n(1).default;
        t.__esModule = !0, t.checkRevision = function(e) {
            var t = e && e[0] || 1,
                n = u.COMPILER_REVISION;
            if (t !== n) {
                if (t < n) {
                    var i = u.REVISION_CHANGES[n],
                        s = u.REVISION_CHANGES[t];
                    throw new d.default("Template was precompiled with an older version of Handlebars than the current runtime. Please update your precompiler to a newer version (" + i + ") or downgrade your runtime to an older version (" + s + ").")
                }
                throw new d.default("Template was precompiled with a newer version of Handlebars than the current runtime. Please update your runtime to a newer version (" + e[1] + ").")
            }
        }, t.template = function(e, t) {
            function n(t) {
                function i(t) {
                    return "" + e.main(s, t, s.helpers, s.partials, a, c, l)
                }
                var o = arguments.length <= 1 || void 0 === arguments[1] ? {} : arguments[1],
                    a = o.data;
                n._setup(o), !o.partial && e.useData && (a = function(e, t) {
                    return t && "root" in t || ((t = t ? u.createFrame(t) : {}).root = e), t
                }(t, a));
                var l = void 0,
                    c = e.useBlockParams ? [] : void 0;
                return e.useDepths && (l = o.depths ? t != o.depths[0] ? [t].concat(o.depths) : o.depths : [t]), (i = r(e.main, i, s, o.depths || [], a, c))(t, o)
            }
            if (!t) throw new d.default("No environment passed to template");
            if (!e || !e.main) throw new d.default("Unknown template object: " + typeof e);
            e.main.decorator = e.main_d, t.VM.checkRevision(e.compiler);
            var s = {
                strict: function(e, t) {
                    if (!(t in e)) throw new d.default('"' + t + '" not defined in ' + e);
                    return e[t]
                },
                lookup: function(e, t) {
                    for (var n = e.length, i = 0; i < n; i++)
                        if (e[i] && null != e[i][t]) return e[i][t]
                },
                lambda: function(e, t) {
                    return "function" == typeof e ? e.call(t) : e
                },
                escapeExpression: c.escapeExpression,
                invokePartial: function(n, i, s) {
                    s.hash && (i = c.extend({}, i, s.hash), s.ids && (s.ids[0] = !0)), n = t.VM.resolvePartial.call(this, n, i, s);
                    var r = t.VM.invokePartial.call(this, n, i, s);
                    if (null == r && t.compile && (s.partials[s.name] = t.compile(n, e.compilerOptions, t), r = s.partials[s.name](i, s)), null != r) {
                        if (s.indent) {
                            for (var o = r.split("\n"), a = 0, l = o.length; a < l && (o[a] || a + 1 !== l); a++) o[a] = s.indent + o[a];
                            r = o.join("\n")
                        }
                        return r
                    }
                    throw new d.default("The partial " + s.name + " could not be compiled when running in runtime-only mode")
                },
                fn: function(t) {
                    var n = e[t];
                    return n.decorator = e[t + "_d"], n
                },
                programs: [],
                program: function(e, t, n, s, r) {
                    var o = this.programs[e],
                        a = this.fn(e);
                    return t || r || s || n ? o = i(this, e, a, t, n, s, r) : o || (o = this.programs[e] = i(this, e, a)), o
                },
                data: function(e, t) {
                    for (; e && t--;) e = e._parent;
                    return e
                },
                merge: function(e, t) {
                    var n = e || t;
                    return e && t && e !== t && (n = c.extend({}, t, e)), n
                },
                nullContext: o({}),
                noop: t.VM.noop,
                compilerInfo: e.compiler
            };
            return n.isTop = !0, n._setup = function(n) {
                n.partial ? (s.helpers = n.helpers, s.partials = n.partials, s.decorators = n.decorators) : (s.helpers = s.merge(n.helpers, t.helpers), e.usePartial && (s.partials = s.merge(n.partials, t.partials)), (e.usePartial || e.useDecorators) && (s.decorators = s.merge(n.decorators, t.decorators)))
            }, n._child = function(t, n, r, o) {
                if (e.useBlockParams && !r) throw new d.default("must pass block params");
                if (e.useDepths && !o) throw new d.default("must pass parent depths");
                return i(s, t, e[t], n, 0, r, o)
            }, n
        }, t.wrapProgram = i, t.resolvePartial = function(e, t, n) {
            return e ? e.call || n.name || (n.name = e, e = n.partials[e]) : e = "@partial-block" === n.name ? n.data["partial-block"] : n.partials[n.name], e
        }, t.invokePartial = function(e, t, n) {
            var i = n.data && n.data["partial-block"];
            n.partial = !0, n.ids && (n.data.contextPath = n.ids[0] || n.data.contextPath);
            var r = void 0;
            if (n.fn && n.fn !== s && function() {
                    n.data = u.createFrame(n.data);
                    var e = n.fn;
                    r = n.data["partial-block"] = function(t) {
                        var n = arguments.length <= 1 || void 0 === arguments[1] ? {} : arguments[1];
                        return n.data = u.createFrame(n.data), n.data["partial-block"] = i, e(t, n)
                    }, e.partials && (n.partials = c.extend({}, n.partials, e.partials))
                }(), void 0 === e && r && (e = r), void 0 === e) throw new d.default("The partial " + n.name + " could not be found");
            if (e instanceof Function) return e(t, n)
        }, t.noop = s;
        var c = a(n(5)),
            d = l(n(6)),
            u = n(4)
    }, function(e, t, n) {
        e.exports = {
            default: n(24),
            __esModule: !0
        }
    }, function(e, t, n) {
        n(25), e.exports = n(30).Object.seal
    }, function(e, t, n) {
        var i = n(26);
        n(27)("seal", function(e) {
            return function(t) {
                return e && i(t) ? e(t) : t
            }
        })
    }, function(e, t) {
        e.exports = function(e) {
            return "object" == typeof e ? null !== e : "function" == typeof e
        }
    }, function(e, t, n) {
        var i = n(28),
            s = n(30),
            r = n(33);
        e.exports = function(e, t) {
            var n = (s.Object || {})[e] || Object[e],
                o = {};
            o[e] = t(n), i(i.S + i.F * r(function() {
                n(1)
            }), "Object", o)
        }
    }, function(e, t, n) {
        var i = n(29),
            s = n(30),
            r = n(31),
            o = "prototype",
            a = function(e, t, n) {
                var l, c, d, u = e & a.F,
                    h = e & a.G,
                    p = e & a.S,
                    f = e & a.P,
                    m = e & a.B,
                    g = e & a.W,
                    v = h ? s : s[t] || (s[t] = {}),
                    _ = h ? i : p ? i[t] : (i[t] || {})[o];
                h && (n = t);
                for (l in n)(c = !u && _ && l in _) && l in v || (d = c ? _[l] : n[l], v[l] = h && "function" != typeof _[l] ? n[l] : m && c ? r(d, i) : g && _[l] == d ? function(e) {
                    var t = function(t) {
                        return this instanceof e ? new e(t) : e(t)
                    };
                    return t[o] = e[o], t
                }(d) : f && "function" == typeof d ? r(Function.call, d) : d, f && ((v[o] || (v[o] = {}))[l] = d))
            };
        a.F = 1, a.G = 2, a.S = 4, a.P = 8, a.B = 16, a.W = 32, e.exports = a
    }, function(e, t) {
        var n = e.exports = "undefined" != typeof window && window.Math == Math ? window : "undefined" != typeof self && self.Math == Math ? self : Function("return this")();
        "number" == typeof __g && (__g = n)
    }, function(e, t) {
        var n = e.exports = {
            version: "1.2.6"
        };
        "number" == typeof __e && (__e = n)
    }, function(e, t, n) {
        var i = n(32);
        e.exports = function(e, t, n) {
            if (i(e), void 0 === t) return e;
            switch (n) {
                case 1:
                    return function(n) {
                        return e.call(t, n)
                    };
                case 2:
                    return function(n, i) {
                        return e.call(t, n, i)
                    };
                case 3:
                    return function(n, i, s) {
                        return e.call(t, n, i, s)
                    }
            }
            return function() {
                return e.apply(t, arguments)
            }
        }
    }, function(e, t) {
        e.exports = function(e) {
            if ("function" != typeof e) throw TypeError(e + " is not a function!");
            return e
        }
    }, function(e, t) {
        e.exports = function(e) {
            try {
                return !!e()
            } catch (e) {
                return !0
            }
        }
    }, function(e, t) {
        (function(n) {
            "use strict";
            t.__esModule = !0, t.default = function(e) {
                var t = void 0 !== n ? n : window,
                    i = t.Handlebars;
                e.noConflict = function() {
                    return t.Handlebars === e && (t.Handlebars = i), e
                }
            }, e.exports = t.default
        }).call(t, function() {
            return this
        }())
    }, function(e, t) {
        "use strict";
        t.__esModule = !0;
        var n = {
            helpers: {
                helperExpression: function(e) {
                    return "SubExpression" === e.type || ("MustacheStatement" === e.type || "BlockStatement" === e.type) && !!(e.params && e.params.length || e.hash)
                },
                scopedId: function(e) {
                    return /^\.|this\b/.test(e.original)
                },
                simpleId: function(e) {
                    return 1 === e.parts.length && !n.helpers.scopedId(e) && !e.depth
                }
            }
        };
        t.default = n, e.exports = t.default
    }, function(e, t, n) {
        "use strict";
        var i = n(1).default,
            s = n(3).default;
        t.__esModule = !0, t.parse = function(e, t) {
            return "Program" === e.type ? e : (r.default.yy = c, c.locInfo = function(e) {
                return new c.SourceLocation(t && t.srcName, e)
            }, new o.default(t).accept(r.default.parse(e)))
        };
        var r = i(n(37)),
            o = i(n(38)),
            a = s(n(40)),
            l = n(5);
        t.parser = r.default;
        var c = {};
        l.extend(c, a)
    }, function(e, t) {
        "use strict";
        t.__esModule = !0;
        var n = function() {
            function e() {
                this.yy = {}
            }
            var t = {
                    trace: function() {},
                    yy: {},
                    symbols_: {
                        error: 2,
                        root: 3,
                        program: 4,
                        EOF: 5,
                        program_repetition0: 6,
                        statement: 7,
                        mustache: 8,
                        block: 9,
                        rawBlock: 10,
                        partial: 11,
                        partialBlock: 12,
                        content: 13,
                        COMMENT: 14,
                        CONTENT: 15,
                        openRawBlock: 16,
                        rawBlock_repetition_plus0: 17,
                        END_RAW_BLOCK: 18,
                        OPEN_RAW_BLOCK: 19,
                        helperName: 20,
                        openRawBlock_repetition0: 21,
                        openRawBlock_option0: 22,
                        CLOSE_RAW_BLOCK: 23,
                        openBlock: 24,
                        block_option0: 25,
                        closeBlock: 26,
                        openInverse: 27,
                        block_option1: 28,
                        OPEN_BLOCK: 29,
                        openBlock_repetition0: 30,
                        openBlock_option0: 31,
                        openBlock_option1: 32,
                        CLOSE: 33,
                        OPEN_INVERSE: 34,
                        openInverse_repetition0: 35,
                        openInverse_option0: 36,
                        openInverse_option1: 37,
                        openInverseChain: 38,
                        OPEN_INVERSE_CHAIN: 39,
                        openInverseChain_repetition0: 40,
                        openInverseChain_option0: 41,
                        openInverseChain_option1: 42,
                        inverseAndProgram: 43,
                        INVERSE: 44,
                        inverseChain: 45,
                        inverseChain_option0: 46,
                        OPEN_ENDBLOCK: 47,
                        OPEN: 48,
                        mustache_repetition0: 49,
                        mustache_option0: 50,
                        OPEN_UNESCAPED: 51,
                        mustache_repetition1: 52,
                        mustache_option1: 53,
                        CLOSE_UNESCAPED: 54,
                        OPEN_PARTIAL: 55,
                        partialName: 56,
                        partial_repetition0: 57,
                        partial_option0: 58,
                        openPartialBlock: 59,
                        OPEN_PARTIAL_BLOCK: 60,
                        openPartialBlock_repetition0: 61,
                        openPartialBlock_option0: 62,
                        param: 63,
                        sexpr: 64,
                        OPEN_SEXPR: 65,
                        sexpr_repetition0: 66,
                        sexpr_option0: 67,
                        CLOSE_SEXPR: 68,
                        hash: 69,
                        hash_repetition_plus0: 70,
                        hashSegment: 71,
                        ID: 72,
                        EQUALS: 73,
                        blockParams: 74,
                        OPEN_BLOCK_PARAMS: 75,
                        blockParams_repetition_plus0: 76,
                        CLOSE_BLOCK_PARAMS: 77,
                        path: 78,
                        dataName: 79,
                        STRING: 80,
                        NUMBER: 81,
                        BOOLEAN: 82,
                        UNDEFINED: 83,
                        NULL: 84,
                        DATA: 85,
                        pathSegments: 86,
                        SEP: 87,
                        $accept: 0,
                        $end: 1
                    },
                    terminals_: {
                        2: "error",
                        5: "EOF",
                        14: "COMMENT",
                        15: "CONTENT",
                        18: "END_RAW_BLOCK",
                        19: "OPEN_RAW_BLOCK",
                        23: "CLOSE_RAW_BLOCK",
                        29: "OPEN_BLOCK",
                        33: "CLOSE",
                        34: "OPEN_INVERSE",
                        39: "OPEN_INVERSE_CHAIN",
                        44: "INVERSE",
                        47: "OPEN_ENDBLOCK",
                        48: "OPEN",
                        51: "OPEN_UNESCAPED",
                        54: "CLOSE_UNESCAPED",
                        55: "OPEN_PARTIAL",
                        60: "OPEN_PARTIAL_BLOCK",
                        65: "OPEN_SEXPR",
                        68: "CLOSE_SEXPR",
                        72: "ID",
                        73: "EQUALS",
                        75: "OPEN_BLOCK_PARAMS",
                        77: "CLOSE_BLOCK_PARAMS",
                        80: "STRING",
                        81: "NUMBER",
                        82: "BOOLEAN",
                        83: "UNDEFINED",
                        84: "NULL",
                        85: "DATA",
                        87: "SEP"
                    },
                    productions_: [0, [3, 2],
                        [4, 1],
                        [7, 1],
                        [7, 1],
                        [7, 1],
                        [7, 1],
                        [7, 1],
                        [7, 1],
                        [7, 1],
                        [13, 1],
                        [10, 3],
                        [16, 5],
                        [9, 4],
                        [9, 4],
                        [24, 6],
                        [27, 6],
                        [38, 6],
                        [43, 2],
                        [45, 3],
                        [45, 1],
                        [26, 3],
                        [8, 5],
                        [8, 5],
                        [11, 5],
                        [12, 3],
                        [59, 5],
                        [63, 1],
                        [63, 1],
                        [64, 5],
                        [69, 1],
                        [71, 3],
                        [74, 3],
                        [20, 1],
                        [20, 1],
                        [20, 1],
                        [20, 1],
                        [20, 1],
                        [20, 1],
                        [20, 1],
                        [56, 1],
                        [56, 1],
                        [79, 2],
                        [78, 1],
                        [86, 3],
                        [86, 1],
                        [6, 0],
                        [6, 2],
                        [17, 1],
                        [17, 2],
                        [21, 0],
                        [21, 2],
                        [22, 0],
                        [22, 1],
                        [25, 0],
                        [25, 1],
                        [28, 0],
                        [28, 1],
                        [30, 0],
                        [30, 2],
                        [31, 0],
                        [31, 1],
                        [32, 0],
                        [32, 1],
                        [35, 0],
                        [35, 2],
                        [36, 0],
                        [36, 1],
                        [37, 0],
                        [37, 1],
                        [40, 0],
                        [40, 2],
                        [41, 0],
                        [41, 1],
                        [42, 0],
                        [42, 1],
                        [46, 0],
                        [46, 1],
                        [49, 0],
                        [49, 2],
                        [50, 0],
                        [50, 1],
                        [52, 0],
                        [52, 2],
                        [53, 0],
                        [53, 1],
                        [57, 0],
                        [57, 2],
                        [58, 0],
                        [58, 1],
                        [61, 0],
                        [61, 2],
                        [62, 0],
                        [62, 1],
                        [66, 0],
                        [66, 2],
                        [67, 0],
                        [67, 1],
                        [70, 1],
                        [70, 2],
                        [76, 1],
                        [76, 2]
                    ],
                    performAction: function(e, t, n, i, s, r, o) {
                        var a = r.length - 1;
                        switch (s) {
                            case 1:
                                return r[a - 1];
                            case 2:
                                this.$ = i.prepareProgram(r[a]);
                                break;
                            case 3:
                            case 4:
                            case 5:
                            case 6:
                            case 7:
                            case 8:
                                this.$ = r[a];
                                break;
                            case 9:
                                this.$ = {
                                    type: "CommentStatement",
                                    value: i.stripComment(r[a]),
                                    strip: i.stripFlags(r[a], r[a]),
                                    loc: i.locInfo(this._$)
                                };
                                break;
                            case 10:
                                this.$ = {
                                    type: "ContentStatement",
                                    original: r[a],
                                    value: r[a],
                                    loc: i.locInfo(this._$)
                                };
                                break;
                            case 11:
                                this.$ = i.prepareRawBlock(r[a - 2], r[a - 1], r[a], this._$);
                                break;
                            case 12:
                                this.$ = {
                                    path: r[a - 3],
                                    params: r[a - 2],
                                    hash: r[a - 1]
                                };
                                break;
                            case 13:
                                this.$ = i.prepareBlock(r[a - 3], r[a - 2], r[a - 1], r[a], !1, this._$);
                                break;
                            case 14:
                                this.$ = i.prepareBlock(r[a - 3], r[a - 2], r[a - 1], r[a], !0, this._$);
                                break;
                            case 15:
                                this.$ = {
                                    open: r[a - 5],
                                    path: r[a - 4],
                                    params: r[a - 3],
                                    hash: r[a - 2],
                                    blockParams: r[a - 1],
                                    strip: i.stripFlags(r[a - 5], r[a])
                                };
                                break;
                            case 16:
                            case 17:
                                this.$ = {
                                    path: r[a - 4],
                                    params: r[a - 3],
                                    hash: r[a - 2],
                                    blockParams: r[a - 1],
                                    strip: i.stripFlags(r[a - 5], r[a])
                                };
                                break;
                            case 18:
                                this.$ = {
                                    strip: i.stripFlags(r[a - 1], r[a - 1]),
                                    program: r[a]
                                };
                                break;
                            case 19:
                                var l = i.prepareBlock(r[a - 2], r[a - 1], r[a], r[a], !1, this._$),
                                    c = i.prepareProgram([l], r[a - 1].loc);
                                c.chained = !0, this.$ = {
                                    strip: r[a - 2].strip,
                                    program: c,
                                    chain: !0
                                };
                                break;
                            case 20:
                                this.$ = r[a];
                                break;
                            case 21:
                                this.$ = {
                                    path: r[a - 1],
                                    strip: i.stripFlags(r[a - 2], r[a])
                                };
                                break;
                            case 22:
                            case 23:
                                this.$ = i.prepareMustache(r[a - 3], r[a - 2], r[a - 1], r[a - 4], i.stripFlags(r[a - 4], r[a]), this._$);
                                break;
                            case 24:
                                this.$ = {
                                    type: "PartialStatement",
                                    name: r[a - 3],
                                    params: r[a - 2],
                                    hash: r[a - 1],
                                    indent: "",
                                    strip: i.stripFlags(r[a - 4], r[a]),
                                    loc: i.locInfo(this._$)
                                };
                                break;
                            case 25:
                                this.$ = i.preparePartialBlock(r[a - 2], r[a - 1], r[a], this._$);
                                break;
                            case 26:
                                this.$ = {
                                    path: r[a - 3],
                                    params: r[a - 2],
                                    hash: r[a - 1],
                                    strip: i.stripFlags(r[a - 4], r[a])
                                };
                                break;
                            case 27:
                            case 28:
                                this.$ = r[a];
                                break;
                            case 29:
                                this.$ = {
                                    type: "SubExpression",
                                    path: r[a - 3],
                                    params: r[a - 2],
                                    hash: r[a - 1],
                                    loc: i.locInfo(this._$)
                                };
                                break;
                            case 30:
                                this.$ = {
                                    type: "Hash",
                                    pairs: r[a],
                                    loc: i.locInfo(this._$)
                                };
                                break;
                            case 31:
                                this.$ = {
                                    type: "HashPair",
                                    key: i.id(r[a - 2]),
                                    value: r[a],
                                    loc: i.locInfo(this._$)
                                };
                                break;
                            case 32:
                                this.$ = i.id(r[a - 1]);
                                break;
                            case 33:
                            case 34:
                                this.$ = r[a];
                                break;
                            case 35:
                                this.$ = {
                                    type: "StringLiteral",
                                    value: r[a],
                                    original: r[a],
                                    loc: i.locInfo(this._$)
                                };
                                break;
                            case 36:
                                this.$ = {
                                    type: "NumberLiteral",
                                    value: Number(r[a]),
                                    original: Number(r[a]),
                                    loc: i.locInfo(this._$)
                                };
                                break;
                            case 37:
                                this.$ = {
                                    type: "BooleanLiteral",
                                    value: "true" === r[a],
                                    original: "true" === r[a],
                                    loc: i.locInfo(this._$)
                                };
                                break;
                            case 38:
                                this.$ = {
                                    type: "UndefinedLiteral",
                                    original: void 0,
                                    value: void 0,
                                    loc: i.locInfo(this._$)
                                };
                                break;
                            case 39:
                                this.$ = {
                                    type: "NullLiteral",
                                    original: null,
                                    value: null,
                                    loc: i.locInfo(this._$)
                                };
                                break;
                            case 40:
                            case 41:
                                this.$ = r[a];
                                break;
                            case 42:
                                this.$ = i.preparePath(!0, r[a], this._$);
                                break;
                            case 43:
                                this.$ = i.preparePath(!1, r[a], this._$);
                                break;
                            case 44:
                                r[a - 2].push({
                                    part: i.id(r[a]),
                                    original: r[a],
                                    separator: r[a - 1]
                                }), this.$ = r[a - 2];
                                break;
                            case 45:
                                this.$ = [{
                                    part: i.id(r[a]),
                                    original: r[a]
                                }];
                                break;
                            case 46:
                                this.$ = [];
                                break;
                            case 47:
                                r[a - 1].push(r[a]);
                                break;
                            case 48:
                                this.$ = [r[a]];
                                break;
                            case 49:
                                r[a - 1].push(r[a]);
                                break;
                            case 50:
                                this.$ = [];
                                break;
                            case 51:
                                r[a - 1].push(r[a]);
                                break;
                            case 58:
                                this.$ = [];
                                break;
                            case 59:
                                r[a - 1].push(r[a]);
                                break;
                            case 64:
                                this.$ = [];
                                break;
                            case 65:
                                r[a - 1].push(r[a]);
                                break;
                            case 70:
                                this.$ = [];
                                break;
                            case 71:
                                r[a - 1].push(r[a]);
                                break;
                            case 78:
                                this.$ = [];
                                break;
                            case 79:
                                r[a - 1].push(r[a]);
                                break;
                            case 82:
                                this.$ = [];
                                break;
                            case 83:
                                r[a - 1].push(r[a]);
                                break;
                            case 86:
                                this.$ = [];
                                break;
                            case 87:
                                r[a - 1].push(r[a]);
                                break;
                            case 90:
                                this.$ = [];
                                break;
                            case 91:
                                r[a - 1].push(r[a]);
                                break;
                            case 94:
                                this.$ = [];
                                break;
                            case 95:
                                r[a - 1].push(r[a]);
                                break;
                            case 98:
                                this.$ = [r[a]];
                                break;
                            case 99:
                                r[a - 1].push(r[a]);
                                break;
                            case 100:
                                this.$ = [r[a]];
                                break;
                            case 101:
                                r[a - 1].push(r[a])
                        }
                    },
                    table: [{
                        3: 1,
                        4: 2,
                        5: [2, 46],
                        6: 3,
                        14: [2, 46],
                        15: [2, 46],
                        19: [2, 46],
                        29: [2, 46],
                        34: [2, 46],
                        48: [2, 46],
                        51: [2, 46],
                        55: [2, 46],
                        60: [2, 46]
                    }, {
                        1: [3]
                    }, {
                        5: [1, 4]
                    }, {
                        5: [2, 2],
                        7: 5,
                        8: 6,
                        9: 7,
                        10: 8,
                        11: 9,
                        12: 10,
                        13: 11,
                        14: [1, 12],
                        15: [1, 20],
                        16: 17,
                        19: [1, 23],
                        24: 15,
                        27: 16,
                        29: [1, 21],
                        34: [1, 22],
                        39: [2, 2],
                        44: [2, 2],
                        47: [2, 2],
                        48: [1, 13],
                        51: [1, 14],
                        55: [1, 18],
                        59: 19,
                        60: [1, 24]
                    }, {
                        1: [2, 1]
                    }, {
                        5: [2, 47],
                        14: [2, 47],
                        15: [2, 47],
                        19: [2, 47],
                        29: [2, 47],
                        34: [2, 47],
                        39: [2, 47],
                        44: [2, 47],
                        47: [2, 47],
                        48: [2, 47],
                        51: [2, 47],
                        55: [2, 47],
                        60: [2, 47]
                    }, {
                        5: [2, 3],
                        14: [2, 3],
                        15: [2, 3],
                        19: [2, 3],
                        29: [2, 3],
                        34: [2, 3],
                        39: [2, 3],
                        44: [2, 3],
                        47: [2, 3],
                        48: [2, 3],
                        51: [2, 3],
                        55: [2, 3],
                        60: [2, 3]
                    }, {
                        5: [2, 4],
                        14: [2, 4],
                        15: [2, 4],
                        19: [2, 4],
                        29: [2, 4],
                        34: [2, 4],
                        39: [2, 4],
                        44: [2, 4],
                        47: [2, 4],
                        48: [2, 4],
                        51: [2, 4],
                        55: [2, 4],
                        60: [2, 4]
                    }, {
                        5: [2, 5],
                        14: [2, 5],
                        15: [2, 5],
                        19: [2, 5],
                        29: [2, 5],
                        34: [2, 5],
                        39: [2, 5],
                        44: [2, 5],
                        47: [2, 5],
                        48: [2, 5],
                        51: [2, 5],
                        55: [2, 5],
                        60: [2, 5]
                    }, {
                        5: [2, 6],
                        14: [2, 6],
                        15: [2, 6],
                        19: [2, 6],
                        29: [2, 6],
                        34: [2, 6],
                        39: [2, 6],
                        44: [2, 6],
                        47: [2, 6],
                        48: [2, 6],
                        51: [2, 6],
                        55: [2, 6],
                        60: [2, 6]
                    }, {
                        5: [2, 7],
                        14: [2, 7],
                        15: [2, 7],
                        19: [2, 7],
                        29: [2, 7],
                        34: [2, 7],
                        39: [2, 7],
                        44: [2, 7],
                        47: [2, 7],
                        48: [2, 7],
                        51: [2, 7],
                        55: [2, 7],
                        60: [2, 7]
                    }, {
                        5: [2, 8],
                        14: [2, 8],
                        15: [2, 8],
                        19: [2, 8],
                        29: [2, 8],
                        34: [2, 8],
                        39: [2, 8],
                        44: [2, 8],
                        47: [2, 8],
                        48: [2, 8],
                        51: [2, 8],
                        55: [2, 8],
                        60: [2, 8]
                    }, {
                        5: [2, 9],
                        14: [2, 9],
                        15: [2, 9],
                        19: [2, 9],
                        29: [2, 9],
                        34: [2, 9],
                        39: [2, 9],
                        44: [2, 9],
                        47: [2, 9],
                        48: [2, 9],
                        51: [2, 9],
                        55: [2, 9],
                        60: [2, 9]
                    }, {
                        20: 25,
                        72: [1, 35],
                        78: 26,
                        79: 27,
                        80: [1, 28],
                        81: [1, 29],
                        82: [1, 30],
                        83: [1, 31],
                        84: [1, 32],
                        85: [1, 34],
                        86: 33
                    }, {
                        20: 36,
                        72: [1, 35],
                        78: 26,
                        79: 27,
                        80: [1, 28],
                        81: [1, 29],
                        82: [1, 30],
                        83: [1, 31],
                        84: [1, 32],
                        85: [1, 34],
                        86: 33
                    }, {
                        4: 37,
                        6: 3,
                        14: [2, 46],
                        15: [2, 46],
                        19: [2, 46],
                        29: [2, 46],
                        34: [2, 46],
                        39: [2, 46],
                        44: [2, 46],
                        47: [2, 46],
                        48: [2, 46],
                        51: [2, 46],
                        55: [2, 46],
                        60: [2, 46]
                    }, {
                        4: 38,
                        6: 3,
                        14: [2, 46],
                        15: [2, 46],
                        19: [2, 46],
                        29: [2, 46],
                        34: [2, 46],
                        44: [2, 46],
                        47: [2, 46],
                        48: [2, 46],
                        51: [2, 46],
                        55: [2, 46],
                        60: [2, 46]
                    }, {
                        13: 40,
                        15: [1, 20],
                        17: 39
                    }, {
                        20: 42,
                        56: 41,
                        64: 43,
                        65: [1, 44],
                        72: [1, 35],
                        78: 26,
                        79: 27,
                        80: [1, 28],
                        81: [1, 29],
                        82: [1, 30],
                        83: [1, 31],
                        84: [1, 32],
                        85: [1, 34],
                        86: 33
                    }, {
                        4: 45,
                        6: 3,
                        14: [2, 46],
                        15: [2, 46],
                        19: [2, 46],
                        29: [2, 46],
                        34: [2, 46],
                        47: [2, 46],
                        48: [2, 46],
                        51: [2, 46],
                        55: [2, 46],
                        60: [2, 46]
                    }, {
                        5: [2, 10],
                        14: [2, 10],
                        15: [2, 10],
                        18: [2, 10],
                        19: [2, 10],
                        29: [2, 10],
                        34: [2, 10],
                        39: [2, 10],
                        44: [2, 10],
                        47: [2, 10],
                        48: [2, 10],
                        51: [2, 10],
                        55: [2, 10],
                        60: [2, 10]
                    }, {
                        20: 46,
                        72: [1, 35],
                        78: 26,
                        79: 27,
                        80: [1, 28],
                        81: [1, 29],
                        82: [1, 30],
                        83: [1, 31],
                        84: [1, 32],
                        85: [1, 34],
                        86: 33
                    }, {
                        20: 47,
                        72: [1, 35],
                        78: 26,
                        79: 27,
                        80: [1, 28],
                        81: [1, 29],
                        82: [1, 30],
                        83: [1, 31],
                        84: [1, 32],
                        85: [1, 34],
                        86: 33
                    }, {
                        20: 48,
                        72: [1, 35],
                        78: 26,
                        79: 27,
                        80: [1, 28],
                        81: [1, 29],
                        82: [1, 30],
                        83: [1, 31],
                        84: [1, 32],
                        85: [1, 34],
                        86: 33
                    }, {
                        20: 42,
                        56: 49,
                        64: 43,
                        65: [1, 44],
                        72: [1, 35],
                        78: 26,
                        79: 27,
                        80: [1, 28],
                        81: [1, 29],
                        82: [1, 30],
                        83: [1, 31],
                        84: [1, 32],
                        85: [1, 34],
                        86: 33
                    }, {
                        33: [2, 78],
                        49: 50,
                        65: [2, 78],
                        72: [2, 78],
                        80: [2, 78],
                        81: [2, 78],
                        82: [2, 78],
                        83: [2, 78],
                        84: [2, 78],
                        85: [2, 78]
                    }, {
                        23: [2, 33],
                        33: [2, 33],
                        54: [2, 33],
                        65: [2, 33],
                        68: [2, 33],
                        72: [2, 33],
                        75: [2, 33],
                        80: [2, 33],
                        81: [2, 33],
                        82: [2, 33],
                        83: [2, 33],
                        84: [2, 33],
                        85: [2, 33]
                    }, {
                        23: [2, 34],
                        33: [2, 34],
                        54: [2, 34],
                        65: [2, 34],
                        68: [2, 34],
                        72: [2, 34],
                        75: [2, 34],
                        80: [2, 34],
                        81: [2, 34],
                        82: [2, 34],
                        83: [2, 34],
                        84: [2, 34],
                        85: [2, 34]
                    }, {
                        23: [2, 35],
                        33: [2, 35],
                        54: [2, 35],
                        65: [2, 35],
                        68: [2, 35],
                        72: [2, 35],
                        75: [2, 35],
                        80: [2, 35],
                        81: [2, 35],
                        82: [2, 35],
                        83: [2, 35],
                        84: [2, 35],
                        85: [2, 35]
                    }, {
                        23: [2, 36],
                        33: [2, 36],
                        54: [2, 36],
                        65: [2, 36],
                        68: [2, 36],
                        72: [2, 36],
                        75: [2, 36],
                        80: [2, 36],
                        81: [2, 36],
                        82: [2, 36],
                        83: [2, 36],
                        84: [2, 36],
                        85: [2, 36]
                    }, {
                        23: [2, 37],
                        33: [2, 37],
                        54: [2, 37],
                        65: [2, 37],
                        68: [2, 37],
                        72: [2, 37],
                        75: [2, 37],
                        80: [2, 37],
                        81: [2, 37],
                        82: [2, 37],
                        83: [2, 37],
                        84: [2, 37],
                        85: [2, 37]
                    }, {
                        23: [2, 38],
                        33: [2, 38],
                        54: [2, 38],
                        65: [2, 38],
                        68: [2, 38],
                        72: [2, 38],
                        75: [2, 38],
                        80: [2, 38],
                        81: [2, 38],
                        82: [2, 38],
                        83: [2, 38],
                        84: [2, 38],
                        85: [2, 38]
                    }, {
                        23: [2, 39],
                        33: [2, 39],
                        54: [2, 39],
                        65: [2, 39],
                        68: [2, 39],
                        72: [2, 39],
                        75: [2, 39],
                        80: [2, 39],
                        81: [2, 39],
                        82: [2, 39],
                        83: [2, 39],
                        84: [2, 39],
                        85: [2, 39]
                    }, {
                        23: [2, 43],
                        33: [2, 43],
                        54: [2, 43],
                        65: [2, 43],
                        68: [2, 43],
                        72: [2, 43],
                        75: [2, 43],
                        80: [2, 43],
                        81: [2, 43],
                        82: [2, 43],
                        83: [2, 43],
                        84: [2, 43],
                        85: [2, 43],
                        87: [1, 51]
                    }, {
                        72: [1, 35],
                        86: 52
                    }, {
                        23: [2, 45],
                        33: [2, 45],
                        54: [2, 45],
                        65: [2, 45],
                        68: [2, 45],
                        72: [2, 45],
                        75: [2, 45],
                        80: [2, 45],
                        81: [2, 45],
                        82: [2, 45],
                        83: [2, 45],
                        84: [2, 45],
                        85: [2, 45],
                        87: [2, 45]
                    }, {
                        52: 53,
                        54: [2, 82],
                        65: [2, 82],
                        72: [2, 82],
                        80: [2, 82],
                        81: [2, 82],
                        82: [2, 82],
                        83: [2, 82],
                        84: [2, 82],
                        85: [2, 82]
                    }, {
                        25: 54,
                        38: 56,
                        39: [1, 58],
                        43: 57,
                        44: [1, 59],
                        45: 55,
                        47: [2, 54]
                    }, {
                        28: 60,
                        43: 61,
                        44: [1, 59],
                        47: [2, 56]
                    }, {
                        13: 63,
                        15: [1, 20],
                        18: [1, 62]
                    }, {
                        15: [2, 48],
                        18: [2, 48]
                    }, {
                        33: [2, 86],
                        57: 64,
                        65: [2, 86],
                        72: [2, 86],
                        80: [2, 86],
                        81: [2, 86],
                        82: [2, 86],
                        83: [2, 86],
                        84: [2, 86],
                        85: [2, 86]
                    }, {
                        33: [2, 40],
                        65: [2, 40],
                        72: [2, 40],
                        80: [2, 40],
                        81: [2, 40],
                        82: [2, 40],
                        83: [2, 40],
                        84: [2, 40],
                        85: [2, 40]
                    }, {
                        33: [2, 41],
                        65: [2, 41],
                        72: [2, 41],
                        80: [2, 41],
                        81: [2, 41],
                        82: [2, 41],
                        83: [2, 41],
                        84: [2, 41],
                        85: [2, 41]
                    }, {
                        20: 65,
                        72: [1, 35],
                        78: 26,
                        79: 27,
                        80: [1, 28],
                        81: [1, 29],
                        82: [1, 30],
                        83: [1, 31],
                        84: [1, 32],
                        85: [1, 34],
                        86: 33
                    }, {
                        26: 66,
                        47: [1, 67]
                    }, {
                        30: 68,
                        33: [2, 58],
                        65: [2, 58],
                        72: [2, 58],
                        75: [2, 58],
                        80: [2, 58],
                        81: [2, 58],
                        82: [2, 58],
                        83: [2, 58],
                        84: [2, 58],
                        85: [2, 58]
                    }, {
                        33: [2, 64],
                        35: 69,
                        65: [2, 64],
                        72: [2, 64],
                        75: [2, 64],
                        80: [2, 64],
                        81: [2, 64],
                        82: [2, 64],
                        83: [2, 64],
                        84: [2, 64],
                        85: [2, 64]
                    }, {
                        21: 70,
                        23: [2, 50],
                        65: [2, 50],
                        72: [2, 50],
                        80: [2, 50],
                        81: [2, 50],
                        82: [2, 50],
                        83: [2, 50],
                        84: [2, 50],
                        85: [2, 50]
                    }, {
                        33: [2, 90],
                        61: 71,
                        65: [2, 90],
                        72: [2, 90],
                        80: [2, 90],
                        81: [2, 90],
                        82: [2, 90],
                        83: [2, 90],
                        84: [2, 90],
                        85: [2, 90]
                    }, {
                        20: 75,
                        33: [2, 80],
                        50: 72,
                        63: 73,
                        64: 76,
                        65: [1, 44],
                        69: 74,
                        70: 77,
                        71: 78,
                        72: [1, 79],
                        78: 26,
                        79: 27,
                        80: [1, 28],
                        81: [1, 29],
                        82: [1, 30],
                        83: [1, 31],
                        84: [1, 32],
                        85: [1, 34],
                        86: 33
                    }, {
                        72: [1, 80]
                    }, {
                        23: [2, 42],
                        33: [2, 42],
                        54: [2, 42],
                        65: [2, 42],
                        68: [2, 42],
                        72: [2, 42],
                        75: [2, 42],
                        80: [2, 42],
                        81: [2, 42],
                        82: [2, 42],
                        83: [2, 42],
                        84: [2, 42],
                        85: [2, 42],
                        87: [1, 51]
                    }, {
                        20: 75,
                        53: 81,
                        54: [2, 84],
                        63: 82,
                        64: 76,
                        65: [1, 44],
                        69: 83,
                        70: 77,
                        71: 78,
                        72: [1, 79],
                        78: 26,
                        79: 27,
                        80: [1, 28],
                        81: [1, 29],
                        82: [1, 30],
                        83: [1, 31],
                        84: [1, 32],
                        85: [1, 34],
                        86: 33
                    }, {
                        26: 84,
                        47: [1, 67]
                    }, {
                        47: [2, 55]
                    }, {
                        4: 85,
                        6: 3,
                        14: [2, 46],
                        15: [2, 46],
                        19: [2, 46],
                        29: [2, 46],
                        34: [2, 46],
                        39: [2, 46],
                        44: [2, 46],
                        47: [2, 46],
                        48: [2, 46],
                        51: [2, 46],
                        55: [2, 46],
                        60: [2, 46]
                    }, {
                        47: [2, 20]
                    }, {
                        20: 86,
                        72: [1, 35],
                        78: 26,
                        79: 27,
                        80: [1, 28],
                        81: [1, 29],
                        82: [1, 30],
                        83: [1, 31],
                        84: [1, 32],
                        85: [1, 34],
                        86: 33
                    }, {
                        4: 87,
                        6: 3,
                        14: [2, 46],
                        15: [2, 46],
                        19: [2, 46],
                        29: [2, 46],
                        34: [2, 46],
                        47: [2, 46],
                        48: [2, 46],
                        51: [2, 46],
                        55: [2, 46],
                        60: [2, 46]
                    }, {
                        26: 88,
                        47: [1, 67]
                    }, {
                        47: [2, 57]
                    }, {
                        5: [2, 11],
                        14: [2, 11],
                        15: [2, 11],
                        19: [2, 11],
                        29: [2, 11],
                        34: [2, 11],
                        39: [2, 11],
                        44: [2, 11],
                        47: [2, 11],
                        48: [2, 11],
                        51: [2, 11],
                        55: [2, 11],
                        60: [2, 11]
                    }, {
                        15: [2, 49],
                        18: [2, 49]
                    }, {
                        20: 75,
                        33: [2, 88],
                        58: 89,
                        63: 90,
                        64: 76,
                        65: [1, 44],
                        69: 91,
                        70: 77,
                        71: 78,
                        72: [1, 79],
                        78: 26,
                        79: 27,
                        80: [1, 28],
                        81: [1, 29],
                        82: [1, 30],
                        83: [1, 31],
                        84: [1, 32],
                        85: [1, 34],
                        86: 33
                    }, {
                        65: [2, 94],
                        66: 92,
                        68: [2, 94],
                        72: [2, 94],
                        80: [2, 94],
                        81: [2, 94],
                        82: [2, 94],
                        83: [2, 94],
                        84: [2, 94],
                        85: [2, 94]
                    }, {
                        5: [2, 25],
                        14: [2, 25],
                        15: [2, 25],
                        19: [2, 25],
                        29: [2, 25],
                        34: [2, 25],
                        39: [2, 25],
                        44: [2, 25],
                        47: [2, 25],
                        48: [2, 25],
                        51: [2, 25],
                        55: [2, 25],
                        60: [2, 25]
                    }, {
                        20: 93,
                        72: [1, 35],
                        78: 26,
                        79: 27,
                        80: [1, 28],
                        81: [1, 29],
                        82: [1, 30],
                        83: [1, 31],
                        84: [1, 32],
                        85: [1, 34],
                        86: 33
                    }, {
                        20: 75,
                        31: 94,
                        33: [2, 60],
                        63: 95,
                        64: 76,
                        65: [1, 44],
                        69: 96,
                        70: 77,
                        71: 78,
                        72: [1, 79],
                        75: [2, 60],
                        78: 26,
                        79: 27,
                        80: [1, 28],
                        81: [1, 29],
                        82: [1, 30],
                        83: [1, 31],
                        84: [1, 32],
                        85: [1, 34],
                        86: 33
                    }, {
                        20: 75,
                        33: [2, 66],
                        36: 97,
                        63: 98,
                        64: 76,
                        65: [1, 44],
                        69: 99,
                        70: 77,
                        71: 78,
                        72: [1, 79],
                        75: [2, 66],
                        78: 26,
                        79: 27,
                        80: [1, 28],
                        81: [1, 29],
                        82: [1, 30],
                        83: [1, 31],
                        84: [1, 32],
                        85: [1, 34],
                        86: 33
                    }, {
                        20: 75,
                        22: 100,
                        23: [2, 52],
                        63: 101,
                        64: 76,
                        65: [1, 44],
                        69: 102,
                        70: 77,
                        71: 78,
                        72: [1, 79],
                        78: 26,
                        79: 27,
                        80: [1, 28],
                        81: [1, 29],
                        82: [1, 30],
                        83: [1, 31],
                        84: [1, 32],
                        85: [1, 34],
                        86: 33
                    }, {
                        20: 75,
                        33: [2, 92],
                        62: 103,
                        63: 104,
                        64: 76,
                        65: [1, 44],
                        69: 105,
                        70: 77,
                        71: 78,
                        72: [1, 79],
                        78: 26,
                        79: 27,
                        80: [1, 28],
                        81: [1, 29],
                        82: [1, 30],
                        83: [1, 31],
                        84: [1, 32],
                        85: [1, 34],
                        86: 33
                    }, {
                        33: [1, 106]
                    }, {
                        33: [2, 79],
                        65: [2, 79],
                        72: [2, 79],
                        80: [2, 79],
                        81: [2, 79],
                        82: [2, 79],
                        83: [2, 79],
                        84: [2, 79],
                        85: [2, 79]
                    }, {
                        33: [2, 81]
                    }, {
                        23: [2, 27],
                        33: [2, 27],
                        54: [2, 27],
                        65: [2, 27],
                        68: [2, 27],
                        72: [2, 27],
                        75: [2, 27],
                        80: [2, 27],
                        81: [2, 27],
                        82: [2, 27],
                        83: [2, 27],
                        84: [2, 27],
                        85: [2, 27]
                    }, {
                        23: [2, 28],
                        33: [2, 28],
                        54: [2, 28],
                        65: [2, 28],
                        68: [2, 28],
                        72: [2, 28],
                        75: [2, 28],
                        80: [2, 28],
                        81: [2, 28],
                        82: [2, 28],
                        83: [2, 28],
                        84: [2, 28],
                        85: [2, 28]
                    }, {
                        23: [2, 30],
                        33: [2, 30],
                        54: [2, 30],
                        68: [2, 30],
                        71: 107,
                        72: [1, 108],
                        75: [2, 30]
                    }, {
                        23: [2, 98],
                        33: [2, 98],
                        54: [2, 98],
                        68: [2, 98],
                        72: [2, 98],
                        75: [2, 98]
                    }, {
                        23: [2, 45],
                        33: [2, 45],
                        54: [2, 45],
                        65: [2, 45],
                        68: [2, 45],
                        72: [2, 45],
                        73: [1, 109],
                        75: [2, 45],
                        80: [2, 45],
                        81: [2, 45],
                        82: [2, 45],
                        83: [2, 45],
                        84: [2, 45],
                        85: [2, 45],
                        87: [2, 45]
                    }, {
                        23: [2, 44],
                        33: [2, 44],
                        54: [2, 44],
                        65: [2, 44],
                        68: [2, 44],
                        72: [2, 44],
                        75: [2, 44],
                        80: [2, 44],
                        81: [2, 44],
                        82: [2, 44],
                        83: [2, 44],
                        84: [2, 44],
                        85: [2, 44],
                        87: [2, 44]
                    }, {
                        54: [1, 110]
                    }, {
                        54: [2, 83],
                        65: [2, 83],
                        72: [2, 83],
                        80: [2, 83],
                        81: [2, 83],
                        82: [2, 83],
                        83: [2, 83],
                        84: [2, 83],
                        85: [2, 83]
                    }, {
                        54: [2, 85]
                    }, {
                        5: [2, 13],
                        14: [2, 13],
                        15: [2, 13],
                        19: [2, 13],
                        29: [2, 13],
                        34: [2, 13],
                        39: [2, 13],
                        44: [2, 13],
                        47: [2, 13],
                        48: [2, 13],
                        51: [2, 13],
                        55: [2, 13],
                        60: [2, 13]
                    }, {
                        38: 56,
                        39: [1, 58],
                        43: 57,
                        44: [1, 59],
                        45: 112,
                        46: 111,
                        47: [2, 76]
                    }, {
                        33: [2, 70],
                        40: 113,
                        65: [2, 70],
                        72: [2, 70],
                        75: [2, 70],
                        80: [2, 70],
                        81: [2, 70],
                        82: [2, 70],
                        83: [2, 70],
                        84: [2, 70],
                        85: [2, 70]
                    }, {
                        47: [2, 18]
                    }, {
                        5: [2, 14],
                        14: [2, 14],
                        15: [2, 14],
                        19: [2, 14],
                        29: [2, 14],
                        34: [2, 14],
                        39: [2, 14],
                        44: [2, 14],
                        47: [2, 14],
                        48: [2, 14],
                        51: [2, 14],
                        55: [2, 14],
                        60: [2, 14]
                    }, {
                        33: [1, 114]
                    }, {
                        33: [2, 87],
                        65: [2, 87],
                        72: [2, 87],
                        80: [2, 87],
                        81: [2, 87],
                        82: [2, 87],
                        83: [2, 87],
                        84: [2, 87],
                        85: [2, 87]
                    }, {
                        33: [2, 89]
                    }, {
                        20: 75,
                        63: 116,
                        64: 76,
                        65: [1, 44],
                        67: 115,
                        68: [2, 96],
                        69: 117,
                        70: 77,
                        71: 78,
                        72: [1, 79],
                        78: 26,
                        79: 27,
                        80: [1, 28],
                        81: [1, 29],
                        82: [1, 30],
                        83: [1, 31],
                        84: [1, 32],
                        85: [1, 34],
                        86: 33
                    }, {
                        33: [1, 118]
                    }, {
                        32: 119,
                        33: [2, 62],
                        74: 120,
                        75: [1, 121]
                    }, {
                        33: [2, 59],
                        65: [2, 59],
                        72: [2, 59],
                        75: [2, 59],
                        80: [2, 59],
                        81: [2, 59],
                        82: [2, 59],
                        83: [2, 59],
                        84: [2, 59],
                        85: [2, 59]
                    }, {
                        33: [2, 61],
                        75: [2, 61]
                    }, {
                        33: [2, 68],
                        37: 122,
                        74: 123,
                        75: [1, 121]
                    }, {
                        33: [2, 65],
                        65: [2, 65],
                        72: [2, 65],
                        75: [2, 65],
                        80: [2, 65],
                        81: [2, 65],
                        82: [2, 65],
                        83: [2, 65],
                        84: [2, 65],
                        85: [2, 65]
                    }, {
                        33: [2, 67],
                        75: [2, 67]
                    }, {
                        23: [1, 124]
                    }, {
                        23: [2, 51],
                        65: [2, 51],
                        72: [2, 51],
                        80: [2, 51],
                        81: [2, 51],
                        82: [2, 51],
                        83: [2, 51],
                        84: [2, 51],
                        85: [2, 51]
                    }, {
                        23: [2, 53]
                    }, {
                        33: [1, 125]
                    }, {
                        33: [2, 91],
                        65: [2, 91],
                        72: [2, 91],
                        80: [2, 91],
                        81: [2, 91],
                        82: [2, 91],
                        83: [2, 91],
                        84: [2, 91],
                        85: [2, 91]
                    }, {
                        33: [2, 93]
                    }, {
                        5: [2, 22],
                        14: [2, 22],
                        15: [2, 22],
                        19: [2, 22],
                        29: [2, 22],
                        34: [2, 22],
                        39: [2, 22],
                        44: [2, 22],
                        47: [2, 22],
                        48: [2, 22],
                        51: [2, 22],
                        55: [2, 22],
                        60: [2, 22]
                    }, {
                        23: [2, 99],
                        33: [2, 99],
                        54: [2, 99],
                        68: [2, 99],
                        72: [2, 99],
                        75: [2, 99]
                    }, {
                        73: [1, 109]
                    }, {
                        20: 75,
                        63: 126,
                        64: 76,
                        65: [1, 44],
                        72: [1, 35],
                        78: 26,
                        79: 27,
                        80: [1, 28],
                        81: [1, 29],
                        82: [1, 30],
                        83: [1, 31],
                        84: [1, 32],
                        85: [1, 34],
                        86: 33
                    }, {
                        5: [2, 23],
                        14: [2, 23],
                        15: [2, 23],
                        19: [2, 23],
                        29: [2, 23],
                        34: [2, 23],
                        39: [2, 23],
                        44: [2, 23],
                        47: [2, 23],
                        48: [2, 23],
                        51: [2, 23],
                        55: [2, 23],
                        60: [2, 23]
                    }, {
                        47: [2, 19]
                    }, {
                        47: [2, 77]
                    }, {
                        20: 75,
                        33: [2, 72],
                        41: 127,
                        63: 128,
                        64: 76,
                        65: [1, 44],
                        69: 129,
                        70: 77,
                        71: 78,
                        72: [1, 79],
                        75: [2, 72],
                        78: 26,
                        79: 27,
                        80: [1, 28],
                        81: [1, 29],
                        82: [1, 30],
                        83: [1, 31],
                        84: [1, 32],
                        85: [1, 34],
                        86: 33
                    }, {
                        5: [2, 24],
                        14: [2, 24],
                        15: [2, 24],
                        19: [2, 24],
                        29: [2, 24],
                        34: [2, 24],
                        39: [2, 24],
                        44: [2, 24],
                        47: [2, 24],
                        48: [2, 24],
                        51: [2, 24],
                        55: [2, 24],
                        60: [2, 24]
                    }, {
                        68: [1, 130]
                    }, {
                        65: [2, 95],
                        68: [2, 95],
                        72: [2, 95],
                        80: [2, 95],
                        81: [2, 95],
                        82: [2, 95],
                        83: [2, 95],
                        84: [2, 95],
                        85: [2, 95]
                    }, {
                        68: [2, 97]
                    }, {
                        5: [2, 21],
                        14: [2, 21],
                        15: [2, 21],
                        19: [2, 21],
                        29: [2, 21],
                        34: [2, 21],
                        39: [2, 21],
                        44: [2, 21],
                        47: [2, 21],
                        48: [2, 21],
                        51: [2, 21],
                        55: [2, 21],
                        60: [2, 21]
                    }, {
                        33: [1, 131]
                    }, {
                        33: [2, 63]
                    }, {
                        72: [1, 133],
                        76: 132
                    }, {
                        33: [1, 134]
                    }, {
                        33: [2, 69]
                    }, {
                        15: [2, 12]
                    }, {
                        14: [2, 26],
                        15: [2, 26],
                        19: [2, 26],
                        29: [2, 26],
                        34: [2, 26],
                        47: [2, 26],
                        48: [2, 26],
                        51: [2, 26],
                        55: [2, 26],
                        60: [2, 26]
                    }, {
                        23: [2, 31],
                        33: [2, 31],
                        54: [2, 31],
                        68: [2, 31],
                        72: [2, 31],
                        75: [2, 31]
                    }, {
                        33: [2, 74],
                        42: 135,
                        74: 136,
                        75: [1, 121]
                    }, {
                        33: [2, 71],
                        65: [2, 71],
                        72: [2, 71],
                        75: [2, 71],
                        80: [2, 71],
                        81: [2, 71],
                        82: [2, 71],
                        83: [2, 71],
                        84: [2, 71],
                        85: [2, 71]
                    }, {
                        33: [2, 73],
                        75: [2, 73]
                    }, {
                        23: [2, 29],
                        33: [2, 29],
                        54: [2, 29],
                        65: [2, 29],
                        68: [2, 29],
                        72: [2, 29],
                        75: [2, 29],
                        80: [2, 29],
                        81: [2, 29],
                        82: [2, 29],
                        83: [2, 29],
                        84: [2, 29],
                        85: [2, 29]
                    }, {
                        14: [2, 15],
                        15: [2, 15],
                        19: [2, 15],
                        29: [2, 15],
                        34: [2, 15],
                        39: [2, 15],
                        44: [2, 15],
                        47: [2, 15],
                        48: [2, 15],
                        51: [2, 15],
                        55: [2, 15],
                        60: [2, 15]
                    }, {
                        72: [1, 138],
                        77: [1, 137]
                    }, {
                        72: [2, 100],
                        77: [2, 100]
                    }, {
                        14: [2, 16],
                        15: [2, 16],
                        19: [2, 16],
                        29: [2, 16],
                        34: [2, 16],
                        44: [2, 16],
                        47: [2, 16],
                        48: [2, 16],
                        51: [2, 16],
                        55: [2, 16],
                        60: [2, 16]
                    }, {
                        33: [1, 139]
                    }, {
                        33: [2, 75]
                    }, {
                        33: [2, 32]
                    }, {
                        72: [2, 101],
                        77: [2, 101]
                    }, {
                        14: [2, 17],
                        15: [2, 17],
                        19: [2, 17],
                        29: [2, 17],
                        34: [2, 17],
                        39: [2, 17],
                        44: [2, 17],
                        47: [2, 17],
                        48: [2, 17],
                        51: [2, 17],
                        55: [2, 17],
                        60: [2, 17]
                    }],
                    defaultActions: {
                        4: [2, 1],
                        55: [2, 55],
                        57: [2, 20],
                        61: [2, 57],
                        74: [2, 81],
                        83: [2, 85],
                        87: [2, 18],
                        91: [2, 89],
                        102: [2, 53],
                        105: [2, 93],
                        111: [2, 19],
                        112: [2, 77],
                        117: [2, 97],
                        120: [2, 63],
                        123: [2, 69],
                        124: [2, 12],
                        136: [2, 75],
                        137: [2, 32]
                    },
                    parseError: function(e, t) {
                        throw new Error(e)
                    },
                    parse: function(e) {
                        function t() {
                            var e;
                            return "number" != typeof(e = n.lexer.lex() || 1) && (e = n.symbols_[e] || e), e
                        }
                        var n = this,
                            i = [0],
                            s = [null],
                            r = [],
                            o = this.table,
                            a = "",
                            l = 0,
                            c = 0,
                            d = 0;
                        this.lexer.setInput(e), this.lexer.yy = this.yy, this.yy.lexer = this.lexer, this.yy.parser = this, void 0 === this.lexer.yylloc && (this.lexer.yylloc = {});
                        var u = this.lexer.yylloc;
                        r.push(u);
                        var h = this.lexer.options && this.lexer.options.ranges;
                        "function" == typeof this.yy.parseError && (this.parseError = this.yy.parseError);
                        for (var p, f, m, g, v, _, y, b, w, x = {};;) {
                            if (m = i[i.length - 1], this.defaultActions[m] ? g = this.defaultActions[m] : (null !== p && void 0 !== p || (p = t()), g = o[m] && o[m][p]), void 0 === g || !g.length || !g[0]) {
                                var k = "";
                                if (!d) {
                                    w = [];
                                    for (_ in o[m]) this.terminals_[_] && _ > 2 && w.push("'" + this.terminals_[_] + "'");
                                    k = this.lexer.showPosition ? "Parse error on line " + (l + 1) + ":\n" + this.lexer.showPosition() + "\nExpecting " + w.join(", ") + ", got '" + (this.terminals_[p] || p) + "'" : "Parse error on line " + (l + 1) + ": Unexpected " + (1 == p ? "end of input" : "'" + (this.terminals_[p] || p) + "'"), this.parseError(k, {
                                        text: this.lexer.match,
                                        token: this.terminals_[p] || p,
                                        line: this.lexer.yylineno,
                                        loc: u,
                                        expected: w
                                    })
                                }
                            }
                            if (g[0] instanceof Array && g.length > 1) throw new Error("Parse Error: multiple actions possible at state: " + m + ", token: " + p);
                            switch (g[0]) {
                                case 1:
                                    i.push(p), s.push(this.lexer.yytext), r.push(this.lexer.yylloc), i.push(g[1]), p = null, f ? (p = f, f = null) : (c = this.lexer.yyleng, a = this.lexer.yytext, l = this.lexer.yylineno, u = this.lexer.yylloc, d > 0 && d--);
                                    break;
                                case 2:
                                    if (y = this.productions_[g[1]][1], x.$ = s[s.length - y], x._$ = {
                                            first_line: r[r.length - (y || 1)].first_line,
                                            last_line: r[r.length - 1].last_line,
                                            first_column: r[r.length - (y || 1)].first_column,
                                            last_column: r[r.length - 1].last_column
                                        }, h && (x._$.range = [r[r.length - (y || 1)].range[0], r[r.length - 1].range[1]]), void 0 !== (v = this.performAction.call(x, a, c, l, this.yy, g[1], s, r))) return v;
                                    y && (i = i.slice(0, -1 * y * 2), s = s.slice(0, -1 * y), r = r.slice(0, -1 * y)), i.push(this.productions_[g[1]][0]), s.push(x.$), r.push(x._$), b = o[i[i.length - 2]][i[i.length - 1]], i.push(b);
                                    break;
                                case 3:
                                    return !0
                            }
                        }
                        return !0
                    }
                },
                n = function() {
                    var e = {
                        EOF: 1,
                        parseError: function(e, t) {
                            if (!this.yy.parser) throw new Error(e);
                            this.yy.parser.parseError(e, t)
                        },
                        setInput: function(e) {
                            return this._input = e, this._more = this._less = this.done = !1, this.yylineno = this.yyleng = 0, this.yytext = this.matched = this.match = "", this.conditionStack = ["INITIAL"], this.yylloc = {
                                first_line: 1,
                                first_column: 0,
                                last_line: 1,
                                last_column: 0
                            }, this.options.ranges && (this.yylloc.range = [0, 0]), this.offset = 0, this
                        },
                        input: function() {
                            var e = this._input[0];
                            this.yytext += e, this.yyleng++, this.offset++, this.match += e, this.matched += e;
                            return e.match(/(?:\r\n?|\n).*/g) ? (this.yylineno++, this.yylloc.last_line++) : this.yylloc.last_column++, this.options.ranges && this.yylloc.range[1]++, this._input = this._input.slice(1), e
                        },
                        unput: function(e) {
                            var t = e.length,
                                n = e.split(/(?:\r\n?|\n)/g);
                            this._input = e + this._input, this.yytext = this.yytext.substr(0, this.yytext.length - t - 1), this.offset -= t;
                            var i = this.match.split(/(?:\r\n?|\n)/g);
                            this.match = this.match.substr(0, this.match.length - 1), this.matched = this.matched.substr(0, this.matched.length - 1), n.length - 1 && (this.yylineno -= n.length - 1);
                            var s = this.yylloc.range;
                            return this.yylloc = {
                                first_line: this.yylloc.first_line,
                                last_line: this.yylineno + 1,
                                first_column: this.yylloc.first_column,
                                last_column: n ? (n.length === i.length ? this.yylloc.first_column : 0) + i[i.length - n.length].length - n[0].length : this.yylloc.first_column - t
                            }, this.options.ranges && (this.yylloc.range = [s[0], s[0] + this.yyleng - t]), this
                        },
                        more: function() {
                            return this._more = !0, this
                        },
                        less: function(e) {
                            this.unput(this.match.slice(e))
                        },
                        pastInput: function() {
                            var e = this.matched.substr(0, this.matched.length - this.match.length);
                            return (e.length > 20 ? "..." : "") + e.substr(-20).replace(/\n/g, "")
                        },
                        upcomingInput: function() {
                            var e = this.match;
                            return e.length < 20 && (e += this._input.substr(0, 20 - e.length)), (e.substr(0, 20) + (e.length > 20 ? "..." : "")).replace(/\n/g, "")
                        },
                        showPosition: function() {
                            var e = this.pastInput(),
                                t = new Array(e.length + 1).join("-");
                            return e + this.upcomingInput() + "\n" + t + "^"
                        },
                        next: function() {
                            if (this.done) return this.EOF;
                            this._input || (this.done = !0);
                            var e, t, n, i, s;
                            this._more || (this.yytext = "", this.match = "");
                            for (var r = this._currentRules(), o = 0; o < r.length && (!(n = this._input.match(this.rules[r[o]])) || t && !(n[0].length > t[0].length) || (t = n, i = o, this.options.flex)); o++);
                            return t ? ((s = t[0].match(/(?:\r\n?|\n).*/g)) && (this.yylineno += s.length), this.yylloc = {
                                first_line: this.yylloc.last_line,
                                last_line: this.yylineno + 1,
                                first_column: this.yylloc.last_column,
                                last_column: s ? s[s.length - 1].length - s[s.length - 1].match(/\r?\n?/)[0].length : this.yylloc.last_column + t[0].length
                            }, this.yytext += t[0], this.match += t[0], this.matches = t, this.yyleng = this.yytext.length, this.options.ranges && (this.yylloc.range = [this.offset, this.offset += this.yyleng]), this._more = !1, this._input = this._input.slice(t[0].length), this.matched += t[0], e = this.performAction.call(this, this.yy, this, r[i], this.conditionStack[this.conditionStack.length - 1]), this.done && this._input && (this.done = !1), e || void 0) : "" === this._input ? this.EOF : this.parseError("Lexical error on line " + (this.yylineno + 1) + ". Unrecognized text.\n" + this.showPosition(), {
                                text: "",
                                token: null,
                                line: this.yylineno
                            })
                        },
                        lex: function() {
                            var e = this.next();
                            return void 0 !== e ? e : this.lex()
                        },
                        begin: function(e) {
                            this.conditionStack.push(e)
                        },
                        popState: function() {
                            return this.conditionStack.pop()
                        },
                        _currentRules: function() {
                            return this.conditions[this.conditionStack[this.conditionStack.length - 1]].rules
                        },
                        topState: function() {
                            return this.conditionStack[this.conditionStack.length - 2]
                        },
                        pushState: function(e) {
                            this.begin(e)
                        }
                    };
                    return e.options = {}, e.performAction = function(e, t, n, i) {
                        function s(e, n) {
                            return t.yytext = t.yytext.substr(e, t.yyleng - n)
                        }
                        switch (n) {
                            case 0:
                                if ("\\\\" === t.yytext.slice(-2) ? (s(0, 1), this.begin("mu")) : "\\" === t.yytext.slice(-1) ? (s(0, 1), this.begin("emu")) : this.begin("mu"), t.yytext) return 15;
                                break;
                            case 1:
                                return 15;
                            case 2:
                                return this.popState(), 15;
                            case 3:
                                return this.begin("raw"), 15;
                            case 4:
                                return this.popState(), "raw" === this.conditionStack[this.conditionStack.length - 1] ? 15 : (t.yytext = t.yytext.substr(5, t.yyleng - 9), "END_RAW_BLOCK");
                            case 5:
                                return 15;
                            case 6:
                                return this.popState(), 14;
                            case 7:
                                return 65;
                            case 8:
                                return 68;
                            case 9:
                                return 19;
                            case 10:
                                return this.popState(), this.begin("raw"), 23;
                            case 11:
                                return 55;
                            case 12:
                                return 60;
                            case 13:
                                return 29;
                            case 14:
                                return 47;
                            case 15:
                            case 16:
                                return this.popState(), 44;
                            case 17:
                                return 34;
                            case 18:
                                return 39;
                            case 19:
                                return 51;
                            case 20:
                                return 48;
                            case 21:
                                this.unput(t.yytext), this.popState(), this.begin("com");
                                break;
                            case 22:
                                return this.popState(), 14;
                            case 23:
                                return 48;
                            case 24:
                                return 73;
                            case 25:
                            case 26:
                                return 72;
                            case 27:
                                return 87;
                            case 28:
                                break;
                            case 29:
                                return this.popState(), 54;
                            case 30:
                                return this.popState(), 33;
                            case 31:
                                return t.yytext = s(1, 2).replace(/\\"/g, '"'), 80;
                            case 32:
                                return t.yytext = s(1, 2).replace(/\\'/g, "'"), 80;
                            case 33:
                                return 85;
                            case 34:
                            case 35:
                                return 82;
                            case 36:
                                return 83;
                            case 37:
                                return 84;
                            case 38:
                                return 81;
                            case 39:
                                return 75;
                            case 40:
                                return 77;
                            case 41:
                                return 72;
                            case 42:
                                return t.yytext = t.yytext.replace(/\\([\\\]])/g, "$1"), 72;
                            case 43:
                                return "INVALID";
                            case 44:
                                return 5
                        }
                    }, e.rules = [/^(?:[^\x00]*?(?=(\{\{)))/, /^(?:[^\x00]+)/, /^(?:[^\x00]{2,}?(?=(\{\{|\\\{\{|\\\\\{\{|$)))/, /^(?:\{\{\{\{(?=[^\/]))/, /^(?:\{\{\{\{\/[^\s!"#%-,\.\/;->@\[-\^`\{-~]+(?=[=}\s\/.])\}\}\}\})/, /^(?:[^\x00]*?(?=(\{\{\{\{)))/, /^(?:[\s\S]*?--(~)?\}\})/, /^(?:\()/, /^(?:\))/, /^(?:\{\{\{\{)/, /^(?:\}\}\}\})/, /^(?:\{\{(~)?>)/, /^(?:\{\{(~)?#>)/, /^(?:\{\{(~)?#\*?)/, /^(?:\{\{(~)?\/)/, /^(?:\{\{(~)?\^\s*(~)?\}\})/, /^(?:\{\{(~)?\s*else\s*(~)?\}\})/, /^(?:\{\{(~)?\^)/, /^(?:\{\{(~)?\s*else\b)/, /^(?:\{\{(~)?\{)/, /^(?:\{\{(~)?&)/, /^(?:\{\{(~)?!--)/, /^(?:\{\{(~)?![\s\S]*?\}\})/, /^(?:\{\{(~)?\*?)/, /^(?:=)/, /^(?:\.\.)/, /^(?:\.(?=([=~}\s\/.)|])))/, /^(?:[\/.])/, /^(?:\s+)/, /^(?:\}(~)?\}\})/, /^(?:(~)?\}\})/, /^(?:"(\\["]|[^"])*")/, /^(?:'(\\[']|[^'])*')/, /^(?:@)/, /^(?:true(?=([~}\s)])))/, /^(?:false(?=([~}\s)])))/, /^(?:undefined(?=([~}\s)])))/, /^(?:null(?=([~}\s)])))/, /^(?:-?[0-9]+(?:\.[0-9]+)?(?=([~}\s)])))/, /^(?:as\s+\|)/, /^(?:\|)/, /^(?:([^\s!"#%-,\.\/;->@\[-\^`\{-~]+(?=([=~}\s\/.)|]))))/, /^(?:\[(\\\]|[^\]])*\])/, /^(?:.)/, /^(?:$)/], e.conditions = {
                        mu: {
                            rules: [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44],
                            inclusive: !1
                        },
                        emu: {
                            rules: [2],
                            inclusive: !1
                        },
                        com: {
                            rules: [6],
                            inclusive: !1
                        },
                        raw: {
                            rules: [3, 4, 5],
                            inclusive: !1
                        },
                        INITIAL: {
                            rules: [0, 1, 44],
                            inclusive: !0
                        }
                    }, e
                }();
            return t.lexer = n, e.prototype = t, t.Parser = e, new e
        }();
        t.default = n, e.exports = t.default
    }, function(e, t, n) {
        "use strict";

        function i() {
            var e = arguments.length <= 0 || void 0 === arguments[0] ? {} : arguments[0];
            this.options = e
        }

        function s(e, t, n) {
            void 0 === t && (t = e.length);
            var i = e[t - 1],
                s = e[t - 2];
            return i ? "ContentStatement" === i.type ? (s || !n ? /\r?\n\s*?$/ : /(^|\r?\n)\s*?$/).test(i.original) : void 0 : n
        }

        function r(e, t, n) {
            void 0 === t && (t = -1);
            var i = e[t + 1],
                s = e[t + 2];
            return i ? "ContentStatement" === i.type ? (s || !n ? /^\s*?\r?\n/ : /^\s*?(\r?\n|$)/).test(i.original) : void 0 : n
        }

        function o(e, t, n) {
            var i = e[null == t ? 0 : t + 1];
            if (i && "ContentStatement" === i.type && (n || !i.rightStripped)) {
                var s = i.value;
                i.value = i.value.replace(n ? /^\s+/ : /^[ \t]*\r?\n?/, ""), i.rightStripped = i.value !== s
            }
        }

        function a(e, t, n) {
            var i = e[null == t ? e.length - 1 : t - 1];
            if (i && "ContentStatement" === i.type && (n || !i.leftStripped)) {
                var s = i.value;
                return i.value = i.value.replace(n ? /\s+$/ : /[ \t]+$/, ""), i.leftStripped = i.value !== s, i.leftStripped
            }
        }
        var l = n(1).default;
        t.__esModule = !0;
        var c = l(n(39));
        (i.prototype = new c.default).Program = function(e) {
            var t = !this.options.ignoreStandalone,
                n = !this.isRootSeen;
            this.isRootSeen = !0;
            for (var i = e.body, l = 0, c = i.length; l < c; l++) {
                var d = i[l],
                    u = this.accept(d);
                if (u) {
                    var h = s(i, l, n),
                        p = r(i, l, n),
                        f = u.openStandalone && h,
                        m = u.closeStandalone && p,
                        g = u.inlineStandalone && h && p;
                    u.close && o(i, l, !0), u.open && a(i, l, !0), t && g && (o(i, l), a(i, l) && "PartialStatement" === d.type && (d.indent = /([ \t]+$)/.exec(i[l - 1].original)[1])), t && f && (o((d.program || d.inverse).body), a(i, l)), t && m && (o(i, l), a((d.inverse || d.program).body))
                }
            }
            return e
        }, i.prototype.BlockStatement = i.prototype.DecoratorBlock = i.prototype.PartialBlockStatement = function(e) {
            this.accept(e.program), this.accept(e.inverse);
            var t = e.program || e.inverse,
                n = e.program && e.inverse,
                i = n,
                l = n;
            if (n && n.chained)
                for (i = n.body[0].program; l.chained;) l = l.body[l.body.length - 1].program;
            var c = {
                open: e.openStrip.open,
                close: e.closeStrip.close,
                openStandalone: r(t.body),
                closeStandalone: s((i || t).body)
            };
            if (e.openStrip.close && o(t.body, null, !0), n) {
                var d = e.inverseStrip;
                d.open && a(t.body, null, !0), d.close && o(i.body, null, !0), e.closeStrip.open && a(l.body, null, !0), !this.options.ignoreStandalone && s(t.body) && r(i.body) && (a(t.body), o(i.body))
            } else e.closeStrip.open && a(t.body, null, !0);
            return c
        }, i.prototype.Decorator = i.prototype.MustacheStatement = function(e) {
            return e.strip
        }, i.prototype.PartialStatement = i.prototype.CommentStatement = function(e) {
            var t = e.strip || {};
            return {
                inlineStandalone: !0,
                open: t.open,
                close: t.close
            }
        }, t.default = i, e.exports = t.default
    }, function(e, t, n) {
        "use strict";

        function i() {
            this.parents = []
        }

        function s(e) {
            this.acceptRequired(e, "path"), this.acceptArray(e.params), this.acceptKey(e, "hash")
        }

        function r(e) {
            s.call(this, e), this.acceptKey(e, "program"), this.acceptKey(e, "inverse")
        }

        function o(e) {
            this.acceptRequired(e, "name"), this.acceptArray(e.params), this.acceptKey(e, "hash")
        }
        var a = n(1).default;
        t.__esModule = !0;
        var l = a(n(6));
        i.prototype = {
            constructor: i,
            mutating: !1,
            acceptKey: function(e, t) {
                var n = this.accept(e[t]);
                if (this.mutating) {
                    if (n && !i.prototype[n.type]) throw new l.default('Unexpected node type "' + n.type + '" found when accepting ' + t + " on " + e.type);
                    e[t] = n
                }
            },
            acceptRequired: function(e, t) {
                if (this.acceptKey(e, t), !e[t]) throw new l.default(e.type + " requires " + t)
            },
            acceptArray: function(e) {
                for (var t = 0, n = e.length; t < n; t++) this.acceptKey(e, t), e[t] || (e.splice(t, 1), t--, n--)
            },
            accept: function(e) {
                if (e) {
                    if (!this[e.type]) throw new l.default("Unknown type: " + e.type, e);
                    this.current && this.parents.unshift(this.current), this.current = e;
                    var t = this[e.type](e);
                    return this.current = this.parents.shift(), !this.mutating || t ? t : !1 !== t ? e : void 0
                }
            },
            Program: function(e) {
                this.acceptArray(e.body)
            },
            MustacheStatement: s,
            Decorator: s,
            BlockStatement: r,
            DecoratorBlock: r,
            PartialStatement: o,
            PartialBlockStatement: function(e) {
                o.call(this, e), this.acceptKey(e, "program")
            },
            ContentStatement: function() {},
            CommentStatement: function() {},
            SubExpression: s,
            PathExpression: function() {},
            StringLiteral: function() {},
            NumberLiteral: function() {},
            BooleanLiteral: function() {},
            UndefinedLiteral: function() {},
            NullLiteral: function() {},
            Hash: function(e) {
                this.acceptArray(e.pairs)
            },
            HashPair: function(e) {
                this.acceptRequired(e, "value")
            }
        }, t.default = i, e.exports = t.default
    }, function(e, t, n) {
        "use strict";

        function i(e, t) {
            if (t = t.path ? t.path.original : t, e.path.original !== t) {
                var n = {
                    loc: e.path.loc
                };
                throw new r.default(e.path.original + " doesn't match " + t, n)
            }
        }
        var s = n(1).default;
        t.__esModule = !0, t.SourceLocation = function(e, t) {
            this.source = e, this.start = {
                line: t.first_line,
                column: t.first_column
            }, this.end = {
                line: t.last_line,
                column: t.last_column
            }
        }, t.id = function(e) {
            return /^\[.*\]$/.test(e) ? e.substr(1, e.length - 2) : e
        }, t.stripFlags = function(e, t) {
            return {
                open: "~" === e.charAt(2),
                close: "~" === t.charAt(t.length - 3)
            }
        }, t.stripComment = function(e) {
            return e.replace(/^\{\{~?\!-?-?/, "").replace(/-?-?~?\}\}$/, "")
        }, t.preparePath = function(e, t, n) {
            n = this.locInfo(n);
            for (var i = e ? "@" : "", s = [], o = 0, a = 0, l = t.length; a < l; a++) {
                var c = t[a].part,
                    d = t[a].original !== c;
                if (i += (t[a].separator || "") + c, d || ".." !== c && "." !== c && "this" !== c) s.push(c);
                else {
                    if (s.length > 0) throw new r.default("Invalid path: " + i, {
                        loc: n
                    });
                    ".." === c && o++
                }
            }
            return {
                type: "PathExpression",
                data: e,
                depth: o,
                parts: s,
                original: i,
                loc: n
            }
        }, t.prepareMustache = function(e, t, n, i, s, r) {
            var o = i.charAt(3) || i.charAt(2),
                a = "{" !== o && "&" !== o;
            return {
                type: /\*/.test(i) ? "Decorator" : "MustacheStatement",
                path: e,
                params: t,
                hash: n,
                escaped: a,
                strip: s,
                loc: this.locInfo(r)
            }
        }, t.prepareRawBlock = function(e, t, n, s) {
            i(e, n);
            var r = {
                type: "Program",
                body: t,
                strip: {},
                loc: s = this.locInfo(s)
            };
            return {
                type: "BlockStatement",
                path: e.path,
                params: e.params,
                hash: e.hash,
                program: r,
                openStrip: {},
                inverseStrip: {},
                closeStrip: {},
                loc: s
            }
        }, t.prepareBlock = function(e, t, n, s, o, a) {
            s && s.path && i(e, s);
            var l = /\*/.test(e.open);
            t.blockParams = e.blockParams;
            var c = void 0,
                d = void 0;
            if (n) {
                if (l) throw new r.default("Unexpected inverse block on decorator", n);
                n.chain && (n.program.body[0].closeStrip = s.strip), d = n.strip, c = n.program
            }
            return o && (o = c, c = t, t = o), {
                type: l ? "DecoratorBlock" : "BlockStatement",
                path: e.path,
                params: e.params,
                hash: e.hash,
                program: t,
                inverse: c,
                openStrip: e.strip,
                inverseStrip: d,
                closeStrip: s && s.strip,
                loc: this.locInfo(a)
            }
        }, t.prepareProgram = function(e, t) {
            if (!t && e.length) {
                var n = e[0].loc,
                    i = e[e.length - 1].loc;
                n && i && (t = {
                    source: n.source,
                    start: {
                        line: n.start.line,
                        column: n.start.column
                    },
                    end: {
                        line: i.end.line,
                        column: i.end.column
                    }
                })
            }
            return {
                type: "Program",
                body: e,
                strip: {},
                loc: t
            }
        }, t.preparePartialBlock = function(e, t, n, s) {
            return i(e, n), {
                type: "PartialBlockStatement",
                name: e.path,
                params: e.params,
                hash: e.hash,
                program: t,
                openStrip: e.strip,
                closeStrip: n && n.strip,
                loc: this.locInfo(s)
            }
        };
        var r = s(n(6))
    }, function(e, t, n) {
        "use strict";

        function i() {}

        function s(e, t) {
            if (e === t) return !0;
            if (l.isArray(e) && l.isArray(t) && e.length === t.length) {
                for (var n = 0; n < e.length; n++)
                    if (!s(e[n], t[n])) return !1;
                return !0
            }
        }

        function r(e) {
            if (!e.path.parts) {
                var t = e.path;
                e.path = {
                    type: "PathExpression",
                    data: !1,
                    depth: 0,
                    parts: [t.original + ""],
                    original: t.original + "",
                    loc: t.loc
                }
            }
        }
        var o = n(1).default;
        t.__esModule = !0, t.Compiler = i, t.precompile = function(e, t, n) {
            if (null == e || "string" != typeof e && "Program" !== e.type) throw new a.default("You must pass a string or Handlebars AST to Handlebars.precompile. You passed " + e);
            "data" in (t = t || {}) || (t.data = !0), t.compat && (t.useDepths = !0);
            var i = n.parse(e, t),
                s = (new n.Compiler).compile(i, t);
            return (new n.JavaScriptCompiler).compile(s, t)
        }, t.compile = function(e, t, n) {
            function i() {
                var i = n.parse(e, t),
                    s = (new n.Compiler).compile(i, t),
                    r = (new n.JavaScriptCompiler).compile(s, t, void 0, !0);
                return n.template(r)
            }

            function s(e, t) {
                return r || (r = i()), r.call(this, e, t)
            }
            if (void 0 === t && (t = {}), null == e || "string" != typeof e && "Program" !== e.type) throw new a.default("You must pass a string or Handlebars AST to Handlebars.compile. You passed " + e);
            "data" in (t = l.extend({}, t)) || (t.data = !0), t.compat && (t.useDepths = !0);
            var r = void 0;
            return s._setup = function(e) {
                return r || (r = i()), r._setup(e)
            }, s._child = function(e, t, n, s) {
                return r || (r = i()), r._child(e, t, n, s)
            }, s
        };
        var a = o(n(6)),
            l = n(5),
            c = o(n(35)),
            d = [].slice;
        i.prototype = {
            compiler: i,
            equals: function(e) {
                var t = this.opcodes.length;
                if (e.opcodes.length !== t) return !1;
                for (var n = 0; n < t; n++) {
                    var i = this.opcodes[n],
                        r = e.opcodes[n];
                    if (i.opcode !== r.opcode || !s(i.args, r.args)) return !1
                }
                t = this.children.length;
                for (n = 0; n < t; n++)
                    if (!this.children[n].equals(e.children[n])) return !1;
                return !0
            },
            guid: 0,
            compile: function(e, t) {
                this.sourceNode = [], this.opcodes = [], this.children = [], this.options = t, this.stringParams = t.stringParams, this.trackIds = t.trackIds, t.blockParams = t.blockParams || [];
                var n = t.knownHelpers;
                if (t.knownHelpers = {
                        helperMissing: !0,
                        blockHelperMissing: !0,
                        each: !0,
                        if: !0,
                        unless: !0,
                        with: !0,
                        log: !0,
                        lookup: !0
                    }, n)
                    for (var i in n) i in n && (this.options.knownHelpers[i] = n[i]);
                return this.accept(e)
            },
            compileProgram: function(e) {
                var t = (new this.compiler).compile(e, this.options),
                    n = this.guid++;
                return this.usePartial = this.usePartial || t.usePartial, this.children[n] = t, this.useDepths = this.useDepths || t.useDepths, n
            },
            accept: function(e) {
                if (!this[e.type]) throw new a.default("Unknown type: " + e.type, e);
                this.sourceNode.unshift(e);
                var t = this[e.type](e);
                return this.sourceNode.shift(), t
            },
            Program: function(e) {
                this.options.blockParams.unshift(e.blockParams);
                for (var t = e.body, n = t.length, i = 0; i < n; i++) this.accept(t[i]);
                return this.options.blockParams.shift(), this.isSimple = 1 === n, this.blockParams = e.blockParams ? e.blockParams.length : 0, this
            },
            BlockStatement: function(e) {
                r(e);
                var t = e.program,
                    n = e.inverse;
                t = t && this.compileProgram(t), n = n && this.compileProgram(n);
                var i = this.classifySexpr(e);
                "helper" === i ? this.helperSexpr(e, t, n) : "simple" === i ? (this.simpleSexpr(e), this.opcode("pushProgram", t), this.opcode("pushProgram", n), this.opcode("emptyHash"), this.opcode("blockValue", e.path.original)) : (this.ambiguousSexpr(e, t, n), this.opcode("pushProgram", t), this.opcode("pushProgram", n), this.opcode("emptyHash"), this.opcode("ambiguousBlockValue")), this.opcode("append")
            },
            DecoratorBlock: function(e) {
                var t = e.program && this.compileProgram(e.program),
                    n = this.setupFullMustacheParams(e, t, void 0),
                    i = e.path;
                this.useDecorators = !0, this.opcode("registerDecorator", n.length, i.original)
            },
            PartialStatement: function(e) {
                this.usePartial = !0;
                var t = e.program;
                t && (t = this.compileProgram(e.program));
                var n = e.params;
                if (n.length > 1) throw new a.default("Unsupported number of partial arguments: " + n.length, e);
                n.length || (this.options.explicitPartialContext ? this.opcode("pushLiteral", "undefined") : n.push({
                    type: "PathExpression",
                    parts: [],
                    depth: 0
                }));
                var i = e.name.original,
                    s = "SubExpression" === e.name.type;
                s && this.accept(e.name), this.setupFullMustacheParams(e, t, void 0, !0);
                var r = e.indent || "";
                this.options.preventIndent && r && (this.opcode("appendContent", r), r = ""), this.opcode("invokePartial", s, i, r), this.opcode("append")
            },
            PartialBlockStatement: function(e) {
                this.PartialStatement(e)
            },
            MustacheStatement: function(e) {
                this.SubExpression(e), e.escaped && !this.options.noEscape ? this.opcode("appendEscaped") : this.opcode("append")
            },
            Decorator: function(e) {
                this.DecoratorBlock(e)
            },
            ContentStatement: function(e) {
                e.value && this.opcode("appendContent", e.value)
            },
            CommentStatement: function() {},
            SubExpression: function(e) {
                r(e);
                var t = this.classifySexpr(e);
                "simple" === t ? this.simpleSexpr(e) : "helper" === t ? this.helperSexpr(e) : this.ambiguousSexpr(e)
            },
            ambiguousSexpr: function(e, t, n) {
                var i = e.path,
                    s = i.parts[0],
                    r = null != t || null != n;
                this.opcode("getContext", i.depth), this.opcode("pushProgram", t), this.opcode("pushProgram", n), i.strict = !0, this.accept(i), this.opcode("invokeAmbiguous", s, r)
            },
            simpleSexpr: function(e) {
                var t = e.path;
                t.strict = !0, this.accept(t), this.opcode("resolvePossibleLambda")
            },
            helperSexpr: function(e, t, n) {
                var i = this.setupFullMustacheParams(e, t, n),
                    s = e.path,
                    r = s.parts[0];
                if (this.options.knownHelpers[r]) this.opcode("invokeKnownHelper", i.length, r);
                else {
                    if (this.options.knownHelpersOnly) throw new a.default("You specified knownHelpersOnly, but used the unknown helper " + r, e);
                    s.strict = !0, s.falsy = !0, this.accept(s), this.opcode("invokeHelper", i.length, s.original, c.default.helpers.simpleId(s))
                }
            },
            PathExpression: function(e) {
                this.addDepth(e.depth), this.opcode("getContext", e.depth);
                var t = e.parts[0],
                    n = c.default.helpers.scopedId(e),
                    i = !e.depth && !n && this.blockParamIndex(t);
                i ? this.opcode("lookupBlockParam", i, e.parts) : t ? e.data ? (this.options.data = !0, this.opcode("lookupData", e.depth, e.parts, e.strict)) : this.opcode("lookupOnContext", e.parts, e.falsy, e.strict, n) : this.opcode("pushContext")
            },
            StringLiteral: function(e) {
                this.opcode("pushString", e.value)
            },
            NumberLiteral: function(e) {
                this.opcode("pushLiteral", e.value)
            },
            BooleanLiteral: function(e) {
                this.opcode("pushLiteral", e.value)
            },
            UndefinedLiteral: function() {
                this.opcode("pushLiteral", "undefined")
            },
            NullLiteral: function() {
                this.opcode("pushLiteral", "null")
            },
            Hash: function(e) {
                var t = e.pairs,
                    n = 0,
                    i = t.length;
                for (this.opcode("pushHash"); n < i; n++) this.pushParam(t[n].value);
                for (; n--;) this.opcode("assignToHash", t[n].key);
                this.opcode("popHash")
            },
            opcode: function(e) {
                this.opcodes.push({
                    opcode: e,
                    args: d.call(arguments, 1),
                    loc: this.sourceNode[0].loc
                })
            },
            addDepth: function(e) {
                e && (this.useDepths = !0)
            },
            classifySexpr: function(e) {
                var t = c.default.helpers.simpleId(e.path),
                    n = t && !!this.blockParamIndex(e.path.parts[0]),
                    i = !n && c.default.helpers.helperExpression(e),
                    s = !n && (i || t);
                if (s && !i) {
                    var r = e.path.parts[0],
                        o = this.options;
                    o.knownHelpers[r] ? i = !0 : o.knownHelpersOnly && (s = !1)
                }
                return i ? "helper" : s ? "ambiguous" : "simple"
            },
            pushParams: function(e) {
                for (var t = 0, n = e.length; t < n; t++) this.pushParam(e[t])
            },
            pushParam: function(e) {
                var t = null != e.value ? e.value : e.original || "";
                if (this.stringParams) t.replace && (t = t.replace(/^(\.?\.\/)*/g, "").replace(/\//g, ".")), e.depth && this.addDepth(e.depth), this.opcode("getContext", e.depth || 0), this.opcode("pushStringParam", t, e.type), "SubExpression" === e.type && this.accept(e);
                else {
                    if (this.trackIds) {
                        var n = void 0;
                        if (!e.parts || c.default.helpers.scopedId(e) || e.depth || (n = this.blockParamIndex(e.parts[0])), n) {
                            var i = e.parts.slice(1).join(".");
                            this.opcode("pushId", "BlockParam", n, i)
                        } else(t = e.original || t).replace && (t = t.replace(/^this(?:\.|$)/, "").replace(/^\.\//, "").replace(/^\.$/, "")), this.opcode("pushId", e.type, t)
                    }
                    this.accept(e)
                }
            },
            setupFullMustacheParams: function(e, t, n, i) {
                var s = e.params;
                return this.pushParams(s), this.opcode("pushProgram", t), this.opcode("pushProgram", n), e.hash ? this.accept(e.hash) : this.opcode("emptyHash", i), s
            },
            blockParamIndex: function(e) {
                for (var t = 0, n = this.options.blockParams.length; t < n; t++) {
                    var i = this.options.blockParams[t],
                        s = i && l.indexOf(i, e);
                    if (i && s >= 0) return [t, s]
                }
            }
        }
    }, function(e, t, n) {
        "use strict";

        function i(e) {
            this.value = e
        }

        function s() {}
        var r = n(1).default;
        t.__esModule = !0;
        var o = n(4),
            a = r(n(6)),
            l = n(5),
            c = r(n(43));
        s.prototype = {
                nameLookup: function(e, t) {
                    return s.isValidJavaScriptVariableName(t) ? [e, ".", t] : [e, "[", JSON.stringify(t), "]"]
                },
                depthedLookup: function(e) {
                    return [this.aliasable("container.lookup"), '(depths, "', e, '")']
                },
                compilerInfo: function() {
                    var e = o.COMPILER_REVISION;
                    return [e, o.REVISION_CHANGES[e]]
                },
                appendToBuffer: function(e, t, n) {
                    return l.isArray(e) || (e = [e]), e = this.source.wrap(e, t), this.environment.isSimple ? ["return ", e, ";"] : n ? ["buffer += ", e, ";"] : (e.appendToBuffer = !0, e)
                },
                initializeBuffer: function() {
                    return this.quotedString("")
                },
                compile: function(e, t, n, i) {
                    this.environment = e, this.options = t, this.stringParams = this.options.stringParams, this.trackIds = this.options.trackIds, this.precompile = !i, this.name = this.environment.name, this.isChild = !!n, this.context = n || {
                        decorators: [],
                        programs: [],
                        environments: []
                    }, this.preamble(), this.stackSlot = 0, this.stackVars = [], this.aliases = {}, this.registers = {
                        list: []
                    }, this.hashes = [], this.compileStack = [], this.inlineStack = [], this.blockParams = [], this.compileChildren(e, t), this.useDepths = this.useDepths || e.useDepths || e.useDecorators || this.options.compat, this.useBlockParams = this.useBlockParams || e.useBlockParams;
                    var s = e.opcodes,
                        r = void 0,
                        o = void 0,
                        l = void 0,
                        c = void 0;
                    for (l = 0, c = s.length; l < c; l++) r = s[l], this.source.currentLocation = r.loc, o = o || r.loc, this[r.opcode].apply(this, r.args);
                    if (this.source.currentLocation = o, this.pushSource(""), this.stackSlot || this.inlineStack.length || this.compileStack.length) throw new a.default("Compile completed with content left on stack");
                    this.decorators.isEmpty() ? this.decorators = void 0 : (this.useDecorators = !0, this.decorators.prepend("var decorators = container.decorators;\n"), this.decorators.push("return fn;"), i ? this.decorators = Function.apply(this, ["fn", "props", "container", "depth0", "data", "blockParams", "depths", this.decorators.merge()]) : (this.decorators.prepend("function(fn, props, container, depth0, data, blockParams, depths) {\n"), this.decorators.push("}\n"), this.decorators = this.decorators.merge()));
                    var d = this.createFunctionContext(i);
                    if (this.isChild) return d;
                    var u = {
                        compiler: this.compilerInfo(),
                        main: d
                    };
                    this.decorators && (u.main_d = this.decorators, u.useDecorators = !0);
                    var h = this.context,
                        p = h.programs,
                        f = h.decorators;
                    for (l = 0, c = p.length; l < c; l++) p[l] && (u[l] = p[l], f[l] && (u[l + "_d"] = f[l], u.useDecorators = !0));
                    return this.environment.usePartial && (u.usePartial = !0), this.options.data && (u.useData = !0), this.useDepths && (u.useDepths = !0), this.useBlockParams && (u.useBlockParams = !0), this.options.compat && (u.compat = !0), i ? u.compilerOptions = this.options : (u.compiler = JSON.stringify(u.compiler), this.source.currentLocation = {
                        start: {
                            line: 1,
                            column: 0
                        }
                    }, u = this.objectLiteral(u), t.srcName ? (u = u.toStringWithSourceMap({
                        file: t.destName
                    })).map = u.map && u.map.toString() : u = u.toString()), u
                },
                preamble: function() {
                    this.lastContext = 0, this.source = new c.default(this.options.srcName), this.decorators = new c.default(this.options.srcName)
                },
                createFunctionContext: function(e) {
                    var t = "",
                        n = this.stackVars.concat(this.registers.list);
                    n.length > 0 && (t += ", " + n.join(", "));
                    var i = 0;
                    for (var s in this.aliases) {
                        var r = this.aliases[s];
                        this.aliases.hasOwnProperty(s) && r.children && r.referenceCount > 1 && (t += ", alias" + ++i + "=" + s, r.children[0] = "alias" + i)
                    }
                    var o = ["container", "depth0", "helpers", "partials", "data"];
                    (this.useBlockParams || this.useDepths) && o.push("blockParams"), this.useDepths && o.push("depths");
                    var a = this.mergeSource(t);
                    return e ? (o.push(a), Function.apply(this, o)) : this.source.wrap(["function(", o.join(","), ") {\n  ", a, "}"])
                },
                mergeSource: function(e) {
                    var t = this.environment.isSimple,
                        n = !this.forceBuffer,
                        i = void 0,
                        s = void 0,
                        r = void 0,
                        o = void 0;
                    return this.source.each(function(e) {
                        e.appendToBuffer ? (r ? e.prepend("  + ") : r = e, o = e) : (r && (s ? r.prepend("buffer += ") : i = !0, o.add(";"), r = o = void 0), s = !0, t || (n = !1))
                    }), n ? r ? (r.prepend("return "), o.add(";")) : s || this.source.push('return "";') : (e += ", buffer = " + (i ? "" : this.initializeBuffer()), r ? (r.prepend("return buffer + "), o.add(";")) : this.source.push("return buffer;")), e && this.source.prepend("var " + e.substring(2) + (i ? "" : ";\n")), this.source.merge()
                },
                blockValue: function(e) {
                    var t = this.aliasable("helpers.blockHelperMissing"),
                        n = [this.contextName(0)];
                    this.setupHelperArgs(e, 0, n);
                    var i = this.popStack();
                    n.splice(1, 0, i), this.push(this.source.functionCall(t, "call", n))
                },
                ambiguousBlockValue: function() {
                    var e = this.aliasable("helpers.blockHelperMissing"),
                        t = [this.contextName(0)];
                    this.setupHelperArgs("", 0, t, !0), this.flushInline();
                    var n = this.topStack();
                    t.splice(1, 0, n), this.pushSource(["if (!", this.lastHelper, ") { ", n, " = ", this.source.functionCall(e, "call", t), "}"])
                },
                appendContent: function(e) {
                    this.pendingContent ? e = this.pendingContent + e : this.pendingLocation = this.source.currentLocation, this.pendingContent = e
                },
                append: function() {
                    if (this.isInline()) this.replaceStack(function(e) {
                        return [" != null ? ", e, ' : ""']
                    }), this.pushSource(this.appendToBuffer(this.popStack()));
                    else {
                        var e = this.popStack();
                        this.pushSource(["if (", e, " != null) { ", this.appendToBuffer(e, void 0, !0), " }"]), this.environment.isSimple && this.pushSource(["else { ", this.appendToBuffer("''", void 0, !0), " }"])
                    }
                },
                appendEscaped: function() {
                    this.pushSource(this.appendToBuffer([this.aliasable("container.escapeExpression"), "(", this.popStack(), ")"]))
                },
                getContext: function(e) {
                    this.lastContext = e
                },
                pushContext: function() {
                    this.pushStackLiteral(this.contextName(this.lastContext))
                },
                lookupOnContext: function(e, t, n, i) {
                    var s = 0;
                    i || !this.options.compat || this.lastContext ? this.pushContext() : this.push(this.depthedLookup(e[s++])), this.resolvePath("context", e, s, t, n)
                },
                lookupBlockParam: function(e, t) {
                    this.useBlockParams = !0, this.push(["blockParams[", e[0], "][", e[1], "]"]), this.resolvePath("context", t, 1)
                },
                lookupData: function(e, t, n) {
                    e ? this.pushStackLiteral("container.data(data, " + e + ")") : this.pushStackLiteral("data"), this.resolvePath("data", t, 0, !0, n)
                },
                resolvePath: function(e, t, n, i, s) {
                    var r = this;
                    if (this.options.strict || this.options.assumeObjects) this.push(function(e, t, n, i) {
                        var s = t.popStack(),
                            r = 0,
                            o = n.length;
                        for (e && o--; r < o; r++) s = t.nameLookup(s, n[r], i);
                        return e ? [t.aliasable("container.strict"), "(", s, ", ", t.quotedString(n[r]), ")"] : s
                    }(this.options.strict && s, this, t, e));
                    else
                        for (var o = t.length; n < o; n++) this.replaceStack(function(s) {
                            var o = r.nameLookup(s, t[n], e);
                            return i ? [" && ", o] : [" != null ? ", o, " : ", s]
                        })
                },
                resolvePossibleLambda: function() {
                    this.push([this.aliasable("container.lambda"), "(", this.popStack(), ", ", this.contextName(0), ")"])
                },
                pushStringParam: function(e, t) {
                    this.pushContext(), this.pushString(t), "SubExpression" !== t && ("string" == typeof e ? this.pushString(e) : this.pushStackLiteral(e))
                },
                emptyHash: function(e) {
                    this.trackIds && this.push("{}"), this.stringParams && (this.push("{}"), this.push("{}")), this.pushStackLiteral(e ? "undefined" : "{}")
                },
                pushHash: function() {
                    this.hash && this.hashes.push(this.hash), this.hash = {
                        values: [],
                        types: [],
                        contexts: [],
                        ids: []
                    }
                },
                popHash: function() {
                    var e = this.hash;
                    this.hash = this.hashes.pop(), this.trackIds && this.push(this.objectLiteral(e.ids)), this.stringParams && (this.push(this.objectLiteral(e.contexts)), this.push(this.objectLiteral(e.types))), this.push(this.objectLiteral(e.values))
                },
                pushString: function(e) {
                    this.pushStackLiteral(this.quotedString(e))
                },
                pushLiteral: function(e) {
                    this.pushStackLiteral(e)
                },
                pushProgram: function(e) {
                    null != e ? this.pushStackLiteral(this.programExpression(e)) : this.pushStackLiteral(null)
                },
                registerDecorator: function(e, t) {
                    var n = this.nameLookup("decorators", t, "decorator"),
                        i = this.setupHelperArgs(t, e);
                    this.decorators.push(["fn = ", this.decorators.functionCall(n, "", ["fn", "props", "container", i]), " || fn;"])
                },
                invokeHelper: function(e, t, n) {
                    var i = this.popStack(),
                        s = this.setupHelper(e, t),
                        r = n ? [s.name, " || "] : "",
                        o = ["("].concat(r, i);
                    this.options.strict || o.push(" || ", this.aliasable("helpers.helperMissing")), o.push(")"), this.push(this.source.functionCall(o, "call", s.callParams))
                },
                invokeKnownHelper: function(e, t) {
                    var n = this.setupHelper(e, t);
                    this.push(this.source.functionCall(n.name, "call", n.callParams))
                },
                invokeAmbiguous: function(e, t) {
                    this.useRegister("helper");
                    var n = this.popStack();
                    this.emptyHash();
                    var i = this.setupHelper(0, e, t),
                        s = ["(", "(helper = ", this.lastHelper = this.nameLookup("helpers", e, "helper"), " || ", n, ")"];
                    this.options.strict || (s[0] = "(helper = ", s.push(" != null ? helper : ", this.aliasable("helpers.helperMissing"))), this.push(["(", s, i.paramsInit ? ["),(", i.paramsInit] : [], "),", "(typeof helper === ", this.aliasable('"function"'), " ? ", this.source.functionCall("helper", "call", i.callParams), " : helper))"])
                },
                invokePartial: function(e, t, n) {
                    var i = [],
                        s = this.setupParams(t, 1, i);
                    e && (t = this.popStack(), delete s.name), n && (s.indent = JSON.stringify(n)), s.helpers = "helpers", s.partials = "partials", s.decorators = "container.decorators", e ? i.unshift(t) : i.unshift(this.nameLookup("partials", t, "partial")), this.options.compat && (s.depths = "depths"), s = this.objectLiteral(s), i.push(s), this.push(this.source.functionCall("container.invokePartial", "", i))
                },
                assignToHash: function(e) {
                    var t = this.popStack(),
                        n = void 0,
                        i = void 0,
                        s = void 0;
                    this.trackIds && (s = this.popStack()), this.stringParams && (i = this.popStack(), n = this.popStack());
                    var r = this.hash;
                    n && (r.contexts[e] = n), i && (r.types[e] = i), s && (r.ids[e] = s), r.values[e] = t
                },
                pushId: function(e, t, n) {
                    "BlockParam" === e ? this.pushStackLiteral("blockParams[" + t[0] + "].path[" + t[1] + "]" + (n ? " + " + JSON.stringify("." + n) : "")) : "PathExpression" === e ? this.pushString(t) : "SubExpression" === e ? this.pushStackLiteral("true") : this.pushStackLiteral("null")
                },
                compiler: s,
                compileChildren: function(e, t) {
                    for (var n = e.children, i = void 0, s = void 0, r = 0, o = n.length; r < o; r++) {
                        i = n[r], s = new this.compiler;
                        var a = this.matchExistingProgram(i);
                        if (null == a) {
                            this.context.programs.push("");
                            var l = this.context.programs.length;
                            i.index = l, i.name = "program" + l, this.context.programs[l] = s.compile(i, t, this.context, !this.precompile), this.context.decorators[l] = s.decorators, this.context.environments[l] = i, this.useDepths = this.useDepths || s.useDepths, this.useBlockParams = this.useBlockParams || s.useBlockParams, i.useDepths = this.useDepths, i.useBlockParams = this.useBlockParams
                        } else i.index = a.index, i.name = "program" + a.index, this.useDepths = this.useDepths || a.useDepths, this.useBlockParams = this.useBlockParams || a.useBlockParams
                    }
                },
                matchExistingProgram: function(e) {
                    for (var t = 0, n = this.context.environments.length; t < n; t++) {
                        var i = this.context.environments[t];
                        if (i && i.equals(e)) return i
                    }
                },
                programExpression: function(e) {
                    var t = this.environment.children[e],
                        n = [t.index, "data", t.blockParams];
                    return (this.useBlockParams || this.useDepths) && n.push("blockParams"), this.useDepths && n.push("depths"), "container.program(" + n.join(", ") + ")"
                },
                useRegister: function(e) {
                    this.registers[e] || (this.registers[e] = !0, this.registers.list.push(e))
                },
                push: function(e) {
                    return e instanceof i || (e = this.source.wrap(e)), this.inlineStack.push(e), e
                },
                pushStackLiteral: function(e) {
                    this.push(new i(e))
                },
                pushSource: function(e) {
                    this.pendingContent && (this.source.push(this.appendToBuffer(this.source.quotedString(this.pendingContent), this.pendingLocation)), this.pendingContent = void 0), e && this.source.push(e)
                },
                replaceStack: function(e) {
                    var t = ["("],
                        n = void 0,
                        s = void 0,
                        r = void 0;
                    if (!this.isInline()) throw new a.default("replaceStack on non-inline");
                    var o = this.popStack(!0);
                    if (o instanceof i) t = ["(", n = [o.value]], r = !0;
                    else {
                        s = !0;
                        var l = this.incrStack();
                        t = ["((", this.push(l), " = ", o, ")"], n = this.topStack()
                    }
                    var c = e.call(this, n);
                    r || this.popStack(), s && this.stackSlot--, this.push(t.concat(c, ")"))
                },
                incrStack: function() {
                    return this.stackSlot++, this.stackSlot > this.stackVars.length && this.stackVars.push("stack" + this.stackSlot), this.topStackName()
                },
                topStackName: function() {
                    return "stack" + this.stackSlot
                },
                flushInline: function() {
                    var e = this.inlineStack;
                    this.inlineStack = [];
                    for (var t = 0, n = e.length; t < n; t++) {
                        var s = e[t];
                        if (s instanceof i) this.compileStack.push(s);
                        else {
                            var r = this.incrStack();
                            this.pushSource([r, " = ", s, ";"]), this.compileStack.push(r)
                        }
                    }
                },
                isInline: function() {
                    return this.inlineStack.length
                },
                popStack: function(e) {
                    var t = this.isInline(),
                        n = (t ? this.inlineStack : this.compileStack).pop();
                    if (!e && n instanceof i) return n.value;
                    if (!t) {
                        if (!this.stackSlot) throw new a.default("Invalid stack pop");
                        this.stackSlot--
                    }
                    return n
                },
                topStack: function() {
                    var e = this.isInline() ? this.inlineStack : this.compileStack,
                        t = e[e.length - 1];
                    return t instanceof i ? t.value : t
                },
                contextName: function(e) {
                    return this.useDepths && e ? "depths[" + e + "]" : "depth" + e
                },
                quotedString: function(e) {
                    return this.source.quotedString(e)
                },
                objectLiteral: function(e) {
                    return this.source.objectLiteral(e)
                },
                aliasable: function(e) {
                    var t = this.aliases[e];
                    return t ? (t.referenceCount++, t) : (t = this.aliases[e] = this.source.wrap(e), t.aliasable = !0, t.referenceCount = 1, t)
                },
                setupHelper: function(e, t, n) {
                    var i = [];
                    return {
                        params: i,
                        paramsInit: this.setupHelperArgs(t, e, i, n),
                        name: this.nameLookup("helpers", t, "helper"),
                        callParams: [this.aliasable(this.contextName(0) + " != null ? " + this.contextName(0) + " : (container.nullContext || {})")].concat(i)
                    }
                },
                setupParams: function(e, t, n) {
                    var i = {},
                        s = [],
                        r = [],
                        o = [],
                        a = !n,
                        l = void 0;
                    a && (n = []), i.name = this.quotedString(e), i.hash = this.popStack(), this.trackIds && (i.hashIds = this.popStack()), this.stringParams && (i.hashTypes = this.popStack(), i.hashContexts = this.popStack());
                    var c = this.popStack(),
                        d = this.popStack();
                    (d || c) && (i.fn = d || "container.noop", i.inverse = c || "container.noop");
                    for (var u = t; u--;) l = this.popStack(), n[u] = l, this.trackIds && (o[u] = this.popStack()), this.stringParams && (r[u] = this.popStack(), s[u] = this.popStack());
                    return a && (i.args = this.source.generateArray(n)), this.trackIds && (i.ids = this.source.generateArray(o)), this.stringParams && (i.types = this.source.generateArray(r), i.contexts = this.source.generateArray(s)), this.options.data && (i.data = "data"), this.useBlockParams && (i.blockParams = "blockParams"), i
                },
                setupHelperArgs: function(e, t, n, i) {
                    var s = this.setupParams(e, t, n);
                    return s = this.objectLiteral(s), i ? (this.useRegister("options"), n.push("options"), ["options=", s]) : n ? (n.push(s), "") : s
                }
            },
            function() {
                for (var e = "break else new var case finally return void catch for switch while continue function this with default if throw delete in try do instanceof typeof abstract enum int short boolean export interface static byte extends long super char final native synchronized class float package throws const goto private transient debugger implements protected volatile double import public let yield await null true false".split(" "), t = s.RESERVED_WORDS = {}, n = 0, i = e.length; n < i; n++) t[e[n]] = !0
            }(), s.isValidJavaScriptVariableName = function(e) {
                return !s.RESERVED_WORDS[e] && /^[a-zA-Z_$][0-9a-zA-Z_$]*$/.test(e)
            }, t.default = s, e.exports = t.default
    }, function(e, t, n) {
        "use strict";

        function i(e, t, n) {
            if (r.isArray(e)) {
                for (var i = [], s = 0, o = e.length; s < o; s++) i.push(t.wrap(e[s], n));
                return i
            }
            return "boolean" == typeof e || "number" == typeof e ? e + "" : e
        }

        function s(e) {
            this.srcFile = e, this.source = []
        }
        t.__esModule = !0;
        var r = n(5),
            o = void 0;
        try {} catch (e) {}
        o || ((o = function(e, t, n, i) {
            this.src = "", i && this.add(i)
        }).prototype = {
            add: function(e) {
                r.isArray(e) && (e = e.join("")), this.src += e
            },
            prepend: function(e) {
                r.isArray(e) && (e = e.join("")), this.src = e + this.src
            },
            toStringWithSourceMap: function() {
                return {
                    code: this.toString()
                }
            },
            toString: function() {
                return this.src
            }
        }), s.prototype = {
            isEmpty: function() {
                return !this.source.length
            },
            prepend: function(e, t) {
                this.source.unshift(this.wrap(e, t))
            },
            push: function(e, t) {
                this.source.push(this.wrap(e, t))
            },
            merge: function() {
                var e = this.empty();
                return this.each(function(t) {
                    e.add(["  ", t, "\n"])
                }), e
            },
            each: function(e) {
                for (var t = 0, n = this.source.length; t < n; t++) e(this.source[t])
            },
            empty: function() {
                var e = this.currentLocation || {
                    start: {}
                };
                return new o(e.start.line, e.start.column, this.srcFile)
            },
            wrap: function(e) {
                var t = arguments.length <= 1 || void 0 === arguments[1] ? this.currentLocation || {
                    start: {}
                } : arguments[1];
                return e instanceof o ? e : (e = i(e, this, t), new o(t.start.line, t.start.column, this.srcFile, e))
            },
            functionCall: function(e, t, n) {
                return n = this.generateList(n), this.wrap([e, t ? "." + t + "(" : "(", n, ")"])
            },
            quotedString: function(e) {
                return '"' + (e + "").replace(/\\/g, "\\\\").replace(/"/g, '\\"').replace(/\n/g, "\\n").replace(/\r/g, "\\r").replace(/\u2028/g, "\\u2028").replace(/\u2029/g, "\\u2029") + '"'
            },
            objectLiteral: function(e) {
                var t = [];
                for (var n in e)
                    if (e.hasOwnProperty(n)) {
                        var s = i(e[n], this);
                        "undefined" !== s && t.push([this.quotedString(n), ":", s])
                    }
                var r = this.generateList(t);
                return r.prepend("{"), r.add("}"), r
            },
            generateList: function(e) {
                for (var t = this.empty(), n = 0, s = e.length; n < s; n++) n && t.add(","), t.add(i(e[n], this));
                return t
            },
            generateArray: function(e) {
                var t = this.generateList(e);
                return t.prepend("["), t.add("]"), t
            }
        }, t.default = s, e.exports = t.default
    }])
}),
function(e, t) {
    "object" == typeof exports && "undefined" != typeof module ? module.exports = t() : "function" == typeof define && define.amd ? define(t) : e.moment = t()
}(this, function() {
    "use strict";

    function e() {
        return Ke.apply(null, arguments)
    }

    function t(e) {
        return e instanceof Array || "[object Array]" === Object.prototype.toString.call(e)
    }

    function n(e) {
        return null != e && "[object Object]" === Object.prototype.toString.call(e)
    }

    function i(e) {
        return void 0 === e
    }

    function s(e) {
        return "number" == typeof e || "[object Number]" === Object.prototype.toString.call(e)
    }

    function r(e) {
        return e instanceof Date || "[object Date]" === Object.prototype.toString.call(e)
    }

    function o(e, t) {
        var n, i = [];
        for (n = 0; n < e.length; ++n) i.push(t(e[n], n));
        return i
    }

    function a(e, t) {
        return Object.prototype.hasOwnProperty.call(e, t)
    }

    function l(e, t) {
        for (var n in t) a(t, n) && (e[n] = t[n]);
        return a(t, "toString") && (e.toString = t.toString), a(t, "valueOf") && (e.valueOf = t.valueOf), e
    }

    function c(e, t, n, i) {
        return ve(e, t, n, i, !0).utc()
    }

    function d(e) {
        return null == e._pf && (e._pf = {
            empty: !1,
            unusedTokens: [],
            unusedInput: [],
            overflow: -2,
            charsLeftOver: 0,
            nullInput: !1,
            invalidMonth: null,
            invalidFormat: !1,
            userInvalidated: !1,
            iso: !1,
            parsedDateParts: [],
            meridiem: null,
            rfc2822: !1,
            weekdayMismatch: !1
        }), e._pf
    }

    function u(e) {
        if (null == e._isValid) {
            var t = d(e),
                n = Je.call(t.parsedDateParts, function(e) {
                    return null != e
                }),
                i = !isNaN(e._d.getTime()) && t.overflow < 0 && !t.empty && !t.invalidMonth && !t.invalidWeekday && !t.weekdayMismatch && !t.nullInput && !t.invalidFormat && !t.userInvalidated && (!t.meridiem || t.meridiem && n);
            if (e._strict && (i = i && 0 === t.charsLeftOver && 0 === t.unusedTokens.length && void 0 === t.bigHour), null != Object.isFrozen && Object.isFrozen(e)) return i;
            e._isValid = i
        }
        return e._isValid
    }

    function h(e) {
        var t = c(NaN);
        return null != e ? l(d(t), e) : d(t).userInvalidated = !0, t
    }

    function p(e, t) {
        var n, s, r;
        if (i(t._isAMomentObject) || (e._isAMomentObject = t._isAMomentObject), i(t._i) || (e._i = t._i), i(t._f) || (e._f = t._f), i(t._l) || (e._l = t._l), i(t._strict) || (e._strict = t._strict), i(t._tzm) || (e._tzm = t._tzm), i(t._isUTC) || (e._isUTC = t._isUTC), i(t._offset) || (e._offset = t._offset), i(t._pf) || (e._pf = d(t)), i(t._locale) || (e._locale = t._locale), Ze.length > 0)
            for (n = 0; n < Ze.length; n++) i(r = t[s = Ze[n]]) || (e[s] = r);
        return e
    }

    function f(t) {
        p(this, t), this._d = new Date(null != t._d ? t._d.getTime() : NaN), this.isValid() || (this._d = new Date(NaN)), !1 === et && (et = !0, e.updateOffset(this), et = !1)
    }

    function m(e) {
        return e instanceof f || null != e && null != e._isAMomentObject
    }

    function g(e) {
        return e < 0 ? Math.ceil(e) || 0 : Math.floor(e)
    }

    function v(e) {
        var t = +e,
            n = 0;
        return 0 !== t && isFinite(t) && (n = g(t)), n
    }

    function _(e, t, n) {
        var i, s = Math.min(e.length, t.length),
            r = Math.abs(e.length - t.length),
            o = 0;
        for (i = 0; i < s; i++)(n && e[i] !== t[i] || !n && v(e[i]) !== v(t[i])) && o++;
        return o + r
    }

    function y(t) {
        !1 === e.suppressDeprecationWarnings && "undefined" != typeof console && console.warn && console.warn("Deprecation warning: " + t)
    }

    function b(t, n) {
        var i = !0;
        return l(function() {
            if (null != e.deprecationHandler && e.deprecationHandler(null, t), i) {
                for (var s, r = [], o = 0; o < arguments.length; o++) {
                    if (s = "", "object" == typeof arguments[o]) {
                        s += "\n[" + o + "] ";
                        for (var a in arguments[0]) s += a + ": " + arguments[0][a] + ", ";
                        s = s.slice(0, -2)
                    } else s = arguments[o];
                    r.push(s)
                }
                y(t + "\nArguments: " + Array.prototype.slice.call(r).join("") + "\n" + (new Error).stack), i = !1
            }
            return n.apply(this, arguments)
        }, n)
    }

    function w(t, n) {
        null != e.deprecationHandler && e.deprecationHandler(t, n), tt[t] || (y(n), tt[t] = !0)
    }

    function x(e) {
        return e instanceof Function || "[object Function]" === Object.prototype.toString.call(e)
    }

    function k(e, t) {
        var i, s = l({}, e);
        for (i in t) a(t, i) && (n(e[i]) && n(t[i]) ? (s[i] = {}, l(s[i], e[i]), l(s[i], t[i])) : null != t[i] ? s[i] = t[i] : delete s[i]);
        for (i in e) a(e, i) && !a(t, i) && n(e[i]) && (s[i] = l({}, s[i]));
        return s
    }

    function C(e) {
        null != e && this.set(e)
    }

    function $(e, t) {
        var n = e.toLowerCase();
        it[n] = it[n + "s"] = it[t] = e
    }

    function S(e) {
        return "string" == typeof e ? it[e] || it[e.toLowerCase()] : void 0
    }

    function T(e) {
        var t, n, i = {};
        for (n in e) a(e, n) && (t = S(n)) && (i[t] = e[n]);
        return i
    }

    function D(e, t) {
        st[e] = t
    }

    function E(e, t, n) {
        var i = "" + Math.abs(e),
            s = t - i.length;
        return (e >= 0 ? n ? "+" : "" : "-") + Math.pow(10, Math.max(0, s)).toString().substr(1) + i
    }

    function P(e, t, n, i) {
        var s = i;
        "string" == typeof i && (s = function() {
            return this[i]()
        }), e && (lt[e] = s), t && (lt[t[0]] = function() {
            return E(s.apply(this, arguments), t[1], t[2])
        }), n && (lt[n] = function() {
            return this.localeData().ordinal(s.apply(this, arguments), e)
        })
    }

    function O(e) {
        return e.match(/\[[\s\S]/) ? e.replace(/^\[|\]$/g, "") : e.replace(/\\/g, "")
    }

    function M(e, t) {
        return e.isValid() ? (t = N(t, e.localeData()), at[t] = at[t] || function(e) {
            var t, n, i = e.match(rt);
            for (t = 0, n = i.length; t < n; t++) lt[i[t]] ? i[t] = lt[i[t]] : i[t] = O(i[t]);
            return function(t) {
                var s, r = "";
                for (s = 0; s < n; s++) r += x(i[s]) ? i[s].call(t, e) : i[s];
                return r
            }
        }(t), at[t](e)) : e.localeData().invalidDate()
    }

    function N(e, t) {
        function n(e) {
            return t.longDateFormat(e) || e
        }
        var i = 5;
        for (ot.lastIndex = 0; i >= 0 && ot.test(e);) e = e.replace(ot, n), ot.lastIndex = 0, i -= 1;
        return e
    }

    function I(e, t, n) {
        $t[e] = x(t) ? t : function(e, i) {
            return e && n ? n : t
        }
    }

    function A(e, t) {
        return a($t, e) ? $t[e](t._strict, t._locale) : new RegExp(function(e) {
            return j(e.replace("\\", "").replace(/\\(\[)|\\(\])|\[([^\]\[]*)\]|\\(.)/g, function(e, t, n, i, s) {
                return t || n || i || s
            }))
        }(e))
    }

    function j(e) {
        return e.replace(/[-\/\\^$*+?.()|[\]{}]/g, "\\$&")
    }

    function H(e, t) {
        var n, i = t;
        for ("string" == typeof e && (e = [e]), s(t) && (i = function(e, n) {
                n[t] = v(e)
            }), n = 0; n < e.length; n++) St[e[n]] = i
    }

    function L(e, t) {
        H(e, function(e, n, i, s) {
            i._w = i._w || {}, t(e, i._w, i, s)
        })
    }

    function F(e, t, n) {
        null != t && a(St, e) && St[e](t, n._a, n, e)
    }

    function R(e) {
        return B(e) ? 366 : 365
    }

    function B(e) {
        return e % 4 == 0 && e % 100 != 0 || e % 400 == 0
    }

    function q(t, n) {
        return function(i) {
            return null != i ? (W(this, t, i), e.updateOffset(this, n), this) : Y(this, t)
        }
    }

    function Y(e, t) {
        return e.isValid() ? e._d["get" + (e._isUTC ? "UTC" : "") + t]() : NaN
    }

    function W(e, t, n) {
        e.isValid() && !isNaN(n) && ("FullYear" === t && B(e.year()) && 1 === e.month() && 29 === e.date() ? e._d["set" + (e._isUTC ? "UTC" : "") + t](n, e.month(), z(n, e.month())) : e._d["set" + (e._isUTC ? "UTC" : "") + t](n))
    }

    function z(e, t) {
        if (isNaN(e) || isNaN(t)) return NaN;
        var n = function(e, t) {
            return (e % t + t) % t
        }(t, 12);
        return e += (t - n) / 12, 1 === n ? B(e) ? 29 : 28 : 31 - n % 7 % 2
    }

    function U(e, t) {
        var n;
        if (!e.isValid()) return e;
        if ("string" == typeof t)
            if (/^\d+$/.test(t)) t = v(t);
            else if (t = e.localeData().monthsParse(t), !s(t)) return e;
        return n = Math.min(e.date(), z(e.year(), t)), e._d["set" + (e._isUTC ? "UTC" : "") + "Month"](t, n), e
    }

    function V(t) {
        return null != t ? (U(this, t), e.updateOffset(this, !0), this) : Y(this, "Month")
    }

    function X() {
        function e(e, t) {
            return t.length - e.length
        }
        var t, n, i = [],
            s = [],
            r = [];
        for (t = 0; t < 12; t++) n = c([2e3, t]), i.push(this.monthsShort(n, "")), s.push(this.months(n, "")), r.push(this.months(n, "")), r.push(this.monthsShort(n, ""));
        for (i.sort(e), s.sort(e), r.sort(e), t = 0; t < 12; t++) i[t] = j(i[t]), s[t] = j(s[t]);
        for (t = 0; t < 24; t++) r[t] = j(r[t]);
        this._monthsRegex = new RegExp("^(" + r.join("|") + ")", "i"), this._monthsShortRegex = this._monthsRegex, this._monthsStrictRegex = new RegExp("^(" + s.join("|") + ")", "i"), this._monthsShortStrictRegex = new RegExp("^(" + i.join("|") + ")", "i")
    }

    function Q(e) {
        var t = new Date(Date.UTC.apply(null, arguments));
        return e < 100 && e >= 0 && isFinite(t.getUTCFullYear()) && t.setUTCFullYear(e), t
    }

    function G(e, t, n) {
        var i = 7 + t - n;
        return -((7 + Q(e, 0, i).getUTCDay() - t) % 7) + i - 1
    }

    function K(e, t, n, i, s) {
        var r, o, a = 1 + 7 * (t - 1) + (7 + n - i) % 7 + G(e, i, s);
        return a <= 0 ? o = R(r = e - 1) + a : a > R(e) ? (r = e + 1, o = a - R(e)) : (r = e, o = a), {
            year: r,
            dayOfYear: o
        }
    }

    function J(e, t, n) {
        var i, s, r = G(e.year(), t, n),
            o = Math.floor((e.dayOfYear() - r - 1) / 7) + 1;
        return o < 1 ? i = o + Z(s = e.year() - 1, t, n) : o > Z(e.year(), t, n) ? (i = o - Z(e.year(), t, n), s = e.year() + 1) : (s = e.year(), i = o), {
            week: i,
            year: s
        }
    }

    function Z(e, t, n) {
        var i = G(e, t, n),
            s = G(e + 1, t, n);
        return (R(e) - i + s) / 7
    }

    function ee() {
        function e(e, t) {
            return t.length - e.length
        }
        var t, n, i, s, r, o = [],
            a = [],
            l = [],
            d = [];
        for (t = 0; t < 7; t++) n = c([2e3, 1]).day(t), i = this.weekdaysMin(n, ""), s = this.weekdaysShort(n, ""), r = this.weekdays(n, ""), o.push(i), a.push(s), l.push(r), d.push(i), d.push(s), d.push(r);
        for (o.sort(e), a.sort(e), l.sort(e), d.sort(e), t = 0; t < 7; t++) a[t] = j(a[t]), l[t] = j(l[t]), d[t] = j(d[t]);
        this._weekdaysRegex = new RegExp("^(" + d.join("|") + ")", "i"), this._weekdaysShortRegex = this._weekdaysRegex, this._weekdaysMinRegex = this._weekdaysRegex, this._weekdaysStrictRegex = new RegExp("^(" + l.join("|") + ")", "i"), this._weekdaysShortStrictRegex = new RegExp("^(" + a.join("|") + ")", "i"), this._weekdaysMinStrictRegex = new RegExp("^(" + o.join("|") + ")", "i")
    }

    function te() {
        return this.hours() % 12 || 12
    }

    function ne(e, t) {
        P(e, 0, 0, function() {
            return this.localeData().meridiem(this.hours(), this.minutes(), t)
        })
    }

    function ie(e, t) {
        return t._meridiemParse
    }

    function se(e) {
        return e ? e.toLowerCase().replace("_", "-") : e
    }

    function re(e) {
        var t = null;
        if (!Jt[e] && "undefined" != typeof module && module && module.exports) try {
            t = Qt._abbr;
            require("./locale/" + e), oe(t)
        } catch (e) {}
        return Jt[e]
    }

    function oe(e, t) {
        var n;
        return e && ((n = i(t) ? le(e) : ae(e, t)) ? Qt = n : "undefined" != typeof console && console.warn && console.warn("Locale " + e + " not found. Did you forget to load it?")), Qt._abbr
    }

    function ae(e, t) {
        if (null !== t) {
            var n, i = Kt;
            if (t.abbr = e, null != Jt[e]) w("defineLocaleOverride", "use moment.updateLocale(localeName, config) to change an existing locale. moment.defineLocale(localeName, config) should only be used for creating a new locale See http://momentjs.com/guides/#/warnings/define-locale/ for more info."), i = Jt[e]._config;
            else if (null != t.parentLocale)
                if (null != Jt[t.parentLocale]) i = Jt[t.parentLocale]._config;
                else {
                    if (null == (n = re(t.parentLocale))) return Zt[t.parentLocale] || (Zt[t.parentLocale] = []), Zt[t.parentLocale].push({
                        name: e,
                        config: t
                    }), null;
                    i = n._config
                }
            return Jt[e] = new C(k(i, t)), Zt[e] && Zt[e].forEach(function(e) {
                ae(e.name, e.config)
            }), oe(e), Jt[e]
        }
        return delete Jt[e], null
    }

    function le(e) {
        var n;
        if (e && e._locale && e._locale._abbr && (e = e._locale._abbr), !e) return Qt;
        if (!t(e)) {
            if (n = re(e)) return n;
            e = [e]
        }
        return function(e) {
            for (var t, n, i, s, r = 0; r < e.length;) {
                for (t = (s = se(e[r]).split("-")).length, n = (n = se(e[r + 1])) ? n.split("-") : null; t > 0;) {
                    if (i = re(s.slice(0, t).join("-"))) return i;
                    if (n && n.length >= t && _(s, n, !0) >= t - 1) break;
                    t--
                }
                r++
            }
            return Qt
        }(e)
    }

    function ce(e) {
        var t, n = e._a;
        return n && -2 === d(e).overflow && (t = n[Dt] < 0 || n[Dt] > 11 ? Dt : n[Et] < 1 || n[Et] > z(n[Tt], n[Dt]) ? Et : n[Pt] < 0 || n[Pt] > 24 || 24 === n[Pt] && (0 !== n[Ot] || 0 !== n[Mt] || 0 !== n[Nt]) ? Pt : n[Ot] < 0 || n[Ot] > 59 ? Ot : n[Mt] < 0 || n[Mt] > 59 ? Mt : n[Nt] < 0 || n[Nt] > 999 ? Nt : -1, d(e)._overflowDayOfYear && (t < Tt || t > Et) && (t = Et), d(e)._overflowWeeks && -1 === t && (t = It), d(e)._overflowWeekday && -1 === t && (t = At), d(e).overflow = t), e
    }

    function de(e, t, n) {
        return null != e ? e : null != t ? t : n
    }

    function ue(t) {
        var n, i, s, r, o, a = [];
        if (!t._d) {
            for (s = function(t) {
                    var n = new Date(e.now());
                    return t._useUTC ? [n.getUTCFullYear(), n.getUTCMonth(), n.getUTCDate()] : [n.getFullYear(), n.getMonth(), n.getDate()]
                }(t), t._w && null == t._a[Et] && null == t._a[Dt] && function(e) {
                    var t, n, i, s, r, o, a, l;
                    if (null != (t = e._w).GG || null != t.W || null != t.E) r = 1, o = 4, n = de(t.GG, e._a[Tt], J(_e(), 1, 4).year), i = de(t.W, 1), ((s = de(t.E, 1)) < 1 || s > 7) && (l = !0);
                    else {
                        r = e._locale._week.dow, o = e._locale._week.doy;
                        var c = J(_e(), r, o);
                        n = de(t.gg, e._a[Tt], c.year), i = de(t.w, c.week), null != t.d ? ((s = t.d) < 0 || s > 6) && (l = !0) : null != t.e ? (s = t.e + r, (t.e < 0 || t.e > 6) && (l = !0)) : s = r
                    }
                    i < 1 || i > Z(n, r, o) ? d(e)._overflowWeeks = !0 : null != l ? d(e)._overflowWeekday = !0 : (a = K(n, i, s, r, o), e._a[Tt] = a.year, e._dayOfYear = a.dayOfYear)
                }(t), null != t._dayOfYear && (o = de(t._a[Tt], s[Tt]), (t._dayOfYear > R(o) || 0 === t._dayOfYear) && (d(t)._overflowDayOfYear = !0), i = Q(o, 0, t._dayOfYear), t._a[Dt] = i.getUTCMonth(), t._a[Et] = i.getUTCDate()), n = 0; n < 3 && null == t._a[n]; ++n) t._a[n] = a[n] = s[n];
            for (; n < 7; n++) t._a[n] = a[n] = null == t._a[n] ? 2 === n ? 1 : 0 : t._a[n];
            24 === t._a[Pt] && 0 === t._a[Ot] && 0 === t._a[Mt] && 0 === t._a[Nt] && (t._nextDay = !0, t._a[Pt] = 0), t._d = (t._useUTC ? Q : function(e, t, n, i, s, r, o) {
                var a = new Date(e, t, n, i, s, r, o);
                return e < 100 && e >= 0 && isFinite(a.getFullYear()) && a.setFullYear(e), a
            }).apply(null, a), r = t._useUTC ? t._d.getUTCDay() : t._d.getDay(), null != t._tzm && t._d.setUTCMinutes(t._d.getUTCMinutes() - t._tzm), t._nextDay && (t._a[Pt] = 24), t._w && void 0 !== t._w.d && t._w.d !== r && (d(t).weekdayMismatch = !0)
        }
    }

    function he(e) {
        var t, n, i, s, r, o, a = e._i,
            l = en.exec(a) || tn.exec(a);
        if (l) {
            for (d(e).iso = !0, t = 0, n = sn.length; t < n; t++)
                if (sn[t][1].exec(l[1])) {
                    s = sn[t][0], i = !1 !== sn[t][2];
                    break
                }
            if (null == s) return void(e._isValid = !1);
            if (l[3]) {
                for (t = 0, n = rn.length; t < n; t++)
                    if (rn[t][1].exec(l[3])) {
                        r = (l[2] || " ") + rn[t][0];
                        break
                    }
                if (null == r) return void(e._isValid = !1)
            }
            if (!i && null != r) return void(e._isValid = !1);
            if (l[4]) {
                if (!nn.exec(l[4])) return void(e._isValid = !1);
                o = "Z"
            }
            e._f = s + (r || "") + (o || ""), me(e)
        } else e._isValid = !1
    }

    function pe(e, t, n, i, s, r) {
        var o = [function(e) {
            var t = parseInt(e, 10); {
                if (t <= 49) return 2e3 + t;
                if (t <= 999) return 1900 + t
            }
            return t
        }(e), Rt.indexOf(t), parseInt(n, 10), parseInt(i, 10), parseInt(s, 10)];
        return r && o.push(parseInt(r, 10)), o
    }

    function fe(e) {
        var t = an.exec(function(e) {
            return e.replace(/\([^)]*\)|[\n\t]/g, " ").replace(/(\s\s+)/g, " ").replace(/^\s\s*/, "").replace(/\s\s*$/, "")
        }(e._i));
        if (t) {
            var n = pe(t[4], t[3], t[2], t[5], t[6], t[7]);
            if (! function(e, t, n) {
                    if (e && Wt.indexOf(e) !== new Date(t[0], t[1], t[2]).getDay()) return d(n).weekdayMismatch = !0, n._isValid = !1, !1;
                    return !0
                }(t[1], n, e)) return;
            e._a = n, e._tzm = function(e, t, n) {
                if (e) return ln[e];
                if (t) return 0;
                var i = parseInt(n, 10),
                    s = i % 100;
                return (i - s) / 100 * 60 + s
            }(t[8], t[9], t[10]), e._d = Q.apply(null, e._a), e._d.setUTCMinutes(e._d.getUTCMinutes() - e._tzm), d(e).rfc2822 = !0
        } else e._isValid = !1
    }

    function me(t) {
        if (t._f !== e.ISO_8601)
            if (t._f !== e.RFC_2822) {
                t._a = [], d(t).empty = !0;
                var n, i, s, r, o, a = "" + t._i,
                    l = a.length,
                    c = 0;
                for (s = N(t._f, t._locale).match(rt) || [], n = 0; n < s.length; n++) r = s[n], (i = (a.match(A(r, t)) || [])[0]) && ((o = a.substr(0, a.indexOf(i))).length > 0 && d(t).unusedInput.push(o), a = a.slice(a.indexOf(i) + i.length), c += i.length), lt[r] ? (i ? d(t).empty = !1 : d(t).unusedTokens.push(r), F(r, i, t)) : t._strict && !i && d(t).unusedTokens.push(r);
                d(t).charsLeftOver = l - c, a.length > 0 && d(t).unusedInput.push(a), t._a[Pt] <= 12 && !0 === d(t).bigHour && t._a[Pt] > 0 && (d(t).bigHour = void 0), d(t).parsedDateParts = t._a.slice(0), d(t).meridiem = t._meridiem, t._a[Pt] = function(e, t, n) {
                    var i;
                    if (null == n) return t;
                    return null != e.meridiemHour ? e.meridiemHour(t, n) : null != e.isPM ? ((i = e.isPM(n)) && t < 12 && (t += 12), i || 12 !== t || (t = 0), t) : t
                }(t._locale, t._a[Pt], t._meridiem), ue(t), ce(t)
            } else fe(t);
        else he(t)
    }

    function ge(a) {
        var c = a._i,
            g = a._f;
        return a._locale = a._locale || le(a._l), null === c || void 0 === g && "" === c ? h({
            nullInput: !0
        }) : ("string" == typeof c && (a._i = c = a._locale.preparse(c)), m(c) ? new f(ce(c)) : (r(c) ? a._d = c : t(g) ? function(e) {
            var t, n, i, s, r;
            if (0 === e._f.length) return d(e).invalidFormat = !0, void(e._d = new Date(NaN));
            for (s = 0; s < e._f.length; s++) r = 0, t = p({}, e), null != e._useUTC && (t._useUTC = e._useUTC), t._f = e._f[s], me(t), u(t) && (r += d(t).charsLeftOver, r += 10 * d(t).unusedTokens.length, d(t).score = r, (null == i || r < i) && (i = r, n = t));
            l(e, n || t)
        }(a) : g ? me(a) : function(a) {
            var l = a._i;
            i(l) ? a._d = new Date(e.now()) : r(l) ? a._d = new Date(l.valueOf()) : "string" == typeof l ? function(t) {
                var n = on.exec(t._i);
                null === n ? (he(t), !1 === t._isValid && (delete t._isValid, fe(t), !1 === t._isValid && (delete t._isValid, e.createFromInputFallback(t)))) : t._d = new Date(+n[1])
            }(a) : t(l) ? (a._a = o(l.slice(0), function(e) {
                return parseInt(e, 10)
            }), ue(a)) : n(l) ? function(e) {
                if (!e._d) {
                    var t = T(e._i);
                    e._a = o([t.year, t.month, t.day || t.date, t.hour, t.minute, t.second, t.millisecond], function(e) {
                        return e && parseInt(e, 10)
                    }), ue(e)
                }
            }(a) : s(l) ? a._d = new Date(l) : e.createFromInputFallback(a)
        }(a), u(a) || (a._d = null), a))
    }

    function ve(e, i, s, r, o) {
        var a = {};
        return !0 !== s && !1 !== s || (r = s, s = void 0), (n(e) && function(e) {
                if (Object.getOwnPropertyNames) return 0 === Object.getOwnPropertyNames(e).length;
                var t;
                for (t in e)
                    if (e.hasOwnProperty(t)) return !1;
                return !0
            }(e) || t(e) && 0 === e.length) && (e = void 0), a._isAMomentObject = !0, a._useUTC = a._isUTC = o, a._l = s, a._i = e, a._f = i, a._strict = r,
            function(e) {
                var t = new f(ce(ge(e)));
                return t._nextDay && (t.add(1, "d"), t._nextDay = void 0), t
            }(a)
    }

    function _e(e, t, n, i) {
        return ve(e, t, n, i, !1)
    }

    function ye(e, n) {
        var i, s;
        if (1 === n.length && t(n[0]) && (n = n[0]), !n.length) return _e();
        for (i = n[0], s = 1; s < n.length; ++s) n[s].isValid() && !n[s][e](i) || (i = n[s]);
        return i
    }

    function be(e) {
        var t = T(e),
            n = t.year || 0,
            i = t.quarter || 0,
            s = t.month || 0,
            r = t.week || t.isoWeek || 0,
            o = t.day || 0,
            a = t.hour || 0,
            l = t.minute || 0,
            c = t.second || 0,
            d = t.millisecond || 0;
        this._isValid = function(e) {
            for (var t in e)
                if (-1 === jt.call(un, t) || null != e[t] && isNaN(e[t])) return !1;
            for (var n = !1, i = 0; i < un.length; ++i)
                if (e[un[i]]) {
                    if (n) return !1;
                    parseFloat(e[un[i]]) !== v(e[un[i]]) && (n = !0)
                }
            return !0
        }(t), this._milliseconds = +d + 1e3 * c + 6e4 * l + 1e3 * a * 60 * 60, this._days = +o + 7 * r, this._months = +s + 3 * i + 12 * n, this._data = {}, this._locale = le(), this._bubble()
    }

    function we(e) {
        return e instanceof be
    }

    function xe(e) {
        return e < 0 ? -1 * Math.round(-1 * e) : Math.round(e)
    }

    function ke(e, t) {
        P(e, 0, 0, function() {
            var e = this.utcOffset(),
                n = "+";
            return e < 0 && (e = -e, n = "-"), n + E(~~(e / 60), 2) + t + E(~~e % 60, 2)
        })
    }

    function Ce(e, t) {
        var n = (t || "").match(e);
        if (null === n) return null;
        var i = ((n[n.length - 1] || []) + "").match(hn) || ["-", 0, 0],
            s = 60 * i[1] + v(i[2]);
        return 0 === s ? 0 : "+" === i[0] ? s : -s
    }

    function $e(t, n) {
        var i, s;
        return n._isUTC ? (i = n.clone(), s = (m(t) || r(t) ? t.valueOf() : _e(t).valueOf()) - i.valueOf(), i._d.setTime(i._d.valueOf() + s), e.updateOffset(i, !1), i) : _e(t).local()
    }

    function Se(e) {
        return 15 * -Math.round(e._d.getTimezoneOffset() / 15)
    }

    function Te() {
        return !!this.isValid() && (this._isUTC && 0 === this._offset)
    }

    function De(e, t) {
        var n, i, r, o = e,
            l = null;
        return we(e) ? o = {
            ms: e._milliseconds,
            d: e._days,
            M: e._months
        } : s(e) ? (o = {}, t ? o[t] = e : o.milliseconds = e) : (l = pn.exec(e)) ? (n = "-" === l[1] ? -1 : 1, o = {
            y: 0,
            d: v(l[Et]) * n,
            h: v(l[Pt]) * n,
            m: v(l[Ot]) * n,
            s: v(l[Mt]) * n,
            ms: v(xe(1e3 * l[Nt])) * n
        }) : (l = fn.exec(e)) ? (n = "-" === l[1] ? -1 : 1, o = {
            y: Ee(l[2], n),
            M: Ee(l[3], n),
            w: Ee(l[4], n),
            d: Ee(l[5], n),
            h: Ee(l[6], n),
            m: Ee(l[7], n),
            s: Ee(l[8], n)
        }) : null == o ? o = {} : "object" == typeof o && ("from" in o || "to" in o) && (r = function(e, t) {
            var n;
            if (!e.isValid() || !t.isValid()) return {
                milliseconds: 0,
                months: 0
            };
            t = $e(t, e), e.isBefore(t) ? n = Pe(e, t) : ((n = Pe(t, e)).milliseconds = -n.milliseconds, n.months = -n.months);
            return n
        }(_e(o.from), _e(o.to)), (o = {}).ms = r.milliseconds, o.M = r.months), i = new be(o), we(e) && a(e, "_locale") && (i._locale = e._locale), i
    }

    function Ee(e, t) {
        var n = e && parseFloat(e.replace(",", "."));
        return (isNaN(n) ? 0 : n) * t
    }

    function Pe(e, t) {
        var n = {
            milliseconds: 0,
            months: 0
        };
        return n.months = t.month() - e.month() + 12 * (t.year() - e.year()), e.clone().add(n.months, "M").isAfter(t) && --n.months, n.milliseconds = +t - +e.clone().add(n.months, "M"), n
    }

    function Oe(e, t) {
        return function(n, i) {
            var s, r;
            return null === i || isNaN(+i) || (w(t, "moment()." + t + "(period, number) is deprecated. Please use moment()." + t + "(number, period). See http://momentjs.com/guides/#/warnings/add-inverted-param/ for more info."), r = n, n = i, i = r), n = "string" == typeof n ? +n : n, s = De(n, i), Me(this, s, e), this
        }
    }

    function Me(t, n, i, s) {
        var r = n._milliseconds,
            o = xe(n._days),
            a = xe(n._months);
        t.isValid() && (s = null == s || s, a && U(t, Y(t, "Month") + a * i), o && W(t, "Date", Y(t, "Date") + o * i), r && t._d.setTime(t._d.valueOf() + r * i), s && e.updateOffset(t, o || a))
    }

    function Ne(e, t) {
        var n, i = 12 * (t.year() - e.year()) + (t.month() - e.month()),
            s = e.clone().add(i, "months");
        return n = t - s < 0 ? (t - s) / (s - e.clone().add(i - 1, "months")) : (t - s) / (e.clone().add(i + 1, "months") - s), -(i + n) || 0
    }

    function Ie(e) {
        var t;
        return void 0 === e ? this._locale._abbr : (null != (t = le(e)) && (this._locale = t), this)
    }

    function Ae() {
        return this._locale
    }

    function je(e, t) {
        P(0, [e, e.length], 0, t)
    }

    function He(e, t, n, i, s) {
        var r;
        return null == e ? J(this, i, s).year : (r = Z(e, i, s), t > r && (t = r), function(e, t, n, i, s) {
            var r = K(e, t, n, i, s),
                o = Q(r.year, 0, r.dayOfYear);
            return this.year(o.getUTCFullYear()), this.month(o.getUTCMonth()), this.date(o.getUTCDate()), this
        }.call(this, e, t, n, i, s))
    }

    function Le(e, t) {
        t[Nt] = v(1e3 * ("0." + e))
    }

    function Fe(e) {
        return e
    }

    function Re(e, t, n, i) {
        var s = le(),
            r = c().set(i, t);
        return s[n](r, e)
    }

    function Be(e, t, n) {
        if (s(e) && (t = e, e = void 0), e = e || "", null != t) return Re(e, t, n, "month");
        var i, r = [];
        for (i = 0; i < 12; i++) r[i] = Re(e, i, n, "month");
        return r
    }

    function qe(e, t, n, i) {
        "boolean" == typeof e ? (s(t) && (n = t, t = void 0), t = t || "") : (n = t = e, e = !1, s(t) && (n = t, t = void 0), t = t || "");
        var r = le(),
            o = e ? r._week.dow : 0;
        if (null != n) return Re(t, (n + o) % 7, i, "day");
        var a, l = [];
        for (a = 0; a < 7; a++) l[a] = Re(t, (a + o) % 7, i, "day");
        return l
    }

    function Ye(e, t, n, i) {
        var s = De(t, n);
        return e._milliseconds += i * s._milliseconds, e._days += i * s._days, e._months += i * s._months, e._bubble()
    }

    function We(e) {
        return e < 0 ? Math.floor(e) : Math.ceil(e)
    }

    function ze(e) {
        return 4800 * e / 146097
    }

    function Ue(e) {
        return 146097 * e / 4800
    }

    function Ve(e) {
        return function() {
            return this.as(e)
        }
    }

    function Xe(e) {
        return function() {
            return this.isValid() ? this._data[e] : NaN
        }
    }

    function Qe(e) {
        return (e > 0) - (e < 0) || +e
    }

    function Ge() {
        if (!this.isValid()) return this.localeData().invalidDate();
        var e, t, n = Yn(this._milliseconds) / 1e3,
            i = Yn(this._days),
            s = Yn(this._months);
        t = g((e = g(n / 60)) / 60), n %= 60, e %= 60;
        var r = g(s / 12),
            o = s %= 12,
            a = i,
            l = t,
            c = e,
            d = n ? n.toFixed(3).replace(/\.?0+$/, "") : "",
            u = this.asSeconds();
        if (!u) return "P0D";
        var h = u < 0 ? "-" : "",
            p = Qe(this._months) !== Qe(u) ? "-" : "",
            f = Qe(this._days) !== Qe(u) ? "-" : "",
            m = Qe(this._milliseconds) !== Qe(u) ? "-" : "";
        return h + "P" + (r ? p + r + "Y" : "") + (o ? p + o + "M" : "") + (a ? f + a + "D" : "") + (l || c || d ? "T" : "") + (l ? m + l + "H" : "") + (c ? m + c + "M" : "") + (d ? m + d + "S" : "")
    }
    var Ke, Je;
    Je = Array.prototype.some ? Array.prototype.some : function(e) {
        for (var t = Object(this), n = t.length >>> 0, i = 0; i < n; i++)
            if (i in t && e.call(this, t[i], i, t)) return !0;
        return !1
    };
    var Ze = e.momentProperties = [],
        et = !1,
        tt = {};
    e.suppressDeprecationWarnings = !1, e.deprecationHandler = null;
    var nt;
    nt = Object.keys ? Object.keys : function(e) {
        var t, n = [];
        for (t in e) a(e, t) && n.push(t);
        return n
    };
    var it = {},
        st = {},
        rt = /(\[[^\[]*\])|(\\)?([Hh]mm(ss)?|Mo|MM?M?M?|Do|DDDo|DD?D?D?|ddd?d?|do?|w[o|w]?|W[o|W]?|Qo?|YYYYYY|YYYYY|YYYY|YY|gg(ggg?)?|GG(GGG?)?|e|E|a|A|hh?|HH?|kk?|mm?|ss?|S{1,9}|x|X|zz?|ZZ?|.)/g,
        ot = /(\[[^\[]*\])|(\\)?(LTS|LT|LL?L?L?|l{1,4})/g,
        at = {},
        lt = {},
        ct = /\d/,
        dt = /\d\d/,
        ut = /\d{3}/,
        ht = /\d{4}/,
        pt = /[+-]?\d{6}/,
        ft = /\d\d?/,
        mt = /\d\d\d\d?/,
        gt = /\d\d\d\d\d\d?/,
        vt = /\d{1,3}/,
        _t = /\d{1,4}/,
        yt = /[+-]?\d{1,6}/,
        bt = /\d+/,
        wt = /[+-]?\d+/,
        xt = /Z|[+-]\d\d:?\d\d/gi,
        kt = /Z|[+-]\d\d(?::?\d\d)?/gi,
        Ct = /[0-9]{0,256}['a-z\u00A0-\u05FF\u0700-\uD7FF\uF900-\uFDCF\uFDF0-\uFF07\uFF10-\uFFEF]{1,256}|[\u0600-\u06FF\/]{1,256}(\s*?[\u0600-\u06FF]{1,256}){1,2}/i,
        $t = {},
        St = {},
        Tt = 0,
        Dt = 1,
        Et = 2,
        Pt = 3,
        Ot = 4,
        Mt = 5,
        Nt = 6,
        It = 7,
        At = 8;
    P("Y", 0, 0, function() {
        var e = this.year();
        return e <= 9999 ? "" + e : "+" + e
    }), P(0, ["YY", 2], 0, function() {
        return this.year() % 100
    }), P(0, ["YYYY", 4], 0, "year"), P(0, ["YYYYY", 5], 0, "year"), P(0, ["YYYYYY", 6, !0], 0, "year"), $("year", "y"), D("year", 1), I("Y", wt), I("YY", ft, dt), I("YYYY", _t, ht), I("YYYYY", yt, pt), I("YYYYYY", yt, pt), H(["YYYYY", "YYYYYY"], Tt), H("YYYY", function(t, n) {
        n[Tt] = 2 === t.length ? e.parseTwoDigitYear(t) : v(t)
    }), H("YY", function(t, n) {
        n[Tt] = e.parseTwoDigitYear(t)
    }), H("Y", function(e, t) {
        t[Tt] = parseInt(e, 10)
    }), e.parseTwoDigitYear = function(e) {
        return v(e) + (v(e) > 68 ? 1900 : 2e3)
    };
    var jt, Ht = q("FullYear", !0);
    jt = Array.prototype.indexOf ? Array.prototype.indexOf : function(e) {
        var t;
        for (t = 0; t < this.length; ++t)
            if (this[t] === e) return t;
        return -1
    }, P("M", ["MM", 2], "Mo", function() {
        return this.month() + 1
    }), P("MMM", 0, 0, function(e) {
        return this.localeData().monthsShort(this, e)
    }), P("MMMM", 0, 0, function(e) {
        return this.localeData().months(this, e)
    }), $("month", "M"), D("month", 8), I("M", ft), I("MM", ft, dt), I("MMM", function(e, t) {
        return t.monthsShortRegex(e)
    }), I("MMMM", function(e, t) {
        return t.monthsRegex(e)
    }), H(["M", "MM"], function(e, t) {
        t[Dt] = v(e) - 1
    }), H(["MMM", "MMMM"], function(e, t, n, i) {
        var s = n._locale.monthsParse(e, i, n._strict);
        null != s ? t[Dt] = s : d(n).invalidMonth = e
    });
    var Lt = /D[oD]?(\[[^\[\]]*\]|\s)+MMMM?/,
        Ft = "January_February_March_April_May_June_July_August_September_October_November_December".split("_"),
        Rt = "Jan_Feb_Mar_Apr_May_Jun_Jul_Aug_Sep_Oct_Nov_Dec".split("_"),
        Bt = Ct,
        qt = Ct;
    P("w", ["ww", 2], "wo", "week"), P("W", ["WW", 2], "Wo", "isoWeek"), $("week", "w"), $("isoWeek", "W"), D("week", 5), D("isoWeek", 5), I("w", ft), I("ww", ft, dt), I("W", ft), I("WW", ft, dt), L(["w", "ww", "W", "WW"], function(e, t, n, i) {
        t[i.substr(0, 1)] = v(e)
    });
    P("d", 0, "do", "day"), P("dd", 0, 0, function(e) {
        return this.localeData().weekdaysMin(this, e)
    }), P("ddd", 0, 0, function(e) {
        return this.localeData().weekdaysShort(this, e)
    }), P("dddd", 0, 0, function(e) {
        return this.localeData().weekdays(this, e)
    }), P("e", 0, 0, "weekday"), P("E", 0, 0, "isoWeekday"), $("day", "d"), $("weekday", "e"), $("isoWeekday", "E"), D("day", 11), D("weekday", 11), D("isoWeekday", 11), I("d", ft), I("e", ft), I("E", ft), I("dd", function(e, t) {
        return t.weekdaysMinRegex(e)
    }), I("ddd", function(e, t) {
        return t.weekdaysShortRegex(e)
    }), I("dddd", function(e, t) {
        return t.weekdaysRegex(e)
    }), L(["dd", "ddd", "dddd"], function(e, t, n, i) {
        var s = n._locale.weekdaysParse(e, i, n._strict);
        null != s ? t.d = s : d(n).invalidWeekday = e
    }), L(["d", "e", "E"], function(e, t, n, i) {
        t[i] = v(e)
    });
    var Yt = "Sunday_Monday_Tuesday_Wednesday_Thursday_Friday_Saturday".split("_"),
        Wt = "Sun_Mon_Tue_Wed_Thu_Fri_Sat".split("_"),
        zt = "Su_Mo_Tu_We_Th_Fr_Sa".split("_"),
        Ut = Ct,
        Vt = Ct,
        Xt = Ct;
    P("H", ["HH", 2], 0, "hour"), P("h", ["hh", 2], 0, te), P("k", ["kk", 2], 0, function() {
        return this.hours() || 24
    }), P("hmm", 0, 0, function() {
        return "" + te.apply(this) + E(this.minutes(), 2)
    }), P("hmmss", 0, 0, function() {
        return "" + te.apply(this) + E(this.minutes(), 2) + E(this.seconds(), 2)
    }), P("Hmm", 0, 0, function() {
        return "" + this.hours() + E(this.minutes(), 2)
    }), P("Hmmss", 0, 0, function() {
        return "" + this.hours() + E(this.minutes(), 2) + E(this.seconds(), 2)
    }), ne("a", !0), ne("A", !1), $("hour", "h"), D("hour", 13), I("a", ie), I("A", ie), I("H", ft), I("h", ft), I("k", ft), I("HH", ft, dt), I("hh", ft, dt), I("kk", ft, dt), I("hmm", mt), I("hmmss", gt), I("Hmm", mt), I("Hmmss", gt), H(["H", "HH"], Pt), H(["k", "kk"], function(e, t, n) {
        var i = v(e);
        t[Pt] = 24 === i ? 0 : i
    }), H(["a", "A"], function(e, t, n) {
        n._isPm = n._locale.isPM(e), n._meridiem = e
    }), H(["h", "hh"], function(e, t, n) {
        t[Pt] = v(e), d(n).bigHour = !0
    }), H("hmm", function(e, t, n) {
        var i = e.length - 2;
        t[Pt] = v(e.substr(0, i)), t[Ot] = v(e.substr(i)), d(n).bigHour = !0
    }), H("hmmss", function(e, t, n) {
        var i = e.length - 4,
            s = e.length - 2;
        t[Pt] = v(e.substr(0, i)), t[Ot] = v(e.substr(i, 2)), t[Mt] = v(e.substr(s)), d(n).bigHour = !0
    }), H("Hmm", function(e, t, n) {
        var i = e.length - 2;
        t[Pt] = v(e.substr(0, i)), t[Ot] = v(e.substr(i))
    }), H("Hmmss", function(e, t, n) {
        var i = e.length - 4,
            s = e.length - 2;
        t[Pt] = v(e.substr(0, i)), t[Ot] = v(e.substr(i, 2)), t[Mt] = v(e.substr(s))
    });
    var Qt, Gt = q("Hours", !0),
        Kt = {
            calendar: {
                sameDay: "[Today at] LT",
                nextDay: "[Tomorrow at] LT",
                nextWeek: "dddd [at] LT",
                lastDay: "[Yesterday at] LT",
                lastWeek: "[Last] dddd [at] LT",
                sameElse: "L"
            },
            longDateFormat: {
                LTS: "h:mm:ss A",
                LT: "h:mm A",
                L: "MM/DD/YYYY",
                LL: "MMMM D, YYYY",
                LLL: "MMMM D, YYYY h:mm A",
                LLLL: "dddd, MMMM D, YYYY h:mm A"
            },
            invalidDate: "Invalid date",
            ordinal: "%d",
            dayOfMonthOrdinalParse: /\d{1,2}/,
            relativeTime: {
                future: "in %s",
                past: "%s ago",
                s: "a few seconds",
                ss: "%d seconds",
                m: "a minute",
                mm: "%d minutes",
                h: "an hour",
                hh: "%d hours",
                d: "a day",
                dd: "%d days",
                M: "a month",
                MM: "%d months",
                y: "a year",
                yy: "%d years"
            },
            months: Ft,
            monthsShort: Rt,
            week: {
                dow: 0,
                doy: 6
            },
            weekdays: Yt,
            weekdaysMin: zt,
            weekdaysShort: Wt,
            meridiemParse: /[ap]\.?m?\.?/i
        },
        Jt = {},
        Zt = {},
        en = /^\s*((?:[+-]\d{6}|\d{4})-(?:\d\d-\d\d|W\d\d-\d|W\d\d|\d\d\d|\d\d))(?:(T| )(\d\d(?::\d\d(?::\d\d(?:[.,]\d+)?)?)?)([\+\-]\d\d(?::?\d\d)?|\s*Z)?)?$/,
        tn = /^\s*((?:[+-]\d{6}|\d{4})(?:\d\d\d\d|W\d\d\d|W\d\d|\d\d\d|\d\d))(?:(T| )(\d\d(?:\d\d(?:\d\d(?:[.,]\d+)?)?)?)([\+\-]\d\d(?::?\d\d)?|\s*Z)?)?$/,
        nn = /Z|[+-]\d\d(?::?\d\d)?/,
        sn = [
            ["YYYYYY-MM-DD", /[+-]\d{6}-\d\d-\d\d/],
            ["YYYY-MM-DD", /\d{4}-\d\d-\d\d/],
            ["GGGG-[W]WW-E", /\d{4}-W\d\d-\d/],
            ["GGGG-[W]WW", /\d{4}-W\d\d/, !1],
            ["YYYY-DDD", /\d{4}-\d{3}/],
            ["YYYY-MM", /\d{4}-\d\d/, !1],
            ["YYYYYYMMDD", /[+-]\d{10}/],
            ["YYYYMMDD", /\d{8}/],
            ["GGGG[W]WWE", /\d{4}W\d{3}/],
            ["GGGG[W]WW", /\d{4}W\d{2}/, !1],
            ["YYYYDDD", /\d{7}/]
        ],
        rn = [
            ["HH:mm:ss.SSSS", /\d\d:\d\d:\d\d\.\d+/],
            ["HH:mm:ss,SSSS", /\d\d:\d\d:\d\d,\d+/],
            ["HH:mm:ss", /\d\d:\d\d:\d\d/],
            ["HH:mm", /\d\d:\d\d/],
            ["HHmmss.SSSS", /\d\d\d\d\d\d\.\d+/],
            ["HHmmss,SSSS", /\d\d\d\d\d\d,\d+/],
            ["HHmmss", /\d\d\d\d\d\d/],
            ["HHmm", /\d\d\d\d/],
            ["HH", /\d\d/]
        ],
        on = /^\/?Date\((\-?\d+)/i,
        an = /^(?:(Mon|Tue|Wed|Thu|Fri|Sat|Sun),?\s)?(\d{1,2})\s(Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)\s(\d{2,4})\s(\d\d):(\d\d)(?::(\d\d))?\s(?:(UT|GMT|[ECMP][SD]T)|([Zz])|([+-]\d{4}))$/,
        ln = {
            UT: 0,
            GMT: 0,
            EDT: -240,
            EST: -300,
            CDT: -300,
            CST: -360,
            MDT: -360,
            MST: -420,
            PDT: -420,
            PST: -480
        };
    e.createFromInputFallback = b("value provided is not in a recognized RFC2822 or ISO format. moment construction falls back to js Date(), which is not reliable across all browsers and versions. Non RFC2822/ISO date formats are discouraged and will be removed in an upcoming major release. Please refer to http://momentjs.com/guides/#/warnings/js-date/ for more info.", function(e) {
        e._d = new Date(e._i + (e._useUTC ? " UTC" : ""))
    }), e.ISO_8601 = function() {}, e.RFC_2822 = function() {};
    var cn = b("moment().min is deprecated, use moment.max instead. http://momentjs.com/guides/#/warnings/min-max/", function() {
            var e = _e.apply(null, arguments);
            return this.isValid() && e.isValid() ? e < this ? this : e : h()
        }),
        dn = b("moment().max is deprecated, use moment.min instead. http://momentjs.com/guides/#/warnings/min-max/", function() {
            var e = _e.apply(null, arguments);
            return this.isValid() && e.isValid() ? e > this ? this : e : h()
        }),
        un = ["year", "quarter", "month", "week", "day", "hour", "minute", "second", "millisecond"];
    ke("Z", ":"), ke("ZZ", ""), I("Z", kt), I("ZZ", kt), H(["Z", "ZZ"], function(e, t, n) {
        n._useUTC = !0, n._tzm = Ce(kt, e)
    });
    var hn = /([\+\-]|\d\d)/gi;
    e.updateOffset = function() {};
    var pn = /^(\-|\+)?(?:(\d*)[. ])?(\d+)\:(\d+)(?:\:(\d+)(\.\d*)?)?$/,
        fn = /^(-|\+)?P(?:([-+]?[0-9,.]*)Y)?(?:([-+]?[0-9,.]*)M)?(?:([-+]?[0-9,.]*)W)?(?:([-+]?[0-9,.]*)D)?(?:T(?:([-+]?[0-9,.]*)H)?(?:([-+]?[0-9,.]*)M)?(?:([-+]?[0-9,.]*)S)?)?$/;
    De.fn = be.prototype, De.invalid = function() {
        return De(NaN)
    };
    var mn = Oe(1, "add"),
        gn = Oe(-1, "subtract");
    e.defaultFormat = "YYYY-MM-DDTHH:mm:ssZ", e.defaultFormatUtc = "YYYY-MM-DDTHH:mm:ss[Z]";
    var vn = b("moment().lang() is deprecated. Instead, use moment().localeData() to get the language configuration. Use moment().locale() to change languages.", function(e) {
        return void 0 === e ? this.localeData() : this.locale(e)
    });
    P(0, ["gg", 2], 0, function() {
        return this.weekYear() % 100
    }), P(0, ["GG", 2], 0, function() {
        return this.isoWeekYear() % 100
    }), je("gggg", "weekYear"), je("ggggg", "weekYear"), je("GGGG", "isoWeekYear"), je("GGGGG", "isoWeekYear"), $("weekYear", "gg"), $("isoWeekYear", "GG"), D("weekYear", 1), D("isoWeekYear", 1), I("G", wt), I("g", wt), I("GG", ft, dt), I("gg", ft, dt), I("GGGG", _t, ht), I("gggg", _t, ht), I("GGGGG", yt, pt), I("ggggg", yt, pt), L(["gggg", "ggggg", "GGGG", "GGGGG"], function(e, t, n, i) {
        t[i.substr(0, 2)] = v(e)
    }), L(["gg", "GG"], function(t, n, i, s) {
        n[s] = e.parseTwoDigitYear(t)
    }), P("Q", 0, "Qo", "quarter"), $("quarter", "Q"), D("quarter", 7), I("Q", ct), H("Q", function(e, t) {
        t[Dt] = 3 * (v(e) - 1)
    }), P("D", ["DD", 2], "Do", "date"), $("date", "D"), D("date", 9), I("D", ft), I("DD", ft, dt), I("Do", function(e, t) {
        return e ? t._dayOfMonthOrdinalParse || t._ordinalParse : t._dayOfMonthOrdinalParseLenient
    }), H(["D", "DD"], Et), H("Do", function(e, t) {
        t[Et] = v(e.match(ft)[0])
    });
    var _n = q("Date", !0);
    P("DDD", ["DDDD", 3], "DDDo", "dayOfYear"), $("dayOfYear", "DDD"), D("dayOfYear", 4), I("DDD", vt), I("DDDD", ut), H(["DDD", "DDDD"], function(e, t, n) {
        n._dayOfYear = v(e)
    }), P("m", ["mm", 2], 0, "minute"), $("minute", "m"), D("minute", 14), I("m", ft), I("mm", ft, dt), H(["m", "mm"], Ot);
    var yn = q("Minutes", !1);
    P("s", ["ss", 2], 0, "second"), $("second", "s"), D("second", 15), I("s", ft), I("ss", ft, dt), H(["s", "ss"], Mt);
    var bn = q("Seconds", !1);
    P("S", 0, 0, function() {
        return ~~(this.millisecond() / 100)
    }), P(0, ["SS", 2], 0, function() {
        return ~~(this.millisecond() / 10)
    }), P(0, ["SSS", 3], 0, "millisecond"), P(0, ["SSSS", 4], 0, function() {
        return 10 * this.millisecond()
    }), P(0, ["SSSSS", 5], 0, function() {
        return 100 * this.millisecond()
    }), P(0, ["SSSSSS", 6], 0, function() {
        return 1e3 * this.millisecond()
    }), P(0, ["SSSSSSS", 7], 0, function() {
        return 1e4 * this.millisecond()
    }), P(0, ["SSSSSSSS", 8], 0, function() {
        return 1e5 * this.millisecond()
    }), P(0, ["SSSSSSSSS", 9], 0, function() {
        return 1e6 * this.millisecond()
    }), $("millisecond", "ms"), D("millisecond", 16), I("S", vt, ct), I("SS", vt, dt), I("SSS", vt, ut);
    var wn;
    for (wn = "SSSS"; wn.length <= 9; wn += "S") I(wn, bt);
    for (wn = "S"; wn.length <= 9; wn += "S") H(wn, Le);
    var xn = q("Milliseconds", !1);
    P("z", 0, 0, "zoneAbbr"), P("zz", 0, 0, "zoneName");
    var kn = f.prototype;
    kn.add = mn, kn.calendar = function(t, n) {
        var i = t || _e(),
            s = $e(i, this).startOf("day"),
            r = e.calendarFormat(this, s) || "sameElse",
            o = n && (x(n[r]) ? n[r].call(this, i) : n[r]);
        return this.format(o || this.localeData().calendar(r, this, _e(i)))
    }, kn.clone = function() {
        return new f(this)
    }, kn.diff = function(e, t, n) {
        var i, s, r;
        if (!this.isValid()) return NaN;
        if (!(i = $e(e, this)).isValid()) return NaN;
        switch (s = 6e4 * (i.utcOffset() - this.utcOffset()), t = S(t)) {
            case "year":
                r = Ne(this, i) / 12;
                break;
            case "month":
                r = Ne(this, i);
                break;
            case "quarter":
                r = Ne(this, i) / 3;
                break;
            case "second":
                r = (this - i) / 1e3;
                break;
            case "minute":
                r = (this - i) / 6e4;
                break;
            case "hour":
                r = (this - i) / 36e5;
                break;
            case "day":
                r = (this - i - s) / 864e5;
                break;
            case "week":
                r = (this - i - s) / 6048e5;
                break;
            default:
                r = this - i
        }
        return n ? r : g(r)
    }, kn.endOf = function(e) {
        return void 0 === (e = S(e)) || "millisecond" === e ? this : ("date" === e && (e = "day"), this.startOf(e).add(1, "isoWeek" === e ? "week" : e).subtract(1, "ms"))
    }, kn.format = function(t) {
        t || (t = this.isUtc() ? e.defaultFormatUtc : e.defaultFormat);
        var n = M(this, t);
        return this.localeData().postformat(n)
    }, kn.from = function(e, t) {
        return this.isValid() && (m(e) && e.isValid() || _e(e).isValid()) ? De({
            to: this,
            from: e
        }).locale(this.locale()).humanize(!t) : this.localeData().invalidDate()
    }, kn.fromNow = function(e) {
        return this.from(_e(), e)
    }, kn.to = function(e, t) {
        return this.isValid() && (m(e) && e.isValid() || _e(e).isValid()) ? De({
            from: this,
            to: e
        }).locale(this.locale()).humanize(!t) : this.localeData().invalidDate()
    }, kn.toNow = function(e) {
        return this.to(_e(), e)
    }, kn.get = function(e) {
        return e = S(e), x(this[e]) ? this[e]() : this
    }, kn.invalidAt = function() {
        return d(this).overflow
    }, kn.isAfter = function(e, t) {
        var n = m(e) ? e : _e(e);
        return !(!this.isValid() || !n.isValid()) && ("millisecond" === (t = S(t) || "millisecond") ? this.valueOf() > n.valueOf() : n.valueOf() < this.clone().startOf(t).valueOf())
    }, kn.isBefore = function(e, t) {
        var n = m(e) ? e : _e(e);
        return !(!this.isValid() || !n.isValid()) && ("millisecond" === (t = S(t) || "millisecond") ? this.valueOf() < n.valueOf() : this.clone().endOf(t).valueOf() < n.valueOf())
    }, kn.isBetween = function(e, t, n, i) {
        var s = m(e) ? e : _e(e),
            r = m(t) ? t : _e(t);
        return !!(this.isValid() && s.isValid() && r.isValid()) && ("(" === (i = i || "()")[0] ? this.isAfter(s, n) : !this.isBefore(s, n)) && (")" === i[1] ? this.isBefore(r, n) : !this.isAfter(r, n))
    }, kn.isSame = function(e, t) {
        var n, i = m(e) ? e : _e(e);
        return !(!this.isValid() || !i.isValid()) && ("millisecond" === (t = S(t) || "millisecond") ? this.valueOf() === i.valueOf() : (n = i.valueOf(), this.clone().startOf(t).valueOf() <= n && n <= this.clone().endOf(t).valueOf()))
    }, kn.isSameOrAfter = function(e, t) {
        return this.isSame(e, t) || this.isAfter(e, t)
    }, kn.isSameOrBefore = function(e, t) {
        return this.isSame(e, t) || this.isBefore(e, t)
    }, kn.isValid = function() {
        return u(this)
    }, kn.lang = vn, kn.locale = Ie, kn.localeData = Ae, kn.max = dn, kn.min = cn, kn.parsingFlags = function() {
        return l({}, d(this))
    }, kn.set = function(e, t) {
        if ("object" == typeof e)
            for (var n = function(e) {
                    var t = [];
                    for (var n in e) t.push({
                        unit: n,
                        priority: st[n]
                    });
                    return t.sort(function(e, t) {
                        return e.priority - t.priority
                    }), t
                }(e = T(e)), i = 0; i < n.length; i++) this[n[i].unit](e[n[i].unit]);
        else if (e = S(e), x(this[e])) return this[e](t);
        return this
    }, kn.startOf = function(e) {
        switch (e = S(e)) {
            case "year":
                this.month(0);
            case "quarter":
            case "month":
                this.date(1);
            case "week":
            case "isoWeek":
            case "day":
            case "date":
                this.hours(0);
            case "hour":
                this.minutes(0);
            case "minute":
                this.seconds(0);
            case "second":
                this.milliseconds(0)
        }
        return "week" === e && this.weekday(0), "isoWeek" === e && this.isoWeekday(1), "quarter" === e && this.month(3 * Math.floor(this.month() / 3)), this
    }, kn.subtract = gn, kn.toArray = function() {
        return [this.year(), this.month(), this.date(), this.hour(), this.minute(), this.second(), this.millisecond()]
    }, kn.toObject = function() {
        return {
            years: this.year(),
            months: this.month(),
            date: this.date(),
            hours: this.hours(),
            minutes: this.minutes(),
            seconds: this.seconds(),
            milliseconds: this.milliseconds()
        }
    }, kn.toDate = function() {
        return new Date(this.valueOf())
    }, kn.toISOString = function(e) {
        if (!this.isValid()) return null;
        var t = !0 !== e,
            n = t ? this.clone().utc() : this;
        return n.year() < 0 || n.year() > 9999 ? M(n, t ? "YYYYYY-MM-DD[T]HH:mm:ss.SSS[Z]" : "YYYYYY-MM-DD[T]HH:mm:ss.SSSZ") : x(Date.prototype.toISOString) ? t ? this.toDate().toISOString() : new Date(this.valueOf() + 60 * this.utcOffset() * 1e3).toISOString().replace("Z", M(n, "Z")) : M(n, t ? "YYYY-MM-DD[T]HH:mm:ss.SSS[Z]" : "YYYY-MM-DD[T]HH:mm:ss.SSSZ")
    }, kn.inspect = function() {
        if (!this.isValid()) return "moment.invalid(/* " + this._i + " */)";
        var e = "moment",
            t = "";
        this.isLocal() || (e = 0 === this.utcOffset() ? "moment.utc" : "moment.parseZone", t = "Z");
        var n = "[" + e + '("]',
            i = 0 <= this.year() && this.year() <= 9999 ? "YYYY" : "YYYYYY",
            s = t + '[")]';
        return this.format(n + i + "-MM-DD[T]HH:mm:ss.SSS" + s)
    }, kn.toJSON = function() {
        return this.isValid() ? this.toISOString() : null
    }, kn.toString = function() {
        return this.clone().locale("en").format("ddd MMM DD YYYY HH:mm:ss [GMT]ZZ")
    }, kn.unix = function() {
        return Math.floor(this.valueOf() / 1e3)
    }, kn.valueOf = function() {
        return this._d.valueOf() - 6e4 * (this._offset || 0)
    }, kn.creationData = function() {
        return {
            input: this._i,
            format: this._f,
            locale: this._locale,
            isUTC: this._isUTC,
            strict: this._strict
        }
    }, kn.year = Ht, kn.isLeapYear = function() {
        return B(this.year())
    }, kn.weekYear = function(e) {
        return He.call(this, e, this.week(), this.weekday(), this.localeData()._week.dow, this.localeData()._week.doy)
    }, kn.isoWeekYear = function(e) {
        return He.call(this, e, this.isoWeek(), this.isoWeekday(), 1, 4)
    }, kn.quarter = kn.quarters = function(e) {
        return null == e ? Math.ceil((this.month() + 1) / 3) : this.month(3 * (e - 1) + this.month() % 3)
    }, kn.month = V, kn.daysInMonth = function() {
        return z(this.year(), this.month())
    }, kn.week = kn.weeks = function(e) {
        var t = this.localeData().week(this);
        return null == e ? t : this.add(7 * (e - t), "d")
    }, kn.isoWeek = kn.isoWeeks = function(e) {
        var t = J(this, 1, 4).week;
        return null == e ? t : this.add(7 * (e - t), "d")
    }, kn.weeksInYear = function() {
        var e = this.localeData()._week;
        return Z(this.year(), e.dow, e.doy)
    }, kn.isoWeeksInYear = function() {
        return Z(this.year(), 1, 4)
    }, kn.date = _n, kn.day = kn.days = function(e) {
        if (!this.isValid()) return null != e ? this : NaN;
        var t = this._isUTC ? this._d.getUTCDay() : this._d.getDay();
        return null != e ? (e = function(e, t) {
            return "string" != typeof e ? e : isNaN(e) ? "number" == typeof(e = t.weekdaysParse(e)) ? e : null : parseInt(e, 10)
        }(e, this.localeData()), this.add(e - t, "d")) : t
    }, kn.weekday = function(e) {
        if (!this.isValid()) return null != e ? this : NaN;
        var t = (this.day() + 7 - this.localeData()._week.dow) % 7;
        return null == e ? t : this.add(e - t, "d")
    }, kn.isoWeekday = function(e) {
        if (!this.isValid()) return null != e ? this : NaN;
        if (null != e) {
            var t = function(e, t) {
                return "string" == typeof e ? t.weekdaysParse(e) % 7 || 7 : isNaN(e) ? null : e
            }(e, this.localeData());
            return this.day(this.day() % 7 ? t : t - 7)
        }
        return this.day() || 7
    }, kn.dayOfYear = function(e) {
        var t = Math.round((this.clone().startOf("day") - this.clone().startOf("year")) / 864e5) + 1;
        return null == e ? t : this.add(e - t, "d")
    }, kn.hour = kn.hours = Gt, kn.minute = kn.minutes = yn, kn.second = kn.seconds = bn, kn.millisecond = kn.milliseconds = xn, kn.utcOffset = function(t, n, i) {
        var s, r = this._offset || 0;
        if (!this.isValid()) return null != t ? this : NaN;
        if (null != t) {
            if ("string" == typeof t) {
                if (null === (t = Ce(kt, t))) return this
            } else Math.abs(t) < 16 && !i && (t *= 60);
            return !this._isUTC && n && (s = Se(this)), this._offset = t, this._isUTC = !0, null != s && this.add(s, "m"), r !== t && (!n || this._changeInProgress ? Me(this, De(t - r, "m"), 1, !1) : this._changeInProgress || (this._changeInProgress = !0, e.updateOffset(this, !0), this._changeInProgress = null)), this
        }
        return this._isUTC ? r : Se(this)
    }, kn.utc = function(e) {
        return this.utcOffset(0, e)
    }, kn.local = function(e) {
        return this._isUTC && (this.utcOffset(0, e), this._isUTC = !1, e && this.subtract(Se(this), "m")), this
    }, kn.parseZone = function() {
        if (null != this._tzm) this.utcOffset(this._tzm, !1, !0);
        else if ("string" == typeof this._i) {
            var e = Ce(xt, this._i);
            null != e ? this.utcOffset(e) : this.utcOffset(0, !0)
        }
        return this
    }, kn.hasAlignedHourOffset = function(e) {
        return !!this.isValid() && (e = e ? _e(e).utcOffset() : 0, (this.utcOffset() - e) % 60 == 0)
    }, kn.isDST = function() {
        return this.utcOffset() > this.clone().month(0).utcOffset() || this.utcOffset() > this.clone().month(5).utcOffset()
    }, kn.isLocal = function() {
        return !!this.isValid() && !this._isUTC
    }, kn.isUtcOffset = function() {
        return !!this.isValid() && this._isUTC
    }, kn.isUtc = Te, kn.isUTC = Te, kn.zoneAbbr = function() {
        return this._isUTC ? "UTC" : ""
    }, kn.zoneName = function() {
        return this._isUTC ? "Coordinated Universal Time" : ""
    }, kn.dates = b("dates accessor is deprecated. Use date instead.", _n), kn.months = b("months accessor is deprecated. Use month instead", V), kn.years = b("years accessor is deprecated. Use year instead", Ht), kn.zone = b("moment().zone is deprecated, use moment().utcOffset instead. http://momentjs.com/guides/#/warnings/zone/", function(e, t) {
        return null != e ? ("string" != typeof e && (e = -e), this.utcOffset(e, t), this) : -this.utcOffset()
    }), kn.isDSTShifted = b("isDSTShifted is deprecated. See http://momentjs.com/guides/#/warnings/dst-shifted/ for more information", function() {
        if (!i(this._isDSTShifted)) return this._isDSTShifted;
        var e = {};
        if (p(e, this), (e = ge(e))._a) {
            var t = e._isUTC ? c(e._a) : _e(e._a);
            this._isDSTShifted = this.isValid() && _(e._a, t.toArray()) > 0
        } else this._isDSTShifted = !1;
        return this._isDSTShifted
    });
    var Cn = C.prototype;
    Cn.calendar = function(e, t, n) {
        var i = this._calendar[e] || this._calendar.sameElse;
        return x(i) ? i.call(t, n) : i
    }, Cn.longDateFormat = function(e) {
        var t = this._longDateFormat[e],
            n = this._longDateFormat[e.toUpperCase()];
        return t || !n ? t : (this._longDateFormat[e] = n.replace(/MMMM|MM|DD|dddd/g, function(e) {
            return e.slice(1)
        }), this._longDateFormat[e])
    }, Cn.invalidDate = function() {
        return this._invalidDate
    }, Cn.ordinal = function(e) {
        return this._ordinal.replace("%d", e)
    }, Cn.preparse = Fe, Cn.postformat = Fe, Cn.relativeTime = function(e, t, n, i) {
        var s = this._relativeTime[n];
        return x(s) ? s(e, t, n, i) : s.replace(/%d/i, e)
    }, Cn.pastFuture = function(e, t) {
        var n = this._relativeTime[e > 0 ? "future" : "past"];
        return x(n) ? n(t) : n.replace(/%s/i, t)
    }, Cn.set = function(e) {
        var t, n;
        for (n in e) x(t = e[n]) ? this[n] = t : this["_" + n] = t;
        this._config = e, this._dayOfMonthOrdinalParseLenient = new RegExp((this._dayOfMonthOrdinalParse.source || this._ordinalParse.source) + "|" + /\d{1,2}/.source)
    }, Cn.months = function(e, n) {
        return e ? t(this._months) ? this._months[e.month()] : this._months[(this._months.isFormat || Lt).test(n) ? "format" : "standalone"][e.month()] : t(this._months) ? this._months : this._months.standalone
    }, Cn.monthsShort = function(e, n) {
        return e ? t(this._monthsShort) ? this._monthsShort[e.month()] : this._monthsShort[Lt.test(n) ? "format" : "standalone"][e.month()] : t(this._monthsShort) ? this._monthsShort : this._monthsShort.standalone
    }, Cn.monthsParse = function(e, t, n) {
        var i, s, r;
        if (this._monthsParseExact) return function(e, t, n) {
            var i, s, r, o = e.toLocaleLowerCase();
            if (!this._monthsParse)
                for (this._monthsParse = [], this._longMonthsParse = [], this._shortMonthsParse = [], i = 0; i < 12; ++i) r = c([2e3, i]), this._shortMonthsParse[i] = this.monthsShort(r, "").toLocaleLowerCase(), this._longMonthsParse[i] = this.months(r, "").toLocaleLowerCase();
            return n ? "MMM" === t ? -1 !== (s = jt.call(this._shortMonthsParse, o)) ? s : null : -1 !== (s = jt.call(this._longMonthsParse, o)) ? s : null : "MMM" === t ? -1 !== (s = jt.call(this._shortMonthsParse, o)) ? s : -1 !== (s = jt.call(this._longMonthsParse, o)) ? s : null : -1 !== (s = jt.call(this._longMonthsParse, o)) ? s : -1 !== (s = jt.call(this._shortMonthsParse, o)) ? s : null
        }.call(this, e, t, n);
        for (this._monthsParse || (this._monthsParse = [], this._longMonthsParse = [], this._shortMonthsParse = []), i = 0; i < 12; i++) {
            if (s = c([2e3, i]), n && !this._longMonthsParse[i] && (this._longMonthsParse[i] = new RegExp("^" + this.months(s, "").replace(".", "") + "$", "i"), this._shortMonthsParse[i] = new RegExp("^" + this.monthsShort(s, "").replace(".", "") + "$", "i")), n || this._monthsParse[i] || (r = "^" + this.months(s, "") + "|^" + this.monthsShort(s, ""), this._monthsParse[i] = new RegExp(r.replace(".", ""), "i")), n && "MMMM" === t && this._longMonthsParse[i].test(e)) return i;
            if (n && "MMM" === t && this._shortMonthsParse[i].test(e)) return i;
            if (!n && this._monthsParse[i].test(e)) return i
        }
    }, Cn.monthsRegex = function(e) {
        return this._monthsParseExact ? (a(this, "_monthsRegex") || X.call(this), e ? this._monthsStrictRegex : this._monthsRegex) : (a(this, "_monthsRegex") || (this._monthsRegex = qt), this._monthsStrictRegex && e ? this._monthsStrictRegex : this._monthsRegex)
    }, Cn.monthsShortRegex = function(e) {
        return this._monthsParseExact ? (a(this, "_monthsRegex") || X.call(this), e ? this._monthsShortStrictRegex : this._monthsShortRegex) : (a(this, "_monthsShortRegex") || (this._monthsShortRegex = Bt), this._monthsShortStrictRegex && e ? this._monthsShortStrictRegex : this._monthsShortRegex)
    }, Cn.week = function(e) {
        return J(e, this._week.dow, this._week.doy).week
    }, Cn.firstDayOfYear = function() {
        return this._week.doy
    }, Cn.firstDayOfWeek = function() {
        return this._week.dow
    }, Cn.weekdays = function(e, n) {
        return e ? t(this._weekdays) ? this._weekdays[e.day()] : this._weekdays[this._weekdays.isFormat.test(n) ? "format" : "standalone"][e.day()] : t(this._weekdays) ? this._weekdays : this._weekdays.standalone
    }, Cn.weekdaysMin = function(e) {
        return e ? this._weekdaysMin[e.day()] : this._weekdaysMin
    }, Cn.weekdaysShort = function(e) {
        return e ? this._weekdaysShort[e.day()] : this._weekdaysShort
    }, Cn.weekdaysParse = function(e, t, n) {
        var i, s, r;
        if (this._weekdaysParseExact) return function(e, t, n) {
            var i, s, r, o = e.toLocaleLowerCase();
            if (!this._weekdaysParse)
                for (this._weekdaysParse = [], this._shortWeekdaysParse = [], this._minWeekdaysParse = [], i = 0; i < 7; ++i) r = c([2e3, 1]).day(i), this._minWeekdaysParse[i] = this.weekdaysMin(r, "").toLocaleLowerCase(), this._shortWeekdaysParse[i] = this.weekdaysShort(r, "").toLocaleLowerCase(), this._weekdaysParse[i] = this.weekdays(r, "").toLocaleLowerCase();
            return n ? "dddd" === t ? -1 !== (s = jt.call(this._weekdaysParse, o)) ? s : null : "ddd" === t ? -1 !== (s = jt.call(this._shortWeekdaysParse, o)) ? s : null : -1 !== (s = jt.call(this._minWeekdaysParse, o)) ? s : null : "dddd" === t ? -1 !== (s = jt.call(this._weekdaysParse, o)) ? s : -1 !== (s = jt.call(this._shortWeekdaysParse, o)) ? s : -1 !== (s = jt.call(this._minWeekdaysParse, o)) ? s : null : "ddd" === t ? -1 !== (s = jt.call(this._shortWeekdaysParse, o)) ? s : -1 !== (s = jt.call(this._weekdaysParse, o)) ? s : -1 !== (s = jt.call(this._minWeekdaysParse, o)) ? s : null : -1 !== (s = jt.call(this._minWeekdaysParse, o)) ? s : -1 !== (s = jt.call(this._weekdaysParse, o)) ? s : -1 !== (s = jt.call(this._shortWeekdaysParse, o)) ? s : null
        }.call(this, e, t, n);
        for (this._weekdaysParse || (this._weekdaysParse = [], this._minWeekdaysParse = [], this._shortWeekdaysParse = [], this._fullWeekdaysParse = []), i = 0; i < 7; i++) {
            if (s = c([2e3, 1]).day(i), n && !this._fullWeekdaysParse[i] && (this._fullWeekdaysParse[i] = new RegExp("^" + this.weekdays(s, "").replace(".", "\\.?") + "$", "i"), this._shortWeekdaysParse[i] = new RegExp("^" + this.weekdaysShort(s, "").replace(".", "\\.?") + "$", "i"), this._minWeekdaysParse[i] = new RegExp("^" + this.weekdaysMin(s, "").replace(".", "\\.?") + "$", "i")), this._weekdaysParse[i] || (r = "^" + this.weekdays(s, "") + "|^" + this.weekdaysShort(s, "") + "|^" + this.weekdaysMin(s, ""), this._weekdaysParse[i] = new RegExp(r.replace(".", ""), "i")), n && "dddd" === t && this._fullWeekdaysParse[i].test(e)) return i;
            if (n && "ddd" === t && this._shortWeekdaysParse[i].test(e)) return i;
            if (n && "dd" === t && this._minWeekdaysParse[i].test(e)) return i;
            if (!n && this._weekdaysParse[i].test(e)) return i
        }
    }, Cn.weekdaysRegex = function(e) {
        return this._weekdaysParseExact ? (a(this, "_weekdaysRegex") || ee.call(this), e ? this._weekdaysStrictRegex : this._weekdaysRegex) : (a(this, "_weekdaysRegex") || (this._weekdaysRegex = Ut), this._weekdaysStrictRegex && e ? this._weekdaysStrictRegex : this._weekdaysRegex)
    }, Cn.weekdaysShortRegex = function(e) {
        return this._weekdaysParseExact ? (a(this, "_weekdaysRegex") || ee.call(this), e ? this._weekdaysShortStrictRegex : this._weekdaysShortRegex) : (a(this, "_weekdaysShortRegex") || (this._weekdaysShortRegex = Vt), this._weekdaysShortStrictRegex && e ? this._weekdaysShortStrictRegex : this._weekdaysShortRegex)
    }, Cn.weekdaysMinRegex = function(e) {
        return this._weekdaysParseExact ? (a(this, "_weekdaysRegex") || ee.call(this), e ? this._weekdaysMinStrictRegex : this._weekdaysMinRegex) : (a(this, "_weekdaysMinRegex") || (this._weekdaysMinRegex = Xt), this._weekdaysMinStrictRegex && e ? this._weekdaysMinStrictRegex : this._weekdaysMinRegex)
    }, Cn.isPM = function(e) {
        return "p" === (e + "").toLowerCase().charAt(0)
    }, Cn.meridiem = function(e, t, n) {
        return e > 11 ? n ? "pm" : "PM" : n ? "am" : "AM"
    }, oe("en", {
        dayOfMonthOrdinalParse: /\d{1,2}(th|st|nd|rd)/,
        ordinal: function(e) {
            var t = e % 10;
            return e + (1 === v(e % 100 / 10) ? "th" : 1 === t ? "st" : 2 === t ? "nd" : 3 === t ? "rd" : "th")
        }
    }), e.lang = b("moment.lang is deprecated. Use moment.locale instead.", oe), e.langData = b("moment.langData is deprecated. Use moment.localeData instead.", le);
    var $n = Math.abs,
        Sn = Ve("ms"),
        Tn = Ve("s"),
        Dn = Ve("m"),
        En = Ve("h"),
        Pn = Ve("d"),
        On = Ve("w"),
        Mn = Ve("M"),
        Nn = Ve("y"),
        In = Xe("milliseconds"),
        An = Xe("seconds"),
        jn = Xe("minutes"),
        Hn = Xe("hours"),
        Ln = Xe("days"),
        Fn = Xe("months"),
        Rn = Xe("years"),
        Bn = Math.round,
        qn = {
            ss: 44,
            s: 45,
            m: 45,
            h: 22,
            d: 26,
            M: 11
        },
        Yn = Math.abs,
        Wn = be.prototype;
    return Wn.isValid = function() {
            return this._isValid
        }, Wn.abs = function() {
            var e = this._data;
            return this._milliseconds = $n(this._milliseconds), this._days = $n(this._days), this._months = $n(this._months), e.milliseconds = $n(e.milliseconds), e.seconds = $n(e.seconds), e.minutes = $n(e.minutes), e.hours = $n(e.hours), e.months = $n(e.months), e.years = $n(e.years), this
        }, Wn.add = function(e, t) {
            return Ye(this, e, t, 1)
        }, Wn.subtract = function(e, t) {
            return Ye(this, e, t, -1)
        }, Wn.as = function(e) {
            if (!this.isValid()) return NaN;
            var t, n, i = this._milliseconds;
            if ("month" === (e = S(e)) || "year" === e) return t = this._days + i / 864e5, n = this._months + ze(t), "month" === e ? n : n / 12;
            switch (t = this._days + Math.round(Ue(this._months)), e) {
                case "week":
                    return t / 7 + i / 6048e5;
                case "day":
                    return t + i / 864e5;
                case "hour":
                    return 24 * t + i / 36e5;
                case "minute":
                    return 1440 * t + i / 6e4;
                case "second":
                    return 86400 * t + i / 1e3;
                case "millisecond":
                    return Math.floor(864e5 * t) + i;
                default:
                    throw new Error("Unknown unit " + e)
            }
        }, Wn.asMilliseconds = Sn, Wn.asSeconds = Tn, Wn.asMinutes = Dn, Wn.asHours = En, Wn.asDays = Pn, Wn.asWeeks = On, Wn.asMonths = Mn, Wn.asYears = Nn, Wn.valueOf = function() {
            return this.isValid() ? this._milliseconds + 864e5 * this._days + this._months % 12 * 2592e6 + 31536e6 * v(this._months / 12) : NaN
        }, Wn._bubble = function() {
            var e, t, n, i, s, r = this._milliseconds,
                o = this._days,
                a = this._months,
                l = this._data;
            return r >= 0 && o >= 0 && a >= 0 || r <= 0 && o <= 0 && a <= 0 || (r += 864e5 * We(Ue(a) + o), o = 0, a = 0), l.milliseconds = r % 1e3, e = g(r / 1e3), l.seconds = e % 60, t = g(e / 60), l.minutes = t % 60, n = g(t / 60), l.hours = n % 24, o += g(n / 24), s = g(ze(o)), a += s, o -= We(Ue(s)), i = g(a / 12), a %= 12, l.days = o, l.months = a, l.years = i, this
        }, Wn.clone = function() {
            return De(this)
        }, Wn.get = function(e) {
            return e = S(e), this.isValid() ? this[e + "s"]() : NaN
        }, Wn.milliseconds = In, Wn.seconds = An, Wn.minutes = jn, Wn.hours = Hn, Wn.days = Ln, Wn.weeks = function() {
            return g(this.days() / 7)
        }, Wn.months = Fn, Wn.years = Rn, Wn.humanize = function(e) {
            if (!this.isValid()) return this.localeData().invalidDate();
            var t = this.localeData(),
                n = function(e, t, n) {
                    var i = De(e).abs(),
                        s = Bn(i.as("s")),
                        r = Bn(i.as("m")),
                        o = Bn(i.as("h")),
                        a = Bn(i.as("d")),
                        l = Bn(i.as("M")),
                        c = Bn(i.as("y")),
                        d = s <= qn.ss && ["s", s] || s < qn.s && ["ss", s] || r <= 1 && ["m"] || r < qn.m && ["mm", r] || o <= 1 && ["h"] || o < qn.h && ["hh", o] || a <= 1 && ["d"] || a < qn.d && ["dd", a] || l <= 1 && ["M"] || l < qn.M && ["MM", l] || c <= 1 && ["y"] || ["yy", c];
                    return d[2] = t, d[3] = +e > 0, d[4] = n,
                        function(e, t, n, i, s) {
                            return s.relativeTime(t || 1, !!n, e, i)
                        }.apply(null, d)
                }(this, !e, t);
            return e && (n = t.pastFuture(+this, n)), t.postformat(n)
        }, Wn.toISOString = Ge, Wn.toString = Ge, Wn.toJSON = Ge, Wn.locale = Ie, Wn.localeData = Ae, Wn.toIsoString = b("toIsoString() is deprecated. Please use toISOString() instead (notice the capitals)", Ge), Wn.lang = vn, P("X", 0, 0, "unix"), P("x", 0, 0, "valueOf"), I("x", wt), I("X", /[+-]?\d+(\.\d{1,3})?/), H("X", function(e, t, n) {
            n._d = new Date(1e3 * parseFloat(e, 10))
        }), H("x", function(e, t, n) {
            n._d = new Date(v(e))
        }), e.version = "2.23.0",
        function(e) {
            Ke = e
        }(_e), e.fn = kn, e.min = function() {
            return ye("isBefore", [].slice.call(arguments, 0))
        }, e.max = function() {
            return ye("isAfter", [].slice.call(arguments, 0))
        }, e.now = function() {
            return Date.now ? Date.now() : +new Date
        }, e.utc = c, e.unix = function(e) {
            return _e(1e3 * e)
        }, e.months = function(e, t) {
            return Be(e, t, "months")
        }, e.isDate = r, e.locale = oe, e.invalid = h, e.duration = De, e.isMoment = m, e.weekdays = function(e, t, n) {
            return qe(e, t, n, "weekdays")
        }, e.parseZone = function() {
            return _e.apply(null, arguments).parseZone()
        }, e.localeData = le, e.isDuration = we, e.monthsShort = function(e, t) {
            return Be(e, t, "monthsShort")
        }, e.weekdaysMin = function(e, t, n) {
            return qe(e, t, n, "weekdaysMin")
        }, e.defineLocale = ae, e.updateLocale = function(e, t) {
            if (null != t) {
                var n, i, s = Kt;
                null != (i = re(e)) && (s = i._config), (n = new C(t = k(s, t))).parentLocale = Jt[e], Jt[e] = n, oe(e)
            } else null != Jt[e] && (null != Jt[e].parentLocale ? Jt[e] = Jt[e].parentLocale : null != Jt[e] && delete Jt[e]);
            return Jt[e]
        }, e.locales = function() {
            return nt(Jt)
        }, e.weekdaysShort = function(e, t, n) {
            return qe(e, t, n, "weekdaysShort")
        }, e.normalizeUnits = S, e.relativeTimeRounding = function(e) {
            return void 0 === e ? Bn : "function" == typeof e && (Bn = e, !0)
        }, e.relativeTimeThreshold = function(e, t) {
            return void 0 !== qn[e] && (void 0 === t ? qn[e] : (qn[e] = t, "s" === e && (qn.ss = t - 1), !0))
        }, e.calendarFormat = function(e, t) {
            var n = e.diff(t, "days", !0);
            return n < -6 ? "sameElse" : n < -1 ? "lastWeek" : n < 0 ? "lastDay" : n < 1 ? "sameDay" : n < 2 ? "nextDay" : n < 7 ? "nextWeek" : "sameElse"
        }, e.prototype = kn, e.HTML5_FMT = {
            DATETIME_LOCAL: "YYYY-MM-DDTHH:mm",
            DATETIME_LOCAL_SECONDS: "YYYY-MM-DDTHH:mm:ss",
            DATETIME_LOCAL_MS: "YYYY-MM-DDTHH:mm:ss.SSS",
            DATE: "YYYY-MM-DD",
            TIME: "HH:mm",
            TIME_SECONDS: "HH:mm:ss",
            TIME_MS: "HH:mm:ss.SSS",
            WEEK: "GGGG-[W]WW",
            MONTH: "YYYY-MM"
        }, e
}),
function(e) {
    "use strict";
    var t = function(e, t) {
        this.type = null, this.options = null, this.enabled = null, this.timeout = null, this.hoverState = null, this.$element = null, this.inState = null, this.init("tooltip", e, t)
    };
    t.VERSION = "3.3.6", t.TRANSITION_DURATION = 150, t.DEFAULTS = {
        animation: !0,
        placement: "top",
        selector: !1,
        template: '<div class="tooltip" role="tooltip"><div class="tooltip-arrow"></div><div class="tooltip-inner"></div></div>',
        trigger: "hover focus",
        title: "",
        delay: 0,
        html: !1,
        container: !1,
        viewport: {
            selector: "body",
            padding: 0
        }
    }, t.prototype.init = function(t, n, i) {
        if (this.enabled = !0, this.type = t, this.$element = e(n), this.options = this.getOptions(i), this.$viewport = this.options.viewport && e(e.isFunction(this.options.viewport) ? this.options.viewport.call(this, this.$element) : this.options.viewport.selector || this.options.viewport), this.inState = {
                click: !1,
                hover: !1,
                focus: !1
            }, this.$element[0] instanceof document.constructor && !this.options.selector) throw new Error("`selector` option must be specified when initializing " + this.type + " on the window.document object!");
        for (var s = this.options.trigger.split(" "), r = s.length; r--;) {
            var o = s[r];
            if ("click" == o) this.$element.on("click." + this.type, this.options.selector, e.proxy(this.toggle, this));
            else if ("manual" != o) {
                var a = "hover" == o ? "mouseenter" : "focusin",
                    l = "hover" == o ? "mouseleave" : "focusout";
                this.$element.on(a + "." + this.type, this.options.selector, e.proxy(this.enter, this)), this.$element.on(l + "." + this.type, this.options.selector, e.proxy(this.leave, this))
            }
        }
        this.options.selector ? this._options = e.extend({}, this.options, {
            trigger: "manual",
            selector: ""
        }) : this.fixTitle()
    }, t.prototype.getDefaults = function() {
        return t.DEFAULTS
    }, t.prototype.getOptions = function(t) {
        return (t = e.extend({}, this.getDefaults(), this.$element.data(), t)).delay && "number" == typeof t.delay && (t.delay = {
            show: t.delay,
            hide: t.delay
        }), t
    }, t.prototype.getDelegateOptions = function() {
        var t = {},
            n = this.getDefaults();
        return this._options && e.each(this._options, function(e, i) {
            n[e] != i && (t[e] = i)
        }), t
    }, t.prototype.enter = function(t) {
        var n = t instanceof this.constructor ? t : e(t.currentTarget).data("bs." + this.type);
        if (n || (n = new this.constructor(t.currentTarget, this.getDelegateOptions()), e(t.currentTarget).data("bs." + this.type, n)), t instanceof e.Event && (n.inState["focusin" == t.type ? "focus" : "hover"] = !0), n.tip().hasClass("in") || "in" == n.hoverState) n.hoverState = "in";
        else {
            if (clearTimeout(n.timeout), n.hoverState = "in", !n.options.delay || !n.options.delay.show) return n.show();
            n.timeout = setTimeout(function() {
                "in" == n.hoverState && n.show()
            }, n.options.delay.show)
        }
    }, t.prototype.isInStateTrue = function() {
        for (var e in this.inState)
            if (this.inState[e]) return !0;
        return !1
    }, t.prototype.leave = function(t) {
        var n = t instanceof this.constructor ? t : e(t.currentTarget).data("bs." + this.type);
        if (n || (n = new this.constructor(t.currentTarget, this.getDelegateOptions()), e(t.currentTarget).data("bs." + this.type, n)), t instanceof e.Event && (n.inState["focusout" == t.type ? "focus" : "hover"] = !1), !n.isInStateTrue()) {
            if (clearTimeout(n.timeout), n.hoverState = "out", !n.options.delay || !n.options.delay.hide) return n.hide();
            n.timeout = setTimeout(function() {
                "out" == n.hoverState && n.hide()
            }, n.options.delay.hide)
        }
    }, t.prototype.show = function() {
        var n = e.Event("show.bs." + this.type);
        if (this.hasContent() && this.enabled) {
            this.$element.trigger(n);
            var i = e.contains(this.$element[0].ownerDocument.documentElement, this.$element[0]);
            if (n.isDefaultPrevented() || !i) return;
            var s = this,
                r = this.tip(),
                o = this.getUID(this.type);
            this.setContent(), r.attr("id", o), this.$element.attr("aria-describedby", o), this.options.animation && r.addClass("fade");
            var a = "function" == typeof this.options.placement ? this.options.placement.call(this, r[0], this.$element[0]) : this.options.placement,
                l = /\s?auto?\s?/i,
                c = l.test(a);
            c && (a = a.replace(l, "") || "top"), r.detach().css({
                top: 0,
                left: 0,
                display: "block"
            }).addClass(a).data("bs." + this.type, this), this.options.container ? r.appendTo(this.options.container) : r.insertAfter(this.$element), this.$element.trigger("inserted.bs." + this.type);
            var d = this.getPosition(),
                u = r[0].offsetWidth,
                h = r[0].offsetHeight;
            if (c) {
                var p = a,
                    f = this.getPosition(this.$viewport);
                a = "bottom" == a && d.bottom + h > f.bottom ? "top" : "top" == a && d.top - h < f.top ? "bottom" : "right" == a && d.right + u > f.width ? "left" : "left" == a && d.left - u < f.left ? "right" : a, r.removeClass(p).addClass(a)
            }
            var m = this.getCalculatedOffset(a, d, u, h);
            this.applyPlacement(m, a);
            var g = function() {
                var e = s.hoverState;
                s.$element.trigger("shown.bs." + s.type), s.hoverState = null, "out" == e && s.leave(s)
            };
            e.support.transition && this.$tip.hasClass("fade") ? r.one("bsTransitionEnd", g).emulateTransitionEnd(t.TRANSITION_DURATION) : g()
        }
    }, t.prototype.applyPlacement = function(t, n) {
        var i = this.tip(),
            s = i[0].offsetWidth,
            r = i[0].offsetHeight,
            o = parseInt(i.css("margin-top"), 10),
            a = parseInt(i.css("margin-left"), 10);
        isNaN(o) && (o = 0), isNaN(a) && (a = 0), t.top += o, t.left += a, e.offset.setOffset(i[0], e.extend({
            using: function(e) {
                i.css({
                    top: Math.round(e.top),
                    left: Math.round(e.left)
                })
            }
        }, t), 0), i.addClass("in");
        var l = i[0].offsetWidth,
            c = i[0].offsetHeight;
        "top" == n && c != r && (t.top = t.top + r - c);
        var d = this.getViewportAdjustedDelta(n, t, l, c);
        d.left ? t.left += d.left : t.top += d.top;
        var u = /top|bottom/.test(n),
            h = u ? 2 * d.left - s + l : 2 * d.top - r + c,
            p = u ? "offsetWidth" : "offsetHeight";
        i.offset(t), this.replaceArrow(h, i[0][p], u)
    }, t.prototype.replaceArrow = function(e, t, n) {
        this.arrow().css(n ? "left" : "top", 50 * (1 - e / t) + "%").css(n ? "top" : "left", "")
    }, t.prototype.setContent = function() {
        var e = this.tip(),
            t = this.getTitle();
        e.find(".tooltip-inner")[this.options.html ? "html" : "text"](t), e.removeClass("fade in top bottom left right")
    }, t.prototype.hide = function(n) {
        function i() {
            "in" != s.hoverState && r.detach(), s.$element.removeAttr("aria-describedby").trigger("hidden.bs." + s.type), n && n()
        }
        var s = this,
            r = e(this.$tip),
            o = e.Event("hide.bs." + this.type);
        if (this.$element.trigger(o), !o.isDefaultPrevented()) return r.removeClass("in"), e.support.transition && r.hasClass("fade") ? r.one("bsTransitionEnd", i).emulateTransitionEnd(t.TRANSITION_DURATION) : i(), this.hoverState = null, this
    }, t.prototype.fixTitle = function() {
        var e = this.$element;
        (e.attr("title") || "string" != typeof e.attr("data-original-title")) && e.attr("data-original-title", e.attr("title") || "").attr("title", "")
    }, t.prototype.hasContent = function() {
        return this.getTitle()
    }, t.prototype.getPosition = function(t) {
        var n = (t = t || this.$element)[0],
            i = "BODY" == n.tagName,
            s = n.getBoundingClientRect();
        null == s.width && (s = e.extend({}, s, {
            width: s.right - s.left,
            height: s.bottom - s.top
        }));
        var r = i ? {
                top: 0,
                left: 0
            } : t.offset(),
            o = {
                scroll: i ? document.documentElement.scrollTop || document.body.scrollTop : t.scrollTop()
            },
            a = i ? {
                width: e(window).width(),
                height: e(window).height()
            } : null;
        return e.extend({}, s, o, a, r)
    }, t.prototype.getCalculatedOffset = function(e, t, n, i) {
        return "bottom" == e ? {
            top: t.top + t.height,
            left: t.left + t.width / 2 - n / 2
        } : "top" == e ? {
            top: t.top - i,
            left: t.left + t.width / 2 - n / 2
        } : "left" == e ? {
            top: t.top + t.height / 2 - i / 2,
            left: t.left - n
        } : {
            top: t.top + t.height / 2 - i / 2,
            left: t.left + t.width
        }
    }, t.prototype.getViewportAdjustedDelta = function(e, t, n, i) {
        var s = {
            top: 0,
            left: 0
        };
        if (!this.$viewport) return s;
        var r = this.options.viewport && this.options.viewport.padding || 0,
            o = this.getPosition(this.$viewport);
        if (/right|left/.test(e)) {
            var a = t.top - r - o.scroll,
                l = t.top + r - o.scroll + i;
            a < o.top ? s.top = o.top - a : l > o.top + o.height && (s.top = o.top + o.height - l)
        } else {
            var c = t.left - r,
                d = t.left + r + n;
            c < o.left ? s.left = o.left - c : d > o.right && (s.left = o.left + o.width - d)
        }
        return s
    }, t.prototype.getTitle = function() {
        var e = this.$element,
            t = this.options;
        return e.attr("data-original-title") || ("function" == typeof t.title ? t.title.call(e[0]) : t.title)
    }, t.prototype.getUID = function(e) {
        do {
            e += ~~(1e6 * Math.random())
        } while (document.getElementById(e));
        return e
    }, t.prototype.tip = function() {
        if (!this.$tip && (this.$tip = e(this.options.template), 1 != this.$tip.length)) throw new Error(this.type + " `template` option must consist of exactly 1 top-level element!");
        return this.$tip
    }, t.prototype.arrow = function() {
        return this.$arrow = this.$arrow || this.tip().find(".tooltip-arrow")
    }, t.prototype.enable = function() {
        this.enabled = !0
    }, t.prototype.disable = function() {
        this.enabled = !1
    }, t.prototype.toggleEnabled = function() {
        this.enabled = !this.enabled
    }, t.prototype.toggle = function(t) {
        var n = this;
        t && ((n = e(t.currentTarget).data("bs." + this.type)) || (n = new this.constructor(t.currentTarget, this.getDelegateOptions()), e(t.currentTarget).data("bs." + this.type, n))), t ? (n.inState.click = !n.inState.click, n.isInStateTrue() ? n.enter(n) : n.leave(n)) : n.tip().hasClass("in") ? n.leave(n) : n.enter(n)
    }, t.prototype.destroy = function() {
        var e = this;
        clearTimeout(this.timeout), this.hide(function() {
            e.$element.off("." + e.type).removeData("bs." + e.type), e.$tip && e.$tip.detach(), e.$tip = null, e.$arrow = null, e.$viewport = null
        })
    };
    var n = e.fn.tooltip;
    e.fn.tooltip = function(n) {
        return this.each(function() {
            var i = e(this),
                s = i.data("bs.tooltip"),
                r = "object" == typeof n && n;
            !s && /destroy|hide/.test(n) || (s || i.data("bs.tooltip", s = new t(this, r)), "string" == typeof n && s[n]())
        })
    }, e.fn.tooltip.Constructor = t, e.fn.tooltip.noConflict = function() {
        return e.fn.tooltip = n, this
    }
}(jQuery),
function(e) {
    "use strict";
    var t = '[data-dismiss="alert"]',
        n = function(n) {
            e(n).on("click", t, this.close)
        };
    n.VERSION = "3.3.6", n.TRANSITION_DURATION = 150, n.prototype.close = function(t) {
        function i() {
            o.detach().trigger("closed.bs.alert").remove()
        }
        var s = e(this),
            r = s.attr("data-target");
        r || (r = (r = s.attr("href")) && r.replace(/.*(?=#[^\s]*$)/, ""));
        var o = e(r);
        t && t.preventDefault(), o.length || (o = s.closest(".alert")), o.trigger(t = e.Event("close.bs.alert")), t.isDefaultPrevented() || (o.removeClass("in"), e.support.transition && o.hasClass("fade") ? o.one("bsTransitionEnd", i).emulateTransitionEnd(n.TRANSITION_DURATION) : i())
    };
    var i = e.fn.alert;
    e.fn.alert = function(t) {
        return this.each(function() {
            var i = e(this),
                s = i.data("bs.alert");
            s || i.data("bs.alert", s = new n(this)), "string" == typeof t && s[t].call(i)
        })
    }, e.fn.alert.Constructor = n, e.fn.alert.noConflict = function() {
        return e.fn.alert = i, this
    }, e(document).on("click.bs.alert.data-api", t, n.prototype.close)
}(jQuery),
function(e) {
    "use strict";

    function t(t) {
        var n, i = t.attr("data-target") || (n = t.attr("href")) && n.replace(/.*(?=#[^\s]+$)/, "");
        return e(i)
    }

    function n(t) {
        return this.each(function() {
            var n = e(this),
                s = n.data("bs.collapse"),
                r = e.extend({}, i.DEFAULTS, n.data(), "object" == typeof t && t);
            !s && r.toggle && /show|hide/.test(t) && (r.toggle = !1), s || n.data("bs.collapse", s = new i(this, r)), "string" == typeof t && s[t]()
        })
    }
    var i = function(t, n) {
        this.$element = e(t), this.options = e.extend({}, i.DEFAULTS, n), this.$trigger = e('[data-toggle="collapse"][href="#' + t.id + '"],[data-toggle="collapse"][data-target="#' + t.id + '"]'), this.transitioning = null, this.options.parent ? this.$parent = this.getParent() : this.addAriaAndCollapsedClass(this.$element, this.$trigger), this.options.toggle && this.toggle()
    };
    i.VERSION = "3.3.6", i.TRANSITION_DURATION = 350, i.DEFAULTS = {
        toggle: !0
    }, i.prototype.dimension = function() {
        return this.$element.hasClass("width") ? "width" : "height"
    }, i.prototype.show = function() {
        if (!this.transitioning && !this.$element.hasClass("in")) {
            var t, s = this.$parent && this.$parent.children(".panel").children(".in, .collapsing");
            if (!(s && s.length && (t = s.data("bs.collapse")) && t.transitioning)) {
                var r = e.Event("show.bs.collapse");
                if (this.$element.trigger(r), !r.isDefaultPrevented()) {
                    s && s.length && (n.call(s, "hide"), t || s.data("bs.collapse", null));
                    var o = this.dimension();
                    this.$element.removeClass("collapse").addClass("collapsing")[o](0).attr("aria-expanded", !0), this.$trigger.removeClass("collapsed").attr("aria-expanded", !0), this.transitioning = 1;
                    var a = function() {
                        this.$element.removeClass("collapsing").addClass("collapse in")[o](""), this.transitioning = 0, this.$element.trigger("shown.bs.collapse")
                    };
                    if (!e.support.transition) return a.call(this);
                    var l = e.camelCase(["scroll", o].join("-"));
                    this.$element.one("bsTransitionEnd", e.proxy(a, this)).emulateTransitionEnd(i.TRANSITION_DURATION)[o](this.$element[0][l])
                }
            }
        }
    }, i.prototype.hide = function() {
        if (!this.transitioning && this.$element.hasClass("in")) {
            var t = e.Event("hide.bs.collapse");
            if (this.$element.trigger(t), !t.isDefaultPrevented()) {
                var n = this.dimension();
                this.$element[n](this.$element[n]())[0].offsetHeight, this.$element.addClass("collapsing").removeClass("collapse in").attr("aria-expanded", !1), this.$trigger.addClass("collapsed").attr("aria-expanded", !1), this.transitioning = 1;
                var s = function() {
                    this.transitioning = 0, this.$element.removeClass("collapsing").addClass("collapse").trigger("hidden.bs.collapse")
                };
                if (!e.support.transition) return s.call(this);
                this.$element[n](0).one("bsTransitionEnd", e.proxy(s, this)).emulateTransitionEnd(i.TRANSITION_DURATION)
            }
        }
    }, i.prototype.toggle = function() {
        this[this.$element.hasClass("in") ? "hide" : "show"]()
    }, i.prototype.getParent = function() {
        return e(this.options.parent).find('[data-toggle="collapse"][data-parent="' + this.options.parent + '"]').each(e.proxy(function(n, i) {
            var s = e(i);
            this.addAriaAndCollapsedClass(t(s), s)
        }, this)).end()
    }, i.prototype.addAriaAndCollapsedClass = function(e, t) {
        var n = e.hasClass("in");
        e.attr("aria-expanded", n), t.toggleClass("collapsed", !n).attr("aria-expanded", n)
    };
    var s = e.fn.collapse;
    e.fn.collapse = n, e.fn.collapse.Constructor = i, e.fn.collapse.noConflict = function() {
        return e.fn.collapse = s, this
    }, e(document).on("click.bs.collapse.data-api", '[data-toggle="collapse"]', function(i) {
        var s = e(this);
        s.attr("data-target") || i.preventDefault();
        var r = t(s),
            o = r.data("bs.collapse") ? "toggle" : s.data();
        n.call(r, o)
    })
}(jQuery),
function(e) {
    "use strict";

    function t(t) {
        var n = t.attr("data-target");
        n || (n = (n = t.attr("href")) && /#[A-Za-z]/.test(n) && n.replace(/.*(?=#[^\s]*$)/, ""));
        var i = n && e(n);
        return i && i.length ? i : t.parent()
    }

    function n(n) {
        n && 3 === n.which || (e(i).remove(), e(s).each(function() {
            var i = e(this),
                s = t(i),
                r = {
                    relatedTarget: this
                };
            s.hasClass("open") && (n && "click" == n.type && /input|textarea/i.test(n.target.tagName) && e.contains(s[0], n.target) || (s.trigger(n = e.Event("hide.bs.dropdown", r)), n.isDefaultPrevented() || (i.attr("aria-expanded", "false"), s.removeClass("open").trigger(e.Event("hidden.bs.dropdown", r)))))
        }))
    }
    var i = ".dropdown-backdrop",
        s = '[data-toggle="dropdown"]',
        r = function(t) {
            e(t).on("click.bs.dropdown", this.toggle)
        };
    r.VERSION = "3.3.6", r.prototype.toggle = function(i) {
        var s = e(this);
        if (!s.is(".disabled, :disabled")) {
            var r = t(s),
                o = r.hasClass("open");
            if (n(), !o) {
                "ontouchstart" in document.documentElement && !r.closest(".navbar-nav").length && e(document.createElement("div")).addClass("dropdown-backdrop").insertAfter(e(this)).on("click", n);
                var a = {
                    relatedTarget: this
                };
                if (r.trigger(i = e.Event("show.bs.dropdown", a)), i.isDefaultPrevented()) return;
                s.trigger("focus").attr("aria-expanded", "true"), r.toggleClass("open").trigger(e.Event("shown.bs.dropdown", a))
            }
            return !1
        }
    }, r.prototype.keydown = function(n) {
        if (/(38|40|27|32)/.test(n.which) && !/input|textarea/i.test(n.target.tagName)) {
            var i = e(this);
            if (n.preventDefault(), n.stopPropagation(), !i.is(".disabled, :disabled")) {
                var r = t(i),
                    o = r.hasClass("open");
                if (!o && 27 != n.which || o && 27 == n.which) return 27 == n.which && r.find(s).trigger("focus"), i.trigger("click");
                var a = r.find(".dropdown-menu li:not(.disabled):visible a");
                if (a.length) {
                    var l = a.index(n.target);
                    38 == n.which && l > 0 && l--, 40 == n.which && l < a.length - 1 && l++, ~l || (l = 0), a.eq(l).trigger("focus")
                }
            }
        }
    };
    var o = e.fn.dropdown;
    e.fn.dropdown = function(t) {
        return this.each(function() {
            var n = e(this),
                i = n.data("bs.dropdown");
            i || n.data("bs.dropdown", i = new r(this)), "string" == typeof t && i[t].call(n)
        })
    }, e.fn.dropdown.Constructor = r, e.fn.dropdown.noConflict = function() {
        return e.fn.dropdown = o, this
    }, e(document).on("click.bs.dropdown.data-api", n).on("click.bs.dropdown.data-api", ".dropdown form", function(e) {
        e.stopPropagation()
    }).on("click.bs.dropdown.data-api", s, r.prototype.toggle).on("keydown.bs.dropdown.data-api", s, r.prototype.keydown).on("keydown.bs.dropdown.data-api", ".dropdown-menu", r.prototype.keydown)
}(jQuery),
function(e) {
    "use strict";

    function t(t, i) {
        return this.each(function() {
            var s = e(this),
                r = s.data("bs.modal"),
                o = e.extend({}, n.DEFAULTS, s.data(), "object" == typeof t && t);
            r || s.data("bs.modal", r = new n(this, o)), "string" == typeof t ? r[t](i) : o.show && r.show(i)
        })
    }
    var n = function(t, n) {
        this.options = n, this.$body = e(document.body), this.$element = e(t), this.$dialog = this.$element.find(".modal-dialog"), this.$backdrop = null, this.isShown = null, this.originalBodyPad = null, this.scrollbarWidth = 0, this.ignoreBackdropClick = !1, this.options.remote && this.$element.find(".modal-content").load(this.options.remote, e.proxy(function() {
            this.$element.trigger("loaded.bs.modal")
        }, this))
    };
    n.VERSION = "3.3.6", n.TRANSITION_DURATION = 300, n.BACKDROP_TRANSITION_DURATION = 150, n.DEFAULTS = {
        backdrop: !0,
        keyboard: !0,
        show: !0
    }, n.prototype.toggle = function(e) {
        return this.isShown ? this.hide() : this.show(e)
    }, n.prototype.show = function(t) {
        var i = this,
            s = e.Event("show.bs.modal", {
                relatedTarget: t
            });
        this.$element.trigger(s), this.isShown || s.isDefaultPrevented() || (this.isShown = !0, this.checkScrollbar(), this.setScrollbar(), this.$body.addClass("modal-open"), this.escape(), this.resize(), this.$element.on("click.dismiss.bs.modal", '[data-dismiss="modal"]', e.proxy(this.hide, this)), this.$dialog.on("mousedown.dismiss.bs.modal", function() {
            i.$element.one("mouseup.dismiss.bs.modal", function(t) {
                e(t.target).is(i.$element) && (i.ignoreBackdropClick = !0)
            })
        }), this.backdrop(function() {
            var s = e.support.transition && i.$element.hasClass("fade");
            i.$element.parent().length || i.$element.appendTo(i.$body), i.$element.show().scrollTop(0), i.adjustDialog(), s && i.$element[0].offsetWidth, i.$element.addClass("in"), i.enforceFocus();
            var r = e.Event("shown.bs.modal", {
                relatedTarget: t
            });
            s ? i.$dialog.one("bsTransitionEnd", function() {
                i.$element.trigger("focus").trigger(r)
            }).emulateTransitionEnd(n.TRANSITION_DURATION) : i.$element.trigger("focus").trigger(r)
        }))
    }, n.prototype.hide = function(t) {
        t && t.preventDefault(), t = e.Event("hide.bs.modal"), this.$element.trigger(t), this.isShown && !t.isDefaultPrevented() && (this.isShown = !1, this.escape(), this.resize(), e(document).off("focusin.bs.modal"), this.$element.removeClass("in").off("click.dismiss.bs.modal").off("mouseup.dismiss.bs.modal"), this.$dialog.off("mousedown.dismiss.bs.modal"), e.support.transition && this.$element.hasClass("fade") ? this.$element.one("bsTransitionEnd", e.proxy(this.hideModal, this)).emulateTransitionEnd(n.TRANSITION_DURATION) : this.hideModal())
    }, n.prototype.enforceFocus = function() {
        e(document).off("focusin.bs.modal").on("focusin.bs.modal", e.proxy(function(e) {
            this.$element[0] === e.target || this.$element.has(e.target).length || this.$element.trigger("focus")
        }, this))
    }, n.prototype.escape = function() {
        this.isShown && this.options.keyboard ? this.$element.on("keydown.dismiss.bs.modal", e.proxy(function(e) {
            27 == e.which && this.hide()
        }, this)) : this.isShown || this.$element.off("keydown.dismiss.bs.modal")
    }, n.prototype.resize = function() {
        this.isShown ? e(window).on("resize.bs.modal", e.proxy(this.handleUpdate, this)) : e(window).off("resize.bs.modal")
    }, n.prototype.hideModal = function() {
        var e = this;
        this.$element.hide(), this.backdrop(function() {
            e.$body.removeClass("modal-open"), e.resetAdjustments(), e.resetScrollbar(), e.$element.trigger("hidden.bs.modal")
        })
    }, n.prototype.removeBackdrop = function() {
        this.$backdrop && this.$backdrop.remove(), this.$backdrop = null
    }, n.prototype.backdrop = function(t) {
        var i = this,
            s = this.$element.hasClass("fade") ? "fade" : "";
        if (this.isShown && this.options.backdrop) {
            var r = e.support.transition && s;
            if (this.$backdrop = e(document.createElement("div")).addClass("modal-backdrop " + s).appendTo(this.$body), this.$element.on("click.dismiss.bs.modal", e.proxy(function(e) {
                    this.ignoreBackdropClick ? this.ignoreBackdropClick = !1 : e.target === e.currentTarget && ("static" == this.options.backdrop ? this.$element[0].focus() : this.hide())
                }, this)), r && this.$backdrop[0].offsetWidth, this.$backdrop.addClass("in"), !t) return;
            r ? this.$backdrop.one("bsTransitionEnd", t).emulateTransitionEnd(n.BACKDROP_TRANSITION_DURATION) : t()
        } else if (!this.isShown && this.$backdrop) {
            this.$backdrop.removeClass("in");
            var o = function() {
                i.removeBackdrop(), t && t()
            };
            e.support.transition && this.$element.hasClass("fade") ? this.$backdrop.one("bsTransitionEnd", o).emulateTransitionEnd(n.BACKDROP_TRANSITION_DURATION) : o()
        } else t && t()
    }, n.prototype.handleUpdate = function() {
        this.adjustDialog()
    }, n.prototype.adjustDialog = function() {
        var e = this.$element[0].scrollHeight > document.documentElement.clientHeight;
        this.$element.css({
            paddingLeft: !this.bodyIsOverflowing && e ? this.scrollbarWidth : "",
            paddingRight: this.bodyIsOverflowing && !e ? this.scrollbarWidth : ""
        })
    }, n.prototype.resetAdjustments = function() {
        this.$element.css({
            paddingLeft: "",
            paddingRight: ""
        })
    }, n.prototype.checkScrollbar = function() {
        var e = window.innerWidth;
        if (!e) {
            var t = document.documentElement.getBoundingClientRect();
            e = t.right - Math.abs(t.left)
        }
        this.bodyIsOverflowing = document.body.clientWidth < e, this.scrollbarWidth = this.measureScrollbar()
    }, n.prototype.setScrollbar = function() {
        var e = parseInt(this.$body.css("padding-right") || 0, 10);
        this.originalBodyPad = document.body.style.paddingRight || "", this.bodyIsOverflowing && this.$body.css("padding-right", e + this.scrollbarWidth)
    }, n.prototype.resetScrollbar = function() {
        this.$body.css("padding-right", this.originalBodyPad)
    }, n.prototype.measureScrollbar = function() {
        var e = document.createElement("div");
        e.className = "modal-scrollbar-measure", this.$body.append(e);
        var t = e.offsetWidth - e.clientWidth;
        return this.$body[0].removeChild(e), t
    };
    var i = e.fn.modal;
    e.fn.modal = t, e.fn.modal.Constructor = n, e.fn.modal.noConflict = function() {
        return e.fn.modal = i, this
    }, e(document).on("click.bs.modal.data-api", '[data-toggle="modal"]', function(n) {
        var i = e(this),
            s = i.attr("href"),
            r = e(i.attr("data-target") || s && s.replace(/.*(?=#[^\s]+$)/, "")),
            o = r.data("bs.modal") ? "toggle" : e.extend({
                remote: !/#/.test(s) && s
            }, r.data(), i.data());
        i.is("a") && n.preventDefault(), r.one("show.bs.modal", function(e) {
            e.isDefaultPrevented() || r.one("hidden.bs.modal", function() {
                i.is(":visible") && i.trigger("focus")
            })
        }), t.call(r, o, this)
    })
}(jQuery),
function(e) {
    "use strict";
    var t = function(e, t) {
        this.init("popover", e, t)
    };
    if (!e.fn.tooltip) throw new Error("Popover requires tooltip.js");
    t.VERSION = "3.3.7", t.DEFAULTS = e.extend({}, e.fn.tooltip.Constructor.DEFAULTS, {
        placement: "right",
        trigger: "click",
        content: "",
        template: '<div class="popover" role="tooltip"><div class="arrow"></div><h3 class="popover-title"></h3><div class="popover-content"></div></div>'
    }), t.prototype = e.extend({}, e.fn.tooltip.Constructor.prototype), t.prototype.constructor = t, t.prototype.getDefaults = function() {
        return t.DEFAULTS
    }, t.prototype.setContent = function() {
        var e = this.tip(),
            t = this.getTitle(),
            n = this.getContent();
        e.find(".popover-title")[this.options.html ? "html" : "text"](t), e.find(".popover-content").children().detach().end()[this.options.html ? "string" == typeof n ? "html" : "append" : "text"](n), e.removeClass("fade top bottom left right in"), e.find(".popover-title").html() || e.find(".popover-title").hide()
    }, t.prototype.hasContent = function() {
        return this.getTitle() || this.getContent()
    }, t.prototype.getContent = function() {
        var e = this.$element,
            t = this.options;
        return e.attr("data-content") || ("function" == typeof t.content ? t.content.call(e[0]) : t.content)
    }, t.prototype.arrow = function() {
        return this.$arrow = this.$arrow || this.tip().find(".arrow")
    };
    var n = e.fn.popover;
    e.fn.popover = function(n) {
        return this.each(function() {
            var i = e(this),
                s = i.data("bs.popover"),
                r = "object" == typeof n && n;
            !s && /destroy|hide/.test(n) || (s || i.data("bs.popover", s = new t(this, r)), "string" == typeof n && s[n]())
        })
    }, e.fn.popover.Constructor = t, e.fn.popover.noConflict = function() {
        return e.fn.popover = n, this
    }
}(jQuery),
function(e) {
    "use strict";

    function t(t) {
        return this.each(function() {
            var i = e(this),
                s = i.data("bs.tab");
            s || i.data("bs.tab", s = new n(this)), "string" == typeof t && s[t]()
        })
    }
    var n = function(t) {
        this.element = e(t)
    };
    n.VERSION = "3.3.6", n.TRANSITION_DURATION = 150, n.prototype.show = function() {
        var t = this.element,
            n = t.closest("ul:not(.dropdown-menu)"),
            i = t.data("target");
        if (i || (i = (i = t.attr("href")) && i.replace(/.*(?=#[^\s]*$)/, "")), !t.parent("li").hasClass("active")) {
            var s = n.find(".active:last a"),
                r = e.Event("hide.bs.tab", {
                    relatedTarget: t[0]
                }),
                o = e.Event("show.bs.tab", {
                    relatedTarget: s[0]
                });
            if (s.trigger(r), t.trigger(o), !o.isDefaultPrevented() && !r.isDefaultPrevented()) {
                var a = e(i);
                this.activate(t.closest("li"), n), this.activate(a, a.parent(), function() {
                    s.trigger({
                        type: "hidden.bs.tab",
                        relatedTarget: t[0]
                    }), t.trigger({
                        type: "shown.bs.tab",
                        relatedTarget: s[0]
                    })
                })
            }
        }
    }, n.prototype.activate = function(t, i, s) {
        function r() {
            o.removeClass("active").find("> .dropdown-menu > .active").removeClass("active").end().find('[data-toggle="tab"]').attr("aria-expanded", !1), t.addClass("active").find('[data-toggle="tab"]').attr("aria-expanded", !0), a ? (t[0].offsetWidth, t.addClass("in")) : t.removeClass("fade"), t.parent(".dropdown-menu").length && t.closest("li.dropdown").addClass("active").end().find('[data-toggle="tab"]').attr("aria-expanded", !0), s && s()
        }
        var o = i.find("> .active"),
            a = s && e.support.transition && (o.length && o.hasClass("fade") || !!i.find("> .fade").length);
        o.length && a ? o.one("bsTransitionEnd", r).emulateTransitionEnd(n.TRANSITION_DURATION) : r(), o.removeClass("in")
    };
    var i = e.fn.tab;
    e.fn.tab = t, e.fn.tab.Constructor = n, e.fn.tab.noConflict = function() {
        return e.fn.tab = i, this
    };
    var s = function(n) {
        n.preventDefault(), t.call(e(this), "show")
    };
    e(document).on("click.bs.tab.data-api", '[data-toggle="tab"]', s).on("click.bs.tab.data-api", '[data-toggle="pill"]', s)
}(jQuery),
function(e) {
    "use strict";
    e.fn.emulateTransitionEnd = function(t) {
        var n = !1,
            i = this;
        e(this).one("bsTransitionEnd", function() {
            n = !0
        });
        return setTimeout(function() {
            n || e(i).trigger(e.support.transition.end)
        }, t), this
    }, e(function() {
        e.support.transition = function() {
            var e = document.createElement("bootstrap"),
                t = {
                    WebkitTransition: "webkitTransitionEnd",
                    MozTransition: "transitionend",
                    OTransition: "oTransitionEnd otransitionend",
                    transition: "transitionend"
                };
            for (var n in t)
                if (void 0 !== e.style[n]) return {
                    end: t[n]
                };
            return !1
        }(), e.support.transition && (e.event.special.bsTransitionEnd = {
            bindType: e.support.transition.end,
            delegateType: e.support.transition.end,
            handle: function(t) {
                if (e(t.target).is(this)) return t.handleObj.handler.apply(this, arguments)
            }
        })
    })
}(jQuery),
function(e, t) {
    "use strict";
    "function" == typeof define && define.amd ? define(["jquery"], t) : "object" == typeof exports ? module.exports = t(require("jquery")) : e.bootbox = t(e.jQuery)
}(this, function e(t, n) {
    "use strict";

    function i(e) {
        var t = _[g.locale];
        return t ? t[e] : _.en[e]
    }

    function s(e, n, i) {
        e.stopPropagation(), e.preventDefault();
        t.isFunction(i) && !1 === i.call(n, e) || n.modal("hide")
    }

    function r(e, n) {
        var i = 0;
        t.each(e, function(e, t) {
            n(e, t, i++)
        })
    }

    function o(e, n, i) {
        return t.extend(!0, {}, e, function(e, t) {
            var n = e.length,
                i = {};
            if (n < 1 || n > 2) throw new Error("Invalid argument length");
            return 2 === n || "string" == typeof e[0] ? (i[t[0]] = e[0], i[t[1]] = e[1]) : i = e[0], i
        }(n, i))
    }

    function a(e, t, n, i) {
        return c(o({
            className: "bootbox-" + e,
            buttons: l.apply(null, t)
        }, i, n), t)
    }

    function l() {
        for (var e = {}, t = 0, n = arguments.length; t < n; t++) {
            var s = arguments[t],
                r = s.toLowerCase(),
                o = s.toUpperCase();
            e[r] = {
                label: i(o)
            }
        }
        return e
    }

    function c(e, t) {
        var i = {};
        return r(t, function(e, t) {
            i[t] = !0
        }), r(e.buttons, function(e) {
            if (i[e] === n) throw new Error("button key " + e + " is not allowed (options are " + t.join("\n") + ")")
        }), e
    }
    var d = "<div class='bootbox modal' tabindex='-1' role='dialog'><div class='modal-dialog'><div class='modal-content'><div class='modal-body'><div class='bootbox-body'></div></div></div></div></div>",
        u = "<div class='modal-header'><h4 class='modal-title'></h4></div>",
        h = "<div class='modal-footer'></div>",
        p = "<button type='button' class='bootbox-close-button close' data-dismiss='modal' aria-hidden='true'>&times;</button>",
        f = "<form class='bootbox-form'></form>",
        m = {
            text: "<input class='bootbox-input bootbox-input-text form-control' autocomplete=off type=text />",
            textarea: "<textarea class='bootbox-input bootbox-input-textarea form-control'></textarea>",
            email: "<input class='bootbox-input bootbox-input-email form-control' autocomplete='off' type='email' />",
            select: "<select class='bootbox-input bootbox-input-select form-control'></select>",
            checkbox: "<div class='checkbox'><label><input class='bootbox-input bootbox-input-checkbox' type='checkbox' /></label></div>",
            date: "<input class='bootbox-input bootbox-input-date form-control' autocomplete=off type='date' />",
            time: "<input class='bootbox-input bootbox-input-time form-control' autocomplete=off type='time' />",
            number: "<input class='bootbox-input bootbox-input-number form-control' autocomplete=off type='number' />",
            password: "<input class='bootbox-input bootbox-input-password form-control' autocomplete='off' type='password' />"
        },
        g = {
            locale: "en",
            backdrop: "static",
            animate: !0,
            className: null,
            closeButton: !0,
            show: !0,
            container: "body"
        },
        v = {};
    v.alert = function() {
        var e;
        if ((e = a("alert", ["ok"], ["message", "callback"], arguments)).callback && !t.isFunction(e.callback)) throw new Error("alert requires callback property to be a function when provided");
        return e.buttons.ok.callback = e.onEscape = function() {
            return !t.isFunction(e.callback) || e.callback.call(this)
        }, v.dialog(e)
    }, v.confirm = function() {
        var e;
        if (e = a("confirm", ["cancel", "confirm"], ["message", "callback"], arguments), e.buttons.cancel.callback = e.onEscape = function() {
                return e.callback.call(this, !1)
            }, e.buttons.confirm.callback = function() {
                return e.callback.call(this, !0)
            }, !t.isFunction(e.callback)) throw new Error("confirm requires a callback");
        return v.dialog(e)
    }, v.prompt = function() {
        var e, i, s, a, d, u, h;
        if (a = t(f), i = {
                className: "bootbox-prompt",
                buttons: l("cancel", "confirm"),
                value: "",
                inputType: "text"
            }, e = c(o(i, arguments, ["title", "callback"]), ["cancel", "confirm"]), u = e.show === n || e.show, e.message = a, e.buttons.cancel.callback = e.onEscape = function() {
                return e.callback.call(this, null)
            }, e.buttons.confirm.callback = function() {
                var n;
                switch (e.inputType) {
                    case "text":
                    case "textarea":
                    case "email":
                    case "select":
                    case "date":
                    case "time":
                    case "number":
                    case "password":
                        n = d.val();
                        break;
                    case "checkbox":
                        var i = d.find("input:checked");
                        n = [], r(i, function(e, i) {
                            n.push(t(i).val())
                        })
                }
                return e.callback.call(this, n)
            }, e.show = !1, !e.title) throw new Error("prompt requires a title");
        if (!t.isFunction(e.callback)) throw new Error("prompt requires a callback");
        if (!m[e.inputType]) throw new Error("invalid prompt type");
        switch (d = t(m[e.inputType]), e.inputType) {
            case "text":
            case "textarea":
            case "email":
            case "date":
            case "time":
            case "number":
            case "password":
                d.val(e.value);
                break;
            case "select":
                var p = {};
                if (h = e.inputOptions || [], !t.isArray(h)) throw new Error("Please pass an array of input options");
                if (!h.length) throw new Error("prompt with select requires options");
                r(h, function(e, i) {
                    var s = d;
                    if (i.value === n || i.text === n) throw new Error("given options in wrong format");
                    i.group && (p[i.group] || (p[i.group] = t("<optgroup/>").attr("label", i.group)), s = p[i.group]), s.append("<option value='" + i.value + "'>" + i.text + "</option>")
                }), r(p, function(e, t) {
                    d.append(t)
                }), d.val(e.value);
                break;
            case "checkbox":
                var g = t.isArray(e.value) ? e.value : [e.value];
                if (!(h = e.inputOptions || []).length) throw new Error("prompt with checkbox requires options");
                if (!h[0].value || !h[0].text) throw new Error("given options in wrong format");
                d = t("<div/>"), r(h, function(n, i) {
                    var s = t(m[e.inputType]);
                    s.find("input").attr("value", i.value), s.find("label").append(i.text), r(g, function(e, t) {
                        t === i.value && s.find("input").prop("checked", !0)
                    }), d.append(s)
                })
        }
        return e.placeholder && d.attr("placeholder", e.placeholder), e.pattern && d.attr("pattern", e.pattern), e.maxlength && d.attr("maxlength", e.maxlength), a.append(d), a.on("submit", function(e) {
            e.preventDefault(), e.stopPropagation(), s.find(".btn-primary").click()
        }), (s = v.dialog(e)).off("shown.bs.modal"), s.on("shown.bs.modal", function() {
            d.focus()
        }), !0 === u && s.modal("show"), s
    }, v.dialog = function(e) {
        e = function(e) {
            var n, i;
            if ("object" != typeof e) throw new Error("Please supply an object of options");
            if (!e.message) throw new Error("Please specify a message");
            return (e = t.extend({}, g, e)).buttons || (e.buttons = {}), n = e.buttons, i = function(e) {
                var t, n = 0;
                for (t in e) n++;
                return n
            }(n), r(n, function(e, s, r) {
                if (t.isFunction(s) && (s = n[e] = {
                        callback: s
                    }), "object" !== t.type(s)) throw new Error("button with key " + e + " must be an object");
                s.label || (s.label = e), s.className || (s.className = i <= 2 && r === i - 1 ? "btn-primary" : "btn-default")
            }), e
        }(e);
        var i = t(d),
            o = i.find(".modal-dialog"),
            a = i.find(".modal-body"),
            l = e.buttons,
            c = "",
            f = {
                onEscape: e.onEscape
            };
        if (t.fn.modal === n) throw new Error("$.fn.modal is not defined; please double check you have included the Bootstrap JavaScript library. See http://getbootstrap.com/javascript/ for more details.");
        if (r(l, function(e, t) {
                c += "<button data-bb-handler='" + e + "' type='button' class='btn " + t.className + "'>" + t.label + "</button>", f[e] = t.callback
            }), a.find(".bootbox-body").html(e.message), !0 === e.animate && i.addClass("fade"), e.className && i.addClass(e.className), "large" === e.size ? o.addClass("modal-lg") : "small" === e.size ? o.addClass("modal-sm") : "xlarge" === e.size && o.addClass("modal-xl"), e.title && a.before(u), e.closeButton) {
            var m = t(p);
            e.title ? i.find(".modal-header").prepend(m) : m.css("margin-top", "-10px").prependTo(a)
        }
        return e.title && i.find(".modal-title").html(e.title), c.length && (a.after(h), i.find(".modal-footer").html(c)), i.on("hidden.bs.modal", function(e) {
            e.target === this && i.remove()
        }), i.on("shown.bs.modal", function() {
            i.find(".btn-primary:first").focus()
        }), "static" !== e.backdrop && i.on("click.dismiss.bs.modal", function(e) {
            i.children(".modal-backdrop").length && (e.currentTarget = i.children(".modal-backdrop").get(0)), e.target === e.currentTarget && i.trigger("escape.close.bb")
        }), i.on("escape.close.bb", function(e) {
            f.onEscape && s(e, i, f.onEscape)
        }), i.on("click", ".modal-footer button", function(e) {
            var n = t(this).data("bb-handler");
            s(e, i, f[n])
        }), i.on("click", ".bootbox-close-button", function(e) {
            s(e, i, f.onEscape)
        }), i.on("keyup", function(e) {
            27 === e.which && i.trigger("escape.close.bb")
        }), t(e.container).append(i), i.modal({
            backdrop: !!e.backdrop && "static",
            keyboard: !1,
            show: !1
        }), e.show && i.modal("show"), i
    }, v.setDefaults = function() {
        var e = {};
        2 === arguments.length ? e[arguments[0]] = arguments[1] : e = arguments[0], t.extend(g, e)
    }, v.hideAll = function() {
        return t(".bootbox").modal("hide"), v
    };
    var _ = {
        bg_BG: {
            OK: "Ок",
            CANCEL: "Отказ",
            CONFIRM: "Потвърждавам"
        },
        br: {
            OK: "OK",
            CANCEL: "Cancelar",
            CONFIRM: "Sim"
        },
        cs: {
            OK: "OK",
            CANCEL: "Zrušit",
            CONFIRM: "Potvrdit"
        },
        da: {
            OK: "OK",
            CANCEL: "Annuller",
            CONFIRM: "Accepter"
        },
        de: {
            OK: "OK",
            CANCEL: "Abbrechen",
            CONFIRM: "Akzeptieren"
        },
        el: {
            OK: "Εντάξει",
            CANCEL: "Ακύρωση",
            CONFIRM: "Επιβεβαίωση"
        },
        en: {
            OK: "OK",
            CANCEL: "Cancel",
            CONFIRM: "OK"
        },
        es: {
            OK: "OK",
            CANCEL: "Cancelar",
            CONFIRM: "Aceptar"
        },
        et: {
            OK: "OK",
            CANCEL: "Katkesta",
            CONFIRM: "OK"
        },
        fa: {
            OK: "قبول",
            CANCEL: "لغو",
            CONFIRM: "تایید"
        },
        fi: {
            OK: "OK",
            CANCEL: "Peruuta",
            CONFIRM: "OK"
        },
        fr: {
            OK: "OK",
            CANCEL: "Annuler",
            CONFIRM: "D'accord"
        },
        he: {
            OK: "אישור",
            CANCEL: "ביטול",
            CONFIRM: "אישור"
        },
        hu: {
            OK: "OK",
            CANCEL: "Mégsem",
            CONFIRM: "Megerősít"
        },
        hr: {
            OK: "OK",
            CANCEL: "Odustani",
            CONFIRM: "Potvrdi"
        },
        id: {
            OK: "OK",
            CANCEL: "Batal",
            CONFIRM: "OK"
        },
        it: {
            OK: "OK",
            CANCEL: "Annulla",
            CONFIRM: "Conferma"
        },
        ja: {
            OK: "OK",
            CANCEL: "キャンセル",
            CONFIRM: "確認"
        },
        lt: {
            OK: "Gerai",
            CANCEL: "Atšaukti",
            CONFIRM: "Patvirtinti"
        },
        lv: {
            OK: "Labi",
            CANCEL: "Atcelt",
            CONFIRM: "Apstiprināt"
        },
        nl: {
            OK: "OK",
            CANCEL: "Annuleren",
            CONFIRM: "Accepteren"
        },
        no: {
            OK: "OK",
            CANCEL: "Avbryt",
            CONFIRM: "OK"
        },
        pl: {
            OK: "OK",
            CANCEL: "Anuluj",
            CONFIRM: "Potwierdź"
        },
        pt: {
            OK: "OK",
            CANCEL: "Cancelar",
            CONFIRM: "Confirmar"
        },
        ru: {
            OK: "OK",
            CANCEL: "Отмена",
            CONFIRM: "Применить"
        },
        sq: {
            OK: "OK",
            CANCEL: "Anulo",
            CONFIRM: "Prano"
        },
        sv: {
            OK: "OK",
            CANCEL: "Avbryt",
            CONFIRM: "OK"
        },
        th: {
            OK: "ตกลง",
            CANCEL: "ยกเลิก",
            CONFIRM: "ยืนยัน"
        },
        tr: {
            OK: "Tamam",
            CANCEL: "İptal",
            CONFIRM: "Onayla"
        },
        zh_CN: {
            OK: "OK",
            CANCEL: "取消",
            CONFIRM: "确认"
        },
        zh_TW: {
            OK: "OK",
            CANCEL: "取消",
            CONFIRM: "確認"
        }
    };
    return v.addLocale = function(e, n) {
        return t.each(["OK", "CANCEL", "CONFIRM"], function(e, t) {
            if (!n[t]) throw new Error("Please supply a translation for '" + t + "'")
        }), _[e] = {
            OK: n.OK,
            CANCEL: n.CANCEL,
            CONFIRM: n.CONFIRM
        }, v
    }, v.removeLocale = function(e) {
        return delete _[e], v
    }, v.setLocale = function(e) {
        return v.setDefaults("locale", e)
    }, v.init = function(n) {
        return e(n || t)
    }, v
}),
function(e) {
    "use strict";
    if ("function" == typeof define && define.amd) define(["jquery", "moment"], e);
    else if ("object" == typeof exports) module.exports = e(require("jquery"), require("moment"));
    else {
        if ("undefined" == typeof jQuery) throw "bootstrap-datetimepicker requires jQuery to be loaded first";
        if ("undefined" == typeof moment) throw "bootstrap-datetimepicker requires Moment.js to be loaded first";
        e(jQuery, moment)
    }
}(function(e, t) {
    "use strict";
    if (!t) throw new Error("bootstrap-datetimepicker requires Moment.js to be loaded first");
    var n = function(n, i) {
        var s, r, o, a, l, c, d, u = {},
            h = !0,
            p = !1,
            f = !1,
            m = 0,
            g = [{
                clsName: "days",
                navFnc: "M",
                navStep: 1
            }, {
                clsName: "months",
                navFnc: "y",
                navStep: 1
            }, {
                clsName: "years",
                navFnc: "y",
                navStep: 10
            }, {
                clsName: "decades",
                navFnc: "y",
                navStep: 100
            }],
            v = ["days", "months", "years", "decades"],
            _ = ["top", "bottom", "auto"],
            y = ["left", "right", "auto"],
            b = ["default", "top", "bottom"],
            w = {
                up: 38,
                38: "up",
                down: 40,
                40: "down",
                left: 37,
                37: "left",
                right: 39,
                39: "right",
                tab: 9,
                9: "tab",
                escape: 27,
                27: "escape",
                enter: 13,
                13: "enter",
                pageUp: 33,
                33: "pageUp",
                pageDown: 34,
                34: "pageDown",
                shift: 16,
                16: "shift",
                control: 17,
                17: "control",
                space: 32,
                32: "space",
                t: 84,
                84: "t",
                delete: 46,
                46: "delete"
            },
            x = {},
            k = function() {
                return void 0 !== t.tz && void 0 !== i.timeZone && null !== i.timeZone && "" !== i.timeZone
            },
            C = function(e) {
                var n;
                return n = void 0 === e || null === e ? t() : k() ? t.tz(e, c, i.useStrict, i.timeZone) : t(e, c, i.useStrict), k() && n.tz(i.timeZone), n
            },
            $ = function(e) {
                if ("string" != typeof e || e.length > 1) throw new TypeError("isEnabled expects a single character string parameter");
                switch (e) {
                    case "y":
                        return -1 !== l.indexOf("Y");
                    case "M":
                        return -1 !== l.indexOf("M");
                    case "d":
                        return -1 !== l.toLowerCase().indexOf("d");
                    case "h":
                    case "H":
                        return -1 !== l.toLowerCase().indexOf("h");
                    case "m":
                        return -1 !== l.indexOf("m");
                    case "s":
                        return -1 !== l.indexOf("s");
                    default:
                        return !1
                }
            },
            S = function() {
                return $("h") || $("m") || $("s")
            },
            T = function() {
                return $("y") || $("M") || $("d")
            },
            D = function() {
                var t = e("<div>").addClass("timepicker-hours").append(e("<table>").addClass("table-condensed")),
                    n = e("<div>").addClass("timepicker-minutes").append(e("<table>").addClass("table-condensed")),
                    s = e("<div>").addClass("timepicker-seconds").append(e("<table>").addClass("table-condensed")),
                    r = [function() {
                        var t = e("<tr>"),
                            n = e("<tr>"),
                            s = e("<tr>");
                        return $("h") && (t.append(e("<td>").append(e("<a>").attr({
                            href: "#",
                            tabindex: "-1",
                            title: i.tooltips.incrementHour
                        }).addClass("btn").attr("data-action", "incrementHours").append(e("<span>").addClass(i.icons.up)))), n.append(e("<td>").append(e("<span>").addClass("timepicker-hour").attr({
                            "data-time-component": "hours",
                            title: i.tooltips.pickHour
                        }).attr("data-action", "showHours"))), s.append(e("<td>").append(e("<a>").attr({
                            href: "#",
                            tabindex: "-1",
                            title: i.tooltips.decrementHour
                        }).addClass("btn").attr("data-action", "decrementHours").append(e("<span>").addClass(i.icons.down))))), $("m") && ($("h") && (t.append(e("<td>").addClass("separator")), n.append(e("<td>").addClass("separator").html(":")), s.append(e("<td>").addClass("separator"))), t.append(e("<td>").append(e("<a>").attr({
                            href: "#",
                            tabindex: "-1",
                            title: i.tooltips.incrementMinute
                        }).addClass("btn").attr("data-action", "incrementMinutes").append(e("<span>").addClass(i.icons.up)))), n.append(e("<td>").append(e("<span>").addClass("timepicker-minute").attr({
                            "data-time-component": "minutes",
                            title: i.tooltips.pickMinute
                        }).attr("data-action", "showMinutes"))), s.append(e("<td>").append(e("<a>").attr({
                            href: "#",
                            tabindex: "-1",
                            title: i.tooltips.decrementMinute
                        }).addClass("btn").attr("data-action", "decrementMinutes").append(e("<span>").addClass(i.icons.down))))), $("s") && ($("m") && (t.append(e("<td>").addClass("separator")), n.append(e("<td>").addClass("separator").html(":")), s.append(e("<td>").addClass("separator"))), t.append(e("<td>").append(e("<a>").attr({
                            href: "#",
                            tabindex: "-1",
                            title: i.tooltips.incrementSecond
                        }).addClass("btn").attr("data-action", "incrementSeconds").append(e("<span>").addClass(i.icons.up)))), n.append(e("<td>").append(e("<span>").addClass("timepicker-second").attr({
                            "data-time-component": "seconds",
                            title: i.tooltips.pickSecond
                        }).attr("data-action", "showSeconds"))), s.append(e("<td>").append(e("<a>").attr({
                            href: "#",
                            tabindex: "-1",
                            title: i.tooltips.decrementSecond
                        }).addClass("btn").attr("data-action", "decrementSeconds").append(e("<span>").addClass(i.icons.down))))), a || (t.append(e("<td>").addClass("separator")), n.append(e("<td>").append(e("<button>").addClass("btn btn-primary").attr({
                            "data-action": "togglePeriod",
                            tabindex: "-1",
                            title: i.tooltips.togglePeriod
                        }))), s.append(e("<td>").addClass("separator"))), e("<div>").addClass("timepicker-picker").append(e("<table>").addClass("table-condensed").append([t, n, s]))
                    }()];
                return $("h") && r.push(t), $("m") && r.push(n), $("s") && r.push(s), r
            },
            E = function() {
                var t = e("<div>").addClass("bootstrap-datetimepicker-widget dtp-dropdown-menu"),
                    n = e("<div>").addClass("datepicker").append(function() {
                        var t = e("<thead>").append(e("<tr>").append(e("<th>").addClass("prev").attr("data-action", "previous").append(e("<span>").addClass(i.icons.previous))).append(e("<th>").addClass("picker-switch").attr("data-action", "pickerSwitch").attr("colspan", i.calendarWeeks ? "6" : "5")).append(e("<th>").addClass("next").attr("data-action", "next").append(e("<span>").addClass(i.icons.next)))),
                            n = e("<tbody>").append(e("<tr>").append(e("<td>").attr("colspan", i.calendarWeeks ? "8" : "7")));
                        return [e("<div>").addClass("datepicker-days").append(e("<table>").addClass("table-condensed").append(t).append(e("<tbody>"))), e("<div>").addClass("datepicker-months").append(e("<table>").addClass("table-condensed").append(t.clone()).append(n.clone())), e("<div>").addClass("datepicker-years").append(e("<table>").addClass("table-condensed").append(t.clone()).append(n.clone())), e("<div>").addClass("datepicker-decades").append(e("<table>").addClass("table-condensed").append(t.clone()).append(n.clone()))]
                    }()),
                    s = e("<div>").addClass("timepicker").append(D()),
                    r = e("<ul>").addClass("list-unstyled"),
                    o = e("<li>").addClass("picker-switch" + (i.collapse ? " accordion-toggle" : "")).append(function() {
                        var t = [];
                        return i.showTodayButton && t.push(e("<td>").append(e("<a>").attr({
                            "data-action": "today",
                            title: i.tooltips.today
                        }).append(e("<span>").addClass(i.icons.today)))), !i.sideBySide && T() && S() && t.push(e("<td>").append(e("<a>").attr({
                            "data-action": "togglePicker",
                            title: i.tooltips.selectTime
                        }).append(e("<span>").addClass(i.icons.time)))), i.showClear && t.push(e("<td>").append(e("<a>").attr({
                            "data-action": "clear",
                            title: i.tooltips.clear
                        }).append(e("<span>").addClass(i.icons.clear)))), i.showClose && t.push(e("<td>").append(e("<a>").attr({
                            "data-action": "close",
                            title: i.tooltips.close
                        }).append(e("<span>").addClass(i.icons.close)))), e("<table>").addClass("table-condensed").append(e("<tbody>").append(e("<tr>").append(t)))
                    }());
                return i.inline && t.removeClass("dtp-dropdown-menu"), a && t.addClass("usetwentyfour"), $("s") && !a && t.addClass("wider"), i.sideBySide && T() && S() ? (t.addClass("timepicker-sbs"), "top" === i.toolbarPlacement && t.append(o), t.append(e("<div>").addClass("row").append(n.addClass("col-md-6")).append(s.addClass("col-md-6"))), "bottom" === i.toolbarPlacement && t.append(o), t) : ("top" === i.toolbarPlacement && r.append(o), T() && r.append(e("<li>").addClass(i.collapse && S() ? "collapse in" : "").append(n)), "default" === i.toolbarPlacement && r.append(o), S() && r.append(e("<li>").addClass(i.collapse && T() ? "collapse" : "").append(s)), "bottom" === i.toolbarPlacement && r.append(o), t.append(r))
            },
            P = function() {
                var t, s = (p || n).position(),
                    r = (p || n).offset(),
                    o = i.widgetPositioning.vertical,
                    a = i.widgetPositioning.horizontal;
                if (i.widgetParent) t = i.widgetParent.append(f);
                else if (n.is("input")) t = n.after(f).parent();
                else {
                    if (i.inline) return void(t = n.append(f));
                    t = n, n.children().first().after(f)
                }
                if ("auto" === o && (o = r.top + 1.5 * f.height() >= e(window).height() + e(window).scrollTop() && f.height() + n.outerHeight() < r.top ? "top" : "bottom"), "auto" === a && (a = t.width() < r.left + f.outerWidth() / 2 && r.left + f.outerWidth() > e(window).width() ? "right" : "left"), "top" === o ? f.addClass("top").removeClass("bottom") : f.addClass("bottom").removeClass("top"), "right" === a ? f.addClass("pull-right") : f.removeClass("pull-right"), "relative" !== t.css("position") && (t = t.parents().filter(function() {
                        return "relative" === e(this).css("position")
                    }).first()), 0 === t.length) throw new Error("datetimepicker component should be placed within a relative positioned container");
                f.css({
                    top: "top" === o ? "auto" : s.top + n.outerHeight(),
                    bottom: "top" === o ? t.outerHeight() - (t === n ? 0 : s.top) : "auto",
                    left: "left" === a ? t === n ? 0 : s.left : "auto",
                    right: "left" === a ? "auto" : t.outerWidth() - n.outerWidth() - (t === n ? 0 : s.left)
                })
            },
            O = function(e) {
                "dp.change" === e.type && (e.date && e.date.isSame(e.oldDate) || !e.date && !e.oldDate) || n.trigger(e)
            },
            M = function(e) {
                "y" === e && (e = "YYYY"), O({
                    type: "dp.update",
                    change: e,
                    viewDate: r.clone()
                })
            },
            N = function(e) {
                f && (e && (d = Math.max(m, Math.min(3, d + e))), f.find(".datepicker > div").hide().filter(".datepicker-" + g[d].clsName).show())
            },
            I = function(t, n) {
                if (!t.isValid()) return !1;
                if (i.disabledDates && "d" === n && function(e) {
                        return !0 === i.disabledDates[e.format("YYYY-MM-DD")]
                    }(t)) return !1;
                if (i.enabledDates && "d" === n && ! function(e) {
                        return !0 === i.enabledDates[e.format("YYYY-MM-DD")]
                    }(t)) return !1;
                if (i.minDate && t.isBefore(i.minDate, n)) return !1;
                if (i.maxDate && t.isAfter(i.maxDate, n)) return !1;
                if (i.daysOfWeekDisabled && "d" === n && -1 !== i.daysOfWeekDisabled.indexOf(t.day())) return !1;
                if (i.disabledHours && ("h" === n || "m" === n || "s" === n) && function(e) {
                        return !0 === i.disabledHours[e.format("H")]
                    }(t)) return !1;
                if (i.enabledHours && ("h" === n || "m" === n || "s" === n) && ! function(e) {
                        return !0 === i.enabledHours[e.format("H")]
                    }(t)) return !1;
                if (i.disabledTimeIntervals && ("h" === n || "m" === n || "s" === n)) {
                    var s = !1;
                    if (e.each(i.disabledTimeIntervals, function() {
                            if (t.isBetween(this[0], this[1])) return s = !0, !1
                        }), s) return !1
                }
                return !0
            },
            A = function() {
                var n, o, a, l, c = f.find(".datepicker-days"),
                    d = c.find("th"),
                    u = [];
                if (T()) {
                    for (d.eq(0).find("span").attr("title", i.tooltips.prevMonth), d.eq(1).attr("title", i.tooltips.selectMonth), d.eq(2).find("span").attr("title", i.tooltips.nextMonth), c.find(".disabled").removeClass("disabled"), d.eq(1).text(r.format(i.dayViewHeaderFormat)), I(r.clone().subtract(1, "M"), "M") || d.eq(0).addClass("disabled"), I(r.clone().add(1, "M"), "M") || d.eq(2).addClass("disabled"), n = r.clone().startOf("M").startOf("w").startOf("d"), l = 0; l < 42; l++) 0 === n.weekday() && (o = e("<tr>"), i.calendarWeeks && o.append('<td class="cw">' + n.week() + "</td>"), u.push(o)), a = "", n.isBefore(r, "M") && (a += " old"), n.isAfter(r, "M") && (a += " new"), n.isSame(s, "d") && !h && (a += " active"), I(n, "d") || (a += " disabled"), n.isSame(C(), "d") && (a += " today"), 0 !== n.day() && 6 !== n.day() || (a += " weekend"), o.append('<td data-action="selectDay" data-day="' + n.format("L") + '" class="day' + a + '">' + n.date() + "</td>"), n.add(1, "d");
                    c.find("tbody").empty().append(u),
                        function() {
                            var t = f.find(".datepicker-months"),
                                n = t.find("th"),
                                o = t.find("tbody").find("span");
                            n.eq(0).find("span").attr("title", i.tooltips.prevYear), n.eq(1).attr("title", i.tooltips.selectYear), n.eq(2).find("span").attr("title", i.tooltips.nextYear), t.find(".disabled").removeClass("disabled"), I(r.clone().subtract(1, "y"), "y") || n.eq(0).addClass("disabled"), n.eq(1).text(r.year()), I(r.clone().add(1, "y"), "y") || n.eq(2).addClass("disabled"), o.removeClass("active"), s.isSame(r, "y") && !h && o.eq(s.month()).addClass("active"), o.each(function(t) {
                                I(r.clone().month(t), "M") || e(this).addClass("disabled")
                            })
                        }(),
                        function() {
                            var e = f.find(".datepicker-years"),
                                t = e.find("th"),
                                n = r.clone().subtract(5, "y"),
                                o = r.clone().add(6, "y"),
                                a = "";
                            for (t.eq(0).find("span").attr("title", i.tooltips.prevDecade), t.eq(1).attr("title", i.tooltips.selectDecade), t.eq(2).find("span").attr("title", i.tooltips.nextDecade), e.find(".disabled").removeClass("disabled"), i.minDate && i.minDate.isAfter(n, "y") && t.eq(0).addClass("disabled"), t.eq(1).text(n.year() + "-" + o.year()), i.maxDate && i.maxDate.isBefore(o, "y") && t.eq(2).addClass("disabled"); !n.isAfter(o, "y");) a += '<span data-action="selectYear" class="year' + (n.isSame(s, "y") && !h ? " active" : "") + (I(n, "y") ? "" : " disabled") + '">' + n.year() + "</span>", n.add(1, "y");
                            e.find("td").html(a)
                        }(),
                        function() {
                            var e, n = f.find(".datepicker-decades"),
                                o = n.find("th"),
                                a = t({
                                    y: r.year() - r.year() % 100 - 1
                                }),
                                l = a.clone().add(100, "y"),
                                c = a.clone(),
                                d = !1,
                                u = !1,
                                h = "";
                            for (o.eq(0).find("span").attr("title", i.tooltips.prevCentury), o.eq(2).find("span").attr("title", i.tooltips.nextCentury), n.find(".disabled").removeClass("disabled"), (a.isSame(t({
                                    y: 1900
                                })) || i.minDate && i.minDate.isAfter(a, "y")) && o.eq(0).addClass("disabled"), o.eq(1).text(a.year() + "-" + l.year()), (a.isSame(t({
                                    y: 2e3
                                })) || i.maxDate && i.maxDate.isBefore(l, "y")) && o.eq(2).addClass("disabled"); !a.isAfter(l, "y");) e = a.year() + 12, d = i.minDate && i.minDate.isAfter(a, "y") && i.minDate.year() <= e, u = i.maxDate && i.maxDate.isAfter(a, "y") && i.maxDate.year() <= e, h += '<span data-action="selectDecade" class="decade' + (s.isAfter(a) && s.year() <= e ? " active" : "") + (I(a, "y") || d || u ? "" : " disabled") + '" data-selection="' + (a.year() + 6) + '">' + (a.year() + 1) + " - " + (a.year() + 12) + "</span>", a.add(12, "y");
                            h += "<span></span><span></span><span></span>", n.find("td").html(h), o.eq(1).text(c.year() + 1 + "-" + a.year())
                        }()
                }
            },
            j = function() {
                var t, n, o = f.find(".timepicker span[data-time-component]");
                a || (t = f.find(".timepicker [data-action=togglePeriod]"), n = s.clone().add(s.hours() >= 12 ? -12 : 12, "h"), t.text(s.format("A")), I(n, "h") ? t.removeClass("disabled") : t.addClass("disabled")), o.filter("[data-time-component=hours]").text(s.format(a ? "HH" : "hh")), o.filter("[data-time-component=minutes]").text(s.format("mm")), o.filter("[data-time-component=seconds]").text(s.format("ss")),
                    function() {
                        var t = f.find(".timepicker-hours table"),
                            n = r.clone().startOf("d"),
                            i = [],
                            s = e("<tr>");
                        for (r.hour() > 11 && !a && n.hour(12); n.isSame(r, "d") && (a || r.hour() < 12 && n.hour() < 12 || r.hour() > 11);) n.hour() % 4 == 0 && (s = e("<tr>"), i.push(s)), s.append('<td data-action="selectHour" class="hour' + (I(n, "h") ? "" : " disabled") + '">' + n.format(a ? "HH" : "hh") + "</td>"), n.add(1, "h");
                        t.empty().append(i)
                    }(),
                    function() {
                        for (var t = f.find(".timepicker-minutes table"), n = r.clone().startOf("h"), s = [], o = e("<tr>"), a = 1 === i.stepping ? 5 : i.stepping; r.isSame(n, "h");) n.minute() % (4 * a) == 0 && (o = e("<tr>"), s.push(o)), o.append('<td data-action="selectMinute" class="minute' + (I(n, "m") ? "" : " disabled") + '">' + n.format("mm") + "</td>"), n.add(a, "m");
                        t.empty().append(s)
                    }(),
                    function() {
                        for (var t = f.find(".timepicker-seconds table"), n = r.clone().startOf("m"), i = [], s = e("<tr>"); r.isSame(n, "m");) n.second() % 20 == 0 && (s = e("<tr>"), i.push(s)), s.append('<td data-action="selectSecond" class="second' + (I(n, "s") ? "" : " disabled") + '">' + n.format("ss") + "</td>"), n.add(5, "s");
                        t.empty().append(i)
                    }()
            },
            H = function() {
                f && (A(), j())
            },
            L = function(e) {
                var t = h ? null : s;
                if (!e) return h = !0, o.val(""), n.data("date", ""), O({
                    type: "dp.change",
                    date: !1,
                    oldDate: t
                }), void H();
                e = e.clone().locale(i.locale), k() && e.tz(i.timeZone), 1 !== i.stepping && e.minutes(Math.round(e.minutes() / i.stepping) * i.stepping).seconds(0), I(e) ? (s = e, o.val(s.format(l)), n.data("date", s.format(l)), h = !1, H(), O({
                    type: "dp.change",
                    date: s.clone(),
                    oldDate: t
                })) : (i.keepInvalid ? O({
                    type: "dp.change",
                    date: e,
                    oldDate: t
                }) : o.val(h ? "" : s.format(l)), O({
                    type: "dp.error",
                    date: e,
                    oldDate: t
                }))
            },
            F = function() {
                var t = !1;
                return f ? (f.find(".collapse").each(function() {
                    var n = e(this).data("collapse");
                    return !n || !n.transitioning || (t = !0, !1)
                }), t ? u : (p && p.hasClass("btn") && p.toggleClass("active"), f.hide(), e(window).off("resize", P), f.off("click", "[data-action]"), f.off("mousedown", !1), f.remove(), f = !1, O({
                    type: "dp.hide",
                    date: s.clone()
                }), o.blur(), d = 0, r = s.clone(), u)) : u
            },
            R = function() {
                L(null)
            },
            B = function(e) {
                return void 0 === i.parseInputDate ? t.isMoment(e) || (e = C(e)) : e = i.parseInputDate(e), e
            },
            q = {
                next: function() {
                    var e = g[d].navFnc;
                    r.add(g[d].navStep, e), A(), M(e)
                },
                previous: function() {
                    var e = g[d].navFnc;
                    r.subtract(g[d].navStep, e), A(), M(e)
                },
                pickerSwitch: function() {
                    N(1)
                },
                selectMonth: function(t) {
                    var n = e(t.target).closest("tbody").find("span").index(e(t.target));
                    r.month(n), d === m ? (L(s.clone().year(r.year()).month(r.month())), i.inline || F()) : (N(-1), A()), M("M")
                },
                selectYear: function(t) {
                    var n = parseInt(e(t.target).text(), 10) || 0;
                    r.year(n), d === m ? (L(s.clone().year(r.year())), i.inline || F()) : (N(-1), A()), M("YYYY")
                },
                selectDecade: function(t) {
                    var n = parseInt(e(t.target).data("selection"), 10) || 0;
                    r.year(n), d === m ? (L(s.clone().year(r.year())), i.inline || F()) : (N(-1), A()), M("YYYY")
                },
                selectDay: function(t) {
                    var n = r.clone();
                    e(t.target).is(".old") && n.subtract(1, "M"), e(t.target).is(".new") && n.add(1, "M"), L(n.date(parseInt(e(t.target).text(), 10))), S() || i.keepOpen || i.inline || F()
                },
                incrementHours: function() {
                    var e = s.clone().add(1, "h");
                    I(e, "h") && L(e)
                },
                incrementMinutes: function() {
                    var e = s.clone().add(i.stepping, "m");
                    I(e, "m") && L(e)
                },
                incrementSeconds: function() {
                    var e = s.clone().add(1, "s");
                    I(e, "s") && L(e)
                },
                decrementHours: function() {
                    var e = s.clone().subtract(1, "h");
                    I(e, "h") && L(e)
                },
                decrementMinutes: function() {
                    var e = s.clone().subtract(i.stepping, "m");
                    I(e, "m") && L(e)
                },
                decrementSeconds: function() {
                    var e = s.clone().subtract(1, "s");
                    I(e, "s") && L(e)
                },
                togglePeriod: function() {
                    L(s.clone().add(s.hours() >= 12 ? -12 : 12, "h"))
                },
                togglePicker: function(t) {
                    var n, s = e(t.target),
                        r = s.closest("ul"),
                        o = r.find(".in"),
                        a = r.find(".collapse:not(.in)");
                    if (o && o.length) {
                        if ((n = o.data("collapse")) && n.transitioning) return;
                        o.collapse ? (o.collapse("hide"), a.collapse("show")) : (o.removeClass("in"), a.addClass("in")), s.is("span") ? s.toggleClass(i.icons.time + " " + i.icons.date) : s.find("span").toggleClass(i.icons.time + " " + i.icons.date)
                    }
                },
                showPicker: function() {
                    f.find(".timepicker > div:not(.timepicker-picker)").hide(), f.find(".timepicker .timepicker-picker").show()
                },
                showHours: function() {
                    f.find(".timepicker .timepicker-picker").hide(), f.find(".timepicker .timepicker-hours").show()
                },
                showMinutes: function() {
                    f.find(".timepicker .timepicker-picker").hide(), f.find(".timepicker .timepicker-minutes").show()
                },
                showSeconds: function() {
                    f.find(".timepicker .timepicker-picker").hide(), f.find(".timepicker .timepicker-seconds").show()
                },
                selectHour: function(t) {
                    var n = parseInt(e(t.target).text(), 10);
                    a || (s.hours() >= 12 ? 12 !== n && (n += 12) : 12 === n && (n = 0)), L(s.clone().hours(n)), q.showPicker.call(u)
                },
                selectMinute: function(t) {
                    L(s.clone().minutes(parseInt(e(t.target).text(), 10))), q.showPicker.call(u)
                },
                selectSecond: function(t) {
                    L(s.clone().seconds(parseInt(e(t.target).text(), 10))), q.showPicker.call(u)
                },
                clear: R,
                today: function() {
                    var e = C();
                    I(e, "d") && L(e)
                },
                close: F
            },
            Y = function(t) {
                return !e(t.currentTarget).is(".disabled") && (q[e(t.currentTarget).data("action")].apply(u, arguments), !1)
            },
            W = function() {
                var t;
                return o.prop("disabled") || !i.ignoreReadonly && o.prop("readonly") || f ? u : (void 0 !== o.val() && 0 !== o.val().trim().length ? L(B(o.val().trim())) : h && i.useCurrent && (i.inline || o.is("input") && 0 === o.val().trim().length) && (t = C(), "string" == typeof i.useCurrent && (t = {
                    year: function(e) {
                        return e.month(0).date(1).hours(0).seconds(0).minutes(0)
                    },
                    month: function(e) {
                        return e.date(1).hours(0).seconds(0).minutes(0)
                    },
                    day: function(e) {
                        return e.hours(0).seconds(0).minutes(0)
                    },
                    hour: function(e) {
                        return e.seconds(0).minutes(0)
                    },
                    minute: function(e) {
                        return e.seconds(0)
                    }
                }[i.useCurrent](t)), L(t)), f = E(), console.log("show dtpicker"), function() {
                    var t = e("<tr>"),
                        n = r.clone().startOf("w").startOf("d");
                    for (!0 === i.calendarWeeks && t.append(e("<th>").addClass("cw").text("#")); n.isBefore(r.clone().endOf("w"));) t.append(e("<th>").addClass("dow").text(n.format("dd"))), n.add(1, "d");
                    f.find(".datepicker-days thead").append(t)
                }(), function() {
                    for (var t = [], n = r.clone().startOf("y").startOf("d"); n.isSame(r, "y");) t.push(e("<span>").attr("data-action", "selectMonth").addClass("month").text(n.format("MMM"))), n.add(1, "M");
                    f.find(".datepicker-months td").empty().append(t)
                }(), f.find(".timepicker-hours").hide(), f.find(".timepicker-minutes").hide(), f.find(".timepicker-seconds").hide(), H(), N(), e(window).on("resize", P), f.on("click", "[data-action]", Y), f.on("mousedown", !1), p && p.hasClass("btn") && p.toggleClass("active"), P(), f.show(), i.focusOnShow && !o.is(":focus") && o.focus(), O({
                    type: "dp.show"
                }), u)
            },
            z = function() {
                return f ? F() : W()
            },
            U = function(e) {
                var t, n, s, r, o = null,
                    a = [],
                    l = {},
                    c = e.which;
                x[c] = "p";
                for (t in x) x.hasOwnProperty(t) && "p" === x[t] && (a.push(t), parseInt(t, 10) !== c && (l[t] = !0));
                for (t in i.keyBinds)
                    if (i.keyBinds.hasOwnProperty(t) && "function" == typeof i.keyBinds[t] && (s = t.split(" ")).length === a.length && w[c] === s[s.length - 1]) {
                        for (r = !0, n = s.length - 2; n >= 0; n--)
                            if (!(w[s[n]] in l)) {
                                r = !1;
                                break
                            }
                        if (r) {
                            o = i.keyBinds[t];
                            break
                        }
                    }
                o && (o.call(u, f), e.stopPropagation(), e.preventDefault())
            },
            V = function(e) {
                x[e.which] = "r", e.stopPropagation(), e.preventDefault()
            },
            X = function(t) {
                var n = e(t.target).val().trim(),
                    i = n ? B(n) : null;
                return L(i), t.stopImmediatePropagation(), !1
            },
            Q = function(t) {
                var n = {};
                return e.each(t, function() {
                    var e = B(this);
                    e.isValid() && (n[e.format("YYYY-MM-DD")] = !0)
                }), !!Object.keys(n).length && n
            },
            G = function(t) {
                var n = {};
                return e.each(t, function() {
                    n[this] = !0
                }), !!Object.keys(n).length && n
            },
            K = function() {
                var e = i.format || "L LT";
                l = e.replace(/(\[[^\[]*\])|(\\)?(LTS|LT|LL?L?L?|l{1,4})/g, function(e) {
                    return (s.localeData().longDateFormat(e) || e).replace(/(\[[^\[]*\])|(\\)?(LTS|LT|LL?L?L?|l{1,4})/g, function(e) {
                        return s.localeData().longDateFormat(e) || e
                    })
                }), (c = i.extraFormats ? i.extraFormats.slice() : []).indexOf(e) < 0 && c.indexOf(l) < 0 && c.push(l), a = l.toLowerCase().indexOf("a") < 1 && l.replace(/\[.*?\]/g, "").indexOf("h") < 1, $("y") && (m = 2), $("M") && (m = 1), $("d") && (m = 0), d = Math.max(m, d), h || L(s)
            };
        if (u.destroy = function() {
                F(), o.off({
                    change: X,
                    blur: blur,
                    keydown: U,
                    keyup: V,
                    focus: i.allowInputToggle ? F : ""
                }), n.is("input") ? o.off({
                    focus: W
                }) : p && (p.off("click", z), p.off("mousedown", !1)), n.removeData("DateTimePicker"), n.removeData("date")
            }, u.toggle = z, u.show = W, u.hide = F, u.disable = function() {
                return F(), p && p.hasClass("btn") && p.addClass("disabled"), o.prop("disabled", !0), u
            }, u.enable = function() {
                return p && p.hasClass("btn") && p.removeClass("disabled"), o.prop("disabled", !1), u
            }, u.ignoreReadonly = function(e) {
                if (0 === arguments.length) return i.ignoreReadonly;
                if ("boolean" != typeof e) throw new TypeError("ignoreReadonly () expects a boolean parameter");
                return i.ignoreReadonly = e, u
            }, u.options = function(t) {
                if (0 === arguments.length) return e.extend(!0, {}, i);
                if (!(t instanceof Object)) throw new TypeError("options() options parameter should be an object");
                return e.extend(!0, i, t), e.each(i, function(e, t) {
                    if (void 0 === u[e]) throw new TypeError("option " + e + " is not recognized!");
                    u[e](t)
                }), u
            }, u.date = function(e) {
                if (0 === arguments.length) return h ? null : s.clone();
                if (!(null === e || "string" == typeof e || t.isMoment(e) || e instanceof Date)) throw new TypeError("date() parameter must be one of [null, string, moment or Date]");
                return L(null === e ? null : B(e)), u
            }, u.format = function(e) {
                if (0 === arguments.length) return i.format;
                if ("string" != typeof e && ("boolean" != typeof e || !1 !== e)) throw new TypeError("format() expects a string or boolean:false parameter " + e);
                return i.format = e, l && K(), u
            }, u.timeZone = function(e) {
                if (0 === arguments.length) return i.timeZone;
                if ("string" != typeof e) throw new TypeError("newZone() expects a string parameter");
                return i.timeZone = e, u
            }, u.dayViewHeaderFormat = function(e) {
                if (0 === arguments.length) return i.dayViewHeaderFormat;
                if ("string" != typeof e) throw new TypeError("dayViewHeaderFormat() expects a string parameter");
                return i.dayViewHeaderFormat = e, u
            }, u.extraFormats = function(e) {
                if (0 === arguments.length) return i.extraFormats;
                if (!1 !== e && !(e instanceof Array)) throw new TypeError("extraFormats() expects an array or false parameter");
                return i.extraFormats = e, c && K(), u
            }, u.disabledDates = function(t) {
                if (0 === arguments.length) return i.disabledDates ? e.extend({}, i.disabledDates) : i.disabledDates;
                if (!t) return i.disabledDates = !1, H(), u;
                if (!(t instanceof Array)) throw new TypeError("disabledDates() expects an array parameter");
                return i.disabledDates = Q(t), i.enabledDates = !1, H(), u
            }, u.enabledDates = function(t) {
                if (0 === arguments.length) return i.enabledDates ? e.extend({}, i.enabledDates) : i.enabledDates;
                if (!t) return i.enabledDates = !1, H(), u;
                if (!(t instanceof Array)) throw new TypeError("enabledDates() expects an array parameter");
                return i.enabledDates = Q(t), i.disabledDates = !1, H(), u
            }, u.daysOfWeekDisabled = function(e) {
                if (0 === arguments.length) return i.daysOfWeekDisabled.splice(0);
                if ("boolean" == typeof e && !e) return i.daysOfWeekDisabled = !1, H(), u;
                if (!(e instanceof Array)) throw new TypeError("daysOfWeekDisabled() expects an array parameter");
                if (i.daysOfWeekDisabled = e.reduce(function(e, t) {
                        return (t = parseInt(t, 10)) > 6 || t < 0 || isNaN(t) ? e : (-1 === e.indexOf(t) && e.push(t), e)
                    }, []).sort(), i.useCurrent && !i.keepInvalid) {
                    for (var t = 0; !I(s, "d");) {
                        if (s.add(1, "d"), 31 === t) throw "Tried 31 times to find a valid date";
                        t++
                    }
                    L(s)
                }
                return H(), u
            }, u.maxDate = function(e) {
                if (0 === arguments.length) return i.maxDate ? i.maxDate.clone() : i.maxDate;
                if ("boolean" == typeof e && !1 === e) return i.maxDate = !1, H(), u;
                "string" == typeof e && ("now" !== e && "moment" !== e || (e = C()));
                var t = B(e);
                if (!t.isValid()) throw new TypeError("maxDate() Could not parse date parameter: " + e);
                if (i.minDate && t.isBefore(i.minDate)) throw new TypeError("maxDate() date parameter is before options.minDate: " + t.format(l));
                return i.maxDate = t, i.useCurrent && !i.keepInvalid && s.isAfter(e) && L(i.maxDate), r.isAfter(t) && (r = t.clone().subtract(i.stepping, "m")), H(), u
            }, u.minDate = function(e) {
                if (0 === arguments.length) return i.minDate ? i.minDate.clone() : i.minDate;
                if ("boolean" == typeof e && !1 === e) return i.minDate = !1, H(), u;
                "string" == typeof e && ("now" !== e && "moment" !== e || (e = C()));
                var t = B(e);
                if (!t.isValid()) throw new TypeError("minDate() Could not parse date parameter: " + e);
                if (i.maxDate && t.isAfter(i.maxDate)) throw new TypeError("minDate() date parameter is after options.maxDate: " + t.format(l));
                return i.minDate = t, i.useCurrent && !i.keepInvalid && s.isBefore(e) && L(i.minDate), r.isBefore(t) && (r = t.clone().add(i.stepping, "m")), H(), u
            }, u.defaultDate = function(e) {
                if (0 === arguments.length) return i.defaultDate ? i.defaultDate.clone() : i.defaultDate;
                if (!e) return i.defaultDate = !1, u;
                "string" == typeof e && (e = "now" === e || "moment" === e ? C() : C(e));
                var t = B(e);
                if (!t.isValid()) throw new TypeError("defaultDate() Could not parse date parameter: " + e);
                if (!I(t)) throw new TypeError("defaultDate() date passed is invalid according to component setup validations");
                return i.defaultDate = t, (i.defaultDate && i.inline || "" === o.val().trim()) && L(i.defaultDate), u
            }, u.locale = function(e) {
                if (0 === arguments.length) return i.locale;
                if (!t.localeData(e)) throw new TypeError("locale() locale " + e + " is not loaded from moment locales!");
                return i.locale = e, s.locale(i.locale), r.locale(i.locale), l && K(), f && (F(), W()), u
            }, u.stepping = function(e) {
                return 0 === arguments.length ? i.stepping : (e = parseInt(e, 10), (isNaN(e) || e < 1) && (e = 1), i.stepping = e, u)
            }, u.useCurrent = function(e) {
                var t = ["year", "month", "day", "hour", "minute"];
                if (0 === arguments.length) return i.useCurrent;
                if ("boolean" != typeof e && "string" != typeof e) throw new TypeError("useCurrent() expects a boolean or string parameter");
                if ("string" == typeof e && -1 === t.indexOf(e.toLowerCase())) throw new TypeError("useCurrent() expects a string parameter of " + t.join(", "));
                return i.useCurrent = e, u
            }, u.collapse = function(e) {
                if (0 === arguments.length) return i.collapse;
                if ("boolean" != typeof e) throw new TypeError("collapse() expects a boolean parameter");
                return i.collapse === e ? u : (i.collapse = e, f && (F(), W()), u)
            }, u.icons = function(t) {
                if (0 === arguments.length) return e.extend({}, i.icons);
                if (!(t instanceof Object)) throw new TypeError("icons() expects parameter to be an Object");
                return e.extend(i.icons, t), f && (F(), W()), u
            }, u.tooltips = function(t) {
                if (0 === arguments.length) return e.extend({}, i.tooltips);
                if (!(t instanceof Object)) throw new TypeError("tooltips() expects parameter to be an Object");
                return e.extend(i.tooltips, t), f && (F(), W()), u
            }, u.useStrict = function(e) {
                if (0 === arguments.length) return i.useStrict;
                if ("boolean" != typeof e) throw new TypeError("useStrict() expects a boolean parameter");
                return i.useStrict = e, u
            }, u.sideBySide = function(e) {
                if (0 === arguments.length) return i.sideBySide;
                if ("boolean" != typeof e) throw new TypeError("sideBySide() expects a boolean parameter");
                return i.sideBySide = e, f && (F(), W()), u
            }, u.viewMode = function(e) {
                if (0 === arguments.length) return i.viewMode;
                if ("string" != typeof e) throw new TypeError("viewMode() expects a string parameter");
                if (-1 === v.indexOf(e)) throw new TypeError("viewMode() parameter must be one of (" + v.join(", ") + ") value");
                return i.viewMode = e, d = Math.max(v.indexOf(e), m), N(), u
            }, u.toolbarPlacement = function(e) {
                if (0 === arguments.length) return i.toolbarPlacement;
                if ("string" != typeof e) throw new TypeError("toolbarPlacement() expects a string parameter");
                if (-1 === b.indexOf(e)) throw new TypeError("toolbarPlacement() parameter must be one of (" + b.join(", ") + ") value");
                return i.toolbarPlacement = e, f && (F(), W()), u
            }, u.widgetPositioning = function(t) {
                if (0 === arguments.length) return e.extend({}, i.widgetPositioning);
                if ("[object Object]" !== {}.toString.call(t)) throw new TypeError("widgetPositioning() expects an object variable");
                if (t.horizontal) {
                    if ("string" != typeof t.horizontal) throw new TypeError("widgetPositioning() horizontal variable must be a string");
                    if (t.horizontal = t.horizontal.toLowerCase(), -1 === y.indexOf(t.horizontal)) throw new TypeError("widgetPositioning() expects horizontal parameter to be one of (" + y.join(", ") + ")");
                    i.widgetPositioning.horizontal = t.horizontal
                }
                if (t.vertical) {
                    if ("string" != typeof t.vertical) throw new TypeError("widgetPositioning() vertical variable must be a string");
                    if (t.vertical = t.vertical.toLowerCase(), -1 === _.indexOf(t.vertical)) throw new TypeError("widgetPositioning() expects vertical parameter to be one of (" + _.join(", ") + ")");
                    i.widgetPositioning.vertical = t.vertical
                }
                return H(), u
            }, u.calendarWeeks = function(e) {
                if (0 === arguments.length) return i.calendarWeeks;
                if ("boolean" != typeof e) throw new TypeError("calendarWeeks() expects parameter to be a boolean value");
                return i.calendarWeeks = e, H(), u
            }, u.showTodayButton = function(e) {
                if (0 === arguments.length) return i.showTodayButton;
                if ("boolean" != typeof e) throw new TypeError("showTodayButton() expects a boolean parameter");
                return i.showTodayButton = e, f && (F(), W()), u
            }, u.showClear = function(e) {
                if (0 === arguments.length) return i.showClear;
                if ("boolean" != typeof e) throw new TypeError("showClear() expects a boolean parameter");
                return i.showClear = e, f && (F(), W()), u
            }, u.widgetParent = function(t) {
                if (0 === arguments.length) return i.widgetParent;
                if ("string" == typeof t && (t = e(t)), null !== t && "string" != typeof t && !(t instanceof e)) throw new TypeError("widgetParent() expects a string or a jQuery object parameter");
                return i.widgetParent = t, f && (F(), W()), u
            }, u.keepOpen = function(e) {
                if (0 === arguments.length) return i.keepOpen;
                if ("boolean" != typeof e) throw new TypeError("keepOpen() expects a boolean parameter");
                return i.keepOpen = e, u
            }, u.focusOnShow = function(e) {
                if (0 === arguments.length) return i.focusOnShow;
                if ("boolean" != typeof e) throw new TypeError("focusOnShow() expects a boolean parameter");
                return i.focusOnShow = e, u
            }, u.inline = function(e) {
                if (0 === arguments.length) return i.inline;
                if ("boolean" != typeof e) throw new TypeError("inline() expects a boolean parameter");
                return i.inline = e, u
            }, u.clear = function() {
                return R(), u
            }, u.keyBinds = function(e) {
                return 0 === arguments.length ? i.keyBinds : (i.keyBinds = e, u)
            }, u.getMoment = function(e) {
                return C(e)
            }, u.debug = function(e) {
                if ("boolean" != typeof e) throw new TypeError("debug() expects a boolean parameter");
                return i.debug = e, u
            }, u.allowInputToggle = function(e) {
                if (0 === arguments.length) return i.allowInputToggle;
                if ("boolean" != typeof e) throw new TypeError("allowInputToggle() expects a boolean parameter");
                return i.allowInputToggle = e, u
            }, u.showClose = function(e) {
                if (0 === arguments.length) return i.showClose;
                if ("boolean" != typeof e) throw new TypeError("showClose() expects a boolean parameter");
                return i.showClose = e, u
            }, u.keepInvalid = function(e) {
                if (0 === arguments.length) return i.keepInvalid;
                if ("boolean" != typeof e) throw new TypeError("keepInvalid() expects a boolean parameter");
                return i.keepInvalid = e, u
            }, u.datepickerInput = function(e) {
                if (0 === arguments.length) return i.datepickerInput;
                if ("string" != typeof e) throw new TypeError("datepickerInput() expects a string parameter");
                return i.datepickerInput = e, u
            }, u.parseInputDate = function(e) {
                if (0 === arguments.length) return i.parseInputDate;
                if ("function" != typeof e) throw new TypeError("parseInputDate() sholud be as function");
                return i.parseInputDate = e, u
            }, u.disabledTimeIntervals = function(t) {
                if (0 === arguments.length) return i.disabledTimeIntervals ? e.extend({}, i.disabledTimeIntervals) : i.disabledTimeIntervals;
                if (!t) return i.disabledTimeIntervals = !1, H(), u;
                if (!(t instanceof Array)) throw new TypeError("disabledTimeIntervals() expects an array parameter");
                return i.disabledTimeIntervals = t, H(), u
            }, u.disabledHours = function(t) {
                if (0 === arguments.length) return i.disabledHours ? e.extend({}, i.disabledHours) : i.disabledHours;
                if (!t) return i.disabledHours = !1, H(), u;
                if (!(t instanceof Array)) throw new TypeError("disabledHours() expects an array parameter");
                if (i.disabledHours = G(t), i.enabledHours = !1, i.useCurrent && !i.keepInvalid) {
                    for (var n = 0; !I(s, "h");) {
                        if (s.add(1, "h"), 24 === n) throw "Tried 24 times to find a valid date";
                        n++
                    }
                    L(s)
                }
                return H(), u
            }, u.enabledHours = function(t) {
                if (0 === arguments.length) return i.enabledHours ? e.extend({}, i.enabledHours) : i.enabledHours;
                if (!t) return i.enabledHours = !1, H(), u;
                if (!(t instanceof Array)) throw new TypeError("enabledHours() expects an array parameter");
                if (i.enabledHours = G(t), i.disabledHours = !1, i.useCurrent && !i.keepInvalid) {
                    for (var n = 0; !I(s, "h");) {
                        if (s.add(1, "h"), 24 === n) throw "Tried 24 times to find a valid date";
                        n++
                    }
                    L(s)
                }
                return H(), u
            }, u.viewDate = function(e) {
                if (0 === arguments.length) return r.clone();
                if (!e) return r = s.clone(), u;
                if (!("string" == typeof e || t.isMoment(e) || e instanceof Date)) throw new TypeError("viewDate() parameter must be one of [string, moment or Date]");
                return r = B(e), M(), u
            }, n.is("input")) o = n;
        else if (0 === (o = n.find(i.datepickerInput)).length) o = n.find("input");
        else if (!o.is("input")) throw new Error('CSS class "' + i.datepickerInput + '" cannot be applied to non input element');
        if (n.hasClass("input-group") && (p = 0 === n.find(".datepickerbutton").length ? n.find(".input-group-addon") : n.find(".datepickerbutton")), !i.inline && !o.is("input")) throw new Error("Could not initialize DateTimePicker without an input element");
        return s = C(), r = s.clone(), e.extend(!0, i, function() {
            var t, s = {};
            return (t = n.is("input") || i.inline ? n.data() : n.find("input").data()).dateOptions && t.dateOptions instanceof Object && (s = e.extend(!0, s, t.dateOptions)), e.each(i, function(e) {
                var n = "date" + e.charAt(0).toUpperCase() + e.slice(1);
                void 0 !== t[n] && (s[e] = t[n])
            }), s
        }()), u.options(i), K(), o.on({
            change: X,
            blur: i.debug ? "" : F,
            keydown: U,
            keyup: V,
            focus: i.allowInputToggle ? W : ""
        }), n.is("input") ? o.on({
            focus: W
        }) : p && (p.on("click", z), p.on("mousedown", !1)), o.prop("disabled") && u.disable(), o.is("input") && 0 !== o.val().trim().length ? L(B(o.val().trim())) : i.defaultDate && void 0 === o.attr("placeholder") && L(i.defaultDate), i.inline && W(), u
    };
    e.fn.datetimepicker = function(t) {
        t = t || {};
        var i, s = Array.prototype.slice.call(arguments, 1),
            r = !0;
        if ("object" == typeof t) return this.each(function() {
            var i = e(this);
            i.data("DateTimePicker") || (t = e.extend(!0, {}, e.fn.datetimepicker.defaults, t), i.data("DateTimePicker", n(i, t)))
        });
        if ("string" == typeof t) return this.each(function() {
            var n = e(this).data("DateTimePicker");
            if (!n) throw new Error('bootstrap-datetimepicker("' + t + '") method was called on an element that is not using DateTimePicker');
            i = n[t].apply(n, s), r = i === n
        }), r || e.inArray(t, ["destroy", "hide", "show", "toggle"]) > -1 ? this : i;
        throw new TypeError("Invalid arguments for DateTimePicker: " + t)
    }, e.fn.datetimepicker.defaults = {
        timeZone: "",
        format: !1,
        dayViewHeaderFormat: "MMMM YYYY",
        extraFormats: !1,
        stepping: 1,
        minDate: !1,
        maxDate: !1,
        useCurrent: !0,
        collapse: !0,
        locale: t.locale(),
        defaultDate: !1,
        disabledDates: !1,
        enabledDates: !1,
        icons: {
            time: "glyphicon glyphicon-time",
            date: "glyphicon glyphicon-calendar",
            up: "glyphicon glyphicon-chevron-up",
            down: "glyphicon glyphicon-chevron-down",
            previous: "glyphicon glyphicon-chevron-left",
            next: "glyphicon glyphicon-chevron-right",
            today: "glyphicon glyphicon-screenshot",
            clear: "glyphicon glyphicon-trash",
            close: "glyphicon glyphicon-remove"
        },
        tooltips: {
            today: "Go to today",
            clear: "Clear selection",
            close: "Close the picker",
            selectMonth: "Select Month",
            prevMonth: "Previous Month",
            nextMonth: "Next Month",
            selectYear: "Select Year",
            prevYear: "Previous Year",
            nextYear: "Next Year",
            selectDecade: "Select Decade",
            prevDecade: "Previous Decade",
            nextDecade: "Next Decade",
            prevCentury: "Previous Century",
            nextCentury: "Next Century",
            pickHour: "Pick Hour",
            incrementHour: "Increment Hour",
            decrementHour: "Decrement Hour",
            pickMinute: "Pick Minute",
            incrementMinute: "Increment Minute",
            decrementMinute: "Decrement Minute",
            pickSecond: "Pick Second",
            incrementSecond: "Increment Second",
            decrementSecond: "Decrement Second",
            togglePeriod: "Toggle Period",
            selectTime: "Select Time"
        },
        useStrict: !1,
        sideBySide: !1,
        daysOfWeekDisabled: !1,
        calendarWeeks: !1,
        viewMode: "days",
        toolbarPlacement: "default",
        showTodayButton: !1,
        showClear: !1,
        showClose: !1,
        widgetPositioning: {
            horizontal: "auto",
            vertical: "auto"
        },
        widgetParent: null,
        ignoreReadonly: !1,
        keepOpen: !1,
        focusOnShow: !0,
        inline: !1,
        keepInvalid: !1,
        datepickerInput: ".datepickerinput",
        keyBinds: {
            up: function(e) {
                if (e) {
                    var t = this.date() || this.getMoment();
                    e.find(".datepicker").is(":visible") ? this.date(t.clone().subtract(7, "d")) : this.date(t.clone().add(this.stepping(), "m"))
                }
            },
            down: function(e) {
                if (e) {
                    var t = this.date() || this.getMoment();
                    e.find(".datepicker").is(":visible") ? this.date(t.clone().add(7, "d")) : this.date(t.clone().subtract(this.stepping(), "m"))
                } else this.show()
            },
            "control up": function(e) {
                if (e) {
                    var t = this.date() || this.getMoment();
                    e.find(".datepicker").is(":visible") ? this.date(t.clone().subtract(1, "y")) : this.date(t.clone().add(1, "h"))
                }
            },
            "control down": function(e) {
                if (e) {
                    var t = this.date() || this.getMoment();
                    e.find(".datepicker").is(":visible") ? this.date(t.clone().add(1, "y")) : this.date(t.clone().subtract(1, "h"))
                }
            },
            left: function(e) {
                if (e) {
                    var t = this.date() || this.getMoment();
                    e.find(".datepicker").is(":visible") && this.date(t.clone().subtract(1, "d"))
                }
            },
            right: function(e) {
                if (e) {
                    var t = this.date() || this.getMoment();
                    e.find(".datepicker").is(":visible") && this.date(t.clone().add(1, "d"))
                }
            },
            pageUp: function(e) {
                if (e) {
                    var t = this.date() || this.getMoment();
                    e.find(".datepicker").is(":visible") && this.date(t.clone().subtract(1, "M"))
                }
            },
            pageDown: function(e) {
                if (e) {
                    var t = this.date() || this.getMoment();
                    e.find(".datepicker").is(":visible") && this.date(t.clone().add(1, "M"))
                }
            },
            enter: function() {
                this.hide()
            },
            escape: function() {
                this.hide()
            },
            "control space": function(e) {
                e && e.find(".timepicker").is(":visible") && e.find('.btn[data-action="togglePeriod"]').click()
            },
            t: function() {
                this.date(this.getMoment())
            },
            delete: function() {
                this.clear()
            }
        },
        debug: !1,
        allowInputToggle: !1,
        disabledTimeIntervals: !1,
        disabledHours: !1,
        enabledHours: !1,
        viewDate: !1
    }, "undefined" != typeof module && (module.exports = e.fn.datetimepicker)
}),
function(e) {
    e.fn.bootstrapResponsiveTabs = function(t) {
        e.extend({
            minTabWidth: "57",
            maxTabWidth: "123"
        }, t);
        var n = function() {
                var e = {};
                return function(t, n, i) {
                    i || (i = "default timer"), e[i] && clearTimeout(e[i]), e[i] = setTimeout(t, n)
                }
            }(),
            i = function(e) {
                var t = e.find("> .js-tab");
                t.sort(function(e, t) {
                    return +e.getAttribute("tab-index") - +t.getAttribute("tab-index")
                }), e.detach("> .js-tab").append(t)
            };
        this.each(function() {
            $container = e(this);
            (function() {
                (function() {
                    TABS_OBJECT = this, TABS_OBJECT.activeTabId = 1, TABS_OBJECT.tabsHorizontalContainer = $container, TABS_OBJECT.tabsHorizontalContainer.addClass("responsive-tabs").wrap("<div class='responsive-tabs-container pull-left clearfix'></div>");
                    var t = function() {
                            var t = 0,
                                n = TABS_OBJECT.tabsHorizontalContainer.parent().parent().width();
                            TABS_OBJECT.tabsHorizontalContainer.parent().siblings(".left").each(function() {
                                t += e(this).outerWidth()
                            }), t += 25, TABS_OBJECT.tabsHorizontalContainer.parent().css("width", n - t)
                        },
                        s = function() {
                            var t = TABS_OBJECT.tabsHorizontalContainer.parent().width(),
                                n = TABS_OBJECT.tabsHorizontalContainer.children("a.nav_el"),
                                i = n.length,
                                s = 0,
                                r = 0;
                            n.each(function(n) {
                                if (e(this).hasClass("hidden") ? (e(this).toggleClass("hidden"), s += e(this).outerWidth(), e(this).toggleClass("hidden")) : s += e(this).outerWidth(), s + 100 >= t) return !1;
                                r++
                            }), r != i && (r--, s + 80 > t && r--);
                            for (var o = i - r, a = 0; a < n.length; a++) {
                                var l = n.eq(a),
                                    c = l.attr("tab-id"),
                                    d = TABS_OBJECT.tabsVerticalContainer.find(".js-tab[tab-id=" + c + "]"),
                                    u = a < r;
                                l.toggleClass("hidden", !u), d.toggleClass("hidden", u)
                            }
                            var h = o > 0;
                            TABS_OBJECT.tabsVerticalContainer.toggleClass("hidden", !h), TABS_OBJECT.tabsVerticalContainer.parent().find(".dropdown-toggle").find(".count").text("More (" + o + ")"), h ? TABS_OBJECT.tabsVerticalContainer.parents(".js-tabs-dropdown").show() : TABS_OBJECT.tabsVerticalContainer.parents(".js-tabs-dropdown").hide(), activeTab = TABS_OBJECT.tabsHorizontalContainer.find(".js-tab[tab-id=" + TABS_OBJECT.activeTabId + "]"), activeTabCurrentIndex = activeTab.index(), activeTabDefaultIndex = activeTab.attr("tab-index"), lastVisibleHorizontalTab = TABS_OBJECT.tabsHorizontalContainer.find(".js-tab:visible").last(), lastVisibleTabIndex = lastVisibleHorizontalTab.index(), lastHiddenVerticalTab = TABS_OBJECT.tabsVerticalContainer.find(".js-tab.hidden").last(), activeVerticalTab = TABS_OBJECT.tabsVerticalContainer.find(".js-tab[tab-index=" + activeTabCurrentIndex + "]"), activeTabCurrentIndex >= r && (activeTab.insertBefore(lastVisibleHorizontalTab), activeTab.removeClass("hidden"), lastVisibleHorizontalTab.addClass("hidden"), lastHiddenVerticalTab.removeClass("hidden"), activeVerticalTab.addClass("hidden")), activeTabCurrentIndex < activeTabDefaultIndex && activeTabCurrentIndex < lastVisibleTabIndex && activeTab.insertAfter(lastVisibleHorizontalTab)
                        };
                    ! function() {
                        var n = TABS_OBJECT.tabsHorizontalContainer.children("a.nav_el");
                        0 !== n.length && (n.each(function(t) {
                            tabIndex = e(this).index(), e(this).addClass("js-tab").attr("tab-id", t + 1).attr("tab-index", tabIndex)
                        }), TABS_OBJECT.tabsHorizontalContainer.append("<div class='nav navbar-nav  dropdown tabs-dropdown js-tabs-dropdown'>               <a href='#' class='dropdown-toggle nav_el' data-toggle='dropdown'><span class='count'>Tabs </span><b class='caret'></b></a>               <ul class='dropdown-menu' role='menu'>               <div class='dropdown-header visible-xs'>                <p class='count'>Tabs</p>                 <button type='button' class='close' data-dismiss='dropdown'><span aria-hidden='true'>&times;</span></button>                 <div class='divider visible-xs'></div>               </div>               </ul>             </div>"), TABS_OBJECT.tabsHorizontalContainer.append("<div class='clear'></div>"), TABS_OBJECT.tabsVerticalContainer = TABS_OBJECT.tabsHorizontalContainer.find(".tabs-dropdown").find(".dropdown-menu"), n.clone().appendTo(TABS_OBJECT.tabsVerticalContainer), t(), s())
                    }(), change_tab = void TABS_OBJECT.tabsHorizontalContainer.parents(".responsive-tabs-container").on("click", ".js-tab", function(t) {
                        var n = e(t.target);
                        TABS_OBJECT.activeTabId = e(this).attr("tab-id"), n.parents(".dropdown-menu").length > 0 ? TABS_OBJECT.tabsHorizontalContainer.find("> .js-tab[tab-id=" + TABS_OBJECT.activeTabId + "]").click() : (i(TABS_OBJECT.tabsHorizontalContainer), i(TABS_OBJECT.tabsVerticalContainer), s())
                    }), e(window).resize(function() {
                        n(function() {
                            t(), s()
                        }, 300, "Resize Tabs")
                    })
                })()
            })()
        })
    }
}(jQuery),
function() {
    var e, t, n, i, s = {}.hasOwnProperty;
    (i = function() {
        function e() {
            this.options_index = 0, this.parsed = []
        }
        return e.prototype.add_node = function(e) {
            return "OPTGROUP" === e.nodeName.toUpperCase() ? this.add_group(e) : this.add_option(e)
        }, e.prototype.add_group = function(e) {
            var t, n, i, s, r, o;
            for (t = this.parsed.length, this.parsed.push({
                    array_index: t,
                    group: !0,
                    label: this.escapeExpression(e.label),
                    title: e.title ? e.title : void 0,
                    children: 0,
                    disabled: e.disabled,
                    classes: e.className
                }), o = [], i = 0, s = (r = e.childNodes).length; i < s; i++) n = r[i], o.push(this.add_option(n, t, e.disabled));
            return o
        }, e.prototype.add_option = function(e, t, n) {
            if ("OPTION" === e.nodeName.toUpperCase()) return "" !== e.text ? (null != t && (this.parsed[t].children += 1), this.parsed.push({
                array_index: this.parsed.length,
                options_index: this.options_index,
                value: e.value,
                text: e.text,
                html: e.innerHTML,
                title: e.title ? e.title : void 0,
                selected: e.selected,
                disabled: !0 === n ? n : e.disabled,
                group_array_index: t,
                group_label: null != t ? this.parsed[t].label : null,
                classes: e.className,
                style: e.style.cssText
            })) : this.parsed.push({
                array_index: this.parsed.length,
                options_index: this.options_index,
                empty: !0
            }), this.options_index += 1
        }, e.prototype.escapeExpression = function(e) {
            var t, n;
            return null == e || !1 === e ? "" : /[\&\<\>\"\'\`]/.test(e) ? (t = {
                "<": "&lt;",
                ">": "&gt;",
                '"': "&quot;",
                "'": "&#x27;",
                "`": "&#x60;"
            }, n = /&(?!\w+;)|[\<\>\"\'\`]/g, e.replace(n, function(e) {
                return t[e] || "&amp;"
            })) : e
        }, e
    }()).select_to_array = function(e) {
        var t, n, s, r, o;
        for (n = new i, s = 0, r = (o = e.childNodes).length; s < r; s++) t = o[s], n.add_node(t);
        return n.parsed
    }, t = function() {
        function e(t, n) {
            this.form_field = t, this.options = null != n ? n : {}, e.browser_is_supported() && (this.is_multiple = this.form_field.multiple, this.set_default_text(), this.set_default_values(), this.setup(), this.set_up_html(), this.register_observers(), this.on_ready())
        }
        return e.prototype.set_default_values = function() {
            var e = this;
            return this.click_test_action = function(t) {
                return e.test_active_click(t)
            }, this.activate_action = function(t) {
                return e.activate_field(t)
            }, this.active_field = !1, this.mouse_on_container = !1, this.results_showing = !1, this.result_highlighted = null, this.allow_single_deselect = null != this.options.allow_single_deselect && null != this.form_field.options[0] && "" === this.form_field.options[0].text && this.options.allow_single_deselect, this.disable_search_threshold = this.options.disable_search_threshold || 0, this.disable_search = this.options.disable_search || !1, this.enable_split_word_search = null == this.options.enable_split_word_search || this.options.enable_split_word_search, this.group_search = null == this.options.group_search || this.options.group_search, this.search_contains = this.options.search_contains || !1, this.single_backstroke_delete = null == this.options.single_backstroke_delete || this.options.single_backstroke_delete, this.max_selected_options = this.options.max_selected_options || 1 / 0, this.inherit_select_classes = this.options.inherit_select_classes || !1, this.display_selected_options = null == this.options.display_selected_options || this.options.display_selected_options, this.display_disabled_options = null == this.options.display_disabled_options || this.options.display_disabled_options, this.include_group_label_in_selected = this.options.include_group_label_in_selected || !1, this.max_shown_results = this.options.max_shown_results || Number.POSITIVE_INFINITY, this.case_sensitive_search = this.options.case_sensitive_search || !1
        }, e.prototype.set_default_text = function() {
            return this.form_field.getAttribute("data-placeholder") ? this.default_text = this.form_field.getAttribute("data-placeholder") : this.is_multiple ? this.default_text = this.options.placeholder_text_multiple || this.options.placeholder_text || e.default_multiple_text : this.default_text = this.options.placeholder_text_single || this.options.placeholder_text || e.default_single_text, this.results_none_found = this.form_field.getAttribute("data-no_results_text") || this.options.no_results_text || e.default_no_result_text
        }, e.prototype.choice_label = function(e) {
            return this.include_group_label_in_selected && null != e.group_label ? "<b class='group-name'>" + e.group_label + "</b>" + e.html : e.html
        }, e.prototype.mouse_enter = function() {
            return this.mouse_on_container = !0
        }, e.prototype.mouse_leave = function() {
            return this.mouse_on_container = !1
        }, e.prototype.input_focus = function(e) {
            var t = this;
            if (this.is_multiple) {
                if (!this.active_field) return setTimeout(function() {
                    return t.container_mousedown()
                }, 50)
            } else if (!this.active_field) return this.activate_field()
        }, e.prototype.input_blur = function(e) {
            var t = this;
            if (!this.mouse_on_container) return this.active_field = !1, setTimeout(function() {
                return t.blur_test()
            }, 100)
        }, e.prototype.results_option_build = function(e) {
            var t, n, i, s, r, o, a;
            for (t = "", s = 0, r = 0, o = (a = this.results_data).length; r < o && (n = a[r], i = "", "" !== (i = n.group ? this.result_add_group(n) : this.result_add_option(n)) && (s++, t += i), (null != e ? e.first : void 0) && (n.selected && this.is_multiple ? this.choice_build(n) : n.selected && !this.is_multiple && this.single_set_selected_text(this.choice_label(n))), !(s >= this.max_shown_results)); r++);
            return t
        }, e.prototype.result_add_option = function(e) {
            var t, n;
            return e.search_match && this.include_option_in_results(e) ? (t = [], e.disabled || e.selected && this.is_multiple || t.push("active-result"), !e.disabled || e.selected && this.is_multiple || t.push("disabled-result"), e.selected && t.push("result-selected"), null != e.group_array_index && t.push("group-option"), "" !== e.classes && t.push(e.classes), n = document.createElement("li"), n.className = t.join(" "), n.style.cssText = e.style, n.setAttribute("data-option-array-index", e.array_index), n.innerHTML = e.search_text, e.title && (n.title = e.title), this.outerHTML(n)) : ""
        }, e.prototype.result_add_group = function(e) {
            var t, n;
            return (e.search_match || e.group_match) && e.active_options > 0 ? ((t = []).push("group-result"), e.classes && t.push(e.classes), n = document.createElement("li"), n.className = t.join(" "), n.innerHTML = e.search_text, e.title && (n.title = e.title), this.outerHTML(n)) : ""
        }, e.prototype.results_update_field = function() {
            if (this.set_default_text(), this.is_multiple || this.results_reset_cleanup(), this.result_clear_highlight(), this.results_build(), this.results_showing) return this.winnow_results()
        }, e.prototype.reset_single_select_options = function() {
            var e, t, n, i, s;
            for (s = [], t = 0, n = (i = this.results_data).length; t < n; t++)(e = i[t]).selected ? s.push(e.selected = !1) : s.push(void 0);
            return s
        }, e.prototype.results_toggle = function() {
            return this.results_showing ? this.results_hide() : this.results_show()
        }, e.prototype.results_search = function(e) {
            return this.results_showing ? this.winnow_results() : this.results_show()
        }, e.prototype.winnow_results = function() {
            var e, t, n, i, s, r, o, a, l, c, d, u;
            for (this.no_results_clear(), i = 0, e = (r = this.get_search_text()).replace(/[-[\]{}()*+?.,\\^$|#\s]/g, "\\$&"), l = new RegExp(e, "i"), n = this.get_search_regex(e), c = 0, d = (u = this.results_data).length; c < d; c++)(t = u[c]).search_match = !1, s = null, this.include_option_in_results(t) && (t.group && (t.group_match = !1, t.active_options = 0), null != t.group_array_index && this.results_data[t.group_array_index] && (0 === (s = this.results_data[t.group_array_index]).active_options && s.search_match && (i += 1), s.active_options += 1), t.search_text = t.group ? t.label : t.html, t.group && !this.group_search || (t.search_match = this.search_string_match(t.search_text, n), t.search_match && !t.group && (i += 1), t.search_match ? (r.length && (o = t.search_text.search(l), a = t.search_text.substr(0, o + r.length) + "</em>" + t.search_text.substr(o + r.length), t.search_text = a.substr(0, o) + "<em>" + a.substr(o)), null != s && (s.group_match = !0)) : null != t.group_array_index && this.results_data[t.group_array_index].search_match && (t.search_match = !0)));
            return this.result_clear_highlight(), i < 1 && r.length ? (this.update_results_content(""), this.no_results(r)) : (this.update_results_content(this.results_option_build()), this.winnow_results_set_highlight())
        }, e.prototype.get_search_regex = function(e) {
            var t, n;
            return t = this.search_contains ? "" : "^", n = this.case_sensitive_search ? "" : "i", new RegExp(t + e, n)
        }, e.prototype.search_string_match = function(e, t) {
            var n, i, s, r;
            if (t.test(e)) return !0;
            if (this.enable_split_word_search && (e.indexOf(" ") >= 0 || 0 === e.indexOf("[")) && (i = e.replace(/\[|\]/g, "").split(" ")).length)
                for (s = 0, r = i.length; s < r; s++)
                    if (n = i[s], t.test(n)) return !0
        }, e.prototype.choices_count = function() {
            var e, t, n;
            if (null != this.selected_option_count) return this.selected_option_count;
            for (this.selected_option_count = 0, e = 0, t = (n = this.form_field.options).length; e < t; e++) n[e].selected && (this.selected_option_count += 1);
            return this.selected_option_count
        }, e.prototype.choices_click = function(e) {
            if (e.preventDefault(), !this.results_showing && !this.is_disabled) return this.results_show()
        }, e.prototype.keyup_checker = function(e) {
            var t, n;
            switch (t = null != (n = e.which) ? n : e.keyCode, this.search_field_scale(), t) {
                case 8:
                    if (this.is_multiple && this.backstroke_length < 1 && this.choices_count() > 0) return this.keydown_backstroke();
                    if (!this.pending_backstroke) return this.result_clear_highlight(), this.results_search();
                    break;
                case 13:
                    if (e.preventDefault(), this.results_showing) return this.result_select(e);
                    break;
                case 27:
                    return this.results_showing && this.results_hide(), !0;
                case 9:
                case 38:
                case 40:
                case 16:
                case 91:
                case 17:
                case 18:
                    break;
                default:
                    return this.results_search()
            }
        }, e.prototype.clipboard_event_checker = function(e) {
            var t = this;
            return setTimeout(function() {
                return t.results_search()
            }, 50)
        }, e.prototype.container_width = function() {
            return null != this.options.width ? this.options.width : this.form_field.offsetWidth + "px"
        }, e.prototype.include_option_in_results = function(e) {
            return !(this.is_multiple && !this.display_selected_options && e.selected) && (!(!this.display_disabled_options && e.disabled) && !e.empty)
        }, e.prototype.search_results_touchstart = function(e) {
            return this.touch_started = !0, this.search_results_mouseover(e)
        }, e.prototype.search_results_touchmove = function(e) {
            return this.touch_started = !1, this.search_results_mouseout(e)
        }, e.prototype.search_results_touchend = function(e) {
            if (this.touch_started) return this.search_results_mouseup(e)
        }, e.prototype.outerHTML = function(e) {
            var t;
            return e.outerHTML ? e.outerHTML : ((t = document.createElement("div")).appendChild(e), t.innerHTML)
        }, e.browser_is_supported = function() {
            return "Microsoft Internet Explorer" === window.navigator.appName ? document.documentMode >= 8 : !(/iP(od|hone)/i.test(window.navigator.userAgent) || /IEMobile/i.test(window.navigator.userAgent) || /Windows Phone/i.test(window.navigator.userAgent) || /BlackBerry/i.test(window.navigator.userAgent) || /BB10/i.test(window.navigator.userAgent) || /Android.*Mobile/i.test(window.navigator.userAgent))
        }, e.default_multiple_text = "Select Some Options", e.default_single_text = "Select an Option", e.default_no_result_text = "No results match", e
    }(), (e = jQuery).fn.extend({
        chosenedge: function(i) {
            return t.browser_is_supported() ? this.each(function(t) {
                var s, r;
                r = (s = e(this)).data("chosen"), "destroy" !== i ? r instanceof n || s.data("chosen", new n(this, i)) : r instanceof n && r.destroy()
            }) : this
        }
    }), n = function(n) {
        function r() {
            return r.__super__.constructor.apply(this, arguments)
        }
        return function(e, t) {
            function n() {
                this.constructor = e
            }
            for (var i in t) s.call(t, i) && (e[i] = t[i]);
            n.prototype = t.prototype, e.prototype = new n, e.__super__ = t.prototype
        }(r, t), r.prototype.setup = function() {
            return this.form_field_jq = e(this.form_field), this.current_selectedIndex = this.form_field.selectedIndex, this.is_rtl = this.form_field_jq.hasClass("chosen-rtl")
        }, r.prototype.set_up_html = function() {
            var t, n;
            return (t = ["chosen-container"]).push("chosen-container-" + (this.is_multiple ? "multi" : "single")), this.inherit_select_classes && this.form_field.className && t.push(this.form_field.className), this.is_rtl && t.push("chosen-rtl"), n = {
                class: t.join(" "),
                style: "width: " + this.container_width() + ";",
                title: this.form_field.title
            }, this.form_field.id.length && (n.id = this.form_field.id.replace(/[^\w]/g, "_") + "_chosen"), this.container = e("<div />", n), this.is_multiple ? this.container.html('<ul class="chosen-choices"><li class="search-field"><input type="text" value="' + this.default_text + '" class="default" autocomplete="off" style="width:25px;" /></li></ul><div class="chosen-drop"><ul class="chosen-results"></ul></div>') : this.container.html('<a class="chosen-single chosen-default"><span>' + this.default_text + '</span><div><b></b></div></a><div class="chosen-drop"><div class="chosen-search"><input type="text" autocomplete="off" /></div><ul class="chosen-results"></ul></div>'), this.form_field_jq.hide().after(this.container), this.dropdown = this.container.find("div.chosen-drop").first(), this.search_field = this.container.find("input").first(), this.search_results = this.container.find("ul.chosen-results").first(), this.search_field_scale(), this.search_no_results = this.container.find("li.no-results").first(), this.is_multiple ? (this.search_choices = this.container.find("ul.chosen-choices").first(), this.search_container = this.container.find("li.search-field").first()) : (this.search_container = this.container.find("div.chosen-search").first(), this.selected_item = this.container.find(".chosen-single").first()), this.results_build(), this.set_tab_index(), this.set_label_behavior()
        }, r.prototype.on_ready = function() {
            return this.form_field_jq.trigger("chosen:ready", {
                chosen: this
            })
        }, r.prototype.register_observers = function() {
            var e = this;
            return this.container.bind("touchstart.chosen", function(t) {
                return e.container_mousedown(t), t.preventDefault()
            }), this.container.bind("touchend.chosen", function(t) {
                return e.container_mouseup(t), t.preventDefault()
            }), this.container.bind("mousedown.chosen", function(t) {
                e.container_mousedown(t)
            }), this.container.bind("mouseup.chosen", function(t) {
                e.container_mouseup(t)
            }), this.container.bind("mouseenter.chosen", function(t) {
                e.mouse_enter(t)
            }), this.container.bind("mouseleave.chosen", function(t) {
                e.mouse_leave(t)
            }), this.search_results.bind("mouseup.chosen", function(t) {
                e.search_results_mouseup(t)
            }), this.search_results.bind("mouseover.chosen", function(t) {
                e.search_results_mouseover(t)
            }), this.search_results.bind("mouseout.chosen", function(t) {
                e.search_results_mouseout(t)
            }), this.search_results.bind("mousewheel.chosen DOMMouseScroll.chosen", function(t) {
                e.search_results_mousewheel(t)
            }), this.search_results.bind("touchstart.chosen", function(t) {
                e.search_results_touchstart(t)
            }), this.search_results.bind("touchmove.chosen", function(t) {
                e.search_results_touchmove(t)
            }), this.search_results.bind("touchend.chosen", function(t) {
                e.search_results_touchend(t)
            }), this.form_field_jq.bind("chosen:updated.chosen", function(t) {
                e.results_update_field(t)
            }), this.form_field_jq.bind("chosen:activate.chosen", function(t) {
                e.activate_field(t)
            }), this.form_field_jq.bind("chosen:open.chosen", function(t) {
                e.container_mousedown(t)
            }), this.form_field_jq.bind("chosen:close.chosen", function(t) {
                e.input_blur(t)
            }), this.search_field.bind("blur.chosen", function(t) {
                e.input_blur(t)
            }), this.search_field.bind("keyup.chosen", function(t) {
                e.keyup_checker(t)
            }), this.search_field.bind("keydown.chosen", function(t) {
                e.keydown_checker(t)
            }), this.search_field.bind("focus.chosen", function(t) {
                e.input_focus(t)
            }), this.search_field.bind("cut.chosen", function(t) {
                e.clipboard_event_checker(t)
            }), this.search_field.bind("paste.chosen", function(t) {
                e.clipboard_event_checker(t)
            }), this.is_multiple ? this.search_choices.bind("click.chosen", function(t) {
                e.choices_click(t)
            }) : this.container.bind("click.chosen", function(e) {
                e.preventDefault()
            })
        }, r.prototype.destroy = function() {
            return e(this.container[0].ownerDocument).unbind("click.chosen", this.click_test_action), this.search_field[0].tabIndex && (this.form_field_jq[0].tabIndex = this.search_field[0].tabIndex), this.container.remove(), this.form_field_jq.removeData("chosen"), this.form_field_jq.show()
        }, r.prototype.search_field_disabled = function() {
            return this.is_disabled = this.form_field_jq[0].disabled, this.is_disabled ? (this.container.addClass("chosen-disabled"), this.search_field[0].disabled = !0, this.is_multiple || this.selected_item.unbind("focus.chosen", this.activate_action), this.close_field()) : (this.container.removeClass("chosen-disabled"), this.search_field[0].disabled = !1, this.is_multiple ? void 0 : this.selected_item.bind("focus.chosen", this.activate_action))
        }, r.prototype.container_mousedown = function(t) {
            if (!this.is_disabled && (t && "mousedown" === t.type && !this.results_showing && t.preventDefault(), null == t || !e(t.target).hasClass("search-choice-close"))) return this.active_field ? this.is_multiple || !t || e(t.target)[0] !== this.selected_item[0] && !e(t.target).parents("a.chosen-single").length || (t.preventDefault(), this.results_toggle()) : (this.is_multiple && this.search_field.val(""), e(this.container[0].ownerDocument).bind("click.chosen", this.click_test_action), this.results_show()), this.activate_field()
        }, r.prototype.container_mouseup = function(e) {
            if ("ABBR" === e.target.nodeName && !this.is_disabled) return this.results_reset(e)
        }, r.prototype.search_results_mousewheel = function(e) {
            var t;
            if (e.originalEvent && (t = e.originalEvent.deltaY || -e.originalEvent.wheelDelta || e.originalEvent.detail), null != t) return e.preventDefault(), "DOMMouseScroll" === e.type && (t *= 40), this.search_results.scrollTop(t + this.search_results.scrollTop())
        }, r.prototype.blur_test = function(e) {
            if (!this.active_field && this.container.hasClass("chosen-container-active")) return this.close_field()
        }, r.prototype.close_field = function() {
            return e(this.container[0].ownerDocument).unbind("click.chosen", this.click_test_action), this.active_field = !1, this.results_hide(), this.container.removeClass("chosen-container-active"), this.clear_backstroke(), this.show_search_field_default(), this.search_field_scale()
        }, r.prototype.activate_field = function() {
            return this.container.addClass("chosen-container-active"), this.active_field = !0, this.search_field.val(this.search_field.val()), this.search_field.focus()
        }, r.prototype.test_active_click = function(t) {
            var n;
            return (n = e(t.target).closest(".chosen-container")).length && this.container[0] === n[0] ? this.active_field = !0 : this.close_field()
        }, r.prototype.results_build = function() {
            return this.parsing = !0, this.selected_option_count = null, this.results_data = i.select_to_array(this.form_field), this.is_multiple ? this.search_choices.find("li.search-choice").remove() : this.is_multiple || (this.single_set_selected_text(), this.disable_search || this.form_field.options.length <= this.disable_search_threshold ? (this.search_field[0].readOnly = !0, this.container.addClass("chosen-container-single-nosearch")) : (this.search_field[0].readOnly = !1, this.container.removeClass("chosen-container-single-nosearch"))), this.update_results_content(this.results_option_build({
                first: !0
            })), this.search_field_disabled(), this.show_search_field_default(), this.search_field_scale(), this.parsing = !1
        }, r.prototype.result_do_highlight = function(e) {
            var t, n, i, s, r;
            if (e.length) {
                if (this.result_clear_highlight(), this.result_highlight = e, this.result_highlight.addClass("highlighted"), i = parseInt(this.search_results.css("maxHeight"), 10), r = this.search_results.scrollTop(), s = i + r, n = this.result_highlight.position().top + this.search_results.scrollTop(), (t = n + this.result_highlight.outerHeight()) >= s) return this.search_results.scrollTop(t - i > 0 ? t - i : 0);
                if (n < r) return this.search_results.scrollTop(n)
            }
        }, r.prototype.result_clear_highlight = function() {
            return this.result_highlight && this.result_highlight.removeClass("highlighted"), this.result_highlight = null
        }, r.prototype.results_show = function() {
            return this.is_multiple && this.max_selected_options <= this.choices_count() ? (this.form_field_jq.trigger("chosen:maxselected", {
                chosen: this
            }), !1) : (this.container.addClass("chosen-with-drop"), this.results_showing = !0, this.search_field.focus(), this.search_field.val(this.search_field.val()), this.winnow_results(), this.form_field_jq.trigger("chosen:showing_dropdown", {
                chosen: this
            }))
        }, r.prototype.update_results_content = function(e) {
            return this.search_results.html(e)
        }, r.prototype.results_hide = function() {
            return this.results_showing && (this.result_clear_highlight(), this.container.removeClass("chosen-with-drop"), this.form_field_jq.trigger("chosen:hiding_dropdown", {
                chosen: this
            })), this.results_showing = !1
        }, r.prototype.set_tab_index = function(e) {
            var t;
            if (this.form_field.tabIndex) return t = this.form_field.tabIndex, this.form_field.tabIndex = -1, this.search_field[0].tabIndex = t
        }, r.prototype.set_label_behavior = function() {
            var t = this;
            if (this.form_field_label = this.form_field_jq.parents("label"), !this.form_field_label.length && this.form_field.id.length && (this.form_field_label = e("label[for='" + this.form_field.id + "']")), this.form_field_label.length > 0) return this.form_field_label.bind("click.chosen", function(e) {
                return t.is_multiple ? t.container_mousedown(e) : t.activate_field()
            })
        }, r.prototype.show_search_field_default = function() {
            return this.is_multiple && this.choices_count() < 1 && !this.active_field ? (this.search_field.val(this.default_text), this.search_field.addClass("default")) : (this.search_field.val(""), this.search_field.removeClass("default"))
        }, r.prototype.search_results_mouseup = function(t) {
            var n;
            if ((n = e(t.target).hasClass("active-result") ? e(t.target) : e(t.target).parents(".active-result").first()).length) return this.result_highlight = n, this.result_select(t), this.search_field.focus()
        }, r.prototype.search_results_mouseover = function(t) {
            var n;
            if (n = e(t.target).hasClass("active-result") ? e(t.target) : e(t.target).parents(".active-result").first()) return this.result_do_highlight(n)
        }, r.prototype.search_results_mouseout = function(t) {
            if (e(t.target).hasClass("active-result")) return this.result_clear_highlight()
        }, r.prototype.choice_build = function(t) {
            var n, i, s = this;
            return n = e("<li />", {
                class: "search-choice"
            }).html("<span>" + this.choice_label(t) + "</span>"), t.disabled ? n.addClass("search-choice-disabled") : ((i = e("<a />", {
                class: "search-choice-close",
                "data-option-array-index": t.array_index
            })).bind("click.chosen", function(e) {
                return s.choice_destroy_link_click(e)
            }), n.append(i)), this.search_container.before(n)
        }, r.prototype.choice_destroy_link_click = function(t) {
            if (t.preventDefault(), t.stopPropagation(), !this.is_disabled) return this.choice_destroy(e(t.target))
        }, r.prototype.choice_destroy = function(e) {
            if (this.result_deselect(e[0].getAttribute("data-option-array-index"))) return this.show_search_field_default(), this.is_multiple && this.choices_count() > 0 && this.search_field.val().length < 1 && this.results_hide(), e.parents("li").first().remove(), this.search_field_scale()
        }, r.prototype.results_reset = function() {
            if (this.reset_single_select_options(), this.form_field.options[0].selected = !0, this.single_set_selected_text(), this.show_search_field_default(), this.results_reset_cleanup(), this.form_field_jq.trigger("change"), this.active_field) return this.results_hide()
        }, r.prototype.results_reset_cleanup = function() {
            return this.current_selectedIndex = this.form_field.selectedIndex, this.selected_item.find("abbr").remove()
        }, r.prototype.result_select = function(e) {
            var t, n;
            if (this.result_highlight) return t = this.result_highlight, this.result_clear_highlight(), this.is_multiple && this.max_selected_options <= this.choices_count() ? (this.form_field_jq.trigger("chosen:maxselected", {
                chosen: this
            }), !1) : (this.is_multiple ? t.removeClass("active-result") : this.reset_single_select_options(), t.addClass("result-selected"), n = this.results_data[t[0].getAttribute("data-option-array-index")], n.selected = !0, this.form_field.options[n.options_index].selected = !0, this.selected_option_count = null, this.is_multiple ? this.choice_build(n) : this.single_set_selected_text(this.choice_label(n)), (e.metaKey || e.ctrlKey) && this.is_multiple || this.results_hide(), this.show_search_field_default(), (this.is_multiple || this.form_field.selectedIndex !== this.current_selectedIndex) && this.form_field_jq.trigger("change", {
                selected: this.form_field.options[n.options_index].value
            }), this.current_selectedIndex = this.form_field.selectedIndex, e.preventDefault(), this.search_field_scale())
        }, r.prototype.single_set_selected_text = function(e) {
            return null == e && (e = this.default_text), e === this.default_text ? this.selected_item.addClass("chosen-default") : (this.single_deselect_control_build(), this.selected_item.removeClass("chosen-default")), this.selected_item.find("span").html(e)
        }, r.prototype.result_deselect = function(e) {
            var t;
            return t = this.results_data[e], !this.form_field.options[t.options_index].disabled && (t.selected = !1, this.form_field.options[t.options_index].selected = !1, this.selected_option_count = null, this.result_clear_highlight(), this.results_showing && this.winnow_results(), this.form_field_jq.trigger("change", {
                deselected: this.form_field.options[t.options_index].value
            }), this.search_field_scale(), !0)
        }, r.prototype.single_deselect_control_build = function() {
            if (this.allow_single_deselect) return this.selected_item.find("abbr").length || this.selected_item.find("span").first().after('<abbr class="search-choice-close"></abbr>'), this.selected_item.addClass("chosen-single-with-deselect")
        }, r.prototype.get_search_text = function() {
            return e("<div/>").text(e.trim(this.search_field.val())).html()
        }, r.prototype.winnow_results_set_highlight = function() {
            var e, t;
            if (t = this.is_multiple ? [] : this.search_results.find(".result-selected.active-result"), null != (e = t.length ? t.first() : this.search_results.find(".active-result").first())) return this.result_do_highlight(e)
        }, r.prototype.no_results = function(t) {
            var n;
            return (n = e('<li class="no-results">' + this.results_none_found + ' "<span></span>"</li>')).find("span").first().html(t), this.search_results.append(n), this.form_field_jq.trigger("chosen:no_results", {
                chosen: this
            })
        }, r.prototype.no_results_clear = function() {
            return this.search_results.find(".no-results").remove()
        }, r.prototype.keydown_arrow = function() {
            var e;
            return this.results_showing && this.result_highlight ? (e = this.result_highlight.nextAll("li.active-result").first()) ? this.result_do_highlight(e) : void 0 : this.results_show()
        }, r.prototype.keyup_arrow = function() {
            var e;
            return this.results_showing || this.is_multiple ? this.result_highlight ? (e = this.result_highlight.prevAll("li.active-result")).length ? this.result_do_highlight(e.first()) : (this.choices_count() > 0 && this.results_hide(), this.result_clear_highlight()) : void 0 : this.results_show()
        }, r.prototype.keydown_backstroke = function() {
            var e;
            return this.pending_backstroke ? (this.choice_destroy(this.pending_backstroke.find("a").first()), this.clear_backstroke()) : (e = this.search_container.siblings("li.search-choice").last()).length && !e.hasClass("search-choice-disabled") ? (this.pending_backstroke = e, this.single_backstroke_delete ? this.keydown_backstroke() : this.pending_backstroke.addClass("search-choice-focus")) : void 0
        }, r.prototype.clear_backstroke = function() {
            return this.pending_backstroke && this.pending_backstroke.removeClass("search-choice-focus"), this.pending_backstroke = null
        }, r.prototype.keydown_checker = function(e) {
            var t, n;
            switch (t = null != (n = e.which) ? n : e.keyCode, this.search_field_scale(), 8 !== t && this.pending_backstroke && this.clear_backstroke(), t) {
                case 8:
                    this.backstroke_length = this.search_field.val().length;
                    break;
                case 9:
                    this.results_showing && !this.is_multiple && this.result_select(e), this.mouse_on_container = !1;
                    break;
                case 13:
                    this.results_showing && e.preventDefault();
                    break;
                case 32:
                    this.disable_search && e.preventDefault();
                    break;
                case 38:
                    e.preventDefault(), this.keyup_arrow();
                    break;
                case 40:
                    e.preventDefault(), this.keydown_arrow()
            }
        }, r.prototype.search_field_scale = function() {
            var t, n, i, s, r, o, a, l;
            if (this.is_multiple) {
                for (0, o = 0, s = "position:absolute; left: -1000px; top: -1000px; display:none;", a = 0, l = (r = ["font-size", "font-style", "font-weight", "font-family", "line-height", "text-transform", "letter-spacing"]).length; a < l; a++) s += (i = r[a]) + ":" + this.search_field.css(i) + ";";
                return (t = e("<div />", {
                    style: s
                })).text(this.search_field.val()), e("body").append(t), o = t.width() + 25, t.remove(), n = this.container.outerWidth(), o > n - 10 && (o = n - 10), this.search_field.css({
                    width: o + "px"
                })
            }
        }, r
    }()
}.call(this),
    function(e) {
        function t(t) {
            if (e.facebox.settings.inited) return !0;
            e.facebox.settings.inited = !0, e(document).trigger("init.facebox");
            var n = e.facebox.settings.imageTypes.join("|");
            e.facebox.settings.imageTypesRegexp = new RegExp("." + n + "$", "i"), t && e.extend(e.facebox.settings, t), e("body").append(e.facebox.settings.faceboxHtml);
            var i = [new Image, new Image];
            i[0].src = e.facebox.settings.closeImage, i[1].src = e.facebox.settings.loadingImage, e("#facebox").find(".b:first, .bl, .br, .tl, .tr").each(function() {
                i.push(new Image), i.slice(-1).src = e(this).css("background-image").replace(/url\((.+)\)/, "$1")
            }), e("#facebox .close").click(e.facebox.close), e("#facebox .close_image").attr("src", e.facebox.settings.closeImage)
        }

        function n(t, n) {
            if (t.match(/#/)) {
                var r = window.location.href.split("#")[0],
                    o = t.replace(r, "");
                e.facebox.reveal(e(o).clone().show(), n)
            } else t.match(e.facebox.settings.imageTypesRegexp) ? i(t, n) : s(t, n)
        }

        function i(t, n) {
            var i = new Image;
            i.onload = function() {
                e.facebox.reveal('<div class="image"><img src="' + i.src + '" /></div>', n)
            }, i.src = t
        }

        function s(t, n) {
            e.get(t, function(t) {
                e.facebox.reveal(t, n)
            })
        }

        function r() {
            return 0 == e.facebox.settings.overlay || null === e.facebox.settings.opacity
        }
        e.facebox = function(t, r) {
            e.facebox.loading(t.opacity), t.nofooter && e("#facebox .footer").remove(), t.width && e("#facebox .body").width(t.width), t.addclass && e("#facebox").addClass(t.addclass), t.ajax ? s(t.ajax) : t.image ? i(t.image) : t.div ? n(t.div) : e.isFunction(t) ? t.call(e) : e.facebox.reveal(t, r)
        }, e.extend(e.facebox, {
            settings: {
                opacity: .5,
                overlay: !0,
                loadingImage: "templates/default/img/facebox/loading.gif",
                closeImage: "templates/default/img/facebox/closelabel.gif",
                imageTypes: ["png", "jpg", "jpeg", "gif"],
                faceboxHtml: '<div id="facebox" style="display:none;"><div class="popup"><table><tbody><tr><td class="tl"/><td class="b"/><td class="tr"/></tr><tr><td class="b"/><td class="body"><div class="content"></div><div class="footer"><a href="#" class="close"><img src="templates/default/js/facebox/closelabel.gif" title="close" class="close_image" /></a></div></td><td class="b"/></tr><tr><td class="bl"/><td class="b"/><td class="br"/></tr></tbody></table></div></div>'
            },
            loading: function(n) {
                if (t(), 1 == e("#facebox .loading").length) return !0;
                ! function(t) {
                    if (!r()) 0 == e("facebox_overlay").length && e("body").append('<div id="facebox_overlay" class="facebox_hide"></div>'), e("#facebox_overlay").hide().addClass("facebox_overlayBG").css("opacity", t || e.facebox.settings.opacity).click(function() {
                        e(document).trigger("close.facebox")
                    }).fadeIn(200)
                }(n), e("#facebox .content").empty(), e("#facebox .body").children().hide().end().append('<div class="loading"><img src="' + e.facebox.settings.loadingImage + '"/></div>'), e("#facebox").css({
                    top: function() {
                        var e, t;
                        return self.pageYOffset ? (t = self.pageYOffset, e = self.pageXOffset) : document.documentElement && document.documentElement.scrollTop ? (t = document.documentElement.scrollTop, e = document.documentElement.scrollLeft) : document.body && (t = document.body.scrollTop, e = document.body.scrollLeft), new Array(e, t)
                    }()[1] + function() {
                        var e;
                        return self.innerHeight ? e = self.innerHeight : document.documentElement && document.documentElement.clientHeight ? e = document.documentElement.clientHeight : document.body && (e = document.body.clientHeight), e
                    }() / 10,
                    left: 385.5
                }).show(), e(document).bind("keydown.facebox", function(t) {
                    return 27 == t.keyCode && e.facebox.close(), !0
                }), e(document).trigger("loading.facebox")
            },
            reveal: function(t, n) {
                e(document).trigger("beforeReveal.facebox"), n && e("#facebox .content").addClass(n), e("#facebox .content").append(t), e("#facebox .loading").remove(), e("#facebox .body").children().fadeIn("normal"), e("#facebox").css("left", e(window).width() / 2 - e("#facebox table").width() / 2), e(document).trigger("reveal.facebox").trigger("afterReveal.facebox")
            },
            close: function() {
                return e(document).trigger("close.facebox"), !1
            }
        }), e.fn.facebox = function(i) {
            return t(i), this.click(function() {
                e.facebox.loading(!0);
                var t = this.rel.match(/facebox\[?\.(\w+)\]?/);
                return t && (t = t[1]), n(this.href, t), !1
            })
        }, e(document).bind("close.facebox", function() {
            e(document).unbind("keydown.facebox"), e("#facebox").fadeOut(function() {
                e("#facebox .content").removeClass().addClass("content"),
                    function() {
                        if (!r()) e("#facebox_overlay").fadeOut(200, function() {
                            e("#facebox_overlay").removeClass("facebox_overlayBG"), e("#facebox_overlay").addClass("facebox_hide"), e("#facebox_overlay").remove()
                        })
                    }(), e("#facebox .loading").remove()
            })
        })
    }(jQuery), jQuery.extend({
        highlight: function(e, t, n, i) {
            if (3 === e.nodeType) {
                var s = e.data.match(t);
                if (s) {
                    var r = document.createElement(n || "span");
                    r.className = i || "highlight";
                    var o = e.splitText(s.index);
                    o.splitText(s[0].length);
                    var a = o.cloneNode(!0);
                    return r.appendChild(a), o.parentNode.replaceChild(r, o), 1
                }
            } else if (1 === e.nodeType && e.childNodes && !/(script|style)/i.test(e.tagName) && (e.tagName !== n.toUpperCase() || e.className !== i))
                for (var l = 0; l < e.childNodes.length; l++) l += jQuery.highlight(e.childNodes[l], t, n, i);
            return 0
        }
    }), jQuery.fn.unhighlight = function(e) {
        var t = {
            className: "highlight",
            element: "span"
        };
        return jQuery.extend(t, e), this.find(t.element + "." + t.className).each(function() {
            var e = this.parentNode;
            e.replaceChild(this.firstChild, this), e.normalize()
        }).end()
    }, jQuery.fn.highlight = function(e, t) {
        var n = {
            className: "highlight",
            element: "span",
            caseSensitive: !1,
            wordsOnly: !1
        };
        if (jQuery.extend(n, t), e.constructor === String && (e = [e]), e = jQuery.grep(e, function(e, t) {
                return "" != e
            }), 0 == (e = jQuery.map(e, function(e, t) {
                return e.replace(/[-[\]{}()*+?.,\\^$|#\s]/g, "\\$&")
            })).length) return this;
        var i = n.caseSensitive ? "" : "i",
            s = "(" + e.join("|") + ")";
        n.wordsOnly && (s = "\\b" + s + "\\b");
        var r = new RegExp(s, i);
        return this.each(function() {
            jQuery.highlight(this, r, n.element, n.className)
        })
    },
    function(e) {
        e.fn.menuAim = function(t) {
            return this.each(function() {
                (function(t) {
                    var n = e(this),
                        i = null,
                        s = [],
                        r = null,
                        o = null,
                        a = e.extend({
                            rowSelector: "> li",
                            submenuSelector: "*",
                            submenuDirection: "right",
                            tolerance: 75,
                            enter: e.noop,
                            exit: e.noop,
                            activate: e.noop,
                            deactivate: e.noop,
                            exitMenu: e.noop
                        }, t),
                        l = function(e) {
                            e != i && (i && a.deactivate(i), a.activate(e), i = e)
                        },
                        c = function(e) {
                            var t = d();
                            t ? o = setTimeout(function() {
                                c(e)
                            }, t) : l(e)
                        },
                        d = function() {
                            function t(e, t) {
                                return (t.y - e.y) / (t.x - e.x)
                            }
                            if (!i || !e(i).is(a.submenuSelector)) return 0;
                            var o = n.offset(),
                                l = {
                                    x: o.left,
                                    y: o.top - a.tolerance
                                },
                                c = {
                                    x: o.left + n.outerWidth(),
                                    y: l.y
                                },
                                d = {
                                    x: o.left,
                                    y: o.top + n.outerHeight() + a.tolerance
                                },
                                u = {
                                    x: o.left + n.outerWidth(),
                                    y: d.y
                                },
                                h = s[s.length - 1],
                                p = s[0];
                            if (!h) return 0;
                            if (p || (p = h), p.x < o.left || p.x > u.x || p.y < o.top || p.y > u.y) return 0;
                            if (r && h.x == r.x && h.y == r.y) return 0;
                            var f = c,
                                m = u;
                            "left" == a.submenuDirection ? (f = d, m = l) : "below" == a.submenuDirection ? (f = u, m = d) : "above" == a.submenuDirection && (f = l, m = c);
                            var g = t(h, f),
                                v = t(h, m),
                                _ = t(p, f),
                                y = t(p, m);
                            return g < _ && v > y ? (r = h, 300) : (r = null, 0)
                        };
                    n.mouseleave(function() {
                        o && clearTimeout(o), a.exitMenu(this) && (i && a.deactivate(i), i = null)
                    }).find(a.rowSelector).mouseenter(function() {
                        o && clearTimeout(o), a.enter(this), c(this)
                    }).mouseleave(function() {
                        a.exit(this)
                    }).click(function() {
                        l(this)
                    }), e(document).mousemove(function(e) {
                        s.push({
                            x: e.pageX,
                            y: e.pageY
                        }), s.length > 3 && s.shift()
                    })
                }).call(this, t)
            }), this
        }
    }(jQuery),
    function(e) {
        if ("function" == typeof define && define.amd) define(e);
        else if ("object" == typeof exports) module.exports = e();
        else {
            var t = window.Cookies,
                n = window.Cookies = e();
            n.noConflict = function() {
                return window.Cookies = t, n
            }
        }
    }(function() {
        function e() {
            for (var e = 0, t = {}; e < arguments.length; e++) {
                var n = arguments[e];
                for (var i in n) t[i] = n[i]
            }
            return t
        }

        function t(n) {
            function i(t, s, r) {
                var o;
                if ("undefined" != typeof document) {
                    if (arguments.length > 1) {
                        if ("number" == typeof(r = e({
                                path: "/"
                            }, i.defaults, r)).expires) {
                            var a = new Date;
                            a.setMilliseconds(a.getMilliseconds() + 864e5 * r.expires), r.expires = a
                        }
                        try {
                            o = JSON.stringify(s), /^[\{\[]/.test(o) && (s = o)
                        } catch (e) {}
                        return s = n.write ? n.write(s, t) : encodeURIComponent(String(s)).replace(/%(23|24|26|2B|3A|3C|3E|3D|2F|3F|40|5B|5D|5E|60|7B|7D|7C)/g, decodeURIComponent), t = encodeURIComponent(String(t)), t = t.replace(/%(23|24|26|2B|5E|60|7C)/g, decodeURIComponent), t = t.replace(/[\(\)]/g, escape), document.cookie = [t, "=", s, r.expires && "; expires=" + r.expires.toUTCString(), r.path && "; path=" + r.path, r.domain && "; domain=" + r.domain, r.secure ? "; secure" : ""].join("")
                    }
                    t || (o = {});
                    for (var l = document.cookie ? document.cookie.split("; ") : [], c = /(%[0-9A-Z]{2})+/g, d = 0; d < l.length; d++) {
                        var u = l[d].split("="),
                            h = u.slice(1).join("=");
                        '"' === h.charAt(0) && (h = h.slice(1, -1));
                        try {
                            var p = u[0].replace(c, decodeURIComponent);
                            if (h = n.read ? n.read(h, p) : n(h, p) || h.replace(c, decodeURIComponent), this.json) try {
                                h = JSON.parse(h)
                            } catch (e) {}
                            if (t === p) {
                                o = h;
                                break
                            }
                            t || (o[p] = h)
                        } catch (e) {}
                    }
                    return o
                }
            }
            return i.set = i, i.get = function(e) {
                return i(e)
            }, i.getJSON = function() {
                return i.apply({
                    json: !0
                }, [].slice.call(arguments))
            }, i.defaults = {}, i.remove = function(t, n) {
                i(t, "", e(n, {
                    expires: -1
                }))
            }, i.withConverter = t, i
        }
        return t(function() {})
    }),
    function(e, t) {
        "function" == typeof define && define.amd ? define(t) : "object" == typeof exports ? module.exports = t() : e.NProgress = t()
    }(this, function() {
        function e(e, t, n) {
            return t > e ? t : e > n ? n : e
        }

        function t(e) {
            return 100 * (-1 + e)
        }

        function n(e, t) {
            return ("string" == typeof e ? e : r(e)).indexOf(" " + t + " ") >= 0
        }

        function i(e, t) {
            var i = r(e),
                s = i + t;
            n(i, t) || (e.className = s.substring(1))
        }

        function s(e, t) {
            var i, s = r(e);
            n(e, t) && (i = s.replace(" " + t + " ", " "), e.className = i.substring(1, i.length - 1))
        }

        function r(e) {
            return (" " + (e && e.className || "") + " ").replace(/\s+/gi, " ")
        }

        function o(e) {
            e && e.parentNode && e.parentNode.removeChild(e)
        }
        var a = {};
        a.version = "0.2.0";
        var l = a.settings = {
            minimum: .08,
            easing: "linear",
            positionUsing: "",
            speed: 350,
            trickle: !0,
            trickleSpeed: 250,
            showSpinner: !0,
            barSelector: '[role="bar"]',
            spinnerSelector: '[role="spinner"]',
            parent: "body",
            template: '<div class="bar" role="bar"><div class="peg"></div></div><div class="spinner" role="spinner"><div class="spinner-icon"></div></div>'
        };
        a.configure = function(e) {
                var t, n;
                for (t in e) void 0 !== (n = e[t]) && e.hasOwnProperty(t) && (l[t] = n);
                return this
            }, a.status = null, a.set = function(n) {
                var i = a.isStarted();
                n = e(n, l.minimum, 1), a.status = 1 === n ? null : n;
                var s = a.render(!i),
                    r = s.querySelector(l.barSelector),
                    o = l.speed,
                    u = l.easing;
                return s.offsetWidth, c(function(e) {
                    "" === l.positionUsing && (l.positionUsing = a.getPositioningCSS()), d(r, function(e, n, i) {
                        var s;
                        return s = "translate3d" === l.positionUsing ? {
                            transform: "translate3d(" + t(e) + "%,0,0)"
                        } : "translate" === l.positionUsing ? {
                            transform: "translate(" + t(e) + "%,0)"
                        } : {
                            "margin-left": t(e) + "%"
                        }, s.transition = "all " + n + "ms " + i, s
                    }(n, o, u)), 1 === n ? (d(s, {
                        transition: "none",
                        opacity: 1
                    }), s.offsetWidth, setTimeout(function() {
                        d(s, {
                            transition: "all " + o + "ms linear",
                            opacity: 0
                        }), setTimeout(function() {
                            a.remove(), e()
                        }, o)
                    }, o)) : setTimeout(e, o)
                }), this
            }, a.isStarted = function() {
                return "number" == typeof a.status
            }, a.start = function() {
                a.status || a.set(0);
                var e = function() {
                    setTimeout(function() {
                        a.status && (a.trickle(), e())
                    }, l.trickleSpeed)
                };
                return l.trickle && e(), this
            }, a.done = function(e) {
                return e || a.status ? a.inc(.3 + .5 * Math.random()).set(1) : this
            }, a.inc = function(t) {
                var n = a.status;
                return n ? n > 1 ? void 0 : ("number" != typeof t && (t = n >= 0 && .25 > n ? (3 * Math.random() + 3) / 100 : n >= .25 && .65 > n ? 3 * Math.random() / 100 : n >= .65 && .9 > n ? 2 * Math.random() / 100 : n >= .9 && .99 > n ? .005 : 0), n = e(n + t, 0, .994), a.set(n)) : a.start()
            }, a.trickle = function() {
                return a.inc()
            },
            function() {
                var e = 0,
                    t = 0;
                a.promise = function(n) {
                    return n && "resolved" !== n.state() ? (0 === t && a.start(), e++, t++, n.always(function() {
                        0 == --t ? (e = 0, a.done()) : a.set((e - t) / e)
                    }), this) : this
                }
            }(), a.render = function(e) {
                if (a.isRendered()) return document.getElementById("nprogress");
                i(document.documentElement, "nprogress-busy");
                var n = document.createElement("div");
                n.id = "nprogress", n.innerHTML = l.template;
                var s, r = n.querySelector(l.barSelector),
                    c = e ? "-100" : t(a.status || 0),
                    u = document.querySelector(l.parent);
                return d(r, {
                    transition: "all 0 linear",
                    transform: "translate3d(" + c + "%,0,0)"
                }), l.showSpinner || (s = n.querySelector(l.spinnerSelector)) && o(s), u != document.body && i(u, "nprogress-custom-parent"), u.appendChild(n), n
            }, a.remove = function() {
                s(document.documentElement, "nprogress-busy"), s(document.querySelector(l.parent), "nprogress-custom-parent");
                var e = document.getElementById("nprogress");
                e && o(e)
            }, a.isRendered = function() {
                return !!document.getElementById("nprogress")
            }, a.getPositioningCSS = function() {
                var e = document.body.style,
                    t = "WebkitTransform" in e ? "Webkit" : "MozTransform" in e ? "Moz" : "msTransform" in e ? "ms" : "OTransform" in e ? "O" : "";
                return t + "Perspective" in e ? "translate3d" : t + "Transform" in e ? "translate" : "margin"
            };
        var c = function() {
                function e() {
                    var n = t.shift();
                    n && n(e)
                }
                var t = [];
                return function(n) {
                    t.push(n), 1 == t.length && e()
                }
            }(),
            d = function() {
                function e(e) {
                    return e = function(e) {
                        return e.replace(/^-ms-/, "ms-").replace(/-([\da-z])/gi, function(e, t) {
                            return t.toUpperCase()
                        })
                    }(e), i[e] || (i[e] = function(e) {
                        var t = document.body.style;
                        if (e in t) return e;
                        for (var i, s = n.length, r = e.charAt(0).toUpperCase() + e.slice(1); s--;)
                            if ((i = n[s] + r) in t) return i;
                        return e
                    }(e))
                }

                function t(t, n, i) {
                    n = e(n), t.style[n] = i
                }
                var n = ["Webkit", "O", "Moz", "ms"],
                    i = {};
                return function(e, n) {
                    var i, s, r = arguments;
                    if (2 == r.length)
                        for (i in n) void 0 !== (s = n[i]) && n.hasOwnProperty(i) && t(e, i, s);
                    else t(e, r[1], r[2])
                }
            }();
        return a
    }),
    function(e) {
        function t(t, i, s) {
            var r = this;
            return this.on("click.pjax", t, function(t) {
                var o = e.extend({}, m(i, s));
                o.container || (o.container = e(this).attr("data-pjax") || r), n(t, o)
            })
        }

        function n(t, n, i) {
            i = m(n, i);
            var r = t.currentTarget;
            if ("A" !== r.tagName.toUpperCase()) throw "$.fn.pjax or $.pjax.click requires an anchor element";
            if (!(t.which > 1 || t.metaKey || t.ctrlKey || t.shiftKey || t.altKey || location.protocol !== r.protocol || location.hostname !== r.hostname || r.href.indexOf("#") > -1 && f(r) == f(location) || t.isDefaultPrevented())) {
                var o = {
                        url: r.href,
                        container: e(r).attr("data-pjax"),
                        target: r
                    },
                    a = e.extend({}, o, i),
                    l = e.Event("pjax:click");
                e(r).trigger(l, [a]), l.isDefaultPrevented() || (s(a), t.preventDefault(), e(r).trigger("pjax:clicked", [a]))
            }
        }

        function i(t, n, i) {
            i = m(n, i);
            var r = t.currentTarget,
                o = e(r);
            if ("FORM" !== r.tagName.toUpperCase()) throw "$.pjax.submit requires a form element";
            var a = {
                type: (o.attr("method") || "GET").toUpperCase(),
                url: o.attr("action"),
                container: o.attr("data-pjax"),
                target: r
            };
            if ("GET" !== a.type && void 0 !== window.FormData) a.data = new FormData(r), a.processData = !1, a.contentType = !1;
            else {
                if (e(r).find(":file").length) return;
                a.data = e(r).serializeArray()
            }
            s(e.extend({}, a, i)), t.preventDefault()
        }

        function s(t) {
            function n(t, n, s) {
                s || (s = {}), s.relatedTarget = i;
                var r = e.Event(t, s);
                return a.trigger(r, n), !r.isDefaultPrevented()
            }
            t = e.extend(!0, {}, e.ajaxSettings, s.defaults, t), e.isFunction(t.url) && (t.url = t.url());
            var i = t.target,
                r = p(t.url).hash,
                a = t.context = g(t.container);
            t.data || (t.data = {}), e.isArray(t.data) ? t.data.push({
                name: "_pjax",
                value: a.selector
            }) : t.data._pjax = a.selector;
            var l;
            t.beforeSend = function(e, i) {
                if ("GET" !== i.type && (i.timeout = 0), e.setRequestHeader("X-PJAX", "true"), e.setRequestHeader("X-PJAX-Container", a.selector), !n("pjax:beforeSend", [e, i])) return !1;
                i.timeout > 0 && (l = setTimeout(function() {
                    n("pjax:timeout", [e, t]) && e.abort("timeout")
                }, i.timeout), i.timeout = 0);
                var s = p(i.url);
                r && (s.hash = r), t.requestUrl = h(s)
            }, t.complete = function(e, i) {
                l && clearTimeout(l), n("pjax:complete", [e, i, t]), n("pjax:end", [e, t])
            }, t.error = function(e, i, s) {
                var r = y("", e, t),
                    a = n("pjax:error", [e, i, s, t]);
                "GET" == t.type && "abort" !== i && a && o(r.url)
            }, t.success = function(i, l, c) {
                var u = s.state,
                    h = "function" == typeof e.pjax.defaults.version ? e.pjax.defaults.version() : e.pjax.defaults.version,
                    f = c.getResponseHeader("X-PJAX-Version"),
                    m = y(i, c, t),
                    g = p(m.url);
                if (r && (g.hash = r, m.url = g.href), h && f && h !== f) o(m.url);
                else if (m.contents) {
                    s.state = {
                        id: t.id || d(),
                        url: m.url,
                        title: m.title,
                        container: a.selector,
                        fragment: t.fragment,
                        timeout: t.timeout
                    }, (t.push || t.replace) && window.history.replaceState(s.state, m.title, m.url);
                    if (e.contains(t.container, document.activeElement)) try {
                        document.activeElement.blur()
                    } catch (e) {}
                    m.title && (document.title = m.title), n("pjax:beforeReplace", [m.contents, t], {
                        state: s.state,
                        previousState: u
                    }), a.html(m.contents);
                    var v = a.find("input[autofocus], textarea[autofocus]").last()[0];
                    v && document.activeElement !== v && v.focus(),
                        function(t) {
                            if (!t) return;
                            var n = e("script[src]");
                            t.each(function() {
                                var t = this.src,
                                    i = n.filter(function() {
                                        return this.src === t
                                    });
                                if (!i.length) {
                                    var s = document.createElement("script"),
                                        r = e(this).attr("type");
                                    r && (s.type = r), s.src = e(this).attr("src"), document.head.appendChild(s)
                                }
                            })
                        }(m.scripts);
                    var _ = t.scrollTo;
                    if (r) {
                        var b = decodeURIComponent(r.slice(1)),
                            w = document.getElementById(b) || document.getElementsByName(b)[0];
                        w && (_ = e(w).offset().top)
                    }
                    "number" == typeof _ && e(window).scrollTop(_), n("pjax:success", [i, l, c, t])
                } else o(m.url)
            }, s.state || (s.state = {
                id: d(),
                url: window.location.href,
                title: document.title,
                container: a.selector,
                fragment: t.fragment,
                timeout: t.timeout
            }, window.history.replaceState(s.state, document.title)), c(s.xhr), s.options = t;
            var f = s.xhr = e.ajax(t);
            return f.readyState > 0 && (t.push && !t.replace && (! function(e, t) {
                T[e] = t, E.push(e), b(D, 0), b(E, s.defaults.maxCacheLength)
            }(s.state.id, u(a)), window.history.pushState(null, "", t.requestUrl)), n("pjax:start", [f, t]), n("pjax:send", [f, t])), s.xhr
        }

        function r(t, n) {
            var i = {
                url: window.location.href,
                push: !1,
                replace: !0,
                scrollTo: !1
            };
            return s(e.extend(i, m(t, n)))
        }

        function o(e) {
            window.history.replaceState(null, "", s.state.url), window.location.replace(e)
        }

        function a(t) {
            C || c(s.xhr);
            var n, i = s.state,
                r = t.state;
            if (r && r.container) {
                if (C && $ == r.url) return;
                if (i) {
                    if (i.id === r.id) return;
                    n = i.id < r.id ? "forward" : "back"
                }
                var a = T[r.id] || [],
                    l = e(a[0] || r.container),
                    d = a[1];
                if (l.length) {
                    i && function(e, t, n) {
                        var i, r;
                        T[t] = n, "forward" === e ? (i = E, r = D) : (i = D, r = E);
                        i.push(t), (t = r.pop()) && delete T[t];
                        b(i, s.defaults.maxCacheLength)
                    }(n, i.id, u(l));
                    var h = e.Event("pjax:popstate", {
                        state: r,
                        direction: n
                    });
                    l.trigger(h);
                    var p = {
                        id: r.id,
                        url: r.url,
                        container: l,
                        push: !1,
                        fragment: r.fragment,
                        timeout: r.timeout,
                        scrollTo: !1
                    };
                    if (d) {
                        l.trigger("pjax:start", [null, p]), s.state = r, r.title && (document.title = r.title);
                        var f = e.Event("pjax:beforeReplace", {
                            state: r,
                            previousState: i
                        });
                        l.trigger(f, [d, p]), l.html(d), l.trigger("pjax:end", [null, p])
                    } else s(p);
                    l[0].offsetHeight
                } else o(location.href)
            }
            C = !1
        }

        function l(t) {
            var n = e.isFunction(t.url) ? t.url() : t.url,
                i = t.type ? t.type.toUpperCase() : "GET",
                s = e("<form>", {
                    method: "GET" === i ? "GET" : "POST",
                    action: n,
                    style: "display:none"
                });
            "GET" !== i && "POST" !== i && s.append(e("<input>", {
                type: "hidden",
                name: "_method",
                value: i.toLowerCase()
            }));
            var r = t.data;
            if ("string" == typeof r) e.each(r.split("&"), function(t, n) {
                var i = n.split("=");
                s.append(e("<input>", {
                    type: "hidden",
                    name: i[0],
                    value: i[1]
                }))
            });
            else if (e.isArray(r)) e.each(r, function(t, n) {
                s.append(e("<input>", {
                    type: "hidden",
                    name: n.name,
                    value: n.value
                }))
            });
            else if ("object" == typeof r) {
                var o;
                for (o in r) s.append(e("<input>", {
                    type: "hidden",
                    name: o,
                    value: r[o]
                }))
            }
            e(document.body).append(s), s.submit()
        }

        function c(t) {
            t && t.readyState < 4 && (t.onreadystatechange = e.noop, t.abort())
        }

        function d() {
            return (new Date).getTime()
        }

        function u(e) {
            var t = e.clone();
            return t.find("script").each(function() {
                this.src || jQuery._data(this, "globalEval", !1)
            }), [e.selector, t.contents()]
        }

        function h(e) {
            return e.search = e.search.replace(/([?&])(_pjax|_)=[^&]*/g, ""), e.href.replace(/\?($|#)/, "$1")
        }

        function p(e) {
            var t = document.createElement("a");
            return t.href = e, t
        }

        function f(e) {
            return e.href.replace(/#.*/, "")
        }

        function m(t, n) {
            return t && n ? n.container = t : n = e.isPlainObject(t) ? t : {
                container: t
            }, n.container && (n.container = g(n.container)), n
        }

        function g(t) {
            if ((t = e(t)).length) {
                if ("" !== t.selector && t.context === document) return t;
                if (t.attr("id")) return e("#" + t.attr("id"));
                throw "cant get selector for pjax container!"
            }
            throw "no pjax container for " + t.selector
        }

        function v(e, t) {
            return e.filter(t).add(e.find(t))
        }

        function _(t) {
            return e.parseHTML(t, document, !0)
        }

        function y(t, n, i) {
            var s = {},
                r = /<html/i.test(t),
                o = n.getResponseHeader("X-PJAX-URL");
            if (s.url = o ? h(p(o)) : i.requestUrl, r) var a = e(_(t.match(/<head[^>]*>([\s\S.]*)<\/head>/i)[0])),
                l = e(_(t.match(/<body[^>]*>([\s\S.]*)<\/body>/i)[0]));
            else a = l = e(_(t));
            if (0 === l.length) return s;
            if (s.title = v(a, "title").last().text(), i.fragment) {
                if ("body" === i.fragment) var c = l;
                else c = v(l, i.fragment).first();
                c.length && (s.contents = "body" === i.fragment ? c : c.contents(), s.title || (s.title = c.attr("title") || c.data("title")))
            } else r || (s.contents = l);
            return s.contents && (s.contents = s.contents.not(function() {
                return e(this).is("title")
            }), s.contents.find("title").remove(), s.scripts = v(s.contents, "script[src]").remove(), s.contents = s.contents.not(s.scripts)), s.title && (s.title = e.trim(s.title)), s
        }

        function b(e, t) {
            for (; e.length > t;) delete T[e.shift()]
        }

        function w() {
            return e("meta").filter(function() {
                var t = e(this).attr("http-equiv");
                return t && "X-PJAX-VERSION" === t.toUpperCase()
            }).attr("content")
        }

        function x() {
            e.fn.pjax = t, e.pjax = s, e.pjax.enable = e.noop, e.pjax.disable = k, e.pjax.click = n, e.pjax.submit = i, e.pjax.reload = r, e.pjax.defaults = {
                timeout: 650,
                push: !0,
                replace: !1,
                type: "GET",
                dataType: "html",
                scrollTo: 0,
                maxCacheLength: 20,
                version: w
            }, e(window).on("popstate.pjax", a)
        }

        function k() {
            e.fn.pjax = function() {
                return this
            }, e.pjax = l, e.pjax.enable = x, e.pjax.disable = e.noop, e.pjax.click = e.noop, e.pjax.submit = e.noop, e.pjax.reload = function() {
                window.location.reload()
            }, e(window).off("popstate.pjax", a)
        }
        var C = !0,
            $ = window.location.href,
            S = window.history.state;
        S && S.container && (s.state = S), "state" in window.history && (C = !1);
        var T = {},
            D = [],
            E = [];
        e.inArray("state", e.event.props) < 0 && e.event.props.push("state"), e.support.pjax = window.history && window.history.pushState && window.history.replaceState && !navigator.userAgent.match(/((iPod|iPhone|iPad).+\bOS\s+[1-4]\D|WebApps\/.+CFNetwork)/), e.support.pjax ? x() : k()
    }(jQuery), $.widgets = function() {
        var e = this;
        this.actionDefinitions = {}, this.registerAction = function(t) {
            e.actionDefinitions[t.handle] = t
        }, this.saveWidgetOrder = function() {
            var e = {};
            $("[data-widget-panel]").each(function(t) {
                var n = $(this).attr("data-widget-panel");
                e[n] = [], $(this).find("[data-widget-id]").each(function() {
                    e[n].push($(this).attr("data-widget-id"))
                })
            }), $.post("?cmd=adminwidgets&action=sortorder", e)
        }, $.fn.getWidgetState = function(e) {
            var t = void 0,
                n = $($(this).data("parentWidget")).data("widgetParameters");
            return n && (t = n.id ? localStorage.getItem($($(this).data("parentWidget")).data("widgetId") + "." + e) : n[e]), t
        }, $.fn.setWidgetState = function(e, t) {
            var n = $($(this).data("parentWidget")).data("widgetParameters");
            return !!n && (!!n.id && (localStorage.setItem($($(this).data("parentWidget")).data("widgetId") + "." + e, t), !0))
        }, this.registerAction({
            handle: "collapse",
            onClick: function() {
                var e = $(this),
                    t = e.closest("[data-is-widget]");
                e.find("i").toggleClass("fa-minus").toggleClass("fa-plus");
                var n = {};
                n.target = ".box-body, .box-footer";
                var i = t.find(n.target).is(":visible");
                t.find(n.target).slideToggle(100, "linear", function() {
                    t.toggleClass("collapsed-box", !!i)
                });
                var s = t.attr("data-widget-id");
                $.post("?cmd=adminwidgets", {
                    widget: s,
                    action: i ? "collapse" : "uncollapse"
                }), t.trigger(i ? "collapsed" : "uncollapsed")
            }
        }), this.registerAction({
            handle: "expand",
            onClick: function() {
                var e = $(this).closest("[data-is-widget]");
                $(".top-widgets").append(e), $.widgets().saveWidgetOrder(), e.trigger("expanded")
            }
        }), this.registerAction({
            handle: "refresh",
            onClick: function(e, t) {
                $(this).data("actionParameters");
                var n = $(this).closest("[data-is-widget]");
                n.trigger("refresh"), n.append('<div class="overlay"><img src="ajax-loading.gif" /></div>');
                var i = n.attr("data-widget-id");
                $.post("?cmd=adminwidgets&action=refresh", {
                    widget: i
                }, function(e) {
                    n.find(".overlay").remove();
                    var t = parse_response(e);
                    t && "string" == typeof t && n.find(".box-body").html(t), n.trigger("refreshed")
                })
            }
        }), this.registerAction({
            handle: "autorefresh",
            onClick: function() {
                var e = $(this).closest("[data-is-widget]").attr("data-widget-id");
                bootbox.prompt("Enter auto-refresh period, 0 to disable", function(t) {
                    null === t || $.post("?cmd=adminwidgets&action=autorefresh", {
                        widget: e,
                        autorefresh: t
                    }, function(e) {
                        parse_response(e);
                        location.reload()
                    })
                })
            }
        }), this.registerAction({
            handle: "remove",
            onClick: function() {
                var e = $(this).closest("[data-is-widget]"),
                    t = e.attr("data-widget-id");
                bootbox.confirm("Delete this panel?", function(n) {
                    n && ($.post("?cmd=adminwidgets&action=remove", {
                        widget: t
                    }, function(t) {
                        parse_response(t);
                        e.remove()
                    }), e.remove())
                }), e.trigger("removed")
            }
        });
        return this.init = function(t) {
            t = t || {};
            var n = function(e) {
                for (var t = {}, n = [], i = 0, s = e.length; i < s; ++i) t.hasOwnProperty(e[i]) || (n.push(e[i]), t[e[i]] = 1);
                return n
            }($("[data-widget-group]").map(function() {
                return $(this).data("widget-group")
            }).get());
            $.each($("[data-is-widget]"), function() {
                var n = $(this),
                    i = n.closest("[data-widget-group]").attr("data-widget-group");
                try {
                    var s = n.attr("data-is-widget"),
                        r = void 0;
                    if (s.length > 0) {
                        s = $.parseJSON(s), n.data("widgetParameters", s), s && s.id && (r = i + "." + s.id, n.data("widgetId", r)), "false" == s.draggable ? n.attr("data-widget-static", "") : n.removeAttr("data-widget-static").find(".box-header").css("cursor", "move");
                        var o = n.attr("data-widget-autorefresh");
                        if (o) {
                            var a, l = n.find(".box-widget-refresh");
                            n.on("initialized refreshed noop", function() {
                                window.clearTimeout(a), a = window.setTimeout(function() {
                                    if (n.is(".collapsed-box")) return n.off("uncollapsed.admin-widget").one("uncollapsed.admin-widget", function() {
                                        l.trigger("click")
                                    }), n.trigger("noop");
                                    l.trigger("click")
                                }, 1e3 * o)
                            })
                        }
                        if (s.id)
                            for (var c in s) "id" != c && s.hasOwnProperty(c) && void 0 == localStorage.getItem(r + "." + c) && (localStorage.setItem(r + "." + c, s[c]), console.log(r + "." + c, s[c]))
                    }
                } catch (e) {
                    console.log(e)
                }
                $("[data-widget]", n).each(function() {
                    var t = $(this),
                        n = t.attr("data-widget"),
                        i = e.actionDefinitions[n];
                    if (void 0 !== i) {
                        i.html && t.append($(i.html));
                        try {
                            var s = t.attr("data-action-" + n);
                            void 0 !== s && (0 == s.length && (s = "{}"), t.data("actionParameters", $.parseJSON(s)))
                        } catch (e) {
                            console.log(e)
                        }
                        t.data("actionDefinition", i), t.data("parentWidget", t.closest("[data-is-widget]")), i.onClick && t.on("click.admin-widget", i.onClick), i.onInit && i.onInit.call(this)
                    }
                }), n.trigger("initialized", [s, t])
            });
            for (var i = n.length - 1; i >= 0; i--) $('[data-widget-group="' + n[i] + '"]').sortable({
                connectWith: '[data-widget-group="' + n[i] + '"]',
                items: "[data-is-widget]:not([data-widget-static])",
                placeholder: "sort-highlight",
                handle: ".box-header",
                start: function(e, t) {
                    t.placeholder.height(t.helper.outerHeight() - 4)
                },
                stop: function(e, t) {
                    $.widgets().saveWidgetOrder()
                }
            });
            $("#addnewwidget").click(function() {
                var e = bootbox.dialog({
                    message: '<select class="form-control"><option>Loading ...</option></select>',
                    title: $(this).text(),
                    buttons: {
                        cancel: {
                            label: "Cancel",
                            className: "btn-defaultr"
                        },
                        confirm: {
                            label: "Activate",
                            className: "btn-success",
                            callback: function(t) {
                                return e.find("form").submit(), !0
                            }
                        }
                    }
                });
                $.get("?cmd=adminwidgets&action=activate", function(t) {
                    e.find(".bootbox-body").html(parse_response(t))
                })
            })
        }, this
    },
    function(e) {
        "use strict";
        "function" == typeof define && define.amd ? define(["jquery"], e) : "object" == typeof exports ? e(require("jquery")) : e(window.jQuery)
    }(function(e) {
        "use strict";
        var t = 0,
            n = e,
            i = "parseJSON";
        "JSON" in window && "parse" in JSON && (n = JSON, i = "parse"), e.ajaxTransport("iframe", function(n) {
            if (n.async) {
                var i, s, r, o = n.initialIframeSrc || "javascript:false;";
                return {
                    send: function(a, l) {
                        (i = e('<form style="display:none;"></form>')).attr("accept-charset", n.formAcceptCharset), r = /\?/.test(n.url) ? "&" : "?", "DELETE" === n.type ? (n.url = n.url + r + "_method=DELETE", n.type = "POST") : "PUT" === n.type ? (n.url = n.url + r + "_method=PUT", n.type = "POST") : "PATCH" === n.type && (n.url = n.url + r + "_method=PATCH", n.type = "POST"), s = e('<iframe src="' + o + '" name="iframe-transport-' + (t += 1) + '"></iframe>').bind("load", function() {
                            var t, r = e.isArray(n.paramName) ? n.paramName : [n.paramName];
                            s.unbind("load").bind("load", function() {
                                var t;
                                try {
                                    if (!(t = s.contents()).length || !t[0].firstChild) throw new Error
                                } catch (e) {
                                    t = void 0
                                }
                                l(200, "success", {
                                    iframe: t
                                }), e('<iframe src="' + o + '"></iframe>').appendTo(i), window.setTimeout(function() {
                                    i.remove()
                                }, 0)
                            }), i.prop("target", s.prop("name")).prop("action", n.url).prop("method", n.type), n.formData && e.each(n.formData, function(t, n) {
                                e('<input type="hidden"/>').prop("name", n.name).val(n.value).appendTo(i)
                            }), n.fileInput && n.fileInput.length && "POST" === n.type && (t = n.fileInput.clone(), n.fileInput.after(function(e) {
                                return t[e]
                            }), n.paramName && n.fileInput.each(function(t) {
                                e(this).prop("name", r[t] || n.paramName)
                            }), i.append(n.fileInput).prop("enctype", "multipart/form-data").prop("encoding", "multipart/form-data"), n.fileInput.removeAttr("form")), i.submit(), t && t.length && n.fileInput.each(function(n, i) {
                                var s = e(t[n]);
                                e(i).prop("name", s.prop("name")).attr("form", s.attr("form")), s.replaceWith(i)
                            })
                        }), i.append(s).appendTo(document.body)
                    },
                    abort: function() {
                        s && s.unbind("load").prop("src", o), i && i.remove()
                    }
                }
            }
        }), e.ajaxSetup({
            converters: {
                "iframe text": function(t) {
                    return t && e(t[0].body).text()
                },
                "iframe json": function(t) {
                    return t && n[i](e(t[0].body).text())
                },
                "iframe html": function(t) {
                    return t && e(t[0].body).html()
                },
                "iframe xml": function(t) {
                    var n = t && t[0];
                    return n && e.isXMLDoc(n) ? n : e.parseXML(n.XMLDocument && n.XMLDocument.xml || e(n.body).html())
                },
                "iframe script": function(t) {
                    return t && e.globalEval(e(t[0].body).text())
                }
            }
        })
    }),
    function(e) {
        "use strict";
        "function" == typeof define && define.amd ? define(["jquery", "jquery-ui/ui/widget"], e) : "object" == typeof exports ? e(require("jquery"), require("./vendor/jquery.ui.widget")) : e(window.jQuery)
    }(function(e) {
        "use strict";

        function t(t) {
            var n = "dragover" === t;
            return function(i) {
                i.dataTransfer = i.originalEvent && i.originalEvent.dataTransfer;
                var s = i.dataTransfer;
                s && -1 !== e.inArray("Files", s.types) && !1 !== this._trigger(t, e.Event(t, {
                    delegatedEvent: i
                })) && (i.preventDefault(), n && (s.dropEffect = "copy"))
            }
        }
        e.support.fileInput = !(new RegExp("(Android (1\\.[0156]|2\\.[01]))|(Windows Phone (OS 7|8\\.0))|(XBLWP)|(ZuneWP)|(WPDesktop)|(w(eb)?OSBrowser)|(webOS)|(Kindle/(1\\.0|2\\.[05]|3\\.0))").test(window.navigator.userAgent) || e('<input type="file">').prop("disabled")), e.support.xhrFileUpload = !(!window.ProgressEvent || !window.FileReader), e.support.xhrFormDataFileUpload = !!window.FormData, e.support.blobSlice = window.Blob && (Blob.prototype.slice || Blob.prototype.webkitSlice || Blob.prototype.mozSlice), e.widget("blueimp.fileupload", {
            options: {
                dropZone: e(document),
                pasteZone: void 0,
                fileInput: void 0,
                replaceFileInput: !0,
                paramName: void 0,
                singleFileUploads: !0,
                limitMultiFileUploads: void 0,
                limitMultiFileUploadSize: void 0,
                limitMultiFileUploadSizeOverhead: 512,
                sequentialUploads: !1,
                limitConcurrentUploads: void 0,
                forceIframeTransport: !1,
                redirect: void 0,
                redirectParamName: void 0,
                postMessage: void 0,
                multipart: !0,
                maxChunkSize: void 0,
                uploadedBytes: void 0,
                recalculateProgress: !0,
                progressInterval: 100,
                bitrateInterval: 500,
                autoUpload: !0,
                messages: {
                    uploadedBytes: "Uploaded bytes exceed file size"
                },
                i18n: function(t, n) {
                    return t = this.messages[t] || t.toString(), n && e.each(n, function(e, n) {
                        t = t.replace("{" + e + "}", n)
                    }), t
                },
                formData: function(e) {
                    return e.serializeArray()
                },
                add: function(t, n) {
                    if (t.isDefaultPrevented()) return !1;
                    (n.autoUpload || !1 !== n.autoUpload && e(this).fileupload("option", "autoUpload")) && n.process().done(function() {
                        n.submit()
                    })
                },
                processData: !1,
                contentType: !1,
                cache: !1,
                timeout: 0
            },
            _specialOptions: ["fileInput", "dropZone", "pasteZone", "multipart", "forceIframeTransport"],
            _blobSlice: e.support.blobSlice && function() {
                return (this.slice || this.webkitSlice || this.mozSlice).apply(this, arguments)
            },
            _BitrateTimer: function() {
                this.timestamp = Date.now ? Date.now() : (new Date).getTime(), this.loaded = 0, this.bitrate = 0, this.getBitrate = function(e, t, n) {
                    var i = e - this.timestamp;
                    return (!this.bitrate || !n || i > n) && (this.bitrate = (t - this.loaded) * (1e3 / i) * 8, this.loaded = t, this.timestamp = e), this.bitrate
                }
            },
            _isXHRUpload: function(t) {
                return !t.forceIframeTransport && (!t.multipart && e.support.xhrFileUpload || e.support.xhrFormDataFileUpload)
            },
            _getFormData: function(t) {
                var n;
                return "function" === e.type(t.formData) ? t.formData(t.form) : e.isArray(t.formData) ? t.formData : "object" === e.type(t.formData) ? (n = [], e.each(t.formData, function(e, t) {
                    n.push({
                        name: e,
                        value: t
                    })
                }), n) : []
            },
            _getTotal: function(t) {
                var n = 0;
                return e.each(t, function(e, t) {
                    n += t.size || 1
                }), n
            },
            _initProgressObject: function(t) {
                var n = {
                    loaded: 0,
                    total: 0,
                    bitrate: 0
                };
                t._progress ? e.extend(t._progress, n) : t._progress = n
            },
            _initResponseObject: function(e) {
                var t;
                if (e._response)
                    for (t in e._response) e._response.hasOwnProperty(t) && delete e._response[t];
                else e._response = {}
            },
            _onProgress: function(t, n) {
                if (t.lengthComputable) {
                    var i, s = Date.now ? Date.now() : (new Date).getTime();
                    if (n._time && n.progressInterval && s - n._time < n.progressInterval && t.loaded !== t.total) return;
                    n._time = s, i = Math.floor(t.loaded / t.total * (n.chunkSize || n._progress.total)) + (n.uploadedBytes || 0), this._progress.loaded += i - n._progress.loaded, this._progress.bitrate = this._bitrateTimer.getBitrate(s, this._progress.loaded, n.bitrateInterval), n._progress.loaded = n.loaded = i, n._progress.bitrate = n.bitrate = n._bitrateTimer.getBitrate(s, i, n.bitrateInterval), this._trigger("progress", e.Event("progress", {
                        delegatedEvent: t
                    }), n), this._trigger("progressall", e.Event("progressall", {
                        delegatedEvent: t
                    }), this._progress)
                }
            },
            _initProgressListener: function(t) {
                var n = this,
                    i = t.xhr ? t.xhr() : e.ajaxSettings.xhr();
                i.upload && (e(i.upload).bind("progress", function(e) {
                    var i = e.originalEvent;
                    e.lengthComputable = i.lengthComputable, e.loaded = i.loaded, e.total = i.total, n._onProgress(e, t)
                }), t.xhr = function() {
                    return i
                })
            },
            _isInstanceOf: function(e, t) {
                return Object.prototype.toString.call(t) === "[object " + e + "]"
            },
            _initXHRData: function(t) {
                var n, i = this,
                    s = t.files[0],
                    r = t.multipart || !e.support.xhrFileUpload,
                    o = "array" === e.type(t.paramName) ? t.paramName[0] : t.paramName;
                t.headers = e.extend({}, t.headers), t.contentRange && (t.headers["Content-Range"] = t.contentRange), r && !t.blob && this._isInstanceOf("File", s) || (t.headers["Content-Disposition"] = 'attachment; filename="' + encodeURI(s.name) + '"'), r ? e.support.xhrFormDataFileUpload && (t.postMessage ? (n = this._getFormData(t), t.blob ? n.push({
                    name: o,
                    value: t.blob
                }) : e.each(t.files, function(i, s) {
                    n.push({
                        name: "array" === e.type(t.paramName) && t.paramName[i] || o,
                        value: s
                    })
                })) : (i._isInstanceOf("FormData", t.formData) ? n = t.formData : (n = new FormData, e.each(this._getFormData(t), function(e, t) {
                    n.append(t.name, t.value)
                })), t.blob ? n.append(o, t.blob, s.name) : e.each(t.files, function(s, r) {
                    (i._isInstanceOf("File", r) || i._isInstanceOf("Blob", r)) && n.append("array" === e.type(t.paramName) && t.paramName[s] || o, r, r.uploadName || r.name)
                })), t.data = n) : (t.contentType = s.type || "application/octet-stream", t.data = t.blob || s), t.blob = null
            },
            _initIframeSettings: function(t) {
                var n = e("<a></a>").prop("href", t.url).prop("host");
                t.dataType = "iframe " + (t.dataType || ""), t.formData = this._getFormData(t), t.redirect && n && n !== location.host && t.formData.push({
                    name: t.redirectParamName || "redirect",
                    value: t.redirect
                })
            },
            _initDataSettings: function(e) {
                this._isXHRUpload(e) ? (this._chunkedUpload(e, !0) || (e.data || this._initXHRData(e), this._initProgressListener(e)), e.postMessage && (e.dataType = "postmessage " + (e.dataType || ""))) : this._initIframeSettings(e)
            },
            _getParamName: function(t) {
                var n = e(t.fileInput),
                    i = t.paramName;
                return i ? e.isArray(i) || (i = [i]) : (i = [], n.each(function() {
                    for (var t = e(this), n = t.prop("name") || "files[]", s = (t.prop("files") || [1]).length; s;) i.push(n), s -= 1
                }), i.length || (i = [n.prop("name") || "files[]"])), i
            },
            _initFormSettings: function(t) {
                t.form && t.form.length || (t.form = e(t.fileInput.prop("form")), t.form.length || (t.form = e(this.options.fileInput.prop("form")))), t.paramName = this._getParamName(t), t.url || (t.url = t.form.prop("action") || location.href), t.type = (t.type || "string" === e.type(t.form.prop("method")) && t.form.prop("method") || "").toUpperCase(), "POST" !== t.type && "PUT" !== t.type && "PATCH" !== t.type && (t.type = "POST"), t.formAcceptCharset || (t.formAcceptCharset = t.form.attr("accept-charset"))
            },
            _getAJAXSettings: function(t) {
                var n = e.extend({}, this.options, t);
                return this._initFormSettings(n), this._initDataSettings(n), n
            },
            _getDeferredState: function(e) {
                return e.state ? e.state() : e.isResolved() ? "resolved" : e.isRejected() ? "rejected" : "pending"
            },
            _enhancePromise: function(e) {
                return e.success = e.done, e.error = e.fail, e.complete = e.always, e
            },
            _getXHRPromise: function(t, n, i) {
                var s = e.Deferred(),
                    r = s.promise();
                return n = n || this.options.context || r, !0 === t ? s.resolveWith(n, i) : !1 === t && s.rejectWith(n, i), r.abort = s.promise, this._enhancePromise(r)
            },
            _addConvenienceMethods: function(t, n) {
                var i = this,
                    s = function(t) {
                        return e.Deferred().resolveWith(i, t).promise()
                    };
                n.process = function(t, r) {
                    return (t || r) && (n._processQueue = this._processQueue = (this._processQueue || s([this])).then(function() {
                        return n.errorThrown ? e.Deferred().rejectWith(i, [n]).promise() : s(arguments)
                    }).then(t, r)), this._processQueue || s([this])
                }, n.submit = function() {
                    return "pending" !== this.state() && (n.jqXHR = this.jqXHR = !1 !== i._trigger("submit", e.Event("submit", {
                        delegatedEvent: t
                    }), this) && i._onSend(t, this)), this.jqXHR || i._getXHRPromise()
                }, n.abort = function() {
                    return this.jqXHR ? this.jqXHR.abort() : (this.errorThrown = "abort", i._trigger("fail", null, this), i._getXHRPromise(!1))
                }, n.state = function() {
                    return this.jqXHR ? i._getDeferredState(this.jqXHR) : this._processQueue ? i._getDeferredState(this._processQueue) : void 0
                }, n.processing = function() {
                    return !this.jqXHR && this._processQueue && "pending" === i._getDeferredState(this._processQueue)
                }, n.progress = function() {
                    return this._progress
                }, n.response = function() {
                    return this._response
                }
            },
            _getUploadedBytes: function(e) {
                var t = e.getResponseHeader("Range"),
                    n = t && t.split("-"),
                    i = n && n.length > 1 && parseInt(n[1], 10);
                return i && i + 1
            },
            _chunkedUpload: function(t, n) {
                t.uploadedBytes = t.uploadedBytes || 0;
                var i, s, r = this,
                    o = t.files[0],
                    a = o.size,
                    l = t.uploadedBytes,
                    c = t.maxChunkSize || a,
                    d = this._blobSlice,
                    u = e.Deferred(),
                    h = u.promise();
                return !(!(this._isXHRUpload(t) && d && (l || ("function" === e.type(c) ? c(t) : c) < a)) || t.data) && (!!n || (l >= a ? (o.error = t.i18n("uploadedBytes"), this._getXHRPromise(!1, t.context, [null, "error", o.error])) : (s = function() {
                    var n = e.extend({}, t),
                        h = n._progress.loaded;
                    n.blob = d.call(o, l, l + ("function" === e.type(c) ? c(n) : c), o.type), n.chunkSize = n.blob.size, n.contentRange = "bytes " + l + "-" + (l + n.chunkSize - 1) + "/" + a, r._initXHRData(n), r._initProgressListener(n), i = (!1 !== r._trigger("chunksend", null, n) && e.ajax(n) || r._getXHRPromise(!1, n.context)).done(function(i, o, c) {
                        l = r._getUploadedBytes(c) || l + n.chunkSize, h + n.chunkSize - n._progress.loaded && r._onProgress(e.Event("progress", {
                            lengthComputable: !0,
                            loaded: l - n.uploadedBytes,
                            total: l - n.uploadedBytes
                        }), n), t.uploadedBytes = n.uploadedBytes = l, n.result = i, n.textStatus = o, n.jqXHR = c, r._trigger("chunkdone", null, n), r._trigger("chunkalways", null, n), l < a ? s() : u.resolveWith(n.context, [i, o, c])
                    }).fail(function(e, t, i) {
                        n.jqXHR = e, n.textStatus = t, n.errorThrown = i, r._trigger("chunkfail", null, n), r._trigger("chunkalways", null, n), u.rejectWith(n.context, [e, t, i])
                    })
                }, this._enhancePromise(h), h.abort = function() {
                    return i.abort()
                }, s(), h)))
            },
            _beforeSend: function(e, t) {
                0 === this._active && (this._trigger("start"), this._bitrateTimer = new this._BitrateTimer, this._progress.loaded = this._progress.total = 0, this._progress.bitrate = 0), this._initResponseObject(t), this._initProgressObject(t), t._progress.loaded = t.loaded = t.uploadedBytes || 0, t._progress.total = t.total = this._getTotal(t.files) || 1, t._progress.bitrate = t.bitrate = 0, this._active += 1, this._progress.loaded += t.loaded, this._progress.total += t.total
            },
            _onDone: function(t, n, i, s) {
                var r = s._progress.total,
                    o = s._response;
                s._progress.loaded < r && this._onProgress(e.Event("progress", {
                    lengthComputable: !0,
                    loaded: r,
                    total: r
                }), s), o.result = s.result = t, o.textStatus = s.textStatus = n, o.jqXHR = s.jqXHR = i, this._trigger("done", null, s)
            },
            _onFail: function(e, t, n, i) {
                var s = i._response;
                i.recalculateProgress && (this._progress.loaded -= i._progress.loaded, this._progress.total -= i._progress.total), s.jqXHR = i.jqXHR = e, s.textStatus = i.textStatus = t, s.errorThrown = i.errorThrown = n, this._trigger("fail", null, i)
            },
            _onAlways: function(e, t, n, i) {
                this._trigger("always", null, i)
            },
            _onSend: function(t, n) {
                n.submit || this._addConvenienceMethods(t, n);
                var i, s, r, o, a = this,
                    l = a._getAJAXSettings(n),
                    c = function() {
                        return a._sending += 1, l._bitrateTimer = new a._BitrateTimer, i = i || ((s || !1 === a._trigger("send", e.Event("send", {
                            delegatedEvent: t
                        }), l)) && a._getXHRPromise(!1, l.context, s) || a._chunkedUpload(l) || e.ajax(l)).done(function(e, t, n) {
                            a._onDone(e, t, n, l)
                        }).fail(function(e, t, n) {
                            a._onFail(e, t, n, l)
                        }).always(function(e, t, n) {
                            if (a._onAlways(e, t, n, l), a._sending -= 1, a._active -= 1, l.limitConcurrentUploads && l.limitConcurrentUploads > a._sending)
                                for (var i = a._slots.shift(); i;) {
                                    if ("pending" === a._getDeferredState(i)) {
                                        i.resolve();
                                        break
                                    }
                                    i = a._slots.shift()
                                }
                            0 === a._active && a._trigger("stop")
                        })
                    };
                return this._beforeSend(t, l), this.options.sequentialUploads || this.options.limitConcurrentUploads && this.options.limitConcurrentUploads <= this._sending ? (this.options.limitConcurrentUploads > 1 ? (r = e.Deferred(), this._slots.push(r), o = r.then(c)) : (this._sequence = this._sequence.then(c, c), o = this._sequence), o.abort = function() {
                    return s = [void 0, "abort", "abort"], i ? i.abort() : (r && r.rejectWith(l.context, s), c())
                }, this._enhancePromise(o)) : c()
            },
            _onAdd: function(t, n) {
                var i, s, r, o, a = this,
                    l = !0,
                    c = e.extend({}, this.options, n),
                    d = n.files,
                    u = d.length,
                    h = c.limitMultiFileUploads,
                    p = c.limitMultiFileUploadSize,
                    f = c.limitMultiFileUploadSizeOverhead,
                    m = 0,
                    g = this._getParamName(c),
                    v = 0;
                if (!u) return !1;
                if (p && void 0 === d[0].size && (p = void 0), (c.singleFileUploads || h || p) && this._isXHRUpload(c))
                    if (c.singleFileUploads || p || !h)
                        if (!c.singleFileUploads && p)
                            for (r = [], i = [], o = 0; o < u; o += 1) m += d[o].size + f, (o + 1 === u || m + d[o + 1].size + f > p || h && o + 1 - v >= h) && (r.push(d.slice(v, o + 1)), (s = g.slice(v, o + 1)).length || (s = g), i.push(s), v = o + 1, m = 0);
                        else i = g;
                else
                    for (r = [], i = [], o = 0; o < u; o += h) r.push(d.slice(o, o + h)), (s = g.slice(o, o + h)).length || (s = g), i.push(s);
                else r = [d], i = [g];
                return n.originalFiles = d, e.each(r || d, function(s, o) {
                    var c = e.extend({}, n);
                    return c.files = r ? o : [o], c.paramName = i[s], a._initResponseObject(c), a._initProgressObject(c), a._addConvenienceMethods(t, c), l = a._trigger("add", e.Event("add", {
                        delegatedEvent: t
                    }), c)
                }), l
            },
            _replaceFileInput: function(t) {
                var n = t.fileInput,
                    i = n.clone(!0),
                    s = n.is(document.activeElement);
                t.fileInputClone = i, e("<form></form>").append(i)[0].reset(), n.after(i).detach(), s && i.focus(), e.cleanData(n.unbind("remove")), this.options.fileInput = this.options.fileInput.map(function(e, t) {
                    return t === n[0] ? i[0] : t
                }), n[0] === this.element[0] && (this.element = i)
            },
            _handleFileTreeEntry: function(t, n) {
                var i, s = this,
                    r = e.Deferred(),
                    o = [],
                    a = function(e) {
                        e && !e.entry && (e.entry = t), r.resolve([e])
                    },
                    l = function() {
                        i.readEntries(function(e) {
                            e.length ? (o = o.concat(e), l()) : function(e) {
                                s._handleFileTreeEntries(e, n + t.name + "/").done(function(e) {
                                    r.resolve(e)
                                }).fail(a)
                            }(o)
                        }, a)
                    };
                return n = n || "", t.isFile ? t._file ? (t._file.relativePath = n, r.resolve(t._file)) : t.file(function(e) {
                    e.relativePath = n, r.resolve(e)
                }, a) : t.isDirectory ? (i = t.createReader(), l()) : r.resolve([]), r.promise()
            },
            _handleFileTreeEntries: function(t, n) {
                var i = this;
                return e.when.apply(e, e.map(t, function(e) {
                    return i._handleFileTreeEntry(e, n)
                })).then(function() {
                    return Array.prototype.concat.apply([], arguments)
                })
            },
            _getDroppedFiles: function(t) {
                var n = (t = t || {}).items;
                return n && n.length && (n[0].webkitGetAsEntry || n[0].getAsEntry) ? this._handleFileTreeEntries(e.map(n, function(e) {
                    var t;
                    return e.webkitGetAsEntry ? ((t = e.webkitGetAsEntry()) && (t._file = e.getAsFile()), t) : e.getAsEntry()
                })) : e.Deferred().resolve(e.makeArray(t.files)).promise()
            },
            _getSingleFileInputFiles: function(t) {
                var n, i, s = (t = e(t)).prop("webkitEntries") || t.prop("entries");
                if (s && s.length) return this._handleFileTreeEntries(s);
                if ((n = e.makeArray(t.prop("files"))).length) void 0 === n[0].name && n[0].fileName && e.each(n, function(e, t) {
                    t.name = t.fileName, t.size = t.fileSize
                });
                else {
                    if (!(i = t.prop("value"))) return e.Deferred().resolve([]).promise();
                    n = [{
                        name: i.replace(/^.*\\/, "")
                    }]
                }
                return e.Deferred().resolve(n).promise()
            },
            _getFileInputFiles: function(t) {
                return t instanceof e && 1 !== t.length ? e.when.apply(e, e.map(t, this._getSingleFileInputFiles)).then(function() {
                    return Array.prototype.concat.apply([], arguments)
                }) : this._getSingleFileInputFiles(t)
            },
            _onChange: function(t) {
                var n = this,
                    i = {
                        fileInput: e(t.target),
                        form: e(t.target.form)
                    };
                this._getFileInputFiles(i.fileInput).always(function(s) {
                    i.files = s, n.options.replaceFileInput && n._replaceFileInput(i), !1 !== n._trigger("change", e.Event("change", {
                        delegatedEvent: t
                    }), i) && n._onAdd(t, i)
                })
            },
            _onPaste: function(t) {
                var n = t.originalEvent && t.originalEvent.clipboardData && t.originalEvent.clipboardData.items,
                    i = {
                        files: []
                    };
                n && n.length && (e.each(n, function(e, t) {
                    var n = t.getAsFile && t.getAsFile();
                    n && i.files.push(n)
                }), !1 !== this._trigger("paste", e.Event("paste", {
                    delegatedEvent: t
                }), i) && this._onAdd(t, i))
            },
            _onDrop: function(t) {
                t.dataTransfer = t.originalEvent && t.originalEvent.dataTransfer;
                var n = this,
                    i = t.dataTransfer,
                    s = {};
                i && i.files && i.files.length && (t.preventDefault(), this._getDroppedFiles(i).always(function(i) {
                    s.files = i, !1 !== n._trigger("drop", e.Event("drop", {
                        delegatedEvent: t
                    }), s) && n._onAdd(t, s)
                }))
            },
            _onDragOver: t("dragover"),
            _onDragEnter: t("dragenter"),
            _onDragLeave: t("dragleave"),
            _initEventHandlers: function() {
                this._isXHRUpload(this.options) && (this._on(this.options.dropZone, {
                    dragover: this._onDragOver,
                    drop: this._onDrop,
                    dragenter: this._onDragEnter,
                    dragleave: this._onDragLeave
                }), this._on(this.options.pasteZone, {
                    paste: this._onPaste
                })), e.support.fileInput && this._on(this.options.fileInput, {
                    change: this._onChange
                })
            },
            _destroyEventHandlers: function() {
                this._off(this.options.dropZone, "dragenter dragleave dragover drop"), this._off(this.options.pasteZone, "paste"), this._off(this.options.fileInput, "change")
            },
            _destroy: function() {
                this._destroyEventHandlers()
            },
            _setOption: function(t, n) {
                var i = -1 !== e.inArray(t, this._specialOptions);
                i && this._destroyEventHandlers(), this._super(t, n), i && (this._initSpecialOptions(), this._initEventHandlers())
            },
            _initSpecialOptions: function() {
                var t = this.options;
                void 0 === t.fileInput ? t.fileInput = this.element.is('input[type="file"]') ? this.element : this.element.find('input[type="file"]') : t.fileInput instanceof e || (t.fileInput = e(t.fileInput)), t.dropZone instanceof e || (t.dropZone = e(t.dropZone)), t.pasteZone instanceof e || (t.pasteZone = e(t.pasteZone))
            },
            _getRegExp: function(e) {
                var t = e.split("/"),
                    n = t.pop();
                return t.shift(), new RegExp(t.join("/"), n)
            },
            _isRegExpOption: function(t, n) {
                return "url" !== t && "string" === e.type(n) && /^\/.*\/[igm]{0,3}$/.test(n)
            },
            _initDataAttributes: function() {
                var t = this,
                    n = this.options,
                    i = this.element.data();
                e.each(this.element[0].attributes, function(e, s) {
                    var r, o = s.name.toLowerCase();
                    /^data-/.test(o) && (o = o.slice(5).replace(/-[a-z]/g, function(e) {
                        return e.charAt(1).toUpperCase()
                    }), r = i[o], t._isRegExpOption(o, r) && (r = t._getRegExp(r)), n[o] = r)
                })
            },
            _create: function() {
                this._initDataAttributes(), this._initSpecialOptions(), this._slots = [], this._sequence = this._getXHRPromise(!0), this._sending = this._active = 0, this._initProgressObject(this), this._initEventHandlers()
            },
            active: function() {
                return this._active
            },
            progress: function() {
                return this._progress
            },
            add: function(t) {
                var n = this;
                t && !this.options.disabled && (t.fileInput && !t.files ? this._getFileInputFiles(t.fileInput).always(function(e) {
                    t.files = e, n._onAdd(null, t)
                }) : (t.files = e.makeArray(t.files), this._onAdd(null, t)))
            },
            send: function(t) {
                if (t && !this.options.disabled) {
                    if (t.fileInput && !t.files) {
                        var n, i, s = this,
                            r = e.Deferred(),
                            o = r.promise();
                        return o.abort = function() {
                            return i = !0, n ? n.abort() : (r.reject(null, "abort", "abort"), o)
                        }, this._getFileInputFiles(t.fileInput).always(function(e) {
                            i || (e.length ? (t.files = e, (n = s._onSend(null, t)).then(function(e, t, n) {
                                r.resolve(e, t, n)
                            }, function(e, t, n) {
                                r.reject(e, t, n)
                            })) : r.reject())
                        }), this._enhancePromise(o)
                    }
                    if (t.files = e.makeArray(t.files), t.files.length) return this._onSend(null, t)
                }
                return this._getXHRPromise(!1, t && t.context)
            }
        })
    }),
    function(e) {
        "use strict";
        "function" == typeof define && define.amd ? define(["jquery", "./jquery.fileupload"], e) : "object" == typeof exports ? e(require("jquery"), require("./jquery.fileupload")) : e(window.jQuery)
    }(function(e) {
        "use strict";
        var t = e.blueimp.fileupload.prototype.options.add;
        e.widget("blueimp.fileupload", e.blueimp.fileupload, {
            options: {
                processQueue: [],
                add: function(n, i) {
                    var s = e(this);
                    i.process(function() {
                        return s.fileupload("process", i)
                    }), t.call(this, n, i)
                }
            },
            processActions: {},
            _processFile: function(t, n) {
                var i = this,
                    s = e.Deferred().resolveWith(i, [t]).promise();
                return this._trigger("process", null, t), e.each(t.processQueue, function(t, r) {
                    var o = function(t) {
                        return n.errorThrown ? e.Deferred().rejectWith(i, [n]).promise() : i.processActions[r.action].call(i, t, r)
                    };
                    s = s.then(o, r.always && o)
                }), s.done(function() {
                    i._trigger("processdone", null, t), i._trigger("processalways", null, t)
                }).fail(function() {
                    i._trigger("processfail", null, t), i._trigger("processalways", null, t)
                }), s
            },
            _transformProcessQueue: function(t) {
                var n = [];
                e.each(t.processQueue, function() {
                    var i = {},
                        s = this.action,
                        r = !0 === this.prefix ? s : this.prefix;
                    e.each(this, function(n, s) {
                        "string" === e.type(s) && "@" === s.charAt(0) ? i[n] = t[s.slice(1) || (r ? r + n.charAt(0).toUpperCase() + n.slice(1) : n)] : i[n] = s
                    }), n.push(i)
                }), t.processQueue = n
            },
            processing: function() {
                return this._processing
            },
            process: function(t) {
                var n = this,
                    i = e.extend({}, this.options, t);
                return i.processQueue && i.processQueue.length && (this._transformProcessQueue(i), 0 === this._processing && this._trigger("processstart"), e.each(t.files, function(s) {
                    var r = s ? e.extend({}, i) : i,
                        o = function() {
                            return t.errorThrown ? e.Deferred().rejectWith(n, [t]).promise() : n._processFile(r, t)
                        };
                    r.index = s, n._processing += 1, n._processingQueue = n._processingQueue.then(o, o).always(function() {
                        n._processing -= 1, 0 === n._processing && n._trigger("processstop")
                    })
                })), this._processingQueue
            },
            _create: function() {
                this._super(), this._processing = 0, this._processingQueue = e.Deferred().resolveWith(this).promise()
            }
        })
    }),
    function(e) {
        "use strict";
        "function" == typeof define && define.amd ? define(["jquery", "./jquery.fileupload-process"], e) : "object" == typeof exports ? e(require("jquery"), require("./jquery.fileupload-process")) : e(window.jQuery)
    }(function(e) {
        "use strict";
        e.blueimp.fileupload.prototype.options.processQueue.push({
            action: "validate",
            always: !0,
            acceptFileTypes: "@",
            maxFileSize: "@",
            minFileSize: "@",
            maxNumberOfFiles: "@",
            disabled: "@disableValidation"
        }), e.widget("blueimp.fileupload", e.blueimp.fileupload, {
            options: {
                getNumberOfFiles: e.noop,
                messages: {
                    maxNumberOfFiles: "Maximum number of files exceeded",
                    acceptFileTypes: "File type not allowed",
                    maxFileSize: "File is too large",
                    minFileSize: "File is too small"
                }
            },
            processActions: {
                validate: function(t, n) {
                    if (n.disabled) return t;
                    var i, s = e.Deferred(),
                        r = this.options,
                        o = t.files[t.index];
                    return (n.minFileSize || n.maxFileSize) && (i = o.size), "number" === e.type(n.maxNumberOfFiles) && (r.getNumberOfFiles() || 0) + t.files.length > n.maxNumberOfFiles ? o.error = r.i18n("maxNumberOfFiles") : !n.acceptFileTypes || n.acceptFileTypes.test(o.type) || n.acceptFileTypes.test(o.name) ? i > n.maxFileSize ? o.error = r.i18n("maxFileSize") : "number" === e.type(i) && i < n.minFileSize ? o.error = r.i18n("minFileSize") : delete o.error : o.error = r.i18n("acceptFileTypes"), o.error || t.files.error ? (t.files.error = !0, s.rejectWith(this, [t])) : s.resolveWith(this, [t]), s.promise()
                }
            }
        })
    }), this.Handlebars = this.Handlebars || {}, this.Handlebars.precompiled = this.Handlebars.precompiled || {}, this.Handlebars.precompiled["fileupload/files-ui.hbs"] = {
        1: function(e, t, n, i, s, r, o) {
            var a, l = null != t ? t : e.nullContext || {};
            return '    <li class="row no-gutter list-group-item file ' + (null != (a = n.if.call(l, null != t ? t.error : t, {
                name: "if",
                hash: {},
                fn: e.program(2, s, 0, r, o),
                inverse: e.noop,
                data: s
            })) ? a : "") + ' clearfix">\n        <div class="col-md-4">\n            <span class="name">\n' + (null != (a = n.if.call(l, null != t ? t.url : t, {
                name: "if",
                hash: {},
                fn: e.program(4, s, 0, r, o),
                inverse: e.noop,
                data: s
            })) ? a : "") + "                <span>" + e.escapeExpression(e.lambda(null != t ? t.name : t, t)) + '</span>\n            </span>\n        </div>\n        <div class="col-md-2">\n' + (null != (a = n.if.call(l, null != o[1] ? o[1].isDownload : o[1], {
                name: "if",
                hash: {},
                fn: e.program(6, s, 0, r, o),
                inverse: e.program(8, s, 0, r, o),
                data: s
            })) ? a : "") + '        </div>\n        <div class="col-md-3">\n' + (null != (a = n.if.call(l, null != o[1] ? o[1].isDownload : o[1], {
                name: "if",
                hash: {},
                fn: e.program(10, s, 0, r, o),
                inverse: e.program(13, s, 0, r, o),
                data: s
            })) ? a : "") + '        </div>\n\n        <div class="pull-right">\n' + (null != (a = n.unless.call(l, null != o[1] ? o[1].isDownload : o[1], {
                name: "unless",
                hash: {},
                fn: e.program(15, s, 0, r, o),
                inverse: e.noop,
                data: s
            })) ? a : "") + (null != (a = n.if.call(l, null != t ? t.delete_url : t, {
                name: "if",
                hash: {},
                fn: e.program(18, s, 0, r, o),
                inverse: e.program(21, s, 0, r, o),
                data: s
            })) ? a : "") + "        </div>\n    </li>\n"
        },
        2: function(e, t, n, i, s) {
            return "list-group-item-danger"
        },
        4: function(e, t, n, i, s, r, o) {
            var a, l = e.escapeExpression;
            return '                    <input type="hidden" name="' + l((n.attr || t && t.attr || n.helperMissing).call(null != t ? t : e.nullContext || {}, "name", null != (a = null != o[1] ? o[1].options : o[1]) ? a.fileInput : a, {
                name: "attr",
                hash: {},
                data: s
            })) + '" value="' + l(e.lambda(null != t ? t.hash : t, t)) + '">\n'
        },
        6: function(e, t, n, i, s) {
            return '                <span class="size">' + e.escapeExpression((n.bytes || t && t.bytes || n.helperMissing).call(null != t ? t : e.nullContext || {}, null != t ? t.size : t, {
                name: "bytes",
                hash: {},
                data: s
            })) + "</span>\n"
        },
        8: function(e, t, n, i, s) {
            return '                <span class="size">Processing...</span>\n'
        },
        10: function(e, t, n, i, s) {
            var r;
            return null != (r = n.if.call(null != t ? t : e.nullContext || {}, null != t ? t.error : t, {
                name: "if",
                hash: {},
                fn: e.program(11, s, 0),
                inverse: e.noop,
                data: s
            })) ? r : ""
        },
        11: function(e, t, n, i, s) {
            return "                    " + e.escapeExpression(e.lambda(null != t ? t.error : t, t)) + "\n"
        },
        13: function(e, t, n, i, s) {
            return '                <div class="progress progress-striped active" role="progressbar" aria-valuemin="0" aria-valuemax="100"\n                     aria-valuenow="0">\n                    <div class="progress-bar progress-bar-success" style="width:0%;"></div>\n                </div>\n'
        },
        15: function(e, t, n, i, s, r, o) {
            var a;
            return null != (a = n.unless.call(null != t ? t : e.nullContext || {}, null != (a = null != o[1] ? o[1].options : o[1]) ? a.autoUpload : a, {
                name: "unless",
                hash: {},
                fn: e.program(16, s, 0, r, o),
                inverse: e.noop,
                data: s
            })) ? a : ""
        },
        16: function(e, t, n, i, s) {
            return '                    <button class="btn btn-primary btn-sm start" disabled>\n                        <i class="fa fa-upload"></i>\n                        <span>Start</span>\n                    </button>\n'
        },
        18: function(e, t, n, i, s, r, o) {
            var a;
            return null != (a = n.if.call(null != t ? t : e.nullContext || {}, null != (a = null != o[1] ? o[1].options : o[1]) ? a.allowDelete : a, {
                name: "if",
                hash: {},
                fn: e.program(19, s, 0, r, o),
                inverse: e.noop,
                data: s
            })) ? a : ""
        },
        19: function(e, t, n, i, s) {
            var r = e.lambda,
                o = e.escapeExpression;
            return '                    <button class="btn btn-danger delete btn-sm" data-type="' + o(r(null != t ? t.delete_type : t, t)) + '"\n                            data-url="' + o(r(null != t ? t.delete_url : t, t)) + '">\n                        <i class="fa fa-trash-o"></i>\n                        <span>Delete</span>\n                    </button>\n'
        },
        21: function(e, t, n, i, s) {
            return '                <button class="btn btn-warning cancel btn-sm">\n                    <i class="fa fa-times"></i>\n                    <span>Cancel</span>\n                </button>\n'
        },
        compiler: [7, ">= 4.0.0"],
        main: function(e, t, n, i, s, r, o) {
            var a;
            return null != (a = n.each.call(null != t ? t : e.nullContext || {}, null != t ? t.files : t, {
                name: "each",
                hash: {},
                fn: e.program(1, s, 0, r, o),
                inverse: e.noop,
                data: s
            })) ? a : ""
        },
        useData: !0,
        useDepths: !0
    },
    function(e, t, n) {
        function i(t, n) {
            t.preventDefault();
            var i, r, o, a = e(this),
                l = a.data();
            return l = l.hasOwnProperty("bootboxform") ? l.bootboxform : l, n = s(l, n), i = a.children().clone(), o = a.find("form"), "string" == typeof n.formaction && (o.length || (o = i = e('<form method="POST"></form>').append(i)), o.prop("action", n.formaction)), (r = bootbox.dialog(n)).find(".bootbox-body").append(i), e(".dp-choose-date", r).remove(), e(".haspicker", r).removeClass("dp-applied").datePicker({
                startDate: startDate
            }), r.modal("show"), a.trigger("bootbox-form.shown", [r]), !1
        }

        function s(n, i) {
            return "function" != typeof(i = e.extend(!0, {}, n || {}, i || {})).callback && (i.callback = function(n) {
                return function(i) {
                    var s = !0;
                    return "string" == typeof n && "function" == typeof t[n] ? s = t[n].apply(this, Array.prototype.slice.call(arguments, 1)) : e("form", this).submit(), !1 !== s || s
                }
            }(i.callback)), e.extend(i, {
                message: " ",
                title: i.title,
                show: !1,
                buttons: {
                    cancel: {
                        label: "Cancel",
                        className: "btn-defaultr"
                    },
                    confirm: {
                        label: i.btntitle || i.title,
                        className: i.btnclass || "btn-success",
                        callback: i.callback
                    }
                }
            })
        }
        e.fn.bootboxform = function(t) {
            return this.each(function(n) {
                var r;
                (r = e(this)).data("bootboxform") instanceof Object || r.data("bootboxform", s(r.data(), t)).on("show.bootbox", "[bootbox]", i).filter("[bootbox]").on("show.bootbox", i)
            })
        }
    }(jQuery, window),
    function(e) {
        function t(t, n) {
            function i() {
                var s = e.extend({}, n.args),
                    o = jQuery.Deferred();
                return l.lastQuery = l.query || "", s[n.query_name] = l.lastQuery, l.query = "", a = !0, t.results_none_found = n.loading_text, e.post(n.url, s).done(function(e) {
                    var t = n.parse(e, n);
                    r(t), "" === l.query ? o.resolve(t) : o.notify(l.query, t)
                }).fail(function(e) {
                    o.reject(e)
                }).always(function() {
                    l.query && i().then(o.resolve, o.reject), a = !1, t.results_none_found = n.results_none_found
                }), o.promise()
            }

            function s() {
                var e = t.search_field.val();
                l.lastQuery !== e && (l.query = e, a || i())
            }

            function r(e) {
                var n = {},
                    i = [];
                l.original_options.each(function() {
                    this.selected && i.push(this.value), n[this.value] = this.outerHTML
                }), l.form.find(":selected").each(function() {
                    i.push(this.value), n[this.value] = this.outerHTML
                }), l.form.empty(), e.length < 1 && !t.is_multiple && l.form.append(c.replace("%name", "Start typing to search").replace("%value", "").replace("%query", "").replace("%attr", "disabled"));
                for (var s = 0, r = e.length; s < r; s++) {
                    var o = e[s].value || e[s].name,
                        a = c.replace("%name", e[s].name || e[s].value).replace("%value", e[s].value || e[s].name).replace("%query", e[s].query || "").replace("%attr", "");
                    n[o] ? n[o] = a : l.form.append(a)
                }
                for (var d in n) n.hasOwnProperty(d) && l.form.append(n[d]);
                l.form.val(i).trigger("liszt:updated").trigger("chosen:updated"), l.original_options = l.form.children().filter(function() {
                    return l.original_values.indexOf(this.value) > -1
                })
            }
            this.chosen = t, this.options = n, this.form = e(t.form_field), this.query = "", this.original_options = this.form.children(), this.original_values = this.original_options.map(function() {
                return this.value
            }).get();
            var o, a, l = this,
                c = '<option value="%value" %attr>%name \x3c!-- %query --\x3e</option>';
            this.set = function(e, t) {
                var n = [{
                    value: e,
                    name: t || e
                }];
                r(n), l.query = e, i().done(function(t) {
                    for (var i = 0, s = t.length; i < s; i++)
                        if (t[i].value == e) return;
                    r(n)
                }).always(function() {
                    l.form.val(e).trigger("liszt:updated").trigger("chosen:updated")
                }), l.form.val(e).trigger("liszt:updated").trigger("chosen:updated")
            }, t.search_field.on("input focus", function(e) {
                clearTimeout(o), o = setTimeout(s, 50)
            }), t.options.placeholder_text_multiple = n.placeholder, t.options.placeholder_text_single = n.placeholder, t.show_search_field_default = function() {}, i()
        }
        var n, i;
        n = {
            Clients: "#{{id}} {{firstname}} {{lastname}} {{companyname}} {{email}}",
            Tickets: "#{{ticket_number}} - {{subject}}",
            Invoices: "#{{id}} {{status}} - {{firstname}} {{lastname}}"
        }, i = {
            url: "?cmd=search&action=single",
            type: "Clients",
            init_request: !1,
            args: {
                type: "Clients"
            },
            query_name: "q",
            loading_text: "Searching for",
            none_option: !1,
            placeholder: "Type to search",
            parse: function(t, i) {
                var s = [];
                if (i.none_option && s.push(i.none_option), !t.items || !i.args.type) return s;
                for (var r = 0, o = t.items.length; r < o; r++) {
                    var a = n[i.args.type];
                    e.each(t.items[r], function(e, t) {
                        a = a.replace("{{" + e + "}}", t)
                    }), s.push({
                        value: t.items[r].id,
                        name: a.replace(/\{\{[a-z0-9\s]+\}\}/g, ""),
                        query: t.query
                    })
                }
                return s
            }
        }, e.fn.extend({
            chosensearch: function(n) {
                return n = n || {}, this.each(function(s) {
                    var r, o;
                    if (r = e(this), o = r.data("chosen"), !(r.data("chosensearch") instanceof t)) {
                        o ? (o.disable_search = !1, o.disable_search_threshold = 0, o.enable_split_word_search = !0) : (r.chosenedge(e.extend(n, {
                            width: n.width || "100%",
                            disable_search: !1,
                            disable_search_threshold: 0,
                            enable_split_word_search: !0
                        })), o = r.data("chosen"));
                        var a = e.extend({}, i);
                        a.results_none_found = o.results_none_found, r.data("chosensearch", new t(o, e.extend(a, n)))
                    }
                })
            }
        })
    }(jQuery),
    function(e, t) {
        "use strict";

        function n(e) {
            return !!("" === e || e && e.charCodeAt && e.substr)
        }

        function i(e) {
            return u ? u(e) : "[object Array]" === h.call(e)
        }

        function s(e) {
            return e && "[object Object]" === h.call(e)
        }

        function r(e, t) {
            var n;
            e = e || {}, t = t || {};
            for (n in t) t.hasOwnProperty(n) && null == e[n] && (e[n] = t[n]);
            return e
        }

        function o(e, t, n) {
            var i, s, r = [];
            if (!e) return r;
            if (d && e.map === d) return e.map(t, n);
            for (i = 0, s = e.length; i < s; i++) r[i] = t.call(n, e[i], i, e);
            return r
        }

        function a(e, t) {
            return e = Math.round(Math.abs(e)), isNaN(e) ? t : e
        }

        function l(e) {
            e = r(e, c), this.settings = {
                currency: {
                    iso: e.iso,
                    code: e.code,
                    symbol: e.sign || "",
                    format: "%s%v %c",
                    decimal: e.format.charAt(5),
                    thousand: e.format.charAt(1),
                    precision: e.decimal,
                    grouping: 3
                },
                number: {
                    precision: e.rounding,
                    grouping: 3,
                    thousand: "",
                    decimal: e.format.charAt(5)
                }
            }
        }
        var c = {
                iso: "USD",
                code: "USD",
                format: "1 234.56",
                rate: 1,
                sign: "$",
                decimal: 2,
                rounding: 2
            },
            d = Array.prototype.map,
            u = Array.isArray,
            h = Object.prototype.toString;
        l.prototype.checkFormatterFormat = function(e) {
            var t = this.settings.currency.format;
            return "function" == typeof e && (e = e()), n(e) && e.match("%v") ? {
                pos: e,
                neg: e.replace("-", "").replace("%v", "-%v"),
                zero: e
            } : e && e.pos && e.pos.match("%v") ? e : n(t) ? this.settings.currency.format = {
                pos: t,
                neg: t.replace("%v", "-%v"),
                zero: t
            } : t
        }, l.prototype.unformat = function(e, t) {
            var n = this;
            if (i(e)) return o(e, function(e) {
                return n.unformat(e, t)
            });
            if ("number" == typeof(e = e || 0)) return e;
            t = t || this.settings.number.decimal;
            var s = new RegExp("[^0-9-" + t + "]", ["g"]),
                r = parseFloat(("" + e).replace(/\((?=\d+)(.*)\)/, "-$1").replace(s, "").replace(t, "."));
            return isNaN(r) ? 0 : r
        }, l.prototype.toFixed = function(e, t) {
            t = a(t, this.settings.number.precision);
            var n = Number(this.unformat(e) + "e" + t),
                i = Math.round(n);
            return Number(i + "e-" + t).toFixed(t)
        }, l.prototype.formatNumber = function(e, t, n, l) {
            var c = this;
            if (i(e)) return o(e, function(e) {
                return c.formatNumber(e, t, n, l)
            });
            e = c.unformat(e);
            var d = r(s(t) ? t : {
                    precision: t,
                    thousand: n,
                    decimal: l
                }, this.settings.number),
                u = a(d.precision),
                h = e < 0 ? "-" : "",
                p = parseInt(c.toFixed(Math.abs(e || 0), u), 10) + "",
                f = p.length > 3 ? p.length % 3 : 0;
            return h + (f ? p.substr(0, f) + d.thousand : "") + p.substr(f).replace(/(\d{3})(?=\d)/g, "$1" + d.thousand) + (u ? d.decimal + c.toFixed(Math.abs(e), u).split(".")[1] : "")
        }, l.prototype.formatMoney = function(e, t, n, l, c, d) {
            var u = this;
            if (i(e)) return o(e, function(e) {
                return u.formatMoney(e, t, n, l, c, d)
            });
            e = u.unformat(e);
            var h = r(s(t) ? t : {
                    symbol: t,
                    precision: n,
                    thousand: l,
                    decimal: c,
                    format: d
                }, this.settings.currency),
                p = u.checkFormatterFormat(h.format),
                f = e > 0 ? p.pos : e < 0 ? p.neg : p.zero,
                m = u.formatNumber(Math.abs(e), a(h.precision), h.thousand, h.decimal);
            return f.replace("%s", h.symbol).replace("%v", m).replace("%c", h.code).trim()
        }, l.prototype.formatColumn = function(e, t, l, c, d, u) {
            if (!e || !i(e)) return [];
            var h = this,
                p = r(s(t) ? t : {
                    symbol: t,
                    precision: l,
                    thousand: c,
                    decimal: d,
                    format: u
                }, this.settings.currency),
                f = h.checkFormatterFormat(p.format),
                m = f.pos.indexOf("%s") < f.pos.indexOf("%v"),
                g = 0;
            return o(o(e, function(e, t) {
                if (i(e)) return h.formatColumn(e, p);
                var n = ((e = h.unformat(e)) > 0 ? f.pos : e < 0 ? f.neg : f.zero).replace("%s", p.symbol).replace("%v", h.formatNumber(Math.abs(e), a(p.precision), p.thousand, p.decimal));
                return n.length > g && (g = n.length), n
            }), function(e, t) {
                return n(e) && e.length < g ? m ? e.replace(p.symbol, p.symbol + new Array(g - e.length + 1).join(" ")) : new Array(g - e.length + 1).join(" ") + e : e
            })
        }, l.prototype.format = l.prototype.formatMoney, e.CurrencyFormat = l
    }(window);
var FilterModal = {
    modal: function(e, t) {
        var n = $("#" + $.trim(e)),
            i = n.find(".modal-body");
        return "" != $.trim(i.text()) ? n.modal() : ajax_update($(t).attr("href"), {}, function(t) {
            i.html(t).find("form").changeElementType("div"), i.find(".freseter").remove(), i.find(".filterform").removeAttributes();
            var s = i.find("input,select");
            s.keypress(function(t) {
                if (13 == t.keyCode) return FilterModal.submit(e), !1
            }), i.find(".filters-actions").length ? (i.find(".filters-actions").remove(), i.find(".form-group").removeClass("col-lg-3 col-md-4")) : s.addClass("form-control").filter("[type=submit]").parents("tr").eq(0).remove(), n.modal()
        }), !1
    },
    submit: function(e) {
        var t = this.init(e);
        t.footer.find(".btn-danger").show(), t.filter.removeClass("btn-default").addClass("btn-danger"), t.src.modal("hide");
        var n = t.activetab_sel.attr("href");
        $("div.slide:visible").addLoader();
        return ajax_update(n + "&" + t.body.find("input,select").serialize(), {}, "div.slide:visible"), !1
    },
    bindsorter: function(e, t) {
        $("a.sortorder[data-orderby]", "div.slide:visible").on("click", function() {
            $("a.sortorder[data-orderby]", "div.slide:visible").removeClass("asc").removeClass("desc");
            var e = $(this).attr("href");
            return "ASC" == t ? (t = "DESC", $(this).addClass("asc")) : (t = "ASC", $(this).addClass("desc")), e += "&orderby=" + $(this).attr("data-orderby") + "|" + t, $("div.slide:visible").addLoader(), ajax_update(e, {}, "div.slide:visible"), !1
        }), e = e.replace(/([a-z]+\.)/gi, "").replace(/[`]/g, ""), $('a.sortorder[data-orderby="' + e + '"]', "div.slide:visible").addClass(t.toLowerCase())
    },
    reset: function(e) {
        var t = this.init(e);
        t.footer.find(".btn-danger").hide(), t.filter.removeClass("btn-danger").addClass("btn-default"), t.src.modal("hide");
        return ajax_update(t.activetab_sel.attr("href") + "&resetfilter=1", {}, "div.slide:visible"), !1
    },
    init: function(e) {
        return {
            src: $("#" + $.trim(e)),
            footer: $("#" + $.trim(e)).find(".modal-footer"),
            filter: $(".slide:visible").find(".btn-is-filter"),
            activetab_sel: $(".nav_sel.nav_sel"),
            body: $("#" + $.trim(e)).find(".modal-body")
        }
    }
};
! function(e) {
    e.fn.changeElementType = function(t) {
        var n = {};
        e.each(this[0].attributes, function(e, t) {
            n[t.nodeName] = t.nodeValue
        }), this.replaceWith(function() {
            return e("<" + t + "/>", n).append(e(this).contents())
        })
    }, e.fn.removeAttributes = function() {
        return this.each(function() {
            var t = e.map(this.attributes, function(e) {
                    return e.name
                }),
                n = e(this);
            e.each(t, function(e, t) {
                n.removeAttr(t)
            })
        })
    }
}(jQuery),
function(e) {
    "use strict";
    var t = Handlebars.create(),
        n = t.template(Handlebars.precompiled["fileupload/files-ui.hbs"]),
        i = {
            options: {
                autoUpload: !0,
                uploadTemplate: n,
                downloadTemplate: n,
                filesContainer: void 0,
                prependFiles: !1,
                dataType: "json",
                allowDelete: !0,
                messages: {
                    unknownError: "Unknown error"
                },
                getNumberOfFiles: function() {
                    return this.filesContainer.children().not(".processing").length
                },
                getFilesFromResponse: function(t) {
                    return t.result && e.isArray(t.result) ? t.result : []
                },
                add: function(t, n) {
                    if (t.isDefaultPrevented()) return !1;
                    var i = e(this),
                        s = i.data("hbFileuploadui") || i.data("fileupload"),
                        r = s.options;
                    n.context = s._renderUpload(n.files).data("data", n).addClass("processing"), r.filesContainer[r.prependFiles ? "prepend" : "append"](n.context), s._forceReflow(n.context), s._transition(n.context), n.process(function() {
                        return i.fileuploadui("process", n)
                    }).always(function() {
                        n.context.each(function(t) {
                            e(this).find(".size").text(s._formatFileSize(n.files[t].size))
                        }).removeClass("processing"), s._renderPreviews(n)
                    }).done(function() {
                        n.context.find(".start").prop("disabled", !1), !1 !== s._trigger("added", t, n) && (r.autoUpload || n.autoUpload) && !1 !== n.autoUpload && n.submit()
                    }).fail(function() {
                        n.files.error && n.context.each(function(t) {
                            var i = n.files[t].error;
                            i && e(this).find(".error").text(i)
                        })
                    })
                },
                send: function(t, n) {
                    if (t.isDefaultPrevented()) return !1;
                    var i = e(this).data("hbFileuploadui") || e(this).data("fileupload");
                    return n.context && n.dataType && "iframe" === n.dataType.substr(0, 6) && n.context.find(".progress").addClass(!e.support.transition && "progress-animated").attr("aria-valuenow", 100).children().first().css("width", "100%"), i._trigger("sent", t, n)
                },
                done: function(t, n) {
                    if (t.isDefaultPrevented()) return !1;
                    var i, s, r = e(this).data("hbFileuploadui") || e(this).data("fileupload"),
                        o = (n.getFilesFromResponse || r.options.getFilesFromResponse)(n);
                    n.context ? n.context.each(function(a) {
                        var l = o[a] || {
                            error: "Empty file upload result"
                        };
                        s = r._addFinishedDeferreds(), r._transition(e(this)).done(function() {
                            var o = e(this);
                            i = r._renderDownload([l]).replaceAll(o), r._forceReflow(i), r._transition(i).done(function() {
                                n.context = e(this), r._trigger("completed", t, n), r._trigger("finished", t, n), s.resolve()
                            })
                        })
                    }) : (i = r._renderDownload(o)[r.options.prependFiles ? "prependTo" : "appendTo"](r.options.filesContainer), r._forceReflow(i), s = r._addFinishedDeferreds(), r._transition(i).done(function() {
                        n.context = e(this), r._trigger("completed", t, n), r._trigger("finished", t, n), s.resolve()
                    }))
                },
                fail: function(t, n) {
                    if (t.isDefaultPrevented()) return !1;
                    var i, s, r = e(this).data("hbFileuploadui") || e(this).data("fileupload");
                    n.context ? n.context.each(function(o) {
                        if ("abort" !== n.errorThrown) {
                            var a = n.files[o];
                            a.error = a.error || n.errorThrown || n.i18n("unknownError"), s = r._addFinishedDeferreds(), r._transition(e(this)).done(function() {
                                var o = e(this);
                                i = r._renderDownload([a]).replaceAll(o), r._forceReflow(i), r._transition(i).done(function() {
                                    n.context = e(this), r._trigger("failed", t, n), r._trigger("finished", t, n), s.resolve()
                                })
                            })
                        } else s = r._addFinishedDeferreds(), r._transition(e(this)).done(function() {
                            e(this).remove(), r._trigger("failed", t, n), r._trigger("finished", t, n), s.resolve()
                        })
                    }) : "abort" !== n.errorThrown ? (n.context = r._renderUpload(n.files)[r.options.prependFiles ? "prependTo" : "appendTo"](r.options.filesContainer).data("data", n), r._forceReflow(n.context), s = r._addFinishedDeferreds(), r._transition(n.context).done(function() {
                        n.context = e(this), r._trigger("failed", t, n), r._trigger("finished", t, n), s.resolve()
                    })) : (r._trigger("failed", t, n), r._trigger("finished", t, n), r._addFinishedDeferreds().resolve())
                },
                progress: function(t, n) {
                    if (t.isDefaultPrevented()) return !1;
                    var i = Math.floor(n.loaded / n.total * 100);
                    n.context && n.context.each(function() {
                        e(this).find(".progress").attr("aria-valuenow", i).children().first().css("width", i + "%")
                    })
                },
                progressall: function(t, n) {
                    if (t.isDefaultPrevented()) return !1;
                    var i = e(this),
                        s = Math.floor(n.loaded / n.total * 100),
                        r = i.find(".fileupload-progress"),
                        o = r.find(".progress-extended");
                    o.length && o.html((i.data("hbFileuploadui") || i.data("fileupload"))._renderExtendedProgress(n)), r.find(".progress").attr("aria-valuenow", s).children().first().css("width", s + "%")
                },
                start: function(t) {
                    if (t.isDefaultPrevented()) return !1;
                    var n = e(this).data("hbFileuploadui") || e(this).data("fileupload");
                    n._resetFinishedDeferreds(), n._transition(e(this).find(".fileupload-progress")).done(function() {
                        n._trigger("started", t)
                    })
                },
                stop: function(t) {
                    if (t.isDefaultPrevented()) return !1;
                    var n = e(this).data("hbFileuploadui") || e(this).data("fileupload"),
                        i = n._addFinishedDeferreds();
                    e.when.apply(e, n._getFinishedDeferreds()).done(function() {
                        n._trigger("stopped", t)
                    }), n._transition(e(this).find(".fileupload-progress")).done(function() {
                        e(this).find(".progress").attr("aria-valuenow", "0").children().first().css("width", "0%"), e(this).find(".progress-extended").html("&nbsp;"), i.resolve()
                    })
                },
                processstart: function(t) {
                    if (t.isDefaultPrevented()) return !1;
                    e(this).addClass("fileupload-processing")
                },
                processstop: function(t) {
                    if (t.isDefaultPrevented()) return !1;
                    e(this).removeClass("fileupload-processing")
                },
                destroy: function(t, n) {
                    if (t.isDefaultPrevented()) return !1;
                    var i = e(this).data("hbFileuploadui") || e(this).data("fileupload"),
                        s = function() {
                            i._transition(n.context).done(function() {
                                e(this).remove(), i._trigger("destroyed", t, n)
                            })
                        };
                    n.url ? (n.dataType = n.dataType || i.options.dataType, e.ajax(n).done(s).fail(function() {
                        i._trigger("destroyfailed", t, n)
                    })) : s()
                }
            },
            _resetFinishedDeferreds: function() {
                this._finishedUploads = []
            },
            _addFinishedDeferreds: function(t) {
                return t || (t = e.Deferred()), this._finishedUploads.push(t), t
            },
            _getFinishedDeferreds: function() {
                return this._finishedUploads
            },
            _enableDragToDesktop: function() {
                var t = e(this),
                    n = t.prop("href"),
                    i = t.prop("download"),
                    s = "application/octet-stream";
                t.bind("dragstart", function(e) {
                    try {
                        e.originalEvent.dataTransfer.setData("DownloadURL", [s, i, n].join(":"))
                    } catch (e) {}
                })
            },
            _formatFileSize: function(e) {
                return "number" != typeof e ? "" : e >= 1e9 ? (e / 1e9).toFixed(2) + " GB" : e >= 1e6 ? (e / 1e6).toFixed(2) + " MB" : (e / 1e3).toFixed(2) + " KB"
            },
            _formatBitrate: function(e) {
                return "number" != typeof e ? "" : e >= 1e9 ? (e / 1e9).toFixed(2) + " Gbit/s" : e >= 1e6 ? (e / 1e6).toFixed(2) + " Mbit/s" : e >= 1e3 ? (e / 1e3).toFixed(2) + " kbit/s" : e.toFixed(2) + " bit/s"
            },
            _formatTime: function(e) {
                var t = new Date(1e3 * e),
                    n = Math.floor(e / 86400);
                return (n = n ? n + "d " : "") + ("0" + t.getUTCHours()).slice(-2) + ":" + ("0" + t.getUTCMinutes()).slice(-2) + ":" + ("0" + t.getUTCSeconds()).slice(-2)
            },
            _formatPercentage: function(e) {
                return (100 * e).toFixed(2) + " %"
            },
            _renderExtendedProgress: function(e) {
                return this._formatBitrate(e.bitrate) + " | " + this._formatTime(8 * (e.total - e.loaded) / e.bitrate) + " | " + this._formatPercentage(e.loaded / e.total) + " | " + this._formatFileSize(e.loaded) + " / " + this._formatFileSize(e.total)
            },
            _renderTemplate: function(t, n, i) {
                if (!t) return e();
                var s = t({
                    files: n,
                    formatFileSize: this._formatFileSize,
                    options: this.options,
                    isDownload: i
                });
                return s instanceof e ? s : e(this.options.templatesContainer).html(s).children()
            },
            _renderPreviews: function(t) {
                t.context.find(".preview").each(function(n, i) {
                    e(i).append(t.files[n].preview)
                })
            },
            _renderUpload: function(e) {
                return this._renderTemplate(this.options.uploadTemplate, e, !1)
            },
            _renderDownload: function(e) {
                return this._renderTemplate(this.options.downloadTemplate, e, !0).find("a[download]").each(this._enableDragToDesktop).end()
            },
            _startHandler: function(t) {
                t.preventDefault();
                var n = e(t.currentTarget),
                    i = n.closest(".file").data("data");
                n.prop("disabled", !0), i && i.submit && i.submit()
            },
            _cancelHandler: function(t) {
                t.preventDefault();
                var n = e(t.currentTarget).closest(".file"),
                    i = n.data("data") || {};
                i.context = i.context || n, i.abort ? i.abort() : (i.errorThrown = "abort", this._trigger("fail", t, i))
            },
            _deleteHandler: function(t) {
                t.preventDefault();
                var n = e(t.currentTarget);
                this._trigger("destroy", t, e.extend({
                    context: n.closest(".file"),
                    type: "DELETE"
                }, n.data()))
            },
            _forceReflow: function(t) {
                return e.support.transition && t.length && t[0].offsetWidth
            },
            _transition: function(t) {
                var n = e.Deferred();
                return e.support.transition && t.hasClass("fade") && t.is(":visible") ? t.bind(e.support.transition.end, function(i) {
                    i.target === t[0] && (t.unbind(e.support.transition.end), n.resolveWith(t))
                }).toggleClass("in") : (t.toggleClass("in"), n.resolveWith(t)), n
            },
            _initButtonBarEventHandlers: function() {
                var t = this.element.find(".fileupload-buttonbar"),
                    n = this.options.filesContainer;
                this._on(t.find(".start"), {
                    click: function(e) {
                        e.preventDefault(), n.find(".start").click()
                    }
                }), this._on(t.find(".cancel"), {
                    click: function(e) {
                        e.preventDefault(), n.find(".cancel").click()
                    }
                }), this._on(t.find(".delete"), {
                    click: function(e) {
                        e.preventDefault(), n.find(".toggle:checked").closest(".file").find(".delete").click(), t.find(".toggle").prop("checked", !1)
                    }
                }), this._on(t.find(".toggle"), {
                    change: function(t) {
                        n.find(".toggle").prop("checked", e(t.currentTarget).is(":checked"))
                    }
                })
            },
            _destroyButtonBarEventHandlers: function() {
                this._off(this.element.find(".fileupload-buttonbar").find(".start, .cancel, .delete"), "click"), this._off(this.element.find(".fileupload-buttonbar .toggle"), "change.")
            },
            _initEventHandlers: function() {
                this._super(), this._on(this.options.filesContainer, {
                    "click .start": this._startHandler,
                    "click .cancel": this._cancelHandler,
                    "click .delete": this._deleteHandler
                }), this._initButtonBarEventHandlers()
            },
            _destroyEventHandlers: function() {
                this._destroyButtonBarEventHandlers(), this._off(this.options.filesContainer, "click"), this._super()
            },
            _enableFileInputButton: function() {
                this.element.find(".fileinput-button input").prop("disabled", !1).parent().removeClass("disabled")
            },
            _disableFileInputButton: function() {
                this.element.find(".fileinput-button input").prop("disabled", !0).parent().addClass("disabled")
            },
            _initTemplates: function() {
                var e = this.options;
                e.templatesContainer = this.document[0].createElement(e.filesContainer.prop("nodeName"))
            },
            _initFilesContainer: function() {
                var t = this.options;
                void 0 === t.filesContainer ? t.filesContainer = this.element.find(".files") : t.filesContainer instanceof e || (t.filesContainer = e(t.filesContainer))
            },
            _initSpecialOptions: function() {
                this._super(), this._initFilesContainer(), this._initTemplates()
            },
            _initDropZone: function() {
                if (this.options.dropZone && this.options.dropZone.length) {
                    var t = this.options.dropZone.is(document) ? e("body") : this.options.dropZone,
                        n = e('<div class="drag-drop-mask"></div>'),
                        i = 0;
                    this._on(document, {
                        dragenter: function(e) {
                            e.preventDefault(), 0 == i++ && (t.append(n), n.offset(t.offset()), n.css({
                                height: t.height(),
                                width: t.width()
                            }))
                        },
                        dragleave: function(e) {
                            0 == --i && n.detach()
                        },
                        dragover: function(e) {
                            e.preventDefault()
                        },
                        drop: function(e) {
                            i = 0, n.detach()
                        }
                    })
                }
            },
            _create: function() {
                this._super(), this._resetFinishedDeferreds(), e.support.fileInput || this._disableFileInputButton(), this._initDropZone(), this.options.result && this._trigger("done", null, this.options)
            },
            _destroy: function() {
                this._super(), this._off(document, "dragenter dragleave dragover drop")
            },
            enable: function() {
                var e = !1;
                this.options.disabled && (e = !0), this._super(), e && (this.element.find("input, button").prop("disabled", !1), this._enableFileInputButton())
            },
            disable: function() {
                this.options.disabled || (this.element.find("input, button").prop("disabled", !0), this._disableFileInputButton()), this._super()
            }
        };
    t.registerHelper("bytes", function(e, t) {
        return i._formatFileSize(e)
    }), t.registerHelper("attr", function(t, n, i) {
        return e(n).attr(t)
    }), e.widget("hb.fileuploadui", e.blueimp.fileupload, i)
}(jQuery),
function(e, t, n) {
    "use strict";

    function i(t, n) {
        this.id = "j-" + s++, this.element = e(t), this.options = n, this.langeditURL = "?cmd=langedit&action=bulktranslate&key=", this.element.after(this.render()), this.element.attr("id", this.id)
    }
    var s = 1;
    e.extend(i.prototype, {
        getValue: function() {
            return this.element.val()
        },
        findTokens: function() {
            for (var e, t = /\{\$lang\.([\w\d_]+)\}/g, n = this.getValue(), i = []; e = t.exec(n);) i.push(e[1]);
            return i
        },
        render: function() {
            var e = this.renderTokens();
            return '<div class="l_editor" id="l_editor_' + this.id + '"><span class="translations"><span class="taag" ' + (e ? "" : 'style="display:none"') + ">Tags: </span>" + e + '</span><a class="fs11 editbtn l_adder" href="#" data-id="' + this.id + '" onclick="return HBInputTranslate.addTranslation(\'' + this.id + '\');">Add translation</a><div class="clear"></div></div>'
        },
        renderTokens: function() {
            var e, t = this.findTokens(),
                n = [],
                i = t.length;
            for (e = 0; e < i; e++) n.push('<a href="' + this.langeditURL + t[e] + '" target="_blank">{$lang.' + t[e] + "}</a>");
            return n.join("\n")
        }
    }), e.fn.hbinput = function(t) {
        var n = "plugin_" + t.name;
        return function(i) {
            return this.each(function() {
                e.data(this, n) || e.data(this, n, new t(this, e.extend({}, e(this).data(), i)))
            })
        }
    }(i)
}(jQuery, window),
function(e, t) {
    function n(t, n) {
        this.element = t, this.$element = e(t), this.options = e.extend({}, i, n || {}), this.current_color = this.options.color, this.setupEvents()
    }
    var i = {
        color: "#03a9f4",
        colors: ["#03a9f4", "#8bc34a", "#e67e22", "#e51c23", "#00bcd4", "#556b8d", "#34495e", "#F78DA7", "#9b59b6", "#dce775"],
        popover: {
            template: '<div class="popover" role="tooltip"><div class="arrow"></div><div class="popover-content"></div></div>',
            placement: "bottom",
            html: !0,
            content: "",
            trigger: "click"
        }
    };
    n.prototype.colorchange = function(e) {
        this.current_color = e, this.$element.data("color", e).trigger("hbpicker.color", [e])
    }, n.prototype.buildHTML = function() {
        var t, n, i, s, r, o = this;
        for (n = e("<div class='hhash'>#</div><div class='hcontainer'><input class='htext' value='" + this.current_color + "' /></div>"), r = e("<div></div>").addClass("hcolor"), t = e("<div></div>").addClass("hbpicker"), s = 0; s < o.options.colors.length; s++) {
            i = o.options.colors[s];
            r.clone().attr("title", i).css("background-color", i).on("click.hbpicker", function() {
                var n = e(this).attr("title");
                t.find(".htext").val(n).trigger("keyup.hbpicker")
            }).appendTo(t)
        }
        return t.append(n), t.find(".htext").on("keyup.hbpicker", function() {
            var t = e(this).val().trim();
            null !== t.match(/^#[a-fA-F0-9]{6}$/) && o.colorchange(t)
        }), t
    }, n.prototype.setupEvents = function() {
        this.options.popover.content = this.buildHTML(), this.$element.on("click", e.proxy(this.on_click, this)), this.$element.popover(this.options.popover), e("body").off("click.hbpicker").on("click.hbpicker", this.hide_popovers)
    }, n.prototype.hide_popovers = function(t) {
        e("[data-original-title]").each(function() {
            e(this).is(t.target) || 0 !== e(this).has(t.target).length || 0 !== e(".popover").has(t.target).length || (((e(this).popover("hide").data("bs.popover") || {}).inState || {}).click = !1)
        })
    }, n.prototype.on_click = function(t) {
        e("[data-original-title]").not(this.element).popover("hide")
    }, e.fn.extend({
        hbpicker: function(t) {
            return this.each(function(i) {
                var s;
                (s = e(this)).data("hbpicker") instanceof n || s.data("hbpicker", new n(this, t))
            })
        }
    })
}(jQuery, window),
function(e, t, n) {
    "use strict";

    function i(t, n) {
        this.element = e(t), this.settings = e.extend({}, r, n), this._defaults = r, this._name = s, this.input = !1, this.chosen = !1, this.query = "", this.xhr = !1, this.init()
    }
    var s = "hbsearchselect",
        r = {
            type: "Clients",
            loading: "Searching for ...",
            noresults: "No Items",
            placeholder: "",
            value: "$id",
            label: "#$id $firstname $lastname $email"
        };
    e.extend(i.prototype, {
        init: function() {
            var t = this;
            this.settings.width && t.element.width(this.settings.width), t.element.chosen(e.extend({}, this.settings, {
                no_results_text: this.settings.noresults,
                placeholder_text_single: this.settings.placeholder || "Search for " + this.settings.type,
                disable_search_threshold: -1,
                search_contains: !0,
                allow_single_deselect: !0
            })), this.chosen = t.element.data("chosen"), this.input = this.chosen.search_container.find("input"), this.chosen.search_container.on("keyup", "input", function() {
                t.query = t.input.val(), "" != t.query && t.request()
            })
        },
        reset: function(e) {
            var t = this.input.val();
            e ? this.element.html(e) : this.element.empty(), this.element.trigger("liszt:updated").trigger("change", !0), this.input.val(t), this.chosen.results_show()
        },
        request: function() {
            if (!this.xhr) {
                var t = this;
                t.chosen.results_none_found = t.settings.loading;
                var n = t.query;
                t.query = "", t.xhr = e.ajax({
                    url: "?cmd=search&action=single&lightweight=1",
                    data: {
                        type: t.settings.type,
                        q: n
                    },
                    success: function(e) {
                        t.reload(e)
                    },
                    error: function() {
                        t.reload([])
                    }
                })
            }
        },
        reload: function(e) {
            if (this.xhr = !1, this.chosen.results_none_found = this.settings.noresults, "" != this.query ? this.request() : this.reset(), e && e.items.length) {
                for (var t = "<option></option>", n = /\$[a-z0-9_]+/gi, i = 0, s = e.items.length; i < s; i++) {
                    var r = e.items[i],
                        o = function(e) {
                            return r[e.substr(1)] || ""
                        };
                    t += '<option value="' + this.settings.value.replace(n, o) + '">' + this.settings.label.replace(n, o) + "\x3c!-- " + e.query + " --\x3e</option>"
                }
                this.reset(t)
            }
        }
    }), e.fn[s] = function(t) {
        return this.each(function() {
            e.data(this, "plugin_" + s) || e.data(this, "plugin_" + s, new i(this, e.extend({}, e(this).data(), t)))
        })
    }
}(jQuery, window),
function(e, t) {
    function n(e) {
        return Array.isArray(e) || (e = Object.keys(e).map(function(t) {
            return e[t]
        })), e.filter(function(e, t, n) {
            return n.indexOf(e) === t
        })
    }

    function i(t, i) {
        this.element = t, this.$element = e(t), this.options = e.extend({}, o, this.$element.data(), i || {}), this.tags = [], this.tags_colors = this.options.tags_colors || {}, this.suggestions = n(this.options.suggestions || []), this.tagNodes = [], this.savedTagName = null, this.setupHtml(), this.setupEvents(), this.ready = 0;
        var s = this;
        setTimeout(function() {
            s.insertTags(n(s.options.tags || [])), s.ready = 1
        })
    }

    function s(t, n) {
        this.$element = e(t), this.options = e.extend({
            items: ".entry",
            filter: ".inlineTags span",
            filter_container: ".tag-filter-container",
            reset: ".tag-filter-reset",
            template: 'Showing products with tag: <span class="label label-success">%tag</span>'
        }, n || {});
        var i = this;
        this.$container = e(this.options.filter_container), this.$reset = e(this.options.reset), this.$element.on("click", this.options.filter, function(t) {
            t.preventDefault(), i.filter.call(i, t, e(this).text(), this)
        }), this.$reset.on("click", function(e) {
            e.preventDefault(), i.reset.call(i, e)
        })
    }
    var r = 1,
        o = {
            tags: [],
            suggestions: [],
            placeholder: "Tags",
            tag_template: '<span class="tag" style="background-color: %color"><a>%tag</a><a class="tag-edit"></a><a class="tag-rem"></a></span>',
            blur_timout: 200,
            colors: !1,
            color: "#03a9f4",
            max_suggestions: 10,
            sortable: !1,
            autoSubmit: !1
        };
    i.prototype.setupHtml = function() {
        var t = "tag-form-" + (this.element.id || r++).replace(/[^\w]+/g, "_");
        this.$element.addClass("tag-form form-control").html('<label for="' + t + '">   <input id="' + t + '" placeholder="' + this.options.placeholder + '" autocomplete="off">   <ul></ul></label>'), this.$input = this.$element.find("input"), this.$inputPlaceholder = e('<span class="tag-form-placeholder"></span>').text(this.options.placeholder).appendTo("body"), this.$inputLabel = this.$element.find("label"), this.$inputSugestions = this.$element.find("ul"), this.refreshTags()
    }, i.prototype.setupEvents = function() {
        var t = this;
        this.$element.on("click.hbtags", e.proxy(this.on_click, this)), this.$element.on("mouseenter.hbtags", e.proxy(this.on_mouseenter, this)), this.$element.on("mouseleave.hbtags", e.proxy(this.on_mouseleave, this)), this.$input.on("blur.hbtags", e.proxy(this.on_blur, this)), this.$input.on("focus.hbtags", e.proxy(this.on_focus, this)), this.$input.on("keyup.hbtags", e.proxy(this.on_keyup, this)), this.$input.on("keydown.hbtags", e.proxy(this.on_keydown, this)), this.$input.on("submit.hbtags", function() {
            return !1
        }), this.$inputSugestions.on("click.hbtags", "a", function() {
            t.insertTags([e(this).text()]), t.$input.val("")
        }), this.options.sortable && this.$element.sortable({
            items: ".tag",
            start: e.proxy(this.on_sort_start, this),
            update: e.proxy(this.on_sort_end, this)
        }), this.close_suggestion_timeout = !1
    }, i.prototype.on_sort_start = function(e, t) {
        this.sortIndex = t.helper.index(), this.sortTag = this.tags[this.sortIndex], t.placeholder.html(t.helper.html())
    }, i.prototype.on_sort_end = function(e, t) {
        this.tags.splice(this.sortIndex, 1), this.tags.splice(t.item.index(), 0, this.sortTag), this.refreshTags()
    }, i.prototype.on_blur = function(e) {
        var t = this;
        t.options.autoSubmit ? this.clear_input_timeout = setTimeout(function() {
            t.insertTags([t.$input.val()]), t.$input.val(""), t.on_mouseleave(e)
        }, this.options.blur_timout) : t.on_mouseleave(e)
    }, i.prototype.on_focus = function(e) {
        this.clear_input_timeout && (clearTimeout(this.clear_input_timeout), this.clear_input_timeout = null), this.refreshSuggestions(), this.on_mouseenter(e)
    }, i.prototype.on_keydown = function(e) {
        return 40 === e.keyCode ? (this.nextSuggestion(), !1) : 38 === e.keyCode ? (this.prevSuggestion(), !1) : void(13 === e.keyCode && e.preventDefault())
    }, i.prototype.on_keyup = function(e) {
        if (38 === e.keyCode || 40 === e.keyCode || 39 === e.keyCode || 37 === e.keyCode) return !1;
        if (e.preventDefault(), this.savedTagName = null, 13 === e.keyCode) {
            var t = [this.$input.val()];
            return this.$input.val(""), void this.insertTags(t)
        }
        this.updateInputWidth(), this.refreshSuggestions()
    }, i.prototype.on_mouseenter = function(e) {
        this.close_suggestion_timeout && (clearTimeout(this.close_suggestion_timeout), this.close_suggestion_timeout = null)
    }, i.prototype.on_mouseleave = function(e) {
        if (!this.$input.is(":focus")) {
            var t = this;
            this.close_suggestion_timeout = setTimeout(function() {
                t.$inputSugestions.hide()
            }, this.options.blur_timout)
        }
    }, i.prototype.on_click = function(t) {
        if (t) {
            var n = e(t.target);
            if (n.hasClass("tag-rem")) return this.refreshTags();
            if (n.hasClass("tag-edit") || n.closest(".popover").length) return
        }
        this.$input.focus()
    }, i.prototype.updateInputWidth = function() {
        this.$inputPlaceholder.text(this.$input.val() || this.options.placeholder), this.$input.css("min-width", this.$inputPlaceholder.width())
    }, i.prototype.inputFilter = function(e) {
        return e.length > 0
    }, i.prototype.removeTags = function(t) {
        var n, i = this;
        t = t.filter(i.inputFilter), i.$element.trigger("tags.before.rem", [t, i]), e.each(t, function(e, t) {
            (n = i.tags.indexOf(t)) < 0 || (i.tags.splice(n, 1), i.$element.trigger("tags.rem", [t, i]))
        }), this.refreshTags()
    }, i.prototype.insertTags = function(t) {
        var n = this;
        t = t.filter(n.inputFilter), n.$element.trigger("tags.before.add", [t, n]), e.each(t, function(e, t) {
            !t.length || n.tags.indexOf(t) >= 0 || (n.tags.push(t), n.$element.trigger("tags.add", [t, n]))
        }), this.refreshTags()
    }, i.prototype.refreshTags = function() {
        var t, n = document.createElement("div"),
            i = this;
        for (t = this.tagNodes.length - 1; t >= 0; t--) this.tagNodes[t].parentNode.removeChild(this.tagNodes[t]), delete this.tagNodes[t];
        this.tagNodes.length = 0, e.each(this.tags, function(t, s) {
            var r = i.tags_colors[s] || i.options.color;
            n.innerHTML = i.options.tag_template.replace("%tag", s).replace("%color", r), i.tagNodes.push(n.firstChild), e(n.firstChild).data({
                tag: s,
                color: r,
                index: t
            }).find(".tag-rem").on("click.hbtags", function() {
                i.removeTags([s])
            }), i.options.colors ? e(n.firstChild).find(".tag-edit").hbpicker({
                color: r
            }).on("hbpicker.color", function(t, n) {
                e(this).parent().css("background-color", n), i.$element.trigger("tags.color", [s, n])
            }) : e(n.firstChild).find(".tag-edit").remove(), i.$inputLabel.before(n.firstChild), i.$element.trigger("tags.insert", [s, n.firstChild])
        }), i.$element.trigger("tags.refresh", [this]), this.updateInputWidth(), this.refreshSuggestions()
    }, i.prototype.refreshSuggestions = function() {
        var n = this,
            i = document.createElement("div"),
            s = 0,
            r = (null === this.savedTagName ? this.$input.val() || "" : this.savedTagName).toLowerCase();
        if (n.$inputSugestions.empty(), e.each(this.suggestions, function(e, t) {
                if (n.options.max_suggestions > 0 && s >= n.options.max_suggestions) return !1;
                if (!(n.tags.indexOf(t) >= 0)) {
                    var o = t === r ? 'class="active"' : "";
                    if (r.length) {
                        var a = t.toLowerCase().indexOf(r);
                        if (a < 0) return;
                        t = t.substr(0, a) + "<u>" + t.substr(a, r.length) + "</u>" + t.substr(a + r.length)
                    }
                    i.innerHTML = "<li " + o + "><a>" + t + "</a></li>", n.$inputSugestions.append(i.firstChild), n.$element.trigger("tags.suggest", [i.firstChild]), s++
                }
            }), !s) return this.$inputSugestions.hide();
        n.$input.is(":focus") && n.$inputSugestions.show(), n.$element.trigger("tags.suggestions", [this.$inputSugestions]);
        var o = n.$inputSugestions[0].getBoundingClientRect();
        n.$inputSugestions.is(".tags-flip") && o.top + t.scrollY < 0 ? n.$inputSugestions.removeClass("tags-flip") : o.bottom + t.scrollY > t.innerHeight && n.$inputSugestions.addClass("tags-flip")
    }, i.prototype.nextSuggestion = function() {
        this.selectSuggestion(1)
    }, i.prototype.prevSuggestion = function() {
        this.selectSuggestion(-1)
    }, i.prototype.selectSuggestion = function(e) {
        var t = this.$inputSugestions.children(),
            n = t.filter(".active");
        if (n.length ? (n.removeClass("active"), (n = e > 0 ? n.next() : n.prev()).length ? this.$input.val(n.addClass("active").text()) : (this.$input.val(this.savedTagName), this.savedTagName = null)) : (null === this.savedTagName && (this.savedTagName = this.$input.val()), n = e > 0 ? t.first() : t.last(), this.$input.val(n.addClass("active").text())), n.length) {
            var i = this.$inputSugestions.scrollTop(),
                s = n.position().top,
                r = n.height(),
                o = this.$inputSugestions.height();
            s + r > o ? this.$inputSugestions.scrollTop(i + s + r - o) : s < 0 && this.$inputSugestions.scrollTop(i + s)
        }
    }, s.prototype.filter = function(e, t) {
        var n = this.$element.find(this.options.items).hide().filter("[data-tags*='" + t + "']").show();
        return this.$element.trigger("tagsfilter.filter", [n]), this.$reset.show(), this.$container.html(this.options.template.replace("%tag", t)), !1
    }, s.prototype.reset = function(e, t) {
        var n = this.$element.find(this.options.items).show();
        this.$element.trigger("tagsfilter.filter", [n]), this.$reset.hide(), this.$container.hide()
    }, e.fn.extend({
        hbtags: function(t) {
            return this.each(function(n) {
                var s;
                (s = e(this)).data("hbtags") instanceof i || s.data("hbtags", new i(this, t))
            })
        },
        hbtagsFilter: function(t) {
            return this.each(function(n) {
                var i;
                (i = e(this)).data("hbtagsfilter") instanceof s || i.data("hbtagsfilter", new s(this, t))
            })
        }
    })
}(jQuery, window);
var HBUtils = {
    hbColors: {
        primary: ["#3498db", "52, 152, 219"],
        success: ["#2ecc71", "46, 204, 113"],
        warning: ["#f1c40f", "241, 196, 15"],
        danger: ["#e74c3c", "231, 76, 60"],
        info: ["#1abcaf", "26, 188, 175"],
        brown: ["#c0392b", "192, 57, 43"],
        indigo: ["#9b59b6", "155, 89, 182"],
        orange: ["#e67e22", "230, 126, 34"],
        midnightblue: ["#34495e", "52, 73, 94"],
        sky: ["#82c4e6", "130, 196, 230"],
        magenta: ["#e73c68", "231, 60, 104"],
        purple: ["#e044ab", "224, 68, 171"],
        green: ["#16a085", "22, 160, 133"],
        grape: ["#7a869c", "122, 134, 156"],
        toyo: ["#556b8d", "85, 107, 141"],
        alizarin: ["#e74c3c", "231, 76, 60"],
        default: ["#ecf0f1", "236, 240, 241"],
        inverse: ["#95a5a6", "149, 165, 166"],
        gray: ["#aaa", "170, 170, 170"]
    },
    getColor: function(e, t) {
        return HBUtils.hbColors[e] ? HBUtils.hbColors[e][t] : HBUtils.hbColors.default[t]
    },
    getNextColor: function(e, t) {
        void 0 === t && (t = 0);
        var n = 0,
            i = "default";
        return $.each(HBUtils.hbColors, function(t, s) {
            n == e && (i = t), n++
        }), HBUtils.getColor(i, t)
    }
};
! function(e, t, n) {
    e.fn.infinitepages = function(t) {
        t = e.extend({
            element: ".npaginer",
            currentselector: ".currentpage",
            appendafter: "<span class='append-dots'> ...</span>",
            appendbefore: "<span class='append-dots'>... </span>",
            pageselector: "div.slide:visible",
            showall: "Show all",
            siblings: 3
        }, t || {});
        var n = e(t.element, e(this));
        n.hide();
        var i = n.filter(t.currentselector);
        if (!i.length) return e(this);
        i.show();
        for (var s = i.prev(), r = i.next(), o = 0; o < t.siblings; o++) s.length && (s.show(), s = s.prev()), r.length && (r.show(), r = r.next());
        if (s.length && s.after(e(t.appendafter)), r.length && r.before(e(t.appendbefore)), t.showall && (r.length || s.length)) {
            var a = e("<a>").addClass("editbtn").text(t.showall).attr("href", "#").on("click", function() {
                return n.show(), e(this).hide(), e(".append-dots").hide(), !1
            });
            e(this).append(a)
        }
        return n.click(function() {
            return ajax_update(e(this).attr("href"), {}, t.pageselector), !1
        }), e(this).show(), e(this)
    }
}(jQuery, window),
function(e, t, n) {
    function i(n) {
        var i = t.console;
        r[n] || (r[n] = !0, e.migrateWarnings.push(n), i && i.warn && !e.migrateMute && (i.warn("JQMIGRATE: " + n), e.migrateTrace && i.trace && i.trace()))
    }

    function s(t, n, s, r) {
        if (Object.defineProperty) try {
            return void Object.defineProperty(t, n, {
                configurable: !0,
                enumerable: !0,
                get: function() {
                    return i(r), s
                },
                set: function(e) {
                    i(r), s = e
                }
            })
        } catch (e) {}
        e._definePropertyBroken = !0, t[n] = s
    }
    e.migrateVersion = "1.4.1";
    var r = {};
    e.migrateWarnings = [], e.migrateMute = !1, void 0 === e.migrateTrace && (e.migrateTrace = !1), e.migrateReset = function() {
        r = {}, e.migrateWarnings.length = 0
    }, "BackCompat" === document.compatMode && i("jQuery is not compatible with Quirks Mode");
    var o = e("<input/>", {
            size: 1
        }).attr("size") && e.attrFn,
        a = e.attr,
        l = e.attrHooks.value && e.attrHooks.value.get || function() {
            return null
        },
        c = e.attrHooks.value && e.attrHooks.value.set || function() {},
        d = /^(?:input|button)$/i,
        u = /^[238]$/,
        h = /^(?:autofocus|autoplay|async|checked|controls|defer|disabled|hidden|loop|multiple|open|readonly|required|scoped|selected)$/i,
        p = /^(?:checked|selected)$/i;
    s(e, "attrFn", o || {}, "jQuery.attrFn is deprecated"), e.attr = function(t, n, s, r) {
        var l = n.toLowerCase(),
            c = t && t.nodeType;
        return r && (a.length < 4 && i("jQuery.fn.attr( props, pass ) is deprecated"), t && !u.test(c) && (o ? n in o : e.isFunction(e.fn[n]))) ? e(t)[n](s) : ("type" === n && void 0 !== s && d.test(t.nodeName) && t.parentNode && i("Can't change the 'type' of an input or button in IE 6/7/8"), !e.attrHooks[l] && h.test(l) && (e.attrHooks[l] = {
            get: function(t, n) {
                var i, s = e.prop(t, n);
                return !0 === s || "boolean" != typeof s && (i = t.getAttributeNode(n)) && !1 !== i.nodeValue ? n.toLowerCase() : void 0
            },
            set: function(t, n, i) {
                var s;
                return !1 === n ? e.removeAttr(t, i) : ((s = e.propFix[i] || i) in t && (t[s] = !0), t.setAttribute(i, i.toLowerCase())), i
            }
        }, p.test(l) && i("jQuery.fn.attr('" + l + "') might use property instead of attribute")), a.call(e, t, n, s))
    }, e.attrHooks.value = {
        get: function(e, t) {
            var n = (e.nodeName || "").toLowerCase();
            return "button" === n ? l.apply(this, arguments) : ("input" !== n && "option" !== n && i("jQuery.fn.attr('value') no longer gets properties"), t in e ? e.value : null)
        },
        set: function(e, t) {
            var n = (e.nodeName || "").toLowerCase();
            if ("button" === n) return c.apply(this, arguments);
            "input" !== n && "option" !== n && i("jQuery.fn.attr('value', val) no longer sets properties"), e.value = t
        }
    };
    var f, m, g = e.fn.init,
        v = e.find,
        _ = e.parseJSON,
        y = /^\s*</,
        b = /\[(\s*[-\w]+\s*)([~|^$*]?=)\s*([-\w#]*?#[-\w#]*)\s*\]/,
        w = /\[(\s*[-\w]+\s*)([~|^$*]?=)\s*([-\w#]*?#[-\w#]*)\s*\]/g,
        x = /^([^<]*)(<[\w\W]+>)([^>]*)$/;
    e.fn.init = function(t, n, s) {
        var r, o;
        return t && "string" == typeof t && !e.isPlainObject(n) && (r = x.exec(e.trim(t))) && r[0] && (y.test(t) || i("$(html) HTML strings must start with '<' character"), r[3] && i("$(html) HTML text after last tag is ignored"), "#" === r[0].charAt(0) && (i("HTML string cannot start with a '#' character"), e.error("JQMIGRATE: Invalid selector string (XSS)")), n && n.context && n.context.nodeType && (n = n.context), e.parseHTML) ? g.call(this, e.parseHTML(r[2], n && n.ownerDocument || n || document, !0), n, s) : (o = g.apply(this, arguments), t && void 0 !== t.selector ? (o.selector = t.selector, o.context = t.context) : (o.selector = "string" == typeof t ? t : "", t && (o.context = t.nodeType ? t : n || document)), o)
    }, e.fn.init.prototype = e.fn, e.find = function(e) {
        var t = Array.prototype.slice.call(arguments);
        if ("string" == typeof e && b.test(e)) try {
            document.querySelector(e)
        } catch (n) {
            e = e.replace(w, function(e, t, n, i) {
                return "[" + t + n + '"' + i + '"]'
            });
            try {
                document.querySelector(e), i("Attribute selector with '#' must be quoted: " + t[0]), t[0] = e
            } catch (e) {
                i("Attribute selector with '#' was not fixed: " + t[0])
            }
        }
        return v.apply(this, t)
    };
    var k;
    for (k in v) Object.prototype.hasOwnProperty.call(v, k) && (e.find[k] = v[k]);
    e.parseJSON = function(e) {
        return e ? _.apply(this, arguments) : (i("jQuery.parseJSON requires a valid JSON string"), null)
    }, e.uaMatch = function(e) {
        e = e.toLowerCase();
        var t = /(chrome)[ \/]([\w.]+)/.exec(e) || /(webkit)[ \/]([\w.]+)/.exec(e) || /(opera)(?:.*version|)[ \/]([\w.]+)/.exec(e) || /(msie) ([\w.]+)/.exec(e) || e.indexOf("compatible") < 0 && /(mozilla)(?:.*? rv:([\w.]+)|)/.exec(e) || [];
        return {
            browser: t[1] || "",
            version: t[2] || "0"
        }
    }, e.browser || (m = {}, (f = e.uaMatch(navigator.userAgent)).browser && (m[f.browser] = !0, m.version = f.version), m.chrome ? m.webkit = !0 : m.webkit && (m.safari = !0), e.browser = m), s(e, "browser", e.browser, "jQuery.browser is deprecated"), e.boxModel = e.support.boxModel = "CSS1Compat" === document.compatMode, s(e, "boxModel", e.boxModel, "jQuery.boxModel is deprecated"), s(e.support, "boxModel", e.support.boxModel, "jQuery.support.boxModel is deprecated"), e.sub = function() {
        function t(e, n) {
            return new t.fn.init(e, n)
        }
        e.extend(!0, t, this), t.superclass = this, (t.fn = t.prototype = this()).constructor = t, t.sub = this.sub, t.fn.init = function(i, s) {
            var r = e.fn.init.call(this, i, s, n);
            return r instanceof t ? r : t(r)
        }, t.fn.init.prototype = t.fn;
        var n = t(document);
        return i("jQuery.sub() is deprecated"), t
    }, e.fn.size = function() {
        return i("jQuery.fn.size() is deprecated; use the .length property"), this.length
    };
    var C = !1;
    e.swap && e.each(["height", "width", "reliableMarginRight"], function(t, n) {
        var i = e.cssHooks[n] && e.cssHooks[n].get;
        i && (e.cssHooks[n].get = function() {
            var e;
            return C = !0, e = i.apply(this, arguments), C = !1, e
        })
    }), e.swap = function(e, t, n, s) {
        var r, o, a = {};
        C || i("jQuery.swap() is undocumented and deprecated");
        for (o in t) a[o] = e.style[o], e.style[o] = t[o];
        r = n.apply(e, s || []);
        for (o in t) e.style[o] = a[o];
        return r
    }, e.ajaxSetup({
        converters: {
            "text json": e.parseJSON
        }
    });
    var $ = e.fn.data;
    e.fn.data = function(t) {
        var n, s, r = this[0];
        return !r || "events" !== t || 1 !== arguments.length || (n = e.data(r, t), s = e._data(r, t), void 0 !== n && n !== s || void 0 === s) ? $.apply(this, arguments) : (i("Use of jQuery.fn.data('events') is deprecated"), s)
    };
    var S = /\/(java|ecma)script/i;
    e.clean || (e.clean = function(t, n, s, r) {
        n = (n = !(n = n || document).nodeType && n[0] || n).ownerDocument || n, i("jQuery.clean() is deprecated");
        var o, a, l, c, d = [];
        if (e.merge(d, e.buildFragment(t, n).childNodes), s)
            for (l = function(e) {
                    if (!e.type || S.test(e.type)) return r ? r.push(e.parentNode ? e.parentNode.removeChild(e) : e) : s.appendChild(e)
                }, o = 0; null != (a = d[o]); o++) e.nodeName(a, "script") && l(a) || (s.appendChild(a), void 0 !== a.getElementsByTagName && (c = e.grep(e.merge([], a.getElementsByTagName("script")), l), d.splice.apply(d, [o + 1, 0].concat(c)), o += c.length));
        return d
    });
    var T = e.event.add,
        D = e.event.remove,
        E = e.event.trigger,
        P = e.fn.toggle,
        O = e.fn.live,
        M = e.fn.die,
        N = e.fn.load,
        I = "ajaxStart|ajaxStop|ajaxSend|ajaxComplete|ajaxError|ajaxSuccess",
        A = new RegExp("\\b(?:" + I + ")\\b"),
        j = /(?:^|\s)hover(\.\S+|)\b/,
        H = function(t) {
            return "string" != typeof t || e.event.special.hover ? t : (j.test(t) && i("'hover' pseudo-event is deprecated, use 'mouseenter mouseleave'"), t && t.replace(j, "mouseenter$1 mouseleave$1"))
        };
    e.event.props && "attrChange" !== e.event.props[0] && e.event.props.unshift("attrChange", "attrName", "relatedNode", "srcElement"), e.event.dispatch && s(e.event, "handle", e.event.dispatch, "jQuery.event.handle is undocumented and deprecated"), e.event.add = function(e, t, n, s, r) {
        e !== document && A.test(t) && i("AJAX events should be attached to document: " + t), T.call(this, e, H(t || ""), n, s, r)
    }, e.event.remove = function(e, t, n, i, s) {
        D.call(this, e, H(t) || "", n, i, s)
    }, e.each(["load", "unload", "error"], function(t, n) {
        e.fn[n] = function() {
            var e = Array.prototype.slice.call(arguments, 0);
            return "load" === n && "string" == typeof e[0] ? N.apply(this, e) : (i("jQuery.fn." + n + "() is deprecated"), e.splice(0, 0, n), arguments.length ? this.bind.apply(this, e) : (this.triggerHandler.apply(this, e), this))
        }
    }), e.fn.toggle = function(t, n) {
        if (!e.isFunction(t) || !e.isFunction(n)) return P.apply(this, arguments);
        i("jQuery.fn.toggle(handler, handler...) is deprecated");
        var s = arguments,
            r = t.guid || e.guid++,
            o = 0,
            a = function(n) {
                var i = (e._data(this, "lastToggle" + t.guid) || 0) % o;
                return e._data(this, "lastToggle" + t.guid, i + 1), n.preventDefault(), s[i].apply(this, arguments) || !1
            };
        for (a.guid = r; o < s.length;) s[o++].guid = r;
        return this.click(a)
    }, e.fn.live = function(t, n, s) {
        return i("jQuery.fn.live() is deprecated"), O ? O.apply(this, arguments) : (e(this.context).on(t, this.selector, n, s), this)
    }, e.fn.die = function(t, n) {
        return i("jQuery.fn.die() is deprecated"), M ? M.apply(this, arguments) : (e(this.context).off(t, this.selector || "**", n), this)
    }, e.event.trigger = function(e, t, n, s) {
        return n || A.test(e) || i("Global events are undocumented and deprecated"), E.call(this, e, t, n || document, s)
    }, e.each(I.split("|"), function(t, n) {
        e.event.special[n] = {
            setup: function() {
                var t = this;
                return t !== document && (e.event.add(document, n + "." + e.guid, function() {
                    e.event.trigger(n, Array.prototype.slice.call(arguments, 1), t, !0)
                }), e._data(this, n, e.guid++)), !1
            },
            teardown: function() {
                return this !== document && e.event.remove(document, n + "." + e._data(this, n)), !1
            }
        }
    }), e.event.special.ready = {
        setup: function() {
            this === document && i("'ready' event is deprecated")
        }
    };
    var L = e.fn.andSelf || e.fn.addBack,
        F = e.fn.find;
    if (e.fn.andSelf = function() {
            return i("jQuery.fn.andSelf() replaced by jQuery.fn.addBack()"), L.apply(this, arguments)
        }, e.fn.find = function(e) {
            var t = F.apply(this, arguments);
            return t.context = this.context, t.selector = this.selector ? this.selector + " " + e : e, t
        }, e.Callbacks) {
        var R = e.Deferred,
            B = [
                ["resolve", "done", e.Callbacks("once memory"), e.Callbacks("once memory"), "resolved"],
                ["reject", "fail", e.Callbacks("once memory"), e.Callbacks("once memory"), "rejected"],
                ["notify", "progress", e.Callbacks("memory"), e.Callbacks("memory")]
            ];
        e.Deferred = function(t) {
            var n = R(),
                s = n.promise();
            return n.pipe = s.pipe = function() {
                var t = arguments;
                return i("deferred.pipe() is deprecated"), e.Deferred(function(i) {
                    e.each(B, function(r, o) {
                        var a = e.isFunction(t[r]) && t[r];
                        n[o[1]](function() {
                            var t = a && a.apply(this, arguments);
                            t && e.isFunction(t.promise) ? t.promise().done(i.resolve).fail(i.reject).progress(i.notify) : i[o[0] + "With"](this === s ? i.promise() : this, a ? [t] : arguments)
                        })
                    }), t = null
                }).promise()
            }, n.isResolved = function() {
                return i("deferred.isResolved is deprecated"), "resolved" === n.state()
            }, n.isRejected = function() {
                return i("deferred.isRejected is deprecated"), "rejected" === n.state()
            }, t && t.call(n, n), n
        }
    }
}(jQuery, window);
var timing = 0,
    t = "",
    maximum = 10,
    num_errors = 0,
    num_infos = 0;
Date.dayNames = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"], Date.abbrDayNames = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"], Date.monthNames = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"], Date.abbrMonthNames = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"], Date.firstDayOfWeek = 1, Date.format = Date.format ? Date.format : "dd/mm/yyyy", Date.fullYearStart = "20",
    function() {
        function e(e, t) {
            Date.prototype[e] || (Date.prototype[e] = t)
        }
        e("isLeapYear", function() {
            var e = this.getFullYear();
            return e % 4 == 0 && e % 100 != 0 || e % 400 == 0
        }), e("isWeekend", function() {
            return 0 == this.getDay() || 6 == this.getDay()
        }), e("isWeekDay", function() {
            return !this.isWeekend()
        }), e("getDaysInMonth", function() {
            return [31, this.isLeapYear() ? 29 : 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31][this.getMonth()]
        }), e("getDayName", function(e) {
            return e ? Date.abbrDayNames[this.getDay()] : Date.dayNames[this.getDay()]
        }), e("getMonthName", function(e) {
            return e ? Date.abbrMonthNames[this.getMonth()] : Date.monthNames[this.getMonth()]
        }), e("getDayOfYear", function() {
            var e = new Date("1/1/" + this.getFullYear());
            return Math.floor((this.getTime() - e.getTime()) / 864e5)
        }), e("getWeekOfYear", function() {
            return Math.ceil(this.getDayOfYear() / 7)
        }), e("setDayOfYear", function(e) {
            return this.setMonth(0), this.setDate(e), this
        }), e("addYears", function(e) {
            return this.setFullYear(this.getFullYear() + e), this
        }), e("addMonths", function(e) {
            var t = this.getDate();
            return this.setMonth(this.getMonth() + e), t > this.getDate() && this.addDays(-this.getDate()), this
        }), e("addDays", function(e) {
            return this.setTime(this.getTime() + 864e5 * e), this
        }), e("addHours", function(e) {
            return this.setHours(this.getHours() + e), this
        }), e("addMinutes", function(e) {
            return this.setMinutes(this.getMinutes() + e), this
        }), e("addSeconds", function(e) {
            return this.setSeconds(this.getSeconds() + e), this
        }), e("zeroTime", function() {
            return this.setMilliseconds(0), this.setSeconds(0), this.setMinutes(0), this.setHours(0), this
        }), e("asString", function(e) {
            return (e || Date.format).split("yyyy").join(this.getFullYear()).split("yy").join((this.getFullYear() + "").substring(2)).split("mmmm").join(this.getMonthName(!1)).split("mmm").join(this.getMonthName(!0)).split("mm").join(t(this.getMonth() + 1)).split("dd").join(t(this.getDate())).split("hh").join(t(this.getHours())).split("min").join(t(this.getMinutes())).split("ss").join(t(this.getSeconds()))
        }), Date.fromString = function(e, t) {
            var n = t || Date.format,
                i = new Date("01/01/1977"),
                s = 0,
                r = n.indexOf("mmmm");
            if (r > -1) {
                for (var o = 0; o < Date.monthNames.length; o++) {
                    var a = e.substr(r, Date.monthNames[o].length);
                    if (Date.monthNames[o] == a) {
                        s = Date.monthNames[o].length - 4;
                        break
                    }
                }
                i.setMonth(o)
            } else if ((r = n.indexOf("mmm")) > -1) {
                for (a = e.substr(r, 3), o = 0; o < Date.abbrMonthNames.length && Date.abbrMonthNames[o] != a; o++);
                i.setMonth(o)
            } else i.setMonth(Number(e.substr(n.indexOf("mm"), 2)) - 1);
            var l = n.indexOf("yyyy");
            l > -1 ? (r < l && (l += s), i.setFullYear(Number(e.substr(l, 4)))) : (r < l && (l += s), i.setFullYear(Number(Date.fullYearStart + e.substr(n.indexOf("yy"), 2))));
            var c = n.indexOf("dd");
            return r < c && (c += s), i.setDate(Number(e.substr(c, 2))), !isNaN(i.getTime()) && i
        };
        var t = function(e) {
            var t = "0" + e;
            return t.substring(t.length - 2)
        }
    }(),
    function(e) {
        function t(e) {
            this.ele = e, this.displayedMonth = null, this.displayedYear = null, this.startDate = null, this.endDate = null, this.showYearNavigation = null, this.closeOnSelect = null, this.displayClose = null, this.rememberViewedMonth = null, this.selectMultiple = null, this.numSelectable = null, this.numSelected = null, this.verticalPosition = null, this.horizontalPosition = null, this.verticalOffset = null, this.horizontalOffset = null, this.button = null, this.renderCallback = [], this.selectedDates = {}, this.inline = null, this.context = "#dp-popup", this.settings = {}
        }

        function n(t) {
            return !!t._dpId && e.event._dpCache[t._dpId]
        }
        e.fn.extend({
            renderCalendar: function(t) {
                var n = function(e) {
                    return document.createElement(e)
                };
                if ((t = e.extend({}, e.fn.datePicker.defaults, t)).showHeader != e.dpConst.SHOW_HEADER_NONE)
                    for (var i = e(n("tr")), s = Date.firstDayOfWeek; s < Date.firstDayOfWeek + 7; s++) {
                        var r = s % 7,
                            o = Date.dayNames[r];
                        i.append(jQuery(n("th")).attr({
                            scope: "col",
                            abbr: o,
                            title: o,
                            class: 0 == r || 6 == r ? "weekend" : "weekday"
                        }).html(t.showHeader == e.dpConst.SHOW_HEADER_SHORT ? o.substr(0, 1) : o))
                    }
                var a = e(n("table")).attr({
                        cellspacing: 2
                    }).addClass("jCalendar").append(t.showHeader != e.dpConst.SHOW_HEADER_NONE ? e(n("thead")).append(i) : n("thead")),
                    l = e(n("tbody")),
                    c = (new Date).zeroTime();
                c.setHours(12);
                var d = void 0 == t.month ? c.getMonth() : t.month,
                    u = t.year || c.getFullYear(),
                    h = new Date(u, d, 1, 12, 0, 0),
                    p = Date.firstDayOfWeek - h.getDay() + 1;
                p > 1 && (p -= 7);
                var f = Math.ceil((-1 * p + 1 + h.getDaysInMonth()) / 7);
                h.addDays(p - 1);
                for (var m = function(n) {
                        return function() {
                            if (t.hoverClass) {
                                var i = e(this);
                                t.selectWeek ? n && !i.is(".disabled") && i.parent().addClass("activeWeekHover") : i.addClass(t.hoverClass)
                            }
                        }
                    }, g = function() {
                        if (t.hoverClass) {
                            var n = e(this);
                            n.removeClass(t.hoverClass), n.parent().removeClass("activeWeekHover")
                        }
                    }, v = 0; v++ < f;) {
                    var _ = jQuery(n("tr")),
                        y = !!t.dpController && h > t.dpController.startDate;
                    for (s = 0; s < 7; s++) {
                        var b = h.getMonth() == d,
                            w = e(n("td")).text(h.getDate() + "").addClass((b ? "current-month " : "other-month ") + (h.isWeekend() ? "weekend " : "weekday ") + (b && h.getTime() == c.getTime() ? "today " : "")).data("datePickerDate", h.asString()).hover(m(y), g);
                        _.append(w), t.renderCallback && t.renderCallback(w, h, d, u), h = new Date(h.getFullYear(), h.getMonth(), h.getDate() + 1, 12, 0, 0)
                    }
                    l.append(_)
                }
                return a.append(l), this.each(function() {
                    e(this).empty().append(a)
                })
            },
            datePicker: function(n) {
                return e.event._dpCache || (e.event._dpCache = []), n = e.extend({}, e.fn.datePicker.defaults, n), this.each(function() {
                    var i = e(this),
                        s = !0;
                    this._dpId || (this._dpId = e.guid++, e.event._dpCache[this._dpId] = new t(this), s = !1), n.inline && (n.createButton = !1, n.displayClose = !1, n.closeOnSelect = !1, i.empty());
                    var r = e.event._dpCache[this._dpId];
                    if (r.init(n), !s && n.createButton && (r.button = e('<a href="#" class="dp-choose-date" title="' + e.dpText.TEXT_CHOOSE_DATE + '">' + e.dpText.TEXT_CHOOSE_DATE + "</a>").bind("click", function() {
                            return i.dpDisplay(this), this.blur(), !1
                        }), i.after(r.button)), !s && i.is(":text")) {
                        i.bind("dateSelected", function(e, t, n) {
                            this.value = t.asString()
                        }).bind("change", function() {
                            if ("" == this.value) r.clearSelected();
                            else {
                                var e = Date.fromString(this.value);
                                e && r.setSelected(e, !0, !0)
                            }
                        }), n.clickInput && i.bind("click", function() {
                            i.trigger("change"), i.dpDisplay()
                        });
                        var o = Date.fromString(this.value);
                        "" != this.value && o && r.setSelected(o, !0, !0)
                    }
                    i.addClass("dp-applied")
                })
            },
            dpSetDisabled: function(e) {
                return i.call(this, "setDisabled", e)
            },
            dpSetStartDate: function(e) {
                return i.call(this, "setStartDate", e)
            },
            dpSetEndDate: function(e) {
                return i.call(this, "setEndDate", e)
            },
            dpGetSelected: function() {
                var e = n(this[0]);
                return e ? e.getSelected() : null
            },
            dpSetSelected: function(e, t, n, s) {
                return void 0 == t && (t = !0), void 0 == n && (n = !0), void 0 == s && (s = !0), i.call(this, "setSelected", Date.fromString(e), t, n, s)
            },
            dpSetDisplayedMonth: function(e, t) {
                return i.call(this, "setDisplayedMonth", Number(e), Number(t), !0)
            },
            dpDisplay: function(e) {
                return i.call(this, "display", e)
            },
            dpSetRenderCallback: function(e) {
                return i.call(this, "setRenderCallback", e)
            },
            dpSetPosition: function(e, t) {
                return i.call(this, "setPosition", e, t)
            },
            dpSetOffset: function(e, t) {
                return i.call(this, "setOffset", e, t)
            },
            dpClose: function() {
                return i.call(this, "_closeCalendar", !1, this[0])
            },
            dpRerenderCalendar: function() {
                return i.call(this, "_rerenderCalendar")
            },
            _dpDestroy: function() {}
        });
        var i = function(e, t, i, s, r) {
            return this.each(function() {
                var o = n(this);
                o && o[e](t, i, s, r)
            })
        };
        e.extend(t.prototype, {
            init: function(e) {
                this.setStartDate(e.startDate), this.setEndDate(e.endDate), this.setDisplayedMonth(Number(e.month), Number(e.year)), this.setRenderCallback(e.renderCallback), this.showYearNavigation = e.showYearNavigation, this.closeOnSelect = e.closeOnSelect, this.displayClose = e.displayClose, this.rememberViewedMonth = e.rememberViewedMonth, this.selectMultiple = e.selectMultiple, this.numSelectable = e.selectMultiple ? e.numSelectable : 1, this.numSelected = 0, this.verticalPosition = e.verticalPosition, this.horizontalPosition = e.horizontalPosition, this.hoverClass = e.hoverClass, this.setOffset(e.verticalOffset, e.horizontalOffset), this.inline = e.inline, this.settings = e, this.inline && (this.context = this.ele, this.display())
            },
            setStartDate: function(e) {
                e && (this.startDate = Date.fromString(e)), this.startDate || (this.startDate = (new Date).zeroTime()), this.setDisplayedMonth(this.displayedMonth, this.displayedYear)
            },
            setEndDate: function(e) {
                e && (this.endDate = Date.fromString(e)), this.endDate || (this.endDate = new Date("12/31/2999")), this.endDate.getTime() < this.startDate.getTime() && (this.endDate = this.startDate), this.setDisplayedMonth(this.displayedMonth, this.displayedYear)
            },
            setPosition: function(e, t) {
                this.verticalPosition = e, this.horizontalPosition = t
            },
            setOffset: function(e, t) {
                this.verticalOffset = parseInt(e) || 0, this.horizontalOffset = parseInt(t) || 0
            },
            setDisabled: function(t) {
                $e = e(this.ele), $e[t ? "addClass" : "removeClass"]("dp-disabled"), this.button && ($but = e(this.button), $but[t ? "addClass" : "removeClass"]("dp-disabled"), $but.attr("title", t ? "" : e.dpText.TEXT_CHOOSE_DATE)), $e.is(":text") && $e.attr("disabled", t ? "disabled" : "")
            },
            setDisplayedMonth: function(t, n, i) {
                if (void 0 != this.startDate && void 0 != this.endDate) {
                    var s = new Date(this.startDate.getTime());
                    s.setDate(1);
                    var r = new Date(this.endDate.getTime());
                    r.setDate(1);
                    var o;
                    !t && !n || isNaN(t) && isNaN(n) ? (o = (new Date).zeroTime()).setDate(1) : o = isNaN(t) ? new Date(n, this.displayedMonth, 1) : isNaN(n) ? new Date(this.displayedYear, t, 1) : new Date(n, t, 1), o.getTime() < s.getTime() ? o = s : o.getTime() > r.getTime() && (o = r);
                    var a = this.displayedMonth,
                        l = this.displayedYear;
                    this.displayedMonth = o.getMonth(), this.displayedYear = o.getFullYear(), !i || this.displayedMonth == a && this.displayedYear == l || (this._rerenderCalendar(), e(this.ele).trigger("dpMonthChanged", [this.displayedMonth, this.displayedYear]))
                }
            },
            setSelected: function(t, n, i, s) {
                if (!(t < this.startDate || t.zeroTime() > this.endDate.zeroTime())) {
                    if (!((a = this.settings).selectWeek && (t = t.addDays(-(t.getDay() - Date.firstDayOfWeek + 7) % 7)) < this.startDate) && n != this.isSelected(t)) {
                        if (0 == this.selectMultiple) this.clearSelected();
                        else if (n && this.numSelected == this.numSelectable) return;
                        !i || this.displayedMonth == t.getMonth() && this.displayedYear == t.getFullYear() || this.setDisplayedMonth(t.getMonth(), t.getFullYear(), !0), this.selectedDates[t.asString()] = n, this.numSelected += n ? 1 : -1;
                        var r, o = "td." + (t.getMonth() == this.displayedMonth ? "current-month" : "other-month");
                        if (e(o, this.context).each(function() {
                                e(this).data("datePickerDate") == t.asString() && (r = e(this), a.selectWeek && r.parent()[n ? "addClass" : "removeClass"]("selectedWeek"), r[n ? "addClass" : "removeClass"]("selected"))
                            }), e("td", this.context).not(".selected")[this.selectMultiple && this.numSelected == this.numSelectable ? "addClass" : "removeClass"]("unselectable"), s) {
                            var a = this.isSelected(t);
                            $e = e(this.ele);
                            var l = Date.fromString(t.asString());
                            $e.trigger("dateSelected", [l, r, a]), $e.trigger("change")
                        }
                    }
                }
            },
            isSelected: function(e) {
                return this.selectedDates[e.asString()]
            },
            getSelected: function() {
                var e = [];
                for (var t in this.selectedDates) 1 == this.selectedDates[t] && e.push(Date.fromString(t));
                return e
            },
            clearSelected: function() {
                this.selectedDates = {}, this.numSelected = 0, e("td.selected", this.context).removeClass("selected").parent().removeClass("selectedWeek")
            },
            display: function(t) {
                if (!e(this.ele).is(".dp-disabled")) {
                    t = t || this.ele;
                    var n, i, s, r = this,
                        o = e(t),
                        a = o.offset();
                    if (r.inline) n = e(this.ele), i = {
                        id: "calendar-" + this.ele._dpId,
                        class: "dp-popup dp-popup-inline"
                    }, e(".dp-popup", n).remove(), s = {};
                    else {
                        n = e("body"), i = {
                            id: "dp-popup",
                            class: "dp-popup"
                        }, s = {
                            top: a.top + r.verticalOffset,
                            left: a.left + r.horizontalOffset
                        };
                        this._checkMouse = function(t) {
                            for (var n = t.target, i = e("#dp-popup")[0];;) {
                                if (n == i) return !0;
                                if (n == document) return r._closeCalendar(), !1;
                                n = e(n).parent()[0]
                            }
                        }, r._closeCalendar(!0), e(document).bind("keydown.datepicker", function(e) {
                            27 == e.keyCode && r._closeCalendar()
                        })
                    }
                    if (!r.rememberViewedMonth) {
                        var l = this.getSelected()[0];
                        l && (l = new Date(l), this.setDisplayedMonth(l.getMonth(), l.getFullYear(), !1))
                    }
                    n.append(e("<div></div>").attr(i).css(s).append(e("<h2></h2>"), e('<div class="dp-nav-prev"></div>').append(e('<a class="dp-nav-prev-year" href="#" title="' + e.dpText.TEXT_PREV_YEAR + '">&lt;&lt;</a>').bind("click", function() {
                        return r._displayNewMonth.call(r, this, 0, -1)
                    }), e('<a class="dp-nav-prev-month" href="#" title="' + e.dpText.TEXT_PREV_MONTH + '">&lt;</a>').bind("click", function() {
                        return r._displayNewMonth.call(r, this, -1, 0)
                    })), e('<div class="dp-nav-next"></div>').append(e('<a class="dp-nav-next-year" href="#" title="' + e.dpText.TEXT_NEXT_YEAR + '">&gt;&gt;</a>').bind("click", function() {
                        return r._displayNewMonth.call(r, this, 0, 1)
                    }), e('<a class="dp-nav-next-month" href="#" title="' + e.dpText.TEXT_NEXT_MONTH + '">&gt;</a>').bind("click", function() {
                        return r._displayNewMonth.call(r, this, 1, 0)
                    })), e('<div class="dp-calendar"></div>')).bgIframe());
                    var c = this.inline ? e(".dp-popup", this.context) : e("#dp-popup");
                    0 == this.showYearNavigation && e(".dp-nav-prev-year, .dp-nav-next-year", r.context).css("display", "none"), this.displayClose && c.append(e('<a href="#" id="dp-close">' + e.dpText.TEXT_CLOSE + "</a>").bind("click", function() {
                        return r._closeCalendar(), !1
                    })), r._renderCalendar(), e(this.ele).trigger("dpDisplayed", c), r.inline || (this.verticalPosition == e.dpConst.POS_BOTTOM && c.css("top", a.top + o.height() - c.height() + r.verticalOffset), this.horizontalPosition == e.dpConst.POS_RIGHT && c.css("left", a.left + o.width() - c.width() + r.horizontalOffset), e(document).bind("mousedown.datepicker", this._checkMouse))
                }
            },
            setRenderCallback: function(e) {
                null != e && (e && "function" == typeof e && (e = [e]), this.renderCallback = this.renderCallback.concat(e))
            },
            cellRender: function(t, n, i, s) {
                var r = this.dpController,
                    o = new Date(n.getTime());
                t.bind("click", function() {
                    var t = e(this);
                    if (!t.is(".disabled") && (r.setSelected(o, !t.is(".selected") || !r.selectMultiple, !1, !0), r.closeOnSelect)) {
                        if (r.settings.autoFocusNextInput) {
                            var n = r.ele,
                                i = !1;
                            e(":input", n.form).each(function() {
                                if (i) return e(this).focus(), !1;
                                this == n && (i = !0)
                            })
                        } else r.ele.focus();
                        r._closeCalendar()
                    }
                }), r.isSelected(o) ? (t.addClass("selected"), r.settings.selectWeek && t.parent().addClass("selectedWeek")) : r.selectMultiple && r.numSelected == r.numSelectable && t.addClass("unselectable")
            },
            _applyRenderCallbacks: function() {
                var t = this;
                e("td", this.context).each(function() {
                    for (var n = 0; n < t.renderCallback.length; n++) $td = e(this), t.renderCallback[n].apply(this, [$td, Date.fromString($td.data("datePickerDate")), t.displayedMonth, t.displayedYear])
                })
            },
            _displayNewMonth: function(t, n, i) {
                return e(t).is(".disabled") || this.setDisplayedMonth(this.displayedMonth + n, this.displayedYear + i, !0), t.blur(), !1
            },
            _rerenderCalendar: function() {
                this._clearCalendar(), this._renderCalendar()
            },
            _renderCalendar: function() {
                if (e("h2", this.context).html(new Date(this.displayedYear, this.displayedMonth, 1).asString(e.dpText.HEADER_FORMAT)), e(".dp-calendar", this.context).renderCalendar(e.extend({}, this.settings, {
                        month: this.displayedMonth,
                        year: this.displayedYear,
                        renderCallback: this.cellRender,
                        dpController: this,
                        hoverClass: this.hoverClass
                    })), this.displayedYear == this.startDate.getFullYear() && this.displayedMonth == this.startDate.getMonth()) {
                    e(".dp-nav-prev-year", this.context).addClass("disabled"), e(".dp-nav-prev-month", this.context).addClass("disabled"), e(".dp-calendar td.other-month", this.context).each(function() {
                        var t = e(this);
                        Number(t.text()) > 20 && t.addClass("disabled")
                    });
                    var t = this.startDate.getDate();
                    e(".dp-calendar td.current-month", this.context).each(function() {
                        var n = e(this);
                        Number(n.text()) < t && n.addClass("disabled")
                    })
                } else {
                    e(".dp-nav-prev-year", this.context).removeClass("disabled"), e(".dp-nav-prev-month", this.context).removeClass("disabled");
                    if ((t = this.startDate.getDate()) > 20) {
                        var n = this.startDate.getTime(),
                            i = new Date(n);
                        i.addMonths(1), this.displayedYear == i.getFullYear() && this.displayedMonth == i.getMonth() && e(".dp-calendar td.other-month", this.context).each(function() {
                            var t = e(this);
                            Date.fromString(t.data("datePickerDate")).getTime() < n && t.addClass("disabled")
                        })
                    }
                }
                if (this.displayedYear == this.endDate.getFullYear() && this.displayedMonth == this.endDate.getMonth()) {
                    e(".dp-nav-next-year", this.context).addClass("disabled"), e(".dp-nav-next-month", this.context).addClass("disabled"), e(".dp-calendar td.other-month", this.context).each(function() {
                        var t = e(this);
                        Number(t.text()) < 14 && t.addClass("disabled")
                    });
                    t = this.endDate.getDate();
                    e(".dp-calendar td.current-month", this.context).each(function() {
                        var n = e(this);
                        Number(n.text()) > t && n.addClass("disabled")
                    })
                } else {
                    e(".dp-nav-next-year", this.context).removeClass("disabled"), e(".dp-nav-next-month", this.context).removeClass("disabled");
                    if ((t = this.endDate.getDate()) < 13) {
                        var s = new Date(this.endDate.getTime());
                        s.addMonths(-1), this.displayedYear == s.getFullYear() && this.displayedMonth == s.getMonth() && e(".dp-calendar td.other-month", this.context).each(function() {
                            var n = e(this),
                                i = Number(n.text());
                            i < 13 && i > t && n.addClass("disabled")
                        })
                    }
                }
                this._applyRenderCallbacks()
            },
            _closeCalendar: function(t, n) {
                n && n != this.ele || (e(document).unbind("mousedown.datepicker"), e(document).unbind("keydown.datepicker"), this._clearCalendar(), e("#dp-popup a").unbind(), e("#dp-popup").empty().remove(), t || e(this.ele).trigger("dpClosed", [this.getSelected()]))
            },
            _clearCalendar: function() {
                e(".dp-calendar td", this.context).unbind(), e(".dp-calendar", this.context).empty()
            }
        }), e.dpConst = {
            SHOW_HEADER_NONE: 0,
            SHOW_HEADER_SHORT: 1,
            SHOW_HEADER_LONG: 2,
            POS_TOP: 0,
            POS_BOTTOM: 1,
            POS_LEFT: 0,
            POS_RIGHT: 1,
            DP_INTERNAL_FOCUS: "dpInternalFocusTrigger"
        }, e.dpText = {
            TEXT_PREV_YEAR: "Previous year",
            TEXT_PREV_MONTH: "Previous month",
            TEXT_NEXT_YEAR: "Next year",
            TEXT_NEXT_MONTH: "Next month",
            TEXT_CLOSE: "Close",
            TEXT_CHOOSE_DATE: "Choose date",
            HEADER_FORMAT: "mmmm yyyy"
        }, e.dpVersion = "$Id: jquery.datePicker.js 102 2010-09-13 14:00:54Z kelvin.luck $", e.fn.datePicker.defaults = {
            month: void 0,
            year: void 0,
            showHeader: e.dpConst.SHOW_HEADER_SHORT,
            startDate: void 0,
            endDate: void 0,
            inline: !1,
            renderCallback: null,
            createButton: !0,
            showYearNavigation: !0,
            closeOnSelect: !0,
            displayClose: !1,
            selectMultiple: !1,
            numSelectable: Number.MAX_VALUE,
            clickInput: !1,
            rememberViewedMonth: !0,
            selectWeek: !1,
            verticalPosition: e.dpConst.POS_TOP,
            horizontalPosition: e.dpConst.POS_LEFT,
            verticalOffset: 0,
            horizontalOffset: 0,
            hoverClass: "dp-hover",
            autoFocusNextInput: !1
        }, void 0 == e.fn.bgIframe && (e.fn.bgIframe = function() {
            return this
        }), e(window).bind("unload", function() {
            var t = e.event._dpCache || [];
            for (var n in t) e(t[n].ele)._dpDestroy()
        })
    }(jQuery),
    function(e) {
        e.event.special.textchange = {
            setup: function() {
                e(this).bind("keyup.textchange", e.event.special.textchange.handler), e(this).bind("cut.textchange paste.textchange input.textchange", e.event.special.textchange.delayedHandler)
            },
            teardown: function() {
                e(this).unbind(".textchange")
            },
            handler: function() {
                e.event.special.textchange.triggerIfChanged(e(this))
            },
            delayedHandler: function() {
                var t = e(this);
                setTimeout(function() {
                    e.event.special.textchange.triggerIfChanged(t)
                }, 25)
            },
            triggerIfChanged: function(e) {
                var t = e.attr("contenteditable") ? e.html() : e.val();
                t !== e.data("lastValue") && (e.trigger("textchange", e.data("lastValue")), e.data("lastValue", t))
            }
        }
    }(jQuery), $.fn.serializeObject = function() {
        var e = {},
            t = this.serializeArray();
        return $.each(t, function() {
            void 0 !== e[this.name] ? (e[this.name].push || (e[this.name] = [e[this.name]]), e[this.name].push(this.value || "")) : e[this.name] = this.value || ""
        }), e
    }, $.extend($.fn, {
        slideToElement: function(e) {
            var t = $("a[name=" + e + "]");
            if (t.length) {
                var n = t.offset().top;
                return $("html,body").animate({
                    scrollTop: n - 100
                }, 500, "linear", function() {}), !1
            }
        },
        dropdownMenu: function(e, t) {
            return $(this).click(function(e) {
                e.preventDefault();
                var n = $(this),
                    i = n.hasClass("activated"),
                    s = n.attr("id"),
                    r = n.offset(),
                    o = n.outerHeight(),
                    a = $(window),
                    l = a.scrollTop(),
                    c = a.height(),
                    d = $.extend({}, r);
                if (n.is(".disabled")) return !1;
                if ($(".contextMenu").hide(), $(".dropdown-menu-on").removeClass("dropdown-menu-on activated"), i) return !1;
                if (n.addClass("activated dropdown-menu-on"), s) {
                    d.top += o;
                    var u = $("#" + s + "_m");
                    u.addClass("contextMenu").show().find("a").off(".dropdown").on("click.dropdown", function(e) {
                        var i = $(this),
                            s = i.parent();
                        return n.removeClass("activated"), $(".contextMenu").hide(), $(document).off(".dropdown"), !s.is(".disabled") && (i.is(".directly") ? (i.off(".dropdown").click(), !0) : ("function" == typeof t && t(i.attr("href"), n, e, i.html()), void e.preventDefault()))
                    });
                    var h = u.outerHeight();
                    if (l + c < r.top + o + h)
                        if (r.top - h > l) d.top = r.top - h;
                        else {
                            var p = Math.max(l + c - (r.top + o), r.top - l),
                                f = 30,
                                m = [
                                    []
                                ],
                                g = 0;
                            u.find("> li, .wrapp > ul > li").filter(function() {
                                return !$(this).hasClass("wrapp")
                            }).each(function() {
                                var e = $(this);
                                f < p ? f += e.height() : (f = e.height() + 30, m[++g] = []), m[g].push(e.detach())
                            }), u.children().remove();
                            for (var v = 0; v < m.length; v++) {
                                $('<li class="wrapp"><ul></ul></li>').appendTo(u).find("ul").append(m[v])
                            }
                            u.width(160 * m.length), h = u.outerHeight(), r.top - h > l && (d.top = r.top - h)
                        }
                    var _ = u.outerWidth();
                    d.left + _ > a.width() && (d.left -= d.left + _ - a.width()), u.offset(d)
                }
                return $(document).unbind(".dropdown").bind("click.dropdown keypress.dropdown", function(e) {
                    return 27 != e.keyCode && (n.is(e.target) || n.find(e.target).length) || ($(document).unbind(".dropdown"), u.hide(), n.removeClass("activated dropdown-menu-on")), !1
                }), !1
            }), $(this)
        },
        SmartSearch: function(e, t) {
            var n = {
                    target: "#smartres",
                    url: "?cmd=search&lightweight=1&action=v2",
                    submitel: "#search_submiter",
                    results: "#smartres-results",
                    container: "#search_form_container",
                    options: {
                        activeclients: 0,
                        searchreplies: 0,
                        searchcontents: 0,
                        searchecontents: 0
                    }
                },
                i = $(this);
            e = $.extend({}, n, e || {});
            return i.search = function(t, n) {
                $(e.results).addLoader(), $.post(e.url, {
                    query: t,
                    options: n || e.options
                }, function(t) {
                    $(e.submitel).removeClass("search_loading");
                    var n = parse_response(t);
                    !1 !== n && "string" == typeof n ? i.showresults(n) : i.clearresults()
                })
            }, i.showresults = function(t) {
                return $(e.results).html(t), $('[data-toggle="tooltip"]', e.results).tooltip(), $(".search-apply-button", e.results).click(function() {
                    var t = n.options;
                    return $.each($(".searchoptions", e.results).serializeArray(), function() {
                        t[this.name] = this.value
                    }), i.search(i.val(), t), !1
                }), $(e.target).fadeIn("fast"), i
            }, i.clearresults = function() {
                return $(e.target).fadeOut("fast", function() {
                    $(e.results).html("")
                }), $(e.container).removeClass("resultsin"), i
            }, i.keydown(function(t) {
                13 == t.keyCode && $(e.submitel).click()
            }), $(".lastsearch", e.results).click(function() {
                var e = $(this).text();
                return i.val(e).search(e), !1
            }), $(e.submitel).click(function() {
                return i.search(i.val()), !1
            }), i
        },
        ToggleNicely: function(e, t) {
            var n = $(this);
            return t || n.is(":visible") !== e ? (n.toggle(e).toggleClass("shownice", e), e && setTimeout(function() {
                n.removeClass("shownice")
            }, 1e3), this) : this
        },
        ShowNicely: function() {
            return $(this).ToggleNicely(!0, !0)
        },
        scrollToEl: function() {
            if ($(this).length) {
                var e = $(this).offset().top;
                $("html,body").animate({
                    scrollTop: e - 100
                }, 500, "linear", function() {})
            }
            return $(this)
        },
        HoverMenu: function(e, t) {
            return $(this).each(function(e) {
                var t = $(this),
                    n = t.offset(),
                    i = t.height(),
                    s = n.left,
                    r = i + n.top;
                $(".submenu", "#menushelf").eq(e).css({
                    top: r,
                    left: s
                }), t.hover(function() {
                    $(this).HoverMenuShow(e)
                }, function() {
                    $(this).HoverTimer()
                })
            }), $(".submenu", "#menushelf").hover(function() {
                $(this).HoverCancelTimer()
            }, function() {
                $(this).HoverMenuHide()
            }), $(this)
        },
        TabbedMenu: function(e) {
            var t = e.elem ? e.elem : ".tabb",
                n = e.picker ? e.picker : "a.tchoice",
                i = e.aclass ? e.aclass : "picked",
                s = e.picked ? parseInt(e.picked) : 0,
                r = e.picker_id ? e.picker_id : "picked_tab",
                o = $(this);
            return $(t).hide(), $(t).eq(s).show(), $(n + ":not(.directlink)").eq(s).addClass(i), o.find("#" + r).length || e.picktab || o.append('<input type="hidden" value="' + s + '" name="' + r + '" id="' + r + '"/>'), o.find(n + ":not(.directlink)").each(function(s) {
                $(this).click(function() {
                    return !$(this).hasClass("disabled") && (e.picktab || o.find("#" + r).val(s), $(t).hide(), $(t).eq(s).show(), $("" + n, o).removeClass(i), $(this).addClass(i), $(this).find("span.notification").length && $(this).find("span.notification").removeClass("notification"), !1)
                })
            }), $(this)
        },
        HoverMenuHide: function() {
            return $(".mainmenu", "#mmcontainer").removeClass("active"), $(".submenu", "#menushelf").hide(), $(this)
        },
        HoverMenuShow: function(e) {
            var t = $(this);
            return t.HoverCancelTimer(), $(".submenu", "#menushelf").hide(), $(".mainmenu", "#mmcontainer").removeClass("active"), $(".submenu", "#menushelf").eq(e).show(), t.addClass("active"), $(this)
        },
        HoverTimer: function() {
            return timing = setTimeout(function() {
                $(".mainmenu", "#mmcontainer").removeClass("active"), $(".submenu", "#menushelf").hide()
            }, 200), $(this)
        },
        HoverCancelTimer: function() {
            return timing && (clearTimeout(timing), timing = null), $(this)
        },
        taskMgr: function(e, t) {
            return $(this).each(function() {
                $(this).taskMgrCountEI();
                var e = $(this);
                e.find("a.showlog").hide(), e.find("a.showlog").mouseover(function() {
                    return e.taskMgrShow(), $(this).hide(), !1
                }), e.hover(function() {}, function() {
                    $(this).taskMgrHide()
                }), $(this).taskMgrCheckInterval()
            }), $(this)
        },
        taskMgrCountEI: function() {
            $("LI.info", "#taskMGR").length > 0 ? $("#numinfos").html($("LI.info", "#taskMGR").length).show() : $("#numinfos").html("0"), $("LI.error", "#taskMGR").length > 0 ? $("#numerrors").html($("LI.error", "#taskMGR").length).show() : $("#numerrors").html("0")
        },
        taskMgrProgress: function(e) {
            var t = $(this);
            t.taskMgrCheckVisibility();
            $(this).find("span.progress");
            return 0 == parseInt(e) ? (NProgress.done(), t.taskMgrCountEI()) : ($("#numinfos").hide(), $("#numerrors").hide(), NProgress.set(parseInt(maximum - e) / maximum)), $(this)
        },
        taskMgrAddInfo: function(e) {
            var t = new Date,
                n = $(this),
                i = t.getMinutes();
            i < 10 && (i = "0" + i);
            var s = t.getHours().toString() + ":" + i,
                r = parseInt($("#numinfos").html());
            return $("#numinfos").html(r + 1).show(), n.find("ul").prepend('<li class="info visible">' + s + " " + e + "<br/></li>"), n.taskMgrCheckInterval(), n.addClass("newel"), $(this)
        },
        taskMgrAddError: function(e) {
            var t = parseInt($("#numerrors").html()),
                n = new Date,
                i = $(this),
                s = n.getMinutes();
            s < 10 && (s = "0" + s);
            var r = n.getHours().toString() + ":" + s;
            return $("#numerrors").html(t + 1).show(), i.find("ul").prepend('<li class="error visible">' + r + " " + e + "<br/></li>"), i.taskMgrCheckInterval(), i.addClass("newel"), $(this)
        },
        taskMgrShow: function() {
            return clearTimeout(t), t = "", $(this).addClass("taskAll").find("li").show(), $(this)
        },
        taskMgrCheckVisibility: function() {
            var e = $(this);
            return e.find("LI").length > 0 || e.find("span.progress").hasClass("visible") ? (e.find("a.showlog").show(), e.show()) : e.hide(), $(this)
        },
        taskQuickLoadShow: function() {
            return NProgress.start(), $(this)
        },
        taskQuickLoadHide: function() {
            return NProgress.done(), $(this)
        },
        taskMgrHide: function() {
            var e = $(this);
            return e.removeClass("taskAll"), e.find("li.hidden").hide(), e.find("LI").length > 0 && e.find("a.showlog").show(), e.taskMgrCheckInterval()
        },
        taskMgrCheckInterval: function() {
            var e = $(this);
            e.taskMgrCheckVisibility();
            return e.find("LI.visible").length > 0 ? (navigator.userAgent.match(/MSIE 6/i) && e.css({
                top: document.documentElement.scrollTop
            }), t = setTimeout(function() {
                "newel taskAll" != e.attr("class") && "taskAll" != e.attr("class") && ($(this).find("LI.visible:last").slideUp("slow", function() {
                    $(this).removeClass("visible").addClass("hidden")
                }), e.taskMgrCheckInterval())
            }, 2e3)) : e.removeClass("newel"), $(this)
        },
        addLoader: function(e) {
            return $("#preloader").remove(), this.length && this.eq(0).addLoaders({
                html: '<div id="preloader" ></div>',
                includeMargin: e || !1
            }), this
        },
        hideLoader: function() {
            return $("#preloader").hide(), this.each(function() {
                var e = $(this),
                    t = e.data("preloader");
                t && (t.remove(), e.removeData("preloader"))
            }), this
        },
        addLoaders: function(e) {
            return e = $.extend({
                html: '<div class="preloader" ></div>',
                includeMargin: !1
            }, e || {}), this.length ? (this.each(function() {
                var t, n, i = $(this),
                    s = this.offsetParent || document.body,
                    r = i.outerWidth(e.includeMargin),
                    o = i.outerHeight(e.includeMargin),
                    a = {
                        top: 0,
                        left: 0
                    };
                ["TD", "TH", "TABLE"].indexOf(s.tagName) > -1 && -1 === $(s).css("display").indexOf("table") ? (n = (t = i.add(i.parents()).filter(function() {
                    return "relative" === $(this).css("position") || "body" === this.tagName
                }).eq(0)).offset(), (a = i.offset()).left -= n.left, a.top -= n.top) : (t = i, "relative" !== i.css("position") ? a = i.position() : e.includeMargin ? (a.left -= parseInt(t.css("margin-left")), a.top -= parseInt(t.css("margin-top"))) : e.includeMargin = !0), e.includeMargin || (a.left += parseInt(t.css("margin-left")), a.top += parseInt(t.css("margin-top")));
                var l = $(e.html);
                l.css({
                    position: "absolute",
                    top: a.top,
                    left: a.left,
                    width: r,
                    height: o,
                    zIndex: 1e3
                }), l.show(), l.appendTo(t), i.data("preloader", l)
            }), this) : this
        }
    });
var initload = 0,
    loadelements = {
        tickets: !1,
        pops: !0,
        widgets: !1,
        invoices: !1,
        services: !1,
        accounts: !1,
        domains: !1,
        clients: !1,
        emails: !1,
        estimates: !1,
        neworder: !1,
        loaders: new Array
    };
$(window).on("load", function() {
    function CSRFProtection(e) {
        var t = $('meta[name="csrf-token"]').attr("content");
        t && e.setRequestHeader("X-CSRF-Token", t)
    }
    "ajaxPrefilter" in $ ? $.ajaxPrefilter(function(e, t, n) {
        CSRFProtection(n)
    }) : $(document).ajaxSend(function(e, t) {
        CSRFProtection(t)
    }), $.ajaxSetup({
        cache: !0
    }), $("#taskMGR").taskMgr(), $("#smarts").on("click", function(e) {
        var t = $(this),
            n = t.val(),
            s = t.data("settings"),
            r = "";
        if (s.lastsearches.length)
            for (r = "<div class='lastsearch-header'>Recent searches: </div>", i = 0; i < s.lastsearches.length; i++) r = r + "<div class='lastsearch'>" + s.lastsearches[i] + "</div>";
        bootbox.dialog({
            title: "<div id='sbox-container'><i class=\"fa fa-search\" id='search_submiter2'></i><input type='text' class='search-bootbox-input' autofocus placeholder='Smart search' value='" + n + "' /></div>",
            onEscape: !0,
            show: !1,
            backdrop: !0,
            animate: !1,
            className: "searchbootbox",
            size: "xlarge",
            message: '<div id="smartres2" ><div id="smartres-results2" class="smartsearch-results" >' + r + "</div></div>"
        }).on("shown.bs.modal", function() {
            $(":focus").blur(), $(".search-bootbox-input").SmartSearch({
                target: "#smartres2",
                submitel: "#search_submiter2",
                results: "#smartres-results2",
                container: ".searchbootbox",
                options: s
            }).on("keyup", function(e) {
                13 != e.keyCode && t.val($(this).val())
            }).focus()
        }).modal("show");
        return !1
    }), loadelements.pops && pops(), $(".fadvanced").click(function() {
        return "" == $("#hider").html() ? (ajax_update($(this).attr("href"), {}, "#hider"), $("#hider2").hide(), $("#hider").show()) : ($("#hider").show(), $("#hider2").hide()), !1
    }), $("a.tload").click(function() {
        return $(this).hasClass("tstyled") && ($("body").find("a.tload").removeClass("selected"), $(this).addClass("selected")), window.clearInterval(checkUrlInval), window.location.hash = "", ajax_update($(this).attr("href"), {}, "#bodycont"), !1
    }), bindEvents();
    var loadelements_cp = loadelements;
    loadelements_cp.tickets && bindTicketEvents(), loadelements_cp.invoices && bindInvoiceEvents(), loadelements_cp.estimates && bindEstimatesEvents(), loadelements_cp.services && bindServicesEvents(), loadelements_cp.accounts && bindAccountEvents(), loadelements_cp.domains && bindDomainEvents(), loadelements_cp.clients && bindClientEvents(), loadelements_cp.neworder && bindNewOrderEvents(), loadelements_cp.widgets && $.widgets().init();
    var l1a = loadelements_cp.loaders,
        ll = l1a.length;
    if (ll > 0) {
        var i = 0;
        for (i = 0; i < ll; i++) eval(l1a[i] + "()")
    }
});
var checkUrlInval = "",
    HBInputTranslate = {};
HBInputTranslate.addTranslation = function(e) {
    return $.getJSON("?cmd=langedit", {
        action: "quicktag"
    }, function(t) {
        var n, i = $("#" + e);
        if (console.log(e, i, t), i.is("input")) {
            var s = i.val();
            i.val(s + "" + t.taglink)
        } else "undefined" != typeof tinyMCE && void 0 !== (n = tinyMCE.get(e)) ? n.isHidden() ? i[0].value = i[0].value + t.taglink : (n.execCommand("mceInsertContent", !1, t.taglink), n.save()) : i.data("ace") ? i.data("aceeditor").getSession().setValue(i.data("aceeditor").getSession().getValue() + t.taglink) : i.val(i.val() + "" + t.taglink);
        $("#l_editor_" + e + " .translations").append('<a href="?cmd=langedit&action=bulktranslate&key=' + t.tag + '" target="_blank">' + t.taglink + "</a>"), $("#l_editor_" + e + " .translations .taag").show()
    }), !1
}, HBInputTranslate.tinyMCEFull = {
    theme: "advanced",
    plugins: "pagebreak,style,layer,table,save,advhr,advimage,advlink,emotions,iespell,insertdatetime,preview,media,searchreplace,print,contextmenu,paste,directionality,fullscreen,noneditable,visualchars,nonbreaking,xhtmlxtras",
    theme_advanced_buttons1: "bold,italic,underline,strikethrough,|,justifyleft,justifycenter,justifyright,justifyfull,|,formatselect,fontselect,fontsizeselect",
    theme_advanced_buttons2: "cut,copy,paste,pastetext,|,search,replace,|,bullist,numlist,|,outdent,indent,blockquote,|,undo,redo,|,link,unlink,anchor,image,cleanup,help,code,|,insertdate,inserttime,preview,|,forecolor,backcolor",
    theme_advanced_buttons3: "tablecontrols,|,hr,removeformat,visualaid,|,sub,sup,|,charmap,emotions,iespell,media,advhr,|,fullscreen",
    theme_advanced_buttons4: "insertlayer,moveforward,movebackward,absolute,|,styleprops|,visualchars,nonbreaking",
    theme_advanced_toolbar_location: "top",
    theme_advanced_toolbar_align: "left",
    theme_advanced_statusbar_location: "bottom",
    skin: "o2k7",
    skin_variant: "silver",
    theme_advanced_resizing: !0,
    convert_urls: !1,
    add_form_submit_trigger: !1,
    setup: function(e) {
        e.onSubmit.add(function(e, t) {
            !e.isHidden() && e.isDirty() && e.save()
        })
    }
}, HBInputTranslate.tinyMCESimple = {
    theme: "advanced",
    theme_advanced_buttons1: "bold,italic,underline,separator,strikethrough,justifyleft,justifycenter,justifyright,justifyfull,bullist,numlist,undo,redo,link,unlink,code",
    theme_advanced_buttons2: "",
    skin: "o2k7",
    skin_variant: "silver",
    theme_advanced_buttons3: "",
    theme_advanced_toolbar_location: "top",
    theme_advanced_toolbar_align: "left",
    theme_advanced_statusbar_location: "bottom",
    add_form_submit_trigger: !1,
    setup: function(e) {
        e.onSubmit.add(function(e, t) {
            !e.isHidden() && e.isDirty() && e.save()
        })
    }
}, HBInputTranslate.editorOff = function(e, t) {
    return t = $("#" + t), $(e).parents("ul").eq(0).find("li").removeClass("active"), $(e).parent("li").addClass("active"), !!t.hasClass("tinyApplied") && (t.tinymce().save(), t.tinymce().hide(), !1)
}, HBInputTranslate.editorOn = function(e, t, n) {
    if (t = $("#" + t), $(e).parents("ul").eq(0).find("li").removeClass("active"), $(e).parent("li").addClass("active"), t.hasClass("tinyApplied")) t.addClass("tinyApplied").tinymce().show();
    else {
        var i = HBInputTranslate.tinyMCESimple;
        n && "string" != typeof n && (i = n), t.addClass("tinyApplied").tinymce(i)
    }
    return !1
}, HBInputTranslate.aceOn = function(e, t) {
    var n = $("#" + t),
        i = $("#" + t + "-ace").parent();
    if (e && ($(e).parents("ul").eq(0).find("li").removeClass("active"), $(e).parent("li").addClass("active")), 1 != n.data("ace")) {
        var s = ace.edit(t + "-ace");
        s.setTheme("ace/theme/chrome"), s.getSession().setMode("ace/mode/smarty"), s.setOptions({
            minLines: 15,
            maxLines: 99999,
            highlightActiveLine: !1
        }), n.data("ace", !0), n.data("aceeditor", s), n.parents("form").on("submit", function() {
            n.val(s.getValue())
        })
    }
    return 1 == n.data("ace") && (n.data("aceeditor").getSession().setValue(n.val()), n.hide(), i.show()), !1
}, HBInputTranslate.aceOff = function(e, t) {
    var n = $("#" + t),
        i = $("#" + t + "-ace").parent();
    return e && ($(e).parents("ul").eq(0).find("li").removeClass("active"), $(e).parent("li").addClass("active")), 1 == n.data("ace") && (n.val(n.data("aceeditor").getValue()), n.show(), i.hide()), !1
}, jQuery, jQuery.event.special.destroyed = {
    remove: function(e) {
        e.handler && e.handler()
    }
};
var Chosen = {
        inp: function(e) {
            if ("function" != typeof jQuery.fn.chosen) return $('<style type="text/css">@import url("templates/default/js/chosen/chosen.css")</style>').appendTo("head"), $.getScript("templates/default/js/chosen/chosen.min.js", function() {
                return Chosen.inp(e), !1
            }), !1;
            var t = !1,
                n = !1,
                i = [e.attr("default")],
                s = e.attr("load"),
                r = "",
                o = function(a) {
                    var l = $(this);
                    if (i.length || e.find(":selected").each(function() {
                            i.push($(this).val())
                        }), t) return n = a, !1;
                    switch (e.data("chosen").results_none_found = "Searching for..", s) {
                        case "clients":
                            r = "?cmd=clients&action=search&lightweight=1";
                            break;
                        case "invoices":
                            r = "?cmd=invoices&action=search&lightweight=1"
                    }
                    t = $.post(r, {
                        query: a && a.query || l.val()
                    }, function(r) {
                        var c = !n;
                        t = !1;
                        var d = a && a.type && a || $.extend({}, n);
                        if (n ? (n = !1, o.call(l[0], d)) : e.data("chosen").results_none_found = "No results match", e.find(".chosen").remove(), void 0 != r.list) {
                            switch (1 == r.list.length && i.push(r.list[0][0]), s) {
                                case "clients":
                                    for (var u = 0; u < r.list.length; u++) {
                                        var h = r.list[u][3].length ? r.list[u][3] + " - " + r.list[u][1] + " " + r.list[u][2] : r.list[u][1] + " " + r.list[u][2];
                                        (p = e.find('option[value="' + r.list[u][0] + '"]')).length ? p.text("#" + r.list[u][0] + " " + h) : e.append('<option class="chosen" value="' + r.list[u][0] + '">#' + r.list[u][0] + " " + h + "</option>")
                                    }
                                    break;
                                case "invoices":
                                    for (u = 0; u < r.list.length; u++) {
                                        var p;
                                        (p = e.find('option[value="' + r.list[u].id + '"]')).length ? p.text("#" + r.list[u].id + " " + r.list[u].formatted) : e.append('<option class="chosen" value="' + r.list[u].id + '">' + r.list[u].formatted + "</option>")
                                    }
                            }
                            if (e.val(i.pop()), e.trigger("liszt:updated"), d && d.type) {
                                var f = e.data("chosen").search_field;
                                f.val(f.val().replace(/( )\s+/g, "$1")), e.data("chosen").results_show(), c && e.change()
                            }
                        }
                        i = []
                    })
                };
            if (e.append('<option class="loader" value="">Loading..</option>').on("liszt:ready", function(t, n) {
                    n.chosen.search_container.on("keyup", "input", o), n.chosen.search_contains = !0, n.chosen.show_search_field_default = function() {}, e.data("chosen", n.chosen), n.chosen.results_none_found = "Searching for..", o.call(n.chosen.search_container, {
                        query: i[0] || ""
                    })
                }), !e.hasClass("chzn-done")) {
                var a = !1,
                    l = !1;
                e.is(":visible") || (l = e.wrap("<span></span>").parent(), a = $('<div style="position:absolute"></div>').appendTo("body"), e.detach().appendTo(a).show()), e.addClass("chzn-css-loaded").find(".loader").remove();
                var c = setInterval(function() {
                    "pointer" === e.css("cursor") && (clearInterval(c), e.removeClass("chzn-css-loaded").chosen(), a && (a.children().detach().appendTo(l), e.unwrap(), a.remove()))
                }, 50)
            }
        },
        recovery: function(e, t) {
            e.bind("destroyed", function() {
                setTimeout(function() {
                    var e = $("select[load]").eq(t);
                    Chosen.recovery(e, t), Chosen.inp(e)
                }, 60)
            })
        },
        find: function(e, t) {
            void 0 != e ? (Chosen.recovery(e, t), Chosen.inp(e)) : $("select[load]").each(function(e) {
                var t = $(this);
                "clients" == t.attr("load") && Chosen.recovery(t, e), Chosen.inp(t)
            })
        }
    },
    AdminNotes = {
        visible: !1,
        show: function() {
            return AdminNotes.hide(), $("#AdmNotes").show().find(".admin-note-new").show(), $("#AdmNotes .admin-note-new textarea").focus(), AdminNotes.visible = !0, !1
        },
        hide: function() {
            return $("#AdmNotes .admin-note-new").hide(), $("#AdmNotes .admin-note-edit:visible").each(function() {
                $(this).hide().prev().show()
            }), !1
        },
        addNew: function() {
            var e = $("textarea, input", "#AdmNotes .admin-note-new"),
                t = e.serializeObject();
            if (t.note && t.note.length) {
                e.filter("textarea").val(""), $("#AdmNotes .admin-note-attach").html(""), AdminNotes.hide(), t.make = "addNote", $.post($("#notesurl").attr("href"), t, AdminNotes.ajax);
                var n = AdminNotes.dateformat.replace("d", ("0" + ts.getDate()).slice(-2)).replace("Y", ts.getFullYear()).replace("m", ("0" + (ts.getMonth() + 1)).slice(-2)) + " " + ("0" + ts.getHours()).slice(-2) + ":" + ("0" + ts.getMinutes()).slice(-2) + ":" + ("0" + ts.getSeconds()).slice(-2);
                $("#notesContainer").prepend('<div class="admin-note"><div class="left">' + n + " by " + AdminNotes.me + '</div><div class="admin-note-body"><br />' + t.note + "</div></div>")
            }
            return !1
        },
        edit: function(e) {
            var t = $("#AdmNotes textarea:visible:last").val(),
                n = new Array;
            return $('#AdmNotes input[name="flags[' + e + '][]"]').each(function() {
                $(this).prop("checked") && n.push($(this).val())
            }), t && t.length && $.post($("#notesurl").attr("href"), {
                make: "editNote",
                note: t,
                noteid: e,
                flags: n
            }, AdminNotes.ajax), !1
        },
        init: function() {
            $("#AdmNotes").length && $.get($("#notesurl").attr("href") + "&make=getNotes", AdminNotes.ajax)
        },
        del: function(e) {
            return $("#notesContainer .admin-note[rel=" + e + "]").remove(), $.post($("#notesurl").attr("href"), {
                make: "delNote",
                noteid: e
            }, AdminNotes.ajax), !1
        },
        addFile: function() {
            var e = {},
                t = $('<div class="result"><input type="file" data-upload="?cmd=downloads&action=upload" /></div>').appendTo(".admin-note-new .admin-note-attach").bind("fileuploadsend", function(n, i) {
                    t.children().hide();
                    for (var s in i.files) e[s] = $('<div class="upload-result"><a class="attachment" >' + i.files[s].name + '</a> <span class="ui-autocomplete-loading" style="padding: 10px;"></span></div>').appendTo(t)
                }).bind("fileuploadalways", function(n, i) {
                    t.children("input").remove();
                    for (var s in i.result)
                        if (e[s]) {
                            var r = e[s];
                            r.children("span").remove(), i.result[s].error ? r.append("<span>" + i.result[s].error + "</span>") : (r.append('<input name="attachments[]" value="' + i.result[s].hash + '" type="hidden"/>'), $('<a href="#" class="editbtn"></a>').append("<small>&#91;Remove&#93;</small>").appendTo(r).click(function() {
                                return $.post(i.result[s].delete_url), r.remove(), !1
                            }))
                        }
                });
            return fileupload_init(), !1
        },
        ajax: function(e) {
            (e = parse_response(e)).length ? ($("#AdmNotes").show(), $("#notesContainer").html(e)) : AdminNotes.visible || $("#notesContainer").html("")
        }
    };
! function(e, t, n) {
    e.fn.pagination = function(t, n) {
        function i() {
            s.each(function() {
                var s = e(this);
                s.empty();
                var o = function() {
                        var e = Math.ceil(n.num_display_entries / 2),
                            i = t,
                            s = i - n.num_display_entries;
                        return [r > e ? Math.max(Math.min(r - e, s), 0) : 0, r > e ? Math.min(r + e, i) : Math.min(n.num_display_entries, i)]
                    }(),
                    a = t,
                    l = function(e) {
                        return function(t) {
                            return function(e, t) {
                                r = e, i();
                                var s = n.callback(e);
                                return s || (t.stopPropagation ? t.stopPropagation() : t.cancelBubble = !0), s
                            }(e, t)
                        }
                    },
                    c = function(t, i) {
                        if (t = t < 0 ? 0 : t < a ? t : a - 1, i = e.extend({
                                text: t + 1,
                                classes: ""
                            }, i || {}), t == r) var o = e("<span class='current'>" + i.text + "</span>");
                        else o = e("<a>" + i.text + "</a>").bind("click", l(t)).attr("href", n.link_to.replace(/__id__/, t));
                        i.classes && o.addClass(i.classes), s.append(o)
                    };
                if (n.prev_text && (r > 0 || n.prev_show_always) && c(r - 1, {
                        text: n.prev_text,
                        classes: "prev"
                    }), o[0] > 0 && n.num_edge_entries > 0) {
                    for (var d = Math.min(n.num_edge_entries, o[0]), u = 0; u < d; u++) c(u);
                    n.num_edge_entries < o[0] && n.ellipse_text && e("<span>" + n.ellipse_text + "</span>").appendTo(s)
                }
                for (u = o[0]; u < o[1]; u++) c(u);
                if (o[1] < a && n.num_edge_entries > 0) {
                    a - n.num_edge_entries > o[1] && n.ellipse_text && e("<span>" + n.ellipse_text + "</span>").appendTo(s);
                    for (u = Math.max(a - n.num_edge_entries, o[1]); u < a; u++) c(u)
                }
                n.next_text && (r < a - 1 || n.next_show_always) && c(r + 1, {
                    text: n.next_text,
                    classes: "next"
                })
            })
        }
        var s = this;
        e.fn.pagination.setPage = function(e) {
            r = parseInt(e), i()
        }, e.fn.pagination.getPage = function(e) {
            return r
        };
        var r = (n = e.extend({
            initial_page: 0,
            num_display_entries: 4,
            current_page: 0,
            num_edge_entries: 1,
            link_to: "#",
            prev_text: "&lt;",
            next_text: "&gt;",
            ellipse_text: "...",
            prev_show_always: !1,
            next_show_always: !1,
            callback: function(t) {
                return e("#updater").addLoader(), e("#checkall").attr("checked", !1), e.post(e("#currentlist").attr("href"), {
                    page: t
                }, function(n) {
                    var i = parse_response(n);
                    i && (e("#updater").html(i), e(".check").unbind("click"), e(".currentpage").val(t), e(".check").click(checkEl))
                }), !1
            }
        }, n || {})).current_page;
        t = !t || t < 0 ? 1 : t, n.items_per_page = !n.items_per_page || n.items_per_page < 0 ? 1 : n.items_per_page, r != n.initial_page && n.callback(r), 0 != t && i()
    }
}(jQuery, window),
function(e, t) {
    var n;
    n = e('<div id="vtip"></div>'), e.fn.extend({
        vTip: function(t) {
            e(this).not(".vtip_applied").each(function() {
                var t = e(this);
                t.data("title", t.data("title") || this.title || this.innerHTML), this.innerHTML = "", this.title = ""
            }).hover(function(t) {
                n[0].innerHTML = e(this).data("title"), this.top = t.pageY + 2, this.left = t.pageX + 5, n.appendTo("body").css({
                    top: this.top + "px",
                    left: this.left + "px"
                }).fadeIn("fast")
            }, function() {
                n.hide().detach()
            }).addClass("vtip_applied")
        }
    })
}(jQuery, document);
//# sourceMappingURL=hostbill.min.js.map