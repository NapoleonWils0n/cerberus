function FindProxyForURL(url, host) {
    // Your proxy server name and port
    var proxyserver = '127.0.0.1:9050';
    //
    //  Here's a list of hosts to connect via the PROXY server
    //
    var proxylist = new Array(
        "proxydetect.com",
	"1337x.org",
	"abmp3.com",
	"beemp3s.org",
	"btindex.org",
	"bitsnoop.com",
	"bomb-mp3.com",
        "btdigg.org",
	"emp3world.cc",
	"extratorrent.cc",
        "eztv.it",
	"filecrop.com",
	"filestube.com",
	"ifirstrowuk.eu",
        "kickass.to",
	"monova.org",
	"mp3juices.com",
	"mp3lemon.org",
	"mp3raid.com",
	"mp3skull.com",
	"newalbumreleases.net",
	"projectfree.tv",
	"rapidlibrary.com",
        "rarbg.com",
	"thepiratebay.se",
	"torrentcrazy.com",
        "torrentfreak.com",
	"torrent-finder.info",
	"torrentsdownload.org",
	"torrentdownloads.me",
	"torrenthound.com",
	"torrentreactor.net",
	"torrents.to",
	"torrentz.eu",
	"yify-torrents.com"
    );
    // Return our proxy name for matched domains/hosts
    for(var i=0; i<proxylist.length; i++) {
        var value = proxylist[i];
        if ( localHostOrDomainIs(host, value) ) {
            return "SOCKS "+proxyserver;
        }
    }
    return "DIRECT";
}