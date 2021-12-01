/**
 * ====================================================================
 * About
 * ====================================================================
 * Sarissa is an ECMAScript library acting as a cross-browser wrapper for native XML APIs.
 * The library supports Gecko based browsers like Mozilla and Firefox,
 * Internet Explorer (5.5+ with MSXML3.0+), Konqueror, Safari and a little of Opera
 * @version 0.9.6.1
 * @author: Manos Batsis, mailto: mbatsis at users full stop sourceforge full stop net
 * ====================================================================
 * Licence
 * ====================================================================
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 2 or
 * the GNU Lesser General Public License version 2.1 as published by
 * the Free Software Foundation (your choice between the two).
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License or GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * or GNU Lesser General Public License along with this program; if not,
 * write to the Free Software Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 * or visit http://www.gnu.org
 *
 */
/**
 * <p>Sarissa is a utility class. Provides "static" methods for DOMDocument and
 * XMLHTTP objects, DOM Node serializatrion to XML strings and other goodies.</p>
 * @constructor
 */
function Sarissa(){};
/** @private */
Sarissa.PARSED_OK = "Document contains no parsing errors";
/**
 * Tells you whether transformNode and transformNodeToObject are available. This functionality
 * is contained in sarissa_ieemu_xslt.js and is deprecated. If you want to control XSLT transformations
 * use the XSLTProcessor
 * @deprecated
 * @type boolean
 */
Sarissa.IS_ENABLED_TRANSFORM_NODE = false;
/**
 * tells you whether XMLHttpRequest (or equivalent) is available
 * @type boolean
 */
Sarissa.IS_ENABLED_XMLHTTP = false;
/**
 * tells you whether selectNodes/selectSingleNode is available
 * @type boolean
 */
Sarissa.IS_ENABLED_SELECT_NODES = false;
var _sarissa_iNsCounter = 0;
var _SARISSA_IEPREFIX4XSLPARAM = "";
var _SARISSA_HAS_DOM_IMPLEMENTATION = document.implementation && true;
var _SARISSA_HAS_DOM_CREATE_DOCUMENT = _SARISSA_HAS_DOM_IMPLEMENTATION && document.implementation.createDocument;
var _SARISSA_HAS_DOM_FEATURE = _SARISSA_HAS_DOM_IMPLEMENTATION && document.implementation.hasFeature;
var _SARISSA_IS_MOZ = _SARISSA_HAS_DOM_CREATE_DOCUMENT && _SARISSA_HAS_DOM_FEATURE;
var _SARISSA_IS_SAFARI = (navigator.userAgent && navigator.vendor && (navigator.userAgent.toLowerCase().indexOf("applewebkit") != -1 || navigator.vendor.indexOf("Apple") != -1));
var _SARISSA_IS_IE = document.all && window.ActiveXObject && navigator.userAgent.toLowerCase().indexOf("msie") > -1  && navigator.userAgent.toLowerCase().indexOf("opera") == -1;
if(!window.Node || !window.Node.ELEMENT_NODE){
    var Node = {ELEMENT_NODE: 1, ATTRIBUTE_NODE: 2, TEXT_NODE: 3, CDATA_SECTION_NODE: 4, ENTITY_REFERENCE_NODE: 5,  ENTITY_NODE: 6, PROCESSING_INSTRUCTION_NODE: 7, COMMENT_NODE: 8, DOCUMENT_NODE: 9, DOCUMENT_TYPE_NODE: 10, DOCUMENT_FRAGMENT_NODE: 11, NOTATION_NODE: 12};
};

