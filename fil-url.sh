#!/bin/bash

echo -e "\033[32m
███████ ██ ██            ██    ██ ██████  ██
██      ██ ██            ██    ██ ██   ██ ██
█████   ██ ██      █████ ██    ██ ██████  ██
██      ██ ██            ██    ██ ██   ██ ██
██      ██ ███████        ██████  ██   ██ ███████

"
if [ ! -d targets ]; then
   mkdir -p targets/$1
fi  
cd targets/$1

if [ -f $1-xss ] ; then
    rm $(ls|grep $1)
fi

START=$(date +%s)
gau $1 --o $1-xss

END=$(date +%s)

timeexec=$(($END - $START))
echo  -e "\033[31m******************GAU Has taken $timeexec seconds from our life**********************"

waybackurls $1 |tee -a $1-xss|qsreplace|tee $1-xss
endtimes=$(date +%s)
timeexecs=$(($endtimes - $START))
echo -e "\033[32m*****************WAYBACKURLS has taken your time $timeexecs seconds********************"

cat $1-xss|grep "="|egrep -iv ".(css|jpg|gif|js|jpeg|tif|tiff|png|ttf|woff|woff2|ico|pdf|svg|txt)|qsreplace|cut -d "?" -f 2|egrep -iv http|sort -u|tee $1-param
sed  -i 's/&/\n/g' $1-param

for i in $(cat $1-param)
do
cat $1-xss |grep $i|head -n 1|tee -a $1-xss-final
done
sort -u $1-xss-final -o $1-xss-final
