#!/usr/bin/env python
'''
#@LICENSE@#
'''

import sys

try:
    from pysimplesoap.client import SoapClient
except :
    sys.exit("Error: Cannot import 'SoapClient' library, you make sure to install PySimpleSoap module.\nYou can download 'PySimpleSoap' at https://code.google.com/p/pysimplesoap")

__module_name__ = "PySymantecApi"
__dic__ = "Python Symatec API connection by RV Global Soft"
__author__ = "Pairote Rojanaphusit"
__author_email__ = "pairote@rvglobalsoft.com"
__copyright__ = "Copyright (C) 2015 RV Global Soft"
__license__ = "LGPL 3.0"
__version__ = "1.0.1"

TIMEOUT = 60
    