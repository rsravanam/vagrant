#!/usr/bin/env python

import urllib2
import json
import sys
import base64
import csv
from datetime import datetime

BASEURL='http://awx.mshome.net/api/v2/inventories'
USERNAME = 'admin'
PASSWORD = 'password'
dt = datetime.now().date()
dt = str(dt)
csv_file = "test-" + dt + ".csv"
next_page = ""

def searchINV(next_page,csv_file):

  path = next_page
  uri = BASEURL + "/?" + path

  while True:

    try:

      req = urllib2.Request(uri)
      base64string = base64.encodestring('%s:%s' % (USERNAME, PASSWORD)).replace('\n', '')
      req.add_header("Authorization", "Basic %s" % base64string)
      req = urllib2.urlopen(req)
      ids = req.read()
      inv_ids = json.loads(ids)
      data = (inv_ids['results'])
      row = ['Id', 'Inventory', 'Hosts']
  
      with open(csv_file, 'w') as csvFile:
        writer = csv.writer(csvFile)
        writer.writerow(row)
	
      csvFile.close()
	   
      for item in data:

        ids = item['id']
        ids = str(ids)
        iname = item['name']
        nhosts = item['total_hosts']
        nhosts = str(nhosts)

        try:

          print ids + "," + iname + "," + nhosts
          row = [ids, iname, nhosts]
  
          with open(csv_file, 'a') as csvFile:
            writer = csv.writer(csvFile)
            writer.writerow(row)
	
          csvFile.close()
		  
        except AttributeError:

          break

      next_page = (inv_ids['next'])

      if next_page == []:

        break

      else:

        next_page = next_page.split('?')[1]
        searchINV(next_page)

    except AttributeError:

      break

  return 0

searchINV(next_page,csv_file)

