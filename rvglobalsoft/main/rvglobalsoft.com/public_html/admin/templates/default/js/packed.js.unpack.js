function isEmpty(a) {
    for (var b in a) if (a.hasOwnProperty(b)) return !1;
    return !0
}
function ajax_update(a, b, c, d, e) {
    $("#taskMGR").taskQuickLoadShow(), "string" == typeof c && c && d && !e && $(c).html('<center><img src="ajax-loading.gif" /></center>'), void 0 != b && isEmpty(b) && (b = {
        empty1m: "param"
    }), $.post(a, b, function (a) {
        $("#taskMGR").taskQuickLoadHide();
        var b = parse_response(a);
        0 == b ? "string" == typeof c && c && !e && $(c).html("") : "function" == typeof c ? (this.resp = b, c.apply(this, arguments)) : c && !e && "string" == typeof b ? $(c).html(b) : c && e && $(c).append(b)
    })
}
function accordion() {
    $("#accordion  div.sor").hide(), $("#accordion  div.sor:first").show(), $("#accordion  li a:first").addClass("opened"), $("#accordion li a").click(function () {
        var a = $(this).next();
        return a.is("div") && a.is(":visible") ? ($("#accordion li a").removeClass("opened"), a.hide(), !1) : a.is("div") && !a.is(":visible") ? ($("#accordion li a").removeClass("opened"), a.show().prev().addClass("opened"), !1) : void 0
    })
}
function pops() {
    ajax_update("index.php", {
        stack: "pop"
    }, function () {
        initload = 1
    }), setTimeout(function () {
        0 == initload && $("#taskMGR").taskMgrProgress(1)
    }, 400)
}
function sorterUpdate(a, b, c) {
    a !== void 0 && $("#sorterlow").html(a), b !== void 0 && $("#sorterhigh").html(b), c !== void 0 && $("#sorterrecords").html(c)
}
function parse_response(data) {
    if (0 != data.indexOf("<!-- {")) return !1;
    var codes = eval("(" + data.substr(data.indexOf("<!-- ") + 4, data.indexOf("-->") - 4) + ")"),
        i = 0;
    for (i = 0; codes.ERROR.length > i; i++) $("#taskMGR").taskMgrAddError(codes.ERROR[i]);
    for (i = 0; codes.INFO.length > i; i++) $("#taskMGR").taskMgrAddInfo(codes.INFO[i]);
    if (codes.EVAL) for (i = 0; codes.EVAL.length > i; i++) eval(codes.EVAL[i]);
    $("#taskMGR").taskMgrProgress(codes.STACK), codes.STACK > 0 && setTimeout("pops()", 10), 0 == codes.STACK && codes.INFO.length > 0 && $(".submiter").length > 0 && $("#currentlist").length > 0 && $(".pagination span.current").length > 0 && ajax_update($("#currentlist").attr("href") + "&page=" + (parseInt($(".pagination span.current").eq(0).html()) - 1), {
        once: "1"
    }, $("#currentlist").attr("updater"), !1);
    var retu = data.substr(data.indexOf("-->") + 3, data.length);
    return "" == retu && (retu = !0), retu
}
function filter(a) {
    if ($("#currentlist").length > 0) {
        var b = $("#content_tb");
        return b.length && b.addClass("searchon"), $("#updater").addLoader(), ajax_update($("#currentlist").attr("href") + "&" + $(a).serialize(), {
            page: parseInt($(".pagination span.current").eq(0).html()) - 1
        }, "#updater"), $(".filter-actions z, .freseter").css({
            display: "inline"
        }), !1
    }
    return !0
}
function appendLoader(a) {
    loadelements.loaders[loadelements.loaders.length] = a
}
function bindClientEvents() {
    var a = $("#client_id", "#bodycont").val();
    $(".clDropdown", "#bodycont").click(function () {
        return !1
    }), $("#clientform").submit(function () {
        return $("#old_currency_id").val() != $("#currency_id").val() ? ($("#bodycont").css("position", "relative"), $("#confirm_curr_change").width($("#bodycont").width()).height($("#bodycont").height()).show(), !1) : !0
    }), $("#sendmail").click(function () {
        return "custom" != $("#mail_id").val() ? ($.post("?cmd=clients&action=sendmail", {
            mail_id: $("#mail_id", "#bodycont").val(),
            id: a
        }, parse_response), !1) : (window.location.href = "?cmd=sendmessage&type=clients&selected=" + $("#client_id").val(), void 0)
    }), $("#tdetail a", "#bodycont").click(function () {
        return $(".secondtd", "#bodycont").toggle(), $(".tdetails", "#bodycont").toggle(), $(".a1", "#tdetail").toggle(), $(".a2", "#tdetail").toggle(), !1
    }), $(".livemode", "#bodycont").hover(function () {
        $(this).append('<a href="#" onclick="return false;" class="manuedit">' + lang.edit + "</a>")
    }, function () {
        $(this).find(".manuedit").remove()
    }).click(function () {
        $("#tdetail a").click()
    }), $(".clDropdown", "#bodycont").dropdownMenu({}, function (b) {
        b = b.substr(b.lastIndexOf("/") + 1), "OpenTicket" == b ? window.location.href = "?cmd=tickets&action=new&client_id=" + a : "CreateInvoice" == b ? window.location.href = "?cmd=invoices&action=createinvoice&client_id=" + a : "PlaceOrder" == b ? window.location.href = "?cmd=orders&action=add&related_client_id=" + a : "SendNewPass" == b ? ajax_update("?cmd=clients&action=show&make=resetpass&id=" + a, !1) : "CloseAccount" == b ? ($("#bodycont").css("position", "relative"), $("#confirm_cacc_close").width($("#bodycont").width()).height($("#bodycont").height()).show()) : "DeleteAccount" == b ? ($("#bodycont").css("position", "relative"), $("#confirm_cacc_delete").width($("#bodycont").width()).height($("#bodycont").height()).show()) : "EditNotes" == b ? AdminNotes.show() : "EnableAffiliate" == b ? window.location.href = "?cmd=affiliates&action=activate&client_id=" + a : "DeleteContact" == b ? confirm(lang.deleteprofileheading) && (window.location.href = "?cmd=clients&make=deleteprofile&client_id=" + a + "&parent_id=" + $("#parent_id").val()) : "ConvertToClient" == b && confirm(lang.convertclientheading) && (window.location.href = "?cmd=clients&action=convertcontact&client_id=" + a)
    }), setTimeout(function () {
        $("#client_id").length > 0 && $("#client_stats").length > 0 && ajax_update("?cmd=clients&action=loadstatistics&id=" + $("#client_id", "#bodycont").val(), {}, "#client_stats")
    }, 30)
}
function bindServicesEvents() {
    $(".addcustom").click(function () {
        return $("#customfield").toggle(), !1
    }), $(".iseditable", "#bodycont").click(function () {
        var a = $(this).parents(".editor-container").eq(0);
        return a.find(".editor").show(), a.find(".org-content").hide(), $(this).parents("tbody.sectioncontent").find(".sectionhead .savesection").show(), !1
    })
}
function tload2() {
    var a = window;
    return a.location.hash && "#" != a.location.hash && (a.clearInterval(checkUrlInval), a.location.hash = ""), ajax_update($(this).attr("href"), {}, "#bodycont"), $(this).attr("rel") && (a.location.hash = $(this).attr("rel").replace(/\s/g, ""), checkUrlInval = setInterval(function () {
        a.location.hash && "#" != a.location.hash || (a.clearInterval(checkUrlInval), $("#backto").length > 0 && ajax_update($("#backto").attr("href"), {}, "#bodycont"), a.location.hash = "")
    }, 200)), !1
}
function bindPredefinied() {
    $("a.file").unbind("click"), setTimeout(function () {
        $(".treeview").undelegate("a.folder, .hitarea", "click").delegate("a.folder, .hitarea", "click", function () {
            var a = $(this).parent(),
                b = !1;
            if ((a.hasClass("expandable") || a.hasClass("collapsable")) && (a.toggleClass("expandable").toggleClass("collapsable"), a.children("div.hitarea").toggleClass("collapsable-hitarea").toggleClass("expandable-hitarea"), (a.hasClass("lastExpandable") || a.hasClass("lastCollapsable")) && (b = !0, a.toggleClass("lastExpandable").toggleClass("lastCollapsable"), a.children("div.hitarea").toggleClass("lastExpandable-hitarea").toggleClass("lastCollapsable-hitarea"))), a.hasClass("collapsable")) {
                if ($(this).hasClass("hitarea")) var c = $(this).siblings("a").attr("href");
                else var c = $(this).attr("href");
                ajax_update(c, {}, function (c) {
                    var d = parse_response(c);
                    $("#" + a.attr("id")).html(d), b && a.children("div.hitarea").addClass("lastCollapsable-hitarea")
                })
            } else a.find("ul").remove();
            return !1
        })
    }, 50)
}
function bindFreseter() {
    $(".haspicker").datePicker({
        startDate: startDate
    }), $("a.freseter", "#content_tb").unbind("click"), $("a.freseter", "#content_tb").click(function () {
        $("a.freseter").hide(), $("form.filterform").each(function () {
            this.reset()
        });
        var a = $("#content_tb");
        return a.length && a.removeClass("searchon"), $("#currentlist").length ? (ajax_update($("#currentlist").attr("href"), {
            page: parseInt($(".pagination span.current").eq(0).html()) - 1,
            resetfilter: "1"
        }, "#updater"), !1) : !0
    })
}
function lateInvoiceBind() {
    $(".tdetail a").unbind("click").click(function () {
        return $(".secondtd").toggle(), $(".tdetails").toggle(), $(".a1").toggle(), $(".a2").toggle(), !1
    }), $(".livemode").unbind("mouseenter mouseleave").hover(function () {
        $(this).append('<a href="#" onclick="return false;" class="manuedit">' + lang.edit + "</a>")
    }, function () {
        $(this).find(".manuedit").remove()
    }).unbind("click").click(function () {
        $(".tdetail a").click()
    })
}
function invoiceItemsSubmit() {
    var a = $(this).parent().parent(),
        b = $("#invoice_id").val();
    if ($(a).attr("id")) {
        var c = $(a).attr("id").replace("line_", "");
        a.find("#ltotal_" + c).html((parseFloat($(a).find(".invqty").eq(0).val()) * parseFloat(a.find(".invamount").eq(0).val())).toFixed(2))
    }
    $.post("?cmd=invoices&action=updatetotals&" + $("#itemsform").serialize(), {
        id: b
    }, function (a) {
        var c = parse_response(a);
        c && ($("#updatetotals").html(c), ajax_update("?cmd=invoices&action=getdetailsmenu", {
            id: b
        }, "#detcont"))
    })
}
function bindInvoiceDetForm() {
    function b() {
        $("#products").hide(), $("#products").html(""), $("#rmliner").show(), $("#addliners").show(), $("#catoptions_container").hide(), $("#addliners2").hide(), $("#catoptions option").each(function () {
            $(this).removeAttr("selected")
        }), $("#catoptions option").eq(1).attr("selected", "selected")
    }
    lateInvoiceBind();
    var a = $("#invoice_id").val();
    $("#bodycont .editline").unbind("mouseenter mouseleave").hover(function () {
        $(this).hasClass("editable1") || $(this).find(".editbtn").show()
    }, function () {
        $(this).find(".editbtn").hide()
    }).find(".editbtn").unbind("click").click(function () {
        var a = $(this).parent();
        return a.find("textarea").height(a.find(".line_descr").height()), a.addClass("editable1").children().hide(), a.find(".editor-line").show().find("textarea").focus(), !1
    }), $("#main-invoice .savebtn").unbind("click").click(function () {
        var a = $(this).parent().parent();
        return a.find(".line_descr").html(a.find("textarea").val().replace(/([^>\r\n]?)(\r\n|\n\r|\r|\n)/g, "$1<br/>$2")).show(), a.removeClass("editable1").find(".editor-line").hide(), a.parent().find(".invitem").eq(0).change(), !1
    }), $("#paid_invoice_line .savebtn").unbind("click").click(function () {
        var b = $(this).parent().parent();
        return b.find("#invoice_number").html(b.find("textarea").val().replace(/([^>\r\n]?)(\r\n|\n\r|\r|\n)/g, "$1<br/>$2")).show(), b.removeClass("editable1").find(".editor-line").hide(), $.post("?cmd=invoices&action=changething&make=changenumber", {
            id: a,
            number: b.find("textarea").val()
        }, function (a) {
            parse_response(a)
        }), !1
    }), $(".haspicker").datePicker({
        startDate: startDate
    }), $("#standardinvoice").length && ($("#standardinvoice").is(":checked") ? ($(".standardinvoice").show(), $(".recurringinvoice").hide(), $("#is_recurring").val(0)) : ($(".recurringinvoice").show(), $(".standardinvoice").hide(), $("#is_recurring").val(1))), $("#detailsform").unbind("submit").submit(function () {
        return 0 == $("#old_client_id").val() ? !0 : ($.post("?cmd=invoices&action=changething&" + $(this).serialize(), {
            id: a
        }, function (b) {
            var c = parse_response(b);
            c && ($("#detcont").html(c), $.post("?cmd=invoices&action=updatetotals", {
                id: a
            }, function (a) {
                var b = parse_response(a);
                b && $("#updatetotals").html(b)
            }))
        }), !1)
    }), $(".removeTrans").unbind("click"), $(".removeTrans").click(function () {
        var a = $(this),
            b = confirm("Do you really want to delete this transaction?");
        return b && $.post($(this).attr("href"), {
            empty1mc: "param"
        }, function (b) {
            var c = parse_response(b);
            1 == c && (a.parent().parent().slideUp("fast", function () {
                $(this).remove()
            }), $(".invitem").eq(0).change())
        }), !1
    }), $(".removeLine").unbind("click"), $(".removeLine").click(function () {
        var a = $(this);
        $(this).parent().parent().addClass("yellow_bg");
        var b = confirm("Do you really want to delete this line?");
        return b && $.post($(this).attr("href"), {
            empty1mc: "param"
        }, function (b) {
            var c = parse_response(b);
            1 == c && (a.parent().parent().slideUp("fast", function () {
                $(this).remove()
            }), $(".invitem").eq(0).change())
        }), $(this).parent().parent().removeClass("yellow_bg"), !1
    }), $(".invitem").unbind("change").change(invoiceItemsSubmit), $(".invitem2").unbind("click").click(invoiceItemsSubmit), $("#catoptions").unbind("change").change(function () {
        "-1" == $(this).val() ? (ajax_update("?cmd=invoices&action=getblank", {}, "#products"), $("#products").show(), $("#rmliner").hide()) : "-2" == $(this).val() ? (ajax_update("?cmd=invoices&action=getaddon", {
            currency_id: $("#currency_id").val()
        }, "#products"), $("#products").show(), $("#rmliner").hide()) : $(this).val() > "0" && (ajax_update("?cmd=invoices&action=getproduct", {
            cat_id: $(this).val(),
            currency_id: $("#currency_id").val()
        }, "#products"), $("#products").show(), $("#rmliner").hide())
    }), $("#updateclietndetails").unbind("click").click(function () {
        $("a", ".tdetail").eq(0).click(), ajax_update("?cmd=invoices&action=changething&make=updateclientdetails&id=" + a), ajax_update("?cmd=invoices&action=edit&list=all&id=" + a, {}, "#bodycont")
    }), $("#prodcanc").unbind("click"), $(".prodok").unbind("click").click(function () {
        if ($("#nline").length > 0 && "" != $("#nline").val()) {
            var b = 0;
            $("#nline_tax").is(":checked") && (b = 1), $.post("?cmd=invoices&action=addline", {
                line: $("#nline").val(),
                tax: b,
                price: $("#nline_price").val(),
                qty: $("#nline_qty").val(),
                id: a
            }, function (a) {
                var b = parse_response(a);
                b && ($("#addliners").before(b), $("#nline").val(""), $("#nline_price").val(""), $("#nline_tax").removeAttr("checked"))
            })
        } else $("#product_id").length > 0 ? $.post("?cmd=invoices&action=addline", {
                product: $("#product_id").val(),
                id: a
            }, function (a) {
                var b = parse_response(a);
                b && ($("#addliners").before(b), $("#detailsform").eq(0).submit())
            }) : $("#addon_id").length > 0 && $.post("?cmd=invoices&action=addline", {
                addon: $("#addon_id").val(),
                id: a
            }, function (a) {
                var b = parse_response(a);
                b && ($("#addliners").before(b), $("#detailsform").eq(0).submit())
            });
        $("#prodcanc").click()
    }), $("#prodcanc").click(function () {
        b()
    }), $("#rmliner").click(function () {
        b()
    })
}
function bindDomainEvents() {
    $(".toLoad").click(function () {
        return $("#dommanager").show(), $("#man_content").html('<center><img src="ajax-loading.gif" /></center>'), $("#man_title").html($(this).attr("value")), $.post("?cmd=domains&action=" + $(this).attr("name"), {
            val: $(this).attr("value"),
            id: $("#domain_id").val(),
            name: $("#domain_name").val()
        }, function (a) {
            $("#man_content").scrollToEl("#man_content");
            var b = parse_response(a);
            b && "" != b ? $("#man_content").html(b) : $("#man_content").html(" ")
        }), !1
    }), $(".livemode").not("tr").hover(function () {
        $(this).append('<a href="#" onclick="return false;" class="manuedit">' + lang.edit + "</a>")
    }, function () {
        $(this).find(".manuedit").remove()
    }).not("tr").click(function () {
        $(".changeMode").eq(0).is(":checked") ? $(".changeMode").removeAttr("checked").eq(0).trigger("change") : $(".changeMode").attr("checked", "checked").eq(0).trigger("change")
    }), $("#bodycont .changeMode").change(function () {
        var a = 0;
        $(this).is(":checked") ? (a = 1, $.post("?cmd=domains&action=manualmode", {
            mode: a,
            id: $("#domain_id").val()
        }, function (a) {
            var b = parse_response(a);
            b && ($(".changeMode").attr("checked", "checked"), $(".manumode").show(), $(".livemode").hide(), $("#domainname").removeAttr("readonly"), $("#epp_code").show())
        })) : $.post("?cmd=domains&action=manualmode", {
            mode: a,
            id: $("#domain_id").val()
        }, function (a) {
            var b = parse_response(a);
            b && ($(".changeMode").removeAttr("checked"), $(".livemode").show(), $(".manumode").hide(), $(".pen").hide(), $(".nep").show(), $("#domainname").attr("readonly", "readonly"), $("#epp_code").hide())
        })
    }), $(".setStatus", "#bodycont").click(function () {
        return !1
    }), $(".setStatus", "#bodycont").dropdownMenu({}, function (a) {
        a = a.substr(a.lastIndexOf("/") + 1), "AdminNotes" == a ? AdminNotes.show() : "ChangeOwner" == a && ($("#ChangeOwner").show(), ajax_update("?cmd=domains&action=getowners", {}, "#ChangeOwner", !0))
    }), $("#sendmail").click(function () {
        return "custom" != $("#mail_id").val() ? ($.post("?cmd=domains&action=sendmail", {
            mail_id: $("#mail_id").val(),
            id: $("#domain_id").val()
        }, function (a) {
            parse_response(a)
        }), !1) : (window.location.href = "?cmd=sendmessage&type=domains&selected=" + $("#domain_id").val(), void 0)
    })
}
function bindAccountEvents() {
    $(".toLoad").click(function () {
        return $("#dommanager").show(), $("#man_content").html('<center><img src="ajax-loading.gif" /></center>'), $("#man_title").html($(this).attr("value")), $.post("?cmd=accounts&action=" + $(this).attr("name"), {
            val: $(this).attr("value"),
            id: $("#account_id").val()
        }, function (a) {
            var b = parse_response(a);
            b && "" != b ? $("#man_content").html(b) : $("#man_content").html(" ")
        }), !1
    }), $(".livemode").not("tr").not("input[type=submit]").hover(function () {
        $(this).append('<a href="#" onclick="return false;" class="manuedit">' + lang.edit + "</a>")
    }, function () {
        $(this).find(".manuedit").remove()
    }).click(function () {
        $(".changeMode").eq(0).is(":checked") ? $("#changeMode").removeAttr("checked").eq(0).trigger("change") : $("#changeMode").attr("checked", "checked").eq(0).trigger("change")
    }), $("#changeMode").change(function () {
        var a = 0;
        $(this).is(":checked") ? (a = 1, $.post("?cmd=accounts&action=manualmode", {
            mode: a,
            id: $("#account_id").val()
        }, function (a) {
            var b = parse_response(a);
            b && ($("#changeMode").attr("checked", "checked"), $(".h_manumode").removeAttr("disabled"), $("#passchange").show(), $(".manumode").show(), $(".livemode").hide())
        })) : $.post("?cmd=accounts&action=manualmode", {
            mode: a,
            id: $("#account_id").val()
        }, function (a) {
            var b = parse_response(a);
            b && ($("#changeMode").removeAttr("checked"), $(".h_manumode").attr("disabled", "disabled"), $(".livemode").show(), $(".manumode").hide(), void 0 != $("#product_id option[def]") && ($(':input[id="product_id"]')[0].selectedIndex = $("#product_id option[def]")[0].index), void 0 != $("#server_id option[def]") && ($(':input[id="server_id"]')[0].selectedIndex = $("#server_id option[def]")[0].index))
        })
    }), $("#product_id").change(function () {
        return $.post("?cmd=accounts&action=getservers", {
            server_id: $("#server_id").val(),
            product_id: $(this).val(),
            manumode: $("#server_id").hasClass("manumode") ? "1" : "0",
            show: $(".changeMode").eq(0).is(":checked") ? "1" : "0"
        }, function (a) {
            var b = parse_response(a);
            b && $("#serversload").html(b)
        }), !1
    }), $("#sendmail").click(function () {
        return "custom" != $("#mail_id").val() ? ($.post("?cmd=accounts&action=sendmail", {
            mail_id: $("#mail_id").val(),
            id: $("#account_id").val()
        }, function (a) {
            parse_response(a)
        }), !1) : (window.location.href = "?cmd=sendmessage&type=accounts&selected=" + $("#account_id").val(), void 0)
    }), $(".setStatus").click(function () {
        return !1
    }), $(".setStatus").dropdownMenu({}, function (a) {
        if (a = a.substr(a.lastIndexOf("/") + 1), "AdminNotes" == a) AdminNotes.show();
        else if ("ChangeOwner" == a) $("#ChangeOwner").show(), ajax_update("?cmd=accounts&action=getowners", {}, "#ChangeOwner", !0);
        else if ("Delete" == a) {
            if (1 > $("#testform input[class=check]:checked").length) return alert("Nothing checked"), !1;
            confirm1()
        }
    }), $("#account_id").length > 0 && ajax_update("?cmd=accounts&action=getacctaddons", {
        id: $("#account_id").val()
    }, "#loadaddons")
}
function bindInvoiceEvents() {
    var a = window;
    "" != a.location.hash && a.location.hash && "#" == a.location.hash.substr(0, 1) && 1 > $("#invoice_id").length && "#" != a.location.hash && ajax_update("?cmd=invoices&action=edit&list=all&id=" + window.location.hash.substr(1), {}, "#bodycont");
    var b = $("#invoice_id").val();
    $(".transeditor").change(function () {
        $.post("?cmd=invoices&action=changething&" + $("#transform").serialize(), {
            id: b
        }, function (a) {
            var b = parse_response(a);
            1 == b && $(".invitem").eq(0).change()
        })
    }), $("#new_currency_id").change(function () {
        $("#exrates").find("input").hide(), $("#exrates").find("input").eq($("#new_currency_id")[0].selectedIndex).show()
    }), $("#calcex").click(function () {
        $(this).is(":checked") ? ($("#exrates").show(), $("#exrates").find("input").eq($("#new_currency_id")[0].selectedIndex).show()) : $("#exrates").hide()
    }), $("#addliner").click(function () {
        return $("#addliners2").show(), $("#catoptions_container").show(), $("#addliners").hide(), !1
    }), $("a.tload2").click(tload2), setTimeout("lateInvoiceBind()", 30), setTimeout("bindInvoiceDetForm()", 30), $("#inv_notes").bind("change", function () {
        $(this).addClass("notes_changed"), $("#notes_submit").show()
    }), $("#notes_submit input").click(function () {
        var a = $("#inv_notes").val();
        return $(this).parent().hide(), $("#inv_notes").removeClass("notes_changed"), $.post("?cmd=invoices&action=changething&make=addnotes", {
            id: b,
            notes: a
        }, function (a) {
            parse_response(a)
        }), !1
    }), $(".setStatus").dropdownMenu({}, function (c, d, e, f) {
        if (c = c.substr(c.lastIndexOf("/") + 1), "Paid" == c || "Unpaid" == c || "Cancelled" == c || "Refunded" == c) $.post("?cmd=invoices&action=changething&make=setstatus", {
                status: c,
                id: b
            }, function (a) {
                var b = parse_response(a);
                0 != b && null != b && ($("#invoice_status").html(f), $("#invoice_status").attr({
                    "class": c
                }), $(".addPayment").removeClass("disabled"), $("#hd1_m li").removeClass("disabled"), $("#hd2_m li").removeClass("disabled"), $("li.act_" + c.toLowerCase()).addClass("disabled"))
            });
        else if ("SplitItems" == c) {
            if (2 > $(".invitem_checker").length || 1 > $(".invitem_checker:checked").length) return;
            var g = $(".invitem_checker:checked").serialize();
            $.getJSON("?cmd=invoices&action=split&" + g, {
                id: b
            }, function (a) {
                a.id && ($("#taskMGR").taskMgrAddInfo("Invoice split success"), ajax_update("?cmd=invoices&action=edit&list=all&id=" + a.id, {}, "#bodycont"), window.location.hash = "#" + a.id)
            })
        } else if ("AddNote" == c) $("#inv_notes").focus();
        else if ("SendReminder2" == c) {
            if (1 > $("#testform input[class=check]:checked").length) return alert("Nothing checked"), !1;
            ajax_update("?cmd=invoices&action=bulkreminder&" + $("#testform").serialize(), {
                stack: "push"
            })
        } else "MarkCancelled" == c ? $(".markcancelled").eq(0).click() : "downloadPDF" == c ? a.location.href = "?action=download&invoice=" + b : "EditNumber" == c ? $("#paid_invoice_line .editbtn").click() : "EditDetails" == c ? $(".tdetail a").click() : "SendInvoice" == c ? $.post("?cmd=invoices&action=changething&make=sendinvoice", {
                id: b
            }, function (a) {
                parse_response(a)
            }) : "IssueRefund" == c ? $("#refunds").load("?cmd=invoices&action=refundsmenu&invoice_id=" + b, function () {
                $("#refunds").show()
            }) : "ChangeCurrency" == c ? $("#chcurr").toggle() : "CreateInvoice" == c ? a.location.href = "?cmd=invoices&action=createinvoice&client_id=" + $("#client_id").val() : "SendReminder" == c ? $.post("?cmd=invoices&action=changething&make=sendreminder", {
                id: b
            }, function (a) {
                parse_response(a)
            }) : "SendMessage" == c && (a.location.href = "?cmd=sendmessage&type=invoices&selected=" + b)
    }), $(".addPayment").click(function () {
        return $(this).hasClass("disabled") || $("#addpay").toggle(), !1
    }), $(".recstatus").click(function () {
        if ($(this).hasClass("activated")) return !1;
        var a = "Active";
        return $(this).hasClass("recoff") && (a = "Stopped"), $(".recstatus").removeClass("activated"), $(this).addClass("activated"), $.post("?cmd=invoices&action=changething&make=changerecstatus", {
            id: b,
            recstatus: a
        }, function (a) {
            parse_response(a)
        }), !1
    }), $(".sendInvoice").click(function () {
        return $.post("?cmd=invoices&action=changething&make=sendinvoice", {
            id: b
        }, function (a) {
            parse_response(a)
        }), !1
    }), $(".deleteInvoice").click(function () {
        var c = confirm("Do you really want to delete this invoice?");
        return c && ($(this).attr("href") ? $.post($(this).attr("href"), {
            empty1mc: "param"
        }, function (a) {
            parse_response(a), $("#currentpage").eq(0).change()
        }) : $.post("?cmd=invoices&action=menubutton&make=deleteinvoice", {
            id: b
        }, function (b) {
            var c = parse_response(b);
            1 == c && (a.location.href = "?cmd=clients&action=show&id=" + $("#client_id").val() + "&picked_tab=invoices")
        })), !1
    }), $(".invoiceUnlock").click(function () {
        var a = this;
        return $.post($(this).attr("href"), {
            empty1mc: "param"
        }, function (b) {
            parse_response(b), $(a).hide()
        }), !1
    })
}
function bindNewOrderEvents() {
    $(".inv_gen_check").click(function () {
        $(this).is(":checked") ? $("#invsend").removeAttr("disabled") : $("#invsend").removeAttr("checked").attr("disabled", "disabled")
    }), $(".get_prod_btn").change(function () {
        var a = $("#product_id");
        if ("new" == $(a).val()) window.location = "?cmd=services&action=addproduct", $(a).val($("select[name='" + $(a).attr("name") + "'] option:first").val());
        else {
            var b = "";
            if ($("#client_id").length > 0) {
                if ("new" == $("#client_id").val()) return window.location = "?cmd=newclient", void 0;
                b = "&client_id=" + $("#client_id").val()
            }
            $("#prod_loader").show(), ajax_update("?cmd=orders&action=get_product" + b, {
                product_id: $("#product_id").val()
            }, "#product_details")
        }
    }), $(".new_gat_btn").change(function () {
        "new" == $(this).val() && (window.location = "?cmd=managemodules&action=payment", $(this).val($("select[name='" + $(this).attr("name") + "'] option:first").val()))
    }), $(".setStatus").dropdownMenu({}, function (a) {
        switch (a = a.substr(a.lastIndexOf("/") + 1)) {
        case "add_discount":
            alert("discount"), $(".dis_menu_el").addClass("hidden").hide(), $(".aff_menu_el").hasClass("hidden") && $(".setStatus").hide();
            break;
        case "assign_aff":
            alert("affiliate"), $(".aff_menu_el").addClass("hidden").hide(), $(".dis_menu_el").hasClass("hidden") && $(".setStatus").hide()
        }
    }), $("#extend_notes").click(function () {
        $(this).hide(), $('textarea[name="order_notes"]').show()
    }), $("#add_dom_btn").click(function () {
        alert("add another domain")
    }), bindCheckAvailOrd()
}
function bindCheckAvailOrd() {
    $(".check_avail").click(function () {
        $(".avail_result").html('<img src="ajax-loading2.gif" />'), ajax_update("?cmd=orders&action=whois", {
            domain: $("#domain_sld").val() + $("#domain_tld").val(),
            type: $("input[name='domain_action']:checked").val()
        }, ".avail_result")
    })
}
function lateEstimatesBind() {
    $(".tdetail a").unbind("click").click(function () {
        return $(".secondtd").toggle(), $(".tdetails").toggle(), $(".a1").toggle(), $(".a2").toggle(), !1
    }), $(".livemode").unbind("mouseenter mouseleave").hover(function () {
        $(this).append('<a href="#" onclick="return false;" class="manuedit">' + lang.edit + "</a>")
    }, function () {
        $(this).find(".manuedit").remove()
    }).unbind("click").click(function () {
        $(".tdetail a").click()
    })
}
function estimatesItemsSubmit() {
    var a = $(this).parent().parent(),
        b = $(a).attr("id").replace("line_", ""),
        c = $("#estimate_id").val();
    a.find("#ltotal_" + b).html((parseFloat($(a).find(".invqty").eq(0).val()) * parseFloat(a.find(".invamount").eq(0).val())).toFixed(2)), $.post("?cmd=estimates&action=updatetotals&" + $("#itemsform").serialize(), {
        id: c
    }, function (a) {
        var b = parse_response(a);
        b && ($("#updatetotals").html(b), ajax_update("?cmd=estimates&action=getdetailsmenu", {
            id: c
        }, "#detcont"))
    })
}
function bindEstimatesDetForm() {
    function b() {
        $("#products").hide(), $("#products").html(""), $("#rmliner").show(), $("#addliners").show(), $("#catoptions_container").hide(), $("#addliners2").hide(), $("#catoptions option").each(function () {
            $(this).removeAttr("selected")
        }), $("#catoptions option").eq(1).attr("selected", "selected")
    }
    lateEstimatesBind();
    var a = $("#estimate_id").val();
    $(".haspicker").datePicker({
        startDate: startDate
    }), $("#main-invoice .editline").unbind("mouseenter mouseleave").hover(function () {
        $(this).hasClass("editable1") || $(this).find(".editbtn").show()
    }, function () {
        $(this).find(".editbtn").hide()
    }).find(".editbtn").unbind("click").click(function () {
        var a = $(this).parent();
        return a.find("textarea").height(a.find(".line_descr").height()), a.addClass("editable1").children().hide(), a.find(".editor-line").show().find("textarea").focus(), !1
    }), $("#main-invoice .savebtn").unbind("click").click(function () {
        var a = $(this).parent().parent();
        return a.find(".line_descr").html(a.find("textarea").val().replace(/([^>\r\n]?)(\r\n|\n\r|\r|\n)/g, "$1<br/>$2")).show(), a.removeClass("editable1").find(".editor-line").hide(), a.parent().find(".invitem").eq(0).change(), !1
    }), $("#detailsform").unbind("submit").one("submit", function () {
        return $.post("?cmd=estimates&action=changething&" + $(this).serialize(), {
            id: a
        }, function (b) {
            var c = parse_response(b);
            c && ($("#detcont").html(c), $.post("?cmd=estimates&action=updatetotals", {
                id: a
            }, function (a) {
                var b = parse_response(a);
                b && $("#updatetotals").html(b)
            }))
        }), !1
    }), $(".removeLine").unbind("click").click(function () {
        var a = $(this);
        $(this).parent().parent().addClass("yellow_bg");
        var b = confirm("Do you really want to delete this line?");
        return b && $.post($(this).attr("href"), {
            empty1mc: "param"
        }, function (b) {
            var c = parse_response(b);
            1 == c && (a.parent().parent().slideUp("fast", function () {
                $(this).remove()
            }), $(".invitem").eq(0).change())
        }), $(this).parent().parent().removeClass("yellow_bg"), !1
    }), $(".invitem").unbind("change").change(estimatesItemsSubmit), $(".invitem2").unbind("click").click(estimatesItemsSubmit), $("#catoptions").unbind("change").change(function () {
        "-1" == $(this).val() ? (ajax_update("?cmd=estimates&action=getblank", {}, "#products"), $("#products").show(), $("#rmliner").hide()) : "-2" == $(this).val() ? (ajax_update("?cmd=estimates&action=getaddon", {
            currency_id: $("#currency_id").val()
        }, "#products"), $("#products").show(), $("#rmliner").hide()) : $(this).val() > "0" && (ajax_update("?cmd=estimates&action=getproduct", {
            cat_id: $(this).val(),
            currency_id: $("#currency_id").val()
        }, "#products"), $("#products").show(), $("#rmliner").hide())
    }), $("#prodcanc").unbind("click"), $(".prodok").unbind("click").click(function () {
        if ($("#nline").length > 0 && "" != $("#nline").val()) {
            var b = 0;
            $("#nline_tax").is(":checked") && (b = 1), $.post("?cmd=estimates&action=addline", {
                line: $("#nline").val(),
                tax: b,
                price: $("#nline_price").val(),
                qty: $("#nline_qty").val(),
                id: a
            }, function (a) {
                var b = parse_response(a);
                b && ($("#addliners").before(b), $("#nline").val(""), $("#nline_price").val(""), $("#nline_tax").removeAttr("checked"), $("#detailsform").eq(0).submit())
            })
        } else $("#product_id").length > 0 ? $.post("?cmd=estimates&action=addline", {
                product: $("#product_id").val(),
                id: a
            }, function (a) {
                var b = parse_response(a);
                b && ($("#addliners").before(b), $("#detailsform").eq(0).submit())
            }) : $("#addon_id").length > 0 && $.post("?cmd=estimates&action=addline", {
                addon: $("#addon_id").val(),
                id: a
            }, function (a) {
                var b = parse_response(a);
                b && ($("#addliners").before(b), $("#detailsform").eq(0).submit())
            });
        $("#prodcanc").click()
    }), $("#prodcanc").click(function () {
        b()
    }), $("#rmliner").click(function () {
        b()
    })
}
function bindEstimatesEvents() {
    var a = $("#estimate_id").val();
    $("#estsubject").focus(function () {
        $(this).addClass("sub_hover")
    }).blur(function () {
        $(this).removeClass("sub_hover")
    }).change(function () {
        var b = $(this).val();
        $.post("?cmd=estimates&action=changething&make=addsubject", {
            id: a,
            subject: b
        }, function (a) {
            parse_response(a)
        })
    }), $("#changeowner").click(function () {
        return $("#curr_det").hide(), $("#client_container").show(), ajax_update("?cmd=estimates&action=changeowner&client_id=" + $("#client_id").val() + "&estimate_id=" + a, !1, "#client_container"), !1
    }), $("#new_estimate_button").click(function () {
        $("#new_estimate").hasClass("shown") ? $("#new_estimate").hide().removeClass("shown") : $("#new_estimate").hasClass("content_loaded") ? $("#new_estimate").show().addClass("shown") : ($("#new_estimate").show().addClass("shown"), ajax_update("?cmd=estimates&action=getclients", {}, "#new_estimate", !0), $("#new_estimate").addClass("content_loaded"))
    }), $("#est_notes").bind("textchange", function () {
        $(this).addClass("notes_changed"), $("#notes_submit").show()
    }), $("#est_admin_notes").bind("textchange", function () {
        $(this).addClass("notes_changed"), $("#admin_notes_submit").show()
    }), $("#notes_submit input").click(function () {
        var b = $("#est_notes").val();
        return $(this).parent().hide(), $("#est_notes").removeClass("notes_changed"), $.post("?cmd=estimates&action=changething&make=addnotes", {
            id: a,
            notes: b
        }, function (a) {
            parse_response(a)
        }), !1
    }), $("#admin_notes_submit input").click(function () {
        var b = $("#est_admin_notes").val();
        return $(this).parent().hide(), $("#est_admin_notes").removeClass("notes_changed"), $.post("?cmd=estimates&action=changething&make=addprivatenotes", {
            id: a,
            notes_private: b
        }, function (a) {
            parse_response(a)
        }), !1
    }), $(".sendEstimate").click(function () {
        $.post("?cmd=estimates&action=changething&make=sendestimate", {
            id: a
        }, function (a) {
            parse_response(a), $("#hd1_m li").removeClass("disabled"), $("li.act_sent").addClass("disabled"), $("#estimate_status").html($("li.act_sent a").html()), $("#estimate_status").attr({
                "class": "Sent"
            })
        })
    }), $(".setStatus").dropdownMenu({}, function (b, c, d, e) {
        b = b.substr(b.lastIndexOf("/") + 1), "Draft" == b || "Sent" == b || "Accepted" == b || "Invoiced" == b || "Dead" == b ? $.post("?cmd=estimates&action=changething&make=setstatus", {
            status: b,
            id: a
        }, function (a) {
            var c = parse_response(a);
            0 != c && null != c && ("Invoiced" == b ? ($("button.invoiced_").attr("disabled", "disabled"), $(".invoiced_").addClass("disabled")) : ($("button.invoiced_").removeAttr("disabled"), $(".invoiced_").removeClass("disabled")), $("#estimate_status").html(e), $("#estimate_status").attr({
                "class": b
            }), $("#hd1_m li").removeClass("disabled"), $("li.act_" + b.toLowerCase()).addClass("disabled"), "Dead" == b || "Draft" == b ? $("#clientlink").hide() : $("#clientlink").ShowNicely())
        }) : "AddNote" == b ? $("#est_notes").focus() : "AddPrivateNote" == b ? $("#est_admin_notes").focus() : "EditDetails" == b ? $(".tdetail a").click() : "CreateInvoice" == b ? $.post("?cmd=estimates&action=createinvoice", {
            id: a
        }, function (a) {
            parse_response(a)
        }) : "downloadPDF" == b ? window.location.href = "?action=download&estimate=" + a : "ChangeCurrency" == b ? $("#chcurr").toggle() : "CreateInvoice" == b && (window.location.href = "?cmd=estimates&action=edit&make=createinvoice&id=" + a)
    }), $("#new_currency_id").change(function () {
        $("#exrates").find("input").hide(), $("#exrates").find("input").eq($("#new_currency_id")[0].selectedIndex).show()
    }), $("#calcex").click(function () {
        $(this).is(":checked") ? ($("#exrates").show(), $("#exrates").find("input").eq($("#new_currency_id")[0].selectedIndex).show()) : $("#exrates").hide()
    }), $("#addliner").click(function () {
        return $("#addliners2").show(), $("#catoptions_container").show(), $("#addliners").hide(), !1
    }), $(".deleteEstimate").click(function () {
        var b = confirm("Do you really want to delete this estimate?");
        return b && ($(this).attr("href") ? $.post($(this).attr("href"), {
            empty1mc: "param"
        }, function (a) {
            parse_response(a), $("#currentpage").eq(0).change()
        }) : $.post("?cmd=estimates&action=menubutton&make=deleteestimate", {
            id: a
        }, function (a) {
            var b = parse_response(a);
            1 == b && (window.location.href = "?cmd=clients&action=show&id=" + $("#client_id").val() + "&picked_tab=estimates")
        })), !1
    }), $(".tdetail a").unbind("click").click(function () {
        return $(".secondtd").toggle(), $(".tdetails").toggle(), $(".a1").toggle(), $(".a2").toggle(), !1
    }), $(".livemode").unbind("mouseenter mouseleave").hover(function () {
        $(this).append('<a href="#" onclick="return false;" class="manuedit">' + lang.edit + "</a>")
    }, function () {
        $(this).find(".manuedit").remove()
    }).unbind("click").click(function () {
        $(".tdetail a").click()
    }), bindEstimatesDetForm()
}
function bindTicketEvents() {
    function d() {
        return 2 > $(".ticketnotesremove").length && ($("#ticketnotebox").slideUp(), $(".badd").show()), ajax_update("?cmd=tickets", {
            make: "removenote",
            action: "menubutton",
            id: a,
            noteid: this.hash.slice(1)
        }, function (a) {
            $("#ticketnotes").html(a), $(".ticketnotesremove").bind("click", d)
        }), !1
    }
    var a = $("#ticket_number").val(),
        b = window,
        c = document;
    ticketpoll === !1 && (ticketpoll = setInterval(function () {
        if (autopoll && $("a.selected", "#content_tb").attr("rel")) {
            if ($(".freseter:visible").length > 0) return !0;
            autopoll = !1, $.post("?cmd=tickets", {
                id: $("#ticket_number").val(),
                make: "poll",
                page: parseInt($(".pagination span.current", "#testform").eq(0).html()) - 1,
                action: "menubutton",
                body: $("#replyarea").val(),
                list: $("a.selected", "#content_tb").length ? $("a.selected", "#content_tb").attr("rel") : "all",
                dept: $(".selected", ".leftNav").parent("div").length ? $("div:has(.selected)", ".leftNav").attr("id").match(/\d*$/) : $(".selected", ".leftNav").attr("id").match(/\d*$/),
                assigned: $("#dept_my").hasClass("selected") ? 1 : $("a.selected", "#content_tb").parent("#listdept_my,#dept_my").length ? 1 : 0
            }, function (a) {
                if (a.tickets) for (var b in a.tickets) {
                        if (b > 10) break;
                        var c = $("a[rel=" + a.tickets[b].ticket_number + "]");
                        if (c.length) {
                            var d = c.parent().parent();
                            0 == a.tickets[b].admin_read ? c.addClass("unread") : c.removeClass("unread"), d.find("td:last").html(a.tickets[b].lastreply), d.find("td").eq(5).find("span").attr("class", "").addClass(a.tickets[b].status).html(lang[a.tickets[b].status])
                        } else {
                            var e = "",
                                f = "";
                            "" != a.tickets[b].client_id && 0 != a.tickets[b].client_id && (e = '<a href="?cmd=clients&amp;action=show&amp;id=' + a.tickets[b].client_id + '">', f = "</a>"), $("#updater").eq(0).prepend('<tr>                         <td width="20"><input type="checkbox" name="selected[]" value="' + a.tickets[b].id + '" class="check">                          </td>                          <td>' + e + a.tickets[b].name + f + "</td> \\n                        <td class='subjectline'><div class='df1'><div class='df2'><div class'df3'><a rel=\"" + a.tickets[b].ticket_number + '" class="tload2" href="?cmd=tickets&amp;action=view&amp;list=all&amp;num=' + a.tickets[b].ticket_number + '">' + a.tickets[b].tsubject + '</a></div></div></div></td>                         <td></td> 						<td><span class="' + a.tickets[b].status + '">' + lang[a.tickets[b].status] + "</span></td>                         <td>" + a.tickets[b].rpname + '</td>                         <td class="border_' + a.tickets[b].priority + '">' + a.tickets[b].lastreply + "</td>                         </tr>")
                        }
                }
                a.draftsave && $("#draftinfo .draftdate").html(lang.draftsavedat + " " + a.draftsave), a.adminreply && 1 > $(".adminr_" + a.adminreply.replier_id).length && $("#alreadyreply").append('<span class="numinfos adminr_' + a.adminreply.replier_id + '"><strong>' + a.adminreply.name + "</strong> " + lang.startedreplyat + " " + a.adminreply.date + '  <a href="#" onclick="loadReply(\'' + a.adminreply.id + "');return false\">" + lang.preview + "</a> </span>"), a.newreply && $("#justadded").ShowNicely(), a.tags && updateTags(a.tags), autopoll = !0
            }, "json")
        }
    }, 1e4)), $("#ticketsubmitter").click(function () {
        autopoll = !1
    }), $("#showlatestreply").click(function () {
        var a = "";
        return $(this).attr("rel") ? (a = $(this).attr("rel"), $(this).removeAttr("rel")) : a = $("#recentreplies input.viewtime:last").val(), ajax_update("?cmd=tickets", {
            action: "menubutton",
            make: "getrecent",
            viewtime: a,
            id: $("#ticket_number").val()
        }, "#recentreplies", !1, !0), $("#justadded").hide(), !1
    }), "" != b.location.hash && b.location.hash && "#" == b.location.hash.substr(0, 1) && 1 > $("#ticket_id").length && "#" != b.location.hash && ajax_update("?cmd=tickets&action=view&list=all&num=" + window.location.hash.substr(1), {}, "#bodycont"), $(".scroller").click(function () {
        var a = $("[name=" + $(this).attr("href").substr(1) + "]");
        if (a.length) {
            var b = a.offset().top;
            return $("html,body").animate({
                scrollTop: b - 100
            }, 500, "linear", function () {
                $("#replyarea").focus()
            }), !1
        }
    }), $("#replyarea").keydown(function () {
        $("#draftinfo .controls").is(":visible") || "" == $("#replyarea").val() || ($("#draftinfo .controls").show(), $("#draftinfo .draftdate").show())
    }), $("#ticketnotessave").click(function () {
        return ajax_update("?cmd=tickets", {
            make: "savenotes",
            action: "menubutton",
            id: a,
            notes: $("#ticketnotesarea").val()
        }, function (a) {
            $("#ticketnotes").html(a), $(".ticketnotesremove").bind("click", d)
        }), $("#ticketnotesarea").val(""), !1
    }), a && ajax_update("?cmd=tickets", {
        action: "menubutton",
        make: "loadnotes",
        id: a
    }, function (a) {
        $("#ticketnotes").html(a), $(".ticketnotesremove").bind("click", d)
    }), $(".attach").click(function () {
        return $("#attachments").show(), $("#attachments").append('<br/><input type="file" size="50" name="attachments[]" class="attachment"/>'), !1
    }), $(".deleteTicket").click(function () {
        var b = confirm("Do you really want to delete this ticket?");
        return b && $.post("?cmd=tickets&action=menubutton&make=deleteticket", {
            tnum: a
        }, function (a) {
            var b = parse_response(a);
            1 == b && $(".tload.selected").trigger("click")
        }), !1
    }), $(".deletereply").click(function () {
        var b = confirm("Do you really want to delete this reply?"),
            c = $(this).attr("href").substr($(this).attr("href").lastIndexOf("/") + 1);
        return b && $.post("?cmd=tickets&action=menubutton&make=deletereply", {
            rid: c,
            tnum: a
        }, function (a) {
            var b = parse_response(a);
            1 == b && $("#reply_" + c).slideUp("slow", function () {
                $(this).remove()
            })
        }), !1
    }), $("#ticket_editform").submit(function (a) {
        a.preventDefault();
        var b = this;
        return $.post("?cmd=tickets&" + $(this).serialize(), {}, function (a) {
            var c = parse_response(a);
            1 == c && ($("#ticket_editdetails").hide(), ajax_update($(b).attr("action"), {}, "#bodycont"))
        }), !1
    }), $("a.editTicket").click(function (b) {
        b.preventDefault();
        var c = [400, 260];
        $(".tdetails").data("cls") && (c = [230, ""]), $(".tdetails tr").show(), $(".tdetails").animate({
            width: c[0]
        }, {
            queue: !0
        }).data("cls", 400 == c[0]).find("input, select").each(function () {
            $(this).unbind("change").bind("change", function () {
                $(this).is("select") ? $(this).prev().text($(this).children('[value="' + $(this).val() + '"]').text()) : $(this).prev().text($(this).val())
            }).toggle().siblings().toggle();
            var a = $(this).val();
            !$(this).parents(".sh_row").length || a.length && (!$(this).is("select") || "0" != a && 0 != a) || $(this).parents(".sh_row").hide()
        }), 400 == c[0] ? $(".tdetails tr").show() : ($(".tdetails tr.sh_row.force").hide(), ajax_update("?cmd=tickets&action=menubutton&make=edit_ticket&" + $("input, select, textarea, button", ".tdetails").serialize(), {
            ticket_number: a
        }, function () {
            ajax_update("?cmd=tickets&action=view&list=all&num=" + a, {}, "#bodycont")
        })), $(".tdetails table tr:first td:last").animate({
            width: c[1]
        }, {
            queue: !0
        })
    }), $("a.editor").click(function (a) {
        a.preventDefault();
        var b = $(this).attr("href");
        (void 0 == typeof b || "#" == b) && (b = "");
        var c = $(this).parents(".ticketmsg");
        return $.post("?cmd=tickets&action=menubutton&make=getreply", {
            rid: "" == b ? $("#ticket_id").val() : b,
            rtype: "" == b ? "ticket" : "reply"
        }, function (a) {
            if (void 0 != typeof a.reply) var d = $("#msgbody" + b, c).height();
            $("#editbody" + b, c).show().children("textarea").height(d).val(a.reply).elastic(), $("#msgbody" + b, c).hide(), $(".editbytext", c).hide()
        }), !1
    }), $("a.editorsubmit").click(function (a) {
        a.preventDefault();
        var b = $(this).attr("href");
        (void 0 == typeof b || "#" == b) && (b = "");
        var c = $(this).parents(".ticketmsg");
        return $.post("?cmd=tickets&action=menubutton&make=editreply", {
            rid: "" == b ? $("#ticket_id").val() : b,
            rtype: "" == b ? "ticket" : "reply",
            body: $("#editbody" + b, c).children("textarea").val()
        }, function (a) {
            var d = parse_response(a);
            $("#msgbody" + b, c).replaceWith(d).show(), $("#editbody" + b, c).hide()
        }), !1
    }), $(".quoter").click(function () {
        var a = "reply";
        "reply" != $(this).attr("type") && (a = "ticket");
        var b = $(this).attr("href").substr($(this).attr("href").lastIndexOf("/") + 1);
        return $.post("?cmd=tickets&action=menubutton&make=quote", {
            rid: b,
            rtype: a
        }, function (a) {
            var b = parse_response(a);
            if ("string" == typeof b) {
                var c = $("#replyarea").val();
                $("#replyarea").val(c + "\r\n" + b), $(".scroller").trigger("click")
            }
        }), !1
    }), $(".tdetail a").click(function () {
        return $(".tdetails").toggle(), $(".a1").toggle(), $(".a2").toggle(), !1
    }), $(".ticketmsg").mouseup(function () {
        var a = c.selection ? c.selection.createRange().text : c.getSelection();
        "" != a ? $(this).find(".quoter2").show() : $(this).find(".quoter2").hide()
    }), $(".quoter2").click(function () {
        var a = c.selection ? c.selection.createRange().text : "" + c.getSelection(),
            b = $("#replyarea").val();
        return $("#replyarea").val(b + "\r\n>" + a.replace(/\n/g, "\n>") + "\r\n"), $(".scroller").trigger("click"), !1
    }), $(".setStatus").dropdownMenu({}, function (b, d, e, f) {
        if (b = b.substr(b.lastIndexOf("/") + 1), -1 != b.lastIndexOf("status|")) b = b.substr(b.lastIndexOf("|") + 1), $.post("?cmd=tickets&action=menubutton&make=setstatus", {
                status: b,
                id: a
            }, function (a) {
                var c = parse_response(a);
                0 != c && null != c && ($("#ticket_status").html(f), $("#ticket_status").attr({
                    "class": b
                }), $("#hd1_m li").removeClass("disabled"), $("li.act_" + b.toLowerCase()).addClass("disabled"), "Closed" == b ? ($("#replytable").hide(), $("#backto").click()) : $("#replytable").show())
            });
        else if ("Low" == b || "Medium" == b || "High" == b) $.post("?cmd=tickets&action=menubutton&make=setpriority", {
                priority: b,
                id: a
            }, function (a) {
                var c = parse_response(a);
                0 != c && null != c && ($("#hd4_m li").removeClass("disabled"), $("#ticket_status").parent().attr("class", "").addClass("prior_" + b), $("li.opt_" + b.toLowerCase()).addClass("disabled"))
            });
        else if ("Unread" == b) ajax_update("?cmd=tickets&action=menubutton&make=markunread", {
                id: a
            });
        else if ("ShowLog" == b) ajax_update("?cmd=tickets&action=menubutton&make=showlog", {
                id: $("#ticket_id").val()
            }, "#ticket_log"), $("#ticket_log").show(), $("#ticket_editdetails").hide();
        else if ("blockBody" == b) {
            var g = c.selection ? c.selection.createRange().text : "" + c.getSelection();
            ajax_update("?cmd=tickets&action=menubutton&make=addban", {
                tnum: a,
                type: "body",
                text: g
            })
        } else "blockEmail" == b ? ajax_update("?cmd=tickets&action=menubutton&make=addban", {
                tnum: a,
                type: "email"
            }) : "blockSubject" == b ? ajax_update("?cmd=tickets&action=menubutton&make=addban", {
                tnum: a,
                type: "subject"
            }) : "share:" == b.substr(0, 6) ? $.post("?cmd=tickets&action=menubutton&make=share", {
                tnum: a,
                uuid: b.substr(6)
            }, function (b) {
                return parse_response(b), ajax_update("?cmd=tickets&action=view&list=all&num=" + a, {}, "#bodycont"), !1
            }) : "unshare" == b ? $.post("?cmd=tickets&action=menubutton&make=unshare", {
                tnum: a
            }, function () {
                ajax_update("?cmd=tickets&action=view&list=all&num=" + a, {}, "#bodycont")
            }) : "assign:" == b.substr(0, 7) && $.post("?cmd=tickets&action=menubutton&make=assign", {
                tnum: a,
                id: b.substr(7)
            }, function (b) {
                return parse_response(b), ajax_update("?cmd=tickets&action=view&list=all&num=" + a, {}, "#bodycont"), !1
            })
    }), $("#suggestion").length > 0 && ($.post("?cmd=predefinied&action=gettop", {
        empty1mc: "param"
    }, function (a) {
        var b = parse_response(a);
        b && ($("#suggestion div.d1").html(b), $("#suggestion div.d1").show())
    }), $("#rswitcher a").click(function () {
        $("#rswitcher a").removeClass("active"), $("#suggestion").addLoader();
        var a = $(this);
        return $.post($(this).attr("href"), {
            empty1mc: "param"
        }, function (b) {
            var c = parse_response(b);
            c && ($("#suggestion div").hide(), $("#suggestion div." + a.attr("class")).html(c).show(), $("#suggestion").hideLoader(), a.addClass("active"))
        }), !1
    })), $("a.tload2").click(tload2), $(c).mouseup(function () {
        var a = c.selection ? c.selection.createRange().text : c.getSelection();
        "" != a ? $(".highlighter").removeClass("disabled") : ($(".highlighter").addClass("disabled"), $(".quoter2").hide())
    }), $("#client_picker").change(function () {
        $(this).removeClass("err"), $(this).val() >= 0 ? ($("#emailrow").hide(), $("#emailrow2").hide()) : 0 > $(this).val() && ($("#emailrow").show(), $("#emailrow2").show())
    }), $("#newticketform").submit(function () {
        return "0" == $("#client_picker").val() ? ($("#client_picker").addClass("err"), !1) : !0
    }), $("input[name='method']").change(function () {
        "POP" == $("input[name='method']:checked").val() ? ($("#popform").show(), $("#pipeform").hide()) : ($("#popform").hide(), $("#pipeform").show()), $(this).blur()
    });
    var e = $(".ticketmsg:gt(0)").not(":last");
    if (e.length > 3) {
        var f = $('<div class="ticketmsg tmsgwarn"><h2>Click here to show (' + e.length + ") other messages</h2></div>").click(function () {
            $(".ticketmsg:hidden").show(), $(this).remove()
        });
        e.hide().eq(0).before(f)
    }
    a == parseInt(a) && $(document).trigger("HostBill.ticketload")
}
function checkEl() {
    var a = $(this).parent().parent();
    $(this).is(":checked") ? a.addClass("checkedRow") : a.removeClass("checkedRow")
}
function bindEvents(a) {
    a !== void 0 || $(document).pjax("a[data-pjax]", "#bodycont", {
        timeout: 800
    }).on("pjax:send", function () {
        $("#taskMGR").taskQuickLoadShow()
    }).on("pjax:complete", function () {
        $("#taskMGR").taskQuickLoadHide(), bindEvents(!0)
    }), $(".leftNav", "#body-content").on("click", "a[data-pjax].tstyled", function () {
        $(".leftNav a", "#body-content").removeClass("selected"), $(this).addClass("selected")
    }), bindFreseter(), $(".check").click(checkEl), $("a.vtip_description").vTip(), $(".hpLinks").dropdownMenu({
        movement: 5
    }, function (a) {
        window.location = a
    }), $(".linkDirectly").click(function () {
        return window.location = $(this).attr("href"), !1
    }), $(".havecontrols").hover(function () {
        $(this).find(".controls").show()
    }, function () {
        $(this).find(".controls").hide()
    }), $("a.sortorder").click(function () {
        return $("#updater").addLoader(), $("a.sortorder").removeClass("asc"), $("a.sortorder").removeClass("desc"), $("#checkall").attr("checked", !1), $("#currentlist").attr("href", $(this).attr("href")), "|ASC" == $(this).attr("href").substring($(this).attr("href").lastIndexOf("|")) ? ($(this).addClass("asc"), $(this).attr("href", $(this).attr("href").substring(0, $(this).attr("href").lastIndexOf("|")) + "|DESC")) : ($(this).addClass("desc"), $(this).attr("href", $(this).attr("href").substring(0, $(this).attr("href").lastIndexOf("|")) + "|ASC")), $.post($("#currentlist").attr("href"), {
            page: parseInt($(".pagination span.current").eq(0).html()) - 1
        }, function (a) {
            var b = parse_response(a);
            b && ($("#updater").html(b), $(".check").unbind("click").click(checkEl))
        }), !1
    }), $("#checkall").click(function () {
        $(this).is(":checked") ? $(".check").attr("checked", !0).parent().parent().addClass("checkedRow") : $(".check").attr("checked", !1).parent().parent().removeClass("checkedRow")
    }), $("div.pagination").pagination($("#totalpages").val()), $(".check").click(checkEl), $(".confirm_it").click(function () {
        return confirm("Are you sure you want to perform this action?") ? void 0 : !1
    }), $(".submiter").click(function () {
        if ($(this).hasClass("confirm") && !confirm("Are you sure you want to perform this action?")) return !1;
        $(this).hasClass("formsubmit") || $("#updater").addLoader(), $("#checkall").removeAttr("checked").prop("checked", !1);
        var a = "";
        "push" == $(this).attr("queue") && (a = "push");
        var b = "";
        return $(".pagination span.current").length > 0 && (b = "&page=" + (parseInt($(".pagination span.current").eq(0).html()) - 1)), $(this).hasClass("formsubmit") ? (window.location = $("#currentlist").attr("href") + b + "&" + $("#testform").serialize() + "&" + $(this).attr("name"), !1) : ($.post($("#currentlist").attr("href") + b + "&" + $("#testform").serialize() + "&" + $(this).attr("name"), {
            stack: a
        }, function (a) {
            var b = parse_response(a);
            b && ($("#updater").html(b), $(".check").unbind("click").click(checkEl))
        }), !1)
    }), $("a.nav_el").each(function (a) {
        $(this).click(function () {
            if ($(this).hasClass("direct")) return !0;
            if ($(this).hasClass("nav_sel")) return $(this).removeClass("nav_sel").removeClass("minim"), $("a.nav_el").eq(0).addClass("nav_sel"), $("div.slide").eq(a).hide(), $("div.slide").eq(0).show(), !1;
            $("#client_tab").find("div.slide").hide();
            var b = $("#client_tab").find("div.slide").eq(a);
            return "Loading" != $(b).html() ? $(b).show() : (ajax_update($(this).attr("href"), {}, "div.slide:eq(" + a + ")"), $(b).show()), $("a.nav_el").removeClass("nav_sel").removeClass("minim"), $(this).addClass("nav_sel"), a > 0 && $(this).addClass("minim"), !1
        })
    }), $("[load]").each(function () {
        var b = $(this);
        if (b.data("loaded")) return !1;
        if ("clients" == b.attr("load")) return Chosen.find(), !1;
        if (b.is("select")) var c = $('<option class="search_loading" style="padding:0 0 0 20px"> Loading</option>').appendTo(this);
        $.get(b.attr("load"), function (a) {
            b.data("loaded", !0).append(a), void 0 !== c && c.remove()
        })
    })
}
function bindQConfigEvents() {
    $("#change_pass").click(function () {
        var a = $(this).parents("form").find("input[name='password1']").val(),
            b = $(this).parents("form").find("input[name='password2']").val();
        $("#qc_update").addLoader(), ajax_update("?action=saveqc&make=changepass", {
            password1: a,
            password2: b,
            qc_page: "Admin_Pass"
        }, "#qc_update")
    }), $(".activate_item").click(function () {
        var a = $(this).parent().find("input[name='type']").val();
        if ("Payment" == a || "Hosting" == a || "Domain" == a) {
            $("#qc_update").addLoader();
            var b = $(this).parent().find("select[name='modulename']").val();
            ajax_update("?action=saveqc&make=activate", {
                filename: b,
                type: a,
                qc_page: a
            }, "#qc_update")
        } else if ("Servers" == a) {
            $("#qc_update").addLoader();
            var c = $(this).parent().find("input[name='name']").val();
            ajax_update("?action=saveqc&make=addserver", {
                name: c,
                qc_page: "Servers"
            }, "#qc_update")
        }
    }), $(".getconfig").click(function () {
        var a = $(this).parents("form").find("input[name='id']").val(),
            b = $(this).parents("form").find("input[name='type']").val();
        if ("Payment" == b) var c = ".payconfig_" + a;
        else if ("Domain" == b) c = ".domconfig_" + a;
        else {
            if ("Servers" != b) return !1;
            c = ".srvconfig_" + a
        }
        return $(c).hasClass("shown") ? ($(this).html("Show Config"), $(c).hide(), $(c).removeClass("shown")) : ($(this).html("Hide Config"), $(c).show(), $(c).addClass("shown")), !1
    }), $(".deactivatemod").click(function () {
        var a = $(this).parents("form").find("input[name='id']").val(),
            b = $(this).parents("form").find("input[name='type']").val();
        $("#qc_update").addLoader(), ajax_update("?action=saveqc&make=deactivate", {
            id: a,
            qc_page: b
        }, "#qc_update")
    }), $(".savemod").click(function () {
        var a = $(this).parents("form").find("input[name='id']").val(),
            b = $(this).parents("form").find("input[name='type']").val(),
            c = $(this).parents("form").serialize();
        $("#qc_update").addLoader(), ajax_update("?action=saveqc&make=savemodule&" + c, {
            id: a,
            qc_page: b
        }, "#qc_update")
    }), $(".saveserver").click(function () {
        var a = $(this).parents("form").find("input[name='id']").val(),
            b = $(this).parents("form").serialize();
        $("#qc_update").addLoader(), ajax_update("?action=saveqc&make=saveserver&" + b, {
            id: a,
            qc_page: "Servers"
        }, "#qc_update")
    }), $(".removeserver").click(function () {
        var a = $(this).parents("form").find("input[name='id']").val();
        confirm("Do You really want to remove this server?") && ($("#qc_update").addLoader(), ajax_update("?action=saveqc&make=removeserver", {
            id: a,
            qc_page: "Servers"
        }, "#qc_update"))
    })
}
function send_msg(a) {
    return "clients" == a && 1 > $("input[class=check]:checked").length || "allclients" != a && 0 == $("input[class=check]:checked").length ? (alert("Nothing checked."), !1) : ($("#testform").removeAttr("action"), $("#testform").attr("action", "?cmd=sendmessage"), $("#testform").append('<input type="hidden" name="type" value="' + a + '" />'), $("#testform").submit(), !1)
}
var timing = 0,
    t = "",
    maximum = 10,
    num_errors = 0,
    num_infos = 0;
