### Create am empty branch with no history [reference](https://stackoverflow.com/questions/34100048/create-empty-branch-on-github/55943394)

```shell
# go to existing repo folder
$ git checkout --orphan empty-branch

# Then you can remove all the files you'll have in the staging area
$ git rm -rf .

# Before you can push to GitHub (or any other Git repository), you will need at least one commit, 
# even if it does not have any content on it (i.e. empty commit), as you cannot push an empty branch
$ git commit --allow-empty -m "root commit"

# Finally, push it to the remote
$ git push origin empty-branch
```