// IE initialization
if(_SARISSA_IS_IE){
    // for XSLT parameter names, prefix needed by IE
    _SARISSA_IEPREFIX4XSLPARAM = "xsl:";
    // used to store the most recent ProgID available out of the above
    var _SARISSA_DOM_PROGID = "";
    var _SARISSA_XMLHTTP_PROGID = "";
    /**
     * Called when the Sarissa_xx.js file is parsed, to pick most recent
     * ProgIDs for IE, then gets destroyed.
     * @param idList an array of MSXML PROGIDs from which the most recent will be picked for a given object
     * @param enabledList an array of arrays where each array has two items; the index of the PROGID for which a certain feature is enabled
     */
    pickRecentProgID = function (idList, enabledList){
        // found progID flag
        var bFound = false;
        for(var i=0; i < idList.length && !bFound; i++){
            try{
                var oDoc = new ActiveXObject(idList[i]);
                o2Store = idList[i];
                bFound = true;
                for(var j=0;j<enabledList.length;j++)
                    if(i <= enabledList[j][1])
                        Sarissa["IS_ENABLED_"+enabledList[j][0]] = true;
            }catch (objException){
                // trap; try next progID
            };
        };
        if (!bFound)
            throw "Could not retreive a valid progID of Class: " + idList[idList.length-1]+". (original exception: "+e+")";
        idList = null;
        return o2Store;
    };
    // pick best available MSXML progIDs
    _SARISSA_DOM_PROGID = pickRecentProgID(["Msxml2.DOMDocument.5.0", "Msxml2.DOMDocument.4.0", "Msxml2.DOMDocument.3.0", "MSXML2.DOMDocument", "MSXML.DOMDocument", "Microsoft.XMLDOM"], [["SELECT_NODES", 2],["TRANSFORM_NODE", 2]]);
    _SARISSA_XMLHTTP_PROGID = pickRecentProgID(["Msxml2.XMLHTTP.5.0", "Msxml2.XMLHTTP.4.0", "MSXML2.XMLHTTP.3.0", "MSXML2.XMLHTTP", "Microsoft.XMLHTTP"], [["XMLHTTP", 4]]);
    _SARISSA_THREADEDDOM_PROGID = pickRecentProgID(["Msxml2.FreeThreadedDOMDocument.5.0", "MSXML2.FreeThreadedDOMDocument.4.0", "MSXML2.FreeThreadedDOMDocument.3.0"]);
    _SARISSA_XSLTEMPLATE_PROGID = pickRecentProgID(["Msxml2.XSLTemplate.5.0", "Msxml2.XSLTemplate.4.0", "MSXML2.XSLTemplate.3.0"], [["XSLTPROC", 2]]);
    // we dont need this anymore
    pickRecentProgID = null;
    //============================================
    // Factory methods (IE)
    //============================================
    // see non-IE version
    Sarissa.getDomDocument = function(sUri, sName){
        var oDoc = new ActiveXObject(_SARISSA_DOM_PROGID);
        // if a root tag name was provided, we need to load it in the DOM
        // object
        if (sName){
            // if needed, create an artifical namespace prefix the way Moz
            // does
            if (sUri){
                oDoc.loadXML("<a" + _sarissa_iNsCounter + ":" + sName + " xmlns:a" + _sarissa_iNsCounter + "=\"" + sUri + "\" />");
                // don't use the same prefix again
                ++_sarissa_iNsCounter;
            }
            else
                oDoc.loadXML("<" + sName + "/>");
        };
        return oDoc;
    };
    // see non-IE version
    Sarissa.getParseErrorText = function (oDoc) {
        var parseErrorText = Sarissa.PARSED_OK;
        if(oDoc.parseError != 0){
            parseErrorText = "XML Parsing Error: " + oDoc.parseError.reason +
                "\nLocation: " + oDoc.parseError.url +
                "\nLine Number " + oDoc.parseError.line + ", Column " +
                oDoc.parseError.linepos +
                ":\n" + oDoc.parseError.srcText +
                "\n";
            for(var i = 0;  i < oDoc.parseError.linepos;i++){
                parseErrorText += "-";
            };
            parseErrorText +=  "^\n";
        };
        return parseErrorText;
    };
    // see non-IE version
    Sarissa.setXpathNamespaces = function(oDoc, sNsSet) {
        oDoc.setProperty("SelectionLanguage", "XPath");
        oDoc.setProperty("SelectionNamespaces", sNsSet);
    };
    /**
     * Basic implementation of Mozilla's XSLTProcessor for IE.
     * Reuses the same XSLT stylesheet for multiple transforms
     * @constructor
     */
    XSLTProcessor = function(){
        this.template = new ActiveXObject(_SARISSA_XSLTEMPLATE_PROGID);
        this.processor = null;
    };
    /**
     * Impoprts the given XSLT DOM and compiles it to a reusable transform
     * @argument xslDoc The XSLT DOMDocument to import
     */
    XSLTProcessor.prototype.importStylesheet = function(xslDoc){
        // convert stylesheet to free threaded
        var converted = new ActiveXObject(_SARISSA_THREADEDDOM_PROGID);
        converted.loadXML(xslDoc.xml);
        this.template.stylesheet = converted;
        this.processor = this.template.createProcessor();
        // (re)set default param values
        this.paramsSet = new Array();
    };
    /**
     * Transform the given XML DOM
     * @argument sourceDoc The XML DOMDocument to transform
     * @return The transformation result as a DOM Document
     */
    XSLTProcessor.prototype.transformToDocument = function(sourceDoc){
        this.processor.input = sourceDoc;
        var outDoc = new ActiveXObject(_SARISSA_DOM_PROGID);
        this.processor.output = outDoc;
        this.processor.transform();
        return outDoc;
    };
    /**
     * Set global XSLT parameter of the imported stylesheet
     * @argument nsURI The parameter namespace URI
     * @argument name The parameter base name
     * @argument value The new parameter value
     */
    XSLTProcessor.prototype.setParameter = function(nsURI, name, value){
        /* nsURI is optional but cannot be null */
        if(nsURI){
            this.processor.addParameter(name, value, nsURI);
        }else{
            this.processor.addParameter(name, value);
        };
        /* update updated params for getParameter */
        if(!this.paramsSet[""+nsURI]){
            this.paramsSet[""+nsURI] = new Array();
        };
        this.paramsSet[""+nsURI][name] = value;
    };
    /**
     * Gets a parameter if previously set by setParameter. Returns null
     * otherwise
     * @argument name The parameter base name
     * @argument value The new parameter value
     * @return The parameter value if reviously set by setParameter, null otherwise
     */
    XSLTProcessor.prototype.getParameter = function(nsURI, name){
        nsURI = nsURI || "";
        if(nsURI in this.paramsSet && name in this.paramsSet[nsURI]){
            return this.paramsSet[nsURI][name];
        }else{
            return null;
        };
    };
}
else{ /* end IE initialization, try to deal with real browsers now ;-) */
    if(_SARISSA_HAS_DOM_CREATE_DOCUMENT){
        /**
         * <p>Ensures the document was loaded correctly, otherwise sets the
         * parseError to -1 to indicate something went wrong. Internal use</p>
         * @private
         */
        Sarissa.__handleLoad__ = function(oDoc){
            if (!oDoc.documentElement || oDoc.documentElement.tagName == "parsererror")
                oDoc.parseError = -1;
            Sarissa.__setReadyState__(oDoc, 4);
        };
        /**
        * <p>Attached by an event handler to the load event. Internal use.</p>
        * @private
        */
        _sarissa_XMLDocument_onload = function(){
            Sarissa.__handleLoad__(this);
        };
        /**
         * <p>Sets the readyState property of the given DOM Document object.
         * Internal use.</p>
         * @private
         * @argument oDoc the DOM Document object to fire the
         *          readystatechange event
         * @argument iReadyState the number to change the readystate property to
         */
        Sarissa.__setReadyState__ = function(oDoc, iReadyState){
            oDoc.readyState = iReadyState;
            if (oDoc.onreadystatechange != null && typeof oDoc.onreadystatechange == "function")
                oDoc.onreadystatechange();
        };
        Sarissa.getDomDocument = function(sUri, sName){
            var oDoc = document.implementation.createDocument(sUri?sUri:"", sName?sName:"", null);
            oDoc.addEventListener("load", _sarissa_XMLDocument_onload, false);
            return oDoc;
        };
        if(window.XMLDocument){
            /**
            * <p>Emulate IE's onreadystatechange attribute</p>
            */
            XMLDocument.prototype.onreadystatechange = null;
            /**
            * <p>Emulates IE's readyState property, which always gives an integer from 0 to 4:</p>
            * <ul><li>1 == LOADING,</li>
            * <li>2 == LOADED,</li>
            * <li>3 == INTERACTIVE,</li>
            * <li>4 == COMPLETED</li></ul>
            */
           if(navigator.appCodeName!='Mozilla')
            XMLDocument.prototype.readyState = 0;
            /**
            * <p>Emulate IE's parseError attribute</p>
            */
            XMLDocument.prototype.parseError = 0;

            // NOTE: setting async to false will only work with documents
            // called over HTTP (meaning a server), not the local file system,
            // unless you are using Moz 1.4+.
            // BTW the try>catch block is for 1.4; I haven't found a way to check if
            // the property is implemented without
            // causing an error and I dont want to use user agent stuff for that...
            var _SARISSA_SYNC_NON_IMPLEMENTED = false;// ("async" in XMLDocument.prototype) ? false: true;
            /**
            * <p>Keeps a handle to the original load() method. Internal use and only
            * if Mozilla version is lower than 1.4</p>
            * @private
            */
            XMLDocument.prototype._sarissa_load = XMLDocument.prototype.load;

            /**
            * <p>Overrides the original load method to provide synchronous loading for
            * Mozilla versions prior to 1.4, using an XMLHttpRequest object (if
            * async is set to false)</p>
            * @returns the DOM Object as it was before the load() call (may be  empty)
            */
            XMLDocument.prototype.load = function(sURI) {
                var oDoc = document.implementation.createDocument("", "", null);
                Sarissa.copyChildNodes(this, oDoc);
                this.parseError = 0;
                Sarissa.__setReadyState__(this, 1);
                try {
                    if(this.async == false && _SARISSA_SYNC_NON_IMPLEMENTED) {
                        var tmp = new XMLHttpRequest();
                        tmp.open("GET", sURI, false);
                        tmp.send(null);
                        Sarissa.__setReadyState__(this, 2);
                        Sarissa.copyChildNodes(tmp.responseXML, this);
                        Sarissa.__setReadyState__(this, 3);
                    }
                    else {
                        this._sarissa_load(sURI);
                    };
                }
                catch (objException) {
                    this.parseError = -1;
                }
                finally {
                    if(this.async == false){
                        Sarissa.__handleLoad__(this);
                    };
                };
                return oDoc;
            };


        }//if(window.XMLDocument)
        else if(document.implementation && document.implementation.hasFeature && document.implementation.hasFeature('LS', '3.0')){
            Document.prototype.async = true;
            Document.prototype.onreadystatechange = null;
            Document.prototype.parseError = 0;
            Document.prototype.load = function(sURI) {
                var parser = document.implementation.createLSParser(this.async ? document.implementation.MODE_ASYNCHRONOUS : document.implementation.MODE_SYNCHRONOUS, null);
                if(this.async){
                    var self = this;
                    parser.addEventListener("load",
                        function(e) {
                            self.readyState = 4;
                            Sarissa.copyChildNodes(e.newDocument, self.documentElement, false);
                            self.onreadystatechange.call();
                        },
                        false);
                };
                try {
                    var oDoc = parser.parseURI(sURI);
                }
                catch(e){
                    this.parseError = -1;
                };
                if(!this.async)
                   Sarissa.copyChildNodes(oDoc, this.documentElement, false);
                return oDoc;
            };
            /**
            * <p>Factory method to obtain a new DOM Document object</p>
            * @argument sUri the namespace of the root node (if any)
            * @argument sUri the local name of the root node (if any)
            * @returns a new DOM Document
            */
            Sarissa.getDomDocument = function(sUri, sName){
                return document.implementation.createDocument(sUri?sUri:"", sName?sName:"", null);
            };
        };
    };//if(_SARISSA_HAS_DOM_CREATE_DOCUMENT)
};
//==========================================
// Common stuff
//==========================================
if(!window.DOMParser){
    /*
    * DOMParser is a utility class, used to construct DOMDocuments from XML strings
    * @constructor
    */
    DOMParser = function() {
    };
    if(_SARISSA_IS_SAFARI){
        /**
        * Construct a new DOM Document from the given XMLstring
        * @param sXml the given XML string
        * @param contentType the content type of the document the given string represents (one of text/xml, application/xml, application/xhtml+xml).
        * @return a new DOM Document from the given XML string
        */
        DOMParser.prototype.parseFromString = function(sXml, contentType){
            if(contentType.toLowerCase() != "application/xml"){
                throw "Cannot handle content type: \"" + contentType + "\"";
            };
            var xmlhttp = new XMLHttpRequest();
            xmlhttp.open("GET", "data:text/xml;charset=utf-8," + encodeURIComponent(str), false);
            xmlhttp.send(null);
            return xmlhttp.responseXML;
        };
    }else if(Sarissa.getDomDocument && Sarissa.getDomDocument() && "loadXML" in Sarissa.getDomDocument()){
        DOMParser.prototype.parseFromString = function(sXml, contentType){
            var doc = Sarissa.getDomDocument();
            doc.loadXML(sXml);
            return doc;
        };
    };
};

