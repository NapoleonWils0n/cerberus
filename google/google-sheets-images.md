# google sheet images

google sheets images on google drive

format for images to display in fusion tables
replace FILE_ID with the files id

https://drive.google.com/uc?export=download&id=FILE_ID

google sheet formula to convert images upload with google forms to format that displays images in fusion table

create a new row in the spreadsheet and give the column a name  
in the second cell paste in the code below  

Change E2:E to the column with the images uploaded by google forms

```
=ARRAYFORMULA(SUBSTITUTE(E2:E,"https://drive.google.com/open?id=","https://drive.google.com/uc?export=download&id="))
```

eg if the images are in column c, change E2:E to C2:C  

the same code but using ifblank

```
=ARRAYFORMULA(IF(ISBLANK(E2:E), "",SUBSTITUTE(E2:E,"https://drive.google.com/open?id=","https://drive.google.com/uc?export=download&id=")))
```