Date.dayNames = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"], Date.abbrDayNames = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"], Date.monthNames = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"], Date.abbrMonthNames = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"], Date.firstDayOfWeek = 1, Date.format = "dd/mm/yyyy", Date.fullYearStart = "20",
function () {
    function a(a, b) {
        Date.prototype[a] || (Date.prototype[a] = b)
    }
    a("isLeapYear", function () {
        var a = this.getFullYear();
        return 0 == a % 4 && 0 != a % 100 || 0 == a % 400
    }), a("isWeekend", function () {
        return 0 == this.getDay() || 6 == this.getDay()
    }), a("isWeekDay", function () {
        return !this.isWeekend()
    }), a("getDaysInMonth", function () {
        return [31, this.isLeapYear() ? 29 : 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31][this.getMonth()]
    }), a("getDayName", function (a) {
        return a ? Date.abbrDayNames[this.getDay()] : Date.dayNames[this.getDay()]
    }), a("getMonthName", function (a) {
        return a ? Date.abbrMonthNames[this.getMonth()] : Date.monthNames[this.getMonth()]
    }), a("getDayOfYear", function () {
        var a = new Date("1/1/" + this.getFullYear());
        return Math.floor((this.getTime() - a.getTime()) / 864e5)
    }), a("getWeekOfYear", function () {
        return Math.ceil(this.getDayOfYear() / 7)
    }), a("setDayOfYear", function (a) {
        return this.setMonth(0), this.setDate(a), this
    }), a("addYears", function (a) {
        return this.setFullYear(this.getFullYear() + a), this
    }), a("addMonths", function (a) {
        var b = this.getDate();
        return this.setMonth(this.getMonth() + a), b > this.getDate() && this.addDays(-this.getDate()), this
    }), a("addDays", function (a) {
        return this.setTime(this.getTime() + 864e5 * a), this
    }), a("addHours", function (a) {
        return this.setHours(this.getHours() + a), this
    }), a("addMinutes", function (a) {
        return this.setMinutes(this.getMinutes() + a), this
    }), a("addSeconds", function (a) {
        return this.setSeconds(this.getSeconds() + a), this
    }), a("zeroTime", function () {
        return this.setMilliseconds(0), this.setSeconds(0), this.setMinutes(0), this.setHours(0), this
    }), a("asString", function (a) {
        var c = a || Date.format;
        return c.split("yyyy").join(this.getFullYear()).split("yy").join((this.getFullYear() + "").substring(2)).split("mmmm").join(this.getMonthName(!1)).split("mmm").join(this.getMonthName(!0)).split("mm").join(b(this.getMonth() + 1)).split("dd").join(b(this.getDate())).split("hh").join(b(this.getHours())).split("min").join(b(this.getMinutes())).split("ss").join(b(this.getSeconds()))
    }), Date.fromString = function (a, b) {
        var c = b || Date.format,
            d = new Date("01/01/1977"),
            e = 0,
            f = c.indexOf("mmmm");
        if (f > -1) {
            for (var g = 0; Date.monthNames.length > g; g++) {
                var h = a.substr(f, Date.monthNames[g].length);
                if (Date.monthNames[g] == h) {
                    e = Date.monthNames[g].length - 4;
                    break
                }
            }
            d.setMonth(g)
        } else if (f = c.indexOf("mmm"), f > -1) {
            for (var h = a.substr(f, 3), g = 0; Date.abbrMonthNames.length > g && Date.abbrMonthNames[g] != h; g++);
            d.setMonth(g)
        } else d.setMonth(Number(a.substr(c.indexOf("mm"), 2)) - 1);
        var i = c.indexOf("yyyy");
        i > -1 ? (i > f && (i += e), d.setFullYear(Number(a.substr(i, 4)))) : (i > f && (i += e), d.setFullYear(Number(Date.fullYearStart + a.substr(c.indexOf("yy"), 2))));
        var j = c.indexOf("dd");
        return j > f && (j += e), d.setDate(Number(a.substr(j, 2))), isNaN(d.getTime()) ? !1 : d
    };
    var b = function (a) {
        var b = "0" + a;
        return b.substring(b.length - 2)
    }
}(),
function (a) {
    function c(a) {
        this.ele = a, this.displayedMonth = null, this.displayedYear = null, this.startDate = null, this.endDate = null, this.showYearNavigation = null, this.closeOnSelect = null, this.displayClose = null, this.rememberViewedMonth = null, this.selectMultiple = null, this.numSelectable = null, this.numSelected = null, this.verticalPosition = null, this.horizontalPosition = null, this.verticalOffset = null, this.horizontalOffset = null, this.button = null, this.renderCallback = [], this.selectedDates = {}, this.inline = null, this.context = "#dp-popup", this.settings = {}
    }
    function d(b) {
        return b._dpId ? a.event._dpCache[b._dpId] : !1
    }
    a.fn.extend({
        renderCalendar: function (b) {
            var c = function (a) {
                return document.createElement(a)
            };
            if (b = a.extend({}, a.fn.datePicker.defaults, b), b.showHeader != a.dpConst.SHOW_HEADER_NONE) for (var d = a(c("tr")), e = Date.firstDayOfWeek; Date.firstDayOfWeek + 7 > e; e++) {
                    var f = e % 7,
                        g = Date.dayNames[f];
                    d.append(jQuery(c("th")).attr({
                        scope: "col",
                        abbr: g,
                        title: g,
                        "class": 0 == f || 6 == f ? "weekend" : "weekday"
                    }).html(b.showHeader == a.dpConst.SHOW_HEADER_SHORT ? g.substr(0, 1) : g))
            }
            var h = a(c("table")).attr({
                cellspacing: 2
            }).addClass("jCalendar").append(b.showHeader != a.dpConst.SHOW_HEADER_NONE ? a(c("thead")).append(d) : c("thead")),
                i = a(c("tbody")),
                j = (new Date).zeroTime();
            j.setHours(12);
            var k = void 0 == b.month ? j.getMonth() : b.month,
                l = b.year || j.getFullYear(),
                m = new Date(l, k, 1, 12, 0, 0),
                n = Date.firstDayOfWeek - m.getDay() + 1;
            n > 1 && (n -= 7);
            var o = Math.ceil((-1 * n + 1 + m.getDaysInMonth()) / 7);
            m.addDays(n - 1);
            for (var p = function (c) {
                return function () {
                    if (b.hoverClass) {
                        var d = a(this);
                        b.selectWeek ? c && !d.is(".disabled") && d.parent().addClass("activeWeekHover") : d.addClass(b.hoverClass)
                    }
                }
            }, q = function () {
                    if (b.hoverClass) {
                        var c = a(this);
                        c.removeClass(b.hoverClass), c.parent().removeClass("activeWeekHover")
                    }
                }, r = 0; o > r++;) {
                for (var s = jQuery(c("tr")), t = b.dpController ? m > b.dpController.startDate : !1, e = 0; 7 > e; e++) {
                    var u = m.getMonth() == k,
                        v = a(c("td")).text(m.getDate() + "").addClass((u ? "current-month " : "other-month ") + (m.isWeekend() ? "weekend " : "weekday ") + (u && m.getTime() == j.getTime() ? "today " : "")).data("datePickerDate", m.asString()).hover(p(t), q);
                    s.append(v), b.renderCallback && b.renderCallback(v, m, k, l), m = new Date(m.getFullYear(), m.getMonth(), m.getDate() + 1, 12, 0, 0)
                }
                i.append(s)
            }
            return h.append(i), this.each(function () {
                a(this).empty().append(h)
            })
        },
        datePicker: function (b) {
            return a.event._dpCache || (a.event._dpCache = []), b = a.extend({}, a.fn.datePicker.defaults, b), this.each(function () {
                var d = a(this),
                    e = !0;
                this._dpId || (this._dpId = a.guid++, a.event._dpCache[this._dpId] = new c(this), e = !1), b.inline && (b.createButton = !1, b.displayClose = !1, b.closeOnSelect = !1, d.empty());
                var f = a.event._dpCache[this._dpId];
                if (f.init(b), !e && b.createButton && (f.button = a('<a href="#" class="dp-choose-date" title="' + a.dpText.TEXT_CHOOSE_DATE + '">' + a.dpText.TEXT_CHOOSE_DATE + "</a>").bind("click", function () {
                    return d.dpDisplay(this), this.blur(), !1
                }), d.after(f.button)), !e && d.is(":text")) {
                    d.bind("dateSelected", function (a, b) {
                        this.value = b.asString()
                    }).bind("change", function () {
                        if ("" == this.value) f.clearSelected();
                        else {
                            var a = Date.fromString(this.value);
                            a && f.setSelected(a, !0, !0)
                        }
                    }), b.clickInput && d.bind("click", function () {
                        d.trigger("change"), d.dpDisplay()
                    });
                    var g = Date.fromString(this.value);
                    "" != this.value && g && f.setSelected(g, !0, !0)
                }
                d.addClass("dp-applied")
            })
        },
        dpSetDisabled: function (a) {
            return b.call(this, "setDisabled", a)
        },
        dpSetStartDate: function (a) {
            return b.call(this, "setStartDate", a)
        },
        dpSetEndDate: function (a) {
            return b.call(this, "setEndDate", a)
        },
        dpGetSelected: function () {
            var a = d(this[0]);
            return a ? a.getSelected() : null
        },
        dpSetSelected: function (a, c, d, e) {
            return void 0 == c && (c = !0), void 0 == d && (d = !0), void 0 == e && (e = !0), b.call(this, "setSelected", Date.fromString(a), c, d, e)
        },
        dpSetDisplayedMonth: function (a, c) {
            return b.call(this, "setDisplayedMonth", Number(a), Number(c), !0)
        },
        dpDisplay: function (a) {
            return b.call(this, "display", a)
        },
        dpSetRenderCallback: function (a) {
            return b.call(this, "setRenderCallback", a)
        },
        dpSetPosition: function (a, c) {
            return b.call(this, "setPosition", a, c)
        },
        dpSetOffset: function (a, c) {
            return b.call(this, "setOffset", a, c)
        },
        dpClose: function () {
            return b.call(this, "_closeCalendar", !1, this[0])
        },
        dpRerenderCalendar: function () {
            return b.call(this, "_rerenderCalendar")
        },
        _dpDestroy: function () {}
    });
    var b = function (a, b, c, e, f) {
        return this.each(function () {
            var g = d(this);
            g && g[a](b, c, e, f)
        })
    };
    a.extend(c.prototype, {
        init: function (a) {
            this.setStartDate(a.startDate), this.setEndDate(a.endDate), this.setDisplayedMonth(Number(a.month), Number(a.year)), this.setRenderCallback(a.renderCallback), this.showYearNavigation = a.showYearNavigation, this.closeOnSelect = a.closeOnSelect, this.displayClose = a.displayClose, this.rememberViewedMonth = a.rememberViewedMonth, this.selectMultiple = a.selectMultiple, this.numSelectable = a.selectMultiple ? a.numSelectable : 1, this.numSelected = 0, this.verticalPosition = a.verticalPosition, this.horizontalPosition = a.horizontalPosition, this.hoverClass = a.hoverClass, this.setOffset(a.verticalOffset, a.horizontalOffset), this.inline = a.inline, this.settings = a, this.inline && (this.context = this.ele, this.display())
        },
        setStartDate: function (a) {
            a && (this.startDate = Date.fromString(a)), this.startDate || (this.startDate = (new Date).zeroTime()), this.setDisplayedMonth(this.displayedMonth, this.displayedYear)
        },
        setEndDate: function (a) {
            a && (this.endDate = Date.fromString(a)), this.endDate || (this.endDate = new Date("12/31/2999")), this.endDate.getTime() < this.startDate.getTime() && (this.endDate = this.startDate), this.setDisplayedMonth(this.displayedMonth, this.displayedYear)
        },
        setPosition: function (a, b) {
            this.verticalPosition = a, this.horizontalPosition = b
        },
        setOffset: function (a, b) {
            this.verticalOffset = parseInt(a) || 0, this.horizontalOffset = parseInt(b) || 0
        },
        setDisabled: function (b) {
            $e = a(this.ele), $e[b ? "addClass" : "removeClass"]("dp-disabled"), this.button && ($but = a(this.button), $but[b ? "addClass" : "removeClass"]("dp-disabled"), $but.attr("title", b ? "" : a.dpText.TEXT_CHOOSE_DATE)), $e.is(":text") && $e.attr("disabled", b ? "disabled" : "")
        },
        setDisplayedMonth: function (b, c, d) {
            if (void 0 != this.startDate && void 0 != this.endDate) {
                var e = new Date(this.startDate.getTime());
                e.setDate(1);
                var f = new Date(this.endDate.getTime());
                f.setDate(1);
                var g;
                !b && !c || isNaN(b) && isNaN(c) ? (g = (new Date).zeroTime(), g.setDate(1)) : g = isNaN(b) ? new Date(c, this.displayedMonth, 1) : isNaN(c) ? new Date(this.displayedYear, b, 1) : new Date(c, b, 1), g.getTime() < e.getTime() ? g = e : g.getTime() > f.getTime() && (g = f);
                var h = this.displayedMonth,
                    i = this.displayedYear;
                this.displayedMonth = g.getMonth(), this.displayedYear = g.getFullYear(), !d || this.displayedMonth == h && this.displayedYear == i || (this._rerenderCalendar(), a(this.ele).trigger("dpMonthChanged", [this.displayedMonth, this.displayedYear]))
            }
        },
        setSelected: function (b, c, d, e) {
            if (!(this.startDate > b || b.zeroTime() > this.endDate.zeroTime())) {
                var f = this.settings;
                if (!(f.selectWeek && (b = b.addDays(-(b.getDay() - Date.firstDayOfWeek + 7) % 7), this.startDate > b)) && c != this.isSelected(b)) {
                    if (0 == this.selectMultiple) this.clearSelected();
                    else if (c && this.numSelected == this.numSelectable) return;
                    !d || this.displayedMonth == b.getMonth() && this.displayedYear == b.getFullYear() || this.setDisplayedMonth(b.getMonth(), b.getFullYear(), !0), this.selectedDates[b.asString()] = c, this.numSelected += c ? 1 : -1;
                    var h, g = "td." + (b.getMonth() == this.displayedMonth ? "current-month" : "other-month");
                    if (a(g, this.context).each(function () {
                        a(this).data("datePickerDate") == b.asString() && (h = a(this), f.selectWeek && h.parent()[c ? "addClass" : "removeClass"]("selectedWeek"), h[c ? "addClass" : "removeClass"]("selected"))
                    }), a("td", this.context).not(".selected")[this.selectMultiple && this.numSelected == this.numSelectable ? "addClass" : "removeClass"]("unselectable"), e) {
                        var f = this.isSelected(b);
                        $e = a(this.ele);
                        var i = Date.fromString(b.asString());
                        $e.trigger("dateSelected", [i, h, f]), $e.trigger("change")
                    }
                }
            }
        },
        isSelected: function (a) {
            return this.selectedDates[a.asString()]
        },
        getSelected: function () {
            var a = [];
            for (var b in this.selectedDates) 1 == this.selectedDates[b] && a.push(Date.fromString(b));
            return a
        },
        clearSelected: function () {
            this.selectedDates = {}, this.numSelected = 0, a("td.selected", this.context).removeClass("selected").parent().removeClass("selectedWeek")
        },
        display: function (b) {
            if (!a(this.ele).is(".dp-disabled")) {
                b = b || this.ele;
                var f, g, i, c = this,
                    d = a(b),
                    e = d.offset();
                if (c.inline) f = a(this.ele), g = {
                        id: "calendar-" + this.ele._dpId,
                        "class": "dp-popup dp-popup-inline"
                }, a(".dp-popup", f).remove(), i = {};
                else {
                    f = a("body"), g = {
                        id: "dp-popup",
                        "class": "dp-popup"
                    }, i = {
                        top: e.top + c.verticalOffset,
                        left: e.left + c.horizontalOffset
                    };
                    var j = function (b) {
                        for (var d = b.target, e = a("#dp-popup")[0];;) {
                            if (d == e) return !0;
                            if (d == document) return c._closeCalendar(), !1;
                            d = a(d).parent()[0]
                        }
                    };
                    this._checkMouse = j, c._closeCalendar(!0), a(document).bind("keydown.datepicker", function (a) {
                        27 == a.keyCode && c._closeCalendar()
                    })
                } if (!c.rememberViewedMonth) {
                    var k = this.getSelected()[0];
                    k && (k = new Date(k), this.setDisplayedMonth(k.getMonth(), k.getFullYear(), !1))
                }
                f.append(a("<div></div>").attr(g).css(i).append(a("<h2></h2>"), a('<div class="dp-nav-prev"></div>').append(a('<a class="dp-nav-prev-year" href="#" title="' + a.dpText.TEXT_PREV_YEAR + '">&lt;&lt;</a>').bind("click", function () {
                    return c._displayNewMonth.call(c, this, 0, -1)
                }), a('<a class="dp-nav-prev-month" href="#" title="' + a.dpText.TEXT_PREV_MONTH + '">&lt;</a>').bind("click", function () {
                    return c._displayNewMonth.call(c, this, -1, 0)
                })), a('<div class="dp-nav-next"></div>').append(a('<a class="dp-nav-next-year" href="#" title="' + a.dpText.TEXT_NEXT_YEAR + '">&gt;&gt;</a>').bind("click", function () {
                    return c._displayNewMonth.call(c, this, 0, 1)
                }), a('<a class="dp-nav-next-month" href="#" title="' + a.dpText.TEXT_NEXT_MONTH + '">&gt;</a>').bind("click", function () {
                    return c._displayNewMonth.call(c, this, 1, 0)
                })), a('<div class="dp-calendar"></div>')).bgIframe());
                var l = this.inline ? a(".dp-popup", this.context) : a("#dp-popup");
                0 == this.showYearNavigation && a(".dp-nav-prev-year, .dp-nav-next-year", c.context).css("display", "none"), this.displayClose && l.append(a('<a href="#" id="dp-close">' + a.dpText.TEXT_CLOSE + "</a>").bind("click", function () {
                    return c._closeCalendar(), !1
                })), c._renderCalendar(), a(this.ele).trigger("dpDisplayed", l), c.inline || (this.verticalPosition == a.dpConst.POS_BOTTOM && l.css("top", e.top + d.height() - l.height() + c.verticalOffset), this.horizontalPosition == a.dpConst.POS_RIGHT && l.css("left", e.left + d.width() - l.width() + c.horizontalOffset), a(document).bind("mousedown.datepicker", this._checkMouse))
            }
        },
        setRenderCallback: function (a) {
            null != a && (a && "function" == typeof a && (a = [a]), this.renderCallback = this.renderCallback.concat(a))
        },
        cellRender: function (b, c) {
            var f = this.dpController,
                g = new Date(c.getTime());
            b.bind("click", function () {
                var b = a(this);
                if (!b.is(".disabled") && (f.setSelected(g, !b.is(".selected") || !f.selectMultiple, !1, !0), f.closeOnSelect)) {
                    if (f.settings.autoFocusNextInput) {
                        var c = f.ele,
                            d = !1;
                        a(":input", c.form).each(function () {
                            return d ? (a(this).focus(), !1) : (this == c && (d = !0), void 0)
                        })
                    } else f.ele.focus();
                    f._closeCalendar()
                }
            }), f.isSelected(g) ? (b.addClass("selected"), f.settings.selectWeek && b.parent().addClass("selectedWeek")) : f.selectMultiple && f.numSelected == f.numSelectable && b.addClass("unselectable")
        },
        _applyRenderCallbacks: function () {
            var b = this;
            a("td", this.context).each(function () {
                for (var c = 0; b.renderCallback.length > c; c++) $td = a(this), b.renderCallback[c].apply(this, [$td, Date.fromString($td.data("datePickerDate")), b.displayedMonth, b.displayedYear])
            })
        },
        _displayNewMonth: function (b, c, d) {
            return a(b).is(".disabled") || this.setDisplayedMonth(this.displayedMonth + c, this.displayedYear + d, !0), b.blur(), !1
        },
        _rerenderCalendar: function () {
            this._clearCalendar(), this._renderCalendar()
        },
        _renderCalendar: function () {
            if (a("h2", this.context).html(new Date(this.displayedYear, this.displayedMonth, 1).asString(a.dpText.HEADER_FORMAT)), a(".dp-calendar", this.context).renderCalendar(a.extend({}, this.settings, {
                month: this.displayedMonth,
                year: this.displayedYear,
                renderCallback: this.cellRender,
                dpController: this,
                hoverClass: this.hoverClass
            })), this.displayedYear == this.startDate.getFullYear() && this.displayedMonth == this.startDate.getMonth()) {
                a(".dp-nav-prev-year", this.context).addClass("disabled"), a(".dp-nav-prev-month", this.context).addClass("disabled"), a(".dp-calendar td.other-month", this.context).each(function () {
                    var b = a(this);
                    Number(b.text()) > 20 && b.addClass("disabled")
                });
                var b = this.startDate.getDate();
                a(".dp-calendar td.current-month", this.context).each(function () {
                    var c = a(this);
                    b > Number(c.text()) && c.addClass("disabled")
                })
            } else {
                a(".dp-nav-prev-year", this.context).removeClass("disabled"), a(".dp-nav-prev-month", this.context).removeClass("disabled");
                var b = this.startDate.getDate();
                if (b > 20) {
                    var c = this.startDate.getTime(),
                        d = new Date(c);
                    d.addMonths(1), this.displayedYear == d.getFullYear() && this.displayedMonth == d.getMonth() && a(".dp-calendar td.other-month", this.context).each(function () {
                        var b = a(this);
                        c > Date.fromString(b.data("datePickerDate")).getTime() && b.addClass("disabled")
                    })
                }
            } if (this.displayedYear == this.endDate.getFullYear() && this.displayedMonth == this.endDate.getMonth()) {
                a(".dp-nav-next-year", this.context).addClass("disabled"), a(".dp-nav-next-month", this.context).addClass("disabled"), a(".dp-calendar td.other-month", this.context).each(function () {
                    var b = a(this);
                    14 > Number(b.text()) && b.addClass("disabled")
                });
                var b = this.endDate.getDate();
                a(".dp-calendar td.current-month", this.context).each(function () {
                    var c = a(this);
                    Number(c.text()) > b && c.addClass("disabled")
                })
            } else {
                a(".dp-nav-next-year", this.context).removeClass("disabled"), a(".dp-nav-next-month", this.context).removeClass("disabled");
                var b = this.endDate.getDate();
                if (13 > b) {
                    var e = new Date(this.endDate.getTime());
                    e.addMonths(-1), this.displayedYear == e.getFullYear() && this.displayedMonth == e.getMonth() && a(".dp-calendar td.other-month", this.context).each(function () {
                        var c = a(this),
                            d = Number(c.text());
                        13 > d && d > b && c.addClass("disabled")
                    })
                }
            }
            this._applyRenderCallbacks()
        },
        _closeCalendar: function (b, c) {
            c && c != this.ele || (a(document).unbind("mousedown.datepicker"), a(document).unbind("keydown.datepicker"), this._clearCalendar(), a("#dp-popup a").unbind(), a("#dp-popup").empty().remove(), b || a(this.ele).trigger("dpClosed", [this.getSelected()]))
        },
        _clearCalendar: function () {
            a(".dp-calendar td", this.context).unbind(), a(".dp-calendar", this.context).empty()
        }
    }), a.dpConst = {
        SHOW_HEADER_NONE: 0,
        SHOW_HEADER_SHORT: 1,
        SHOW_HEADER_LONG: 2,
        POS_TOP: 0,
        POS_BOTTOM: 1,
        POS_LEFT: 0,
        POS_RIGHT: 1,
        DP_INTERNAL_FOCUS: "dpInternalFocusTrigger"
    }, a.dpText = {
        TEXT_PREV_YEAR: "Previous year",
        TEXT_PREV_MONTH: "Previous month",
        TEXT_NEXT_YEAR: "Next year",
        TEXT_NEXT_MONTH: "Next month",
        TEXT_CLOSE: "Close",
        TEXT_CHOOSE_DATE: "Choose date",
        HEADER_FORMAT: "mmmm yyyy"
    }, a.dpVersion = "$Id: jquery.datePicker.js 102 2010-09-13 14:00:54Z kelvin.luck $", a.fn.datePicker.defaults = {
        month: void 0,
        year: void 0,
        showHeader: a.dpConst.SHOW_HEADER_SHORT,
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
        verticalPosition: a.dpConst.POS_TOP,
        horizontalPosition: a.dpConst.POS_LEFT,
        verticalOffset: 0,
        horizontalOffset: 0,
        hoverClass: "dp-hover",
        autoFocusNextInput: !1
    }, void 0 == a.fn.bgIframe && (a.fn.bgIframe = function () {
        return this
    }), a(window).bind("unload", function () {
        var b = a.event._dpCache || [];
        for (var c in b) a(b[c].ele)._dpDestroy()
    })
}(jQuery), jQuery.fn.pagination = function (a, b) {
    function d() {
        var d = Math.ceil(b.num_display_entries / 2),
            e = a,
            f = e - b.num_display_entries,
            g = c > d ? Math.max(Math.min(c - d, f), 0) : 0,
            h = c > d ? Math.min(c + d, e) : Math.min(b.num_display_entries, e);
        return [g, h]
    }
    function e(a, d) {
        c = a, g();
        var e = b.callback(a);
        return e || (d.stopPropagation ? d.stopPropagation() : d.cancelBubble = !0), e
    }
    function g() {
        f.each(function () {
            var f = jQuery(this);
            f.empty();
            var g = d(),
                h = a,
                i = function (a) {
                    return function (b) {
                        return e(a, b)
                    }
                }, j = function (a, d) {
                    if (a = 0 > a ? 0 : h > a ? a : h - 1, d = jQuery.extend({
                        text: a + 1,
                        classes: ""
                    }, d || {}), a == c) var e = jQuery("<span class='current'>" + d.text + "</span>");
                    else var e = jQuery("<a>" + d.text + "</a>").bind("click", i(a)).attr("href", b.link_to.replace(/__id__/, a));
                    d.classes && e.addClass(d.classes), f.append(e)
                };
            if (b.prev_text && (c > 0 || b.prev_show_always) && j(c - 1, {
                text: b.prev_text,
                classes: "prev"
            }), g[0] > 0 && b.num_edge_entries > 0) {
                for (var k = Math.min(b.num_edge_entries, g[0]), l = 0; k > l; l++) j(l);
                b.num_edge_entries < g[0] && b.ellipse_text && jQuery("<span>" + b.ellipse_text + "</span>").appendTo(f)
            }
            for (var l = g[0]; g[1] > l; l++) j(l);
            if (h > g[1] && b.num_edge_entries > 0) {
                h - b.num_edge_entries > g[1] && b.ellipse_text && jQuery("<span>" + b.ellipse_text + "</span>").appendTo(f);
                for (var m = Math.max(h - b.num_edge_entries, g[1]), l = m; h > l; l++) j(l)
            }
            b.next_text && (h - 1 > c || b.next_show_always) && j(c + 1, {
                text: b.next_text,
                classes: "next"
            })
        })
    }
    if (jQuery.fn.pagination.setPage = function (a) {
        c = parseInt(a), g()
    }, void 0 != a && 0 != a) {
        b = jQuery.extend({
            num_display_entries: 4,
            current_page: 0,
            num_edge_entries: 1,
            link_to: "#",
            prev_text: "&lt;",
            next_text: "&gt;",
            ellipse_text: "...",
            prev_show_always: !1,
            next_show_always: !1,
            callback: function (a) {
                return $("#updater").addLoader(), $("#checkall").attr("checked", !1), $.post($("#currentlist").attr("href"), {
                    page: a
                }, function (b) {
                    var c = parse_response(b);
                    c && ($("#updater").html(c), $(".check").unbind("click"), $(".currentpage").val(a), $(".check").click(checkEl))
                }), !1
            }
        }, b || {});
        var c = b.current_page;
        a = !a || 0 > a ? 1 : a, b.items_per_page = !b.items_per_page || 0 > b.items_per_page ? 1 : b.items_per_page;
        var f = this;
        g(), 0 != c && b.callback(c)
    }
},
function (a) {
    a.event.special.textchange = {
        setup: function () {
            a(this).bind("keyup.textchange", a.event.special.textchange.handler), a(this).bind("cut.textchange paste.textchange input.textchange", a.event.special.textchange.delayedHandler)
        },
        teardown: function () {
            a(this).unbind(".textchange")
        },
        handler: function () {
            a.event.special.textchange.triggerIfChanged(a(this))
        },
        delayedHandler: function () {
            var b = a(this);
            setTimeout(function () {
                a.event.special.textchange.triggerIfChanged(b)
            }, 25)
        },
        triggerIfChanged: function (a) {
            var b = a.attr("contenteditable") ? a.html() : a.val();
            b !== a.data("lastValue") && (a.trigger("textchange", a.data("lastValue")), a.data("lastValue", b))
        }
    }
}(jQuery), $.fn.serializeObject = function () {
    var a = {}, b = this.serializeArray();
    return $.each(b, function () {
        void 0 !== a[this.name] ? (a[this.name].push || (a[this.name] = [a[this.name]]), a[this.name].push(this.value || "")) : a[this.name] = this.value || ""
    }), a
}, $.extend($.fn, {
    vTip: function () {
        var b = 5,
            c = 2;
        $(this).not(".vtip_applied").hover(function (a) {
            this.t = this.title, this.title = "", this.top = a.pageY + c, this.left = a.pageX + b, $("body").append('<p id="vtip">' + this.t + "</p>"), $("p#vtip").css("top", this.top + "px").css("left", this.left + "px").fadeIn("fast")
        }, function () {
            this.title = this.t, $("p#vtip").hide().remove()
        }).addClass("vtip_applied")
    },
    slideToElement: function (a) {
        var b = $("a[name=" + a + "]");
        if (b.length) {
            var c = b.offset().top;
            return $("html,body").animate({
                scrollTop: c - 100
            }, 500, "linear", function () {}), !1
        }
    },
    dropdownMenu: function (a, b) {
        void 0 == a.movement && (a.movement = 3);
        var c = $(this);
        return $(this).each(function () {
            var d = $(this).attr("id") + "_m",
                e = $(this);
            $("#" + d).addClass("contextMenu"), $(this).mousedown(function (f) {
                var g = f;
                $(this).mouseup(function () {
                    var h = $(this);
                    if ($(this).unbind("mouseup"), 1 == g.button || 0 == g.button) {
                        $(".contextMenu").hide();
                        var i = $("#" + d);
                        if ($(e).hasClass("disabled")) return !1;
                        c.removeClass("activated"), $(e).addClass("activated");
                        var k, l, m = $(e).position(),
                            n = $(e).height();
                        k = m.left, l = n + m.top + a.movement, $(document).unbind("click");
                        var o = $(i).css({
                            top: l,
                            left: k
                        }).show().outerHeight(),
                            p = $(e).offset().top + o + $(e).outerHeight() + a.movement;
                        p > $(window).height() && $(i).css({
                            top: -o + m.top + a.movement
                        }), $(i).find("A").mouseover(function () {
                            $(i).find("LI.hover").removeClass("hover"), $(this).parent().addClass("hover")
                        }).mouseout(function () {
                            $(i).find("LI.hover").removeClass("hover")
                        }), $(document).keypress(function (a) {
                            switch (a.keyCode) {
                            case 13:
                                $(i).find("LI.hover A").trigger("click");
                                break;
                            case 27:
                                $(document).trigger("click")
                            }
                        }), $("#" + d).find("A").unbind("click"), $("#" + d).find("LI:not(.disabled) A:not(.directly)").click(function () {
                            return $(document).unbind("click").unbind("keypress"), $(this).unbind("click").unbind("keypress"), $(".contextMenu").hide(), c.removeClass("activated"), b && b($(this).attr("href"), $(h), {
                                x: k - m.left,
                                y: l - m.top,
                                docX: k,
                                docY: l
                            }, $(this).html()), !1
                        }), $("#" + d).find("LI:not(.disabled) A.directly").click(function () {
                            return $(document).trigger("click"), !0
                        }), setTimeout(function () {
                            $(document).click(function () {
                                return $(document).unbind("click").unbind("keypress"), $(this).unbind("click").unbind("keypress"), $(i).hide(), c.removeClass("activated"), !1
                            })
                        }, 0)
                    }
                })
            })
        }), $(this)
    },
    SmartSearch: function (a) {
        var c = {
            target: "#smartres",
            url: "?cmd=search&lightweight=1",
            submitel: "#search_submiter",
            results: "#smartres-results",
            container: "#search_form_container"
        };
        return a = $.extend({}, c, a || {}), $(this).each(function () {
            var b = $(this),
                c = $(b).offset(),
                d = $(b).height(),
                e = c.left,
                f = d + c.top + 4;
            $(b).position().left, $(b).position().top + 4 + d;
            var i = $(window).width() - (e + b.outerWidth());
            $(a.target).css({
                top: f,
                right: i
            }), $(a.submitel).click(function () {
                return $(this).addClass("search_loading"), $.post(a.url, {
                    query: b.val()
                }, function (c) {
                    $(a.submitel).removeClass("search_loading");
                    var d = parse_response(c);
                    d !== !1 && "string" == typeof d ? b.SmartSearchShow(d, b.val(), a) : b.SmartSearchHide(a)
                }), !1
            }), $(this).keydown(function (b) {
                13 == b.keyCode && $(a.submitel).click()
            })
        }), $(this)
    },
    ShowNicely: function () {
        var a = $(this);
        return a.addClass("shownice").show(), setTimeout(function () {
            $(a).removeClass("shownice")
        }, 1e3, a), $(this)
    },
    scrollToEl: function () {
        if ($(this).length) {
            var a = $(this).offset().top;
            $("html,body").animate({
                scrollTop: a - 100
            }, 500, "linear", function () {})
        }
        return $(this)
    },
    SmartSearchHide: function (a) {
        return $(a.target).fadeOut("fast", function () {
            $(a.results).html("")
        }), $(a.container).removeClass("resultsin"), $(this)
    },
    SmartSearchShow: function (a, b, c) {
        $(c.results).html(a);
        var d = b.split(" ");
        for (var e in d) $("li.result", c.results).highlight(d[e].replace("*", ""), {
                className: "h"
            });
        $(c.container).addClass("resultsin"), $(c.target).fadeIn("fast");
        var f = $(this);
        return $(document).click(function () {
            return $(document).unbind("click"), f.SmartSearchHide(c), !1
        }), $("a", c.target).click(function () {
            return !0
        }).mousedown(function (a) {
            return a.stopPropagation(), 2 == a.which && (a.preventDefault(), $(this).attr("target", "_blank").click().removeAttr("target")), $(this).click(), !0
        }), $(this)
    },
    HoverMenu: function () {
        return $(this).each(function (a) {
            var b = $(this),
                c = b.offset(),
                d = b.height(),
                e = c.left,
                f = d + c.top;
            $(".submenu", "#menushelf").eq(a).css({
                top: f,
                left: e
            }), b.hover(function () {
                $(this).HoverMenuShow(a)
            }, function () {
                $(this).HoverTimer()
            })
        }), $(".submenu", "#menushelf").hover(function () {
            $(this).HoverCancelTimer()
        }, function () {
            $(this).HoverMenuHide()
        }), $(this)
    },
    TabbedMenu: function (a) {
        var b = a.elem ? a.elem : ".tabb",
            c = a.picker ? a.picker : "a.tchoice",
            d = a.aclass ? a.aclass : "picked",
            e = a.picked ? parseInt(a.picked) : 0,
            f = a.picker_id ? a.picker_id : "picked_tab",
            g = $(this);
        return $(b).hide(), $(b).eq(e).show(), $("" + c + ":not(.directlink)").eq(e).addClass(d), g.find("#" + f).length || a.picktab || g.append('<input type="hidden" value="' + e + '" name="' + f + '" id="' + f + '"/>'), g.find("" + c + ":not(.directlink)").each(function (e) {
            $(this).click(function () {
                return $(this).hasClass("disabled") ? !1 : (a.picktab || g.find("#" + f).val(e), $(b).hide(), $(b).eq(e).show(), $("" + c).removeClass(d), $(this).addClass(d), $(this).find("span.notification").length && $(this).find("span.notification").removeClass("notification"), !1)
            })
        }), $(this)
    },
    HoverMenuHide: function () {
        return $(".mainmenu", "#mmcontainer").removeClass("active"), $(".submenu", "#menushelf").hide(), $(this)
    },
    HoverMenuShow: function (a) {
        var b = $(this);
        return b.HoverCancelTimer(), $(".submenu", "#menushelf").hide(), $(".mainmenu", "#mmcontainer").removeClass("active"), $(".submenu", "#menushelf").eq(a).show(), b.addClass("active"), $(this)
    },
    HoverTimer: function () {
        return timing = setTimeout(function () {
            $(".mainmenu", "#mmcontainer").removeClass("active"), $(".submenu", "#menushelf").hide()
        }, 200), $(this)
    },
    HoverCancelTimer: function () {
        return timing && (clearTimeout(timing), timing = null), $(this)
    },
    taskMgr: function () {
        return $(this).each(function () {
            $(this).taskMgrCountEI();
            var a = $(this);
            a.find("span.progress").progressBar(0, {
                max: maximum
            }).addClass("hidden").hide(), a.find("a.showlog").hide(), a.find("a.showlog").mouseover(function () {
                return a.taskMgrShow(), $(this).hide(), !1
            }), a.hover(function () {}, function () {
                $(this).taskMgrHide()
            }), $(this).taskMgrCheckInterval()
        }), $(this)
    },
    taskMgrCountEI: function () {
        $("LI.info", "#taskMGR").length > 0 ? $("#numinfos").html($("LI.info", "#taskMGR").length).show() : $("#numinfos").html("0"), $("LI.error", "#taskMGR").length > 0 ? $("#numerrors").html($("LI.error", "#taskMGR").length).show() : $("#numerrors").html("0")
    },
    taskMgrProgress: function (a) {
        var b = $(this);
        b.taskMgrCheckVisibility();
        var c = $(this).find("span.progress");
        return 0 == parseInt(a) ? (c.progressBar(maximum).fadeOut("fast", function () {
            b.taskMgrCheckVisibility()
        }).addClass("hidden").removeClass("visible"), b.taskMgrCountEI()) : ($("#numinfos").hide(), $("#numerrors").hide(), c.hasClass("hidden") && c.removeClass("hidden").addClass("visible").fadeIn(), c.progressBar(maximum - parseInt(a), {
            max: maximum,
            callback: function (a) {
                a.max == a.running_value && (c.fadeOut().addClass("hidden").removeClass("visible"), b.taskMgrCountEI())
            }
        })), $(this)
    },
    taskMgrAddInfo: function (a) {
        var b = new Date,
            c = $(this),
            d = b.getMinutes();
        10 > d && (d = "0" + d);
        var e = "" + b.getHours() + ":" + d,
            f = parseInt($("#numinfos").html());
        return $("#numinfos").html(f + 1).show(), c.find("ul").prepend('<li class="info visible">' + e + " " + a + "<br/></li>"), c.taskMgrCheckInterval(), c.addClass("newel"), $(this)
    },
    taskMgrAddError: function (a) {
        var b = parseInt($("#numerrors").html()),
            c = new Date,
            d = $(this),
            e = c.getMinutes();
        10 > e && (e = "0" + e);
        var f = "" + c.getHours() + ":" + e;
        return $("#numerrors").html(b + 1).show(), d.find("ul").prepend('<li class="error visible">' + f + " " + a + "<br/></li>"), d.taskMgrCheckInterval(), d.addClass("newel"), $(this)
    },
    taskMgrShow: function () {
        return clearTimeout(t), t = "", $(this).addClass("taskAll").find("li").show(), $(this)
    },
    taskMgrCheckVisibility: function () {
        var a = $(this);
        return a.find("LI").length > 0 || a.find("span.progress").hasClass("visible") ? (a.find("a.showlog").show(), a.show()) : a.hide(), $(this)
    },
    taskQuickLoadShow: function () {
        return $(this).find("span.progress").hasClass("visible") || $(this).show().find(".small-load").show(), $(this)
    },
    taskQuickLoadHide: function () {
        return $(this).find(".small-load").hide(), $(this)
    },
    taskMgrHide: function () {
        var a = $(this);
        return a.removeClass("taskAll"), a.find("li.hidden").hide(), a.find("LI").length > 0 && a.find("a.showlog").show(), a.taskMgrCheckInterval()
    },
    taskMgrCheckInterval: function () {
        var a = $(this);
        a.taskMgrCheckVisibility();
        var b = a.find("LI.visible").length;
        return b > 0 ? (navigator.userAgent.match(/MSIE 6/i) && a.css({
            top: document.documentElement.scrollTop
        }), t = setTimeout(function () {
            "newel taskAll" != a.attr("class") && "taskAll" != a.attr("class") && ($(this).find("LI.visible:last").slideUp("slow", function () {
                $(this).removeClass("visible").addClass("hidden")
            }), a.taskMgrCheckInterval())
        }, 2e3)) : a.removeClass("newel"), $(this)
    },
    addLoader: function () {
        if (null === $(this).offset()) return $(this);
        var a = $(this).width(),
            b = $(this).height();
        if (a += parseInt($(this).css("padding-left"), 10) + parseInt($(this).css("padding-right"), 10), b += parseInt($(this).css("padding-top"), 10) + parseInt($(this).css("padding-bottom"), 10), $("#preloader").length > 0) $("#preloader").css({
                width: a + "px",
                height: b + "px"
            }).show();
        else {
            var c = '<div id="preloader" style="position:absolute;top:' + $(this).offset().top + "px;left:" + $(this).offset().left + "px;width:" + a + "px;height:" + b + 'px;"></div> ';
            $(this).append(c)
        }
        return $(this)
    },
    hideLoader: function () {
        return $("#preloader").hide(), $(this)
    }
}),
function (a) {
    a.extend({
        progressBar: new function () {
            this.defaults = {
                steps: 20,
                step_duration: 20,
                max: 100,
                width: 120,
                height: 12,
                callback: null,
                boxImage: "images/progressbar.gif",
                barImage: "images/progressbg_blue.gif",
                running_value: 0,
                value: 0,
                image: null
            }, this.construct = function (b, c) {
                var d = null,
                    e = null;
                return null != b && (isNaN(b) ? e = b : (d = b, null != c && (e = c))), this.each(function () {
                    function l(a) {
                        return 100 * a.running_value / a.max
                    }
                    function m(a) {
                        var b = a.barImage;
                        return b
                    }
                    var c = this,
                        f = this.config;
                    if (null != d && null != this.bar && null != this.config) this.config.value = d, null != e && (c.config = a.extend(this.config, e)), f = c.config;
                    else {
                        var g = a(this),
                            f = a.extend({}, a.progressBar.defaults, e);
                        f.id = g[0].id ? g[0].id : Math.ceil(1e5 * Math.random()), null == d && (d = g.html().replace("%", "")), f.value = d, f.running_value = 0, f.image = m(f), g.html("");
                        var h = document.createElement("img"),
                            i = document.createElement("span"),
                            j = a(h),
                            k = a(i);
                        c.bar = j, j.attr("id", f.id + "_pbImage"), k.attr("id", f.id + "_pbText"), j.attr("src", f.boxImage), j.attr("width", f.width), j.css("width", f.width + "px"), j.css("height", f.height + "px"), j.css("background-image", "url(" + f.image + ")"), j.css("background-position", -1 * f.width + "px 50%"), j.css("padding", "0"), j.css("margin", "0"), g.append(j), g.append(k)
                    }
                    f.increment = Math.round((f.value - f.running_value) / f.steps), 0 > f.increment && (f.increment *= -1), 1 > f.increment && (f.increment = 1);
                    var n = setInterval(function () {
                        var b = f.width / 100;
                        f.running_value > f.value ? f.running_value - f.increment < f.value ? f.running_value = f.value : f.running_value -= f.increment : f.running_value < f.value && (f.running_value + f.increment > f.value ? f.running_value = f.value : f.running_value += f.increment), f.running_value == f.value && clearInterval(n);
                        var e = a("#" + f.id + "_pbImage");
                        a("#" + f.id + "_pbText");
                        var h = m(f);
                        h != f.image && (e.css("background-image", "url(" + h + ")"), f.image = h), e.css("background-position", -1 * f.width + l(f) * b + "px 50%"), null != f.callback && "function" == typeof f.callback && f.callback(f), c.config = f
                    }, f.step_duration)
                })
            }
        }
    }), a.fn.extend({
        progressBar: a.progressBar.construct
    })
}(jQuery);
var initload = 0,
    loadelements = {
        tickets: !1,
        invoices: !1,
        services: !1,
        accounts: !1,
        domains: !1,
        clients: !1,
        emails: !1,
        estimates: !1,
        neworder: !1,
        loaders: Array()
    };
