cd /data02/code
date=`date +%Y%m%d`
file='guest'$date'.tgz'
mv /data01/home/s264362/$file update
chown root:root update/$file
chmod 444 update/$file
cp update/$file .
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
echo -n "Updating AGLOCO ..."
tar xzf $file
rm -f $file
chown -R tomcat:tomcat ROOT
find ROOT -type f -print | xargs chmod 644
echo "Done!"
/etc/init.d/tomcat start
cd /data02/tomcat
tail -f logs/all/ag_all.log