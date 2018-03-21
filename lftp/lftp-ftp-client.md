# lftp ftp client

Create ~/.lftp directory

```
mkdir -p ~/.lftp
```

Create the ~/.lftp/rc file

```
vim ~/.lftp/rc
```

add the following code to the ~/.lftp/rc file

```
set ssl:check-hostname false;
```

