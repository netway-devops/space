<script type="text/javascript">
    {literal}
	
    /*!
     * jQuery UI 1.8.2
     *
     * Copyright (c) 2010 AUTHORS.txt (http://jqueryui.com/about)
     * Dual licensed under the MIT (MIT-LICENSE.txt)
     * and GPL (GPL-LICENSE.txt) licenses.
     *
     * http://docs.jquery.com/UI
     */
    (function(c){c.ui=c.ui||{};if(!c.ui.version){c.extend(c.ui,{version:"1.8.2",plugin:{add:function(a,b,d){a=c.ui[a].prototype;for(var e in d){a.plugins[e]=a.plugins[e]||[];a.plugins[e].push([b,d[e]])}},call:function(a,b,d){if((b=a.plugins[b])&&a.element[0].parentNode)for(var e=0;e<b.length;e++)a.options[b[e][0]]&&b[e][1].apply(a.element,d)}},contains:function(a,b){return document.compareDocumentPosition?a.compareDocumentPosition(b)&16:a!==b&&a.contains(b)},hasScroll:function(a,b){if(c(a).css("overflow")==
                        "hidden")return false;b=b&&b=="left"?"scrollLeft":"scrollTop";var d=false;if(a[b]>0)return true;a[b]=1;d=a[b]>0;a[b]=0;return d},isOverAxis:function(a,b,d){return a>b&&a<b+d},isOver:function(a,b,d,e,f,g){return c.ui.isOverAxis(a,d,f)&&c.ui.isOverAxis(b,e,g)},keyCode:{ALT:18,BACKSPACE:8,CAPS_LOCK:20,COMMA:188,COMMAND:91,COMMAND_LEFT:91,COMMAND_RIGHT:93,CONTROL:17,DELETE:46,DOWN:40,END:35,ENTER:13,ESCAPE:27,HOME:36,INSERT:45,LEFT:37,MENU:93,NUMPAD_ADD:107,NUMPAD_DECIMAL:110,NUMPAD_DIVIDE:111,NUMPAD_ENTER:108,
                    NUMPAD_MULTIPLY:106,NUMPAD_SUBTRACT:109,PAGE_DOWN:34,PAGE_UP:33,PERIOD:190,RIGHT:39,SHIFT:16,SPACE:32,TAB:9,UP:38,WINDOWS:91}});c.fn.extend({_focus:c.fn.focus,focus:function(a,b){return typeof a==="number"?this.each(function(){var d=this;setTimeout(function(){c(d).focus();b&&b.call(d)},a)}):this._focus.apply(this,arguments)},enableSelection:function(){return this.attr("unselectable","off").css("MozUserSelect","")},disableSelection:function(){return this.attr("unselectable","on").css("MozUserSelect",
                    "none")},scrollParent:function(){var a;a=c.browser.msie&&/(static|relative)/.test(this.css("position"))||/absolute/.test(this.css("position"))?this.parents().filter(function(){return/(relative|absolute|fixed)/.test(c.curCSS(this,"position",1))&&/(auto|scroll)/.test(c.curCSS(this,"overflow",1)+c.curCSS(this,"overflow-y",1)+c.curCSS(this,"overflow-x",1))}).eq(0):this.parents().filter(function(){return/(auto|scroll)/.test(c.curCSS(this,"overflow",1)+c.curCSS(this,"overflow-y",1)+c.curCSS(this,"overflow-x",
                        1))}).eq(0);return/fixed/.test(this.css("position"))||!a.length?c(document):a},zIndex:function(a){if(a!==undefined)return this.css("zIndex",a);if(this.length){a=c(this[0]);for(var b;a.length&&a[0]!==document;){b=a.css("position");if(b=="absolute"||b=="relative"||b=="fixed"){b=parseInt(a.css("zIndex"));if(!isNaN(b)&&b!=0)return b}a=a.parent()}}return 0}});c.extend(c.expr[":"],{data:function(a,b,d){return!!c.data(a,d[3])},focusable:function(a){var b=a.nodeName.toLowerCase(),d=c.attr(a,"tabindex");return(/input|select|textarea|button|object/.test(b)?
                        !a.disabled:"a"==b||"area"==b?a.href||!isNaN(d):!isNaN(d))&&!c(a)["area"==b?"parents":"closest"](":hidden").length},tabbable:function(a){var b=c.attr(a,"tabindex");return(isNaN(b)||b>=0)&&c(a).is(":focusable")}})}})(jQuery);
    ;/*!
     * jQuery UI Widget 1.8.2
     *
     * Copyright (c) 2010 AUTHORS.txt (http://jqueryui.com/about)
     * Dual licensed under the MIT (MIT-LICENSE.txt)
     * and GPL (GPL-LICENSE.txt) licenses.
     *
     * http://docs.jquery.com/UI/Widget
     */
    (function(b){var j=b.fn.remove;b.fn.remove=function(a,c){return this.each(function(){if(!c)if(!a||b.filter(a,[this]).length)b("*",this).add(this).each(function(){b(this).triggerHandler("remove")});return j.call(b(this),a,c)})};b.widget=function(a,c,d){var e=a.split(".")[0],f;a=a.split(".")[1];f=e+"-"+a;if(!d){d=c;c=b.Widget}b.expr[":"][f]=function(h){return!!b.data(h,a)};b[e]=b[e]||{};b[e][a]=function(h,g){arguments.length&&this._createWidget(h,g)};c=new c;c.options=b.extend({},c.options);b[e][a].prototype=
                b.extend(true,c,{namespace:e,widgetName:a,widgetEventPrefix:b[e][a].prototype.widgetEventPrefix||a,widgetBaseClass:f},d);b.widget.bridge(a,b[e][a])};b.widget.bridge=function(a,c){b.fn[a]=function(d){var e=typeof d==="string",f=Array.prototype.slice.call(arguments,1),h=this;d=!e&&f.length?b.extend.apply(null,[true,d].concat(f)):d;if(e&&d.substring(0,1)==="_")return h;e?this.each(function(){var g=b.data(this,a),i=g&&b.isFunction(g[d])?g[d].apply(g,f):g;if(i!==g&&i!==undefined){h=i;return false}}):this.each(function(){var g=
                        b.data(this,a);if(g){d&&g.option(d);g._init()}else b.data(this,a,new c(d,this))});return h}};b.Widget=function(a,c){arguments.length&&this._createWidget(a,c)};b.Widget.prototype={widgetName:"widget",widgetEventPrefix:"",options:{disabled:false},_createWidget:function(a,c){this.element=b(c).data(this.widgetName,this);this.options=b.extend(true,{},this.options,b.metadata&&b.metadata.get(c)[this.widgetName],a);var d=this;this.element.bind("remove."+this.widgetName,function(){d.destroy()});this._create();
                this._init()},_create:function(){},_init:function(){},destroy:function(){this.element.unbind("."+this.widgetName).removeData(this.widgetName);this.widget().unbind("."+this.widgetName).removeAttr("aria-disabled").removeClass(this.widgetBaseClass+"-disabled ui-state-disabled")},widget:function(){return this.element},option:function(a,c){var d=a,e=this;if(arguments.length===0)return b.extend({},e.options);if(typeof a==="string"){if(c===undefined)return this.options[a];d={};d[a]=c}b.each(d,function(f,
                h){e._setOption(f,h)});return e},_setOption:function(a,c){this.options[a]=c;if(a==="disabled")this.widget()[c?"addClass":"removeClass"](this.widgetBaseClass+"-disabled ui-state-disabled").attr("aria-disabled",c);return this},enable:function(){return this._setOption("disabled",false)},disable:function(){return this._setOption("disabled",true)},_trigger:function(a,c,d){var e=this.options[a];c=b.Event(c);c.type=(a===this.widgetEventPrefix?a:this.widgetEventPrefix+a).toLowerCase();d=d||{};if(c.originalEvent){a=
                        b.event.props.length;for(var f;a;){f=b.event.props[--a];c[f]=c.originalEvent[f]}}this.element.trigger(c,d);return!(b.isFunction(e)&&e.call(this.element[0],c,d)===false||c.isDefaultPrevented())}}})(jQuery);
    ;/*!
     * jQuery UI Mouse 1.8.2
     *
     * Copyright (c) 2010 AUTHORS.txt (http://jqueryui.com/about)
     * Dual licensed under the MIT (MIT-LICENSE.txt)
     * and GPL (GPL-LICENSE.txt) licenses.
     *
     * http://docs.jquery.com/UI/Mouse
     *
     * Depends:
     *	jquery.ui.widget.js
     */
    (function(c){c.widget("ui.mouse",{options:{cancel:":input,option",distance:1,delay:0},_mouseInit:function(){var a=this;this.element.bind("mousedown."+this.widgetName,function(b){return a._mouseDown(b)}).bind("click."+this.widgetName,function(b){if(a._preventClickEvent){a._preventClickEvent=false;b.stopImmediatePropagation();return false}});this.started=false},_mouseDestroy:function(){this.element.unbind("."+this.widgetName)},_mouseDown:function(a){a.originalEvent=a.originalEvent||{};if(!a.originalEvent.mouseHandled){this._mouseStarted&&
                        this._mouseUp(a);this._mouseDownEvent=a;var b=this,e=a.which==1,f=typeof this.options.cancel=="string"?c(a.target).parents().add(a.target).filter(this.options.cancel).length:false;if(!e||f||!this._mouseCapture(a))return true;this.mouseDelayMet=!this.options.delay;if(!this.mouseDelayMet)this._mouseDelayTimer=setTimeout(function(){b.mouseDelayMet=true},this.options.delay);if(this._mouseDistanceMet(a)&&this._mouseDelayMet(a)){this._mouseStarted=this._mouseStart(a)!==false;if(!this._mouseStarted){a.preventDefault();
                            return true}}this._mouseMoveDelegate=function(d){return b._mouseMove(d)};this._mouseUpDelegate=function(d){return b._mouseUp(d)};c(document).bind("mousemove."+this.widgetName,this._mouseMoveDelegate).bind("mouseup."+this.widgetName,this._mouseUpDelegate);c.browser.safari||a.preventDefault();return a.originalEvent.mouseHandled=true}},_mouseMove:function(a){if(c.browser.msie&&!a.button)return this._mouseUp(a);if(this._mouseStarted){this._mouseDrag(a);return a.preventDefault()}if(this._mouseDistanceMet(a)&&
                    this._mouseDelayMet(a))(this._mouseStarted=this._mouseStart(this._mouseDownEvent,a)!==false)?this._mouseDrag(a):this._mouseUp(a);return!this._mouseStarted},_mouseUp:function(a){c(document).unbind("mousemove."+this.widgetName,this._mouseMoveDelegate).unbind("mouseup."+this.widgetName,this._mouseUpDelegate);if(this._mouseStarted){this._mouseStarted=false;this._preventClickEvent=a.target==this._mouseDownEvent.target;this._mouseStop(a)}return false},_mouseDistanceMet:function(a){return Math.max(Math.abs(this._mouseDownEvent.pageX-
                    a.pageX),Math.abs(this._mouseDownEvent.pageY-a.pageY))>=this.options.distance},_mouseDelayMet:function(){return this.mouseDelayMet},_mouseStart:function(){},_mouseDrag:function(){},_mouseStop:function(){},_mouseCapture:function(){return true}})})(jQuery);
    ;/*
     * jQuery UI Slider 1.8.2
     *
     * Copyright (c) 2010 AUTHORS.txt (http://jqueryui.com/about)
     * Dual licensed under the MIT (MIT-LICENSE.txt)
     * and GPL (GPL-LICENSE.txt) licenses.
     *
     * http://docs.jquery.com/UI/Slider
     *
     * Depends:
     *	jquery.ui.core.js
     *	jquery.ui.mouse.js
     *	jquery.ui.widget.js
     */
    (function(d){d.widget("ui.slider",d.ui.mouse,{widgetEventPrefix:"slide",options:{animate:false,distance:0,max:100,min:0,orientation:"horizontal",range:false,step:1,value:0,values:null},_create:function(){var a=this,b=this.options;this._mouseSliding=this._keySliding=false;this._animateOff=true;this._handleIndex=null;this._detectOrientation();this._mouseInit();this.element.addClass("ui-slider ui-slider-"+this.orientation+" ui-widget ui-widget-content ui-corner-all");b.disabled&&this.element.addClass("ui-slider-disabled ui-disabled");
                this.range=d([]);if(b.range){if(b.range===true){this.range=d("<div></div>");if(!b.values)b.values=[this._valueMin(),this._valueMin()];if(b.values.length&&b.values.length!==2)b.values=[b.values[0],b.values[0]]}else this.range=d("<div></div>");this.range.appendTo(this.element).addClass("ui-slider-range");if(b.range==="min"||b.range==="max")this.range.addClass("ui-slider-range-"+b.range);this.range.addClass("ui-widget-header")}d(".ui-slider-handle",this.element).length===0&&d("<a href='#'></a>").appendTo(this.element).addClass("ui-slider-handle");
                if(b.values&&b.values.length)for(;d(".ui-slider-handle",this.element).length<b.values.length;)d("<a href='#'></a>").appendTo(this.element).addClass("ui-slider-handle");this.handles=d(".ui-slider-handle",this.element).addClass("ui-state-default ui-corner-all");this.handle=this.handles.eq(0);this.handles.add(this.range).filter("a").click(function(c){c.preventDefault()}).hover(function(){b.disabled||d(this).addClass("ui-state-hover")},function(){d(this).removeClass("ui-state-hover")}).focus(function(){if(b.disabled)d(this).blur();
                    else{d(".ui-slider .ui-state-focus").removeClass("ui-state-focus");d(this).addClass("ui-state-focus")}}).blur(function(){d(this).removeClass("ui-state-focus")});this.handles.each(function(c){d(this).data("index.ui-slider-handle",c)});this.handles.keydown(function(c){var e=true,f=d(this).data("index.ui-slider-handle"),g,h,i;if(!a.options.disabled){switch(c.keyCode){case d.ui.keyCode.HOME:case d.ui.keyCode.END:case d.ui.keyCode.PAGE_UP:case d.ui.keyCode.PAGE_DOWN:case d.ui.keyCode.UP:case d.ui.keyCode.RIGHT:case d.ui.keyCode.DOWN:case d.ui.keyCode.LEFT:e=
                                                                false;if(!a._keySliding){a._keySliding=true;d(this).addClass("ui-state-active");g=a._start(c,f);if(g===false)return}break}i=a.options.step;g=a.options.values&&a.options.values.length?(h=a.values(f)):(h=a.value());switch(c.keyCode){case d.ui.keyCode.HOME:h=a._valueMin();break;case d.ui.keyCode.END:h=a._valueMax();break;case d.ui.keyCode.PAGE_UP:h=a._trimAlignValue(g+(a._valueMax()-a._valueMin())/5);break;case d.ui.keyCode.PAGE_DOWN:h=a._trimAlignValue(g-(a._valueMax()-a._valueMin())/5);break;case d.ui.keyCode.UP:case d.ui.keyCode.RIGHT:if(g===
                                                                                        a._valueMax())return;h=a._trimAlignValue(g+i);break;case d.ui.keyCode.DOWN:case d.ui.keyCode.LEFT:if(g===a._valueMin())return;h=a._trimAlignValue(g-i);break}a._slide(c,f,h);return e}}).keyup(function(c){var e=d(this).data("index.ui-slider-handle");if(a._keySliding){a._keySliding=false;a._stop(c,e);a._change(c,e);d(this).removeClass("ui-state-active")}});this._refreshValue();this._animateOff=false},destroy:function(){this.handles.remove();this.range.remove();this.element.removeClass("ui-slider ui-slider-horizontal ui-slider-vertical ui-slider-disabled ui-widget ui-widget-content ui-corner-all").removeData("slider").unbind(".slider");
                                                                                this._mouseDestroy();return this},_mouseCapture:function(a){var b=this.options,c,e,f,g,h,i;if(b.disabled)return false;this.elementSize={width:this.element.outerWidth(),height:this.element.outerHeight()};this.elementOffset=this.element.offset();c={x:a.pageX,y:a.pageY};e=this._normValueFromMouse(c);f=this._valueMax()-this._valueMin()+1;h=this;this.handles.each(function(j){var k=Math.abs(e-h.values(j));if(f>k){f=k;g=d(this);i=j}});if(b.range===true&&this.values(1)===b.min){i+=1;g=d(this.handles[i])}if(this._start(a,
                                                                                i)===false)return false;this._mouseSliding=true;h._handleIndex=i;g.addClass("ui-state-active").focus();b=g.offset();this._clickOffset=!d(a.target).parents().andSelf().is(".ui-slider-handle")?{left:0,top:0}:{left:a.pageX-b.left-g.width()/2,top:a.pageY-b.top-g.height()/2-(parseInt(g.css("borderTopWidth"),10)||0)-(parseInt(g.css("borderBottomWidth"),10)||0)+(parseInt(g.css("marginTop"),10)||0)};e=this._normValueFromMouse(c);this._slide(a,i,e);return this._animateOff=true},_mouseStart:function(){return true},
                                                                            _mouseDrag:function(a){var b=this._normValueFromMouse({x:a.pageX,y:a.pageY});this._slide(a,this._handleIndex,b);return false},_mouseStop:function(a){this.handles.removeClass("ui-state-active");this._mouseSliding=false;this._stop(a,this._handleIndex);this._change(a,this._handleIndex);this._clickOffset=this._handleIndex=null;return this._animateOff=false},_detectOrientation:function(){this.orientation=this.options.orientation==="vertical"?"vertical":"horizontal"},_normValueFromMouse:function(a){var b;
                                                                                if(this.orientation==="horizontal"){b=this.elementSize.width;a=a.x-this.elementOffset.left-(this._clickOffset?this._clickOffset.left:0)}else{b=this.elementSize.height;a=a.y-this.elementOffset.top-(this._clickOffset?this._clickOffset.top:0)}b=a/b;if(b>1)b=1;if(b<0)b=0;if(this.orientation==="vertical")b=1-b;a=this._valueMax()-this._valueMin();return this._trimAlignValue(this._valueMin()+b*a)},_start:function(a,b){var c={handle:this.handles[b],value:this.value()};if(this.options.values&&this.options.values.length){c.value=
                                                                                        this.values(b);c.values=this.values()}return this._trigger("start",a,c)},_slide:function(a,b,c){var e;if(this.options.values&&this.options.values.length){e=this.values(b?0:1);if(this.options.values.length===2&&this.options.range===true&&(b===0&&c>e||b===1&&c<e))c=e;if(c!==this.values(b)){e=this.values();e[b]=c;a=this._trigger("slide",a,{handle:this.handles[b],value:c,values:e});this.values(b?0:1);a!==false&&this.values(b,c,true)}}else if(c!==this.value()){a=this._trigger("slide",a,{handle:this.handles[b],
                                                                                        value:c});a!==false&&this.value(c)}},_stop:function(a,b){var c={handle:this.handles[b],value:this.value()};if(this.options.values&&this.options.values.length){c.value=this.values(b);c.values=this.values()}this._trigger("stop",a,c)},_change:function(a,b){if(!this._keySliding&&!this._mouseSliding){var c={handle:this.handles[b],value:this.value()};if(this.options.values&&this.options.values.length){c.value=this.values(b);c.values=this.values()}this._trigger("change",a,c)}},value:function(a){if(arguments.length){this.options.value=
                                                                                        this._trimAlignValue(a);this._refreshValue();this._change(null,0)}return this._value()},values:function(a,b){var c,e,f;if(arguments.length>1){this.options.values[a]=this._trimAlignValue(b);this._refreshValue();this._change(null,a)}if(arguments.length)if(d.isArray(arguments[0])){c=this.options.values;e=arguments[0];for(f=0;f<c.length;f+=1){c[f]=this._trimAlignValue(e[f]);this._change(null,f)}this._refreshValue()}else return this.options.values&&this.options.values.length?this._values(a):this.value();
                                                                                else return this._values()},_setOption:function(a,b){var c,e=0;if(d.isArray(this.options.values))e=this.options.values.length;d.Widget.prototype._setOption.apply(this,arguments);switch(a){case "disabled":if(b){this.handles.filter(".ui-state-focus").blur();this.handles.removeClass("ui-state-hover");this.handles.attr("disabled","disabled");this.element.addClass("ui-disabled")}else{this.handles.removeAttr("disabled");this.element.removeClass("ui-disabled")}break;case "orientation":this._detectOrientation();
                                                                                            this.element.removeClass("ui-slider-horizontal ui-slider-vertical").addClass("ui-slider-"+this.orientation);this._refreshValue();break;case "value":this._animateOff=true;this._refreshValue();this._change(null,0);this._animateOff=false;break;case "values":this._animateOff=true;this._refreshValue();for(c=0;c<e;c+=1)this._change(null,c);this._animateOff=false;break}},_value:function(){var a=this.options.value;return a=this._trimAlignValue(a)},_values:function(a){var b,c;if(arguments.length){b=this.options.values[a];
                                                                                                    return b=this._trimAlignValue(b)}else{b=this.options.values.slice();for(c=0;c<b.length;c+=1)b[c]=this._trimAlignValue(b[c]);return b}},_trimAlignValue:function(a){if(a<this._valueMin())return this._valueMin();if(a>this._valueMax())return this._valueMax();var b=this.options.step>0?this.options.step:1,c=a%b;a=a-c;if(Math.abs(c)*2>=b)a+=c>0?b:-b;return parseFloat(a.toFixed(5))},_valueMin:function(){return this.options.min},_valueMax:function(){return this.options.max},_refreshValue:function(){var a=
                                                                                                    this.options.range,b=this.options,c=this,e=!this._animateOff?b.animate:false,f,g={},h,i,j,k;if(this.options.values&&this.options.values.length)this.handles.each(function(l){f=(c.values(l)-c._valueMin())/(c._valueMax()-c._valueMin())*100;g[c.orientation==="horizontal"?"left":"bottom"]=f+"%";d(this).stop(1,1)[e?"animate":"css"](g,b.animate);if(c.options.range===true)if(c.orientation==="horizontal"){if(l===0)c.range.stop(1,1)[e?"animate":"css"]({left:f+"%"},b.animate);if(l===1)c.range[e?"animate":"css"]({width:f-
                                                                                                                h+"%"},{queue:false,duration:b.animate})}else{if(l===0)c.range.stop(1,1)[e?"animate":"css"]({bottom:f+"%"},b.animate);if(l===1)c.range[e?"animate":"css"]({height:f-h+"%"},{queue:false,duration:b.animate})}h=f});else{i=this.value();j=this._valueMin();k=this._valueMax();f=k!==j?(i-j)/(k-j)*100:0;g[c.orientation==="horizontal"?"left":"bottom"]=f+"%";this.handle.stop(1,1)[e?"animate":"css"](g,b.animate);if(a==="min"&&this.orientation==="horizontal")this.range.stop(1,1)[e?"animate":"css"]({width:f+"%"},
                                                                                                    b.animate);if(a==="max"&&this.orientation==="horizontal")this.range[e?"animate":"css"]({width:100-f+"%"},{queue:false,duration:b.animate});if(a==="min"&&this.orientation==="vertical")this.range.stop(1,1)[e?"animate":"css"]({height:f+"%"},b.animate);if(a==="max"&&this.orientation==="vertical")this.range[e?"animate":"css"]({height:100-f+"%"},{queue:false,duration:b.animate})}}});d.extend(d.ui.slider,{version:"1.8.2"})})(jQuery);
                                                                                    ;

	
	
                                                                                    var init_sliders = function()  {
                                                                                        $(".slider").each(function(index, object) {
                                                                                            var slider = $(object).slider();
                                                                                            var target = $(slider.attr("target"));
                                                                                            var minus = $(slider.attr("minus")).next();
                                                                                            var total = slider.attr("total");
    
                                                                                            if (max = slider.attr("max"))
                                                                                                slider.slider("option", "max", parseInt(max.toString()));

                                                                                            if (min = slider.attr("min"))
                                                                                                slider.slider("option", "min", parseInt(min.toString()));
      
                                                                                            if (min = slider.attr("step"))
                                                                                                slider.slider("option", "step", parseInt(min.toString()));
    
                                                                                            if (target.length)
                                                                                            {
                                                                                                target.interval = null;
                                                                                                slider.interval = null;

                                                                                                var update_target = function() {      
                                                                                                    target.attr("value", parseInt(slider.slider("value").toString()) || 0);  
                                                                                                    if(minus.length && total) {
			
                                                                                                        var rest = total - (parseInt(target.attr("value").toString()) || 0);
                                                                                                        if(rest==0)
                                                                                                            rest=1;
                                                                                                        if(minus.slider("value") > rest)
                                                                                                            minus.slider("value",rest);
                                                                                                    }		
                                                                                                }

                                                                                                var update_slider = function() {      
                                                                                                    slider.slider("value", parseInt(target.attr("value").toString()) || 0);      
		
                                                                                                }

                                                                                                slider.bind("slidestart", function() {
                                                                                                    slider.interval = setInterval(update_target, 200);
                                                                                                    update_target();
                                                                                                });

                                                                                                slider.bind("slidestop", function() {     
                                                                                                    clearInterval(slider.interval);
                                                                                                    slider.interval = null;      
                                                                                                });

                                                                                                slider.bind("slidechange", function() {
                                                                                                    if (target.interval == null) update_target();
                                                                                                });

                                                                                                target.bind("focusin", function() {
                                                                                                    target.interval = setInterval(update_slider, 300);
                                                                                                });

                                                                                                target.bind("focusout", function() {
                                                                                                    target.attr("value", parseInt(slider.slider("value").toString()) || 0);
                                                                                                    clearInterval(target.interval);
                                                                                                    target.interval = null;
                                                                                                });

                                                                                                update_slider();
                                                                                            }
                                                                                        });
                                                                                    }


                                                                                    {/literal}
