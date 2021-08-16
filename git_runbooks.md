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

### error: src refspec master does not match any: [reference](https://stackoverflow.com/questions/21264738/error-src-refspec-master-does-not-match-any/54158784)
```shell
# Option 01: 
# You can rename the branch with -mv flag, like this:
$ git branch -mv origin master

# Option 02:
# Oops! Never committed!
$ git commit -m "initial commit"
$ git push origin master
