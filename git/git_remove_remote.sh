remove a remote from your local git repo
using the git remote rm command:

git remote -v
# View current remotes

# origin  git@github.com:user/repo.git (fetch)
# origin  git@github.com:user/repo.git (push)
# destination  git@github.com:forker/repo.git (fetch)
# destination  git@github.com:forker/repo.git (push)
git remote rm destination
# Remove remote

git remote -v
# Verify removal

# origin  git@github.com:user/repo.git (fetch)
# origin  git@github.com:user/repo.git (push)