</script>

<script type="text/javascript" src="{$system_url}templates/common/facebox/facebox.js"></script>
<link media="all" type="text/css" rel="stylesheet" href="{$system_url}templates/common/facebox/facebox.css" />
<style type="text/css">
    {literal}
    .details .detail-item {
        float:left;
        padding:6px 22px;
        width:370px;
    }
    .details h4 {
        color:#333333;
        margin:0px;
        font-size:13px;
        margin-bottom:5px;}
    .details .detail-item p.value {
        color:#444444;
        float:right;
        font-size:13px;
        font-weight:bold;
    }
    .details .detail-item span.free-space {
        color:#666666;
        font-size:11px;
        font-weight:normal;
    }
    .details .detail-item h4, p.value {
        margin:0;
        padding:2px 0 4px;
        line-height:normal !important;
    }
    .details .status-bar {
        background:url("{/literal}{$system_url}{literal}includes/types/onappcloud/images/progress-bg.png") repeat scroll 0 0 #5A5A5A;
        border-bottom:1px solid #8F8F8F;
        border-top:1px solid #555555;
        clear:both;
        height:30px;
    }
    .details .detail-item h4 {
        float:left;

    }
    .details .status-bar .usage {
        background:url("{/literal}{$system_url}includes/types/soluspanel/{literal}bb_ga.gif") repeat-x scroll 0 0 #21a4c5;
        float:left;
        height:30px;
        outline:1px solid #AAAAAA;
    }
    .details .status-bar p.min {
        float:left;
        margin-left:0;
    }
    .details .status-bar p.max {
        float:right;
        margin-right:0;
    }
    .details .status-bar p {
        clear:both;
        color:#DDDDDD;
        margin-top:-28px;
        padding:4px 10px;
    }




    .page_tabs {
        margin-bottom:-1px;
        margin-top:0;
        position:relative;
        width:870px;
        z-index:10;
        margin:0px;
        padding:0px;
        overflow:hidden;
        list-style:none;
    }

    .page_tabs li {

        display:block;
        float:left;
        margin:20px 5px 0 0;
    }
    .page_tabs li a.active {
        background:url("{/literal}{$system_url}{literal}includes/types/vpscloud/images/nav-repeat-active.gif") repeat-x scroll 0 0 transparent;
        color:#000000;
        height:31px;
        margin-bottom:-3px;
        margin-top:0;
    }
    .page_tabs li a span {
        display:block;
        float:left;
    }

    .page_tabs li a.active .left-border {
        background:url("{/literal}{$system_url}{literal}includes/types/vpscloud/images/nav-left-active.gif") no-repeat scroll 0 0 transparent;
        height:31px;
        width:5px;
        float:left;
        display:block
    }
    .page_tabs li a.active .right-border {
        background:url("{/literal}{$system_url}{literal}includes/types/vpscloud/images/nav-right-active.gif") no-repeat scroll 0 0 transparent;
        height:31px;
        width:5px;
    }
    .page_tabs li a:hover {
        text-decoration:underline;
    }
    .page_tabs li a {
        background:url("{/literal}{$system_url}{literal}includes/types/vpscloud/images/nav-repeat.gif") repeat-x scroll 0 0 transparent;
        color:#4E4E4E;
        display:block;
        float:left;
        font-size:100%;
        height:25px;
        margin-bottom:3px;
        margin-top:3px;
        overflow:hidden;
        padding:0;
        text-decoration:none;
    }
    .page_tabs li a .text {
        padding:5px 5px 0;
    }
    .page_tabs li a .right-border {
        background:url("{/literal}{$system_url}{literal}includes/types/vpscloud/images/nav-right.gif") no-repeat scroll 0 0 transparent;
        float:left;
        height:26px;
        width:5px;
    }
    .page_tabs li a .left-border {
        background:url("{/literal}{$system_url}{literal}includes/types/vpscloud/images/nav-left.gif") no-repeat scroll 0 0 transparent;
        height:26px;
        width:5px;
    }	

    .virtual-machine-details-content {
        background:url("{/literal}{$system_url}{literal}includes/types/vpscloud/images/content-repeat-wide.gif") repeat-y scroll 0 0 transparent;
        padding:10px;
    }
    .virtual-machine-details-bottom {
        background:url("{/literal}{$system_url}{literal}includes/types/vpscloud/images/content-bottom-wide.gif") no-repeat scroll 0 0 transparent;
        height:5px;
        width:936px;
    }
    .virtual-machine-details {
        float:left;
        position:relative;
        width:876px;

        z-index:1;
    }
    td.right-aligned b{
        padding-right: 10px;
    }
    .virtual-machine-details .grey-bar {
        background:url("{/literal}{$system_url}{literal}includes/types/vpscloud/images/under-nav-bar-wide.gif") no-repeat scroll 0 0 transparent;
        height:27px;
        margin-top:-3px;
        overflow:hidden;
    }
    .grey-bar dl.actions dt {
        float:left;
    }
    .grey-bar dl.actions {
        float:right;
        margin:0 10px;
        overflow:hidden;
    }
    .grey-bar dl.actions dd {
        float:left;
        font-size:95%;
        margin-left:10px;
    }
    .grey-bar dl.actions dd a:hover { text-decoration:underline;}
    .grey-bar dl.actions dd a.shutdown { background-image:url({/literal}{$system_url}{literal}includes/types/vpscloud/images/shutdown-vm.png);}
    .grey-bar dl.actions dd a.power-off { background-image:url({/literal}{$system_url}{literal}includes/types/vpscloud/images/power-off-vm.png);}
    .grey-bar dl.actions dd a.startup { background-image:url({/literal}{$system_url}{literal}includes/types/vpscloud/images/startup-vm.png);}
    .grey-bar dl.actions dd a.edit { background-image:url({/literal}{$system_url}{literal}includes/types/vpscloud/images/edit-vm.png);}
    .grey-bar dl.actions dd a.delete { background-image:url({/literal}{$system_url}{literal}includes/types/vpscloud/images/delete-vm.png); }
    .grey-bar dl.actions dd a.new-backup { background-image:url({/literal}{$system_url}{literal}includes/types/vpscloud/images/backup.png); }
    .grey-bar dl.actions dd a.reboot { background-image:url({/literal}{$system_url}{literal}includes/types/vpscloud/images/reboot-vm.png);}
    .grey-bar dl.actions dd a { padding:2px 0px 2px 20px; background-position:0px 1px; background-repeat:no-repeat; display:block; margin-top:5px; color:#005bb8; text-decoration:none;}

    span.yes { background-image:url({/literal}{$system_url}{literal}includes/types/vpscloud/images/tick.png);padding:2px 0px 2px 20px; background-position:0px 1px; background-repeat:no-repeat; margin-top:5px; color:#005bb8; text-decoration:none; }
    span.no { background-image:url({/literal}{$system_url}{literal}includes/types/vpscloud/images/cross.png);padding:2px 0px 2px 20px; background-position:0px 1px; background-repeat:no-repeat; margin-top:5px; color:#005bb8; text-decoration:none; }
    a.bkpdelete {background-image:url({/literal}{$system_url}{literal}includes/types/vpscloud/images/delete-vm.png);padding:2px 0px 2px 20px; background-position:0px 1px; background-repeat:no-repeat; margin-top:5px; color:#005bb8; }
    a.bkprestore {background-image:url({/literal}{$system_url}{literal}includes/types/vpscloud/images/restore-backup.png);padding:2px 0px 2px 20px; background-position:0px 1px; background-repeat:no-repeat; margin-top:5px; color:#C13700; }
    a.linfo {margin-left:5px;background-image:url({/literal}{$system_url}{literal}includes/types/vpscloud/images/helpi.png);padding:2px 0px 2px 20px; background-position:0px 1px; background-repeat:no-repeat; margin-top:5px; color:#C13700; }

    .power-status .yes {
        background:url("{/literal}{$system_url}{literal}includes/types/vpscloud/images/vm-on.png") no-repeat scroll 0 0 transparent;
        display:block;
        height:16px;
        text-indent:-99999px;
        width:16px;

    }

    .power-status .no {
        background:url("{/literal}{$system_url}{literal}includes/types/vpscloud/images/vm-off.png") no-repeat scroll 0 0 transparent;
        display:block;
        height:16px;
        text-indent:-99999px;
        width:16px;
    }
    .right-aligned {
        text-align:right;
    }
    .ttable td {
        padding:3px 4px;
    }
    .ttable a.xmore {
        font-size: 10px;
        font-weight: bold;
    }
    table.data-table.backups-list thead {
        border:1px solid #DDDDDD;
    }
    table.data-table.backups-list thead {
        border-left:1px solid #005395;
        border-right:1px solid #005395;
    }
    table.data-table.backups-list thead {
        font-size:80%;
        font-weight:bold;
        text-transform:uppercase;
    }
    table.data-table.backups-list thead td {
        background:none repeat scroll 0 0 #777777;
        color:#FFFFFF;
        padding:8px 5px;
    }
    table.data-table tbody td {
        background:none repeat scroll 0 0 #FFFFFF;
        border-top:1px solid #DDDDDD;
    }
    table.data-table tbody tr:hover td {
        background-color: #FFF5BD;
    }
    table.data-table tbody tr td {
        border-color:-moz-use-text-color #DDDDDD #DDDDDD;
        border-right:1px solid #DDDDDD;
        border-style:none solid solid;
        border-width:0 1px 1px;
        font-size:90%;
        padding:8px;
    }
    div.step-part {
        background-color:#F5F5F5;
        padding: 10px;
    }
    h4 {margin:10px}
    table.billingtable td {
        padding: 6px;
    }
    table.billingtable td.title {
        font-weight: bold;
    }
    {/literal}
</style>
<script type="text/javascript" src="{$system_url}templates/common/facebox/facebox.js"></script>
<link media="all" type="text/css" rel="stylesheet" href="{$system_url}templates/common/facebox/facebox.css" />



{if $service}
{if $service.status!='Active'}
<div class="wbox" id="billing_info" >
    <div class="wbox_header">{$lang.billing_info|capitalize}
	<a class="delete right" style="text-decoration:none;font-weight:normal"  href="?cmd=clientarea&action=services&service={$service.id}&cid={$service.category_id}&cancel"><span class="no">{$lang.cancelrequest}</span></a>
	</div>
    <div class="wbox_content">
        <table width="100%" cellspacing="0" cellpadding="0" border="0" class="checker">
			{include file='service_billing.tpl'}
        </table>
    </div>
</div>
{else}
<ul class="page_tabs">
    <li><a href="?cmd=clientarea&action=services&service={$service.id}"  class="{if !$vpsdo}active{/if}" ><span class="left-border"></span><span class="text">{$lang.overview}</span><span class="right-border"></span></a></li>
    <li><a href="?cmd=clientarea&action=services&service={$service.id}&vpsdo={if $service.options=='KVM' || ($service.type == 'Xen HVM' && $is_windows)}{*VNC IS needed for KVM and HVM*}vnc{else}console{/if}" class="{if $vpsdo=='console'}active{/if}" ><span class="left-border"></span><span class="text">{if $service.type=='KVM' || ($service.type == 'Xen HVM' && $is_windows) }VNC{else}SSH{/if} {$lang.Console}</span><span class="right-border"></span></a></li>

    {if $nfo.loadgraph!=''}
    <li><a href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=cpu" class="{if $vpsdo=='cpu'}active{/if}"><span class="left-border"></span><span class="text">{$lang.cpucharts}</span><span class="right-border"></span></a></li>
    {/if}
    {if $nfo.memorygraph!=''}
    <li><a href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=memory" class="{if $vpsdo=='memory'}active{/if}"><span class="left-border"></span><span class="text">Memory Usage</span><span class="right-border"></span></a></li>
    {/if}
    {if $nfo.trafficgraph!=''}
    <li><a href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=bandwidth" class="{if $vpsdo=='bandwidth'}active{/if}"><span class="left-border"></span><span class="text">{$lang.bwcharts}</span><span class="right-border"></span></a></li>
	{/if}
	{if $addons}{foreach from=$addons item=addon}
		{if $addon.templated}{foreach from=$addon.templated item=it}
    <li><a href="?cmd=clientarea&amp;action=addonmodule&amp;id={$service.id}&amp;addon_id={$addon.id}&amp;call={$it}" onclick="return process('{$it}',{$service.id},'#_ocustom',{$addon.id})"><span class="left-border"></span><span class="text">{if $lang.$it}{$lang.$it}{else}{$it}{/if}</span><span class="right-border"></span></a></li>
		{/foreach}{/if}
		{if $addon.methods}{foreach from=$addon.methods item=it}
    <li><a href="?cmd=clientarea&amp;action=addonmodule&amp;id={$service.id}&amp;addon_id={$addon.id}&amp;call={$it}"><span class="left-border"></span><span class="text">{if $lang.$it}{$lang.$it}{else}{$it}{/if}</span><span class="right-border"></span></a></li>
		{/foreach}{/if}
	{/foreach}{/if}
    <li style="float: right"><a href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=billing" class="{if $vpsdo=='billing'}active{/if}"><span class="left-border"></span><span class="text">{$lang.billing_info}</span><span class="right-border"></span></a></li>
	{if $upgrades}
    <li style="float: right"><a href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=upgrade" class="{if $vpsdo=='upgrade'}active{/if}"><span class="left-border"></span><span class="text"><strong>{$lang.Upgrade}</strong></span><span class="right-border"></span></a></li>
	{/if}
</ul>

<div class="virtual-machine-details wide">
    <div class="grey-bar">
        <dl class="actions">
            {if $service.status=='Active' && !$vpsdo}
            <dt></dt>
            {if $vpsdetails.power_action_pending}
            <dd><a href="?cmd=clientarea&action=services&service={$service.id}" ><img src="includes/types/soluspanel/assets/arrow_refresh_small.gif" /></a></dd>
            <dt></dt>
            <dd style="display:block;margin-top:5px;padding:2px 0 2px 20px;">{$lang.vpsrunning}</dd>
            {else}
            {if $nfo.state=='online'}
            <dd><a onclick="return confirm('{$lang.sure_to_shutdown}?');" class="shutdown" href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=shutdown">{$lang.Shutdown}</a></dd>
            <dt></dt>
            <dd><a onclick="return confirm('{$lang.sure_to_reboot}?');" class="reboot" href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=reboot">{$lang.GracefulReboot}</a></dd>
            {else}

            <dd><a class="startup" href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=poweron">{$lang.Startup}</a></dd>
            {/if}
            {/if}
            <dt></dt>
            <dd><a  class="delete" href="?cmd=clientarea&action=services&service={$service.id}&cid={$service.category_id}&cancel">{$lang.cancelrequest}</a></dd>
            <dt></dt>
            <dd><a class="reboot" href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=reinstall">{$lang.ReinstallVPS}</a></dd>
            {if $vpsaddons.ip.available}
            <dt></dt>
            <dd><a class="new-backup" href="?cmd=cart&amp;action=add&amp;cat_id=addons&amp;id={$vpsaddons.ip.id}&amp;account_id={$service.id}&amp;addon_cycles[{$vpsaddons.ip.id}]={$vpsaddons.ip.paytype}" >{$lang.ordernewip}</a></dd>
					{/if}
            {/if}
        </dl>
    </div>


    <div class="virtual-machine-details-content">

        <div class="top-background">

				{if $vpsdo=='console'}

            <div style="text-align: center;">
                <div style="margin: 24px">Username: <b style="padding-right: 100px">{$console.username}</b> Password: <b  style="padding-right: 100px">{$console.password}</b> <!-- <a style="padding-right: 100px" href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=changeclipass"><small>change</small></a> --> Root Password: <strong>{$console.rootpass}</strong> <a href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=changeclipass"><small>change</small></a></div>
                <applet width="640" height="480" archive="SSHTermApplet-signed.jar,SSHTermApplet-jdkbug-workaround-signed.jar,SSHTermApplet-jdk1.3.1-dependencies-signed.jar" code="com.sshtools.sshterm.SshTermApplet" codebase="includes/libs/sshterm-applet/" style="display: block; border:1px solid #d0d5e4; padding: 0px; margin: 24px auto 24px auto;">
                    <param name="sshapps.connection.host" value="{$console.ip}">
                    <param name="sshapps.connection.port" value="{$console.port}">
                    <param name="sshapps.connection.userName" value="{$console.username}">
                    <param name="sshapps.connection.showConnectionDialog" value="false">
                    <param name="sshapps.connection.authenticationMethod" value="password">
                    <param name="sshapps.connection.connectImmediately" value="true">
                </applet>
            </div>

				{elseif $vpsdo=='vnc'}

            <div style="text-align: center;">
                <div style="margin: 24px">VNC Password: <strong>{$vnc.password}</strong></div>
                <applet archive="/java/vnc/VncViewer.jar" code="VncViewer.class" codebase="http://{$vnc.vncpath}:5353/" height="560" width="700">
                    <param name="PORT" value="{$vnc.port}">
                    <param name="HOST" value="{$vnc.ip}">
                    <param name="PASSWORD" value="{$vnc.password}">
                </applet>
            </div>
        </div>

				{elseif $vpsdo=='upgrade'}
        <div style="width: 420px;margin:auto">
            <div style="float: left;line-height:25px; font-weight: bold" >{$lang.upgradeyourvps}:</div>
            <div style="float:right;">
						{if $upgrades=='-1'}
						{$lang.upgrade_due_invoice}
						{else}
                <form action="" method="post" class="form-horizontal">
                    <input type="hidden" value="upgrade" name="make" />
                    <div style="margin-bottom:10px;">
                        <select  name="upgrades" onchange="sss(this)">
                            {foreach from=$upgrades item=up}
                                <option value="{$up.id}">{$up.catname}: {$up.name}</option>
                            {/foreach}
                        </select>
                    </div>
                    <div class="fs11" id="up_descriptions" style="margin: 10px 0;">
                        {foreach from=$upgrades item=up key=k}
                            <span {if $k!=0}style="display:none"{/if} class="up_desc">{$up.description}</span>
                        {/foreach}
                    </div>
                    <div id="billing_options">
                        {foreach from=$upgrades item=i key=k}
                            <div {if $k!=0}style="display:none"{/if} class="up_desc">
                            {if $i.paytype=='Free'}
                                <input type="hidden" name="cycle[{$i.id}]" value="Free" />
                                        {$lang.price}: <strong> {$lang.Free}</strong>
                                        {elseif $i.paytype=='Once'}
                                <input type="hidden" name="cycle[{$i.id}]" value="Once" />
                                        {$lang.price}: {$i.m|price:$currency} {$lang.once}
                                        {else}
                                        {$lang.pickcycle}
                                <select name="cycle[{$i.id}]">
                                            {if $i.d!=0}<option value="d" {if $i.cycle=='d'}selected="selected"{/if}>{$i.d|price:$currency} {$lang.d}</option>{/if}
                                            {if $i.w!=0}<option value="w" {if $i.cycle=='w'}selected="selected"{/if}>{$i.w|price:$currency} {$lang.w}</option>{/if}
                                            {if $i.m!=0}<option value="m" {if $i.cycle=='m'}selected="selected"{/if}>{$i.m|price:$currency} {$lang.m}</option>{/if}
                                            {if $i.q!=0}<option value="q" {if $i.cycle=='q'}selected="selected"{/if}>{$i.q|price:$currency} {$lang.q}</option>{/if}
                                            {if $i.s!=0}<option value="s" {if $i.cycle=='s'}selected="selected"{/if}>{$i.s|price:$currency} {$lang.s}</option>{/if}
                                            {if $i.a!=0}<option value="a" {if $i.cycle=='a'}selected="selected"{/if}>{$i.a|price:$currency} {$lang.a}</option>{/if}
                                            {if $i.b!=0}<option value="b" {if $i.cycle=='b'}selected="selected"{/if}>{$i.b|price:$currency} {$lang.b}</option>{/if}
                                            {if $i.t!=0}<option value="t" {if $i.cycle=='t'}selected="selected"{/if}>{$i.t|price:$currency} {$lang.t}</option>{/if}
                                    </select>
                                        {/if}
                            </div>
                        {/foreach}
                    </div>
                    <br />
                    <center><input type="submit" value="{$lang.continue}" style="font-weight:bold" class="btn"/></center>
            </div>
            <script type="text/javascript">
                {literal}
                function sss(el) {
                $('.up_desc').hide();
                var index=$(el).eq(0).prop('selectedIndex');
                $('#up_descriptions .up_desc').eq(index).show();
                $('#billing_options .up_desc').eq(index).show();
                }
                {/literal}
            </script>
            </form>
					{/if}
        </div>
        <div class="clear"></div></div>


				{elseif $vpsdo=='billing'}


    <table cellpadding="0" cellspacing="0" class="billingtable">
        <tr>
            <td class="title" width="160" align="right">{$lang.registrationdate}</td>
            <td>{$service.date_created|dateformat:$date_format}</td>
            <td width="40%" class="title" align="right">{$lang.service}</td>
            <td>{$service.catname} - {$service.name} </td>
        </tr>
        <tr>
            <td class="title" align="right">{$lang.firstpayment_amount}</td>
            <td>{$service.firstpayment|price:$currency}</td>
            <td class="title" align="right">{$lang.reccuring_amount}</td>
            <td>{$service.total|price:$currency}</td>
        </tr>
					{if $service.billingcycle!='Free' && $service.billingcycle!='Once'}
        <tr >
            <td class="title" align="right">{$lang.bcycle}</td>
            <td>{$lang[$service.billingcycle]}</td>
            <td class="title" align="right">{$lang.nextdue}</td>
            <td>{$service.next_due|dateformat:$date_format}</td>
        </tr>
					{/if}
    </table>

				{elseif $vpsdo=='changerootpass'}

    <div style="text-align: center; margin-bottom: 24px;">
        <h3><br />root password</h3>
        <form action="?cmd=clientarea&action=services&service={$service.id}&vpsdo=changerootpass" method="post">
            <input type="password" name="rootpass" value="" /><input type="submit" value="Change" />
        </form>
    </div>

				{elseif $vpsdo=='changeclipass'}

    <div style="text-align: center; margin-bottom: 24px;">
        <h3><br />console password</h3>
        <form action="?cmd=clientarea&action=services&service={$service.id}&vpsdo=changeclipass" method="post">
            <input type="password" name="clipass" value="" /><input type="submit" value="Change" />
        </form>
    </div>

				{elseif $vpsdo=='cpu'}

    <div style="text-align: center; margin-bottom: 24px;">
        <h3><br />{$lang.dayusage}</h3>
        <img src="{$nfo.loadgraph}" class="periodval" />
    </div>

				{elseif $vpsdo=='memory'}

    <div style="text-align: center; margin-bottom: 24px;">
        <h3><br />{$lang.dayusage}</h3>
        <img src="{$nfo.memorygraph}" class="periodval" />
    </div>

				{elseif $vpsdo=='bandwidth'}

    <div style="text-align: center; margin-bottom: 24px;">
        <h3><br />{$lang.dayusage}</h3>
        <img src="{$nfo.trafficgraph}" class="periodval" />
    </div>

				{elseif $vpsdo=='reinstall'}

    <!-- reinstall start -->
    <h3><br />{$lang.ReinstallVPS}<br/></h3>
    {$lang.choose_template1} <font color="#cc0000">{$lang.choose_template2}</font><br /><br />{$lang.choose_template3}
    {if $ostemplates}
    <div style="padding:10px; text-align: center; width:850px">
        <form action="" method="post">
            <select name="os">
	                			{foreach from=$ostemplates item=templt}
                <option value="{$templt[0]}">{$templt[1]} {if $templt[2] && $templt[2]>0} ({$templt[2]|price:$currency}){/if}</option>
	                			{/foreach}
            </select>
            <input type="submit" value="{$lang.ReinstallVPS}" name="changeos" />
        </form>
    </div>
    {else}
    <div style="color: red; text-align: center; width:850px"><strong>{$lang.ostemplates_error}</strong></div>
    {/if}
    <!-- reinstall end -->

				{else}

    <!-- overview start -->
    <table cellpadding="4" width="100%" class="ttable">
        <tbody>
            <tr>
                <td width="50%">
                    <table style="width: 100%;">
                        <tr>
                            <td class="right-aligned" width="50%"><b>{$lang.hostname}</b></td>
                            <td class="courier-font"  width="50%">{$service.domain}</td>
                        </tr>
                        <tr>
                            <td class="right-aligned"><b>{$lang.ostemplate}</b></td>
                            <td class="courier-font">  {$service.os} </td>
                        </tr>
                        <tr>
                            <td class="right-aligned"><b>{$lang.status}</b></td>
                            <td class="power-status">{if $nfo.state=='online'}<span class="yes">Yes</span>{else}<span class="no">No</span>{/if}</td>
                        </tr>
                        <tr>
                            <td class="right-aligned"><b>{$lang.inirootpass}</b></td>
                            <td>{$rpass} <a href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=changerootpass"><small>change</small></a></td>
                        </tr>
                        <tr>
                            <td class="right-aligned" valign="top"><b>{$lang.ipadd}</b><br /></td>
                            <td class="courier-font">{foreach from=$nfo.ipaddresses item=ip}<a style="display: block;" href="http://{$ip}">{$ip}</a> {/foreach}</td>
                        </tr>
                    </table>
                </td>
                <td width="50%">
                    <div class="details statistics">
                        <div class="detail-item">
                            <h4>Disk Usage</h4>
                            <p class="value">
										{$nfo.hdd.used} / {$nfo.hdd.total}
                                <span class="free-space">({$nfo.hdd.free} free)</span>
                            </p>
                            <div class="status-bar">
                                <div style="width: {$nfo.hdd.percent};" class="usage"></div>
                                <p class="min">{$nfo.hdd.used}</p>
                                <p class="max">{$nfo.hdd.total}</p>
                            </div>
                        </div>
                        <div class="detail-item">
                            <h4>Memory Usage</h4>
                            <p class="value">
										{$nfo.memory.used} / {$nfo.memory.total}
                                <span class="free-space">({$nfo.memory.free} free)</span>
                            </p>
                            <div class="status-bar">
                                <div style="width: {$nfo.memory.percent};" class="usage"></div>
                                <p class="min">{$nfo.memory.used}</p>
                                <p class="max">{$nfo.memory.total}</p>
                            </div>
                        </div>
                        <div class="detail-item">
                            <h4>Bandwidth Usage</h4>
                            <p class="value">
										{$nfo.bandwidth.used} / {$nfo.bandwidth.total}
                                <span class="free-space">({$nfo.bandwidth.free} free)</span>
                            </p>
                            <div class="status-bar">
                                <div style="width: {$nfo.bandwidth.percent};" class="usage"></div>
                                <p class="min">{$nfo.bandwidth.used}</p>
                                <p class="max">{$nfo.bandwidth.total}</p>
                            </div>
                        </div>
                    </div>
                </td>
            </tr>
        </tbody>
    </table><!-- overview end -->
    <script type="text/javascript">
                                                                                        {literal}
                                                                                        function animate_sliders() {
                                                                                            $('.status-bar .usage').each(function(){
                                                                                                var w=$(this).width();
                                                                                                $(this).width(0);
                                                                                                $(this).animate({width:w},'slow');
                                                                                            });
                                                                                        }
                                                                                        appendLoader('animate_sliders');
                                                                                        {/literal}
    </script>
				{/if}

</div>
</div>
<div class="virtual-machine-details-bottom"></div>
</div>
<div class="clear"></div>
	{/if}
{/if}