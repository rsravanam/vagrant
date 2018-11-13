import httplib2

h = httplib2.Http(".cache")
h.add_credentials('admin', 'password')
r, content = h.request("http://127.0.0.1/", "GET")

print r['status']
print r['content-type']
