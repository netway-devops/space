from flask import request
from pprint import pprint
from phpserialize import unserialize

class BaseController:
    CONF = ''
    def __init__(self, conf):
        self.CONF = conf
        userAgent = request.headers.get('RV_API_SECRET_CODE')
        if userAgent != self.CONF['secret-code']:
            raise RuntimeError('NOT allow your request')
        try:
            self.connection()
        except Exception, e:
            RuntimeError("%s" % str(e))
            
    def toarray(self, str):
        try:
            dic = unserialize(str)
        except Exception, e:
            dic = {}
            
        return dic