'''
#@LICENSE@#
'''
import sys
from pysimplesoap.client import SoapClient
from pprint import pprint
import re

from . import __module_name__, __author__, __copyright__, __license__, __version__, TIMEOUT

if __name__ == '__main__':
    pass

class Base:
    """
    Soap Symantec API Connection 
    """
    mode            = 'query'
    test_mode       = False
    partnercode     = ''
    username        = ''
    password        = ''
    wsdl_url        = ''
    o_soap          = None
    soap_connect    = False
    verbose         = False
    replay_token    = None
    
    def connection(self, mode='query',test_mode=False,partnercode='',username=''
                 ,password='', cache=None, verbose=False):
        if mode != 'query' and mode != 'order':
            print "Error: In option mode you can usage 'query' or 'order' only"
            sys.exit()
            
        self.mode           = mode
        self.test_mode      = test_mode
        self.partnercode    = partnercode
        self.username       = username
        self.password       = password
        self.verbose        = verbose
        
        wsdl_url = 'https://'
        if test_mode == True:
            wsdl_url += 'test-'
            
        wsdl_url += 'api.geotrust.com/webtrust/'
        
        if mode == 'query':
            wsdl_url += 'query.jws?WSDL'
        else:
            wsdl_url += 'order.jws?WSDL'
            
        self.wsdl_url = wsdl_url
        
        try:
            self.o_soap         = SoapClient(wsdl=self.wsdl_url, cache=cache)
            self.soap_connect   = True
        except Exception as e:
            pprint(e)
            self.soap_connect   = False
            sys.exit("Error: Connect to %s has problam!!" % self.wsdl_url);
        
    def printVersion(self):
        print "%s version %s" % (__module_name__, __version__)

    def setVerbose(self, verbose):
        self.verbose = verbose
        
    def getWsdlURL(self):
        return self.wsdl_url

    def setPartnerLogin(self, partnetcode, username, password):
        self.partnercode    = partnercode
        self.username       = username
        self.password       = password
        
    def getPartnerCode(self):
        return self.partnercode
    
    def getUsername(self):
        return self.username
    
    def getPassword(self):
        return self.password
       
    def _quoteSmart(self, val):
        return '"""%s"""' % val.replace('"', '\\"')

    def sendSoap(self, function, params):
        """ Sends a SOAP request to the server with the given parameters. """
        str_param = ''
        for key, val in params.iteritems():
            if str_param != '':
                str_param += ','
            if type(val) is dict:
                pass
            else:
                val = self._quoteSmart(val)
                
            str_param += '%s=%s' % (key, val)
            
        cmd = 'self.o_soap.%s(%s)' % (function, str_param)
        
        if self.verbose == True:
            print "<h3>Soap Request:</h3>"
            print "<pre>"
            print "%s" % cmd
            print "</pre>"
            
        try:
            return eval(cmd)
        except Exception as e:
            return {'errorResult': e }
        
    def _setReplayToken(self,replay_token):
        self.replay_token = replay_token
        
    def createRequestHeader(self, options={}):
        headers = {}
        headers['PartnerCode']              = self.partnercode
        headers['AuthToken']                = {}
        headers['AuthToken']['UserName']    = self.username
        headers['AuthToken']['Password']    = self.password
        
        if self.replay_token != None:
            headers['UseReplayToken']   = True
            headers['ReplayToken']      = self.replay_token
            
        if self.verbose == True:
            pass
        
        return headers
    
    def createContact(self, firstName='', lastName='',  email='', title='', organizationName='', addressLine1=''
                      , addressLine2='', city='', region='', countryCode='', postalCode='', phone='', fax=''):
        """ 
        Creates an array with the correct key names as they are required by the SOAP API.
                
        :param firstName: string - Contact person's First (given) name - middle names can also be entered here
        :param lastName: string- Contact person's Last (family) name
        :param phone: string - Contact's phone number
        :param email: string - Contact's email address
        :param countryCode: string - Contact's country code, example: 'DE' for Germany, 'US' for United States
        :param region: string - Contact's region - It is from the Address structure. This is the region of the address such as state or province. If this is a U.S. state, it must have a valid two-character abbreviation.
        :param city: string - Contact's city name
        :param addressLine1: string - First address line
        :param addressLine2: string - Second address line for longer addresses
        :param postalCode: string - Contact's postal code
        :param fax: string - Contact's fax number
        :param title: string - Contact's title in the company
        :param organizationName - This is the name of the organization applying for the product. This applies to Organization Vetted products and SSL123.
            
        :return dict:
        """
        contact = {}
        if firstName != '' :
            contact['FirstName']    = firstName
            
        if lastName != '':
            contact['LastName']     = lastName
            
        if phone != '':
            contact['Phone']        = phone
            
        if email != '':
            contact['Email']        = email
            
        if countryCode != '':
            contact['Country']      = countryCode
            
        if region != '':
            contact['Region']       = region
            
        if postalCode != '':
            contact['PostalCode']   = postalCode
            
        if city != '':
            contact['City']         = city
            
        if addressLine1 != '':
            contact['AddressLine1'] = addressLine1
            
        if addressLine2 != '':
            contact['AddressLine2'] = addressLine2
            
        if fax != '':
            contact['Fax']          = fax
            
        if title != '':
            contact['Title']        = title
            
        if organizationName != '':
            contact['OrganizationName'] = organizationName
            
        return contact

    def createOrganizationAddress(self, addressLine1='', addressLine2='', addressLine3=''
                                  , city='', region='', countryCode='', postalCode='', phone='', fax=''):
        """
        Creates an array with the correct key names as they are required by the SOAP API.
        You can use this function for an Organization Address.
        For unused fields either enter null or ''.
    
        :param countryCode: string - Contact's country code, example: 'DE' for Germany, 'US' for United States
        :param region: string           - Contact's region - It is from the Address structure. This is the region of the address such as state or province. If this is a U.S. state, it must have a valid two-character abbreviation.
        :param city: string             - Contact's city name
        :param addressLine1: string     - First address line
        :param addressLine2: string     - Second address line for longer addresses
        :param addressLine3: string     - Third address line for very long addresses
        :param postalCode: string       - The postal code
        :param phone: string            - The company phone number
        :param fax: string              - The company fax number
            
        :return dir:
        """
        address = {}
        if addressLine1 != '':
            address['AddressLine1'] = addressLine1
            
        if addressLine2 != '':
            address['AddressLine2'] = addressLine2
            
        if addressLine3 != '':
            address['AddressLine3'] = addressLine3
            
        if city != '':
            address['City']         = city
            
        if region != '':
            address['Region']       = region
            
        if countryCode != '':
            address['Country']      = countryCode
            
        if postalCode != '':
            address['PostalCode']   = postalCode
            
        if phone != '':
            address['Phone']        = phone
            
        if fax != '':
            address['Fax']          = fax
            
        return address
    
    def createOrganizationInfo(self, orgName, orgAddress):
        """
        Creates an array with the correct key names as they are required by the SOAP API.
        You can use this function for organization information.

        :param orgName: string - Name of the organization.
        :param orgAddress: dict - Use the createOrganizationAddress() function to create this array.

        :return dict:
        """
        return {
            'OrganizationName':     orgName,
            'OrganizationAddress':  orgAddress,
        }
    
    
    def getRequestHeader(self):
        return self.createRequestHeader()
    
    
    
