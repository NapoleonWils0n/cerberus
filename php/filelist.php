<?php
  $dir = new RecursiveDirectoryIterator(".");
  foreach(new RecursiveIteratorIterator($dir) as $file) {
    if ($file->IsFile() &&
        $file != "./manifest.php" &&
        !preg_match('/.php$/', $file) &&
        substr($file->getFilename(), 0, 1) != ".")
    {
   	  echo "<ul>";
      echo "<li><a href=\"$file\">$file</a></li>";
      echo "</ul>";
    }
  }
?>