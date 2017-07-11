#!/usr/bin/env bash


## init
THE_BASE_DIR_PATH=$(cd -P -- "$(dirname -- "$0")" && pwd -P)
source $THE_BASE_DIR_PATH/_init.sh


## cd project dir
cd $THE_PRJ_DIR_PATH

## rm -rf build

## create build dir
mkdir -p build
cd build


## clone nginx
git clone https://github.com/nginx/nginx.git


## clone nginx-rtmp-module
git clone https://github.com/arut/nginx-rtmp-module.git


## download pcre
wget -c https://ftp.pcre.org/pub/pcre/pcre-8.39.tar.gz
tar -xzvf pcre-8.39.tar.gz


## cd nginx dir
cd nginx


## use nginx version release-1.9.9
git checkout release-1.9.9


## create cfg.sh for configure
cat > cfg.sh <<EOF
auto/configure \\
	--prefix=$THE_SERVER_DIR_PATH \\
	--with-pcre=../pcre-8.39 \\
	--with-http_ssl_module \\
	--with-http_v2_module \\
	--with-http_flv_module \\
	--with-http_mp4_module \\
	--add-module=../nginx-rtmp-module \\
EOF

chmod u+x cfg.sh

./cfg.sh


## make and make install
make
make install


## mkdir
mkdir -p "$THE_HLS_ROOT_DIR_PATH"


## nginx.conf
base_conf_install


## html
base_html_install
