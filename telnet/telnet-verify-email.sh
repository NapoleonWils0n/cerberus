#!/bin/sh

# Verifying an e-mail address
# Step 1 – Find the mail server:

host -t mx gmail.com

# Step 2 – Pick one and Telnet to port 25
telnet gmail-smtp-in.l.google.com 25

# Step 3: Mimic the Simple Mail Transfer Protocol (SMTP):
HELO test

#250 mx.google.com at your service

MAIL FROM: <test@test.com>
# 250 2.1.0 OK

# Step 4a: Positive test:
RCPT TO: <roelof.temmingh@gmail.com>

# 250 2.1.5 OK

# Step 4b: Negative test:
RCPT TO: <kosie.kramer@gmail.com>
# 550 5.1.1 No such user d26si15626330nfh

# Step 5: Say goodbye:
quit
# 221 2.0.0 mx.google.com closing connection d26si15626330nfh
