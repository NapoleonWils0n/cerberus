#!/bin/sh

# ===============================================
# = chmod - chgrp chown - Modifying Permissions =
# ===============================================
 

# 'chmod' changes file permissions (change modes) by specifying permissions for the user owner, the group owner, and all others.
# A single letter mnemonic is used to represent each class of user, and each class of permission.

# 'u' is for user owner, 'g' is for group owner, 'o' is for others.
# 'r' is for read permission, 'w' is for write permission, and 'x' is for execute permission.


# To set permissions to read, write, and execute (rwx) for the user owner (u) use:

chmod u=rwx file-name


# To set permissions to read and execute (rx) for the group owner (g) use:

chmod g=rx file-name


# And finally, to set permissions to read (r) for others (o) use:

chmod o=r file-name


# These can be set all at once by separating the permission sets by commas.


chmod u=rwx,g=rx,o=r file-name

ls -l file-name



# One may add or remove permissions by replacing the equals with a plus sign to add, or a minus sign to remove. Permissions that are not mentioned are left untouched.


# Take away read permission for others:

chmod o-r file-name


# Add write permission for the group:

chmod g+w file-name


 # ===================
 # = Changing Owners =
 # ===================

# 'chown' changes the user owner and/or group owner of a file. Note that only user 'root' is allowed to change the owner of a file, so the command must be run using sudo.

# To change the owners of a file, give the new user owner and group owner separated by a colon:

# For example, change the group owner keeping the user owner the same:

chown admin file-name

ls -l file-name



# To change both the user owner and the group owner:


sudo chown janice:staff file-name

# Password:   (give your administrator password here)

ls -l file-name

