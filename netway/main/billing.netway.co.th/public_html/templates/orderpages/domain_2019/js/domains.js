var glob = ('undefined' === typeof window) ? global : window,

    Handlebars = glob.Handlebars || require('handlebars');

this["Handlebars"] = this["Handlebars"] || {};
this["Handlebars"]["templates"] = this["Handlebars"]["templates"] || {};

this["Handlebars"]["templates"]["result-row-data"] = Handlebars.template({"1":function(container,depth0,helpers,partials,data) {
        var helper;

        return "                <a href=\"#whois/"
            + container.escapeExpression(((helper = (helper = helpers.hostname || (depth0 != null ? depth0.hostname : depth0)) != null ? helper : helpers.helperMissing),(typeof helper === "function" ? helper.call(depth0 != null ? depth0 : {},{"name":"hostname","hash":{},"data":data}) : helper)))
            + "\" class=\"d-none d-md-inline-block result-whois-link ml-2 small\">whois</a>\n";
    },"3":function(container,depth0,helpers,partials,data) {
        return "            <label class=\"badge text-danger mr-5\">"
            + container.escapeExpression((helpers.lang || (depth0 && depth0.lang) || helpers.helperMissing).call(depth0 != null ? depth0 : {},"premium",{"name":"lang","hash":{},"data":data}))
            + "</label>\n";
    },"5":function(container,depth0,helpers,partials,data) {
        var stack1;

        return ((stack1 = (helpers.ifCond || (depth0 && depth0.ifCond) || helpers.helperMissing).call(depth0 != null ? depth0 : {},((stack1 = (depth0 != null ? depth0.before : depth0)) != null ? stack1.price : stack1),">",0,{"name":"ifCond","hash":{},"fn":container.program(6, data, 0),"inverse":container.noop,"data":data})) != null ? stack1 : "");
    },"6":function(container,depth0,helpers,partials,data) {
        var stack1;

        return "            <div class=\"result-oldprice mx-4\">\n            <span class=\"price-old-amount text-secondary \"><del>"
            + container.escapeExpression((helpers.$ || (depth0 && depth0.$) || helpers.helperMissing).call(depth0 != null ? depth0 : {},((stack1 = (depth0 != null ? depth0.before : depth0)) != null ? stack1.price : stack1),{"name":"$","hash":{},"data":data}))
            + "</del></span>\n            </div>\n";
    },"8":function(container,depth0,helpers,partials,data) {
        var stack1;

        return "        <div class=\"result-price mx-4\">\n        <span class=\"price-amount text-primary \">"
            + container.escapeExpression((helpers.$ || (depth0 && depth0.$) || helpers.helperMissing).call(depth0 != null ? depth0 : {},((stack1 = (depth0 != null ? depth0.price : depth0)) != null ? stack1.price : stack1),{"name":"$","hash":{},"data":data}))
            + "</span>\n            <span class=\"d-none d-md-inline-block price-period text-muted small\">"
            + container.escapeExpression(container.lambda(((stack1 = (depth0 != null ? depth0.price : depth0)) != null ? stack1.title : stack1), depth0))
            + "</span>\n        </div>\n";
    },"10":function(container,depth0,helpers,partials,data) {
        return "        <div class=\"result-price empty\"></div>\n";
    },"12":function(container,depth0,helpers,partials,data) {
        return "        <a class=\"result-button btn btn-primary text-white btn-border1px btn-rounded btn-sm domain-register\">\n            <span class=\"d-inline-block d-md-none material-icons size-sm\">add_shopping_cart</span>\n            <span class=\"d-none d-md-inline-block\">\n                <i class=\" material-icons size-sm mr-2\">shopping_cart</i>\n                "
            + container.escapeExpression((helpers.lang || (depth0 && depth0.lang) || helpers.helperMissing).call(depth0 != null ? depth0 : {},"register",{"name":"lang","hash":{},"data":data}))
            + "\n            </span>\n        </a>\n";
    },"14":function(container,depth0,helpers,partials,data) {
        var stack1;

        return ((stack1 = helpers["if"].call(depth0 != null ? depth0 : {},(depth0 != null ? depth0.canTransfer : depth0),{"name":"if","hash":{},"fn":container.program(15, data, 0),"inverse":container.program(17, data, 0),"data":data})) != null ? stack1 : "");
    },"15":function(container,depth0,helpers,partials,data) {
        return "        <a class=\"result-button btn btn-primary text-white btn-border1px btn-rounded btn-sm domain-transfer\">\n            <span class=\"d-inline-block d-md-none material-icons size-sm\">add_shopping_cart</span>\n            <span class=\"d-none d-md-inline-block\">\n                <i class=\"material-icons size-sm mr-2\">compare_arrows</i>\n                "
            + container.escapeExpression((helpers.lang || (depth0 && depth0.lang) || helpers.helperMissing).call(depth0 != null ? depth0 : {},"transfer",{"name":"lang","hash":{},"data":data}))
            + "\n            </span>\n        </a>\n";
    },"17":function(container,depth0,helpers,partials,data) {
        var stack1;

        return ((stack1 = (helpers.eq || (depth0 && depth0.eq) || helpers.helperMissing).call(depth0 != null ? depth0 : {},(depth0 != null ? depth0.status : depth0),-1,{"name":"eq","hash":{},"fn":container.program(18, data, 0),"inverse":container.program(20, data, 0),"data":data})) != null ? stack1 : "");
    },"18":function(container,depth0,helpers,partials,data) {
        return "        <a class=\"result-button btn btn-sm btn-outline-primary btn-border1px btn-rounded disabled domain-loading btn-sm\">\n            <div class=\"cart_preloader\">\n                <div class=\"cart_preloader_line bg-primary\"></div>\n                <div class=\"cart_preloader_line bg-primary\"></div>\n                <div class=\"cart_preloader_line bg-primary\"></div>\n            </div>\n        </a>\n";
    },"20":function(container,depth0,helpers,partials,data) {
        return "        <a class=\"result-button btn btn-sm btn-secondary disabled domain-noaction\">"
            + container.escapeExpression((helpers.lang || (depth0 && depth0.lang) || helpers.helperMissing).call(depth0 != null ? depth0 : {},"Unavailable",{"name":"lang","hash":{},"data":data}))
            + "</a>\n    ";
    },"compiler":[7,">= 4.0.0"],"main":function(container,depth0,helpers,partials,data) {
        var stack1, helper;

        return "<div class=\"result-data\">\n        <div class=\"result-hostname font-weight-bold d-flex flex-row align-items-center\" title=\""
            + container.escapeExpression(((helper = (helper = helpers.hostname || (depth0 != null ? depth0.hostname : depth0)) != null ? helper : helpers.helperMissing),(typeof helper === "function" ? helper.call(depth0 != null ? depth0 : {},{"name":"hostname","hash":{},"data":data}) : helper)))
            + "\">\n            <span class=\"result-sld mid max\">"
            + container.escapeExpression((helpers.dots || (depth0 && depth0.dots) || helpers.helperMissing).call(depth0 != null ? depth0 : {},(depth0 != null ? depth0.sld : depth0),(depth0 != null ? depth0.tld : depth0),50,{"name":"dots","hash":{},"data":data}))
            + "</span>\n            <span class=\"result-tld\">"
            + container.escapeExpression(((helper = (helper = helpers.tld || (depth0 != null ? depth0.tld : depth0)) != null ? helper : helpers.helperMissing),(typeof helper === "function" ? helper.call(depth0 != null ? depth0 : {},{"name":"tld","hash":{},"data":data}) : helper)))
            + "</span>\n"
            + ((stack1 = (helpers.eq || (depth0 && depth0.eq) || helpers.helperMissing).call(depth0 != null ? depth0 : {},(depth0 != null ? depth0.status : depth0),"",{"name":"eq","hash":{},"fn":container.program(1, data, 0),"inverse":container.noop,"data":data})) != null ? stack1 : "")
            + "        </div>\n    </div>\n    <div class=\"result-actions d-flex flex-row align-items-center\">\n"
            + ((stack1 = helpers["if"].call(depth0 != null ? depth0 : {},(depth0 != null ? depth0.premium : depth0),{"name":"if","hash":{},"fn":container.program(3, data, 0),"inverse":container.noop,"data":data})) != null ? stack1 : "")
            + ((stack1 = helpers["if"].call(depth0 != null ? depth0 : {},((stack1 = (depth0 != null ? depth0.before : depth0)) != null ? stack1.price : stack1),{"name":"if","hash":{},"fn":container.program(5, data, 0),"inverse":container.noop,"data":data})) != null ? stack1 : "")
            + ((stack1 = helpers["if"].call(depth0 != null ? depth0 : {},(depth0 != null ? depth0.price : depth0),{"name":"if","hash":{},"fn":container.program(8, data, 0),"inverse":container.program(10, data, 0),"data":data})) != null ? stack1 : "")
            + ((stack1 = helpers["if"].call(depth0 != null ? depth0 : {},(depth0 != null ? depth0.canRegister : depth0),{"name":"if","hash":{},"fn":container.program(12, data, 0),"inverse":container.program(14, data, 0),"data":data})) != null ? stack1 : "")
            + "    <div class=\"result-incart\">\n        <a href=\"#remove\" class=\"btn btn-danger btn-sm result-remove\" title=\""
            + container.escapeExpression((helpers.lang || (depth0 && depth0.lang) || helpers.helperMissing).call(depth0 != null ? depth0 : {},"removefromcart",{"name":"lang","hash":{},"data":data}))
            + "\">\n            <i class=\"material-icons size-sm\">delete</i>\n            <span class=\"d-none d-md-inline-block min mid ml-2\">"
            + container.escapeExpression((helpers.lang || (depth0 && depth0.lang) || helpers.helperMissing).call(depth0 != null ? depth0 : {},"removefromcart",{"name":"lang","hash":{},"data":data}))
            + "</span>\n        </a>\n    </div>\n    </div>";
    },"useData":true});


