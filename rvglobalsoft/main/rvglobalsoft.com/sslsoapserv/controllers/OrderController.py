from . import BaseController
from library.pysymantecapi.soapssl import SSLOrder
from pprint import pprint
from flask import request


class OrderController(BaseController):
    """
    QueryController
    """
    o_connect = ''
    def connection(self):
        connection_conf = self.CONF['symantec-connecton']
        self.o_connect  = SSLOrder(test_mode=connection_conf['test-mode'], verbose=connection_conf['verbose']
                             , username=connection_conf['username'], password=connection_conf['password'], 
                             partnercode=connection_conf['partnercode'])
    
        
    def QuickOrder(self):
        if request.method == 'POST':
            productCode         = request.form['productCode']
            orderParameters     = self.toarray(request.form['orderParameters'])
            organizationInfo    = self.toarray(request.form['organizationInfo'])
            adminContact        = self.toarray(request.form['adminContact'])
            techContact         = self.toarray(request.form['techContact'])
            billingContact      = self.toarray(request.form['billingContact'])
            approverEmail       = request.form['approverEmail']
            options             = self.toarray(request.form['options'])
            
            return self.o_connect.quickOrder(productCode=productCode, orderParameters=orderParameters, organizationInfo=organizationInfo,
                                             adminContact=adminContact, techContact=techContact, billingContact=billingContact,
                                             approverEmail=approverEmail, options=options
                                             )
    def QuickInvite(self):
        if request.method == 'POST':
            productCode         = request.form['productCode']
            orderParameters     = self.toarray(request.form['orderParameters'])
            organizationInfo    = self.toarray(request.form['organizationInfo'])
            adminContact        = self.toarray(request.form['adminContact'])
            techContact         = self.toarray(request.form['techContact'])
            billingContact      = self.toarray(request.form['billingContact'])
            approverEmail       = request.form['approverEmail']
            options             = self.toarray(request.form['options'])
            
            return self.o_connect.quickInvite(productCode=productCode
                                              , orderParameters=orderParameters
                                              , organizationInfo=organizationInfo
                                              , adminContact=adminContact
                                              , techContact=techContact
                                              , billingContact=billingContact
                                              , approverEmail=approverEmail
                                              , options=options
                                              )
    
    def ChangeApproverEmail(self):
        if request.method == 'POST':
            partnerOrderID      = request.form['partnerOrderID']
            approverEmail       = request.form['approverEmail']
            options             = self.toarray(request.form['options'])
            
            return self.o_connect.changeApproverEmail(partnerOrderID=partnerOrderID
                                                      , approverEmail=approverEmail
                                                      , options=options
                                                      )
    
    def ModifyOrder(self):
        if request.method == 'POST':
            partnerOrderID      = request.form['partnerOrderID']
            orderOperation      = request.form['orderOperation']
            options             = self.toarray(request.form['options'])
            
            return self.o_connect.modifyOrder(partnerOrderID=partnerOrderID
                                              , orderOperation=orderOperation
                                              , options=options
                                              )
    
    def Reissue(self):
        if request.method == 'POST':
            partnerOrderID      = request.form['partnerOrderID']
            reissueEmail        = request.form['reissueEmail']
            options             = self.toarray(request.form['options'])
            
            return self.o_connect.reissue(partnerOrderID=partnerOrderID
                                          , reissueEmail=reissueEmail
                                          , options=options
                                          )
    
    def ResendEmail(self):
        if request.method == 'POST':
            productCode         = request.form['productCode']
            partnerOrderID      = request.form['partnerOrderID']
            resendMailType      = request.form['resendMailType']
            options             = self.toarray(request.form['options'])
            
            return self.o_connect.resendEmail(productCode=productCode
                                              , partnerOrderID=partnerOrderID
                                              , resendMailType=resendMailType
                                              , options=options
                                              )
    
    def Revoke(self):
        if request.method == 'POST':
            certificate         = request.form['certificate']
            revokeReason        = request.form['revokeReason']
            options             = self.toarray(request.form['options'])
            
            return self.o_connect.revoke(certificate=certificate
                                         , revokeReason=revokeReason
                                         , options=options
                                         )
    
    def ValidateOrderParameters(self):
        if request.method == 'POST':
            productCode         = request.form['productCode']
            orderParams         = self.toarray(request.form['orderParams'])
            options             = self.toarray(request.form['options'])
            
            return self.o_connect.validateOrderParameters(productCode=productCode
                                                          , orderParams=orderParams
                                                          , options=options
                                                          )