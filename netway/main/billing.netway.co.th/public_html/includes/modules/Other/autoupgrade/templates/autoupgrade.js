$(document).ready(function () {
   $('#pluginexcluded').chosenedge();
});

var HBAutoupgrade = {

    previousStep: "",
    currentStep: "",
    targetLog: "#autoupgrade_log",
    target: "package",
    storage: {},

    parseResponse: function(dta) {
        var codes = dta;



        for (var i = 0; i < codes.INFO.length; i++) {
            $(HBAutoupgrade.targetLog).append("<div class='info'>" + codes.INFO[i] + "</div>");
        }
        for (var i = 0; i < codes.ERROR.length; i++) {
            $(HBAutoupgrade.targetLog).append("<div class='error'>" + codes.ERROR[i] + "</div>");
        }
        if(codes.STORAGE) {
            $.each(codes.STORAGE,function(k,v){
                HBAutoupgrade.storage[k]=v;
            });
        }
        if (codes.EVAL) {
            for (i = 0; i < codes.EVAL.length; i++) {
                eval(codes.EVAL[i]);
            }
        }
        if (codes.PROGRESS) {
            NProgress.set(codes.PROGRESS);
        }
        if (codes.NEXT) {
            HBAutoupgrade.executeStep(codes.NEXT);
        }
        if(codes.ERROR && codes.PROGRESS<1 && !codes.NEXT) {
            NProgress.done();
        }

    },

    executeStep: function(step) {
        console.log("Executing next step: " + step);

        HBAutoupgrade.previousStep = HBAutoupgrade.currentStep;
        HBAutoupgrade.currentStep = step;
        $.getJSON("?cmd=autoupgrade",{
            action: 'step_'+ step,
            target: HBAutoupgrade.target,
            storage: HBAutoupgrade.storage
        },HBAutoupgrade.parseResponse);
    },

    initPluginsUpgrade: function() {
        bootbox.confirm("Are you sure you wish to proceed with plugins update?", function (choice) {
            if (choice) {

                $('#form-info').hide();
                $('#form-log').show();

                HBAutoupgrade.executeStep("startplugins");
            }
        });
        return false;
    },
    initVersionUpgrade: function() {
        bootbox.confirm("Are you sure you wish to proceed with update?", function (choice) {
            if (choice) {

                $('#form-info').hide();
                $('#form-log').show();

                HBAutoupgrade.executeStep("preupgrade");
            }
        });
        return false;

    }


};