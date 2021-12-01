from . import BaseController
from library.pysymantecapi.soapssl import SSLQuery
from pprint import pprint
from flask import request
#from phpserialize import unserialize

class QueryController(BaseController):
    """
    QueryController
    """
    o_connect = ''
    def connection(self):
        connection_conf = self.CONF['symantec-connecton']
        self.o_connect  = SSLQuery(test_mode=connection_conf['test-mode'], verbose=connection_conf['verbose']
                             , username=connection_conf['username'], password=connection_conf['password'], 
                             partnercode=connection_conf['partnercode'])
        
    def hello(self):
        # Test OK
        if request.method == 'POST':
            msg = request.form['input']
            
            return self.o_connect.hello(input=msg)
        
    def GetOrderByPartnerOrderID(self):
        # TEST OK
        if request.method == 'POST':
            partnerOrderID  = request.form['partnerOrderID']
            options         = self.toarray(request.form['options'])
            
            return self.o_connect.getOrderByPartnerOrderID(partnerOrderID=partnerOrderID
                                                           , options=options
                                                           )
    
    def GetFulfillment(self):
        # Test OK
        if request.method == 'POST':
            partnerOrderID  = request.form['partnerOrderID']
            options         = self.toarray(request.form['options'])
            
            return self.o_connect.getFulfillment(partnerOrderID=partnerOrderID
                                                 , options=options
                                                 )
        
    def GetModifiedOrders(self):
        if request.method == 'POST':
            fromDate    = request.form['fromDate']
            toDate      = request.form['toDate']
            options     = self.toarray(request.form['options'])
                
            return self.o_connect.getModifiedOrders(fromDate=fromDate
                                                    , toDate=toDate
                                                    , options=options
                                                    )
    
    def GetQuickApproverList(self):
        if request.method == 'POST':
            domain  = request.form['domain']
            options = self.toarray(request.form['options'])
                     
            return self.o_connect.getQuickApproverList(domain=domain
                                                       , options=options
                                                       )
        
    def GetOrdersByDateRange(self):
        if request.method == 'POST':
            fromDate    = request.form['fromDate']
            toDate      = request.form['toDate']
            options     = self.toarray(request.form['options'])
            
            return self.o_connect.getOrdersByDateRange(fromDate=fromDate
                                                       , toDate=toDate
                                                       , options=options
                                                       )
        
    def ParseCSR(self):
        if request.method == 'POST':
            csr         = request.form['CSR']
            options     = self.toarray(request.form['options'])
            
            return self.o_connect.parseCSR(csr=csr
                                           , options=options
                                           )
        
    def CheckStatus(self):
        # Test OK
        if request.method == 'POST':
            partnerOrderID  = request.form['partnerOrderID']
            options         = self.toarray(request.form['options'])
            
            return self.o_connect.checkStatus(partnerOrderID=partnerOrderID
                                              , options=options
                                              )
    
    def GetUserAgreement(self):
        if request.method == 'POST':
            productCode     = request.form['productsCode']
            options         = self.toarray(request.form['options'])
            
            return self.o_connect.getUserAgreement(productCode=productCode
                                                   , options=options
                                                   )
            
        