class SSLQuery(Base):
    """
    SSL Query 
    """
    def __init__(self, test_mode=False,partnercode='',username='', password='', cache=None, verbose=False):
        self.connection('query', test_mode, partnercode, username, password, cache, verbose)
    
    def hello(self, input=''):
        """
        Returns the "Input" parameter as "helloResult" parameter.
        This is mainly useful to test the connection to the API
        and to see how responses are formatted.

        :param input: dict     - the "Input" parameter
        
        :return dict of strings
        """
        return self.sendSoap('hello', {'Input': input})
    
    def getOrderByPartnerOrderID(self, partnerOrderID, options={}):
        """
        Returns detailed order information for the order matching the PartnerOrderID.
        The PartnerOrderID can optionally be supplied during a QuickInvite or
        QuickOrder command. If the PartnerOrderID is not supplied, GeoTrust
        automatically generates a PartnerOrderID for an order after it is successfully
        submitted. A PartnerOrderID must be unique and cannot be reused.

        NOTE: This operation currently returns only orders. It does not return invitations
        that have not been converted into orders (the results of a QuickInvite).
        
        **Required Parameters**
        PartnerOrderID : string

        **Optional Parameters**
        ReturnProductDetail : bool
        ReturnContacts : bool
        ReturnCertificateInfo : bool
        ReturnFulfillment : bool
        ReturnCACerts : bool
        ReturnPKCS7Cert : bool
        ReturnOrderAttributes : bool
        ReturnAuthenticationComments : bool
        ReturnAuthenticationStatuses : bool
        ReturnTrustServicesSummary : bool
        ReturnTrustServicesDetails : bool
        ReturnVulnerabilityScanSummary : bool
        ReturnVulnerabilityScanDetails : bool
        ReturnFileAuthDVSummary : bool
        ReturnDNSAuthDVSummary : bool

        :param partnerOrderID: string  - Partner order ID
        :param options: dict           - options
        
        :return dict of strings:
        """
        headers = self.createRequestHeader()
        return self.sendSoap('GetOrderByPartnerOrderID', {'Request': {
                                                                      'QueryRequestHeader': headers, 
                                                                      'PartnerOrderID':     partnerOrderID,
                                                                      'OrderQueryOptions':  options
                                                                      }
                                                          }
                             )
    
    def checkStatus(self, partnerOrderID, options={}):
        """
        Returns the processing status of the order.

        :param partnerOrderID: string    - Partner order ID
        :param options: dict             - options
        
        :return dict of strings:
        """
        headers = self.createRequestHeader()
        return self.sendSoap('CheckStatus', {'Request':{
                                                        'QueryRequestHeader':   headers,
                                                        'PartnerOrderID':       partnerOrderID,
                                                        }
                                            }
                             )
    
    
    def getFulfillment(self, partnerOrderID, options={}):
        """
        Returns the fulfillment of an order.

        :param partnerOrderID: string  - Partner order ID
        :param options: dict           -
        
        :return dict of strings
        """
        headers = self.createRequestHeader()
        
        request = {
            'QueryRequestHeader':   headers,
            'PartnerOrderID':       partnerOrderID,
        }
        
        for key, val in options.iteritems():
            request[key] = val
            
        return self.sendSoap('GetFulfillment', {'Request': request})

    def getModifiedOrders(self, fromDate, toDate, options={}):
        """
        Returns order detail records for all orders whose status was modified
        in the specified date range.
        This operation should ideally be run on a periodic basis (e.g. every 10
        or 15 minutes) so that order status can be keupt up to date in a partner's
        system. If no orders have changed status, a return count of zero is returned.

        :param fromDate: string      - Timestamp in 'YYYY-MM-DDTHH:MM:SS' format. (24 hours)
        :param toDate: string        - Timestamp in 'YYYY-MM-DDTHH:MM:SS' format. (24 hours)
        :param options: dict         -
        
        :return dict of strings
        """
        headers = self.createRequestHeader()
        return self.sendSoap('GetModifiedOrders', {'Request': {
                                                               'QueryRequestHeader':    headers,
                                                               'FromDate':              fromDate,
                                                               'ToDate':                toDate,
                                                               'OrderQueryOptions':     options
                                                               }
                                                   }
                             )
    
    def getQuickApproverList(self, domain, options={}):
        """
        Returns the complete list of valid approver email messages for a specified domain.
        This list contains three "types" of email addresses.

        :param domain: string    - (example: 'yahoo.com')
        :param options: dict     - options

        :return dict of strings
        """
        headers = self.createRequestHeader(options)
        
        return self.sendSoap('GetQuickApproverList', {'Request': {
                                                                  'QueryRequestHeader': headers,
                                                                  'Domain':             domain,
                                                                  }
                                                      }
                             )
        
    def getOrdersByDateRange(self, fromDate, toDate, options={}):
        """
        Returns order detail records for all orders whose status was modified
        in the specified date range.
        This operation should ideally be run on a periodic basis (e.g. every 10
        or 15 minutes) so that order status can be keupt up to date in a partner's
        system. If no orders have changed status, a return count of zero is returned.

        :param fromDate: string  - Timestamp in 'YYYY-MM-DDTHH:MM:SS' format. (24 hours)
        :param toDate: string    - Timestamp in 'YYYY-MM-DDTHH:MM:SS' format. (24 hours)
        :param options: dict     - options
        
        :return dict of strings
        """
        headers = self.createRequestHeader(options)
        
        return self.sendSoap('GetOrdersByDateRange', {'Request': {
                                                                  'QueryRequestHeader': headers,
                                                                  'FromDate':           fromDate,
                                                                  'ToDate':             toDate,
                                                                  'OrderQueryOptions':  options
                                                                  }
                                                      }
                             )
    
    def getUserAgreement(self, productCode, options={}):
        """
        The GetUserAgreement operation allows partners to request the appropriate user agreement
        for a particular product.

        Possible values for 'AgreementType' are 'ORDERING' and 'VULNERABILITY'.
        
        :param productCode: string  - product code
        :param options: dict        - options
        
        :return dict of strings
        """
        headers = self.createRequestHeader(options)
        
        request = {
            'QueryRequestHeader':       headers,
            'UserAgreementProductCode': productCode,
        }
        
        for key, val in options.iteritems():
            request[key] = val
            
        return self.sendSoap('GetUserAgreement', {'Request': request})
        
    def parseCSR(self, csr, options={}):
        """
        Parses a CSR and returns its' content.

        Possible values for 'AgreementType' are 'ORDERING' and 'VULNERABILITY'.
        
        :param csr: string      - CSR
        :param options: dict    -
        :return dict of strings
        """
        headers = self.createRequestHeader(options)
        
        params = {
                  'QueryRequestHeader': headers, 
                  'CSR':                csr
                  }
        
        return self.sendSoap('ParseCSR', {'Request': params})
    
    
