<?php
  header('Content-Type: text/cache-manifest');
  echo "CACHE MANIFEST\n";

  $hashes = "";

  $dir = new RecursiveDirectoryIterator(".");
  foreach(new RecursiveIteratorIterator($dir) as $file) {
    if ($file->IsFile() &&
        $file != "./manifest.php" &&
        !preg_match('/.php$/', $file) &&
        substr($file->getFilename(), 0, 1) != ".")
    {
      echo $file . "\n";
      $hashes .= md5_file($file);
    }
  }
  echo "NETWORK: \n";
  echo "* \n";  
  echo "# Hash: " . md5($hashes) . "\n";
?>