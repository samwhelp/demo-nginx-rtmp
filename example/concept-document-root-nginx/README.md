
# HTTP Document Root

## 原始討論

* 回覆: ubuntu搭建推流服務器Nginx+rtmp

## 範例目標

延續另一個範例「[concept-document-root-php](../concept-document-root-php)」，

這個範例「concept-document-root-nginx」，則是要瞭解「nginx」設定「Document Root」的概念。

## 操作環境

* Xubuntu 16.04 amd64 英文界面

## 安裝 Nginx

執行

``` sh
$ ./nginx-install.sh
```

詳細步驟，請參考「[nginx-install.sh](nginx-install.sh)」。

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


## 觀看「nginx.conf」設定的「Document Root」路徑

以這個範例為例，「[nginx.conf](conf/nginx.conf)」的路徑是在「/usr/local/share/nginx/conf/nginx.conf」。

其中有一段在「第[43](conf/nginx.conf#L43)行 ~ 第[46](conf/nginx.conf#L46)行」

```
location / {
	root   html;
	index  index.html index.htm;
}
```

上面的「root html;」就是在設定「Document Root」的路徑，

因為是「nginx」安裝在「/usr/local/share/nginx/」，

所以「root html;」的「html」指的就是「/usr/local/share/nginx/」加上「html」，

所以應該就是「root /usr/local/share/nginx/html;」，

也就是「Document Root」是設定在「/usr/local/share/nginx/html」這個路徑。

這個範例，我們不修改「Document Root」的路徑。

## html 檔案

這裡先準備了一些「html檔案」，放在「[web](web)」這個資料夾裡。

執行

``` sh
$ tree web
```

顯示

```
web
├── about.html
├── blog
│   ├── article-001.html
│   ├── article-002.html
│   ├── article-003.html
│   └── index.html
├── contact.html
└── index.html

1 directory, 7 files
```

也就是下面幾個檔案

* [web/index.html](web/index.html)
* [web/about.html](web/about.html)
* [web/contact.html](web/contact.html)
* [web/blog/index.html](web/blog/index.html)
* [web/blog/article-001.html](web/blog/article-001.html)
* [web/blog/article-002.html](web/blog/article-002.html)
* [web/blog/article-003.html](web/blog/article-003.html)


## 複製 「html 檔案」到「nginx」的「Document Root」

執行

``` sh
sudo cp html/index.html /usr/local/share/nginx/html/index.html
sudo cp html/about.html /usr/local/share/nginx/html/about.html
sudo cp html/contact.html /usr/local/share/nginx/html/contact.html
```

執行下面指令，建立「/usr/local/share/nginx/html/blog」這個資料夾

``` sh
$ sudo mkdir -p /usr/local/share/nginx/html/blog
```

執行

``` sh
sudo cp html/blog/index.html /usr/local/share/nginx/html/blog/index.html
sudo cp html/blog/article-001.html /usr/local/share/nginx/html/blog/article-001.html
sudo cp html/blog/article-002.html /usr/local/share/nginx/html/blog/article-002.html
sudo cp html/blog/article-003.html /usr/local/share/nginx/html/blog/article-003.html
```

上面的指令，統合寫在「[html-install.sh](html-install.sh)」。

執行

``` sh
$ tree /usr/local/share/nginx/html
```

顯示

```
/usr/local/share/nginx/html/
├── 50x.html
├── about.html
├── blog
│   ├── article-001.html
│   ├── article-002.html
│   ├── article-003.html
│   └── index.html
├── contact.html
└── index.html

1 directory, 8 files
```

執行

``` sh
$ tree /usr/local/share/nginx
```

顯示

```
/usr/local/share/nginx
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
│   ├── about.html
│   ├── blog
│   │   ├── article-001.html
│   │   ├── article-002.html
│   │   ├── article-003.html
│   │   └── index.html
│   ├── contact.html
│   └── index.html
├── logs
└── sbin
    └── nginx

5 directories, 24 files
```

## 修改 port

這個範例，我們不修改「Document Root」的路徑，只修改「port」。

在原本的「nginx.conf」的「第[35](conf/nginx.conf#L35)行 ~ 第[37](conf/nginx.conf#L37)行」可以看到下面這三行

```
server {
	listen       80;
	server_name  localhost;
```

主要要修改的是「第36行」的「listen       80;」。

所以可以改成

```
server {
	listen       8080;
	server_name  localhost;
```

也就是「第36行」，從原本「[listen       80;](conf/nginx.conf#L36)」，

改成「[listen       8080;](conf/nginx.conf.change-port#L36)」。

也就是原本的「port」是「80」改成「8080」。


## start nginx

接下來執行下面指令，start nginx

``` sh
$ sudo /usr/local/share/nginx/sbin/nginx
```

上面指令寫在「[server-start.sh](server-start.sh)」。


## 觀看網站首頁

執行下面指令，觀看網站首頁。

``` sh
$ firefox http://localhost:8080/
```

上面指令寫在「[view-page-home.sh](view-page-home.sh)」。

上面指令會開啟「 http://localhost:8080/ 」這個頁面，

您也可以直接在「firefox」或其他的網頁瀏覽器的網址列，直接輸入「 http://localhost:8080/ 」這個網址來觀看網站首頁。


## 「頁面網址」對照「檔案路徑」

* http://localhost:8080 <-> /usr/local/share/nginx/html/index.html
* http://localhost:8080/index.html <-> /usr/local/share/nginx/html/index.html
* http://localhost:8080/about.html <-> /usr/local/share/nginx/html/about.html
* http://localhost:8080/contact.html <-> /usr/local/share/nginx/html/contact.html
* http://localhost:8080/blog/ <-> /usr/local/share/nginx/html/blog/index.html
* http://localhost:8080/blog/index.html <-> /usr/local/share/nginx/html/blog/index.html
* http://localhost:8080/blog/article-001.html <-> /usr/local/share/nginx/html/blog/article-001.html
* http://localhost:8080/blog/article-002.html <-> /usr/local/share/nginx/html/blog/article-002.html
* http://localhost:8080/blog/article-003.html <-> /usr/local/share/nginx/html/blog/article-003.html
