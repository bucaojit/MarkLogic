#!/bin/sh

let i=0

while [ "$i" -lt "$1" ]; do
   echo "<root>value is $i</root>" > file$i.xml
   let i=$i+1
done