if(window.XMLHttpRequest){
    Sarissa.IS_ENABLED_XMLHTTP = true;
}
else if(_SARISSA_IS_IE){
    /**
     * Emulate XMLHttpRequest
     * @constructor
     */
    XMLHttpRequest = function() {
        return new ActiveXObject(_SARISSA_XMLHTTP_PROGID);
    };
    Sarissa.IS_ENABLED_XMLHTTP = true;
};

if(!window.document.importNode && _SARISSA_IS_IE){
    try{
        /**
        * Implements importNode for the current window document in IE using innerHTML.
        * Testing showed that DOM was multiple times slower than innerHTML for this,
        * sorry folks. If you encounter trouble (who knows what IE does behind innerHTML)
        * please gimme a call.
        * @param oNode the Node to import
        * @param bChildren whether to include the children of oNode
        * @returns the imported node for further use
        */
        window.document.importNode = function(oNode, bChildren){
            var importNode = document.createElement("div");
            if(bChildren)
                importNode.innerHTML = Sarissa.serialize(oNode);
            else
                importNode.innerHTML = Sarissa.serialize(oNode.cloneNode(false));
            return importNode.firstChild;
        };
        }catch(e){};
};
if(!Sarissa.getParseErrorText){
    /**
     * <p>Returns a human readable description of the parsing error. Usefull
     * for debugging. Tip: append the returned error string in a &lt;pre&gt;
     * element if you want to render it.</p>
     * <p>Many thanks to Christian Stocker for the initial patch.</p>
     * @argument oDoc The target DOM document
     * @returns The parsing error description of the target Document in
     *          human readable form (preformated text)
     */
    Sarissa.getParseErrorText = function (oDoc){
        var parseErrorText = Sarissa.PARSED_OK;
        if(oDoc && oDoc.parseError && oDoc.parseError != 0){
            /*moz*/
            if(oDoc.documentElement.tagName == "parsererror"){
                parseErrorText = oDoc.documentElement.firstChild.data;
                parseErrorText += "\n" +  oDoc.documentElement.firstChild.nextSibling.firstChild.data;
            }/*konq*/
            else{
                parseErrorText = Sarissa.getText(oDoc.documentElement);/*.getElementsByTagName("h1")[0], false) + "\n";
                parseErrorText += Sarissa.getText(oDoc.documentElement.getElementsByTagName("body")[0], false) + "\n";
                parseErrorText += Sarissa.getText(oDoc.documentElement.getElementsByTagName("pre")[0], false);*/
            };
        };
        return parseErrorText;
    };
};
Sarissa.getText = function(oNode, deep){
    var s = "";
    var nodes = oNode.childNodes;
    for(var i=0; i < nodes.length; i++){
        var node = nodes[i];
        var nodeType = node.nodeType;
        if(nodeType == Node.TEXT_NODE || nodeType == Node.CDATA_SECTION_NODE){
            s += node.data;
        }else if(deep == true
                    && (nodeType == Node.ELEMENT_NODE
                        || nodeType == Node.DOCUMENT_NODE
                        || nodeType == Node.DOCUMENT_FRAGMENT_NODE)){
            s += Sarissa.getText(node, true);
        };
    };
    return s;
};
if(window.XMLSerializer){
    /**
     * <p>Factory method to obtain the serialization of a DOM Node</p>
     * @returns the serialized Node as an XML string
     */
    Sarissa.serialize = function(oDoc){
        var s = null;
        if(oDoc){
            s = oDoc.innerHTML?oDoc.innerHTML:(new XMLSerializer()).serializeToString(oDoc);
        };
        return s;
    };
}else{
    if(Sarissa.getDomDocument && (Sarissa.getDomDocument("","foo", null)).xml){
        // see non-IE version
        Sarissa.serialize = function(oDoc) {
            var s = null;
            if(oDoc){
                s = oDoc.innerHTML?oDoc.innerHTML:oDoc.xml;
            };
            return s;
        };
        /**
         * Utility class to serialize DOM Node objects to XML strings
         * @constructor
         */
        XMLSerializer = function(){};
        /**
         * Serialize the given DOM Node to an XML string
         * @param oNode the DOM Node to serialize
         */
        XMLSerializer.prototype.serializeToString = function(oNode) {
            return oNode.xml;
        };
    };
};

