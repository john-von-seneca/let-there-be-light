import pycurl
import re

#print("{query}")
input_arg = '9601f0a6ab90874e8c0a9d93f9a7b1e5#The Martian [Reprint ed.]  - Andy Weir - 2014.epub'

#input_arg = "{query}"
md5_hash, filename = input_arg.split('#')

reg_exp = re.compile("\\\\")
filename = reg_exp.sub('', filename)
#print(filename)

status = 'failed'
with open(filename, 'wb') as f:
    c = pycurl.Curl()
    c.setopt(c.URL, 'http://libgen.io/get.php?md5='+md5_hash)
    c.setopt(c.FOLLOWLOCATION, True)
    c.setopt(c.WRITEDATA, f)
    c.perform()
    status = 'Status: %d' % c.getinfo(c.RESPONSE_CODE)
    c.close()
print(status + " :: " + filename)

## todo
## if libgen fails, have to parse bookzz and use curl again to dwld
