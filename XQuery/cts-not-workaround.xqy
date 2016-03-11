xquery version "1.0-ml";

(:
    cts-not() constructor is as accurate as the unfiltered underlying
    query.  As such, this can yield false positive results as the
    unfiltered search is based off index resolution.  For guaranteed
    results, the query has to be rewritten to not make use of cts-not().

    Other workarounds may be to modify index settings
:)

xdmp:document-insert("/cts-test/doc1",  
                     <document> Hello World </document>
                     );
xdmp:document-insert("/cts-test/doc2",  
                     <document> Hello World Again</document>
                     );                     
xdmp:document-insert("/cts-test/doc3",  
                     <document> Just World </document>
                     );

let $all := cts:search(fn:doc(), cts:and-query(()))
let $subtract := cts:search(fn:doc(), cts:word-query("Hello"))
let $map_all := map:new($all ! map:entry(fn:base-uri(.), fn:true()))
let $map_to_subtract := map:new($subtract ! map:entry(fn:base-uri(.), fn:true()))
let $output := fn:doc(map:keys($map_all - $map_to_subtract))

return concat("Search results for not contains 'Hello' : ",string-join($output,"|")) ; 

let $all := cts:search(fn:doc(), cts:and-query(()))
let $subtract := cts:search(fn:doc(), cts:word-query("Just"))
let $map_all := map:new($all ! map:entry(fn:base-uri(.), fn:true()))
let $map_to_subtract := map:new($subtract ! map:entry(fn:base-uri(.), fn:true()))
let $output := fn:doc(map:keys($map_all - $map_to_subtract))

return concat("Search results for not contains 'Just' : ",string-join($output,"|")) ; 

let $all := cts:search(fn:doc(), cts:and-query(()))
let $subtract := cts:search(fn:doc(), cts:word-query("World"))
let $map_all := map:new($all ! map:entry(fn:base-uri(.), fn:true()))
let $map_to_subtract := map:new($subtract ! map:entry(fn:base-uri(.), fn:true()))
let $output := fn:doc(map:keys($map_all - $map_to_subtract))

return concat("Search results for not contains 'World' : ",string-join($output,"|")) ; 

let $all := cts:search(fn:doc(), cts:and-query(()))
let $subtract := cts:search(fn:doc(), cts:word-query("Test"))
let $map_all := map:new($all ! map:entry(fn:base-uri(.), fn:true()))
let $map_to_subtract := map:new($subtract ! map:entry(fn:base-uri(.), fn:true()))
let $output := fn:doc(map:keys($map_all - $map_to_subtract))

return concat("Search results for not contains 'Test' : ",string-join($output,"|")) ; 
