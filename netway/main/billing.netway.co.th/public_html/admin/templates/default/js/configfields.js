function fieldclick(type){$(".dark_shelf .dhidden").show(),$(".fselect").removeClass("selected"),$("#field"+type).parent().addClass("selected"),$("#initial-desc").hide(),$("#s_menu div.description").hide(),$("#s_menu div.descr_image").hide(),$("#s_menu #"+type+"-description").show(),$("#s_menu #"+type+"-descr_image").show(),$("#duplicateform input[name=type]").val(type),$("#addform input[name=type]").val(type),$("#premadeloader").hide(),$(".spinner").show(),$.post("?cmd=configfields&action=loadpremade_field",{type:type},function(data){var d=parse_response(data);$(".spinner").hide(),"string"==typeof d&&$("#premadeloader").html(d).show()})}function saveChangesField(){$(".spinner").show();var post=$("#saveform").serializeForm();post.paytype=$("input[name=paytype]:checked").val(),$("#facebox").data("last-tab",$("#lefthandmenu a.picked").attr("href")),ajax_update("index.php?cmd=configfields&x="+Math.random(),post,".content").always(reloadForms)}function reloadForms(){return ajax_update("?cmd=configfields",{action:"loadproduct",product_id:$("#product_id").val()},"#configeditor_content")}function createField(){return $(".spinner").show(),$("#premade_val").length&&0!=$("#premade_val").val()&&$("#premade_to_fill").val($("#premade_val").val()),$("#premade_val").length&&0!=$("#premade_val").val()&&$("#premadeurl_to_fill").val($("#premadeurl_val").val()),ajax_update("index.php?x="+Math.random()+"&paytype="+$("input[name=paytype]:checked").val(),$("#addform").serializeObject(),"#formcontainer").always(function(){0!=$("#premade_val").val()&&reloadForms()}),!1}function duplicateFieldSubmit(){return $(".spinner").show(),ajax_update("index.php?cmd=configfields&x="+Math.random(),$("#duplicatefield").serializeObject(),"#formcontainer").always(function(){reloadForms(),$(".spinner").hide()}),!1}function usePremade(){return 0!=$("#premadeid").length&&0!=$("#premadeid").val()&&(!!confirm(configfields_lang.premade_over)&&(ajax_update("index.php?cmd=configfields&action=overwritepremade",{premade:$("#premadeid").val(),category_id:$("#field_category_id").val()},"#subitems_editor").always(reloadForms),!1))}function deleteItem(btn){return!!confirm(configfields_lang.delconf2)&&($(btn).parents("li").remove(),ajax_update($(btn).attr("href"),{},reloadForms),!1)}function addNewConfigItemValue(){var v=$("input[name=new_value_name]").val();if(!v)return!1;$("input[name=new_value_name]").val("");var data=$("input, select, textarea","#config-new-value").serializeObject();return data.name=v,data.category_id=$("#field_category_id").val(),ajax_update("index.php?cmd=configfields&action=additem&make=addnewitem",data,"#subitems_editor").always(reloadForms),!1}function duplicateField(){return $(".spinner").show(),ajax_update("index.php?x="+Math.random(),$("#duplicateform").serializeObject(),"#formcontainer").always(reloadForms),!1}function bindParseDuplicateForm(){$(".chosen[data-chosen]").chosenedge({width:"100%",search_contains:!0}),$("#dup_category_select").chosenedge().change(function(){var parent=$("#dup_category_select").val(),productSel=$("#dup_product_select"),formSel=$("#dup_form_select");$(productSel).val(""),$(productSel).find("option").prop("disabled",!0),""!==parent?($(productSel).closest(".row").show(),$(productSel).find('option[data-parent="'+parent+'"]').prop("disabled",!1)):$(productSel).closest(".row").hide(),$(productSel).trigger("chosen:updated"),$(formSel).closest(".row").hide(),$(formSel).val(""),$(formSel).find("option").prop("disabled",!0),$(formSel).trigger("chosen:updated")}),$("#dup_product_select").chosenedge().change(function(){var parent=$("#dup_product_select").val(),formSel=$("#dup_form_select");$(formSel).val(""),$(formSel).find("option").prop("disabled",!0),""!==parent?($(formSel).closest(".row").show(),$(formSel).find('option[value="selectall"]').prop("disabled",!1),$(formSel).find('option[data-parent="'+parent+'"]').prop("disabled",!1)):$(formSel).closest(".row").hide(),$(formSel).trigger("chosen:updated")})}function updatePricingForms(){for(var i in updatepricingform_calbacks)updatepricingform_calbacks[i]();$(document).trigger("updatePricinForms",$("input[name=paytype]:checked").val()||$("#pricing_overide:visible input[name=bundle_paytype]:checked").val()||$("input[name=dynamic_paytype]:checked").val())}function formbilling(that){that=$(that);var id=that.attr("href").substr(1);$("#formbilling > div").hide().find("select,input,textarea").prop("disabled",!0).attr("disabled","disabled").end().filter("#formbilling_"+id).show().find("select,input,textarea").prop("disabled",!1).removeAttr("disabled").end().trigger("formbilling"),that.addClass("active").siblings().removeClass("active"),$(".formbilling-paytype").val(id)}function saveOrder2(){var fieldid=$("#customitemseditor").attr("data-field-id"),sorts=$("#customitemseditor input.ser2").serialize();ajax_update("?cmd=configfields&action=changeorder&field_id="+fieldid+"&"+sorts,{})}function latebindme(){$("#grab-sorter").dragsort({dragSelector:"a.sorter-ha",dragBetween:!1,dragEnd:saveOrder,placeHolderTemplate:"<li class='placeHolder'><div></div></li>"}),$("#customitemseditor").dragsort({dragSelector:"a.sorter-ha",dragBetween:!1,dragEnd:saveOrder2,placeHolderTemplate:"<li class='placeHolder'><div></div></li>"})}function refreshConfigView(pid){return pid&&ajax_update("?cmd=configfields",{action:"loadproduct",product_id:pid},"#configeditor_content"),!1}function addCustomFieldForm(pid){return $.facebox({ajax:"?cmd=configfields&action=addconfig&product_id="+pid,width:900,nofooter:!0,opacity:.5,addclass:"modernfacebox"}),!1}function previewCustomForm(url){return $.facebox({ajax:url,width:900,nofooter:!0,opacity:.5,addclass:"modernfacebox"}),!1}function editCustomFieldForm(id,pid){return $.facebox({ajax:"?cmd=configfields&action=field&id="+id+"&product_id="+pid+"&paytype="+$("input[name=paytype]:checked").val(),width:900,nofooter:!0,opacity:.5,addclass:"modernfacebox"}),!1}function duplicateCustomFieldForm(id,pid){if(confirm("Are you sure you want to duplicate this field?"))return ajax_update("?cmd=configfields&action=duplicatefield&id="+id+"&product_id="+pid,{},reloadForms),!1}function deleteItemConf(el){return confirm("{/literal}{$lang.delconf2}{literal}")&&ajax_update($(el).attr("href"),{},"#configeditor_content").always(reloadForms),!1}function deleteItemConfCat(el){if(confirm("{/literal}{$lang.delconf1}{literal}")){var href=$(el).attr("href"),id=href.match(/[?&]id=(\d+)/);id&&destroyProductOptionForm(id[1]),ajax_update(href,{},"#configeditor_content").always(reloadForms)}return!1}function destroyProductOptionForm(id){var conf=$(".config-var[value="+id+"]");if(!conf.length)return!1;var cfdata=conf.data(),config=$("#config_"+cfdata.var);if(!config.length)return!1;config.find(".form-var-old").show(),config.find(".form-var-active").remove(),config.find("input.formchecker").prop("checked",!1),config.find("a.orspace").remove()}function initItemConfCat(){var confvattpl=Handlebars.compile(document.getElementById("config-var-tpl").innerHTML);$(".config-var").each(function(){var cfdata=$(this).data(),config=$("#config_"+cfdata.var),metered=$("#checkb_"+cfdata.var);if(cfdata.product_id=$("#product_id").val(),metered.length&&metered.attr("checked","checked"),config.length){var old=config.find(".form-var-old");config.find(".form-var-active").length||(old.length?old.hide():config.children().wrap('<div class="form-var-old" style="display: none;"></div>'),config.append(confvattpl(cfdata)),$("#config_"+cfdata.var+"_descr").hide())}})}function copyCustomFieldForm(pid){return $.facebox({ajax:"?cmd=configfields&action=getduplicateform&product_id="+pid,width:900,nofooter:!0,opacity:.5,addclass:"modernfacebox"}),!1}var updatepricingform_calbacks={};"function"==typeof saveOrder&&"function"==typeof $("#customitemseditor").dragsort&&latebindme();