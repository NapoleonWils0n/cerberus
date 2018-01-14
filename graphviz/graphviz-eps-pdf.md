# graphviz convert to eps and svg

convert graphviz gv file to svg 

```
dot -Tsvg graph.gv -o graph.svg
```

convert graphviz gv file to eps

```
dot -Teps graph.gv -o graph.eps
```

use epstopdf to convert eps file to pdf

```
epstopdf graph.eps
```
