#!/usr/bin/python


import sys
import requests
import re
import os




if len(sys.argv) < 5:
    print "ERROR: TOOLCHAIN_ID, BEARER, or PROJECT_NAME are not defined."
    exit(1)
    
    
TOOLCHAIN_ID = sys.argv[1]
BEARER = sys.argv[2]
PROJECT_NAME = sys.argv[3]
OUTPUT_FILE = sys.argv[4]
DRA_SERVICE_NAME = 'draservicebroker'
DRA_PRESENT = False
ORGANIZATION_GUID = ''
DRA_SERVER = ''



try:
    r = requests.get( 'https://devops-api.stage1.ng.bluemix.net/v1/toolchains/' + TOOLCHAIN_ID + '?include=metadata', headers={ 'Authorization': BEARER })
    
    data = r.json()
    #print data
    if r.status_code == 200:
        
        for items in data[ 'items' ]:
            #print items[ 'name' ]
            if items[ 'name' ] == PROJECT_NAME:
                #print items[ 'name' ]
                #print items[ 'organization_guid' ]
                ORGANIZATION_GUID = items[ 'organization_guid' ]
                
                for services in items[ 'services' ]:
                    #print services[ 'service_id' ]
                    if services[ 'service_id' ] == DRA_SERVICE_NAME:
                        DRA_PRESENT = True
                        #Test case
                        #services[ 'dashboard_url' ]='https://da.oneibmcloud.com/dalskdjl/ljalkdj/'
                        #print services[ 'dashboard_url' ]
                        urlRegex = re.compile(r'http\w*://\S+?/');
                        mo = urlRegex.search(services[ 'dashboard_url' ])
                        DRA_SERVER = mo.group()[:-1]
    else:
        #ERROR response from toolchain API
        print 'ERROR:', r.status_code, '-', data
        #print 'DRA was disabled for this session.'
except requests.exceptions.RequestException as e:
    print 'ERROR: ', e
    #print 'DRA was disabled for this session.'
    


        
        
if DRA_PRESENT:
    f = open(OUTPUT_FILE,'w')
    f.write(ORGANIZATION_GUID)
    f.write('\n')
    f.write(DRA_SERVER)
    f.close()
    exit(0)
else:
    exit(1)