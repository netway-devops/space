function ConfirmInvoiceEdit(callback) {
    if (void 0 == typeof window.EditWarning || !window.EditWarning) return callback();
    bootbox.confirm("This invoice has been issued and is locked                    for edit, are you sure you want to change it?", function(result) {
        return !result || (window.EditWarning = !1, callback(), !0)
    })
}

function toggleStatusActions() {
    var status = $("#invoice_status, #estimate_status").data("status");
    if (status) {
        status = status.replace(/receipt/gi, "") || "CreditNote";
        var statusLo = status.toLowerCase(),
            acts = $(".act-status");
        acts.filter('[class*="off-"]').removeClass("disabled").filter(".off-" + statusLo).addClass("disabled"), acts.filter('[class*="on-"]').addClass("disabled").filter(".on-" + statusLo).removeClass("disabled")
    }
}
$(function() {
    function replaceContent(data) {
        var response = Array.isArray(data) ? parse_response(data[0]) : parse_response(data),
            container_id = Array.isArray(data) ? data[1] : "#detcont",
            container = $(container_id);
        if (response.length > 10) {
            var resp = $(response),
                cont = resp.find(container_id);
            return cont.length && (response = cont.html()), container.html(response), $(".haspicker", container).datePicker({
                startDate: startDate
            }), !0
        }
        return !1
    }

    function FormSubmit(e) {
        if (e.preventDefault(), "0" !== $("#old_client_id").val()) {
            var id = $("input[name=invoice_id]").val(),
                form = $.extend(!0, $("#detailsform").serializeForm(), $("#itemsform").serializeForm()),
                newitem = $(e.target).is(".newline-add");
            if (newitem) {
                if (!form.item.n.description.length) return
            } else delete form.item.n;
            form.id = id, form.action = "edit_preview";
            var total = $("#updatetotals");
            newitem ? $("#itemsform").addClass("wrap-loading") : total.addClass("wrap-loading"), $.post(cmdUrl, form, function(data) {
                $(".wrap-loading").removeClass("wrap-loading"), data = parse_response(data);
                var html = $(data),
                    linebody = $("#main-invoice"),
                    newlinebody = $("#main-invoice", html),
                    focus = linebody.find(":focus"),
                    active = linebody.find("tr:has(.editor-line.active)");
                if (linebody.replaceWith(newlinebody), focus.each(function() {
                        $('[name="' + $(this).attr("name") + '"]', "#main-invoice").focus()
                    }), active.each(function() {
                        var tr = $(this),
                            id = tr.attr("id"),
                            _tr = id ? "#" + id : '[data-line="' + tr.data("line") + '"]';
                        $(".editor-line", _tr).addClass("active")
                    }), $.each(removedLines, function(key, tr) {
                        var old = newlinebody.find("#" + tr.attr("id")),
                            line = tr.data("line"),
                            inserted = !1;
                        if (old.length) return void old.replaceWith(tr.clone());
                        newlinebody.children().each(function() {
                            if ($(this).data("line") > line) return tr.clone().insertBefore(this), inserted = !0, !1
                        }), inserted || newlinebody.append(tr.clone())
                    }), total.replaceWith($("#updatetotals", html)), newitem) {
                    $("#addliners").replaceWith($("#addliners", html));
                    $("#addliners .setStatus").dropdownMenu()
                }
                $(".invoice-update-field").each(function() {
                    var self = $(this),
                        val = self.val(),
                        text = self.data("formated");
                    $("." + self.attr("id")).each(function() {
                        var sub = $(this);
                        sub.is("input, select, textarea") ? sub.val(val).change() : sub.text(text)
                    })
                })
            }), $("#invoice-actions").addClass("Draft")
        }
    }

    function ToggleEditMode() {
        var a1 = $(".tdetail .a1"),
            a2 = $(".tdetail .a2");
        if (a1.length) {
            var state = a1.is(":visible");
            return $(".secondtd").toggleClass("active", state), $(".tdetails").toggleClass("active", !state), $("#invoice-queue").toggleClass("active", !state), a1.toggle(!state), a2.toggle(state), !1
        }
    }

    function checkrecurring() {
        var client = $("#client_id").val(),
            recurring = $("#is_recurring");
        if (!recurring.length) return !0;
        var startDate = $("#recurring_start_date").val(),
            oldStartDate = $("#old_recurring_start_date").val();
        return "1" != recurring.val() || "0" == client || startDate != RcStartDate || startDate == oldStartDate || confirm(lang.invoicerecurrnow)
    }

    function hash_action(e) {
        var self = $(this),
            hash = self.attr("href"),
            action = hash && "#" == hash[0] && hash.substr(1) || !1;
        if (!action) return !0;
        switch (action) {
            case "save":
                return ConfirmInvoiceEdit(function() {
                    var id = $("input[name=invoice_id]").val(),
                        form = $.extend(!0, $("#detailsform").serializeForm(), $("#itemsform").serializeForm());
                    return form.id = id, form.action = "edit", form.make = "save", delete form.item.n, $.post(cmdUrl, form, function(data) {
                        replaceContent([data, "#bodycont"])
                    }), !1
                }), !1;
            case "update":
                FormSubmit.call(this, e);
                break;
            case "cancel":
                ToggleEditMode();
                break;
            case "convert":
                if (!checkrecurring()) return !1;
                var form = $("#detailsform").serializeObject();
                form.id = $("input[name=invoice_id]").val(), form.action = "convertdraft", $.post(cmdUrl, form, function(data) {
                    replaceContent([data, "#bodycont"])
                });
                break;
            case "itemqueue":
                if (confirm("Are you sure? Invoice queue will be emptied for this client")) {
                    $("#itemsform").append();
                    var form = {
                        id: $("input[name=invoice_id]").val(),
                        action: "edit",
                        itemqueue: 1
                    };
                    $.post(cmdUrl, form, function(data) {
                        replaceContent([data, "#bodycont"])
                    })
                }
        }
        return !1
    }
    $("input:disabled, textarea:disabled, select:disabled").css("cursor", "default");
    var cmdUrl = window.location.href.replace(/(id|action)=[^&]*&?/g, "").replace(/&$|&#/, ""),
        draft = $("#invoice_status").is(".Draft"),
        invoicebody = $("#bodycont"),
        removedLines = {};
    invoicebody.on("click", "#invoice-actions a, #invoice-queue a", hash_action), invoicebody.on("mouseenter", ".editor-line", function() {
        $(this).hasClass("editable1") || $(this).find(".editbtn").show()
    }), invoicebody.on("mouseleave", ".editor-line", function() {
        $(this).find(".editbtn").hide()
    }), invoicebody.on("click", ".input-mask", function() {
        var self = $(this);
        self.removeClass("active"), self.next().focus()
    }), invoicebody.on("blur", ".input-mask + input", function() {
        var self = $(this);
        "" === self.val() && self.prev().addClass("active")
    }), invoicebody.on("click", ".editor-line .editbtn", function() {
        return $(this).parents(".editor-line").toggleClass("active"), !1
    }), invoicebody.on("click", ".removeLine", function(e) {
        var self = $(this);
        self.toggleClass("active");
        var deleted = self.is(".active"),
            tr = self.parents("tr:first"),
            item_id = tr.data("item-id");
        return item_id ? (tr.toggleClass("delete", deleted), tr.find("input, textarea").prop("disabled", deleted), !draft && deleted ? removedLines[item_id] = tr.clone() : delete removedLines[item_id]) : tr.remove(), $("#itemsform").addClass("wrap-loading"), FormSubmit.call(this, e), !1
    }), invoicebody.on("change", ".invitem", FormSubmit), invoicebody.on("change", "#detailsform input, #detailsform select", FormSubmit), invoicebody.on("click", ".tdetail a", ToggleEditMode), invoicebody.on("mouseenter mouseleave click", ".livemode", function(e) {
        var self = $(this);
        if (self.parents(".read-only").length) return !1;
        switch (e.type) {
            case "mouseenter":
                self.append('<a href="#" onclick="return false;" class="manuedit">' + lang.edit + "</a>");
                break;
            case "mouseleave":
                self.find(".manuedit").remove();
                break;
            case "click":
                ToggleEditMode.call(this, e)
        }
        return !1
    }), invoicebody.on("click", "#invoice-draft #clientloader a.menuitm", function(e) {
        var select = $("#clientloader select"),
            value = select.val();
        return 0 != value && "" != value && select.trigger("confirm"), !1
    }), invoicebody.on("change confirm", "#invoice-draft .invoice-type input, #invoice-draft #clientloader select", function(e) {
        var self = $(this),
            step = self.parents(".draft-step:first"),
            navs = $("#client_tab .hbnav li");
        if (self.is("select") && "confirm" != e.type) return !1;
        var form = {};
        return form.id = $("input[name=invoice_id]").val(), form.action = "changething", form.make = "editdetails", form["invoice[invoicetype]"] = "", form[self.attr("name")] = self.val(), $.post(cmdUrl, form, function(data) {
            replaceContent([data, "#invoice-draft"]), step.hide(), step.next().show(), navs.removeClass("active");
            var index = step.index() + 1;
            navs.eq(index).addClass("active")
        }), !1
    }), invoicebody.on("click", "#invoice-draft .draft-steps a", function(e) {
        var self = $(this),
            navs = $("#client_tab .hbnav li"),
            steps = $("#client_tab .draft-step"),
            index = self.parent().index();
        return !(navs.filter(".active:last").index() < index) && (navs.removeClass("active"), self.parent().addClass("active"), steps.hide().eq(index).show(), !1)
    }), invoicebody.on("change", "#inp_recurring_occurrences", function() {
        var inp = $("#recurring_occurrences");
        $(this).is(":checked") ? inp.prop("disabled", !0) : inp.prop("disabled", !1)
    }), invoicebody.on("click", "#prodcanc, #rmliner", function() {
        prodcanc()
    }), invoicebody.on("click", ".newline-add", FormSubmit), invoicebody.on("click", ".newline-cancel", function() {
        $("#addliners").removeClass("advanced")
    }), invoicebody.on("click", "#lineaction_m a", function() {
        var self = $(this),
            action = self.attr("href"),
            body = $(".newline-adv-body"),
            lineform = $("#addliners");
        if ("NewLine" === action) {
            var ifrm = $("#itemsform").addClass("wrap-loading");
            $.post(cmdUrl, {
                action: self.data("line"),
                cycle: self.data("cycle"),
                currency_id: $("#currency_id").val()
            }, function(data) {
                ifrm.removeClass("wrap-loading"), lineform.addClass("advanced"), body.html(parse_response(data))
            })
        }
    }), invoicebody.on("change", "#product_id", function() {
        var self = $(this),
            option = self.find(":selected");
        $("#nline").val(option.parent().attr("label") + " - " + option.text()), $("#addliners .invamount").val(option.data("price"))
    }), invoicebody.on("show", "[bootbox]", function() {
        var self = $(this),
            opts = self.data(),
            dialog = bootbox.dialog({
                message: " ",
                title: opts.title,
                show: !1,
                buttons: {
                    cancel: {
                        label: "Cancel",
                        className: "btn-defaultr"
                    },
                    confirm: {
                        label: opts.btntitle || opts.title,
                        className: "btn-success",
                        callback: function(e) {
                            return dialog.find("form").submit(), !0
                        }
                    }
                }
            });
        dialog.find(".bootbox-body").append(self.children().clone()), $(".dp-choose-date", dialog).remove(), $(".haspicker", dialog).removeClass("dp-applied").datePicker({
            startDate: startDate
        }), dialog.modal("show")
    }), invoicebody.on("click", ".addPayment", function() {
        return $(this).hasClass("disabled") || $("#add-payment").trigger("show"), !1
    }), invoicebody.on("click", "#add-credit-btn", function() {
        $("#add-credit").trigger("show")
    }), invoicebody.on("click", ".tax-rates.dropdown-menu a", function() {
        var self = $(this),
            combo = self.closest(".input-combo");
        combo.find('input[name$="[taxed]"]').val(void 0 === self.data("notax") ? 1 : 0), combo.find('input[name$="[tax_rate]"]').val(self.data("value")).trigger("change")
    }), $(document).on("change", "#new_currency_id", function() {
        var parent = $(this).parents(".modal-body:first"),
            rates = $("#exrates input", parent);
        rates.hide(), rates.eq(this.selectedIndex).show()
    }), $(document).on("click", "#calcex", function() {
        var parent = $(this).parents(".modal-body:first"),
            rates = $("#exrates", parent);
        $(this).is(":checked") ? (rates.show(), rates.find("input").eq($("#new_currency_id", parent)[0].selectedIndex).show()) : rates.hide()
    }), $(document).on("click", "#history-tab .show-change-list", function() {
        bootbox.dialog({
            message: $(this.getAttribute("href")).html(),
            onEscape: !0,
            title: "Change List"
        })
    })
});