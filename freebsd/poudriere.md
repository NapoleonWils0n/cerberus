# poudriere

poudriere package building environment

switch to root using either sudo or doas

* switch to root using sudo 

```
sudo su
```

* or use doas to switch to root

```
doas su
```

the hash symbol # before a command indicates that the command needs to be run as root

## Create an SSL Certificate and Key

When we build packages with poudriere, we want to be able to sign them with a private key. This will ensure all of our machines that the packages created are legitimate and that nobody is intercepting the connection to the build machine to serve malicious packages.

To start off, we will create a directory structure for our key and certificate. Since all of our optional software configuration takes place within the /usr/local/etc directory, and because other software uses the /usr/local/etc/ssl location, this is where we will place our files.

We will ensure that we have an ssl directory that contains two subdirectories called keys and certs. We can do this in one command by typing:

```
# mkdir -p /usr/local/etc/ssl/{keys,certs}
```

Our private key, which must be kept secret, will be placed in the keys directory. This will be used to sign the packages that we will be creating. Keeping this secure is essential to ensuring that our packages are not being tampered with. We can lock down the directory so that users without root or sudo privileges will be unable to interact with the directory or its contents:

```
# chmod 0600 /usr/local/etc/ssl/keys
```

The certs directory will contain our publicly available certificate created with the key. As such, we can leave the default permissions on that directory.

Next, we will generate a 4096 bit key called poudriere.key, and place it in our keys directory by typing:

```
# openssl genrsa -out /usr/local/etc/ssl/keys/poudriere.key 4096
```

After the key is generated, we can create a public cert from it by typing:

```
# openssl rsa -in /usr/local/etc/ssl/keys/poudriere.key -pubout -out /usr/local/etc/ssl/certs/poudriere.cert
```

We now have the SSL components we need to sign packages and verify the signatures. Later on, we will configure our clients to use the generated certificate for package verification.

## poudriere install

```
# pkg install poudriere
```

edit the poudriere.conf file

```
# vi /usr/local/etc/poudriere.conf
```

### Creating the Build Environment

```
# poudriere jail -c -j freebsd_12-0x64 -v 12.0-RELEASE
```

This will take awhile to complete, so be patient.  
When you are finished, you can see the installed jail by typing:

```
poudriere jail -l
```

Once you have a jail created, we will have to install a ports tree. It is possible to maintain multiple ports trees in order to serve different development needs. We will be installing a single ports tree that our jail can utilize.

We can use the -p flag to name our ports tree. We will call our tree "HEAD" as it accurately summarizes the use of this tree (the "head" or most up-to-date point of the tree). We will be updating it regularly to match the most current version of the ports tree available:

```
# poudriere ports -c -p HEAD
```

Again, this procedure will take awhile because the entire ports tree must be fetched and extracted. When it is finished, we can view our ports tree by typing:

```
# poudriere ports -l
```

### Creating a Port Building List and Setting Port Options

We will be creating a list of ports that we can pass directly to the command.  

```
# vi /usr/local/etc/poudriere.d/port-list 
```

The file create should list the port category followed by a slash and the port name to reflect its location within the ports tree, like this:

```
net-p2p/rtorrent
```

If you use specific make.conf options to build your ports, you can create a make.conf file for each jail within your /usr/local/etc/poudriere.d directory. For example, for our jail, we can create a make.conf file with this name:

```
# vi /usr/local/etc/poudriere.d/freebsd_12-0x64-make.conf
```

```
OPTIONS_UNSET+= DOCS NLS X11 EXAMPLES
```

Afterwards, we can configure each of our ports, which will create files with the options we selected.

You can configure anything which has not been already configured using the options command. We should pass in both the port tree we created (using the -p option) and the jail we are setting these options for (using the -j option). We also must specify the list of ports we want to configure using the -f option.

Our command will look like this:

```
# poudriere options -j freebsd_12-0x64 -p HEAD -f /usr/local/etc/poudriere.d/port-list
```

You will see a dialog for each of the ports on the list and any dependencies that do not have corresponding options set in the -options directory. The specifications in your make.conf file will be preselected in the selection screens. Select all of the options you would like to use.

If you wish to reconfigure the options for your ports in the future, you can re-run the command above with the -c option. This will show you all of the available configuration options, regardless of whether you have made a selection in the past:

```
# poudriere options -c -j freebsd_12-0x64 -p HEAD -f /usr/local/etc/poudriere.d/port-list
```

### Building the Ports

Now, we are finally ready to start building ports.

The last thing we need to do is ensure that both our jail and ports tree are up-to-date. This probably won't be an issue the first time you build ports since we just created both the ports tree and the jail, but it is good to get in the habit to do this each time you run a build.

To update your jail, type:

```
# poudriere jail -u -j freebsd_12-0x64
```

To update your ports tree, type:

```
# poudriere ports -u -p HEAD
```

Once that is complete, we can kick off the bulk build process.

```
# poudriere bulk -j freebsd_12-0x64 -p HEAD -f /usr/local/etc/poudriere.d/port-list
```

This will start up a number of workers (depending on your poudriere.conf file or the number of CPUs available) and begin building the ports.

At any time during the build process, you can get information about the progress by holding the CTRL key and hitting t:

```
CTRL-t
```

## Configuring pkg Clients to Use a Poudriere Repository
	
	

Now that you have packages built and a repository configured to serve your packages, you can configure your clients to use your the server as the source of their packages.
Configuring the Build Server to Use Its Own Package Repo

We can begin by configuring the build server to use the packages it has been building.

First, we need to make a directory to hold our repository configuration files:

```
# mkdir -p /usr/local/etc/pkg/repos
```

Inside this directory, we can create our repository configuration file. It must end in .conf, so we will call it poudriere.conf to reflect its purpose:

```
# vi /usr/local/etc/pkg/repos/poudriere.conf
```

We will define the repository name as poudriere once again. Inside the definition, we will point to the location on disk where our packages are stored. This should be a directory that combines your jail name and port tree name with a dash. Check your filesystem to be certain. We will also set up signature validation of our packages by pointing to the certificate we created.

In the end, your file should look something like this:

```
Poudriere: {
    url: "file:///usr/local/poudriere/data/packages/freebsd_12-0x64-HEAD"
    mirror_type: "srv",
    signature_type: "pubkey",
    pubkey: "/usr/local/etc/ssl/certs/poudriere.cert",
    enabled: yes,
    priority: 100
}
```

At this point, you need to make a decision. If you want to prefer your compiled packages and fall back on the packages provided by the main FreeBSD repositories, you can set a priority here, telling it to prefer packages out of this repository. This will cause our local repository to take priority over the official repositories.

Keep in mind that mixing packages in this way can have some complicated consequences. If the official repositories have a package version that is higher than your local repository version, your compiled package may be replaced by the generic one from the official repositories (until you rebuild with poudriere and reinstall with pkg). Also, the official packages may assume that dependent packages are built in a certain way and may not function when mixed with your custom packages.

If you choose to mix these two package sources, be prepared to carefully audit each install to ensure that you are not accidentally causing undesirable behavior.

To mix packages, add a priority setting to your repository definition, specifying that the local repo has a higher precedence

Update the repo info:

```
# pkg update
```
