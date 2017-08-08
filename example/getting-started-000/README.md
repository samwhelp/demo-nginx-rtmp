
## 安裝 Nginx

執行

``` sh
$ ./install.sh
```

詳細步驟，請參考「[install.sh](install.sh)」。

## Nginx 安裝的路徑

此範例將「nginx」安裝到「/usr/local/share/nginx/」這個路徑。

執行下面指令，觀看「/usr/local/share/nginx/」的資料夾結構。

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
│   └── index.html
├── logs
└── sbin
    └── nginx

4 directories, 18 files
```

## RTMP URL

### rtmp://localhost:2020/live/film

請參考「[/usr/local/share/nginx/conf/nginx.conf](nginx.conf#L17)」的設定，設定如下

```
rtmp {
	server {
		listen  2020;

		application live {
			live on;
			allow publish all;
			allow play all;
		}
	}
}
```

相關的「[Directives](https://github.com/arut/nginx-rtmp-module/wiki/Directives)」

* [rtmp](https://github.com/arut/nginx-rtmp-module/wiki/Directives#rtmp)
* [server](https://github.com/arut/nginx-rtmp-module/wiki/Directives#server)
* [listen](https://github.com/arut/nginx-rtmp-module/wiki/Directives#listen)
* [application](https://github.com/arut/nginx-rtmp-module/wiki/Directives#application)
* [live](https://github.com/arut/nginx-rtmp-module/wiki/Directives#live)
* [allow](https://github.com/arut/nginx-rtmp-module/wiki/Directives#allow)


## nginx 簡易操作

可以參考

* Nginx Documentation / Beginner’s Guide / [Starting, Stopping, and Reloading Configuration](https://nginx.org/en/docs/beginners_guide.html#control)
* Nginx Documentation / [Controlling nginx](https://nginx.org/en/docs/control.html)

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

## 如何測試

### 範例檔案

以下假設有一個範例檔案「~/Videos/test.mp4」。

當啟動「nginx」後，

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


## 原始討論

* [#3 回覆: ubuntu搭建推流服務器Nginx+rtmp](https://www.ubuntu-tw.org/modules/newbb/viewtopic.php?post_id=357776#forumpost357776)


## 參考文章

* [ubuntu搭建推流服務器Nginx+rtmp](http://www.jianshu.com/p/f0bf83ca3ea3)


## Nginx RTMP Module 官方網址

* [Streaming with nginx-rtmp-module](http://nginx-rtmp.blogspot.com) ([GitHub](https://github.com/arut/nginx-rtmp-module))


## Nginx RTMP Module 官方文件

* [Getting started with nginx rtmp](https://github.com/arut/nginx-rtmp-module/wiki/Getting-started-with-nginx-rtmp)
* [Directives](https://github.com/arut/nginx-rtmp-module/wiki/Directives)
* [Examples](https://github.com/arut/nginx-rtmp-module/wiki/Examples#simple-live-broadcast-service)


## Nginx 官方網址

* [https://nginx.org/](https://nginx.org/) ([GitHub](https://github.com/nginx/nginx))


## Nginx 官方文件

* [Beginner’s Guide](https://nginx.org/en/docs/beginners_guide.html)
