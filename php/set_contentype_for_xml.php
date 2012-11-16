<?php
if (stristr($_SERVER["HTTP_ACCEPT"],"application/xhtml+xml")) {
    header("Content-type: application/xhtml+xml");
    echo '<?xml version="1.0" encoding="UTF-8"?>';
    }
else { header("Content-type: text/html"); }
?> 