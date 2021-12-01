#!/usr/bin/python
from flask import Flask, request, jsonify
from datetime import datetime
from pprint import pprint
from config import __CONFIGS__
import os

# configuration
DEBUG = __CONFIGS__['debug']

# create our little application
app = Flask(__name__)

def _error(code, message, header='Error'):
    details = {
               'header': header,
               'message': message,
               }
    return jsonify(status=0, code= code, details=details)

@app.errorhandler(405)
def method_not_allow(error):
    return _error(code='405', header='Method Not Allowed', message="The method is not allowed for the requested URL.")

@app.errorhandler(404)
def page_not_found(error):
    return _error(code='404', header='File not found.', message="This page does not exist")

@app.route('/', methods=['POST'])
def index():
    CONF = {}
    try:
        MODE = '%s_mode' % request.headers.get('RV_API_MODE')
        CONF['secret-code'] = __CONFIGS__['secret-code']
        CONF['symantec-connecton'] = __CONFIGS__['symantec-connection'][MODE]
        CONF['symantec-connecton']['partnercode'] = request.headers.get('SYM_PARTNER_CODE')
        CONF['symantec-connecton']['username'] = request.headers.get('SYM_USERNAME')
        CONF['symantec-connecton']['password'] = request.headers.get('SYM_PASSWORD')
        
        api_request = request.headers.get('RV_API_REQUEST')
        command = request.headers.get('RV_API_COMMAND')
        
        o_ctrl = None
        if api_request == 'query':
            try:
                from controllers import QueryController
                try:
                    o_ctrl = QueryController.QueryController(CONF)
                except Exception, e:
                        return _error(code='501', message="%s" % str(e))
                    
            except Exception, e:
                return _error(code='001', message="%s" % str(e))
        elif api_request == 'order':
            try:
                from controllers import OrderController
                try:
                    o_ctrl = OrderController.OrderController(CONF)
                except Exception, e:
                        return _error(code='501', message="%s" % str(e))
            except Exception, e:
                return _error(code='001', message="%s" % str(e))
        else:
            return _error(code='404', header='File not found.', message="This page does not exist")
        
        try:
            cmd = 'o_ctrl.%s()' % command
            result = eval(cmd)
            return jsonify(status=1, details=result)
        except Exception, e:
            return _error(code='001', message="%s" % str(e))   
        
    except Exception, e:
        return _error(code='001', message="%s" % str(e))

def info(title):
    print(title)
    print('module name:', __name__)
    if hasattr(os, 'getppid'):  # only available on Unix
        print('parent process:', os.getppid())
    print('process id:', os.getpid())
    
  
def startServer(inDebug, port):
    print "Starting Service to Connect Symantec SSL API SERVER"
    app.config.from_object(__name__)
    app.config.from_envvar('RV_SYMANTED_SSL_API', silent=True)
    app.debug = DEBUG
    app.run()
    
def startProxyServer(inDebug, port):
    print "Starting JSONP Starting Service to Connect Symantec SSL API Proxy"
    appJsonp.run(debug=inDebug, port=jsonpPort)
    
if __name__ == '__main__':
    info('Main Line Starting')
    startServer(False, 5000)
    
    #p = mp.Process(target=startServer, args=(False, port))
    #p.deamon = True
    #p.start()
    #p1 = mp.Process(target=startProxyServer, args=(False, port))
    #p1.deamon = True
    #p1.start()
    #p.join()
    #p1.join()
    