this["Handlebars"]["templates"]["result-row"] = Handlebars.template({"1":function(container,depth0,helpers,partials,data) {
        return "lazy";
    },"3":function(container,depth0,helpers,partials,data) {
        return "active";
    },"compiler":[7,">= 4.0.0"],"main":function(container,depth0,helpers,partials,data) {
        var stack1, helper;

        return "<div class=\"result-row border-bottom py-3 d-flex flex-column flex-md-row justify-content-start justify-content-md-between aling-items-center "
            + ((stack1 = helpers["if"].call(depth0 != null ? depth0 : {},(depth0 != null ? depth0.lazy : depth0),{"name":"if","hash":{},"fn":container.program(1, data, 0),"inverse":container.noop,"data":data})) != null ? stack1 : "")
            + " "
            + ((stack1 = helpers["if"].call(depth0 != null ? depth0 : {},(depth0 != null ? depth0.inCart : depth0),{"name":"if","hash":{},"fn":container.program(3, data, 0),"inverse":container.noop,"data":data})) != null ? stack1 : "")
            + "\" id=\""
            + container.escapeExpression(((helper = (helper = helpers.htmlId || (depth0 != null ? depth0.htmlId : depth0)) != null ? helper : helpers.helperMissing),(typeof helper === "function" ? helper.call(depth0 != null ? depth0 : {},{"name":"htmlId","hash":{},"data":data}) : helper)))
            + "\" data-id=\""
            + container.escapeExpression(((helper = (helper = helpers.key || (data && data.key)) != null ? helper : helpers.helperMissing),(typeof helper === "function" ? helper.call(depth0 != null ? depth0 : {},{"name":"key","hash":{},"data":data}) : helper)))
            + "\" data-loader=\"whois\">\n"
            + ((stack1 = container.invokePartial(partials.resultRowData,depth0,{"name":"resultRowData","data":data,"indent":"                ","helpers":helpers,"partials":partials,"decorators":container.decorators})) != null ? stack1 : "")
            + "                </div>";
    },"usePartial":true,"useData":true});

this["Handlebars"]["templates"]["result-group"] = Handlebars.template({"1":function(container,depth0,helpers,partials,data) {
        var stack1, helper;

        return "                <div class=\"result-query mt-4\">"
            + container.escapeExpression((helpers.lang || (depth0 && depth0.lang) || helpers.helperMissing).call(depth0 != null ? depth0 : {},"resultsfor",{"name":"lang","hash":{},"data":data}))
            + ": <span class=\"result-query-text text-primary\">"
            + container.escapeExpression(((helper = (helper = helpers.query || (depth0 != null ? depth0.query : depth0)) != null ? helper : helpers.helperMissing),(typeof helper === "function" ? helper.call(depth0 != null ? depth0 : {},{"name":"query","hash":{},"data":data}) : helper)))
            + "</span></div>\n                <div class=\"result-group d-flex flex-column\" data-id=\""
            + container.escapeExpression(((helper = (helper = helpers.key || (data && data.key)) != null ? helper : helpers.helperMissing),(typeof helper === "function" ? helper.call(depth0 != null ? depth0 : {},{"name":"key","hash":{},"data":data}) : helper)))
            + "\">\n"
            + ((stack1 = helpers.each.call(depth0 != null ? depth0 : {},(depth0 != null ? depth0.display : depth0),{"name":"each","hash":{},"fn":container.program(2, data, 0),"inverse":container.noop,"data":data})) != null ? stack1 : "")
            + "                </div>\n";
    },"2":function(container,depth0,helpers,partials,data) {
        var stack1;

        return ((stack1 = container.invokePartial(partials.resultRow,depth0,{"name":"resultRow","data":data,"indent":"                ","helpers":helpers,"partials":partials,"decorators":container.decorators})) != null ? stack1 : "");
    },"compiler":[7,">= 4.0.0"],"main":function(container,depth0,helpers,partials,data) {
        var stack1;

        return ((stack1 = helpers.each.call(depth0 != null ? depth0 : {},(depth0 != null ? depth0.items : depth0),{"name":"each","hash":{},"fn":container.program(1, data, 0),"inverse":container.noop,"data":data})) != null ? stack1 : "");
    },"usePartial":true,"useData":true});


