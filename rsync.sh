cd /data02/code
echo -n "Stopping Tomcat "
/etc/init.d/tomcat stop > /dev/null 2>&1
pid=1
while [ $pid -gt 0 ]
do
  pid=`ps --user tomcat u | grep java | wc -l`
  echo -n "."
  sleep 1
done
echo "Done!"
rsync -vazu --delete --password-file=rsync.dat tomcat@209.1.238.104::agloco/ROOT /data02/code
#rsync -vazu --delete --password-file=rsync.dat tomcat@209.1.238.104::tomcat/conf/Catalina/localhost/ROOT.xml /data02/code
/etc/init.d/tomcat start
cd /data02/tomcat
tail -f logs/all/ag_all.log