/**
 * strips tags from a markup string
 */
Sarissa.stripTags = function (s) {
    return s.replace(/<[^>]+>/g,"");
};
/**
 * <p>Deletes all child nodes of the given node</p>
 * @argument oNode the Node to empty
 */
Sarissa.clearChildNodes = function(oNode) {
    // need to check for firstChild due to opera 8 bug with hasChildNodes
    while(oNode.firstChild){
        oNode.removeChild(oNode.firstChild);
    };
};
/**
 * <p> Copies the childNodes of nodeFrom to nodeTo</p>
 * <p> <b>Note:</b> The second object's original content is deleted before
 * the copy operation, unless you supply a true third parameter</p>
 * @argument nodeFrom the Node to copy the childNodes from
 * @argument nodeTo the Node to copy the childNodes to
 * @argument bPreserveExisting whether to preserve the original content of nodeTo, default is false
 */
Sarissa.copyChildNodes = function(nodeFrom, nodeTo, bPreserveExisting) {
    if((!nodeFrom) || (!nodeTo)){
        throw "Both source and destination nodes must be provided";
    };
    if(!bPreserveExisting){
        Sarissa.clearChildNodes(nodeTo);
    };
    var ownerDoc = nodeTo.nodeType == Node.DOCUMENT_NODE ? nodeTo : nodeTo.ownerDocument;
    var nodes = nodeFrom.childNodes;
    if(ownerDoc.importNode && (!_SARISSA_IS_IE)) {
        for(var i=0;i < nodes.length;i++) {
            nodeTo.appendChild(ownerDoc.importNode(nodes[i], true));
        };
    }
    else{
        for(var i=0;i < nodes.length;i++) {
            nodeTo.appendChild(nodes[i].cloneNode(true));
        };
    };
};