this["Handlebars"]["templates"]["summary-details"] = Handlebars.template({"1":function(container,depth0,helpers,partials,data) {
        var stack1, helper;

        return "                <tr class=\"summary-box-row-item \" data-hostname=\""
            + container.escapeExpression(((helper = (helper = helpers.name || (depth0 != null ? depth0.name : depth0)) != null ? helper : helpers.helperMissing),(typeof helper === "function" ? helper.call(depth0 != null ? depth0 : {},{"name":"name","hash":{},"data":data}) : helper)))
            + "\" data-id=\""
            + container.escapeExpression(((helper = (helper = helpers.htmlId || (depth0 != null ? depth0.htmlId : depth0)) != null ? helper : helpers.helperMissing),(typeof helper === "function" ? helper.call(depth0 != null ? depth0 : {},{"name":"htmlId","hash":{},"data":data}) : helper)))
            + "\">\n                    <td colspan=\"2\">\n"
            + ((stack1 = (helpers.ifeq || (depth0 && depth0.ifeq) || helpers.helperMissing).call(depth0 != null ? depth0 : {},(depth0 != null ? depth0.type : depth0),"register",{"name":"ifeq","hash":{},"fn":container.program(2, data, 0),"inverse":container.noop,"data":data})) != null ? stack1 : "")
            + ((stack1 = (helpers.ifeq || (depth0 && depth0.ifeq) || helpers.helperMissing).call(depth0 != null ? depth0 : {},(depth0 != null ? depth0.type : depth0),"transfer",{"name":"ifeq","hash":{},"fn":container.program(4, data, 0),"inverse":container.noop,"data":data})) != null ? stack1 : "")
            + "                        <b>"
            + container.escapeExpression(((helper = (helper = helpers.name || (depth0 != null ? depth0.name : depth0)) != null ? helper : helpers.helperMissing),(typeof helper === "function" ? helper.call(depth0 != null ? depth0 : {},{"name":"name","hash":{},"data":data}) : helper)))
            + "</b> - "
            + container.escapeExpression(((helper = (helper = helpers.period || (depth0 != null ? depth0.period : depth0)) != null ? helper : helpers.helperMissing),(typeof helper === "function" ? helper.call(depth0 != null ? depth0 : {},{"name":"period","hash":{},"data":data}) : helper)))
            + " "
            + container.escapeExpression((helpers.lang || (depth0 && depth0.lang) || helpers.helperMissing).call(depth0 != null ? depth0 : {},"years",{"name":"lang","hash":{},"data":data}))
            + "\n                    </td>\n                    <td>\n                        "
            + container.escapeExpression((helpers.$ || (depth0 && depth0.$) || helpers.helperMissing).call(depth0 != null ? depth0 : {},(depth0 != null ? depth0.price : depth0),{"name":"$","hash":{},"data":data}))
            + "\n"
            + ((stack1 = helpers["if"].call(depth0 != null ? depth0 : {},(depth0 != null ? depth0.before : depth0),{"name":"if","hash":{},"fn":container.program(6, data, 0),"inverse":container.noop,"data":data})) != null ? stack1 : "")
            + "                        <a href=\"#remove\" class=\"float-right btn btn-sm btn-outline-danger ml-3 result-remove\">"
            + container.escapeExpression((helpers.lang || (depth0 && depth0.lang) || helpers.helperMissing).call(depth0 != null ? depth0 : {},"removefromcart",{"name":"lang","hash":{},"data":data}))
            + "</a>\n                    </td>\n                </tr>\n";
    },"2":function(container,depth0,helpers,partials,data) {
        return "                            <span class=\"badge badge-primary mr-2\">"
            + container.escapeExpression((helpers.lang || (depth0 && depth0.lang) || helpers.helperMissing).call(depth0 != null ? depth0 : {},"register",{"name":"lang","hash":{},"data":data}))
            + "</span>\n";
    },"4":function(container,depth0,helpers,partials,data) {
        return "                            <span class=\"badge badge-primary mr-2\">"
            + container.escapeExpression((helpers.lang || (depth0 && depth0.lang) || helpers.helperMissing).call(depth0 != null ? depth0 : {},"transfer",{"name":"lang","hash":{},"data":data}))
            + "</span>\n";
    },"6":function(container,depth0,helpers,partials,data) {
        return "                            <span class=\"text-secondary ml-2\"><del>"
            + container.escapeExpression((helpers.$ || (depth0 && depth0.$) || helpers.helperMissing).call(depth0 != null ? depth0 : {},(depth0 != null ? depth0.before : depth0),{"name":"$","hash":{},"data":data}))
            + "</del></span>\n";
    },"8":function(container,depth0,helpers,partials,data) {
        var stack1;

        return "            <tr>\n                <td class=\"text-right\" colspan=\"2\">\n                    "
            + container.escapeExpression((helpers.lang || (depth0 && depth0.lang) || helpers.helperMissing).call(depth0 != null ? depth0 : {},"total_recurring",{"name":"lang","hash":{},"data":data}))
            + "\n                </td>\n                <td>\n"
            + ((stack1 = helpers.each.call(depth0 != null ? depth0 : {},((stack1 = (depth0 != null ? depth0.summary : depth0)) != null ? stack1.recurring : stack1),{"name":"each","hash":{},"fn":container.program(9, data, 0),"inverse":container.noop,"data":data})) != null ? stack1 : "")
            + "                </td>\n            </tr>\n";
    },"9":function(container,depth0,helpers,partials,data) {
        var helper;

        return "                    "
            + container.escapeExpression((helpers.$ || (depth0 && depth0.$) || helpers.helperMissing).call(depth0 != null ? depth0 : {},(depth0 != null ? depth0.price : depth0),{"name":"$","hash":{},"data":data}))
            + " "
            + container.escapeExpression(((helper = (helper = helpers.title || (depth0 != null ? depth0.title : depth0)) != null ? helper : helpers.helperMissing),(typeof helper === "function" ? helper.call(depth0 != null ? depth0 : {},{"name":"title","hash":{},"data":data}) : helper)))
            + "<br>\n";
    },"11":function(container,depth0,helpers,partials,data) {
        var stack1;

        return "            <tr>\n                <td class=\"text-right\" colspan=\"2\">\n                    "
            + container.escapeExpression((helpers.lang || (depth0 && depth0.lang) || helpers.helperMissing).call(depth0 != null ? depth0 : {},"discount",{"name":"lang","hash":{},"data":data}))
            + "\n                </td>\n                <td>\n                    - "
            + container.escapeExpression((helpers.$ || (depth0 && depth0.$) || helpers.helperMissing).call(depth0 != null ? depth0 : {},((stack1 = (depth0 != null ? depth0.summary : depth0)) != null ? stack1.discount : stack1),{"name":"$","hash":{},"data":data}))
            + "\n                </td>\n            </tr>\n";
    },"13":function(container,depth0,helpers,partials,data) {
        var stack1;

        return ((stack1 = helpers.each.call(depth0 != null ? depth0 : {},((stack1 = (depth0 != null ? depth0.summary : depth0)) != null ? stack1.tax : stack1),{"name":"each","hash":{},"fn":container.program(14, data, 0),"inverse":container.noop,"data":data})) != null ? stack1 : "");
    },"14":function(container,depth0,helpers,partials,data) {
        var helper;

        return "            <tr>\n                <td class=\"text-right\" colspan=\"2\">\n                    "
            + container.escapeExpression(((helper = (helper = helpers.name || (depth0 != null ? depth0.name : depth0)) != null ? helper : helpers.helperMissing),(typeof helper === "function" ? helper.call(depth0 != null ? depth0 : {},{"name":"name","hash":{},"data":data}) : helper)))
            + " @ "
            + container.escapeExpression(((helper = (helper = helpers.value || (depth0 != null ? depth0.value : depth0)) != null ? helper : helpers.helperMissing),(typeof helper === "function" ? helper.call(depth0 != null ? depth0 : {},{"name":"value","hash":{},"data":data}) : helper)))
            + " %\n                </td>\n                <td>\n                    "
            + container.escapeExpression((helpers.$ || (depth0 && depth0.$) || helpers.helperMissing).call(depth0 != null ? depth0 : {},(depth0 != null ? depth0.tax : depth0),{"name":"$","hash":{},"data":data}))
            + "\n                </td>\n            </tr>\n";
    },"16":function(container,depth0,helpers,partials,data) {
        var stack1;

        return ((stack1 = helpers["if"].call(depth0 != null ? depth0 : {},((stack1 = (depth0 != null ? depth0.summary : depth0)) != null ? stack1.credit : stack1),{"name":"if","hash":{},"fn":container.program(17, data, 0),"inverse":container.noop,"data":data})) != null ? stack1 : "");
    },"17":function(container,depth0,helpers,partials,data) {
        var stack1;

        return "            <tr>\n                <td class=\"text-right\" colspan=\"2\">\n                    "
            + container.escapeExpression((helpers.lang || (depth0 && depth0.lang) || helpers.helperMissing).call(depth0 != null ? depth0 : {},"credit",{"name":"lang","hash":{},"data":data}))
            + "\n                </td>\n                <td>\n                    "
            + container.escapeExpression((helpers.$ || (depth0 && depth0.$) || helpers.helperMissing).call(depth0 != null ? depth0 : {},((stack1 = (depth0 != null ? depth0.summary : depth0)) != null ? stack1.credit : stack1),{"name":"$","hash":{},"data":data}))
            + "\n                </td>\n            </tr>\n            ";
    },"compiler":[7,">= 4.0.0"],"main":function(container,depth0,helpers,partials,data) {
        var stack1;

        return "<div class=\"domain-search-summary-details-table\">\n        <table class=\"table table-borderless w-100\">\n            <thead class=\"thead-transparent\">\n            <tr>\n                <th class=\"static\" width=\"60%\" align=\"left\">"
            + container.escapeExpression((helpers.lang || (depth0 && depth0.lang) || helpers.helperMissing).call(depth0 != null ? depth0 : {},"Domain",{"name":"lang","hash":{},"data":data}))
            + "</th>\n                <th class=\"static\" width=\"10%\">"
            + container.escapeExpression((helpers.lang || (depth0 && depth0.lang) || helpers.helperMissing).call(depth0 != null ? depth0 : {},"setup",{"name":"lang","hash":{},"data":data}))
            + "</th>\n                <th class=\"static\" width=\"30%\">"
            + container.escapeExpression((helpers.lang || (depth0 && depth0.lang) || helpers.helperMissing).call(depth0 != null ? depth0 : {},"price",{"name":"lang","hash":{},"data":data}))
            + "</th>\n            </tr>\n            </thead>\n            <tbody>\n"
            + ((stack1 = helpers.each.call(depth0 != null ? depth0 : {},(depth0 != null ? depth0.domains : depth0),{"name":"each","hash":{},"fn":container.program(1, data, 0),"inverse":container.noop,"data":data})) != null ? stack1 : "")
            + ((stack1 = helpers["if"].call(depth0 != null ? depth0 : {},((stack1 = (depth0 != null ? depth0.summary : depth0)) != null ? stack1.recurring : stack1),{"name":"if","hash":{},"fn":container.program(8, data, 0),"inverse":container.noop,"data":data})) != null ? stack1 : "")
            + ((stack1 = helpers["if"].call(depth0 != null ? depth0 : {},((stack1 = (depth0 != null ? depth0.summary : depth0)) != null ? stack1.discount : stack1),{"name":"if","hash":{},"fn":container.program(11, data, 0),"inverse":container.noop,"data":data})) != null ? stack1 : "")
            + ((stack1 = helpers["if"].call(depth0 != null ? depth0 : {},((stack1 = (depth0 != null ? depth0.summary : depth0)) != null ? stack1.tax : stack1),{"name":"if","hash":{},"fn":container.program(13, data, 0),"inverse":container.program(16, data, 0),"data":data})) != null ? stack1 : "")
            + "            <tr>\n                <td class=\"text-right\" colspan=\"2\">\n                    <strong>"
            + container.escapeExpression((helpers.lang || (depth0 && depth0.lang) || helpers.helperMissing).call(depth0 != null ? depth0 : {},"total_today",{"name":"lang","hash":{},"data":data}))
            + "</strong>\n                </td>\n                <td>\n                    <h3><b>"
            + container.escapeExpression((helpers.$ || (depth0 && depth0.$) || helpers.helperMissing).call(depth0 != null ? depth0 : {},((stack1 = (depth0 != null ? depth0.summary : depth0)) != null ? stack1.total : stack1),{"name":"$","hash":{},"data":data}))
            + "</b></h3>\n                </td>\n            </tr>\n            </tbody>\n        </table>\n    </div>\n    <hr>";
    },"useData":true});
