
# HTTP Document Root

## 原始討論

* [#19 回覆: ubuntu搭建推流服務器Nginx+rtmp](https://www.ubuntu-tw.org/modules/newbb/viewtopic.php?post_id=357894#forumpost357894)

## 範例目標

這個範例，要透過「[PHP Built-in web server](http://php.net/manual/en/features.commandline.webserver.php)」來闡述「Document Root」的概念。

## 操作環境

* Xubuntu 16.04 amd64 英文界面

## 前置作業

執行下面指令，安裝「[php-cli](https://packages.ubuntu.com/xenial/php-cli)」這個套件

``` sh
$ sudo apt-get install php-cli
```

安裝完畢後，就會有「php」這個指令可以執行，實際的路徑在「/usr/bin/php」。

## 觀看 help

執行

``` sh
$ php -h
```

顯示

```
Usage: php [options] [-f] <file> [--] [args...]
   php [options] -r <code> [--] [args...]
   php [options] [-B <begin_code>] -R <code> [-E <end_code>] [--] [args...]
   php [options] [-B <begin_code>] -F <file> [-E <end_code>] [--] [args...]
   php [options] -S <addr>:<port> [-t docroot] [router]
   php [options] -- [args...]
   php [options] -a

  -a               Run interactively
  -c <path>|<file> Look for php.ini file in this directory
  -n               No configuration (ini) files will be used
  -d foo[=bar]     Define INI entry foo with value 'bar'
  -e               Generate extended information for debugger/profiler
  -f <file>        Parse and execute <file>.
  -h               This help
  -i               PHP information
  -l               Syntax check only (lint)
  -m               Show compiled in modules
  -r <code>        Run PHP <code> without using script tags <?..?>
  -B <begin_code>  Run PHP <begin_code> before processing input lines
  -R <code>        Run PHP <code> for every input line
  -F <file>        Parse and execute <file> for every input line
  -E <end_code>    Run PHP <end_code> after processing all input lines
  -H               Hide any passed arguments from external tools.
  -S <addr>:<port> Run with built-in web server.
  -t <docroot>     Specify document root <docroot> for built-in web server.
  -s               Output HTML syntax highlighted source.
  -v               Version number
  -w               Output source with stripped comments and whitespace.
  -z <file>        Load Zend extension <file>.

  args...          Arguments passed to script. Use -- args when first argument
                   starts with - or script is read from stdin

  --ini            Show configuration file names

  --rf <name>      Show information about function <name>.
  --rc <name>      Show information about class <name>.
  --re <name>      Show information about extension <name>.
  --rz <name>      Show information about Zend extension <name>.
  --ri <name>      Show configuration for extension <name>.
```

## 觀看版本(Version)

執行

``` sh
$ php -v
```

顯示

```
PHP 7.0.18-0ubuntu0.16.04.1 (cli) ( NTS )
Copyright (c) 1997-2017 The PHP Group
Zend Engine v3.0.0, Copyright (c) 1998-2017 Zend Technologies
    with Zend OPcache v7.0.18-0ubuntu0.16.04.1, Copyright (c) 1999-2017, by Zend Technologies
```

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

以下範例，假設以「/home/user/project/concept-document-root-php/」這個路徑來當作「起始資料夾路徑」。

所以上面的「web/index.html」就會是「/home/user/project/concept-document-root-php/web/index.html」，

其他的以此類推。

其中「/home/user」，請根據您目前使用的帳號而定。

## 啟動 「PHP Built-in web server」

參考上面執行「`php -h`」可以找到下面兩個參數說明

```
-S <addr>:<port> Run with built-in web server.
-t <docroot>     Specify document root <docroot> for built-in web server.
```

### 方式一

先執行下面指令，切換到「[web](web)」這個資料夾

``` sh
$ cd web
```

您可以執行「`pwd`」確認目前所在位置，

會顯示

```
/home/user/project/concept-document-root-php/web
```

接下來執行下面指令，啟動「PHP Built-in web server」

``` sh
$ php -S localhost:8080
```

上面這個指令寫在「[server-start-000.sh](server-start-000.sh)」。

顯示

```
PHP 7.0.18-0ubuntu0.16.04.1 Development Server started at Fri Jul 21 14:52:11 2017
Listening on http://localhost:8080
Document root is /home/user/project/concept-document-root-php/web
Press Ctrl-C to quit.
```

因為上面指令，並沒有指定「Document root」的路徑，所以預設會採用目前所在的資料夾路徑，
也就是「web」這個資料夾的路徑。

可以按下「Ctrl-C」就會離開，也就是關閉剛剛啟動的「PHP Built-in web server」。

### 方式二

執行下面指令，先回到剛剛進到「[web](web)」這個資料夾前的路徑。

``` sh
$ cd ..
```

執行

``` sh
$ pwd
```

顯示目前所在路徑

```
/home/user/project/concept-document-root-php
```

接下來執行下面指令，啟動「PHP Built-in web server」

``` sh
$ php -S localhost:8080 -t web/
```

上面的指令寫在「[server-start-001.sh](server-start-001.sh)」。

顯示

```
PHP 7.0.18-0ubuntu0.16.04.1 Development Server started at Fri Jul 21 15:00:24 2017
Listening on http://localhost:8080
Document root is /home/user/project/concept-document-root-php/web
Press Ctrl-C to quit.
```

這裡我們有多加一個「-t web/」，所以會將「[web](web)」這個資料夾的路徑，當作是「Document root」。


## 觀看網站首頁

另外開啟一個「Terminal」，執行下面指令，觀看網站首頁。

``` sh
$ firefox http://localhost:8080/
```

上面指令寫在「[view-page-home.sh](view-page-home.sh)」。

上面指令會開啟「 http://localhost:8080/ 」這個頁面，

您也可以直接在「firefox」或其他的網頁瀏覽器的網址列，直接輸入「 http://localhost:8080/ 」這個網址來觀看網站首頁。


## 「頁面網址」對照「檔案路徑」

* http://localhost:8080 <-> /home/user/project/concept-document-root-php/web/index.html
* http://localhost:8080/index.html <-> /home/user/project/concept-document-root-php/web/index.html
* http://localhost:8080/about.html <-> /home/user/project/concept-document-root-php/web/about.html
* http://localhost:8080/contact.html <-> /home/user/project/concept-document-root-php/web/contact.html
* http://localhost:8080/blog/ <-> /home/user/project/concept-document-root-php/web/blog/index.html
* http://localhost:8080/blog/index.html <-> /home/user/project/concept-document-root-php/web/blog/index.html
* http://localhost:8080/blog/article-001.html <-> /home/user/project/concept-document-root-php/web/blog/article-001.html
* http://localhost:8080/blog/article-002.html <-> /home/user/project/concept-document-root-php/web/blog/article-002.html
* http://localhost:8080/blog/article-003.html <-> /home/user/project/concept-document-root-php/web/blog/article-003.html