/**
 * <p> Moves the childNodes of nodeFrom to nodeTo</p>
 * <p> <b>Note:</b> The second object's original content is deleted before
 * the move operation, unless you supply a true third parameter</p>
 * @argument nodeFrom the Node to copy the childNodes from
 * @argument nodeTo the Node to copy the childNodes to
 * @argument bPreserveExisting whether to preserve the original content of nodeTo, default is
 */
Sarissa.moveChildNodes = function(nodeFrom, nodeTo, bPreserveExisting) {
    if((!nodeFrom) || (!nodeTo)){
        throw "Both source and destination nodes must be provided";
    };
    if(!bPreserveExisting){
        Sarissa.clearChildNodes(nodeTo);
    };
    var nodes = nodeFrom.childNodes;
    // if within the same doc, just move, else copy and delete
    if(nodeFrom.ownerDocument == nodeTo.ownerDocument){
        while(nodeFrom.firstChild){
            nodeTo.appendChild(nodeFrom.firstChild);
        };
    }else{
        var ownerDoc = nodeTo.nodeType == Node.DOCUMENT_NODE ? nodeTo : nodeTo.ownerDocument;
        if(ownerDoc.importNode && (!_SARISSA_IS_IE)) {
           for(var i=0;i < nodes.length;i++) {
               nodeTo.appendChild(ownerDoc.importNode(nodes[i], true));
           };
        }else{
           for(var i=0;i < nodes.length;i++) {
               nodeTo.appendChild(nodes[i].cloneNode(true));
           };
        };
        Sarissa.clearChildNodes(nodeFrom);
    };
};

/**
 * <p>Serialize any object to an XML string. All properties are serialized using the property name
 * as the XML element name. Array elements are rendered as <code>array-item</code> elements,
 * using their index/key as the value of the <code>key</code> attribute.</p>
 * @argument anyObject the object to serialize
 * @argument objectName a name for that object
 * @return the XML serializationj of the given object as a string
 */
