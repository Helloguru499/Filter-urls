# Filter-urls

For ex using waybackurls+gau gives us urls www.target.com/u/vicky/token?u=xxxxxx

www.target.com/u/guru/token?u=xxxxxx

www.target.com/u/Jack/token?u=xxxxxx

Above script makes extract parameters from urls and then extracts urls with no duplicate parameters with different paths.

output will be first url and remaining will be eliminated

Tools needed:

1.Waybackurls

2.gau

3.qsreplace

How to Install :

git clone https://github.com/Helloguru499/Filter-urls.git

Usage:

cd Filter-urls

chmod +x fil-url.sh

./fil-url.sh target.com
