# tidy html remove font tags
#=======================================================================

# tidy remove font tags and output html head and body tags
tidy -mibq --doctype strict --drop-font-tags yes --tidy-mark no --output-xhtml yes clean-index.htm

# m = modify original file
# i = indent
# b = bare strip quotes
# q = quiet
# --doctype strict = strict xhtml doctype
# --drop-font-tags yes = remove font tags
# --tidy-mark no = dont show tidy text
# --output-xhtml yes = output closing tags

# tidy remove font tags and dont output html head and body tags
tidy -mibq -omit --doctype omit --drop-font-tags yes --tidy-mark no --show-body-only yes --output-xhtml yes clean-index.htm


# m = modify original file
# i = indent
# b = bare strip quotes
# q = quiet
# -omit = omit optional end tags
# --doctype omit = omit doctype
# --drop-font-tags yes = remove font tags
# --tidy-mark no = dont show tidy text
# --show-body-only yes = only output text between body tags
# --output-xhtml yes = output closing tags


find . -type f -regex ".*\.\(htm\|html\)$" |
while read file
do
hxnormalize -x "$file" | \
hxselect -s '\n' -c  \
'html>body>table>tbody>tr>td:nth-of-type(2)>table>tbody>tr:nth-of-type(5)>td>table>tbody>tr>td' | \
tidy -mibq --doctype strict --drop-font-tags yes --tidy-mark no --output-xhtml yes -o "$file"
done
