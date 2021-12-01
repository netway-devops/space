/*!

 handlebars v4.0.5

Copyright (C) 2011-2015 by Yehuda Katz

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

@license
*/
(function webpackUniversalModuleDefinition(root, factory) {
	if(typeof exports === 'object' && typeof module === 'object')
		module.exports = factory();
	else if(typeof define === 'function' && define.amd)
		define([], factory);
	else if(typeof exports === 'object')
		exports["Handlebars"] = factory();
	else
		root["Handlebars"] = factory();
})(this, function() {
return /******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};

/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {

/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId])
/******/ 			return installedModules[moduleId].exports;

/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			exports: {},
/******/ 			id: moduleId,
/******/ 			loaded: false
/******/ 		};

/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);

/******/ 		// Flag the module as loaded
/******/ 		module.loaded = true;

/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}


/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;

/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;

/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "";

/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(0);
/******/ })
/************************************************************************/
/******/ ([
/* 0 */
/***/ function(module, exports, __webpack_require__) {

	'use strict';

	var _interopRequireDefault = __webpack_require__(1)['default'];

	exports.__esModule = true;

	var _handlebarsRuntime = __webpack_require__(2);

	var _handlebarsRuntime2 = _interopRequireDefault(_handlebarsRuntime);

	// Compiler imports

	var _handlebarsCompilerAst = __webpack_require__(21);

	var _handlebarsCompilerAst2 = _interopRequireDefault(_handlebarsCompilerAst);

	var _handlebarsCompilerBase = __webpack_require__(22);

	var _handlebarsCompilerCompiler = __webpack_require__(27);

	var _handlebarsCompilerJavascriptCompiler = __webpack_require__(28);

	var _handlebarsCompilerJavascriptCompiler2 = _interopRequireDefault(_handlebarsCompilerJavascriptCompiler);

	var _handlebarsCompilerVisitor = __webpack_require__(25);

	var _handlebarsCompilerVisitor2 = _interopRequireDefault(_handlebarsCompilerVisitor);

	var _handlebarsNoConflict = __webpack_require__(20);

	var _handlebarsNoConflict2 = _interopRequireDefault(_handlebarsNoConflict);

	var _create = _handlebarsRuntime2['default'].create;
	function create() {
	  var hb = _create();

	  hb.compile = function (input, options) {
	    return _handlebarsCompilerCompiler.compile(input, options, hb);
	  };
	  hb.precompile = function (input, options) {
	    return _handlebarsCompilerCompiler.precompile(input, options, hb);
	  };

	  hb.AST = _handlebarsCompilerAst2['default'];
	  hb.Compiler = _handlebarsCompilerCompiler.Compiler;
	  hb.JavaScriptCompiler = _handlebarsCompilerJavascriptCompiler2['default'];
	  hb.Parser = _handlebarsCompilerBase.parser;
	  hb.parse = _handlebarsCompilerBase.parse;

	  return hb;
	}

	var inst = create();
	inst.create = create;

	_handlebarsNoConflict2['default'](inst);

	inst.Visitor = _handlebarsCompilerVisitor2['default'];

	inst['default'] = inst;

	exports['default'] = inst;
	module.exports = exports['default'];

/***/ },
/* 1 */
/***/ function(module, exports) {

	"use strict";

	exports["default"] = function (obj) {
	  return obj && obj.__esModule ? obj : {
	    "default": obj
	  };
	};

	exports.__esModule = true;

/***/ },
/* 2 */
/***/ function(module, exports, __webpack_require__) {

	'use strict';

	var _interopRequireWildcard = __webpack_require__(3)['default'];

	var _interopRequireDefault = __webpack_require__(1)['default'];

	exports.__esModule = true;

	var _handlebarsBase = __webpack_require__(4);

	var base = _interopRequireWildcard(_handlebarsBase);

	// Each of these augment the Handlebars object. No need to setup here.
	// (This is done to easily share code between commonjs and browse envs)

	var _handlebarsSafeString = __webpack_require__(18);

	var _handlebarsSafeString2 = _interopRequireDefault(_handlebarsSafeString);

	var _handlebarsException = __webpack_require__(6);

	var _handlebarsException2 = _interopRequireDefault(_handlebarsException);

	var _handlebarsUtils = __webpack_require__(5);

	var Utils = _interopRequireWildcard(_handlebarsUtils);

	var _handlebarsRuntime = __webpack_require__(19);

	var runtime = _interopRequireWildcard(_handlebarsRuntime);

	var _handlebarsNoConflict = __webpack_require__(20);

	var _handlebarsNoConflict2 = _interopRequireDefault(_handlebarsNoConflict);

	// For compatibility and usage outside of module systems, make the Handlebars object a namespace
	function create() {
	  var hb = new base.HandlebarsEnvironment();

	  Utils.extend(hb, base);
	  hb.SafeString = _handlebarsSafeString2['default'];
	  hb.Exception = _handlebarsException2['default'];
	  hb.Utils = Utils;
	  hb.escapeExpression = Utils.escapeExpression;

	  hb.VM = runtime;
	  hb.template = function (spec) {
	    return runtime.template(spec, hb);
	  };

	  return hb;
	}

	var inst = create();
	inst.create = create;

	_handlebarsNoConflict2['default'](inst);

	inst['default'] = inst;

	exports['default'] = inst;
	module.exports = exports['default'];

/***/ },
/* 3 */
/***/ function(module, exports) {

	"use strict";

	exports["default"] = function (obj) {
	  if (obj && obj.__esModule) {
	    return obj;
	  } else {
	    var newObj = {};

	    if (obj != null) {
	      for (var key in obj) {
	        if (Object.prototype.hasOwnProperty.call(obj, key)) newObj[key] = obj[key];
	      }
	    }

	    newObj["default"] = obj;
	    return newObj;
	  }
	};

	exports.__esModule = true;

/***/ },
/* 4 */
/***/ function(module, exports, __webpack_require__) {

	'use strict';

	var _interopRequireDefault = __webpack_require__(1)['default'];

	exports.__esModule = true;
	exports.HandlebarsEnvironment = HandlebarsEnvironment;

	var _utils = __webpack_require__(5);

	var _exception = __webpack_require__(6);

	var _exception2 = _interopRequireDefault(_exception);

	var _helpers = __webpack_require__(7);

	var _decorators = __webpack_require__(15);

	var _logger = __webpack_require__(17);

	var _logger2 = _interopRequireDefault(_logger);

	var VERSION = '4.0.5';
	exports.VERSION = VERSION;
	var COMPILER_REVISION = 7;

	exports.COMPILER_REVISION = COMPILER_REVISION;
	var REVISION_CHANGES = {
	  1: '<= 1.0.rc.2', // 1.0.rc.2 is actually rev2 but doesn't report it
	  2: '== 1.0.0-rc.3',
	  3: '== 1.0.0-rc.4',
	  4: '== 1.x.x',
	  5: '== 2.0.0-alpha.x',
	  6: '>= 2.0.0-beta.1',
	  7: '>= 4.0.0'
	};

	exports.REVISION_CHANGES = REVISION_CHANGES;
	var objectType = '[object Object]';

	function HandlebarsEnvironment(helpers, partials, decorators) {
	  this.helpers = helpers || {};
	  this.partials = partials || {};
	  this.decorators = decorators || {};

	  _helpers.registerDefaultHelpers(this);
	  _decorators.registerDefaultDecorators(this);
	}

	HandlebarsEnvironment.prototype = {
	  constructor: HandlebarsEnvironment,

	  logger: _logger2['default'],
	  log: _logger2['default'].log,

	  registerHelper: function registerHelper(name, fn) {
	    if (_utils.toString.call(name) === objectType) {
	      if (fn) {
	        throw new _exception2['default']('Arg not supported with multiple helpers');
	      }
	      _utils.extend(this.helpers, name);
	    } else {
	      this.helpers[name] = fn;
	    }
	  },
	  unregisterHelper: function unregisterHelper(name) {
	    delete this.helpers[name];
	  },

	  registerPartial: function registerPartial(name, partial) {
	    if (_utils.toString.call(name) === objectType) {
	      _utils.extend(this.partials, name);
	    } else {
	      if (typeof partial === 'undefined') {
	        throw new _exception2['default']('Attempting to register a partial called "' + name + '" as undefined');
	      }
	      this.partials[name] = partial;
	    }
	  },
	  unregisterPartial: function unregisterPartial(name) {
	    delete this.partials[name];
	  },

	  registerDecorator: function registerDecorator(name, fn) {
	    if (_utils.toString.call(name) === objectType) {
	      if (fn) {
	        throw new _exception2['default']('Arg not supported with multiple decorators');
	      }
	      _utils.extend(this.decorators, name);
	    } else {
	      this.decorators[name] = fn;
	    }
	  },
	  unregisterDecorator: function unregisterDecorator(name) {
	    delete this.decorators[name];
	  }
	};

	var log = _logger2['default'].log;

	exports.log = log;
	exports.createFrame = _utils.createFrame;
	exports.logger = _logger2['default'];

/***/ },
/* 5 */
/***/ function(module, exports) {

	'use strict';

	exports.__esModule = true;
	exports.extend = extend;
	exports.indexOf = indexOf;
	exports.escapeExpression = escapeExpression;
	exports.isEmpty = isEmpty;
	exports.createFrame = createFrame;
	exports.blockParams = blockParams;
	exports.appendContextPath = appendContextPath;
	var escape = {
	  '&': '&amp;',
	  '<': '&lt;',
	  '>': '&gt;',
	  '"': '&quot;',
	  "'": '&#x27;',
	  '`': '&#x60;',
	  '=': '&#x3D;'
	};

	var badChars = /[&<>"'`=]/g,
	    possible = /[&<>"'`=]/;

	function escapeChar(chr) {
	  return escape[chr];
	}

	function extend(obj /* , ...source */) {
	  for (var i = 1; i < arguments.length; i++) {
	    for (var key in arguments[i]) {
	      if (Object.prototype.hasOwnProperty.call(arguments[i], key)) {
	        obj[key] = arguments[i][key];
	      }
	    }
	  }

	  return obj;
	}

	var toString = Object.prototype.toString;

	exports.toString = toString;
	// Sourced from lodash
	// https://github.com/bestiejs/lodash/blob/master/LICENSE.txt
	/* eslint-disable func-style */
	var isFunction = function isFunction(value) {
	  return typeof value === 'function';
	};
	// fallback for older versions of Chrome and Safari
	/* istanbul ignore next */
	if (isFunction(/x/)) {
	  exports.isFunction = isFunction = function (value) {
	    return typeof value === 'function' && toString.call(value) === '[object Function]';
	  };
	}
	exports.isFunction = isFunction;

	/* eslint-enable func-style */

	/* istanbul ignore next */
	var isArray = Array.isArray || function (value) {
	  return value && typeof value === 'object' ? toString.call(value) === '[object Array]' : false;
	};

	exports.isArray = isArray;
	// Older IE versions do not directly support indexOf so we must implement our own, sadly.

	function indexOf(array, value) {
	  for (var i = 0, len = array.length; i < len; i++) {
	    if (array[i] === value) {
	      return i;
	    }
	  }
	  return -1;
	}

	function escapeExpression(string) {
	  if (typeof string !== 'string') {
	    // don't escape SafeStrings, since they're already safe
	    if (string && string.toHTML) {
	      return string.toHTML();
	    } else if (string == null) {
	      return '';
	    } else if (!string) {
	      return string + '';
	    }

	    // Force a string conversion as this will be done by the append regardless and
	    // the regex test will do this transparently behind the scenes, causing issues if
	    // an object's to string has escaped characters in it.
	    string = '' + string;
	  }

	  if (!possible.test(string)) {
	    return string;
	  }
	  return string.replace(badChars, escapeChar);
	}

	function isEmpty(value) {
	  if (!value && value !== 0) {
	    return true;
	  } else if (isArray(value) && value.length === 0) {
	    return true;
	  } else {
	    return false;
	  }
	}

	function createFrame(object) {
	  var frame = extend({}, object);
	  frame._parent = object;
	  return frame;
	}

	function blockParams(params, ids) {
	  params.path = ids;
	  return params;
	}

	function appendContextPath(contextPath, id) {
	  return (contextPath ? contextPath + '.' : '') + id;
	}

/***/ },
/* 6 */
/***/ function(module, exports) {

	'use strict';

	exports.__esModule = true;

	var errorProps = ['description', 'fileName', 'lineNumber', 'message', 'name', 'number', 'stack'];

	function Exception(message, node) {
	  var loc = node && node.loc,
	      line = undefined,
	      column = undefined;
	  if (loc) {
	    line = loc.start.line;
	    column = loc.start.column;

	    message += ' - ' + line + ':' + column;
	  }

	  var tmp = Error.prototype.constructor.call(this, message);

	  // Unfortunately errors are not enumerable in Chrome (at least), so `for prop in tmp` doesn't work.
	  for (var idx = 0; idx < errorProps.length; idx++) {
	    this[errorProps[idx]] = tmp[errorProps[idx]];
	  }

	  /* istanbul ignore else */
	  if (Error.captureStackTrace) {
	    Error.captureStackTrace(this, Exception);
	  }

	  if (loc) {
	    this.lineNumber = line;
	    this.column = column;
	  }
	}

	Exception.prototype = new Error();

	exports['default'] = Exception;
	module.exports = exports['default'];

/***/ },
/* 7 */
/***/ function(module, exports, __webpack_require__) {

	'use strict';

	var _interopRequireDefault = __webpack_require__(1)['default'];

	exports.__esModule = true;
	exports.registerDefaultHelpers = registerDefaultHelpers;

	var _helpersBlockHelperMissing = __webpack_require__(8);

	var _helpersBlockHelperMissing2 = _interopRequireDefault(_helpersBlockHelperMissing);

	var _helpersEach = __webpack_require__(9);

	var _helpersEach2 = _interopRequireDefault(_helpersEach);

	var _helpersHelperMissing = __webpack_require__(10);

	var _helpersHelperMissing2 = _interopRequireDefault(_helpersHelperMissing);

	var _helpersIf = __webpack_require__(11);

	var _helpersIf2 = _interopRequireDefault(_helpersIf);

	var _helpersLog = __webpack_require__(12);

	var _helpersLog2 = _interopRequireDefault(_helpersLog);

	var _helpersLookup = __webpack_require__(13);

	var _helpersLookup2 = _interopRequireDefault(_helpersLookup);

	var _helpersWith = __webpack_require__(14);

	var _helpersWith2 = _interopRequireDefault(_helpersWith);

	function registerDefaultHelpers(instance) {
	  _helpersBlockHelperMissing2['default'](instance);
	  _helpersEach2['default'](instance);
	  _helpersHelperMissing2['default'](instance);
	  _helpersIf2['default'](instance);
	  _helpersLog2['default'](instance);
	  _helpersLookup2['default'](instance);
	  _helpersWith2['default'](instance);
	}

/***/ },
/* 8 */
/***/ function(module, exports, __webpack_require__) {

	'use strict';

	exports.__esModule = true;

	var _utils = __webpack_require__(5);

	exports['default'] = function (instance) {
	  instance.registerHelper('blockHelperMissing', function (context, options) {
	    var inverse = options.inverse,
	        fn = options.fn;

	    if (context === true) {
	      return fn(this);
	    } else if (context === false || context == null) {
	      return inverse(this);
	    } else if (_utils.isArray(context)) {
	      if (context.length > 0) {
	        if (options.ids) {
	          options.ids = [options.name];
	        }

	        return instance.helpers.each(context, options);
	      } else {
	        return inverse(this);
	      }
	    } else {
	      if (options.data && options.ids) {
	        var data = _utils.createFrame(options.data);
	        data.contextPath = _utils.appendContextPath(options.data.contextPath, options.name);
	        options = { data: data };
	      }

	      return fn(context, options);
	    }
	  });
	};

	module.exports = exports['default'];

/***/ },
/* 9 */
/***/ function(module, exports, __webpack_require__) {

	'use strict';

	var _interopRequireDefault = __webpack_require__(1)['default'];

	exports.__esModule = true;

	var _utils = __webpack_require__(5);

	var _exception = __webpack_require__(6);

	var _exception2 = _interopRequireDefault(_exception);

	exports['default'] = function (instance) {
	  instance.registerHelper('each', function (context, options) {
	    if (!options) {
	      throw new _exception2['default']('Must pass iterator to #each');
	    }

	    var fn = options.fn,
	        inverse = options.inverse,
	        i = 0,
	        ret = '',
	        data = undefined,
	        contextPath = undefined;

	    if (options.data && options.ids) {
	      contextPath = _utils.appendContextPath(options.data.contextPath, options.ids[0]) + '.';
	    }

	    if (_utils.isFunction(context)) {
	      context = context.call(this);
	    }

	    if (options.data) {
	      data = _utils.createFrame(options.data);
	    }

	    function execIteration(field, index, last) {
	      if (data) {
	        data.key = field;
	        data.index = index;
	        data.first = index === 0;
	        data.last = !!last;

	        if (contextPath) {
	          data.contextPath = contextPath + field;
	        }
	      }

	      ret = ret + fn(context[field], {
	        data: data,
	        blockParams: _utils.blockParams([context[field], field], [contextPath + field, null])
	      });
	    }

	    if (context && typeof context === 'object') {
	      if (_utils.isArray(context)) {
	        for (var j = context.length; i < j; i++) {
	          if (i in context) {
	            execIteration(i, i, i === context.length - 1);
	          }
	        }
	      } else {
	        var priorKey = undefined;

	        for (var key in context) {
	          if (context.hasOwnProperty(key)) {
	            // We're running the iterations one step out of sync so we can detect
	            // the last iteration without have to scan the object twice and create
	            // an itermediate keys array.
	            if (priorKey !== undefined) {
	              execIteration(priorKey, i - 1);
	            }
	            priorKey = key;
	            i++;
	          }
	        }
	        if (priorKey !== undefined) {
	          execIteration(priorKey, i - 1, true);
	        }
	      }
	    }

	    if (i === 0) {
	      ret = inverse(this);
	    }

	    return ret;
	  });
	};

	module.exports = exports['default'];

/***/ },
/* 10 */
/***/ function(module, exports, __webpack_require__) {

	'use strict';

	var _interopRequireDefault = __webpack_require__(1)['default'];

	exports.__esModule = true;

	var _exception = __webpack_require__(6);

	var _exception2 = _interopRequireDefault(_exception);

	exports['default'] = function (instance) {
	  instance.registerHelper('helperMissing', function () /* [args, ]options */{
	    if (arguments.length === 1) {
	      // A missing field in a {{foo}} construct.
	      return undefined;
	    } else {
	      // Someone is actually trying to call something, blow up.
	      throw new _exception2['default']('Missing helper: "' + arguments[arguments.length - 1].name + '"');
	    }
	  });
	};

	module.exports = exports['default'];

/***/ },
/* 11 */
/***/ function(module, exports, __webpack_require__) {

	'use strict';

	exports.__esModule = true;

	var _utils = __webpack_require__(5);

	exports['default'] = function (instance) {
	  instance.registerHelper('if', function (conditional, options) {
	    if (_utils.isFunction(conditional)) {
	      conditional = conditional.call(this);
	    }

	    // Default behavior is to render the positive path if the value is truthy and not empty.
	    // The `includeZero` option may be set to treat the condtional as purely not empty based on the
	    // behavior of isEmpty. Effectively this determines if 0 is handled by the positive path or negative.
	    if (!options.hash.includeZero && !conditional || _utils.isEmpty(conditional)) {
	      return options.inverse(this);
	    } else {
	      return options.fn(this);
	    }
	  });

	  instance.registerHelper('unless', function (conditional, options) {
	    return instance.helpers['if'].call(this, conditional, { fn: options.inverse, inverse: options.fn, hash: options.hash });
	  });
	};

	module.exports = exports['default'];

/***/ },
/* 12 */
/***/ function(module, exports) {

	'use strict';

	exports.__esModule = true;

	exports['default'] = function (instance) {
	  instance.registerHelper('log', function () /* message, options */{
	    var args = [undefined],
	        options = arguments[arguments.length - 1];
	    for (var i = 0; i < arguments.length - 1; i++) {
	      args.push(arguments[i]);
	    }

	    var level = 1;
	    if (options.hash.level != null) {
	      level = options.hash.level;
	    } else if (options.data && options.data.level != null) {
	      level = options.data.level;
	    }
	    args[0] = level;

	    instance.log.apply(instance, args);
	  });
	};

	module.exports = exports['default'];

/***/ },
/* 13 */
/***/ function(module, exports) {

	'use strict';

	exports.__esModule = true;

	exports['default'] = function (instance) {
	  instance.registerHelper('lookup', function (obj, field) {
	    return obj && obj[field];
	  });
	};

	module.exports = exports['default'];

/***/ },
/* 14 */
/***/ function(module, exports, __webpack_require__) {

	'use strict';

	exports.__esModule = true;

	var _utils = __webpack_require__(5);

	exports['default'] = function (instance) {
	  instance.registerHelper('with', function (context, options) {
	    if (_utils.isFunction(context)) {
	      context = context.call(this);
	    }

	    var fn = options.fn;

	    if (!_utils.isEmpty(context)) {
	      var data = options.data;
	      if (options.data && options.ids) {
	        data = _utils.createFrame(options.data);
	        data.contextPath = _utils.appendContextPath(options.data.contextPath, options.ids[0]);
	      }

	      return fn(context, {
	        data: data,
	        blockParams: _utils.blockParams([context], [data && data.contextPath])
	      });
	    } else {
	      return options.inverse(this);
	    }
	  });
	};

	module.exports = exports['default'];

/***/ },
/* 15 */
/***/ function(module, exports, __webpack_require__) {

	'use strict';

	var _interopRequireDefault = __webpack_require__(1)['default'];

	exports.__esModule = true;
	exports.registerDefaultDecorators = registerDefaultDecorators;

	var _decoratorsInline = __webpack_require__(16);

	var _decoratorsInline2 = _interopRequireDefault(_decoratorsInline);

	function registerDefaultDecorators(instance) {
	  _decoratorsInline2['default'](instance);
	}

/***/ },
/* 16 */
/***/ function(module, exports, __webpack_require__) {

	'use strict';

	exports.__esModule = true;

	var _utils = __webpack_require__(5);

	exports['default'] = function (instance) {
	  instance.registerDecorator('inline', function (fn, props, container, options) {
	    var ret = fn;
	    if (!props.partials) {
	      props.partials = {};
	      ret = function (context, options) {
	        // Create a new partials stack frame prior to exec.
	        var original = container.partials;
	        container.partials = _utils.extend({}, original, props.partials);
	        var ret = fn(context, options);
	        container.partials = original;
	        return ret;
	      };
	    }

	    props.partials[options.args[0]] = options.fn;

	    return ret;
	  });
	};

	module.exports = exports['default'];

/***/ },
/* 17 */
/***/ function(module, exports, __webpack_require__) {

	'use strict';

	exports.__esModule = true;

	var _utils = __webpack_require__(5);

	var logger = {
	  methodMap: ['debug', 'info', 'warn', 'error'],
	  level: 'info',

	  // Maps a given level value to the `methodMap` indexes above.
	  lookupLevel: function lookupLevel(level) {
	    if (typeof level === 'string') {
	      var levelMap = _utils.indexOf(logger.methodMap, level.toLowerCase());
	      if (levelMap >= 0) {
	        level = levelMap;
	      } else {
	        level = parseInt(level, 10);
	      }
	    }

	    return level;
	  },

	  // Can be overridden in the host environment
	  log: function log(level) {
	    level = logger.lookupLevel(level);

	    if (typeof console !== 'undefined' && logger.lookupLevel(logger.level) <= level) {
	      var method = logger.methodMap[level];
	      if (!console[method]) {
	        // eslint-disable-line no-console
	        method = 'log';
	      }

	      for (var _len = arguments.length, message = Array(_len > 1 ? _len - 1 : 0), _key = 1; _key < _len; _key++) {
	        message[_key - 1] = arguments[_key];
	      }

	      console[method].apply(console, message); // eslint-disable-line no-console
	    }
	  }
	};

	exports['default'] = logger;
	module.exports = exports['default'];

/***/ },
/* 18 */
/***/ function(module, exports) {

	// Build out our basic SafeString type
	'use strict';

	exports.__esModule = true;
	function SafeString(string) {
	  this.string = string;
	}

	SafeString.prototype.toString = SafeString.prototype.toHTML = function () {
	  return '' + this.string;
	};

	exports['default'] = SafeString;
	module.exports = exports['default'];

/***/ },
/* 19 */
/***/ function(module, exports, __webpack_require__) {

	'use strict';

	var _interopRequireWildcard = __webpack_require__(3)['default'];

	var _interopRequireDefault = __webpack_require__(1)['default'];

	exports.__esModule = true;
	exports.checkRevision = checkRevision;
	exports.template = template;
	exports.wrapProgram = wrapProgram;
	exports.resolvePartial = resolvePartial;
	exports.invokePartial = invokePartial;
	exports.noop = noop;

	var _utils = __webpack_require__(5);

	var Utils = _interopRequireWildcard(_utils);

	var _exception = __webpack_require__(6);

	var _exception2 = _interopRequireDefault(_exception);

	var _base = __webpack_require__(4);

	function checkRevision(compilerInfo) {
	  var compilerRevision = compilerInfo && compilerInfo[0] || 1,
	      currentRevision = _base.COMPILER_REVISION;

	  if (compilerRevision !== currentRevision) {
	    if (compilerRevision < currentRevision) {
	      var runtimeVersions = _base.REVISION_CHANGES[currentRevision],
	          compilerVersions = _base.REVISION_CHANGES[compilerRevision];
	      throw new _exception2['default']('Template was precompiled with an older version of Handlebars than the current runtime. ' + 'Please update your precompiler to a newer version (' + runtimeVersions + ') or downgrade your runtime to an older version (' + compilerVersions + ').');
	    } else {
	      // Use the embedded version info since the runtime doesn't know about this revision yet
	      throw new _exception2['default']('Template was precompiled with a newer version of Handlebars than the current runtime. ' + 'Please update your runtime to a newer version (' + compilerInfo[1] + ').');
	    }
	  }
	}

	function template(templateSpec, env) {
	  /* istanbul ignore next */
	  if (!env) {
	    throw new _exception2['default']('No environment passed to template');
	  }
	  if (!templateSpec || !templateSpec.main) {
	    throw new _exception2['default']('Unknown template object: ' + typeof templateSpec);
	  }

	  templateSpec.main.decorator = templateSpec.main_d;

	  // Note: Using env.VM references rather than local var references throughout this section to allow
	  // for external users to override these as psuedo-supported APIs.
	  env.VM.checkRevision(templateSpec.compiler);

	  function invokePartialWrapper(partial, context, options) {
	    if (options.hash) {
	      context = Utils.extend({}, context, options.hash);
	      if (options.ids) {
	        options.ids[0] = true;
	      }
	    }

	    partial = env.VM.resolvePartial.call(this, partial, context, options);
	    var result = env.VM.invokePartial.call(this, partial, context, options);

	    if (result == null && env.compile) {
	      options.partials[options.name] = env.compile(partial, templateSpec.compilerOptions, env);
	      result = options.partials[options.name](context, options);
	    }
	    if (result != null) {
	      if (options.indent) {
	        var lines = result.split('\n');
	        for (var i = 0, l = lines.length; i < l; i++) {
	          if (!lines[i] && i + 1 === l) {
	            break;
	          }

	          lines[i] = options.indent + lines[i];
	        }
	        result = lines.join('\n');
	      }
	      return result;
	    } else {
	      throw new _exception2['default']('The partial ' + options.name + ' could not be compiled when running in runtime-only mode');
	    }
	  }

	  // Just add water
	  var container = {
	    strict: function strict(obj, name) {
	      if (!(name in obj)) {
	        throw new _exception2['default']('"' + name + '" not defined in ' + obj);
	      }
	      return obj[name];
	    },
	    lookup: function lookup(depths, name) {
	      var len = depths.length;
	      for (var i = 0; i < len; i++) {
	        if (depths[i] && depths[i][name] != null) {
	          return depths[i][name];
	        }
	      }
	    },
	    lambda: function lambda(current, context) {
	      return typeof current === 'function' ? current.call(context) : current;
	    },

	    escapeExpression: Utils.escapeExpression,
	    invokePartial: invokePartialWrapper,

	    fn: function fn(i) {
	      var ret = templateSpec[i];
	      ret.decorator = templateSpec[i + '_d'];
	      return ret;
	    },

	    programs: [],
	    program: function program(i, data, declaredBlockParams, blockParams, depths) {
	      var programWrapper = this.programs[i],
	          fn = this.fn(i);
	      if (data || depths || blockParams || declaredBlockParams) {
	        programWrapper = wrapProgram(this, i, fn, data, declaredBlockParams, blockParams, depths);
	      } else if (!programWrapper) {
	        programWrapper = this.programs[i] = wrapProgram(this, i, fn);
	      }
	      return programWrapper;
	    },

	    data: function data(value, depth) {
	      while (value && depth--) {
	        value = value._parent;
	      }
	      return value;
	    },
	    merge: function merge(param, common) {
	      var obj = param || common;

	      if (param && common && param !== common) {
	        obj = Utils.extend({}, common, param);
	      }

	      return obj;
	    },

	    noop: env.VM.noop,
	    compilerInfo: templateSpec.compiler
	  };

	  function ret(context) {
	    var options = arguments.length <= 1 || arguments[1] === undefined ? {} : arguments[1];

	    var data = options.data;

	    ret._setup(options);
	    if (!options.partial && templateSpec.useData) {
	      data = initData(context, data);
	    }
	    var depths = undefined,
	        blockParams = templateSpec.useBlockParams ? [] : undefined;
	    if (templateSpec.useDepths) {
	      if (options.depths) {
	        depths = context !== options.depths[0] ? [context].concat(options.depths) : options.depths;
	      } else {
	        depths = [context];
	      }
	    }

	    function main(context /*, options*/) {
	      return '' + templateSpec.main(container, context, container.helpers, container.partials, data, blockParams, depths);
	    }
	    main = executeDecorators(templateSpec.main, main, container, options.depths || [], data, blockParams);
	    return main(context, options);
	  }
	  ret.isTop = true;

	  ret._setup = function (options) {
	    if (!options.partial) {
	      container.helpers = container.merge(options.helpers, env.helpers);

	      if (templateSpec.usePartial) {
	        container.partials = container.merge(options.partials, env.partials);
	      }
	      if (templateSpec.usePartial || templateSpec.useDecorators) {
	        container.decorators = container.merge(options.decorators, env.decorators);
	      }
	    } else {
	      container.helpers = options.helpers;
	      container.partials = options.partials;
	      container.decorators = options.decorators;
	    }
	  };

	  ret._child = function (i, data, blockParams, depths) {
	    if (templateSpec.useBlockParams && !blockParams) {
	      throw new _exception2['default']('must pass block params');
	    }
	    if (templateSpec.useDepths && !depths) {
	      throw new _exception2['default']('must pass parent depths');
	    }

	    return wrapProgram(container, i, templateSpec[i], data, 0, blockParams, depths);
	  };
	  return ret;
	}

	function wrapProgram(container, i, fn, data, declaredBlockParams, blockParams, depths) {
	  function prog(context) {
	    var options = arguments.length <= 1 || arguments[1] === undefined ? {} : arguments[1];

	    var currentDepths = depths;
	    if (depths && context !== depths[0]) {
	      currentDepths = [context].concat(depths);
	    }

	    return fn(container, context, container.helpers, container.partials, options.data || data, blockParams && [options.blockParams].concat(blockParams), currentDepths);
	  }

	  prog = executeDecorators(fn, prog, container, depths, data, blockParams);

	  prog.program = i;
	  prog.depth = depths ? depths.length : 0;
	  prog.blockParams = declaredBlockParams || 0;
	  return prog;
	}

	function resolvePartial(partial, context, options) {
	  if (!partial) {
	    if (options.name === '@partial-block') {
	      partial = options.data['partial-block'];
	    } else {
	      partial = options.partials[options.name];
	    }
	  } else if (!partial.call && !options.name) {
	    // This is a dynamic partial that returned a string
	    options.name = partial;
	    partial = options.partials[partial];
	  }
	  return partial;
	}

	function invokePartial(partial, context, options) {
	  options.partial = true;
	  if (options.ids) {
	    options.data.contextPath = options.ids[0] || options.data.contextPath;
	  }

	  var partialBlock = undefined;
	  if (options.fn && options.fn !== noop) {
	    options.data = _base.createFrame(options.data);
	    partialBlock = options.data['partial-block'] = options.fn;

	    if (partialBlock.partials) {
	      options.partials = Utils.extend({}, options.partials, partialBlock.partials);
	    }
	  }

	  if (partial === undefined && partialBlock) {
	    partial = partialBlock;
	  }

	  if (partial === undefined) {
	    throw new _exception2['default']('The partial ' + options.name + ' could not be found');
	  } else if (partial instanceof Function) {
	    return partial(context, options);
	  }
	}

	function noop() {
	  return '';
	}

	function initData(context, data) {
	  if (!data || !('root' in data)) {
	    data = data ? _base.createFrame(data) : {};
	    data.root = context;
	  }
	  return data;
	}

	function executeDecorators(fn, prog, container, depths, data, blockParams) {
	  if (fn.decorator) {
	    var props = {};
	    prog = fn.decorator(prog, props, container, depths && depths[0], data, blockParams, depths);
	    Utils.extend(prog, props);
	  }
	  return prog;
	}

/***/ },
/* 20 */
/***/ function(module, exports) {

	/* WEBPACK VAR INJECTION */(function(global) {/* global window */
	'use strict';

	exports.__esModule = true;

	exports['default'] = function (Handlebars) {
	  /* istanbul ignore next */
	  var root = typeof global !== 'undefined' ? global : window,
	      $Handlebars = root.Handlebars;
	  /* istanbul ignore next */
	  Handlebars.noConflict = function () {
	    if (root.Handlebars === Handlebars) {
	      root.Handlebars = $Handlebars;
	    }
	    return Handlebars;
	  };
	};

	module.exports = exports['default'];
	/* WEBPACK VAR INJECTION */}.call(exports, (function() { return this; }())))

/***/ },
/* 21 */
/***/ function(module, exports) {

	'use strict';

	exports.__esModule = true;
	var AST = {
	  // Public API used to evaluate derived attributes regarding AST nodes
	  helpers: {
	    // a mustache is definitely a helper if:
	    // * it is an eligible helper, and
	    // * it has at least one parameter or hash segment
	    helperExpression: function helperExpression(node) {
	      return node.type === 'SubExpression' || (node.type === 'MustacheStatement' || node.type === 'BlockStatement') && !!(node.params && node.params.length || node.hash);
	    },

	    scopedId: function scopedId(path) {
	      return (/^\.|this\b/.test(path.original)
	      );
	    },

	    // an ID is simple if it only has one part, and that part is not
	    // `..` or `this`.
	    simpleId: function simpleId(path) {
	      return path.parts.length === 1 && !AST.helpers.scopedId(path) && !path.depth;
	    }
	  }
	};

	// Must be exported as an object rather than the root of the module as the jison lexer
	// must modify the object to operate properly.
	exports['default'] = AST;
	module.exports = exports['default'];

/***/ },
/* 22 */
/***/ function(module, exports, __webpack_require__) {

	'use strict';

	var _interopRequireDefault = __webpack_require__(1)['default'];

	var _interopRequireWildcard = __webpack_require__(3)['default'];

	exports.__esModule = true;
	exports.parse = parse;

	var _parser = __webpack_require__(23);

	var _parser2 = _interopRequireDefault(_parser);

	var _whitespaceControl = __webpack_require__(24);

	var _whitespaceControl2 = _interopRequireDefault(_whitespaceControl);

	var _helpers = __webpack_require__(26);

	var Helpers = _interopRequireWildcard(_helpers);

	var _utils = __webpack_require__(5);

	exports.parser = _parser2['default'];

	var yy = {};
	_utils.extend(yy, Helpers);

	function parse(input, options) {
	  // Just return if an already-compiled AST was passed in.
	  if (input.type === 'Program') {
	    return input;
	  }

	  _parser2['default'].yy = yy;

	  // Altering the shared object here, but this is ok as parser is a sync operation
	  yy.locInfo = function (locInfo) {
	    return new yy.SourceLocation(options && options.srcName, locInfo);
	  };

	  var strip = new _whitespaceControl2['default'](options);
	  return strip.accept(_parser2['default'].parse(input));
	}

/***/ },
/* 23 */
/***/ function(module, exports) {

	/* istanbul ignore next */
	/* Jison generated parser */
	"use strict";

	var handlebars = (function () {
	    var parser = { trace: function trace() {},
	        yy: {},
	        symbols_: { "error": 2, "root": 3, "program": 4, "EOF": 5, "program_repetition0": 6, "statement": 7, "mustache": 8, "block": 9, "rawBlock": 10, "partial": 11, "partialBlock": 12, "content": 13, "COMMENT": 14, "CONTENT": 15, "openRawBlock": 16, "rawBlock_repetition_plus0": 17, "END_RAW_BLOCK": 18, "OPEN_RAW_BLOCK": 19, "helperName": 20, "openRawBlock_repetition0": 21, "openRawBlock_option0": 22, "CLOSE_RAW_BLOCK": 23, "openBlock": 24, "block_option0": 25, "closeBlock": 26, "openInverse": 27, "block_option1": 28, "OPEN_BLOCK": 29, "openBlock_repetition0": 30, "openBlock_option0": 31, "openBlock_option1": 32, "CLOSE": 33, "OPEN_INVERSE": 34, "openInverse_repetition0": 35, "openInverse_option0": 36, "openInverse_option1": 37, "openInverseChain": 38, "OPEN_INVERSE_CHAIN": 39, "openInverseChain_repetition0": 40, "openInverseChain_option0": 41, "openInverseChain_option1": 42, "inverseAndProgram": 43, "INVERSE": 44, "inverseChain": 45, "inverseChain_option0": 46, "OPEN_ENDBLOCK": 47, "OPEN": 48, "mustache_repetition0": 49, "mustache_option0": 50, "OPEN_UNESCAPED": 51, "mustache_repetition1": 52, "mustache_option1": 53, "CLOSE_UNESCAPED": 54, "OPEN_PARTIAL": 55, "partialName": 56, "partial_repetition0": 57, "partial_option0": 58, "openPartialBlock": 59, "OPEN_PARTIAL_BLOCK": 60, "openPartialBlock_repetition0": 61, "openPartialBlock_option0": 62, "param": 63, "sexpr": 64, "OPEN_SEXPR": 65, "sexpr_repetition0": 66, "sexpr_option0": 67, "CLOSE_SEXPR": 68, "hash": 69, "hash_repetition_plus0": 70, "hashSegment": 71, "ID": 72, "EQUALS": 73, "blockParams": 74, "OPEN_BLOCK_PARAMS": 75, "blockParams_repetition_plus0": 76, "CLOSE_BLOCK_PARAMS": 77, "path": 78, "dataName": 79, "STRING": 80, "NUMBER": 81, "BOOLEAN": 82, "UNDEFINED": 83, "NULL": 84, "DATA": 85, "pathSegments": 86, "SEP": 87, "$accept": 0, "$end": 1 },
	        terminals_: { 2: "error", 5: "EOF", 14: "COMMENT", 15: "CONTENT", 18: "END_RAW_BLOCK", 19: "OPEN_RAW_BLOCK", 23: "CLOSE_RAW_BLOCK", 29: "OPEN_BLOCK", 33: "CLOSE", 34: "OPEN_INVERSE", 39: "OPEN_INVERSE_CHAIN", 44: "INVERSE", 47: "OPEN_ENDBLOCK", 48: "OPEN", 51: "OPEN_UNESCAPED", 54: "CLOSE_UNESCAPED", 55: "OPEN_PARTIAL", 60: "OPEN_PARTIAL_BLOCK", 65: "OPEN_SEXPR", 68: "CLOSE_SEXPR", 72: "ID", 73: "EQUALS", 75: "OPEN_BLOCK_PARAMS", 77: "CLOSE_BLOCK_PARAMS", 80: "STRING", 81: "NUMBER", 82: "BOOLEAN", 83: "UNDEFINED", 84: "NULL", 85: "DATA", 87: "SEP" },
	        productions_: [0, [3, 2], [4, 1], [7, 1], [7, 1], [7, 1], [7, 1], [7, 1], [7, 1], [7, 1], [13, 1], [10, 3], [16, 5], [9, 4], [9, 4], [24, 6], [27, 6], [38, 6], [43, 2], [45, 3], [45, 1], [26, 3], [8, 5], [8, 5], [11, 5], [12, 3], [59, 5], [63, 1], [63, 1], [64, 5], [69, 1], [71, 3], [74, 3], [20, 1], [20, 1], [20, 1], [20, 1], [20, 1], [20, 1], [20, 1], [56, 1], [56, 1], [79, 2], [78, 1], [86, 3], [86, 1], [6, 0], [6, 2], [17, 1], [17, 2], [21, 0], [21, 2], [22, 0], [22, 1], [25, 0], [25, 1], [28, 0], [28, 1], [30, 0], [30, 2], [31, 0], [31, 1], [32, 0], [32, 1], [35, 0], [35, 2], [36, 0], [36, 1], [37, 0], [37, 1], [40, 0], [40, 2], [41, 0], [41, 1], [42, 0], [42, 1], [46, 0], [46, 1], [49, 0], [49, 2], [50, 0], [50, 1], [52, 0], [52, 2], [53, 0], [53, 1], [57, 0], [57, 2], [58, 0], [58, 1], [61, 0], [61, 2], [62, 0], [62, 1], [66, 0], [66, 2], [67, 0], [67, 1], [70, 1], [70, 2], [76, 1], [76, 2]],
	        performAction: function anonymous(yytext, yyleng, yylineno, yy, yystate, $$, _$
	        /**/) {

	            var $0 = $$.length - 1;
	            switch (yystate) {
	                case 1:
	                    return $$[$0 - 1];
	                    break;
	                case 2:
	                    this.$ = yy.prepareProgram($$[$0]);
	                    break;
	                case 3:
	                    this.$ = $$[$0];
	                    break;
	                case 4:
	                    this.$ = $$[$0];
	                    break;
	                case 5:
	                    this.$ = $$[$0];
	                    break;
	                case 6:
	                    this.$ = $$[$0];
	                    break;
	                case 7:
	                    this.$ = $$[$0];
	                    break;
	                case 8:
	                    this.$ = $$[$0];
	                    break;
	                case 9:
	                    this.$ = {
	                        type: 'CommentStatement',
	                        value: yy.stripComment($$[$0]),
	                        strip: yy.stripFlags($$[$0], $$[$0]),
	                        loc: yy.locInfo(this._$)
	                    };

	                    break;
	                case 10:
	                    this.$ = {
	                        type: 'ContentStatement',
	                        original: $$[$0],
	                        value: $$[$0],
	                        loc: yy.locInfo(this._$)
	                    };

	                    break;
	                case 11:
	                    this.$ = yy.prepareRawBlock($$[$0 - 2], $$[$0 - 1], $$[$0], this._$);
	                    break;
	                case 12:
	                    this.$ = { path: $$[$0 - 3], params: $$[$0 - 2], hash: $$[$0 - 1] };
	                    break;
	                case 13:
	                    this.$ = yy.prepareBlock($$[$0 - 3], $$[$0 - 2], $$[$0 - 1], $$[$0], false, this._$);
	                    break;
	                case 14:
	                    this.$ = yy.prepareBlock($$[$0 - 3], $$[$0 - 2], $$[$0 - 1], $$[$0], true, this._$);
	                    break;
	                case 15:
	                    this.$ = { open: $$[$0 - 5], path: $$[$0 - 4], params: $$[$0 - 3], hash: $$[$0 - 2], blockParams: $$[$0 - 1], strip: yy.stripFlags($$[$0 - 5], $$[$0]) };
	                    break;
	                case 16:
	                    this.$ = { path: $$[$0 - 4], params: $$[$0 - 3], hash: $$[$0 - 2], blockParams: $$[$0 - 1], strip: yy.stripFlags($$[$0 - 5], $$[$0]) };
	                    break;
	                case 17:
	                    this.$ = { path: $$[$0 - 4], params: $$[$0 - 3], hash: $$[$0 - 2], blockParams: $$[$0 - 1], strip: yy.stripFlags($$[$0 - 5], $$[$0]) };
	                    break;
	                case 18:
	                    this.$ = { strip: yy.stripFlags($$[$0 - 1], $$[$0 - 1]), program: $$[$0] };
	                    break;
	                case 19:
	                    var inverse = yy.prepareBlock($$[$0 - 2], $$[$0 - 1], $$[$0], $$[$0], false, this._$),
	                        program = yy.prepareProgram([inverse], $$[$0 - 1].loc);
	                    program.chained = true;

	                    this.$ = { strip: $$[$0 - 2].strip, program: program, chain: true };

	                    break;
	                case 20:
	                    this.$ = $$[$0];
	                    break;
	                case 21:
	                    this.$ = { path: $$[$0 - 1], strip: yy.stripFlags($$[$0 - 2], $$[$0]) };
	                    break;
	                case 22:
	                    this.$ = yy.prepareMustache($$[$0 - 3], $$[$0 - 2], $$[$0 - 1], $$[$0 - 4], yy.stripFlags($$[$0 - 4], $$[$0]), this._$);
	                    break;
	                case 23:
	                    this.$ = yy.prepareMustache($$[$0 - 3], $$[$0 - 2], $$[$0 - 1], $$[$0 - 4], yy.stripFlags($$[$0 - 4], $$[$0]), this._$);
	                    break;
	                case 24:
	                    this.$ = {
	                        type: 'PartialStatement',
	                        name: $$[$0 - 3],
	                        params: $$[$0 - 2],
	                        hash: $$[$0 - 1],
	                        indent: '',
	                        strip: yy.stripFlags($$[$0 - 4], $$[$0]),
	                        loc: yy.locInfo(this._$)
	                    };

	                    break;
	                case 25:
	                    this.$ = yy.preparePartialBlock($$[$0 - 2], $$[$0 - 1], $$[$0], this._$);
	                    break;
	                case 26:
	                    this.$ = { path: $$[$0 - 3], params: $$[$0 - 2], hash: $$[$0 - 1], strip: yy.stripFlags($$[$0 - 4], $$[$0]) };
	                    break;
	                case 27:
	                    this.$ = $$[$0];
	                    break;
	                case 28:
	                    this.$ = $$[$0];
	                    break;
	                case 29:
	                    this.$ = {
	                        type: 'SubExpression',
	                        path: $$[$0 - 3],
	                        params: $$[$0 - 2],
	                        hash: $$[$0 - 1],
	                        loc: yy.locInfo(this._$)
	                    };

	                    break;
	                case 30:
	                    this.$ = { type: 'Hash', pairs: $$[$0], loc: yy.locInfo(this._$) };
	                    break;
	                case 31:
	                    this.$ = { type: 'HashPair', key: yy.id($$[$0 - 2]), value: $$[$0], loc: yy.locInfo(this._$) };
	                    break;
	                case 32:
	                    this.$ = yy.id($$[$0 - 1]);
	                    break;
	                case 33:
	                    this.$ = $$[$0];
	                    break;
	                case 34:
	                    this.$ = $$[$0];
	                    break;
	                case 35:
	                    this.$ = { type: 'StringLiteral', value: $$[$0], original: $$[$0], loc: yy.locInfo(this._$) };
	                    break;
	                case 36:
	                    this.$ = { type: 'NumberLiteral', value: Number($$[$0]), original: Number($$[$0]), loc: yy.locInfo(this._$) };
	                    break;
	                case 37:
	                    this.$ = { type: 'BooleanLiteral', value: $$[$0] === 'true', original: $$[$0] === 'true', loc: yy.locInfo(this._$) };
	                    break;
	                case 38:
	                    this.$ = { type: 'UndefinedLiteral', original: undefined, value: undefined, loc: yy.locInfo(this._$) };
	                    break;
	                case 39:
	                    this.$ = { type: 'NullLiteral', original: null, value: null, loc: yy.locInfo(this._$) };
	                    break;
	                case 40:
	                    this.$ = $$[$0];
	                    break;
	                case 41:
	                    this.$ = $$[$0];
	                    break;
	                case 42:
	                    this.$ = yy.preparePath(true, $$[$0], this._$);
	                    break;
	                case 43:
	                    this.$ = yy.preparePath(false, $$[$0], this._$);
	                    break;
	                case 44:
	                    $$[$0 - 2].push({ part: yy.id($$[$0]), original: $$[$0], separator: $$[$0 - 1] });this.$ = $$[$0 - 2];
	                    break;
	                case 45:
	                    this.$ = [{ part: yy.id($$[$0]), original: $$[$0] }];
	                    break;
	                case 46:
	                    this.$ = [];
	                    break;
	                case 47:
	                    $$[$0 - 1].push($$[$0]);
	                    break;
	                case 48:
	                    this.$ = [$$[$0]];
	                    break;
	                case 49:
	                    $$[$0 - 1].push($$[$0]);
	                    break;
	                case 50:
	                    this.$ = [];
	                    break;
	                case 51:
	                    $$[$0 - 1].push($$[$0]);
	                    break;
	                case 58:
	                    this.$ = [];
	                    break;
	                case 59:
	                    $$[$0 - 1].push($$[$0]);
	                    break;
	                case 64:
	                    this.$ = [];
	                    break;
	                case 65:
	                    $$[$0 - 1].push($$[$0]);
	                    break;
	                case 70:
	                    this.$ = [];
	                    break;
	                case 71:
	                    $$[$0 - 1].push($$[$0]);
	                    break;
	                case 78:
	                    this.$ = [];
	                    break;
	                case 79:
	                    $$[$0 - 1].push($$[$0]);
	                    break;
	                case 82:
	                    this.$ = [];
	                    break;
	                case 83:
	                    $$[$0 - 1].push($$[$0]);
	                    break;
	                case 86:
	                    this.$ = [];
	                    break;
	                case 87:
	                    $$[$0 - 1].push($$[$0]);
	                    break;
	                case 90:
	                    this.$ = [];
	                    break;
	                case 91:
	                    $$[$0 - 1].push($$[$0]);
	                    break;
	                case 94:
	                    this.$ = [];
	                    break;
	                case 95:
	                    $$[$0 - 1].push($$[$0]);
	                    break;
	                case 98:
	                    this.$ = [$$[$0]];
	                    break;
	                case 99:
	                    $$[$0 - 1].push($$[$0]);
	                    break;
	                case 100:
	                    this.$ = [$$[$0]];
	                    break;
	                case 101:
	                    $$[$0 - 1].push($$[$0]);
	                    break;
	            }
	        },
	        table: [{ 3: 1, 4: 2, 5: [2, 46], 6: 3, 14: [2, 46], 15: [2, 46], 19: [2, 46], 29: [2, 46], 34: [2, 46], 48: [2, 46], 51: [2, 46], 55: [2, 46], 60: [2, 46] }, { 1: [3] }, { 5: [1, 4] }, { 5: [2, 2], 7: 5, 8: 6, 9: 7, 10: 8, 11: 9, 12: 10, 13: 11, 14: [1, 12], 15: [1, 20], 16: 17, 19: [1, 23], 24: 15, 27: 16, 29: [1, 21], 34: [1, 22], 39: [2, 2], 44: [2, 2], 47: [2, 2], 48: [1, 13], 51: [1, 14], 55: [1, 18], 59: 19, 60: [1, 24] }, { 1: [2, 1] }, { 5: [2, 47], 14: [2, 47], 15: [2, 47], 19: [2, 47], 29: [2, 47], 34: [2, 47], 39: [2, 47], 44: [2, 47], 47: [2, 47], 48: [2, 47], 51: [2, 47], 55: [2, 47], 60: [2, 47] }, { 5: [2, 3], 14: [2, 3], 15: [2, 3], 19: [2, 3], 29: [2, 3], 34: [2, 3], 39: [2, 3], 44: [2, 3], 47: [2, 3], 48: [2, 3], 51: [2, 3], 55: [2, 3], 60: [2, 3] }, { 5: [2, 4], 14: [2, 4], 15: [2, 4], 19: [2, 4], 29: [2, 4], 34: [2, 4], 39: [2, 4], 44: [2, 4], 47: [2, 4], 48: [2, 4], 51: [2, 4], 55: [2, 4], 60: [2, 4] }, { 5: [2, 5], 14: [2, 5], 15: [2, 5], 19: [2, 5], 29: [2, 5], 34: [2, 5], 39: [2, 5], 44: [2, 5], 47: [2, 5], 48: [2, 5], 51: [2, 5], 55: [2, 5], 60: [2, 5] }, { 5: [2, 6], 14: [2, 6], 15: [2, 6], 19: [2, 6], 29: [2, 6], 34: [2, 6], 39: [2, 6], 44: [2, 6], 47: [2, 6], 48: [2, 6], 51: [2, 6], 55: [2, 6], 60: [2, 6] }, { 5: [2, 7], 14: [2, 7], 15: [2, 7], 19: [2, 7], 29: [2, 7], 34: [2, 7], 39: [2, 7], 44: [2, 7], 47: [2, 7], 48: [2, 7], 51: [2, 7], 55: [2, 7], 60: [2, 7] }, { 5: [2, 8], 14: [2, 8], 15: [2, 8], 19: [2, 8], 29: [2, 8], 34: [2, 8], 39: [2, 8], 44: [2, 8], 47: [2, 8], 48: [2, 8], 51: [2, 8], 55: [2, 8], 60: [2, 8] }, { 5: [2, 9], 14: [2, 9], 15: [2, 9], 19: [2, 9], 29: [2, 9], 34: [2, 9], 39: [2, 9], 44: [2, 9], 47: [2, 9], 48: [2, 9], 51: [2, 9], 55: [2, 9], 60: [2, 9] }, { 20: 25, 72: [1, 35], 78: 26, 79: 27, 80: [1, 28], 81: [1, 29], 82: [1, 30], 83: [1, 31], 84: [1, 32], 85: [1, 34], 86: 33 }, { 20: 36, 72: [1, 35], 78: 26, 79: 27, 80: [1, 28], 81: [1, 29], 82: [1, 30], 83: [1, 31], 84: [1, 32], 85: [1, 34], 86: 33 }, { 4: 37, 6: 3, 14: [2, 46], 15: [2, 46], 19: [2, 46], 29: [2, 46], 34: [2, 46], 39: [2, 46], 44: [2, 46], 47: [2, 46], 48: [2, 46], 51: [2, 46], 55: [2, 46], 60: [2, 46] }, { 4: 38, 6: 3, 14: [2, 46], 15: [2, 46], 19: [2, 46], 29: [2, 46], 34: [2, 46], 44: [2, 46], 47: [2, 46], 48: [2, 46], 51: [2, 46], 55: [2, 46], 60: [2, 46] }, { 13: 40, 15: [1, 20], 17: 39 }, { 20: 42, 56: 41, 64: 43, 65: [1, 44], 72: [1, 35], 78: 26, 79: 27, 80: [1, 28], 81: [1, 29], 82: [1, 30], 83: [1, 31], 84: [1, 32], 85: [1, 34], 86: 33 }, { 4: 45, 6: 3, 14: [2, 46], 15: [2, 46], 19: [2, 46], 29: [2, 46], 34: [2, 46], 47: [2, 46], 48: [2, 46], 51: [2, 46], 55: [2, 46], 60: [2, 46] }, { 5: [2, 10], 14: [2, 10], 15: [2, 10], 18: [2, 10], 19: [2, 10], 29: [2, 10], 34: [2, 10], 39: [2, 10], 44: [2, 10], 47: [2, 10], 48: [2, 10], 51: [2, 10], 55: [2, 10], 60: [2, 10] }, { 20: 46, 72: [1, 35], 78: 26, 79: 27, 80: [1, 28], 81: [1, 29], 82: [1, 30], 83: [1, 31], 84: [1, 32], 85: [1, 34], 86: 33 }, { 20: 47, 72: [1, 35], 78: 26, 79: 27, 80: [1, 28], 81: [1, 29], 82: [1, 30], 83: [1, 31], 84: [1, 32], 85: [1, 34], 86: 33 }, { 20: 48, 72: [1, 35], 78: 26, 79: 27, 80: [1, 28], 81: [1, 29], 82: [1, 30], 83: [1, 31], 84: [1, 32], 85: [1, 34], 86: 33 }, { 20: 42, 56: 49, 64: 43, 65: [1, 44], 72: [1, 35], 78: 26, 79: 27, 80: [1, 28], 81: [1, 29], 82: [1, 30], 83: [1, 31], 84: [1, 32], 85: [1, 34], 86: 33 }, { 33: [2, 78], 49: 50, 65: [2, 78], 72: [2, 78], 80: [2, 78], 81: [2, 78], 82: [2, 78], 83: [2, 78], 84: [2, 78], 85: [2, 78] }, { 23: [2, 33], 33: [2, 33], 54: [2, 33], 65: [2, 33], 68: [2, 33], 72: [2, 33], 75: [2, 33], 80: [2, 33], 81: [2, 33], 82: [2, 33], 83: [2, 33], 84: [2, 33], 85: [2, 33] }, { 23: [2, 34], 33: [2, 34], 54: [2, 34], 65: [2, 34], 68: [2, 34], 72: [2, 34], 75: [2, 34], 80: [2, 34], 81: [2, 34], 82: [2, 34], 83: [2, 34], 84: [2, 34], 85: [2, 34] }, { 23: [2, 35], 33: [2, 35], 54: [2, 35], 65: [2, 35], 68: [2, 35], 72: [2, 35], 75: [2, 35], 80: [2, 35], 81: [2, 35], 82: [2, 35], 83: [2, 35], 84: [2, 35], 85: [2, 35] }, { 23: [2, 36], 33: [2, 36], 54: [2, 36], 65: [2, 36], 68: [2, 36], 72: [2, 36], 75: [2, 36], 80: [2, 36], 81: [2, 36], 82: [2, 36], 83: [2, 36], 84: [2, 36], 85: [2, 36] }, { 23: [2, 37], 33: [2, 37], 54: [2, 37], 65: [2, 37], 68: [2, 37], 72: [2, 37], 75: [2, 37], 80: [2, 37], 81: [2, 37], 82: [2, 37], 83: [2, 37], 84: [2, 37], 85: [2, 37] }, { 23: [2, 38], 33: [2, 38], 54: [2, 38], 65: [2, 38], 68: [2, 38], 72: [2, 38], 75: [2, 38], 80: [2, 38], 81: [2, 38], 82: [2, 38], 83: [2, 38], 84: [2, 38], 85: [2, 38] }, { 23: [2, 39], 33: [2, 39], 54: [2, 39], 65: [2, 39], 68: [2, 39], 72: [2, 39], 75: [2, 39], 80: [2, 39], 81: [2, 39], 82: [2, 39], 83: [2, 39], 84: [2, 39], 85: [2, 39] }, { 23: [2, 43], 33: [2, 43], 54: [2, 43], 65: [2, 43], 68: [2, 43], 72: [2, 43], 75: [2, 43], 80: [2, 43], 81: [2, 43], 82: [2, 43], 83: [2, 43], 84: [2, 43], 85: [2, 43], 87: [1, 51] }, { 72: [1, 35], 86: 52 }, { 23: [2, 45], 33: [2, 45], 54: [2, 45], 65: [2, 45], 68: [2, 45], 72: [2, 45], 75: [2, 45], 80: [2, 45], 81: [2, 45], 82: [2, 45], 83: [2, 45], 84: [2, 45], 85: [2, 45], 87: [2, 45] }, { 52: 53, 54: [2, 82], 65: [2, 82], 72: [2, 82], 80: [2, 82], 81: [2, 82], 82: [2, 82], 83: [2, 82], 84: [2, 82], 85: [2, 82] }, { 25: 54, 38: 56, 39: [1, 58], 43: 57, 44: [1, 59], 45: 55, 47: [2, 54] }, { 28: 60, 43: 61, 44: [1, 59], 47: [2, 56] }, { 13: 63, 15: [1, 20], 18: [1, 62] }, { 15: [2, 48], 18: [2, 48] }, { 33: [2, 86], 57: 64, 65: [2, 86], 72: [2, 86], 80: [2, 86], 81: [2, 86], 82: [2, 86], 83: [2, 86], 84: [2, 86], 85: [2, 86] }, { 33: [2, 40], 65: [2, 40], 72: [2, 40], 80: [2, 40], 81: [2, 40], 82: [2, 40], 83: [2, 40], 84: [2, 40], 85: [2, 40] }, { 33: [2, 41], 65: [2, 41], 72: [2, 41], 80: [2, 41], 81: [2, 41], 82: [2, 41], 83: [2, 41], 84: [2, 41], 85: [2, 41] }, { 20: 65, 72: [1, 35], 78: 26, 79: 27, 80: [1, 28], 81: [1, 29], 82: [1, 30], 83: [1, 31], 84: [1, 32], 85: [1, 34], 86: 33 }, { 26: 66, 47: [1, 67] }, { 30: 68, 33: [2, 58], 65: [2, 58], 72: [2, 58], 75: [2, 58], 80: [2, 58], 81: [2, 58], 82: [2, 58], 83: [2, 58], 84: [2, 58], 85: [2, 58] }, { 33: [2, 64], 35: 69, 65: [2, 64], 72: [2, 64], 75: [2, 64], 80: [2, 64], 81: [2, 64], 82: [2, 64], 83: [2, 64], 84: [2, 64], 85: [2, 64] }, { 21: 70, 23: [2, 50], 65: [2, 50], 72: [2, 50], 80: [2, 50], 81: [2, 50], 82: [2, 50], 83: [2, 50], 84: [2, 50], 85: [2, 50] }, { 33: [2, 90], 61: 71, 65: [2, 90], 72: [2, 90], 80: [2, 90], 81: [2, 90], 82: [2, 90], 83: [2, 90], 84: [2, 90], 85: [2, 90] }, { 20: 75, 33: [2, 80], 50: 72, 63: 73, 64: 76, 65: [1, 44], 69: 74, 70: 77, 71: 78, 72: [1, 79], 78: 26, 79: 27, 80: [1, 28], 81: [1, 29], 82: [1, 30], 83: [1, 31], 84: [1, 32], 85: [1, 34], 86: 33 }, { 72: [1, 80] }, { 23: [2, 42], 33: [2, 42], 54: [2, 42], 65: [2, 42], 68: [2, 42], 72: [2, 42], 75: [2, 42], 80: [2, 42], 81: [2, 42], 82: [2, 42], 83: [2, 42], 84: [2, 42], 85: [2, 42], 87: [1, 51] }, { 20: 75, 53: 81, 54: [2, 84], 63: 82, 64: 76, 65: [1, 44], 69: 83, 70: 77, 71: 78, 72: [1, 79], 78: 26, 79: 27, 80: [1, 28], 81: [1, 29], 82: [1, 30], 83: [1, 31], 84: [1, 32], 85: [1, 34], 86: 33 }, { 26: 84, 47: [1, 67] }, { 47: [2, 55] }, { 4: 85, 6: 3, 14: [2, 46], 15: [2, 46], 19: [2, 46], 29: [2, 46], 34: [2, 46], 39: [2, 46], 44: [2, 46], 47: [2, 46], 48: [2, 46], 51: [2, 46], 55: [2, 46], 60: [2, 46] }, { 47: [2, 20] }, { 20: 86, 72: [1, 35], 78: 26, 79: 27, 80: [1, 28], 81: [1, 29], 82: [1, 30], 83: [1, 31], 84: [1, 32], 85: [1, 34], 86: 33 }, { 4: 87, 6: 3, 14: [2, 46], 15: [2, 46], 19: [2, 46], 29: [2, 46], 34: [2, 46], 47: [2, 46], 48: [2, 46], 51: [2, 46], 55: [2, 46], 60: [2, 46] }, { 26: 88, 47: [1, 67] }, { 47: [2, 57] }, { 5: [2, 11], 14: [2, 11], 15: [2, 11], 19: [2, 11], 29: [2, 11], 34: [2, 11], 39: [2, 11], 44: [2, 11], 47: [2, 11], 48: [2, 11], 51: [2, 11], 55: [2, 11], 60: [2, 11] }, { 15: [2, 49], 18: [2, 49] }, { 20: 75, 33: [2, 88], 58: 89, 63: 90, 64: 76, 65: [1, 44], 69: 91, 70: 77, 71: 78, 72: [1, 79], 78: 26, 79: 27, 80: [1, 28], 81: [1, 29], 82: [1, 30], 83: [1, 31], 84: [1, 32], 85: [1, 34], 86: 33 }, { 65: [2, 94], 66: 92, 68: [2, 94], 72: [2, 94], 80: [2, 94], 81: [2, 94], 82: [2, 94], 83: [2, 94], 84: [2, 94], 85: [2, 94] }, { 5: [2, 25], 14: [2, 25], 15: [2, 25], 19: [2, 25], 29: [2, 25], 34: [2, 25], 39: [2, 25], 44: [2, 25], 47: [2, 25], 48: [2, 25], 51: [2, 25], 55: [2, 25], 60: [2, 25] }, { 20: 93, 72: [1, 35], 78: 26, 79: 27, 80: [1, 28], 81: [1, 29], 82: [1, 30], 83: [1, 31], 84: [1, 32], 85: [1, 34], 86: 33 }, { 20: 75, 31: 94, 33: [2, 60], 63: 95, 64: 76, 65: [1, 44], 69: 96, 70: 77, 71: 78, 72: [1, 79], 75: [2, 60], 78: 26, 79: 27, 80: [1, 28], 81: [1, 29], 82: [1, 30], 83: [1, 31], 84: [1, 32], 85: [1, 34], 86: 33 }, { 20: 75, 33: [2, 66], 36: 97, 63: 98, 64: 76, 65: [1, 44], 69: 99, 70: 77, 71: 78, 72: [1, 79], 75: [2, 66], 78: 26, 79: 27, 80: [1, 28], 81: [1, 29], 82: [1, 30], 83: [1, 31], 84: [1, 32], 85: [1, 34], 86: 33 }, { 20: 75, 22: 100, 23: [2, 52], 63: 101, 64: 76, 65: [1, 44], 69: 102, 70: 77, 71: 78, 72: [1, 79], 78: 26, 79: 27, 80: [1, 28], 81: [1, 29], 82: [1, 30], 83: [1, 31], 84: [1, 32], 85: [1, 34], 86: 33 }, { 20: 75, 33: [2, 92], 62: 103, 63: 104, 64: 76, 65: [1, 44], 69: 105, 70: 77, 71: 78, 72: [1, 79], 78: 26, 79: 27, 80: [1, 28], 81: [1, 29], 82: [1, 30], 83: [1, 31], 84: [1, 32], 85: [1, 34], 86: 33 }, { 33: [1, 106] }, { 33: [2, 79], 65: [2, 79], 72: [2, 79], 80: [2, 79], 81: [2, 79], 82: [2, 79], 83: [2, 79], 84: [2, 79], 85: [2, 79] }, { 33: [2, 81] }, { 23: [2, 27], 33: [2, 27], 54: [2, 27], 65: [2, 27], 68: [2, 27], 72: [2, 27], 75: [2, 27], 80: [2, 27], 81: [2, 27], 82: [2, 27], 83: [2, 27], 84: [2, 27], 85: [2, 27] }, { 23: [2, 28], 33: [2, 28], 54: [2, 28], 65: [2, 28], 68: [2, 28], 72: [2, 28], 75: [2, 28], 80: [2, 28], 81: [2, 28], 82: [2, 28], 83: [2, 28], 84: [2, 28], 85: [2, 28] }, { 23: [2, 30], 33: [2, 30], 54: [2, 30], 68: [2, 30], 71: 107, 72: [1, 108], 75: [2, 30] }, { 23: [2, 98], 33: [2, 98], 54: [2, 98], 68: [2, 98], 72: [2, 98], 75: [2, 98] }, { 23: [2, 45], 33: [2, 45], 54: [2, 45], 65: [2, 45], 68: [2, 45], 72: [2, 45], 73: [1, 109], 75: [2, 45], 80: [2, 45], 81: [2, 45], 82: [2, 45], 83: [2, 45], 84: [2, 45], 85: [2, 45], 87: [2, 45] }, { 23: [2, 44], 33: [2, 44], 54: [2, 44], 65: [2, 44], 68: [2, 44], 72: [2, 44], 75: [2, 44], 80: [2, 44], 81: [2, 44], 82: [2, 44], 83: [2, 44], 84: [2, 44], 85: [2, 44], 87: [2, 44] }, { 54: [1, 110] }, { 54: [2, 83], 65: [2, 83], 72: [2, 83], 80: [2, 83], 81: [2, 83], 82: [2, 83], 83: [2, 83], 84: [2, 83], 85: [2, 83] }, { 54: [2, 85] }, { 5: [2, 13], 14: [2, 13], 15: [2, 13], 19: [2, 13], 29: [2, 13], 34: [2, 13], 39: [2, 13], 44: [2, 13], 47: [2, 13], 48: [2, 13], 51: [2, 13], 55: [2, 13], 60: [2, 13] }, { 38: 56, 39: [1, 58], 43: 57, 44: [1, 59], 45: 112, 46: 111, 47: [2, 76] }, { 33: [2, 70], 40: 113, 65: [2, 70], 72: [2, 70], 75: [2, 70], 80: [2, 70], 81: [2, 70], 82: [2, 70], 83: [2, 70], 84: [2, 70], 85: [2, 70] }, { 47: [2, 18] }, { 5: [2, 14], 14: [2, 14], 15: [2, 14], 19: [2, 14], 29: [2, 14], 34: [2, 14], 39: [2, 14], 44: [2, 14], 47: [2, 14], 48: [2, 14], 51: [2, 14], 55: [2, 14], 60: [2, 14] }, { 33: [1, 114] }, { 33: [2, 87], 65: [2, 87], 72: [2, 87], 80: [2, 87], 81: [2, 87], 82: [2, 87], 83: [2, 87], 84: [2, 87], 85: [2, 87] }, { 33: [2, 89] }, { 20: 75, 63: 116, 64: 76, 65: [1, 44], 67: 115, 68: [2, 96], 69: 117, 70: 77, 71: 78, 72: [1, 79], 78: 26, 79: 27, 80: [1, 28], 81: [1, 29], 82: [1, 30], 83: [1, 31], 84: [1, 32], 85: [1, 34], 86: 33 }, { 33: [1, 118] }, { 32: 119, 33: [2, 62], 74: 120, 75: [1, 121] }, { 33: [2, 59], 65: [2, 59], 72: [2, 59], 75: [2, 59], 80: [2, 59], 81: [2, 59], 82: [2, 59], 83: [2, 59], 84: [2, 59], 85: [2, 59] }, { 33: [2, 61], 75: [2, 61] }, { 33: [2, 68], 37: 122, 74: 123, 75: [1, 121] }, { 33: [2, 65], 65: [2, 65], 72: [2, 65], 75: [2, 65], 80: [2, 65], 81: [2, 65], 82: [2, 65], 83: [2, 65], 84: [2, 65], 85: [2, 65] }, { 33: [2, 67], 75: [2, 67] }, { 23: [1, 124] }, { 23: [2, 51], 65: [2, 51], 72: [2, 51], 80: [2, 51], 81: [2, 51], 82: [2, 51], 83: [2, 51], 84: [2, 51], 85: [2, 51] }, { 23: [2, 53] }, { 33: [1, 125] }, { 33: [2, 91], 65: [2, 91], 72: [2, 91], 80: [2, 91], 81: [2, 91], 82: [2, 91], 83: [2, 91], 84: [2, 91], 85: [2, 91] }, { 33: [2, 93] }, { 5: [2, 22], 14: [2, 22], 15: [2, 22], 19: [2, 22], 29: [2, 22], 34: [2, 22], 39: [2, 22], 44: [2, 22], 47: [2, 22], 48: [2, 22], 51: [2, 22], 55: [2, 22], 60: [2, 22] }, { 23: [2, 99], 33: [2, 99], 54: [2, 99], 68: [2, 99], 72: [2, 99], 75: [2, 99] }, { 73: [1, 109] }, { 20: 75, 63: 126, 64: 76, 65: [1, 44], 72: [1, 35], 78: 26, 79: 27, 80: [1, 28], 81: [1, 29], 82: [1, 30], 83: [1, 31], 84: [1, 32], 85: [1, 34], 86: 33 }, { 5: [2, 23], 14: [2, 23], 15: [2, 23], 19: [2, 23], 29: [2, 23], 34: [2, 23], 39: [2, 23], 44: [2, 23], 47: [2, 23], 48: [2, 23], 51: [2, 23], 55: [2, 23], 60: [2, 23] }, { 47: [2, 19] }, { 47: [2, 77] }, { 20: 75, 33: [2, 72], 41: 127, 63: 128, 64: 76, 65: [1, 44], 69: 129, 70: 77, 71: 78, 72: [1, 79], 75: [2, 72], 78: 26, 79: 27, 80: [1, 28], 81: [1, 29], 82: [1, 30], 83: [1, 31], 84: [1, 32], 85: [1, 34], 86: 33 }, { 5: [2, 24], 14: [2, 24], 15: [2, 24], 19: [2, 24], 29: [2, 24], 34: [2, 24], 39: [2, 24], 44: [2, 24], 47: [2, 24], 48: [2, 24], 51: [2, 24], 55: [2, 24], 60: [2, 24] }, { 68: [1, 130] }, { 65: [2, 95], 68: [2, 95], 72: [2, 95], 80: [2, 95], 81: [2, 95], 82: [2, 95], 83: [2, 95], 84: [2, 95], 85: [2, 95] }, { 68: [2, 97] }, { 5: [2, 21], 14: [2, 21], 15: [2, 21], 19: [2, 21], 29: [2, 21], 34: [2, 21], 39: [2, 21], 44: [2, 21], 47: [2, 21], 48: [2, 21], 51: [2, 21], 55: [2, 21], 60: [2, 21] }, { 33: [1, 131] }, { 33: [2, 63] }, { 72: [1, 133], 76: 132 }, { 33: [1, 134] }, { 33: [2, 69] }, { 15: [2, 12] }, { 14: [2, 26], 15: [2, 26], 19: [2, 26], 29: [2, 26], 34: [2, 26], 47: [2, 26], 48: [2, 26], 51: [2, 26], 55: [2, 26], 60: [2, 26] }, { 23: [2, 31], 33: [2, 31], 54: [2, 31], 68: [2, 31], 72: [2, 31], 75: [2, 31] }, { 33: [2, 74], 42: 135, 74: 136, 75: [1, 121] }, { 33: [2, 71], 65: [2, 71], 72: [2, 71], 75: [2, 71], 80: [2, 71], 81: [2, 71], 82: [2, 71], 83: [2, 71], 84: [2, 71], 85: [2, 71] }, { 33: [2, 73], 75: [2, 73] }, { 23: [2, 29], 33: [2, 29], 54: [2, 29], 65: [2, 29], 68: [2, 29], 72: [2, 29], 75: [2, 29], 80: [2, 29], 81: [2, 29], 82: [2, 29], 83: [2, 29], 84: [2, 29], 85: [2, 29] }, { 14: [2, 15], 15: [2, 15], 19: [2, 15], 29: [2, 15], 34: [2, 15], 39: [2, 15], 44: [2, 15], 47: [2, 15], 48: [2, 15], 51: [2, 15], 55: [2, 15], 60: [2, 15] }, { 72: [1, 138], 77: [1, 137] }, { 72: [2, 100], 77: [2, 100] }, { 14: [2, 16], 15: [2, 16], 19: [2, 16], 29: [2, 16], 34: [2, 16], 44: [2, 16], 47: [2, 16], 48: [2, 16], 51: [2, 16], 55: [2, 16], 60: [2, 16] }, { 33: [1, 139] }, { 33: [2, 75] }, { 33: [2, 32] }, { 72: [2, 101], 77: [2, 101] }, { 14: [2, 17], 15: [2, 17], 19: [2, 17], 29: [2, 17], 34: [2, 17], 39: [2, 17], 44: [2, 17], 47: [2, 17], 48: [2, 17], 51: [2, 17], 55: [2, 17], 60: [2, 17] }],
	        defaultActions: { 4: [2, 1], 55: [2, 55], 57: [2, 20], 61: [2, 57], 74: [2, 81], 83: [2, 85], 87: [2, 18], 91: [2, 89], 102: [2, 53], 105: [2, 93], 111: [2, 19], 112: [2, 77], 117: [2, 97], 120: [2, 63], 123: [2, 69], 124: [2, 12], 136: [2, 75], 137: [2, 32] },
	        parseError: function parseError(str, hash) {
	            throw new Error(str);
	        },
	        parse: function parse(input) {
	            var self = this,
	                stack = [0],
	                vstack = [null],
	                lstack = [],
	                table = this.table,
	                yytext = "",
	                yylineno = 0,
	                yyleng = 0,
	                recovering = 0,
	                TERROR = 2,
	                EOF = 1;
	            this.lexer.setInput(input);
	            this.lexer.yy = this.yy;
	            this.yy.lexer = this.lexer;
	            this.yy.parser = this;
	            if (typeof this.lexer.yylloc == "undefined") this.lexer.yylloc = {};
	            var yyloc = this.lexer.yylloc;
	            lstack.push(yyloc);
	            var ranges = this.lexer.options && this.lexer.options.ranges;
	            if (typeof this.yy.parseError === "function") this.parseError = this.yy.parseError;
	            function popStack(n) {
	                stack.length = stack.length - 2 * n;
	                vstack.length = vstack.length - n;
	                lstack.length = lstack.length - n;
	            }
	            function lex() {
	                var token;
	                token = self.lexer.lex() || 1;
	                if (typeof token !== "number") {
	                    token = self.symbols_[token] || token;
	                }
	                return token;
	            }
	            var symbol,
	                preErrorSymbol,
	                state,
	                action,
	                a,
	                r,
	                yyval = {},
	                p,
	                len,
	                newState,
	                expected;
	            while (true) {
	                state = stack[stack.length - 1];
	                if (this.defaultActions[state]) {
	                    action = this.defaultActions[state];
	                } else {
	                    if (symbol === null || typeof symbol == "undefined") {
	                        symbol = lex();
	                    }
	                    action = table[state] && table[state][symbol];
	                }
	                if (typeof action === "undefined" || !action.length || !action[0]) {
	                    var errStr = "";
	                    if (!recovering) {
	                        expected = [];
	                        for (p in table[state]) if (this.terminals_[p] && p > 2) {
	                            expected.push("'" + this.terminals_[p] + "'");
	                        }
	                        if (this.lexer.showPosition) {
	                            errStr = "Parse error on line " + (yylineno + 1) + ":\n" + this.lexer.showPosition() + "\nExpecting " + expected.join(", ") + ", got '" + (this.terminals_[symbol] || symbol) + "'";
	                        } else {
	                            errStr = "Parse error on line " + (yylineno + 1) + ": Unexpected " + (symbol == 1 ? "end of input" : "'" + (this.terminals_[symbol] || symbol) + "'");
	                        }
	                        this.parseError(errStr, { text: this.lexer.match, token: this.terminals_[symbol] || symbol, line: this.lexer.yylineno, loc: yyloc, expected: expected });
	                    }
	                }
	                if (action[0] instanceof Array && action.length > 1) {
	                    throw new Error("Parse Error: multiple actions possible at state: " + state + ", token: " + symbol);
	                }
	                switch (action[0]) {
	                    case 1:
	                        stack.push(symbol);
	                        vstack.push(this.lexer.yytext);
	                        lstack.push(this.lexer.yylloc);
	                        stack.push(action[1]);
	                        symbol = null;
	                        if (!preErrorSymbol) {
	                            yyleng = this.lexer.yyleng;
	                            yytext = this.lexer.yytext;
	                            yylineno = this.lexer.yylineno;
	                            yyloc = this.lexer.yylloc;
	                            if (recovering > 0) recovering--;
	                        } else {
	                            symbol = preErrorSymbol;
	                            preErrorSymbol = null;
	                        }
	                        break;
	                    case 2:
	                        len = this.productions_[action[1]][1];
	                        yyval.$ = vstack[vstack.length - len];
	                        yyval._$ = { first_line: lstack[lstack.length - (len || 1)].first_line, last_line: lstack[lstack.length - 1].last_line, first_column: lstack[lstack.length - (len || 1)].first_column, last_column: lstack[lstack.length - 1].last_column };
	                        if (ranges) {
	                            yyval._$.range = [lstack[lstack.length - (len || 1)].range[0], lstack[lstack.length - 1].range[1]];
	                        }
	                        r = this.performAction.call(yyval, yytext, yyleng, yylineno, this.yy, action[1], vstack, lstack);
	                        if (typeof r !== "undefined") {
	                            return r;
	                        }
	                        if (len) {
	                            stack = stack.slice(0, -1 * len * 2);
	                            vstack = vstack.slice(0, -1 * len);
	                            lstack = lstack.slice(0, -1 * len);
	                        }
	                        stack.push(this.productions_[action[1]][0]);
	                        vstack.push(yyval.$);
	                        lstack.push(yyval._$);
	                        newState = table[stack[stack.length - 2]][stack[stack.length - 1]];
	                        stack.push(newState);
	                        break;
	                    case 3:
	                        return true;
	                }
	            }
	            return true;
	        }
	    };
	    /* Jison generated lexer */
	    var lexer = (function () {
	        var lexer = { EOF: 1,
	            parseError: function parseError(str, hash) {
	                if (this.yy.parser) {
	                    this.yy.parser.parseError(str, hash);
	                } else {
	                    throw new Error(str);
	                }
	            },
	            setInput: function setInput(input) {
	                this._input = input;
	                this._more = this._less = this.done = false;
	                this.yylineno = this.yyleng = 0;
	                this.yytext = this.matched = this.match = '';
	                this.conditionStack = ['INITIAL'];
	                this.yylloc = { first_line: 1, first_column: 0, last_line: 1, last_column: 0 };
	                if (this.options.ranges) this.yylloc.range = [0, 0];
	                this.offset = 0;
	                return this;
	            },
	            input: function input() {
	                var ch = this._input[0];
	                this.yytext += ch;
	                this.yyleng++;
	                this.offset++;
	                this.match += ch;
	                this.matched += ch;
	                var lines = ch.match(/(?:\r\n?|\n).*/g);
	                if (lines) {
	                    this.yylineno++;
	                    this.yylloc.last_line++;
	                } else {
	                    this.yylloc.last_column++;
	                }
	                if (this.options.ranges) this.yylloc.range[1]++;

	                this._input = this._input.slice(1);
	                return ch;
	            },
	            unput: function unput(ch) {
	                var len = ch.length;
	                var lines = ch.split(/(?:\r\n?|\n)/g);

	                this._input = ch + this._input;
	                this.yytext = this.yytext.substr(0, this.yytext.length - len - 1);
	                //this.yyleng -= len;
	                this.offset -= len;
	                var oldLines = this.match.split(/(?:\r\n?|\n)/g);
	                this.match = this.match.substr(0, this.match.length - 1);
	                this.matched = this.matched.substr(0, this.matched.length - 1);

	                if (lines.length - 1) this.yylineno -= lines.length - 1;
	                var r = this.yylloc.range;

	                this.yylloc = { first_line: this.yylloc.first_line,
	                    last_line: this.yylineno + 1,
	                    first_column: this.yylloc.first_column,
	                    last_column: lines ? (lines.length === oldLines.length ? this.yylloc.first_column : 0) + oldLines[oldLines.length - lines.length].length - lines[0].length : this.yylloc.first_column - len
	                };

	                if (this.options.ranges) {
	                    this.yylloc.range = [r[0], r[0] + this.yyleng - len];
	                }
	                return this;
	            },
	            more: function more() {
	                this._more = true;
	                return this;
	            },
	            less: function less(n) {
	                this.unput(this.match.slice(n));
	            },
	            pastInput: function pastInput() {
	                var past = this.matched.substr(0, this.matched.length - this.match.length);
	                return (past.length > 20 ? '...' : '') + past.substr(-20).replace(/\n/g, "");
	            },
	            upcomingInput: function upcomingInput() {
	                var next = this.match;
	                if (next.length < 20) {
	                    next += this._input.substr(0, 20 - next.length);
	                }
	                return (next.substr(0, 20) + (next.length > 20 ? '...' : '')).replace(/\n/g, "");
	            },
	            showPosition: function showPosition() {
	                var pre = this.pastInput();
	                var c = new Array(pre.length + 1).join("-");
	                return pre + this.upcomingInput() + "\n" + c + "^";
	            },
	            next: function next() {
	                if (this.done) {
	                    return this.EOF;
	                }
	                if (!this._input) this.done = true;

	                var token, match, tempMatch, index, col, lines;
	                if (!this._more) {
	                    this.yytext = '';
	                    this.match = '';
	                }
	                var rules = this._currentRules();
	                for (var i = 0; i < rules.length; i++) {
	                    tempMatch = this._input.match(this.rules[rules[i]]);
	                    if (tempMatch && (!match || tempMatch[0].length > match[0].length)) {
	                        match = tempMatch;
	                        index = i;
	                        if (!this.options.flex) break;
	                    }
	                }
	                if (match) {
	                    lines = match[0].match(/(?:\r\n?|\n).*/g);
	                    if (lines) this.yylineno += lines.length;
	                    this.yylloc = { first_line: this.yylloc.last_line,
	                        last_line: this.yylineno + 1,
	                        first_column: this.yylloc.last_column,
	                        last_column: lines ? lines[lines.length - 1].length - lines[lines.length - 1].match(/\r?\n?/)[0].length : this.yylloc.last_column + match[0].length };
	                    this.yytext += match[0];
	                    this.match += match[0];
	                    this.matches = match;
	                    this.yyleng = this.yytext.length;
	                    if (this.options.ranges) {
	                        this.yylloc.range = [this.offset, this.offset += this.yyleng];
	                    }
	                    this._more = false;
	                    this._input = this._input.slice(match[0].length);
	                    this.matched += match[0];
	                    token = this.performAction.call(this, this.yy, this, rules[index], this.conditionStack[this.conditionStack.length - 1]);
	                    if (this.done && this._input) this.done = false;
	                    if (token) return token;else return;
	                }
	                if (this._input === "") {
	                    return this.EOF;
	                } else {
	                    return this.parseError('Lexical error on line ' + (this.yylineno + 1) + '. Unrecognized text.\n' + this.showPosition(), { text: "", token: null, line: this.yylineno });
	                }
	            },
	            lex: function lex() {
	                var r = this.next();
	                if (typeof r !== 'undefined') {
	                    return r;
	                } else {
	                    return this.lex();
	                }
	            },
	            begin: function begin(condition) {
	                this.conditionStack.push(condition);
	            },
	            popState: function popState() {
	                return this.conditionStack.pop();
	            },
	            _currentRules: function _currentRules() {
	                return this.conditions[this.conditionStack[this.conditionStack.length - 1]].rules;
	            },
	            topState: function topState() {
	                return this.conditionStack[this.conditionStack.length - 2];
	            },
	            pushState: function begin(condition) {
	                this.begin(condition);
	            } };
	        lexer.options = {};
	        lexer.performAction = function anonymous(yy, yy_, $avoiding_name_collisions, YY_START
	        /**/) {

	            function strip(start, end) {
	                return yy_.yytext = yy_.yytext.substr(start, yy_.yyleng - end);
	            }

	            var YYSTATE = YY_START;
	            switch ($avoiding_name_collisions) {
	                case 0:
	                    if (yy_.yytext.slice(-2) === "\\\\") {
	                        strip(0, 1);
	                        this.begin("mu");
	                    } else if (yy_.yytext.slice(-1) === "\\") {
	                        strip(0, 1);
	                        this.begin("emu");
	                    } else {
	                        this.begin("mu");
	                    }
	                    if (yy_.yytext) return 15;

	                    break;
	                case 1:
	                    return 15;
	                    break;
	                case 2:
	                    this.popState();
	                    return 15;

	                    break;
	                case 3:
	                    this.begin('raw');return 15;
	                    break;
	                case 4:
	                    this.popState();
	                    // Should be using `this.topState()` below, but it currently
	                    // returns the second top instead of the first top. Opened an
	                    // issue about it at https://github.com/zaach/jison/issues/291
	                    if (this.conditionStack[this.conditionStack.length - 1] === 'raw') {
	                        return 15;
	                    } else {
	                        yy_.yytext = yy_.yytext.substr(5, yy_.yyleng - 9);
	                        return 'END_RAW_BLOCK';
	                    }

	                    break;
	                case 5:
	                    return 15;
	                    break;
	                case 6:
	                    this.popState();
	                    return 14;

	                    break;
	                case 7:
	                    return 65;
	                    break;
	                case 8:
	                    return 68;
	                    break;
	                case 9:
	                    return 19;
	                    break;
	                case 10:
	                    this.popState();
	                    this.begin('raw');
	                    return 23;

	                    break;
	                case 11:
	                    return 55;
	                    break;
	                case 12:
	                    return 60;
	                    break;
	                case 13:
	                    return 29;
	                    break;
	                case 14:
	                    return 47;
	                    break;
	                case 15:
	                    this.popState();return 44;
	                    break;
	                case 16:
	                    this.popState();return 44;
	                    break;
	                case 17:
	                    return 34;
	                    break;
	                case 18:
	                    return 39;
	                    break;
	                case 19:
	                    return 51;
	                    break;
	                case 20:
	                    return 48;
	                    break;
	                case 21:
	                    this.unput(yy_.yytext);
	                    this.popState();
	                    this.begin('com');

	                    break;
	                case 22:
	                    this.popState();
	                    return 14;

	                    break;
	                case 23:
	                    return 48;
	                    break;
	                case 24:
	                    return 73;
	                    break;
	                case 25:
	                    return 72;
	                    break;
	                case 26:
	                    return 72;
	                    break;
	                case 27:
	                    return 87;
	                    break;
	                case 28:
	                    // ignore whitespace
	                    break;
	                case 29:
	                    this.popState();return 54;
	                    break;
	                case 30:
	                    this.popState();return 33;
	                    break;
	                case 31:
	                    yy_.yytext = strip(1, 2).replace(/\\"/g, '"');return 80;
	                    break;
	                case 32:
	                    yy_.yytext = strip(1, 2).replace(/\\'/g, "'");return 80;
	                    break;
	                case 33:
	                    return 85;
	                    break;
	                case 34:
	                    return 82;
	                    break;
	                case 35:
	                    return 82;
	                    break;
	                case 36:
	                    return 83;
	                    break;
	                case 37:
	                    return 84;
	                    break;
	                case 38:
	                    return 81;
	                    break;
	                case 39:
	                    return 75;
	                    break;
	                case 40:
	                    return 77;
	                    break;
	                case 41:
	                    return 72;
	                    break;
	                case 42:
	                    yy_.yytext = yy_.yytext.replace(/\\([\\\]])/g, '$1');return 72;
	                    break;
	                case 43:
	                    return 'INVALID';
	                    break;
	                case 44:
	                    return 5;
	                    break;
	            }
	        };
	        lexer.rules = [/^(?:[^\x00]*?(?=(\{\{)))/, /^(?:[^\x00]+)/, /^(?:[^\x00]{2,}?(?=(\{\{|\\\{\{|\\\\\{\{|$)))/, /^(?:\{\{\{\{(?=[^/]))/, /^(?:\{\{\{\{\/[^\s!"#%-,\.\/;->@\[-\^`\{-~]+(?=[=}\s\/.])\}\}\}\})/, /^(?:[^\x00]*?(?=(\{\{\{\{)))/, /^(?:[\s\S]*?--(~)?\}\})/, /^(?:\()/, /^(?:\))/, /^(?:\{\{\{\{)/, /^(?:\}\}\}\})/, /^(?:\{\{(~)?>)/, /^(?:\{\{(~)?#>)/, /^(?:\{\{(~)?#\*?)/, /^(?:\{\{(~)?\/)/, /^(?:\{\{(~)?\^\s*(~)?\}\})/, /^(?:\{\{(~)?\s*else\s*(~)?\}\})/, /^(?:\{\{(~)?\^)/, /^(?:\{\{(~)?\s*else\b)/, /^(?:\{\{(~)?\{)/, /^(?:\{\{(~)?&)/, /^(?:\{\{(~)?!--)/, /^(?:\{\{(~)?![\s\S]*?\}\})/, /^(?:\{\{(~)?\*?)/, /^(?:=)/, /^(?:\.\.)/, /^(?:\.(?=([=~}\s\/.)|])))/, /^(?:[\/.])/, /^(?:\s+)/, /^(?:\}(~)?\}\})/, /^(?:(~)?\}\})/, /^(?:"(\\["]|[^"])*")/, /^(?:'(\\[']|[^'])*')/, /^(?:@)/, /^(?:true(?=([~}\s)])))/, /^(?:false(?=([~}\s)])))/, /^(?:undefined(?=([~}\s)])))/, /^(?:null(?=([~}\s)])))/, /^(?:-?[0-9]+(?:\.[0-9]+)?(?=([~}\s)])))/, /^(?:as\s+\|)/, /^(?:\|)/, /^(?:([^\s!"#%-,\.\/;->@\[-\^`\{-~]+(?=([=~}\s\/.)|]))))/, /^(?:\[(\\\]|[^\]])*\])/, /^(?:.)/, /^(?:$)/];
	        lexer.conditions = { "mu": { "rules": [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44], "inclusive": false }, "emu": { "rules": [2], "inclusive": false }, "com": { "rules": [6], "inclusive": false }, "raw": { "rules": [3, 4, 5], "inclusive": false }, "INITIAL": { "rules": [0, 1, 44], "inclusive": true } };
	        return lexer;
	    })();
	    parser.lexer = lexer;
	    function Parser() {
	        this.yy = {};
	    }Parser.prototype = parser;parser.Parser = Parser;
	    return new Parser();
	})();exports.__esModule = true;
	exports['default'] = handlebars;

/***/ },
/* 24 */
/***/ function(module, exports, __webpack_require__) {

	'use strict';

	var _interopRequireDefault = __webpack_require__(1)['default'];

	exports.__esModule = true;

	var _visitor = __webpack_require__(25);

	var _visitor2 = _interopRequireDefault(_visitor);

	function WhitespaceControl() {
	  var options = arguments.length <= 0 || arguments[0] === undefined ? {} : arguments[0];

	  this.options = options;
	}
	WhitespaceControl.prototype = new _visitor2['default']();

	WhitespaceControl.prototype.Program = function (program) {
	  var doStandalone = !this.options.ignoreStandalone;

	  var isRoot = !this.isRootSeen;
	  this.isRootSeen = true;

	  var body = program.body;
	  for (var i = 0, l = body.length; i < l; i++) {
	    var current = body[i],
	        strip = this.accept(current);

	    if (!strip) {
	      continue;
	    }

	    var _isPrevWhitespace = isPrevWhitespace(body, i, isRoot),
	        _isNextWhitespace = isNextWhitespace(body, i, isRoot),
	        openStandalone = strip.openStandalone && _isPrevWhitespace,
	        closeStandalone = strip.closeStandalone && _isNextWhitespace,
	        inlineStandalone = strip.inlineStandalone && _isPrevWhitespace && _isNextWhitespace;

	    if (strip.close) {
	      omitRight(body, i, true);
	    }
	    if (strip.open) {
	      omitLeft(body, i, true);
	    }

	    if (doStandalone && inlineStandalone) {
	      omitRight(body, i);

	      if (omitLeft(body, i)) {
	        // If we are on a standalone node, save the indent info for partials
	        if (current.type === 'PartialStatement') {
	          // Pull out the whitespace from the final line
	          current.indent = /([ \t]+$)/.exec(body[i - 1].original)[1];
	        }
	      }
	    }
	    if (doStandalone && openStandalone) {
	      omitRight((current.program || current.inverse).body);

	      // Strip out the previous content node if it's whitespace only
	      omitLeft(body, i);
	    }
	    if (doStandalone && closeStandalone) {
	      // Always strip the next node
	      omitRight(body, i);

	      omitLeft((current.inverse || current.program).body);
	    }
	  }

	  return program;
	};

	WhitespaceControl.prototype.BlockStatement = WhitespaceControl.prototype.DecoratorBlock = WhitespaceControl.prototype.PartialBlockStatement = function (block) {
	  this.accept(block.program);
	  this.accept(block.inverse);

	  // Find the inverse program that is involed with whitespace stripping.
	  var program = block.program || block.inverse,
	      inverse = block.program && block.inverse,
	      firstInverse = inverse,
	      lastInverse = inverse;

	  if (inverse && inverse.chained) {
	    firstInverse = inverse.body[0].program;

	    // Walk the inverse chain to find the last inverse that is actually in the chain.
	    while (lastInverse.chained) {
	      lastInverse = lastInverse.body[lastInverse.body.length - 1].program;
	    }
	  }

	  var strip = {
	    open: block.openStrip.open,
	    close: block.closeStrip.close,

	    // Determine the standalone candiacy. Basically flag our content as being possibly standalone
	    // so our parent can determine if we actually are standalone
	    openStandalone: isNextWhitespace(program.body),
	    closeStandalone: isPrevWhitespace((firstInverse || program).body)
	  };

	  if (block.openStrip.close) {
	    omitRight(program.body, null, true);
	  }

	  if (inverse) {
	    var inverseStrip = block.inverseStrip;

	    if (inverseStrip.open) {
	      omitLeft(program.body, null, true);
	    }

	    if (inverseStrip.close) {
	      omitRight(firstInverse.body, null, true);
	    }
	    if (block.closeStrip.open) {
	      omitLeft(lastInverse.body, null, true);
	    }

	    // Find standalone else statments
	    if (!this.options.ignoreStandalone && isPrevWhitespace(program.body) && isNextWhitespace(firstInverse.body)) {
	      omitLeft(program.body);
	      omitRight(firstInverse.body);
	    }
	  } else if (block.closeStrip.open) {
	    omitLeft(program.body, null, true);
	  }

	  return strip;
	};

	WhitespaceControl.prototype.Decorator = WhitespaceControl.prototype.MustacheStatement = function (mustache) {
	  return mustache.strip;
	};

	WhitespaceControl.prototype.PartialStatement = WhitespaceControl.prototype.CommentStatement = function (node) {
	  /* istanbul ignore next */
	  var strip = node.strip || {};
	  return {
	    inlineStandalone: true,
	    open: strip.open,
	    close: strip.close
	  };
	};

	function isPrevWhitespace(body, i, isRoot) {
	  if (i === undefined) {
	    i = body.length;
	  }

	  // Nodes that end with newlines are considered whitespace (but are special
	  // cased for strip operations)
	  var prev = body[i - 1],
	      sibling = body[i - 2];
	  if (!prev) {
	    return isRoot;
	  }

	  if (prev.type === 'ContentStatement') {
	    return (sibling || !isRoot ? /\r?\n\s*?$/ : /(^|\r?\n)\s*?$/).test(prev.original);
	  }
	}
	function isNextWhitespace(body, i, isRoot) {
	  if (i === undefined) {
	    i = -1;
	  }

	  var next = body[i + 1],
	      sibling = body[i + 2];
	  if (!next) {
	    return isRoot;
	  }

	  if (next.type === 'ContentStatement') {
	    return (sibling || !isRoot ? /^\s*?\r?\n/ : /^\s*?(\r?\n|$)/).test(next.original);
	  }
	}

	// Marks the node to the right of the position as omitted.
	// I.e. {{foo}}' ' will mark the ' ' node as omitted.
	//
	// If i is undefined, then the first child will be marked as such.
	//
	// If mulitple is truthy then all whitespace will be stripped out until non-whitespace
	// content is met.
	function omitRight(body, i, multiple) {
	  var current = body[i == null ? 0 : i + 1];
	  if (!current || current.type !== 'ContentStatement' || !multiple && current.rightStripped) {
	    return;
	  }

	  var original = current.value;
	  current.value = current.value.replace(multiple ? /^\s+/ : /^[ \t]*\r?\n?/, '');
	  current.rightStripped = current.value !== original;
	}

	// Marks the node to the left of the position as omitted.
	// I.e. ' '{{foo}} will mark the ' ' node as omitted.
	//
	// If i is undefined then the last child will be marked as such.
	//
	// If mulitple is truthy then all whitespace will be stripped out until non-whitespace
	// content is met.
	function omitLeft(body, i, multiple) {
	  var current = body[i == null ? body.length - 1 : i - 1];
	  if (!current || current.type !== 'ContentStatement' || !multiple && current.leftStripped) {
	    return;
	  }

	  // We omit the last node if it's whitespace only and not preceeded by a non-content node.
	  var original = current.value;
	  current.value = current.value.replace(multiple ? /\s+$/ : /[ \t]+$/, '');
	  current.leftStripped = current.value !== original;
	  return current.leftStripped;
	}

	exports['default'] = WhitespaceControl;
	module.exports = exports['default'];

/***/ },
/* 25 */
/***/ function(module, exports, __webpack_require__) {

	'use strict';

	var _interopRequireDefault = __webpack_require__(1)['default'];

	exports.__esModule = true;

	var _exception = __webpack_require__(6);

	var _exception2 = _interopRequireDefault(_exception);

	function Visitor() {
	  this.parents = [];
	}

	Visitor.prototype = {
	  constructor: Visitor,
	  mutating: false,

	  // Visits a given value. If mutating, will replace the value if necessary.
	  acceptKey: function acceptKey(node, name) {
	    var value = this.accept(node[name]);
	    if (this.mutating) {
	      // Hacky sanity check: This may have a few false positives for type for the helper
	      // methods but will generally do the right thing without a lot of overhead.
	      if (value && !Visitor.prototype[value.type]) {
	        throw new _exception2['default']('Unexpected node type "' + value.type + '" found when accepting ' + name + ' on ' + node.type);
	      }
	      node[name] = value;
	    }
	  },

	  // Performs an accept operation with added sanity check to ensure
	  // required keys are not removed.
	  acceptRequired: function acceptRequired(node, name) {
	    this.acceptKey(node, name);

	    if (!node[name]) {
	      throw new _exception2['default'](node.type + ' requires ' + name);
	    }
	  },

	  // Traverses a given array. If mutating, empty respnses will be removed
	  // for child elements.
	  acceptArray: function acceptArray(array) {
	    for (var i = 0, l = array.length; i < l; i++) {
	      this.acceptKey(array, i);

	      if (!array[i]) {
	        array.splice(i, 1);
	        i--;
	        l--;
	      }
	    }
	  },

	  accept: function accept(object) {
	    if (!object) {
	      return;
	    }

	    /* istanbul ignore next: Sanity code */
	    if (!this[object.type]) {
	      throw new _exception2['default']('Unknown type: ' + object.type, object);
	    }

	    if (this.current) {
	      this.parents.unshift(this.current);
	    }
	    this.current = object;

	    var ret = this[object.type](object);

	    this.current = this.parents.shift();

	    if (!this.mutating || ret) {
	      return ret;
	    } else if (ret !== false) {
	      return object;
	    }
	  },

	  Program: function Program(program) {
	    this.acceptArray(program.body);
	  },

	  MustacheStatement: visitSubExpression,
	  Decorator: visitSubExpression,

	  BlockStatement: visitBlock,
	  DecoratorBlock: visitBlock,

	  PartialStatement: visitPartial,
	  PartialBlockStatement: function PartialBlockStatement(partial) {
	    visitPartial.call(this, partial);

	    this.acceptKey(partial, 'program');
	  },

	  ContentStatement: function ContentStatement() /* content */{},
	  CommentStatement: function CommentStatement() /* comment */{},

	  SubExpression: visitSubExpression,

	  PathExpression: function PathExpression() /* path */{},

	  StringLiteral: function StringLiteral() /* string */{},
	  NumberLiteral: function NumberLiteral() /* number */{},
	  BooleanLiteral: function BooleanLiteral() /* bool */{},
	  UndefinedLiteral: function UndefinedLiteral() /* literal */{},
	  NullLiteral: function NullLiteral() /* literal */{},

	  Hash: function Hash(hash) {
	    this.acceptArray(hash.pairs);
	  },
	  HashPair: function HashPair(pair) {
	    this.acceptRequired(pair, 'value');
	  }
	};

	function visitSubExpression(mustache) {
	  this.acceptRequired(mustache, 'path');
	  this.acceptArray(mustache.params);
	  this.acceptKey(mustache, 'hash');
	}
	function visitBlock(block) {
	  visitSubExpression.call(this, block);

	  this.acceptKey(block, 'program');
	  this.acceptKey(block, 'inverse');
	}
	function visitPartial(partial) {
	  this.acceptRequired(partial, 'name');
	  this.acceptArray(partial.params);
	  this.acceptKey(partial, 'hash');
	}

	exports['default'] = Visitor;
	module.exports = exports['default'];

/***/ },
/* 26 */
/***/ function(module, exports, __webpack_require__) {

	'use strict';

	var _interopRequireDefault = __webpack_require__(1)['default'];

	exports.__esModule = true;
	exports.SourceLocation = SourceLocation;
	exports.id = id;
	exports.stripFlags = stripFlags;
	exports.stripComment = stripComment;
	exports.preparePath = preparePath;
	exports.prepareMustache = prepareMustache;
	exports.prepareRawBlock = prepareRawBlock;
	exports.prepareBlock = prepareBlock;
	exports.prepareProgram = prepareProgram;
	exports.preparePartialBlock = preparePartialBlock;

	var _exception = __webpack_require__(6);

	var _exception2 = _interopRequireDefault(_exception);

	function validateClose(open, close) {
	  close = close.path ? close.path.original : close;

	  if (open.path.original !== close) {
	    var errorNode = { loc: open.path.loc };

	    throw new _exception2['default'](open.path.original + " doesn't match " + close, errorNode);
	  }
	}

	function SourceLocation(source, locInfo) {
	  this.source = source;
	  this.start = {
	    line: locInfo.first_line,
	    column: locInfo.first_column
	  };
	  this.end = {
	    line: locInfo.last_line,
	    column: locInfo.last_column
	  };
	}

	function id(token) {
	  if (/^\[.*\]$/.test(token)) {
	    return token.substr(1, token.length - 2);
	  } else {
	    return token;
	  }
	}

	function stripFlags(open, close) {
	  return {
	    open: open.charAt(2) === '~',
	    close: close.charAt(close.length - 3) === '~'
	  };
	}

	function stripComment(comment) {
	  return comment.replace(/^\{\{~?\!-?-?/, '').replace(/-?-?~?\}\}$/, '');
	}

	function preparePath(data, parts, loc) {
	  loc = this.locInfo(loc);

	  var original = data ? '@' : '',
	      dig = [],
	      depth = 0,
	      depthString = '';

	  for (var i = 0, l = parts.length; i < l; i++) {
	    var part = parts[i].part,

	    // If we have [] syntax then we do not treat path references as operators,
	    // i.e. foo.[this] resolves to approximately context.foo['this']
	    isLiteral = parts[i].original !== part;
	    original += (parts[i].separator || '') + part;

	    if (!isLiteral && (part === '..' || part === '.' || part === 'this')) {
	      if (dig.length > 0) {
	        throw new _exception2['default']('Invalid path: ' + original, { loc: loc });
	      } else if (part === '..') {
	        depth++;
	        depthString += '../';
	      }
	    } else {
	      dig.push(part);
	    }
	  }

	  return {
	    type: 'PathExpression',
	    data: data,
	    depth: depth,
	    parts: dig,
	    original: original,
	    loc: loc
	  };
	}

	function prepareMustache(path, params, hash, open, strip, locInfo) {
	  // Must use charAt to support IE pre-10
	  var escapeFlag = open.charAt(3) || open.charAt(2),
	      escaped = escapeFlag !== '{' && escapeFlag !== '&';

	  var decorator = /\*/.test(open);
	  return {
	    type: decorator ? 'Decorator' : 'MustacheStatement',
	    path: path,
	    params: params,
	    hash: hash,
	    escaped: escaped,
	    strip: strip,
	    loc: this.locInfo(locInfo)
	  };
	}

	function prepareRawBlock(openRawBlock, contents, close, locInfo) {
	  validateClose(openRawBlock, close);

	  locInfo = this.locInfo(locInfo);
	  var program = {
	    type: 'Program',
	    body: contents,
	    strip: {},
	    loc: locInfo
	  };

	  return {
	    type: 'BlockStatement',
	    path: openRawBlock.path,
	    params: openRawBlock.params,
	    hash: openRawBlock.hash,
	    program: program,
	    openStrip: {},
	    inverseStrip: {},
	    closeStrip: {},
	    loc: locInfo
	  };
	}

	function prepareBlock(openBlock, program, inverseAndProgram, close, inverted, locInfo) {
	  if (close && close.path) {
	    validateClose(openBlock, close);
	  }

	  var decorator = /\*/.test(openBlock.open);

	  program.blockParams = openBlock.blockParams;

	  var inverse = undefined,
	      inverseStrip = undefined;

	  if (inverseAndProgram) {
	    if (decorator) {
	      throw new _exception2['default']('Unexpected inverse block on decorator', inverseAndProgram);
	    }

	    if (inverseAndProgram.chain) {
	      inverseAndProgram.program.body[0].closeStrip = close.strip;
	    }

	    inverseStrip = inverseAndProgram.strip;
	    inverse = inverseAndProgram.program;
	  }

	  if (inverted) {
	    inverted = inverse;
	    inverse = program;
	    program = inverted;
	  }

	  return {
	    type: decorator ? 'DecoratorBlock' : 'BlockStatement',
	    path: openBlock.path,
	    params: openBlock.params,
	    hash: openBlock.hash,
	    program: program,
	    inverse: inverse,
	    openStrip: openBlock.strip,
	    inverseStrip: inverseStrip,
	    closeStrip: close && close.strip,
	    loc: this.locInfo(locInfo)
	  };
	}

	function prepareProgram(statements, loc) {
	  if (!loc && statements.length) {
	    var firstLoc = statements[0].loc,
	        lastLoc = statements[statements.length - 1].loc;

	    /* istanbul ignore else */
	    if (firstLoc && lastLoc) {
	      loc = {
	        source: firstLoc.source,
	        start: {
	          line: firstLoc.start.line,
	          column: firstLoc.start.column
	        },
	        end: {
	          line: lastLoc.end.line,
	          column: lastLoc.end.column
	        }
	      };
	    }
	  }

	  return {
	    type: 'Program',
	    body: statements,
	    strip: {},
	    loc: loc
	  };
	}

	function preparePartialBlock(open, program, close, locInfo) {
	  validateClose(open, close);

	  return {
	    type: 'PartialBlockStatement',
	    name: open.path,
	    params: open.params,
	    hash: open.hash,
	    program: program,
	    openStrip: open.strip,
	    closeStrip: close && close.strip,
	    loc: this.locInfo(locInfo)
	  };
	}

/***/ },
/* 27 */
/***/ function(module, exports, __webpack_require__) {

	/* eslint-disable new-cap */

	'use strict';

	var _interopRequireDefault = __webpack_require__(1)['default'];

	exports.__esModule = true;
	exports.Compiler = Compiler;
	exports.precompile = precompile;
	exports.compile = compile;

	var _exception = __webpack_require__(6);

	var _exception2 = _interopRequireDefault(_exception);

	var _utils = __webpack_require__(5);

	var _ast = __webpack_require__(21);

	var _ast2 = _interopRequireDefault(_ast);

	var slice = [].slice;

	function Compiler() {}

	// the foundHelper register will disambiguate helper lookup from finding a
	// function in a context. This is necessary for mustache compatibility, which
	// requires that context functions in blocks are evaluated by blockHelperMissing,
	// and then proceed as if the resulting value was provided to blockHelperMissing.

	Compiler.prototype = {
	  compiler: Compiler,

	  equals: function equals(other) {
	    var len = this.opcodes.length;
	    if (other.opcodes.length !== len) {
	      return false;
	    }

	    for (var i = 0; i < len; i++) {
	      var opcode = this.opcodes[i],
	          otherOpcode = other.opcodes[i];
	      if (opcode.opcode !== otherOpcode.opcode || !argEquals(opcode.args, otherOpcode.args)) {
	        return false;
	      }
	    }

	    // We know that length is the same between the two arrays because they are directly tied
	    // to the opcode behavior above.
	    len = this.children.length;
	    for (var i = 0; i < len; i++) {
	      if (!this.children[i].equals(other.children[i])) {
	        return false;
	      }
	    }

	    return true;
	  },

	  guid: 0,

	  compile: function compile(program, options) {
	    this.sourceNode = [];
	    this.opcodes = [];
	    this.children = [];
	    this.options = options;
	    this.stringParams = options.stringParams;
	    this.trackIds = options.trackIds;

	    options.blockParams = options.blockParams || [];

	    // These changes will propagate to the other compiler components
	    var knownHelpers = options.knownHelpers;
	    options.knownHelpers = {
	      'helperMissing': true,
	      'blockHelperMissing': true,
	      'each': true,
	      'if': true,
	      'unless': true,
	      'with': true,
	      'log': true,
	      'lookup': true
	    };
	    if (knownHelpers) {
	      for (var _name in knownHelpers) {
	        /* istanbul ignore else */
	        if (_name in knownHelpers) {
	          options.knownHelpers[_name] = knownHelpers[_name];
	        }
	      }
	    }

	    return this.accept(program);
	  },

	  compileProgram: function compileProgram(program) {
	    var childCompiler = new this.compiler(),
	        // eslint-disable-line new-cap
	    result = childCompiler.compile(program, this.options),
	        guid = this.guid++;

	    this.usePartial = this.usePartial || result.usePartial;

	    this.children[guid] = result;
	    this.useDepths = this.useDepths || result.useDepths;

	    return guid;
	  },

	  accept: function accept(node) {
	    /* istanbul ignore next: Sanity code */
	    if (!this[node.type]) {
	      throw new _exception2['default']('Unknown type: ' + node.type, node);
	    }

	    this.sourceNode.unshift(node);
	    var ret = this[node.type](node);
	    this.sourceNode.shift();
	    return ret;
	  },

	  Program: function Program(program) {
	    this.options.blockParams.unshift(program.blockParams);

	    var body = program.body,
	        bodyLength = body.length;
	    for (var i = 0; i < bodyLength; i++) {
	      this.accept(body[i]);
	    }

	    this.options.blockParams.shift();

	    this.isSimple = bodyLength === 1;
	    this.blockParams = program.blockParams ? program.blockParams.length : 0;

	    return this;
	  },

	  BlockStatement: function BlockStatement(block) {
	    transformLiteralToPath(block);

	    var program = block.program,
	        inverse = block.inverse;

	    program = program && this.compileProgram(program);
	    inverse = inverse && this.compileProgram(inverse);

	    var type = this.classifySexpr(block);

	    if (type === 'helper') {
	      this.helperSexpr(block, program, inverse);
	    } else if (type === 'simple') {
	      this.simpleSexpr(block);

	      // now that the simple mustache is resolved, we need to
	      // evaluate it by executing `blockHelperMissing`
	      this.opcode('pushProgram', program);
	      this.opcode('pushProgram', inverse);
	      this.opcode('emptyHash');
	      this.opcode('blockValue', block.path.original);
	    } else {
	      this.ambiguousSexpr(block, program, inverse);

	      // now that the simple mustache is resolved, we need to
	      // evaluate it by executing `blockHelperMissing`
	      this.opcode('pushProgram', program);
	      this.opcode('pushProgram', inverse);
	      this.opcode('emptyHash');
	      this.opcode('ambiguousBlockValue');
	    }

	    this.opcode('append');
	  },

	  DecoratorBlock: function DecoratorBlock(decorator) {
	    var program = decorator.program && this.compileProgram(decorator.program);
	    var params = this.setupFullMustacheParams(decorator, program, undefined),
	        path = decorator.path;

	    this.useDecorators = true;
	    this.opcode('registerDecorator', params.length, path.original);
	  },

	  PartialStatement: function PartialStatement(partial) {
	    this.usePartial = true;

	    var program = partial.program;
	    if (program) {
	      program = this.compileProgram(partial.program);
	    }

	    var params = partial.params;
	    if (params.length > 1) {
	      throw new _exception2['default']('Unsupported number of partial arguments: ' + params.length, partial);
	    } else if (!params.length) {
	      if (this.options.explicitPartialContext) {
	        this.opcode('pushLiteral', 'undefined');
	      } else {
	        params.push({ type: 'PathExpression', parts: [], depth: 0 });
	      }
	    }

	    var partialName = partial.name.original,
	        isDynamic = partial.name.type === 'SubExpression';
	    if (isDynamic) {
	      this.accept(partial.name);
	    }

	    this.setupFullMustacheParams(partial, program, undefined, true);

	    var indent = partial.indent || '';
	    if (this.options.preventIndent && indent) {
	      this.opcode('appendContent', indent);
	      indent = '';
	    }

	    this.opcode('invokePartial', isDynamic, partialName, indent);
	    this.opcode('append');
	  },
	  PartialBlockStatement: function PartialBlockStatement(partialBlock) {
	    this.PartialStatement(partialBlock);
	  },

	  MustacheStatement: function MustacheStatement(mustache) {
	    this.SubExpression(mustache);

	    if (mustache.escaped && !this.options.noEscape) {
	      this.opcode('appendEscaped');
	    } else {
	      this.opcode('append');
	    }
	  },
	  Decorator: function Decorator(decorator) {
	    this.DecoratorBlock(decorator);
	  },

	  ContentStatement: function ContentStatement(content) {
	    if (content.value) {
	      this.opcode('appendContent', content.value);
	    }
	  },

	  CommentStatement: function CommentStatement() {},

	  SubExpression: function SubExpression(sexpr) {
	    transformLiteralToPath(sexpr);
	    var type = this.classifySexpr(sexpr);

	    if (type === 'simple') {
	      this.simpleSexpr(sexpr);
	    } else if (type === 'helper') {
	      this.helperSexpr(sexpr);
	    } else {
	      this.ambiguousSexpr(sexpr);
	    }
	  },
	  ambiguousSexpr: function ambiguousSexpr(sexpr, program, inverse) {
	    var path = sexpr.path,
	        name = path.parts[0],
	        isBlock = program != null || inverse != null;

	    this.opcode('getContext', path.depth);

	    this.opcode('pushProgram', program);
	    this.opcode('pushProgram', inverse);

	    path.strict = true;
	    this.accept(path);

	    this.opcode('invokeAmbiguous', name, isBlock);
	  },

	  simpleSexpr: function simpleSexpr(sexpr) {
	    var path = sexpr.path;
	    path.strict = true;
	    this.accept(path);
	    this.opcode('resolvePossibleLambda');
	  },

	  helperSexpr: function helperSexpr(sexpr, program, inverse) {
	    var params = this.setupFullMustacheParams(sexpr, program, inverse),
	        path = sexpr.path,
	        name = path.parts[0];

	    if (this.options.knownHelpers[name]) {
	      this.opcode('invokeKnownHelper', params.length, name);
	    } else if (this.options.knownHelpersOnly) {
	      throw new _exception2['default']('You specified knownHelpersOnly, but used the unknown helper ' + name, sexpr);
	    } else {
	      path.strict = true;
	      path.falsy = true;

	      this.accept(path);
	      this.opcode('invokeHelper', params.length, path.original, _ast2['default'].helpers.simpleId(path));
	    }
	  },

	  PathExpression: function PathExpression(path) {
	    this.addDepth(path.depth);
	    this.opcode('getContext', path.depth);

	    var name = path.parts[0],
	        scoped = _ast2['default'].helpers.scopedId(path),
	        blockParamId = !path.depth && !scoped && this.blockParamIndex(name);

	    if (blockParamId) {
	      this.opcode('lookupBlockParam', blockParamId, path.parts);
	    } else if (!name) {
	      // Context reference, i.e. `{{foo .}}` or `{{foo ..}}`
	      this.opcode('pushContext');
	    } else if (path.data) {
	      this.options.data = true;
	      this.opcode('lookupData', path.depth, path.parts, path.strict);
	    } else {
	      this.opcode('lookupOnContext', path.parts, path.falsy, path.strict, scoped);
	    }
	  },

	  StringLiteral: function StringLiteral(string) {
	    this.opcode('pushString', string.value);
	  },

	  NumberLiteral: function NumberLiteral(number) {
	    this.opcode('pushLiteral', number.value);
	  },

	  BooleanLiteral: function BooleanLiteral(bool) {
	    this.opcode('pushLiteral', bool.value);
	  },

	  UndefinedLiteral: function UndefinedLiteral() {
	    this.opcode('pushLiteral', 'undefined');
	  },

	  NullLiteral: function NullLiteral() {
	    this.opcode('pushLiteral', 'null');
	  },

	  Hash: function Hash(hash) {
	    var pairs = hash.pairs,
	        i = 0,
	        l = pairs.length;

	    this.opcode('pushHash');

	    for (; i < l; i++) {
	      this.pushParam(pairs[i].value);
	    }
	    while (i--) {
	      this.opcode('assignToHash', pairs[i].key);
	    }
	    this.opcode('popHash');
	  },

	  // HELPERS
	  opcode: function opcode(name) {
	    this.opcodes.push({ opcode: name, args: slice.call(arguments, 1), loc: this.sourceNode[0].loc });
	  },

	  addDepth: function addDepth(depth) {
	    if (!depth) {
	      return;
	    }

	    this.useDepths = true;
	  },

	  classifySexpr: function classifySexpr(sexpr) {
	    var isSimple = _ast2['default'].helpers.simpleId(sexpr.path);

	    var isBlockParam = isSimple && !!this.blockParamIndex(sexpr.path.parts[0]);

	    // a mustache is an eligible helper if:
	    // * its id is simple (a single part, not `this` or `..`)
	    var isHelper = !isBlockParam && _ast2['default'].helpers.helperExpression(sexpr);

	    // if a mustache is an eligible helper but not a definite
	    // helper, it is ambiguous, and will be resolved in a later
	    // pass or at runtime.
	    var isEligible = !isBlockParam && (isHelper || isSimple);

	    // if ambiguous, we can possibly resolve the ambiguity now
	    // An eligible helper is one that does not have a complex path, i.e. `this.foo`, `../foo` etc.
	    if (isEligible && !isHelper) {
	      var _name2 = sexpr.path.parts[0],
	          options = this.options;

	      if (options.knownHelpers[_name2]) {
	        isHelper = true;
	      } else if (options.knownHelpersOnly) {
	        isEligible = false;
	      }
	    }

	    if (isHelper) {
	      return 'helper';
	    } else if (isEligible) {
	      return 'ambiguous';
	    } else {
	      return 'simple';
	    }
	  },

	  pushParams: function pushParams(params) {
	    for (var i = 0, l = params.length; i < l; i++) {
	      this.pushParam(params[i]);
	    }
	  },

	  pushParam: function pushParam(val) {
	    var value = val.value != null ? val.value : val.original || '';

	    if (this.stringParams) {
	      if (value.replace) {
	        value = value.replace(/^(\.?\.\/)*/g, '').replace(/\//g, '.');
	      }

	      if (val.depth) {
	        this.addDepth(val.depth);
	      }
	      this.opcode('getContext', val.depth || 0);
	      this.opcode('pushStringParam', value, val.type);

	      if (val.type === 'SubExpression') {
	        // SubExpressions get evaluated and passed in
	        // in string params mode.
	        this.accept(val);
	      }
	    } else {
	      if (this.trackIds) {
	        var blockParamIndex = undefined;
	        if (val.parts && !_ast2['default'].helpers.scopedId(val) && !val.depth) {
	          blockParamIndex = this.blockParamIndex(val.parts[0]);
	        }
	        if (blockParamIndex) {
	          var blockParamChild = val.parts.slice(1).join('.');
	          this.opcode('pushId', 'BlockParam', blockParamIndex, blockParamChild);
	        } else {
	          value = val.original || value;
	          if (value.replace) {
	            value = value.replace(/^this(?:\.|$)/, '').replace(/^\.\//, '').replace(/^\.$/, '');
	          }

	          this.opcode('pushId', val.type, value);
	        }
	      }
	      this.accept(val);
	    }
	  },

	  setupFullMustacheParams: function setupFullMustacheParams(sexpr, program, inverse, omitEmpty) {
	    var params = sexpr.params;
	    this.pushParams(params);

	    this.opcode('pushProgram', program);
	    this.opcode('pushProgram', inverse);

	    if (sexpr.hash) {
	      this.accept(sexpr.hash);
	    } else {
	      this.opcode('emptyHash', omitEmpty);
	    }

	    return params;
	  },

	  blockParamIndex: function blockParamIndex(name) {
	    for (var depth = 0, len = this.options.blockParams.length; depth < len; depth++) {
	      var blockParams = this.options.blockParams[depth],
	          param = blockParams && _utils.indexOf(blockParams, name);
	      if (blockParams && param >= 0) {
	        return [depth, param];
	      }
	    }
	  }
	};

	function precompile(input, options, env) {
	  if (input == null || typeof input !== 'string' && input.type !== 'Program') {
	    throw new _exception2['default']('You must pass a string or Handlebars AST to Handlebars.precompile. You passed ' + input);
	  }

	  options = options || {};
	  if (!('data' in options)) {
	    options.data = true;
	  }
	  if (options.compat) {
	    options.useDepths = true;
	  }

	  var ast = env.parse(input, options),
	      environment = new env.Compiler().compile(ast, options);
	  return new env.JavaScriptCompiler().compile(environment, options);
	}

	function compile(input, options, env) {
	  if (options === undefined) options = {};

	  if (input == null || typeof input !== 'string' && input.type !== 'Program') {
	    throw new _exception2['default']('You must pass a string or Handlebars AST to Handlebars.compile. You passed ' + input);
	  }

	  if (!('data' in options)) {
	    options.data = true;
	  }
	  if (options.compat) {
	    options.useDepths = true;
	  }

	  var compiled = undefined;

	  function compileInput() {
	    var ast = env.parse(input, options),
	        environment = new env.Compiler().compile(ast, options),
	        templateSpec = new env.JavaScriptCompiler().compile(environment, options, undefined, true);
	    return env.template(templateSpec);
	  }

	  // Template is only compiled on first use and cached after that point.
	  function ret(context, execOptions) {
	    if (!compiled) {
	      compiled = compileInput();
	    }
	    return compiled.call(this, context, execOptions);
	  }
	  ret._setup = function (setupOptions) {
	    if (!compiled) {
	      compiled = compileInput();
	    }
	    return compiled._setup(setupOptions);
	  };
	  ret._child = function (i, data, blockParams, depths) {
	    if (!compiled) {
	      compiled = compileInput();
	    }
	    return compiled._child(i, data, blockParams, depths);
	  };
	  return ret;
	}

	function argEquals(a, b) {
	  if (a === b) {
	    return true;
	  }

	  if (_utils.isArray(a) && _utils.isArray(b) && a.length === b.length) {
	    for (var i = 0; i < a.length; i++) {
	      if (!argEquals(a[i], b[i])) {
	        return false;
	      }
	    }
	    return true;
	  }
	}

	function transformLiteralToPath(sexpr) {
	  if (!sexpr.path.parts) {
	    var literal = sexpr.path;
	    // Casting to string here to make false and 0 literal values play nicely with the rest
	    // of the system.
	    sexpr.path = {
	      type: 'PathExpression',
	      data: false,
	      depth: 0,
	      parts: [literal.original + ''],
	      original: literal.original + '',
	      loc: literal.loc
	    };
	  }
	}

/***/ },
/* 28 */
/***/ function(module, exports, __webpack_require__) {

	'use strict';

	var _interopRequireDefault = __webpack_require__(1)['default'];

	exports.__esModule = true;

	var _base = __webpack_require__(4);

	var _exception = __webpack_require__(6);

	var _exception2 = _interopRequireDefault(_exception);

	var _utils = __webpack_require__(5);

	var _codeGen = __webpack_require__(29);

	var _codeGen2 = _interopRequireDefault(_codeGen);

	function Literal(value) {
	  this.value = value;
	}

	function JavaScriptCompiler() {}

	JavaScriptCompiler.prototype = {
	  // PUBLIC API: You can override these methods in a subclass to provide
	  // alternative compiled forms for name lookup and buffering semantics
	  nameLookup: function nameLookup(parent, name /* , type*/) {
	    if (JavaScriptCompiler.isValidJavaScriptVariableName(name)) {
	      return [parent, '.', name];
	    } else {
	      return [parent, '[', JSON.stringify(name), ']'];
	    }
	  },
	  depthedLookup: function depthedLookup(name) {
	    return [this.aliasable('container.lookup'), '(depths, "', name, '")'];
	  },

	  compilerInfo: function compilerInfo() {
	    var revision = _base.COMPILER_REVISION,
	        versions = _base.REVISION_CHANGES[revision];
	    return [revision, versions];
	  },

	  appendToBuffer: function appendToBuffer(source, location, explicit) {
	    // Force a source as this simplifies the merge logic.
	    if (!_utils.isArray(source)) {
	      source = [source];
	    }
	    source = this.source.wrap(source, location);

	    if (this.environment.isSimple) {
	      return ['return ', source, ';'];
	    } else if (explicit) {
	      // This is a case where the buffer operation occurs as a child of another
	      // construct, generally braces. We have to explicitly output these buffer
	      // operations to ensure that the emitted code goes in the correct location.
	      return ['buffer += ', source, ';'];
	    } else {
	      source.appendToBuffer = true;
	      return source;
	    }
	  },

	  initializeBuffer: function initializeBuffer() {
	    return this.quotedString('');
	  },
	  // END PUBLIC API

	  compile: function compile(environment, options, context, asObject) {
	    this.environment = environment;
	    this.options = options;
	    this.stringParams = this.options.stringParams;
	    this.trackIds = this.options.trackIds;
	    this.precompile = !asObject;

	    this.name = this.environment.name;
	    this.isChild = !!context;
	    this.context = context || {
	      decorators: [],
	      programs: [],
	      environments: []
	    };

	    this.preamble();

	    this.stackSlot = 0;
	    this.stackVars = [];
	    this.aliases = {};
	    this.registers = { list: [] };
	    this.hashes = [];
	    this.compileStack = [];
	    this.inlineStack = [];
	    this.blockParams = [];

	    this.compileChildren(environment, options);

	    this.useDepths = this.useDepths || environment.useDepths || environment.useDecorators || this.options.compat;
	    this.useBlockParams = this.useBlockParams || environment.useBlockParams;

	    var opcodes = environment.opcodes,
	        opcode = undefined,
	        firstLoc = undefined,
	        i = undefined,
	        l = undefined;

	    for (i = 0, l = opcodes.length; i < l; i++) {
	      opcode = opcodes[i];

	      this.source.currentLocation = opcode.loc;
	      firstLoc = firstLoc || opcode.loc;
	      this[opcode.opcode].apply(this, opcode.args);
	    }

	    // Flush any trailing content that might be pending.
	    this.source.currentLocation = firstLoc;
	    this.pushSource('');

	    /* istanbul ignore next */
	    if (this.stackSlot || this.inlineStack.length || this.compileStack.length) {
	      throw new _exception2['default']('Compile completed with content left on stack');
	    }

	    if (!this.decorators.isEmpty()) {
	      this.useDecorators = true;

	      this.decorators.prepend('var decorators = container.decorators;\n');
	      this.decorators.push('return fn;');

	      if (asObject) {
	        this.decorators = Function.apply(this, ['fn', 'props', 'container', 'depth0', 'data', 'blockParams', 'depths', this.decorators.merge()]);
	      } else {
	        this.decorators.prepend('function(fn, props, container, depth0, data, blockParams, depths) {\n');
	        this.decorators.push('}\n');
	        this.decorators = this.decorators.merge();
	      }
	    } else {
	      this.decorators = undefined;
	    }

	    var fn = this.createFunctionContext(asObject);
	    if (!this.isChild) {
	      var ret = {
	        compiler: this.compilerInfo(),
	        main: fn
	      };

	      if (this.decorators) {
	        ret.main_d = this.decorators; // eslint-disable-line camelcase
	        ret.useDecorators = true;
	      }

	      var _context = this.context;
	      var programs = _context.programs;
	      var decorators = _context.decorators;

	      for (i = 0, l = programs.length; i < l; i++) {
	        if (programs[i]) {
	          ret[i] = programs[i];
	          if (decorators[i]) {
	            ret[i + '_d'] = decorators[i];
	            ret.useDecorators = true;
	          }
	        }
	      }

	      if (this.environment.usePartial) {
	        ret.usePartial = true;
	      }
	      if (this.options.data) {
	        ret.useData = true;
	      }
	      if (this.useDepths) {
	        ret.useDepths = true;
	      }
	      if (this.useBlockParams) {
	        ret.useBlockParams = true;
	      }
	      if (this.options.compat) {
	        ret.compat = true;
	      }

	      if (!asObject) {
	        ret.compiler = JSON.stringify(ret.compiler);

	        this.source.currentLocation = { start: { line: 1, column: 0 } };
	        ret = this.objectLiteral(ret);

	        if (options.srcName) {
	          ret = ret.toStringWithSourceMap({ file: options.destName });
	          ret.map = ret.map && ret.map.toString();
	        } else {
	          ret = ret.toString();
	        }
	      } else {
	        ret.compilerOptions = this.options;
	      }

	      return ret;
	    } else {
	      return fn;
	    }
	  },

	  preamble: function preamble() {
	    // track the last context pushed into place to allow skipping the
	    // getContext opcode when it would be a noop
	    this.lastContext = 0;
	    this.source = new _codeGen2['default'](this.options.srcName);
	    this.decorators = new _codeGen2['default'](this.options.srcName);
	  },

	  createFunctionContext: function createFunctionContext(asObject) {
	    var varDeclarations = '';

	    var locals = this.stackVars.concat(this.registers.list);
	    if (locals.length > 0) {
	      varDeclarations += ', ' + locals.join(', ');
	    }

	    // Generate minimizer alias mappings
	    //
	    // When using true SourceNodes, this will update all references to the given alias
	    // as the source nodes are reused in situ. For the non-source node compilation mode,
	    // aliases will not be used, but this case is already being run on the client and
	    // we aren't concern about minimizing the template size.
	    var aliasCount = 0;
	    for (var alias in this.aliases) {
	      // eslint-disable-line guard-for-in
	      var node = this.aliases[alias];

	      if (this.aliases.hasOwnProperty(alias) && node.children && node.referenceCount > 1) {
	        varDeclarations += ', alias' + ++aliasCount + '=' + alias;
	        node.children[0] = 'alias' + aliasCount;
	      }
	    }

	    var params = ['container', 'depth0', 'helpers', 'partials', 'data'];

	    if (this.useBlockParams || this.useDepths) {
	      params.push('blockParams');
	    }
	    if (this.useDepths) {
	      params.push('depths');
	    }

	    // Perform a second pass over the output to merge content when possible
	    var source = this.mergeSource(varDeclarations);

	    if (asObject) {
	      params.push(source);

	      return Function.apply(this, params);
	    } else {
	      return this.source.wrap(['function(', params.join(','), ') {\n  ', source, '}']);
	    }
	  },
	  mergeSource: function mergeSource(varDeclarations) {
	    var isSimple = this.environment.isSimple,
	        appendOnly = !this.forceBuffer,
	        appendFirst = undefined,
	        sourceSeen = undefined,
	        bufferStart = undefined,
	        bufferEnd = undefined;
	    this.source.each(function (line) {
	      if (line.appendToBuffer) {
	        if (bufferStart) {
	          line.prepend('  + ');
	        } else {
	          bufferStart = line;
	        }
	        bufferEnd = line;
	      } else {
	        if (bufferStart) {
	          if (!sourceSeen) {
	            appendFirst = true;
	          } else {
	            bufferStart.prepend('buffer += ');
	          }
	          bufferEnd.add(';');
	          bufferStart = bufferEnd = undefined;
	        }

	        sourceSeen = true;
	        if (!isSimple) {
	          appendOnly = false;
	        }
	      }
	    });

	    if (appendOnly) {
	      if (bufferStart) {
	        bufferStart.prepend('return ');
	        bufferEnd.add(';');
	      } else if (!sourceSeen) {
	        this.source.push('return "";');
	      }
	    } else {
	      varDeclarations += ', buffer = ' + (appendFirst ? '' : this.initializeBuffer());

	      if (bufferStart) {
	        bufferStart.prepend('return buffer + ');
	        bufferEnd.add(';');
	      } else {
	        this.source.push('return buffer;');
	      }
	    }

	    if (varDeclarations) {
	      this.source.prepend('var ' + varDeclarations.substring(2) + (appendFirst ? '' : ';\n'));
	    }

	    return this.source.merge();
	  },

	  // [blockValue]
	  //
	  // On stack, before: hash, inverse, program, value
	  // On stack, after: return value of blockHelperMissing
	  //
	  // The purpose of this opcode is to take a block of the form
	  // `{{#this.foo}}...{{/this.foo}}`, resolve the value of `foo`, and
	  // replace it on the stack with the result of properly
	  // invoking blockHelperMissing.
	  blockValue: function blockValue(name) {
	    var blockHelperMissing = this.aliasable('helpers.blockHelperMissing'),
	        params = [this.contextName(0)];
	    this.setupHelperArgs(name, 0, params);

	    var blockName = this.popStack();
	    params.splice(1, 0, blockName);

	    this.push(this.source.functionCall(blockHelperMissing, 'call', params));
	  },

	  // [ambiguousBlockValue]
	  //
	  // On stack, before: hash, inverse, program, value
	  // Compiler value, before: lastHelper=value of last found helper, if any
	  // On stack, after, if no lastHelper: same as [blockValue]
	  // On stack, after, if lastHelper: value
	  ambiguousBlockValue: function ambiguousBlockValue() {
	    // We're being a bit cheeky and reusing the options value from the prior exec
	    var blockHelperMissing = this.aliasable('helpers.blockHelperMissing'),
	        params = [this.contextName(0)];
	    this.setupHelperArgs('', 0, params, true);

	    this.flushInline();

	    var current = this.topStack();
	    params.splice(1, 0, current);

	    this.pushSource(['if (!', this.lastHelper, ') { ', current, ' = ', this.source.functionCall(blockHelperMissing, 'call', params), '}']);
	  },

	  // [appendContent]
	  //
	  // On stack, before: ...
	  // On stack, after: ...
	  //
	  // Appends the string value of `content` to the current buffer
	  appendContent: function appendContent(content) {
	    if (this.pendingContent) {
	      content = this.pendingContent + content;
	    } else {
	      this.pendingLocation = this.source.currentLocation;
	    }

	    this.pendingContent = content;
	  },

	  // [append]
	  //
	  // On stack, before: value, ...
	  // On stack, after: ...
	  //
	  // Coerces `value` to a String and appends it to the current buffer.
	  //
	  // If `value` is truthy, or 0, it is coerced into a string and appended
	  // Otherwise, the empty string is appended
	  append: function append() {
	    if (this.isInline()) {
	      this.replaceStack(function (current) {
	        return [' != null ? ', current, ' : ""'];
	      });

	      this.pushSource(this.appendToBuffer(this.popStack()));
	    } else {
	      var local = this.popStack();
	      this.pushSource(['if (', local, ' != null) { ', this.appendToBuffer(local, undefined, true), ' }']);
	      if (this.environment.isSimple) {
	        this.pushSource(['else { ', this.appendToBuffer("''", undefined, true), ' }']);
	      }
	    }
	  },

	  // [appendEscaped]
	  //
	  // On stack, before: value, ...
	  // On stack, after: ...
	  //
	  // Escape `value` and append it to the buffer
	  appendEscaped: function appendEscaped() {
	    this.pushSource(this.appendToBuffer([this.aliasable('container.escapeExpression'), '(', this.popStack(), ')']));
	  },

	  // [getContext]
	  //
	  // On stack, before: ...
	  // On stack, after: ...
	  // Compiler value, after: lastContext=depth
	  //
	  // Set the value of the `lastContext` compiler value to the depth
	  getContext: function getContext(depth) {
	    this.lastContext = depth;
	  },

	  // [pushContext]
	  //
	  // On stack, before: ...
	  // On stack, after: currentContext, ...
	  //
	  // Pushes the value of the current context onto the stack.
	  pushContext: function pushContext() {
	    this.pushStackLiteral(this.contextName(this.lastContext));
	  },

	  // [lookupOnContext]
	  //
	  // On stack, before: ...
	  // On stack, after: currentContext[name], ...
	  //
	  // Looks up the value of `name` on the current context and pushes
	  // it onto the stack.
	  lookupOnContext: function lookupOnContext(parts, falsy, strict, scoped) {
	    var i = 0;

	    if (!scoped && this.options.compat && !this.lastContext) {
	      // The depthed query is expected to handle the undefined logic for the root level that
	      // is implemented below, so we evaluate that directly in compat mode
	      this.push(this.depthedLookup(parts[i++]));
	    } else {
	      this.pushContext();
	    }

	    this.resolvePath('context', parts, i, falsy, strict);
	  },

	  // [lookupBlockParam]
	  //
	  // On stack, before: ...
	  // On stack, after: blockParam[name], ...
	  //
	  // Looks up the value of `parts` on the given block param and pushes
	  // it onto the stack.
	  lookupBlockParam: function lookupBlockParam(blockParamId, parts) {
	    this.useBlockParams = true;

	    this.push(['blockParams[', blockParamId[0], '][', blockParamId[1], ']']);
	    this.resolvePath('context', parts, 1);
	  },

	  // [lookupData]
	  //
	  // On stack, before: ...
	  // On stack, after: data, ...
	  //
	  // Push the data lookup operator
	  lookupData: function lookupData(depth, parts, strict) {
	    if (!depth) {
	      this.pushStackLiteral('data');
	    } else {
	      this.pushStackLiteral('container.data(data, ' + depth + ')');
	    }

	    this.resolvePath('data', parts, 0, true, strict);
	  },

	  resolvePath: function resolvePath(type, parts, i, falsy, strict) {
	    // istanbul ignore next

	    var _this = this;

	    if (this.options.strict || this.options.assumeObjects) {
	      this.push(strictLookup(this.options.strict && strict, this, parts, type));
	      return;
	    }

	    var len = parts.length;
	    for (; i < len; i++) {
	      /* eslint-disable no-loop-func */
	      this.replaceStack(function (current) {
	        var lookup = _this.nameLookup(current, parts[i], type);
	        // We want to ensure that zero and false are handled properly if the context (falsy flag)
	        // needs to have the special handling for these values.
	        if (!falsy) {
	          return [' != null ? ', lookup, ' : ', current];
	        } else {
	          // Otherwise we can use generic falsy handling
	          return [' && ', lookup];
	        }
	      });
	      /* eslint-enable no-loop-func */
	    }
	  },

	  // [resolvePossibleLambda]
	  //
	  // On stack, before: value, ...
	  // On stack, after: resolved value, ...
	  //
	  // If the `value` is a lambda, replace it on the stack by
	  // the return value of the lambda
	  resolvePossibleLambda: function resolvePossibleLambda() {
	    this.push([this.aliasable('container.lambda'), '(', this.popStack(), ', ', this.contextName(0), ')']);
	  },

	  // [pushStringParam]
	  //
	  // On stack, before: ...
	  // On stack, after: string, currentContext, ...
	  //
	  // This opcode is designed for use in string mode, which
	  // provides the string value of a parameter along with its
	  // depth rather than resolving it immediately.
	  pushStringParam: function pushStringParam(string, type) {
	    this.pushContext();
	    this.pushString(type);

	    // If it's a subexpression, the string result
	    // will be pushed after this opcode.
	    if (type !== 'SubExpression') {
	      if (typeof string === 'string') {
	        this.pushString(string);
	      } else {
	        this.pushStackLiteral(string);
	      }
	    }
	  },

	  emptyHash: function emptyHash(omitEmpty) {
	    if (this.trackIds) {
	      this.push('{}'); // hashIds
	    }
	    if (this.stringParams) {
	      this.push('{}'); // hashContexts
	      this.push('{}'); // hashTypes
	    }
	    this.pushStackLiteral(omitEmpty ? 'undefined' : '{}');
	  },
	  pushHash: function pushHash() {
	    if (this.hash) {
	      this.hashes.push(this.hash);
	    }
	    this.hash = { values: [], types: [], contexts: [], ids: [] };
	  },
	  popHash: function popHash() {
	    var hash = this.hash;
	    this.hash = this.hashes.pop();

	    if (this.trackIds) {
	      this.push(this.objectLiteral(hash.ids));
	    }
	    if (this.stringParams) {
	      this.push(this.objectLiteral(hash.contexts));
	      this.push(this.objectLiteral(hash.types));
	    }

	    this.push(this.objectLiteral(hash.values));
	  },

	  // [pushString]
	  //
	  // On stack, before: ...
	  // On stack, after: quotedString(string), ...
	  //
	  // Push a quoted version of `string` onto the stack
	  pushString: function pushString(string) {
	    this.pushStackLiteral(this.quotedString(string));
	  },

	  // [pushLiteral]
	  //
	  // On stack, before: ...
	  // On stack, after: value, ...
	  //
	  // Pushes a value onto the stack. This operation prevents
	  // the compiler from creating a temporary variable to hold
	  // it.
	  pushLiteral: function pushLiteral(value) {
	    this.pushStackLiteral(value);
	  },

	  // [pushProgram]
	  //
	  // On stack, before: ...
	  // On stack, after: program(guid), ...
	  //
	  // Push a program expression onto the stack. This takes
	  // a compile-time guid and converts it into a runtime-accessible
	  // expression.
	  pushProgram: function pushProgram(guid) {
	    if (guid != null) {
	      this.pushStackLiteral(this.programExpression(guid));
	    } else {
	      this.pushStackLiteral(null);
	    }
	  },

	  // [registerDecorator]
	  //
	  // On stack, before: hash, program, params..., ...
	  // On stack, after: ...
	  //
	  // Pops off the decorator's parameters, invokes the decorator,
	  // and inserts the decorator into the decorators list.
	  registerDecorator: function registerDecorator(paramSize, name) {
	    var foundDecorator = this.nameLookup('decorators', name, 'decorator'),
	        options = this.setupHelperArgs(name, paramSize);

	    this.decorators.push(['fn = ', this.decorators.functionCall(foundDecorator, '', ['fn', 'props', 'container', options]), ' || fn;']);
	  },

	  // [invokeHelper]
	  //
	  // On stack, before: hash, inverse, program, params..., ...
	  // On stack, after: result of helper invocation
	  //
	  // Pops off the helper's parameters, invokes the helper,
	  // and pushes the helper's return value onto the stack.
	  //
	  // If the helper is not found, `helperMissing` is called.
	  invokeHelper: function invokeHelper(paramSize, name, isSimple) {
	    var nonHelper = this.popStack(),
	        helper = this.setupHelper(paramSize, name),
	        simple = isSimple ? [helper.name, ' || '] : '';

	    var lookup = ['('].concat(simple, nonHelper);
	    if (!this.options.strict) {
	      lookup.push(' || ', this.aliasable('helpers.helperMissing'));
	    }
	    lookup.push(')');

	    this.push(this.source.functionCall(lookup, 'call', helper.callParams));
	  },

	  // [invokeKnownHelper]
	  //
	  // On stack, before: hash, inverse, program, params..., ...
	  // On stack, after: result of helper invocation
	  //
	  // This operation is used when the helper is known to exist,
	  // so a `helperMissing` fallback is not required.
	  invokeKnownHelper: function invokeKnownHelper(paramSize, name) {
	    var helper = this.setupHelper(paramSize, name);
	    this.push(this.source.functionCall(helper.name, 'call', helper.callParams));
	  },

	  // [invokeAmbiguous]
	  //
	  // On stack, before: hash, inverse, program, params..., ...
	  // On stack, after: result of disambiguation
	  //
	  // This operation is used when an expression like `{{foo}}`
	  // is provided, but we don't know at compile-time whether it
	  // is a helper or a path.
	  //
	  // This operation emits more code than the other options,
	  // and can be avoided by passing the `knownHelpers` and
	  // `knownHelpersOnly` flags at compile-time.
	  invokeAmbiguous: function invokeAmbiguous(name, helperCall) {
	    this.useRegister('helper');

	    var nonHelper = this.popStack();

	    this.emptyHash();
	    var helper = this.setupHelper(0, name, helperCall);

	    var helperName = this.lastHelper = this.nameLookup('helpers', name, 'helper');

	    var lookup = ['(', '(helper = ', helperName, ' || ', nonHelper, ')'];
	    if (!this.options.strict) {
	      lookup[0] = '(helper = ';
	      lookup.push(' != null ? helper : ', this.aliasable('helpers.helperMissing'));
	    }

	    this.push(['(', lookup, helper.paramsInit ? ['),(', helper.paramsInit] : [], '),', '(typeof helper === ', this.aliasable('"function"'), ' ? ', this.source.functionCall('helper', 'call', helper.callParams), ' : helper))']);
	  },

	  // [invokePartial]
	  //
	  // On stack, before: context, ...
	  // On stack after: result of partial invocation
	  //
	  // This operation pops off a context, invokes a partial with that context,
	  // and pushes the result of the invocation back.
	  invokePartial: function invokePartial(isDynamic, name, indent) {
	    var params = [],
	        options = this.setupParams(name, 1, params);

	    if (isDynamic) {
	      name = this.popStack();
	      delete options.name;
	    }

	    if (indent) {
	      options.indent = JSON.stringify(indent);
	    }
	    options.helpers = 'helpers';
	    options.partials = 'partials';
	    options.decorators = 'container.decorators';

	    if (!isDynamic) {
	      params.unshift(this.nameLookup('partials', name, 'partial'));
	    } else {
	      params.unshift(name);
	    }

	    if (this.options.compat) {
	      options.depths = 'depths';
	    }
	    options = this.objectLiteral(options);
	    params.push(options);

	    this.push(this.source.functionCall('container.invokePartial', '', params));
	  },

	  // [assignToHash]
	  //
	  // On stack, before: value, ..., hash, ...
	  // On stack, after: ..., hash, ...
	  //
	  // Pops a value off the stack and assigns it to the current hash
	  assignToHash: function assignToHash(key) {
	    var value = this.popStack(),
	        context = undefined,
	        type = undefined,
	        id = undefined;

	    if (this.trackIds) {
	      id = this.popStack();
	    }
	    if (this.stringParams) {
	      type = this.popStack();
	      context = this.popStack();
	    }

	    var hash = this.hash;
	    if (context) {
	      hash.contexts[key] = context;
	    }
	    if (type) {
	      hash.types[key] = type;
	    }
	    if (id) {
	      hash.ids[key] = id;
	    }
	    hash.values[key] = value;
	  },

	  pushId: function pushId(type, name, child) {
	    if (type === 'BlockParam') {
	      this.pushStackLiteral('blockParams[' + name[0] + '].path[' + name[1] + ']' + (child ? ' + ' + JSON.stringify('.' + child) : ''));
	    } else if (type === 'PathExpression') {
	      this.pushString(name);
	    } else if (type === 'SubExpression') {
	      this.pushStackLiteral('true');
	    } else {
	      this.pushStackLiteral('null');
	    }
	  },

	  // HELPERS

	  compiler: JavaScriptCompiler,

	  compileChildren: function compileChildren(environment, options) {
	    var children = environment.children,
	        child = undefined,
	        compiler = undefined;

	    for (var i = 0, l = children.length; i < l; i++) {
	      child = children[i];
	      compiler = new this.compiler(); // eslint-disable-line new-cap

	      var index = this.matchExistingProgram(child);

	      if (index == null) {
	        this.context.programs.push(''); // Placeholder to prevent name conflicts for nested children
	        index = this.context.programs.length;
	        child.index = index;
	        child.name = 'program' + index;
	        this.context.programs[index] = compiler.compile(child, options, this.context, !this.precompile);
	        this.context.decorators[index] = compiler.decorators;
	        this.context.environments[index] = child;

	        this.useDepths = this.useDepths || compiler.useDepths;
	        this.useBlockParams = this.useBlockParams || compiler.useBlockParams;
	      } else {
	        child.index = index;
	        child.name = 'program' + index;

	        this.useDepths = this.useDepths || child.useDepths;
	        this.useBlockParams = this.useBlockParams || child.useBlockParams;
	      }
	    }
	  },
	  matchExistingProgram: function matchExistingProgram(child) {
	    for (var i = 0, len = this.context.environments.length; i < len; i++) {
	      var environment = this.context.environments[i];
	      if (environment && environment.equals(child)) {
	        return i;
	      }
	    }
	  },

	  programExpression: function programExpression(guid) {
	    var child = this.environment.children[guid],
	        programParams = [child.index, 'data', child.blockParams];

	    if (this.useBlockParams || this.useDepths) {
	      programParams.push('blockParams');
	    }
	    if (this.useDepths) {
	      programParams.push('depths');
	    }

	    return 'container.program(' + programParams.join(', ') + ')';
	  },

	  useRegister: function useRegister(name) {
	    if (!this.registers[name]) {
	      this.registers[name] = true;
	      this.registers.list.push(name);
	    }
	  },

	  push: function push(expr) {
	    if (!(expr instanceof Literal)) {
	      expr = this.source.wrap(expr);
	    }

	    this.inlineStack.push(expr);
	    return expr;
	  },

	  pushStackLiteral: function pushStackLiteral(item) {
	    this.push(new Literal(item));
	  },

	  pushSource: function pushSource(source) {
	    if (this.pendingContent) {
	      this.source.push(this.appendToBuffer(this.source.quotedString(this.pendingContent), this.pendingLocation));
	      this.pendingContent = undefined;
	    }

	    if (source) {
	      this.source.push(source);
	    }
	  },

	  replaceStack: function replaceStack(callback) {
	    var prefix = ['('],
	        stack = undefined,
	        createdStack = undefined,
	        usedLiteral = undefined;

	    /* istanbul ignore next */
	    if (!this.isInline()) {
	      throw new _exception2['default']('replaceStack on non-inline');
	    }

	    // We want to merge the inline statement into the replacement statement via ','
	    var top = this.popStack(true);

	    if (top instanceof Literal) {
	      // Literals do not need to be inlined
	      stack = [top.value];
	      prefix = ['(', stack];
	      usedLiteral = true;
	    } else {
	      // Get or create the current stack name for use by the inline
	      createdStack = true;
	      var _name = this.incrStack();

	      prefix = ['((', this.push(_name), ' = ', top, ')'];
	      stack = this.topStack();
	    }

	    var item = callback.call(this, stack);

	    if (!usedLiteral) {
	      this.popStack();
	    }
	    if (createdStack) {
	      this.stackSlot--;
	    }
	    this.push(prefix.concat(item, ')'));
	  },

	  incrStack: function incrStack() {
	    this.stackSlot++;
	    if (this.stackSlot > this.stackVars.length) {
	      this.stackVars.push('stack' + this.stackSlot);
	    }
	    return this.topStackName();
	  },
	  topStackName: function topStackName() {
	    return 'stack' + this.stackSlot;
	  },
	  flushInline: function flushInline() {
	    var inlineStack = this.inlineStack;
	    this.inlineStack = [];
	    for (var i = 0, len = inlineStack.length; i < len; i++) {
	      var entry = inlineStack[i];
	      /* istanbul ignore if */
	      if (entry instanceof Literal) {
	        this.compileStack.push(entry);
	      } else {
	        var stack = this.incrStack();
	        this.pushSource([stack, ' = ', entry, ';']);
	        this.compileStack.push(stack);
	      }
	    }
	  },
	  isInline: function isInline() {
	    return this.inlineStack.length;
	  },

	  popStack: function popStack(wrapped) {
	    var inline = this.isInline(),
	        item = (inline ? this.inlineStack : this.compileStack).pop();

	    if (!wrapped && item instanceof Literal) {
	      return item.value;
	    } else {
	      if (!inline) {
	        /* istanbul ignore next */
	        if (!this.stackSlot) {
	          throw new _exception2['default']('Invalid stack pop');
	        }
	        this.stackSlot--;
	      }
	      return item;
	    }
	  },

	  topStack: function topStack() {
	    var stack = this.isInline() ? this.inlineStack : this.compileStack,
	        item = stack[stack.length - 1];

	    /* istanbul ignore if */
	    if (item instanceof Literal) {
	      return item.value;
	    } else {
	      return item;
	    }
	  },

	  contextName: function contextName(context) {
	    if (this.useDepths && context) {
	      return 'depths[' + context + ']';
	    } else {
	      return 'depth' + context;
	    }
	  },

	  quotedString: function quotedString(str) {
	    return this.source.quotedString(str);
	  },

	  objectLiteral: function objectLiteral(obj) {
	    return this.source.objectLiteral(obj);
	  },

	  aliasable: function aliasable(name) {
	    var ret = this.aliases[name];
	    if (ret) {
	      ret.referenceCount++;
	      return ret;
	    }

	    ret = this.aliases[name] = this.source.wrap(name);
	    ret.aliasable = true;
	    ret.referenceCount = 1;

	    return ret;
	  },

	  setupHelper: function setupHelper(paramSize, name, blockHelper) {
	    var params = [],
	        paramsInit = this.setupHelperArgs(name, paramSize, params, blockHelper);
	    var foundHelper = this.nameLookup('helpers', name, 'helper'),
	        callContext = this.aliasable(this.contextName(0) + ' != null ? ' + this.contextName(0) + ' : {}');

	    return {
	      params: params,
	      paramsInit: paramsInit,
	      name: foundHelper,
	      callParams: [callContext].concat(params)
	    };
	  },

	  setupParams: function setupParams(helper, paramSize, params) {
	    var options = {},
	        contexts = [],
	        types = [],
	        ids = [],
	        objectArgs = !params,
	        param = undefined;

	    if (objectArgs) {
	      params = [];
	    }

	    options.name = this.quotedString(helper);
	    options.hash = this.popStack();

	    if (this.trackIds) {
	      options.hashIds = this.popStack();
	    }
	    if (this.stringParams) {
	      options.hashTypes = this.popStack();
	      options.hashContexts = this.popStack();
	    }

	    var inverse = this.popStack(),
	        program = this.popStack();

	    // Avoid setting fn and inverse if neither are set. This allows
	    // helpers to do a check for `if (options.fn)`
	    if (program || inverse) {
	      options.fn = program || 'container.noop';
	      options.inverse = inverse || 'container.noop';
	    }

	    // The parameters go on to the stack in order (making sure that they are evaluated in order)
	    // so we need to pop them off the stack in reverse order
	    var i = paramSize;
	    while (i--) {
	      param = this.popStack();
	      params[i] = param;

	      if (this.trackIds) {
	        ids[i] = this.popStack();
	      }
	      if (this.stringParams) {
	        types[i] = this.popStack();
	        contexts[i] = this.popStack();
	      }
	    }

	    if (objectArgs) {
	      options.args = this.source.generateArray(params);
	    }

	    if (this.trackIds) {
	      options.ids = this.source.generateArray(ids);
	    }
	    if (this.stringParams) {
	      options.types = this.source.generateArray(types);
	      options.contexts = this.source.generateArray(contexts);
	    }

	    if (this.options.data) {
	      options.data = 'data';
	    }
	    if (this.useBlockParams) {
	      options.blockParams = 'blockParams';
	    }
	    return options;
	  },

	  setupHelperArgs: function setupHelperArgs(helper, paramSize, params, useRegister) {
	    var options = this.setupParams(helper, paramSize, params);
	    options = this.objectLiteral(options);
	    if (useRegister) {
	      this.useRegister('options');
	      params.push('options');
	      return ['options=', options];
	    } else if (params) {
	      params.push(options);
	      return '';
	    } else {
	      return options;
	    }
	  }
	};

	(function () {
	  var reservedWords = ('break else new var' + ' case finally return void' + ' catch for switch while' + ' continue function this with' + ' default if throw' + ' delete in try' + ' do instanceof typeof' + ' abstract enum int short' + ' boolean export interface static' + ' byte extends long super' + ' char final native synchronized' + ' class float package throws' + ' const goto private transient' + ' debugger implements protected volatile' + ' double import public let yield await' + ' null true false').split(' ');

	  var compilerWords = JavaScriptCompiler.RESERVED_WORDS = {};

	  for (var i = 0, l = reservedWords.length; i < l; i++) {
	    compilerWords[reservedWords[i]] = true;
	  }
	})();

	JavaScriptCompiler.isValidJavaScriptVariableName = function (name) {
	  return !JavaScriptCompiler.RESERVED_WORDS[name] && /^[a-zA-Z_$][0-9a-zA-Z_$]*$/.test(name);
	};

	function strictLookup(requireTerminal, compiler, parts, type) {
	  var stack = compiler.popStack(),
	      i = 0,
	      len = parts.length;
	  if (requireTerminal) {
	    len--;
	  }

	  for (; i < len; i++) {
	    stack = compiler.nameLookup(stack, parts[i], type);
	  }

	  if (requireTerminal) {
	    return [compiler.aliasable('container.strict'), '(', stack, ', ', compiler.quotedString(parts[i]), ')'];
	  } else {
	    return stack;
	  }
	}

	exports['default'] = JavaScriptCompiler;
	module.exports = exports['default'];

/***/ },
/* 29 */
/***/ function(module, exports, __webpack_require__) {

	/* global define */
	'use strict';

	exports.__esModule = true;

	var _utils = __webpack_require__(5);

	var SourceNode = undefined;

	try {
	  /* istanbul ignore next */
	  if (false) {
	    // We don't support this in AMD environments. For these environments, we asusme that
	    // they are running on the browser and thus have no need for the source-map library.
	    var SourceMap = require('source-map');
	    SourceNode = SourceMap.SourceNode;
	  }
	} catch (err) {}
	/* NOP */

	/* istanbul ignore if: tested but not covered in istanbul due to dist build  */
	if (!SourceNode) {
	  SourceNode = function (line, column, srcFile, chunks) {
	    this.src = '';
	    if (chunks) {
	      this.add(chunks);
	    }
	  };
	  /* istanbul ignore next */
	  SourceNode.prototype = {
	    add: function add(chunks) {
	      if (_utils.isArray(chunks)) {
	        chunks = chunks.join('');
	      }
	      this.src += chunks;
	    },
	    prepend: function prepend(chunks) {
	      if (_utils.isArray(chunks)) {
	        chunks = chunks.join('');
	      }
	      this.src = chunks + this.src;
	    },
	    toStringWithSourceMap: function toStringWithSourceMap() {
	      return { code: this.toString() };
	    },
	    toString: function toString() {
	      return this.src;
	    }
	  };
	}

	function castChunk(chunk, codeGen, loc) {
	  if (_utils.isArray(chunk)) {
	    var ret = [];

	    for (var i = 0, len = chunk.length; i < len; i++) {
	      ret.push(codeGen.wrap(chunk[i], loc));
	    }
	    return ret;
	  } else if (typeof chunk === 'boolean' || typeof chunk === 'number') {
	    // Handle primitives that the SourceNode will throw up on
	    return chunk + '';
	  }
	  return chunk;
	}

	function CodeGen(srcFile) {
	  this.srcFile = srcFile;
	  this.source = [];
	}

	CodeGen.prototype = {
	  isEmpty: function isEmpty() {
	    return !this.source.length;
	  },
	  prepend: function prepend(source, loc) {
	    this.source.unshift(this.wrap(source, loc));
	  },
	  push: function push(source, loc) {
	    this.source.push(this.wrap(source, loc));
	  },

	  merge: function merge() {
	    var source = this.empty();
	    this.each(function (line) {
	      source.add(['  ', line, '\n']);
	    });
	    return source;
	  },

	  each: function each(iter) {
	    for (var i = 0, len = this.source.length; i < len; i++) {
	      iter(this.source[i]);
	    }
	  },

	  empty: function empty() {
	    var loc = this.currentLocation || { start: {} };
	    return new SourceNode(loc.start.line, loc.start.column, this.srcFile);
	  },
	  wrap: function wrap(chunk) {
	    var loc = arguments.length <= 1 || arguments[1] === undefined ? this.currentLocation || { start: {} } : arguments[1];

	    if (chunk instanceof SourceNode) {
	      return chunk;
	    }

	    chunk = castChunk(chunk, this, loc);

	    return new SourceNode(loc.start.line, loc.start.column, this.srcFile, chunk);
	  },

	  functionCall: function functionCall(fn, type, params) {
	    params = this.generateList(params);
	    return this.wrap([fn, type ? '.' + type + '(' : '(', params, ')']);
	  },

	  quotedString: function quotedString(str) {
	    return '"' + (str + '').replace(/\\/g, '\\\\').replace(/"/g, '\\"').replace(/\n/g, '\\n').replace(/\r/g, '\\r').replace(/\u2028/g, '\\u2028') // Per Ecma-262 7.3 + 7.8.4
	    .replace(/\u2029/g, '\\u2029') + '"';
	  },

	  objectLiteral: function objectLiteral(obj) {
	    var pairs = [];

	    for (var key in obj) {
	      if (obj.hasOwnProperty(key)) {
	        var value = castChunk(obj[key], this);
	        if (value !== 'undefined') {
	          pairs.push([this.quotedString(key), ':', value]);
	        }
	      }
	    }

	    var ret = this.generateList(pairs);
	    ret.prepend('{');
	    ret.add('}');
	    return ret;
	  },

	  generateList: function generateList(entries) {
	    var ret = this.empty();

	    for (var i = 0, len = entries.length; i < len; i++) {
	      if (i) {
	        ret.add(',');
	      }

	      ret.add(castChunk(entries[i], this));
	    }

	    return ret;
	  },

	  generateArray: function generateArray(entries) {
	    var ret = this.generateList(entries);
	    ret.prepend('[');
	    ret.add(']');

	    return ret;
	  }
	};

	exports['default'] = CodeGen;
	module.exports = exports['default'];

/***/ }
/******/ ])
});
;;//! moment.js
//! version : 2.12.0
//! authors : Tim Wood, Iskren Chernev, Moment.js contributors
//! license : MIT
//! momentjs.com
!function(a,b){"object"==typeof exports&&"undefined"!=typeof module?module.exports=b():"function"==typeof define&&define.amd?define(b):a.moment=b()}(this,function(){"use strict";function a(){return Zc.apply(null,arguments)}function b(a){Zc=a}function c(a){return a instanceof Array||"[object Array]"===Object.prototype.toString.call(a)}function d(a){return a instanceof Date||"[object Date]"===Object.prototype.toString.call(a)}function e(a,b){var c,d=[];for(c=0;c<a.length;++c)d.push(b(a[c],c));return d}function f(a,b){return Object.prototype.hasOwnProperty.call(a,b)}function g(a,b){for(var c in b)f(b,c)&&(a[c]=b[c]);return f(b,"toString")&&(a.toString=b.toString),f(b,"valueOf")&&(a.valueOf=b.valueOf),a}function h(a,b,c,d){return Ia(a,b,c,d,!0).utc()}function i(){return{empty:!1,unusedTokens:[],unusedInput:[],overflow:-2,charsLeftOver:0,nullInput:!1,invalidMonth:null,invalidFormat:!1,userInvalidated:!1,iso:!1}}function j(a){return null==a._pf&&(a._pf=i()),a._pf}function k(a){if(null==a._isValid){var b=j(a);a._isValid=!(isNaN(a._d.getTime())||!(b.overflow<0)||b.empty||b.invalidMonth||b.invalidWeekday||b.nullInput||b.invalidFormat||b.userInvalidated),a._strict&&(a._isValid=a._isValid&&0===b.charsLeftOver&&0===b.unusedTokens.length&&void 0===b.bigHour)}return a._isValid}function l(a){var b=h(NaN);return null!=a?g(j(b),a):j(b).userInvalidated=!0,b}function m(a){return void 0===a}function n(a,b){var c,d,e;if(m(b._isAMomentObject)||(a._isAMomentObject=b._isAMomentObject),m(b._i)||(a._i=b._i),m(b._f)||(a._f=b._f),m(b._l)||(a._l=b._l),m(b._strict)||(a._strict=b._strict),m(b._tzm)||(a._tzm=b._tzm),m(b._isUTC)||(a._isUTC=b._isUTC),m(b._offset)||(a._offset=b._offset),m(b._pf)||(a._pf=j(b)),m(b._locale)||(a._locale=b._locale),$c.length>0)for(c in $c)d=$c[c],e=b[d],m(e)||(a[d]=e);return a}function o(b){n(this,b),this._d=new Date(null!=b._d?b._d.getTime():NaN),_c===!1&&(_c=!0,a.updateOffset(this),_c=!1)}function p(a){return a instanceof o||null!=a&&null!=a._isAMomentObject}function q(a){return 0>a?Math.ceil(a):Math.floor(a)}function r(a){var b=+a,c=0;return 0!==b&&isFinite(b)&&(c=q(b)),c}function s(a,b,c){var d,e=Math.min(a.length,b.length),f=Math.abs(a.length-b.length),g=0;for(d=0;e>d;d++)(c&&a[d]!==b[d]||!c&&r(a[d])!==r(b[d]))&&g++;return g+f}function t(b){a.suppressDeprecationWarnings===!1&&"undefined"!=typeof console&&console.warn&&console.warn("Deprecation warning: "+b)}function u(a,b){var c=!0;return g(function(){return c&&(t(a+"\nArguments: "+Array.prototype.slice.call(arguments).join(", ")+"\n"+(new Error).stack),c=!1),b.apply(this,arguments)},b)}function v(a,b){ad[a]||(t(b),ad[a]=!0)}function w(a){return a instanceof Function||"[object Function]"===Object.prototype.toString.call(a)}function x(a){return"[object Object]"===Object.prototype.toString.call(a)}function y(a){var b,c;for(c in a)b=a[c],w(b)?this[c]=b:this["_"+c]=b;this._config=a,this._ordinalParseLenient=new RegExp(this._ordinalParse.source+"|"+/\d{1,2}/.source)}function z(a,b){var c,d=g({},a);for(c in b)f(b,c)&&(x(a[c])&&x(b[c])?(d[c]={},g(d[c],a[c]),g(d[c],b[c])):null!=b[c]?d[c]=b[c]:delete d[c]);return d}function A(a){null!=a&&this.set(a)}function B(a){return a?a.toLowerCase().replace("_","-"):a}function C(a){for(var b,c,d,e,f=0;f<a.length;){for(e=B(a[f]).split("-"),b=e.length,c=B(a[f+1]),c=c?c.split("-"):null;b>0;){if(d=D(e.slice(0,b).join("-")))return d;if(c&&c.length>=b&&s(e,c,!0)>=b-1)break;b--}f++}return null}function D(a){var b=null;if(!cd[a]&&"undefined"!=typeof module&&module&&module.exports)try{b=bd._abbr,require("./locale/"+a),E(b)}catch(c){}return cd[a]}function E(a,b){var c;return a&&(c=m(b)?H(a):F(a,b),c&&(bd=c)),bd._abbr}function F(a,b){return null!==b?(b.abbr=a,null!=cd[a]?(v("defineLocaleOverride","use moment.updateLocale(localeName, config) to change an existing locale. moment.defineLocale(localeName, config) should only be used for creating a new locale"),b=z(cd[a]._config,b)):null!=b.parentLocale&&(null!=cd[b.parentLocale]?b=z(cd[b.parentLocale]._config,b):v("parentLocaleUndefined","specified parentLocale is not defined yet")),cd[a]=new A(b),E(a),cd[a]):(delete cd[a],null)}function G(a,b){if(null!=b){var c;null!=cd[a]&&(b=z(cd[a]._config,b)),c=new A(b),c.parentLocale=cd[a],cd[a]=c,E(a)}else null!=cd[a]&&(null!=cd[a].parentLocale?cd[a]=cd[a].parentLocale:null!=cd[a]&&delete cd[a]);return cd[a]}function H(a){var b;if(a&&a._locale&&a._locale._abbr&&(a=a._locale._abbr),!a)return bd;if(!c(a)){if(b=D(a))return b;a=[a]}return C(a)}function I(){return Object.keys(cd)}function J(a,b){var c=a.toLowerCase();dd[c]=dd[c+"s"]=dd[b]=a}function K(a){return"string"==typeof a?dd[a]||dd[a.toLowerCase()]:void 0}function L(a){var b,c,d={};for(c in a)f(a,c)&&(b=K(c),b&&(d[b]=a[c]));return d}function M(b,c){return function(d){return null!=d?(O(this,b,d),a.updateOffset(this,c),this):N(this,b)}}function N(a,b){return a.isValid()?a._d["get"+(a._isUTC?"UTC":"")+b]():NaN}function O(a,b,c){a.isValid()&&a._d["set"+(a._isUTC?"UTC":"")+b](c)}function P(a,b){var c;if("object"==typeof a)for(c in a)this.set(c,a[c]);else if(a=K(a),w(this[a]))return this[a](b);return this}function Q(a,b,c){var d=""+Math.abs(a),e=b-d.length,f=a>=0;return(f?c?"+":"":"-")+Math.pow(10,Math.max(0,e)).toString().substr(1)+d}function R(a,b,c,d){var e=d;"string"==typeof d&&(e=function(){return this[d]()}),a&&(hd[a]=e),b&&(hd[b[0]]=function(){return Q(e.apply(this,arguments),b[1],b[2])}),c&&(hd[c]=function(){return this.localeData().ordinal(e.apply(this,arguments),a)})}function S(a){return a.match(/\[[\s\S]/)?a.replace(/^\[|\]$/g,""):a.replace(/\\/g,"")}function T(a){var b,c,d=a.match(ed);for(b=0,c=d.length;c>b;b++)hd[d[b]]?d[b]=hd[d[b]]:d[b]=S(d[b]);return function(e){var f="";for(b=0;c>b;b++)f+=d[b]instanceof Function?d[b].call(e,a):d[b];return f}}function U(a,b){return a.isValid()?(b=V(b,a.localeData()),gd[b]=gd[b]||T(b),gd[b](a)):a.localeData().invalidDate()}function V(a,b){function c(a){return b.longDateFormat(a)||a}var d=5;for(fd.lastIndex=0;d>=0&&fd.test(a);)a=a.replace(fd,c),fd.lastIndex=0,d-=1;return a}function W(a,b,c){zd[a]=w(b)?b:function(a,d){return a&&c?c:b}}function X(a,b){return f(zd,a)?zd[a](b._strict,b._locale):new RegExp(Y(a))}function Y(a){return Z(a.replace("\\","").replace(/\\(\[)|\\(\])|\[([^\]\[]*)\]|\\(.)/g,function(a,b,c,d,e){return b||c||d||e}))}function Z(a){return a.replace(/[-\/\\^$*+?.()|[\]{}]/g,"\\$&")}function $(a,b){var c,d=b;for("string"==typeof a&&(a=[a]),"number"==typeof b&&(d=function(a,c){c[b]=r(a)}),c=0;c<a.length;c++)Ad[a[c]]=d}function _(a,b){$(a,function(a,c,d,e){d._w=d._w||{},b(a,d._w,d,e)})}function aa(a,b,c){null!=b&&f(Ad,a)&&Ad[a](b,c._a,c,a)}function ba(a,b){return new Date(Date.UTC(a,b+1,0)).getUTCDate()}function ca(a,b){return c(this._months)?this._months[a.month()]:this._months[Kd.test(b)?"format":"standalone"][a.month()]}function da(a,b){return c(this._monthsShort)?this._monthsShort[a.month()]:this._monthsShort[Kd.test(b)?"format":"standalone"][a.month()]}function ea(a,b,c){var d,e,f;for(this._monthsParse||(this._monthsParse=[],this._longMonthsParse=[],this._shortMonthsParse=[]),d=0;12>d;d++){if(e=h([2e3,d]),c&&!this._longMonthsParse[d]&&(this._longMonthsParse[d]=new RegExp("^"+this.months(e,"").replace(".","")+"$","i"),this._shortMonthsParse[d]=new RegExp("^"+this.monthsShort(e,"").replace(".","")+"$","i")),c||this._monthsParse[d]||(f="^"+this.months(e,"")+"|^"+this.monthsShort(e,""),this._monthsParse[d]=new RegExp(f.replace(".",""),"i")),c&&"MMMM"===b&&this._longMonthsParse[d].test(a))return d;if(c&&"MMM"===b&&this._shortMonthsParse[d].test(a))return d;if(!c&&this._monthsParse[d].test(a))return d}}function fa(a,b){var c;if(!a.isValid())return a;if("string"==typeof b)if(/^\d+$/.test(b))b=r(b);else if(b=a.localeData().monthsParse(b),"number"!=typeof b)return a;return c=Math.min(a.date(),ba(a.year(),b)),a._d["set"+(a._isUTC?"UTC":"")+"Month"](b,c),a}function ga(b){return null!=b?(fa(this,b),a.updateOffset(this,!0),this):N(this,"Month")}function ha(){return ba(this.year(),this.month())}function ia(a){return this._monthsParseExact?(f(this,"_monthsRegex")||ka.call(this),a?this._monthsShortStrictRegex:this._monthsShortRegex):this._monthsShortStrictRegex&&a?this._monthsShortStrictRegex:this._monthsShortRegex}function ja(a){return this._monthsParseExact?(f(this,"_monthsRegex")||ka.call(this),a?this._monthsStrictRegex:this._monthsRegex):this._monthsStrictRegex&&a?this._monthsStrictRegex:this._monthsRegex}function ka(){function a(a,b){return b.length-a.length}var b,c,d=[],e=[],f=[];for(b=0;12>b;b++)c=h([2e3,b]),d.push(this.monthsShort(c,"")),e.push(this.months(c,"")),f.push(this.months(c,"")),f.push(this.monthsShort(c,""));for(d.sort(a),e.sort(a),f.sort(a),b=0;12>b;b++)d[b]=Z(d[b]),e[b]=Z(e[b]),f[b]=Z(f[b]);this._monthsRegex=new RegExp("^("+f.join("|")+")","i"),this._monthsShortRegex=this._monthsRegex,this._monthsStrictRegex=new RegExp("^("+e.join("|")+")$","i"),this._monthsShortStrictRegex=new RegExp("^("+d.join("|")+")$","i")}function la(a){var b,c=a._a;return c&&-2===j(a).overflow&&(b=c[Cd]<0||c[Cd]>11?Cd:c[Dd]<1||c[Dd]>ba(c[Bd],c[Cd])?Dd:c[Ed]<0||c[Ed]>24||24===c[Ed]&&(0!==c[Fd]||0!==c[Gd]||0!==c[Hd])?Ed:c[Fd]<0||c[Fd]>59?Fd:c[Gd]<0||c[Gd]>59?Gd:c[Hd]<0||c[Hd]>999?Hd:-1,j(a)._overflowDayOfYear&&(Bd>b||b>Dd)&&(b=Dd),j(a)._overflowWeeks&&-1===b&&(b=Id),j(a)._overflowWeekday&&-1===b&&(b=Jd),j(a).overflow=b),a}function ma(a){var b,c,d,e,f,g,h=a._i,i=Pd.exec(h)||Qd.exec(h);if(i){for(j(a).iso=!0,b=0,c=Sd.length;c>b;b++)if(Sd[b][1].exec(i[1])){e=Sd[b][0],d=Sd[b][2]!==!1;break}if(null==e)return void(a._isValid=!1);if(i[3]){for(b=0,c=Td.length;c>b;b++)if(Td[b][1].exec(i[3])){f=(i[2]||" ")+Td[b][0];break}if(null==f)return void(a._isValid=!1)}if(!d&&null!=f)return void(a._isValid=!1);if(i[4]){if(!Rd.exec(i[4]))return void(a._isValid=!1);g="Z"}a._f=e+(f||"")+(g||""),Ba(a)}else a._isValid=!1}function na(b){var c=Ud.exec(b._i);return null!==c?void(b._d=new Date(+c[1])):(ma(b),void(b._isValid===!1&&(delete b._isValid,a.createFromInputFallback(b))))}function oa(a,b,c,d,e,f,g){var h=new Date(a,b,c,d,e,f,g);return 100>a&&a>=0&&isFinite(h.getFullYear())&&h.setFullYear(a),h}function pa(a){var b=new Date(Date.UTC.apply(null,arguments));return 100>a&&a>=0&&isFinite(b.getUTCFullYear())&&b.setUTCFullYear(a),b}function qa(a){return ra(a)?366:365}function ra(a){return a%4===0&&a%100!==0||a%400===0}function sa(){return ra(this.year())}function ta(a,b,c){var d=7+b-c,e=(7+pa(a,0,d).getUTCDay()-b)%7;return-e+d-1}function ua(a,b,c,d,e){var f,g,h=(7+c-d)%7,i=ta(a,d,e),j=1+7*(b-1)+h+i;return 0>=j?(f=a-1,g=qa(f)+j):j>qa(a)?(f=a+1,g=j-qa(a)):(f=a,g=j),{year:f,dayOfYear:g}}function va(a,b,c){var d,e,f=ta(a.year(),b,c),g=Math.floor((a.dayOfYear()-f-1)/7)+1;return 1>g?(e=a.year()-1,d=g+wa(e,b,c)):g>wa(a.year(),b,c)?(d=g-wa(a.year(),b,c),e=a.year()+1):(e=a.year(),d=g),{week:d,year:e}}function wa(a,b,c){var d=ta(a,b,c),e=ta(a+1,b,c);return(qa(a)-d+e)/7}function xa(a,b,c){return null!=a?a:null!=b?b:c}function ya(b){var c=new Date(a.now());return b._useUTC?[c.getUTCFullYear(),c.getUTCMonth(),c.getUTCDate()]:[c.getFullYear(),c.getMonth(),c.getDate()]}function za(a){var b,c,d,e,f=[];if(!a._d){for(d=ya(a),a._w&&null==a._a[Dd]&&null==a._a[Cd]&&Aa(a),a._dayOfYear&&(e=xa(a._a[Bd],d[Bd]),a._dayOfYear>qa(e)&&(j(a)._overflowDayOfYear=!0),c=pa(e,0,a._dayOfYear),a._a[Cd]=c.getUTCMonth(),a._a[Dd]=c.getUTCDate()),b=0;3>b&&null==a._a[b];++b)a._a[b]=f[b]=d[b];for(;7>b;b++)a._a[b]=f[b]=null==a._a[b]?2===b?1:0:a._a[b];24===a._a[Ed]&&0===a._a[Fd]&&0===a._a[Gd]&&0===a._a[Hd]&&(a._nextDay=!0,a._a[Ed]=0),a._d=(a._useUTC?pa:oa).apply(null,f),null!=a._tzm&&a._d.setUTCMinutes(a._d.getUTCMinutes()-a._tzm),a._nextDay&&(a._a[Ed]=24)}}function Aa(a){var b,c,d,e,f,g,h,i;b=a._w,null!=b.GG||null!=b.W||null!=b.E?(f=1,g=4,c=xa(b.GG,a._a[Bd],va(Ja(),1,4).year),d=xa(b.W,1),e=xa(b.E,1),(1>e||e>7)&&(i=!0)):(f=a._locale._week.dow,g=a._locale._week.doy,c=xa(b.gg,a._a[Bd],va(Ja(),f,g).year),d=xa(b.w,1),null!=b.d?(e=b.d,(0>e||e>6)&&(i=!0)):null!=b.e?(e=b.e+f,(b.e<0||b.e>6)&&(i=!0)):e=f),1>d||d>wa(c,f,g)?j(a)._overflowWeeks=!0:null!=i?j(a)._overflowWeekday=!0:(h=ua(c,d,e,f,g),a._a[Bd]=h.year,a._dayOfYear=h.dayOfYear)}function Ba(b){if(b._f===a.ISO_8601)return void ma(b);b._a=[],j(b).empty=!0;var c,d,e,f,g,h=""+b._i,i=h.length,k=0;for(e=V(b._f,b._locale).match(ed)||[],c=0;c<e.length;c++)f=e[c],d=(h.match(X(f,b))||[])[0],d&&(g=h.substr(0,h.indexOf(d)),g.length>0&&j(b).unusedInput.push(g),h=h.slice(h.indexOf(d)+d.length),k+=d.length),hd[f]?(d?j(b).empty=!1:j(b).unusedTokens.push(f),aa(f,d,b)):b._strict&&!d&&j(b).unusedTokens.push(f);j(b).charsLeftOver=i-k,h.length>0&&j(b).unusedInput.push(h),j(b).bigHour===!0&&b._a[Ed]<=12&&b._a[Ed]>0&&(j(b).bigHour=void 0),b._a[Ed]=Ca(b._locale,b._a[Ed],b._meridiem),za(b),la(b)}function Ca(a,b,c){var d;return null==c?b:null!=a.meridiemHour?a.meridiemHour(b,c):null!=a.isPM?(d=a.isPM(c),d&&12>b&&(b+=12),d||12!==b||(b=0),b):b}function Da(a){var b,c,d,e,f;if(0===a._f.length)return j(a).invalidFormat=!0,void(a._d=new Date(NaN));for(e=0;e<a._f.length;e++)f=0,b=n({},a),null!=a._useUTC&&(b._useUTC=a._useUTC),b._f=a._f[e],Ba(b),k(b)&&(f+=j(b).charsLeftOver,f+=10*j(b).unusedTokens.length,j(b).score=f,(null==d||d>f)&&(d=f,c=b));g(a,c||b)}function Ea(a){if(!a._d){var b=L(a._i);a._a=e([b.year,b.month,b.day||b.date,b.hour,b.minute,b.second,b.millisecond],function(a){return a&&parseInt(a,10)}),za(a)}}function Fa(a){var b=new o(la(Ga(a)));return b._nextDay&&(b.add(1,"d"),b._nextDay=void 0),b}function Ga(a){var b=a._i,e=a._f;return a._locale=a._locale||H(a._l),null===b||void 0===e&&""===b?l({nullInput:!0}):("string"==typeof b&&(a._i=b=a._locale.preparse(b)),p(b)?new o(la(b)):(c(e)?Da(a):e?Ba(a):d(b)?a._d=b:Ha(a),k(a)||(a._d=null),a))}function Ha(b){var f=b._i;void 0===f?b._d=new Date(a.now()):d(f)?b._d=new Date(+f):"string"==typeof f?na(b):c(f)?(b._a=e(f.slice(0),function(a){return parseInt(a,10)}),za(b)):"object"==typeof f?Ea(b):"number"==typeof f?b._d=new Date(f):a.createFromInputFallback(b)}function Ia(a,b,c,d,e){var f={};return"boolean"==typeof c&&(d=c,c=void 0),f._isAMomentObject=!0,f._useUTC=f._isUTC=e,f._l=c,f._i=a,f._f=b,f._strict=d,Fa(f)}function Ja(a,b,c,d){return Ia(a,b,c,d,!1)}function Ka(a,b){var d,e;if(1===b.length&&c(b[0])&&(b=b[0]),!b.length)return Ja();for(d=b[0],e=1;e<b.length;++e)(!b[e].isValid()||b[e][a](d))&&(d=b[e]);return d}function La(){var a=[].slice.call(arguments,0);return Ka("isBefore",a)}function Ma(){var a=[].slice.call(arguments,0);return Ka("isAfter",a)}function Na(a){var b=L(a),c=b.year||0,d=b.quarter||0,e=b.month||0,f=b.week||0,g=b.day||0,h=b.hour||0,i=b.minute||0,j=b.second||0,k=b.millisecond||0;this._milliseconds=+k+1e3*j+6e4*i+36e5*h,this._days=+g+7*f,this._months=+e+3*d+12*c,this._data={},this._locale=H(),this._bubble()}function Oa(a){return a instanceof Na}function Pa(a,b){R(a,0,0,function(){var a=this.utcOffset(),c="+";return 0>a&&(a=-a,c="-"),c+Q(~~(a/60),2)+b+Q(~~a%60,2)})}function Qa(a,b){var c=(b||"").match(a)||[],d=c[c.length-1]||[],e=(d+"").match(Zd)||["-",0,0],f=+(60*e[1])+r(e[2]);return"+"===e[0]?f:-f}function Ra(b,c){var e,f;return c._isUTC?(e=c.clone(),f=(p(b)||d(b)?+b:+Ja(b))-+e,e._d.setTime(+e._d+f),a.updateOffset(e,!1),e):Ja(b).local()}function Sa(a){return 15*-Math.round(a._d.getTimezoneOffset()/15)}function Ta(b,c){var d,e=this._offset||0;return this.isValid()?null!=b?("string"==typeof b?b=Qa(wd,b):Math.abs(b)<16&&(b=60*b),!this._isUTC&&c&&(d=Sa(this)),this._offset=b,this._isUTC=!0,null!=d&&this.add(d,"m"),e!==b&&(!c||this._changeInProgress?ib(this,cb(b-e,"m"),1,!1):this._changeInProgress||(this._changeInProgress=!0,a.updateOffset(this,!0),this._changeInProgress=null)),this):this._isUTC?e:Sa(this):null!=b?this:NaN}function Ua(a,b){return null!=a?("string"!=typeof a&&(a=-a),this.utcOffset(a,b),this):-this.utcOffset()}function Va(a){return this.utcOffset(0,a)}function Wa(a){return this._isUTC&&(this.utcOffset(0,a),this._isUTC=!1,a&&this.subtract(Sa(this),"m")),this}function Xa(){return this._tzm?this.utcOffset(this._tzm):"string"==typeof this._i&&this.utcOffset(Qa(vd,this._i)),this}function Ya(a){return this.isValid()?(a=a?Ja(a).utcOffset():0,(this.utcOffset()-a)%60===0):!1}function Za(){return this.utcOffset()>this.clone().month(0).utcOffset()||this.utcOffset()>this.clone().month(5).utcOffset()}function $a(){if(!m(this._isDSTShifted))return this._isDSTShifted;var a={};if(n(a,this),a=Ga(a),a._a){var b=a._isUTC?h(a._a):Ja(a._a);this._isDSTShifted=this.isValid()&&s(a._a,b.toArray())>0}else this._isDSTShifted=!1;return this._isDSTShifted}function _a(){return this.isValid()?!this._isUTC:!1}function ab(){return this.isValid()?this._isUTC:!1}function bb(){return this.isValid()?this._isUTC&&0===this._offset:!1}function cb(a,b){var c,d,e,g=a,h=null;return Oa(a)?g={ms:a._milliseconds,d:a._days,M:a._months}:"number"==typeof a?(g={},b?g[b]=a:g.milliseconds=a):(h=$d.exec(a))?(c="-"===h[1]?-1:1,g={y:0,d:r(h[Dd])*c,h:r(h[Ed])*c,m:r(h[Fd])*c,s:r(h[Gd])*c,ms:r(h[Hd])*c}):(h=_d.exec(a))?(c="-"===h[1]?-1:1,g={y:db(h[2],c),M:db(h[3],c),w:db(h[4],c),d:db(h[5],c),h:db(h[6],c),m:db(h[7],c),s:db(h[8],c)}):null==g?g={}:"object"==typeof g&&("from"in g||"to"in g)&&(e=fb(Ja(g.from),Ja(g.to)),g={},g.ms=e.milliseconds,g.M=e.months),d=new Na(g),Oa(a)&&f(a,"_locale")&&(d._locale=a._locale),d}function db(a,b){var c=a&&parseFloat(a.replace(",","."));return(isNaN(c)?0:c)*b}function eb(a,b){var c={milliseconds:0,months:0};return c.months=b.month()-a.month()+12*(b.year()-a.year()),a.clone().add(c.months,"M").isAfter(b)&&--c.months,c.milliseconds=+b-+a.clone().add(c.months,"M"),c}function fb(a,b){var c;return a.isValid()&&b.isValid()?(b=Ra(b,a),a.isBefore(b)?c=eb(a,b):(c=eb(b,a),c.milliseconds=-c.milliseconds,c.months=-c.months),c):{milliseconds:0,months:0}}function gb(a){return 0>a?-1*Math.round(-1*a):Math.round(a)}function hb(a,b){return function(c,d){var e,f;return null===d||isNaN(+d)||(v(b,"moment()."+b+"(period, number) is deprecated. Please use moment()."+b+"(number, period)."),f=c,c=d,d=f),c="string"==typeof c?+c:c,e=cb(c,d),ib(this,e,a),this}}function ib(b,c,d,e){var f=c._milliseconds,g=gb(c._days),h=gb(c._months);b.isValid()&&(e=null==e?!0:e,f&&b._d.setTime(+b._d+f*d),g&&O(b,"Date",N(b,"Date")+g*d),h&&fa(b,N(b,"Month")+h*d),e&&a.updateOffset(b,g||h))}function jb(a,b){var c=a||Ja(),d=Ra(c,this).startOf("day"),e=this.diff(d,"days",!0),f=-6>e?"sameElse":-1>e?"lastWeek":0>e?"lastDay":1>e?"sameDay":2>e?"nextDay":7>e?"nextWeek":"sameElse",g=b&&(w(b[f])?b[f]():b[f]);return this.format(g||this.localeData().calendar(f,this,Ja(c)))}function kb(){return new o(this)}function lb(a,b){var c=p(a)?a:Ja(a);return this.isValid()&&c.isValid()?(b=K(m(b)?"millisecond":b),"millisecond"===b?+this>+c:+c<+this.clone().startOf(b)):!1}function mb(a,b){var c=p(a)?a:Ja(a);return this.isValid()&&c.isValid()?(b=K(m(b)?"millisecond":b),"millisecond"===b?+c>+this:+this.clone().endOf(b)<+c):!1}function nb(a,b,c){return this.isAfter(a,c)&&this.isBefore(b,c)}function ob(a,b){var c,d=p(a)?a:Ja(a);return this.isValid()&&d.isValid()?(b=K(b||"millisecond"),"millisecond"===b?+this===+d:(c=+d,+this.clone().startOf(b)<=c&&c<=+this.clone().endOf(b))):!1}function pb(a,b){return this.isSame(a,b)||this.isAfter(a,b)}function qb(a,b){return this.isSame(a,b)||this.isBefore(a,b)}function rb(a,b,c){var d,e,f,g;return this.isValid()?(d=Ra(a,this),d.isValid()?(e=6e4*(d.utcOffset()-this.utcOffset()),b=K(b),"year"===b||"month"===b||"quarter"===b?(g=sb(this,d),"quarter"===b?g/=3:"year"===b&&(g/=12)):(f=this-d,g="second"===b?f/1e3:"minute"===b?f/6e4:"hour"===b?f/36e5:"day"===b?(f-e)/864e5:"week"===b?(f-e)/6048e5:f),c?g:q(g)):NaN):NaN}function sb(a,b){var c,d,e=12*(b.year()-a.year())+(b.month()-a.month()),f=a.clone().add(e,"months");return 0>b-f?(c=a.clone().add(e-1,"months"),d=(b-f)/(f-c)):(c=a.clone().add(e+1,"months"),d=(b-f)/(c-f)),-(e+d)}function tb(){return this.clone().locale("en").format("ddd MMM DD YYYY HH:mm:ss [GMT]ZZ")}function ub(){var a=this.clone().utc();return 0<a.year()&&a.year()<=9999?w(Date.prototype.toISOString)?this.toDate().toISOString():U(a,"YYYY-MM-DD[T]HH:mm:ss.SSS[Z]"):U(a,"YYYYYY-MM-DD[T]HH:mm:ss.SSS[Z]")}function vb(b){var c=U(this,b||a.defaultFormat);return this.localeData().postformat(c)}function wb(a,b){return this.isValid()&&(p(a)&&a.isValid()||Ja(a).isValid())?cb({to:this,from:a}).locale(this.locale()).humanize(!b):this.localeData().invalidDate()}function xb(a){return this.from(Ja(),a)}function yb(a,b){return this.isValid()&&(p(a)&&a.isValid()||Ja(a).isValid())?cb({from:this,to:a}).locale(this.locale()).humanize(!b):this.localeData().invalidDate()}function zb(a){return this.to(Ja(),a)}function Ab(a){var b;return void 0===a?this._locale._abbr:(b=H(a),null!=b&&(this._locale=b),this)}function Bb(){return this._locale}function Cb(a){switch(a=K(a)){case"year":this.month(0);case"quarter":case"month":this.date(1);case"week":case"isoWeek":case"day":this.hours(0);case"hour":this.minutes(0);case"minute":this.seconds(0);case"second":this.milliseconds(0)}return"week"===a&&this.weekday(0),"isoWeek"===a&&this.isoWeekday(1),"quarter"===a&&this.month(3*Math.floor(this.month()/3)),this}function Db(a){return a=K(a),void 0===a||"millisecond"===a?this:this.startOf(a).add(1,"isoWeek"===a?"week":a).subtract(1,"ms")}function Eb(){return+this._d-6e4*(this._offset||0)}function Fb(){return Math.floor(+this/1e3)}function Gb(){return this._offset?new Date(+this):this._d}function Hb(){var a=this;return[a.year(),a.month(),a.date(),a.hour(),a.minute(),a.second(),a.millisecond()]}function Ib(){var a=this;return{years:a.year(),months:a.month(),date:a.date(),hours:a.hours(),minutes:a.minutes(),seconds:a.seconds(),milliseconds:a.milliseconds()}}function Jb(){return this.isValid()?this.toISOString():null}function Kb(){return k(this)}function Lb(){return g({},j(this))}function Mb(){return j(this).overflow}function Nb(){return{input:this._i,format:this._f,locale:this._locale,isUTC:this._isUTC,strict:this._strict}}function Ob(a,b){R(0,[a,a.length],0,b)}function Pb(a){return Tb.call(this,a,this.week(),this.weekday(),this.localeData()._week.dow,this.localeData()._week.doy)}function Qb(a){return Tb.call(this,a,this.isoWeek(),this.isoWeekday(),1,4)}function Rb(){return wa(this.year(),1,4)}function Sb(){var a=this.localeData()._week;return wa(this.year(),a.dow,a.doy)}function Tb(a,b,c,d,e){var f;return null==a?va(this,d,e).year:(f=wa(a,d,e),b>f&&(b=f),Ub.call(this,a,b,c,d,e))}function Ub(a,b,c,d,e){var f=ua(a,b,c,d,e),g=pa(f.year,0,f.dayOfYear);return this.year(g.getUTCFullYear()),this.month(g.getUTCMonth()),this.date(g.getUTCDate()),this}function Vb(a){return null==a?Math.ceil((this.month()+1)/3):this.month(3*(a-1)+this.month()%3)}function Wb(a){return va(a,this._week.dow,this._week.doy).week}function Xb(){return this._week.dow}function Yb(){return this._week.doy}function Zb(a){var b=this.localeData().week(this);return null==a?b:this.add(7*(a-b),"d")}function $b(a){var b=va(this,1,4).week;return null==a?b:this.add(7*(a-b),"d")}function _b(a,b){return"string"!=typeof a?a:isNaN(a)?(a=b.weekdaysParse(a),"number"==typeof a?a:null):parseInt(a,10)}function ac(a,b){return c(this._weekdays)?this._weekdays[a.day()]:this._weekdays[this._weekdays.isFormat.test(b)?"format":"standalone"][a.day()]}function bc(a){return this._weekdaysShort[a.day()]}function cc(a){return this._weekdaysMin[a.day()]}function dc(a,b,c){var d,e,f;for(this._weekdaysParse||(this._weekdaysParse=[],this._minWeekdaysParse=[],this._shortWeekdaysParse=[],this._fullWeekdaysParse=[]),d=0;7>d;d++){if(e=Ja([2e3,1]).day(d),c&&!this._fullWeekdaysParse[d]&&(this._fullWeekdaysParse[d]=new RegExp("^"+this.weekdays(e,"").replace(".",".?")+"$","i"),this._shortWeekdaysParse[d]=new RegExp("^"+this.weekdaysShort(e,"").replace(".",".?")+"$","i"),this._minWeekdaysParse[d]=new RegExp("^"+this.weekdaysMin(e,"").replace(".",".?")+"$","i")),this._weekdaysParse[d]||(f="^"+this.weekdays(e,"")+"|^"+this.weekdaysShort(e,"")+"|^"+this.weekdaysMin(e,""),this._weekdaysParse[d]=new RegExp(f.replace(".",""),"i")),c&&"dddd"===b&&this._fullWeekdaysParse[d].test(a))return d;if(c&&"ddd"===b&&this._shortWeekdaysParse[d].test(a))return d;if(c&&"dd"===b&&this._minWeekdaysParse[d].test(a))return d;if(!c&&this._weekdaysParse[d].test(a))return d}}function ec(a){if(!this.isValid())return null!=a?this:NaN;var b=this._isUTC?this._d.getUTCDay():this._d.getDay();return null!=a?(a=_b(a,this.localeData()),this.add(a-b,"d")):b}function fc(a){if(!this.isValid())return null!=a?this:NaN;var b=(this.day()+7-this.localeData()._week.dow)%7;return null==a?b:this.add(a-b,"d")}function gc(a){return this.isValid()?null==a?this.day()||7:this.day(this.day()%7?a:a-7):null!=a?this:NaN}function hc(a){var b=Math.round((this.clone().startOf("day")-this.clone().startOf("year"))/864e5)+1;return null==a?b:this.add(a-b,"d")}function ic(){return this.hours()%12||12}function jc(a,b){R(a,0,0,function(){return this.localeData().meridiem(this.hours(),this.minutes(),b)})}function kc(a,b){return b._meridiemParse}function lc(a){return"p"===(a+"").toLowerCase().charAt(0)}function mc(a,b,c){return a>11?c?"pm":"PM":c?"am":"AM"}function nc(a,b){b[Hd]=r(1e3*("0."+a))}function oc(){return this._isUTC?"UTC":""}function pc(){return this._isUTC?"Coordinated Universal Time":""}function qc(a){return Ja(1e3*a)}function rc(){return Ja.apply(null,arguments).parseZone()}function sc(a,b,c){var d=this._calendar[a];return w(d)?d.call(b,c):d}function tc(a){var b=this._longDateFormat[a],c=this._longDateFormat[a.toUpperCase()];return b||!c?b:(this._longDateFormat[a]=c.replace(/MMMM|MM|DD|dddd/g,function(a){return a.slice(1)}),this._longDateFormat[a])}function uc(){return this._invalidDate}function vc(a){return this._ordinal.replace("%d",a)}function wc(a){return a}function xc(a,b,c,d){var e=this._relativeTime[c];return w(e)?e(a,b,c,d):e.replace(/%d/i,a)}function yc(a,b){var c=this._relativeTime[a>0?"future":"past"];return w(c)?c(b):c.replace(/%s/i,b)}function zc(a,b,c,d){var e=H(),f=h().set(d,b);return e[c](f,a)}function Ac(a,b,c,d,e){if("number"==typeof a&&(b=a,a=void 0),a=a||"",null!=b)return zc(a,b,c,e);var f,g=[];for(f=0;d>f;f++)g[f]=zc(a,f,c,e);return g}function Bc(a,b){return Ac(a,b,"months",12,"month")}function Cc(a,b){return Ac(a,b,"monthsShort",12,"month")}function Dc(a,b){return Ac(a,b,"weekdays",7,"day")}function Ec(a,b){return Ac(a,b,"weekdaysShort",7,"day")}function Fc(a,b){return Ac(a,b,"weekdaysMin",7,"day")}function Gc(){var a=this._data;return this._milliseconds=xe(this._milliseconds),this._days=xe(this._days),this._months=xe(this._months),a.milliseconds=xe(a.milliseconds),a.seconds=xe(a.seconds),a.minutes=xe(a.minutes),a.hours=xe(a.hours),a.months=xe(a.months),a.years=xe(a.years),this}function Hc(a,b,c,d){var e=cb(b,c);return a._milliseconds+=d*e._milliseconds,a._days+=d*e._days,a._months+=d*e._months,a._bubble()}function Ic(a,b){return Hc(this,a,b,1)}function Jc(a,b){return Hc(this,a,b,-1)}function Kc(a){return 0>a?Math.floor(a):Math.ceil(a)}function Lc(){var a,b,c,d,e,f=this._milliseconds,g=this._days,h=this._months,i=this._data;return f>=0&&g>=0&&h>=0||0>=f&&0>=g&&0>=h||(f+=864e5*Kc(Nc(h)+g),g=0,h=0),i.milliseconds=f%1e3,a=q(f/1e3),i.seconds=a%60,b=q(a/60),i.minutes=b%60,c=q(b/60),i.hours=c%24,g+=q(c/24),e=q(Mc(g)),h+=e,g-=Kc(Nc(e)),d=q(h/12),h%=12,i.days=g,i.months=h,i.years=d,this}function Mc(a){return 4800*a/146097}function Nc(a){return 146097*a/4800}function Oc(a){var b,c,d=this._milliseconds;if(a=K(a),"month"===a||"year"===a)return b=this._days+d/864e5,c=this._months+Mc(b),"month"===a?c:c/12;switch(b=this._days+Math.round(Nc(this._months)),a){case"week":return b/7+d/6048e5;case"day":return b+d/864e5;case"hour":return 24*b+d/36e5;case"minute":return 1440*b+d/6e4;case"second":return 86400*b+d/1e3;case"millisecond":return Math.floor(864e5*b)+d;default:throw new Error("Unknown unit "+a)}}function Pc(){return this._milliseconds+864e5*this._days+this._months%12*2592e6+31536e6*r(this._months/12)}function Qc(a){return function(){return this.as(a)}}function Rc(a){return a=K(a),this[a+"s"]()}function Sc(a){return function(){return this._data[a]}}function Tc(){return q(this.days()/7)}function Uc(a,b,c,d,e){return e.relativeTime(b||1,!!c,a,d)}function Vc(a,b,c){var d=cb(a).abs(),e=Ne(d.as("s")),f=Ne(d.as("m")),g=Ne(d.as("h")),h=Ne(d.as("d")),i=Ne(d.as("M")),j=Ne(d.as("y")),k=e<Oe.s&&["s",e]||1>=f&&["m"]||f<Oe.m&&["mm",f]||1>=g&&["h"]||g<Oe.h&&["hh",g]||1>=h&&["d"]||h<Oe.d&&["dd",h]||1>=i&&["M"]||i<Oe.M&&["MM",i]||1>=j&&["y"]||["yy",j];return k[2]=b,k[3]=+a>0,k[4]=c,Uc.apply(null,k)}function Wc(a,b){return void 0===Oe[a]?!1:void 0===b?Oe[a]:(Oe[a]=b,!0)}function Xc(a){var b=this.localeData(),c=Vc(this,!a,b);return a&&(c=b.pastFuture(+this,c)),b.postformat(c)}function Yc(){var a,b,c,d=Pe(this._milliseconds)/1e3,e=Pe(this._days),f=Pe(this._months);a=q(d/60),b=q(a/60),d%=60,a%=60,c=q(f/12),f%=12;var g=c,h=f,i=e,j=b,k=a,l=d,m=this.asSeconds();return m?(0>m?"-":"")+"P"+(g?g+"Y":"")+(h?h+"M":"")+(i?i+"D":"")+(j||k||l?"T":"")+(j?j+"H":"")+(k?k+"M":"")+(l?l+"S":""):"P0D"}var Zc,$c=a.momentProperties=[],_c=!1,ad={};a.suppressDeprecationWarnings=!1;var bd,cd={},dd={},ed=/(\[[^\[]*\])|(\\)?([Hh]mm(ss)?|Mo|MM?M?M?|Do|DDDo|DD?D?D?|ddd?d?|do?|w[o|w]?|W[o|W]?|Qo?|YYYYYY|YYYYY|YYYY|YY|gg(ggg?)?|GG(GGG?)?|e|E|a|A|hh?|HH?|mm?|ss?|S{1,9}|x|X|zz?|ZZ?|.)/g,fd=/(\[[^\[]*\])|(\\)?(LTS|LT|LL?L?L?|l{1,4})/g,gd={},hd={},id=/\d/,jd=/\d\d/,kd=/\d{3}/,ld=/\d{4}/,md=/[+-]?\d{6}/,nd=/\d\d?/,od=/\d\d\d\d?/,pd=/\d\d\d\d\d\d?/,qd=/\d{1,3}/,rd=/\d{1,4}/,sd=/[+-]?\d{1,6}/,td=/\d+/,ud=/[+-]?\d+/,vd=/Z|[+-]\d\d:?\d\d/gi,wd=/Z|[+-]\d\d(?::?\d\d)?/gi,xd=/[+-]?\d+(\.\d{1,3})?/,yd=/[0-9]*['a-z\u00A0-\u05FF\u0700-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]+|[\u0600-\u06FF\/]+(\s*?[\u0600-\u06FF]+){1,2}/i,zd={},Ad={},Bd=0,Cd=1,Dd=2,Ed=3,Fd=4,Gd=5,Hd=6,Id=7,Jd=8;R("M",["MM",2],"Mo",function(){return this.month()+1}),R("MMM",0,0,function(a){return this.localeData().monthsShort(this,a)}),R("MMMM",0,0,function(a){return this.localeData().months(this,a)}),J("month","M"),W("M",nd),W("MM",nd,jd),W("MMM",function(a,b){return b.monthsShortRegex(a)}),W("MMMM",function(a,b){return b.monthsRegex(a)}),$(["M","MM"],function(a,b){b[Cd]=r(a)-1}),$(["MMM","MMMM"],function(a,b,c,d){var e=c._locale.monthsParse(a,d,c._strict);null!=e?b[Cd]=e:j(c).invalidMonth=a});var Kd=/D[oD]?(\[[^\[\]]*\]|\s+)+MMMM?/,Ld="January_February_March_April_May_June_July_August_September_October_November_December".split("_"),Md="Jan_Feb_Mar_Apr_May_Jun_Jul_Aug_Sep_Oct_Nov_Dec".split("_"),Nd=yd,Od=yd,Pd=/^\s*((?:[+-]\d{6}|\d{4})-(?:\d\d-\d\d|W\d\d-\d|W\d\d|\d\d\d|\d\d))(?:(T| )(\d\d(?::\d\d(?::\d\d(?:[.,]\d+)?)?)?)([\+\-]\d\d(?::?\d\d)?|\s*Z)?)?/,Qd=/^\s*((?:[+-]\d{6}|\d{4})(?:\d\d\d\d|W\d\d\d|W\d\d|\d\d\d|\d\d))(?:(T| )(\d\d(?:\d\d(?:\d\d(?:[.,]\d+)?)?)?)([\+\-]\d\d(?::?\d\d)?|\s*Z)?)?/,Rd=/Z|[+-]\d\d(?::?\d\d)?/,Sd=[["YYYYYY-MM-DD",/[+-]\d{6}-\d\d-\d\d/],["YYYY-MM-DD",/\d{4}-\d\d-\d\d/],["GGGG-[W]WW-E",/\d{4}-W\d\d-\d/],["GGGG-[W]WW",/\d{4}-W\d\d/,!1],["YYYY-DDD",/\d{4}-\d{3}/],["YYYY-MM",/\d{4}-\d\d/,!1],["YYYYYYMMDD",/[+-]\d{10}/],["YYYYMMDD",/\d{8}/],["GGGG[W]WWE",/\d{4}W\d{3}/],["GGGG[W]WW",/\d{4}W\d{2}/,!1],["YYYYDDD",/\d{7}/]],Td=[["HH:mm:ss.SSSS",/\d\d:\d\d:\d\d\.\d+/],["HH:mm:ss,SSSS",/\d\d:\d\d:\d\d,\d+/],["HH:mm:ss",/\d\d:\d\d:\d\d/],["HH:mm",/\d\d:\d\d/],["HHmmss.SSSS",/\d\d\d\d\d\d\.\d+/],["HHmmss,SSSS",/\d\d\d\d\d\d,\d+/],["HHmmss",/\d\d\d\d\d\d/],["HHmm",/\d\d\d\d/],["HH",/\d\d/]],Ud=/^\/?Date\((\-?\d+)/i;a.createFromInputFallback=u("moment construction falls back to js Date. This is discouraged and will be removed in upcoming major release. Please refer to https://github.com/moment/moment/issues/1407 for more info.",function(a){a._d=new Date(a._i+(a._useUTC?" UTC":""))}),R("Y",0,0,function(){var a=this.year();return 9999>=a?""+a:"+"+a}),R(0,["YY",2],0,function(){return this.year()%100}),R(0,["YYYY",4],0,"year"),R(0,["YYYYY",5],0,"year"),R(0,["YYYYYY",6,!0],0,"year"),J("year","y"),W("Y",ud),W("YY",nd,jd),W("YYYY",rd,ld),W("YYYYY",sd,md),W("YYYYYY",sd,md),$(["YYYYY","YYYYYY"],Bd),$("YYYY",function(b,c){c[Bd]=2===b.length?a.parseTwoDigitYear(b):r(b);
}),$("YY",function(b,c){c[Bd]=a.parseTwoDigitYear(b)}),$("Y",function(a,b){b[Bd]=parseInt(a,10)}),a.parseTwoDigitYear=function(a){return r(a)+(r(a)>68?1900:2e3)};var Vd=M("FullYear",!1);a.ISO_8601=function(){};var Wd=u("moment().min is deprecated, use moment.max instead. https://github.com/moment/moment/issues/1548",function(){var a=Ja.apply(null,arguments);return this.isValid()&&a.isValid()?this>a?this:a:l()}),Xd=u("moment().max is deprecated, use moment.min instead. https://github.com/moment/moment/issues/1548",function(){var a=Ja.apply(null,arguments);return this.isValid()&&a.isValid()?a>this?this:a:l()}),Yd=function(){return Date.now?Date.now():+new Date};Pa("Z",":"),Pa("ZZ",""),W("Z",wd),W("ZZ",wd),$(["Z","ZZ"],function(a,b,c){c._useUTC=!0,c._tzm=Qa(wd,a)});var Zd=/([\+\-]|\d\d)/gi;a.updateOffset=function(){};var $d=/^(\-)?(?:(\d*)[. ])?(\d+)\:(\d+)(?:\:(\d+)\.?(\d{3})?\d*)?$/,_d=/^(-)?P(?:([0-9,.]*)Y)?(?:([0-9,.]*)M)?(?:([0-9,.]*)W)?(?:([0-9,.]*)D)?(?:T(?:([0-9,.]*)H)?(?:([0-9,.]*)M)?(?:([0-9,.]*)S)?)?$/;cb.fn=Na.prototype;var ae=hb(1,"add"),be=hb(-1,"subtract");a.defaultFormat="YYYY-MM-DDTHH:mm:ssZ";var ce=u("moment().lang() is deprecated. Instead, use moment().localeData() to get the language configuration. Use moment().locale() to change languages.",function(a){return void 0===a?this.localeData():this.locale(a)});R(0,["gg",2],0,function(){return this.weekYear()%100}),R(0,["GG",2],0,function(){return this.isoWeekYear()%100}),Ob("gggg","weekYear"),Ob("ggggg","weekYear"),Ob("GGGG","isoWeekYear"),Ob("GGGGG","isoWeekYear"),J("weekYear","gg"),J("isoWeekYear","GG"),W("G",ud),W("g",ud),W("GG",nd,jd),W("gg",nd,jd),W("GGGG",rd,ld),W("gggg",rd,ld),W("GGGGG",sd,md),W("ggggg",sd,md),_(["gggg","ggggg","GGGG","GGGGG"],function(a,b,c,d){b[d.substr(0,2)]=r(a)}),_(["gg","GG"],function(b,c,d,e){c[e]=a.parseTwoDigitYear(b)}),R("Q",0,"Qo","quarter"),J("quarter","Q"),W("Q",id),$("Q",function(a,b){b[Cd]=3*(r(a)-1)}),R("w",["ww",2],"wo","week"),R("W",["WW",2],"Wo","isoWeek"),J("week","w"),J("isoWeek","W"),W("w",nd),W("ww",nd,jd),W("W",nd),W("WW",nd,jd),_(["w","ww","W","WW"],function(a,b,c,d){b[d.substr(0,1)]=r(a)});var de={dow:0,doy:6};R("D",["DD",2],"Do","date"),J("date","D"),W("D",nd),W("DD",nd,jd),W("Do",function(a,b){return a?b._ordinalParse:b._ordinalParseLenient}),$(["D","DD"],Dd),$("Do",function(a,b){b[Dd]=r(a.match(nd)[0],10)});var ee=M("Date",!0);R("d",0,"do","day"),R("dd",0,0,function(a){return this.localeData().weekdaysMin(this,a)}),R("ddd",0,0,function(a){return this.localeData().weekdaysShort(this,a)}),R("dddd",0,0,function(a){return this.localeData().weekdays(this,a)}),R("e",0,0,"weekday"),R("E",0,0,"isoWeekday"),J("day","d"),J("weekday","e"),J("isoWeekday","E"),W("d",nd),W("e",nd),W("E",nd),W("dd",yd),W("ddd",yd),W("dddd",yd),_(["dd","ddd","dddd"],function(a,b,c,d){var e=c._locale.weekdaysParse(a,d,c._strict);null!=e?b.d=e:j(c).invalidWeekday=a}),_(["d","e","E"],function(a,b,c,d){b[d]=r(a)});var fe="Sunday_Monday_Tuesday_Wednesday_Thursday_Friday_Saturday".split("_"),ge="Sun_Mon_Tue_Wed_Thu_Fri_Sat".split("_"),he="Su_Mo_Tu_We_Th_Fr_Sa".split("_");R("DDD",["DDDD",3],"DDDo","dayOfYear"),J("dayOfYear","DDD"),W("DDD",qd),W("DDDD",kd),$(["DDD","DDDD"],function(a,b,c){c._dayOfYear=r(a)}),R("H",["HH",2],0,"hour"),R("h",["hh",2],0,ic),R("hmm",0,0,function(){return""+ic.apply(this)+Q(this.minutes(),2)}),R("hmmss",0,0,function(){return""+ic.apply(this)+Q(this.minutes(),2)+Q(this.seconds(),2)}),R("Hmm",0,0,function(){return""+this.hours()+Q(this.minutes(),2)}),R("Hmmss",0,0,function(){return""+this.hours()+Q(this.minutes(),2)+Q(this.seconds(),2)}),jc("a",!0),jc("A",!1),J("hour","h"),W("a",kc),W("A",kc),W("H",nd),W("h",nd),W("HH",nd,jd),W("hh",nd,jd),W("hmm",od),W("hmmss",pd),W("Hmm",od),W("Hmmss",pd),$(["H","HH"],Ed),$(["a","A"],function(a,b,c){c._isPm=c._locale.isPM(a),c._meridiem=a}),$(["h","hh"],function(a,b,c){b[Ed]=r(a),j(c).bigHour=!0}),$("hmm",function(a,b,c){var d=a.length-2;b[Ed]=r(a.substr(0,d)),b[Fd]=r(a.substr(d)),j(c).bigHour=!0}),$("hmmss",function(a,b,c){var d=a.length-4,e=a.length-2;b[Ed]=r(a.substr(0,d)),b[Fd]=r(a.substr(d,2)),b[Gd]=r(a.substr(e)),j(c).bigHour=!0}),$("Hmm",function(a,b,c){var d=a.length-2;b[Ed]=r(a.substr(0,d)),b[Fd]=r(a.substr(d))}),$("Hmmss",function(a,b,c){var d=a.length-4,e=a.length-2;b[Ed]=r(a.substr(0,d)),b[Fd]=r(a.substr(d,2)),b[Gd]=r(a.substr(e))});var ie=/[ap]\.?m?\.?/i,je=M("Hours",!0);R("m",["mm",2],0,"minute"),J("minute","m"),W("m",nd),W("mm",nd,jd),$(["m","mm"],Fd);var ke=M("Minutes",!1);R("s",["ss",2],0,"second"),J("second","s"),W("s",nd),W("ss",nd,jd),$(["s","ss"],Gd);var le=M("Seconds",!1);R("S",0,0,function(){return~~(this.millisecond()/100)}),R(0,["SS",2],0,function(){return~~(this.millisecond()/10)}),R(0,["SSS",3],0,"millisecond"),R(0,["SSSS",4],0,function(){return 10*this.millisecond()}),R(0,["SSSSS",5],0,function(){return 100*this.millisecond()}),R(0,["SSSSSS",6],0,function(){return 1e3*this.millisecond()}),R(0,["SSSSSSS",7],0,function(){return 1e4*this.millisecond()}),R(0,["SSSSSSSS",8],0,function(){return 1e5*this.millisecond()}),R(0,["SSSSSSSSS",9],0,function(){return 1e6*this.millisecond()}),J("millisecond","ms"),W("S",qd,id),W("SS",qd,jd),W("SSS",qd,kd);var me;for(me="SSSS";me.length<=9;me+="S")W(me,td);for(me="S";me.length<=9;me+="S")$(me,nc);var ne=M("Milliseconds",!1);R("z",0,0,"zoneAbbr"),R("zz",0,0,"zoneName");var oe=o.prototype;oe.add=ae,oe.calendar=jb,oe.clone=kb,oe.diff=rb,oe.endOf=Db,oe.format=vb,oe.from=wb,oe.fromNow=xb,oe.to=yb,oe.toNow=zb,oe.get=P,oe.invalidAt=Mb,oe.isAfter=lb,oe.isBefore=mb,oe.isBetween=nb,oe.isSame=ob,oe.isSameOrAfter=pb,oe.isSameOrBefore=qb,oe.isValid=Kb,oe.lang=ce,oe.locale=Ab,oe.localeData=Bb,oe.max=Xd,oe.min=Wd,oe.parsingFlags=Lb,oe.set=P,oe.startOf=Cb,oe.subtract=be,oe.toArray=Hb,oe.toObject=Ib,oe.toDate=Gb,oe.toISOString=ub,oe.toJSON=Jb,oe.toString=tb,oe.unix=Fb,oe.valueOf=Eb,oe.creationData=Nb,oe.year=Vd,oe.isLeapYear=sa,oe.weekYear=Pb,oe.isoWeekYear=Qb,oe.quarter=oe.quarters=Vb,oe.month=ga,oe.daysInMonth=ha,oe.week=oe.weeks=Zb,oe.isoWeek=oe.isoWeeks=$b,oe.weeksInYear=Sb,oe.isoWeeksInYear=Rb,oe.date=ee,oe.day=oe.days=ec,oe.weekday=fc,oe.isoWeekday=gc,oe.dayOfYear=hc,oe.hour=oe.hours=je,oe.minute=oe.minutes=ke,oe.second=oe.seconds=le,oe.millisecond=oe.milliseconds=ne,oe.utcOffset=Ta,oe.utc=Va,oe.local=Wa,oe.parseZone=Xa,oe.hasAlignedHourOffset=Ya,oe.isDST=Za,oe.isDSTShifted=$a,oe.isLocal=_a,oe.isUtcOffset=ab,oe.isUtc=bb,oe.isUTC=bb,oe.zoneAbbr=oc,oe.zoneName=pc,oe.dates=u("dates accessor is deprecated. Use date instead.",ee),oe.months=u("months accessor is deprecated. Use month instead",ga),oe.years=u("years accessor is deprecated. Use year instead",Vd),oe.zone=u("moment().zone is deprecated, use moment().utcOffset instead. https://github.com/moment/moment/issues/1779",Ua);var pe=oe,qe={sameDay:"[Today at] LT",nextDay:"[Tomorrow at] LT",nextWeek:"dddd [at] LT",lastDay:"[Yesterday at] LT",lastWeek:"[Last] dddd [at] LT",sameElse:"L"},re={LTS:"h:mm:ss A",LT:"h:mm A",L:"MM/DD/YYYY",LL:"MMMM D, YYYY",LLL:"MMMM D, YYYY h:mm A",LLLL:"dddd, MMMM D, YYYY h:mm A"},se="Invalid date",te="%d",ue=/\d{1,2}/,ve={future:"in %s",past:"%s ago",s:"a few seconds",m:"a minute",mm:"%d minutes",h:"an hour",hh:"%d hours",d:"a day",dd:"%d days",M:"a month",MM:"%d months",y:"a year",yy:"%d years"},we=A.prototype;we._calendar=qe,we.calendar=sc,we._longDateFormat=re,we.longDateFormat=tc,we._invalidDate=se,we.invalidDate=uc,we._ordinal=te,we.ordinal=vc,we._ordinalParse=ue,we.preparse=wc,we.postformat=wc,we._relativeTime=ve,we.relativeTime=xc,we.pastFuture=yc,we.set=y,we.months=ca,we._months=Ld,we.monthsShort=da,we._monthsShort=Md,we.monthsParse=ea,we._monthsRegex=Od,we.monthsRegex=ja,we._monthsShortRegex=Nd,we.monthsShortRegex=ia,we.week=Wb,we._week=de,we.firstDayOfYear=Yb,we.firstDayOfWeek=Xb,we.weekdays=ac,we._weekdays=fe,we.weekdaysMin=cc,we._weekdaysMin=he,we.weekdaysShort=bc,we._weekdaysShort=ge,we.weekdaysParse=dc,we.isPM=lc,we._meridiemParse=ie,we.meridiem=mc,E("en",{ordinalParse:/\d{1,2}(th|st|nd|rd)/,ordinal:function(a){var b=a%10,c=1===r(a%100/10)?"th":1===b?"st":2===b?"nd":3===b?"rd":"th";return a+c}}),a.lang=u("moment.lang is deprecated. Use moment.locale instead.",E),a.langData=u("moment.langData is deprecated. Use moment.localeData instead.",H);var xe=Math.abs,ye=Qc("ms"),ze=Qc("s"),Ae=Qc("m"),Be=Qc("h"),Ce=Qc("d"),De=Qc("w"),Ee=Qc("M"),Fe=Qc("y"),Ge=Sc("milliseconds"),He=Sc("seconds"),Ie=Sc("minutes"),Je=Sc("hours"),Ke=Sc("days"),Le=Sc("months"),Me=Sc("years"),Ne=Math.round,Oe={s:45,m:45,h:22,d:26,M:11},Pe=Math.abs,Qe=Na.prototype;Qe.abs=Gc,Qe.add=Ic,Qe.subtract=Jc,Qe.as=Oc,Qe.asMilliseconds=ye,Qe.asSeconds=ze,Qe.asMinutes=Ae,Qe.asHours=Be,Qe.asDays=Ce,Qe.asWeeks=De,Qe.asMonths=Ee,Qe.asYears=Fe,Qe.valueOf=Pc,Qe._bubble=Lc,Qe.get=Rc,Qe.milliseconds=Ge,Qe.seconds=He,Qe.minutes=Ie,Qe.hours=Je,Qe.days=Ke,Qe.weeks=Tc,Qe.months=Le,Qe.years=Me,Qe.humanize=Xc,Qe.toISOString=Yc,Qe.toString=Yc,Qe.toJSON=Yc,Qe.locale=Ab,Qe.localeData=Bb,Qe.toIsoString=u("toIsoString() is deprecated. Please use toISOString() instead (notice the capitals)",Yc),Qe.lang=ce,R("X",0,0,"unix"),R("x",0,0,"valueOf"),W("x",ud),W("X",xd),$("X",function(a,b,c){c._d=new Date(1e3*parseFloat(a,10))}),$("x",function(a,b,c){c._d=new Date(r(a))}),a.version="2.12.0",b(Ja),a.fn=pe,a.min=La,a.max=Ma,a.now=Yd,a.utc=h,a.unix=qc,a.months=Bc,a.isDate=d,a.locale=E,a.invalid=l,a.duration=cb,a.isMoment=p,a.weekdays=Dc,a.parseZone=rc,a.localeData=H,a.isDuration=Oa,a.monthsShort=Cc,a.weekdaysMin=Fc,a.defineLocale=F,a.updateLocale=G,a.locales=I,a.weekdaysShort=Ec,a.normalizeUnits=K,a.relativeTimeThreshold=Wc,a.prototype=pe;var Re=a;return Re});;/*!
 * FullCalendar v2.7.3
 * Docs & License: http://fullcalendar.io/
 * (c) 2016 Adam Shaw
 */

(function (factory) {
    if (typeof define === 'function' && define.amd) {
        define(['jquery', 'moment'], factory);
    } else if (typeof exports === 'object') { // Node/CommonJS
        module.exports = factory(require('jquery'), require('moment'));
    } else {
        factory(jQuery, moment);
    }
})(function ($, moment) {

    ;
    ;

    var FC = $.fullCalendar = {
        version: "2.7.3",
        internalApiVersion: 4
    };
    var fcViews = FC.views = {};


    $.fn.fullCalendar = function (options) {
        var args = Array.prototype.slice.call(arguments, 1); // for a possible method call
        var res = this; // what this function will return (this jQuery object by default)

        this.each(function (i, _element) { // loop each DOM element involved
            var element = $(_element);
            var calendar = element.data('fullCalendar'); // get the existing calendar object (if any)
            var singleRes; // the returned value of this single method call

            // a method call
            if (typeof options === 'string') {
                if (calendar && $.isFunction(calendar[options])) {
                    singleRes = calendar[options].apply(calendar, args);
                    if (!i) {
                        res = singleRes; // record the first method call result
                    }
                    if (options === 'destroy') { // for the destroy method, must remove Calendar object data
                        element.removeData('fullCalendar');
                    }
                }
            }
            // a new calendar initialization
            else if (!calendar) { // don't initialize twice
                calendar = new Calendar(element, options);
                element.data('fullCalendar', calendar);
                calendar.render();
            }
        });

        return res;
    };


    var complexOptions = [// names of options that are objects whose properties should be combined
        'header',
        'buttonText',
        'buttonIcons',
        'themeButtonIcons'
    ];


// Merges an array of option objects into a single object
    function mergeOptions(optionObjs) {
        return mergeProps(optionObjs, complexOptions);
    }


// Given options specified for the calendar's constructor, massages any legacy options into a non-legacy form.
// Converts View-Option-Hashes into the View-Specific-Options format.
    function massageOverrides(input) {
        var overrides = {views: input.views || {}}; // the output. ensure a `views` hash
        var subObj;

        // iterate through all option override properties (except `views`)
        $.each(input, function (name, val) {
            if (name != 'views') {

                // could the value be a legacy View-Option-Hash?
                if (
                    $.isPlainObject(val) &&
                    !/(time|duration|interval)$/i.test(name) && // exclude duration options. might be given as objects
                    $.inArray(name, complexOptions) == -1 // complex options aren't allowed to be View-Option-Hashes
                    ) {
                    subObj = null;

                    // iterate through the properties of this possible View-Option-Hash value
                    $.each(val, function (subName, subVal) {

                        // is the property targeting a view?
                        if (/^(month|week|day|default|basic(Week|Day)?|agenda(Week|Day)?)$/.test(subName)) {
                            if (!overrides.views[subName]) { // ensure the view-target entry exists
                                overrides.views[subName] = {};
                            }
                            overrides.views[subName][name] = subVal; // record the value in the `views` object
                        } else { // a non-View-Option-Hash property
                            if (!subObj) {
                                subObj = {};
                            }
                            subObj[subName] = subVal; // accumulate these unrelated values for later
                        }
                    });

                    if (subObj) { // non-View-Option-Hash properties? transfer them as-is
                        overrides[name] = subObj;
                    }
                } else {
                    overrides[name] = val; // transfer normal options as-is
                }
            }
        });

        return overrides;
    }

    ;
    ;

// exports
    FC.intersectRanges = intersectRanges;
    FC.applyAll = applyAll;
    FC.debounce = debounce;
    FC.isInt = isInt;
    FC.htmlEscape = htmlEscape;
    FC.cssToStr = cssToStr;
    FC.proxy = proxy;
    FC.capitaliseFirstLetter = capitaliseFirstLetter;


    /* FullCalendar-specific DOM Utilities
     ----------------------------------------------------------------------------------------------------------------------*/


// Given the scrollbar widths of some other container, create borders/margins on rowEls in order to match the left
// and right space that was offset by the scrollbars. A 1-pixel border first, then margin beyond that.
    function compensateScroll(rowEls, scrollbarWidths) {
        if (scrollbarWidths.left) {
            rowEls.css({
                'border-left-width': 1,
                'margin-left': scrollbarWidths.left - 1
            });
        }
        if (scrollbarWidths.right) {
            rowEls.css({
                'border-right-width': 1,
                'margin-right': scrollbarWidths.right - 1
            });
        }
    }


// Undoes compensateScroll and restores all borders/margins
    function uncompensateScroll(rowEls) {
        rowEls.css({
            'margin-left': '',
            'margin-right': '',
            'border-left-width': '',
            'border-right-width': ''
        });
    }


// Make the mouse cursor express that an event is not allowed in the current area
    function disableCursor() {
        $('body').addClass('fc-not-allowed');
    }


// Returns the mouse cursor to its original look
    function enableCursor() {
        $('body').removeClass('fc-not-allowed');
    }


// Given a total available height to fill, have `els` (essentially child rows) expand to accomodate.
// By default, all elements that are shorter than the recommended height are expanded uniformly, not considering
// any other els that are already too tall. if `shouldRedistribute` is on, it considers these tall rows and 
// reduces the available height.
    function distributeHeight(els, availableHeight, shouldRedistribute) {

        // *FLOORING NOTE*: we floor in certain places because zoom can give inaccurate floating-point dimensions,
        // and it is better to be shorter than taller, to avoid creating unnecessary scrollbars.

        var minOffset1 = Math.floor(availableHeight / els.length); // for non-last element
        var minOffset2 = Math.floor(availableHeight - minOffset1 * (els.length - 1)); // for last element *FLOORING NOTE*
        var flexEls = []; // elements that are allowed to expand. array of DOM nodes
        var flexOffsets = []; // amount of vertical space it takes up
        var flexHeights = []; // actual css height
        var usedHeight = 0;

        undistributeHeight(els); // give all elements their natural height

        // find elements that are below the recommended height (expandable).
        // important to query for heights in a single first pass (to avoid reflow oscillation).
        els.each(function (i, el) {
            var minOffset = i === els.length - 1 ? minOffset2 : minOffset1;
            var naturalOffset = $(el).outerHeight(true);

            if (naturalOffset < minOffset) {
                flexEls.push(el);
                flexOffsets.push(naturalOffset);
                flexHeights.push($(el).height());
            } else {
                // this element stretches past recommended height (non-expandable). mark the space as occupied.
                usedHeight += naturalOffset;
            }
        });

        // readjust the recommended height to only consider the height available to non-maxed-out rows.
        if (shouldRedistribute) {
            availableHeight -= usedHeight;
            minOffset1 = Math.floor(availableHeight / flexEls.length);
            minOffset2 = Math.floor(availableHeight - minOffset1 * (flexEls.length - 1)); // *FLOORING NOTE*
        }

        // assign heights to all expandable elements
        $(flexEls).each(function (i, el) {
            var minOffset = i === flexEls.length - 1 ? minOffset2 : minOffset1;
            var naturalOffset = flexOffsets[i];
            var naturalHeight = flexHeights[i];
            var newHeight = minOffset - (naturalOffset - naturalHeight); // subtract the margin/padding

            if (naturalOffset < minOffset) { // we check this again because redistribution might have changed things
                $(el).height(newHeight);
            }
        });
    }


// Undoes distrubuteHeight, restoring all els to their natural height
    function undistributeHeight(els) {
        els.height('');
    }


// Given `els`, a jQuery set of <td> cells, find the cell with the largest natural width and set the widths of all the
// cells to be that width.
// PREREQUISITE: if you want a cell to take up width, it needs to have a single inner element w/ display:inline
    function matchCellWidths(els) {
        var maxInnerWidth = 0;

        els.find('> span').each(function (i, innerEl) {
            var innerWidth = $(innerEl).outerWidth();
            if (innerWidth > maxInnerWidth) {
                maxInnerWidth = innerWidth;
            }
        });

        maxInnerWidth++; // sometimes not accurate of width the text needs to stay on one line. insurance

        els.width(maxInnerWidth);

        return maxInnerWidth;
    }


// Given one element that resides inside another,
// Subtracts the height of the inner element from the outer element.
    function subtractInnerElHeight(outerEl, innerEl) {
        var both = outerEl.add(innerEl);
        var diff;

        // effin' IE8/9/10/11 sometimes returns 0 for dimensions. this weird hack was the only thing that worked
        both.css({
            position: 'relative', // cause a reflow, which will force fresh dimension recalculation
            left: -1 // ensure reflow in case the el was already relative. negative is less likely to cause new scroll
        });
        diff = outerEl.outerHeight() - innerEl.outerHeight(); // grab the dimensions
        both.css({position: '', left: ''}); // undo hack

        return diff;
    }


    /* Element Geom Utilities
     ----------------------------------------------------------------------------------------------------------------------*/

    FC.getOuterRect = getOuterRect;
    FC.getClientRect = getClientRect;
    FC.getContentRect = getContentRect;
    FC.getScrollbarWidths = getScrollbarWidths;


// borrowed from https://github.com/jquery/jquery-ui/blob/1.11.0/ui/core.js#L51
    function getScrollParent(el) {
        var position = el.css('position'),
            scrollParent = el.parents().filter(function () {
            var parent = $(this);
            return (/(auto|scroll)/).test(
                parent.css('overflow') + parent.css('overflow-y') + parent.css('overflow-x')
                );
        }).eq(0);

        return position === 'fixed' || !scrollParent.length ? $(el[0].ownerDocument || document) : scrollParent;
    }


// Queries the outer bounding area of a jQuery element.
// Returns a rectangle with absolute coordinates: left, right (exclusive), top, bottom (exclusive).
// Origin is optional.
    function getOuterRect(el, origin) {
        var offset = el.offset();
        var left = offset.left - (origin ? origin.left : 0);
        var top = offset.top - (origin ? origin.top : 0);

        return {
            left: left,
            right: left + el.outerWidth(),
            top: top,
            bottom: top + el.outerHeight()
        };
    }


// Queries the area within the margin/border/scrollbars of a jQuery element. Does not go within the padding.
// Returns a rectangle with absolute coordinates: left, right (exclusive), top, bottom (exclusive).
// Origin is optional.
// NOTE: should use clientLeft/clientTop, but very unreliable cross-browser.
    function getClientRect(el, origin) {
        var offset = el.offset();
        var scrollbarWidths = getScrollbarWidths(el);
        var left = offset.left + getCssFloat(el, 'border-left-width') + scrollbarWidths.left - (origin ? origin.left : 0);
        var top = offset.top + getCssFloat(el, 'border-top-width') + scrollbarWidths.top - (origin ? origin.top : 0);

        return {
            left: left,
            right: left + el[0].clientWidth, // clientWidth includes padding but NOT scrollbars
            top: top,
            bottom: top + el[0].clientHeight // clientHeight includes padding but NOT scrollbars
        };
    }


// Queries the area within the margin/border/padding of a jQuery element. Assumed not to have scrollbars.
// Returns a rectangle with absolute coordinates: left, right (exclusive), top, bottom (exclusive).
// Origin is optional.
    function getContentRect(el, origin) {
        var offset = el.offset(); // just outside of border, margin not included
        var left = offset.left + getCssFloat(el, 'border-left-width') + getCssFloat(el, 'padding-left') -
            (origin ? origin.left : 0);
        var top = offset.top + getCssFloat(el, 'border-top-width') + getCssFloat(el, 'padding-top') -
            (origin ? origin.top : 0);

        return {
            left: left,
            right: left + el.width(),
            top: top,
            bottom: top + el.height()
        };
    }


// Returns the computed left/right/top/bottom scrollbar widths for the given jQuery element.
// NOTE: should use clientLeft/clientTop, but very unreliable cross-browser.
    function getScrollbarWidths(el) {
        var leftRightWidth = el.innerWidth() - el[0].clientWidth; // the paddings cancel out, leaving the scrollbars
        var widths = {
            left: 0,
            right: 0,
            top: 0,
            bottom: el.innerHeight() - el[0].clientHeight // the paddings cancel out, leaving the bottom scrollbar
        };

        if (getIsLeftRtlScrollbars() && el.css('direction') == 'rtl') { // is the scrollbar on the left side?
            widths.left = leftRightWidth;
        } else {
            widths.right = leftRightWidth;
        }

        return widths;
    }


// Logic for determining if, when the element is right-to-left, the scrollbar appears on the left side

    var _isLeftRtlScrollbars = null;

    function getIsLeftRtlScrollbars() { // responsible for caching the computation
        if (_isLeftRtlScrollbars === null) {
            _isLeftRtlScrollbars = computeIsLeftRtlScrollbars();
        }
        return _isLeftRtlScrollbars;
    }

    function computeIsLeftRtlScrollbars() { // creates an offscreen test element, then removes it
        var el = $('<div><div/></div>')
            .css({
                position: 'absolute',
                top: -1000,
                left: 0,
                border: 0,
                padding: 0,
                overflow: 'scroll',
                direction: 'rtl'
            })
            .appendTo('body');
        var innerEl = el.children();
        var res = innerEl.offset().left > el.offset().left; // is the inner div shifted to accommodate a left scrollbar?
        el.remove();
        return res;
    }


// Retrieves a jQuery element's computed CSS value as a floating-point number.
// If the queried value is non-numeric (ex: IE can return "medium" for border width), will just return zero.
    function getCssFloat(el, prop) {
        return parseFloat(el.css(prop)) || 0;
    }


    /* Mouse / Touch Utilities
     ----------------------------------------------------------------------------------------------------------------------*/

    FC.preventDefault = preventDefault;


// Returns a boolean whether this was a left mouse click and no ctrl key (which means right click on Mac)
    function isPrimaryMouseButton(ev) {
        return ev.which == 1 && !ev.ctrlKey;
    }


    function getEvX(ev) {
        if (ev.pageX !== undefined) {
            return ev.pageX;
        }
        var touches = ev.originalEvent.touches;
        if (touches) {
            return touches[0].pageX;
        }
    }


    function getEvY(ev) {
        if (ev.pageY !== undefined) {
            return ev.pageY;
        }
        var touches = ev.originalEvent.touches;
        if (touches) {
            return touches[0].pageY;
        }
    }


    function getEvIsTouch(ev) {
        return /^touch/.test(ev.type);
    }


    function preventSelection(el) {
        el.addClass('fc-unselectable')
            .on('selectstart', preventDefault);
    }


// Stops a mouse/touch event from doing it's native browser action
    function preventDefault(ev) {
        ev.preventDefault();
    }


// attach a handler to get called when ANY scroll action happens on the page.
// this was impossible to do with normal on/off because 'scroll' doesn't bubble.
// http://stackoverflow.com/a/32954565/96342
// returns `true` on success.
    function bindAnyScroll(handler) {
        if (window.addEventListener) {
            window.addEventListener('scroll', handler, true); // useCapture=true
            return true;
        }
        return false;
    }


// undoes bindAnyScroll. must pass in the original function.
// returns `true` on success.
    function unbindAnyScroll(handler) {
        if (window.removeEventListener) {
            window.removeEventListener('scroll', handler, true); // useCapture=true
            return true;
        }
        return false;
    }


    /* General Geometry Utils
     ----------------------------------------------------------------------------------------------------------------------*/

    FC.intersectRects = intersectRects;

// Returns a new rectangle that is the intersection of the two rectangles. If they don't intersect, returns false
    function intersectRects(rect1, rect2) {
        var res = {
            left: Math.max(rect1.left, rect2.left),
            right: Math.min(rect1.right, rect2.right),
            top: Math.max(rect1.top, rect2.top),
            bottom: Math.min(rect1.bottom, rect2.bottom)
        };

        if (res.left < res.right && res.top < res.bottom) {
            return res;
        }
        return false;
    }


// Returns a new point that will have been moved to reside within the given rectangle
    function constrainPoint(point, rect) {
        return {
            left: Math.min(Math.max(point.left, rect.left), rect.right),
            top: Math.min(Math.max(point.top, rect.top), rect.bottom)
        };
    }


// Returns a point that is the center of the given rectangle
    function getRectCenter(rect) {
        return {
            left: (rect.left + rect.right) / 2,
            top: (rect.top + rect.bottom) / 2
        };
    }


// Subtracts point2's coordinates from point1's coordinates, returning a delta
    function diffPoints(point1, point2) {
        return {
            left: point1.left - point2.left,
            top: point1.top - point2.top
        };
    }


    /* Object Ordering by Field
     ----------------------------------------------------------------------------------------------------------------------*/

    FC.parseFieldSpecs = parseFieldSpecs;
    FC.compareByFieldSpecs = compareByFieldSpecs;
    FC.compareByFieldSpec = compareByFieldSpec;
    FC.flexibleCompare = flexibleCompare;


    function parseFieldSpecs(input) {
        var specs = [];
        var tokens = [];
        var i, token;

        if (typeof input === 'string') {
            tokens = input.split(/\s*,\s*/);
        } else if (typeof input === 'function') {
            tokens = [input];
        } else if ($.isArray(input)) {
            tokens = input;
        }

        for (i = 0; i < tokens.length; i++) {
            token = tokens[i];

            if (typeof token === 'string') {
                specs.push(
                    token.charAt(0) == '-' ?
                    {field: token.substring(1), order: -1} :
                    {field: token, order: 1}
                );
            } else if (typeof token === 'function') {
                specs.push({func: token});
            }
        }

        return specs;
    }


    function compareByFieldSpecs(obj1, obj2, fieldSpecs) {
        var i;
        var cmp;

        for (i = 0; i < fieldSpecs.length; i++) {
            cmp = compareByFieldSpec(obj1, obj2, fieldSpecs[i]);
            if (cmp) {
                return cmp;
            }
        }

        return 0;
    }


    function compareByFieldSpec(obj1, obj2, fieldSpec) {
        if (fieldSpec.func) {
            return fieldSpec.func(obj1, obj2);
        }
        return flexibleCompare(obj1[fieldSpec.field], obj2[fieldSpec.field]) *
            (fieldSpec.order || 1);
    }


    function flexibleCompare(a, b) {
        if (!a && !b) {
            return 0;
        }
        if (b == null) {
            return -1;
        }
        if (a == null) {
            return 1;
        }
        if ($.type(a) === 'string' || $.type(b) === 'string') {
            return String(a).localeCompare(String(b));
        }
        return a - b;
    }


    /* FullCalendar-specific Misc Utilities
     ----------------------------------------------------------------------------------------------------------------------*/


// Computes the intersection of the two ranges. Returns undefined if no intersection.
// Expects all dates to be normalized to the same timezone beforehand.
// TODO: move to date section?
    function intersectRanges(subjectRange, constraintRange) {
        var subjectStart = subjectRange.start;
        var subjectEnd = subjectRange.end;
        var constraintStart = constraintRange.start;
        var constraintEnd = constraintRange.end;
        var segStart, segEnd;
        var isStart, isEnd;

        if (subjectEnd > constraintStart && subjectStart < constraintEnd) { // in bounds at all?

            if (subjectStart >= constraintStart) {
                segStart = subjectStart.clone();
                isStart = true;
            } else {
                segStart = constraintStart.clone();
                isStart = false;
            }

            if (subjectEnd <= constraintEnd) {
                segEnd = subjectEnd.clone();
                isEnd = true;
            } else {
                segEnd = constraintEnd.clone();
                isEnd = false;
            }

            return {
                start: segStart,
                end: segEnd,
                isStart: isStart,
                isEnd: isEnd
            };
        }
    }


    /* Date Utilities
     ----------------------------------------------------------------------------------------------------------------------*/

    FC.computeIntervalUnit = computeIntervalUnit;
    FC.divideRangeByDuration = divideRangeByDuration;
    FC.divideDurationByDuration = divideDurationByDuration;
    FC.multiplyDuration = multiplyDuration;
    FC.durationHasTime = durationHasTime;

    var dayIDs = ['sun', 'mon', 'tue', 'wed', 'thu', 'fri', 'sat'];
    var intervalUnits = ['year', 'month', 'week', 'day', 'hour', 'minute', 'second', 'millisecond'];


// Diffs the two moments into a Duration where full-days are recorded first, then the remaining time.
// Moments will have their timezones normalized.
    function diffDayTime(a, b) {
        return moment.duration({
            days: a.clone().stripTime().diff(b.clone().stripTime(), 'days'),
            ms: a.time() - b.time() // time-of-day from day start. disregards timezone
        });
    }


// Diffs the two moments via their start-of-day (regardless of timezone). Produces whole-day durations.
    function diffDay(a, b) {
        return moment.duration({
            days: a.clone().stripTime().diff(b.clone().stripTime(), 'days')
        });
    }


// Diffs two moments, producing a duration, made of a whole-unit-increment of the given unit. Uses rounding.
    function diffByUnit(a, b, unit) {
        return moment.duration(
            Math.round(a.diff(b, unit, true)), // returnFloat=true
            unit
            );
    }


// Computes the unit name of the largest whole-unit period of time.
// For example, 48 hours will be "days" whereas 49 hours will be "hours".
// Accepts start/end, a range object, or an original duration object.
    function computeIntervalUnit(start, end) {
        var i, unit;
        var val;

        for (i = 0; i < intervalUnits.length; i++) {
            unit = intervalUnits[i];
            val = computeRangeAs(unit, start, end);

            if (val >= 1 && isInt(val)) {
                break;
            }
        }

        return unit; // will be "milliseconds" if nothing else matches
    }


// Computes the number of units (like "hours") in the given range.
// Range can be a {start,end} object, separate start/end args, or a Duration.
// Results are based on Moment's .as() and .diff() methods, so results can depend on internal handling
// of month-diffing logic (which tends to vary from version to version).
    function computeRangeAs(unit, start, end) {

        if (end != null) { // given start, end
            return end.diff(start, unit, true);
        } else if (moment.isDuration(start)) { // given duration
            return start.as(unit);
        } else { // given { start, end } range object
            return start.end.diff(start.start, unit, true);
        }
    }


// Intelligently divides a range (specified by a start/end params) by a duration
    function divideRangeByDuration(start, end, dur) {
        var months;

        if (durationHasTime(dur)) {
            return (end - start) / dur;
        }
        months = dur.asMonths();
        if (Math.abs(months) >= 1 && isInt(months)) {
            return end.diff(start, 'months', true) / months;
        }
        return end.diff(start, 'days', true) / dur.asDays();
    }


// Intelligently divides one duration by another
    function divideDurationByDuration(dur1, dur2) {
        var months1, months2;

        if (durationHasTime(dur1) || durationHasTime(dur2)) {
            return dur1 / dur2;
        }
        months1 = dur1.asMonths();
        months2 = dur2.asMonths();
        if (
            Math.abs(months1) >= 1 && isInt(months1) &&
            Math.abs(months2) >= 1 && isInt(months2)
            ) {
            return months1 / months2;
        }
        return dur1.asDays() / dur2.asDays();
    }


// Intelligently multiplies a duration by a number
    function multiplyDuration(dur, n) {
        var months;

        if (durationHasTime(dur)) {
            return moment.duration(dur * n);
        }
        months = dur.asMonths();
        if (Math.abs(months) >= 1 && isInt(months)) {
            return moment.duration({months: months * n});
        }
        return moment.duration({days: dur.asDays() * n});
    }


// Returns a boolean about whether the given duration has any time parts (hours/minutes/seconds/ms)
    function durationHasTime(dur) {
        return Boolean(dur.hours() || dur.minutes() || dur.seconds() || dur.milliseconds());
    }


    function isNativeDate(input) {
        return  Object.prototype.toString.call(input) === '[object Date]' || input instanceof Date;
    }


// Returns a boolean about whether the given input is a time string, like "06:40:00" or "06:00"
    function isTimeString(str) {
        return /^\d+\:\d+(?:\:\d+\.?(?:\d{3})?)?$/.test(str);
    }


    /* Logging and Debug
     ----------------------------------------------------------------------------------------------------------------------*/

    FC.log = function () {
        var console = window.console;

        if (console && console.log) {
            return console.log.apply(console, arguments);
        }
    };

    FC.warn = function () {
        var console = window.console;

        if (console && console.warn) {
            return console.warn.apply(console, arguments);
        } else {
            return FC.log.apply(FC, arguments);
        }
    };


    /* General Utilities
     ----------------------------------------------------------------------------------------------------------------------*/

    var hasOwnPropMethod = {}.hasOwnProperty;


// Merges an array of objects into a single object.
// The second argument allows for an array of property names who's object values will be merged together.
    function mergeProps(propObjs, complexProps) {
        var dest = {};
        var i, name;
        var complexObjs;
        var j, val;
        var props;

        if (complexProps) {
            for (i = 0; i < complexProps.length; i++) {
                name = complexProps[i];
                complexObjs = [];

                // collect the trailing object values, stopping when a non-object is discovered
                for (j = propObjs.length - 1; j >= 0; j--) {
                    val = propObjs[j][name];

                    if (typeof val === 'object') {
                        complexObjs.unshift(val);
                    } else if (val !== undefined) {
                        dest[name] = val; // if there were no objects, this value will be used
                        break;
                    }
                }

                // if the trailing values were objects, use the merged value
                if (complexObjs.length) {
                    dest[name] = mergeProps(complexObjs);
                }
            }
        }

        // copy values into the destination, going from last to first
        for (i = propObjs.length - 1; i >= 0; i--) {
            props = propObjs[i];

            for (name in props) {
                if (!(name in dest)) { // if already assigned by previous props or complex props, don't reassign
                    dest[name] = props[name];
                }
            }
        }

        return dest;
    }


// Create an object that has the given prototype. Just like Object.create
    function createObject(proto) {
        var f = function () {};
        f.prototype = proto;
        return new f();
    }


    function copyOwnProps(src, dest) {
        for (var name in src) {
            if (hasOwnProp(src, name)) {
                dest[name] = src[name];
            }
        }
    }


// Copies over certain methods with the same names as Object.prototype methods. Overcomes an IE<=8 bug:
// https://developer.mozilla.org/en-US/docs/ECMAScript_DontEnum_attribute#JScript_DontEnum_Bug
    function copyNativeMethods(src, dest) {
        var names = ['constructor', 'toString', 'valueOf'];
        var i, name;

        for (i = 0; i < names.length; i++) {
            name = names[i];

            if (src[name] !== Object.prototype[name]) {
                dest[name] = src[name];
            }
        }
    }


    function hasOwnProp(obj, name) {
        return hasOwnPropMethod.call(obj, name);
    }


// Is the given value a non-object non-function value?
    function isAtomic(val) {
        return /undefined|null|boolean|number|string/.test($.type(val));
    }


    function applyAll(functions, thisObj, args) {
        if ($.isFunction(functions)) {
            functions = [functions];
        }
        if (functions) {
            var i;
            var ret;
            for (i = 0; i < functions.length; i++) {
                ret = functions[i].apply(thisObj, args) || ret;
            }
            return ret;
        }
    }


    function firstDefined() {
        for (var i = 0; i < arguments.length; i++) {
            if (arguments[i] !== undefined) {
                return arguments[i];
            }
        }
    }


    function htmlEscape(s) {
        return (s + '').replace(/&/g, '&amp;')
            .replace(/</g, '&lt;')
            .replace(/>/g, '&gt;')
            .replace(/'/g, '&#039;')
            .replace(/"/g, '&quot;')
            .replace(/\n/g, '<br />');
    }


    function stripHtmlEntities(text) {
        return text.replace(/&.*?;/g, '');
    }


// Given a hash of CSS properties, returns a string of CSS.
// Uses property names as-is (no camel-case conversion). Will not make statements for null/undefined values.
    function cssToStr(cssProps) {
        var statements = [];

        $.each(cssProps, function (name, val) {
            if (val != null) {
                statements.push(name + ':' + val);
            }
        });

        return statements.join(';');
    }


    function capitaliseFirstLetter(str) {
        return str.charAt(0).toUpperCase() + str.slice(1);
    }


    function compareNumbers(a, b) { // for .sort()
        return a - b;
    }


    function isInt(n) {
        return n % 1 === 0;
    }


// Returns a method bound to the given object context.
// Just like one of the jQuery.proxy signatures, but without the undesired behavior of treating the same method with
// different contexts as identical when binding/unbinding events.
    function proxy(obj, methodName) {
        var method = obj[methodName];

        return function () {
            return method.apply(obj, arguments);
        };
    }


// Returns a function, that, as long as it continues to be invoked, will not
// be triggered. The function will be called after it stops being called for
// N milliseconds. If `immediate` is passed, trigger the function on the
// leading edge, instead of the trailing.
// https://github.com/jashkenas/underscore/blob/1.6.0/underscore.js#L714
    function debounce(func, wait, immediate) {
        var timeout, args, context, timestamp, result;

        var later = function () {
            var last = +new Date() - timestamp;
            if (last < wait) {
                timeout = setTimeout(later, wait - last);
            } else {
                timeout = null;
                if (!immediate) {
                    result = func.apply(context, args);
                    context = args = null;
                }
            }
        };

        return function () {
            context = this;
            args = arguments;
            timestamp = +new Date();
            var callNow = immediate && !timeout;
            if (!timeout) {
                timeout = setTimeout(later, wait);
            }
            if (callNow) {
                result = func.apply(context, args);
                context = args = null;
            }
            return result;
        };
    }

    ;
    ;

    var ambigDateOfMonthRegex = /^\s*\d{4}-\d\d$/;
    var ambigTimeOrZoneRegex =
        /^\s*\d{4}-(?:(\d\d-\d\d)|(W\d\d$)|(W\d\d-\d)|(\d\d\d))((T| )(\d\d(:\d\d(:\d\d(\.\d+)?)?)?)?)?$/;
    var newMomentProto = moment.fn; // where we will attach our new methods
    var oldMomentProto = $.extend({}, newMomentProto); // copy of original moment methods
    var allowValueOptimization;
    var setUTCValues; // function defined below
    var setLocalValues; // function defined below


// Creating
// -------------------------------------------------------------------------------------------------

// Creates a new moment, similar to the vanilla moment(...) constructor, but with
// extra features (ambiguous time, enhanced formatting). When given an existing moment,
// it will function as a clone (and retain the zone of the moment). Anything else will
// result in a moment in the local zone.
    FC.moment = function () {
        return makeMoment(arguments);
    };

// Sames as FC.moment, but forces the resulting moment to be in the UTC timezone.
    FC.moment.utc = function () {
        var mom = makeMoment(arguments, true);

        // Force it into UTC because makeMoment doesn't guarantee it
        // (if given a pre-existing moment for example)
        if (mom.hasTime()) { // don't give ambiguously-timed moments a UTC zone
            mom.utc();
        }

        return mom;
    };

// Same as FC.moment, but when given an ISO8601 string, the timezone offset is preserved.
// ISO8601 strings with no timezone offset will become ambiguously zoned.
    FC.moment.parseZone = function () {
        return makeMoment(arguments, true, true);
    };

// Builds an enhanced moment from args. When given an existing moment, it clones. When given a
// native Date, or called with no arguments (the current time), the resulting moment will be local.
// Anything else needs to be "parsed" (a string or an array), and will be affected by:
//    parseAsUTC - if there is no zone information, should we parse the input in UTC?
//    parseZone - if there is zone information, should we force the zone of the moment?
    function makeMoment(args, parseAsUTC, parseZone) {
        var input = args[0];
        var isSingleString = args.length == 1 && typeof input === 'string';
        var isAmbigTime;
        var isAmbigZone;
        var ambigMatch;
        var mom;

        if (moment.isMoment(input)) {
            mom = moment.apply(null, args); // clone it
            transferAmbigs(input, mom); // the ambig flags weren't transfered with the clone
        } else if (isNativeDate(input) || input === undefined) {
            mom = moment.apply(null, args); // will be local
        } else { // "parsing" is required
            isAmbigTime = false;
            isAmbigZone = false;

            if (isSingleString) {
                if (ambigDateOfMonthRegex.test(input)) {
                    // accept strings like '2014-05', but convert to the first of the month
                    input += '-01';
                    args = [input]; // for when we pass it on to moment's constructor
                    isAmbigTime = true;
                    isAmbigZone = true;
                } else if ((ambigMatch = ambigTimeOrZoneRegex.exec(input))) {
                    isAmbigTime = !ambigMatch[5]; // no time part?
                    isAmbigZone = true;
                }
            } else if ($.isArray(input)) {
                // arrays have no timezone information, so assume ambiguous zone
                isAmbigZone = true;
            }
            // otherwise, probably a string with a format

            if (parseAsUTC || isAmbigTime) {
                mom = moment.utc.apply(moment, args);
            } else {
                mom = moment.apply(null, args);
            }

            if (isAmbigTime) {
                mom._ambigTime = true;
                mom._ambigZone = true; // ambiguous time always means ambiguous zone
            } else if (parseZone) { // let's record the inputted zone somehow
                if (isAmbigZone) {
                    mom._ambigZone = true;
                } else if (isSingleString) {
                    if (mom.utcOffset) {
                        mom.utcOffset(input); // if not a valid zone, will assign UTC
                    } else {
                        mom.zone(input); // for moment-pre-2.9
                    }
                }
            }
        }

        mom._fullCalendar = true; // flag for extended functionality

        return mom;
    }


// A clone method that works with the flags related to our enhanced functionality.
// In the future, use moment.momentProperties
    newMomentProto.clone = function () {
        var mom = oldMomentProto.clone.apply(this, arguments);

        // these flags weren't transfered with the clone
        transferAmbigs(this, mom);
        if (this._fullCalendar) {
            mom._fullCalendar = true;
        }

        return mom;
    };


// Week Number
// -------------------------------------------------------------------------------------------------


// Returns the week number, considering the locale's custom week number calcuation
// `weeks` is an alias for `week`
    newMomentProto.week = newMomentProto.weeks = function (input) {
        var weekCalc = (this._locale || this._lang) // works pre-moment-2.8
            ._fullCalendar_weekCalc;

        if (input == null && typeof weekCalc === 'function') { // custom function only works for getter
            return weekCalc(this);
        } else if (weekCalc === 'ISO') {
            return oldMomentProto.isoWeek.apply(this, arguments); // ISO getter/setter
        }

        return oldMomentProto.week.apply(this, arguments); // local getter/setter
    };


// Time-of-day
// -------------------------------------------------------------------------------------------------

// GETTER
// Returns a Duration with the hours/minutes/seconds/ms values of the moment.
// If the moment has an ambiguous time, a duration of 00:00 will be returned.
//
// SETTER
// You can supply a Duration, a Moment, or a Duration-like argument.
// When setting the time, and the moment has an ambiguous time, it then becomes unambiguous.
    newMomentProto.time = function (time) {

        // Fallback to the original method (if there is one) if this moment wasn't created via FullCalendar.
        // `time` is a generic enough method name where this precaution is necessary to avoid collisions w/ other plugins.
        if (!this._fullCalendar) {
            return oldMomentProto.time.apply(this, arguments);
        }

        if (time == null) { // getter
            return moment.duration({
                hours: this.hours(),
                minutes: this.minutes(),
                seconds: this.seconds(),
                milliseconds: this.milliseconds()
            });
        } else { // setter

            this._ambigTime = false; // mark that the moment now has a time

            if (!moment.isDuration(time) && !moment.isMoment(time)) {
                time = moment.duration(time);
            }

            // The day value should cause overflow (so 24 hours becomes 00:00:00 of next day).
            // Only for Duration times, not Moment times.
            var dayHours = 0;
            if (moment.isDuration(time)) {
                dayHours = Math.floor(time.asDays()) * 24;
            }

            // We need to set the individual fields.
            // Can't use startOf('day') then add duration. In case of DST at start of day.
            return this.hours(dayHours + time.hours())
                .minutes(time.minutes())
                .seconds(time.seconds())
                .milliseconds(time.milliseconds());
        }
    };

// Converts the moment to UTC, stripping out its time-of-day and timezone offset,
// but preserving its YMD. A moment with a stripped time will display no time
// nor timezone offset when .format() is called.
    newMomentProto.stripTime = function () {
        var a;

        if (!this._ambigTime) {

            // get the values before any conversion happens
            a = this.toArray(); // array of y/m/d/h/m/s/ms

            // TODO: use keepLocalTime in the future
            this.utc(); // set the internal UTC flag (will clear the ambig flags)
            setUTCValues(this, a.slice(0, 3)); // set the year/month/date. time will be zero

            // Mark the time as ambiguous. This needs to happen after the .utc() call, which might call .utcOffset(),
            // which clears all ambig flags. Same with setUTCValues with moment-timezone.
            this._ambigTime = true;
            this._ambigZone = true; // if ambiguous time, also ambiguous timezone offset
        }

        return this; // for chaining
    };

// Returns if the moment has a non-ambiguous time (boolean)
    newMomentProto.hasTime = function () {
        return !this._ambigTime;
    };


// Timezone
// -------------------------------------------------------------------------------------------------

// Converts the moment to UTC, stripping out its timezone offset, but preserving its
// YMD and time-of-day. A moment with a stripped timezone offset will display no
// timezone offset when .format() is called.
// TODO: look into Moment's keepLocalTime functionality
    newMomentProto.stripZone = function () {
        var a, wasAmbigTime;

        if (!this._ambigZone) {

            // get the values before any conversion happens
            a = this.toArray(); // array of y/m/d/h/m/s/ms
            wasAmbigTime = this._ambigTime;

            this.utc(); // set the internal UTC flag (might clear the ambig flags, depending on Moment internals)
            setUTCValues(this, a); // will set the year/month/date/hours/minutes/seconds/ms

            // the above call to .utc()/.utcOffset() unfortunately might clear the ambig flags, so restore
            this._ambigTime = wasAmbigTime || false;

            // Mark the zone as ambiguous. This needs to happen after the .utc() call, which might call .utcOffset(),
            // which clears the ambig flags. Same with setUTCValues with moment-timezone.
            this._ambigZone = true;
        }

        return this; // for chaining
    };

// Returns of the moment has a non-ambiguous timezone offset (boolean)
    newMomentProto.hasZone = function () {
        return !this._ambigZone;
    };


// this method implicitly marks a zone
    newMomentProto.local = function () {
        var a = this.toArray(); // year,month,date,hours,minutes,seconds,ms as an array
        var wasAmbigZone = this._ambigZone;

        oldMomentProto.local.apply(this, arguments);

        // ensure non-ambiguous
        // this probably already happened via local() -> utcOffset(), but don't rely on Moment's internals
        this._ambigTime = false;
        this._ambigZone = false;

        if (wasAmbigZone) {
            // If the moment was ambiguously zoned, the date fields were stored as UTC.
            // We want to preserve these, but in local time.
            // TODO: look into Moment's keepLocalTime functionality
            setLocalValues(this, a);
        }

        return this; // for chaining
    };


// implicitly marks a zone
    newMomentProto.utc = function () {
        oldMomentProto.utc.apply(this, arguments);

        // ensure non-ambiguous
        // this probably already happened via utc() -> utcOffset(), but don't rely on Moment's internals
        this._ambigTime = false;
        this._ambigZone = false;

        return this;
    };


// methods for arbitrarily manipulating timezone offset.
// should clear time/zone ambiguity when called.
    $.each([
        'zone', // only in moment-pre-2.9. deprecated afterwards
        'utcOffset'
    ], function (i, name) {
        if (oldMomentProto[name]) { // original method exists?

            // this method implicitly marks a zone (will probably get called upon .utc() and .local())
            newMomentProto[name] = function (tzo) {

                if (tzo != null) { // setter
                    // these assignments needs to happen before the original zone method is called.
                    // I forget why, something to do with a browser crash.
                    this._ambigTime = false;
                    this._ambigZone = false;
                }

                return oldMomentProto[name].apply(this, arguments);
            };
        }
    });


// Formatting
// -------------------------------------------------------------------------------------------------

    newMomentProto.format = function () {
        if (this._fullCalendar && arguments[0]) { // an enhanced moment? and a format string provided?
            return formatDate(this, arguments[0]); // our extended formatting
        }
        if (this._ambigTime) {
            return oldMomentFormat(this, 'YYYY-MM-DD');
        }
        if (this._ambigZone) {
            return oldMomentFormat(this, 'YYYY-MM-DD[T]HH:mm:ss');
        }
        return oldMomentProto.format.apply(this, arguments);
    };

    newMomentProto.toISOString = function () {
        if (this._ambigTime) {
            return oldMomentFormat(this, 'YYYY-MM-DD');
        }
        if (this._ambigZone) {
            return oldMomentFormat(this, 'YYYY-MM-DD[T]HH:mm:ss');
        }
        return oldMomentProto.toISOString.apply(this, arguments);
    };


// Querying
// -------------------------------------------------------------------------------------------------

// Is the moment within the specified range? `end` is exclusive.
// FYI, this method is not a standard Moment method, so always do our enhanced logic.
    newMomentProto.isWithin = function (start, end) {
        var a = commonlyAmbiguate([this, start, end]);
        return a[0] >= a[1] && a[0] < a[2];
    };

// When isSame is called with units, timezone ambiguity is normalized before the comparison happens.
// If no units specified, the two moments must be identically the same, with matching ambig flags.
    newMomentProto.isSame = function (input, units) {
        var a;

        // only do custom logic if this is an enhanced moment
        if (!this._fullCalendar) {
            return oldMomentProto.isSame.apply(this, arguments);
        }

        if (units) {
            a = commonlyAmbiguate([this, input], true); // normalize timezones but don't erase times
            return oldMomentProto.isSame.call(a[0], a[1], units);
        } else {
            input = FC.moment.parseZone(input); // normalize input
            return oldMomentProto.isSame.call(this, input) &&
                Boolean(this._ambigTime) === Boolean(input._ambigTime) &&
                Boolean(this._ambigZone) === Boolean(input._ambigZone);
        }
    };

// Make these query methods work with ambiguous moments
    $.each([
        'isBefore',
        'isAfter'
    ], function (i, methodName) {
        newMomentProto[methodName] = function (input, units) {
            var a;

            // only do custom logic if this is an enhanced moment
            if (!this._fullCalendar) {
                return oldMomentProto[methodName].apply(this, arguments);
            }

            a = commonlyAmbiguate([this, input]);
            return oldMomentProto[methodName].call(a[0], a[1], units);
        };
    });


// Misc Internals
// -------------------------------------------------------------------------------------------------

// given an array of moment-like inputs, return a parallel array w/ moments similarly ambiguated.
// for example, of one moment has ambig time, but not others, all moments will have their time stripped.
// set `preserveTime` to `true` to keep times, but only normalize zone ambiguity.
// returns the original moments if no modifications are necessary.
    function commonlyAmbiguate(inputs, preserveTime) {
        var anyAmbigTime = false;
        var anyAmbigZone = false;
        var len = inputs.length;
        var moms = [];
        var i, mom;

        // parse inputs into real moments and query their ambig flags
        for (i = 0; i < len; i++) {
            mom = inputs[i];
            if (!moment.isMoment(mom)) {
                mom = FC.moment.parseZone(mom);
            }
            anyAmbigTime = anyAmbigTime || mom._ambigTime;
            anyAmbigZone = anyAmbigZone || mom._ambigZone;
            moms.push(mom);
        }

        // strip each moment down to lowest common ambiguity
        // use clones to avoid modifying the original moments
        for (i = 0; i < len; i++) {
            mom = moms[i];
            if (!preserveTime && anyAmbigTime && !mom._ambigTime) {
                moms[i] = mom.clone().stripTime();
            } else if (anyAmbigZone && !mom._ambigZone) {
                moms[i] = mom.clone().stripZone();
            }
        }

        return moms;
    }

// Transfers all the flags related to ambiguous time/zone from the `src` moment to the `dest` moment
// TODO: look into moment.momentProperties for this.
    function transferAmbigs(src, dest) {
        if (src._ambigTime) {
            dest._ambigTime = true;
        } else if (dest._ambigTime) {
            dest._ambigTime = false;
        }

        if (src._ambigZone) {
            dest._ambigZone = true;
        } else if (dest._ambigZone) {
            dest._ambigZone = false;
        }
    }


// Sets the year/month/date/etc values of the moment from the given array.
// Inefficient because it calls each individual setter.
    function setMomentValues(mom, a) {
        mom.year(a[0] || 0)
            .month(a[1] || 0)
            .date(a[2] || 0)
            .hours(a[3] || 0)
            .minutes(a[4] || 0)
            .seconds(a[5] || 0)
            .milliseconds(a[6] || 0);
    }

// Can we set the moment's internal date directly?
    allowValueOptimization = '_d' in moment() && 'updateOffset' in moment;

// Utility function. Accepts a moment and an array of the UTC year/month/date/etc values to set.
// Assumes the given moment is already in UTC mode.
    setUTCValues = allowValueOptimization ? function (mom, a) {
        // simlate what moment's accessors do
        mom._d.setTime(Date.UTC.apply(Date, a));
        moment.updateOffset(mom, false); // keepTime=false
    } : setMomentValues;

// Utility function. Accepts a moment and an array of the local year/month/date/etc values to set.
// Assumes the given moment is already in local mode.
    setLocalValues = allowValueOptimization ? function (mom, a) {
        // simlate what moment's accessors do
        mom._d.setTime(+new Date(// FYI, there is now way to apply an array of args to a constructor
            a[0] || 0,
            a[1] || 0,
            a[2] || 0,
            a[3] || 0,
            a[4] || 0,
            a[5] || 0,
            a[6] || 0
            ));
        moment.updateOffset(mom, false); // keepTime=false
    } : setMomentValues;

    ;
    ;

// Single Date Formatting
// -------------------------------------------------------------------------------------------------


// call this if you want Moment's original format method to be used
    function oldMomentFormat(mom, formatStr) {
        return oldMomentProto.format.call(mom, formatStr); // oldMomentProto defined in moment-ext.js
    }


// Formats `date` with a Moment formatting string, but allow our non-zero areas and
// additional token.
    function formatDate(date, formatStr) {
        return formatDateWithChunks(date, getFormatStringChunks(formatStr));
    }


    function formatDateWithChunks(date, chunks) {
        var s = '';
        var i;

        for (i = 0; i < chunks.length; i++) {
            s += formatDateWithChunk(date, chunks[i]);
        }

        return s;
    }


// addition formatting tokens we want recognized
    var tokenOverrides = {
        t: function (date) { // "a" or "p"
            return oldMomentFormat(date, 'a').charAt(0);
        },
        T: function (date) { // "A" or "P"
            return oldMomentFormat(date, 'A').charAt(0);
        }
    };


    function formatDateWithChunk(date, chunk) {
        var token;
        var maybeStr;

        if (typeof chunk === 'string') { // a literal string
            return chunk;
        } else if ((token = chunk.token)) { // a token, like "YYYY"
            if (tokenOverrides[token]) {
                return tokenOverrides[token](date); // use our custom token
            }
            return oldMomentFormat(date, token);
        } else if (chunk.maybe) { // a grouping of other chunks that must be non-zero
            maybeStr = formatDateWithChunks(date, chunk.maybe);
            if (maybeStr.match(/[1-9]/)) {
                return maybeStr;
            }
        }

        return '';
    }


// Date Range Formatting
// -------------------------------------------------------------------------------------------------
// TODO: make it work with timezone offset

// Using a formatting string meant for a single date, generate a range string, like
// "Sep 2 - 9 2013", that intelligently inserts a separator where the dates differ.
// If the dates are the same as far as the format string is concerned, just return a single
// rendering of one date, without any separator.
    function formatRange(date1, date2, formatStr, separator, isRTL) {
        var localeData;

        date1 = FC.moment.parseZone(date1);
        date2 = FC.moment.parseZone(date2);

        localeData = (date1.localeData || date1.lang).call(date1); // works with moment-pre-2.8

        // Expand localized format strings, like "LL" -> "MMMM D YYYY"
        formatStr = localeData.longDateFormat(formatStr) || formatStr;
        // BTW, this is not important for `formatDate` because it is impossible to put custom tokens
        // or non-zero areas in Moment's localized format strings.

        separator = separator || ' - ';

        return formatRangeWithChunks(
            date1,
            date2,
            getFormatStringChunks(formatStr),
            separator,
            isRTL
            );
    }
    FC.formatRange = formatRange; // expose


    function formatRangeWithChunks(date1, date2, chunks, separator, isRTL) {
        var unzonedDate1 = date1.clone().stripZone(); // for formatSimilarChunk
        var unzonedDate2 = date2.clone().stripZone(); // "
        var chunkStr; // the rendering of the chunk
        var leftI;
        var leftStr = '';
        var rightI;
        var rightStr = '';
        var middleI;
        var middleStr1 = '';
        var middleStr2 = '';
        var middleStr = '';

        // Start at the leftmost side of the formatting string and continue until you hit a token
        // that is not the same between dates.
        for (leftI = 0; leftI < chunks.length; leftI++) {
            chunkStr = formatSimilarChunk(date1, date2, unzonedDate1, unzonedDate2, chunks[leftI]);
            if (chunkStr === false) {
                break;
            }
            leftStr += chunkStr;
        }

        // Similarly, start at the rightmost side of the formatting string and move left
        for (rightI = chunks.length - 1; rightI > leftI; rightI--) {
            chunkStr = formatSimilarChunk(date1, date2, unzonedDate1, unzonedDate2, chunks[rightI]);
            if (chunkStr === false) {
                break;
            }
            rightStr = chunkStr + rightStr;
        }

        // The area in the middle is different for both of the dates.
        // Collect them distinctly so we can jam them together later.
        for (middleI = leftI; middleI <= rightI; middleI++) {
            middleStr1 += formatDateWithChunk(date1, chunks[middleI]);
            middleStr2 += formatDateWithChunk(date2, chunks[middleI]);
        }

        if (middleStr1 || middleStr2) {
            if (isRTL) {
                middleStr = middleStr2 + separator + middleStr1;
            } else {
                middleStr = middleStr1 + separator + middleStr2;
            }
        }

        return leftStr + middleStr + rightStr;
    }


    var similarUnitMap = {
        Y: 'year',
        M: 'month',
        D: 'day', // day of month
        d: 'day', // day of week
        // prevents a separator between anything time-related...
        A: 'second', // AM/PM
        a: 'second', // am/pm
        T: 'second', // A/P
        t: 'second', // a/p
        H: 'second', // hour (24)
        h: 'second', // hour (12)
        m: 'second', // minute
        s: 'second' // second
    };
// TODO: week maybe?


// Given a formatting chunk, and given that both dates are similar in the regard the
// formatting chunk is concerned, format date1 against `chunk`. Otherwise, return `false`.
    function formatSimilarChunk(date1, date2, unzonedDate1, unzonedDate2, chunk) {
        var token;
        var unit;

        if (typeof chunk === 'string') { // a literal string
            return chunk;
        } else if ((token = chunk.token)) {
            unit = similarUnitMap[token.charAt(0)];

            // are the dates the same for this unit of measurement?
            // use the unzoned dates for this calculation because unreliable when near DST (bug #2396)
            if (unit && unzonedDate1.isSame(unzonedDate2, unit)) {
                return oldMomentFormat(date1, token); // would be the same if we used `date2`
                // BTW, don't support custom tokens
            }
        }

        return false; // the chunk is NOT the same for the two dates
        // BTW, don't support splitting on non-zero areas
    }


// Chunking Utils
// -------------------------------------------------------------------------------------------------


    var formatStringChunkCache = {};


    function getFormatStringChunks(formatStr) {
        if (formatStr in formatStringChunkCache) {
            return formatStringChunkCache[formatStr];
        }
        return (formatStringChunkCache[formatStr] = chunkFormatString(formatStr));
    }


// Break the formatting string into an array of chunks
    function chunkFormatString(formatStr) {
        var chunks = [];
        var chunker = /\[([^\]]*)\]|\(([^\)]*)\)|(LTS|LT|(\w)\4*o?)|([^\w\[\(]+)/g; // TODO: more descrimination
        var match;

        while ((match = chunker.exec(formatStr))) {
            if (match[1]) { // a literal string inside [ ... ]
                chunks.push(match[1]);
            } else if (match[2]) { // non-zero formatting inside ( ... )
                chunks.push({maybe: chunkFormatString(match[2])});
            } else if (match[3]) { // a formatting token
                chunks.push({token: match[3]});
            } else if (match[5]) { // an unenclosed literal string
                chunks.push(match[5]);
            }
        }

        return chunks;
    }

    ;
    ;

    FC.Class = Class; // export

// Class that all other classes will inherit from
    function Class() { }


// Called on a class to create a subclass.
// Last argument contains instance methods. Any argument before the last are considered mixins.
    Class.extend = function () {
        var len = arguments.length;
        var i;
        var members;

        for (i = 0; i < len; i++) {
            members = arguments[i];
            if (i < len - 1) { // not the last argument?
                mixIntoClass(this, members);
            }
        }

        return extendClass(this, members || {}); // members will be undefined if no arguments
    };


// Adds new member variables/methods to the class's prototype.
// Can be called with another class, or a plain object hash containing new members.
    Class.mixin = function (members) {
        mixIntoClass(this, members);
    };


    function extendClass(superClass, members) {
        var subClass;

        // ensure a constructor for the subclass, forwarding all arguments to the super-constructor if it doesn't exist
        if (hasOwnProp(members, 'constructor')) {
            subClass = members.constructor;
        }
        if (typeof subClass !== 'function') {
            subClass = members.constructor = function () {
                superClass.apply(this, arguments);
            };
        }

        // build the base prototype for the subclass, which is an new object chained to the superclass's prototype
        subClass.prototype = createObject(superClass.prototype);

        // copy each member variable/method onto the the subclass's prototype
        copyOwnProps(members, subClass.prototype);
        copyNativeMethods(members, subClass.prototype); // hack for IE8

        // copy over all class variables/methods to the subclass, such as `extend` and `mixin`
        copyOwnProps(superClass, subClass);

        return subClass;
    }


    function mixIntoClass(theClass, members) {
        copyOwnProps(members, theClass.prototype); // TODO: copyNativeMethods?
    }
    ;
    ;

    var EmitterMixin = FC.EmitterMixin = {
        // jQuery-ification via $(this) allows a non-DOM object to have
        // the same event handling capabilities (including namespaces).


        on: function (types, handler) {

            // handlers are always called with an "event" object as their first param.
            // sneak the `this` context and arguments into the extra parameter object
            // and forward them on to the original handler.
            var intercept = function (ev, extra) {
                return handler.apply(
                    extra.context || this,
                    extra.args || []
                    );
            };

            // mimick jQuery's internal "proxy" system (risky, I know)
            // causing all functions with the same .guid to appear to be the same.
            // https://github.com/jquery/jquery/blob/2.2.4/src/core.js#L448
            // this is needed for calling .off with the original non-intercept handler.
            if (!handler.guid) {
                handler.guid = $.guid++;
            }
            intercept.guid = handler.guid;

            $(this).on(types, intercept);

            return this; // for chaining
        },
        off: function (types, handler) {
            $(this).off(types, handler);

            return this; // for chaining
        },
        trigger: function (types) {
            var args = Array.prototype.slice.call(arguments, 1); // arguments after the first

            // pass in "extra" info to the intercept
            $(this).triggerHandler(types, {args: args});

            return this; // for chaining
        },
        triggerWith: function (types, context, args) {

            // `triggerHandler` is less reliant on the DOM compared to `trigger`.
            // pass in "extra" info to the intercept.
            $(this).triggerHandler(types, {context: context, args: args});

            return this; // for chaining
        }

    };

    ;
    ;

    /*
     Utility methods for easily listening to events on another object,
     and more importantly, easily unlistening from them.
     */
    var ListenerMixin = FC.ListenerMixin = (function () {
        var guid = 0;
        var ListenerMixin = {
            listenerId: null,
            /*
             Given an `other` object that has on/off methods, bind the given `callback` to an event by the given name.
             The `callback` will be called with the `this` context of the object that .listenTo is being called on.
             Can be called:
             .listenTo(other, eventName, callback)
             OR
             .listenTo(other, {
             eventName1: callback1,
             eventName2: callback2
             })
             */
            listenTo: function (other, arg, callback) {
                if (typeof arg === 'object') { // given dictionary of callbacks
                    for (var eventName in arg) {
                        if (arg.hasOwnProperty(eventName)) {
                            this.listenTo(other, eventName, arg[eventName]);
                        }
                    }
                } else if (typeof arg === 'string') {
                    other.on(
                        arg + '.' + this.getListenerNamespace(), // use event namespacing to identify this object
                        $.proxy(callback, this) // always use `this` context
                        // the usually-undesired jQuery guid behavior doesn't matter,
                        // because we always unbind via namespace
                        );
                }
            },
            /*
             Causes the current object to stop listening to events on the `other` object.
             `eventName` is optional. If omitted, will stop listening to ALL events on `other`.
             */
            stopListeningTo: function (other, eventName) {
                other.off((eventName || '') + '.' + this.getListenerNamespace());
            },
            /*
             Returns a string, unique to this object, to be used for event namespacing
             */
            getListenerNamespace: function () {
                if (this.listenerId == null) {
                    this.listenerId = guid++;
                }
                return '_listener' + this.listenerId;
            }

        };
        return ListenerMixin;
    })();
    ;
    ;

// simple class for toggle a `isIgnoringMouse` flag on delay
// initMouseIgnoring must first be called, with a millisecond delay setting.
    var MouseIgnorerMixin = {
        isIgnoringMouse: false, // bool
        delayUnignoreMouse: null, // method


        initMouseIgnoring: function (delay) {
            this.delayUnignoreMouse = debounce(proxy(this, 'unignoreMouse'), delay || 1000);
        },
        // temporarily ignore mouse actions on segments
        tempIgnoreMouse: function () {
            this.isIgnoringMouse = true;
            this.delayUnignoreMouse();
        },
        // delayUnignoreMouse eventually calls this
        unignoreMouse: function () {
            this.isIgnoringMouse = false;
        }

    };

    ;
    ;

    /* A rectangular panel that is absolutely positioned over other content
     ------------------------------------------------------------------------------------------------------------------------
     Options:
     - className (string)
     - content (HTML string or jQuery element set)
     - parentEl
     - top
     - left
     - right (the x coord of where the right edge should be. not a "CSS" right)
     - autoHide (boolean)
     - show (callback)
     - hide (callback)
     */

    var Popover = Class.extend(ListenerMixin, {
        isHidden: true,
        options: null,
        el: null, // the container element for the popover. generated by this object
        margin: 10, // the space required between the popover and the edges of the scroll container


        constructor: function (options) {
            this.options = options || {};
        },
        // Shows the popover on the specified position. Renders it if not already
        show: function () {
            if (this.isHidden) {
                if (!this.el) {
                    this.render();
                }
                this.el.show();
                this.position();
                this.isHidden = false;
                this.trigger('show');
            }
        },
        // Hides the popover, through CSS, but does not remove it from the DOM
        hide: function () {
            if (!this.isHidden) {
                this.el.hide();
                this.isHidden = true;
                this.trigger('hide');
            }
        },
        // Creates `this.el` and renders content inside of it
        render: function () {
            var _this = this;
            var options = this.options;

            this.el = $('<div class="fc-popover"/>')
                .addClass(options.className || '')
                .css({
                    // position initially to the top left to avoid creating scrollbars
                    top: 0,
                    left: 0
                })
                .append(options.content)
                .appendTo(options.parentEl);

            // when a click happens on anything inside with a 'fc-close' className, hide the popover
            this.el.on('click', '.fc-close', function () {
                _this.hide();
            });

            if (options.autoHide) {
                this.listenTo($(document), 'mousedown', this.documentMousedown);
            }
        },
        // Triggered when the user clicks *anywhere* in the document, for the autoHide feature
        documentMousedown: function (ev) {
            // only hide the popover if the click happened outside the popover
            if (this.el && !$(ev.target).closest(this.el).length) {
                this.hide();
            }
        },
        // Hides and unregisters any handlers
        removeElement: function () {
            this.hide();

            if (this.el) {
                this.el.remove();
                this.el = null;
            }

            this.stopListeningTo($(document), 'mousedown');
        },
        // Positions the popover optimally, using the top/left/right options
        position: function () {
            var options = this.options;
            var origin = this.el.offsetParent().offset();
            var width = this.el.outerWidth();
            var height = this.el.outerHeight();
            var windowEl = $(window);
            var viewportEl = getScrollParent(this.el);
            var viewportTop;
            var viewportLeft;
            var viewportOffset;
            var top; // the "position" (not "offset") values for the popover
            var left; //

            // compute top and left
            top = options.top || 0;
            if (options.left !== undefined) {
                left = options.left;
            } else if (options.right !== undefined) {
                left = options.right - width; // derive the left value from the right value
            } else {
                left = 0;
            }

            if (viewportEl.is(window) || viewportEl.is(document)) { // normalize getScrollParent's result
                viewportEl = windowEl;
                viewportTop = 0; // the window is always at the top left
                viewportLeft = 0; // (and .offset() won't work if called here)
            } else {
                viewportOffset = viewportEl.offset();
                viewportTop = viewportOffset.top;
                viewportLeft = viewportOffset.left;
            }

            // if the window is scrolled, it causes the visible area to be further down
            viewportTop += windowEl.scrollTop();
            viewportLeft += windowEl.scrollLeft();

            // constrain to the view port. if constrained by two edges, give precedence to top/left
            if (options.viewportConstrain !== false) {
                top = Math.min(top, viewportTop + viewportEl.outerHeight() - height - this.margin);
                top = Math.max(top, viewportTop + this.margin);
                left = Math.min(left, viewportLeft + viewportEl.outerWidth() - width - this.margin);
                left = Math.max(left, viewportLeft + this.margin);
            }

            this.el.css({
                top: top - origin.top,
                left: left - origin.left
            });
        },
        // Triggers a callback. Calls a function in the option hash of the same name.
        // Arguments beyond the first `name` are forwarded on.
        // TODO: better code reuse for this. Repeat code
        trigger: function (name) {
            if (this.options[name]) {
                this.options[name].apply(this, Array.prototype.slice.call(arguments, 1));
            }
        }

    });

    ;
    ;

    /*
     A cache for the left/right/top/bottom/width/height values for one or more elements.
     Works with both offset (from topleft document) and position (from offsetParent).
     
     options:
     - els
     - isHorizontal
     - isVertical
     */
    var CoordCache = FC.CoordCache = Class.extend({
        els: null, // jQuery set (assumed to be siblings)
        forcedOffsetParentEl: null, // options can override the natural offsetParent
        origin: null, // {left,top} position of offsetParent of els
        boundingRect: null, // constrain cordinates to this rectangle. {left,right,top,bottom} or null
        isHorizontal: false, // whether to query for left/right/width
        isVertical: false, // whether to query for top/bottom/height

        // arrays of coordinates (offsets from topleft of document)
        lefts: null,
        rights: null,
        tops: null,
        bottoms: null,
        constructor: function (options) {
            this.els = $(options.els);
            this.isHorizontal = options.isHorizontal;
            this.isVertical = options.isVertical;
            this.forcedOffsetParentEl = options.offsetParent ? $(options.offsetParent) : null;
        },
        // Queries the els for coordinates and stores them.
        // Call this method before using and of the get* methods below.
        build: function () {
            var offsetParentEl = this.forcedOffsetParentEl || this.els.eq(0).offsetParent();

            this.origin = offsetParentEl.offset();
            this.boundingRect = this.queryBoundingRect();

            if (this.isHorizontal) {
                this.buildElHorizontals();
            }
            if (this.isVertical) {
                this.buildElVerticals();
            }
        },
        // Destroys all internal data about coordinates, freeing memory
        clear: function () {
            this.origin = null;
            this.boundingRect = null;
            this.lefts = null;
            this.rights = null;
            this.tops = null;
            this.bottoms = null;
        },
        // When called, if coord caches aren't built, builds them
        ensureBuilt: function () {
            if (!this.origin) {
                this.build();
            }
        },
        // Compute and return what the elements' bounding rectangle is, from the user's perspective.
        // Right now, only returns a rectangle if constrained by an overflow:scroll element.
        queryBoundingRect: function () {
            var scrollParentEl = getScrollParent(this.els.eq(0));

            if (!scrollParentEl.is(document)) {
                return getClientRect(scrollParentEl);
            }
        },
        // Populates the left/right internal coordinate arrays
        buildElHorizontals: function () {
            var lefts = [];
            var rights = [];

            this.els.each(function (i, node) {
                var el = $(node);
                var left = el.offset().left;
                var width = el.outerWidth();

                lefts.push(left);
                rights.push(left + width);
            });

            this.lefts = lefts;
            this.rights = rights;
        },
        // Populates the top/bottom internal coordinate arrays
        buildElVerticals: function () {
            var tops = [];
            var bottoms = [];

            this.els.each(function (i, node) {
                var el = $(node);
                var top = el.offset().top;
                var height = el.outerHeight();

                tops.push(top);
                bottoms.push(top + height);
            });

            this.tops = tops;
            this.bottoms = bottoms;
        },
        // Given a left offset (from document left), returns the index of the el that it horizontally intersects.
        // If no intersection is made, or outside of the boundingRect, returns undefined.
        getHorizontalIndex: function (leftOffset) {
            this.ensureBuilt();

            var boundingRect = this.boundingRect;
            var lefts = this.lefts;
            var rights = this.rights;
            var len = lefts.length;
            var i;

            if (!boundingRect || (leftOffset >= boundingRect.left && leftOffset < boundingRect.right)) {
                for (i = 0; i < len; i++) {
                    if (leftOffset >= lefts[i] && leftOffset < rights[i]) {
                        return i;
                    }
                }
            }
        },
        // Given a top offset (from document top), returns the index of the el that it vertically intersects.
        // If no intersection is made, or outside of the boundingRect, returns undefined.
        getVerticalIndex: function (topOffset) {
            this.ensureBuilt();

            var boundingRect = this.boundingRect;
            var tops = this.tops;
            var bottoms = this.bottoms;
            var len = tops.length;
            var i;

            if (!boundingRect || (topOffset >= boundingRect.top && topOffset < boundingRect.bottom)) {
                for (i = 0; i < len; i++) {
                    if (topOffset >= tops[i] && topOffset < bottoms[i]) {
                        return i;
                    }
                }
            }
        },
        // Gets the left offset (from document left) of the element at the given index
        getLeftOffset: function (leftIndex) {
            this.ensureBuilt();
            return this.lefts[leftIndex];
        },
        // Gets the left position (from offsetParent left) of the element at the given index
        getLeftPosition: function (leftIndex) {
            this.ensureBuilt();
            return this.lefts[leftIndex] - this.origin.left;
        },
        // Gets the right offset (from document left) of the element at the given index.
        // This value is NOT relative to the document's right edge, like the CSS concept of "right" would be.
        getRightOffset: function (leftIndex) {
            this.ensureBuilt();
            return this.rights[leftIndex];
        },
        // Gets the right position (from offsetParent left) of the element at the given index.
        // This value is NOT relative to the offsetParent's right edge, like the CSS concept of "right" would be.
        getRightPosition: function (leftIndex) {
            this.ensureBuilt();
            return this.rights[leftIndex] - this.origin.left;
        },
        // Gets the width of the element at the given index
        getWidth: function (leftIndex) {
            this.ensureBuilt();
            return this.rights[leftIndex] - this.lefts[leftIndex];
        },
        // Gets the top offset (from document top) of the element at the given index
        getTopOffset: function (topIndex) {
            this.ensureBuilt();
            return this.tops[topIndex];
        },
        // Gets the top position (from offsetParent top) of the element at the given position
        getTopPosition: function (topIndex) {
            this.ensureBuilt();
            return this.tops[topIndex] - this.origin.top;
        },
        // Gets the bottom offset (from the document top) of the element at the given index.
        // This value is NOT relative to the offsetParent's bottom edge, like the CSS concept of "bottom" would be.
        getBottomOffset: function (topIndex) {
            this.ensureBuilt();
            return this.bottoms[topIndex];
        },
        // Gets the bottom position (from the offsetParent top) of the element at the given index.
        // This value is NOT relative to the offsetParent's bottom edge, like the CSS concept of "bottom" would be.
        getBottomPosition: function (topIndex) {
            this.ensureBuilt();
            return this.bottoms[topIndex] - this.origin.top;
        },
        // Gets the height of the element at the given index
        getHeight: function (topIndex) {
            this.ensureBuilt();
            return this.bottoms[topIndex] - this.tops[topIndex];
        }

    });

    ;
    ;

    /* Tracks a drag's mouse movement, firing various handlers
     ----------------------------------------------------------------------------------------------------------------------*/
// TODO: use Emitter

    var DragListener = FC.DragListener = Class.extend(ListenerMixin, MouseIgnorerMixin, {
        options: null,
        // for IE8 bug-fighting behavior
        subjectEl: null,
        subjectHref: null,
        // coordinates of the initial mousedown
        originX: null,
        originY: null,
        // the wrapping element that scrolls, or MIGHT scroll if there's overflow.
        // TODO: do this for wrappers that have overflow:hidden as well.
        scrollEl: null,
        isInteracting: false,
        isDistanceSurpassed: false,
        isDelayEnded: false,
        isDragging: false,
        isTouch: false,
        delay: null,
        delayTimeoutId: null,
        minDistance: null,
        handleTouchScrollProxy: null, // calls handleTouchScroll, always bound to `this`


        constructor: function (options) {
            this.options = options || {};
            this.handleTouchScrollProxy = proxy(this, 'handleTouchScroll');
            this.initMouseIgnoring(500);
        },
        // Interaction (high-level)
        // -----------------------------------------------------------------------------------------------------------------


        startInteraction: function (ev, extraOptions) {
            var isTouch = getEvIsTouch(ev);

            if (ev.type === 'mousedown') {
                if (this.isIgnoringMouse) {
                    return;
                } else if (!isPrimaryMouseButton(ev)) {
                    return;
                } else {
                    ev.preventDefault(); // prevents native selection in most browsers
                }
            }

            if (!this.isInteracting) {

                // process options
                extraOptions = extraOptions || {};
                this.delay = firstDefined(extraOptions.delay, this.options.delay, 0);
                this.minDistance = firstDefined(extraOptions.distance, this.options.distance, 0);
                this.subjectEl = this.options.subjectEl;

                this.isInteracting = true;
                this.isTouch = isTouch;
                this.isDelayEnded = false;
                this.isDistanceSurpassed = false;

                this.originX = getEvX(ev);
                this.originY = getEvY(ev);
                this.scrollEl = getScrollParent($(ev.target));

                this.bindHandlers();
                this.initAutoScroll();
                this.handleInteractionStart(ev);
                this.startDelay(ev);

                if (!this.minDistance) {
                    this.handleDistanceSurpassed(ev);
                }
            }
        },
        handleInteractionStart: function (ev) {
            this.trigger('interactionStart', ev);
        },
        endInteraction: function (ev, isCancelled) {
            if (this.isInteracting) {
                this.endDrag(ev);

                if (this.delayTimeoutId) {
                    clearTimeout(this.delayTimeoutId);
                    this.delayTimeoutId = null;
                }

                this.destroyAutoScroll();
                this.unbindHandlers();

                this.isInteracting = false;
                this.handleInteractionEnd(ev, isCancelled);

                // a touchstart+touchend on the same element will result in the following addition simulated events:
                // mouseover + mouseout + click
                // let's ignore these bogus events
                if (this.isTouch) {
                    this.tempIgnoreMouse();
                }
            }
        },
        handleInteractionEnd: function (ev, isCancelled) {
            this.trigger('interactionEnd', ev, isCancelled || false);
        },
        // Binding To DOM
        // -----------------------------------------------------------------------------------------------------------------


        bindHandlers: function () {
            var _this = this;
            var touchStartIgnores = 1;

            if (this.isTouch) {
                this.listenTo($(document), {
                    touchmove: this.handleTouchMove,
                    touchend: this.endInteraction,
                    touchcancel: this.endInteraction,
                    // Sometimes touchend doesn't fire
                    // (can't figure out why. touchcancel doesn't fire either. has to do with scrolling?)
                    // If another touchstart happens, we know it's bogus, so cancel the drag.
                    // touchend will continue to be broken until user does a shorttap/scroll, but this is best we can do.
                    touchstart: function (ev) {
                        if (touchStartIgnores) { // bindHandlers is called from within a touchstart,
                            touchStartIgnores--; // and we don't want this to fire immediately, so ignore.
                        } else {
                            _this.endInteraction(ev, true); // isCancelled=true
                        }
                    }
                });

                // listen to ALL scroll actions on the page
                if (
                    !bindAnyScroll(this.handleTouchScrollProxy) && // hopefully this works and short-circuits the rest
                    this.scrollEl // otherwise, attach a single handler to this
                    ) {
                    this.listenTo(this.scrollEl, 'scroll', this.handleTouchScroll);
                }
            } else {
                this.listenTo($(document), {
                    mousemove: this.handleMouseMove,
                    mouseup: this.endInteraction
                });
            }

            this.listenTo($(document), {
                selectstart: preventDefault, // don't allow selection while dragging
                contextmenu: preventDefault // long taps would open menu on Chrome dev tools
            });
        },
        unbindHandlers: function () {
            this.stopListeningTo($(document));

            // unbind scroll listening
            unbindAnyScroll(this.handleTouchScrollProxy);
            if (this.scrollEl) {
                this.stopListeningTo(this.scrollEl, 'scroll');
            }
        },
        // Drag (high-level)
        // -----------------------------------------------------------------------------------------------------------------


        // extraOptions ignored if drag already started
        startDrag: function (ev, extraOptions) {
            this.startInteraction(ev, extraOptions); // ensure interaction began

            if (!this.isDragging) {
                this.isDragging = true;
                this.handleDragStart(ev);
            }
        },
        handleDragStart: function (ev) {
            this.trigger('dragStart', ev);
            this.initHrefHack();
        },
        handleMove: function (ev) {
            var dx = getEvX(ev) - this.originX;
            var dy = getEvY(ev) - this.originY;
            var minDistance = this.minDistance;
            var distanceSq; // current distance from the origin, squared

            if (!this.isDistanceSurpassed) {
                distanceSq = dx * dx + dy * dy;
                if (distanceSq >= minDistance * minDistance) { // use pythagorean theorem
                    this.handleDistanceSurpassed(ev);
                }
            }

            if (this.isDragging) {
                this.handleDrag(dx, dy, ev);
            }
        },
        // Called while the mouse is being moved and when we know a legitimate drag is taking place
        handleDrag: function (dx, dy, ev) {
            this.trigger('drag', dx, dy, ev);
            this.updateAutoScroll(ev); // will possibly cause scrolling
        },
        endDrag: function (ev) {
            if (this.isDragging) {
                this.isDragging = false;
                this.handleDragEnd(ev);
            }
        },
        handleDragEnd: function (ev) {
            this.trigger('dragEnd', ev);
            this.destroyHrefHack();
        },
        // Delay
        // -----------------------------------------------------------------------------------------------------------------


        startDelay: function (initialEv) {
            var _this = this;

            if (this.delay) {
                this.delayTimeoutId = setTimeout(function () {
                    _this.handleDelayEnd(initialEv);
                }, this.delay);
            } else {
                this.handleDelayEnd(initialEv);
            }
        },
        handleDelayEnd: function (initialEv) {
            this.isDelayEnded = true;

            if (this.isDistanceSurpassed) {
                this.startDrag(initialEv);
            }
        },
        // Distance
        // -----------------------------------------------------------------------------------------------------------------


        handleDistanceSurpassed: function (ev) {
            this.isDistanceSurpassed = true;

            if (this.isDelayEnded) {
                this.startDrag(ev);
            }
        },
        // Mouse / Touch
        // -----------------------------------------------------------------------------------------------------------------


        handleTouchMove: function (ev) {
            // prevent inertia and touchmove-scrolling while dragging
            if (this.isDragging) {
                ev.preventDefault();
            }

            this.handleMove(ev);
        },
        handleMouseMove: function (ev) {
            this.handleMove(ev);
        },
        // Scrolling (unrelated to auto-scroll)
        // -----------------------------------------------------------------------------------------------------------------


        handleTouchScroll: function (ev) {
            // if the drag is being initiated by touch, but a scroll happens before
            // the drag-initiating delay is over, cancel the drag
            if (!this.isDragging) {
                this.endInteraction(ev, true); // isCancelled=true
            }
        },
        // <A> HREF Hack
        // -----------------------------------------------------------------------------------------------------------------


        initHrefHack: function () {
            var subjectEl = this.subjectEl;

            // remove a mousedown'd <a>'s href so it is not visited (IE8 bug)
            if ((this.subjectHref = subjectEl ? subjectEl.attr('href') : null)) {
                subjectEl.removeAttr('href');
            }
        },
        destroyHrefHack: function () {
            var subjectEl = this.subjectEl;
            var subjectHref = this.subjectHref;

            // restore a mousedown'd <a>'s href (for IE8 bug)
            setTimeout(function () { // must be outside of the click's execution
                if (subjectHref) {
                    subjectEl.attr('href', subjectHref);
                }
            }, 0);
        },
        // Utils
        // -----------------------------------------------------------------------------------------------------------------


        // Triggers a callback. Calls a function in the option hash of the same name.
        // Arguments beyond the first `name` are forwarded on.
        trigger: function (name) {
            if (this.options[name]) {
                this.options[name].apply(this, Array.prototype.slice.call(arguments, 1));
            }
            // makes _methods callable by event name. TODO: kill this
            if (this['_' + name]) {
                this['_' + name].apply(this, Array.prototype.slice.call(arguments, 1));
            }
        }


    });

    ;
    ;
    /*
     this.scrollEl is set in DragListener
     */
    DragListener.mixin({
        isAutoScroll: false,
        scrollBounds: null, // { top, bottom, left, right }
        scrollTopVel: null, // pixels per second
        scrollLeftVel: null, // pixels per second
        scrollIntervalId: null, // ID of setTimeout for scrolling animation loop

        // defaults
        scrollSensitivity: 30, // pixels from edge for scrolling to start
        scrollSpeed: 200, // pixels per second, at maximum speed
        scrollIntervalMs: 50, // millisecond wait between scroll increment


        initAutoScroll: function () {
            var scrollEl = this.scrollEl;

            this.isAutoScroll =
                this.options.scroll &&
                scrollEl &&
                !scrollEl.is(window) &&
                !scrollEl.is(document);

            if (this.isAutoScroll) {
                // debounce makes sure rapid calls don't happen
                this.listenTo(scrollEl, 'scroll', debounce(this.handleDebouncedScroll, 100));
            }
        },
        destroyAutoScroll: function () {
            this.endAutoScroll(); // kill any animation loop

            // remove the scroll handler if there is a scrollEl
            if (this.isAutoScroll) {
                this.stopListeningTo(this.scrollEl, 'scroll'); // will probably get removed by unbindHandlers too :(
            }
        },
        // Computes and stores the bounding rectangle of scrollEl
        computeScrollBounds: function () {
            if (this.isAutoScroll) {
                this.scrollBounds = getOuterRect(this.scrollEl);
                // TODO: use getClientRect in future. but prevents auto scrolling when on top of scrollbars
            }
        },
        // Called when the dragging is in progress and scrolling should be updated
        updateAutoScroll: function (ev) {
            var sensitivity = this.scrollSensitivity;
            var bounds = this.scrollBounds;
            var topCloseness, bottomCloseness;
            var leftCloseness, rightCloseness;
            var topVel = 0;
            var leftVel = 0;

            if (bounds) { // only scroll if scrollEl exists

                // compute closeness to edges. valid range is from 0.0 - 1.0
                topCloseness = (sensitivity - (getEvY(ev) - bounds.top)) / sensitivity;
                bottomCloseness = (sensitivity - (bounds.bottom - getEvY(ev))) / sensitivity;
                leftCloseness = (sensitivity - (getEvX(ev) - bounds.left)) / sensitivity;
                rightCloseness = (sensitivity - (bounds.right - getEvX(ev))) / sensitivity;

                // translate vertical closeness into velocity.
                // mouse must be completely in bounds for velocity to happen.
                if (topCloseness >= 0 && topCloseness <= 1) {
                    topVel = topCloseness * this.scrollSpeed * -1; // negative. for scrolling up
                } else if (bottomCloseness >= 0 && bottomCloseness <= 1) {
                    topVel = bottomCloseness * this.scrollSpeed;
                }

                // translate horizontal closeness into velocity
                if (leftCloseness >= 0 && leftCloseness <= 1) {
                    leftVel = leftCloseness * this.scrollSpeed * -1; // negative. for scrolling left
                } else if (rightCloseness >= 0 && rightCloseness <= 1) {
                    leftVel = rightCloseness * this.scrollSpeed;
                }
            }

            this.setScrollVel(topVel, leftVel);
        },
        // Sets the speed-of-scrolling for the scrollEl
        setScrollVel: function (topVel, leftVel) {

            this.scrollTopVel = topVel;
            this.scrollLeftVel = leftVel;

            this.constrainScrollVel(); // massages into realistic values

            // if there is non-zero velocity, and an animation loop hasn't already started, then START
            if ((this.scrollTopVel || this.scrollLeftVel) && !this.scrollIntervalId) {
                this.scrollIntervalId = setInterval(
                    proxy(this, 'scrollIntervalFunc'), // scope to `this`
                    this.scrollIntervalMs
                    );
            }
        },
        // Forces scrollTopVel and scrollLeftVel to be zero if scrolling has already gone all the way
        constrainScrollVel: function () {
            var el = this.scrollEl;

            if (this.scrollTopVel < 0) { // scrolling up?
                if (el.scrollTop() <= 0) { // already scrolled all the way up?
                    this.scrollTopVel = 0;
                }
            } else if (this.scrollTopVel > 0) { // scrolling down?
                if (el.scrollTop() + el[0].clientHeight >= el[0].scrollHeight) { // already scrolled all the way down?
                    this.scrollTopVel = 0;
                }
            }

            if (this.scrollLeftVel < 0) { // scrolling left?
                if (el.scrollLeft() <= 0) { // already scrolled all the left?
                    this.scrollLeftVel = 0;
                }
            } else if (this.scrollLeftVel > 0) { // scrolling right?
                if (el.scrollLeft() + el[0].clientWidth >= el[0].scrollWidth) { // already scrolled all the way right?
                    this.scrollLeftVel = 0;
                }
            }
        },
        // This function gets called during every iteration of the scrolling animation loop
        scrollIntervalFunc: function () {
            var el = this.scrollEl;
            var frac = this.scrollIntervalMs / 1000; // considering animation frequency, what the vel should be mult'd by

            // change the value of scrollEl's scroll
            if (this.scrollTopVel) {
                el.scrollTop(el.scrollTop() + this.scrollTopVel * frac);
            }
            if (this.scrollLeftVel) {
                el.scrollLeft(el.scrollLeft() + this.scrollLeftVel * frac);
            }

            this.constrainScrollVel(); // since the scroll values changed, recompute the velocities

            // if scrolled all the way, which causes the vels to be zero, stop the animation loop
            if (!this.scrollTopVel && !this.scrollLeftVel) {
                this.endAutoScroll();
            }
        },
        // Kills any existing scrolling animation loop
        endAutoScroll: function () {
            if (this.scrollIntervalId) {
                clearInterval(this.scrollIntervalId);
                this.scrollIntervalId = null;

                this.handleScrollEnd();
            }
        },
        // Get called when the scrollEl is scrolled (NOTE: this is delayed via debounce)
        handleDebouncedScroll: function () {
            // recompute all coordinates, but *only* if this is *not* part of our scrolling animation
            if (!this.scrollIntervalId) {
                this.handleScrollEnd();
            }
        },
        // Called when scrolling has stopped, whether through auto scroll, or the user scrolling
        handleScrollEnd: function () {
        }

    });
    ;
    ;

    /* Tracks mouse movements over a component and raises events about which hit the mouse is over.
     ------------------------------------------------------------------------------------------------------------------------
     options:
     - subjectEl
     - subjectCenter
     */

    var HitDragListener = DragListener.extend({
        component: null, // converts coordinates to hits
        // methods: prepareHits, releaseHits, queryHit

        origHit: null, // the hit the mouse was over when listening started
        hit: null, // the hit the mouse is over
        coordAdjust: null, // delta that will be added to the mouse coordinates when computing collisions


        constructor: function (component, options) {
            DragListener.call(this, options); // call the super-constructor

            this.component = component;
        },
        // Called when drag listening starts (but a real drag has not necessarily began).
        // ev might be undefined if dragging was started manually.
        handleInteractionStart: function (ev) {
            var subjectEl = this.subjectEl;
            var subjectRect;
            var origPoint;
            var point;

            this.computeCoords();

            if (ev) {
                origPoint = {left: getEvX(ev), top: getEvY(ev)};
                point = origPoint;

                // constrain the point to bounds of the element being dragged
                if (subjectEl) {
                    subjectRect = getOuterRect(subjectEl); // used for centering as well
                    point = constrainPoint(point, subjectRect);
                }

                this.origHit = this.queryHit(point.left, point.top);

                // treat the center of the subject as the collision point?
                if (subjectEl && this.options.subjectCenter) {

                    // only consider the area the subject overlaps the hit. best for large subjects.
                    // TODO: skip this if hit didn't supply left/right/top/bottom
                    if (this.origHit) {
                        subjectRect = intersectRects(this.origHit, subjectRect) ||
                            subjectRect; // in case there is no intersection
                    }

                    point = getRectCenter(subjectRect);
                }

                this.coordAdjust = diffPoints(point, origPoint); // point - origPoint
            } else {
                this.origHit = null;
                this.coordAdjust = null;
            }

            // call the super-method. do it after origHit has been computed
            DragListener.prototype.handleInteractionStart.apply(this, arguments);
        },
        // Recomputes the drag-critical positions of elements
        computeCoords: function () {
            this.component.prepareHits();
            this.computeScrollBounds(); // why is this here??????
        },
        // Called when the actual drag has started
        handleDragStart: function (ev) {
            var hit;

            DragListener.prototype.handleDragStart.apply(this, arguments); // call the super-method

            // might be different from this.origHit if the min-distance is large
            hit = this.queryHit(getEvX(ev), getEvY(ev));

            // report the initial hit the mouse is over
            // especially important if no min-distance and drag starts immediately
            if (hit) {
                this.handleHitOver(hit);
            }
        },
        // Called when the drag moves
        handleDrag: function (dx, dy, ev) {
            var hit;

            DragListener.prototype.handleDrag.apply(this, arguments); // call the super-method

            hit = this.queryHit(getEvX(ev), getEvY(ev));

            if (!isHitsEqual(hit, this.hit)) { // a different hit than before?
                if (this.hit) {
                    this.handleHitOut();
                }
                if (hit) {
                    this.handleHitOver(hit);
                }
            }
        },
        // Called when dragging has been stopped
        handleDragEnd: function () {
            this.handleHitDone();
            DragListener.prototype.handleDragEnd.apply(this, arguments); // call the super-method
        },
        // Called when a the mouse has just moved over a new hit
        handleHitOver: function (hit) {
            var isOrig = isHitsEqual(hit, this.origHit);

            this.hit = hit;

            this.trigger('hitOver', this.hit, isOrig, this.origHit);
        },
        // Called when the mouse has just moved out of a hit
        handleHitOut: function () {
            if (this.hit) {
                this.trigger('hitOut', this.hit);
                this.handleHitDone();
                this.hit = null;
            }
        },
        // Called after a hitOut. Also called before a dragStop
        handleHitDone: function () {
            if (this.hit) {
                this.trigger('hitDone', this.hit);
            }
        },
        // Called when the interaction ends, whether there was a real drag or not
        handleInteractionEnd: function () {
            DragListener.prototype.handleInteractionEnd.apply(this, arguments); // call the super-method

            this.origHit = null;
            this.hit = null;

            this.component.releaseHits();
        },
        // Called when scrolling has stopped, whether through auto scroll, or the user scrolling
        handleScrollEnd: function () {
            DragListener.prototype.handleScrollEnd.apply(this, arguments); // call the super-method

            this.computeCoords(); // hits' absolute positions will be in new places. recompute
        },
        // Gets the hit underneath the coordinates for the given mouse event
        queryHit: function (left, top) {

            if (this.coordAdjust) {
                left += this.coordAdjust.left;
                top += this.coordAdjust.top;
            }

            return this.component.queryHit(left, top);
        }

    });


// Returns `true` if the hits are identically equal. `false` otherwise. Must be from the same component.
// Two null values will be considered equal, as two "out of the component" states are the same.
    function isHitsEqual(hit0, hit1) {

        if (!hit0 && !hit1) {
            return true;
        }

        if (hit0 && hit1) {
            return hit0.component === hit1.component &&
                isHitPropsWithin(hit0, hit1) &&
                isHitPropsWithin(hit1, hit0); // ensures all props are identical
        }

        return false;
    }


// Returns true if all of subHit's non-standard properties are within superHit
    function isHitPropsWithin(subHit, superHit) {
        for (var propName in subHit) {
            if (!/^(component|left|right|top|bottom)$/.test(propName)) {
                if (subHit[propName] !== superHit[propName]) {
                    return false;
                }
            }
        }
        return true;
    }

    ;
    ;

    /* Creates a clone of an element and lets it track the mouse as it moves
     ----------------------------------------------------------------------------------------------------------------------*/

    var MouseFollower = Class.extend(ListenerMixin, {
        options: null,
        sourceEl: null, // the element that will be cloned and made to look like it is dragging
        el: null, // the clone of `sourceEl` that will track the mouse
        parentEl: null, // the element that `el` (the clone) will be attached to

        // the initial position of el, relative to the offset parent. made to match the initial offset of sourceEl
        top0: null,
        left0: null,
        // the absolute coordinates of the initiating touch/mouse action
        y0: null,
        x0: null,
        // the number of pixels the mouse has moved from its initial position
        topDelta: null,
        leftDelta: null,
        isFollowing: false,
        isHidden: false,
        isAnimating: false, // doing the revert animation?

        constructor: function (sourceEl, options) {
            this.options = options = options || {};
            this.sourceEl = sourceEl;
            this.parentEl = options.parentEl ? $(options.parentEl) : sourceEl.parent(); // default to sourceEl's parent
        },
        // Causes the element to start following the mouse
        start: function (ev) {
            if (!this.isFollowing) {
                this.isFollowing = true;

                this.y0 = getEvY(ev);
                this.x0 = getEvX(ev);
                this.topDelta = 0;
                this.leftDelta = 0;

                if (!this.isHidden) {
                    this.updatePosition();
                }

                if (getEvIsTouch(ev)) {
                    this.listenTo($(document), 'touchmove', this.handleMove);
                } else {
                    this.listenTo($(document), 'mousemove', this.handleMove);
                }
            }
        },
        // Causes the element to stop following the mouse. If shouldRevert is true, will animate back to original position.
        // `callback` gets invoked when the animation is complete. If no animation, it is invoked immediately.
        stop: function (shouldRevert, callback) {
            var _this = this;
            var revertDuration = this.options.revertDuration;

            function complete() {
                this.isAnimating = false;
                _this.removeElement();

                this.top0 = this.left0 = null; // reset state for future updatePosition calls

                if (callback) {
                    callback();
                }
            }

            if (this.isFollowing && !this.isAnimating) { // disallow more than one stop animation at a time
                this.isFollowing = false;

                this.stopListeningTo($(document));

                if (shouldRevert && revertDuration && !this.isHidden) { // do a revert animation?
                    this.isAnimating = true;
                    this.el.animate({
                        top: this.top0,
                        left: this.left0
                    }, {
                        duration: revertDuration,
                        complete: complete
                    });
                } else {
                    complete();
                }
            }
        },
        // Gets the tracking element. Create it if necessary
        getEl: function () {
            var el = this.el;

            if (!el) {
                this.sourceEl.width(); // hack to force IE8 to compute correct bounding box
                el = this.el = this.sourceEl.clone()
                    .addClass(this.options.additionalClass || '')
                    .css({
                        position: 'absolute',
                        visibility: '', // in case original element was hidden (commonly through hideEvents())
                        display: this.isHidden ? 'none' : '', // for when initially hidden
                        margin: 0,
                        right: 'auto', // erase and set width instead
                        bottom: 'auto', // erase and set height instead
                        width: this.sourceEl.width(), // explicit height in case there was a 'right' value
                        height: this.sourceEl.height(), // explicit width in case there was a 'bottom' value
                        opacity: this.options.opacity || '',
                        zIndex: this.options.zIndex
                    });

                // we don't want long taps or any mouse interaction causing selection/menus.
                // would use preventSelection(), but that prevents selectstart, causing problems.
                el.addClass('fc-unselectable');

                el.appendTo(this.parentEl);
            }

            return el;
        },
        // Removes the tracking element if it has already been created
        removeElement: function () {
            if (this.el) {
                this.el.remove();
                this.el = null;
            }
        },
        // Update the CSS position of the tracking element
        updatePosition: function () {
            var sourceOffset;
            var origin;

            this.getEl(); // ensure this.el

            // make sure origin info was computed
            if (this.top0 === null) {
                this.sourceEl.width(); // hack to force IE8 to compute correct bounding box
                sourceOffset = this.sourceEl.offset();
                origin = this.el.offsetParent().offset();
                this.top0 = sourceOffset.top - origin.top;
                this.left0 = sourceOffset.left - origin.left;
            }

            this.el.css({
                top: this.top0 + this.topDelta,
                left: this.left0 + this.leftDelta
            });
        },
        // Gets called when the user moves the mouse
        handleMove: function (ev) {
            this.topDelta = getEvY(ev) - this.y0;
            this.leftDelta = getEvX(ev) - this.x0;

            if (!this.isHidden) {
                this.updatePosition();
            }
        },
        // Temporarily makes the tracking element invisible. Can be called before following starts
        hide: function () {
            if (!this.isHidden) {
                this.isHidden = true;
                if (this.el) {
                    this.el.hide();
                }
            }
        },
        // Show the tracking element after it has been temporarily hidden
        show: function () {
            if (this.isHidden) {
                this.isHidden = false;
                this.updatePosition();
                this.getEl().show();
            }
        }

    });

    ;
    ;

    /* An abstract class comprised of a "grid" of areas that each represent a specific datetime
     ----------------------------------------------------------------------------------------------------------------------*/

    var Grid = FC.Grid = Class.extend(ListenerMixin, MouseIgnorerMixin, {
        view: null, // a View object
        isRTL: null, // shortcut to the view's isRTL option

        start: null,
        end: null,
        el: null, // the containing element
        elsByFill: null, // a hash of jQuery element sets used for rendering each fill. Keyed by fill name.

        // derived from options
        eventTimeFormat: null,
        displayEventTime: null,
        displayEventEnd: null,
        minResizeDuration: null, // TODO: hack. set by subclasses. minumum event resize duration

        // if defined, holds the unit identified (ex: "year" or "month") that determines the level of granularity
        // of the date areas. if not defined, assumes to be day and time granularity.
        // TODO: port isTimeScale into same system?
        largeUnit: null,
        dayDragListener: null,
        segDragListener: null,
        segResizeListener: null,
        externalDragListener: null,
        constructor: function (view) {
            this.view = view;
            this.isRTL = view.opt('isRTL');
            this.elsByFill = {};

            this.dayDragListener = this.buildDayDragListener();
            this.initMouseIgnoring();
        },
        /* Options
         ------------------------------------------------------------------------------------------------------------------*/


        // Generates the format string used for event time text, if not explicitly defined by 'timeFormat'
        computeEventTimeFormat: function () {
            return this.view.opt('smallTimeFormat');
        },
        // Determines whether events should have their end times displayed, if not explicitly defined by 'displayEventTime'.
        // Only applies to non-all-day events.
        computeDisplayEventTime: function () {
            return true;
        },
        // Determines whether events should have their end times displayed, if not explicitly defined by 'displayEventEnd'
        computeDisplayEventEnd: function () {
            return true;
        },
        /* Dates
         ------------------------------------------------------------------------------------------------------------------*/


        // Tells the grid about what period of time to display.
        // Any date-related internal data should be generated.
        setRange: function (range) {
            this.start = range.start.clone();
            this.end = range.end.clone();

            this.rangeUpdated();
            this.processRangeOptions();
        },
        // Called when internal variables that rely on the range should be updated
        rangeUpdated: function () {
        },
        // Updates values that rely on options and also relate to range
        processRangeOptions: function () {
            var view = this.view;
            var displayEventTime;
            var displayEventEnd;

            this.eventTimeFormat =
                view.opt('eventTimeFormat') ||
                view.opt('timeFormat') || // deprecated
                this.computeEventTimeFormat();

            displayEventTime = view.opt('displayEventTime');
            if (displayEventTime == null) {
                displayEventTime = this.computeDisplayEventTime(); // might be based off of range
            }

            displayEventEnd = view.opt('displayEventEnd');
            if (displayEventEnd == null) {
                displayEventEnd = this.computeDisplayEventEnd(); // might be based off of range
            }

            this.displayEventTime = displayEventTime;
            this.displayEventEnd = displayEventEnd;
        },
        // Converts a span (has unzoned start/end and any other grid-specific location information)
        // into an array of segments (pieces of events whose format is decided by the grid).
        spanToSegs: function (span) {
            // subclasses must implement
        },
        // Diffs the two dates, returning a duration, based on granularity of the grid
        // TODO: port isTimeScale into this system?
        diffDates: function (a, b) {
            if (this.largeUnit) {
                return diffByUnit(a, b, this.largeUnit);
            } else {
                return diffDayTime(a, b);
            }
        },
        /* Hit Area
         ------------------------------------------------------------------------------------------------------------------*/


        // Called before one or more queryHit calls might happen. Should prepare any cached coordinates for queryHit
        prepareHits: function () {
        },
        // Called when queryHit calls have subsided. Good place to clear any coordinate caches.
        releaseHits: function () {
        },
        // Given coordinates from the topleft of the document, return data about the date-related area underneath.
        // Can return an object with arbitrary properties (although top/right/left/bottom are encouraged).
        // Must have a `grid` property, a reference to this current grid. TODO: avoid this
        // The returned object will be processed by getHitSpan and getHitEl.
        queryHit: function (leftOffset, topOffset) {
        },
        // Given position-level information about a date-related area within the grid,
        // should return an object with at least a start/end date. Can provide other information as well.
        getHitSpan: function (hit) {
        },
        // Given position-level information about a date-related area within the grid,
        // should return a jQuery element that best represents it. passed to dayClick callback.
        getHitEl: function (hit) {
        },
        /* Rendering
         ------------------------------------------------------------------------------------------------------------------*/


        // Sets the container element that the grid should render inside of.
        // Does other DOM-related initializations.
        setElement: function (el) {
            this.el = el;
            preventSelection(el);

            this.bindDayHandler('touchstart', this.dayTouchStart);
            this.bindDayHandler('mousedown', this.dayMousedown);

            // attach event-element-related handlers. in Grid.events
            // same garbage collection note as above.
            this.bindSegHandlers();

            this.bindGlobalHandlers();
        },
        bindDayHandler: function (name, handler) {
            var _this = this;

            // attach a handler to the grid's root element.
            // jQuery will take care of unregistering them when removeElement gets called.
            this.el.on(name, function (ev) {
                if (
                    !$(ev.target).is('.fc-event-container *, .fc-more') && // not an an event element, or "more.." link
                    !$(ev.target).closest('.fc-popover').length // not on a popover (like the "more.." events one)
                    ) {
                    return handler.call(_this, ev);
                }
            });
        },
        // Removes the grid's container element from the DOM. Undoes any other DOM-related attachments.
        // DOES NOT remove any content beforehand (doesn't clear events or call unrenderDates), unlike View
        removeElement: function () {
            this.unbindGlobalHandlers();
            this.clearDragListeners();

            this.el.remove();

            // NOTE: we don't null-out this.el for the same reasons we don't do it within View::removeElement
        },
        // Renders the basic structure of grid view before any content is rendered
        renderSkeleton: function () {
            // subclasses should implement
        },
        // Renders the grid's date-related content (like areas that represent days/times).
        // Assumes setRange has already been called and the skeleton has already been rendered.
        renderDates: function () {
            // subclasses should implement
        },
        // Unrenders the grid's date-related content
        unrenderDates: function () {
            // subclasses should implement
        },
        /* Handlers
         ------------------------------------------------------------------------------------------------------------------*/


        // Binds DOM handlers to elements that reside outside the grid, such as the document
        bindGlobalHandlers: function () {
            this.listenTo($(document), {
                dragstart: this.externalDragStart, // jqui
                sortstart: this.externalDragStart // jqui
            });
        },
        // Unbinds DOM handlers from elements that reside outside the grid
        unbindGlobalHandlers: function () {
            this.stopListeningTo($(document));
        },
        // Process a mousedown on an element that represents a day. For day clicking and selecting.
        dayMousedown: function (ev) {
            if (!this.isIgnoringMouse) {
                this.dayDragListener.startInteraction(ev, {
                    //distance: 5, // needs more work if we want dayClick to fire correctly
                });
            }
        },
        dayTouchStart: function (ev) {
            var view = this.view;

            // HACK to prevent a user's clickaway for unselecting a range or an event
            // from causing a dayClick.
            if (view.isSelected || view.selectedEvent) {
                this.tempIgnoreMouse();
            }

            this.dayDragListener.startInteraction(ev, {
                delay: this.view.opt('longPressDelay')
            });
        },
        // Creates a listener that tracks the user's drag across day elements.
        // For day clicking and selecting.
        buildDayDragListener: function () {
            var _this = this;
            var view = this.view;
            var isSelectable = view.opt('selectable');
            var dayClickHit; // null if invalid dayClick
            var selectionSpan; // null if invalid selection

            // this listener tracks a mousedown on a day element, and a subsequent drag.
            // if the drag ends on the same day, it is a 'dayClick'.
            // if 'selectable' is enabled, this listener also detects selections.
            var dragListener = new HitDragListener(this, {
                scroll: view.opt('dragScroll'),
                interactionStart: function () {
                    dayClickHit = dragListener.origHit; // for dayClick, where no dragging happens
                },
                dragStart: function () {
                    view.unselect(); // since we could be rendering a new selection, we want to clear any old one
                },
                hitOver: function (hit, isOrig, origHit) {
                    if (origHit) { // click needs to have started on a hit

                        // if user dragged to another cell at any point, it can no longer be a dayClick
                        if (!isOrig) {
                            dayClickHit = null;
                        }

                        if (isSelectable) {
                            selectionSpan = _this.computeSelection(
                                _this.getHitSpan(origHit),
                                _this.getHitSpan(hit)
                                );
                            if (selectionSpan) {
                                _this.renderSelection(selectionSpan);
                            } else if (selectionSpan === false) {
                                disableCursor();
                            }
                        }
                    }
                },
                hitOut: function () {
                    dayClickHit = null;
                    selectionSpan = null;
                    _this.unrenderSelection();
                    enableCursor();
                },
                interactionEnd: function (ev, isCancelled) {
                    if (!isCancelled) {
                        if (
                            dayClickHit &&
                            !_this.isIgnoringMouse // see hack in dayTouchStart
                            ) {
                            view.triggerDayClick(
                                _this.getHitSpan(dayClickHit),
                                _this.getHitEl(dayClickHit),
                                ev
                                );
                        }
                        if (selectionSpan) {
                            // the selection will already have been rendered. just report it
                            view.reportSelection(selectionSpan, ev);
                        }
                        enableCursor();
                    }
                }
            });

            return dragListener;
        },
        // Kills all in-progress dragging.
        // Useful for when public API methods that result in re-rendering are invoked during a drag.
        // Also useful for when touch devices misbehave and don't fire their touchend.
        clearDragListeners: function () {
            this.dayDragListener.endInteraction();

            if (this.segDragListener) {
                this.segDragListener.endInteraction(); // will clear this.segDragListener
            }
            if (this.segResizeListener) {
                this.segResizeListener.endInteraction(); // will clear this.segResizeListener
            }
            if (this.externalDragListener) {
                this.externalDragListener.endInteraction(); // will clear this.externalDragListener
            }
        },
        /* Event Helper
         ------------------------------------------------------------------------------------------------------------------*/
        // TODO: should probably move this to Grid.events, like we did event dragging / resizing


        // Renders a mock event at the given event location, which contains zoned start/end properties.
        // Returns all mock event elements.
        renderEventLocationHelper: function (eventLocation, sourceSeg) {
            var fakeEvent = this.fabricateHelperEvent(eventLocation, sourceSeg);

            return this.renderHelper(fakeEvent, sourceSeg); // do the actual rendering
        },
        // Builds a fake event given zoned event date properties and a segment is should be inspired from.
        // The range's end can be null, in which case the mock event that is rendered will have a null end time.
        // `sourceSeg` is the internal segment object involved in the drag. If null, something external is dragging.
        fabricateHelperEvent: function (eventLocation, sourceSeg) {
            var fakeEvent = sourceSeg ? createObject(sourceSeg.event) : {}; // mask the original event object if possible

            fakeEvent.start = eventLocation.start.clone();
            fakeEvent.end = eventLocation.end ? eventLocation.end.clone() : null;
            fakeEvent.allDay = null; // force it to be freshly computed by normalizeEventDates
            this.view.calendar.normalizeEventDates(fakeEvent);

            // this extra className will be useful for differentiating real events from mock events in CSS
            fakeEvent.className = (fakeEvent.className || []).concat('fc-helper');

            // if something external is being dragged in, don't render a resizer
            if (!sourceSeg) {
                fakeEvent.editable = false;
            }

            return fakeEvent;
        },
        // Renders a mock event. Given zoned event date properties.
        // Must return all mock event elements.
        renderHelper: function (eventLocation, sourceSeg) {
            // subclasses must implement
        },
        // Unrenders a mock event
        unrenderHelper: function () {
            // subclasses must implement
        },
        /* Selection
         ------------------------------------------------------------------------------------------------------------------*/


        // Renders a visual indication of a selection. Will highlight by default but can be overridden by subclasses.
        // Given a span (unzoned start/end and other misc data)
        renderSelection: function (span) {
            this.renderHighlight(span);
        },
        // Unrenders any visual indications of a selection. Will unrender a highlight by default.
        unrenderSelection: function () {
            this.unrenderHighlight();
        },
        // Given the first and last date-spans of a selection, returns another date-span object.
        // Subclasses can override and provide additional data in the span object. Will be passed to renderSelection().
        // Will return false if the selection is invalid and this should be indicated to the user.
        // Will return null/undefined if a selection invalid but no error should be reported.
        computeSelection: function (span0, span1) {
            var span = this.computeSelectionSpan(span0, span1);

            if (span && !this.view.calendar.isSelectionSpanAllowed(span)) {
                return false;
            }

            return span;
        },
        // Given two spans, must return the combination of the two.
        // TODO: do this separation of concerns (combining VS validation) for event dnd/resize too.
        computeSelectionSpan: function (span0, span1) {
            var dates = [span0.start, span0.end, span1.start, span1.end];

            dates.sort(compareNumbers); // sorts chronologically. works with Moments

            return {start: dates[0].clone(), end: dates[3].clone()};
        },
        /* Highlight
         ------------------------------------------------------------------------------------------------------------------*/


        // Renders an emphasis on the given date range. Given a span (unzoned start/end and other misc data)
        renderHighlight: function (span) {
            this.renderFill('highlight', this.spanToSegs(span));
        },
        // Unrenders the emphasis on a date range
        unrenderHighlight: function () {
            this.unrenderFill('highlight');
        },
        // Generates an array of classNames for rendering the highlight. Used by the fill system.
        highlightSegClasses: function () {
            return ['fc-highlight'];
        },
        /* Business Hours
         ------------------------------------------------------------------------------------------------------------------*/


        renderBusinessHours: function () {
        },
        unrenderBusinessHours: function () {
        },
        /* Now Indicator
         ------------------------------------------------------------------------------------------------------------------*/


        getNowIndicatorUnit: function () {
        },
        renderNowIndicator: function (date) {
        },
        unrenderNowIndicator: function () {
        },
        /* Fill System (highlight, background events, business hours)
         --------------------------------------------------------------------------------------------------------------------
         TODO: remove this system. like we did in TimeGrid
         */


        // Renders a set of rectangles over the given segments of time.
        // MUST RETURN a subset of segs, the segs that were actually rendered.
        // Responsible for populating this.elsByFill. TODO: better API for expressing this requirement
        renderFill: function (type, segs) {
            // subclasses must implement
        },
        // Unrenders a specific type of fill that is currently rendered on the grid
        unrenderFill: function (type) {
            var el = this.elsByFill[type];

            if (el) {
                el.remove();
                delete this.elsByFill[type];
            }
        },
        // Renders and assigns an `el` property for each fill segment. Generic enough to work with different types.
        // Only returns segments that successfully rendered.
        // To be harnessed by renderFill (implemented by subclasses).
        // Analagous to renderFgSegEls.
        renderFillSegEls: function (type, segs) {
            var _this = this;
            var segElMethod = this[type + 'SegEl'];
            var html = '';
            var renderedSegs = [];
            var i;

            if (segs.length) {

                // build a large concatenation of segment HTML
                for (i = 0; i < segs.length; i++) {
                    html += this.fillSegHtml(type, segs[i]);
                }

                // Grab individual elements from the combined HTML string. Use each as the default rendering.
                // Then, compute the 'el' for each segment.
                $(html).each(function (i, node) {
                    var seg = segs[i];
                    var el = $(node);

                    // allow custom filter methods per-type
                    if (segElMethod) {
                        el = segElMethod.call(_this, seg, el);
                    }

                    if (el) { // custom filters did not cancel the render
                        el = $(el); // allow custom filter to return raw DOM node

                        // correct element type? (would be bad if a non-TD were inserted into a table for example)
                        if (el.is(_this.fillSegTag)) {
                            seg.el = el;
                            renderedSegs.push(seg);
                        }
                    }
                });
            }

            return renderedSegs;
        },
        fillSegTag: 'div', // subclasses can override


        // Builds the HTML needed for one fill segment. Generic enought o work with different types.
        fillSegHtml: function (type, seg) {

            // custom hooks per-type
            var classesMethod = this[type + 'SegClasses'];
            var cssMethod = this[type + 'SegCss'];

            var classes = classesMethod ? classesMethod.call(this, seg) : [];
            var css = cssToStr(cssMethod ? cssMethod.call(this, seg) : {});

            return '<' + this.fillSegTag +
                (classes.length ? ' class="' + classes.join(' ') + '"' : '') +
                (css ? ' style="' + css + '"' : '') +
                ' />';
        },
        /* Generic rendering utilities for subclasses
         ------------------------------------------------------------------------------------------------------------------*/


        // Computes HTML classNames for a single-day element
        getDayClasses: function (date) {
            var view = this.view;
            var today = view.calendar.getNow();
            var classes = ['fc-' + dayIDs[date.day()]];

            if (
                view.intervalDuration.as('months') == 1 &&
                date.month() != view.intervalStart.month()
                ) {
                classes.push('fc-other-month');
            }

            if (date.isSame(today, 'day')) {
                classes.push(
                    'fc-today',
                    view.highlightStateClass
                    );
            } else if (date < today) {
                classes.push('fc-past');
            } else {
                classes.push('fc-future');
            }

            return classes;
        }

    });

    ;
    ;

    /* Event-rendering and event-interaction methods for the abstract Grid class
     ----------------------------------------------------------------------------------------------------------------------*/

    Grid.mixin({
        mousedOverSeg: null, // the segment object the user's mouse is over. null if over nothing
        isDraggingSeg: false, // is a segment being dragged? boolean
        isResizingSeg: false, // is a segment being resized? boolean
        isDraggingExternal: false, // jqui-dragging an external element? boolean
        segs: null, // the *event* segments currently rendered in the grid. TODO: rename to `eventSegs`


        // Renders the given events onto the grid
        renderEvents: function (events) {
            var bgEvents = [];
            var fgEvents = [];
            var i;

            for (i = 0; i < events.length; i++) {
                (isBgEvent(events[i]) ? bgEvents : fgEvents).push(events[i]);
            }

            this.segs = [].concat(// record all segs
                this.renderBgEvents(bgEvents),
                this.renderFgEvents(fgEvents)
                );
        },
        renderBgEvents: function (events) {
            var segs = this.eventsToSegs(events);

            // renderBgSegs might return a subset of segs, segs that were actually rendered
            return this.renderBgSegs(segs) || segs;
        },
        renderFgEvents: function (events) {
            var segs = this.eventsToSegs(events);

            // renderFgSegs might return a subset of segs, segs that were actually rendered
            return this.renderFgSegs(segs) || segs;
        },
        // Unrenders all events currently rendered on the grid
        unrenderEvents: function () {
            this.handleSegMouseout(); // trigger an eventMouseout if user's mouse is over an event
            this.clearDragListeners();

            this.unrenderFgSegs();
            this.unrenderBgSegs();

            this.segs = null;
        },
        // Retrieves all rendered segment objects currently rendered on the grid
        getEventSegs: function () {
            return this.segs || [];
        },
        /* Foreground Segment Rendering
         ------------------------------------------------------------------------------------------------------------------*/


        // Renders foreground event segments onto the grid. May return a subset of segs that were rendered.
        renderFgSegs: function (segs) {
            // subclasses must implement
        },
        // Unrenders all currently rendered foreground segments
        unrenderFgSegs: function () {
            // subclasses must implement
        },
        // Renders and assigns an `el` property for each foreground event segment.
        // Only returns segments that successfully rendered.
        // A utility that subclasses may use.
        renderFgSegEls: function (segs, disableResizing) {
            var view = this.view;
            var html = '';
            var renderedSegs = [];
            var i;

            if (segs.length) { // don't build an empty html string

                // build a large concatenation of event segment HTML
                for (i = 0; i < segs.length; i++) {
                    html += this.fgSegHtml(segs[i], disableResizing);
                }

                // Grab individual elements from the combined HTML string. Use each as the default rendering.
                // Then, compute the 'el' for each segment. An el might be null if the eventRender callback returned false.
                $(html).each(function (i, node) {
                    var seg = segs[i];
                    var el = view.resolveEventEl(seg.event, $(node));

                    if (el) {
                        el.data('fc-seg', seg); // used by handlers
                        seg.el = el;
                        renderedSegs.push(seg);
                    }
                });
            }

            return renderedSegs;
        },
        // Generates the HTML for the default rendering of a foreground event segment. Used by renderFgSegEls()
        fgSegHtml: function (seg, disableResizing) {
            // subclasses should implement
        },
        /* Background Segment Rendering
         ------------------------------------------------------------------------------------------------------------------*/


        // Renders the given background event segments onto the grid.
        // Returns a subset of the segs that were actually rendered.
        renderBgSegs: function (segs) {
            return this.renderFill('bgEvent', segs);
        },
        // Unrenders all the currently rendered background event segments
        unrenderBgSegs: function () {
            this.unrenderFill('bgEvent');
        },
        // Renders a background event element, given the default rendering. Called by the fill system.
        bgEventSegEl: function (seg, el) {
            return this.view.resolveEventEl(seg.event, el); // will filter through eventRender
        },
        // Generates an array of classNames to be used for the default rendering of a background event.
        // Called by the fill system.
        bgEventSegClasses: function (seg) {
            var event = seg.event;
            var source = event.source || {};

            return ['fc-bgevent'].concat(
                event.className,
                source.className || []
                );
        },
        // Generates a semicolon-separated CSS string to be used for the default rendering of a background event.
        // Called by the fill system.
        bgEventSegCss: function (seg) {
            return {
                'background-color': this.getSegSkinCss(seg)['background-color']
            };
        },
        // Generates an array of classNames to be used for the rendering business hours overlay. Called by the fill system.
        businessHoursSegClasses: function (seg) {
            return ['fc-nonbusiness', 'fc-bgevent'];
        },
        /* Handlers
         ------------------------------------------------------------------------------------------------------------------*/


        // Attaches event-element-related handlers to the container element and leverage bubbling
        bindSegHandlers: function () {
            this.bindSegHandler('touchstart', this.handleSegTouchStart);
            this.bindSegHandler('touchend', this.handleSegTouchEnd);
            this.bindSegHandler('mouseenter', this.handleSegMouseover);
            this.bindSegHandler('mouseleave', this.handleSegMouseout);
            this.bindSegHandler('mousedown', this.handleSegMousedown);
            this.bindSegHandler('click', this.handleSegClick);
        },
        // Executes a handler for any a user-interaction on a segment.
        // Handler gets called with (seg, ev), and with the `this` context of the Grid
        bindSegHandler: function (name, handler) {
            var _this = this;

            this.el.on(name, '.fc-event-container > *', function (ev) {
                var seg = $(this).data('fc-seg'); // grab segment data. put there by View::renderEvents

                // only call the handlers if there is not a drag/resize in progress
                if (seg && !_this.isDraggingSeg && !_this.isResizingSeg) {
                    return handler.call(_this, seg, ev); // context will be the Grid
                }
            });
        },
        handleSegClick: function (seg, ev) {
            return this.view.trigger('eventClick', seg.el[0], seg.event, ev); // can return `false` to cancel
        },
        // Updates internal state and triggers handlers for when an event element is moused over
        handleSegMouseover: function (seg, ev) {
            if (
                !this.isIgnoringMouse &&
                !this.mousedOverSeg
                ) {
                this.mousedOverSeg = seg;
                seg.el.addClass('fc-allow-mouse-resize');
                this.view.trigger('eventMouseover', seg.el[0], seg.event, ev);
            }
        },
        // Updates internal state and triggers handlers for when an event element is moused out.
        // Can be given no arguments, in which case it will mouseout the segment that was previously moused over.
        handleSegMouseout: function (seg, ev) {
            ev = ev || {}; // if given no args, make a mock mouse event

            if (this.mousedOverSeg) {
                seg = seg || this.mousedOverSeg; // if given no args, use the currently moused-over segment
                this.mousedOverSeg = null;
                seg.el.removeClass('fc-allow-mouse-resize');
                this.view.trigger('eventMouseout', seg.el[0], seg.event, ev);
            }
        },
        handleSegMousedown: function (seg, ev) {
            var isResizing = this.startSegResize(seg, ev, {distance: 5});

            if (!isResizing && this.view.isEventDraggable(seg.event)) {
                this.buildSegDragListener(seg)
                    .startInteraction(ev, {
                        distance: 5
                    });
            }
        },
        handleSegTouchStart: function (seg, ev) {
            var view = this.view;
            var event = seg.event;
            var isSelected = view.isEventSelected(event);
            var isDraggable = view.isEventDraggable(event);
            var isResizable = view.isEventResizable(event);
            var isResizing = false;
            var dragListener;

            if (isSelected && isResizable) {
                // only allow resizing of the event is selected
                isResizing = this.startSegResize(seg, ev);
            }

            if (!isResizing && (isDraggable || isResizable)) { // allowed to be selected?

                dragListener = isDraggable ?
                    this.buildSegDragListener(seg) :
                    this.buildSegSelectListener(seg); // seg isn't draggable, but still needs to be selected

                dragListener.startInteraction(ev, {// won't start if already started
                    delay: isSelected ? 0 : this.view.opt('longPressDelay') // do delay if not already selected
                });
            }

            // a long tap simulates a mouseover. ignore this bogus mouseover.
            this.tempIgnoreMouse();
        },
        handleSegTouchEnd: function (seg, ev) {
            // touchstart+touchend = click, which simulates a mouseover.
            // ignore this bogus mouseover.
            this.tempIgnoreMouse();
        },
        // returns boolean whether resizing actually started or not.
        // assumes the seg allows resizing.
        // `dragOptions` are optional.
        startSegResize: function (seg, ev, dragOptions) {
            if ($(ev.target).is('.fc-resizer')) {
                this.buildSegResizeListener(seg, $(ev.target).is('.fc-start-resizer'))
                    .startInteraction(ev, dragOptions);
                return true;
            }
            return false;
        },
        /* Event Dragging
         ------------------------------------------------------------------------------------------------------------------*/


        // Builds a listener that will track user-dragging on an event segment.
        // Generic enough to work with any type of Grid.
        // Has side effect of setting/unsetting `segDragListener`
        buildSegDragListener: function (seg) {
            var _this = this;
            var view = this.view;
            var calendar = view.calendar;
            var el = seg.el;
            var event = seg.event;
            var isDragging;
            var mouseFollower; // A clone of the original element that will move with the mouse
            var dropLocation; // zoned event date properties

            if (this.segDragListener) {
                return this.segDragListener;
            }

            // Tracks mouse movement over the *view's* coordinate map. Allows dragging and dropping between subcomponents
            // of the view.
            var dragListener = this.segDragListener = new HitDragListener(view, {
                scroll: view.opt('dragScroll'),
                subjectEl: el,
                subjectCenter: true,
                interactionStart: function (ev) {
                    isDragging = false;
                    mouseFollower = new MouseFollower(seg.el, {
                        additionalClass: 'fc-dragging',
                        parentEl: view.el,
                        opacity: dragListener.isTouch ? null : view.opt('dragOpacity'),
                        revertDuration: view.opt('dragRevertDuration'),
                        zIndex: 2 // one above the .fc-view
                    });
                    mouseFollower.hide(); // don't show until we know this is a real drag
                    mouseFollower.start(ev);
                },
                dragStart: function (ev) {
                    if (dragListener.isTouch && !view.isEventSelected(event)) {
                        // if not previously selected, will fire after a delay. then, select the event
                        view.selectEvent(event);
                    }
                    isDragging = true;
                    _this.handleSegMouseout(seg, ev); // ensure a mouseout on the manipulated event has been reported
                    _this.segDragStart(seg, ev);
                    view.hideEvent(event); // hide all event segments. our mouseFollower will take over
                },
                hitOver: function (hit, isOrig, origHit) {
                    var dragHelperEls;

                    // starting hit could be forced (DayGrid.limit)
                    if (seg.hit) {
                        origHit = seg.hit;
                    }

                    // since we are querying the parent view, might not belong to this grid
                    dropLocation = _this.computeEventDrop(
                        origHit.component.getHitSpan(origHit),
                        hit.component.getHitSpan(hit),
                        event
                        );

                    if (dropLocation && !calendar.isEventSpanAllowed(_this.eventToSpan(dropLocation), event)) {
                        disableCursor();
                        dropLocation = null;
                    }

                    // if a valid drop location, have the subclass render a visual indication
                    if (dropLocation && (dragHelperEls = view.renderDrag(dropLocation, seg))) {

                        dragHelperEls.addClass('fc-dragging');
                        if (!dragListener.isTouch) {
                            _this.applyDragOpacity(dragHelperEls);
                        }

                        mouseFollower.hide(); // if the subclass is already using a mock event "helper", hide our own
                    } else {
                        mouseFollower.show(); // otherwise, have the helper follow the mouse (no snapping)
                    }

                    if (isOrig) {
                        dropLocation = null; // needs to have moved hits to be a valid drop
                    }
                },
                hitOut: function () { // called before mouse moves to a different hit OR moved out of all hits
                    view.unrenderDrag(); // unrender whatever was done in renderDrag
                    mouseFollower.show(); // show in case we are moving out of all hits
                    dropLocation = null;
                },
                hitDone: function () { // Called after a hitOut OR before a dragEnd
                    enableCursor();
                },
                interactionEnd: function (ev) {
                    // do revert animation if hasn't changed. calls a callback when finished (whether animation or not)
                    mouseFollower.stop(!dropLocation, function () {
                        if (isDragging) {
                            view.unrenderDrag();
                            view.showEvent(event);
                            _this.segDragStop(seg, ev);
                        }
                        if (dropLocation) {
                            view.reportEventDrop(event, dropLocation, this.largeUnit, el, ev);
                        }
                    });
                    _this.segDragListener = null;
                }
            });

            return dragListener;
        },
        // seg isn't draggable, but let's use a generic DragListener
        // simply for the delay, so it can be selected.
        // Has side effect of setting/unsetting `segDragListener`
        buildSegSelectListener: function (seg) {
            var _this = this;
            var view = this.view;
            var event = seg.event;

            if (this.segDragListener) {
                return this.segDragListener;
            }

            var dragListener = this.segDragListener = new DragListener({
                dragStart: function (ev) {
                    if (dragListener.isTouch && !view.isEventSelected(event)) {
                        // if not previously selected, will fire after a delay. then, select the event
                        view.selectEvent(event);
                    }
                },
                interactionEnd: function (ev) {
                    _this.segDragListener = null;
                }
            });

            return dragListener;
        },
        // Called before event segment dragging starts
        segDragStart: function (seg, ev) {
            this.isDraggingSeg = true;
            this.view.trigger('eventDragStart', seg.el[0], seg.event, ev, {}); // last argument is jqui dummy
        },
        // Called after event segment dragging stops
        segDragStop: function (seg, ev) {
            this.isDraggingSeg = false;
            this.view.trigger('eventDragStop', seg.el[0], seg.event, ev, {}); // last argument is jqui dummy
        },
        // Given the spans an event drag began, and the span event was dropped, calculates the new zoned start/end/allDay
        // values for the event. Subclasses may override and set additional properties to be used by renderDrag.
        // A falsy returned value indicates an invalid drop.
        // DOES NOT consider overlap/constraint.
        computeEventDrop: function (startSpan, endSpan, event) {
            var calendar = this.view.calendar;
            var dragStart = startSpan.start;
            var dragEnd = endSpan.start;
            var delta;
            var dropLocation; // zoned event date properties

            if (dragStart.hasTime() === dragEnd.hasTime()) {
                delta = this.diffDates(dragEnd, dragStart);

                // if an all-day event was in a timed area and it was dragged to a different time,
                // guarantee an end and adjust start/end to have times
                if (event.allDay && durationHasTime(delta)) {
                    dropLocation = {
                        start: event.start.clone(),
                        end: calendar.getEventEnd(event), // will be an ambig day
                        allDay: false // for normalizeEventTimes
                    };
                    calendar.normalizeEventTimes(dropLocation);
                }
                // othewise, work off existing values
                else {
                    dropLocation = {
                        start: event.start.clone(),
                        end: event.end ? event.end.clone() : null,
                        allDay: event.allDay // keep it the same
                    };
                }

                dropLocation.start.add(delta);
                if (dropLocation.end) {
                    dropLocation.end.add(delta);
                }
            } else {
                // if switching from day <-> timed, start should be reset to the dropped date, and the end cleared
                dropLocation = {
                    start: dragEnd.clone(),
                    end: null, // end should be cleared
                    allDay: !dragEnd.hasTime()
                };
            }

            return dropLocation;
        },
        // Utility for apply dragOpacity to a jQuery set
        applyDragOpacity: function (els) {
            var opacity = this.view.opt('dragOpacity');

            if (opacity != null) {
                els.each(function (i, node) {
                    // Don't use jQuery (will set an IE filter), do it the old fashioned way.
                    // In IE8, a helper element will disappears if there's a filter.
                    node.style.opacity = opacity;
                });
            }
        },
        /* External Element Dragging
         ------------------------------------------------------------------------------------------------------------------*/


        // Called when a jQuery UI drag is initiated anywhere in the DOM
        externalDragStart: function (ev, ui) {
            var view = this.view;
            var el;
            var accept;

            if (view.opt('droppable')) { // only listen if this setting is on
                el = $((ui ? ui.item : null) || ev.target);

                // Test that the dragged element passes the dropAccept selector or filter function.
                // FYI, the default is "*" (matches all)
                accept = view.opt('dropAccept');
                if ($.isFunction(accept) ? accept.call(el[0], el) : el.is(accept)) {
                    if (!this.isDraggingExternal) { // prevent double-listening if fired twice
                        this.listenToExternalDrag(el, ev, ui);
                    }
                }
            }
        },
        // Called when a jQuery UI drag starts and it needs to be monitored for dropping
        listenToExternalDrag: function (el, ev, ui) {
            var _this = this;
            var calendar = this.view.calendar;
            var meta = getDraggedElMeta(el); // extra data about event drop, including possible event to create
            var dropLocation; // a null value signals an unsuccessful drag

            // listener that tracks mouse movement over date-associated pixel regions
            var dragListener = _this.externalDragListener = new HitDragListener(this, {
                interactionStart: function () {
                    _this.isDraggingExternal = true;
                },
                hitOver: function (hit) {
                    dropLocation = _this.computeExternalDrop(
                        hit.component.getHitSpan(hit), // since we are querying the parent view, might not belong to this grid
                        meta
                        );

                    if (// invalid hit?
                        dropLocation &&
                        !calendar.isExternalSpanAllowed(_this.eventToSpan(dropLocation), dropLocation, meta.eventProps)
                        ) {
                        disableCursor();
                        dropLocation = null;
                    }

                    if (dropLocation) {
                        _this.renderDrag(dropLocation); // called without a seg parameter
                    }
                },
                hitOut: function () {
                    dropLocation = null; // signal unsuccessful
                },
                hitDone: function () { // Called after a hitOut OR before a dragEnd
                    enableCursor();
                    _this.unrenderDrag();
                },
                interactionEnd: function (ev) {
                    if (dropLocation) { // element was dropped on a valid hit
                        _this.view.reportExternalDrop(meta, dropLocation, el, ev, ui);
                    }
                    _this.isDraggingExternal = false;
                    _this.externalDragListener = null;
                }
            });

            dragListener.startDrag(ev); // start listening immediately
        },
        // Given a hit to be dropped upon, and misc data associated with the jqui drag (guaranteed to be a plain object),
        // returns the zoned start/end dates for the event that would result from the hypothetical drop. end might be null.
        // Returning a null value signals an invalid drop hit.
        // DOES NOT consider overlap/constraint.
        computeExternalDrop: function (span, meta) {
            var calendar = this.view.calendar;
            var dropLocation = {
                start: calendar.applyTimezone(span.start), // simulate a zoned event start date
                end: null
            };

            // if dropped on an all-day span, and element's metadata specified a time, set it
            if (meta.startTime && !dropLocation.start.hasTime()) {
                dropLocation.start.time(meta.startTime);
            }

            if (meta.duration) {
                dropLocation.end = dropLocation.start.clone().add(meta.duration);
            }

            return dropLocation;
        },
        /* Drag Rendering (for both events and an external elements)
         ------------------------------------------------------------------------------------------------------------------*/


        // Renders a visual indication of an event or external element being dragged.
        // `dropLocation` contains hypothetical start/end/allDay values the event would have if dropped. end can be null.
        // `seg` is the internal segment object that is being dragged. If dragging an external element, `seg` is null.
        // A truthy returned value indicates this method has rendered a helper element.
        // Must return elements used for any mock events.
        renderDrag: function (dropLocation, seg) {
            // subclasses must implement
        },
        // Unrenders a visual indication of an event or external element being dragged
        unrenderDrag: function () {
            // subclasses must implement
        },
        /* Resizing
         ------------------------------------------------------------------------------------------------------------------*/


        // Creates a listener that tracks the user as they resize an event segment.
        // Generic enough to work with any type of Grid.
        buildSegResizeListener: function (seg, isStart) {
            var _this = this;
            var view = this.view;
            var calendar = view.calendar;
            var el = seg.el;
            var event = seg.event;
            var eventEnd = calendar.getEventEnd(event);
            var isDragging;
            var resizeLocation; // zoned event date properties. falsy if invalid resize

            // Tracks mouse movement over the *grid's* coordinate map
            var dragListener = this.segResizeListener = new HitDragListener(this, {
                scroll: view.opt('dragScroll'),
                subjectEl: el,
                interactionStart: function () {
                    isDragging = false;
                },
                dragStart: function (ev) {
                    isDragging = true;
                    _this.handleSegMouseout(seg, ev); // ensure a mouseout on the manipulated event has been reported
                    _this.segResizeStart(seg, ev);
                },
                hitOver: function (hit, isOrig, origHit) {
                    var origHitSpan = _this.getHitSpan(origHit);
                    var hitSpan = _this.getHitSpan(hit);

                    resizeLocation = isStart ?
                        _this.computeEventStartResize(origHitSpan, hitSpan, event) :
                        _this.computeEventEndResize(origHitSpan, hitSpan, event);

                    if (resizeLocation) {
                        if (!calendar.isEventSpanAllowed(_this.eventToSpan(resizeLocation), event)) {
                            disableCursor();
                            resizeLocation = null;
                        }
                        // no change? (TODO: how does this work with timezones?)
                        else if (resizeLocation.start.isSame(event.start) && resizeLocation.end.isSame(eventEnd)) {
                            resizeLocation = null;
                        }
                    }

                    if (resizeLocation) {
                        view.hideEvent(event);
                        _this.renderEventResize(resizeLocation, seg);
                    }
                },
                hitOut: function () { // called before mouse moves to a different hit OR moved out of all hits
                    resizeLocation = null;
                },
                hitDone: function () { // resets the rendering to show the original event
                    _this.unrenderEventResize();
                    view.showEvent(event);
                    enableCursor();
                },
                interactionEnd: function (ev) {
                    if (isDragging) {
                        _this.segResizeStop(seg, ev);
                    }
                    if (resizeLocation) { // valid date to resize to?
                        view.reportEventResize(event, resizeLocation, this.largeUnit, el, ev);
                    }
                    _this.segResizeListener = null;
                }
            });

            return dragListener;
        },
        // Called before event segment resizing starts
        segResizeStart: function (seg, ev) {
            this.isResizingSeg = true;
            this.view.trigger('eventResizeStart', seg.el[0], seg.event, ev, {}); // last argument is jqui dummy
        },
        // Called after event segment resizing stops
        segResizeStop: function (seg, ev) {
            this.isResizingSeg = false;
            this.view.trigger('eventResizeStop', seg.el[0], seg.event, ev, {}); // last argument is jqui dummy
        },
        // Returns new date-information for an event segment being resized from its start
        computeEventStartResize: function (startSpan, endSpan, event) {
            return this.computeEventResize('start', startSpan, endSpan, event);
        },
        // Returns new date-information for an event segment being resized from its end
        computeEventEndResize: function (startSpan, endSpan, event) {
            return this.computeEventResize('end', startSpan, endSpan, event);
        },
        // Returns new zoned date information for an event segment being resized from its start OR end
        // `type` is either 'start' or 'end'.
        // DOES NOT consider overlap/constraint.
        computeEventResize: function (type, startSpan, endSpan, event) {
            var calendar = this.view.calendar;
            var delta = this.diffDates(endSpan[type], startSpan[type]);
            var resizeLocation; // zoned event date properties
            var defaultDuration;

            // build original values to work from, guaranteeing a start and end
            resizeLocation = {
                start: event.start.clone(),
                end: calendar.getEventEnd(event),
                allDay: event.allDay
            };

            // if an all-day event was in a timed area and was resized to a time, adjust start/end to have times
            if (resizeLocation.allDay && durationHasTime(delta)) {
                resizeLocation.allDay = false;
                calendar.normalizeEventTimes(resizeLocation);
            }

            resizeLocation[type].add(delta); // apply delta to start or end

            // if the event was compressed too small, find a new reasonable duration for it
            if (!resizeLocation.start.isBefore(resizeLocation.end)) {

                defaultDuration =
                    this.minResizeDuration || // TODO: hack
                    (event.allDay ?
                        calendar.defaultAllDayEventDuration :
                        calendar.defaultTimedEventDuration);

                if (type == 'start') { // resizing the start?
                    resizeLocation.start = resizeLocation.end.clone().subtract(defaultDuration);
                } else { // resizing the end?
                    resizeLocation.end = resizeLocation.start.clone().add(defaultDuration);
                }
            }

            return resizeLocation;
        },
        // Renders a visual indication of an event being resized.
        // `range` has the updated dates of the event. `seg` is the original segment object involved in the drag.
        // Must return elements used for any mock events.
        renderEventResize: function (range, seg) {
            // subclasses must implement
        },
        // Unrenders a visual indication of an event being resized.
        unrenderEventResize: function () {
            // subclasses must implement
        },
        /* Rendering Utils
         ------------------------------------------------------------------------------------------------------------------*/


        // Compute the text that should be displayed on an event's element.
        // `range` can be the Event object itself, or something range-like, with at least a `start`.
        // If event times are disabled, or the event has no time, will return a blank string.
        // If not specified, formatStr will default to the eventTimeFormat setting,
        // and displayEnd will default to the displayEventEnd setting.
        getEventTimeText: function (range, formatStr, displayEnd) {
            
            if (formatStr == null) {
                formatStr = this.eventTimeFormat;
            }

            if (displayEnd == null) {
                displayEnd = this.displayEventEnd;
            }

            if (this.displayEventTime && range.start.hasTime()) {
                if (displayEnd && range.end) {
                    return this.view.formatRange(range, formatStr);
                } else {
                    return range.start.format(formatStr);
                }
            }

            return '';
        },
        // Generic utility for generating the HTML classNames for an event segment's element
        getSegClasses: function (seg, isDraggable, isResizable) {
            var view = this.view;
            var event = seg.event;
            var classes = [
                'fc-event',
                seg.isStart ? 'fc-start' : 'fc-not-start',
                seg.isEnd ? 'fc-end' : 'fc-not-end'
            ].concat(
                event.className,
                event.source ? event.source.className : []
                );

            if (isDraggable) {
                classes.push('fc-draggable');
            }
            if (isResizable) {
                classes.push('fc-resizable');
            }

            // event is currently selected? attach a className.
            if (view.isEventSelected(event)) {
                classes.push('fc-selected');
            }

            return classes;
        },
        // Utility for generating event skin-related CSS properties
        getSegSkinCss: function (seg) {
            var event = seg.event;
            var view = this.view;
            var source = event.source || {};
            var eventColor = event.color;
            var sourceColor = source.color;
            var optionColor = view.opt('eventColor');

            return {
                'background-color':
                    event.backgroundColor ||
                    eventColor ||
                    source.backgroundColor ||
                    sourceColor ||
                    view.opt('eventBackgroundColor') ||
                    optionColor,
                'border-color':
                    event.borderColor ||
                    eventColor ||
                    source.borderColor ||
                    sourceColor ||
                    view.opt('eventBorderColor') ||
                    optionColor,
                color:
                    event.textColor ||
                    source.textColor ||
                    view.opt('eventTextColor')
            };
        },
        /* Converting events -> eventRange -> eventSpan -> eventSegs
         ------------------------------------------------------------------------------------------------------------------*/


        // Generates an array of segments for the given single event
        // Can accept an event "location" as well (which only has start/end and no allDay)
        eventToSegs: function (event) {
            return this.eventsToSegs([event]);
        },
        eventToSpan: function (event) {
            return this.eventToSpans(event)[0];
        },
        // Generates spans (always unzoned) for the given event.
        // Does not do any inverting for inverse-background events.
        // Can accept an event "location" as well (which only has start/end and no allDay)
        eventToSpans: function (event) {
            var range = this.eventToRange(event);
            return this.eventRangeToSpans(range, event);
        },
        // Converts an array of event objects into an array of event segment objects.
        // A custom `segSliceFunc` may be given for arbitrarily slicing up events.
        // Doesn't guarantee an order for the resulting array.
        eventsToSegs: function (allEvents, segSliceFunc) {
            var _this = this;
            var eventsById = groupEventsById(allEvents);
            var segs = [];

            $.each(eventsById, function (id, events) {
                var ranges = [];
                var i;

                for (i = 0; i < events.length; i++) {
                    ranges.push(_this.eventToRange(events[i]));
                }

                // inverse-background events (utilize only the first event in calculations)
                if (isInverseBgEvent(events[0])) {
                    ranges = _this.invertRanges(ranges);

                    for (i = 0; i < ranges.length; i++) {
                        segs.push.apply(segs, // append to
                            _this.eventRangeToSegs(ranges[i], events[0], segSliceFunc));
                    }
                }
                // normal event ranges
                else {
                    for (i = 0; i < ranges.length; i++) {
                        segs.push.apply(segs, // append to
                            _this.eventRangeToSegs(ranges[i], events[i], segSliceFunc));
                    }
                }
            });

            return segs;
        },
        // Generates the unzoned start/end dates an event appears to occupy
        // Can accept an event "location" as well (which only has start/end and no allDay)
        eventToRange: function (event) {
            return {
                start: event.start.clone().stripZone(),
                end: (
                    event.end ?
                    event.end.clone() :
                    // derive the end from the start and allDay. compute allDay if necessary
                    this.view.calendar.getDefaultEventEnd(
                        event.allDay != null ?
                        event.allDay :
                        !event.start.hasTime(),
                        event.start
                        )
                    ).stripZone()
            };
        },
        // Given an event's range (unzoned start/end), and the event itself,
        // slice into segments (using the segSliceFunc function if specified)
        eventRangeToSegs: function (range, event, segSliceFunc) {
            var spans = this.eventRangeToSpans(range, event);
            var segs = [];
            var i;

            for (i = 0; i < spans.length; i++) {
                segs.push.apply(segs, // append to
                    this.eventSpanToSegs(spans[i], event, segSliceFunc));
            }

            return segs;
        },
        // Given an event's unzoned date range, return an array of "span" objects.
        // Subclasses can override.
        eventRangeToSpans: function (range, event) {
            return [$.extend({}, range)]; // copy into a single-item array
        },
        // Given an event's span (unzoned start/end and other misc data), and the event itself,
        // slices into segments and attaches event-derived properties to them.
        eventSpanToSegs: function (span, event, segSliceFunc) {
            var segs = segSliceFunc ? segSliceFunc(span) : this.spanToSegs(span);
            var i, seg;

            for (i = 0; i < segs.length; i++) {
                seg = segs[i];
                seg.event = event;
                seg.eventStartMS = +span.start; // TODO: not the best name after making spans unzoned
                seg.eventDurationMS = span.end - span.start;
            }

            return segs;
        },
        // Produces a new array of range objects that will cover all the time NOT covered by the given ranges.
        // SIDE EFFECT: will mutate the given array and will use its date references.
        invertRanges: function (ranges) {
            var view = this.view;
            var viewStart = view.start.clone(); // need a copy
            var viewEnd = view.end.clone(); // need a copy
            var inverseRanges = [];
            var start = viewStart; // the end of the previous range. the start of the new range
            var i, range;

            // ranges need to be in order. required for our date-walking algorithm
            ranges.sort(compareRanges);

            for (i = 0; i < ranges.length; i++) {
                range = ranges[i];

                // add the span of time before the event (if there is any)
                if (range.start > start) { // compare millisecond time (skip any ambig logic)
                    inverseRanges.push({
                        start: start,
                        end: range.start
                    });
                }

                start = range.end;
            }

            // add the span of time after the last event (if there is any)
            if (start < viewEnd) { // compare millisecond time (skip any ambig logic)
                inverseRanges.push({
                    start: start,
                    end: viewEnd
                });
            }

            return inverseRanges;
        },
        sortEventSegs: function (segs) {
            segs.sort(proxy(this, 'compareEventSegs'));
        },
        // A cmp function for determining which segments should take visual priority
        compareEventSegs: function (seg1, seg2) {
            return seg1.eventStartMS - seg2.eventStartMS || // earlier events go first
                seg2.eventDurationMS - seg1.eventDurationMS || // tie? longer events go first
                seg2.event.allDay - seg1.event.allDay || // tie? put all-day events first (booleans cast to 0/1)
                compareByFieldSpecs(seg1.event, seg2.event, this.view.eventOrderSpecs);
        }

    });


    /* Utilities
     ----------------------------------------------------------------------------------------------------------------------*/


    function isBgEvent(event) { // returns true if background OR inverse-background
        var rendering = getEventRendering(event);
        return rendering === 'background' || rendering === 'inverse-background';
    }
    FC.isBgEvent = isBgEvent; // export


    function isInverseBgEvent(event) {
        return getEventRendering(event) === 'inverse-background';
    }


    function getEventRendering(event) {
        return firstDefined((event.source || {}).rendering, event.rendering);
    }


    function groupEventsById(events) {
        var eventsById = {};
        var i, event;

        for (i = 0; i < events.length; i++) {
            event = events[i];
            (eventsById[event._id] || (eventsById[event._id] = [])).push(event);
        }

        return eventsById;
    }


// A cmp function for determining which non-inverted "ranges" (see above) happen earlier
    function compareRanges(range1, range2) {
        return range1.start - range2.start; // earlier ranges go first
    }


    /* External-Dragging-Element Data
     ----------------------------------------------------------------------------------------------------------------------*/

// Require all HTML5 data-* attributes used by FullCalendar to have this prefix.
// A value of '' will query attributes like data-event. A value of 'fc' will query attributes like data-fc-event.
    FC.dataAttrPrefix = '';

// Given a jQuery element that might represent a dragged FullCalendar event, returns an intermediate data structure
// to be used for Event Object creation.
// A defined `.eventProps`, even when empty, indicates that an event should be created.
    function getDraggedElMeta(el) {
        var prefix = FC.dataAttrPrefix;
        var eventProps; // properties for creating the event, not related to date/time
        var startTime; // a Duration
        var duration;
        var stick;

        if (prefix) {
            prefix += '-';
        }
        eventProps = el.data(prefix + 'event') || null;

        if (eventProps) {
            if (typeof eventProps === 'object') {
                eventProps = $.extend({}, eventProps); // make a copy
            } else { // something like 1 or true. still signal event creation
                eventProps = {};
            }

            // pluck special-cased date/time properties
            startTime = eventProps.start;
            if (startTime == null) {
                startTime = eventProps.time;
            } // accept 'time' as well
            duration = eventProps.duration;
            stick = eventProps.stick;
            delete eventProps.start;
            delete eventProps.time;
            delete eventProps.duration;
            delete eventProps.stick;
        }

        // fallback to standalone attribute values for each of the date/time properties
        if (startTime == null) {
            startTime = el.data(prefix + 'start');
        }
        if (startTime == null) {
            startTime = el.data(prefix + 'time');
        } // accept 'time' as well
        if (duration == null) {
            duration = el.data(prefix + 'duration');
        }
        if (stick == null) {
            stick = el.data(prefix + 'stick');
        }

        // massage into correct data types
        startTime = startTime != null ? moment.duration(startTime) : null;
        duration = duration != null ? moment.duration(duration) : null;
        stick = Boolean(stick);

        return {eventProps: eventProps, startTime: startTime, duration: duration, stick: stick};
    }


    ;
    ;

    /*
     A set of rendering and date-related methods for a visual component comprised of one or more rows of day columns.
     Prerequisite: the object being mixed into needs to be a *Grid*
     */
    var DayTableMixin = FC.DayTableMixin = {
        breakOnWeeks: false, // should create a new row for each week?
        dayDates: null, // whole-day dates for each column. left to right
        dayIndices: null, // for each day from start, the offset
        daysPerRow: null,
        rowCnt: null,
        colCnt: null,
        colHeadFormat: null,
        // Populates internal variables used for date calculation and rendering
        updateDayTable: function () {
            var view = this.view;
            var date = this.start.clone();
            var dayIndex = -1;
            var dayIndices = [];
            var dayDates = [];
            var daysPerRow;
            var firstDay;
            var rowCnt;

            while (date.isBefore(this.end)) { // loop each day from start to end
                if (view.isHiddenDay(date)) {
                    dayIndices.push(dayIndex + 0.5); // mark that it's between indices
                } else {
                    dayIndex++;
                    dayIndices.push(dayIndex);
                    dayDates.push(date.clone());
                }
                date.add(1, 'days');
            }

            if (this.breakOnWeeks) {
                // count columns until the day-of-week repeats
                firstDay = dayDates[0].day();
                for (daysPerRow = 1; daysPerRow < dayDates.length; daysPerRow++) {
                    if (dayDates[daysPerRow].day() == firstDay) {
                        break;
                    }
                }
                rowCnt = Math.ceil(dayDates.length / daysPerRow);
            } else {
                rowCnt = 1;
                daysPerRow = dayDates.length;
            }

            this.dayDates = dayDates;
            this.dayIndices = dayIndices;
            this.daysPerRow = daysPerRow;
            this.rowCnt = rowCnt;

            this.updateDayTableCols();
        },
        // Computes and assigned the colCnt property and updates any options that may be computed from it
        updateDayTableCols: function () {
            this.colCnt = this.computeColCnt();
            this.colHeadFormat = this.view.opt('columnFormat') || this.computeColHeadFormat();
        },
        // Determines how many columns there should be in the table
        computeColCnt: function () {
            return this.daysPerRow;
        },
        // Computes the ambiguously-timed moment for the given cell
        getCellDate: function (row, col) {
            return this.dayDates[
                this.getCellDayIndex(row, col)
            ].clone();
        },
        // Computes the ambiguously-timed date range for the given cell
        getCellRange: function (row, col) {
            var start = this.getCellDate(row, col);
            var end = start.clone().add(1, 'days');

            return {start: start, end: end};
        },
        // Returns the number of day cells, chronologically, from the first of the grid (0-based)
        getCellDayIndex: function (row, col) {
            return row * this.daysPerRow + this.getColDayIndex(col);
        },
        // Returns the numner of day cells, chronologically, from the first cell in *any given row*
        getColDayIndex: function (col) {
            if (this.isRTL) {
                return this.colCnt - 1 - col;
            } else {
                return col;
            }
        },
        // Given a date, returns its chronolocial cell-index from the first cell of the grid.
        // If the date lies between cells (because of hiddenDays), returns a floating-point value between offsets.
        // If before the first offset, returns a negative number.
        // If after the last offset, returns an offset past the last cell offset.
        // Only works for *start* dates of cells. Will not work for exclusive end dates for cells.
        getDateDayIndex: function (date) {
            var dayIndices = this.dayIndices;
            var dayOffset = date.diff(this.start, 'days');

            if (dayOffset < 0) {
                return dayIndices[0] - 1;
            } else if (dayOffset >= dayIndices.length) {
                return dayIndices[dayIndices.length - 1] + 1;
            } else {
                return dayIndices[dayOffset];
            }
        },
        /* Options
         ------------------------------------------------------------------------------------------------------------------*/


        // Computes a default column header formatting string if `colFormat` is not explicitly defined
        computeColHeadFormat: function () {
            // if more than one week row, or if there are a lot of columns with not much space,
            // put just the day numbers will be in each cell
            if (this.rowCnt > 1 || this.colCnt > 10) {
                return 'ddd'; // "Sat"
            }
            // multiple days, so full single date string WON'T be in title text
            else if (this.colCnt > 1) {
                return this.view.opt('dayOfMonthFormat'); // "Sat 12/10"
            }
            // single day, so full single date string will probably be in title text
            else {
                return 'dddd'; // "Saturday"
            }
        },
        /* Slicing
         ------------------------------------------------------------------------------------------------------------------*/


        // Slices up a date range into a segment for every week-row it intersects with
        sliceRangeByRow: function (range) {
            var daysPerRow = this.daysPerRow;
            var normalRange = this.view.computeDayRange(range); // make whole-day range, considering nextDayThreshold
            var rangeFirst = this.getDateDayIndex(normalRange.start); // inclusive first index
            var rangeLast = this.getDateDayIndex(normalRange.end.clone().subtract(1, 'days')); // inclusive last index
            var segs = [];
            var row;
            var rowFirst, rowLast; // inclusive day-index range for current row
            var segFirst, segLast; // inclusive day-index range for segment

            for (row = 0; row < this.rowCnt; row++) {
                rowFirst = row * daysPerRow;
                rowLast = rowFirst + daysPerRow - 1;

                // intersect segment's offset range with the row's
                segFirst = Math.max(rangeFirst, rowFirst);
                segLast = Math.min(rangeLast, rowLast);

                // deal with in-between indices
                segFirst = Math.ceil(segFirst); //