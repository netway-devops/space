===========================
INSTALL ON LINUX
===========================
yum install -y python-setuptools
easy_install virtualenv
export VENV=~/env
virtualenv $VENV
$VENV/bin/pip install flask
$VENV/bin/pip install datetime
$VENV/bin/pip install pprint
cd /home/rvglobal/sslsoapserv/PySimpleSOAP-1.10
$VENV/bin/python setup.py build
$VENV/bin/python setup.py install
$VENV/bin/pip install phpserialize
$VENV/bin/pip install httplib2


===========================
INSTALL ON UBUNTO
===========================
sudo easy_install virtualenv
export VENV=~/env
virtualenv $VENV

$VENV/bin/pip install flask
$VENV/bin/pip install datetime
$VENV/bin/pip install pprint
wget http://pysimplesoap.googlecode.com/files/PySimpleSOAP-1.10.zip
unzip PySimpleSOAP-1.10.zip
cd PySimpleSOAP-1.10
$VENV/bin/python setup.py build
$VENV/bin/python setup.py install
$VENV/bin/pip install phpserialize
$VENV/bin/pip install httplib2



=========================================================
RUN SERVER
=========================================================
$VENV/bin/python app.py


=========================================================
HOW TO FIX:
=========================================================
 1. Error: httplib2.SSLHandshakeError: [Errno 1] _ssl.c:504: error:14077410:SSL routines:SSL23_GET_SERVER_HELLO:sslv3 alert handshake failure
 1.1 edit file /root/env/lib/pythonX.Y/site-packages/httplib2/__init__.py
 Fix Code:
  def _ssl_wrap_socket(sock, key_file, cert_file,
                         disable_validation, ca_certs):
        if disable_validation:
            cert_reqs = ssl.CERT_NONE
        else:
            cert_reqs = ssl.CERT_REQUIRED
        # We should be specifying SSL version 3 or TLS v1, but the ssl module
        # doesn't expose the necessary knobs. So we need to go with the default
        # of SSLv23.
        return ssl.wrap_socket(sock, keyfile=key_file, certfile=cert_file,
                               cert_reqs=cert_reqs, ca_certs=ca_certs)
  
  with:
  
    def _ssl_wrap_socket(sock, key_file, cert_file,
                         disable_validation, ca_certs):
        if disable_validation:
            cert_reqs = ssl.CERT_NONE
        else:
            cert_reqs = ssl.CERT_REQUIRED
        # We should be specifying SSL version 3 or TLS v1, but the ssl module
        # doesn't expose the necessary knobs. So we need to go with the default
        # of SSLv23.
        try:
            tempsock = ssl.wrap_socket(sock, keyfile=key_file, certfile=cert_file,
                 cert_reqs=cert_reqs, ca_certs=ca_certs, ssl_version=ssl.PROTOCOL_TLSv1)
        except ssl.SSLError, e:
            try:
                tempsock = ssl.wrap_socket(sock, keyfile=key_file, certfile=cert_file,
                    cert_reqs=cert_reqs, ca_certs=ca_certs, ssl_version=ssl.PROTOCOL_SSLv3)
            except ssl.SSLError, e:
                tempsock = ssl.wrap_socket(sock, keyfile=key_file, certfile=cert_file,
                    cert_reqs=cert_reqs, ca_certs=ca_certs, ssl_version=ssl.PROTOCOL_SSLv23)
        return tempsock
        
=========================================================
CAN NOT ENCODE CHARACTERS:
=========================================================
<simplexml.py>
import sys
reload(sys)
sys.setdefaultencoding('utf-8')
        
IN PHP CHANGE ENCODE WITH :
header('Content-type: text/html; charset=utf-8');