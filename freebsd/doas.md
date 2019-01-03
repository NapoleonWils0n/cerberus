# doas install

doas sudo alternative  
install doas

```
sudo pkg install doas
```

## create the doas config file

```
sudo vim /usr/local/etc/doas.conf
```

add the following code to the doas.conf file

```
permit nopass keepenv :wheel
permit nopass keepenv root as root
```

make sure your user is in the wheel group

The syntax is:

```
pw group mod {GROUP-NAME-HERE} -m {USERNAME-HERE}
pw group mod wheel -m username
```

### enable auto completion for doas and bash

edit your ~/.bashrc

```
vim ~/.bashrc
```

add the following code to your ~/.bashrc to enable doas bash auto completion

```
complete -cf doas
```

source your ~/.bashrc 

```
. ~/.bashrc
```
