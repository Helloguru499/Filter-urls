echo -e "\033[31m
███████ ██ ██            ██    ██ ██████  ██
██      ██ ██            ██    ██ ██   ██ ██
█████   ██ ██      █████ ██    ██ ██████  ██
██      ██ ██            ██    ██ ██   ██ ██
██      ██ ███████        ██████  ██   ██ ███████

"



domain=$1

START=$(date +%s)
gau $domain --o $domain

END=$(date +%s)

timeexec=$(($END - $START))
echo  -e "\033[31m******************GAU  worked on target for $timeexec seconds **********************\033[m"

waybackurls $domain |tee -a $domain|qsreplace > $domain
endtimes=$(date +%s)
timeexecs=$(($endtimes - $START))
echo -e "\033[32m*****************WAYBACKURLS  worked on target for $timeexecs seconds********************\033[m"

cat $domain|grep "="|egrep -iv ".(css|jpg|gif|js|jpeg|tif|tiff|png|ttf|woff|woff2|ico|pdf|svg|txt)"|qsreplace|cut -d "?" -f 2|egrep -iv http|sort -u > $domain-param
sed  -i 's/&/\n/g' $domain-param

for i in $(cat $domain-param)
do
cat $domain |grep $i|head -n 1 >> $domain-final
done
rm $domain
rm $domain-param
sort -u $domain-final -o $domain-final

cat $domain-final
rm $domain-final
