# find symlinks in home directory

find symlinks in your home directory and where they point to

```
find $HOME -type l -ls | awk '{print $NF}'
```
