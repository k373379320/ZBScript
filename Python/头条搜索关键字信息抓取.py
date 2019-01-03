#!/usr/bin/python
#-*- coding: utf-8 -*-
#encoding=utf-8

import json
import requests
import urllib2,urllib
import os
from bs4 import BeautifulSoup
import sys
reload(sys)
sys.setdefaultencoding('utf-8')

myKeyword = '表情'


def _create_dir(path):
	if not os.path.exists(path):
		os.mkdir(path)
		print ('创建文件夹{}成功'.format(path.split('\\')[-1]))
	return path


def _get_query_string(data):
	return urllib.urlencode(data)

#获取每个URL
def get_article_urls(req):
	res = urllib2.urlopen(req).read()
	d = json.loads(res).get('data')
	if d is None:
		print ('数据全部请求完毕...')
		return
	titles = [article.get('title') for article in d]

	for i in range(20):
		try :
			img_li = d[i]['image_detail']
			for j in img_li:
				save_photo(j.get('url'),titles[i])
		except Exception as e:
			print (e)
			continue

	return titles

def save_photo(photo_url,save_dir):
	photo_name = photo_url.rsplit('/',1)[-1]+'.jpg'
	res = requests.get(photo_url)
	save_path = root_dir + '/'+save_dir
	_create_dir(save_path)
	print ('savePath:{},file{}'.format(save_path,photo_name))
	with open (save_path+"/"+photo_name,'wb') as f:
		f.write(res.content)
		print ('已下载图片:{dir_name}/{photo_name},请求的url:{url}'.format(dir_name=save_dir,photo_name=photo_name,url=photo_url))



if __name__ == '__main__':
	ongoing = True
	offset = 0
	myDir =  "头条新闻爬去资料/"+myKeyword+"/"
	_create_dir("头条新闻爬去资料/")
	root_dir = _create_dir(myDir)
	requests_headers = {
	'User-Agent':'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/56.0.2924.87 Safari/537.36',
	'Referer':'http://www.toutiao.com/search/?keyword={}'.format(myKeyword)
	}

#http://www.toutiao.com/search_content/?offset=0&format=json&keyword=ios&autoload=true&count=20&cur_tab=1
while  ongoing:
	quert_data = {
		'offset':offset,
		'format':'json',
		'keyword':myKeyword,
		'autoload':'true',
		'count':'20',
		'cur_tab':'1',
	}

	quert_url = 'http://www.toutiao.com/search_content/?'+_get_query_string(quert_data)

	article_req = urllib2.Request(quert_url,headers=requests_headers)

	title = get_article_urls(article_req)

	if not title:
		break

	offset += 20


