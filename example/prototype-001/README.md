

## Nginx 安裝的路徑

* /usr/local/share/nginx/

## Http Document Root 路徑

* /usr/local/share/nginx/html <--> http://localhost:8080/

請參考「[/usr/local/share/nginx/conf/nginx.conf](nginx.conf#L45)」的設定

```
http {
...略...
		location / {
			root   html;
			index  index.html index.htm;
		}
...略...
}
```

## Rtmp HLS Root 路徑

* /usr/local/share/nginx/html/hls <--> http://localhost:8080/hls

請參考「[/usr/local/share/nginx/conf/nginx.conf](nginx.conf#L135)」的設定

```
			hls_path /usr/local/share/nginx/html/hls;
```

## Rtmp URL

* rtmp://localhost:2020/hls/film

請參考「[/usr/local/share/nginx/conf/nginx.conf](nginx.conf#L132)」的設定，和參考「[push-hls.sh](push-hls.sh)」。

```
rtmp {
	server {
		listen  2020;
...略...
		application hls {
			live on;
			hls on;
			hls_path /usr/local/share/nginx/html/hls;
			hls_fragment 5s;
		}
	}
}
```


* rtmp://localhost:2020/live/film

請參考「[/usr/local/share/nginx/conf/nginx.conf](nginx.conf#L126)」的設定，和參考「[push-live.sh](push-live.sh)」。

```
rtmp {
	server {
		listen  2020;
...略...
		application live {
			live on; #stream on live allow
			allow publish all; # control access privilege
			allow play all; # control access privilege
		}
...略...		
	}
}
```


## 原始討論

* [#3 回覆: ubuntu搭建推流服務器Nginx+rtmp](https://www.ubuntu-tw.org/modules/newbb/viewtopic.php?post_id=357776#forumpost357776)
