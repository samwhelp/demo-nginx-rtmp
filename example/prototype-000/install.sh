#!/usr/bin/env bash


## http://www.jianshu.com/p/f0bf83ca3ea3
## https://www.ubuntu-tw.org/modules/newbb/viewtopic.php?post_id=357776#forumpost357776


mkdir nginx-src
cd nginx-src

git clone https://github.com/nginx/nginx.git
git clone https://github.com/arut/nginx-rtmp-module.git

#wget ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-8.39.tar.gz
wget -c https://ftp.pcre.org/pub/pcre/pcre-8.39.tar.gz
tar -xzvf pcre-8.39.tar.gz

cd nginx

git checkout release-1.9.9

cat > cfg.sh <<EOF
auto/configure \\
	--prefix=/usr/local/nginx \\
	--with-pcre=../pcre-8.39 \\
	--with-http_ssl_module \\
	--with-http_v2_module \\
	--with-http_flv_module \\
	--with-http_mp4_module \\
	--add-module=../nginx-rtmp-module \\
EOF

chmod a+x cfg.sh

./cfg.sh

make

sudo make install
