import urllib2
from base64 import encodestring
import json

request = urllib2.Request('http://127.0.0.1/api/v2/inventories/')
base64string = encodestring('%s:%s' % ('admin', 'password')).replace('\n', '')
request.add_header('Authorization', 'Basic %s' % base64string)
r = urllib2.urlopen(request)

#print r.getcode()
#print r.headers["content-type"]
#r = urllib2.urlopen(request)
data = json.load(r)
inv_count = data["count"]
while inv_count > 0:
  print data["results"][ + inv_count + ]["id"]
  #print data["results"][inv_count]["name"]
  inv_count -= 1
  print "=============================="
#print r.headers["X-RateLimit-Limit"]