class SSLOrder(Base):
    """
    SSL Order
    """
    def __init__(self, test_mode=False,partnercode='',username='', password='', cache=None, verbose=False):
        self.connection('order', test_mode, partnercode, username, password, cache, verbose)
        
    def quickOrder(self, productCode, orderParameters, organizationInfo, adminContact, techContact, billingContact, approverEmail, options={}):
        """
        The QuickOrder command allows partners to perform all the actions that requestors would
        typically perform using our Web forms to place an order with one API operation call.
        This includes submitting the full order information, such as technical contact,
        administrative contact, and CSR, as well as approver email address (if applicable).
        Our system validates that the approver email address matches the set of approver email
        addresses that would have been presented to the requestor. Orders can only be successfully
        placed if there is a match between the addresses.

        :param productCode: string        - product code
        :param orderParameters: dict      - OrderParameters: ValidityPeriod, CSR, WebServerType
        :param organizationInfo: dict     - OrganizationInfo: OrganizationName, OrganizationAddress (array), ...
        :param adminContact: dict         - AdminContact: FirstName, LastName, Phone, Email, Title, ...
        :param techContact: dict          - TechContact: FirstName, LastName, Phone, Email, Title, ...
        :param billingContact: dict       - BillingContact: FirstName, LastName, Phone, Email, Title, ...
        :param approverEmail: dict        - ApproverEmail: required for TrueBusinessID with EV. If you have another
                                            product, you can put an empty string here.
        :param options: dict              - options

        :return dict of strings
        """
        headers = self.createRequestHeader(options)
        
        headers['ProductCode'] = productCode;
        
        if 'PartnerOrderID' in options:
            headers['PartnerOrderID'] = options['PartnerOrderID']
            del options['PartnerOrderID']
        
        params = {
                  'OrderRequestHeader':     headers,
                  'OrderParameters':        orderParameters,
                  'OrganizationInfo':       organizationInfo,
                  'AdminContact':           adminContact,
                  'TechContact':            techContact,
                  'BillingContact':         billingContact,
                  'ApproverEmail':          approverEmail
                  }
        
        for key, val in options.iteritems():
            params[key] = val
            
        return self.sendSoap('QuickOrder', {'Request': params})
    
    def quickInvite(self, productCode, orderParameters, organizationInfo, adminContact, techContact, billingContact, approverEmail, options={}):
        """
        QuickInvite is a mechanism that allows partners to invite a third party to complete an order. 
        With QuickInvite, partners can pre-fill a subset of order data. Upon receiving a submission, 
        our system sends an email to the requestor inviting the requestor to complete the order. 
        The information provided by the partner is protected and cannot be edited by the requestor. 
        From this point, the order process proceeds in the same manner as a typical Domain Vetted, 
        Organization Vetted, or Domain and Organization Vetted order. Section 5.3.1 contains a complete profile 
        of the fields used in the QuickInvite command for all product categories.

        :param productCode: string         - Product code
        :param orderParameters: dict       - OrderParameters: ValidityPeriod, CSR, WebServerType
        :param organizationInfo: dict      - OrganizationInfo: OrganizationName, OrganizationAddress (array), ...
        :param adminContact: dict          - AdminContact: FirstName, LastName, Phone, Email, Title, ...
        :param techContact: dict           - TechContact: FirstName, LastName, Phone, Email, Title, ...
        :param billingContact: dict        - BillingContact: FirstName, LastName, Phone, Email, Title, ...
        :param approverEmail: string       - ApproverEmail: required for TrueBusinessID with EV. If you have another
                                             product, you can put an empty string here.
        :param options: dict               - Options
        
        :return dict of strings
        """
        headers = self.createRequestHeader(options)
        headers['ProductCode'] = productCode
        
        if 'PartnerOrderID' in options and 'InviteQuantity' not in orderParameters:
            headers['PartnerOrderID'] = options['PartnerOrderID']
            del options['PartnerOrderID']
            
        params = {
                  'OrderRequestHeader': headers,
                  'OrderParameters':    orderParameters,
                  'OrganizationInfo':   organizationInfo,
                  'AdminContact':       adminContact,
                  'TechContact':        techContact,
                  'BillingContact':     billingContact,
                  #'ApproverEmail':      approverEmail,
                  'RequestorEmail':     approverEmail,
                  }
        
        for key, val in options.iteritems():
            params[key] = val
            
        return self.sendSoap('QuickInvite', {'Request': params})
        
    def reissue(self, partnerOrderID, reissueEmail, options={}):
        """
        The Reissue operation allows partners to initiate the reissue of an order so that customers
        do not need to visit the GeoTrust website to initiate a reissue. Partners are expected to
        properly validate the authority of customers to initiate certificate reissues prior to using
        the API command to help assure that only an authorized person initiates the reissue.

        :param partnerOrderID: string     - partner order ID
        :param reissueEmail: string       - reissue email
        :param options: dict              - Options
        
        :return dict of strings
        """
        headers = self.createRequestHeader(options)
        
        headers['PartnerOrderID'] = partnerOrderID
        
        params = {
                  'OrderRequestHeader':     headers,
                  'OrderParameters':        options,
                  'ReissueEmail':           reissueEmail
                  }
        
        return self.sendSoap('Reissue', {'Request': params})
    
    def modifyOrder(self, partnerOrderID, orderOperation, options={}):
        """
        Lets you modify your order. This function only works in the test environment
        and is to help you simulate a fully processed order.

        Possible "ModifyOrderOperation" Values: (See API Section 5.3.4.12)
               APPROVE, RESELLER_APPROVE, RESELLER_DISAPPROVE, APPROVE_ESSL,
               REJECT, CANCEL, UPDATE_POST_STATUS, DEACTIVATE, REQUEST_ON_DEMAND_SCAN,
               UPDATE_SEAL_PREFERENCES, REQUEST_VULNERABILITY SCAN

        :param partnerOrderID: string - partner order ID
        :param orderOperation: string - ModifyOrderOperation
        :param options: dict          - Options
        
        :return dict of strings
        """
        headers = self.createRequestHeader(options)
        
        headers['PartnerOrderID'] = partnerOrderID
        
        params = {
                  'OrderRequestHeader':     headers,
                  'ModifyOrderOperation':   orderOperation
                  }
        
        for key, val in options.iteritems():
            params[key] = val
            
        return self.sendSoap('ModifyOrder', {'Request': params})
        
    def changeApproverEmail(self, partnerOrderID, approverEmail, options={}):
        """
        The ChangeApproverEmail operation allows partners to change the domain approver email for orders where the domain approval
        process has not been completed. This operation applies to all GeoTrust and Thawte domain validated and organization and domain
        validated certificates.

        :param partnerOrderID: string    - Partner order ID
        :param approverEmail: string     - New email approver
        :param options: dict             - Options
        
        :return dict of strings
        """
        headers = self.createRequestHeader(options)
        
        headers['PartnerOrderID'] = partnerOrderID
        
        params = {
                  'OrderRequestHeader': headers,
                  'ApproverEmail':      approverEmail
                  }
        
        return self.sendSoap('ChangeApproverEmail', {'Request': params})
    
    def validateOrderParameters(self, productCode, orderParams, options={}):
        """
        Allows partners to validate a number of order fields in one API message. This allows partners to perform
        validation prior to submitting an order, which provides a better UI experience for users.
        If any of the fields are invalid, an error will be returned listing all the errors. If there are no errors,
        the operation will provide responses for many of the values and include additional information.
        Optionally, the ValidateOrderParameters operation can also be invoked, specifying only the CSR to exclusively test validity of the CSR.

        :param productCode: string   - Product code
        :param orderParams: dict     - Order parameters
        :param options: dict         - Further optional parameters (add ReplayToken here)
        
        :return dict of strings
        """
        headers = self.createRequestHeader(options)
        
        if 'PartnerOrderID' in options:
            headers['PartnerOrderID'] = options['PartnerOrderID']
            del options['PartnerOrderID']
            
        params = {
                  'OrderRequestHeader': headers,
                  'OrderParameters':    orderParams
                  }
        
        for key, val in options.iteritems():
            params[key] = val
            
        return self.sendSoap('ValidateOrderParameters', {'Request': params})
    
    def resendEmail(self, productCode, partnerOrderID, resendMailType, options={}):
        """
        The ResendEmail operation allows partners to resend various email messages sent by GeoTrust
        in the course of processing orders. Certain email types may not apply for a particular order.

        :param productCode: string       - ProductCode
        :param partnerOrderID: string    - PartnerOrderID
        :param resendMailType: string    - Possible values: InviteEmail, ApproverEmail, PickUpEmail, FulfillmentEmail, PhoneAuthEmail
        :param options: dict             - Further optional parameters (add ReplayToken here)

        :return array of strings
        """
        headers = self.createRequestHeader(options)
        
        headers['ProductCode']      = productCode
        headers['PartnerOrderID']   = partnerOrderID
        
        params = {
                  'OrderRequestHeader': headers,
                  'ResendEmailType':    resendMailType
                  }
        
        for key, val in options.iteritems():
            params[key] = val
            
        return self.sendSoap('ResendEmail', {'Request': params})
        
    def revoke(self, certificate, revokeReason, options={}):
        """
        GeoTrust SSL revoke
        The following revoke functionality is currently available for GeoTrust certificates only.
        One of two reasons must be cited when submitting a GeoTrust revocation request via the API.

            - 'cessation of service' -- this revocation request is used when a partner wants to ensure
             non-use of a certificate the end customer has stopped paying for. In this instance,
             Symantec verifies the certificate is still live on a server prior to revoking the certificate.
        
            - 'key Compromise' -- this reason is cited when the certificates private key has been compromised.
             Symantec immediately revokes the certificate on approval when this reason is cited in the request.

        In each case, the request must be confirmed via a link sent in an email to the technical contact.

        :param certificate: string      - Certificate
        :param revokeReason: string     - Reason why you are revoking
        :param options: dict            - Further optional parameters (add ReplayToken here)
        
        :return dict of strings 
        """
        headers = self.createRequestHeader(options)
        
        params = {
                  'OrderRequestHeader': headers,
                  'Certificate':        certificate,
                  'RevokeReason':       revokeReason
                  }
        
        return self.sendSoap('Revoke', {'Request': params})
    
    def showReplayTokens(self):
        """ Returns all Replay Tokens you have used so far. """
        """ NOTE: Operation ShowReplayTokens not found in WSDL """
        
        headers = self.createRequestHeader()
        return self.sendSoap('ShowReplayTokens', {'PartnerCode': self.partnercode})
    