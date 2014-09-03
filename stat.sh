#!/bin/sh
user=root
password=agl0c0
database=agloco

do_query() {
  local comment=$1
  local query=$2
  local report=$3
  echo $comment | sed -e 's/^--\s*//g' >> $report
  local utext=
  if [ -n "$user" ] ; then
    utext="-u$user"
  fi
  local ptext=
  if [ -n "$password" ] ; then
    ptext="-p$password"
  fi
  echo "$query" | mysql $utext $ptext $database -B --column-names >> $report
  echo >> $report
}

prg="$0"
prgdir=`dirname "$prg"`
cd "$prgdir"
script='daily.sql'
date=`date +%Y%m%d`
report='report'$date'.csv'
saved_tz=$TZ
TZ='PST8PDT'
export TZ
datetime=`date "+%Z(%z) %Y-%m-%d %H:%M:%S"`
echo $datetime > $report
comment=
query=
cat $script | while read line
do
  line=`echo $line | sed -e 's/^\s*//g' | sed -e 's/\s*$//g'`
  pos=`expr index "$line" " "`
  pos=`expr $pos - 1`
  word="`expr substr "$line" 1 $pos`"
  case "$word" in
  --)
    comment="$line"
    query=
  ;;
  select)
    query="$line"
  ;;
  *)
  ;;
  esac
  if [ -n "$comment" -a -n "$query" ]
  then
    do_query "$comment" "$query" "$report"
    comment=
    query=
  fi
done
sed -e 's/\s*,/,/g' $report > 1.tmp
sed -e 's/,\s*/, /g' 1.tmp > $report
rm -f 1.tmp
cp -f $report /data01/home/s264362
chmod 666 /data01/home/s264362/$report
chmod 400 $report
mv $report report/
exit 1