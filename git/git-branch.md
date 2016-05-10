# git branch

Create the branch on your local machine and switch in this branch :

```
$ git checkout -b [name_of_your_new_branch]
```

You can see all branches created by using :

```
$ git branch
```

switch back to the master branch and then merge

Then you need to apply to merge changes,
if your branch is derivated from develop you need to do :

```
$ git merge [name_of_your_remote]/develop
```

Delete a branch on your local filesystem :

```
$ git branch -d [name_of_your_new_branch]
```

To force the deletion of local branch on your filesystem :

```
$ git branch -D [name_of_your_new_branch]
```