// this["Handlebars"]["templates"][""] = Handlebars.template();
// this["Handlebars"]["templates"][""] = Handlebars.template();
// this["Handlebars"]["templates"][""] = Handlebars.template();
// this["Handlebars"]["templates"][""] = Handlebars.template();
// this["Handlebars"]["templates"][""] = Handlebars.template();
// this["Handlebars"]["templates"][""] = Handlebars.template();
// this["Handlebars"]["templates"][""] = Handlebars.template();
// this["Handlebars"]["templates"][""] = Handlebars.template();


(function (HBCart, Handlebars) {
    HBCart.Lang = HBCart.Lang || {};

    Handlebars.registerHelper('$', function (price, format, options) {
        if (!format || !format.iso)
            format = HBCart.cart.currency;

        format.after = false;
        return HBCart.Utils.formatMoney(price, format)
    });

    Handlebars.registerHelper('$&', function (price, format, options) {
        if (!format || !format.iso)
            format = HBCart.cart.currency;
        return HBCart.Utils.formatMoney(price, format)
    });

    Handlebars.registerHelper('eq', function (a, b) {
        var next = arguments[arguments.length - 1];
        return (a === b) ? next.fn(this) : next.inverse(this);
    });

    Handlebars.registerHelper('lang', function (a) {
        return HBCart.Lang[a] || a;
    });

    Handlebars.registerHelper('ifeq', function (arg1, arg2, options) {
        return (arg1 == arg2) ? options.fn(this) : options.inverse(this);
    });

    Handlebars.registerHelper('get_length', function (obj) {
        return Object.keys(obj).length;
    });

    Handlebars.registerHelper('ifCond', function (v1, operator, v2, options) {

        switch (operator) {
            case '==':
                return (v1 == v2) ? options.fn(this) : options.inverse(this);
            case '===':
                return (v1 === v2) ? options.fn(this) : options.inverse(this);
            case '!=':
                return (v1 != v2) ? options.fn(this) : options.inverse(this);
            case '!==':
                return (v1 !== v2) ? options.fn(this) : options.inverse(this);
            case '<':
                return (v1 < v2) ? options.fn(this) : options.inverse(this);
            case '<=':
                return (v1 <= v2) ? options.fn(this) : options.inverse(this);
            case '>':
                return (v1 > v2) ? options.fn(this) : options.inverse(this);
            case '>=':
                return (v1 >= v2) ? options.fn(this) : options.inverse(this);
            case '&&':
                return (v1 && v2) ? options.fn(this) : options.inverse(this);
            case '||':
                return (v1 || v2) ? options.fn(this) : options.inverse(this);
            default:
                return options.inverse(this);
        }
    });

    Handlebars.registerHelper('eq', function (options) {
        var argv = Array.prototype.slice.call(arguments);

        if (argv.length > 1) {

            options = argv[argv.length - 1];
            if (argv[0] == argv[1]) {
                return options.fn(this);
            }
            return options.inverse(this);
        }
        for (var key in options.hash) {
            if (this[key] == options.hash[key])
                return options.fn(this);
        }
        return options.inverse(this);
    });

    Handlebars.registerHelper('dots', function (string, tld, trimtoLength, options) {
        if (string.length + tld.length < trimtoLength)
            return string;

        var sp = Math.ceil(string.length / 2),
            cutoff = Math.floor((string.length + tld.length - trimtoLength) / 2) + 1;
        return string.substr(0, sp - cutoff) + '...' + string.substr(sp + cutoff);
    });

    Handlebars.registerHelper('$', function (price, format, options) {
        if (!format || !format.iso)
            format = HBCart.cart.currency;
        return HBCart.Utils.formatMoney(price, format)
    });

    Handlebars.registerPartial('resultRow', Handlebars.templates['result-row']);
    Handlebars.registerPartial('resultRowData', Handlebars.templates['result-row-data']);

})(HBCart, Handlebars);

