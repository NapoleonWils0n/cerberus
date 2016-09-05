# sed insert yaml header

sed insert empty yaml header at top of file for jekyll

```
sed -i '1i ---\n---\n' foo.md 
```

* find markdown files and use sed to insert yaml header

```
find . -type f -regex ".*\.md$" -exec sed -i '1i ---\n---\n' '{}' \;
```
