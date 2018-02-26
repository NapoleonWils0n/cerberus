# awk extract text inside brackets

```
awk -F'[][]' -v RS=" " '/http/ {print $2}'
```
