#!/usr/bin/env python3.6

# try import modules
try:
    import sys
    import re
    import requests
    from urllib.parse import urlparse
except ImportError:
    print('Import error')

# main
def main(argv):

    if len(argv) == 0: # no arguments passed to script
        print("No arguments passed to script")
        sys.exit()
    elif len(argv) > 1: # too many arguments passed to script
        print("Too many arguments passed to script")
        sys.exit()

    # base url passed as first arg to script
    url=(argv[0])

    # get domain from url
    parse_domain = urlparse(url)
    domain = '{uri.scheme}://{uri.netloc}'.format(uri=parse_domain)
    domain_netloc = '{uri.netloc}'.format(uri=parse_domain)

    # domains
    tvcatchup='tvcatchup.com'

    def pagehtml(url, referer=None):
        # requests open page
        try:
            # requests headers
            user_agent = 'Mozilla/5.0 (iPad; U; CPU OS 3_2 like Mac OS X; en-us) AppleWebKit/531.21.10 (KHTML, like Gecko) Version/4.0.4 Mobile/7B334b Safari/531.21.10'
            if referer:
                headers = {'user-agent': user_agent, 'referer': referer}  
            else:
                headers = {'user-agent': user_agent}  
            r = requests.get(url,headers=headers,timeout=10)
            r.raise_for_status()
            thepage = r.text
        except requests.exceptions.HTTPError as errh:
            thepage = None
            print ("Http Error:",errh)
        except requests.exceptions.ConnectionError as errc:
            thepage = None
            print ("Error Connecting:",errc)
        except requests.exceptions.Timeout as errt:
            thepage = None
            print ("Timeout Error:",errt)
        except requests.exceptions.RequestException as err:
            thepage = None
            print ("OOps: Something Else",err)
        return thepage

    def tv(thehtml):
        pageComp = re.compile('source[\s]+src=[\'\"](.*?)[\'\"]')
        pageFind = pageComp.findall(thehtml)
        if pageFind:
            return pageFind
        else:
            print("no match")
            sys.exit()
    # check domain
    if tvcatchup in domain_netloc:
        try:
            # download page
            page = pagehtml(url)
            catchup = tv(page)
            result = catchup[0]
            print(result)
        except (ValueError,IndexError):
            print("ValueError,IndexError")
    else:
        print('Domain not matched')

#def entry():
#    main(sys.argv[1:])

if __name__ == "__main__":
    main(sys.argv[1:])
