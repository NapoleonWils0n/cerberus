#/bin/sh
 
NAME="John Doe"
ADDRESS="1 Fictitious Rd, Bucksnort, TN"
PHONE="(555) 555-5555"
GPA="3.885"
printf "%20s | %30s | %14s | %5s\n" "Name" "Address" "Phone Number" "GPA"
printf "%20s | %30s | %14s | %5.2f\n" "$NAME" "$ADDRESS" "$PHONE" "$GPA"