Sarissa.xmlize = function(anyObject, objectName, indentSpace){
    indentSpace = indentSpace?indentSpace:'';
    var s = indentSpace  + '<' + objectName + '>';
    var isLeaf = false;
    if(!(anyObject instanceof Object) || anyObject instanceof Number || anyObject instanceof String
        || anyObject instanceof Boolean || anyObject instanceof Date){
        s += Sarissa.escape(""+anyObject);
        isLeaf = true;
    }else{
        s += "\n";
        var itemKey = '';
        var isArrayItem = anyObject instanceof Array;
        for(var name in anyObject){
            s += Sarissa.xmlize(anyObject[name], (isArrayItem?"array-item key=\""+name+"\"":name), indentSpace + "   ");
        };
        s += indentSpace;
    };
    return s += (objectName.indexOf(' ')!=-1?"</array-item>\n":"</" + objectName + ">\n");
};

/**
 * Escape the given string chacters that correspond to the five predefined XML entities
 * @param sXml the string to escape
 */
Sarissa.escape = function(sXml){
    return sXml.replace(/&/g, "&amp;")
        .replace(/</g, "&lt;")
        .replace(/>/g, "&gt;")
        .replace(/"/g, "&quot;")
        .replace(/'/g, "&apos;");
};

/**
 * Unescape the given string. This turns the occurences of the predefined XML
 * entities to become the characters they represent correspond to the five predefined XML entities
 * @param sXml the string to unescape
 */
Sarissa.unescape = function(sXml){
    return sXml.replace(/&apos;/g,"'")
        .replace(/&quot;/g,"\"")
        .replace(/&gt;/g,">")
        .replace(/&lt;/g,"<")
        .replace(/&amp;/g,"&");
};
//   EOF

/**
 * ====================================================================
 * About
 * ====================================================================
 * Sarissa cross browser XML library - AJAX module
 * @version 0.9.6.1
 * @author: Copyright Manos Batsis, mailto: mbatsis at users full stop sourceforge full stop net
 *
 * This module contains some convinient AJAX tricks based on Sarissa
 *
 * ====================================================================
 * Licence
 * ====================================================================
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 2 or
 * the GNU Lesser General Public License version 2.1 as published by
 * the Free Software Foundation (your choice between the two).
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License or GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * or GNU Lesser General Public License along with this program; if not,
 * write to the Free Software Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 * or visit http://www.gnu.org
 *
 */
/**
 * Update an element with response of a GET request on the given URL.
 * @addon
 * @param sFromUrl the URL to make the request to
 * @param oTargetElement the element to update
 * @param xsltproc (optional) the transformer to use on the returned
 *                  content before updating the target element with it
 */
Sarissa.updateContentFromURI = function(sFromUrl, oTargetElement, xsltproc) {
    try{
        oTargetElement.style.cursor = "wait";
        var xmlhttp = new XMLHttpRequest();
        xmlhttp.open("GET", sFromUrl);
        function sarissa_dhtml_loadHandler() {
            if (xmlhttp.readyState == 4) {
                oTargetElement.style.cursor = "auto";
                Sarissa.updateContentFromNode(xmlhttp.responseXML, oTargetElement, xsltproc);
            };
        };
        xmlhttp.onreadystatechange = sarissa_dhtml_loadHandler;
        xmlhttp.send(null);
        oTargetElement.style.cursor = "auto";
    }
    catch(e){
        oTargetElement.style.cursor = "auto";
        throw e;
    };
};

/**
 * Update an element's content with the given DOM node.
 * @addon
 * @param sFromUrl the URL to make the request to
 * @param oTargetElement the element to update
 * @param xsltproc (optional) the transformer to use on the given
 *                  DOM node before updating the target element with it
 */
Sarissa.updateContentFromNode = function(oNode, oTargetElement, xsltproc) {
    try {
        oTargetElement.style.cursor = "wait";
        Sarissa.clearChildNodes(oTargetElement);
        // check for parsing errors
        var ownerDoc = oNode.nodeType == Node.DOCUMENT_NODE?oNode:oNode.ownerDocument;
        if(ownerDoc.parseError && ownerDoc.parseError != 0) {
            var pre = document.createElement("pre");
            pre.appendChild(document.createTextNode(Sarissa.getParseErrorText(ownerDoc)));
            oTargetElement.appendChild(pre);
        }
        else {
            // transform if appropriate
            if(xsltproc) {
                oNode = xsltproc.transformToDocument(oNode);
            };
            // be smart, maybe the user wants to display the source instead
            if(oTargetElement.tagName.toLowerCase == "textarea" || oTargetElement.tagName.toLowerCase == "input") {
                oTargetElement.value = Sarissa.serialize(oNode);
            }
            else {
                // ok that was not smart; it was paranoid. Keep up the good work by trying to use DOM instead of innerHTML
                if(oNode.nodeType == Node.DOCUMENT_NODE || oNode.ownerDocument.documentElement == oNode) {
                    oTargetElement.innerHTML = Sarissa.serialize(oNode);
                }
                else{
                    oTargetElement.appendChild(oTargetElement.ownerDocument.importNode(oNode, true));
                };
            };
        };
    }
    catch(e) {
        throw e;
    }
    finally{
        oTargetElement.style.cursor = "auto";
    };
};

var ajaxterm={};
ajaxterm.Terminal_ctor=function(id,width,height) {
	var ie=0;
	if(window.ActiveXObject)
		ie=1;
	var sid=""+Math.round(Math.random()*1000000000);
	var query0="s="+sid+"&w="+width+"&h="+height;
	var query1=query0+"&c=1&k=";
	var buf="";
	var timeout;
	var error_timeout;
	var keybuf=[];
	var sending=0;
	var rmax=1;

	var div=document.getElementById(id);
	var dstat=document.createElement('pre');
	var sled=document.createElement('span');
	var opt_get=document.createElement('a');
	var opt_color=document.createElement('a');
	var opt_paste=document.createElement('a');
	var sdebug=document.createElement('span');
	var dterm=document.createElement('div');

	function debug(s) {
		sdebug.innerHTML=s;
	}
	function error() {
		sled.className='off';
		debug("Connection lost timeout ts:"+((new Date).getTime()));
	}
	function opt_add(opt,name) {
		opt.className='off';
		opt.innerHTML=' '+name+' ';
		dstat.appendChild(opt);
		dstat.appendChild(document.createTextNode(' '));
	}
	function do_get(event) {
		opt_get.className=(opt_get.className=='off')?'on':'off';
		debug('GET '+opt_get.className);
	}
	function do_color(event) {
		var o=opt_color.className=(opt_color.className=='off')?'on':'off';
		if(o=='on')
			query1=query0+"&c=1&k=";
		else
			query1=query0+"&k=";
		debug('Color '+opt_color.className);
	}
	function mozilla_clipboard() {
		 // mozilla sucks
		try {
			netscape.security.PrivilegeManager.enablePrivilege("UniversalXPConnect");
		} catch (err) {
			debug('Access denied, <a href="http://kb.mozillazine.org/Granting_JavaScript_access_to_the_clipboard" target="_blank">more info</a>');
			return undefined;
		}
		var clip = Components.classes["@mozilla.org/widget/clipboard;1"].createInstance(Components.interfaces.nsIClipboard);
		var trans = Components.classes["@mozilla.org/widget/transferable;1"].createInstance(Components.interfaces.nsITransferable);
		if (!clip || !trans) {
			return undefined;
		}
		trans.addDataFlavor("text/unicode");
		clip.getData(trans,clip.kGlobalClipboard);
		var str=new Object();
		var strLength=new Object();
		try {
			trans.getTransferData("text/unicode",str,strLength);
		} catch(err) {
			return "";
		}
		if (str) {
			str=str.value.QueryInterface(Components.interfaces.nsISupportsString);
		}
		if (str) {
			return str.data.substring(0,strLength.value / 2);
		} else {
			return "";
		}
	}
	function do_paste(event) {
		var p=undefined;
		if (window.clipboardData) {
			p=window.clipboardData.getData("Text");
		} else if(window.netscape) {
			p=mozilla_clipboard();
		}
		if (p) {
			debug('Pasted');
			queue(encodeURIComponent(p));
		} else {
		}
	}
	function update() {
//		debug("ts: "+((new Date).getTime())+" rmax:"+rmax);
		if(sending==0) {
			sending=1;
			sled.className='on';
			var r=new XMLHttpRequest();
			var send="";
			while(keybuf.length>0) {
				send+=keybuf.pop();
			}
			var query=query1+send;
			if(opt_get.className=='on') {
				r.open("GET",window.location.href+"&"+query,true);
				if(ie) {
					r.setRequestHeader("If-Modified-Since", "Sat, 1 Jan 2000 00:00:00 GMT");
				}
			} else {
				r.open("POST",window.location.href,true);
			}
			r.setRequestHeader('Content-Type','application/x-www-form-urlencoded');
			r.onreadystatechange = function () {
//				debug("xhr:"+((new Date).getTime())+" state:"+r.readyState+" status:"+r.status+" statusText:"+r.statusText);
				if (r.readyState==4) {
					if(r.status==200) {
						window.clearTimeout(error_timeout);
						de=r.responseXML.documentElement;
						if(de.tagName=="pre") {
							if(ie) {
								Sarissa.updateContentFromNode(de, dterm);
							} else {
								Sarissa.updateContentFromNode(de, dterm);
//								old=div.firstChild;
//								div.replaceChild(de,old);
							}
							rmax=100;
						} else {
							rmax*=2;
							if(rmax>2000)
								rmax=2000;
						}
						sending=0;
						sled.className='off';
						timeout=window.setTimeout(update,rmax);
					} else {
						debug("Connection error status:"+r.status);
					}
				}
			}
			error_timeout=window.setTimeout(error,5000);
			if(opt_get.className=='on') {
				r.send(null);
			} else {
				r.send(query);
			}
		}
	}
	function queue(s) {
		keybuf.unshift(s);
		if(sending==0) {
			window.clearTimeout(timeout);
			timeout=window.setTimeout(update,1);
		}
	}
	function keypress(ev) {
		if (!ev) var ev=window.event;
//		s="kp keyCode="+ev.keyCode+" which="+ev.which+" shiftKey="+ev.shiftKey+" ctrlKey="+ev.ctrlKey+" altKey="+ev.altKey;
//		debug(s);
//		return false;
//		else { if (!ev.ctrlKey || ev.keyCode==17) { return; }
		var kc;
		var k="";
		if (ev.keyCode)
			kc=ev.keyCode;
		if (ev.which)
			kc=ev.which;
		if (ev.altKey) {
			if (kc>=65 && kc<=90)
				kc+=32;
			if (kc>=97 && kc<=122) {
				k=String.fromCharCode(27)+String.fromCharCode(kc);
			}
		} else if (ev.ctrlKey) {
			if (kc>=65 && kc<=90) k=String.fromCharCode(kc-64); // Ctrl-A..Z
			else if (kc>=97 && kc<=122) k=String.fromCharCode(kc-96); // Ctrl-A..Z
			else if (kc==54)  k=String.fromCharCode(30); // Ctrl-^
			else if (kc==109) k=String.fromCharCode(31); // Ctrl-_
			else if (kc==219) k=String.fromCharCode(27); // Ctrl-[
			else if (kc==220) k=String.fromCharCode(28); // Ctrl-\
			else if (kc==221) k=String.fromCharCode(29); // Ctrl-]
			else if (kc==219) k=String.fromCharCode(29); // Ctrl-]
			else if (kc==219) k=String.fromCharCode(0);  // Ctrl-@
		} else if (ev.which==0) {
			if (kc==9) k=String.fromCharCode(9);  // Tab
			else if (kc==8) k=String.fromCharCode(127);  // Backspace
			else if (kc==27) k=String.fromCharCode(27); // Escape
			else {
				if (kc==33) k="[5~";        // PgUp
				else if (kc==34) k="[6~";   // PgDn
				else if (kc==35) k="[4~";   // End
				else if (kc==36) k="[1~";   // Home
				else if (kc==37) k="[D";    // Left
				else if (kc==38) k="[A";    // Up
				else if (kc==39) k="[C";    // Right
				else if (kc==40) k="[B";    // Down
				else if (kc==45) k="[2~";   // Ins
				else if (kc==46) k="[3~";   // Del
				else if (kc==112) k="[[A";  // F1
				else if (kc==113) k="[[B";  // F2
				else if (kc==114) k="[[C";  // F3
				else if (kc==115) k="[[D";  // F4
				else if (kc==116) k="[[E";  // F5
				else if (kc==117) k="[17~"; // F6
				else if (kc==118) k="[18~"; // F7
				else if (kc==119) k="[19~"; // F8
				else if (kc==120) k="[20~"; // F9
				else if (kc==121) k="[21~"; // F10
				else if (kc==122) k="[23~"; // F11
				else if (kc==123) k="[24~"; // F12
				if (k.length) {
					k=String.fromCharCode(27)+k;
				}
			}
		} else {
			if (kc==8)
				k=String.fromCharCode(127);  // Backspace
			else
				k=String.fromCharCode(kc);
		}
		if(k.length) {
//			queue(encodeURIComponent(k));
			if(k=="+") {
				queue("%2B");
			} else {
				queue(escape(k));
			}
		}
		ev.cancelBubble=true;
		if (ev.stopPropagation) ev.stopPropagation();
		if (ev.preventDefault)  ev.preventDefault();
		return false;
	}
	function keydown(ev) {
		if (!ev) var ev=window.event;
		if (ie) {
//			s="kd keyCode="+ev.keyCode+" which="+ev.which+" shiftKey="+ev.shiftKey+" ctrlKey="+ev.ctrlKey+" altKey="+ev.altKey;
//			debug(s);
			o={9:1,8:1,27:1,33:1,34:1,35:1,36:1,37:1,38:1,39:1,40:1,45:1,46:1,112:1,
			113:1,114:1,115:1,116:1,117:1,118:1,119:1,120:1,121:1,122:1,123:1};
			if (o[ev.keyCode] || ev.ctrlKey || ev.altKey) {
				ev.which=0;
				return keypress(ev);
			}
		}
	}
	function init() {
		sled.appendChild(document.createTextNode('\xb7'));
		sled.className='off';
		dstat.appendChild(sled);
		dstat.appendChild(document.createTextNode(' '));
		opt_add(opt_color,'Colors');
		opt_color.className='on';
		opt_add(opt_get,'GET');
		opt_add(opt_paste,'Paste');
		dstat.appendChild(sdebug);
		dstat.className='stat';
		div.appendChild(dstat);
		div.appendChild(dterm);
		if(opt_color.addEventListener) {
			opt_get.addEventListener('click',do_get,true);
			opt_color.addEventListener('click',do_color,true);
			opt_paste.addEventListener('click',do_paste,true);
		} else {
			opt_get.attachEvent("onclick", do_get);
			opt_color.attachEvent("onclick", do_color);
			opt_paste.attachEvent("onclick", do_paste);
		}
		document.onkeypress=keypress;
		document.onkeydown=keydown;
		timeout=window.setTimeout(update,100);
	}
	init();
}
ajaxterm.Terminal=function(id,width,height) {
	return new this.Terminal_ctor(id,width,height);
}

