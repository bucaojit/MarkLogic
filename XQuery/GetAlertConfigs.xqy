xquery version "1.0-ml";
"--- Config ---";
import module namespace alert = "http://marklogic.com/xdmp/alert" 
		  at "/MarkLogic/alert.xqy";
let $uri := "http://marklogic.com/alert/uris"
return alert:config-get($uri);
"--- Actions ---";
  import module namespace alert = "http://marklogic.com/xdmp/alert" 
		  at "/MarkLogic/alert.xqy";
alert:get-actions("http://marklogic.com/alert/uris",("*"));
"--- Rules ---";
xquery version "1.0-ml";
  import module namespace alert = "http://marklogic.com/xdmp/alert" 
		  at "/MarkLogic/alert.xqy";
  alert:get-all-rules("http://marklogic.com/alert/uris", cts:and-query(()));
