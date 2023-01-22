<?php

$sites = ['google.com','perdu.com','laredoute.fr','yahoo.com','xkcd.com','arstechnica.com','www.wired.com','sfr.fr','actu.fr','wanadoo.fr'];
$temp = [];
$results = [];

// Thanks to https://stackoverflow.com/a/9843251
function pingDomain($domain){
    $starttime = microtime(true);
    $file      = fsockopen ($domain, 80, $errno, $errstr, 10);
    $stoptime  = microtime(true);
    $status    = 0;

    if (!$file) $status = -1;  // Site is down
    else {
        fclose($file);
        $status = ($stoptime - $starttime) * 1000;
        $status = floor($status);
    }
    return $status;
}

foreach ($sites as $site) {
	 $temp[] = pingDomain($site) . ' ' . $site;
}
natsort($temp);
// var_dump($temp); // could have stopped here
foreach ($temp as $el) {
	$results[] = preg_replace("/([0-9]+) ([a-z\.-]+)$/", '$2 : $1 ms', $el);
}
// var_dump($results);
foreach($results as $el) {
	echo "$el\n";
}