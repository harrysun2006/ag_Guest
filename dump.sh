#!/bin/sh
date=`date +%Y%m%d`
file="guest$date.tgz"
find ROOT -newer README.TXT -type f \
  -not -iwholename "./lib/*" -not -iname "vssver*.scc" -not -iname "portal-ext.properties" \
  -print | xargs tar czf $file
