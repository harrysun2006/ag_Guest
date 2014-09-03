#!/bin/sh
user=root
password=
memberid=
membercode=
memberemail=
database=agloco

do_query() {
  local comment=$1
  local query=$2
  local out=$3
  local utext=
  if [ -n "$user" ] ; then
    utext="-u$user"
  fi
  local ptext=
  if [ -n "$password" ] ; then
    ptext="-p$password"
  fi
  local result=echo "$query" | mysql $utext $ptext $database -B --column-names 
  if [-n "$out" ] ; then
  	echo $comment | sed -e 's/^--\s*//g' >> $out
  	echo $result >> $out
  	echo >> $out
  fi
  echo $result
}

prg="$0"
prgdir=`dirname "$prg"`
cd "$prgdir"
date=`date +%Y%m%d`
echo "please input database password for $user: "
read password
echo "please input member code/member id/member email address: "
read answer
case $memberid in
	[0-9]+)
		memberid=$answer
		;;
	[a-zA-Z]{4}.*)
		membercode=$answer
		;;
	.+@.+)
		memberemail=$answer
		;;
esac
sql="select memberId, memberCode, emailAddress from AG_Member where 1 = 1"
if [-n "$memberid" ] ; then
	$sql
fi
report='audit'$date'.csv'
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