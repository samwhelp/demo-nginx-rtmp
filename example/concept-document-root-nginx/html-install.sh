#!/usr/bin/env bash


sudo cp html/index.html /usr/local/share/nginx/html/index.html
sudo cp html/about.html /usr/local/share/nginx/html/about.html
sudo cp html/contact.html /usr/local/share/nginx/html/contact.html

sudo mkdir -p /usr/local/share/nginx/html/blog

sudo cp html/blog/index.html /usr/local/share/nginx/html/blog/index.html
sudo cp html/blog/article-001.html /usr/local/share/nginx/html/blog/article-001.html
sudo cp html/blog/article-002.html /usr/local/share/nginx/html/blog/article-002.html
sudo cp html/blog/article-003.html /usr/local/share/nginx/html/blog/article-003.html
