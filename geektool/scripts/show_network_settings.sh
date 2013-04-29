networksetup -getairportnetwork en0
echo "------------------------------"; 
printf "Lan: "
ifconfig en0 |grep -E 'inet.[0-9]' | grep -v '127.0.0.1' | awk '{ print $2}'

echo "------------------------"
printf "Wan: "
curl -s "http://v4.ipv6-test.com/api/myip.php"
echo \\n"------------------------"

printf "IPV6: "
curl -s 'http://v6.ipv6-test.com/api/myip.php'
echo \\n"------------------------"
printf "DNS: "; networksetup -getdnsservers Wi-Fi | tr '\n' ' '
echo \\n"------------------------"