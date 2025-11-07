# Useful git command
1. To list committed files in git branch
```bash
git ls-tree --name-only -r <branch_name>
git ls-tree --name-only -r HEAD
```

2. To remove files in git but keep it in local storage
```bash
git rm --cached path/to/file
git rm --cached /\*.exe
```
3. To list all config
```bash
git config --list
git config -l
```
4. View git graph
```bash
git log --graph --full-history --all
git log --graph --full-history --all --pretty=format:"%h%x09%d%x20%s"
```
5. Remove submodule
```bash
git rm <path/to/submodule>
rm -rf .git/modules/<path/to/submodule>
git config --remove-section submodule.<path/to/submodule>
```
6. Restore single file
```bash
git checkout HEAD~1 -- my-file.txt # restore file in history
git restore pathTo/MyFile # restore file to HEAD
git restore -s master~2 pathTo/MyFile # restore file in commit history
git restore -s my-feature-branch pathTo/MyFile # restore from other branch
```
