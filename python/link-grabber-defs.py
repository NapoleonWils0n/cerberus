from urllib.request import Request, urlopen, re, urlparse

url=''

def getheads(): 
	r = requests.get(url)
	print(type(r))
	print(r.status_code)
	print(r.headers)
	print(r.headers['content-type'])
	
	############# these settings are optional
	# print(r.text)
	#data= r.json()
	#print (data)
	#print (data['origin'])
	

##### playlist location needs to be a default location  set at line 42 f.open
def getplaylists():
	req = Request(url, headers={'User-Agent':'Mozilla/5.0'})
	web_byte = urlopen(req).read()
	webpage = web_byte.decode('utf-8')
	newlink= (re.search("(?P<url>https?://[^\s]+)", webpage).group("url"))
	channel= url.rsplit('/', 1)[-1]
	auth=newlink.rsplit('?', )[1]
	channel_name= channel.rsplit('.', 1)[0]
	data = '<item>\n<title>' + str(channel_name) + '</title>\n<link>' + str(newlink) +'</link>\n<thumbnail></thumbnail>\n</item>\n'
	f= open("c:/pilfer/playlists/pilfer-playlist.xml","a+")
	f.write(data)
	f.close
	print (newlink)
	print ()
	print ('authorisation code for ' + str(channel_name) + " " + str(auth))
	#print (webpage)
	
def getlinks
	content_allow = ['text/plain', 'text/html']
	class Links(object):

		"""Grabs links from a web page
		based upon a URL and filters"""

		def __init__(self, href=None, text=None, parser='lxml'):
			""" Create instance of Links class

			:param href: URL to download links from
			:param text: Search through text for links instead of URL
			:param parser: Parser for BeautifulSoup library. [default: lxml]
			"""
			if href is not None and not href.startswith('http'):
				raise ValueError("URL must contain http:// or https://")
			elif href is not None:
				self._href = href
				self._response = requests.get(self._href)
				if self._response.status_code != 200:
					raise ValueError('Response FAIL: %s' %
									self._response.status_code)

				if not hasattr(self._response, 'headers'):
					raise ValueError('Response has not headers')

				if 'content-type' not in self._response.headers:
					raise ValueError('content-type information is not available')

				self._ctype = self._response.headers['content-type'].rsplit(';')[0]
				if self._ctype not in content_allow:
					raise ValueError(
						'the content-type %s is not textable' % self._ctype)

				self._text = self._response.text

			elif href is None and text is not None:
				self._text = text
			else:
				raise ValueError("Either href or text must not be empty")

			self._soup = BeautifulSoup(self._text, parser)

		def __repr__(self):
			return "<Links {0}>".format(self._href or self._text[:15] + '...')

		@property
		def text(self):
			return self._text

		@property
		def response(self):
			return self._response

		def find(self, limit=None, reverse=False, sort=None,
				exclude=None, duplicates=True, pretty=False, **filters):
			""" Using filters and sorts, this finds all hyperlinks
			on a web page

			:param limit: Crop results down to limit specified
			:param reverse: Reverse the list of links, useful for before limiting
			:param exclude: Remove links from list
			:param duplicates: Determines if identical URLs should be displayed
			:param pretty: Quick and pretty formatting using pprint
			:param filters: All the links to search for """
			if exclude is None:
				exclude = []

			if 'href' not in filters:
				filters['href'] = True
			search = self._soup.findAll('a', **filters)

			if reverse:
				search.reverse()

			links = []
			for anchor in search:
				build_link = anchor.attrs
				try:
					build_link[u'seo'] = seoify_hyperlink(anchor['href'])
				except KeyError:
					pass

				try:
					build_link[u'text'] = anchor.string or build_link['seo']
				except KeyError:
					pass

				ignore_link = False
				for nixd in exclude:
					for key, value in six.iteritems(nixd):
						if key in build_link:
							if (isinstance(build_link[key], collections.Iterable)
									and not isinstance(build_link[key], six.string_types)):
							for item in build_link[key]:
									ignore_link = exclude_match(value, item)
							else:
								ignore_link = exclude_match(value, build_link[key])

				if not duplicates:
					for link in links:
						if link['href'] == anchor['href']:
							ignore_link = True

				if not ignore_link:
					links.append(build_link)

				if limit is not None and len(links) == limit:
					break

			if sort is not None:
				links = sorted(links, key=sort, reverse=reverse)

			if pretty:
				pp = pprint.PrettyPrinter(indent=4)
				return pp.pprint(links)
			else:
				return links


	def exclude_match(exclude, link_value):
		""" Check excluded value against the link's current value """
		if hasattr(exclude, "search") and exclude.search(link_value):
			return True

		if exclude == link_value:
			return True

		return False


	def seoify_hyperlink(hyperlink):
		"""Modify a hyperlink to make it SEO-friendly by replacing
		hyphens with spaces and trimming multiple spaces.

		:param hyperlink: URL to attempt to grab SEO from """
		last_slash = hyperlink.rfind('/')
		return re.sub(r' +|-', ' ', hyperlink[last_slash + 1:])
