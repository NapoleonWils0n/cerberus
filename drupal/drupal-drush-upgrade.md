# Upgrade Using Drush

In order to upgrade your Drupal web site using Drush, you should first log in your account via SSH. Detailed instructions on how to use SSH can be found in our SSH tutorial. After you login to your account via SSH, navigate to the Drupal installation’s home folder.

Then run the following command below to check for available updates:
	
```
drush ups
```

After the check for updates, you should enable maintenance mode on your website using the command below:
	
```
drush sset system.maintenance_mode 1
```

Afterwards clear the application's cache:
	
```
drush cr
```

To begin with the actual upgrade, execute the command below:
	
```
drush up drupal
```

After the application's core is upgraded, you should make sure to update the database as well.
	
```
drush updb
```

Update entity, if any required entity updates are needed:
	
```
drush entup
```

The final step would be to simply deactivate maintenance mode 
	
```
drush sset system.maintenance_mode 0
```

clear the cache once more

```
drush cr
```
