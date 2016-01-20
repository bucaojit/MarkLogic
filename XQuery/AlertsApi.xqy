(: Adding commands used to test alerting, not meant to be run in one script :)

(: Creating alert config, Also setting the domain name :)
xquery version "1.0-ml";
import module namespace alert="http://marklogic.com/xdmp/alert"
   at "/MarkLogic/alert.xqy";

let $cpf-domain := "Default Samples"

let $config-uri := "http://marklogic.com/alert/uris"

let $config := alert:make-config(

$config-uri,

"My Alerts",

"Alerting config for My application.",
<alert:options/>

)
let $realConfig := alert:config-get($config-uri)

let $insert := alert:config-set-cpf-domain-names($realConfig, $cpf-domain )

return alert:config-insert($insert)

(: Simple Config get :)

xquery version "1.0-ml";
import module namespace alert = "http://marklogic.com/xdmp/alert" 
		  at "/MarkLogic/alert.xqy";

let $uri := "http://marklogic.com/alert/uris"
return alert:config-get($uri)

(: Deleting a config, without domain :)
xquery version "1.0-ml";
import module namespace alert = "http://marklogic.com/xdmp/alert"
at "/MarkLogic/alert.xqy";
let $config-uri := "http://marklogic.com/alert/uris"
return alert:config-delete($config-uri)

(: Deleting config, with domain :)
xquery version "1.0-ml";
import module namespace alert = "http://marklogic.com/xdmp/alert"
at "/MarkLogic/alert.xqy";
let $config-uri := "http://marklogic.com/alert/uris"
let $config := alert:config-get($config-uri)
let $config := alert:config-set-cpf-domain-names($config, ())
return alert:config-insert($config)

(: Making the action :)
  xquery version "1.0-ml";
  import module namespace alert = "http://marklogic.com/xdmp/alert" 
		  at "/MarkLogic/alert.xqy";

  let $action := alert:make-action(
    "logMsg",
    "Sends basic log message",
    xdmp:modules-database(),
    xdmp:modules-root(),
    "/tmp/logText.xqy",
    <alert:options>
    </alert:options>
  )
  
  return alert:action-insert("http://marklogic.com/alert/uris", $action)

(: Get and set action :)
xquery version "1.0-ml";
  import module namespace alert = "http://marklogic.com/xdmp/alert" 
		  at "/MarkLogic/alert.xqy";

let $action := alert:get-actions("http://marklogic.com/alert/uris",("logMsg"))
let $action := alert:action-set-module($action, "/tmp/logText.xqy")
let $action := alert:action-set-module-root($action, "/")
return alert:action-insert("http://marklogic.com/alert/uris", $action)

(: Simple get all actions :)
xquery version "1.0-ml";
  import module namespace alert = "http://marklogic.com/xdmp/alert" 
		  at "/MarkLogic/alert.xqy";

alert:get-actions("http://marklogic.com/alert/uris",("*"))

(: Making the rule :)
xquery version "1.0-ml";
import module namespace alert = "http://marklogic.com/xdmp/alert" 
		  at "/MarkLogic/alert.xqy";

let $rule := alert:make-rule(
    "simple", 
    "hello world rule",
    0, (: equivalent to xdmp:user(xdmp:get-current-user()) :)
    cts:word-query(“hello world”)
    ,
    "logMsg",
    <alert:options/> )
return
alert:rule-insert("http://marklogic.com/alert/uris", $rule)

(: Get the rule to view :)
  xquery version "1.0-ml";
  import module namespace alert = "http://marklogic.com/xdmp/alert" 
		  at "/MarkLogic/alert.xqy";

  alert:get-all-rules("http://marklogic.com/alert/uris", cts:word-query("simple"))

(: Should be all set, now to test :)

xquery version "1.0-ml";
import module namespace alert = "http://marklogic.com/xdmp/alert" 
  at "/MarkLogic/alert.xqy";

alert:invoke-matching-actions("http://marklogic.com/alert/uris", 
      <doc>hello world</doc>, <options/>)

(: Testing with an actual insert :) 
xquery version "1.0-ml";
let $contents :=

<doc>
hello world 234
</doc>

return
xdmp:document-insert("/testing/testDoc1.xml", $contents)