$(window).load(function () {
    function CSRFProtection(a) {
        var b = $('meta[name="csrf-token"]').attr("content");
        b && a.setRequestHeader("X-CSRF-Token", b)
    }
    "ajaxPrefilter" in $ ? $.ajaxPrefilter(function (a, b, c) {
        CSRFProtection(c)
    }) : $(document).ajaxSend(function (a, b) {
        CSRFProtection(b)
    }), $("#taskMGR").taskMgr(), $("#smarts").SmartSearch(), pops(), $(".fadvanced").click(function () {
        return "" == $("#hider").html() ? (ajax_update($(this).attr("href"), {}, "#hider"), $("#hider2").hide(), $("#hider").show()) : ($("#hider").show(), $("#hider2").hide()), !1
    }), $("a.tload").click(function () {
        return $(this).hasClass("tstyled") && ($("body").find("a.tload").removeClass("selected"), $(this).addClass("selected")), window.clearInterval(checkUrlInval), window.location.hash = "", ajax_update($(this).attr("href"), {}, "#bodycont"), !1
    }), bindEvents();
    var loadelements_cp = loadelements;
    loadelements_cp.tickets && bindTicketEvents(), loadelements_cp.invoices && bindInvoiceEvents(), loadelements_cp.estimates && bindEstimatesEvents(), loadelements_cp.services && bindServicesEvents(), loadelements_cp.accounts && bindAccountEvents(), loadelements_cp.domains && bindDomainEvents(), loadelements_cp.clients && bindClientEvents(), loadelements_cp.neworder && bindNewOrderEvents();
    var l1a = loadelements_cp.loaders,
        ll = l1a.length;
    if (ll > 0) {
        var i = 0;
        for (i = 0; ll > i; i++) eval(l1a[i] + "()")
    }
});
var checkUrlInval = "",
    autopoll = !0,
    ticketpoll = !1,
    HBInputTranslate = {};
