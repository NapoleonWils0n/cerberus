# remove file by its inode number

remove a file by its inode number

use ls with the -i option to list files and their inode number  
and -l for long format

```
ls -il
```

125657 -rw-r--r--  1 username  username  0 Sep 24 20:24 bar

Then use find with the -inum option and the inode number to delete the file

```
find . -inum 125657 -exec rm {} \;
```