if (!Object.prototype.forEach) {
    Object.defineProperty(Object.prototype, 'forEach', {
        value: function (callback, thisArg) {
            if (this == null) {
                throw new TypeError('Not an object');
            }
            thisArg = thisArg || window;
            for (var key in this) {
                if (this.hasOwnProperty(key)) {
                    callback.call(thisArg, this[key], key, this);
                }
            }
        }
    });
}


$(function () {
    var root = $('#domains'),
        textarea = root.find('.domain-search textarea'),
        tpltarget = $('#orderpage .domain-search-results'),
        nc = $('#newContacts'),
        usemyContacts = $('input[name="contacts[usemy]"]'),
        showmore = $('.result-more'),
        showmorebtn = showmore.find('.btn'),
        rows_limit = parseInt(root.attr('data-limit')) || 10,
        rows_limit_new = rows_limit,
        mode,
        listToDisplay,
        cache = {},
        lastValue = '',
        typing,
        requests = [],
        tplopt = {
            data: {
                domains: 0
            }
        };

    var DCart = {
        common: {
            isSummaryDetailsHidden: false,
            summaryBlock: function (hideDetails) {
                var summBlock = $('.domain-search-summary');
                if (summBlock.length) {
                    var sb = $('.sidebar');
                    var sbWidth = parseInt($(sb).width());
                    var sbMleft = parseInt($(sb).css('margin-left'));
                    var sm = $('.section-main');
                    var smWidth = parseInt($(sm).width());
                    var invisble = DCart.common.isSummaryDetailsHidden || hideDetails;

                    summBlock.addClass("domain-search-summary-sticky")
                        .css({'margin-left': window.innerWidth < 993 ? 0 : sbWidth + sbMleft});
                    summBlock.find(".domain-search-summary-content").css({'width': smWidth});
                    summBlock.find(".domain-search-summary-details").css({'width': smWidth});
                    summBlock.find(".domain-search-summary-details-info").css({'width': smWidth});
                    if ($('.orderpage').hasClass('container'))
                        summBlock.addClass('container');
                    if (invisble) {
                        DCart.common.hideSummaryBlock();
                    } else {
                        DCart.common.showSummaryBlock();
                    }

                    if (summBlock.is(':visible')) {
                        summBlock.parent().css({'margin-bottom': summBlock.height() + 50});
                    } else {
                        summBlock.parent().css({'margin-bottom': 0});
                    }
                }
            },
            hideSummaryBlock: function () {
                var summBlock = $('.domain-search-summary');
                var foldIcon = summBlock.find(".domain-search-summary-details-btn .fold-icon");
                foldIcon.removeClass('top');
                foldIcon.addClass('bottom');
                summBlock.find(".domain-search-summary-details").hide();
            },
            handleUpdates: function () {
                var cnt = Object.keys(HBCart.cart.domains).length;
                $('.cart-cnt').text(cnt);
                DCart.common.isSummaryDetailsHidden = !($('.domain-search-summary .domain-search-summary-details').is(':visible'));
                if (cnt < 1) {
                    $('.domain-search-summary').hide().parent().css('margin-bottom', 0);
                } else {
                    HBCart.cart.domains.forEach(function (item, key) {
                        HBCart.cart.domains[key].htmlId = 'r_' + btoa(encodeURIComponent(HBCart.cart.domains[key].id + HBCart.cart.domains[key].name)).replace(/=+/, '')
                        HBCart.cart.category.products.forEach(function (pitem, pkey) {
                            if (item.id == pitem.id) {
                                pitem.periods.forEach(function (peitem, pekey) {
                                    if (peitem.value == item.period)
                                        HBCart.cart.domains[key].before = peitem.before;
                                });
                            }
                        });
                    });
                    var format = HBCart.cart.currency;
                    format.after = false;
                    var total = HBCart.Utils.formatMoney(HBCart.cart.summary.subtotal, format)
                    $('.domain-search-summary-details').html(Handlebars.templates['summary-details'](HBCart.cart));
                    $('.domain-search-summary-content-count').html(cnt);
                    $('.domain-search-summary-content-total').html(total);
                    DCart.common.summaryBlock();
                    $('.domain-search-summary').show().parent().css({'margin-bottom': $('.domain-search-summary').height() + 50});

                    HBCart.cart.domains.forEach(function (item, key) {
                        var price = HBCart.Utils.formatMoney(item.price, HBCart.cart.currency);
                        $('tr[data-domain-id="'+item.index+'"]').find('.price-cell').html(price);
                    });

                    if(HBCart.cart.summary.tax[0]) {
                        $('.tax-row.tax-value').html(HBCart.cart.summary.tax[0].value);
                        $('.tax-row.tax-amount').html(HBCart.Utils.formatMoney(HBCart.cart.summary.tax[0].tax, format));
                    }
                }
            },
            doWhois: function (e) {
                e.preventDefault();
                var self = $(e.target),
                    token = $('meta[name="csrf-token"]').attr('content'),
                    params = self.attr('href').match(/#whois\/(.+)(\..+?)$/),
                    url = '?cmd=checkdomain&action=whois&sld=' + params[1] + '&tld=' + params[2] + '&security_token=' + token;
                window.open(url, params[1] + params[2], 'width=500, height=500, scrollbars=1')
            },
            uniqueId: function () {
                return '_' + Date.now() + Math.random() + Math.random();
            }
        },
        step1: {
            modeswitch: function (_mode) {
                if (_mode != 'transfer' && _mode != 'register') {
                    return false;
                }
                mode = _mode;
                $('#orderpage .domain-modes').removeClass('active').filter('.mode-' + mode).addClass('active');
                $('#orderpage').attr('class', '').addClass(mode);
                textarea.prop('placeholder', textarea.data('mode-' + mode));
                DCart.step1.lookup();
                return true;
            }, lazyWhois: function (group) {
                var lazywhois = {},
                    data = group.data('group'),
                    rows = $(".result-row.lazy", group);

                rows.removeClass('lazy');
                rows.Lazy({
                    appendScroll: group,
                    visibleOnly: true,
                    scrollDirection: 'vertical',
                    threshold: 0,
                    throttle: 250,
                    whois: function (element) {

                        var row = $(element),
                            item = row.data('item');

                        lazywhois[item.hostname] = DCart.step1.checkdomain(item);

                        lazywhois[item.hostname].done(function () {
                            delete lazywhois[item.hostname];
                        }).fail(function () {
                            delete lazywhois[item.hostname];
                            row.data('handled', false)
                        })
                    },
                    onUnload: function (element) {
                        var row = $(element),
                            item = row.data('item'),
                            hostname = item.hostname;

                        if (lazywhois[hostname] && lazywhois[hostname].state() == 'pending')
                            lazywhois[hostname].abort();
                    }
                });

                var timeout;
                group.on('scroll', function () {
                    clearTimeout(timeout)
                    timeout = setTimeout(function () {
                        group.trigger('resize');
                    }, 1000)
                })
            }, checkdomain: function (item) {
                var defered =
                    HBCart.Api.checkDomain(item.sld, item.tld).done(function (data) {
                        data.canTransfer = data.status == '';
                        data.canRegister = data.status == 'ok';
                        data.price = data.canRegister ? item.register : (
                            data.canTransfer ? item.transfer : null
                        )
                        cache[item.hostname] = data;
                        if (data.premium && data.canRegister) {
                            data.price.price = data.prices["1"].register;
                        }

                        $.extend(item, data);
                        $('#' + item.htmlId).html(Handlebars.templates['result-row-data'](item, tplopt));
                    })
                requests.push(defered);
                return defered;
            }, firstperiod: function (type, periods) {
                for (var i = 0, l = periods.length; i < l; i++) {
                    if (periods[i][type] >= 0)
                        return {
                            period: periods[i].value,
                            title: periods[i].title,
                            price: periods[i][type]
                        }
                }
            }, lookupgroup: function (sld, tlds) {
                var tlds_l = tlds.length,
                    tlds_found = [],
                    group = {
                        query: sld,
                        items: [],
                        display: []
                    };

                for (var i = 0, l = HBCart.cart.category.products.length; i < l; i++) {
                    var product = HBCart.cart.category.products[i],
                        domain = sld + product.name,
                        tld_in_query = tlds.indexOf(product.name),
                        tags = product.tags || [];

                    if (mode == 'transfer' && tld_in_query < 0)
                        continue;

                    group.items.push({
                        id: product.id,
                        hostname: domain,
                        sld: sld,
                        tld: product.name,
                        status: -1,
                        inquery: tld_in_query >= 0 ? tlds_l - tld_in_query : -1,
                        featured: tags.indexOf('featured') > -1,
                        line: tld_in_query,
                        inCart: typeof HBCart.cart.domains[domain] !== 'undefined',
                        transfer: DCart.step1.firstperiod('transfer', product.periods),
                        register: DCart.step1.firstperiod('register', product.periods),
                        before: DCart.step1.firstperiod('before', product.periods),
                        price: DCart.step1.firstperiod(mode, product.periods),
                        htmlId: 'r_' + btoa(encodeURIComponent(product.id + domain)).replace(/=+/, '')
                    });
                    if (tld_in_query >= 0)
                        tlds_found.push(product.name);
                }
                if (tlds_found.length != tlds_l) {
                    for (var i = 0; i < tlds_l; i++) {
                        if (tlds_found.indexOf(tlds[i]) >= 0)
                            continue;

                        var tld_in_query = tlds.indexOf(tlds[i])
                        group.items.push({
                            hostname: sld + tlds[i],
                            sld: sld,
                            tld: tlds[i],
                            inquery: tlds_l - tld_in_query,
                            line: tld_in_query,
                            status: 'notsupported',
                        })
                    }
                }
                if (!group.items.length)
                    return null;

                group.items.sort(function (a, b) {
                    if (a.inquery !== b.inquery)
                        return b.inquery - a.inquery

                    if (a.inCart !== b.inCart)
                        return b.inCart - a.inCart

                    if (a.featured !== b.featured)
                        return b.featured - a.featured

                    return a.index - b.index

                })
                group.display = group.items;
                return group;
            },
            lookup: function () {
                listToDisplay = {};
                var query = {};

                if (!textarea.val())
                    return false;

                var hostnames = textarea.val().split(/\n/),
                    wipe = /^[-\.]+|[-\.]+$|^((?!xn).{2})--|[!@#$€%^&*()<>=+`~'"\[\\\/\],;| _]|^w{1,3}$|^w{1,3}\./g;
                //^[-\.]+ / remove leading hyphen and dot
                //[-\.]+$ / remove end hyphen and dot
                //^((?!xn).{2})-- / Cannot have a hyphen in third and fourth position, unless it starts with 'xn'
                //[!@#$€%^&*()<>=+`~'"\[\\\/\],;| _] / not allowed characters
                //^w{1,3}$|^w{1,3}\. / strip www from query

                $.each(hostnames, function (i, hostname) {
                    hostname = hostname.trim().toLowerCase().replace(wipe, '$1');

                    var dot = (hostname + '.').indexOf('.'),
                        parts = [hostname.slice(0, dot), hostname.slice(dot + 1)],
                        sld = parts[0],
                        tld = parts[1] ? '.' + parts[1].replace(wipe, '') : '';

                    hostname = sld + (tld || '');
                    if (hostname.length < 2)
                        return;

                    if (!query[sld])
                        query[sld] = [];

                    if (tld)
                        query[sld].push(tld);
                });
                $.each(query, function (sld, tlds) {
                    listToDisplay['G' + sld] = DCart.step1.lookupgroup(sld, tlds);
                });
                var subi = 0;
                while (true) {
                    var hasitems = 0;
                    for (var d in listToDisplay) {
                        if (!listToDisplay.hasOwnProperty(d) || !listToDisplay[d] || !listToDisplay[d].display[subi])
                            continue;

                        var item = listToDisplay[d].display[subi];
                        hasitems++;

                        if (!cache[item.hostname]) {
                            if (subi < rows_limit_new)
                                DCart.step1.checkdomain(item);
                            else
                                item.lazy = 1;
                            continue;
                        }
                        $.extend(item, cache[item.hostname]);
                    }
                    if (!hasitems)
                        break;

                    subi++;
                }
                tpltarget.html(Handlebars.templates['result-group']({items: listToDisplay}, tplopt));
                $('.result-group', tpltarget).each(function () {
                    var group = $(this),
                        groupid = group.data('id'),
                        rows = group.children(),
                        rowheight = null;

                    group.data('group', listToDisplay[groupid]);

                    rows.each(function () {
                        var row = $(this),
                            rowid = row.data('id');

                        row.data('item', listToDisplay[groupid].display[rowid]);
                        if (rowheight == null)
                            rowheight = (row.outerHeight(true) - row.outerHeight()) / 2 + row.outerHeight();
                    })
                    if (!(group.hasClass('loaded'))) {
                        if (rows.length > rows_limit_new) {
                            group.height(rowheight * rows_limit_new);
                            showmore.show();
                        } else {
                            showmore.hide();
                        }
                    }
                    DCart.step1.lazyWhois(group);
                });

            }, modeFromUrl: function () {
                if (['#register', '#transfer'].indexOf(window.location.hash) > -1)
                    return window.location.hash.substr(1);
                return window.location.href.match(/\/transfer/) ? 'transfer' : 'register';
            }
        },
        step2: {
            bulk_periods: function (period = 1) {
                $('.result-period').each(function () {
                    if ($(this).find("option[value='"+period+"']").length > 0)
                        $(this).val(period);
                }).trigger('change');
            },
            change_period: function (domain, newperiod = 1) {
                ajax_update('?cmd=cart&step=2&do=changedomainperiod', {key: domain, period: newperiod}, '#cartSummary');
                return false;
            },
            set_form: function (type, domain, id, val) {

            },
            applyCoupon: function (e) {
                e.preventDefault();
                $(e.target).closest('form').append('<input type="hidden" name="addcoupon" value="true"/><input type="hidden" name="step" value="2"/>');
                $(e.target).closest('form').submit();
            },
            removeCoupon: function (e) {
                e.preventDefault();
                ajax_update('?cmd=cart&removecoupon=true&step=2');
                location.reload();
            },
            add_ns: function (elem) {
                var limit = 10,
                    tr = $(elem).parents('tr').first(),
                    button = $('.add_ns'),
                    id = tr.children().last().children().first().data('id'),
                    clone = tr.clone(),
                    new_id = id + 1,
                    ip = $('input[name="nsip' + id + '"]').parents('tr').first(),
                    new_ip = $('input[name="nsip' + new_id + '"]').parents('tr').first();

                if (id < limit) {
                    clone = DCart.step2.prepare_ns(clone, id);
                    if (new_id === limit)
                        clone.children().last().children().last().remove();
                    tr.after(clone);
                    button.remove();
                    if (ip.length > 0 && new_ip.length <= 0) {
                        var cloneip = ip.clone();
                        cloneip = DCart.step2.prepare_ns(cloneip, id);
                        ip.after(cloneip);
                    }
                }
            },
            prepare_ns: function (clone, id) {
                var input = clone.children().last().children().first(),
                    text = clone.children().first().html(),
                    new_id = id + 1,
                    name = input.prop('name');
                input.data('id', new_id);
                input.prop('name', name.replace(id, new_id));
                input.prop('value', '');
                text = text.replace(id, new_id);
                clone.children().first().html(text);
                return clone;
            },
            addsubproduct: function (product_id) {
                var html = '<input type="hidden" name="addsubproduct" value="'+product_id+'"/>';
                $('form#cart3').append(html).submit();
            },
            toggle_contacts: function () {
                nc.find('.sing-up [required]').prop('disabled', usemyContacts.is(':checked'));
            },
            updateNames: function (form, prefix) {
                form.find('input, select, textarea').each(function () {
                    var field = $(this);
                    if (field.attr('type') === 'checkbox') {
                        field.attr('name', prefix + '[' + field.attr('name').replace('[', ']['));
                    } else {
                        field.attr('name', prefix + '[' + field.attr('name') + ']');
                    }
                })
            },
            contacts_singupform: function (select) {
                var self = $(select),
                    target = self.siblings('.sing-up'),
                    pref = self.attr('name');
                self.parent().addLoader();
                $.get('?cmd=signup&contact&private', function (resp) {
                    $('#preloader').remove();
                    var form = $('<div></div>')
                    form.append('<input type="hidden" name="__nocontact" value="1" />');
                    form.append('<input type="checkbox" name="__nocontact" value="0" checked="checked" /> <label>' + HBCart.Lang['addthiscontact'] + '</label>');
                    form.append(parse_response(resp));
                    DCart.step2.updateNames(form, pref)
                    target.html('');
                    form.appendTo(target);
                    DCart.step2.toggle_contacts();
                    DCart.step2.parse_contact_forms(target);
                });
            },
            parse_contact_forms: function (target) {
                $(target).find('.form-label-group').each(function () {
                    var u = DCart.common.uniqueId();

                    var lab_for = $(this).find('label').attr('for');
                    $(this).find('label').attr('for', lab_for + u);

                    var inp_id = $(this).find('input').attr('id');
                    $(this).find('input').attr('id', inp_id + u);

                    var txarea_id = $(this).find('textarea').attr('id');
                    $(this).find('textarea').attr('id', txarea_id + u);

                    var slct_id = $(this).find('select').attr('id');
                    $(this).find('select').attr('id', slct_id + u);
                })
            }
        },
    };

    $(window).scroll(function () {
        DCart.common.summaryBlock(true);
    });

    $(window).resize(function () {
         DCart.common.summaryBlock(true);
    })
    DCart.common.summaryBlock(true);

    $(window).on("hashchange", function () {
        DCart.step1.modeswitch(DCart.step1.modeFromUrl());
    });

    if (step < 2) {
        DCart.step1.modeswitch(DCart.step1.modeFromUrl());
    }

    $(document).on('cart.updated', function () {
        DCart.common.handleUpdates();
    }).trigger('cart.updated');

    $(document).on('cart.errors', function (e, list) {
        $.each(list, function (key, item) {
            pnotify([item.message], 'error')
        });
    });

    $(document).on('cart.info', function (e, list) {
        $.each(list, function (key, item) {
            pnotify([item.message], 'info')
        });
    });

    DCart.common.summaryBlock(true);

    autosize(textarea);

    HBCart.whenReady(function () {
        textarea.on('input keyup', function (e) {
            var val = textarea.val().trim();
            if (lastValue === val)
                return;

            clearTimeout(typing);
            if (val.length < 3)
                return;

            rows_limit_new = rows_limit;

            lastValue = val;
            for (var i = 0; i < requests.length; i++) {
                requests[i].abort();
            }
            requests = [];

            typing = setTimeout(DCart.step1.lookup, 260)
        }).trigger('input');

        setTimeout(function () {
            //$(window).trigger('resize');
            DCart.common.summaryBlock(true);
        }, 300);
    });

    $(document).on('click', '.result-cart', function (e) {
        e.preventDefault();
        if ($(this).hasClass('disabled'))
            return false;
        setTimeout(function(){$(document).find('.btn-summary-continue')[0].click()}, 100);
    });

    $(document).on('click', '.btn-left-navbar.btn-toggler', function () {
        setTimeout(function () {
            //$(window).trigger('resize');
            DCart.common.summaryBlock(true);
        }, 300);
    });

    $(document).on('click', '#domains .domain-modes span:not(.mode-notclick)', function () {
        var hash = $(this).attr('href');
        if (window.history.pushState) {
            window.history.pushState(null, null, window.location.href.replace(/#.*$/, '') + hash);
            DCart.step1.modeswitch(DCart.step1.modeFromUrl());
        } else {
            window.location.hash = hash;
        }
    });

    $(document).on('click', '#domains .result-row .domain-transfer, .result-row .domain-register', function (e) {
        e.preventDefault();
        var self = $(this),
            row = self.parents('.result-row:first'),
            item = row.data('item');

        if (!item || !item.price)
            return;

        row.addClass('active');
        $('.result-cart, .result-order').addClass('disabled')

        if (item.canTransfer)
            HBCart.Api.transferDomain(item.id, item.hostname, item.price.period, {queue: false})
                .done(function () {
                    $('.result-cart, .result-order').removeClass('disabled');
                });
        else
            HBCart.Api.registerDomain(item.id, item.hostname, item.price.period, {queue: false})
                .done(function () {
                    $('.result-cart, .result-order').removeClass('disabled');
                });

        $('.cart-cnt').text(++tplopt.data.domains);
    })

    $(document).on('click', '#domains .result-row .result-remove', function (e) {
        e.preventDefault();
        var self = $(this),
            row = self.parents('.result-row:first'),
            item = row.data('item');

        if (!item)
            return;

        HBCart.Api.removeDomain(item.hostname, {queue: false}).always(function () {
            row.removeClass('active')
        });
    })

    $(document).on('click', '.domain-row .result-remove', function (e) {
        e.preventDefault();
        if (!confirm(HBCart.Lang['itemremoveconfirm']))
            return false;
        var self = $(this),
            row = self.closest('tbody'),
            hostname = self.data('hostname');
        if (!hostname)
            return;
        HBCart.Api.removeDomain(hostname, {queue: false}).always(function () {
            row.remove();
            DCart.common.handleUpdates();
            if (Object.keys(HBCart.cart.domains).length < 1)
                window.location = '?cmd=cart';
        });
    })

    $(document).on('click', '.summary-box-row-item .result-remove', function (e) {
        e.preventDefault();
        if (!confirm(HBCart.Lang['itemremoveconfirm']))
            return false;

        var self = $(this),
            row = self.parents('.summary-box-row-item:first'),
            hostname = row.data('hostname'),
            did = row.data('id');

        if (!hostname)
            return;

        if (step > 1) {
            HBCart.Api.removeDomainInStep2(hostname, {queue: false});
        } else {
            HBCart.Api.removeDomain(hostname, {queue: false});
        }

        if (Object.keys(HBCart.cart.domains).length < 1)
            window.location = '?cmd=cart';

        $('.result-row#' + did + '').removeClass('active');
        $('.table-result-row[data-hostname="' + hostname + '"]').remove();
        DCart.common.handleUpdates();
    })

    $(document).on('change', '.domain-row .result-period', function (e) {
        e.preventDefault();
        var self = $(this),
            period = $(this).val(),
            hostname = self.data('hostname');
        if (!hostname)
            return;

        HBCart.Api.changeDomainPeriod(hostname, period, {step: 2});
        DCart.common.handleUpdates();
    });

    $(document).on('click', '.sub-products .addsubproduct', function (e) {
        e.preventDefault();
        return DCart.step2.addsubproduct($(this).attr('data-id'));
    })

    $(document).on('keyup', '.promo input', function (e) {
        if (e.keyCode === 13)
            return DCart.step2.applyCoupon(e);
        return false;
    });

    $(document).on('click', '.promo .coupon-add', function (e) {
        e.preventDefault();
        return DCart.step2.applyCoupon(e);
    });

    $(document).on('click', '.promo .coupon-remove', function (e) {
        e.preventDefault();
        return DCart.step2.removeCoupon(e);
    });

    $(document).on('change', '.domain-config-table .bulk_period', function (e) {
        var period = $(this).val();
        DCart.step2.bulk_periods(period);
    });

    $(document).on('click', '.domain-config-table .add_ns', function (e) {
        e.preventDefault();
        DCart.step2.add_ns(e.target);
    })

    $(document).on('click', '.domain-search-summary-details-btn', function (e) {
        e.preventDefault();
        $('.domain-search-summary-details').toggle();
    });

    $(document).on('click', '#domains .domain-input button', DCart.step1.lookup);

    $(document).on('click', '#domains .result-whois-link', function (e) {
        return DCart.common.doWhois(e);
    });

    $(document).on('click', '.result-more .btn', function (e) {
        rows_limit_new += rows_limit;
        $('.result-group', tpltarget).each(function () {
            e.preventDefault();
            DCart.step1.lookup($(this));
        });
    })

    $('.domain-form').find('input, select, textarea').change(function () {
        var row = $(this).closest('.domain-form');
        var id = row.attr('data-id');
        var domain = row.attr('data-hostname');
        if ($(this).is(':checkbox')) {
            var val = ($(this).is(':checked')) ? 1 : 0;
        } else {
            var val = $(this).val();
        }
        HBCart.Api.setDomainForm(domain, id, val, {simulate: 1});
        DCart.common.handleUpdates();
    });

    usemyContacts.on('init change', function () {
        if (!this.checked) {
            nc.slideDown('fast');
            DCart.step2.toggle_contacts();
        } else {
            nc.slideUp('fast');
            DCart.step2.toggle_contacts();
        }
    }).trigger('init');

    $('.contact-selection').each(function () {
        var self = $(this),
            target = self.siblings('.sing-up');

        self.on('change', function () {
            if (self.val() == 'new')
                DCart.step2.contacts_singupform(this);
            else
                target.html('');
        })
        if (self.val() == 'new' && !target.children().length)
            DCart.step2.contacts_singupform(this);
    });

    $('[data-c-type]').each(function () {
        var self = $(this),
            type = self.data('c-type');
        DCart.step2.updateNames(self, 'contacts[' + type + ']');
    });
});