HBInputTranslate.addTranslation = function (a) {
    return $.getJSON("?cmd=langedit", {
        action: "quicktag"
    }, function (b) {
        var c = $("#" + a);
        if (c.is("input")) {
            var d = c.val();
            c.val(d + "" + b.taglink)
        } else if (c.hasClass("tinyApplied")) c.tinymce().execCommand("mceInsertContent", !1, b.taglink);
        else {
            var d = c.val();
            c.val(d + "" + b.taglink)
        }
        $("#l_editor_" + a + " .translations").append('<a href="?cmd=langedit&action=bulktranslate&key=' + b.tag + '" target="_blank">' + b.taglink + "</a>"), $("#l_editor_" + a + " .translations .taag").show()
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
    convert_urls: !1
}, HBInputTranslate.tinyMCESimple = {
    theme: "advanced",
    theme_advanced_buttons1: "bold,italic,underline,separator,strikethrough,justifyleft,justifycenter,justifyright,justifyfull,bullist,numlist,undo,redo,link,unlink,code",
    theme_advanced_buttons2: "",
    skin: "o2k7",
    skin_variant: "silver",
    theme_advanced_buttons3: "",
    theme_advanced_toolbar_location: "top",
    theme_advanced_toolbar_align: "left",
    theme_advanced_statusbar_location: "bottom"
}, HBInputTranslate.editorOff = function (a, b) {
    return b = $("#" + b), $(a).parents("ul").eq(0).find("li").removeClass("active"), $(a).parent("li").addClass("active"), b.hasClass("tinyApplied") ? (b.tinymce().hide(), !1) : !1
}, HBInputTranslate.editorOn = function (a, b, c) {
    if (b = $("#" + b), $(a).parents("ul").eq(0).find("li").removeClass("active"), $(a).parent("li").addClass("active"), b.hasClass("tinyApplied")) b.addClass("tinyApplied").tinymce().show();
    else {
        var d = HBInputTranslate.tinyMCESimple;
        c && "string" != typeof c && (d = c), b.addClass("tinyApplied").tinymce(d)
    }
    return !1
},
function () {
    jQuery.event.special.destroyed = {
        remove: function (a) {
            a.handler && a.handler()
        }
    }
}(jQuery);
var Chosen = {
    inp: function (a) {
        if ("function" != typeof jQuery.fn.chosen) return $('<style type="text/css">@import url("templates/default/js/chosen/chosen.css")</style>').appendTo("head"), $.getScript("templates/default/js/chosen/chosen.min.js", function () {
                return Chosen.inp(a), !1
            }), !1;
        a.append('<option class="loader" value="">Loading..</option>');
        var b = a.attr("default");
        if ($.get("?cmd=clients&action=json", function (c) {
            if (void 0 != c.list) {
                for (var d = 0; c.list.length > d; d++) {
                    var e = c.list[d][3].length ? c.list[d][3] : c.list[d][1] + " " + c.list[d][2],
                        f = b == c.list[d][0] ? 'selected="selected"' : "";
                    a.append('<option value="' + c.list[d][0] + '" ' + f + ">#" + c.list[d][0] + " " + e + "</option>")
                }
                a.trigger("liszt:updated")
            }
        }), !a.hasClass("chzn-done")) {
            var c = !1,
                d = !1;
            a.is(":visible") || (d = a.wrap("<span></span>").parent(), c = $('<div style="position:abolute"></div>').appendTo("body"), a.detach().appendTo(c).show()), a.addClass("chzn-css-loaded").find(".loader").remove();
            var e = setInterval(function () {
                "pointer" === a.css("cursor") && (clearInterval(e), a.removeClass("chzn-css-loaded").chosen(), c && (c.children().detach().appendTo(d), a.unwrap(), c.remove()))
            }, 50)
        }
    },
    recovery: function (a, b) {
        a.bind("destroyed", function () {
            setTimeout(function () {
                var a = $("select[load]").eq(b);
                Chosen.recovery(a, b), Chosen.inp(a)
            }, 60)
        })
    },
    find: function (a, b) {
        void 0 != a ? (Chosen.recovery(a, b), Chosen.inp(a)) : $("select[load]").each(function (a) {
            var b = $(this);
            "clients" == b.attr("load") && Chosen.recovery(b, a), Chosen.inp(b)
        })
    }
}, AdminNotes = {
        show: function () {
            AdminNotes.hide(), $("#AdmNotes").show().find(".admin-note-new").show(), $("#AdmNotes .admin-note-new textarea").focus()
        },
        hide: function () {
            $("#AdmNotes .admin-note-new").hide(), $("#AdmNotes .admin-note-edit:visible").each(function () {
                $(this).hide().prev().show()
            })
        },
        addNew: function () {
            var a = $("#AdmNotes .admin-note-new textarea"),
                b = a.val();
            a.val(""), AdminNotes.hide(), b && b.length && $.post($("#notesurl").attr("href"), {
                make: "addNote",
                note: b
            }, AdminNotes.ajax)
        },
        edit: function (a) {
            var b = $("#AdmNotes textarea:visible:last").val();
            b && b.length && $.post($("#notesurl").attr("href"), {
                make: "editNote",
                note: b,
                noteid: a
            }, AdminNotes.ajax)
        },
        init: function () {
            var a = $("#AdmNotes");
            a.length && $.get($("#notesurl").attr("href") + "&make=getNotes", AdminNotes.ajax)
        },
        del: function (a) {
            $.post($("#notesurl").attr("href"), {
                make: "delNote",
                noteid: a
            }, AdminNotes.ajax)
        },
        ajax: function (a) {
            a = parse_response(a), a.length ? ($("#AdmNotes").show(), $("#notesContainer").html(a)) : ($("#AdmNotes").hide(), $("#notesContainer").html(""))
        }
    };