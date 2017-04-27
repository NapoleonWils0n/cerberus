# Pandoc webclipper

## javascript bookmarklet

javascript bookmarklet

```
javascript:(function()%7Bvar node%3Ddocument.createElement('div')%3Bnode.appendChild(getSelection().getRangeAt(0).cloneContents())%3Blocation.href='pandoc-protocol://'+'[title]'+(document.title)+'[/title]'+'[content]'+(node.innerHTML)+'[/content]'%3B%7D)()%3B
```

## mimedatabase

```
[MIME Cache]
x-scheme-handler/pandoc-protocol=pandoc-protocol.desktop;
```

## desktop file

```
[Desktop Entry]
Name=pandoc-protocol
Exec=web-clipper %u
Type=Application
Terminal=false
Categories=System;
MimeType=x-scheme-handler/pandoc-protocol;
```

## script

```
#!/usr/bin/env bash

# extract title, content with awk
title=$(awk -F "[][]" '/title/{print $3}' <<<"$@")
content=$(awk -F "[][]" '/content/{print $7}' <<<"$@")

# pandoc convert content and save with title as filename
pandoc <<<"$content" -f html -t html5 --normalize -s --self-contained --variable pagetitle="$title" -o "$HOME/Desktop/${title}.html"
```
