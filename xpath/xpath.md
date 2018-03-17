# xpath tips

## Firefox

Right click on the page and select inspect element to open the web inspector
Open the console tab

Type the xpath like so

```
$x("path")
```

Where path is you xpath query


```
$x("//title")
```

### xpath queries

* a href

find all links on the page and return the link

```
$x("//a/@href")
```

find all links on the page that contain a string of text and return the link
where some string is the string to search for 

```
$x("//a[contains(@href, 'somestring')]/@href")
```

find all links on the page and return the link text


```
$x("//a/text()")
```

* Images

find all the images on the page and return the src attribute

```
$x("//img/@src")
```
