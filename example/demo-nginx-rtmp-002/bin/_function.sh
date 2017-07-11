## THE_BASE_DIR_PATH=$(cd -P -- "$(dirname -- "$0")" && pwd -P)

find_dir_path () {
	if [ ! -d $(dirname -- "$1") ]; then
		dirname -- "$1"
		return 1
	fi
	echo $(cd -P -- "$(dirname -- "$1")" && pwd -P)
}

##THIS_BASE_DIR_PATH=$(find_dir_path $0)

base_var_init () {
	THE_PRJ_DIR_PATH=$(find_dir_path "$THE_BASE_DIR_PATH/../.")

	THE_BIN_DIR_NAME=bin
	THE_BIN_DIR_PATH=$(find_dir_path "$THE_BASE_DIR_PATH/../$THE_BIN_DIR_NAME/.")

	THE_VAR_DIR_NAME=var
	THE_VAR_DIR_PATH=$(find_dir_path "$THE_BASE_DIR_PATH/../$THE_VAR_DIR_NAME/.")

	THE_BUILD_DIR_NAME=build
	THE_BUILD_DIR_PATH=$(find_dir_path "$THE_BASE_DIR_PATH/../$THE_BUILD_DIR_NAME/.")

	THE_APP_DIR_NAME=app
	## /home/user/app
	THE_APP_DIR_PATH="$HOME/$THE_APP_DIR_NAME"

	THE_NGINX_DIR_NAME=nginx
	## /home/user/app/nginx
	THE_NGINX_DIR_PATH="$THE_APP_DIR_PATH/$THE_NGINX_DIR_NAME"

	THE_SERVER_DIR_NAME=demo-nginx-rtmp
	## /home/user/app/nginx/versions/demo-nginx-rtmp
	THE_SERVER_DIR_PATH="$THE_NGINX_DIR_PATH/versions/$THE_SERVER_DIR_NAME"

	## /home/user/app/nginx/versions/demo-nginx-rtmp/html
	THE_DOCUMENT_ROOT_DIR_PATH="$THE_SERVER_DIR_PATH/html"

	## /home/user/app/nginx/versions/demo-nginx-rtmp/html/hls
	THE_HLS_ROOT_DIR_PATH="$THE_DOCUMENT_ROOT_DIR_PATH/hls"

	## /home/user/app/nginx/versions/demo-nginx-rtmp/conf/nginx.conf
	THE_NGINX_CONF_FILE_PATH="$THE_SERVER_DIR_PATH/conf/nginx.conf"

	## /home/user/app/nginx/versions/demo-nginx-rtmp/sbin/nginx
	THE_NGINX_BIN_FILE_PATH="$THE_SERVER_DIR_PATH/sbin/nginx"

	## user account id
	THE_USER_NAME=$(id -nu)

	## test.mp4
	## /home/user/Videos/hls/video/test.mp4
	THE_DEMO_FILM_FILE_PATH="$HOME/Videos/hls/video/test.mp4"

	## rtmp url - live
	THE_DEMO_FILM_LIVE_RTMP_URL="rtmp://localhost:2020/live/film"

	## rtmp url - hls
	THE_DEMO_FILM_HLS_RTMP_URL="rtmp://localhost:2020/hls/film"

	## m3u url - hls
	THE_DEMO_FILM_HLS_M3U_URL="http://localhost:8080/hls/film.m3u8"

}

base_var_dump () {
	echo '$THE_PRJ_DIR_PATH:' $THE_PRJ_DIR_PATH

	echo '$THE_BIN_DIR_NAME:' $THE_BIN_DIR_NAME
	echo '$THE_BIN_DIR_PATH:' $THE_BIN_DIR_PATH

	echo '$THE_VAR_DIR_NAME:' $THE_VAR_DIR_NAME
	echo '$THE_VAR_DIR_PATH:' $THE_VAR_DIR_PATH

	echo '$THE_BUILD_DIR_NAME:' $THE_BUILD_DIR_NAME
	echo '$THE_BUILD_DIR_PATH:' $THE_BUILD_DIR_PATH

	echo '$THE_APP_DIR_NAME:' $THE_APP_DIR_NAME
	echo '$THE_APP_DIR_PATH:' $THE_APP_DIR_PATH

	echo '$THE_NGINX_DIR_NAME:' $THE_NGINX_DIR_NAME
	echo '$THE_NGINX_DIR_PATH:' $THE_NGINX_DIR_PATH

	echo '$THE_SERVER_DIR_NAME:' $THE_SERVER_DIR_NAME
	echo '$THE_SERVER_DIR_PATH:' $THE_SERVER_DIR_PATH

	echo '$THE_DOCUMENT_ROOT_DIR_PATH:' $THE_DOCUMENT_ROOT_DIR_PATH
	echo '$THE_HLS_ROOT_DIR_PATH:' $THE_HLS_ROOT_DIR_PATH
	echo '$THE_NGINX_CONF_FILE_PATH:' $THE_NGINX_CONF_FILE_PATH
	echo '$THE_NGINX_BIN_FILE_PATH:' $THE_NGINX_BIN_FILE_PATH

	echo '$THE_USER_NAME:' $THE_USER_NAME

	echo '$THE_DEMO_FILM_FILE_PATH:' $THE_DEMO_FILM_FILE_PATH
	echo '$THE_DEMO_FILM_LIVE_RTMP_URL:' $THE_DEMO_FILM_LIVE_RTMP_URL
	echo '$THE_DEMO_FILM_HLS_RTMP_URL:' $THE_DEMO_FILM_HLS_RTMP_URL
	echo '$THE_DEMO_FILM_HLS_M3U_URL:' $THE_DEMO_FILM_HLS_M3U_URL


}


base_html_install () {
	## install html
	cp "$THE_VAR_DIR_PATH/html/index.html" "$THE_DOCUMENT_ROOT_DIR_PATH/index.html"
	cp "$THE_VAR_DIR_PATH/html/live.html" "$THE_DOCUMENT_ROOT_DIR_PATH/live.html"
}

base_conf_install () {
	## nginx.conf
	cp "$THE_VAR_DIR_PATH/conf/nginx.conf" "$THE_NGINX_CONF_FILE_PATH"
	sed -i "s/__USER__/${THE_USER_NAME}/g" "$THE_NGINX_CONF_FILE_PATH"
}
