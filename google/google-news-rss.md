# google news rss feeds

Found an up-to-date library (1) that uses Google News RSS.

The URL new format seems to be:

Top news:

https://news.google.com/news/rss

By topic:

https://news.google.com/news/rss/headlines/section/topic/{topic}

Where {topic} is one of the following values WORLD NATION BUSINESS TECHNOLOGY ENTERTAINMENT SPORTS SCIENCE HEALTH

Custom topics does not seem to work.

By geolocation:

https://news.google.com/news/rss/headlines/section/geo/{location}

Not sure about the formatting for the {location} parameter

By search query

https://news.google.com/news/rss/search/section/q/{query}

Where the {query} parameter is a free text search

Specifying country and language

For example if you wish to have news in Swedish and located from Swedish sources, add the following query string to the URL to change country and language to sv-SE: ?hl=sv&gl=SE&ceid=SE%3Asv
