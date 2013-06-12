#!/bin/bash

# textmate rmate script set up

# copy rmate to the server
scp /Applications/TextMate.app/Contents/Frameworks/Preferences.framework/Versions/A/Resources/rmate user@sshserver.com:/home/user/bin

# ssh command
ssh -R 52698:127.0.0.1:52698 user@sshserver.com

# ssh config
RemoteForward 52698 127.0.0.1:52698