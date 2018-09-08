# firefox block css

* Open Firefox and press Alt to show the top menu, then click on Help → Troubleshooting Information
* Click the Show Folder button beside the Profile Folder entry
* Create a folder named chrome in the directory that opens
* In the chrome folder create a css file with the name userContent.css
* Copy the following code to userContent.css, replacing "example.com" with the website you want to modify and your own custom CSS, and restart Firefox:

@-moz-document domain(example.com) {
    img { opacity: 0.05 !important; }
}

