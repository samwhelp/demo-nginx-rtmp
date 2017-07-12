
## 安裝 Nginx

執行

``` sh
$ ./install.sh
```

詳細步驟，請參考「[install.sh](install.sh)」。

## Nginx 安裝的路徑

* /usr/local/share/nginx/

執行

``` sh
$ tree /usr/local/share/nginx
```

顯示

```
/usr/local/share/nginx/
├── conf
│   ├── fastcgi.conf
│   ├── fastcgi.conf.default
│   ├── fastcgi_params
│   ├── fastcgi_params.default
│   ├── koi-utf
│   ├── koi-win
│   ├── mime.types
│   ├── mime.types.default
│   ├── nginx.conf
│   ├── nginx.conf.default
│   ├── scgi_params
│   ├── scgi_params.default
│   ├── uwsgi_params
│   ├── uwsgi_params.default
│   └── win-utf
├── html
│   ├── 50x.html
│   ├── hls
│   └── index.html
├── logs
└── sbin
    └── nginx

5 directories, 18 files
```

## HTTP Document Root 路徑

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

## RTMP HLS 路徑

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

## nginx 簡易操作

### help

執行

``` sh
$ /usr/local/share/nginx/sbin/nginx -h
```

顯示

```
nginx version: nginx/1.9.9
Usage: nginx [-?hvVtTq] [-s signal] [-c filename] [-p prefix] [-g directives]

Options:
  -?,-h         : this help
  -v            : show version and exit
  -V            : show version and configure options then exit
  -t            : test configuration and exit
  -T            : test configuration, dump it and exit
  -q            : suppress non-error messages during configuration testing
  -s signal     : send signal to a master process: stop, quit, reopen, reload
  -p prefix     : set prefix path (default: /usr/local/share/nginx/)
  -c filename   : set configuration file (default: conf/nginx.conf)
  -g directives : set global directives out of configuration file
```


### start

執行

``` sh
$ sudo /usr/local/share/nginx/sbin/nginx
```

上面指令寫在「[server-start.sh](server-start.sh)」。


### reload

執行

``` sh
$ sudo /usr/local/share/nginx/sbin/nginx -s reload
```

上面指令寫在「[server-reload.sh](server-reload.sh)」。

若原本已經啟動「nginx」，

修改完「/usr/local/share/nginx/conf/nginx.conf」，則是可以執行這個指令。


### stop

執行

``` sh
$ sudo /usr/local/share/nginx/sbin/nginx -s stop
```

上面指令寫在「[server-stop.sh](server-stop.sh)」。


一般的狀況下，採用上面的方式來「stop」。

若遇到特殊的狀況，上面的方式無法運作的時候

可以執行下面指令

``` sh
$ ps aux | grep nginx
```

顯示

```
root     27138  0.0  0.0  36900  4980 ?        Ss   09:33   0:00 nginx: master process /usr/local/share/nginx/sbin/nginx
nobody   27139  0.0  0.1  37568  8312 ?        S    09:33   0:00 nginx: worker process
nobody   27140  0.0  0.1  37096  7536 ?        S    09:33   0:00 nginx: cache manager process
```

透過「[kill](http://manpages.ubuntu.com/manpages/xenial/en/man1/kill.1.html)」這個指令來「stop」。

``` sh
sudo kill -9 27138
sudo kill -9 27139
sudo kill -9 27140
```

或是也可以透過「[killall](http://manpages.ubuntu.com/manpages/xenial/en/man1/killall.1.html)」這個指令來「stop」。

``` sh
$ sudo killall -9 nginx
```

## 測試

### 範例檔案

以下假設有一個範例檔案「~/Videos/test.mp4」。

當啟動「nginx」後

### 測試「rtmp://localhost:2020/live/film」

先開啟一個「Terinaml」，執行下面指令

``` sh
$ ffmpeg -re -i ~/Videos/test.mp4 -c copy -f flv rtmp://localhost:2020/live/film
```

然後在開啟另一個「Terminal」，執行下面指令觀看

``` sh
$ ffplay rtmp://localhost:2020/live/film
```

也可以執行下面指令觀看

``` sh
$ vlc rtmp://localhost:2020/live/film
```

也可以執行下面指令觀看

``` sh
$ mpv rtmp://localhost:2020/live/film
```

上面指令寫在「[view-live.sh](view-live.sh)」。


### 測試「rtmp://localhost:2020/hls/film」

先開啟一個「Terinaml」，執行下面指令

``` sh
$ ffmpeg -re -i ~/Videos/test.mp4 -c copy -f flv rtmp://localhost:2020/hls/film
```

然後執行

``` sh
$ ls /usr/local/share/nginx/html/hls -1
```

會看到

```
film-0.ts
film-1.ts
film-2.ts
film-3.ts
film-4.ts
film-5.ts
...略...
film.m3u8
```

然後在開啟另一個「Terminal」，執行下面指令觀看

``` sh
$ ffplay rtmp://localhost:2020/hls/film
```

也可以執行下面指令觀看

``` sh
$ vlc rtmp://localhost:2020/hls/film
```

也可以執行下面指令觀看

``` sh
$ mpv rtmp://localhost:2020/hls/film
```

上面指令寫在「[view-hls.sh](view-hls.sh)」。

也可以執行下面指令觀看

``` sh
$ ffplay http://localhost:8080/hls/film.m3u8
```

也可以執行下面指令觀看

``` sh
$ vlc http://localhost:8080/hls/film.m3u8
```

也可以執行下面指令觀看

``` sh
$ mpv http://localhost:8080/hls/film.m3u8
```

上面指令寫在「[view-hls-m3u8.sh](view-hls-m3u8.sh)」。

或是透過網頁來觀看

``` sh
$ firefox http://localhost:8080/live.html
```

上面指令寫在「[view-hls-page.sh](view-hls-page.sh)」。

請參考「[/usr/local/share/nginx/html/live.html](live.html)」的內容，

網頁是播放「 http://localhost:8080/hls/film.m3u8 」。

當過一段時間後，再觀看「/usr/local/share/nginx/html/hls」，裡面的「film*」的這些檔案，是會被清除的。

可以查詢「[hls](https://www.google.com.tw/#q=hls)」，參考「[直播協議 hls 筆記](http://huli.logdown.com/posts/1142411-livestreamming-hls-note)」這篇的說明。

我之前也有寫了一篇「[關於「m3u」和「mpv」和「smplayer」的操作使用](https://www.ubuntu-tw.org/modules/newbb/viewtopic.php?post_id=357582#forumpost357582)」。


## 原始討論

* [#3 回覆: ubuntu搭建推流服務器Nginx+rtmp](https://www.ubuntu-tw.org/modules/newbb/viewtopic.php?post_id=357776#forumpost357776)


## 參考文章

* [ubuntu搭建推流服務器Nginx+rtmp](http://www.jianshu.com/p/f0bf83ca3ea3)

## Docs

* [Streaming with nginx-rtmp-module](http://nginx-rtmp.blogspot.com) ([GitHub](https://github.com/arut/nginx-rtmp-module))
* [Getting started with nginx rtmp](https://github.com/arut/nginx-rtmp-module/wiki/Getting-started-with-nginx-rtmp)
* [Video.js: The Player Framework](http://videojs.com/) ([GitHub](https://github.com/videojs))
