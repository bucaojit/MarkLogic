xquery version "1.0-ml";
 
declare namespace directory="http://marklogic.com/xdmp/directory";
declare variable $DIRECTORY="/tmp/";
 
for $entry in xdmp:filesystem-directory($DIRECTORY)//directory:entry
 
let $filename := $entry//directory:filename
let $path:= $entry//directory:pathname
 
 
(: Full document-insert parameter list:
  xdmp:document-insert(
     $uri as xs:string,
     $root as node(),
     [$permissions as element(sec:permission)*],
     [$collections as xs:string*],
     [$quality as xs:int?],
     [$forest-ids as xs:unsignedLong*]
  ) as empty-sequence()
:)
return xdmp:document-insert($filename, xdmp:document-get($path))
